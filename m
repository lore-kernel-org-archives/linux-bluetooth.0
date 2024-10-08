Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93A218FDB7;
	Tue,  8 Oct 2024 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728375108; cv=none; b=FuMFmR+dpfEiegvQWeKRdmJBxlFjDUUbwMfhZFH80MoU1uDDxcd/2tlH9dzWeMPiTgfQJIjTRIli2WgDvNYmbbomJKl8taKmvdzEkYIFrMvdlfPaZzAqAbdCfgt4wPZZwRnw/f+5xUJAgV5yourfV3B6tV6PWgUPK1MVmBHLuQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728375108; c=relaxed/simple;
	bh=F2qXz/WIke5JYnywjFUODNGIhgeCaMbp2Q2K3tt5jV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oc33lXzUdtJIPfgTo2KPCsv5zfVeRB5z2pYAaq8oXVl8VC8WRPUvF0vm7N411Vm3hwVFPFcKJS75ZXJqc4mOnfQKmyYudrzIL3Zg6eLExZPFLoZfWzyWtouQ1gh1mLaLTp54xGIm2YvfhVQPQNqdp5ZyG4gLeH3LQzEyx8hwXjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gSNNk7u8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gSNNk7u8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728375107; x=1759911107;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F2qXz/WIke5JYnywjFUODNGIhgeCaMbp2Q2K3tt5jV4=;
  b=gSNNk7u8Dvg2Jiu1Ofkh5rIjKoeIZbGanM5p4VeqqpdGc14aQvUSzAba
   mOpssGMJBFkwy4DvXDvs7yQcixaQneYvSjeBNaUIlqiSWO/CWXCwKFwzI
   uGefd35nImdOVq9kS4dMuF6JsOeHIZPDsBmqHqOuCXJQUl4Wzi93aQfd2
   7yusAaaBKRR6xcvgYZNx7LqNqAkyGzCxTYW83NrJU1Wjb0MfUjSAef3fZ
   eLZKVr0VK8H3QK/kKyfm1GGaUmyulXXEbzDEJsz59MnRNAid6dqxM355R
   6AF0nvbM8IPpTIB8sNqi16Go986VQLZN4eRnqG0nr6heQBSDwvqXtcCsU
   w==;
X-CSE-ConnectionGUID: Utiik9s6Te+wDIkgwVPRdQ==
X-CSE-MsgGUID: eE0QZbvrS2u5eU9cOzCClA==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27498958"
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208";a="27498958"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 01:11:47 -0700
X-CSE-ConnectionGUID: OrSDAzvoT/i4qIU6uBYKaw==
X-CSE-MsgGUID: NEZ6dFjtRTCip3sFf84OVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208";a="75729498"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 08 Oct 2024 01:11:43 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sy5Jk-00064q-0Z;
	Tue, 08 Oct 2024 08:11:40 +0000
Date: Tue, 8 Oct 2024 16:11:12 +0800
From: kernel test robot <lkp@intel.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, marcel@holtmann.org,
	luiz.dentz@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	amitkumar.karwar@nxp.com, rohit.fule@nxp.com,
	neeraj.sanjaykale@nxp.com, sherry.sun@nxp.com, ziniu.wang_1@nxp.com,
	haibo.chen@nxp.com, LnxRevLi@nxp.com
Subject: Re: [PATCH v4 2/2] Bluetooth: btnxpuart: Add GPIO support to power
 save feature
Message-ID: <202410081516.Mt35mvJk-lkp@intel.com>
References: <20241007131316.626690-3-neeraj.sanjaykale@nxp.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007131316.626690-3-neeraj.sanjaykale@nxp.com>

Hi Neeraj,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth/master]
[also build test ERROR on bluetooth-next/master robh/for-next linus/master v6.12-rc2 next-20241004]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Neeraj-Sanjay-Kale/dt-bindings-net-bluetooth-nxp-Add-support-for-power-save-feature-using-GPIO/20241007-211315
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20241007131316.626690-3-neeraj.sanjaykale%40nxp.com
patch subject: [PATCH v4 2/2] Bluetooth: btnxpuart: Add GPIO support to power save feature
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20241008/202410081516.Mt35mvJk-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241008/202410081516.Mt35mvJk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410081516.Mt35mvJk-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/bluetooth/btnxpuart.c:21:
   drivers/bluetooth/btnxpuart.c: In function 'ps_setup':
