Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4CF24DD15
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Aug 2026 05:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785562293; cv=none; b=PcEfAx4Zi4dM2jhh84svg7Qp3+rfNbuD5IReX8NzmoMmTWqocq8gFrwUVXVsIbXmWuNnAHBGZLoRTRn5D1Jmv3fvlW1GQbLS63tfB4hF5TkgdgO1hepSNkPndaaLzGr00EXg+K3Zb88XLgkTYShy9FZNK1I+s2/3OX9a5b1Tjuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785562293; c=relaxed/simple;
	bh=IMTgHrIrpQ6en3rZCABERHusOAJ3ia/e1owKSXkE1Xw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WCeKS+CTz6TPMaARLEnzkGXXM9VXiCFai32rPPFZxKBV5ro4fJ8H3wobVVVQfOLEz5+WUVcOTIDDUXfGX64+aCwqQ/GXASOS8qKEQQ6jdUtVkDxWGPDRiDiG6Rfmt+ErNqncdwJ5k6upM/hvTCkYQBmh29aSd5CVP1evlVSnRuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PCDkaCkf; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PCDkaCkf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785562291; x=1817098291;
  h=date:from:to:cc:subject:message-id;
  bh=IMTgHrIrpQ6en3rZCABERHusOAJ3ia/e1owKSXkE1Xw=;
  b=PCDkaCkfQdYMeR6qlXlh/IzHXwtWljX7ypM+3xVGal4ge2VKgGHMpYWs
   1kqiahYcAolPYwcyx/6LyvtzejZOLT+BYxWlvQ7MjpKuVsU3QrBopx55S
   6Ifb3/DjtqVpkKcGNID5jlwnsztNT5swW6N6fEG6Yefjb+ZbwW0Rx+ata
   ZyHhcj6Pd7C25Aa6aW43cIXgLBDSxi8CfzJDMIEVTBNEcC0cPw4dHVwec
   9PzAmDuMb98NmGhaqBNbmYQSLaaDFdFOLCHlzMk+OPUQTJIwtC14XRsJo
   8N/2VsdqIVvXmRAvkkW1sIjZCpZ9Y+zSDIqWxXHnBEU8YOgM6LrEiLs/C
   g==;
X-CSE-ConnectionGUID: X0jOV0VuQ42N4mRzdKuAyA==
X-CSE-MsgGUID: nuW6S5fkTzyyeZ/8bacSLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="86056370"
X-IronPort-AV: E=Sophos;i="6.25,197,1779174000"; 
   d="scan'208";a="86056370"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 22:31:30 -0700
X-CSE-ConnectionGUID: AfKsRIS6QsaZ5vwnDMxW1A==
X-CSE-MsgGUID: seOlW7S6Sve2WF/sucMIDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,197,1779174000"; 
   d="scan'208";a="260797769"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 31 Jul 2026 22:31:29 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wq2Ji-000000002n3-3ogZ;
	Sat, 01 Aug 2026 05:31:26 +0000
Date: Sat, 01 Aug 2026 13:31:16 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 1b16c012931d707c56d4a62947245c4ccc91de89
Message-ID: <202608011301.T3gRUi3e-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 1b16c012931d707c56d4a62947245c4ccc91de89  Bluetooth: btintel: Add Bluetooth SAR revision 2 support

elapsed time: 774m

configs tested: 53
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                  allnoconfig    gcc-16.1.0
alpha                 allyesconfig    gcc-16.1.0
alpha                    defconfig    gcc-16.1.0
arc                   allmodconfig    gcc-16.1.0
arc                   allyesconfig    gcc-16.1.0
arc        randconfig-001-20260801    gcc-14.3.0
arc        randconfig-002-20260801    gcc-12.5.0
arm        randconfig-001-20260801    clang-24
arm        randconfig-002-20260801    gcc-8.5.0
arm        randconfig-003-20260801    gcc-12.5.0
arm        randconfig-004-20260801    clang-18
arm64      randconfig-001-20260801    clang-21
arm64      randconfig-002-20260801    clang-21
arm64      randconfig-003-20260801    gcc-14.3.0
arm64      randconfig-004-20260801    clang-24
csky                  allmodconfig    gcc-16.1.0
csky       randconfig-001-20260801    gcc-12.5.0
csky       randconfig-002-20260801    gcc-10.5.0
i386                  allmodconfig    gcc-14
loongarch                defconfig    clang-24
nios2                 allmodconfig    gcc-11.5.0
nios2                  allnoconfig    gcc-11.5.0
parisc                allmodconfig    gcc-16.1.0
parisc                allyesconfig    gcc-16.1.0
parisc                   defconfig    gcc-16.1.0
parisc     randconfig-001-20260801    gcc-11.5.0
parisc     randconfig-002-20260801    gcc-9.5.0
powerpc           bamboo_defconfig    clang-21
powerpc    randconfig-001-20260801    clang-20
powerpc    randconfig-002-20260801    gcc-10.5.0
powerpc64  randconfig-001-20260801    clang-24
powerpc64  randconfig-002-20260801    clang-24
riscv               randconfig-001    gcc-13.4.0
riscv      randconfig-001-20260801    gcc-14.3.0
riscv      randconfig-002-20260801    clang-20
s390       randconfig-001-20260801    gcc-15.2.0
s390       randconfig-002-20260801    clang-24
sh                       defconfig    gcc-16.1.0
sh         randconfig-001-20260801    gcc-16.1.0
sh         randconfig-002-20260801    gcc-16.1.0
sparc64    randconfig-001-20260801    gcc-9.5.0
x86_64     randconfig-011-20260801    clang-22
x86_64     randconfig-012-20260801    gcc-14
x86_64     randconfig-013-20260801    clang-22
x86_64     randconfig-014-20260801    gcc-14
x86_64     randconfig-015-20260801    clang-22
x86_64     randconfig-016-20260801    clang-22
x86_64     randconfig-071-20260801    gcc-14
x86_64     randconfig-072-20260801    gcc-14
x86_64     randconfig-073-20260801    clang-22
x86_64     randconfig-074-20260801    gcc-14
x86_64     randconfig-075-20260801    clang-22
x86_64     randconfig-076-20260801    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
