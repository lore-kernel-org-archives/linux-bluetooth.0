Return-Path: <erics_trip@hotmail.com>
From: "Forever Again" <erics_trip@hotmail.com>
To: marcel@holtmann.org
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] HCI not working after using usb_storage
Date: Sat, 14 Feb 2004 00:11:24 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law12-F120WaL4Oftvg00010095@hotmail.com>
List-ID: <bluez-users.lists.sourceforge.net>

I apologize to everyone ... my first day on the list, and I wasted your 
time. For some reason, after I had added the usb_storage, the power to my 
bluetooth went off. Or maybe I turned it off by accident. I turned it back 
on and hciconfig found my device. I'll try to be less hasty before posting 
to the list about problems like that.
Evan




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
>
>
>-------------------------------------------------------
>SF.Net is sponsored by: Speed Start Your Linux Apps Now.
>Build and deploy apps & Web services for Linux with
>a free DVD software kit from IBM. Click Now!
>http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users

_________________________________________________________________
Optimize your Internet experience to the max with the new MSN Premium 
Internet Software. http://click.atdmt.com/AVE/go/onm00200359ave/direct/01/
