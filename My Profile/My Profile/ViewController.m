//
//  ViewController.m
//  My Profile
//
//  Created by SaTHYa on 08/01/17.
//  Copyright © 2017 SaTHYa. All rights reserved.
//

#import "ViewController.h"
#import "Details+CoreDataProperties.h"

#define BottomButtonColor [UIColor colorWithRed:32.0/255.0 green:36.0/255.0 blue:49.0/255.0 alpha:1]
#define BottomMiddleButtonColor [UIColor colorWithRed:45.0/255.0 green:51.0/255.0 blue:64.0/255.0 alpha:1]
#define BottomSelectedButtonColor [UIColor colorWithRed:24.0/255.0 green:28.0/255.0 blue:38.0/255.0 alpha:1]
#define SelectedGreenColor [UIColor colorWithRed:0.0/255.0 green:223.0/255.0 blue:184.0/255.0 alpha:1]
#define TopBarColor [UIColor colorWithRed:156.0/255.0 green:165.0/255.0 blue:185.0/255.0 alpha:1]
#define WhiteColor [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]
#define SettingBackground [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.3]
#define ProximaNovaRegular [UIFont fontWithName:@"ProximaNova-Regular" size:72.0f]
#define ProximaNovaSemiBold [UIFont fontWithName:@"ProximaNova-Semibold" size:72.0f]
#define ProximaNovaBold [UIFont fontWithName:@"ProximaNova-Bold" size:72.0f]



@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *trendButton;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *feedButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *myProfileScreenButton;
@property (weak, nonatomic) IBOutlet UIButton *middleButton1;
@property (weak, nonatomic) IBOutlet UIButton *midldeButton2;
@property (weak, nonatomic) IBOutlet UIButton *middleButton3;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicImageView;
@property (weak, nonatomic) IBOutlet UIButton *middleButton4;
@property (weak, nonatomic) IBOutlet UIButton *fbButton;
@property (weak, nonatomic) IBOutlet UIButton *instaButton;
@property (weak, nonatomic) IBOutlet UIButton *twitButton;
@property (strong, nonatomic) IBOutlet UIView *settingsView;
@property (strong, nonatomic) IBOutlet UIView *backGroundView;
@property (weak, nonatomic) IBOutlet UIButton *quoteEditButton;
@property (weak, nonatomic) IBOutlet UITextField *quotesTextField;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
@property (weak, nonatomic) IBOutlet UIImageView *coverPicImageView;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *professionTextfield;
@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;
@property (strong, nonatomic) IBOutlet UILabel *professionLabel;
@property (weak, nonatomic) IBOutlet UITextField *profTextfield;
@property(retain, nonatomic)NSMutableArray *imageStore;
@property(retain, nonatomic)UIButton *backButton;
@property(assign, nonatomic)bool isProfilePic;

