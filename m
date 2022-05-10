Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B14C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 May 2022 07:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237473AbiEJH5d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 May 2022 03:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237498AbiEJH5R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 May 2022 03:57:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B931F2438C8
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 May 2022 00:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652169198; x=1683705198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mq8uA6DkD8ojbYoNG53FPFmYjZTYEZhmbF0+6OF9Mjw=;
  b=b7wQp4j/j+sGDFDt0JrmVsVOb4n3ivqF3sSlrIL/AEl8n/4gJKolijSB
   WefBJI+8WvZGWh5Pqb2kYHbEcTj3nr89CYM5bSL1V8NQdH2ZNU/Lf8g6d
   nAQd9tUg7Fd+VB3hRlsb/+Rlo+dunFXDgYeQDBQx+WvftEFHMZTmE0cLG
   2QP1eiiB2ncKz0t/3fbpjKO8QV2I2S2SeT/xulTReVDd+lCMwI2h3iBLS
   l1iCq+T2ugXhja3iK9jnhgE58UN5Cu7CnUayPstFkQFOL5X29TUgQtzaw
   oh/LvL/PjlV8NGCZMQFF3k25Yo0UlTb0bXDemJVeoLTyoka6K+CC9ZTlM
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="256835928"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="256835928"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 00:53:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="519630000"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 10 May 2022 00:53:16 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noKgG-000HW2-5h;
        Tue, 10 May 2022 07:53:16 +0000
Date:   Tue, 10 May 2022 15:52:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brian Gix <brian.gix@intel.com>, linux-bluetooth@vger.kernel.org
Cc:     kbuild-all@lists.01.org, marcel@holtmann.org, luiz.dentz@gmail.com,
        brian.gix@intel.com
Subject: Re: [PATCH v2 2/2] Bluetooth: Add experimental wrapper for MGMT
 based mesh
Message-ID: <202205101530.WHKiKnKN-lkp@intel.com>
References: <20220509220512.482695-3-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509220512.482695-3-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on bluetooth-next/master v5.18-rc6 next-20220509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Brian-Gix/Add-Mesh-functionality-to-net-bluetooth/20220510-060608
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
config: arc-randconfig-s031-20220509 (https://download.01.org/0day-ci/archive/20220510/202205101530.WHKiKnKN-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/885a42ec302cf25607003d07fec0f13cbeb61d35
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Brian-Gix/Add-Mesh-functionality-to-net-bluetooth/20220510-060608
        git checkout 885a42ec302cf25607003d07fec0f13cbeb61d35
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash net/bluetooth/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> net/bluetooth/mgmt.c:2145:71: sparse: sparse: Using plain integer as NULL pointer
   net/bluetooth/mgmt.c:4107:29: sparse: sparse: restricted __le16 degrades to integer
   net/bluetooth/mgmt.c:4933:9: sparse: sparse: cast to restricted __le32
   net/bluetooth/mgmt.c:10213:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le64 [usertype] instant @@     got unsigned int [usertype] instant @@
   net/bluetooth/mgmt.c:10213:21: sparse:     expected restricted __le64 [usertype] instant
   net/bluetooth/mgmt.c:10213:21: sparse:     got unsigned int [usertype] instant

vim +2145 net/bluetooth/mgmt.c

  2131	
  2132	static void set_mesh_complete(struct hci_dev *hdev, void *data, int err)
  2133	{
  2134		struct mgmt_pending_cmd *cmd = data;
  2135		u8 status = mgmt_status(err);
  2136		struct sock *sk = cmd->sk;
  2137	
  2138		if (status) {
  2139			mgmt_pending_foreach(MGMT_OP_SET_MESH_RECEIVER, hdev,
  2140							cmd_status_rsp, &status);
  2141			return;
  2142		}
  2143	
  2144		mgmt_pending_remove(cmd);
> 2145		mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER, 0, 0, 0);
  2146	}
  2147	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
