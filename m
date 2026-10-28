Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793161451;
	b=ZTXAQKskAA4W1ronuRpHeAaPIxxiO1aSFYtdS0sQivhNZo4sUZyJay2aqS3fWjOqGiSR
	 MRsIRtnxvaNqemoj0LvsBtP3Tw0TD2aj1g4G1VdgW2yYhocS2S2mLcMTca0FaeIXBv0vu
	 02y6vb3RMqGJGVRaBrpEeKhWB3DKTl/AoB/p7yHicV5fPCQfY3bghX6v6gmEgge9EYqX8
	 qdI/cpMnbBBajGCZzxs0SMk/KCa+bEz+e3ox4l+ttSUgXBZVH9PuVHm29UgX6Av4NP2zN
	 YM5KFfTl2IHNW10j9aMg1axAUoY+4tNBeD4KFgUO7g1uOo4MuRGmfZXTFN5l38A0rlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793161451;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=dD8W5WBQMPy3ziMZHtMxw8sDTMymrGL8CjNAJn6O79Y=;
	b=ophcz9WPyNrZ9zf7BnG9C1C7R3bzqRgjHgc/U6dKJ9jvEzl2wwriXr8CpijF1cNXE5P7
	 j51X1bdc6hfEzdkkCHAo8fHdJq2IvqOMTdbpaLdnQ1fDHReG/+cYbKAknSE4ib0BP6uh5
	 BC5goeaX7pcv9bKvyHXF63SiUm79Bb4C2f4CbFNFfFEaD5GfVxiBCuLkfW4t6IgizwteH
	 31tTOeqexs1+7NUf6hTJUPMC4ZJ1NbXsvQ5bOmQbTwkklpmArX+xmTlz5VloXfRyN5vY/
	 DwP4r56ZlUK7Qkk0AZJEViap6GTpu9vrYS2xEiv2esf2BceSKpPG10h099bhUhi6ccw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a5E4ALp+;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E86606A31A
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 04:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29E86606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a5E4ALp+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793161448; x=1824697448;
  h=date:from:to:cc:subject:message-id;
  bh=YHS9p34t2Rx8z2ENOadIhF/GZaFJbnINd0id5lza5Lo=;
  b=a5E4ALp+3S32KPwQ5DyKxGfdSmaqznM4i3n3vU0ufNvZtFyllVGPm8TO
   aEBQTcGvzeShUW7Jw9xZF5LJ0hFsUU/fQPfle97QAvlIxnF4rcTblmvCL
   n5DN8gthIGJ6AIQGa1wtB5OoP14Srcu3ORshdGJWR/0W+0nu15Y/lPI8o
   1Pm3GXoccHw+X8Accp0Y8m2Brk0eg4hgZdIQE5iiTBBiEvvYu517/r5ho
   zplu3cKfmjrNCoy/14XooB44CQ/Bw5cNCoH0Itenm9iWkN7yDnTektBSu
   siyJ6O4BbSac+1E/XP8ZmOTd77lYShquwjUdY3qMc8qaVyajic1uHH7CX
   g==;
X-CSE-ConnectionGUID: lK2ZJ6sVTBaDOTQKy8YR3Q==
X-CSE-MsgGUID: Ipx+6bA8SgSEtGq8rEjtVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1776278"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1776278"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 21:24:07 -0700
X-CSE-ConnectionGUID: Ww4uguacSASmuzKybtApHQ==
X-CSE-MsgGUID: lj1a64+dQjy1qQ03eurTHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4750468"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 27 Oct 2026 21:24:07 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xLvCl-00000000YAM-3tDc;
	Wed, 28 Oct 2026 04:24:03 +0000
Date: Wed, 28 Oct 2026 12:24:03 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 27731ba091954eccddb2657053b590d2113e8d98
Message-ID: <202610281200.iYCZUHdv-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 27731ba091954eccddb2657053b590d2113e8d98  Merge branch 'bluetooth' into bluetooth-next

elapsed time: 9747m

