Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F3D369220
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768591760; cv=none; b=WJ8nNbrGWjD25QE/s+9y9CrIqUENbHQ4CY9F3hXwG0MYP+v6LGHTdPCPRpXNE0sJ8abiuSkyTtnJqcirfTWmaUA3d6q/7no+KnHMh/aODy7UAyqOi21uYGznLjEXjfjlWgPjFj+urTX5j9oybvft2eCcUUFXH1cqqdmvxRgUviY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768591760; c=relaxed/simple;
	bh=CRYhrh7TkmdLA/azwJ1OE/b49TeVZKlSj3m9m+4BkYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDlbLD6YjIy9fz4yD8RE6ybNDUE6N/X9OIkKstPMe1qcVIhHU3TzaKkb1E+WDSq357sHCHA/hbl7Xajj2b8GQe5HaNzki00GcRO66WN70dRJgG6YS7ZCqShKQqYiOkL0eYxdx0BHqGM8TUTitPYa9auFIreMPtWdIqctjmotEF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yxj5dfDy; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yxj5dfDy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768591758; x=1800127758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CRYhrh7TkmdLA/azwJ1OE/b49TeVZKlSj3m9m+4BkYI=;
  b=Yxj5dfDy32cJKz5QNPD21TugvtD7EyDHqLXSK+IelRelzYjWs/kefNhB
   qtem0fOmF9pzG06G0+VDP/82eDMSCGJ4H5HeO9pl/uP/PyoSL3RuYbMhG
   Zhr0EHUAsPFqn4MyrUIWFlsxEu83N5xzRWVEt0o7uEoOsOjFmuYlsLwvj
   OgDwcTwb5jn4ZPKp3BV2JskoEfGHMPDRtZJbICoqswhzeGfLkSBqDIt4p
   MJrtGqpxnXuHiIU3Cm8kctSRwipN7MWWUXh0zoYRk770agjL14Ep89Jy/
   am+vRVv5Ry7MUYGN0sEhPnVcfkzAEFs3r0x2/YeZjxTfrCOtQe366JR2c
   Q==;
X-CSE-ConnectionGUID: 9yfCKYArS+mMxLp3Toj9aw==
X-CSE-MsgGUID: kKv2jToxRlmQFnt3ndYXyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="69961301"
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="69961301"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 11:29:17 -0800
X-CSE-ConnectionGUID: /ob7D2+zTS+WAL/LPtkSUw==
X-CSE-MsgGUID: O+zFpQrLRo+CR5JAL4/SkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="205348973"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 16 Jan 2026 11:29:17 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgpVR-00000000LAS-3db4;
	Fri, 16 Jan 2026 19:29:13 +0000
Date: Sat, 17 Jan 2026 03:29:04 +0800
From: kernel test robot <lkp@intel.com>
To: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/3] Bluetooth: btmtksdio: Simplify dev_pm_ops usage
Message-ID: <202601170415.QZeIgHEM-lkp@intel.com>
References: <20260116125803.598552-2-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116125803.598552-2-hadess@hadess.net>

Hi Bastien,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on linus/master v6.19-rc5]
[cannot apply to bluetooth-next/master next-20260116]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bastien-Nocera/Bluetooth-btmtksdio-Simplify-dev_pm_ops-usage/20260116-210400
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20260116125803.598552-2-hadess%40hadess.net
patch subject: [PATCH 1/3] Bluetooth: btmtksdio: Simplify dev_pm_ops usage
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20260117/202601170415.QZeIgHEM-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260117/202601170415.QZeIgHEM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601170415.QZeIgHEM-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/bluetooth/btmtksdio.c:1534:12: warning: 'btmtksdio_system_resume' defined but not used [-Wunused-function]
    1534 | static int btmtksdio_system_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/bluetooth/btmtksdio.c:1497:12: warning: 'btmtksdio_system_suspend' defined but not used [-Wunused-function]
    1497 | static int btmtksdio_system_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/btmtksdio_system_resume +1534 drivers/bluetooth/btmtksdio.c

