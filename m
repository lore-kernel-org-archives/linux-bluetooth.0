Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55A7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Mar 2022 23:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241278AbiCNXD0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Mar 2022 19:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238795AbiCNXDY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Mar 2022 19:03:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61586340F3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 16:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647298934; x=1678834934;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nmb0PTFiFQ7no7UFdrIRoEcjtdkrXl8xYXmyB55GnGw=;
  b=CYfd1QcajJUfbUqbd7sRqikBGPF+l1KXqMBXYmjV3cyKkk2bNBMQIyTI
   dbrXvHoo8d82aHQH2k229up9fBYXUM6KCMSaOJkvbvTUQ6toWB5HYvyE0
   n/m/cttTanHSUTAP+9talgLKZ7YfdKALsx8rGynrYtQPp+qradkjzex7E
   1f49/yRQeMjbgobc4oc8dS6B0JQSrw//2FQDEKhA36rgjWIWLkGaW1AXa
   SU9W04umrC7YqCBEofmLot2zwWIF3zr8Q2MEvc6GZv+2hrhCA5E4i2yzZ
   hEvv16yb9F8pNAQfhKNE9LMfoz0XBKI+fDoJ9ljU6KEUs6B0vS4jmwrgk
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256115580"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="256115580"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 16:02:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="497802662"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 14 Mar 2022 16:02:13 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTthc-000AJd-Ao; Mon, 14 Mar 2022 23:02:12 +0000
Date:   Tue, 15 Mar 2022 07:01:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     kbuild-all@lists.01.org, linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master 111/128]
 drivers/net/ethernet/mscc/ocelot.c:2920:14: error: 'IEEE_8021QAZ_MAX_TCS'
 undeclared
Message-ID: <202203150608.Rb0JPSVD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   f564af34bb7d58f4e0776b64168f565f17ee8597
commit: 978777d0fb06663523281aa50a5040c3aa31fbe7 [111/128] net: dsa: felix: configure default-prio and dscp priorities
config: i386-randconfig-a001-20220314 (https://download.01.org/0day-ci/archive/20220315/202203150608.Rb0JPSVD-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=978777d0fb06663523281aa50a5040c3aa31fbe7
        git remote add bluetooth-next https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
        git fetch --no-tags bluetooth-next master
        git checkout 978777d0fb06663523281aa50a5040c3aa31fbe7
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/ethernet/mscc/ocelot.c: In function 'ocelot_port_set_default_prio':
>> drivers/net/ethernet/mscc/ocelot.c:2920:14: error: 'IEEE_8021QAZ_MAX_TCS' undeclared (first use in this function)
    2920 |  if (prio >= IEEE_8021QAZ_MAX_TCS)
         |              ^~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mscc/ocelot.c:2920:14: note: each undeclared identifier is reported only once for each function it appears in
   drivers/net/ethernet/mscc/ocelot.c: In function 'ocelot_port_add_dscp_prio':
   drivers/net/ethernet/mscc/ocelot.c:2962:14: error: 'IEEE_8021QAZ_MAX_TCS' undeclared (first use in this function)
    2962 |  if (prio >= IEEE_8021QAZ_MAX_TCS)
         |              ^~~~~~~~~~~~~~~~~~~~


vim +/IEEE_8021QAZ_MAX_TCS +2920 drivers/net/ethernet/mscc/ocelot.c

  2917	
  2918	int ocelot_port_set_default_prio(struct ocelot *ocelot, int port, u8 prio)
  2919	{
> 2920		if (prio >= IEEE_8021QAZ_MAX_TCS)
  2921			return -ERANGE;
  2922	
  2923		ocelot_rmw_gix(ocelot,
  2924			       ANA_PORT_QOS_CFG_QOS_DEFAULT_VAL(prio),
  2925			       ANA_PORT_QOS_CFG_QOS_DEFAULT_VAL_M,
  2926			       ANA_PORT_QOS_CFG,
  2927			       port);
  2928	
  2929		return 0;
  2930	}
  2931	EXPORT_SYMBOL_GPL(ocelot_port_set_default_prio);
  2932	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
