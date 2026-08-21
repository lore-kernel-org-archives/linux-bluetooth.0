Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F24360EC6
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787326497; cv=none; b=orjU1UkhHXXi7UHcV7+qji0jvGWzwkMCxxLb2WBpvHkxcMHx8L9I3+MIBPa7WFdyRiJ1q4oPHFhPrX8Abe4oi/Kv9UdJ0lfj0jXEdLWs5mzoqKW8nKCBloP8Ncr5mml6AO0gr1B8Pg3q+daU7P102vhpKTNq7AzHfqSAuBR6jgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787326497; c=relaxed/simple;
	bh=ykwZWgDMgOV8peIGe6wkaEkS+CcdQbH5sJf9SdYvdyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmDHy1iFmXAH53EbkcpUnj1N0fZcE2h1AcBjD/VZyg8UcIVcPclYKlg20FsT3e4X3ufAAQODJL1ANg3UfpWXU+LeSc2Jp6AHc6bBL4et0iin2/0A6F5OCUfcBvNUWXABgtTxe91JY1ouaxHdbWHUBSYcNY7m3IbShcTTXhG5tGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iEVi+Iek; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iEVi+Iek"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787326494; x=1818862494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ykwZWgDMgOV8peIGe6wkaEkS+CcdQbH5sJf9SdYvdyo=;
  b=iEVi+IekOmO0tePq/2KsK/TKd3mQazf5Gs79EVCPKezXmfCME5tkKX9j
   Q/q7NnNfUmR/5jV83xjqFvYXYtFyCe/iSiOEXjTSQps+EVJHuwwadu4Vy
   RE4MRLFE85IzJ6Sm594PBmx8dw1mDjmYwKG3eyZ1solL+FTE4F+Ad/b3Y
   MyIEvdyZLVdoxsqMmjEVVaiuJNn1H26iAgLHhjWJ3/X6/VKtRyQy/Xoo/
   EjkXtsSiWWz9LdEW5eiXNuKzy2snMujOLCT44YbOwmGSZEVxokX/UntMw
   53UO8IA+1kOatnkfXJBxct8oLGlcJR71U18BFQaNdVvPnW2/H7pDLME/b
   g==;
X-CSE-ConnectionGUID: OD20xz2ITeKQDuHOdTKpDA==
X-CSE-MsgGUID: 6y19Pb25TZ2mg5g8xLdovw==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="99031837"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="99031837"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 08:34:52 -0700
X-CSE-ConnectionGUID: YCmjc5zpSKe6qOfMnt93zQ==
X-CSE-MsgGUID: sjcpjyf+Qh+J6H/K79WmwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="271595539"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 21 Aug 2026 08:34:50 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wxRGZ-00000000q6z-3Tmf;
	Fri, 21 Aug 2026 15:34:47 +0000
Date: Fri, 21 Aug 2026 23:34:26 +0800
From: kernel test robot <lkp@intel.com>
To: Li Jun <lijun01@kylinos.cn>, marcel@holtmann.org, luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] bluetooth: pm: use SIMPLE_DEV_OPS for pm struct
Message-ID: <202608212327.5HOcOSwg-lkp@intel.com>
References: <20260819054525.2325031-1-lijun01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819054525.2325031-1-lijun01@kylinos.cn>

Hi Li,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on bluetooth-next/master linus/master v7.2 next-20260820]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Jun/bluetooth-pm-use-SIMPLE_DEV_OPS-for-pm-struct/20260819-134525
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20260819054525.2325031-1-lijun01%40kylinos.cn
patch subject: [PATCH] bluetooth: pm: use SIMPLE_DEV_OPS for pm struct
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20260821/202608212327.5HOcOSwg-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260821/202608212327.5HOcOSwg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608212327.5HOcOSwg-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/bluetooth/btmrvl_sdio.c:1678:12: warning: 'btmrvl_sdio_resume' defined but not used [-Wunused-function]
    1678 | static int btmrvl_sdio_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~
>> drivers/bluetooth/btmrvl_sdio.c:1608:12: warning: 'btmrvl_sdio_suspend' defined but not used [-Wunused-function]
    1608 | static int btmrvl_sdio_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~


vim +/btmrvl_sdio_resume +1678 drivers/bluetooth/btmrvl_sdio.c

