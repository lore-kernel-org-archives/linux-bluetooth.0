Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 13 Aug 2018 08:35:06 +0800
From: kbuild test robot <lkp@intel.com>
To: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH v1 1/2] Bluetooth: mediatek: Add protocol support for
 MediaTek MT7668U USB devices
Message-ID: <201808130807.Y9VO6O2r%fengguang.wu@intel.com>
References: <d976d455588eb0e3007cee1c3447e0455a06573e.1534062988.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d976d455588eb0e3007cee1c3447e0455a06573e.1534062988.git.sean.wang@mediatek.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sean,

I love your patch! Perhaps something to improve:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on v4.18 next-20180810]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/linux-kernel-owner-vger-kernel-org/Bluetooth-mediatek-Add-protocol-support-for-MediaTek-MT7668U-USB-devices/20180813-043802
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master


coccinelle warnings: (new ones prefixed by >>)

>> drivers/bluetooth/btmtk.c:86:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
