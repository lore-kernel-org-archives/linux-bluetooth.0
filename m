Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794918786;
	b=XeTcxtXLZbhuq2zlaFLQS94FmZSUhSpNip3qdXbOF7MtUUgkJNcmhPut4abUZDICC7Ig
	 8UJOCnCKO7QqqcNucnyzDU9hstKhzwCT2sDK1GmRfMy/HkmX+gpiGXJapPj/rs5KtH7jm
	 czEofpL/QW5CgxQWS7K290r5/ibPLN+viG/2FB/YjWobbRyf8Ihz4Hl4qxdSojvlAI6OI
	 ePczmZ+CryZyXH/ttakzqJf0mXQclfQtqiw1zJ9CtK5mlSDi1K3oIepq4ZFqBEIV1ISHy
	 cs++SF7beq55dv3ETwRELYJCyMmVHC/xVL2D5nEltTBx9urwd3tsqjp+D69SUD7X1pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794918786;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=ONe2Ml1ODqvRE1iV4VBUOqxDZaeq6ZQRulrw1r0MC9M=;
	b=iPWaDNDRi/oyAX0lUctj9KmqFKamAeXSxXCyamNqyrlhn28IXJ42ObwfV9QOBg0UQ0S0
	 g1BR72ddkzci9ZHyuw6M2D412S9ITWHuQTAzkd7TSY2EUZvhwlck2B3KuPRIp42dWUcxI
	 lwZRYINI433c524bIcmmoUVrHa/klPjmhFQzsFC/hQEpzpPquvQp8VF5oanJ+FobKlpBR
	 7CGiUXTHzckll+a2JuBhX5346jt+wsXJAVWMO1DvxhFkoFw/AXAz9xWtTFqOantOZWN81
	 CSW5rPOOYCNGPBAYepd6GEhTzOOUCQzUyn43O8D4NWtFKsVjAc57IiiXSmLURVjEXdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IRiyQn6S;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB67D606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 12:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB67D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IRiyQn6S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794918786; x=1826454786;
  h=date:from:to:cc:subject:message-id;
  bh=2WnBqYJhxCrqwA50t5sen+6yVxSUFG3CcXpcdWXcbco=;
  b=IRiyQn6ShZlCvJBBMcc4XpfkL7Bdb35TA7JHz+Ekdor3BnCJzy2er9NA
   sc7HchqNSDYxKM0upXnIJo/WWPj5OEultDz3DttcjEsCmGjHHFudgx0IH
   aFHnvwLQRqQIWqyV90ZT23NBX4E7ORLnlqp7Cdba0x2F0VWsQzYEdU6zS
   5KP4240Uks9vCXaP1weYZJOJHXuEiCbWQE7wCtvNVkS+gwySjTRX9IAcM
   aPPSfjufnkkKOx7DY5qIEZw4HCbA3EoQpn3NRRkjFt0awWwb/ctyokm4C
   eVB6ggpFO7cjyhTTxcZnVYYY9vfIWowmnuPfg/vtkRwT17dB2N9nZy2fs
   Q==;
X-CSE-ConnectionGUID: aBbbAvRSTXSq6Go1FIHQ+w==
X-CSE-MsgGUID: ThcwXxgyQcW8hmdrylK5og==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3679664"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3679664"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 04:33:00 -0800
X-CSE-ConnectionGUID: KmAzGyUfSKC7/m/hVDxvkg==
X-CSE-MsgGUID: G4pRTALDT6echwDO3Pn+WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10356670"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 17 Nov 2026 04:32:58 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xTIMq-00000001BUz-1fpa;
	Tue, 17 Nov 2026 12:32:56 +0000
Date: Tue, 17 Nov 2026 20:32:49 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 3c5963d23d64972385786e0be47be16d89ff4434
Message-ID: <20261117203249.ZF0fdCkw-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 3c5963d23d64972385786e0be47be16d89ff4434  Merge branch 'bluetooth' into bluetooth-next

elapsed time: 1003m

