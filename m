Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 22 Aug 2018 00:55:29 +0800
From: kbuild test robot <lkp@intel.com>
To: Raghuram Hegde <raghuram.hegde@intel.com>
Cc: kbuild-all@01.org, linux-bluetooth@vger.kernel.org,
        raghuram.hegde@intel.com, chethan.tumkur.narayan@intel.com,
        sukumar.ghorai@intel.com, amit.k.bag@intel.com
Subject: Re: [PATCH 1/2] Bluetooth: btintel: Add platform device for rfkill
 signal
Message-ID: <201808220036.6FX5Scvn%fengguang.wu@intel.com>
References: <1534844080-31240-1-git-send-email-raghuram.hegde@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1534844080-31240-1-git-send-email-raghuram.hegde@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sukumar,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on v4.18 next-20180821]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Raghuram-Hegde/Bluetooth-btintel-Add-platform-device-for-rfkill-signal/20180821-195829
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master


coccinelle warnings: (new ones prefixed by >>)

>> drivers/bluetooth/btintel.c:416:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
