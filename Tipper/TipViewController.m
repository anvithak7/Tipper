//
//  TipViewController.m
//  Tipper
//
//  Created by Anvitha Kachinthaya on 6/22/21.
//

#import "TipViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipPercentageControl;
@property (weak, nonatomic) IBOutlet UIView *labelsContainerView;
@property (weak, nonatomic) IBOutlet UITextField *customTipField;

@end

@implementation TipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    self.labelsContainerView.alpha = 0;
    self.customTipField.alpha = 0;
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:true];
}

- (IBAction)updateLabels:(id)sender {
    double customTip = 0;
    if (self.tipPercentageControl.selectedSegmentIndex == 3) {
        self.customTipField.alpha = 1;
        customTip = [self.customTipField.text doubleValue];
        customTip = customTip * 0.01;
        NSLog(@"Changed custom tip!");
    }
    if (self.tipPercentageControl.selectedSegmentIndex != 3) {
        self.customTipField.alpha = 0;
    }
    double tipPercentages[] = {0.15, 0.18, 0.2, customTip};
    double tipPercent = tipPercentages[self.tipPercentageControl.selectedSegmentIndex];
    double bill = [self.billField.text doubleValue];
    double tip = bill * tipPercent;
    double total = bill + tip;
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", tip];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", total];
}

- (IBAction)startedEditing:(id)sender {
    [self hideLabels];
}

- (IBAction)endedEditing:(id)sender {
    [self showLabels];
}

- (void)hideLabels {
    [UIView animateWithDuration:0.2 animations:^{
        CGRect billFrame = self.billField.frame;
        billFrame.origin.y -= 200;
//        self.billField.frame = billFrame;
        
        CGRect labelsFrame = self.labelsContainerView.frame;
        labelsFrame.origin.y -= 200;
        self.labelsContainerView.frame = labelsFrame;
        self.labelsContainerView.alpha = 0;
    }];
}

- (void)showLabels {
    [UIView animateWithDuration:0.2 animations:^{
        CGRect billFrame = self.billField.frame;
        billFrame.origin.y += 200;
//        self.billField.frame = billFrame;
        
        CGRect labelsFrame = self.labelsContainerView.frame;
        labelsFrame.origin.y += 200;
        self.labelsContainerView.frame = labelsFrame;
        self.labelsContainerView.alpha = 1;
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
