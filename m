Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: hcid config
From: Marcel Holtmann <marcel@holtmann.org>
To: Chris Searle <usenet@chrissearle.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <lg4qnzgkuz.fsf@montgomery.empolis.no>
References: <lgk6wvgqax.fsf@montgomery.empolis.no>
	 <1090572097.21828.53.camel@pegasus> <lg8ydbgliv.fsf@montgomery.empolis.no>
	 <1090572685.21828.58.camel@pegasus>  <lg4qnzgkuz.fsf@montgomery.empolis.no>
Content-Type: text/plain
Message-Id: <1090573758.4791.1.camel@pegasus>
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
Date: Fri, 23 Jul 2004 11:09:18 +0200

Hi Chris,

> hci0:   Type: USB
>         BD Address: 00:30:C2:08:0A:A1 ACL MTU: 128:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN 
>         RX bytes:2762 acl:20 sco:0 events:74 errors:0
>         TX bytes:427 acl:10 sco:0 commands:32 errors:0
>         Features: 0xff 0xff 0x05 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
>         Link policy: 
>         Link mode: SLAVE ACCEPT 
>         Name: 'Chris'
>         Class: 0x000000
>         Service Classes: Unspecified
>         Device Class: Miscellaneous, 
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x72 LMP Ver: 1.1 (0x1) LMP Subver: 0x72
>         Manufacturer: Cambridge Silicon Radio (10)
> 
> hci1:   Type: USB
>         BD Address: 00:0A:3A:54:5B:49 ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN 
>         RX bytes:1619 acl:0 sco:0 events:45 errors:0
>         TX bytes:161 acl:0 sco:0 commands:25 errors:0
>         Features: 0xff 0xff 0x0b 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
>         Link policy: 
>         Link mode: SLAVE ACCEPT 
>         Name: 'WINDOWS-2000'
>         Class: 0x000000
>         Service Classes: Unspecified
>         Device Class: Miscellaneous, 
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
>         Manufacturer: Cambridge Silicon Radio (10)

these devices are not brought up by hcid. Activate "autoinit" in
hcid.conf and restart the hcid.

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
