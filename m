Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB02BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 May 2022 02:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388079AbiEFCaC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 May 2022 22:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbiEFCaA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 May 2022 22:30:00 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A0224BFE
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 May 2022 19:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651803979; x=1683339979;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eryJz/9RtHuOB6CRWfiag+ngqeXaVhYaOUx7ooJ0ABs=;
  b=TKVlrCGDb1htGQNLtlKR3FvWnCcrBS+1JKrIiMVbIGVNonRYBZ+JiFpg
   Yzb2iy+VF623YatTVabrx1LJ/DFSXaB1X+sIb493KL/zE/wZFr73Ezuyp
   ki3pj9hGSceQ4k3TjOuYppouFgKzH1/kZb5JaW2KC7CxVhJTIygyK0NiQ
   ZDDdYCW3QA2BRhXDUmNzr6TlwrGj1tPryZWvpgTRyNLvAK+AeHfWMNBp3
   PjbxZ2bEtGtMYM0VWzMgECKCE75As3241QRtwm7dkXlq1HyvFj7sXcf7N
   4BFSGsbzBYbqylX2VrgZm1IXxC5ivg+5bjuImpflG8s7AVsn/JLyU4vxC
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="293528004"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="293528004"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 19:26:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="735325957"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 05 May 2022 19:26:17 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmnfd-000Czk-3Z;
        Fri, 06 May 2022 02:26:17 +0000
Date:   Fri, 6 May 2022 10:25:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH 6/8] Bluetooth: ISO: Add broadcast support
Message-ID: <202205061022.2EG8sVaE-lkp@intel.com>
References: <20220505230550.3450617-6-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505230550.3450617-6-luiz.dentz@gmail.com>
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
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220506/202205061022.2EG8sVaE-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/c9952abdb0e8adbeadc722ce26b2ee5a64244860
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Luiz-Augusto-von-Dentz/Bluetooth-eir-Add-helpers-for-managing-service-data/20220506-070828
        git checkout c9952abdb0e8adbeadc722ce26b2ee5a64244860
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash net/bluetooth/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   net/bluetooth/iso.c: In function 'iso_sock_getsockopt':
>> net/bluetooth/iso.c:1214:13: warning: variable 'base' set but not used [-Wunused-but-set-variable]
    1214 |         u8 *base;
         |             ^~~~


vim +/base +1214 net/bluetooth/iso.c

  1206	
  1207	static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
  1208				       char __user *optval, int __user *optlen)
  1209	{
  1210		struct sock *sk = sock->sk;
  1211		int len, err = 0;
  1212		struct bt_iso_qos qos;
  1213		u8 base_len;
> 1214		u8 *base;
  1215	
  1216		BT_DBG("sk %p", sk);
  1217	
  1218		if (get_user(len, optlen))
  1219			return -EFAULT;
  1220	
  1221		lock_sock(sk);
  1222	
  1223		switch (optname) {
  1224	
  1225		case BT_DEFER_SETUP:
  1226			if (sk->sk_state != BT_BOUND && sk->sk_state != BT_LISTEN) {
  1227				err = -EINVAL;
  1228				break;
  1229			}
  1230	
  1231			if (put_user(test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags),
  1232				     (u32 __user *)optval))
  1233				err = -EFAULT;
  1234	
  1235			break;
  1236	
  1237		case BT_ISO_QOS:
  1238			if (sk->sk_state == BT_CONNECTED)
  1239				qos = iso_pi(sk)->conn->hcon->iso_qos;
  1240			else
  1241				qos = iso_pi(sk)->qos;
  1242	
  1243			len = min_t(unsigned int, len, sizeof(qos));
  1244			if (copy_to_user(optval, (char *)&qos, len))
  1245				err = -EFAULT;
  1246	
  1247			break;
  1248	
  1249		case BT_ISO_BASE:
  1250			if (sk->sk_state == BT_CONNECTED) {
  1251				base_len = iso_pi(sk)->conn->hcon->le_per_adv_data_len;
  1252				base = iso_pi(sk)->conn->hcon->le_per_adv_data;
  1253			} else {
  1254				base_len = iso_pi(sk)->base_len;
  1255				base = iso_pi(sk)->base;
  1256			}
  1257	
  1258			len = min_t(unsigned int, len, base_len);
  1259			if (copy_to_user(optval, (char *)&qos, len))
  1260				err = -EFAULT;
  1261	
  1262			break;
  1263	
  1264		default:
  1265			err = -ENOPROTOOPT;
  1266			break;
  1267		}
  1268	
  1269		release_sock(sk);
  1270		return err;
  1271	}
  1272	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
