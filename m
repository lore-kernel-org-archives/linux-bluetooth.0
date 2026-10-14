Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEEA466B77;
	Wed, 14 Oct 2026 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792005164; cv=none; b=oVhwMpMHvnZB6eHgD3e5Cy8bo1fr1CaWqXXKAlvcLjXeE97pVu3NXGtH0aqHb0jvjVe+3DIWIGGp+Oa3SxuOPlnw5ifZ6BX85FExRdEF7ACC/AgnsuoWwmR5aarFwB1xQr27N83Pzzo9FiySY2UKnPQXUVWs6YY0Gs2aGm/m5Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792005164; c=relaxed/simple;
	bh=uOw76DHvX5PKnEX4zQ3KFX7xGReoTZ7N6GvqbXLz9Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5N3wqxEMF78UKJBmnEf9o94tseD2FYGx4a9nmqV4o2uUJ7MxqVinLfoFl7B2jH0wFPM4kpAXWgQ6vPtXhcqC55VjAt2meDXn/wiHAiVhXpVqDIXq4AJVvd1QC2x/itd19dMsSF/zEcInIJgAan9mWyBvBDcp+lXDDo/Ufa2lXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mfWszqZ2; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mfWszqZ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792005160; x=1823541160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uOw76DHvX5PKnEX4zQ3KFX7xGReoTZ7N6GvqbXLz9Qo=;
  b=mfWszqZ2TCxSVbcpEvAvjo7yJbv9C0PlZvuif5XwkH5snvvlTmIHRX+/
   CTWl4KGrAmkcbrx1kjDFBHpSPWkB/1ktPeluLcnxdDHJ1FaVZsSn9E/Ga
   x1RPORKghfSHchEmRJFiCiJ+6lkK/8u964Sd+cDDqU3ra+VQJFuHBdSYo
   jJYn6oMYRHlgMTA6t/PwWqMYoxl9cF/4xrnhaJLpHq5C1WIe+QGvlcFcz
   TCWPoOHNw5GTAg6Dst+52JBs3Y/4Uhy6lL99QHK1b1/GlUPDGReTk5/Qu
   pBMIYKZZIXZjmrQeKm3ruEI5LHpqvQL7rzMVqxg9/fCld0iwM22EwbOaj
   w==;
X-CSE-ConnectionGUID: IJi+BuWeTvevTd7tcTR3fA==
X-CSE-MsgGUID: LlbqizpNR9y0cUL5cjUmHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="662923"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="662923"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 12:12:39 -0700
X-CSE-ConnectionGUID: epMBbctzSIOaYFCJzGPtKA==
X-CSE-MsgGUID: 1yDTyJ/iQoSi2oqeauhA4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1609634"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 14 Oct 2026 12:12:37 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xH4Ov-00000000F5r-3jiq;
	Wed, 14 Oct 2026 19:12:33 +0000
Date: Thu, 15 Oct 2026 03:11:54 +0800
From: kernel test robot <lkp@intel.com>
To: Cen Zhang <zzzccc427@gmail.com>, marcel@holtmann.org,
	luiz.dentz@gmail.com, padovan@profusion.mobi,
	johan.hedberg@nokia.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, jjzuming@gmail.com, zzzccc427@gmail.com
Subject: Re: [PATCH] Bluetooth: MGMT: Serialize power-on with power-off
 completion
Message-ID: <202610150313.1x2NMEsK-lkp@intel.com>
References: <pm-bluetooth-objects-candidate-0063-v7-35a6680c94a332fea155@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pm-bluetooth-objects-candidate-0063-v7-35a6680c94a332fea155@gmail.com>

