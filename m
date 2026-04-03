Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B5421A447
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 12:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775217943; cv=none; b=NZjQirnwLf4rr0nZ2LbIOy6JHG2LS11cPBv3SArG5LmRfe64NNH6qf0jdfEignE5HySJYbcRRHpCku7NuxyIgA8BHyX+fORU02t00y93RzMohgYDE6mToPDkWoUrNDmHiFMbc8bCKXnVHOHL3Jp83LJ2krmmnhQwaqQJVJHoRJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775217943; c=relaxed/simple;
	bh=VXwgY1lM9kxq3Rx7gei645vjs6rDBBJSXZYxTMiEqaU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dwvn9jCyHqCx8NlWFwXGrC/eF2LobK3n1hfKCG/IH7CEssih14xxt7u+biQdFykTx/zlZhseQu1LlkzE9K3D9GwsjgGmWiP29jIJmsU8zwx6RPkG3ZhgZajine20C3zJ9rWBlMwFgR+oKkwLZ8/p468w+xpmKbh7nMzyc66/SXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TJ7LAs2V; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TJ7LAs2V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775217941; x=1806753941;
  h=date:from:to:cc:subject:message-id;
  bh=VXwgY1lM9kxq3Rx7gei645vjs6rDBBJSXZYxTMiEqaU=;
  b=TJ7LAs2V8smBBvxhO+eYBuv1bCSUA7wSGtvja2fMPEWVyfjx/YQ4KXvw
   zTJCpJkA/ZhMJUiO/YJbAjK6SgFUDZM7yr/0OzHIs79eaKSq5qiVIitsg
   WmzjRojljtiJxIJaiVJZ6BktYllb9rJZicskzvfs3lsg6TZDuM4sVJDxQ
   jyj8bvUQx7SNnt9t6Jhf88aIos6Pwfpctmj36mlIRXHGrtspeEMsc02od
   aj8/3F1HQ6Pg0dabdzjA5LvgqCuLapaPhZX34W+NN6aJpahqVPGHqCRre
   ZjWyiGywoQcfT3W2jyorAmmTbz21ONahMuNsf9PPX0llEzbqVUMeidv95
   A==;
X-CSE-ConnectionGUID: oNrT5T9+RuSmHUoMCmiR/Q==
X-CSE-MsgGUID: Bcz2aahdT1uMbv46qXNbVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76165022"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="76165022"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 05:05:41 -0700
X-CSE-ConnectionGUID: ClaAcnd8QtqPb1aYdR0S2g==
X-CSE-MsgGUID: allAQ6dWRiqVd19KuyqVcw==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 0f5e2a219720) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 03 Apr 2026 05:05:39 -0700
Received: from kbuild by 0f5e2a219720 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w8dHM-0000000004d-3pRt;
	Fri, 03 Apr 2026 12:05:36 +0000
Date: Fri, 03 Apr 2026 20:04:55 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 60f6ea0dbe1a7d2c8999162153acdcaeddf196c4
Message-ID: <202604032046.NMiALOZw-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 60f6ea0dbe1a7d2c8999162153acdcaeddf196c4  Bluetooth: hci_ll: Enable BROKEN_ENHANCED_SETUP_SYNC_CONN for WL183x

elapsed time: 938m

