Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Printer adapter w/o SDP
From: Marcel Holtmann <marcel@holtmann.org>
To: Michael Albinus <michael.albinus@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <nq7jt0m8wd.fsf@alcatel.de>
References: <87acxxxly1.fsf@gmx.de> <1090178500.4400.25.camel@pegasus>
	 <87wu11w1e3.fsf@gmx.de> <1090180872.4400.36.camel@pegasus>
	 <nq7jt0m8wd.fsf@alcatel.de>
Content-Type: text/plain
Message-Id: <1090776708.31693.29.camel@pegasus>
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
Date: Sun, 25 Jul 2004 19:31:48 +0200

Hi Michael,

> > so everything is as new as possible. Seems we must fix the code to work
> > correct with UUID32. Where do you got this printer adapter? Looks like I
> > have to buy one of them or is there a sponsor out there?
> 
> It's a cheap Typhoon device
> <http://www.anubisline.com/english/articlec.asp?id=20005&catid=200>,
> bought at ebay. I'll donate it to you; no problem to get another
> one. Could you, please, provide me a postal address?

thanks for the device. It was a bug in the SDP part of the Bluetooth
library. The funny thing is that it was able to work with UUID128 and
UUID16, but it seems that actually nobody used UUID32 for protocol
identifiers before. The fix for that is in the CVS now.

Besides using UUID32 which is really stupid, but allowed, this devices
uses an unallowed manufacturer id. It is an end user product ;)

# hcitool info 00:0C:xx:xx:xx:xx
Requesting information ...
        BD Address:  00:0C:xx:xx:xx:xx
        Device Name: PCR HCRP SPP OPP
        LMP Version: 1.1 (0x1) LMP Subversion: 0x904
        Manufacturer: internal use (65535)
        Features: 0xff 0xfa 0x05 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset> 
                <timing accuracy> <role switch> <hold mode> <sniff mode> 
                <RSSI> <SCO link> <HV2 packets> <HV3 packets> <u-law log> 
                <A-law log> <CVSD> <power control> 

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
