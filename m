Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] BT unter SuSE 9.2
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAsfVFWzu3xEqf6jbMNBUU/QEAAAAA@t-online.de>
References: 
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAsfVFWzu3xEqf6jbMNBUU/QEAAAAA@t-online.de>
Content-Type: text/plain
Message-Id: <1102679972.9481.1.camel@pegasus>
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
Date: Fri, 10 Dec 2004 12:59:32 +0100

Hi Peter,

> Linux-Notebook:~ # hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:03:7A:08:54:80 ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN AUTH
>         RX bytes:1038 acl:0 sco:0 events:34 errors:0
>         TX bytes:371 acl:0 sco:0 commands:22 errors:0
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'BlueZ (0)'
>         Class: 0x100100
>         Service Classes:
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver:
> 0x20d
>         Manufacturer: Cambridge Silicon Radio (10)
> 
> Linux-Notebook:~ #
> 
> and now hciconfig -x
> I have to send the PIN to the bt-accesspoint, the PIN is set in
> /etc/bluetooth/pin and in hcid.conf security is set to auto.

and you switched your device into security mode 3. This will always
cause troubles. Deaktivate authentication and encryption with YaST.

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
