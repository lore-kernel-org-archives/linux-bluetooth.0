Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795466739;
	b=bk8D4hW0due3T/lTm5MdsJ857Fvt07gSv/icJlm2evIEgVTP4aN7qNgGz7KeTp3Q8LFf
	 PgbGpbU0qZOFUnzRwxEy12J3HQ3qpb761H+F5dgmcD/kh2hte0t5VZko3p9vHHuCHZUsK
	 2CNJUxHZv6cz89UqEC1xUm70VvYL4mQYqVQ7XLd/Dm0crzXJWTj8K7Pw/Ap9zgwAIuDnH
	 Jn+NyjXE40AYEtdmIkKAJkZcFBj2FK/4S4dmMjpW8FLyln4HutQyDJGqoFT82YkOOtKtB
	 QkyyhbDhicC9Dvy1KhHqJR7Avrtaf5YmXcxqbT8fqnQ0eXVdY1Z/EAcIQwbJq+9d7Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795466739;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=0VnDzB9Agb8Amuz7dt6dADKRSDTSttYnUxwg1T6681U=;
	b=JXl6mJILGGPXr3tfkZg3ebw6aS5x2DHawBcNkPUsHU0Iv+41JL0htZ2/QrHKpUMJzJhv
	 cD8VVkCVLj2fNJ34sP97KFX2JxxI8VUbGxQG+AnyQ2yObY2vsvzvUKhXUnVm3HmT2pT8J
	 gdDByMYJq7HbUS3saD4IIFWZiEQkTu0IFACeNeRh4kEMPvcFhEJ1k9m834a0VjIIsnmFm
	 Cj9cFQqa8DEbWYPiuPZklUC2Dqj764f43v/SYbjkSNyvXiNSmv/Ph8QMHQPP6WXf5oyOY
	 sg1aRUX7BytN48/05bLKsAfKzjS8VLuLnJydzVNAez/yfDZPDBjhkqviodGShxD/0/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XfV8i5uv;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88308606A332
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 20:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88308606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XfV8i5uv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795466738; x=1827002738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6gkWUv1slhnM9aD8OpSgfBPXiR4hMfiYjKQsCunZYD4=;
  b=XfV8i5uvFhDohw+fUS9AtTSPNMzX5Ccz67muWPGBKWl/EYVmQPcwApr1
   GAK926F54ARJdS9B+doUIxk79pg7MSDolRRhYzXU+KEJ+YKJPVCLvVlOV
   KmB1DwsMbrDKJfJtyX3G/+uDeRmRLR/AomqCRSqS3rlxO6Ph9UavF4VCW
   Nl4QLsxxu8Eg+DoLzB1CGKvJyJfgj8UKgcrfhYRck92vzqs+5pM+Whf6a
   88MjDkuTfHaXMQuVJv0jO1lqt60Pjkhz3KXs4gzMD7af+xHX2s1JI/4Wt
   13nhUl4zeMqF9NqLzaEAFGOm7b9bQxXn38jeyHvBEsSQZNX4PPBmkq1Y6
   A==;
X-CSE-ConnectionGUID: igkvP13tTNCHbsF2CLxyYg==
X-CSE-MsgGUID: R6QH+C1wScSwDEqa/yCbiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4187729"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4187729"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 12:45:38 -0800
X-CSE-ConnectionGUID: mCaRPCwpTKOwjvUalQD94w==
X-CSE-MsgGUID: mZD1cFO1RVCe0x5lHz0ZkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="13182741"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa011.fm.intel.com with ESMTP; 23 Nov 2026 12:45:36 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xVaur-00000001NtW-1mgr;
	Mon, 23 Nov 2026 20:45:33 +0000
Date: Tue, 24 Nov 2026 04:44:35 +0800
From: kernel test robot <lkp@intel.com>
To: Kiran K <kiran.k@intel.com>, linux-bluetooth@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
	ravindra@intel.com, Kiran K <kiran.k@intel.com>
Subject: Re: [PATCH v1 3/3] Bluetooth: btintel_pcie: Serialize MAC access
 requests
Message-ID: <20261124043547.lzdrjg8w-lkp@intel.com>
References: <20261123065523.2769017-3-kiran.k@intel.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123065523.2769017-3-kiran.k@intel.com>

