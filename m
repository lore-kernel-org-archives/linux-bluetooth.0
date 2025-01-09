Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EF8204C39
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jan 2025 21:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736459369; cv=none; b=jT9T/HYNFNW1OhOGzPm+i7IcsXKrpE6qzkzOkwJt/kgaSNY00RpPTCJ0o5zR7dTKCYhFrYs/cesuuLYTnKq33/FL8RbdXj8rtb2RMbMvvmkTdsjgsYR5FxhHcImTAIO3/EFFmJTnTWqsARvxTyaIC9Lpj178P8J9p3QOL/yxppI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736459369; c=relaxed/simple;
	bh=lzmIzp15rqpbqUvRfX4xeqxPtuZK0HAQPnNDbvBK+I0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XLsgHiU01UMm/i9bR2kjKihdmOmn2Bw8hlHegbeDLQWGxY6d6UWIZiuYvo2jWRXySWf3vQX2vNQRz660ww8Vdp2g+W67qND+1CGtsejGGskdeAtvIcOxGUbNB1sUc3t834c9PbYfXuWufeHNZl5KvQBr0owvOBU1bSS6hTrwhak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FIHhGwPx; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FIHhGwPx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736459368; x=1767995368;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lzmIzp15rqpbqUvRfX4xeqxPtuZK0HAQPnNDbvBK+I0=;
  b=FIHhGwPxzbN7gj8FpFk877wueI+VAhV7NHAPrOEEI0dz89bdaMKUf+Ds
   fB/U+CV90fEfF8ZSPQK5jjIfbQVlYfYXBEn4Gq89KQQW5czrARMItv5AM
   5IiiDSPNTLnGy/dRY9G9yMrBUwKKBbEFSFJH7GjcMU9HoG89VRC1K1cmM
   SdWuLNL0G8w85DDWLYfQ+1bzVm8Tk0ATdqcpaeN14AVTNeWIYveoCBJXM
   P7OzOjWj54Wi4c9FSlY3YsDP3BFmgdhVCDydyIo2hfesXHfbrj5OZwSq7
   FLH5Qa3QvUjIkBAXmUW/DO5U7yaYVD8dGrRePMuZc7JllKTX2tU0vxoeg
   A==;
X-CSE-ConnectionGUID: HNxwfGDHQCCejdaF14u0Ig==
X-CSE-MsgGUID: fuyXtVxtSAee0k6GwMCoFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="40423011"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="40423011"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 13:49:28 -0800
X-CSE-ConnectionGUID: n5wy8IETQm2eoaXz7hPvzw==
X-CSE-MsgGUID: y9qK0aaCTwmDXhdXw/au6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="103338833"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 09 Jan 2025 13:49:26 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tW0P5-000IAt-2g;
	Thu, 09 Jan 2025 21:49:23 +0000
Date: Fri, 10 Jan 2025 05:48:55 +0800
From: kernel test robot <lkp@intel.com>
To: Charles Han <hanchunchao@inspur.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [bluetooth-next:master 78/83] drivers/bluetooth/btbcm.c:557:24:
 error: returning 'int' from a function with return type 'const char *' makes
 pointer from integer without a cast
Message-ID: <202501100509.YVUpfNCG-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   a5d2ee08adc1d98647679c4e4c73223464d5d936
commit: 52d2af10759262ab95162ddc1a56faa8fe3aabde [78/83] Bluetooth: btbcm: Fix NULL deref in btbcm_get_board_name()
config: sparc-randconfig-001-20250110 (https://download.01.org/0day-ci/archive/20250110/202501100509.YVUpfNCG-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250110/202501100509.YVUpfNCG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501100509.YVUpfNCG-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/bluetooth/btbcm.c: In function 'btbcm_get_board_name':
>> drivers/bluetooth/btbcm.c:557:24: error: returning 'int' from a function with return type 'const char *' makes pointer from integer without a cast [-Wint-conversion]
     557 |                 return -ENOMEM;
         |                        ^


vim +557 drivers/bluetooth/btbcm.c

   536	
   537	/*
   538	 * This currently only looks up the device tree board appendix,
   539	 * but can be expanded to other mechanisms.
   540	 */
   541	static const char *btbcm_get_board_name(struct device *dev)
   542	{
   543	#ifdef CONFIG_OF
   544		struct device_node *root __free(device_node) = of_find_node_by_path("/");
   545		char *board_type;
   546		const char *tmp;
   547	
   548		if (!root)
   549			return NULL;
   550	
   551		if (of_property_read_string_index(root, "compatible", 0, &tmp))
   552			return NULL;
   553	
   554		/* get rid of any '/' in the compatible string */
   555		board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);
   556		if (!board_type)
 > 557			return -ENOMEM;
   558	
   559		strreplace(board_type, '/', '-');
   560	
   561		return board_type;
   562	#else
   563		return NULL;
   564	#endif
   565	}
   566	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
