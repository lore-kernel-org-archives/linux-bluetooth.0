Return-Path: <fengguang.wu@intel.com>
Date: Tue, 3 Apr 2018 20:13:03 +0800
From: kbuild test robot <lkp@intel.com>
To: sean.wang@mediatek.com
Cc: kbuild-all@01.org, robh+dt@kernel.org, mark.rutland@arm.com,
	marcel@holtmann.org, johan.hedberg@gmail.com,
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH v1 6/7] Bluetooth: hci_mediatek: Add protocol support for
 MediaTek serial devices
Message-ID: <201804032020.XSC8Oqit%fengguang.wu@intel.com>
References: <f0e0a0b7f1dc3845dc6eafb4ccd60284d1675f8d.1522736996.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f0e0a0b7f1dc3845dc6eafb4ccd60284d1675f8d.1522736996.git.sean.wang@mediatek.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sean,

I love your patch! Perhaps something to improve:

[auto build test WARNING on next-20180329]
[also build test WARNING on v4.16]
[cannot apply to linus/master bluetooth/master bluetooth-next/master v4.16 v4.16-rc7 v4.16-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/sean-wang-mediatek-com/add-support-for-Bluetooth-on-MT7622-SoC/20180403-160035
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/bluetooth/hci_mediatek.c:322:5: sparse: symbol 'mtk_recv_frame' was not declared. Should it be static?
>> drivers/bluetooth/hci_mediatek.c:415:57: sparse: Using plain integer as NULL pointer

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
