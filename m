Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2352C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jan 2022 18:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382141AbiAUSbl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Jan 2022 13:31:41 -0500
Received: from mga06.intel.com ([134.134.136.31]:45742 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1382048AbiAUSbQ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Jan 2022 13:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642789876; x=1674325876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zFD3urVjPXljiBgWCnV5ct4lnC2I/1e0hvWj60qyZYQ=;
  b=Yy94EeYOagvi7rn/cWU15H1cWZS53YoBj3Ht/yCdbD1KsAK1Rpq+yUPC
   bSUK2ZoLfJ+Ar+swKaF6GGYd+hOoWMkzIIDgY8cAJ7yX5Dyk99aRFOcSd
   CafWNg5YD0QPJLjj+fTWOd2AvT1gKg6bQzpK39SwrxwypvzJbz2JQOPyo
   9aJBQlpiHs5Ke2VKRRps5Y+/uZXw+i4JwqQLHg2I/1oQPQEfpkLt/1wn6
   ps2VgTlyBMLZObZuC9XK6qo5iozuf4QTMbvXqB0aVysUxM0dQXHiFq+Jd
   0yB6wZP8l4oKF+mFDJX5jh6pTUfskXPdJGWuztVTOc1Jr/+0Vz//fSR+G
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="306437294"
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="306437294"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 10:31:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="476036054"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Jan 2022 10:31:00 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nAyge-000FZ0-1B; Fri, 21 Jan 2022 18:31:00 +0000
Date:   Sat, 22 Jan 2022 02:30:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joseph Hwang <josephsih@chromium.org>,
        linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     kbuild-all@lists.01.org,
        chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH v1 2/2] Bluetooth: btintel: surface Intel telemetry
 events through mgmt
Message-ID: <202201220238.tZ1BfUpc-lkp@intel.com>
References: <20220121192152.v1.2.I63681490281b2392aa1ac05dff91a126394ab649@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121192152.v1.2.I63681490281b2392aa1ac05dff91a126394ab649@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joseph,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on next-20220121]
[cannot apply to net-next/master net/master bluetooth/master v5.16]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Joseph-Hwang/Bluetooth-aosp-surface-AOSP-quality-report-through-mgmt/20220121-192436
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
config: ia64-randconfig-r035-20220121 (https://download.01.org/0day-ci/archive/20220122/202201220238.tZ1BfUpc-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/9484eb7f87f7c8759b6fd7eec9d431c375b97432
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Joseph-Hwang/Bluetooth-aosp-surface-AOSP-quality-report-through-mgmt/20220121-192436
        git checkout 9484eb7f87f7c8759b6fd7eec9d431c375b97432
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/bluetooth/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/ia64/include/asm/pgtable.h:153,
                    from include/linux/pgtable.h:6,
                    from arch/ia64/include/asm/uaccess.h:40,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/poll.h:10,
                    from include/net/bluetooth/bluetooth.h:28,
                    from drivers/bluetooth/btintel.c:14:
   arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
   arch/ia64/include/asm/mmu_context.h:127:48: warning: variable 'old_rr4' set but not used [-Wunused-but-set-variable]
     127 |         unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
         |                                                ^~~~~~~
   In file included from drivers/bluetooth/btintel.c:14:
   drivers/bluetooth/btintel.c: In function 'btintel_pull_quality_report_data':
>> drivers/bluetooth/btintel.c:2680:24: warning: format '%u' expects argument of type 'unsigned int', but argument 3 has type 'long unsigned int' [-Wformat=]
    2680 |                 BT_ERR("Telemetry event length %d too short (at least %u)",
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    2681 |                        skb->len, sizeof(struct intel_tlv));
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~
         |                                  |
         |                                  long unsigned int
   include/net/bluetooth/bluetooth.h:199:40: note: in definition of macro 'BT_ERR'
     199 | #define BT_ERR(fmt, ...)        bt_err(fmt "\n", ##__VA_ARGS__)
         |                                        ^~~
   drivers/bluetooth/btintel.c:2680:72: note: format string is defined here
    2680 |                 BT_ERR("Telemetry event length %d too short (at least %u)",
         |                                                                       ~^
         |                                                                        |
         |                                                                        unsigned int
         |                                                                       %lu


vim +2680 drivers/bluetooth/btintel.c

  2673	
  2674	bool btintel_pull_quality_report_data(struct sk_buff *skb)
  2675	{
  2676		skb_pull(skb, sizeof(struct intel_prefix_evt_data));
  2677	
  2678		/* A telemetry event contains at least one intel_tlv subevent. */
  2679		if (skb->len < sizeof(struct intel_tlv)) {
> 2680			BT_ERR("Telemetry event length %d too short (at least %u)",
  2681			       skb->len, sizeof(struct intel_tlv));
  2682			return false;
  2683		}
  2684	
  2685		return true;
  2686	}
  2687	EXPORT_SYMBOL_GPL(btintel_pull_quality_report_data);
  2688	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
