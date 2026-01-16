Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018C52566F7
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 21:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768600225; cv=none; b=M7gvHq5ZEUVOaYnSan7vR/WnKBl8l3yRu4SpzCuksIlmuL4eeTslm5SsgxU7brFmrDvb8rMjzgDXJwuxW5TE5CcoJnuhNiFk01tj9VneaF7BX++5hmsY9k+Mc8+O2Ul++zCWFLUu8HNwwm2mWcrVxoia3BCZcTxikbQQ2EnQiL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768600225; c=relaxed/simple;
	bh=fF8lfZA+aQ0843Df3tGPAqtL39ko7kSyh1RXD5llta0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkyKlI6E9o5oOsLa2Ay014Ek5TIW/88+XvkJxiY0YwUSgH/2p6AmiVnCD0gI08T5F785YLHMNDO7sINCWPyX1xuHrgvzwkvlkolPkZAwKuUbq9UG/RiHUA6NX1JS8GAo6PfUEG1lWuuhBUxXv+9yQ3nBkqJF5nKeLwmc/AXZ/xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gIUTJAHT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gIUTJAHT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768600224; x=1800136224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fF8lfZA+aQ0843Df3tGPAqtL39ko7kSyh1RXD5llta0=;
  b=gIUTJAHT8pYmKUKDVtcD6reUNlx5ToAbXFXK1WyDgYoJ5VZUgZtnaj9y
   qM5XVSMr5umzA1Zxs4DRoonb6KVDGHn8hfWiJpXGNqVJ4RySXEYn6nkCc
   Vgk1pTKyjdPxafAzVhqXzJTtTknVsussVvdDJCzBJP6LSYohSLvd5Sour
   RqhsNo7Ny4VDdWJ89ueDRsBgvdMM1oIyfu76yakXpuDcPMhlnkbWa7qsh
   eS5a7OYl6ekEoSPx4CMBXxGPUBHtT5d3eeGVmX7eGXajDRpizDZUZv8ob
   Cb6UtXjyd8qVNDziJRBzhcCAHlJb8ltGcxOmprh/zpYJtjjq6sJNt6RhR
   A==;
X-CSE-ConnectionGUID: qhk59zk6Qk+tYSEF9RyxWA==
X-CSE-MsgGUID: 8eXlQ8z/QlCmTKeHMieOEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="81364044"
X-IronPort-AV: E=Sophos;i="6.21,232,1763452800"; 
   d="scan'208";a="81364044"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 13:50:24 -0800
X-CSE-ConnectionGUID: r5r5+870SVCDJ7FJTvTdHQ==
X-CSE-MsgGUID: E9W7NGEuSz+w07Dgnd4ssw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,232,1763452800"; 
   d="scan'208";a="210357911"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 16 Jan 2026 13:50:22 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgrhz-00000000LHY-3kZt;
	Fri, 16 Jan 2026 21:50:19 +0000
Date: Sat, 17 Jan 2026 05:49:37 +0800
From: kernel test robot <lkp@intel.com>
To: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 3/3] Bluetooth: btintel: Remove unneeded CONFIG_PM*
 #ifdef's
Message-ID: <202601170613.lx6wk4st-lkp@intel.com>
References: <20260116125803.598552-4-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116125803.598552-4-hadess@hadess.net>

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
patch link:    https://lore.kernel.org/r/20260116125803.598552-4-hadess%40hadess.net
patch subject: [PATCH 3/3] Bluetooth: btintel: Remove unneeded CONFIG_PM* #ifdef's
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20260117/202601170613.lx6wk4st-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260117/202601170613.lx6wk4st-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601170613.lx6wk4st-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/bluetooth/hci_intel.c:1101:12: warning: 'intel_resume' defined but not used [-Wunused-function]
    1101 | static int intel_resume(struct device *dev)
         |            ^~~~~~~~~~~~
>> drivers/bluetooth/hci_intel.c:1091:12: warning: 'intel_suspend' defined but not used [-Wunused-function]
    1091 | static int intel_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~


vim +/intel_resume +1101 drivers/bluetooth/hci_intel.c

aa6802df09fe32 Loic Poulain 2015-09-02  1090  
f755247379912f Loic Poulain 2015-09-09 @1091  static int intel_suspend(struct device *dev)
f755247379912f Loic Poulain 2015-09-09  1092  {
f755247379912f Loic Poulain 2015-09-09  1093  	struct intel_device *idev = dev_get_drvdata(dev);
f755247379912f Loic Poulain 2015-09-09  1094  
f755247379912f Loic Poulain 2015-09-09  1095  	if (device_may_wakeup(dev))
f755247379912f Loic Poulain 2015-09-09  1096  		enable_irq_wake(idev->irq);
f755247379912f Loic Poulain 2015-09-09  1097  
f755247379912f Loic Poulain 2015-09-09  1098  	return intel_suspend_device(dev);
f755247379912f Loic Poulain 2015-09-09  1099  }
f755247379912f Loic Poulain 2015-09-09  1100  
f755247379912f Loic Poulain 2015-09-09 @1101  static int intel_resume(struct device *dev)
f755247379912f Loic Poulain 2015-09-09  1102  {
f755247379912f Loic Poulain 2015-09-09  1103  	struct intel_device *idev = dev_get_drvdata(dev);
f755247379912f Loic Poulain 2015-09-09  1104  
f755247379912f Loic Poulain 2015-09-09  1105  	if (device_may_wakeup(dev))
f755247379912f Loic Poulain 2015-09-09  1106  		disable_irq_wake(idev->irq);
f755247379912f Loic Poulain 2015-09-09  1107  
f755247379912f Loic Poulain 2015-09-09  1108  	return intel_resume_device(dev);
f755247379912f Loic Poulain 2015-09-09  1109  }
f755247379912f Loic Poulain 2015-09-09  1110  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
