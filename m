Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1477BEEC0
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2026 08:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777106303; cv=none; b=I/Ggx+2UY66v+qbmTvDYT8b+n0XOYNpCjLcbE23wQcC9N4Oj6pl2XXxJmeU4j92BCkDR/BNkxuUebuLX/QQSbedBYkEmpLrnLK0/tJd20vb1jynuWowTpQhY8+yrmEIXho2fcPDWM1JaeTj47sp0mYRtE5btVfi9wKvLqqBSAiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777106303; c=relaxed/simple;
	bh=uHWX4JR9i4atjLyu4nPDm7xzfUX1ozEwwGdOsmGVpBo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=i80ZJwYym4yPEPOP8Gm5pgt6f4ANl4c9g2Z3gm3gIDQx0VCnFhhEjd+VVt29mzrpnhHhKpuuYcWs5yw7NXm0UdvfymR4tRVkXozNSU/fPWgz09j+fZgGWG0M8AAWW6aMAOrgeg4K4hhuKLUDfS66VUfs3Tgs4QIt9s2AsyIxrps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mSHj0Gkb; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mSHj0Gkb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777106302; x=1808642302;
  h=date:from:to:cc:subject:message-id;
  bh=uHWX4JR9i4atjLyu4nPDm7xzfUX1ozEwwGdOsmGVpBo=;
  b=mSHj0GkbXoU/ldC06dAR1hjSvq1Ri+HXkMH89vGHHJkAZrSbm+OXUbcV
   iwauOVIcoltPDjff0IgRc7IijbJzR34T3a4AidFx6qErQBT1z+rsFgTEs
   Ai4mmRfA30Yj/KZfyEAqo+OcpCq9q2E5emIDVsECAlhI9WIWmPU66C+ek
   FCulgMdxRUnR5XEYnfxG1LyP2x74uyi1USsOsi7/aZth1WHeSFtQo32nP
   ukmPPFBJMnQSYAXu/mNcHa7LwcXa53u91iTbERM1WN7v2sz5MgylA1ncA
   8joR0NvZBd7tI7imn2ZGsJ6Gw/BXwG5FCTSffdWyvmy47DePT1hrP14v/
   Q==;
X-CSE-ConnectionGUID: 9u1CGfykRQSEGRz7xSVrLQ==
X-CSE-MsgGUID: hfMnd8AxSdicW3bfdySZyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11766"; a="77237716"
X-IronPort-AV: E=Sophos;i="6.23,198,1770624000"; 
   d="scan'208";a="77237716"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2026 01:38:21 -0700
X-CSE-ConnectionGUID: CvKGPc9DQ+67VR6ijQhBLw==
X-CSE-MsgGUID: g1X1sEHiS7yg3S0uObn4Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,198,1770624000"; 
   d="scan'208";a="228844425"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 25 Apr 2026 01:38:21 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wGYWo-000000006Zh-1lPX;
	Sat, 25 Apr 2026 08:38:18 +0000
Date: Sat, 25 Apr 2026 16:38:05 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 516a3ab44299afd2ffd58279cf355c87c0d35754
Message-ID: <202604251657.FRfzvZtG-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 516a3ab44299afd2ffd58279cf355c87c0d35754  Bluetooth: btusb: Add Realtek RTL8922AE VID/PID 0bda/d923

elapsed time: 832m

configs tested: 54
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-15.2.0
alpha        allyesconfig    gcc-15.2.0
arc          allmodconfig    gcc-15.2.0
arc           allnoconfig    gcc-15.2.0
arc          allyesconfig    gcc-15.2.0
arm           allnoconfig    clang-23
arm          allyesconfig    gcc-15.2.0
arm64        allmodconfig    clang-19
arm64         allnoconfig    gcc-15.2.0
csky         allmodconfig    gcc-15.2.0
csky          allnoconfig    gcc-15.2.0
hexagon      allmodconfig    clang-17
hexagon       allnoconfig    clang-23
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-23
m68k         allmodconfig    gcc-15.2.0
m68k          allnoconfig    gcc-15.2.0
m68k         allyesconfig    gcc-15.2.0
microblaze    allnoconfig    gcc-15.2.0
microblaze   allyesconfig    gcc-15.2.0
mips         allmodconfig    gcc-15.2.0
mips          allnoconfig    gcc-15.2.0
mips         allyesconfig    gcc-15.2.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-15.2.0
openrisc      allnoconfig    gcc-15.2.0
parisc       allmodconfig    gcc-15.2.0
parisc        allnoconfig    gcc-15.2.0
parisc       allyesconfig    gcc-15.2.0
powerpc      allmodconfig    gcc-15.2.0
powerpc       allnoconfig    gcc-15.2.0
riscv        allmodconfig    clang-23
riscv         allnoconfig    gcc-15.2.0
riscv        allyesconfig    clang-16
s390         allmodconfig    clang-18
s390          allnoconfig    clang-23
s390         allyesconfig    gcc-15.2.0
sh           allmodconfig    gcc-15.2.0
sh            allnoconfig    gcc-15.2.0
sh           allyesconfig    gcc-15.2.0
sparc         allnoconfig    gcc-15.2.0
sparc64      allmodconfig    clang-23
um           allmodconfig    clang-19
um            allnoconfig    clang-23
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-20
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64      rhel-9.4-rust    clang-20
xtensa        allnoconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
