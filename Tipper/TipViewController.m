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

// The function below makes sure that you can't see the labelsContainerView upon opening the app (so it can slide up later), and the customTipField is hidden.
- (void)viewDidAppear:(BOOL)animated {
    self.labelsContainerView.alpha = 0;
    self.customTipField.alpha = 0;
}

// After typing in the text boxes, you can tap anywhere to close the keyboard.
- (IBAction)onTap:(id)sender {
    [self.view endEditing:true];
}

// This function calculates the tips and total after constantly updating based on the bill amount. Custom tip percentages are added here with a new variable.
- (IBAction)updateLabels:(id)sender {
    double customTip = 0;
    if (self.tipPercentageControl.selectedSegmentIndex == 3) { // If a user selects a custon tip,
        self.customTipField.alpha = 1; // Show the custom tip text field,
        customTip = [self.customTipField.text doubleValue]; // Turn the value into a double,
        customTip = customTip * 0.01; // And apply the percentage,
        NSLog(@"Changed custom tip!"); // Just a note for debugging purposes!
    } // Note that this is related to the customTipField changing, so it can constantly update.
    if (self.tipPercentageControl.selectedSegmentIndex != 3) {
        self.customTipField.alpha = 0; // Otherwise, we want to make sure the custom tip field doesn't show for cleanliness reasons.
    }
    double tipPercentages[] = {0.15, 0.18, 0.2, customTip}; // The possible tip values.
    double tipPercent = tipPercentages[self.tipPercentageControl.selectedSegmentIndex]; // Our final percent will be a value from the previous list based on the index.
    double bill = [self.billField.text doubleValue]; // We take the value the user inputted and turn it into a double.
    double tip = bill * tipPercent; // Calculating the tip.
    double total = bill + tip; // Adding the tip to the bill.
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", tip]; // Display the calculated tip value.
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", total]; // Display the calculated total value.
}

- (IBAction)startedEditing:(id)sender { // This function hides the labelsContainerView when a user hasn't input a bill amount yet. It's separate so it doesn't change with each digit.
    [self hideLabels];
}

- (IBAction)endedEditing:(id)sender { // This function shows the tips and total after the bill amount is entered. It's separate so it doesn't change with each digit.
    [self showLabels];
}

// This function makes the labelsContainerView disappear and pushes the billFrame.
- (void)hideLabels {
    [UIView animateWithDuration:0.2 animations:^{
        CGRect billFrame = self.billField.frame;
        billFrame.origin.y -= 200;
//        self.billField.frame = billFrame; This is commented out so that we can change billFrame back afterwards.
        
        CGRect labelsFrame = self.labelsContainerView.frame;
        labelsFrame.origin.y -= 200;
        self.labelsContainerView.frame = labelsFrame;
        self.labelsContainerView.alpha = 0;
    }];
}

// Same as hideLabels but backwards.
- (void)showLabels {
    [UIView animateWithDuration:0.2 animations:^{
        CGRect billFrame = self.billField.frame;
        billFrame.origin.y += 200;
//        self.billField.frame = billFrame; This is commented out so that we can change billFrame back afterwards (don't want to permanently reset it).
        
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
