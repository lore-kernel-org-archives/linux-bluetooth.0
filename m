Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F372E228D
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 12:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776256270; cv=none; b=Yy58TP4S6DjzQ9GXHRobn1KoKbaUR+OORJHV3QSIb8mhDv/sQa61nMUefEZ1KB22MJj62axOCfLZ3UOW4kLJLJ9rXQQAmS+FnYmmj9RFei6B4n+9ZrbY01Tink08PyvBQB3+qYyaBk5KgpkcSyfkHa42AabYXFqf/7hJ/V9YXnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776256270; c=relaxed/simple;
	bh=IyAAieHWtEoLzO+C7M91IQXZviDRvSny8J0mcTR8Wo4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PGBWZmLqf54JMvwOkORzP64VVHEfJrdkmO+M3gi63rQt8uEadgxKCL7jRlI9v5VKDGCogiN6us8eVSyzp7lu4xJhDMrIPelKAdiDn4M4vIoRMBsM+5Qbjk3r9ns/0GV/XurIHNLkcnBbCEzzwvyiqgclBKqm6YxdvwIUy0D9MJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ayeCIQEB; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ayeCIQEB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776256267; x=1807792267;
  h=date:from:to:cc:subject:message-id;
  bh=IyAAieHWtEoLzO+C7M91IQXZviDRvSny8J0mcTR8Wo4=;
  b=ayeCIQEBYvEwXfuCjrniC7/pPKrzI8Cs7o5Cfyvi1ab/L6eVva+Sv91L
   rpmeilhFIa/kENMzU3pw6SHWmUXg12nWVdy2v1i45N7E9H2wWj0sDIp57
   slGDP6qhhyM91a8LjAR4RznU1hkjS8BHr7Fm5QuUj9XQFljLbhORYZrzk
   feUCkoPKBbf8aEX5jXUUK3PtoRpByALfh1vDCOs82I3oPtqSvjYRq9DC7
   PHs+2EzYXcsRH3WFWYn+PaLRIdjC/wLrAxDbx6rVN2/xfAPA3+XuMxtzR
   pX3VaB9IRyvTKJzSse8VP1ag3EX6Y5JKD0CnkB1HWamDx/CuFNZChrdM6
   Q==;
X-CSE-ConnectionGUID: i7UEiLpPTrmKSlQOnaPGHA==
X-CSE-MsgGUID: RSi1wxrCReyyaLUfTXEKNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="88680703"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="88680703"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 05:31:06 -0700
X-CSE-ConnectionGUID: Kv57QDBxR2e49R63uzwXtg==
X-CSE-MsgGUID: hAgQk2f5QBGUPmpfIfnbJQ==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 7f3b36e5d6a5) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 15 Apr 2026 05:31:04 -0700
Received: from kbuild by 7f3b36e5d6a5 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wCzOY-000000000VF-2RxN;
	Wed, 15 Apr 2026 12:31:02 +0000
Date: Wed, 15 Apr 2026 20:30:26 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 41388deeb99016b772801aa19ca7a3023d53826e
Message-ID: <202604152018.33luWo9H-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 41388deeb99016b772801aa19ca7a3023d53826e  Bluetooth: btusb: MT7925: Add VID/PID 0e8d/8c38

elapsed time: 907m

configs tested: 67
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.2.0
alpha                  allyesconfig    gcc-15.2.0
arc                    allmodconfig    gcc-15.2.0
arc                     allnoconfig    gcc-15.2.0
arc                    allyesconfig    gcc-15.2.0
arc         randconfig-001-20260415    gcc-13.4.0
arc         randconfig-002-20260415    gcc-15.2.0
arm                     allnoconfig    clang-23
arm                    allyesconfig    gcc-15.2.0
arm64                  allmodconfig    clang-19
arm64                   allnoconfig    gcc-15.2.0
csky                   allmodconfig    gcc-15.2.0
csky                    allnoconfig    gcc-15.2.0
hexagon                allmodconfig    clang-17
hexagon                 allnoconfig    clang-23
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
i386                   allyesconfig    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-23
m68k                   allmodconfig    gcc-15.2.0
m68k                    allnoconfig    gcc-15.2.0
m68k                   allyesconfig    gcc-15.2.0
m68k                      defconfig    gcc-15.2.0
microblaze              allnoconfig    gcc-15.2.0
microblaze             allyesconfig    gcc-15.2.0
microblaze                defconfig    gcc-15.2.0
mips                   allmodconfig    gcc-15.2.0
mips                    allnoconfig    gcc-15.2.0
mips                   allyesconfig    gcc-15.2.0
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    gcc-11.5.0
nios2                     defconfig    gcc-11.5.0
openrisc               allmodconfig    gcc-15.2.0
openrisc                allnoconfig    gcc-15.2.0
parisc                 allmodconfig    gcc-15.2.0
parisc                  allnoconfig    gcc-15.2.0
parisc                 allyesconfig    gcc-15.2.0
powerpc                allmodconfig    gcc-15.2.0
powerpc                 allnoconfig    gcc-15.2.0
riscv                  allmodconfig    clang-23
riscv                   allnoconfig    gcc-15.2.0
riscv                  allyesconfig    clang-16
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-23
s390                   allyesconfig    gcc-15.2.0
sh                     allmodconfig    gcc-15.2.0
sh                      allnoconfig    gcc-15.2.0
sh                     allyesconfig    gcc-15.2.0
sh                        defconfig    gcc-15.2.0
sh                polaris_defconfig    gcc-15.2.0
sparc                   allnoconfig    gcc-15.2.0
sparc64                allmodconfig    clang-23
sparc64                   defconfig    clang-20
um                     allmodconfig    clang-19
um                      allnoconfig    clang-23
um                     allyesconfig    gcc-14
um                        defconfig    clang-23
um                   i386_defconfig    gcc-14
um                 x86_64_defconfig    clang-23
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-20
x86_64                 allyesconfig    clang-20
x86_64                    defconfig    gcc-14
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    gcc-15.2.0
xtensa                 allyesconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
