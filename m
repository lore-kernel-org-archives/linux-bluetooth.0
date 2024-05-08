Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8DD26291;
	Wed,  8 May 2024 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715152395; cv=none; b=LW8I96Xs9U0lYSgPo/TKAT+RbKhVNkcxPwV7Rt6EoDwMAK4Pt1MSWy31tMT2ga/LYALBq8c5iXfAQukyGjT22137M03Nkwly77fts5ST2PJqH/5VGI7efnMQQJFquQO8oKu+VNxADi3C/3TKs9vUZwVkJ2+2T4325SZ/V8Qv8+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715152395; c=relaxed/simple;
	bh=kcyv9B4aVwqHiIYH9soi2Une9+zbvCi85GRN+JQDBrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsDGpVRYrtUAtLE4a8P0Ft1ahgsaDcM4OwxHzlw7YDDQuU0p4DHlcVz92wJK0LG7rdIpdts3G34UXAK7qCxB42sZqBhadaS+VJVmaLEy/rxyKDnX/k4ZOUf33X9z+kaA8VHZqklm3DuJlwzC0NzaHPuelQB/44NZHkuD2zjfOZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YVToH9qf; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YVToH9qf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715152394; x=1746688394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kcyv9B4aVwqHiIYH9soi2Une9+zbvCi85GRN+JQDBrw=;
  b=YVToH9qfjGIvFNkVk2EPoyPJn14/W0G6GyuCB9KC8t/tqdSIno6AAOub
   gAzagqVVYSii3cBc7VClUnp2+7+TP8m6wFSnJE5aVPL0dRZsfUltzop9V
   pNhD2AtWrE2igwNtiqMVWwTY4uy3aKFs19+yGxdf19QZSORtPC0GGFnC7
   i1U25TaOn8u/61Byf2fX078kVJXpqEpITa69sAh8lNFpndNR1dvYGjgmd
   IYNIcJ2bEfNllEpUfaj+TVljxK4VlzwupwCNh+z2HOM/WxRooQeowDgHj
   xvFBcdzpml6veOBUutM0ht2SRHVycNbD0+hcf2ZVSUBw5IbbbqKqLDx/i
   A==;
X-CSE-ConnectionGUID: 9GeM6nIrQpm52B1WadIIzQ==
X-CSE-MsgGUID: BlOueZa3SW6ybDZt6jdM8A==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="28510634"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="28510634"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 00:13:13 -0700
X-CSE-ConnectionGUID: ENhzKVk6SOGhN6R8K3Ve/w==
X-CSE-MsgGUID: 3/5Xc0TtRTCLRkYiBpYK5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="33310222"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 08 May 2024 00:13:10 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4bUC-00037E-0m;
	Wed, 08 May 2024 07:13:08 +0000
Date: Wed, 8 May 2024 15:12:52 +0800
From: kernel test robot <lkp@intel.com>
To: sean.wang@kernel.org, marcel@holtmann.org, johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH v4 1/5] Bluetooth: btmtk: add the function to get the fw
 name
Message-ID: <202405081456.v2MvcQ0P-lkp@intel.com>
References: <965cd14922aea67e2750ff2c2ecad773f8ba485a.1715109394.git.sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <965cd14922aea67e2750ff2c2ecad773f8ba485a.1715109394.git.sean.wang@kernel.org>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on bluetooth-next/master linus/master v6.9-rc7 next-20240507]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/sean-wang-kernel-org/Bluetooth-btmtk-apply-the-common-btmtk_fw_get_filename/20240508-032333
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/965cd14922aea67e2750ff2c2ecad773f8ba485a.1715109394.git.sean.wang%40kernel.org
patch subject: [PATCH v4 1/5] Bluetooth: btmtk: add the function to get the fw name
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240508/202405081456.v2MvcQ0P-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240508/202405081456.v2MvcQ0P-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405081456.v2MvcQ0P-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/bluetooth/btmtk.c: In function 'btmtk_fw_get_filename':
>> drivers/bluetooth/btmtk.c:115:35: warning: 'mediatek/BT_RAM_CODE_MT' directive output truncated writing 23 bytes into a region of size 8 [-Wformat-truncation=]
     115 |                          "mediatek/BT_RAM_CODE_MT%04x_1a_%x_hdr.bin",
         |                           ~~~~~~~~^~~~~~~~~~~~~~~
   drivers/bluetooth/btmtk.c:115:26: note: directive argument in the range [1, 256]
     115 |                          "mediatek/BT_RAM_CODE_MT%04x_1a_%x_hdr.bin",
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bluetooth/btmtk.c:114:17: note: 'snprintf' output between 41 and 43 bytes into a destination of size 8
     114 |                 snprintf(buf, sizeof(size),
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
     115 |                          "mediatek/BT_RAM_CODE_MT%04x_1a_%x_hdr.bin",
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     116 |                          dev_id & 0xffff, (fw_ver & 0xff) + 1);
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +115 drivers/bluetooth/btmtk.c

   105	
   106	void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u32 fw_ver,
   107				   u32 fw_flavor)
   108	{
   109		if (dev_id == 0x7925)
   110			snprintf(buf, size,
   111				 "mediatek/mt%04x/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
   112				 dev_id & 0xffff, dev_id & 0xffff, (fw_ver & 0xff) + 1);
   113		else if (dev_id == 0x7961 && fw_flavor)
   114			snprintf(buf, sizeof(size),
 > 115				 "mediatek/BT_RAM_CODE_MT%04x_1a_%x_hdr.bin",
   116				 dev_id & 0xffff, (fw_ver & 0xff) + 1);
   117		else
   118			snprintf(buf, size,
   119				 "mediatek/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
   120				 dev_id & 0xffff, (fw_ver & 0xff) + 1);
   121	}
   122	EXPORT_SYMBOL_GPL(btmtk_fw_get_filename);
   123	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
