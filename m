Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADC8132122
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Mar 2025 20:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740862305; cv=none; b=Dp5Zf2eCrwvrhqTHsMtJKCefUIeTMQL+CDrIrxmqzJerEC6tIxx/bbcm76xOe2SYftvdY4F8Kjnl/i+oqyV8JOyOIvIqh3EbXOmU8Tkmo7ZQlbfyFbpXwhix9smZODn74BYI8Rp+kcN266voKvIx/RSpFkaM2lInH0NPllLbxJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740862305; c=relaxed/simple;
	bh=5A0iPUqj+0+Ml/j0lwkCcIs7DfCKdjbwjCmjrpEIQ5o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KHobDWKkBsF8bC0w5irVmbHSRdgZcv5/7Z9VQeFtEqu7/inv0StM1Ile6vT6B1U8DQ+y1J6c/7cJRv9Z1NeL8sOgC0OcfO3t41a4182FphspA1fq43WaI4dDHMrp4qahQKAwqui+EJvk8+qJ3L5h1YMJf3Pqn61stCSEAUmdeic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UDO0lrre; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UDO0lrre"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740862303; x=1772398303;
  h=date:from:to:cc:subject:message-id;
  bh=5A0iPUqj+0+Ml/j0lwkCcIs7DfCKdjbwjCmjrpEIQ5o=;
  b=UDO0lrre+ldfhcVLmsGsOxH//Ltw+I/h73T57tnyn3c2PJGcKio8evNr
   Qfe+wUE3m+3if5G63MlXO+gDKeI4mfo2RE9irs9c8ki9R2JNYMMAI22Ba
   llBzR5qp+xXf2T5kaKKDCtn9BnWYxCIWqHjJfQsuvPRSmWcwM+m/1jLWB
   tJafX6ZS7ZBFY3oJf69lYU68Da4euuKdzpE51JBB4GK8OyQaIt0IY8/Bb
   pm1itSWCKG9i+28Fbkc4XhEtSHDT5F3A/TfRS3Dcja3RR9h0BDT7csUx9
   gG/RpTtugRoBmDtAyW/2+Jy9zntVrP/BYzdS817jD78kKh3iKYjFtpMlo
   Q==;
X-CSE-ConnectionGUID: jtoJQHk6QDyTU9JlCjVsOw==
X-CSE-MsgGUID: jabl4qcGRuaZfLi3MX0slw==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="45551810"
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="45551810"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 12:51:42 -0800
X-CSE-ConnectionGUID: sYStuYFHQTuaXEW41dpBmg==
X-CSE-MsgGUID: xqYXcxMTTxCrjjtg/bGaSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="122646742"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 01 Mar 2025 12:51:40 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toToA-000Ggg-1L;
	Sat, 01 Mar 2025 20:51:38 +0000
Date: Sun, 02 Mar 2025 04:51:34 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 ebbeaffb5622dee1b21cd881b1f24589a0d70433
Message-ID: <202503020426.1xFqVEm1-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: ebbeaffb5622dee1b21cd881b1f24589a0d70433  Bluetooth: SCO: fix sco_conn refcounting on sco_conn_ready

elapsed time: 1448m

