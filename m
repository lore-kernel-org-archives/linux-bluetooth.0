Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Piconet problems
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <I92QQS$82908F943F74AC6A26E56B7A5E562E11@libero.it>
References: <I92QQS$82908F943F74AC6A26E56B7A5E562E11@libero.it>
Content-Type: text/plain
Message-Id: <1103637360.15574.7.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 21 Dec 2004 14:56:00 +0100

Hi Jers,

> > What is the output of "hciconfig -a" for these dongles? 
> >  
>  
> hci0:   Type: USB 
>         BD Address: 00:E0:98:85:A1:5F ACL MTU: 192:8  SCO MTU: 64:8 
>         UP RUNNING PSCAN ISCAN 
>         RX bytes:15287 acl:102 sco:0 events:610 errors:0 
>         TX bytes:38313 acl:383 sco:0 commands:136 errors:0 
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00 
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
>         Link policy: 
>         Link mode: SLAVE ACCEPT 
>         Name: 'Slave1' 
>         Class: 0x000000 
>         Service Classes: Unspecified 
>         Device Class: Miscellaneous, 
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Subver: 0x175 
>         Manufacturer: Cambridge Silicon Radio (10) 
>  
> hci0:   Type: USB 
>         BD Address: 00:E0:98:85:A1:64 ACL MTU: 192:8  SCO MTU: 64:8 
>         UP RUNNING PSCAN ISCAN 
>         RX bytes:22169 acl:233 sco:0 events:192 errors:0 
>         TX bytes:7885 acl:92 sco:0 commands:62 errors:0 
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00 
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
>         Link policy: 
>         Link mode: SLAVE ACCEPT 
>         Name: 'Slave2' 
>         Class: 0x000000 
>         Service Classes: Unspecified 
>         Device Class: Miscellaneous, 
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Subver: 0x175 
>         Manufacturer: Cambridge Silicon Radio (10) 
>  
> 
> hci0:   Type: USB 
>         BD Address: 00:08:E0:01:9E:86 ACL MTU: 192:8  SCO MTU: 64:8 
>         UP RUNNING PSCAN ISCAN 
>         RX bytes:21366 acl:130 sco:0 events:217 errors:0 
>         TX bytes:1668 acl:23 sco:0 commands:108 errors:0 
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00 
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
>         Link policy: 
>         Link mode: SLAVE ACCEPT 
>         Name: 'Master' 
>         Class: 0x000000 
>         Service Classes: Unspecified 
>         Device Class: Miscellaneous, 
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1 (0x1) LMP Subver: 0x33c 
>         Manufacturer: Cambridge Silicon Radio (10) 

there is no link policy set (rswitch) and both of your slaves have
firmwares pre HCI 16.4 and so there are limitations. Check my webpage
about CSR for more details.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
