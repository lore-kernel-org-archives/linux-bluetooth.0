Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62F3C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 May 2022 00:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387590AbiEFApz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 May 2022 20:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348227AbiEFApx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 May 2022 20:45:53 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709935AED8
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 May 2022 17:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651797732; x=1683333732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C/yVRAjQLj9s6qLrBgrsq5zknP237UMvJYdR77pZxPg=;
  b=B7QY5JT0NyNx01JTHSCRTtPC16TN3/Jhq03ZjPvB2NqzzmD/0elJza2Q
   sXTWNgprZVYi+vQkj8KxcptHbDdKmJcsUFaEtq7lt8kwQvBJCt8kd2fpv
   zHQpU142WVoiWMUCYvGOsjAwBhUU6G/t5Dc6bfnPNExhbUFrpseCPrf3I
   PWGYuDD9wVKQYfvoRsk7a4bx65nqAoEqvnEMkO1mZIvlnhMzgFSZqUR4O
   FPVeYkFQhELB7/TN4uFBTY2vhXtkBPDNUtUdhNA3NZQ813zXlmIqA2K7Y
   kYLvfc+tJKLPfG6/ZRFF5N54mTbL84Hkcx9feB+5b0IftSMZ4D6uoq1fT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="250293729"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="250293729"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 17:42:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="517785257"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 05 May 2022 17:42:10 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmm2s-000Csi-6y;
        Fri, 06 May 2022 00:42:10 +0000
Date:   Fri, 6 May 2022 08:41:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH 5/8] Bluetooth: Add initial implementation of BIS
 connections
Message-ID: <202205060852.Supq0SZS-lkp@intel.com>
References: <20220505230550.3450617-5-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505230550.3450617-5-luiz.dentz@gmail.com>
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
config: riscv-randconfig-r042-20220505 (https://download.01.org/0day-ci/archive/20220506/202205060852.Supq0SZS-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d69aaead9db3307f674a711d3db70e884b31d381
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Luiz-Augusto-von-Dentz/Bluetooth-eir-Add-helpers-for-managing-service-data/20220506-070828
        git checkout d69aaead9db3307f674a711d3db70e884b31d381
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash net/bluetooth/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/bluetooth/hci_conn.c:1361:18: warning: no previous prototype for 'hci_add_bis' [-Wmissing-prototypes]
    1361 | struct hci_conn *hci_add_bis(struct hci_dev *hdev, bdaddr_t *dst,
         |                  ^~~~~~~~~~~
>> net/bluetooth/hci_conn.c:1874:18: warning: no previous prototype for 'hci_bind_bis' [-Wmissing-prototypes]
    1874 | struct hci_conn *hci_bind_bis(struct hci_conn *conn, struct bt_iso_qos *qos)
         |                  ^~~~~~~~~~~~
--
>> net/bluetooth/hci_sync.c:1056:5: warning: no previous prototype for 'hci_adv_bcast_annoucement' [-Wmissing-prototypes]
    1056 | int hci_adv_bcast_annoucement(struct hci_dev *hdev, struct adv_info *adv)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/hci_add_bis +1361 net/bluetooth/hci_conn.c

  1359	
  1360	/* This function requires the caller holds hdev->lock */
> 1361	struct hci_conn *hci_add_bis(struct hci_dev *hdev, bdaddr_t *dst,
  1362				     struct bt_iso_qos *qos)
  1363	{
  1364		struct hci_conn *conn;
  1365		struct iso_list_data data;
  1366		int err;
  1367	
  1368		/* Let's make sure that le is enabled.*/
  1369		if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
  1370			if (lmp_le_capable(hdev))
  1371				return ERR_PTR(-ECONNREFUSED);
  1372			return ERR_PTR(-EOPNOTSUPP);
  1373		}
  1374	
  1375		err = qos_set_big(hdev, qos);
  1376		if (err)
  1377			return ERR_PTR(err);
  1378	
  1379		err = qos_set_bis(hdev, qos);
  1380		if (err)
  1381			return ERR_PTR(err);
  1382	
  1383		data.big = qos->big;
  1384		data.bis = qos->bis;
  1385		data.count = 0;
  1386	
  1387		/* Check if there is already a matching BIG/BIS */
  1388		hci_conn_hash_list_state(hdev, bis_list, ISO_LINK, BT_BOUND, &data);
  1389		if (data.count)
  1390			return ERR_PTR(-EADDRINUSE);
  1391	
  1392		conn = hci_conn_hash_lookup_bis(hdev, dst, qos->big, qos->bis);
  1393		if (conn)
  1394			return ERR_PTR(-EADDRINUSE);
  1395	
  1396		conn = hci_conn_add(hdev, ISO_LINK, dst, HCI_ROLE_MASTER);
  1397		if (!conn)
  1398			return ERR_PTR(-ENOMEM);
  1399	
  1400		set_bit(HCI_CONN_PER_ADV, &conn->flags);
  1401		conn->state = BT_CONNECT;
  1402	
  1403		hci_conn_hold(conn);
  1404		return conn;
  1405	}
  1406	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
