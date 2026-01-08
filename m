Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FDE20311
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jan 2026 01:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767834687; cv=none; b=DOg1UYlGpc9p1RiYoBcGmMpXlLsvra0pB5IE53d7ExUccs+93wKI2tMDWcOMGXu4wWI3tstJ1R03NWYqXjbmCFhiin0fiA/f8RJMdyc0lI349wasolma1Jg4zUDyXXVnuMEnrfx0HIPMTY+ls4ZI5PDd439vE+u10NVVrSeoaZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767834687; c=relaxed/simple;
	bh=IXYCoqXJpcCxrnaAhuf/HHLz1uid1cdg7+bqywwZrqA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=s98HvdrdNE+mQw5J5IF68JDxfLFqtLDR8PblI/IjlOgEsgP+kg/MYLq1Hah7fv0gRx1zFb9/ZGWN9khVWxNtusxNCWrmxpEF0F3qIEgwS+sXcVHN144seYlROGtbuzbK0OMedRIrg7RMfovsdpJ+3aE7YA24vkk6HuSLrLY1Pt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FAdixnK1; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FAdixnK1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767834686; x=1799370686;
  h=date:from:to:cc:subject:message-id;
  bh=IXYCoqXJpcCxrnaAhuf/HHLz1uid1cdg7+bqywwZrqA=;
  b=FAdixnK1gW/R7//qTIS3IgM9FXHHlTeitjtPxA46QZ8crDhVjQ9AXC9d
   dPUpBeyf57Uc0dOulLNJOqgjEf9cJ3SR2piOC5v7Ptd3zPp8DWJJuMsXM
   SRAaDpcLhYuTVrDlkvPA6Iu7Xf1AVqIUhg9yBsyKN6SOLETQ9GellgHiF
   O9+DveZdPG5hylmuypDzYcPk6cs4yaNPnNnUUK49wZ2e90Y58xBtQ8Lck
   Mo9CyKAH9SwIwOnVz1w9+1batZCeNvvgcFuau0udBEHA7BRUxGBLfwrXn
   IOw0pD7kM0OthFh6537BtcFXnx3sZo0hO6bBCoHULYbHyMG5Pd0O1qp2n
   A==;
X-CSE-ConnectionGUID: dchYxJ4XTGGz4jqKuD0BGQ==
X-CSE-MsgGUID: UEnlBqOSQVmkAED/Mmjs6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="86628561"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="86628561"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 17:11:26 -0800
X-CSE-ConnectionGUID: T6lDS0ArRHaUP4kDfmauOA==
X-CSE-MsgGUID: pnwjorwyQwy3K9vxDDGuVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="208132851"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 07 Jan 2026 17:11:24 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vdeYb-000000004IP-33GX;
	Thu, 08 Jan 2026 01:11:21 +0000
Date: Thu, 08 Jan 2026 09:11:12 +0800
From: kernel test robot <lkp@intel.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-bluetooth@vger.kernel.org,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Subject: [bluetooth-next:master 43/46]
 drivers/i2c/busses/i2c-designware-platform.o: warning: objtool:
 dw_i2c_plat_remove+0xe1: no-cfi indirect call!
Message-ID: <202601080917.48r3wydk-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   bdb9aba465a85122bcba01a6154e237b9843e25b
commit: 030d2c0e9c1d68e67f91c08704482ad9881583eb [43/46] Bluetooth: btqca: Add WCN6855 firmware priority selection feature
config: x86_64-randconfig-161-20260108 (https://download.01.org/0day-ci/archive/20260108/202601080917.48r3wydk-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260108/202601080917.48r3wydk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601080917.48r3wydk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/i2c/busses/i2c-designware-platform.o: warning: objtool: dw_i2c_plat_remove+0xe1: no-cfi indirect call!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
