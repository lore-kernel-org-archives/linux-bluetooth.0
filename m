Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F05221FD3;
	Mon,  9 Jun 2025 23:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749510795; cv=none; b=Vf4dlSxWEwSBBMMcMUsTTSFQi5lfUtsKK8x74cyB5dSU4XngSmGblDWoFItJs9tmPRoR8PuLedjmUwOP7yECFHAEWLniwAqnmbVMaO7c/IA1hee5WQ65OpbGt2BdCi/HvkmSRs3NbDF1FHH8holu8hXFoi1K2b69fnvSr4QgFTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749510795; c=relaxed/simple;
	bh=LJomR0DzWGegAJfsI920xhyjmDqAiAFaWiWA0HJyYQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahIoAHhIvVe0dnXgO1l4Z8XfuZh6jTaNbro80EnNYYfhSu1ssGWD/J1FOo4Tq2jFEg/bRbLLChMISnJLPfYpuFTyJ7SQKrtyQqHi92Ag+UhGxSYsqpK3dYpIgzgrnmO8u/W1RAmJsKEq4hdh21//66u9UAf9Zr4ltciS6/2TUuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ll4l/jxS; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ll4l/jxS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749510794; x=1781046794;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LJomR0DzWGegAJfsI920xhyjmDqAiAFaWiWA0HJyYQ0=;
  b=Ll4l/jxStJkxSu7jwZHIc7fpQFYsE+6TMnIF6Xw4s8qtD0DuIQJ2Ny+l
   7yzjgc4w3pnv0ikebhwHsqMoyjJ7gmazrqu9bLPknLQJ3YybUvr1mJe0+
   E0jQztjGh4GuDLFKBm+GLeocSp1LftyK8y1MN0b3YCTrUMXP2IA6xr22/
   b+mWfwawk2eA/ayR1MikbSMFlQy8YaTDB1VV0G0OIITxFBvji3//D1e9M
   H3fkM2ZG87RDInI4BAWX6GqWKrpTsuBYj52YuNifawdrF9MMpIAq9vbD8
   ToyqzWs0j/EAiWndM7JOCAUnTgG3IhLdL8Fh/Q9X6TTBRgED0PXp9YC+G
   Q==;
X-CSE-ConnectionGUID: hUnDTR+gTtqHNNaitPTvog==
X-CSE-MsgGUID: nhecbhWSQaOi6es9uBJmbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51593610"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="51593610"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 16:13:14 -0700
X-CSE-ConnectionGUID: DMR3dSWAQA2AKACU/nLUQg==
X-CSE-MsgGUID: dheRHgf4SgS2i9nS/xMH7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="151651381"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 09 Jun 2025 16:13:11 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uOlfx-0007Ut-0Y;
	Mon, 09 Jun 2025 23:13:09 +0000
Date: Tue, 10 Jun 2025 07:12:37 +0800
From: kernel test robot <lkp@intel.com>
To: Hilda Wu <hildawu@realtek.com>, marcel@holtmann.org
Cc: oe-kbuild-all@lists.linux.dev, luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	max.chou@realtek.com, alex_lu@realsil.com.cn
Subject: Re: [PATCH v2 1/2] Bluetooth: btrtl: Firmware format v3 support
Message-ID: <202506100621.JeEJ7e7X-lkp@intel.com>
References: <20250606090559.896242-2-hildawu@realtek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606090559.896242-2-hildawu@realtek.com>

Hi Hilda,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on bluetooth-next/master linus/master v6.16-rc1 next-20250606]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hilda-Wu/Bluetooth-btrtl-Firmware-format-v3-support/20250606-170957
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20250606090559.896242-2-hildawu%40realtek.com
patch subject: [PATCH v2 1/2] Bluetooth: btrtl: Firmware format v3 support
config: arm-randconfig-r061-20250609 (https://download.01.org/0day-ci/archive/20250610/202506100621.JeEJ7e7X-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506100621.JeEJ7e7X-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/bluetooth/btrtl.c:1676:3-9: WARNING: NULL check before some freeing functions is not needed.
   drivers/bluetooth/btrtl.c:1678:3-9: WARNING: NULL check before some freeing functions is not needed.

vim +1676 drivers/bluetooth/btrtl.c

  1659	
  1660	void btrtl_free(struct btrtl_device_info *btrtl_dev)
  1661	{
  1662		struct rtl_subsection *entry, *tmp;
  1663		struct rtl_section_patch_image *image, *next;
  1664	
  1665		kvfree(btrtl_dev->fw_data);
  1666		kvfree(btrtl_dev->cfg_data);
  1667	
  1668		list_for_each_entry_safe(entry, tmp, &btrtl_dev->patch_subsecs, list) {
  1669			list_del(&entry->list);
  1670			kfree(entry);
  1671		}
  1672	
  1673		list_for_each_entry_safe(image, next, &btrtl_dev->patch_images, list) {
  1674			list_del(&image->list);
  1675			if (image->image_data)
> 1676				kvfree(image->image_data);
  1677			if (image->cfg_buf)
  1678				kvfree(image->cfg_buf);
  1679			kfree(image);
  1680		}
  1681	
  1682		kfree(btrtl_dev);
  1683	}
  1684	EXPORT_SYMBOL_GPL(btrtl_free);
  1685	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
