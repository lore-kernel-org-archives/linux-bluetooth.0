Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB32C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Jan 2022 07:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbiAVHcy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 22 Jan 2022 02:32:54 -0500
Received: from mga05.intel.com ([192.55.52.43]:1403 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231319AbiAVHcx (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 22 Jan 2022 02:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642836773; x=1674372773;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cizgc7EJPYJc6NpUftyLET1tlqZwYXAx2pO2qAvaYE0=;
  b=dRVmgMK5tjRGOkcowHldBW65fIKi6mwNXyFbqUOAwhElYSv9ythR62Es
   rJeA9IB9OhyGhacA8guzMs/7Izxrxi4mVxHJ+QGxcijUxXJVi0DTr2iV9
   w4sz5wLQyL75N8vfC3NVTVjWdT7rONRSvsOMTBbGkuevDAxIgTGqdfCee
   9pqoo/Bjf+wjm3wliRqhmRjwKmdSPVgBPdBFaGYbXuZfNgEmD7rAW+5+C
   NZdJNHlXPF1xXmH63KnvSmELZO9BrxiDjF/gpjpWyndqaavWQXvwGG73R
   a3YE1oFMpw1vtLkvOCf5WVlnanaDqP7IrCacoxyRwXA3yUAKHKGC1NRq8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="332153096"
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="332153096"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 23:31:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="694880236"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 21 Jan 2022 23:31:25 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBArs-000GAL-KW; Sat, 22 Jan 2022 07:31:24 +0000
Date:   Sat, 22 Jan 2022 15:31:06 +0800
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
Message-ID: <202201221555.iq4k2aDR-lkp@intel.com>
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

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bluetooth-next/master]
[also build test ERROR on next-20220121]
[cannot apply to net-next/master net/master bluetooth/master v5.16]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Joseph-Hwang/Bluetooth-aosp-surface-AOSP-quality-report-through-mgmt/20220121-192436
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20220122/202201221555.iq4k2aDR-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/9484eb7f87f7c8759b6fd7eec9d431c375b97432
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Joseph-Hwang/Bluetooth-aosp-surface-AOSP-quality-report-through-mgmt/20220121-192436
        git checkout 9484eb7f87f7c8759b6fd7eec9d431c375b97432
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/bluetooth/hci_ldisc.c:34:
>> drivers/bluetooth/btintel.h:317:1: error: expected identifier or '(' before '{' token
     317 | {
         | ^
   drivers/bluetooth/btintel.h:316:20: warning: 'btintel_pull_quality_report_data' declared 'static' but never defined [-Wunused-function]
     316 | static inline bool btintel_pull_quality_report_data(struct sk_buff *skb);
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +317 drivers/bluetooth/btintel.h

   315	
   316	static inline bool btintel_pull_quality_report_data(struct sk_buff *skb);
 > 317	{

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
