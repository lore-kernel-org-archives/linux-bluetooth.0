Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F418938D414
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784996781; cv=none; b=mMZ7n8ad+92EsJkda8fRS5OyNYypUUHwVstZdZcbXWSC6T5PoKDA9ku19AzAsp986owo+CacWtpkjomW83duwKaqtfED/hDRl7aSGmV7WlwVAGYm2FfFUdp+bPHCKpZLtfQrMnmBzdDyuTZtX4nXs2W1fFzJG5UUvlyk0/OBu80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784996781; c=relaxed/simple;
	bh=t3OHe5ErwSBRxC1UU8GUohwhIdUGB/wwJ+hS+vtH6v8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YdckazwcNy7aPDC4bIzBvqkmiawYksRtBI0N6SV9pCwmBviK14s6R3f4WEzcrQeGlRhY/h0kkovjXRtiqJJZB5unw1RIslSxzTU99OfvJ0geYl6xY/IsJ4akIb+57EcX3wkp3DZVEyYERRcJfEwODtEOzxKsccjlHJwkIOeqCd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dCaTUmHs; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dCaTUmHs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784996778; x=1816532778;
  h=date:from:to:cc:subject:message-id;
  bh=t3OHe5ErwSBRxC1UU8GUohwhIdUGB/wwJ+hS+vtH6v8=;
  b=dCaTUmHs+LB8AjoUv8sUZuiW2AlSfLe2yKY4k56FQzzdfkTeOYLYKGL2
   gZ1muWN1fpqDF82Du7d1Md4IObvYvzGnehId0s5NeqhPNSpZ96e0D+qUM
   giT9L0xCWH14m27QQFtpqCi0YrJOUwXLAP3mzqldkh8YYCaNF7J0/5Vf6
   xLYB1RzYjQnZYEr1zwVnFUqE3Az17zSlsljwXptjia0j/vh9dlT52mpfW
   SCXqM2wvnNN3KiIB9XplBHha9y4dPUrld9CwJZ+MLm0ibRxSseFC++o+b
   d6corCID44HQ0yCPwynyivQmAstlgd56CfOD6vRM+QUI4qQCqzwfM9tAo
   w==;
X-CSE-ConnectionGUID: bZSEn2Q2Tv+ClCtspKHkWA==
X-CSE-MsgGUID: mk/H/bXaQG6wCmemDdgkVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11856"; a="84758757"
X-IronPort-AV: E=Sophos;i="6.25,184,1779174000"; 
   d="scan'208";a="84758757"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2026 09:26:17 -0700
X-CSE-ConnectionGUID: xJZia1I0Q5i7uAFuTcYXwA==
X-CSE-MsgGUID: kg6HwNBFTzeCb16yiwHUww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,184,1779174000"; 
   d="scan'208";a="255066123"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 25 Jul 2026 09:26:16 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wnfCW-00000000bn4-3p58;
	Sat, 25 Jul 2026 16:26:13 +0000
Date: Sun, 26 Jul 2026 00:25:14 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 6f55ad8fb0acd861e5c4e526b2272fc71952e1e3
Message-ID: <202607260046.HCg6dhhE-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 6f55ad8fb0acd861e5c4e526b2272fc71952e1e3  Bluetooth: btusb: Realtek: Replace HCI_VENDOR_PKT usage with HCI_EV_VENDOR

elapsed time: 5522m

configs tested: 76
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                           randconfig-001    clang-21
arc                  randconfig-001-20260725    clang-21
arc                  randconfig-002-20260725    clang-21
arm                  randconfig-001-20260725    clang-21
arm                  randconfig-002-20260725    clang-21
arm                  randconfig-003-20260725    clang-21
arm                  randconfig-004-20260725    clang-21
csky                            allmodconfig    gcc-16.1.0
hexagon                       randconfig-001    gcc-9.5.0
hexagon              randconfig-001-20260725    gcc-9.5.0
hexagon              randconfig-002-20260725    gcc-9.5.0
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260725    clang-22
i386       buildonly-randconfig-002-20260725    clang-22
i386       buildonly-randconfig-003-20260725    clang-22
i386       buildonly-randconfig-004-20260725    clang-22
i386       buildonly-randconfig-005-20260725    clang-22
i386       buildonly-randconfig-006-20260725    clang-22
i386                          randconfig-001    clang-22
i386                 randconfig-001-20260725    clang-22
i386                 randconfig-002-20260725    clang-22
i386                 randconfig-003-20260725    clang-22
i386                 randconfig-004-20260725    clang-22
i386                 randconfig-005-20260725    clang-22
i386                 randconfig-006-20260725    clang-22
i386                 randconfig-007-20260725    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260725    gcc-9.5.0
loongarch            randconfig-002-20260725    gcc-9.5.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260725    gcc-9.5.0
nios2                randconfig-002-20260725    gcc-9.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260725    clang-17
parisc               randconfig-002-20260725    clang-17
powerpc              randconfig-001-20260725    clang-17
powerpc              randconfig-002-20260725    clang-17
powerpc64            randconfig-001-20260725    clang-17
powerpc64            randconfig-002-20260725    clang-17
riscv                randconfig-001-20260725    gcc-10.5.0
riscv                randconfig-002-20260725    gcc-10.5.0
s390                 randconfig-001-20260725    gcc-10.5.0
s390                 randconfig-002-20260725    gcc-10.5.0
sh                                 defconfig    gcc-16.1.0
sh                       edosk7760_defconfig    gcc-16.1.0
sh                   randconfig-001-20260725    gcc-10.5.0
sh                   randconfig-002-20260725    gcc-10.5.0
x86_64     buildonly-randconfig-001-20260725    gcc-12
x86_64     buildonly-randconfig-002-20260725    gcc-12
x86_64     buildonly-randconfig-003-20260725    gcc-12
x86_64     buildonly-randconfig-004-20260725    gcc-12
x86_64     buildonly-randconfig-005-20260725    gcc-12
x86_64     buildonly-randconfig-006-20260725    gcc-12
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    gcc-14
x86_64               randconfig-001-20260725    gcc-14
x86_64               randconfig-002-20260725    gcc-14
x86_64               randconfig-003-20260725    gcc-14
x86_64               randconfig-004-20260725    gcc-14
x86_64               randconfig-005-20260725    gcc-14
x86_64               randconfig-006-20260725    gcc-14
x86_64               randconfig-071-20260725    gcc-14
x86_64               randconfig-072-20260725    gcc-14
x86_64               randconfig-073-20260725    gcc-14
x86_64               randconfig-074-20260725    gcc-14
x86_64               randconfig-075-20260725    gcc-14
x86_64               randconfig-076-20260725    gcc-14
x86_64                          rhel-9.4-bpf    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
