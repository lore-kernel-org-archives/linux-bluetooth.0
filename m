Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202DA1A01C6
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jun 2025 14:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749825769; cv=none; b=aOldUe64EKm9GatN2mKT1L+euzVwtQ5WLgRp8V8Q1302bVAzVvYzFdkR8htaUYNMKigrBofLIl6XLUXBLZqPKWzbi9h0mhvuD/Gl2qPmQhjpRRTG3FnuijKqcPInAxfG5T5dSMaG7tlKxwRzRQaDYh0vCvvHD8bSo0uGJsETjh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749825769; c=relaxed/simple;
	bh=2aFf+CzwB5p4fwT+A457jcOCXceYmn4jJDlrm78XIS0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VNHwOa56kgWseP3iMzKTT63nTCTOuhgyZA5XlpJRESIR6qDEn4RWRHQMn4j3fXlLw8b8B/pMnR3yGmMcxiIrF+IFxJ8+YOHUSPi6mvMoTUoU9nqP/HN1icquE4W1eyLrvVm9Y78usIkueKGfFrkA8EgGzHG3CMNcd49MTAQfc08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C2FTxxCC; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C2FTxxCC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749825768; x=1781361768;
  h=date:from:to:cc:subject:message-id;
  bh=2aFf+CzwB5p4fwT+A457jcOCXceYmn4jJDlrm78XIS0=;
  b=C2FTxxCCqij+Blo/lhkWXuqIwhMFPA/qI0nVduh1xahlFH2xkcwFMY/l
   75wM3LxTj0mH3/XEpj2/YsPqCWi3S+WyUq5AiXJvo12rKyDxBGG/A6bh1
   lSsiM3aiU7bu0eW6qoKSbWT7kEDWfoRD+qvg9YFKScNVyixtixMWNmh69
   w33/P6Hm2Fh9KwAoaImFps+mqtX0rQPjIWdPtL4jpgfIrhBrrog7UZxy+
   fCBNxZpRc0tctUCbfbZnW4YqQdfoXCuR8zMCs5sAOHqKpc//lQbJKiPUT
   Qf6aLGVxKwSBAyAG5Gom7wstrOawKxsgK/vqjdZIRR1ftHG1RwoTXG43Y
   A==;
X-CSE-ConnectionGUID: ebpTbiBbTE2kVrR6NYfKwA==
X-CSE-MsgGUID: 9i/yG2thRLa6nOTdzqT+eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="51961555"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="51961555"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 07:42:47 -0700
X-CSE-ConnectionGUID: NpVHefwSQwysaS4i2iZAeg==
X-CSE-MsgGUID: yjPh80OgQCiM8c8V1VrE/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="148736709"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 13 Jun 2025 07:42:45 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uQ5cA-000Ci6-2W;
	Fri, 13 Jun 2025 14:42:42 +0000
Date: Fri, 13 Jun 2025 22:42:30 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 6c31dab4ff1e1f4e0f3412efb1cfc88033358d1f
Message-ID: <202506132220.OKHrD3F2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 6c31dab4ff1e1f4e0f3412efb1cfc88033358d1f  driver: bluetooth: hci_qca:fix unable to load the BT driver

elapsed time: 1449m

configs tested: 98
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20250613    gcc-12.4.0
arc                   randconfig-002-20250613    gcc-12.4.0
arm                               allnoconfig    clang-21
arm                   randconfig-001-20250613    clang-21
arm                   randconfig-002-20250613    clang-20
arm                   randconfig-003-20250613    gcc-7.5.0
arm                   randconfig-004-20250613    clang-21
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250613    gcc-15.1.0
arm64                 randconfig-002-20250613    clang-21
arm64                 randconfig-003-20250613    clang-21
arm64                 randconfig-004-20250613    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250613    gcc-15.1.0
csky                  randconfig-002-20250613    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250613    clang-21
hexagon               randconfig-002-20250613    clang-21
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250612    clang-20
i386        buildonly-randconfig-002-20250612    gcc-12
i386        buildonly-randconfig-003-20250612    clang-20
i386        buildonly-randconfig-004-20250612    clang-20
i386        buildonly-randconfig-005-20250612    clang-20
i386        buildonly-randconfig-006-20250612    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch             randconfig-001-20250613    gcc-15.1.0
loongarch             randconfig-002-20250613    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250613    gcc-11.5.0
nios2                 randconfig-002-20250613    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250613    gcc-7.5.0
parisc                randconfig-002-20250613    gcc-13.3.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250613    clang-21
powerpc               randconfig-002-20250613    gcc-5.5.0
powerpc               randconfig-003-20250613    gcc-9.3.0
powerpc64             randconfig-001-20250613    gcc-6.5.0
powerpc64             randconfig-002-20250613    gcc-5.5.0
powerpc64             randconfig-003-20250613    gcc-10.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250613    gcc-15.1.0
riscv                 randconfig-002-20250613    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250613    clang-21
s390                  randconfig-002-20250613    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250613    gcc-7.5.0
sh                    randconfig-002-20250613    gcc-6.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250613    gcc-10.3.0
sparc                 randconfig-002-20250613    gcc-13.3.0
sparc64               randconfig-001-20250613    gcc-15.1.0
sparc64               randconfig-002-20250613    gcc-6.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250613    gcc-12
um                    randconfig-002-20250613    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250613    clang-20
x86_64      buildonly-randconfig-002-20250613    gcc-12
x86_64      buildonly-randconfig-003-20250613    gcc-12
x86_64      buildonly-randconfig-004-20250613    gcc-12
x86_64      buildonly-randconfig-005-20250613    clang-20
x86_64      buildonly-randconfig-006-20250613    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250613    gcc-15.1.0
xtensa                randconfig-002-20250613    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
