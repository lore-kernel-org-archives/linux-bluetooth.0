Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] SDP problems on embedded device
From: Marcel Holtmann <marcel@holtmann.org>
To: "Rolf E. Thorup" <rolft@daimi.au.dk>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40FE3ACF.4030608@daimi.au.dk>
References: <40FC2322.4060204@daimi.au.dk>
	 <1090270387.4400.100.camel@pegasus>  <40FCF471.4010501@daimi.au.dk>
	 <1090334863.4400.124.camel@pegasus>  <40FD5217.3060705@daimi.au.dk>
	 <1090345399.21683.2.camel@pegasus>  <40FE3ACF.4030608@daimi.au.dk>
Content-Type: text/plain
Message-Id: <1090404291.21683.81.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 21 Jul 2004 12:04:51 +0200

Hi Rolf,

> >>>Try using 2.4.19-mh14 and show us the output of "hciconfig -a" on your
> >>>Cerfcube. Is the Cerfcube a big endian machine?
> >>
> >>After compiling a new kernel and reflashing:
> > 
> > does this kernel work?
> 
> Yes (but I haven't tested much), although I get this error message when 
> booting:

I meant, if the SDP browsing works with that kernel patch?

> Calculating module dependencies... depmod: *** Unresolved symbols in 
> /lib/modules/2.4.19-rmk6-pxa1-cerf1/kernel/drivers/bluetooth/bfusb.o

This can happen. You won't need the bfusb.o driver. Try a clean compile.

> A couple of months ago when I first tried to get sdp to work, I also 
> randomly tried the mh13- and mh15-patches but with the same outcome as 
> with the mh14- and mh17-patches.

So is the mh14 working for you or not? I don't get the correct point
here.

> > Please try another dongle with at least HCI 16.4 firmware.
> 
> Sorry for being a little bit puzzled now. How do I see what the firmware 
> version is for my current dongle? I translate the HCI Rev hex number to 
> 469 in decimal so should I just put the decimal point after the 4?
> 
> At the moment I also have another USB dongle available and the output 
> from "hciconfig hci0 version" is
> 
> [root@xscale3 /root]# hciconfig hci0 version
> hci0:   Type: USB
>          BD Address: 00:0C:76:B1:05:74 ACL MTU: 192:8  SCO MTU: 64:8
>          HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP 
> Subver: 0x20d
>          Manufacturer: Cambridge Silicon Radio (10)
> 
> Which give HCI Rev number 525 in decimal. Are my dongles really that 
> antique?

You can use "hciconfig hci0 revision" or look it up on my CSR page.

> Final question. I'm curious about why I should try the mh14-patch? Do 
> one experience subtle differences between the output from hciconfig?

I think that this change "Fix non-blocking socket race conditions" could
have caused some problems. One part of it already has :(

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
