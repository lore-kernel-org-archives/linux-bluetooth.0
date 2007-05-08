Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: David Woodhouse <dwmw2@infradead.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1178630359.8628.63.camel@aeonflux.holtmann.net>
References: <463F7386.6050900@am.sony.com>
	<1178608551.8628.52.camel@aeonflux.holtmann.net>
	<1178622391.2824.34.camel@pmac.infradead.org>
	<1178630359.8628.63.camel@aeonflux.holtmann.net>
Date: Tue, 08 May 2007 16:47:24 +0100
Message-Id: <1178639244.2824.40.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: maxk@qualcomm.com, bluez-devel@lists.sf.net,
        Geoff Levand <geoffrey.levand@am.sony.com>
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

On Tue, 2007-05-08 at 15:19 +0200, Marcel Holtmann wrote:
> since it is a CSR device, please also do "hciconfig hci0 revision" as
> root and "bccmd buildname" plus "bccmd builddef".

Sorry for delayed response. Reply-To: considered harmful.

[root@ps3 ~]# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:13:A9:79:09:C3 ACL MTU: 384:8 SCO MTU: 64:8
        Build 3608
        Chip version: Unknown
        Max key size: 128 bit
        SCO mapping:  HCI
[root@ps3 ~]# bccmd builddef
Build definitions:
0x0009 - TRANSPORT_BCSP
0x000a - TRANSPORT_H4
0x000b - TRANSPORT_USB
0x000d - MAX_CRYPT_KEY_LEN_128
0x0012 - REQUIRE_8MBIT
0x0013 - RADIOTEST
0x0015 - INSTALL_FLASH
0x0016 - INSTALL_EEPROM
0x0017 - INSTALL_COMBO_DOT11
0x001d - CHIP_BASE_BC3
0x0020 - INSTALL_HCI_MODULE
0x002a - BT_VER_1_2
0x0031 - CHIP_BASE_BC4
[root@ps3 ~]# bccmd buildname
Build name: sly_8hci_fl_bt2.0_tachikoma-rc29_encr128_tachikoma
2006-10-16

-- 
dwmw2


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
