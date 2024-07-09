Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2CE1B86D4
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 21:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720561491; cv=none; b=qTB3LSxIlZPCM+5n4BNJFtlTeQPnsVwxQk94dThEItTwewK3a3HngfbTZfo+FvIzzzedRXXNAyV7Sp0QAe5v1oFhbghtCPxo5gQHUF3vPtIdlUpLeMSS4ARMroMB2DsriTPUTDZ2y7HC+MlMYAwyYvkf+yBI+ACjmT66Du01cYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720561491; c=relaxed/simple;
	bh=63izeCz53G078iWXEXL7eFAOgiVSv0mEufcjVf+3teg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hJBB819//t+bmwxPqdk0z2BlTa8XwRVOgSddg9GVZslU1XoEGZoz+GXepFfMDaXJM/qA7oKh1KP3XUOA6I1Z4iZs0c7gfTw2gVQsm+rRg2ge8TERv3FwnrIXt/3PCL0z/E+9fEV04wGB5Q486eMunf2LUjJSA6AGL/MOaAbjY+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JkXwipeu; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JkXwipeu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720561490; x=1752097490;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=63izeCz53G078iWXEXL7eFAOgiVSv0mEufcjVf+3teg=;
  b=JkXwipeu1bgLNnjDcO3Ru136Sxj+EuXgBNau0S3xETuid3CxI3whcQM9
   87I5jcgf4/5GE7T2BhCTBp9s+3AxBQ+6qVag5gar7q8SwuLN8mAvYhli8
   DVM3q11XL8+ITNzPGu6OpauDR573ZrpQ7wPpDow2ay1Sk9Ca015iw5+w+
   hqw5aBt6CRPTEH4eaErOK83A+lXJRTfOlfEC85xSeBPBb+EK4zhb9Z38C
   7/rt9MG+0MmGZ39Bu9PnPgis2uHHN3G3wYdXM6uV+1anKUGyTmVwNC2Fy
   MAU/IIiDrSJGrLhL1NQtjx8AveOTmadq/aisFQRVlJ5aPCYxrdRhJpsy5
   g==;
X-CSE-ConnectionGUID: L7g9lpz2SfqFK45HBKF0RA==
X-CSE-MsgGUID: QuaZs4+1T0KIIQQ0zhHJuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="21619296"
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="21619296"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 14:44:31 -0700
X-CSE-ConnectionGUID: bt27X9HKQAWpWt4KeuNtEQ==
X-CSE-MsgGUID: /dYkPFVIQ6CuMUFbFksp3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="79149867"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 09 Jul 2024 14:44:29 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRIdP-000X8w-10;
	Tue, 09 Jul 2024 21:44:27 +0000
Date: Wed, 10 Jul 2024 05:44:21 +0800
From: kernel test robot <lkp@intel.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [bluetooth-next:master 76/76] drivers/bluetooth/btnxpuart.c:1534:12:
 warning: 'nxp_serdev_resume' defined but not used
Message-ID: <202407100518.06Xxq5PK-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   c6052c312e85011cd31237804900013f63420403
commit: c6052c312e85011cd31237804900013f63420403 [76/76] Bluetooth: btnxpuart: Add system suspend and resume handlers
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240710/202407100518.06Xxq5PK-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240710/202407100518.06Xxq5PK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407100518.06Xxq5PK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/bluetooth/btnxpuart.c:1534:12: warning: 'nxp_serdev_resume' defined but not used [-Wunused-function]
    1534 | static int nxp_serdev_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~
>> drivers/bluetooth/btnxpuart.c:1525:12: warning: 'nxp_serdev_suspend' defined but not used [-Wunused-function]
    1525 | static int nxp_serdev_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~


vim +/nxp_serdev_resume +1534 drivers/bluetooth/btnxpuart.c

  1524	
> 1525	static int nxp_serdev_suspend(struct device *dev)
  1526	{
  1527		struct btnxpuart_dev *nxpdev = dev_get_drvdata(dev);
  1528		struct ps_data *psdata = &nxpdev->psdata;
  1529	
  1530		ps_control(psdata->hdev, PS_STATE_SLEEP);
  1531		return 0;
  1532	}
  1533	
> 1534	static int nxp_serdev_resume(struct device *dev)
  1535	{
  1536		struct btnxpuart_dev *nxpdev = dev_get_drvdata(dev);
  1537		struct ps_data *psdata = &nxpdev->psdata;
  1538	
  1539		ps_control(psdata->hdev, PS_STATE_AWAKE);
  1540		return 0;
  1541	}
  1542	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
