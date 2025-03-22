Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90761F3BBE
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Mar 2025 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742661902; cv=none; b=NTKkgUqn4Nz6CORfAf3KdvC+aXMiwx8TjVWPwSlDdEc2A0vT8vf1iaah8liOlKDnTviYv5MOVkdFOcEjcBv4s590tZHKr4B9hl05V5kp7kbuImm9rp9ad7l1b51ibqbyZC8GVTskfZmFQzqc1JhOVP8GzsHUgtd6DtGOvQwzMGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742661902; c=relaxed/simple;
	bh=r8T/4lQhaIhEKO5yG6odiXyJwrw23ZdMNY2CM7IU1FY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=J0dVeRdRWeiYjuLZz+nAdbN9kdsrIgeh2Mh2a7MflrNA8laED/qMwDJUSDqUTxCNkc3vkhsbQI0QZWAnQ17cDU0khs62o0ImHxFp7/j5XgHH/NtrYw+Xn2uYzH08EqgOYnT3Q4OQKwl0zxjVVaEmP6ffZaOBPC9EXGjvAT0IXzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aMJrU9I/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aMJrU9I/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742661900; x=1774197900;
  h=date:from:to:cc:subject:message-id;
  bh=r8T/4lQhaIhEKO5yG6odiXyJwrw23ZdMNY2CM7IU1FY=;
  b=aMJrU9I/d7O4zGcZc0iqafUSRbIunNM/m8lYOdHNWk0WHnLczL1vYrJU
   za4RrwrmDLbW63CVNhGFjlsZ/8U7tjipHtbv4Dt+TANcu4zoVG4gTETNI
   A2DXjjxQ/ElADK1IS3M48TopnyvKGzVH+f7NHpy5hlxhsxLgJPBCkqsuH
   +72JD0ecWb8jpJCzpr63jevSw3H/WNEoFEYw8tvYYa9NM+XwatEoOayr9
   HUMVOlAPZkPkSXjxEecVFA4v7n+gtUxHbCyECh/0Cq69+wLgdK5GMT/yo
   b+AziObFWvuyVxo4r+dDgXIf0uI/Vd1KpZeGTyl8ss2MlxyGIGX4ffg9h
   g==;
X-CSE-ConnectionGUID: u4coCXjkS2uM8oIIibp9SQ==
X-CSE-MsgGUID: hq4agRiLT3SKIet/wXqcUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11381"; a="43792335"
X-IronPort-AV: E=Sophos;i="6.14,267,1736841600"; 
   d="scan'208";a="43792335"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2025 09:44:59 -0700
X-CSE-ConnectionGUID: wElYJ8+PSHWtLXLZLN/cng==
X-CSE-MsgGUID: fDUyowJ9S5O4i9TB6oVnbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,267,1736841600"; 
   d="scan'208";a="123465809"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 22 Mar 2025 09:44:58 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tw1x2-0002Gt-2I;
	Sat, 22 Mar 2025 16:44:42 +0000
Date: Sun, 23 Mar 2025 00:43:53 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 a37df2815c1b51468a2fe71758b81cb2084433eb
Message-ID: <202503230048.mHESMTK0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: a37df2815c1b51468a2fe71758b81cb2084433eb  Bluetooth: hci_event: Fix handling of HCI_EV_LE_DIRECT_ADV_REPORT

elapsed time: 1441m

configs tested: 106
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250322    gcc-10.5.0
arc                   randconfig-002-20250322    gcc-8.5.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250322    gcc-7.5.0
arm                   randconfig-002-20250322    gcc-7.5.0
arm                   randconfig-003-20250322    clang-21
arm                   randconfig-004-20250322    clang-19
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250322    clang-21
arm64                 randconfig-002-20250322    clang-21
arm64                 randconfig-003-20250322    gcc-8.5.0
arm64                 randconfig-004-20250322    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250322    gcc-14.2.0
csky                  randconfig-002-20250322    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250322    clang-21
hexagon               randconfig-002-20250322    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250322    clang-20
i386        buildonly-randconfig-002-20250322    gcc-12
i386        buildonly-randconfig-003-20250322    gcc-12
i386        buildonly-randconfig-004-20250322    clang-20
i386        buildonly-randconfig-005-20250322    clang-20
i386        buildonly-randconfig-006-20250322    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250322    gcc-14.2.0
loongarch             randconfig-002-20250322    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250322    gcc-6.5.0
nios2                 randconfig-002-20250322    gcc-10.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250322    gcc-5.5.0
parisc                randconfig-002-20250322    gcc-13.3.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc               randconfig-001-20250322    clang-21
powerpc               randconfig-002-20250322    gcc-8.5.0
powerpc               randconfig-003-20250322    clang-21
powerpc64             randconfig-001-20250322    clang-21
powerpc64             randconfig-002-20250322    gcc-8.5.0
powerpc64             randconfig-003-20250322    gcc-8.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250322    gcc-8.5.0
riscv                 randconfig-002-20250322    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250322    gcc-9.3.0
s390                  randconfig-002-20250322    gcc-6.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250322    gcc-10.5.0
sh                    randconfig-002-20250322    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250322    gcc-9.3.0
sparc                 randconfig-002-20250322    gcc-9.3.0
sparc64               randconfig-001-20250322    gcc-5.5.0
sparc64               randconfig-002-20250322    gcc-5.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250322    clang-21
um                    randconfig-002-20250322    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250322    clang-20
x86_64      buildonly-randconfig-002-20250322    clang-20
x86_64      buildonly-randconfig-003-20250322    clang-20
x86_64      buildonly-randconfig-004-20250322    gcc-12
x86_64      buildonly-randconfig-005-20250322    clang-20
x86_64      buildonly-randconfig-006-20250322    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250322    gcc-14.2.0
xtensa                randconfig-002-20250322    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
