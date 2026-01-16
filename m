Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1E0342528
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 19:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768593081; cv=none; b=P010J8BKyBeIvfn8uOKLbGWtb7BKl/KlIcnIkN9wj3SCztfXq382tPyPNO3BcLPqzbrFKeox5NFlGGZxiUrw5uKIGfVGZREd3YjCLGwpBFs+MiKY3R6+VrhTt7RnANfZ2qIG1iUVi8hXKM779wz26zWmnIMFdvJulQy0yA2tPnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768593081; c=relaxed/simple;
	bh=nMpC88Ebfx7H/t0BzpFXSSi7x3kkNI6T2P/RJ8Tgvk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHRLF0Wp7oNxCDzjX4OIQXlXgKRLCe6T1OEUw5u+c3evb5crLuEFKM9vpLLhdlX40J+QhiiOI73aXGtWiWB3mpP6brxw76uF6RFx+2T0Dz0fO4z1tiHqO2dT5T07icGafzBVQ0gzfcyKXNhKiaGw+xJqMHdDOOOq/nFSeYPukEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gm2/dPL0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gm2/dPL0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768593080; x=1800129080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nMpC88Ebfx7H/t0BzpFXSSi7x3kkNI6T2P/RJ8Tgvk0=;
  b=Gm2/dPL0dJleJFjVrLwbBRrhSC7aBdUGOpo1XvWW8JeZHlCvij1I2brm
   Fu0ElsHgdGpTHvQKovcq9FFFCYZXr7c92Eq+BGXu54d3msbUjZT6FauQN
   CwgyHM1vbeI4sBUQj0XZ2DNFpGjlA7ng853AfCl19V0TqWv/p3r99Zse5
   jZr1R+OPYKq5qV01lb5yj54ijBxP/kx9m/VtRFthNoajFSfUFCiI2Ksiy
   ngtk3dWfJRbe88QpYEi+5nqQU853IM2YiFZNHpPVcedmKeGPFx7j4qO/b
   HpfGl+zdxnqq6qoJUnenrBinpZJdk7ynPcO8FsAvLaQZVpZAbVRzMl5YI
   g==;
X-CSE-ConnectionGUID: DCfL3Er3RpShJfLvYG7KkA==
X-CSE-MsgGUID: umiiKtOPQFuNvhW/vhvVbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="80633025"
X-IronPort-AV: E=Sophos;i="6.21,232,1763452800"; 
   d="scan'208";a="80633025"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 11:51:19 -0800
X-CSE-ConnectionGUID: mPpZX8szQWm7Z+BNuPkCFQ==
X-CSE-MsgGUID: OdyxXsAfS3S8DVtSIr7HwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,232,1763452800"; 
   d="scan'208";a="210332627"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 16 Jan 2026 11:51:17 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgpqk-00000000LBg-3XVw;
	Fri, 16 Jan 2026 19:51:14 +0000
Date: Sat, 17 Jan 2026 03:50:59 +0800
From: kernel test robot <lkp@intel.com>
To: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/3] Bluetooth: btnxpuart: Remove unneeded CONFIG_PM ifdef
Message-ID: <202601170322.MZrwlt6M-lkp@intel.com>
References: <20260116125803.598552-3-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116125803.598552-3-hadess@hadess.net>

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
patch link:    https://lore.kernel.org/r/20260116125803.598552-3-hadess%40hadess.net
patch subject: [PATCH 2/3] Bluetooth: btnxpuart: Remove unneeded CONFIG_PM ifdef
config: x86_64-randconfig-002-20260116 (https://download.01.org/0day-ci/archive/20260117/202601170322.MZrwlt6M-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260117/202601170322.MZrwlt6M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601170322.MZrwlt6M-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/bluetooth/btnxpuart.c:1964:12: warning: 'nxp_serdev_resume' defined but not used [-Wunused-function]
    1964 | static int nxp_serdev_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~
>> drivers/bluetooth/btnxpuart.c:1950:12: warning: 'nxp_serdev_suspend' defined but not used [-Wunused-function]
    1950 | static int nxp_serdev_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~


vim +/nxp_serdev_resume +1964 drivers/bluetooth/btnxpuart.c

689ca16e5232784 Neeraj Sanjay Kale 2023-03-16  1949  
658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05 @1950  static int nxp_serdev_suspend(struct device *dev)
658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1951  {
658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1952  	struct btnxpuart_dev *nxpdev = dev_get_drvdata(dev);
658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1953  	struct ps_data *psdata = &nxpdev->psdata;
658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1954  
658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1955  	ps_control(psdata->hdev, PS_STATE_SLEEP);
c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14  1956  
c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14  1957  	if (psdata->wakeup_source) {
c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14  1958  		enable_irq_wake(psdata->irq_handler);
c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14  1959  		enable_irq(psdata->irq_handler);
c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14  1960  	}
658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1961  	return 0;
658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1962  }
658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1963  
658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05 @1964  static int nxp_serdev_resume(struct device *dev)
658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1965  {
658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1966  	struct btnxpuart_dev *nxpdev = dev_get_drvdata(dev);
658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1967  	struct ps_data *psdata = &nxpdev->psdata;
658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1968  
c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14  1969  	if (psdata->wakeup_source) {
c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14  1970  		disable_irq(psdata->irq_handler);
c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14  1971  		disable_irq_wake(psdata->irq_handler);
c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14  1972  	}
c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14  1973  
658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1974  	ps_control(psdata->hdev, PS_STATE_AWAKE);
658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1975  	return 0;
658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1976  }
658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1977  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
