Return-Path: <charles@bueche.ch>
Subject: Re: [Bluez-devel] Re: blueZ-bthid testing
From: Charles Bueche <charles@bueche.ch>
To: Deepesh S Gujarathi <d_gujarathi@hotmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Law11-OE66zpDERHZWY00000fb1@hotmail.com>
References: <LAW11-OE33GHeqXipAS00015cf1@hotmail.com>
	 <1073314449.2508.1.camel@pegasus> <LAW11-OE14JMxg22Civ0001db81@hotmail.com>
	 <1073394980.2508.59.camel@pegasus>
	 <Law11-OE46C3SpmFZfs000064c7@hotmail.com>
	 <1073481066.2508.150.camel@pegasus>
	 <Law11-OE66zpDERHZWY00000fb1@hotmail.com>
Content-Type: text/plain
Message-Id: <1073563642.6616.14.camel@bluez.bueche.ch>
Mime-Version: 1.0
Date: Thu, 08 Jan 2004 13:07:22 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Hi,

looks OK to me. If you want, when you have a stable version, I can host
it beside mine on my web server.

Charles

On Thu, 2004-01-08 at 12:09, Deepesh S Gujarathi wrote:
> Hi all,
> 
> Thanks to Marcel, finally the MS mouse is working effortlessly with the
> bthid program and I am a happy man.
> 
> I had messed up two things,
> - had not loaded the mousedev.o module and
> - made a typo in the XF86Config-4 file.
> 
> my two cents
> please find attached a howto document that details the steps involved in
> making the MS IntelliExplorer mouse working with Marcel's bthid utility.
> 
> PS: maybe some one can just verify the howto document for any possible
> errors.
> 
> thanks everyone for your patience.
> Deepesh
> 
> Deepesh S Gujarathi
> Encodex Technologies (India) Pvt. Ltd.
> 69 Amchi Colony, Bavdhan Khurd
> Pune - 411021
> 91-20-2953590 , 2953591
> URL: www.encodexindia.com
> 
> 
> 
> ----- Original Message -----
> From: "Marcel Holtmann" <marcel@holtmann.org>
> To: "Deepesh S Gujarathi" <d_gujarathi@hotmail.com>
> Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
> Sent: Wednesday, January 07, 2004 6:41 PM
> Subject: Re: blueZ-bthid testing
> 
> 
> > Hi Deepesh,
> >
> > > I created the uinput node with the following command
> > > # mknod /dev/input/uinput c 10 223
> > > and the bthid error (bthid[2040]: can't open input device: no such file
> or
> > > directory (2))  is gone, but for some reason I still cant move the
> cursor.
> > >
> > > - I checked the hcidump and it shows all the data coming from the MS
> > > wireless mouse as I move the mouse and click
> > >
> > > - the tail -f /var/log/messages shows the following
> > >     Bluetooth HID service started
> > >     Connected: Microsoft Five Button Mouse
> > >     Vendor HID usage 0xff00fe01 value 0x1
> > >     adequate battery
> > >
> > > - when I do an lsmod I see
> > >     Module         Used by                Not     tainted
> > >     uinput            1
> > >     hci_usb          1
> > >     l2cap              5
> > >     bluez              4 [hci_usb l2cap]
> > >     input              0 (autoclean)    [uinput]
> > >
> > > I doubt the following, if anyone can verify it would be great
> > >
> > > - my XF86Config-4 file consists
> > >
> > > Section "InputDevice"
> > >          Identifier "MSmouse"
> > >          driver "mouse"
> > >          option "Protocol" "IMPS/2"
> > >          option "Device" "/dev/input/mice"
> > >          option "ZAxisMapping" "4 5"
> > >          option "Buttons" "5"
> > >          option "Emulate3Buttons" "false"
> > > EndSection
> > >
> > > now is the protocol IMPS/2 correct for a MS Intelliexplorer mouse (I
> copied
> > > it from the Logitech example) ?
> >
> > yes it is, but maybe you need to have additional CorePointer options.
> > Look at some XFree config howto's.
> >
> > > - also in the option "Device" the value specified as "/dev/input/mice"
> does
> > > it need to be /dev/input/uinput or something else ?
> >
> > No. The mice device is correct.
> >
> > > - does the mousedev module need to be loaded to make it work ?
> >
> > Yes.
> >
> > Regards
> >
> > Marcel
> >
> >
> >
-- 
Charles Bueche <charles@bueche.ch>
sand, snow, wave, wind and net -surfer
