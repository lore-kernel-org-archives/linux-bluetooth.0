Return-Path: <erics_trip@hotmail.com>
From: "Forever Again" <erics_trip@hotmail.com>
To: marcel@holtmann.org
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] HCI not working after using usb_storage
Date: Fri, 13 Feb 2004 23:44:29 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law12-F1060zpn4XrkQ0001da3d@hotmail.com>
List-ID: <bluez-users.lists.sourceforge.net>

oh, I probably should've mentioned this, but this is an HP laptop, with 
their built in bluetooth, which (I believe) uses a USB hub.



>From: Marcel Holtmann <marcel@holtmann.org>
>To: Forever Again <erics_trip@hotmail.com>
>CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
>Subject: Re: [Bluez-users] HCI not working after using usb_storage
>Date: Sat, 14 Feb 2004 00:42:31 +0100
>
>Hi Evan,
>
> > I have a logitech mx900 mouse, which was working fine before. I'm 
>running
> > the 2.6.2 kernel on Fedora. Using the bthid daemon it was working. Then 
>I
> > tried to use a usb memory stick, and after using the usb_storage driver, 
>my
> > mouse stopped working. I check to see what was up and I noticed that my 
>hci
> > device was gone. When I try running hciconfig hci0 up, I get this:
> >
> > Can't open HCI socket.: Address family not supported by protocol.
> >
> > What do I need to do to get the mouse working again, and is it possible 
>to
> > use the usb_storage as well. I'm more concerned about using the mouse, 
>but
> > both would be nice.
>
>check your log files for a kernel oops or other specific messages from
>the USB bus. If you really think that this only happen in conjunction
>with the USB storage driver then you should post this to the USB mailing
>list.
>
>Regards
>
>Marcel
>
>

_________________________________________________________________
Let the advanced features & services of MSN Internet Software maximize your 
online time. http://click.atdmt.com/AVE/go/onm00200363ave/direct/01/