Hi Cen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on bluetooth-next/master linus/master v7.3-rc7 next-20261012]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cen-Zhang/Bluetooth-MGMT-Serialize-power-on-with-power-off-completion/20261014-002814
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/pm-bluetooth-objects-candidate-0063-v7-35a6680c94a332fea155%40gmail.com
patch subject: [PATCH] Bluetooth: MGMT: Serialize power-on with power-off completion
config: arm64-randconfig-1000-20261014 (https://download.01.org/0day-ci/archive/20261015/202610150313.1x2NMEsK-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 6719b9e31d6a93099612c474eec76d9f41d0275a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261015/202610150313.1x2NMEsK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610150313.1x2NMEsK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/bluetooth/mgmt.c:1415:2: warning: mutex 'hdev->req_lock' is not held on every path through here [-Wthread-safety-analysis]
    1415 |         hci_dev_lock(hdev);
         |         ^
   include/net/bluetooth/hci_core.h:1752:26: note: expanded from macro 'hci_dev_lock'
    1752 | #define hci_dev_lock(d)         mutex_lock(&d->lock)
         |                                 ^
   include/linux/mutex.h:193:26: note: expanded from macro 'mutex_lock'
     193 | #define mutex_lock(lock) mutex_lock_nested(lock, 0)
         |                          ^
   net/bluetooth/mgmt.c:1413:3: note: mutex acquired here
    1413 |                 hci_req_sync_lock(hdev);
         |                 ^
   include/net/bluetooth/hci_sync.h:15:35: note: expanded from macro 'hci_req_sync_lock'
      15 | #define hci_req_sync_lock(hdev)   mutex_lock(&hdev->req_lock)
         |                                   ^
   include/linux/mutex.h:193:26: note: expanded from macro 'mutex_lock'
     193 | #define mutex_lock(lock) mutex_lock_nested(lock, 0)
         |                          ^
>> net/bluetooth/mgmt.c:1459:3: warning: releasing mutex 'hdev->req_lock' that was not held [-Wthread-safety-analysis]
    1459 |                 hci_req_sync_unlock(hdev);
         |                 ^
   include/net/bluetooth/hci_sync.h:16:35: note: expanded from macro 'hci_req_sync_unlock'
      16 | #define hci_req_sync_unlock(hdev) mutex_unlock(&hdev->req_lock)
         |                                   ^
   2 warnings generated.


vim +1415 net/bluetooth/mgmt.c

8b064a3ad377c01 Johan Hedberg          2014-02-24  1394  
bdb6d97154b7b7e Johan Hedberg          2012-02-28  1395  static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
bdb6d97154b7b7e Johan Hedberg          2012-02-28  1396  		       u16 len)
eec8d2bcc841ae4 Johan Hedberg          2010-12-16  1397  {
650f726d16a3f25 Vinicius Costa Gomes   2012-02-02  1398  	struct mgmt_mode *cp = data;
3b0602cd01a5711 Johan Hedberg          2015-03-06  1399  	struct mgmt_pending_cmd *cmd;
4b34ee782164fba Johan Hedberg          2012-02-21  1400  	int err;
eec8d2bcc841ae4 Johan Hedberg          2010-12-16  1401  
181d695352305cc Marcel Holtmann        2020-05-06  1402  	bt_dev_dbg(hdev, "sock %p", sk);
eec8d2bcc841ae4 Johan Hedberg          2010-12-16  1403  
a7e80f25ae2296d Johan Hedberg          2013-01-09  1404  	if (cp->val != 0x00 && cp->val != 0x01)
a69e8375a134eb7 Johan Hedberg          2015-03-06  1405  		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_POWERED,
a7e80f25ae2296d Johan Hedberg          2013-01-09  1406  				       MGMT_STATUS_INVALID_PARAMS);
a7e80f25ae2296d Johan Hedberg          2013-01-09  1407  
0ec18e0eaccffd5 Cen Zhang              2026-10-14  1408  	/*
0ec18e0eaccffd5 Cen Zhang              2026-10-14  1409  	 * Wait for the previous power-off completion before publishing a
0ec18e0eaccffd5 Cen Zhang              2026-10-14  1410  	 * new command that could reuse its freed pending-command address.
0ec18e0eaccffd5 Cen Zhang              2026-10-14  1411  	 */
0ec18e0eaccffd5 Cen Zhang              2026-10-14  1412  	if (cp->val)
0ec18e0eaccffd5 Cen Zhang              2026-10-14  1413  		hci_req_sync_lock(hdev);
0ec18e0eaccffd5 Cen Zhang              2026-10-14  1414  
09fd0de5bd8f8ef Gustavo Padovan        2011-06-17 @1415  	hci_dev_lock(hdev);
eec8d2bcc841ae4 Johan Hedberg          2010-12-16  1416  
b14202aff5acba3 Jonas Dreßler          2024-01-07  1417  	if (!cp->val) {
b14202aff5acba3 Jonas Dreßler          2024-01-07  1418  		if (hci_dev_test_flag(hdev, HCI_POWERING_DOWN)) {
b14202aff5acba3 Jonas Dreßler          2024-01-07  1419  			err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_POWERED,
b14202aff5acba3 Jonas Dreßler          2024-01-07  1420  					      MGMT_STATUS_BUSY);
b14202aff5acba3 Jonas Dreßler          2024-01-07  1421  			goto failed;
b14202aff5acba3 Jonas Dreßler          2024-01-07  1422  		}
b14202aff5acba3 Jonas Dreßler          2024-01-07  1423  	}
b14202aff5acba3 Jonas Dreßler          2024-01-07  1424  
333ae95d054519f Johan Hedberg          2015-03-17  1425  	if (pending_find(MGMT_OP_SET_POWERED, hdev)) {
a69e8375a134eb7 Johan Hedberg          2015-03-06  1426  		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_POWERED,
87b95ba64efcfcf Johan Hedberg          2013-09-25  1427  				      MGMT_STATUS_BUSY);
87b95ba64efcfcf Johan Hedberg          2013-09-25  1428  		goto failed;
87b95ba64efcfcf Johan Hedberg          2013-09-25  1429  	}
87b95ba64efcfcf Johan Hedberg          2013-09-25  1430  
4b34ee782164fba Johan Hedberg          2012-02-21  1431  	if (!!cp->val == hdev_is_powered(hdev)) {
69ab39ea5da03e6 Johan Hedberg          2011-12-15  1432  		err = send_settings_rsp(sk, MGMT_OP_SET_POWERED, hdev);
eec8d2bcc841ae4 Johan Hedberg          2010-12-16  1433  		goto failed;
eec8d2bcc841ae4 Johan Hedberg          2010-12-16  1434  	}
eec8d2bcc841ae4 Johan Hedberg          2010-12-16  1435  
275f3f64870245b Brian Gix              2022-03-01  1436  	cmd = mgmt_pending_add(sk, MGMT_OP_SET_POWERED, hdev, data, len);
366a033698266c3 Johan Hedberg          2011-02-19  1437  	if (!cmd) {
366a033698266c3 Johan Hedberg          2011-02-19  1438  		err = -ENOMEM;
eec8d2bcc841ae4 Johan Hedberg          2010-12-16  1439  		goto failed;
366a033698266c3 Johan Hedberg          2011-02-19  1440  	}
eec8d2bcc841ae4 Johan Hedberg          2010-12-16  1441  
f419863588217f7 Archie Pusaka          2023-04-20  1442  	/* Cancel potentially blocking sync operation before power off */
d883a4669a1def6 Luiz Augusto von Dentz 2023-04-21  1443  	if (cp->val == 0x00) {
63298d6e752fc0e Luiz Augusto von Dentz 2024-01-09  1444  		hci_cmd_sync_cancel_sync(hdev, -EHOSTDOWN);
cf75ad8b41d2aa0 Luiz Augusto von Dentz 2021-10-27  1445  		err = hci_cmd_sync_queue(hdev, set_powered_sync, cmd,
cf75ad8b41d2aa0 Luiz Augusto von Dentz 2021-10-27  1446  					 mgmt_set_powered_complete);
d883a4669a1def6 Luiz Augusto von Dentz 2023-04-21  1447  	} else {
d883a4669a1def6 Luiz Augusto von Dentz 2023-04-21  1448  		/* Use hci_cmd_sync_submit since hdev might not be running */
d883a4669a1def6 Luiz Augusto von Dentz 2023-04-21  1449  		err = hci_cmd_sync_submit(hdev, set_powered_sync, cmd,
d883a4669a1def6 Luiz Augusto von Dentz 2023-04-21  1450  					  mgmt_set_powered_complete);
d883a4669a1def6 Luiz Augusto von Dentz 2023-04-21  1451  	}
eec8d2bcc841ae4 Johan Hedberg          2010-12-16  1452  
275f3f64870245b Brian Gix              2022-03-01  1453  	if (err < 0)
275f3f64870245b Brian Gix              2022-03-01  1454  		mgmt_pending_remove(cmd);
275f3f64870245b Brian Gix              2022-03-01  1455  
eec8d2bcc841ae4 Johan Hedberg          2010-12-16  1456  failed:
09fd0de5bd8f8ef Gustavo Padovan        2011-06-17  1457  	hci_dev_unlock(hdev);
0ec18e0eaccffd5 Cen Zhang              2026-10-14  1458  	if (cp->val)
0ec18e0eaccffd5 Cen Zhang              2026-10-14 @1459  		hci_req_sync_unlock(hdev);
366a033698266c3 Johan Hedberg          2011-02-19  1460  	return err;
eec8d2bcc841ae4 Johan Hedberg          2010-12-16  1461  }
eec8d2bcc841ae4 Johan Hedberg          2010-12-16  1462  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
