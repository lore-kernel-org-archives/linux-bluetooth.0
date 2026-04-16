Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C553248F73;
	Thu, 16 Apr 2026 06:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776320736; cv=none; b=RNnpJEJkTscI1gwzNwocvOWfqP4UIM3A/ctGZJ+babDIjsKwDV74naH4N/7ddGlWhkZ2e0iwf6hPfEmlaUfD6fQlSBf2wqrymojoWKSKoNy9hyLS0GRYmUqd/pRccaNo8w7oMrRA0Vqc9UN6TpskKVaNMo90EIUIMwXY57vkzV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776320736; c=relaxed/simple;
	bh=8CsymCZaGad+OZGIqws32VF9Ro8L7v206gqJodd0NSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjcTegwh6McTzgdsCaCJhuIQm8mIwayVGnczWDE3EIWbD0CYyFAf+MuXSW43PXGtkWRXpgblwuMpGMN9CjFDBQQUODsAEvQYwb+4Z+9tPTPBf6a8wXxIwgZGUBGsBGyM4kVSc9h+PDbUOzSaLb/O2xf/nX6LwKHGwPD3016RmNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d0EPVjti; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0EPVjti"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776320734; x=1807856734;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8CsymCZaGad+OZGIqws32VF9Ro8L7v206gqJodd0NSw=;
  b=d0EPVjtik9YKYFrhMXmFfsDRjfVawu7sMWM6bcPEhLDLd7S1pPXxWk0t
   paktVWWVBR9ACTopo2WNwO10H5ANmXeMVvX+oQ8swH3IJigOf2F3MQr75
   3c3MINWwYXnhua4D3h3cJ6BUIhVLY6N/r4Y4xZ1MIXadKciaBAaAU40Io
   eD4VK0Fyv0DsN2KP1XYtQ0CIpIJTgMI1zi6S1f9b7eMUIRTwDszXYPhTm
   lQjheJOPcZPFYK8hRBgOVdrbuVag6IZ2c1vT9MsE1+Jib7jwVc3e8EB3Z
   HuUXRXz8OFm5SLEGi3S9i8D+IUfML7BtJMydPo30Rbm6wNOBioPVVkDMl
   w==;
X-CSE-ConnectionGUID: MM1/dOsGTauuHe7oamx9QQ==
X-CSE-MsgGUID: 9CUcYEtwSKygUXScVEVahA==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77217573"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="77217573"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 23:25:34 -0700
X-CSE-ConnectionGUID: G9Cpx52SQIeV1G6+7pq+9g==
X-CSE-MsgGUID: eyY9TVweRgiXQ7pyfSSrFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="227978469"
Received: from lkp-server01.sh.intel.com (HELO 7f3b36e5d6a5) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 15 Apr 2026 23:25:31 -0700
Received: from kbuild by 7f3b36e5d6a5 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wDGAJ-000000001Li-3r8D;
	Thu, 16 Apr 2026 06:25:27 +0000
Date: Thu, 16 Apr 2026 14:25:22 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Lu <chris.lu@mediatek.com>, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Von Dentz <luiz.dentz@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Sean Wang <sean.wang@mediatek.com>,
	Will Lee <will-cy.Lee@mediatek.com>, SS Wu <ss.wu@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-mediatek <linux-mediatek@lists.infradead.org>,
	Chris Lu <chris.lu@mediatek.com>
Subject: Re: [PATCH v3] Bluetooth: btmtk: add event filter to filter specific
 event
Message-ID: <202604161458.dT9HKalR-lkp@intel.com>
References: <20260412090242.1129701-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260412090242.1129701-1-chris.lu@mediatek.com>

Hi Chris,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth/master]
[also build test ERROR on bluetooth-next/master linus/master v7.0 next-20260415]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Lu/Bluetooth-btmtk-add-event-filter-to-filter-specific-event/20260415-122458
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20260412090242.1129701-1-chris.lu%40mediatek.com
patch subject: [PATCH v3] Bluetooth: btmtk: add event filter to filter specific event
config: i386-randconfig-051-20260416 (https://download.01.org/0day-ci/archive/20260416/202604161458.dT9HKalR-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260416/202604161458.dT9HKalR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604161458.dT9HKalR-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "btmtk_recv_event" [drivers/bluetooth/btusb.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
