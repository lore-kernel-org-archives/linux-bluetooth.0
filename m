Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634381ADC8C
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740769556; cv=none; b=hsQdscT/U5utsTeQku2HeOEgcZ8IHFjSjaxXJG4v+SV1Aho3+a9iwmd90rku2RYAtt398maNXkrDmtZXFIPVlwLxYmdx9mMoaPpRuMs2VyyBULHvxnGVPzvdBLPYP3K9fKbOPWl6BRyeWgCApvyHSpOPhDw9KRA6l+iu6CEjokE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740769556; c=relaxed/simple;
	bh=rm5aoGJXRVurNPuxCvWtGrFOSNatnMlkngupqJflnAo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HZs1weU5kC4awZmSGr32jBLAKKEttP2y4Cfkvzisq4y4vAOrqypqbgpOMnpgEXiWfolibZ5dHDycYLknzfkHVLsYxUhaO9ifFCVLx5ec3cGQ8X0A2G/dFzIlrpqcG9lZ1OCSUMGysf3cIEweqXKc6cIvJZBHENWZxPB/4KNPl38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RBp2Puwv; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RBp2Puwv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740769554; x=1772305554;
  h=date:from:to:cc:subject:message-id;
  bh=rm5aoGJXRVurNPuxCvWtGrFOSNatnMlkngupqJflnAo=;
  b=RBp2PuwvrA4qgZT4qDBd0NZm5ITdKBW4tcjiQdrY30WvMAA4TkViiJ3N
   75lvhibqEz2V4fThdFG4piTC9rwfPUeSTvDdP8TY/zMVUF2HOY15I4LX2
   u1Hg+lIKXX7cX8iZuBDYaQUContYbaFiNfnpAG1DXHjUtuJWj2ZnGabqD
   EV4r2NLtV7KKQA+2ia9EW+qewEIeqsd15vfmcd9V/M4MzlFF2HyWEiP9c
   xJjAkU8suuDWOQJQ0HUAXnjXeF8DAVgV7ovOc9VzADzMfrUf+0AyPUk0f
   XyA7GTMCz3QLnhPMVyCB99Qrtwx4sAl/wdkFqMgLmY1XcsZd1lqFMIdGk
   g==;
X-CSE-ConnectionGUID: OFUErZ8ERrmyot2XKGQWMQ==
X-CSE-MsgGUID: 4rZ/Cy68SjGzFzN0BRgnNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="41829809"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="41829809"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 11:05:54 -0800
X-CSE-ConnectionGUID: w6Gv2ZM7RgKoi9VzRPkWuA==
X-CSE-MsgGUID: JbSSSogSS5O4iXowx3Khng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="148222910"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 28 Feb 2025 11:05:53 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1to5fn-000FNW-0z;
	Fri, 28 Feb 2025 19:05:32 +0000
Date: Sat, 01 Mar 2025 03:04:21 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 7c2203f91affcad4b45ff59945aa621b33f7a413
Message-ID: <202503010307.zYS2Xocb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 7c2203f91affcad4b45ff59945aa621b33f7a413  Bluetooth: btusb: Configure altsetting for HCI_USER_CHANNEL

elapsed time: 1460m

configs tested: 61
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                  randconfig-001-20250228    gcc-13.2.0
arc                  randconfig-002-20250228    gcc-13.2.0
arm                  randconfig-001-20250228    clang-21
arm                  randconfig-002-20250228    gcc-14.2.0
arm                  randconfig-003-20250228    gcc-14.2.0
arm                  randconfig-004-20250228    gcc-14.2.0
arm64                randconfig-001-20250228    gcc-14.2.0
arm64                randconfig-002-20250228    clang-21
arm64                randconfig-003-20250228    clang-16
arm64                randconfig-004-20250228    gcc-14.2.0
csky                 randconfig-001-20250228    gcc-14.2.0
csky                 randconfig-002-20250228    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250228    clang-19
hexagon              randconfig-002-20250228    clang-21
i386       buildonly-randconfig-001-20250228    clang-19
i386       buildonly-randconfig-002-20250228    clang-19
i386       buildonly-randconfig-003-20250228    gcc-12
i386       buildonly-randconfig-004-20250228    clang-19
i386       buildonly-randconfig-005-20250228    clang-19
i386       buildonly-randconfig-006-20250228    clang-19
loongarch            randconfig-001-20250228    gcc-14.2.0
loongarch            randconfig-002-20250228    gcc-14.2.0
nios2                randconfig-001-20250228    gcc-14.2.0
nios2                randconfig-002-20250228    gcc-14.2.0
parisc               randconfig-001-20250228    gcc-14.2.0
parisc               randconfig-002-20250228    gcc-14.2.0
powerpc              randconfig-001-20250228    gcc-14.2.0
powerpc              randconfig-002-20250228    clang-16
powerpc              randconfig-003-20250228    clang-18
powerpc64            randconfig-001-20250228    clang-16
powerpc64            randconfig-002-20250228    clang-18
powerpc64            randconfig-003-20250228    gcc-14.2.0
riscv                randconfig-001-20250228    gcc-14.2.0
riscv                randconfig-002-20250228    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250228    gcc-14.2.0
s390                 randconfig-002-20250228    clang-17
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250228    gcc-14.2.0
sh                   randconfig-002-20250228    gcc-14.2.0
sparc                randconfig-001-20250228    gcc-14.2.0
sparc                randconfig-002-20250228    gcc-14.2.0
sparc64              randconfig-001-20250228    gcc-14.2.0
sparc64              randconfig-002-20250228    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250228    clang-21
um                   randconfig-002-20250228    clang-21
x86_64     buildonly-randconfig-001-20250228    clang-19
x86_64     buildonly-randconfig-002-20250228    clang-19
x86_64     buildonly-randconfig-003-20250228    gcc-12
x86_64     buildonly-randconfig-004-20250228    clang-19
x86_64     buildonly-randconfig-005-20250228    gcc-12
x86_64     buildonly-randconfig-006-20250228    gcc-12
xtensa               randconfig-001-20250228    gcc-14.2.0
xtensa               randconfig-002-20250228    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