configs tested: 213
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                   randconfig-001-20260403    gcc-10.5.0
arc                   randconfig-001-20260403    gcc-8.5.0
arc                   randconfig-002-20260403    gcc-10.5.0
arc                   randconfig-002-20260403    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    gcc-15.2.0
arm                         orion5x_defconfig    clang-23
arm                   randconfig-001-20260403    clang-23
arm                   randconfig-001-20260403    gcc-10.5.0
arm                   randconfig-002-20260403    gcc-10.5.0
arm                   randconfig-003-20260403    gcc-10.5.0
arm                   randconfig-003-20260403    gcc-15.2.0
arm                   randconfig-004-20260403    gcc-10.5.0
arm                   randconfig-004-20260403    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260403    gcc-13.4.0
arm64                 randconfig-001-20260403    gcc-8.5.0
arm64                 randconfig-002-20260403    clang-23
arm64                 randconfig-002-20260403    gcc-13.4.0
arm64                 randconfig-003-20260403    gcc-13.4.0
arm64                 randconfig-003-20260403    gcc-8.5.0
arm64                 randconfig-004-20260403    clang-17
arm64                 randconfig-004-20260403    gcc-13.4.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-001-20260403    gcc-13.4.0
csky                  randconfig-001-20260403    gcc-9.5.0
csky                  randconfig-002-20260403    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon               randconfig-001-20260403    clang-23
hexagon               randconfig-002-20260403    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260403    gcc-14
i386        buildonly-randconfig-002-20260403    clang-20
i386        buildonly-randconfig-002-20260403    gcc-14
i386        buildonly-randconfig-003-20260403    gcc-14
i386        buildonly-randconfig-004-20260403    gcc-14
i386        buildonly-randconfig-005-20260403    gcc-14
i386        buildonly-randconfig-006-20260403    gcc-14
i386                  randconfig-001-20260403    gcc-14
i386                  randconfig-002-20260403    gcc-14
i386                  randconfig-003-20260403    gcc-14
i386                  randconfig-004-20260403    gcc-14
i386                  randconfig-005-20260403    gcc-14
i386                  randconfig-006-20260403    gcc-14
i386                  randconfig-007-20260403    gcc-14
i386                  randconfig-011-20260403    clang-20
i386                  randconfig-011-20260403    gcc-14
i386                  randconfig-012-20260403    clang-20
i386                  randconfig-013-20260403    clang-20
i386                  randconfig-014-20260403    clang-20
i386                  randconfig-015-20260403    clang-20
i386                  randconfig-016-20260403    clang-20
i386                  randconfig-016-20260403    gcc-14
i386                  randconfig-017-20260403    clang-20
i386                  randconfig-017-20260403    gcc-13
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260403    clang-23
loongarch             randconfig-002-20260403    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                      fuloong2e_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260403    gcc-8.5.0
nios2                 randconfig-002-20260403    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260403    gcc-10.5.0
parisc                randconfig-001-20260403    gcc-11.5.0
parisc                randconfig-002-20260403    gcc-10.5.0
parisc                randconfig-002-20260403    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260403    clang-23
powerpc               randconfig-001-20260403    gcc-10.5.0
powerpc               randconfig-002-20260403    gcc-10.5.0
powerpc               randconfig-002-20260403    gcc-13.4.0
powerpc64             randconfig-001-20260403    clang-23
powerpc64             randconfig-001-20260403    gcc-10.5.0
powerpc64             randconfig-002-20260403    gcc-10.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260403    clang-23
riscv                 randconfig-001-20260403    gcc-10.5.0
riscv                 randconfig-002-20260403    clang-23
riscv                 randconfig-002-20260403    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260403    clang-23
s390                  randconfig-002-20260403    clang-18
s390                  randconfig-002-20260403    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260403    clang-23
sh                    randconfig-001-20260403    gcc-13.4.0
sh                    randconfig-002-20260403    clang-23
sh                    randconfig-002-20260403    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260403    gcc-8.5.0
sparc                 randconfig-002-20260403    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260403    gcc-15.2.0
sparc64               randconfig-002-20260403    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260403    clang-20
um                    randconfig-002-20260403    gcc-14
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260403    clang-20
x86_64      buildonly-randconfig-002-20260403    clang-20
x86_64      buildonly-randconfig-003-20260403    clang-20
x86_64      buildonly-randconfig-004-20260403    clang-20
x86_64      buildonly-randconfig-005-20260403    clang-20
x86_64      buildonly-randconfig-006-20260403    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260403    clang-20
x86_64                randconfig-001-20260403    gcc-14
x86_64                randconfig-002-20260403    clang-20
x86_64                randconfig-003-20260403    clang-20
x86_64                randconfig-003-20260403    gcc-13
x86_64                randconfig-004-20260403    clang-20
x86_64                randconfig-005-20260403    clang-20
x86_64                randconfig-005-20260403    gcc-13
x86_64                randconfig-006-20260403    clang-20
x86_64                randconfig-011-20260403    gcc-14
x86_64                randconfig-012-20260403    gcc-14
x86_64                randconfig-013-20260403    gcc-14
x86_64                randconfig-014-20260403    gcc-14
x86_64                randconfig-015-20260403    gcc-14
x86_64                randconfig-016-20260403    gcc-14
x86_64                randconfig-071-20260403    gcc-14
x86_64                randconfig-072-20260403    gcc-14
x86_64                randconfig-073-20260403    gcc-14
x86_64                randconfig-074-20260403    gcc-14
x86_64                randconfig-075-20260403    clang-20
x86_64                randconfig-075-20260403    gcc-14
x86_64                randconfig-076-20260403    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260403    gcc-9.5.0
xtensa                randconfig-002-20260403    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
