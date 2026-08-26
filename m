Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1CA3FFD
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 00:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787703036; cv=none; b=aUt3RA0qhyBYIVOyi39zPdREkQ6LdAc4eayacaYmuh/xDLZqJuHvRNaNkDGGvBbcvPq+FN1ejN+3omv8KBCog/5Bxlq9YFieJmb2H/bbbOXv2f/WZLvJ5gyVxmx2b+sDE1oPfxALg5OW9C7GGeRzrqrYuMU5YLFYwkY39++O3gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787703036; c=relaxed/simple;
	bh=nG+LOEbyLCGbx2+So3aAy6+0HN5jOiIDwrwuxJ+E0pM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UjBTBlZNvqXY9nl+kEzbl2pdgKkSGchjbn2XznpHyObt96Ve3IzDOMxxSAd7GEDHJLyHoW610TbDD2hMdxHzFR4iGBLjv0aGF1Ipklvlu/80RRMj54+/PoexQBgtj9voFaeAGNi0k596JbrLey4Yt2MaG1ZkZGM/z2xXVCzbZ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DoR0tCxg; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DoR0tCxg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787703034; x=1819239034;
  h=date:from:to:cc:subject:message-id;
  bh=nG+LOEbyLCGbx2+So3aAy6+0HN5jOiIDwrwuxJ+E0pM=;
  b=DoR0tCxg/30KesVg28VeJq7WZ+iFut37Rt0cWa/skkEet4qxLkdAPxpg
   sEL9Dci5MZdrVvp3BjUAun1eqlAVKGEw394VRFYXwgAhhOS9gOJVZ7Dbd
   72Qxg4kDM8DqcjlJ5eai/BNWSw5QkBXAOxdHS/5B4O/LzIi22yN210aYw
   io4rWCVr2RX3pBGOkWXWpEqOI8CBEfU7uCyw9/pwq5lgjBF2svJbBnlqD
   B6MYBCwEFDj/wMUQNCFoBQfMvMsxtZrvHuSdSTgrvtCiPyozqVvQI9q5Y
   l9vCg6CNYxYXU79CIDhDg4Nru5BHQmjRuUceqcK1lcBovuK0zs9j2ejFy
   w==;
X-CSE-ConnectionGUID: lFxh5W8OSU+52wPIoakCVw==
X-CSE-MsgGUID: f0W3Ff3MRf2d6t18jCP5+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="99337320"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="99337320"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 17:10:33 -0700
X-CSE-ConnectionGUID: QXoaLB/fQdeK3ESIauyv7A==
X-CSE-MsgGUID: egpDj3KjS8KfOmSj9Godeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="270917077"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 25 Aug 2026 17:10:32 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wz1Dq-000000006az-232T;
	Wed, 26 Aug 2026 00:10:30 +0000
Date: Wed, 26 Aug 2026 08:10:07 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 fe3897b4ab57b7c934532d86df79c129d6ac17a9
Message-ID: <202608260857.DKmCx9pI-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: fe3897b4ab57b7c934532d86df79c129d6ac17a9  Bluetooth: RFCOMM: serialize session teardown

elapsed time: 791m

configs tested: 15
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha          allnoconfig    gcc-16.1.0
alpha         allyesconfig    gcc-16.1.0
alpha            defconfig    gcc-16.1.0
arc           allmodconfig    gcc-16.1.0
arc           allyesconfig    gcc-16.1.0
csky          allmodconfig    gcc-16.1.0
i386          allmodconfig    gcc-14
loongarch        defconfig    clang-24
nios2         allmodconfig    gcc-11.5.0
nios2          allnoconfig    gcc-11.5.0
parisc        allmodconfig    gcc-16.1.0
parisc        allyesconfig    gcc-16.1.0
parisc           defconfig    gcc-16.1.0
powerpc    ppc64_defconfig    clang-17
sh               defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
