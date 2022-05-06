Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AFFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 May 2022 01:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241640AbiEFBr6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 May 2022 21:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbiEFBr6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 May 2022 21:47:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90F554F8E
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 May 2022 18:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651801456; x=1683337456;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7XM+AeEbGcWLiVa8zNZNnX2naOFV4ZUCs5WP9XbyHc4=;
  b=CN8dV1zE8kVFzqlnUQ4AIBWQCk4rLTIZ7bCSTGYi1r/K6vPhcYELUKy5
   2ABzDpQ9V0Pc2y2K/M/HeeYY5we3JWbkSDHa4KZ71mwt1cKaGQgBOC/vm
   Ig4Qr6zfz0T3jFo6yx6t5cOZwlk/smdkTcdWbdQ03kenYZi/g1wnq2lyW
   klDndX75V98E9EOo6/EGFEMWU5DJaUt5/Sfkgwn67Uaww9+VyIOtG+YnE
   C404pmKHcnWXE5/K6msDWaWYLlPNCXxszAk3Inu386hfyPniN36v8hBYi
   25LWxwET1LyHK7fWc3Xd73wM36yGxmzDNs+wEhmeSyAWEkuKqYWe6Qg7X
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="265906730"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="265906730"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 18:44:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="537645627"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 May 2022 18:44:15 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmn0w-000Cwu-Jt;
        Fri, 06 May 2022 01:44:14 +0000
Date:   Fri, 6 May 2022 09:44:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH 3/8] Bluetooth: Add initial implementation of CIS
 connections
Message-ID: <202205060934.yZqT8q6k-lkp@intel.com>
References: <20220505230550.3450617-3-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505230550.3450617-3-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

I love your patch! Perhaps something to improve:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on v5.18-rc5 next-20220505]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Luiz-Augusto-von-Dentz/Bluetooth-eir-Add-helpers-for-managing-service-data/20220506-070828
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
config: sparc-randconfig-s032-20220505 (https://download.01.org/0day-ci/archive/20220506/202205060934.yZqT8q6k-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/aec184428c78dfd0b7d66190234e7fb4b92c9330
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Luiz-Augusto-von-Dentz/Bluetooth-eir-Add-helpers-for-managing-service-data/20220506-070828
        git checkout aec184428c78dfd0b7d66190234e7fb4b92c9330
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc SHELL=/bin/bash net/bluetooth/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> net/bluetooth/hci_conn.c:1250:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] c_sdu @@     got unsigned short [usertype] sdu @@
   net/bluetooth/hci_conn.c:1250:21: sparse:     expected restricted __le16 [usertype] c_sdu
   net/bluetooth/hci_conn.c:1250:21: sparse:     got unsigned short [usertype] sdu
>> net/bluetooth/hci_conn.c:1251:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] p_sdu @@     got unsigned short [usertype] sdu @@
   net/bluetooth/hci_conn.c:1251:21: sparse:     expected restricted __le16 [usertype] p_sdu
   net/bluetooth/hci_conn.c:1251:21: sparse:     got unsigned short [usertype] sdu
--
   net/bluetooth/hci_event.c:337:15: sparse: sparse: restricted __le16 degrades to integer
>> net/bluetooth/hci_event.c:3788:26: sparse: sparse: cast to restricted __le16
>> net/bluetooth/hci_event.c:3788:26: sparse: sparse: cast to restricted __le16
>> net/bluetooth/hci_event.c:3788:26: sparse: sparse: cast to restricted __le16
>> net/bluetooth/hci_event.c:3788:26: sparse: sparse: cast to restricted __le16
   net/bluetooth/hci_event.c:3790:26: sparse: sparse: cast to restricted __le16
   net/bluetooth/hci_event.c:3790:26: sparse: sparse: cast to restricted __le16
   net/bluetooth/hci_event.c:3790:26: sparse: sparse: cast to restricted __le16
   net/bluetooth/hci_event.c:3790:26: sparse: sparse: cast to restricted __le16
   net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
   include/net/bluetooth/hci.h:2518:47: sparse: sparse: array of flexible structures
   include/net/bluetooth/hci.h:2604:43: sparse: sparse: array of flexible structures
>> net/bluetooth/hci_event.c:6685:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] sdu @@     got restricted __le16 [usertype] c_mtu @@
   net/bluetooth/hci_event.c:6685:38: sparse:     expected unsigned short [usertype] sdu
   net/bluetooth/hci_event.c:6685:38: sparse:     got restricted __le16 [usertype] c_mtu
>> net/bluetooth/hci_event.c:6686:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] sdu @@     got restricted __le16 [usertype] p_mtu @@
   net/bluetooth/hci_event.c:6686:39: sparse:     expected unsigned short [usertype] sdu
   net/bluetooth/hci_event.c:6686:39: sparse:     got restricted __le16 [usertype] p_mtu

vim +1250 net/bluetooth/hci_conn.c

  1244	
  1245	static void cis_add(struct iso_list_data *d, struct bt_iso_qos *qos)
  1246	{
  1247		struct hci_cis_params *cis = &d->pdu.cis[d->pdu.cp.num_cis];
  1248	
  1249		cis->cis_id = qos->cis;
> 1250		cis->c_sdu  = qos->out.sdu;
> 1251		cis->p_sdu  = qos->in.sdu;
  1252		cis->c_phy  = qos->out.phy;
  1253		cis->p_phy  = qos->in.phy;
  1254		cis->c_rtn  = qos->out.rtn;
  1255		cis->p_rtn  = qos->in.rtn;
  1256	
  1257		d->pdu.cp.num_cis++;
  1258	}
  1259	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