configs tested: 150
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                   randconfig-001-20250301    gcc-13.2.0
arc                   randconfig-001-20250302    gcc-14.2.0
arc                   randconfig-002-20250301    gcc-13.2.0
arc                   randconfig-002-20250302    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                       aspeed_g4_defconfig    gcc-14.2.0
arm                         lpc18xx_defconfig    gcc-14.2.0
arm                   milbeaut_m10v_defconfig    gcc-14.2.0
arm                            mps2_defconfig    clang-15
arm                        mvebu_v7_defconfig    clang-15
arm                            qcom_defconfig    clang-15
arm                   randconfig-001-20250301    gcc-14.2.0
arm                   randconfig-001-20250302    gcc-14.2.0
arm                   randconfig-002-20250301    gcc-14.2.0
arm                   randconfig-002-20250302    gcc-14.2.0
arm                   randconfig-003-20250301    clang-21
arm                   randconfig-003-20250302    gcc-14.2.0
arm                   randconfig-004-20250301    clang-21
arm                   randconfig-004-20250302    gcc-14.2.0
arm                         vf610m4_defconfig    gcc-14.2.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250301    gcc-14.2.0
arm64                 randconfig-001-20250302    gcc-14.2.0
arm64                 randconfig-002-20250301    clang-21
arm64                 randconfig-002-20250302    gcc-14.2.0
arm64                 randconfig-003-20250301    clang-15
arm64                 randconfig-003-20250302    gcc-14.2.0
arm64                 randconfig-004-20250301    clang-17
arm64                 randconfig-004-20250302    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250301    gcc-14.2.0
csky                  randconfig-002-20250301    gcc-14.2.0
hexagon                           allnoconfig    gcc-14.2.0
hexagon               randconfig-001-20250301    clang-21
hexagon               randconfig-002-20250301    clang-21
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20250301    clang-19
i386        buildonly-randconfig-001-20250302    gcc-12
i386        buildonly-randconfig-002-20250301    clang-19
i386        buildonly-randconfig-002-20250302    gcc-12
i386        buildonly-randconfig-003-20250301    clang-19
i386        buildonly-randconfig-003-20250302    gcc-12
i386        buildonly-randconfig-004-20250301    clang-19
i386        buildonly-randconfig-004-20250302    gcc-12
i386        buildonly-randconfig-005-20250301    gcc-12
i386        buildonly-randconfig-005-20250302    gcc-12
i386        buildonly-randconfig-006-20250301    clang-19
i386        buildonly-randconfig-006-20250302    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250302    gcc-12
i386                  randconfig-002-20250302    gcc-12
i386                  randconfig-003-20250302    gcc-12
i386                  randconfig-004-20250302    gcc-12
i386                  randconfig-005-20250302    gcc-12
i386                  randconfig-006-20250302    gcc-12
i386                  randconfig-007-20250302    gcc-12
i386                  randconfig-011-20250302    gcc-11
i386                  randconfig-012-20250302    gcc-11
i386                  randconfig-013-20250302    gcc-11
i386                  randconfig-014-20250302    gcc-11
i386                  randconfig-015-20250302    gcc-11
i386                  randconfig-016-20250302    gcc-11
i386                  randconfig-017-20250302    gcc-11
loongarch                        alldefconfig    clang-15
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250301    gcc-14.2.0
loongarch             randconfig-002-20250301    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250301    gcc-14.2.0
nios2                 randconfig-002-20250301    gcc-14.2.0
openrisc                          allnoconfig    clang-15
openrisc                    or1ksim_defconfig    gcc-14.2.0
parisc                            allnoconfig    clang-15
parisc                generic-32bit_defconfig    clang-15
parisc                randconfig-001-20250301    gcc-14.2.0
parisc                randconfig-002-20250301    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                 mpc832x_rdb_defconfig    clang-15
powerpc               randconfig-001-20250301    clang-17
powerpc               randconfig-002-20250301    clang-19
powerpc               randconfig-003-20250301    clang-21
powerpc64             randconfig-001-20250301    gcc-14.2.0
powerpc64             randconfig-002-20250301    clang-21
powerpc64             randconfig-003-20250301    gcc-14.2.0
riscv                             allnoconfig    clang-15
riscv                 randconfig-001-20250301    gcc-14.2.0
riscv                 randconfig-002-20250301    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250301    clang-15
s390                  randconfig-002-20250301    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250301    gcc-14.2.0
sh                    randconfig-002-20250301    gcc-14.2.0
sh                             sh03_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250301    gcc-14.2.0
sparc                 randconfig-002-20250301    gcc-14.2.0
sparc64               randconfig-001-20250301    gcc-14.2.0
sparc64               randconfig-002-20250301    gcc-14.2.0
um                                allnoconfig    clang-15
um                    randconfig-001-20250301    gcc-12
um                    randconfig-002-20250301    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250301    clang-19
x86_64      buildonly-randconfig-001-20250302    gcc-12
x86_64      buildonly-randconfig-002-20250301    clang-19
x86_64      buildonly-randconfig-002-20250302    gcc-12
x86_64      buildonly-randconfig-003-20250301    gcc-11
x86_64      buildonly-randconfig-003-20250302    gcc-12
x86_64      buildonly-randconfig-004-20250301    gcc-12
x86_64      buildonly-randconfig-004-20250302    gcc-12
x86_64      buildonly-randconfig-005-20250301    gcc-12
x86_64      buildonly-randconfig-005-20250302    gcc-12
x86_64      buildonly-randconfig-006-20250301    clang-19
x86_64      buildonly-randconfig-006-20250302    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250302    clang-19
x86_64                randconfig-002-20250302    clang-19
x86_64                randconfig-003-20250302    clang-19
x86_64                randconfig-004-20250302    clang-19
x86_64                randconfig-005-20250302    clang-19
x86_64                randconfig-006-20250302    clang-19
x86_64                randconfig-007-20250302    clang-19
x86_64                randconfig-008-20250302    clang-19
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-18
x86_64                          rhel-9.4-func    clang-19
x86_64                         rhel-9.4-kunit    clang-18
x86_64                           rhel-9.4-ltp    clang-18
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250301    gcc-14.2.0
xtensa                randconfig-002-20250301    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
