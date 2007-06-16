Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <003e01c7af3c$65f14e00$a100010a@Libera.local>
References: <003e01c7af3c$65f14e00$a100010a@Libera.local>
Date: Sat, 16 Jun 2007 09:33:11 +0200
Message-Id: <1181979191.6846.55.camel@aeonflux.inter-touch.com>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] RV: sdp_connect don't work with some handsets
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Jose,

> Here you can see "hciconfig -a" result:
> 
> ******************************************
> [root@localhost sbin]# ./hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:0B:0D:0B:21:6F ACL MTU: 120:20 SCO MTU: 0:0
>         UP RUNNING PSCAN ISCAN 
>         RX bytes:33459 acl:496 sco:0 events:750 errors:0
>         TX bytes:46184 acl:740 sco:0 commands:228 errors:0
>         Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
>         Link policy: RSWITCH HOLD SNIFF PARK 
>         Link mode: SLAVE ACCEPT 
>         Name: 'libera networks'
>         Class: 0x120104
>         Service Classes: Networking, Object Transfer
>         Device Class: Computer, Desktop workstation
>         HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x757
>         Manufacturer: Silicon Wave (11)
> *******************************************
> 
> With "hcitool info MAC" I have the same problem:

do you have a CSR based dongle that you can use for testing. I wanna
check that this is not a dongle problem.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
