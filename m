Return-Path: <djrobx@hotmail.com>
From: "Rob Raper" <djrobx@hotmail.com>
To: marcel@holtmann.org
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] What's the best way to go about device detection?
Date: Mon, 17 May 2004 09:45:04 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY14-F125F0uTDF1cy000524f0@hotmail.com>
List-ID: <bluez-users.lists.sourceforge.net>

I have two CSR based dongles (one D-Link DBt120 rev B3) and one Microsoft 
dongle from their wireless keyboard & mouse pack.   They both operate pretty 
much identically.   If I can obtain a 1.2 dongle that supports getting rssi 
on a scan it's probably a better solution anyway.   Your hardware support 
list shows all 1.1, however, do you know which dongles can support 1.2?

Also just FYI, the phones we're connecting to at the moment are Nokia 3650s.

The D-link that I do most of the testing on shows:

hci0:   Type: USB
        BD Address: 00:0F:3D:0B:FB:45 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:3686 acl:0 sco:0 events:273 errors:0
        TX bytes:2832 acl:0 sco:0 commands:205 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: MASTER
        Name: 'Embt'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 
0x20d
        Manufacturer: Cambridge Silicon Radio (10)



>From: Marcel Holtmann <marcel@holtmann.org>
>To: Rob Raper <djrobx@hotmail.com>
>CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
>Subject: Re: [Bluez-users] What's the best way to go about device 
>detection?
>Date: Mon, 17 May 2004 13:04:52 +0200
>
>Hi Rob,
>
> > Without involving any of my source code at alll, I can demonstrate one 
>of my
> > biggest problems.     I'll first create a connection to an existing
> > bluetooth device.  It works fine.  I can get an RSSI value or link 
>value.
> > Then, I'lll try a non-existent device.   I get a connection timed out 
>error
> > fairly quickly.  Great, that's exactly what I want and what I expect.  
>What
> > follows, however, is what is really causing me problems.  I can no 
>longer
> > connect to the valid bt device.   I just get errors for a long time.  I
> > can't disconnect either.   How can I clear out the failed connection and
> > move on without everything breaking down like this?
> >
> > pluto62:~/bluez-utils-2.4/tools# hcitool cc 00:60:57:23:35:15
> > pluto62:~/bluez-utils-2.4/tools# hcitool rssi 00:60:57:23:35:15
> > RSSI return value: -1
> > pluto62:~/bluez-utils-2.4/tools# hcitool dc 00:60:57:23:35:15
> >
> > So far so good...Now try an invalid address
> >
> > pluto62:~/bluez-utils-2.4/tools# hcitool cc 00:60:57:23:35:14
> > Can't create connection: Connection timed out
> >
> > As expected.
> >
> > pluto62:~/bluez-utils-2.4/tools# hcitool dc 00:60:57:23:35:14
> > Disconnect failed: Input/output error
> >
> > Why an input/output error?  It's on the con list, how do I get it off?
>
>if create_connection fails no ACL link is in the connection list and
>there is no need to disconnect it unless we have a bug in the Bluetooth
>core layer. However using the native HCI create_connection and
>disconnect functions is not a good idea and the timeout you see is not
>from the Bluetooth chip I think. If the create_connection process is
>still running you can't disconnect anything and in some cases you
>trouble the Bluetooth chip with such actions. Check with hcidump what is
>going on.
>
>What kind of Bluetooth modules are you using? Show us "hciconfig -a".
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by: SourceForge.net Broadband
>Sign-up now for SourceForge Broadband and get the fastest
>6.0/768 connection for only $19.95/mo for the first 3 months!
>http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users

_________________________________________________________________
Express yourself with the new version of MSN Messenger! Download today - 
it's FREE! http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
