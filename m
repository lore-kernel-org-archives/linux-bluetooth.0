Return-Path: <d_gujarathi@hotmail.com>
From: "Deepesh S Gujarathi" <d_gujarathi@hotmail.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
References: <LAW11-OE33GHeqXipAS00015cf1@hotmail.com> <1073314449.2508.1.camel@pegasus> <LAW11-OE14JMxg22Civ0001db81@hotmail.com> <1073394980.2508.59.camel@pegasus>
Subject: Re: blueZ-bthid testing
Date: Wed, 7 Jan 2004 18:26:39 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Message-ID: <Law11-OE46C3SpmFZfs000064c7@hotmail.com>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

I created the uinput node with the following command
# mknod /dev/input/uinput c 10 223
and the bthid error (bthid[2040]: can't open input device: no such file or
directory (2))  is gone, but for some reason I still cant move the cursor.

- I checked the hcidump and it shows all the data coming from the MS
wireless mouse as I move the mouse and click

- the tail -f /var/log/messages shows the following
    Bluetooth HID service started
    Connected: Microsoft Five Button Mouse
    Vendor HID usage 0xff00fe01 value 0x1
    adequate battery

- when I do an lsmod I see
    Module         Used by                Not     tainted
    uinput            1
    hci_usb          1
    l2cap              5
    bluez              4 [hci_usb l2cap]
    input              0 (autoclean)    [uinput]

I doubt the following, if anyone can verify it would be great

- my XF86Config-4 file consists

Section "InputDevice"
         Identifier "MSmouse"
         driver "mouse"
         option "Protocol" "IMPS/2"
         option "Device" "/dev/input/mice"
         option "ZAxisMapping" "4 5"
         option "Buttons" "5"
         option "Emulate3Buttons" "false"
EndSection

now is the protocol IMPS/2 correct for a MS Intelliexplorer mouse (I copied
it from the Logitech example) ?

- also in the option "Device" the value specified as "/dev/input/mice" does
it need to be /dev/input/uinput or something else ?

- does the mousedev module need to be loaded to make it work ?

I am determined to get this MS mouse working....;)

thanks for your patience
Deepesh

Deepesh S Gujarathi
Encodex Technologies (India) Pvt. Ltd.
69 Amchi Colony, Bavdhan Khurd
Pune - 411021
91-20-2953590 , 2953591
URL: www.encodexindia.com



----- Original Message -----
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "Deepesh S Gujarathi" <d_gujarathi@hotmail.com>
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Sent: Tuesday, January 06, 2004 6:46 PM
Subject: Re: blueZ-bthid testing


> Hi Deepesh,
>
> > I tried to create the device node using the following commands but I
still
> > get the same error ( > bthid[2040]: can't open input device: no such
file or
> > directory (2)) .
> > I created a device node using the command
> > # mknod /dev/misc/uinput c 10 101
> > I hope I an not feeding the wrong MAJOR device number.
>
> yes you do. According to Documentation/devices.txt it is "c 10 223". And
> of course the kernel module "uinput" must be loaded.
>
> Regards
>
> Marcel
>
>
>
