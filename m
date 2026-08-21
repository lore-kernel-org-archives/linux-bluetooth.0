Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03ED37C92C
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787314309; cv=none; b=OE0260uCBbNH/N2VzuKW/+dezB0cfIjf/MG1cZYFjO2n1NuQrN3GHqdAqXxNp6iSgqr8Uw3q1H4Qi+9S2xXU6uoV6UbcJcEds35wjagZYD8B18kB9z0VQrv+jsBLjynq4d9Q5qceyGmwuRs2czz/ZMLJcI/jgSBPiLVdMvpDkBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787314309; c=relaxed/simple;
	bh=NK0V+kXUVrH6+CK+09Em8AKNOt3RdIo9pzGn4yny8Fo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=POE38CJ1uiuK8pqaWd6ZdtzNVaCYDd1bgvIRwU5vv99CQc2wS8BAUCfTMsrUMYYMz8j8QbAwlWuEvA5vbeLUNX7STYHrnoY3nqkTvkieIFFiMvLWDGWHkLzbeIFx1FBwb+ihg1LdMH8GtP4xLDgeVD8CWqRXXzooT7hB8kNaCbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/NZ0w5H; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/NZ0w5H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787314299; x=1818850299;
  h=date:from:to:cc:subject:message-id;
  bh=NK0V+kXUVrH6+CK+09Em8AKNOt3RdIo9pzGn4yny8Fo=;
  b=a/NZ0w5HZb8fWo3EWTtq9WuBraOrBlt1T5cuoMXV6AldbxNkcHW0FqhT
   TzBRxIN+3kXda0V/Ml0Q44fYBTU6DG4T7sWOzEMm29wulxjN/bPC4P/5z
   PgDn/SEwfKhCi0bY6m+X0Fq5q2mloWsE+/+sDGe/iYBVJsCi8YAoSqbmf
   /Va9F7kbbhKFsNzCzi9gjB4QhgS0t+sgaShzu+VLxGuVObAG82NDxw8dL
   jPJTFy6OGMfAQZ/jChJpOewv61+iXzCNDctrBYBt8wHg55eYvJ3SMQ4aZ
   XUAMNZeZTAIy+aO18YnvXhkB70k/NPaNhPh+rI9eu7AojXsjAjufSXKZy
   A==;
X-CSE-ConnectionGUID: NJbNOAGySZSnjuqPkdPxxQ==
X-CSE-MsgGUID: LM4Md4FLSbqtbuQrjJPZIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="105241810"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="105241810"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 05:11:37 -0700
X-CSE-ConnectionGUID: f7lelhjSTTC36UbQKgd7Fg==
X-CSE-MsgGUID: VKD16gwZRh+wpx9gn0/0Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="265823247"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 21 Aug 2026 05:11:36 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wxO5t-00000000prj-3BYp;
	Fri, 21 Aug 2026 12:11:33 +0000
Date: Fri, 21 Aug 2026 20:10:48 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 486f8908aa587ab2a213bbef39311743e4f8f57a
Message-ID: <202608212036.7VbF45xd-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 486f8908aa587ab2a213bbef39311743e4f8f57a  Bluetooth: ISO: fix use-after-free of listener socket in iso_conn_ready

elapsed time: 2338m

