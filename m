Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] SDP problems on embedded device
From: Marcel Holtmann <marcel@holtmann.org>
To: "Rolf E. Thorup" <rolft@daimi.au.dk>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40FD5217.3060705@daimi.au.dk>
References: <40FC2322.4060204@daimi.au.dk>
	 <1090270387.4400.100.camel@pegasus>  <40FCF471.4010501@daimi.au.dk>
	 <1090334863.4400.124.camel@pegasus>  <40FD5217.3060705@daimi.au.dk>
Content-Type: text/plain
Message-Id: <1090345399.21683.2.camel@pegasus>
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
Date: Tue, 20 Jul 2004 19:43:19 +0200

Hi Rolf,

> > Try using 2.4.19-mh14 and show us the output of "hciconfig -a" on your
> > Cerfcube. Is the Cerfcube a big endian machine?
> 
> After compiling a new kernel and reflashing:

does this kernel work?

> [root@xscale3 /root]# hciconfig -a
> hci0:   Type: USB
>          BD Address: 00:0A:94:00:20:2A ACL MTU: 192:8  SCO MTU: 64:8
>          UP RUNNING PSCAN ISCAN
>          RX bytes:99 acl:0 sco:0 events:13 errors:0
>          TX bytes:296 acl:0 sco:0 commands:12 errors:0
>          Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>          Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>          Link policy: RSWITCH HOLD SNIFF PARK
>          Link mode: SLAVE ACCEPT
>          Name: 'xscale3'
>          Class: 0x000100
>          Service Classes: Unspecified
>          Device Class: Computer, Uncategorized
>          HCI Ver: 1.1 (0x1) HCI Rev: 0x1d3 LMP Ver: 1.1 (0x1) LMP 
> Subver: 0x1d3
>          Manufacturer: Cambridge Silicon Radio (10)

Please try another dongle with at least HCI 16.4 firmware.

> With regards to endianess, good quiestion. After googling around I 
> actually think it can be both. But I made a small program testing it and 
> it said little endian.

Was only an idea. In general the BlueZ should now be endian safe, but
you never know for sure ;)

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