>> drivers/bluetooth/btnxpuart.c:445:28: error: expected ')' before 'PTR_ERR'
     445 |                            PTR_ERR(psdata->h2c_ps_gpio));
         |                            ^~~~~~~
   include/net/bluetooth/bluetooth.h:263:40: note: in definition of macro 'BT_ERR'
     263 | #define BT_ERR(fmt, ...)        bt_err(fmt "\n", ##__VA_ARGS__)
         |                                        ^~~
   drivers/bluetooth/btnxpuart.c:444:17: note: in expansion of macro 'bt_dev_err'
     444 |                 bt_dev_err(hdev, "Error fetching device-wakeup-gpios: %ld"
         |                 ^~~~~~~~~~
   include/net/bluetooth/bluetooth.h:263:39: note: to match this '('
     263 | #define BT_ERR(fmt, ...)        bt_err(fmt "\n", ##__VA_ARGS__)
         |                                       ^
   include/net/bluetooth/bluetooth.h:278:9: note: in expansion of macro 'BT_ERR'
     278 |         BT_ERR("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
         |         ^~~~~~
   drivers/bluetooth/btnxpuart.c:444:17: note: in expansion of macro 'bt_dev_err'
     444 |                 bt_dev_err(hdev, "Error fetching device-wakeup-gpios: %ld"
         |                 ^~~~~~~~~~
>> include/net/bluetooth/bluetooth.h:278:16: warning: format '%s' expects a matching 'char *' argument [-Wformat=]
     278 |         BT_ERR("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
         |                ^~~~~~
   include/net/bluetooth/bluetooth.h:263:40: note: in definition of macro 'BT_ERR'
     263 | #define BT_ERR(fmt, ...)        bt_err(fmt "\n", ##__VA_ARGS__)
         |                                        ^~~
   drivers/bluetooth/btnxpuart.c:444:17: note: in expansion of macro 'bt_dev_err'
     444 |                 bt_dev_err(hdev, "Error fetching device-wakeup-gpios: %ld"
         |                 ^~~~~~~~~~
   include/net/bluetooth/bluetooth.h:278:18: note: format string is defined here
     278 |         BT_ERR("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
         |                 ~^
         |                  |
         |                  char *
>> include/net/bluetooth/bluetooth.h:278:16: warning: format '%ld' expects a matching 'long int' argument [-Wformat=]
     278 |         BT_ERR("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
         |                ^~~~~~
   include/net/bluetooth/bluetooth.h:263:40: note: in definition of macro 'BT_ERR'
     263 | #define BT_ERR(fmt, ...)        bt_err(fmt "\n", ##__VA_ARGS__)
         |                                        ^~~
   drivers/bluetooth/btnxpuart.c:444:17: note: in expansion of macro 'bt_dev_err'
     444 |                 bt_dev_err(hdev, "Error fetching device-wakeup-gpios: %ld"
         |                 ^~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +445 drivers/bluetooth/btnxpuart.c

   434	
   435	static int ps_setup(struct hci_dev *hdev)
   436	{
   437		struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
   438		struct serdev_device *serdev = nxpdev->serdev;
   439		struct ps_data *psdata = &nxpdev->psdata;
   440	
   441		psdata->h2c_ps_gpio = devm_gpiod_get_optional(&serdev->dev, "device-wakeup",
   442							      GPIOD_OUT_LOW);
   443		if (IS_ERR(psdata->h2c_ps_gpio)) {
   444			bt_dev_err(hdev, "Error fetching device-wakeup-gpios: %ld"
 > 445				   PTR_ERR(psdata->h2c_ps_gpio));
   446			return PTR_ERR(psdata->h2c_ps_gpio);
   447		}
   448	
   449		if (!psdata->h2c_ps_gpio)
   450			psdata->h2c_wakeup_gpio = 0xff;
   451	
   452		psdata->hdev = hdev;
   453		INIT_WORK(&psdata->work, ps_work_func);
   454		mutex_init(&psdata->ps_lock);
   455		timer_setup(&psdata->ps_timer, ps_timeout_func, 0);
   456	
   457		return 0;
   458	}
   459	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
