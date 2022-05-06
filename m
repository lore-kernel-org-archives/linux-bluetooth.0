Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCEAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 May 2022 01:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387813AbiEFBR7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 May 2022 21:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237763AbiEFBR4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 May 2022 21:17:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D640C6129F
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 May 2022 18:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651799654; x=1683335654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WFCBimkcBYP+hIPMbP4+JtYDeZqFKssgFgElwgDbHIg=;
  b=LCnbFiSRCwArBWMwPRH51nxQ8AMudW0C4Ujgj7y48Ide59r6sCfb+4yH
   YZNVQ2DuKmRttIKjVIVHthHOYn1jl1vnrNKMpjSMX6YoaKSFiGwXF6Q+6
   gOF4V5AvOtUhtLDbL9MUXb99Xnzk6/vfVsL3EHqGYvLdj8lNNmp2ljaEc
   zkyTBly6OJ+vyfMf28OHIp0b7hqqF6W6/nmQe3tLlbV8qpGiA67hU2OOe
   1tbFkZLadbUFaYa8tE8di7BQb8JOjQKJRscyrex31wdJ9DocF9re3vg8S
   uT4h4eNBsE2JF2/QdVqrJAMsfKAKVEQqzkZ9lBDUw3Lssd5LNBRXV/+WR
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="354744135"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="354744135"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 18:14:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="621574292"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 05 May 2022 18:14:13 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmmXs-000CvV-MQ;
        Fri, 06 May 2022 01:14:12 +0000
Date:   Fri, 6 May 2022 09:13:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH 4/8] Bluetooth: Add BTPROTO_ISO socket type
Message-ID: <202205060800.a0ZUbInN-lkp@intel.com>
References: <20220505230550.3450617-4-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505230550.3450617-4-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

I love your patch! Perhaps something to improve:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on bluetooth/master v5.18-rc5 next-20220505]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Luiz-Augusto-von-Dentz/Bluetooth-eir-Add-helpers-for-managing-service-data/20220506-070828
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
config: hexagon-randconfig-r025-20220505 (https://download.01.org/0day-ci/archive/20220506/202205060800.a0ZUbInN-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e004fb787698440a387750db7f8028e7cb14cfc)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9ab3ba7464f8b680ac64a72e2a75f663c922bcef
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Luiz-Augusto-von-Dentz/Bluetooth-eir-Add-helpers-for-managing-service-data/20220506-070828
        git checkout 9ab3ba7464f8b680ac64a72e2a75f663c922bcef
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash net/bluetooth/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/bluetooth/mgmt.c:4432:6: warning: variable 'changed' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (!err)
               ^~~~
   net/bluetooth/mgmt.c:4444:6: note: uninitialized use occurs here
           if (changed)
               ^~~~~~~
   net/bluetooth/mgmt.c:4432:2: note: remove the 'if' if its condition is always true
           if (!err)
           ^~~~~~~~~
   net/bluetooth/mgmt.c:4405:19: note: initialize the variable 'changed' to silence this warning
           bool val, changed;
                            ^
                             = 0
   1 warning generated.
--
>> net/bluetooth/iso.c:777:11: warning: variable 'sent' set but not used [-Wunused-but-set-variable]
           int err, sent = 0;
                    ^
   1 warning generated.


vim +4432 net/bluetooth/mgmt.c

  4398	
  4399	#ifdef CONFIG_BT_LE
  4400	static int set_iso_socket_func(struct sock *sk, struct hci_dev *hdev,
  4401				       struct mgmt_cp_set_exp_feature *cp, u16 data_len)
  4402	{
  4403		struct mgmt_rp_set_exp_feature rp;
  4404	
  4405		bool val, changed;
  4406		int err;
  4407	
  4408		/* Command requires to use the non-controller index */
  4409		if (hdev)
  4410			return mgmt_cmd_status(sk, hdev->id,
  4411					       MGMT_OP_SET_EXP_FEATURE,
  4412					       MGMT_STATUS_INVALID_INDEX);
  4413	
  4414		/* Parameters are limited to a single octet */
  4415		if (data_len != MGMT_SET_EXP_FEATURE_SIZE + 1)
  4416			return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
  4417					       MGMT_OP_SET_EXP_FEATURE,
  4418					       MGMT_STATUS_INVALID_PARAMS);
  4419	
  4420		/* Only boolean on/off is supported */
  4421		if (cp->param[0] != 0x00 && cp->param[0] != 0x01)
  4422			return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
  4423					       MGMT_OP_SET_EXP_FEATURE,
  4424					       MGMT_STATUS_INVALID_PARAMS);
  4425	
  4426		val = cp->param[0] ? true : false;
  4427		if (val)
  4428			err = iso_init();
  4429		else
  4430			err = iso_exit();
  4431	
> 4432		if (!err)
  4433			changed = true;
  4434	
  4435		memcpy(rp.uuid, iso_socket_uuid, 16);
  4436		rp.flags = cpu_to_le32(val ? BIT(0) : 0);
  4437	
  4438		hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
  4439	
  4440		err = mgmt_cmd_complete(sk, MGMT_INDEX_NONE,
  4441					MGMT_OP_SET_EXP_FEATURE, 0,
  4442					&rp, sizeof(rp));
  4443	
  4444		if (changed)
  4445			exp_feature_changed(hdev, iso_socket_uuid, val, sk);
  4446	
  4447		return err;
  4448	}
  4449	#endif
  4450	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