Hi Kiran,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on next-20261123]
[cannot apply to linus/master v7.4-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kiran-K/Bluetooth-btintel_pcie-Serialize-doorbell-writes-and-target-reads/20261123-122522
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20261123065523.2769017-3-kiran.k%40intel.com
patch subject: [PATCH v1 3/3] Bluetooth: btintel_pcie: Serialize MAC access requests
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20261124/20261124043547.lzdrjg8w-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 2012344e5da8e03ea4b8283ecd6fad6e13f09d64)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261124/20261124043547.lzdrjg8w-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261124043547.lzdrjg8w-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/bluetooth/btintel_pcie.c:1053:12: warning: mutex 'data->mac_access_lock' is not held on every path through here [-Wthread-safety-analysis]
    1053 |                 for (i = 0; i < config_set->num_pairs; i++) {
         |                          ^
   drivers/bluetooth/btintel_pcie.c:1038:4: note: mutex acquired here
    1038 |                         mutex_lock(&data->mac_access_lock);
         |                         ^
   include/linux/mutex.h:193:26: note: expanded from macro 'mutex_lock'
     193 | #define mutex_lock(lock) mutex_lock_nested(lock, 0)
         |                          ^
>> drivers/bluetooth/btintel_pcie.c:1111:4: warning: releasing mutex 'data->mac_access_lock' that was not held [-Wthread-safety-analysis]
    1111 |                         mutex_unlock(&data->mac_access_lock);
         |                         ^
   2 warnings generated.


vim +1053 drivers/bluetooth/btintel_pcie.c

50932a1567d614c Ajaykv  2026-11-11  1000  
68e0925f16c028a Ajaykv  2026-11-11  1001  static void
68e0925f16c028a Ajaykv  2026-11-11  1002  btintel_pcie_apply_yoyo_config_sets(struct btintel_pcie_data *data,
68e0925f16c028a Ajaykv  2026-11-11  1003  				    u32 time_point)
68e0925f16c028a Ajaykv  2026-11-11  1004  {
68e0925f16c028a Ajaykv  2026-11-11  1005  	struct btintel_pcie_yoyo_config_set *config_set;
68e0925f16c028a Ajaykv  2026-11-11  1006  	resource_size_t bar0_len;
68e0925f16c028a Ajaykv  2026-11-11  1007  	int ret;
68e0925f16c028a Ajaykv  2026-11-11  1008  	u32 i;
68e0925f16c028a Ajaykv  2026-11-11  1009  
68e0925f16c028a Ajaykv  2026-11-11  1010  	if (!data)
68e0925f16c028a Ajaykv  2026-11-11  1011  		return;
68e0925f16c028a Ajaykv  2026-11-11  1012  
68e0925f16c028a Ajaykv  2026-11-11  1013  	/* Get the length of PCI BAR0 */
68e0925f16c028a Ajaykv  2026-11-11  1014  	bar0_len = pci_resource_len(data->pdev, 0);
68e0925f16c028a Ajaykv  2026-11-11  1015  
68e0925f16c028a Ajaykv  2026-11-11  1016  	if (!data->yoyo.enabled)
68e0925f16c028a Ajaykv  2026-11-11  1017  		return;
68e0925f16c028a Ajaykv  2026-11-11  1018  
68e0925f16c028a Ajaykv  2026-11-11  1019  	list_for_each_entry(config_set, &data->yoyo.config_set_list, list) {
68e0925f16c028a Ajaykv  2026-11-11  1020  		u32 pair_addr, addr, value;
68e0925f16c028a Ajaykv  2026-11-11  1021  
68e0925f16c028a Ajaykv  2026-11-11  1022  		if (config_set->time_point != time_point)
68e0925f16c028a Ajaykv  2026-11-11  1023  			continue;
68e0925f16c028a Ajaykv  2026-11-11  1024  
68e0925f16c028a Ajaykv  2026-11-11  1025  		switch (config_set->config_set_type) {
68e0925f16c028a Ajaykv  2026-11-11  1026  		case BTINTEL_PCIE_CFGSET_CSR:
68e0925f16c028a Ajaykv  2026-11-11  1027  		case BTINTEL_PCIE_CFGSET_PERIPH_MAC:
68e0925f16c028a Ajaykv  2026-11-11  1028  		case BTINTEL_PCIE_CFGSET_DEVICE_MEM:
68e0925f16c028a Ajaykv  2026-11-11  1029  			break;
68e0925f16c028a Ajaykv  2026-11-11  1030  		default:
68e0925f16c028a Ajaykv  2026-11-11  1031  			BT_WARN("YoYo: unknown/unsupported config_set type %u, skipping",
68e0925f16c028a Ajaykv  2026-11-11  1032  				config_set->config_set_type);
68e0925f16c028a Ajaykv  2026-11-11  1033  			continue;
68e0925f16c028a Ajaykv  2026-11-11  1034  		}
68e0925f16c028a Ajaykv  2026-11-11  1035  
68e0925f16c028a Ajaykv  2026-11-11  1036  		if (config_set->config_set_type == BTINTEL_PCIE_CFGSET_PERIPH_MAC ||
68e0925f16c028a Ajaykv  2026-11-11  1037  		    config_set->config_set_type == BTINTEL_PCIE_CFGSET_DEVICE_MEM) {
1151389a60ccbe5 Kiran K 2026-11-23  1038  			mutex_lock(&data->mac_access_lock);
68e0925f16c028a Ajaykv  2026-11-11  1039  			ret = btintel_pcie_get_mac_access(data);
68e0925f16c028a Ajaykv  2026-11-11  1040  			if (ret) {
68e0925f16c028a Ajaykv  2026-11-11  1041  				BT_WARN("YoYo: MAC access failed for config set (%d), skipping",
68e0925f16c028a Ajaykv  2026-11-11  1042  					ret);
68e0925f16c028a Ajaykv  2026-11-11  1043  				/* get_mac_access() asserts MAC_ACCESS_REQ before it
68e0925f16c028a Ajaykv  2026-11-11  1044  				 * polls, and leaves it set on timeout; drop it so the
68e0925f16c028a Ajaykv  2026-11-11  1045  				 * request bit is not leaked.
68e0925f16c028a Ajaykv  2026-11-11  1046  				 */
68e0925f16c028a Ajaykv  2026-11-11  1047  				btintel_pcie_release_mac_access(data);
1151389a60ccbe5 Kiran K 2026-11-23  1048  				mutex_unlock(&data->mac_access_lock);
68e0925f16c028a Ajaykv  2026-11-11  1049  				continue;
68e0925f16c028a Ajaykv  2026-11-11  1050  			}
68e0925f16c028a Ajaykv  2026-11-11  1051  		}
68e0925f16c028a Ajaykv  2026-11-11  1052  
68e0925f16c028a Ajaykv  2026-11-11 @1053  		for (i = 0; i < config_set->num_pairs; i++) {
68e0925f16c028a Ajaykv  2026-11-11  1054  			pair_addr = get_unaligned_le32(&config_set->pairs[i].address);
68e0925f16c028a Ajaykv  2026-11-11  1055  
68e0925f16c028a Ajaykv  2026-11-11  1056  			/* Calculate the effective address by adding the address offset */
68e0925f16c028a Ajaykv  2026-11-11  1057  			if (check_add_overflow(pair_addr, config_set->addr_offset, &addr)) {
68e0925f16c028a Ajaykv  2026-11-11  1058  				BT_WARN("YoYo: config set address overflow (0x%08x + 0x%08x)",
68e0925f16c028a Ajaykv  2026-11-11  1059  					pair_addr, config_set->addr_offset);
68e0925f16c028a Ajaykv  2026-11-11  1060  				continue;
68e0925f16c028a Ajaykv  2026-11-11  1061  			}
68e0925f16c028a Ajaykv  2026-11-11  1062  
68e0925f16c028a Ajaykv  2026-11-11  1063  			value = get_unaligned_le32(&config_set->pairs[i].value);
68e0925f16c028a Ajaykv  2026-11-11  1064  
68e0925f16c028a Ajaykv  2026-11-11  1065  			switch (config_set->config_set_type) {
68e0925f16c028a Ajaykv  2026-11-11  1066  			/* Direct Address Access (CSR) */
68e0925f16c028a Ajaykv  2026-11-11  1067  			case BTINTEL_PCIE_CFGSET_CSR:
68e0925f16c028a Ajaykv  2026-11-11  1068  				/* Validate the effective address for CSR access (Direct Address)
68e0925f16c028a Ajaykv  2026-11-11  1069  				 * addr not aligned to 4 bytes or exceeds the BAR0 length
68e0925f16c028a Ajaykv  2026-11-11  1070  				 */
68e0925f16c028a Ajaykv  2026-11-11  1071  				if ((addr & (sizeof(u32) - 1)) ||
68e0925f16c028a Ajaykv  2026-11-11  1072  				    bar0_len < sizeof(u32) ||
68e0925f16c028a Ajaykv  2026-11-11  1073  				    addr > bar0_len - sizeof(u32)) {
68e0925f16c028a Ajaykv  2026-11-11  1074  					BT_WARN("YoYo: bad CSR address 0x%08x for BAR0 length %llu",
68e0925f16c028a Ajaykv  2026-11-11  1075  						addr, (unsigned long long)bar0_len);
68e0925f16c028a Ajaykv  2026-11-11  1076  					continue;
68e0925f16c028a Ajaykv  2026-11-11  1077  				}
68e0925f16c028a Ajaykv  2026-11-11  1078  
68e0925f16c028a Ajaykv  2026-11-11  1079  				BT_DBG("YoYo: CSR write [0x%08x] = 0x%08x", addr, value);
6df2b5e2ac4b8a1 Kiran K 2026-11-23  1080  				/* addr may be PRPH_DEV_* or HBUS_TARG_WRPTR */
6df2b5e2ac4b8a1 Kiran K 2026-11-23  1081  				spin_lock(&data->dev_mem_lock);
68e0925f16c028a Ajaykv  2026-11-11  1082  				btintel_pcie_wr_reg32(data, addr, value);
6df2b5e2ac4b8a1 Kiran K 2026-11-23  1083  				spin_unlock(&data->dev_mem_lock);
68e0925f16c028a Ajaykv  2026-11-11  1084  				break;
68e0925f16c028a Ajaykv  2026-11-11  1085  			/* Indirect Address Access (Peripheral MAC and Device Memory) */
68e0925f16c028a Ajaykv  2026-11-11  1086  			case BTINTEL_PCIE_CFGSET_PERIPH_MAC:
68e0925f16c028a Ajaykv  2026-11-11  1087  			case BTINTEL_PCIE_CFGSET_DEVICE_MEM:
68e0925f16c028a Ajaykv  2026-11-11  1088  				/* The config-set TLV comes from an untrusted external file;
68e0925f16c028a Ajaykv  2026-11-11  1089  				 * reject null or unaligned targets.
68e0925f16c028a Ajaykv  2026-11-11  1090  				 */
68e0925f16c028a Ajaykv  2026-11-11  1091  				if (!addr || (addr & (sizeof(u32) - 1))) {
68e0925f16c028a Ajaykv  2026-11-11  1092  					BT_WARN("YoYo: bad indirect address 0x%08x for type %u",
68e0925f16c028a Ajaykv  2026-11-11  1093  						addr, config_set->config_set_type);
68e0925f16c028a Ajaykv  2026-11-11  1094  					continue;
68e0925f16c028a Ajaykv  2026-11-11  1095  				}
68e0925f16c028a Ajaykv  2026-11-11  1096  
6df2b5e2ac4b8a1 Kiran K 2026-11-23  1097  				btintel_pcie_wr_dev_mem(data, addr, value);
68e0925f16c028a Ajaykv  2026-11-11  1098  				BT_DBG("YoYo: indirect write type %u addr 0x%08x value 0x%08x",
68e0925f16c028a Ajaykv  2026-11-11  1099  				       config_set->config_set_type, addr, value);
68e0925f16c028a Ajaykv  2026-11-11  1100  				break;
68e0925f16c028a Ajaykv  2026-11-11  1101  			default:
68e0925f16c028a Ajaykv  2026-11-11  1102  				BT_WARN("YoYo: unknown config_set type %u",
68e0925f16c028a Ajaykv  2026-11-11  1103  					config_set->config_set_type);
68e0925f16c028a Ajaykv  2026-11-11  1104  				break;
68e0925f16c028a Ajaykv  2026-11-11  1105  			}
68e0925f16c028a Ajaykv  2026-11-11  1106  		}
68e0925f16c028a Ajaykv  2026-11-11  1107  
68e0925f16c028a Ajaykv  2026-11-11  1108  		if (config_set->config_set_type == BTINTEL_PCIE_CFGSET_PERIPH_MAC ||
1151389a60ccbe5 Kiran K 2026-11-23  1109  		    config_set->config_set_type == BTINTEL_PCIE_CFGSET_DEVICE_MEM) {
68e0925f16c028a Ajaykv  2026-11-11  1110  			btintel_pcie_release_mac_access(data);
1151389a60ccbe5 Kiran K 2026-11-23 @1111  			mutex_unlock(&data->mac_access_lock);
1151389a60ccbe5 Kiran K 2026-11-23  1112  		}
68e0925f16c028a Ajaykv  2026-11-11  1113  	}
68e0925f16c028a Ajaykv  2026-11-11  1114  }
68e0925f16c028a Ajaykv  2026-11-11  1115  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