@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setInitialValues];
}
-(void)setInitialValues{
    UITapGestureRecognizer *profilePicTouchGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profilePicTapDetected)];
    profilePicTouchGesture.numberOfTapsRequired = 1;
    [self.profilePicImageView setUserInteractionEnabled:YES];
    [self.profilePicImageView addGestureRecognizer:profilePicTouchGesture];
    
    UITapGestureRecognizer *coverPicTouchGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverPicTapDetected)];
    coverPicTouchGesture.numberOfTapsRequired = 1;
    [self.coverPicImageView setUserInteractionEnabled:YES];
    [self.coverPicImageView addGestureRecognizer:coverPicTouchGesture];
    
    UITapGestureRecognizer *outsideSettings = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(outsideSettingsDetected)];
    outsideSettings.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:outsideSettings];
    
    self.quotesTextField.enabled=NO;
    self.quotesTextField.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    self.imageStore=[NSMutableArray array];
    [self.imageStore addObject:[NSString stringWithFormat:@"p1.jpg"]];
    [self.imageStore addObject:@"p2.jpg"];
    [self.imageStore addObject:@"p3.jpg"];
    [self.imageStore addObject:@"p4.jpg"];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self.collectionView setBackgroundColor:[UIColor colorWithRed:237.0/255.0 green:239.0/255.0 blue:243.0/255.0 alpha:1]];
    
    [self.view addSubview:self.collectionView];
    
    self.trendButton.backgroundColor=self.searchButton.backgroundColor=self.likeButton.backgroundColor=BottomButtonColor;
    self.midldeButton2.backgroundColor=self.middleButton3.backgroundColor=self.middleButton4.backgroundColor=WhiteColor;
    self.middleButton1.backgroundColor=SelectedGreenColor;
    self.myProfileScreenButton.backgroundColor=BottomSelectedButtonColor;
    self.feedButton.backgroundColor=BottomMiddleButtonColor;
    
    [self.quoteEditButton setImage:[self scaleImageWithName:@"edit.png"] forState:UIControlStateNormal];
    [self.fbButton setImage:[self scaleImageWithName:@"fb.png"] forState:UIControlStateNormal];
    [self.instaButton setImage:[self scaleImageWithName:@"insta.png"] forState:UIControlStateNormal];
    [self.twitButton setImage:[self scaleImageWithName:@"twit.png"] forState:UIControlStateNormal];
    
    [self.settingsButton setImage:[self scaleImageWithName:@"setting.png"] forState:UIControlStateNormal];
    self.settingsButton.layer.cornerRadius=self.settingsButton.frame.size.height /2;
    self.settingsButton.layer.masksToBounds = YES;
    self.settingsButton.backgroundColor=SettingBackground;
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.hidden=YES;
    [self.backButton  addTarget:self action:@selector(backTouched) forControlEvents:UIControlEventTouchUpInside];
    [self.backButton  setTitle:@"X" forState:UIControlStateNormal];
    self.backButton .backgroundColor=TopBarColor;
    self.backButton .frame = CGRectMake(10, 15, 15,15);
    
    self.nameLabel.font=ProximaNovaSemiBold;
    self.professionLabel.font=ProximaNovaRegular;
    self.nameLabel.textColor=BottomButtonColor;
    self.professionLabel.textColor=TopBarColor;
    [self setNameAndProfession];
    self.profilePicImageView.layer.cornerRadius = self.profilePicImageView.frame.size.height /2;
    self.profilePicImageView.layer.masksToBounds = YES;
    self.profilePicImageView.layer.borderWidth = 0;
    self.profilePicImageView.image= [UIImage imageNamed: @"profilepic"];
    self.coverPicImageView.image=[UIImage imageNamed:@"coverPhoto"];
    
    [self.middleButton1 setImage:[self scaleImageWithName:@"m1.png"] forState:UIControlStateNormal];
    [self.midldeButton2 setImage:[self scaleImageWithName:@"m2.png"] forState:UIControlStateNormal];
    [self.middleButton3 setImage:[self scaleImageWithName:@"m3.png"] forState:UIControlStateNormal];
    [self.middleButton4 setImage:[self scaleImageWithName:@"m4.png"] forState:UIControlStateNormal];
    
    [self.trendButton setImage:[self scaleImageWithName:@"trend.png"] forState:UIControlStateNormal];
    [self.searchButton setImage:[self scaleImageWithName:@"search.png"] forState:UIControlStateNormal];
    [self.feedButton setImage:[self scaleImageWithName:@"feed.png"] forState:UIControlStateNormal];
    [self.likeButton setImage:[self scaleImageWithName:@"likes.png"] forState:UIControlStateNormal];
    [self.myProfileScreenButton setImage:[self scaleImageWithName:@"myProfile.png"] forState:UIControlStateNormal];
    
    [self.middleButton1 setTopBorder];
    [self.midldeButton2 setTopBorder];
    [self.middleButton3 setTopBorder];
    [self.middleButton4 setTopBorder];
    
    [self.midldeButton2 setLeftBorder];
    [self.middleButton3 setLeftBorder];
    [self.middleButton4 setLeftBorder];
}
- (IBAction)settingButtonTouched:(id)sender {
    self.settingsView.layer.cornerRadius=4;
    [self.nameTextfield becomeFirstResponder];
    self.settingsView.frame=CGRectMake((self.view.superview.frame.size.width-self.settingsView.frame.size.width)/2, (self.view.frame.size.height-self.settingsView.frame.size.height)/2, self.settingsView.frame.size.width,self.settingsView.frame.size.height);
    self.backGroundView=[[UIView alloc]initWithFrame:self.view.frame];
    self.backGroundView.backgroundColor=[UIColor blackColor];
    self.backGroundView.alpha=0.5
    ;
    [self.view addSubview: self.backGroundView];
    [self.nameTextfield setBottomBorder];
    [self.profTextfield setBottomBorder];
    [self.view addSubview: self.settingsView];
}
- (IBAction)settingsDoneTouched:(id)sender {
    [self.settingsView removeFromSuperview];
    [self.backGroundView removeFromSuperview];
    self.backGroundView=nil;
    [self saveDetails];
    [self setNameAndProfession];
}
- (IBAction)settingsBackTouched:(id)sender {
    [self.settingsView removeFromSuperview];
    [self.backGroundView removeFromSuperview];
    self.backGroundView=nil;
}
-(void)setNameAndProfession{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Details"];
    NSArray *result= [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    if (![[[result lastObject] valueForKey:@"name"] isEqualToString:@""]) {
        self.nameLabel.text=[[result lastObject] valueForKey:@"name"];
        self.professionLabel.text=[[result lastObject] valueForKey:@"professional"];
    }else{
        self.nameLabel.text=@"SaTHYa";
        self.professionLabel.text=@"iOS Developer";
    }
}
- (IBAction)quoteEditButtonTouched:(id)sender {
    if ([self.quotesTextField isEnabled]) {
        self.quotesTextField.enabled=NO;
        [self.quotesTextField resignFirstResponder];
    }else{
        self.quotesTextField.enabled=YES;
        [self.quotesTextField becomeFirstResponder];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{   self.quotesTextField.enabled=NO;
    [textField resignFirstResponder];
    return YES;
}
//webViews
-(void)initWebViewToLoadWithURL:(NSURL *)loadURL{
    self.webView.frame=self.view.frame;
    [self.view addSubview:self.webView];
    self.backButton.hidden=NO;
    [self.view addSubview:self.backButton];
    [self.webView loadRequest:[NSURLRequest requestWithURL:loadURL]];
}
-( void)backTouched{
    [self.webView removeFromSuperview];
    self.backButton.hidden=YES;
}
- (IBAction)fbClicked:(id)sender {
    [self initWebViewToLoadWithURL:[NSURL URLWithString:@"https://www.facebook.com/sathya26d"]];
}
- (IBAction)twitterButtonTouched:(id)sender {
    [self initWebViewToLoadWithURL:[NSURL URLWithString:@"https://www.twitter.com/sathya_tnj"]];
}
- (IBAction)instaButtonTouched:(id)sender {
    [self initWebViewToLoadWithURL:[NSURL URLWithString:@"https://www.instagram.com/sathya26d"]];
}
//gestureMethods
-(void)outsideSettingsDetected{
    [self.settingsView removeFromSuperview];
    [self.backGroundView removeFromSuperview];
    self.backGroundView=nil;
}
-(void)coverPicTapDetected{
    self.isProfilePic=NO;
    [self openGallery];
}
-(void)profilePicTapDetected{
    self.isProfilePic=YES;
    [self openGallery];
}
//profileAndCoverPhotoSetterMethods
-(void)openGallery{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    if (self.isProfilePic) {
        self.profilePicImageView.image = chosenImage;
    }else{
        self.coverPicImageView.image = chosenImage;
    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.imageStore count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    NSUInteger index = [indexPath indexAtPosition:[indexPath length] - 1];
    UIView *cellUIView = [[UIView alloc] init];
    cellUIView.frame = cell.bounds;
    cellUIView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.imageStore[index]]];
    imageView.frame = CGRectMake(cellUIView.frame.origin.x, cellUIView.frame.origin.y, 110, 110);
    UILabel *projectNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(cellUIView.frame.origin.x, cellUIView.frame.origin.y+110, 110, 40)];
    projectNameLabel.text = [NSString stringWithFormat:@"Project %lu",(unsigned long)index];
    projectNameLabel.font=ProximaNovaBold;
    projectNameLabel.textColor=[UIColor blackColor];
    projectNameLabel.textAlignment = NSTextAlignmentCenter;
    [cellUIView addSubview:projectNameLabel];
    [cellUIView addSubview:imageView];
    cellUIView.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:cellUIView];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(110, 150);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//imageScaleMethod
-(UIImage*)scaleImageWithName:(NSString*)imageName{
    UIImage *originalImage = [UIImage imageNamed:imageName];
    CGSize destinationSize = CGSizeMake(15, 15);
    UIGraphicsBeginImageContext(destinationSize);
    [originalImage drawInRect:CGRectMake(0,0,destinationSize.width,destinationSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
//MOC
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
- (void)saveDetails {
    [self clearCoreData];
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *detailsEntity = [NSEntityDescription insertNewObjectForEntityForName:@"Details" inManagedObjectContext:context];
    [detailsEntity setValue:self.nameTextfield.text forKey:@"name"];
    [detailsEntity setValue:self.profTextfield.text forKey:@"professional"];
    NSError *error = nil;
    if (![context save:&error]) {}
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)clearCoreData{
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *detailsEntity = [NSEntityDescription entityForName:@"Details" inManagedObjectContext:[self managedObjectContext]];
        [fetchRequest setEntity:detailsEntity];
        NSError *error;
        NSArray *items = [[self managedObjectContext] executeFetchRequest:fetchRequest error:&error];
        for (NSManagedObject *managedObject in items) {
            [[self managedObjectContext] deleteObject:managedObject];
        }
}

@end
@implementation UITextField(TextField)

-(void)setBottomBorder{
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = TopBarColor.CGColor;
    border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, self.frame.size.height);
    border.borderWidth = borderWidth;
    [self.layer addSublayer:border];
    self.layer.masksToBounds = YES;
}

@end
@implementation UIButton(Button)

-(void)setTopBorder{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    lineView.backgroundColor = TopBarColor;
    [self addSubview:lineView];
}
-(void)setLeftBorder{
    UIView *leftBorder = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, self.frame.size.height)];
    leftBorder.backgroundColor = TopBarColor;
    [self addSubview:leftBorder];
}
@end