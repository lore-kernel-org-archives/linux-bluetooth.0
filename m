Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF4328E11
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 23:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715901768; cv=none; b=hOfzCCKzSzwLm9StBnYAE8Mp98bbN30g5m79TPT2TzXwsRFV91XqKI+kHlot3Qo2sSs6/btNFj/2LC1zlWkO0oDBDD9JneHmLNneezSTtHMdG7PaFu3G/rXvoV36ENmS3toWU16QGYwQjxxbqaM2MIlGaXWHMkB3Yoz0iKQq0bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715901768; c=relaxed/simple;
	bh=G+Cs4U2ifijWaGMbXgbT9LXR6f7giXlLhHfrKpLRDNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qw8sE7Wqb+Mp3O1koEGQAKyVkpI/4pR/23tSkfRemD4jAZLMdsBfMrpu2QlkZwLRojAG/EcuF36Fg/SIHHWAnUmEq8lS1dDyDMXs+FVKCypM4aGM/m+WwvKLpTiiSmcM5yNE3n21qFwMtja89pW87+tlR5fz+8RWTC6EB+82uro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FrampAEF; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FrampAEF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715901765; x=1747437765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G+Cs4U2ifijWaGMbXgbT9LXR6f7giXlLhHfrKpLRDNY=;
  b=FrampAEFr2k34qsyzM/ivUG3GdE7GLX3PCscq45K+bHj6WoRlcUFcvb0
   wAwADFCZSQ2knxRj46610haYUuSLR215tdAS/VIx1Cm0xcMgHhNpTcVuy
   aofN2X5H5rnDaE1NkCvH4VLSd0jZNIH++eEXceJ8LHS4rDIxlz/wHLKYn
   GdtNFbPebHLkwSOiRmiRIy+OMfrQHrUrXP/qMq0NqnL45lhnw7D0iVHEe
   7WTOH0V6rkIkBRyZCnuqQbGCqxNz3SN4roLf5KleMRAslXg+KSVxvwri0
   NcybT+v206fOBhISosz+mzJawiZ+ebj3WDKz8KOJQ/yQqsPE5Z+qrtodj
   Q==;
X-CSE-ConnectionGUID: xUsS+2dEQt6qhsxHmLhhFA==
X-CSE-MsgGUID: YtffSWsiT/OfGJaz0lqNpA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15881318"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="15881318"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 16:22:45 -0700
X-CSE-ConnectionGUID: x5KInBcMQBO0jb4NwJuX1A==
X-CSE-MsgGUID: OC9ARInGR7mS+lAvK6faEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="36385389"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 16 May 2024 16:22:43 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7kQq-000Eyb-2i;
	Thu, 16 May 2024 23:22:40 +0000
Date: Fri, 17 May 2024 07:22:05 +0800
From: kernel test robot <lkp@intel.com>
To: Nobuaki.Tsunashima@infineon.com, marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Patch for CYW4373 hci up fail issue
Message-ID: <202405170648.10OEk1LW-lkp@intel.com>
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
config: i386-randconfig-062-20240517 (https://download.01.org/0day-ci/archive/20240517/202405170648.10OEk1LW-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240517/202405170648.10OEk1LW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405170648.10OEk1LW-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/bluetooth/btbcm.c:453:95: sparse: sparse: incorrect type in initializer (different modifiers) @@     expected struct bcm_chip_version_table *entry @@     got struct bcm_chip_version_table const * @@
   drivers/bluetooth/btbcm.c:453:95: sparse:     expected struct bcm_chip_version_table *entry
   drivers/bluetooth/btbcm.c:453:95: sparse:     got struct bcm_chip_version_table const *

vim +453 drivers/bluetooth/btbcm.c

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
