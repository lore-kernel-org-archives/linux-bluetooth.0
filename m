Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] PICO Bluetooth Card / Modem
From: Marcel Holtmann <marcel@holtmann.org>
To: Monika Hubrich <monikahubrich@aol.com>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <005001c4aeef$5d9d8e80$8601b6ac@monika>
References: <005001c4aeef$5d9d8e80$8601b6ac@monika>
Content-Type: text/plain
Message-Id: <1097485834.9474.0.camel@notepaq>
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
Date: Mon, 11 Oct 2004 11:11:28 +0200

Hi Monika,

> I tried to install my bluetooth modem (PICO/Sphinx Bluetooth Modem) on
> SuSE Linux 8.2.
> But I get always the message "Connection refused".
> What do I wrong?
>  
> linux:~ # hciconfig
> hci0:   Type: PCCARD
>         BD Address: 00:80:37:14:C3:51 ACL MTU: 672:10  SCO MTU: 64:0
>         UP RUNNING PSCAN ISCAN
>         RX bytes:1407 acl:29 sco:0 events:69 errors:0
>         TX bytes:1157 acl:34 sco:0 commands:35 errors:0
>  
> linux:~ # hciconfig hci0 up
> linux:~ # hciconfig -a
> hci0:   Type: PCCARD
>         BD Address: 00:80:37:14:C3:51 ACL MTU: 672:10  SCO MTU: 64:0
>         UP RUNNING PSCAN ISCAN
>         RX bytes:1407 acl:29 sco:0 events:69 errors:0
>         TX bytes:1157 acl:34 sco:0 commands:35 errors:0
>         Features: 0x07 0xea 0x31 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'BlueZ (0)'
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0xb LMP Ver: 1.1 (0x1) LMP Subver:
> 0x300
>         Manufacturer: Ericsson Technology Licensing (0)
>  
> linux:~ # hcitool scan
> Scanning ...
>         00:02:C7:09:9B:FA       n/a
> linux:~ # sdptool browse 00:02:C7:09:9B:FA
> Browsing 00:02:C7:09:9B:FA ...
> linux:~ # rfcomm connect 0 00:02:C7:09:9B:FA 1
> Can't connect RFCOMM socket: Connection refused
> linux:~ # rfcomm connect 0 00:02:C7:09:9B:FA 2
> Can't connect RFCOMM socket: Connection refused

run "hcidump -x" as root and show us the output.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
