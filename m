Return-Path: <cyrus@holtmann.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: btusb hibernation/suspend breakage in current -git
Date: Wed, 27 Aug 2008 15:29:46 +0200
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Oliver Neukum <oliver@neukum.org>,
 Stefan Seyfried <seife@suse.de>,
 linux-pm@lists.linux-foundation.org,
 linux-bluetooth@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <200808221520.19791.oliver@neukum.org> <5E249C07-0710-49B2-B352-87DDA85E891D@holtmann.org> <20080827091031.GA1688@elf.ucw.cz>
In-Reply-To: <20080827091031.GA1688@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808271529.47760.rjw@sisk.pl>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday, 27 of August 2008, Pavel Machek wrote:
> On Wed 2008-08-27 07:22:58, Marcel Holtmann wrote:
> > Hi Rafael,
> >
> >>>>>>> Good. Can you test what happens if you unplug the device while 
> >>>>>>> suspended
> >>>>>>> and hibernated?
> >>>>>>
> >>>>>> It's built-in, I can't unplug it. :-)
> >>>>>
> >>>>> Maybe you can disable it in the BIOS, but this might change the DSDT / 
> >>>>> other
> >>>>> system configuration, so it might break resume in other ways :-(
> >>>>
> >>>> There is a switch that's supposed to disable the radio (rfkill or 
> >>>> something).
> >>>> I used it to switch the radio off while the box was waking up from 
> >>>> hibernation
> >>>> and kbluetooth didn't find the adapter after the resume.  After I've 
> >>>> pressed
> >>>> the "radio off" button again, the bluetooth appears to be functional 
> >>>> again.
> >>>>
> >>>> However, this "radio off" button is shared between bluetooth and 
> >>>> wireless
> >>>> (b43) and there are some surprising interactions.  Nothing seems to be 
> >>>> broken,
> >>>> though.
> >>>
> >>> This doesn't explain the original failure. Can you comment out the 
> >>> support
> >>> for suspend/resume in the driver and try again?
> >>
> >> With that commented out, I'm able to reproduce the failure.  With the 
> >> original
> >> patch, I'm not.
> >
> > I've never seen any issues with the suspend/resume and btusb, but I must 
> > admit that I am using an X61 and in that case pm-utils has a magic hack to 
> > disable Bluetooth before suspend and this means a clean disconnect from the 
> > USB bus.
> 
> I was using x60 _without_ that script, and it was okay for long long
> time, but it has problems now. Something regressed somewhere.
> 
> Rafael, could you try if 2.6.26 suspends ok if you don't unload
> anything?

It appears to be fine (I couldn't reproduce the problem on it).

Thanks,
Rafael