configs tested: 155
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                           randconfig-001    clang-24
arc                  randconfig-001-20260820    clang-24
arc                  randconfig-001-20260821    gcc-10.5.0
arc                  randconfig-002-20260820    clang-24
arc                  randconfig-002-20260821    gcc-10.5.0
arm                  randconfig-001-20260820    clang-24
arm                  randconfig-001-20260821    gcc-10.5.0
arm                  randconfig-002-20260820    clang-24
arm                  randconfig-002-20260821    gcc-10.5.0
arm                  randconfig-003-20260820    clang-24
arm                  randconfig-003-20260821    gcc-10.5.0
arm                  randconfig-004-20260820    clang-24
arm                  randconfig-004-20260821    gcc-10.5.0
arm                          sunxi_defconfig    gcc-16.1.0
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260820    clang-24
arm64                randconfig-001-20260820    gcc-14.3.0
arm64                randconfig-002-20260820    clang-24
arm64                randconfig-002-20260820    gcc-14.3.0
arm64                randconfig-003-20260820    clang-24
arm64                randconfig-003-20260820    gcc-14.3.0
arm64                randconfig-004-20260820    clang-24
arm64                randconfig-004-20260820    gcc-14.3.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260820    clang-24
csky                 randconfig-001-20260820    gcc-14.3.0
csky                 randconfig-002-20260820    clang-24
csky                 randconfig-002-20260820    gcc-14.3.0
hexagon                       randconfig-001    gcc-14.3.0
hexagon              randconfig-001-20260820    gcc-14.3.0
hexagon              randconfig-002-20260820    gcc-14.3.0
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260820    gcc-14
i386       buildonly-randconfig-001-20260821    gcc-14
i386       buildonly-randconfig-002-20260820    clang-22
i386       buildonly-randconfig-002-20260820    gcc-14
i386       buildonly-randconfig-002-20260821    gcc-14
i386       buildonly-randconfig-003-20260820    gcc-14
i386       buildonly-randconfig-003-20260821    gcc-14
i386       buildonly-randconfig-004-20260820    clang-22
i386       buildonly-randconfig-004-20260820    gcc-14
i386       buildonly-randconfig-004-20260821    gcc-14
i386       buildonly-randconfig-005-20260820    gcc-14
i386       buildonly-randconfig-005-20260821    gcc-14
i386       buildonly-randconfig-006-20260820    gcc-13
i386       buildonly-randconfig-006-20260820    gcc-14
i386       buildonly-randconfig-006-20260821    gcc-14
i386                 randconfig-001-20260820    clang-22
i386                 randconfig-002-20260820    clang-22
i386                 randconfig-003-20260820    clang-22
i386                 randconfig-004-20260820    clang-22
i386                 randconfig-005-20260820    clang-22
i386                 randconfig-006-20260820    clang-22
i386                 randconfig-007-20260820    clang-22
i386                 randconfig-011-20260820    gcc-14
i386                 randconfig-012-20260820    gcc-14
i386                 randconfig-013-20260820    gcc-14
i386                 randconfig-014-20260820    gcc-14
i386                 randconfig-015-20260820    clang-22
i386                 randconfig-015-20260820    gcc-14
i386                 randconfig-016-20260820    gcc-14
i386                 randconfig-017-20260820    clang-22
i386                 randconfig-017-20260820    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260820    gcc-14.3.0
loongarch            randconfig-002-20260820    gcc-14.3.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260820    gcc-14.3.0
nios2                randconfig-002-20260820    gcc-14.3.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260820    gcc-8.5.0
parisc               randconfig-002-20260820    gcc-8.5.0
powerpc                mpc834x_itx_defconfig    clang-24
powerpc              randconfig-001-20260820    gcc-8.5.0
powerpc              randconfig-002-20260820    gcc-8.5.0
powerpc                    sequoia_defconfig    clang-24
powerpc64            randconfig-001-20260820    gcc-8.5.0
powerpc64            randconfig-002-20260820    gcc-8.5.0
riscv                randconfig-001-20260820    clang-24
riscv                randconfig-002-20260820    clang-24
s390                 randconfig-001-20260820    clang-24
s390                 randconfig-002-20260820    clang-24
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260820    clang-24
sh                   randconfig-002-20260820    clang-24
sparc                randconfig-001-20260820    gcc-13.4.0
sparc                randconfig-001-20260820    gcc-8.5.0
sparc                randconfig-001-20260821    gcc-8.5.0
sparc                randconfig-002-20260820    gcc-13.4.0
sparc                randconfig-002-20260820    gcc-16.1.0
sparc                randconfig-002-20260821    gcc-8.5.0
sparc64              randconfig-001-20260820    gcc-11.5.0
sparc64              randconfig-001-20260820    gcc-13.4.0
sparc64              randconfig-001-20260821    gcc-8.5.0
sparc64              randconfig-002-20260820    gcc-13.4.0
sparc64              randconfig-002-20260820    gcc-9.5.0
sparc64              randconfig-002-20260821    gcc-8.5.0
um                   randconfig-001-20260820    gcc-13.4.0
um                   randconfig-001-20260820    gcc-14
um                   randconfig-001-20260821    gcc-8.5.0
um                   randconfig-002-20260820    gcc-13.4.0
um                   randconfig-002-20260820    gcc-14
um                   randconfig-002-20260821    gcc-8.5.0
x86_64     buildonly-randconfig-001-20260820    gcc-14
x86_64     buildonly-randconfig-001-20260821    clang-22
x86_64     buildonly-randconfig-002-20260820    gcc-14
x86_64     buildonly-randconfig-002-20260821    clang-22
x86_64     buildonly-randconfig-003-20260820    gcc-14
x86_64     buildonly-randconfig-003-20260821    clang-22
x86_64     buildonly-randconfig-004-20260820    gcc-14
x86_64     buildonly-randconfig-004-20260821    clang-22
x86_64     buildonly-randconfig-005-20260820    gcc-14
x86_64     buildonly-randconfig-005-20260821    clang-22
x86_64     buildonly-randconfig-006-20260820    gcc-14
x86_64     buildonly-randconfig-006-20260821    clang-22
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    gcc-14
x86_64               randconfig-001-20260820    clang-22
x86_64               randconfig-001-20260820    gcc-14
x86_64               randconfig-002-20260820    clang-22
x86_64               randconfig-002-20260820    gcc-14
x86_64               randconfig-003-20260820    clang-22
x86_64               randconfig-003-20260820    gcc-14
x86_64               randconfig-004-20260820    clang-22
x86_64               randconfig-004-20260820    gcc-14
x86_64               randconfig-005-20260820    clang-22
x86_64               randconfig-005-20260820    gcc-14
x86_64               randconfig-006-20260820    clang-22
x86_64               randconfig-006-20260820    gcc-14
x86_64               randconfig-011-20260820    clang-22
x86_64               randconfig-012-20260820    clang-22
x86_64               randconfig-013-20260820    clang-22
x86_64               randconfig-014-20260820    clang-22
x86_64               randconfig-015-20260820    clang-22
x86_64               randconfig-016-20260820    clang-22
x86_64               randconfig-071-20260820    clang-22
x86_64               randconfig-072-20260820    clang-22
x86_64               randconfig-073-20260820    clang-22
x86_64               randconfig-074-20260820    clang-22
x86_64               randconfig-075-20260820    clang-22
x86_64               randconfig-076-20260820    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260820    gcc-13.4.0
xtensa               randconfig-001-20260820    gcc-8.5.0
xtensa               randconfig-001-20260821    gcc-8.5.0
xtensa               randconfig-002-20260820    gcc-13.4.0
xtensa               randconfig-002-20260821    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
