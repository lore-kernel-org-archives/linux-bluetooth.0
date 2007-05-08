Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1178622391.2824.34.camel@pmac.infradead.org>
References: <463F7386.6050900@am.sony.com>
	<1178608551.8628.52.camel@aeonflux.holtmann.net>
	<1178622391.2824.34.camel@pmac.infradead.org>
Date: Tue, 08 May 2007 15:19:18 +0200
Message-Id: <1178630359.8628.63.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: Geoff Levand <geoffrey.levand@am.sony.com>, bluez-devel@lists.sf.net,
        maxk@qualcomm.com
Subject: Re: [Bluez-devel] [RFC] PS3 Bluetooth quirk for HCI_FLT_CLEAR_ALL
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

Hi David,

> hci0:   Type: USB
>         BD Address: 00:13:A9:79:09:C3 ACL MTU: 384:8 SCO MTU: 64:8
>         UP RUNNING PSCAN 
>         RX bytes:408 acl:0 sco:0 events:17 errors:0
>         TX bytes:317 acl:0 sco:0 commands:17 errors:0
>         Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
>         Link policy: RSWITCH HOLD SNIFF PARK 
>         Link mode: SLAVE ACCEPT 
>         Name: 'ps3.infradead.org-0'
>         Class: 0x120104
>         Service Classes: Networking, Object Transfer
>         Device Class: Computer, Desktop workstation
>         HCI Ver: 2.0 (0x3) HCI Rev: 0xe18 LMP Ver: 2.0 (0x3) LMP Subver: 0xe18
>         Manufacturer: Cambridge Silicon Radio (10)

since it is a CSR device, please also do "hciconfig hci0 revision" as
root and "bccmd buildname" plus "bccmd builddef".

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
