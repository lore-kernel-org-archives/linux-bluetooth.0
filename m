Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AB319580B
	for <linux-bluetooth@vger.kernel.org>; Thu, 31 Oct 2024 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367731; cv=none; b=EfbjyMblJchQpbZ7XWxDkEDiITEL23RGnXAXLYGnbWS7iuKW8huRBx9Qvt0YTNDnrwOnWYiR4NzqmswhAk+GSok5nXKrYIHKx2N+Y5CHST2ttMorFO9GbLTN00UViuPIgHNKFv6wDQgpMEqRQZ521mxL5Szb8RJzIR/1sQkJLTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367731; c=relaxed/simple;
	bh=VCREazrDrGXt49/J8DdEH/vs3isdFDGoTQgns62M+3E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kAM6pD0XuPAyjiQ7jXfY4FrNWPGVL1gcvTuspMwnIA8ve5sk1kG++ywtWVMEVXvT0VvJL7PFaplj9MvuyjE0nv6ORDIX1BQtpWDk8m5cDQIt1159dRrlGzBNUnBIrooM7c7ljdYuMvfoTHSzTKm85ui9EdNljJhjpg9NhtjPz94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OLyZZvKV; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OLyZZvKV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730367729; x=1761903729;
  h=date:from:to:cc:subject:message-id;
  bh=VCREazrDrGXt49/J8DdEH/vs3isdFDGoTQgns62M+3E=;
  b=OLyZZvKVHh0II1upiUVLtDJYSjTaj8HPi03v+J6OGsBA1eEIopuODZBE
   YYQi2Wp/Yj9fZTZvXZLPtz3pm4qLxetMu69sYH5bmV8EsHnZry1mxrNIR
   K+YUq2EhtBwpz6XtbbQKX6/GlIbMMp7EMffk4DG+IA8mS5reBwaY46bv1
   QIBPgVl9Z5uElgzfPX4jWl96ztlQvT1m2qFLTJ3CSs1ZAvwPmofWKMa4T
   37oQLDP6/LBr4I+hbqYpu95H8i2znhqf0wZLZpeFhHJRu4aFe6Ns2r/th
   UvNvmwn+Q2rMj5A9Nxb5mCHGNr3QOqa3Ak3tgd2S8SKfzy7wcowh4W5Mp
   Q==;
X-CSE-ConnectionGUID: Twqqc5lkTfSZnLsn2Jx/cw==
X-CSE-MsgGUID: 87EiSKhjT5e6QW8OBcDsXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="32935647"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="32935647"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 02:42:08 -0700
X-CSE-ConnectionGUID: sZca7E3MR4CfhSFcw5hh+A==
X-CSE-MsgGUID: 2xnEloyxSge+r2FCpS6PQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82502138"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 31 Oct 2024 02:42:07 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6Rgq-000fvY-2Q;
	Thu, 31 Oct 2024 09:42:04 +0000
Date: Thu, 31 Oct 2024 17:41:32 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 af524ed29eee9390eb1a60d7b7b56bc5afe68560
Message-ID: <202410311720.aQTXGxVf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: af524ed29eee9390eb1a60d7b7b56bc5afe68560  Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs

elapsed time: 843m

configs tested: 125
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                 nsimosci_hs_smp_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                        clps711x_defconfig    clang-20
arm                         lpc18xx_defconfig    clang-20
arm                            mmp2_defconfig    gcc-14.1.0
arm                        mvebu_v7_defconfig    gcc-14.1.0
arm                        neponset_defconfig    gcc-14.1.0
arm                            qcom_defconfig    clang-20
arm                         s3c6400_defconfig    gcc-14.1.0
arm                         socfpga_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
hexagon                          alldefconfig    clang-20
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                          amiga_defconfig    gcc-14.1.0
m68k                        stmark2_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                      bmips_stb_defconfig    gcc-14.1.0
mips                            gpr_defconfig    clang-20
mips                          rb532_defconfig    clang-20
mips                         rt305x_defconfig    clang-20
mips                         rt305x_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                     asp8347_defconfig    gcc-14.1.0
powerpc                    gamecube_defconfig    gcc-14.1.0
powerpc                    ge_imp3a_defconfig    clang-20
powerpc                       holly_defconfig    clang-20
powerpc                      mgcoge_defconfig    gcc-14.1.0
powerpc                      pasemi_defconfig    gcc-14.1.0
powerpc                         ps3_defconfig    gcc-14.1.0
powerpc                     tqm8540_defconfig    clang-20
powerpc                     tqm8560_defconfig    clang-20
powerpc                 xes_mpc85xx_defconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                      rts7751r2d1_defconfig    clang-20
sh                           se7721_defconfig    clang-20
sh                   sh7724_generic_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241031    clang-19
x86_64      buildonly-randconfig-002-20241031    clang-19
x86_64      buildonly-randconfig-003-20241031    clang-19
x86_64      buildonly-randconfig-004-20241031    clang-19
x86_64      buildonly-randconfig-005-20241031    clang-19
x86_64      buildonly-randconfig-006-20241031    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241031    clang-19
x86_64                randconfig-002-20241031    clang-19
x86_64                randconfig-003-20241031    clang-19
x86_64                randconfig-004-20241031    clang-19
x86_64                randconfig-005-20241031    clang-19
x86_64                randconfig-006-20241031    clang-19
x86_64                randconfig-011-20241031    clang-19
x86_64                randconfig-012-20241031    clang-19
x86_64                randconfig-013-20241031    clang-19
x86_64                randconfig-014-20241031    clang-19
x86_64                randconfig-015-20241031    clang-19
x86_64                randconfig-016-20241031    clang-19
x86_64                randconfig-071-20241031    clang-19
x86_64                randconfig-072-20241031    clang-19
x86_64                randconfig-073-20241031    clang-19
x86_64                randconfig-074-20241031    clang-19
x86_64                randconfig-075-20241031    clang-19
x86_64                randconfig-076-20241031    clang-19
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0
xtensa                    xip_kc705_defconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