configs tested: 216
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
arc                               allmodconfig    clang-24
arc                               allmodconfig    gcc-16.2.0
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                          haps_hs_defconfig    gcc-16.2.0
arc                      nsimosci_hs_defconfig    gcc-16.2.0
arc                   randconfig-1000-20261117    gcc-13.5.0
arc                   randconfig-1001-20261117    gcc-13.5.0
arc                            tb10x_defconfig    clang-24
arm                               alldefconfig    gcc-16.2.0
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                       footbridge_defconfig    gcc-16.2.0
arm                       jornada720_defconfig    clang-24
arm                         neponset_defconfig    gcc-16.2.0
arm                          nhk8815_defconfig    clang-24
arm                          orion5x_defconfig    gcc-16.2.0
arm                   randconfig-1000-20261117    gcc-13.5.0
arm                   randconfig-1001-20261117    gcc-13.5.0
arm                   randconfig-1002-20261117    gcc-13.5.0
arm                   randconfig-1003-20261117    gcc-13.5.0
arm                            spitz_defconfig    clang-24
arm                         vexpress_defconfig    gcc-16.2.0
arm64                             alldefconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261117    gcc-16.2.0
arm64                 randconfig-1001-20261117    gcc-16.2.0
arm64                 randconfig-1002-20261117    gcc-16.2.0
arm64                 randconfig-1003-20261117    gcc-16.2.0
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261117    gcc-16.2.0
csky                  randconfig-1001-20261117    gcc-16.2.0
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261117    clang-17
hexagon               randconfig-1001-20261117    clang-17
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261117    clang-22
i386        buildonly-randconfig-1001-20261117    clang-22
i386        buildonly-randconfig-1002-20261117    clang-22
i386        buildonly-randconfig-1003-20261117    clang-22
i386        buildonly-randconfig-1004-20261117    clang-22
i386        buildonly-randconfig-1005-20261117    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261117    gcc-14
i386                  randconfig-1001-20261117    gcc-14
i386                  randconfig-1002-20261117    gcc-14
i386                  randconfig-1003-20261117    gcc-14
i386                  randconfig-1004-20261117    gcc-14
i386                  randconfig-1005-20261117    gcc-14
i386                  randconfig-1006-20261117    gcc-14
i386                  randconfig-1007-20261117    clang-22
i386                  randconfig-1008-20261117    clang-22
i386                  randconfig-1009-20261117    clang-22
i386                  randconfig-1010-20261117    clang-22
i386                  randconfig-1011-20261117    clang-22
i386                  randconfig-1012-20261117    clang-22
i386                  randconfig-1013-20261117    clang-22
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch                 loongson32_defconfig    clang-24
loongarch             randconfig-1000-20261117    clang-17
loongarch             randconfig-1001-20261117    clang-17
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.2.0
m68k                           amiga_defconfig    gcc-16.2.0
m68k                                 defconfig    clang-24
m68k                        m5235evb_defconfig    gcc-16.2.0
m68k                             q40_defconfig    clang-24
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                          bigsur_defconfig    gcc-16.2.0
mips                      cu1830-neo_defconfig    gcc-16.2.0
mips                           eyeq6_defconfig    clang-24
mips                      eyeq6lplus_defconfig    gcc-16.2.0
mips                      loongson2k_defconfig    gcc-16.2.0
mips                       maltaaprp_defconfig    clang-24
mips                       pic32mzda_defconfig    gcc-16.2.0
mips                          rt305x_defconfig    clang-24
mips                            xway_defconfig    gcc-16.2.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261117    clang-17
nios2                 randconfig-1001-20261117    clang-17
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261117    gcc-9.5.0
parisc                randconfig-1001-20261117    gcc-9.5.0
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                      asp8347_defconfig    clang-24
powerpc                        holly_defconfig    clang-24
powerpc                  mpc8313_rdb_defconfig    gcc-16.2.0
powerpc                      mpc83xx_defconfig    gcc-16.2.0
powerpc                       pasemi_defconfig    gcc-16.2.0
powerpc                      powernv_defconfig    gcc-16.2.0
powerpc                        ppc64_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261117    gcc-9.5.0
powerpc               randconfig-1001-20261117    gcc-9.5.0
powerpc                      skiroot_defconfig    clang-24
powerpc                          wii_defconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261117    gcc-9.5.0
powerpc64             randconfig-1001-20261117    gcc-9.5.0
riscv                             alldefconfig    clang-24
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261117    clang-24
riscv                 randconfig-1001-20261117    clang-24
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261117    clang-24
s390                  randconfig-1001-20261117    clang-24
s390                        zfcpdump_defconfig    gcc-16.2.0
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                              espt_defconfig    gcc-16.2.0
sh                    randconfig-1000-20261117    clang-24
sh                    randconfig-1001-20261117    clang-24
sh                           sdk7780_defconfig    gcc-16.2.0
sh                            se7750_defconfig    clang-24
sh                            sh2007_defconfig    clang-24
sh                      sh7710voipgw_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261117    gcc-15.3.0
sparc                 randconfig-1001-20261117    gcc-15.3.0
sparc                        sparc32_defconfig    gcc-16.2.0
sparc                        sparc64_defconfig    clang-24
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261117    gcc-15.3.0
sparc64               randconfig-1001-20261117    gcc-15.3.0
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261117    gcc-15.3.0
um                    randconfig-1001-20261117    gcc-15.3.0
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261117    gcc-13
x86_64      buildonly-randconfig-1001-20261117    gcc-13
x86_64      buildonly-randconfig-1002-20261117    gcc-13
x86_64      buildonly-randconfig-1003-20261117    gcc-13
x86_64      buildonly-randconfig-1004-20261117    gcc-13
x86_64      buildonly-randconfig-1005-20261117    gcc-13
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261117    clang-22
x86_64                randconfig-1001-20261117    clang-22
x86_64                randconfig-1002-20261117    clang-22
x86_64                randconfig-1003-20261117    clang-22
x86_64                randconfig-1004-20261117    clang-22
x86_64                randconfig-1005-20261117    clang-22
x86_64                randconfig-1006-20261117    gcc-14
x86_64                randconfig-1007-20261117    gcc-14
x86_64                randconfig-1008-20261117    gcc-14
x86_64                randconfig-1009-20261117    gcc-14
x86_64                randconfig-1010-20261117    gcc-14
x86_64                randconfig-1011-20261117    gcc-14
x86_64                randconfig-1012-20261117    gcc-14
x86_64                randconfig-1013-20261117    gcc-14
x86_64                randconfig-1014-20261117    gcc-14
x86_64                randconfig-1015-20261117    gcc-14
x86_64                randconfig-1016-20261117    gcc-14
x86_64                randconfig-1017-20261117    gcc-14
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                           iss_defconfig    gcc-16.2.0
xtensa                randconfig-1000-20261117    gcc-15.3.0
xtensa                randconfig-1001-20261117    gcc-15.3.0
xtensa                          virt_defconfig    gcc-16.2.0
xtensa                     xip_kc705_defconfig    gcc-16.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
