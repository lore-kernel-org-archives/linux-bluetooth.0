Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Sat, 14 Apr 2018 00:28:54 +0800
From: kbuild test robot <lkp@intel.com>
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Cc: kbuild-all@01.org, linux-bluetooth@vger.kernel.org,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: Re: [PATCH v1 15/18] Bluetooth: Implement disable and removal of adv
 instance
Message-ID: <201804132202.mLXQJclE%fengguang.wu@intel.com>
References: <1523531987-17140-16-git-send-email-jaganathx.kanakkassery@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1523531987-17140-16-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on v4.16 next-20180413]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jaganath-Kanakkassery/Extended-Adv-Scan-Connection-and-PHY-support/20180413-201735
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> net/bluetooth/hci_request.c:1446:6: sparse: symbol '__hci_req_remove_ext_adv_set' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
