Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Sep 2012 08:06:57 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Jaroslav Resler <resler@cs.cas.cz>
Cc: kernel-janitors@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
	"Cho, Yu-Chen" <acho@suse.com>, linux-bluetooth@vger.kernel.org
Subject: [bluetooth:master 22/22] drivers/bluetooth/btusb.c:97:2: error:
 expected '}' before '{' token
Message-ID: <20120919000657.GA9208@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaroslav,

FYI, kernel build failed on

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   493969cf4728668412ecd428a60b39914d9831e3
commit: 493969cf4728668412ecd428a60b39914d9831e3 [22/22] Bluetooth: Add support for BCM20702A0 [04ca, 2003]
config: x86_64-allmodconfig

All related error/warning messages:

drivers/bluetooth/btusb.c:97:2: error: expected '}' before '{' token

vim +97 drivers/bluetooth/btusb.c
    92		/* Canyon CN-BTU1 with HID interfaces */
    93		{ USB_DEVICE(0x0c10, 0x0000) },
    94	
    95		/* Broadcom BCM20702A0 */
    96		{ USB_DEVICE(0x04ca, 0x2003) }
  > 97		{ USB_DEVICE(0x0489, 0xe042) },
    98		{ USB_DEVICE(0x0a5c, 0x21e3) },
    99		{ USB_DEVICE(0x0a5c, 0x21e6) },
   100		{ USB_DEVICE(0x0a5c, 0x21e8) },
   101		{ USB_DEVICE(0x0a5c, 0x21f3) },
   102		{ USB_DEVICE(0x413c, 0x8197) },

---
0-DAY kernel build testing backend         Open Source Technology Centre
Fengguang Wu, Yuanhan Liu                              Intel Corporation
