Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD16AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jun 2022 23:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiF3Xja (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiF3Xj3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jun 2022 19:39:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9B444A3D
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 16:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656632365; x=1688168365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lvm9py/P6xDFjy3ilmHS9mO7mQQ3hlDVtCIcPB8KDgE=;
  b=acMgy4bgsECw3TgjyKQ+xFTwgD+eBKyRg6d7PSfiCOGDLOKbE6tPho5k
   9QtUPn5O7lPkpUahDv58cWE/620GS9mqSKtqssO+HG310N8QwYWg8AlQu
   fgB3kp8MJCzSVKtrRSs453Pc+zldiyzfH89+kca6C7aOY8VdPH4iUU+G1
   nviksHGV7XT6zAsHCsIyHQgn0T/uprdkrjv0cfDlGyrpwR2H58e8LeFov
   rcHRDfF8UCxpEeRekaJO25ds83xPYF3Ab6Bt2CKcng/qSAmooOioBR7p+
   9EeTTPZsnNJsxXIRbUGpeXwWCfveoLeL+VUykQpWnNrNbk3paormWTtVV
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="281262409"
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="281262409"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 16:39:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="837810627"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jun 2022 16:39:15 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o73kh-000DJQ-7c;
        Thu, 30 Jun 2022 23:39:15 +0000
Date:   Fri, 1 Jul 2022 07:38:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH v4 4/7] Bluetooth: Add initial implementation of BIS
 connections
Message-ID: <202207010714.VP7EmpRd-lkp@intel.com>
References: <20220630221415.638408-4-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630221415.638408-4-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

I love your patch! Perhaps something to improve:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on next-20220630]
[cannot apply to bluetooth/master linus/master v5.19-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Luiz-Augusto-von-Dentz/Bluetooth-hci_core-Introduce-hci_recv_event_data/20220701-061626
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
config: sparc64-randconfig-r032-20220629 (https://download.01.org/0day-ci/archive/20220701/202207010714.VP7EmpRd-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/71de20339d16663211f831340ed16ed442bd3f35
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Luiz-Augusto-von-Dentz/Bluetooth-hci_core-Introduce-hci_recv_event_data/20220701-061626
        git checkout 71de20339d16663211f831340ed16ed442bd3f35
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sparc64 SHELL=/bin/bash net/bluetooth/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/bluetooth/hci_conn.c:1365:18: warning: no previous prototype for 'hci_add_bis' [-Wmissing-prototypes]
    1365 | struct hci_conn *hci_add_bis(struct hci_dev *hdev, bdaddr_t *dst,
         |                  ^~~~~~~~~~~
>> net/bluetooth/hci_conn.c:1907:18: warning: no previous prototype for 'hci_bind_bis' [-Wmissing-prototypes]
    1907 | struct hci_conn *hci_bind_bis(struct hci_conn *conn, struct bt_iso_qos *qos)
         |                  ^~~~~~~~~~~~
--
>> net/bluetooth/hci_sync.c:1066:5: warning: no previous prototype for 'hci_adv_bcast_annoucement' [-Wmissing-prototypes]
    1066 | int hci_adv_bcast_annoucement(struct hci_dev *hdev, struct adv_info *adv)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/hci_add_bis +1365 net/bluetooth/hci_conn.c

  1363	
  1364	/* This function requires the caller holds hdev->lock */
> 1365	struct hci_conn *hci_add_bis(struct hci_dev *hdev, bdaddr_t *dst,
  1366				     struct bt_iso_qos *qos)
  1367	{
  1368		struct hci_conn *conn;
  1369		struct iso_list_data data;
  1370		int err;
  1371	
  1372		/* Let's make sure that le is enabled.*/
  1373		if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
  1374			if (lmp_le_capable(hdev))
  1375				return ERR_PTR(-ECONNREFUSED);
  1376			return ERR_PTR(-EOPNOTSUPP);
  1377		}
  1378	
  1379		err = qos_set_big(hdev, qos);
  1380		if (err)
  1381			return ERR_PTR(err);
  1382	
  1383		err = qos_set_bis(hdev, qos);
  1384		if (err)
  1385			return ERR_PTR(err);
  1386	
  1387		data.big = qos->big;
  1388		data.bis = qos->bis;
  1389		data.count = 0;
  1390	
  1391		/* Check if there is already a matching BIG/BIS */
  1392		hci_conn_hash_list_state(hdev, bis_list, ISO_LINK, BT_BOUND, &data);
  1393		if (data.count)
  1394			return ERR_PTR(-EADDRINUSE);
  1395	
  1396		conn = hci_conn_hash_lookup_bis(hdev, dst, qos->big, qos->bis);
  1397		if (conn)
  1398			return ERR_PTR(-EADDRINUSE);
  1399	
  1400		conn = hci_conn_add(hdev, ISO_LINK, dst, HCI_ROLE_MASTER);
  1401		if (!conn)
  1402			return ERR_PTR(-ENOMEM);
  1403	
  1404		set_bit(HCI_CONN_PER_ADV, &conn->flags);
  1405		conn->state = BT_CONNECT;
  1406	
  1407		hci_conn_hold(conn);
  1408		return conn;
  1409	}
  1410	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