configs tested: 480
configs skipped: 25

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
arc                               allyesconfig    gcc-16.2.0
arc                           axs103_defconfig    gcc-16.2.0
arc                                  defconfig    gcc-16.2.0
arc                      nsimosci_hs_defconfig    gcc-16.2.0
arc                   randconfig-1000-20261023    gcc-14.4.0
arc                   randconfig-1000-20261024    clang-24
arc                   randconfig-1001-20261023    gcc-14.4.0
arc                   randconfig-1001-20261024    clang-24
arc                   randconfig-2000-20261021    clang-24
arc                   randconfig-2001-20261021    clang-24
arc                  randconfig-r2109-20261021    gcc-8.5.0  cocci
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                               allyesconfig    gcc-16.2.0
arm                                  defconfig    gcc-16.2.0
arm                       integrator_defconfig    gcc-16.2.0
arm                    milbeaut_m10v_defconfig    gcc-16.2.0
arm                         mvebu_v7_defconfig    gcc-16.2.0
arm                          nhk8815_defconfig    clang-24
arm                   randconfig-1000-20261023    gcc-14.4.0
arm                   randconfig-1000-20261024    clang-24
arm                   randconfig-1001-20261023    gcc-14.4.0
arm                   randconfig-1001-20261024    clang-24
arm                   randconfig-1002-20261023    gcc-14.4.0
arm                   randconfig-1002-20261024    clang-24
arm                   randconfig-1003-20261023    gcc-14.4.0
arm                   randconfig-1003-20261024    clang-24
arm                   randconfig-2000-20261021    clang-24
arm                   randconfig-2001-20261021    clang-24
arm                  randconfig-r2200-20261021    gcc-10.5.0 smatch
arm                  randconfig-r2202-20261021    gcc-13.5.0 smatch
arm                          s5pv210_defconfig    gcc-16.2.0
arm                            sama5_defconfig    clang-19
arm                          socfpga_defconfig    gcc-16.2.0
arm                           sp7021_defconfig    clang-24
arm                        spear13xx_defconfig    gcc-16.2.0
arm                         spear6xx_defconfig    gcc-16.2.0
arm                            stm32_defconfig    gcc-16.2.0
arm                         vexpress_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261023    gcc-8.5.0
arm64                 randconfig-1000-20261024    gcc-10.5.0
arm64                 randconfig-1001-20261023    gcc-8.5.0
arm64                 randconfig-1001-20261024    gcc-10.5.0
arm64                 randconfig-1002-20261023    gcc-8.5.0
arm64                 randconfig-1002-20261024    gcc-10.5.0
arm64                 randconfig-1003-20261023    gcc-8.5.0
arm64                 randconfig-1003-20261024    gcc-10.5.0
arm64                 randconfig-2000-20261021    clang-24
arm64                 randconfig-2001-20261021    clang-24
arm64                randconfig-r2105-20261021    clang-24   cocci
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261023    gcc-8.5.0
csky                  randconfig-1000-20261024    gcc-10.5.0
csky                  randconfig-1001-20261023    gcc-8.5.0
csky                  randconfig-1001-20261024    gcc-10.5.0
csky                  randconfig-2000-20261021    clang-24
csky                  randconfig-2001-20261021    clang-24
csky                 randconfig-r2101-20261021    gcc-8.5.0  cocci
csky                 randconfig-r2300-20261021    clang-22   sparse
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261023    clang-17
hexagon               randconfig-1000-20261024    clang-24
hexagon               randconfig-1001-20261023    clang-17
hexagon               randconfig-1001-20261024    clang-24
hexagon               randconfig-2000-20261021    clang-24
hexagon               randconfig-2001-20261021    clang-24
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261023    clang-22
i386        buildonly-randconfig-1000-20261024    clang-22
i386        buildonly-randconfig-1001-20261023    clang-22
i386        buildonly-randconfig-1001-20261024    clang-22
i386        buildonly-randconfig-1002-20261023    clang-22
i386        buildonly-randconfig-1002-20261024    clang-22
i386        buildonly-randconfig-1003-20261023    clang-22
i386        buildonly-randconfig-1003-20261024    clang-22
i386        buildonly-randconfig-1004-20261023    clang-22
i386        buildonly-randconfig-1004-20261024    clang-22
i386        buildonly-randconfig-1005-20261023    clang-22
i386        buildonly-randconfig-1005-20261024    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261022    gcc-13
i386                  randconfig-1000-20261023    gcc-14
i386                  randconfig-1000-20261024    clang-22
i386                  randconfig-1001-20261022    gcc-13
i386                  randconfig-1001-20261023    gcc-14
i386                  randconfig-1001-20261024    clang-22
i386                  randconfig-1002-20261022    gcc-13
i386                  randconfig-1002-20261023    gcc-14
i386                  randconfig-1002-20261024    clang-22
i386                  randconfig-1003-20261022    gcc-13
i386                  randconfig-1003-20261023    gcc-14
i386                  randconfig-1003-20261024    clang-22
i386                  randconfig-1004-20261022    gcc-13
i386                  randconfig-1004-20261023    gcc-14
i386                  randconfig-1004-20261024    clang-22
i386                  randconfig-1005-20261022    gcc-13
i386                  randconfig-1005-20261023    gcc-14
i386                  randconfig-1005-20261024    clang-22
i386                  randconfig-1006-20261022    gcc-13
i386                  randconfig-1006-20261023    gcc-14
i386                  randconfig-1006-20261024    clang-22
i386                  randconfig-1007-20261022    clang-22
i386                  randconfig-1007-20261023    clang-22
i386                  randconfig-1007-20261024    gcc-14
i386                  randconfig-1008-20261022    clang-22
i386                  randconfig-1008-20261023    clang-22
i386                  randconfig-1008-20261024    gcc-14
i386                  randconfig-1009-20261022    clang-22
i386                  randconfig-1009-20261023    clang-22
i386                  randconfig-1009-20261024    gcc-14
i386                  randconfig-1010-20261022    clang-22
i386                  randconfig-1010-20261023    clang-22
i386                  randconfig-1010-20261024    gcc-14
i386                  randconfig-1011-20261022    clang-22
i386                  randconfig-1011-20261023    clang-22
i386                  randconfig-1011-20261024    gcc-14
i386                  randconfig-1012-20261022    clang-22
i386                  randconfig-1012-20261023    clang-22
i386                  randconfig-1012-20261024    gcc-14
i386                  randconfig-1013-20261022    clang-22
i386                  randconfig-1013-20261023    clang-22
i386                  randconfig-1013-20261024    gcc-14
i386                  randconfig-2000-20261021    clang-24
i386                  randconfig-2001-20261021    clang-24
i386                  randconfig-2100-20261021    gcc-14     cocci
i386                  randconfig-2101-20261021    gcc-14     cocci
i386                  randconfig-2102-20261021    gcc-14     cocci
i386                  randconfig-2103-20261021    gcc-14     cocci
i386                  randconfig-2104-20261021    gcc-14     cocci
i386                  randconfig-2105-20261021    gcc-14     cocci
i386                  randconfig-2200-20261021    clang-22   smatch
i386                  randconfig-2300-20261021    clang-22   sparse
i386                  randconfig-2301-20261021    clang-22   sparse
i386                  randconfig-2302-20261021    clang-22   sparse
i386                 randconfig-r2104-20261021    clang-24   cocci
loongarch                         alldefconfig    gcc-16.2.0
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch                 loongson32_defconfig    gcc-11.5.0
loongarch             randconfig-1000-20261023    clang-17
loongarch             randconfig-1000-20261024    clang-24
loongarch             randconfig-1001-20261023    clang-17
loongarch             randconfig-1001-20261024    clang-24
loongarch             randconfig-2000-20261021    gcc-11.5.0
loongarch             randconfig-2001-20261021    gcc-11.5.0
loongarch            randconfig-r2106-20261021    clang-24   cocci
m68k                              alldefconfig    gcc-16.2.0
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.2.0
m68k                        bvme6000_defconfig    gcc-16.2.0
m68k                                 defconfig    clang-24
m68k                           hp300_defconfig    gcc-16.2.0
m68k                        m5275evb_defconfig    gcc-16.2.0
m68k                             mac_defconfig    gcc-16.2.0
m68k                           multi_defconfig    gcc-16.2.0
m68k                             q40_defconfig    gcc-16.2.0
m68k                 randconfig-r2102-20261021    gcc-8.5.0  cocci
m68k                            sun3_defconfig    clang-17
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                       bmips_stb_defconfig    clang-24
mips                   cavium_octeon_defconfig    gcc-16.2.0
mips                            ci20_defconfig    gcc-16.2.0
mips                      eyeq6lplus_defconfig    gcc-16.2.0
mips                        lemote2f_defconfig    gcc-16.2.0
mips                           malta_defconfig    gcc-11.5.0
mips                 malta_qemu_32r6_defconfig    gcc-16.2.0
mips                       maltaaprp_defconfig    clang-17
mips                     maltaup_xpa_defconfig    gcc-11.5.0
mips                         omega2p_defconfig    clang-19
mips                         omega2p_defconfig    gcc-16.2.0
mips                 randconfig-r2111-20261021    clang-24   cocci
mips                        rbtx49xx_defconfig    clang-24
mips                           rm200_defconfig    gcc-16.2.0
mips                    sb1250_swarm_defconfig    gcc-16.2.0
mips                            xway_defconfig    clang-17
nios2                             alldefconfig    gcc-11.5.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261023    clang-17
nios2                 randconfig-1000-20261024    clang-24
nios2                 randconfig-1001-20261023    clang-17
nios2                 randconfig-1001-20261024    clang-24
nios2                 randconfig-2000-20261021    gcc-11.5.0
nios2                 randconfig-2001-20261021    gcc-11.5.0
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                            allyesconfig    gcc-16.2.0
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261023    gcc-15.3.0
parisc                randconfig-1000-20261024    clang-24
parisc                randconfig-1001-20261023    gcc-15.3.0
parisc                randconfig-1001-20261024    clang-24
parisc                randconfig-2000-20261021    gcc-11.5.0
parisc                randconfig-2001-20261021    gcc-11.5.0
parisc               randconfig-r2301-20261021    clang-22   sparse
parisc64                          alldefconfig    clang-17
parisc64                             defconfig    clang-24
powerpc                     adder875_defconfig    gcc-16.2.0
powerpc                      akebono_defconfig    gcc-16.2.0
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                     amigaone_defconfig    gcc-16.2.0
powerpc                       arches_defconfig    gcc-16.2.0
powerpc                      asp8347_defconfig    gcc-16.2.0
powerpc                       chrp32_defconfig    gcc-16.2.0
powerpc                        ebony_defconfig    gcc-11.5.0
powerpc                         fsp2_defconfig    gcc-16.2.0
powerpc                           g5_defconfig    clang-24
powerpc                     gamecube_defconfig    clang-19
powerpc                     ge_imp3a_defconfig    gcc-16.2.0
powerpc                         icon_defconfig    clang-24
powerpc                   iss476-smp_defconfig    gcc-16.2.0
powerpc                    lite5200b_defconfig    clang-24
powerpc                      mpc512x_defconfig    gcc-11.5.0
powerpc                       pmac32_defconfig    gcc-16.2.0
powerpc                          ps3_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261023    gcc-15.3.0
powerpc               randconfig-1000-20261024    clang-24
powerpc               randconfig-1001-20261023    gcc-15.3.0
powerpc               randconfig-1001-20261024    clang-24
powerpc               randconfig-2000-20261021    clang-24
powerpc               randconfig-2001-20261021    clang-24
powerpc                     sam440ep_defconfig    clang-17
powerpc                      skiroot_defconfig    gcc-11.5.0
powerpc                          wii_defconfig    gcc-16.2.0
powerpc64                         alldefconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261023    gcc-15.3.0
powerpc64             randconfig-1000-20261024    clang-24
powerpc64             randconfig-1001-20261023    gcc-15.3.0
powerpc64             randconfig-1001-20261024    clang-24
powerpc64             randconfig-2000-20261021    clang-24
powerpc64             randconfig-2001-20261021    clang-24
powerpc64            randconfig-r2103-20261021    gcc-8.5.0  cocci
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv              nommu_k210_sdcard_defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261022    gcc-13.5.0
riscv                 randconfig-1000-20261023    gcc-16.2.0
riscv                 randconfig-1000-20261024    gcc-11.5.0
riscv                 randconfig-1001-20261022    gcc-13.5.0
riscv                 randconfig-1001-20261023    gcc-16.2.0
riscv                 randconfig-1001-20261024    gcc-11.5.0
riscv                 randconfig-2000-20261021    clang-18
riscv                 randconfig-2001-20261021    clang-18
riscv                         rzfive_defconfig    gcc-16.2.0
s390                              alldefconfig    gcc-16.2.0
s390                              allmodconfig    clang-17
s390                              allmodconfig    gcc-16.2.0
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261022    gcc-13.5.0
s390                  randconfig-1000-20261023    gcc-16.2.0
s390                  randconfig-1000-20261024    gcc-11.5.0
s390                  randconfig-1001-20261022    gcc-13.5.0
s390                  randconfig-1001-20261023    gcc-16.2.0
s390                  randconfig-1001-20261024    gcc-11.5.0
s390                  randconfig-2000-20261021    clang-18
s390                  randconfig-2001-20261021    clang-18
s390                 randconfig-r2110-20261021    clang-24   cocci
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                allyesconfig    gcc-16.2.0
sh                          apsh4a3a_defconfig    clang-17
sh                                   defconfig    gcc-14
sh                         edosk7705_defconfig    gcc-16.2.0
sh                                j2_defconfig    gcc-16.2.0
sh                             migor_defconfig    gcc-16.2.0
sh                    randconfig-1000-20261022    gcc-13.5.0
sh                    randconfig-1000-20261023    gcc-16.2.0
sh                    randconfig-1000-20261024    gcc-11.5.0
sh                    randconfig-1001-20261022    gcc-13.5.0
sh                    randconfig-1001-20261023    gcc-16.2.0
sh                    randconfig-1001-20261024    gcc-11.5.0
sh                    randconfig-2000-20261021    clang-18
sh                    randconfig-2001-20261021    clang-18
sh                   randconfig-r2107-20261021    clang-24   cocci
sh                   randconfig-r2304-20261021    clang-22   sparse
sh                           rsk7201_defconfig    gcc-16.2.0
sh                           rsk7269_defconfig    gcc-16.2.0
sh                           sdk7786_defconfig    gcc-16.2.0
sh                            se7343_defconfig    gcc-16.2.0
sh                            se7712_defconfig    gcc-16.2.0
sh                            se7722_defconfig    gcc-16.2.0
sh                            se7724_defconfig    gcc-11.5.0
sh                            se7724_defconfig    gcc-16.2.0
sh                              sh03_defconfig    clang-19
sh                            sh2007_defconfig    gcc-16.2.0
sh                    sh7724_generic_defconfig    gcc-16.2.0
sh                         sh7757lcr_defconfig    clang-24
sh                   sh7785lcr_32bit_defconfig    gcc-16.2.0
sh                         sh7785lcr_defconfig    gcc-16.2.0
sh                             shmin_defconfig    gcc-16.2.0
sh                              shx3_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261022    gcc-12
sparc                 randconfig-1000-20261023    clang-24
sparc                 randconfig-1000-20261024    gcc-14
sparc                 randconfig-1001-20261022    gcc-12
sparc                 randconfig-1001-20261023    clang-24
sparc                 randconfig-1001-20261024    gcc-14
sparc                 randconfig-2000-20261021    gcc-16.2.0
sparc                 randconfig-2001-20261021    gcc-16.2.0
sparc                        sparc32_defconfig    clang-19
sparc                        sparc32_defconfig    gcc-16.2.0
sparc                        sparc64_defconfig    gcc-16.2.0
sparc64                           alldefconfig    gcc-16.2.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261022    gcc-12
sparc64               randconfig-1000-20261023    clang-24
sparc64               randconfig-1000-20261024    gcc-14
sparc64               randconfig-1001-20261022    gcc-12
sparc64               randconfig-1001-20261023    clang-24
sparc64               randconfig-1001-20261024    gcc-14
sparc64               randconfig-2000-20261021    gcc-16.2.0
sparc64               randconfig-2001-20261021    gcc-16.2.0
sparc64              randconfig-r2305-20261021    clang-22   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261022    gcc-12
um                    randconfig-1000-20261023    clang-24
um                    randconfig-1000-20261024    gcc-14
um                    randconfig-1001-20261022    gcc-12
um                    randconfig-1001-20261023    clang-24
um                    randconfig-1001-20261024    gcc-14
um                    randconfig-2000-20261021    gcc-16.2.0
um                    randconfig-2001-20261021    gcc-16.2.0
um                   randconfig-r2201-20261021    clang-24   smatch
um                   randconfig-r2303-20261021    clang-22   sparse
um                            x86_64_defconfig    clang-19
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261022    gcc-14
x86_64      buildonly-randconfig-1000-20261023    clang-22
x86_64      buildonly-randconfig-1000-20261024    gcc-14
x86_64      buildonly-randconfig-1001-20261022    gcc-14
x86_64      buildonly-randconfig-1001-20261023    clang-22
x86_64      buildonly-randconfig-1001-20261024    gcc-14
x86_64      buildonly-randconfig-1002-20261022    gcc-14
x86_64      buildonly-randconfig-1002-20261023    clang-22
x86_64      buildonly-randconfig-1002-20261024    gcc-14
x86_64      buildonly-randconfig-1003-20261022    gcc-14
x86_64      buildonly-randconfig-1003-20261023    clang-22
x86_64      buildonly-randconfig-1003-20261024    gcc-14
x86_64      buildonly-randconfig-1004-20261022    gcc-14
x86_64      buildonly-randconfig-1004-20261023    clang-22
x86_64      buildonly-randconfig-1004-20261024    gcc-14
x86_64      buildonly-randconfig-1005-20261022    gcc-14
x86_64      buildonly-randconfig-1005-20261023    clang-22
x86_64      buildonly-randconfig-1005-20261024    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261022    clang-22
x86_64                randconfig-1000-20261023    gcc-14
x86_64                randconfig-1000-20261024    gcc-14
x86_64                randconfig-1001-20261022    clang-22
x86_64                randconfig-1001-20261023    gcc-14
x86_64                randconfig-1001-20261024    gcc-14
x86_64                randconfig-1002-20261022    clang-22
x86_64                randconfig-1002-20261023    gcc-14
x86_64                randconfig-1002-20261024    gcc-14
x86_64                randconfig-1003-20261022    clang-22
x86_64                randconfig-1003-20261023    gcc-14
x86_64                randconfig-1003-20261024    gcc-14
x86_64                randconfig-1004-20261022    clang-22
x86_64                randconfig-1004-20261023    gcc-14
x86_64                randconfig-1004-20261024    gcc-14
x86_64                randconfig-1005-20261022    clang-22
x86_64                randconfig-1005-20261023    gcc-14
x86_64                randconfig-1005-20261024    gcc-14
x86_64                randconfig-1006-20261022    clang-22
x86_64                randconfig-1006-20261023    gcc-14
x86_64                randconfig-1006-20261024    gcc-13
x86_64                randconfig-1007-20261022    clang-22
x86_64                randconfig-1007-20261023    gcc-14
x86_64                randconfig-1007-20261024    gcc-13
x86_64                randconfig-1008-20261022    clang-22
x86_64                randconfig-1008-20261023    gcc-14
x86_64                randconfig-1008-20261024    gcc-13
x86_64                randconfig-1009-20261022    clang-22
x86_64                randconfig-1009-20261023    gcc-14
x86_64                randconfig-1009-20261024    gcc-13
x86_64                randconfig-1010-20261022    clang-22
x86_64                randconfig-1010-20261023    gcc-14
x86_64                randconfig-1010-20261024    gcc-13
x86_64                randconfig-1011-20261022    clang-22
x86_64                randconfig-1011-20261023    gcc-14
x86_64                randconfig-1011-20261024    gcc-13
x86_64                randconfig-1012-20261023    clang-22
x86_64                randconfig-1012-20261024    clang-22
x86_64                randconfig-1013-20261023    clang-22
x86_64                randconfig-1013-20261024    clang-22
x86_64                randconfig-1014-20261023    clang-22
x86_64                randconfig-1014-20261024    clang-22
x86_64                randconfig-1015-20261023    clang-22
x86_64                randconfig-1015-20261024    clang-22
x86_64                randconfig-1016-20261023    clang-22
x86_64                randconfig-1016-20261024    clang-22
x86_64                randconfig-1017-20261023    clang-22
x86_64                randconfig-1017-20261024    clang-22
x86_64                randconfig-2000-20261021    clang-24
x86_64                randconfig-2001-20261021    clang-24
x86_64                randconfig-2100-20261021    clang-22   cocci
x86_64                randconfig-2101-20261021    clang-22   cocci
x86_64                randconfig-2102-20261021    clang-22   cocci
x86_64                randconfig-2103-20261021    clang-22   cocci
x86_64                randconfig-2104-20261021    clang-22   cocci
x86_64                randconfig-2105-20261021    clang-22   cocci
x86_64                randconfig-2200-20261021    clang-22   smatch
x86_64                randconfig-2300-20261021    clang-22   sparse
x86_64                randconfig-2301-20261021    clang-22   sparse
x86_64                randconfig-2302-20261021    clang-22   sparse
x86_64               randconfig-r2302-20261021    clang-22   sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                            alldefconfig    gcc-16.2.0
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                   cadence_csp_defconfig    clang-17
xtensa                 generic_kc705_defconfig    gcc-16.2.0
xtensa                randconfig-1000-20261022    gcc-12
xtensa                randconfig-1000-20261023    clang-24
xtensa                randconfig-1000-20261024    gcc-14
xtensa                randconfig-1001-20261022    gcc-12
xtensa                randconfig-1001-20261023    clang-24
xtensa                randconfig-1001-20261024    gcc-14
xtensa                randconfig-2000-20261021    gcc-16.2.0
xtensa                randconfig-2001-20261021    gcc-16.2.0
xtensa               randconfig-r2100-20261021    gcc-8.5.0  cocci
xtensa               randconfig-r2108-20261021    gcc-8.5.0  cocci

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