789221ecc870117 Bing Zhao              2009-06-02  1607  
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25 @1608  static int btmrvl_sdio_suspend(struct device *dev)
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1609  {
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1610  	struct sdio_func *func = dev_to_sdio_func(dev);
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1611  	struct btmrvl_sdio_card *card;
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1612  	struct btmrvl_private *priv;
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1613  	mmc_pm_flag_t pm_flags;
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1614  	struct hci_dev *hcidev;
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1615  
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1616  	if (func) {
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1617  		pm_flags = sdio_get_host_pm_caps(func);
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1618  		BT_DBG("%s: suspend: PM flags = 0x%x", sdio_func_id(func),
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1619  		       pm_flags);
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1620  		if (!(pm_flags & MMC_PM_KEEP_POWER)) {
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1621  			BT_ERR("%s: cannot remain alive while suspended",
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1622  			       sdio_func_id(func));
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1623  			return -ENOSYS;
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1624  		}
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1625  		card = sdio_get_drvdata(func);
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1626  		if (!card || !card->priv) {
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1627  			BT_ERR("card or priv structure is not valid");
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1628  			return 0;
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1629  		}
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1630  	} else {
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1631  		BT_ERR("sdio_func is not specified");
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1632  		return 0;
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1633  	}
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1634  
bb7f4f0bcee6844 Xinming Hu             2016-04-26  1635  	/* Enable platform specific wakeup interrupt */
e660b3510eb4b3c Abhishek Pandit-Subedi 2020-06-10  1636  	if (card->plt_wake_cfg && card->plt_wake_cfg->irq_bt >= 0 &&
e660b3510eb4b3c Abhishek Pandit-Subedi 2020-06-10  1637  	    device_may_wakeup(dev)) {
bb7f4f0bcee6844 Xinming Hu             2016-04-26  1638  		card->plt_wake_cfg->wake_by_bt = false;
bb7f4f0bcee6844 Xinming Hu             2016-04-26  1639  		enable_irq(card->plt_wake_cfg->irq_bt);
bb7f4f0bcee6844 Xinming Hu             2016-04-26  1640  		enable_irq_wake(card->plt_wake_cfg->irq_bt);
bb7f4f0bcee6844 Xinming Hu             2016-04-26  1641  	}
bb7f4f0bcee6844 Xinming Hu             2016-04-26  1642  
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1643  	priv = card->priv;
8cf60cf238ce1be Chin-Ran Lo            2016-01-06  1644  	priv->adapter->is_suspending = true;
5bf8a7481d21a66 Chin-Ran Lo            2014-07-14  1645  	hcidev = priv->btmrvl_dev.hcidev;
5bf8a7481d21a66 Chin-Ran Lo            2014-07-14  1646  	BT_DBG("%s: SDIO suspend", hcidev->name);
5bf8a7481d21a66 Chin-Ran Lo            2014-07-14  1647  	hci_suspend_dev(hcidev);
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1648  
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1649  	if (priv->adapter->hs_state != HS_ACTIVATED) {
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1650  		if (btmrvl_enable_hs(priv)) {
8f91566f99fab8f Colin Ian King         2017-02-18  1651  			BT_ERR("HS not activated, suspend failed!");
6eb7bd66830c1e1 Xinming Hu             2017-03-31  1652  			/* Disable platform specific wakeup interrupt */
6eb7bd66830c1e1 Xinming Hu             2017-03-31  1653  			if (card->plt_wake_cfg &&
e660b3510eb4b3c Abhishek Pandit-Subedi 2020-06-10  1654  			    card->plt_wake_cfg->irq_bt >= 0 &&
e660b3510eb4b3c Abhishek Pandit-Subedi 2020-06-10  1655  			    device_may_wakeup(dev)) {
6eb7bd66830c1e1 Xinming Hu             2017-03-31  1656  				disable_irq_wake(card->plt_wake_cfg->irq_bt);
6eb7bd66830c1e1 Xinming Hu             2017-03-31  1657  				disable_irq(card->plt_wake_cfg->irq_bt);
6eb7bd66830c1e1 Xinming Hu             2017-03-31  1658  			}
6eb7bd66830c1e1 Xinming Hu             2017-03-31  1659  
e7acf43024e95fa Amitkumar Karwar       2016-07-15  1660  			priv->adapter->is_suspending = false;
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1661  			return -EBUSY;
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1662  		}
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1663  	}
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1664  
8cf60cf238ce1be Chin-Ran Lo            2016-01-06  1665  	priv->adapter->is_suspending = false;
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1666  	priv->adapter->is_suspended = true;
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1667  
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1668  	/* We will keep the power when hs enabled successfully */
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1669  	if (priv->adapter->hs_state == HS_ACTIVATED) {
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1670  		BT_DBG("suspend with MMC_PM_KEEP_POWER");
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1671  		return sdio_set_host_pm_flags(func, MMC_PM_KEEP_POWER);
f1554b7b2c27ced prasanna karthik       2017-03-28  1672  	}
f1554b7b2c27ced prasanna karthik       2017-03-28  1673  
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1674  	BT_DBG("suspend without MMC_PM_KEEP_POWER");
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1675  	return 0;
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1676  }
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1677  
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25 @1678  static int btmrvl_sdio_resume(struct device *dev)
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1679  {
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1680  	struct sdio_func *func = dev_to_sdio_func(dev);
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1681  	struct btmrvl_sdio_card *card;
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1682  	struct btmrvl_private *priv;
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1683  	mmc_pm_flag_t pm_flags;
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1684  	struct hci_dev *hcidev;
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1685  
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1686  	if (func) {
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1687  		pm_flags = sdio_get_host_pm_caps(func);
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1688  		BT_DBG("%s: resume: PM flags = 0x%x", sdio_func_id(func),
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1689  		       pm_flags);
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1690  		card = sdio_get_drvdata(func);
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1691  		if (!card || !card->priv) {
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1692  			BT_ERR("card or priv structure is not valid");
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1693  			return 0;
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1694  		}
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1695  	} else {
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1696  		BT_ERR("sdio_func is not specified");
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1697  		return 0;
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1698  	}
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1699  	priv = card->priv;
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1700  
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1701  	if (!priv->adapter->is_suspended) {
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1702  		BT_DBG("device already resumed");
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1703  		return 0;
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1704  	}
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1705  
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1706  	priv->hw_wakeup_firmware(priv);
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1707  	priv->adapter->hs_state = HS_DEACTIVATED;
5bf8a7481d21a66 Chin-Ran Lo            2014-07-14  1708  	hcidev = priv->btmrvl_dev.hcidev;
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1709  	BT_DBG("%s: HS DEACTIVATED in resume!", hcidev->name);
5bf8a7481d21a66 Chin-Ran Lo            2014-07-14  1710  	priv->adapter->is_suspended = false;
5bf8a7481d21a66 Chin-Ran Lo            2014-07-14  1711  	BT_DBG("%s: SDIO resume", hcidev->name);
5bf8a7481d21a66 Chin-Ran Lo            2014-07-14  1712  	hci_resume_dev(hcidev);
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1713  
bb7f4f0bcee6844 Xinming Hu             2016-04-26  1714  	/* Disable platform specific wakeup interrupt */
e660b3510eb4b3c Abhishek Pandit-Subedi 2020-06-10  1715  	if (card->plt_wake_cfg && card->plt_wake_cfg->irq_bt >= 0 &&
e660b3510eb4b3c Abhishek Pandit-Subedi 2020-06-10  1716  	    device_may_wakeup(dev)) {
bb7f4f0bcee6844 Xinming Hu             2016-04-26  1717  		disable_irq_wake(card->plt_wake_cfg->irq_bt);
bb7f4f0bcee6844 Xinming Hu             2016-04-26  1718  		disable_irq(card->plt_wake_cfg->irq_bt);
9af02d86e11dc40 Jeffy Chen             2017-01-23  1719  		if (card->plt_wake_cfg->wake_by_bt)
9af02d86e11dc40 Jeffy Chen             2017-01-23  1720  			/* Undo our disable, since interrupt handler already
9af02d86e11dc40 Jeffy Chen             2017-01-23  1721  			 * did this.
9af02d86e11dc40 Jeffy Chen             2017-01-23  1722  			 */
9af02d86e11dc40 Jeffy Chen             2017-01-23  1723  			enable_irq(card->plt_wake_cfg->irq_bt);
bb7f4f0bcee6844 Xinming Hu             2016-04-26  1724  	}
bb7f4f0bcee6844 Xinming Hu             2016-04-26  1725  
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1726  	return 0;
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1727  }
ba54a16ffacfc71 Amitkumar Karwar       2012-04-25  1728  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
