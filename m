Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix display of last device classes in hciconfig
From: Daniel Abraham <daniel.shrugged@gmail.com>
To: Vinicius Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <2a9506371003221436s1cf1b465r907f726797b4f251@mail.gmail.com>
References: <2c3916b71003160533s714e9ef3h6c803f88a79f27d2@mail.gmail.com>
	 <2a9506371003221436s1cf1b465r907f726797b4f251@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 27 Mar 2010 11:28:31 +0300
Message-ID: <1269678511.22795.22.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> > ---
> >  tools/hciconfig.c |   30 ++++++++++++++++++++++++++----
> >  1 files changed, 26 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/hciconfig.c b/tools/hciconfig.c
> > index 3f687e0..c97ce44 100644
> > --- a/tools/hciconfig.c
> > +++ b/tools/hciconfig.c
> > @@ -645,8 +645,26 @@ static char *get_minor_device_name(int major, int minor)
> >                        return "Game";
> >                }
> >                break;
> > -       case 63:        /* uncategorised */
> > -               return "";
> 
> I think that the test for the "Uncategorised" (which seems to be
> misspelled in many places) device class would be better staying here,
> because the same code is used inside hcitool.c. Fixing there would be
> nice too.
> 
> Another thing, looks like this "case 63:" is wrong,  major device
> class is a 5 bit number, and the uncategorized device class is defined
> as 31. Looks like a legacy from ancient times ;-)

That's exactly why I changed it: the original check below whether to
enter this function ("if ((cls[1] & 0x1f) >= ...") meant <no. of
categories + 1> where +1 meant "Unrecognized", but this is mistaken as
you wrote.

I don't mind fixing it in "hcitool.c" as well, but see followup question
at the bottom.

> > +       case 9: /* health */
> > +               switch(minor) {
> > +               case 0:
> > +                       return "Undefined";
> > +               case 1:
> > +                       return "Blood Pressure Monitor";
> > +               case 2:
> > +                       return "Thermometer";
> > +               case 3:
> > +                       return "Weighing Scale";
> > +               case 4:
> > +                       return "Glucose Meter";
> > +               case 5:
> > +                       return "Pulse Oximeter";
> > +               case 6:
> > +                       return "Heart/Pulse Rate Monitor";
> > +               case 7:
> > +                       return "Health Data Display";
> > +               }
> > +               break;
> >        }
> >        return "Unknown (reserved) minor device class";
> >  }
> > @@ -668,7 +686,9 @@ static void cmd_class(int ctl, int hdev, char *opt)
> >                                        "Audio/Video",
> >                                        "Peripheral",
> >                                        "Imaging",
> > -                                       "Uncategorized" };
> > +                                       "Wearable",
> > +                                       "Toy",
> > +                                       "Health" };
> >        int s = hci_open_dev(hdev);
> >
> >        if (s < 0) {
> > @@ -706,7 +726,9 @@ static void cmd_class(int ctl, int hdev, char *opt)
> >                } else
> >                        printf("Unspecified");
> >                printf("\n\tDevice Class: ");
> > -               if ((cls[1] & 0x1f) >= sizeof(major_devices) / sizeof(*major_devices))
> > +               if (0x1f == cls[1])
> 
> This test is inverted, in BlueZ code we use the form: (variable
> operator constant)
> 
> > +                       printf("Uncategorized\n");
> > +               else if ((cls[1] & 0x1f) >= sizeof(major_devices) / sizeof(*major_devices))
> 
> See above.

Will fix both.

> >                        printf("Invalid Device Class!\n");
> >                else
> >                        printf("%s, %s\n", major_devices[cls[1] & 0x1f],
> > --
> > 1.6.6.1
> > --
> >
> 
> 
> Cheers,

Thanks for the comments! I'll send a fixed patch.

But here's a followup question: what's the convention for submitting a
change to a patch - another patch on top of it, or a full replacement
patch? As a reply to this thread, or as new message?

