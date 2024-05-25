Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D2B4AEF8
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 May 2024 18:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716662573; cv=none; b=KmCcP/7rVfPiuxtKNworWqwHbcznVhUCYU9VFgg0nhD/TIsw+lnC11lFA7lXicIkmul0KVuzbO0u6IZr75FBfOUVzPeBZltwVcswARi6tBR1FSJFOB4M9ijHIniCYoyuVoY03MgyjjYqqOj19RXo03AumJx7J4aX7Q/99wzcuIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716662573; c=relaxed/simple;
	bh=+bLBiD2C3fu0KAIROrvDsfXNma9kKzPx9/pn6uQUsTo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=o7Wee8cErjkzV4pgCbRLHH+vkvrRw+XSwzETjbmyBIIngjoUlc8RLAqo1/7faV3NWfhfpVQ+MWTDqDIxbWzcTJawBT6yP9sunHrq4vIV86YvM5mxLyK9OA0uTvHIWjKInlaeI/wk7rm2W8zBJUsTnPzSeZq6GjDOTi8YbilN+6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zph14me2; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zph14me2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716662572; x=1748198572;
  h=date:from:to:cc:subject:message-id;
  bh=+bLBiD2C3fu0KAIROrvDsfXNma9kKzPx9/pn6uQUsTo=;
  b=Zph14me2MaAI/1dME0iPB6vs0/VXTrCNkAhiF3YQLnyXr5v4sSPIlweb
   E92r25UYwuwIZBq0JJIdqJSkfXNHMeVrGVBN1FXXm489Zjub5itGCeLKf
   wy4jbfx9zVkj8lu8kKMa0KjByS5e6uxQSwJhwwz8zVaHISKK5UeXgtax6
   /0Fqw2bEMjHgisngGN3sJvsmSldhBfFInTZlHqJ0B1Jrs27oI5z3B/uuT
   z7YEIXg/DBGZMzHvDdnOyWPbbK0c4zDhs+HitzC56Iv/+5L+rhr4e8tG9
   OXU+bs11poUmZCihN8+JgnOJeec+KosT3Ptuc3FOgoPAxuktwTi2HEukY
   Q==;
X-CSE-ConnectionGUID: aGRg2efoRF2hkSbTocvLcw==
X-CSE-MsgGUID: bRGr66L1Qf2xBsoOt8gddw==
X-IronPort-AV: E=McAfee;i="6600,9927,11083"; a="16853767"
X-IronPort-AV: E=Sophos;i="6.08,188,1712646000"; 
   d="scan'208";a="16853767"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2024 11:42:52 -0700
X-CSE-ConnectionGUID: wgeZ/iARQNmlUPJKXK5+hQ==
X-CSE-MsgGUID: oRN4ZfnDQRCqI8jwOZEXbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,188,1712646000"; 
   d="scan'208";a="34322389"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 25 May 2024 11:42:50 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sAwLw-0007Jr-0l;
	Sat, 25 May 2024 18:42:48 +0000
Date: Sun, 26 May 2024 02:42:01 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 3c376f35eb13a144d5039d911b35110c2beef815
Message-ID: <202405260259.xUBnItCo-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 3c376f35eb13a144d5039d911b35110c2beef815  Bluetooth: Use sizeof(*pointer) instead of sizeof(type)

elapsed time: 1299m

configs tested: 173
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20240525   gcc  
arc                   randconfig-002-20240525   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                          collie_defconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240525   gcc  
arm                   randconfig-002-20240525   gcc  
arm                   randconfig-003-20240525   clang
arm                   randconfig-004-20240525   clang
arm                           sama5_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240525   gcc  
arm64                 randconfig-002-20240525   clang
arm64                 randconfig-003-20240525   gcc  
arm64                 randconfig-004-20240525   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240525   gcc  
csky                  randconfig-002-20240525   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240525   clang
hexagon               randconfig-002-20240525   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240525   gcc  
i386         buildonly-randconfig-002-20240525   gcc  
i386         buildonly-randconfig-003-20240525   gcc  
i386         buildonly-randconfig-004-20240525   clang
i386         buildonly-randconfig-005-20240525   gcc  
i386         buildonly-randconfig-006-20240525   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240525   clang
i386                  randconfig-002-20240525   gcc  
i386                  randconfig-003-20240525   clang
i386                  randconfig-004-20240525   clang
i386                  randconfig-005-20240525   gcc  
i386                  randconfig-006-20240525   gcc  
i386                  randconfig-011-20240525   clang
i386                  randconfig-012-20240525   clang
i386                  randconfig-013-20240525   clang
i386                  randconfig-014-20240525   gcc  
i386                  randconfig-015-20240525   clang
i386                  randconfig-016-20240525   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240525   gcc  
loongarch             randconfig-002-20240525   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240525   gcc  
nios2                 randconfig-002-20240525   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240525   gcc  
parisc                randconfig-002-20240525   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240525   gcc  
powerpc               randconfig-002-20240525   gcc  
powerpc               randconfig-003-20240525   gcc  
powerpc64             randconfig-001-20240525   clang
powerpc64             randconfig-002-20240525   gcc  
powerpc64             randconfig-003-20240525   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240525   gcc  
riscv                 randconfig-002-20240525   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240525   clang
s390                  randconfig-002-20240525   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240525   gcc  
sh                    randconfig-002-20240525   gcc  
sh                          rsk7269_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240525   gcc  
sparc64               randconfig-002-20240525   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240525   gcc  
um                    randconfig-002-20240525   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240525   clang
x86_64       buildonly-randconfig-002-20240525   gcc  
x86_64       buildonly-randconfig-003-20240525   gcc  
x86_64       buildonly-randconfig-004-20240525   gcc  
x86_64       buildonly-randconfig-005-20240525   gcc  
x86_64       buildonly-randconfig-006-20240525   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240525   clang
x86_64                randconfig-002-20240525   clang
x86_64                randconfig-003-20240525   clang
x86_64                randconfig-004-20240525   clang
x86_64                randconfig-005-20240525   clang
x86_64                randconfig-006-20240525   clang
x86_64                randconfig-011-20240525   clang
x86_64                randconfig-012-20240525   clang
x86_64                randconfig-013-20240525   gcc  
x86_64                randconfig-014-20240525   clang
x86_64                randconfig-015-20240525   gcc  
x86_64                randconfig-016-20240525   clang
x86_64                randconfig-071-20240525   gcc  
x86_64                randconfig-072-20240525   clang
x86_64                randconfig-073-20240525   clang
x86_64                randconfig-074-20240525   gcc  
x86_64                randconfig-075-20240525   gcc  
x86_64                randconfig-076-20240525   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                randconfig-001-20240525   gcc  
xtensa                randconfig-002-20240525   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