7f3c563c575e73 Sean Wang       2019-04-18  1496  
4ed924fc122f75 Zhengping Jiang 2023-10-13 @1497  static int btmtksdio_system_suspend(struct device *dev)
4ed924fc122f75 Zhengping Jiang 2023-10-13  1498  {
4ed924fc122f75 Zhengping Jiang 2023-10-13  1499  	struct sdio_func *func = dev_to_sdio_func(dev);
4ed924fc122f75 Zhengping Jiang 2023-10-13  1500  	struct btmtksdio_dev *bdev;
4ed924fc122f75 Zhengping Jiang 2023-10-13  1501  
4ed924fc122f75 Zhengping Jiang 2023-10-13  1502  	bdev = sdio_get_drvdata(func);
4ed924fc122f75 Zhengping Jiang 2023-10-13  1503  	if (!bdev)
4ed924fc122f75 Zhengping Jiang 2023-10-13  1504  		return 0;
4ed924fc122f75 Zhengping Jiang 2023-10-13  1505  
4ed924fc122f75 Zhengping Jiang 2023-10-13  1506  	if (!test_bit(BTMTKSDIO_FUNC_ENABLED, &bdev->tx_state))
4ed924fc122f75 Zhengping Jiang 2023-10-13  1507  		return 0;
4ed924fc122f75 Zhengping Jiang 2023-10-13  1508  
4ed924fc122f75 Zhengping Jiang 2023-10-13  1509  	set_bit(BTMTKSDIO_BT_WAKE_ENABLED, &bdev->tx_state);
4ed924fc122f75 Zhengping Jiang 2023-10-13  1510  
4ed924fc122f75 Zhengping Jiang 2023-10-13  1511  	return btmtksdio_runtime_suspend(dev);
4ed924fc122f75 Zhengping Jiang 2023-10-13  1512  }
4ed924fc122f75 Zhengping Jiang 2023-10-13  1513  
7f3c563c575e73 Sean Wang       2019-04-18  1514  static int btmtksdio_runtime_resume(struct device *dev)
7f3c563c575e73 Sean Wang       2019-04-18  1515  {
7f3c563c575e73 Sean Wang       2019-04-18  1516  	struct sdio_func *func = dev_to_sdio_func(dev);
7f3c563c575e73 Sean Wang       2019-04-18  1517  	struct btmtksdio_dev *bdev;
7f3c563c575e73 Sean Wang       2019-04-18  1518  	int err;
7f3c563c575e73 Sean Wang       2019-04-18  1519  
7f3c563c575e73 Sean Wang       2019-04-18  1520  	bdev = sdio_get_drvdata(func);
7f3c563c575e73 Sean Wang       2019-04-18  1521  	if (!bdev)
7f3c563c575e73 Sean Wang       2019-04-18  1522  		return 0;
7f3c563c575e73 Sean Wang       2019-04-18  1523  
4b4b2228f521c3 Sean Wang       2021-12-02  1524  	if (!test_bit(BTMTKSDIO_FUNC_ENABLED, &bdev->tx_state))
4b4b2228f521c3 Sean Wang       2021-12-02  1525  		return 0;
4b4b2228f521c3 Sean Wang       2021-12-02  1526  
c7e301d7c85544 Mark Chen       2022-01-12  1527  	err = btmtksdio_drv_pmctrl(bdev);
7f3c563c575e73 Sean Wang       2019-04-18  1528  
095519de2debef Sean Wang       2022-01-12  1529  	bt_dev_dbg(bdev->hdev, "status (%d) get ownership from device", err);
7f3c563c575e73 Sean Wang       2019-04-18  1530  
7f3c563c575e73 Sean Wang       2019-04-18  1531  	return err;
7f3c563c575e73 Sean Wang       2019-04-18  1532  }
7f3c563c575e73 Sean Wang       2019-04-18  1533  
4ed924fc122f75 Zhengping Jiang 2023-10-13 @1534  static int btmtksdio_system_resume(struct device *dev)
4ed924fc122f75 Zhengping Jiang 2023-10-13  1535  {
4ed924fc122f75 Zhengping Jiang 2023-10-13  1536  	return btmtksdio_runtime_resume(dev);
4ed924fc122f75 Zhengping Jiang 2023-10-13  1537  }
4ed924fc122f75 Zhengping Jiang 2023-10-13  1538  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
