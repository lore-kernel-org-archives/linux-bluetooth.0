Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768D5CD37B1
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 Sep 2023 02:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbjIPCF1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Sep 2023 22:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238274AbjIPCFF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Sep 2023 22:05:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328F5173C
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Sep 2023 19:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694829900; x=1726365900;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GTZhQfbu7FWSbVurXZ1LVhxXDcF5x6wqalSswIAmFhI=;
  b=JiHz1Z7IAamd3lLMdomhHGWUPCqc43v8ITiA4WnN5H5NXkrkRjUYvcnE
   fSZS2fo+GW5G8eQqRVfeg9YHlMbJU4A8o3sKEr1jpOv43JHrfOry6Y6qz
   AAe0gT/Typru9SIw/URfyoTeuhUerxjuq5skw4Smon12x2K9yg7k+Fn84
   0yrMJR7Kb/081Vt6ldMaRUo/wHIe1ab2xUki62fZpCVFSkCTnoCd3EMsG
   TANIdDfxTaqeM3r0yBJwnwCJUCFWYv7c5JFgZsUB/1WeCP8bwWn6IZ8QY
   lgCEIV4UjD0W8Rpn3dsv/Q5YJ1gyg6Sy973jeuzRntjlq5Dv33FNzzGj4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="369697643"
X-IronPort-AV: E=Sophos;i="6.02,150,1688454000"; 
   d="scan'208";a="369697643"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 19:04:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="888412525"
X-IronPort-AV: E=Sophos;i="6.02,150,1688454000"; 
   d="scan'208";a="888412525"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 15 Sep 2023 19:04:21 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qhKg3-0003jB-1t;
        Sat, 16 Sep 2023 02:04:55 +0000
Date:   Sat, 16 Sep 2023 10:04:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 1/2] Bluetooth: hci_core: Fix build warnings
Message-ID: <202309160927.DmionDGV-lkp@intel.com>
References: <20230915234742.3739283-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915234742.3739283-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.6-rc1 next-20230915]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luiz-Augusto-von-Dentz/Bluetooth-hci_codec-Fix-leaking-content-of-local_codecs/20230916-075018
base:   linus/master
patch link:    https://lore.kernel.org/r/20230915234742.3739283-1-luiz.dentz%40gmail.com
patch subject: [PATCH v3 1/2] Bluetooth: hci_core: Fix build warnings
config: parisc-randconfig-002-20230916 (https://download.01.org/0day-ci/archive/20230916/202309160927.DmionDGV-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230916/202309160927.DmionDGV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309160927.DmionDGV-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/bluetooth/hci_event.c: In function 'hci_cc_read_class_of_dev':
>> net/bluetooth/hci_event.c:521:9: warning: 'memcpy' writing 3 bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
     521 |         memcpy(hdev->dev_class, rp->dev_class, 3);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: note: destination object is likely at address zero


vim +/memcpy +521 net/bluetooth/hci_event.c

e5b0ad69c97a04f Abhishek Pandit-Subedi 2021-03-03  510  
c8992cffbe7411c Luiz Augusto von Dentz 2021-12-01  511  static u8 hci_cc_read_class_of_dev(struct hci_dev *hdev, void *data,
c8992cffbe7411c Luiz Augusto von Dentz 2021-12-01  512  				   struct sk_buff *skb)
a9de9248064bfc8 Marcel Holtmann        2007-10-20  513  {
c8992cffbe7411c Luiz Augusto von Dentz 2021-12-01  514  	struct hci_rp_read_class_of_dev *rp = data;
e3f3a1aea8719ac Luiz Augusto von Dentz 2021-12-01  515  
e3f3a1aea8719ac Luiz Augusto von Dentz 2021-12-01  516  	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
a9de9248064bfc8 Marcel Holtmann        2007-10-20  517  
a9de9248064bfc8 Marcel Holtmann        2007-10-20  518  	if (rp->status)
c8992cffbe7411c Luiz Augusto von Dentz 2021-12-01  519  		return rp->status;
a9de9248064bfc8 Marcel Holtmann        2007-10-20  520  
a9de9248064bfc8 Marcel Holtmann        2007-10-20 @521  	memcpy(hdev->dev_class, rp->dev_class, 3);
a9de9248064bfc8 Marcel Holtmann        2007-10-20  522  
e3f3a1aea8719ac Luiz Augusto von Dentz 2021-12-01  523  	bt_dev_dbg(hdev, "class 0x%.2x%.2x%.2x", hdev->dev_class[2],
e3f3a1aea8719ac Luiz Augusto von Dentz 2021-12-01  524  		   hdev->dev_class[1], hdev->dev_class[0]);
c8992cffbe7411c Luiz Augusto von Dentz 2021-12-01  525  
c8992cffbe7411c Luiz Augusto von Dentz 2021-12-01  526  	return rp->status;
a9de9248064bfc8 Marcel Holtmann        2007-10-20  527  }
a9de9248064bfc8 Marcel Holtmann        2007-10-20  528  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
