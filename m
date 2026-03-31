Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34E93BED6F
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 20:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774987785; cv=none; b=GAV1CjOZe+rbjHFLhcZp5Zlpk25W0kYqTem1WeunHYM+HlxZzjqWJaDv+ZA4+5Dga68XMOJMFQjcMQXZc+KzewuXpDmKJrKeyF3xHJtmMbdk9nczUBisuYl3sTDXe3YCOwgY3D55IR5W7xmsu73+gFZsGazUKgSziNk2b1qm8xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774987785; c=relaxed/simple;
	bh=qutch8vAZkjPX5HOf/+dD3A0girkO6giHpeHVnVV9u4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mzoHE5uj+JsIhgzQBI8vfX6MXJicUeFDApYIZciq8v5NcOoIW8oz6oYa+d9zhTQd/seMi2+VFErqTyk5EE3VKXVh82oi6VGaRZ8hd+Lcjd4TU9OsmI/WYvXUz83y0YWEL9vGmfCABOKj0E5GFmFHNx5HwrSqYX00UtgSXkmdGRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y1Q+TUcG; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y1Q+TUcG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774987783; x=1806523783;
  h=date:from:to:cc:subject:message-id;
  bh=qutch8vAZkjPX5HOf/+dD3A0girkO6giHpeHVnVV9u4=;
  b=Y1Q+TUcGAGfTZcnlu47cZgXVPwsLLJMqQoG83+w0b1m/s9Cot5XHFqGW
   /4kmmLljTyzliNamu4grDKnyYkeo5aRI0cKOzfdN3NQaxzHMYb1+7J5fR
   RPCvgT7pqAlUow3uCXZlSB6TZU8Nv68xlXp7xxJdHyFdXwzf8Bj75V12s
   +77OZzSfZiApcsFrGJTc77eanMePkUNVxvuBOdvopsaeGj/OPD0dhDRwi
   Q38IChFPeHV/x44HIqCXuqarRj/jTGg4Ru9VuinOW+1eCZ1snyt1M7kRE
   Kinv37aE1OnkuAz/1IoqS+WY7dnk4JmlQ+QjKyMrZ9EL/e2XGdupRgoTZ
   g==;
X-CSE-ConnectionGUID: ANnZc4HcT3OZ7Evr26FAfA==
X-CSE-MsgGUID: UQCLnD/PRn6uX/sug9LobA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75186269"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="75186269"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 13:09:42 -0700
X-CSE-ConnectionGUID: TxJFesCbQ+iiDbn0L8EeTQ==
X-CSE-MsgGUID: b8rAHhwkToOcDwTMDpY/iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="230898886"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 31 Mar 2026 13:09:40 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7fP8-000000004Dh-0L0N;
	Tue, 31 Mar 2026 20:09:38 +0000
Date: Wed, 01 Apr 2026 04:09:09 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 13be27bc49847211616bb36e58ceacb50a7c4d5f
Message-ID: <202604010401.nqy22qOr-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 13be27bc49847211616bb36e58ceacb50a7c4d5f  Bluetooth: btmtk: refactor endpoint lookup

elapsed time: 1179m

configs tested: 175
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260331    clang-23
arc                   randconfig-002-20260331    clang-23
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260331    clang-23
arm                   randconfig-002-20260331    clang-23
arm                   randconfig-003-20260331    clang-23
arm                   randconfig-004-20260331    clang-23
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260331    clang-18
arm64                 randconfig-002-20260331    clang-18
arm64                 randconfig-003-20260331    clang-18
arm64                 randconfig-004-20260331    clang-18
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260331    clang-18
csky                  randconfig-002-20260331    clang-18
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260331    clang-20
i386        buildonly-randconfig-002-20260331    clang-20
i386        buildonly-randconfig-003-20260331    clang-20
i386        buildonly-randconfig-004-20260331    clang-20
i386        buildonly-randconfig-005-20260331    clang-20
i386        buildonly-randconfig-006-20260331    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260331    gcc-14
i386                  randconfig-002-20260331    gcc-14
i386                  randconfig-003-20260331    gcc-14
i386                  randconfig-004-20260331    gcc-14
i386                  randconfig-005-20260331    gcc-14
i386                  randconfig-006-20260331    gcc-14
i386                  randconfig-007-20260331    gcc-14
i386                  randconfig-011-20260331    clang-20
i386                  randconfig-012-20260331    clang-20
i386                  randconfig-013-20260331    clang-20
i386                  randconfig-014-20260331    clang-20
i386                  randconfig-015-20260331    clang-20
i386                  randconfig-016-20260331    clang-20
i386                  randconfig-017-20260331    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260331    clang-23
parisc                randconfig-002-20260331    clang-23
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      pcm030_defconfig    clang-23
powerpc               randconfig-001-20260331    clang-23
powerpc               randconfig-002-20260331    clang-23
powerpc64             randconfig-001-20260331    clang-23
powerpc64             randconfig-002-20260331    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260331    gcc-15.2.0
riscv                 randconfig-002-20260331    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260331    gcc-15.2.0
s390                  randconfig-002-20260331    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260331    gcc-15.2.0
sh                    randconfig-002-20260331    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260331    gcc-15.2.0
sparc                 randconfig-002-20260331    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260331    gcc-15.2.0
sparc64               randconfig-002-20260331    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260331    gcc-15.2.0
um                    randconfig-002-20260331    gcc-15.2.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260331    clang-20
x86_64      buildonly-randconfig-002-20260331    clang-20
x86_64      buildonly-randconfig-003-20260331    clang-20
x86_64      buildonly-randconfig-004-20260331    clang-20
x86_64      buildonly-randconfig-005-20260331    clang-20
x86_64      buildonly-randconfig-006-20260331    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260331    gcc-14
x86_64                randconfig-002-20260331    gcc-14
x86_64                randconfig-003-20260331    gcc-14
x86_64                randconfig-004-20260331    gcc-14
x86_64                randconfig-005-20260331    gcc-14
x86_64                randconfig-006-20260331    gcc-14
x86_64                randconfig-071-20260331    clang-20
x86_64                randconfig-072-20260331    clang-20
x86_64                randconfig-073-20260331    clang-20
x86_64                randconfig-074-20260331    clang-20
x86_64                randconfig-075-20260331    clang-20
x86_64                randconfig-076-20260331    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260331    gcc-15.2.0
xtensa                randconfig-002-20260331    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
