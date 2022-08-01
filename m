Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAC9C00144
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Aug 2022 22:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbiHAWVz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Aug 2022 18:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbiHAWVz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Aug 2022 18:21:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AECA2B27D
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 15:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659392514; x=1690928514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UfH+DHt+SfDqvYzGWovR90BoEQp1JLN1BxEU+dw/zT4=;
  b=jzJ9wvtcoYy18M/ywdmEkejj3R/aQqIo7kb+OQ9L5340m3tVkBPhRWNS
   noJYfLp9fkkEsqeGrsjzeljMMnTZicSLFx5oZsT2+yB9OI/PTrpACXo8I
   VTBoNi8Wu/cH50O5O+x5N8BZJI9PMUeD11gtBQbLllA8G8AMI4IwhyJdI
   y9Yc16mdv8G7jHt65pz/6HwBJRpCs1sQHPhFRBz+ACFiTR12xpzODp44v
   8/LZ+ez5RVxcr13O1B2FKVPMXOTezBQkrWAdz8XDreykDnIsTb6z7Gucg
   EBtDTNY4E8MBSeFIDgN3Hku2/qgRJP539m8D5sDyk/RTWbHfYd5UEfV4V
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="289276560"
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="289276560"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 15:21:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="635066192"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 01 Aug 2022 15:21:52 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIdnL-000FQo-2U;
        Mon, 01 Aug 2022 22:21:51 +0000
Date:   Tue, 2 Aug 2022 06:21:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix l2cap_global_chan_by_psm regression
Message-ID: <202208020648.fs6gb987-lkp@intel.com>
References: <20220801210609.2183766-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801210609.2183766-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

I love your patch! Perhaps something to improve:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on bluetooth/master linus/master v5.19 next-20220728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luiz-Augusto-von-Dentz/Bluetooth-L2CAP-Fix-l2cap_global_chan_by_psm-regression/20220802-050647
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
config: parisc-randconfig-r024-20220801 (https://download.01.org/0day-ci/archive/20220802/202208020648.fs6gb987-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/075988314335917c0e43d00f6a3a8ef68963b3de
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Luiz-Augusto-von-Dentz/Bluetooth-L2CAP-Fix-l2cap_global_chan_by_psm-regression/20220802-050647
        git checkout 075988314335917c0e43d00f6a3a8ef68963b3de
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash net/bluetooth/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from net/bluetooth/l2cap_core.c:37:
   In function 'bacmp',
       inlined from 'l2cap_global_chan_by_psm' at net/bluetooth/l2cap_core.c:2003:15:
>> include/net/bluetooth/bluetooth.h:347:16: warning: 'memcmp' specified bound 6 exceeds source size 0 [-Wstringop-overread]
     347 |         return memcmp(ba1, ba2, sizeof(bdaddr_t));
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/memcmp +347 include/net/bluetooth/bluetooth.h

^1da177e4c3f41 Linus Torvalds 2005-04-16  343  
^1da177e4c3f41 Linus Torvalds 2005-04-16  344  /* Copy, swap, convert BD Address */
f53c20e93612f7 David Herrmann 2013-04-06  345  static inline int bacmp(const bdaddr_t *ba1, const bdaddr_t *ba2)
^1da177e4c3f41 Linus Torvalds 2005-04-16  346  {
^1da177e4c3f41 Linus Torvalds 2005-04-16 @347  	return memcmp(ba1, ba2, sizeof(bdaddr_t));
^1da177e4c3f41 Linus Torvalds 2005-04-16  348  }
f53c20e93612f7 David Herrmann 2013-04-06  349  static inline void bacpy(bdaddr_t *dst, const bdaddr_t *src)
^1da177e4c3f41 Linus Torvalds 2005-04-16  350  {
^1da177e4c3f41 Linus Torvalds 2005-04-16  351  	memcpy(dst, src, sizeof(bdaddr_t));
^1da177e4c3f41 Linus Torvalds 2005-04-16  352  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  353  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
