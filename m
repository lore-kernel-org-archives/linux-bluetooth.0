Return-Path: <d_gujarathi@hotmail.com>
From: "Deepesh S Gujarathi" <d_gujarathi@hotmail.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
References: <LAW11-OE33GHeqXipAS00015cf1@hotmail.com> <1073314449.2508.1.camel@pegasus>
Subject: Re: blueZ-bthid testing
Date: Tue, 6 Jan 2004 18:33:22 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Message-ID: <LAW11-OE14JMxg22Civ0001db81@hotmail.com>
List-ID: <bluez-devel.lists.sourceforge.net>


Hi Marcel,

I tried to create the device node using the following commands but I still
get the same error ( > bthid[2040]: can't open input device: no such file or
directory (2)) .
I created a device node using the command
# mknod /dev/misc/uinput c 10 101
I hope I an not feeding the wrong MAJOR device number.
Do let me know the proper command to create the device nodes for creating
uinput or mice node.

thanks
Deepesh

> Hi,
>
> > I'm implementing the firmware for a bluetooth HID mouse using an
> > Ericsson module and using the bluez stack to test my implementation.
> > For a start I was trying to make the MS Intelliexplorer mouse work
> > with Marcels bthid program, but somehow havent been able to see the
> > cursor move, heres what all I did
> >
> > - downloaded a crisp new linux2.4.22 kernel from kernel.org
> >
> > - patched the kenel with patch-2.4.22-mh2.gz
> >
> > - recompiled the kenel with Input Core support (uinput.o) + BlueZ
> > modules + usb support (usb_ohci) modules etc.
> >
> > - reboot with linux2.4.22-mh2 kernel
> >
> > - downloaded the latest rpms and did a rpm update to bluez.
> >
> > - downloaded and compiled the libs2 and utils2 as per Marcel's
> > instructions (using --prefix /opt/bluetooth etc.) from cvs
> >
> > - added the following to the XFree86config-4 file
> >
> > Section "InputDevice"
> >         Identifier "MSmouse"
> >         driver "mouse"
> >         option "Protocol" "IMPS/2"
> >         option "Device" "/dev/input/mice"
> >         option "ZAxisMapping" "4 5"
> >         option "Buttons" "5"
> >         option "Emulate3Buttons" "false"
> > EndSection
> >
> > and added
> > InputDevice  "MSmouse" "SendCoreEvents" to the ServerLayout section
> >
> > - the following modules are present (lsmod)
> >
> > l2cap.o
> > bluez.o
> > input.o
> > uinput.o
> > usb_uhci.o
> > hci_usb.o
> > usb_core.o
> >
> > - run hcid daemon
> >
> > - run bthid daemon
> >
> > -run /opt/bluetooth/sbin/bthid -c 00:50:F2:E5:89:15 (here the
> > /var/log/messages shows the following )
> >
> > bthid[2040]: cant open input device: no such file or directory (2)
> > bthid[2040]: connected: Microsoft Five Button Mouse
> >
> > when I do a hcitool scan, the local device detects the MS
> > IntelliExplorer mouse. but nothing happens further.
> >
> > am I missing something relevant ?
>
> what about creating the /dev/input/uinput device node?
>
> Regards
>
> Marcel
>
>
>
