Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974DE23D7FC;
	Sat, 22 Nov 2025 03:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763782343; cv=none; b=cPpO7zyzwSkS6MuPb34rc3gbleXNsWa5COe9W9UcySX1yeX/8pYp13400mUX/14g20aaxF75qK4/+Q2vLdVQd2SjTJC8Q+LVUAvF/W0YXEs0XPfC9jPgAHyEQv2Af+9vUL5GVe/AXRrvuJwmxfz89rc8mo/zglf+3vMqqBFZOWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763782343; c=relaxed/simple;
	bh=fKZ3mFx0QkPhKj75Tr3yl0HRKoY0BsGVZcLqDCBeIvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6J66INbm2fSSS2R7sTPLw0VaDuJpZ2pRIdHDmZB4Kwnu08xYBEmWBO/HTxNh93NDYxc6F5+sbjqw2cTaegsr/JjIaehygIGipCZYAg1HLa9aHji92ZM/9sfp/NgWkJESINhOWus9KBjioftw1XEmj8pOsgA3/OobmgpEIb8Uu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XLG3ytoI; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XLG3ytoI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763782342; x=1795318342;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fKZ3mFx0QkPhKj75Tr3yl0HRKoY0BsGVZcLqDCBeIvg=;
  b=XLG3ytoIP2xLIpSVL8GOWf0snX4BHoAKBT9RNzJ9n1rA23ao+7boIG1J
   zuB1nRICwvWJ0qo5A0AFLh7vOGvQ5r928wiXEOAF2HelwzUan9OKt8Lhd
   l8fdTJSXEvNVbXdO+jK10gP1VZ+eqP96XKLhAOz4OxdELnr3LJ7zAvLqu
   HxOGkbJZAnKPmqyjf81wRb2Jqx+hmgg3YobB1+MB1QCJFb1JhZpdnvMxH
   2HA+pMdIxNxWn/SDZRJpGrDDBpFdqvVFpXv3o1qWWIVo7Ro6ARH4J0+97
   RhAqzCta+5H9fRuYZsxpTOxU+kNfqcH7Ovryk/B2ikU7CcqnjrehkZuGE
   w==;
X-CSE-ConnectionGUID: mN8bQoK/R46ppSumGJBoqg==
X-CSE-MsgGUID: sR0aDD0AQmqL0w3DrJUaeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="83267353"
X-IronPort-AV: E=Sophos;i="6.20,217,1758610800"; 
   d="scan'208";a="83267353"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 19:32:22 -0800
X-CSE-ConnectionGUID: 7lZqQ4GUToqhSsntBH1YHg==
X-CSE-MsgGUID: KVXY2BD3S662ZDaZ9LHvnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,217,1758610800"; 
   d="scan'208";a="196326365"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 21 Nov 2025 19:32:18 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMeMB-00077P-2j;
	Sat, 22 Nov 2025 03:32:15 +0000
Date: Sat, 22 Nov 2025 11:31:58 +0800
From: kernel test robot <lkp@intel.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com, sherry.sun@nxp.com, dmitrii.lebed@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: Re: [PATCH v1 05/11] Bluetooth: btnxpuart: Add TLS host hello
 handshake implementation
Message-ID: <202511221150.4Zd49lpF-lkp@intel.com>
References: <20251118142025.1982263-6-neeraj.sanjaykale@nxp.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118142025.1982263-6-neeraj.sanjaykale@nxp.com>

Hi Neeraj,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on bluetooth-next/master linus/master v6.18-rc6 next-20251121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Neeraj-Sanjay-Kale/Bluetooth-btnxpuart-Add-firmware-metadata-parsing-for-secure-interface/20251118-223605
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20251118142025.1982263-6-neeraj.sanjaykale%40nxp.com
patch subject: [PATCH v1 05/11] Bluetooth: btnxpuart: Add TLS host hello handshake implementation
config: arm-randconfig-001-20251122 (https://download.01.org/0day-ci/archive/20251122/202511221150.4Zd49lpF-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9e9fe08b16ea2c4d9867fb4974edf2a3776d6ece)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251122/202511221150.4Zd49lpF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511221150.4Zd49lpF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/bluetooth/btnxpuart.c:438:29: warning: field host_hello within 'struct nxp_tls_host_hello_payload::(anonymous at drivers/bluetooth/btnxpuart.c:436:2)' is less aligned than 'struct nxp_tls_host_hello' and is usually due to 'struct nxp_tls_host_hello_payload::(anonymous at drivers/bluetooth/btnxpuart.c:436:2)' being packed, which can lead to unaligned accesses [-Wunaligned-access]
     438 |                 struct nxp_tls_host_hello host_hello;
         |                                           ^
   drivers/bluetooth/btnxpuart.c:1828:1: warning: unused label 'free_skb' [-Wunused-label]
    1828 | free_skb:
         | ^~~~~~~~~
   2 warnings generated.


vim +438 drivers/bluetooth/btnxpuart.c

   434	
   435	union nxp_tls_host_hello_payload {
   436		struct {
   437			u8 msg_type;
 > 438			struct nxp_tls_host_hello host_hello;
   439		} __packed;
   440		u8 buf[113];
   441	};
   442	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
