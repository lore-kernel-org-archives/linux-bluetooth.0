Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A7BD271
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 19:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715888637; cv=none; b=lMccsE8xEj6UWI/zSmlpfk0CvAoUSPw5fwfIjUeij/LOvaVvRb8aRHaf/jEebm2rHQp3b/Rcqqi/9GNWe/AuzWAN5ame80qVS0t+qxXT4NHsge+66mrNH7aoCcCrv4lb0uIJm8EFweYHdIYPVgVfJIGCE+f1EtzTab3ARaPHZ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715888637; c=relaxed/simple;
	bh=LTfmtFCBmSRqcn56AbASH2+mF4i4przll0JQpuKsY54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJjTatAD08PxeD99ZVs/5O8g+rQqhN+hSy2s6Pibq2pVn4g/pvyhagfXnw33kBc1kfJ8Q5Au63lGszEQx2E2b3mDRXderEZXCwgGYWabn/LQHZ1TN6/IQucKcd9bXT60OQGtJC/T02DbDyEbDxoZjMLGaN0oUAr/BHuz8jb5qTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XvCjf065; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XvCjf065"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715888635; x=1747424635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LTfmtFCBmSRqcn56AbASH2+mF4i4przll0JQpuKsY54=;
  b=XvCjf065y3dKEQfxv68JydALIs9wxOQjRqNxf31H2cmGz/DgomziOBLz
   804CxA49V8pgKcx3Bge60Sunw5BCdHCl2gD41eqHbR/rQKpxJFegFhQ8L
   F/aZf2nBSEw1YpyId+7Lg6vh1dD8yg/uCYSX9E115qdXF4RmPK6O/zrc5
   NrTh9ouXeA408u6wmALSe2pT73Tj8db+jLHDIjFIJdYLj7DG6YAxK2VFo
   viTxCYEOG27DNc857/pAGB34CrFmHD0hu8TDWw0J7iqeZkvkzxvPF0x5s
   WfvulRpG0V+CicnWlTsaFpk6ndbOWL3ISZpjrt4P1FTYlvNzIeYmzHpW1
   w==;
X-CSE-ConnectionGUID: ht0+h4qfSm68VD5Y+Z935w==
X-CSE-MsgGUID: X7wYKK9gSMyZsvP4vSiqFw==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15858935"
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="15858935"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 12:43:55 -0700
X-CSE-ConnectionGUID: N8RlK2NwQdSvKxX9nTJQQw==
X-CSE-MsgGUID: fZ8FPP/gTx6K77oLl2ghIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="62369706"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 16 May 2024 12:43:53 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7h14-000Ei5-2B;
	Thu, 16 May 2024 19:43:50 +0000
Date: Fri, 17 May 2024 03:43:10 +0800
From: kernel test robot <lkp@intel.com>
To: Nobuaki.Tsunashima@infineon.com, marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Patch for CYW4373 hci up fail issue
Message-ID: <202405170330.QEHgPNm1-lkp@intel.com>
References: <6267800d70ae4344acaba3486b54bc0c@infineon.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6267800d70ae4344acaba3486b54bc0c@infineon.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on bluetooth-next/master linus/master v6.9 next-20240516]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nobuaki-Tsunashima-infineon-com/Bluetooth-Patch-for-CYW4373-hci-up-fail-issue/20240516-131000
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/6267800d70ae4344acaba3486b54bc0c%40infineon.com
patch subject: [PATCH] Bluetooth: Patch for CYW4373 hci up fail issue
config: arm-pxa_defconfig (https://download.01.org/0day-ci/archive/20240517/202405170330.QEHgPNm1-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240517/202405170330.QEHgPNm1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405170330.QEHgPNm1-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/bluetooth/btbcm.c: In function 'btbcm_is_disable_broken_read_tx_power_by_chip_ver':
>> drivers/bluetooth/btbcm.c:453:48: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     453 |         struct bcm_chip_version_table *entry = &disable_broken_read_transmit_power_by_chip_ver[0];
         |                                                ^


vim +/const +453 drivers/bluetooth/btbcm.c

   440	
   441	struct bcm_chip_version_table {
   442		u8	chip_id;
   443		u16 baseline;
   444	};
   445	#define BCM_ROMFW_BASELINE_NUM	0xFFFF
   446	static const struct bcm_chip_version_table disable_broken_read_transmit_power_by_chip_ver[] = {
   447		{0x87, BCM_ROMFW_BASELINE_NUM}		/* CYW4373/4373E */
   448	};
   449	static bool btbcm_is_disable_broken_read_tx_power_by_chip_ver(u8 chip_id, u16 baseline)
   450	{
   451		int i;
   452		int table_size = sizeof(disable_broken_read_transmit_power_by_chip_ver)/sizeof(disable_broken_read_transmit_power_by_chip_ver[0]);
 > 453		struct bcm_chip_version_table *entry = &disable_broken_read_transmit_power_by_chip_ver[0];
   454	
   455		for( i=0 ; i<table_size ; i++, entry++)
   456		{
   457			if( (chip_id == entry->chip_id) && (baseline == entry->baseline) )
   458				return true;
   459		}
   460	
   461		return false;
   462	}
   463	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
