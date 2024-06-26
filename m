Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BD41862
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jun 2024 00:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719361198; cv=none; b=ARFZ/T2/fSv2L+eDLsfi+x1HBofmnIQI3HYdYPGrwOdeYkHE2GlFDUhUg/zko4bjagTx5e0txFhxSu2MMtG6rp3rhUtrpNBt4Ib6vsl1TjQmPVshrYy+ec0YNAs0Zco2WZ0AFGOTkGVNv/im9Xx3mlqrIUcM8jrBLtzMoFYJD0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719361198; c=relaxed/simple;
	bh=LAwZpy3+qHkbeq9PeG40wpWmYPLEMz8RHsNqK/BorGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nz/v7fwGJaI+f1e6Cf6BsMu921mxtE5gLmPh2U7PFNTic2U44KcDPM87SBpKOgUE8eRhaotDu02wamM4BWJCQYrzPVzTECvt0cjNcAjrylbOLNcinwPgXwgSsCa3RDCC8qJsgI1lkvsote/LRf5U4Y2eLEkjoTUpHDVk9Rwp1ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VrgMaEp7; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VrgMaEp7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719361197; x=1750897197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LAwZpy3+qHkbeq9PeG40wpWmYPLEMz8RHsNqK/BorGA=;
  b=VrgMaEp72NoqRaCin4hc9jGHjLcsQA3wunal+89jMe4dg8KRu1Lu8OlR
   gXRHv0oa2XLMZBHWrmuwBtfqLaxy0Z1FZlJQOgONYol9R7YAE9nuN0bxa
   1Sgjonh5Pj+U295oXaqmMwt3l80hn/lkOonYan7/dYg4MNr481sMDuNSG
   RnACTs1wWvhuDLF+UgO3/OcuZuMRpU8d9vMHTfxwO+tl8l78y/AzC/fsr
   fdFDq9cd8GdIBZhs+2z/1OacX5lY/qGdA0RNPRwyAO/tYxCbf9isMG3Hb
   fb/u1Age9tIK62FJE7E9l6WUCfBOFAsYpitVG2X10conXwco4ASIl3PBI
   g==;
X-CSE-ConnectionGUID: b1YZLCaZSD2Fp3/OjeoY4g==
X-CSE-MsgGUID: UddL9iDDTvGRd8gCzi31+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16233150"
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="16233150"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 17:19:57 -0700
X-CSE-ConnectionGUID: OmMYyxwxTtaphR/2m1b0oQ==
X-CSE-MsgGUID: A4LbpmDfSEqtuUuO+S2UMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="48201436"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 25 Jun 2024 17:19:52 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMGO7-000EpK-2t;
	Wed, 26 Jun 2024 00:19:51 +0000
Date: Wed, 26 Jun 2024 08:19:11 +0800
From: kernel test robot <lkp@intel.com>
To: Kiran K <kiran.k@intel.com>, linux-bluetooth@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com, vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: Re: [PATCH v2] Bluetooth: btintel: Allow lowering of drive strength
 of BRI
Message-ID: <202406260704.ZkFL5RKp-lkp@intel.com>
References: <20240621064419.2185652-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621064419.2185652-1-kiran.k@intel.com>

Hi Kiran,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth-next/master]
[also build test ERROR on next-20240625]
[cannot apply to bluetooth/master linus/master v6.10-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kiran-K/Bluetooth-btintel-Allow-lowering-of-drive-strength-of-BRI/20240625-161151
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20240621064419.2185652-1-kiran.k%40intel.com
patch subject: [PATCH v2] Bluetooth: btintel: Allow lowering of drive strength of BRI
config: i386-buildonly-randconfig-001-20240626 (https://download.01.org/0day-ci/archive/20240626/202406260704.ZkFL5RKp-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240626/202406260704.ZkFL5RKp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406260704.ZkFL5RKp-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/bluetooth/btintel.c:66:46: error: incompatible pointer types passing 'size_t *' (aka 'unsigned int *') to parameter of type 'unsigned long *' [-Werror,-Wincompatible-pointer-types]
      66 |         status = efi.get_variable(name, guid, NULL, &data_size, NULL);
         |                                                     ^~~~~~~~~~
   drivers/bluetooth/btintel.c:76:46: error: incompatible pointer types passing 'size_t *' (aka 'unsigned int *') to parameter of type 'unsigned long *' [-Werror,-Wincompatible-pointer-types]
      76 |         status = efi.get_variable(name, guid, NULL, &data_size, data);
         |                                                     ^~~~~~~~~~
   2 errors generated.


vim +66 drivers/bluetooth/btintel.c

    49	
    50	static const guid_t btintel_guid_dsm =
    51		GUID_INIT(0xaa10f4e0, 0x81ac, 0x4233,
    52			  0xab, 0xf6, 0x3b, 0x2a, 0xc5, 0x0e, 0x28, 0xd9);
    53	
    54	static void *btintel_uefi_get_variable(efi_char16_t *name, efi_guid_t *guid)
    55	{
    56		void *data;
    57		efi_status_t status;
    58		size_t data_size = 0;
    59	
    60		if (!IS_ENABLED(CONFIG_EFI))
    61			return ERR_PTR(-EOPNOTSUPP);
    62	
    63		if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
    64			return ERR_PTR(-EOPNOTSUPP);
    65	
  > 66		status = efi.get_variable(name, guid, NULL, &data_size, NULL);
    67	
    68		if (status != EFI_BUFFER_TOO_SMALL || !data_size)
    69			return ERR_PTR(-EIO);
    70	
    71		data = kmalloc(data_size, GFP_KERNEL);
    72	
    73		if (!data)
    74			return ERR_PTR(-ENOMEM);
    75	
    76		status = efi.get_variable(name, guid, NULL, &data_size, data);
    77	
    78		if (status != EFI_SUCCESS) {
    79			kfree(data);
    80			return ERR_PTR(-ENXIO);
    81		}
    82	
    83		return data;
    84	}
    85	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
