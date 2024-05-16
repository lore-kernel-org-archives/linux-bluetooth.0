Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4231B1514D6
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 20:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715893092; cv=none; b=Hlbohi7T+sKljO50kjiit5Ga7tYnWz962eDAUgqzHahkr+xf/fN/6Zop4j4KbzQO40M0AlLRSTEE9zgzILucOYTpRrko7ROhMAM6qseXN2xKfrhOiWXinycsp8l59kTiPcSTxNdHD0uPzvgGh0ctxYex3TgcWT/tDpy7GWt6FNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715893092; c=relaxed/simple;
	bh=ctWB/dFDLpYDVoZ2Jy6AFmL4gx6JFcg93o7Aw7dtoqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6OzaSCPwIwy8WQWk6TQQ/498w6wUrInNDPCf7xZLKyKEPwZC3NxD0cuEy8NxS1YJE/RRuDjAi61slIfvy2m9LL1uXPGq80m/4+t9oPh1LHDqI1bITsw5fnLDb9q26IiJAmxhP+DncU38F+pCsvjtV3ZkqXY6HOhLqlCUnUR3CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xrap/Q+u; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xrap/Q+u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715893091; x=1747429091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ctWB/dFDLpYDVoZ2Jy6AFmL4gx6JFcg93o7Aw7dtoqs=;
  b=Xrap/Q+uk5wJbJG7jTD/9KvahnsGhgzBANwZUedqZtHRLIpKb9asOke6
   6WwBRO8xDIo0FVlMqXHPRZHmimqNuNBCH86J1SG1dpO+d3RRqMRuAfKAA
   NOg4nqRdjOC4xWauBg3wNinQX2VY0TtHoIzk4J2hXjhQHtyl88lsEAtfE
   7EvuKTlVcuCb+JYHCcrzGfqT9WCXhem3sCleeFeMceBckW6D7Mvo6UUvu
   uhTp+EvL65rN4xO9Y9dykccGkeIg6k7nwd1luzn2gq6l4QYnD8Kzl/JlJ
   a449mbz/Svy2XZCogQu5XB9EtiJP2MzfhpqXMyWy4gM9mG35yi6/j+9b6
   w==;
X-CSE-ConnectionGUID: Aj+SwSA/To28mVBcF3hc1g==
X-CSE-MsgGUID: XcB1mFkkQA6gL+8gpliUMQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11890976"
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="11890976"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 13:58:11 -0700
X-CSE-ConnectionGUID: GdxwgKv7RJ2AMMyvEVt5dQ==
X-CSE-MsgGUID: 6KluEpYARt+n2hgkZHdDqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="31687972"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 16 May 2024 13:58:09 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7iAw-000Emn-26;
	Thu, 16 May 2024 20:58:06 +0000
Date: Fri, 17 May 2024 04:57:55 +0800
From: kernel test robot <lkp@intel.com>
To: Nobuaki.Tsunashima@infineon.com, marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Patch for CYW4373 hci up fail issue
Message-ID: <202405170433.qYUNBTtS-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth/master]
[also build test ERROR on bluetooth-next/master linus/master v6.9 next-20240516]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nobuaki-Tsunashima-infineon-com/Bluetooth-Patch-for-CYW4373-hci-up-fail-issue/20240516-131000
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/6267800d70ae4344acaba3486b54bc0c%40infineon.com
patch subject: [PATCH] Bluetooth: Patch for CYW4373 hci up fail issue
config: x86_64-buildonly-randconfig-003-20240517 (https://download.01.org/0day-ci/archive/20240517/202405170433.qYUNBTtS-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240517/202405170433.qYUNBTtS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405170433.qYUNBTtS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/bluetooth/btbcm.c:453:33: error: initializing 'struct bcm_chip_version_table *' with an expression of type 'const struct bcm_chip_version_table *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     453 |         struct bcm_chip_version_table *entry = &disable_broken_read_transmit_power_by_chip_ver[0];
         |                                        ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


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
