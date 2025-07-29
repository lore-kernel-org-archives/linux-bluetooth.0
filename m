Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4E51E3DF2
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 12:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753791140; cv=none; b=qoZ636cqbklhzH9hSiTvEebLGQKWRvEhMPUBe6mnuQ2mOQXxjumhwn2l1R0kwV1Pvt6iSfI1jtU0lORazhkncYmLPq6YPpjSkvfM2IaE5a8piah95lVD2NamhjfA7OBLzPhU1nJnaQ6c4njXwtcdpNVx5Z9aQDBBcHnEY4STgYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753791140; c=relaxed/simple;
	bh=extTeBmOFxErPAvamzZP0379z9fB0kk2jvjFqWptSco=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YSmre6bdUyHiOW7JXN4gb8jEtTbWW8vhpfz1wd8d08Q/cYI5BAYCmokPH32U95JBCo7mHc42uwClBEaTYvcUlrLgxmPha+h4ozY0juhB4LC9aYOi2L+vU1yf/h3f11cb4pWD2e5rIERsy45to4QpnRRJBFt0ePyeirHmAB2jcDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gi1fQkXV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gi1fQkXV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753791138; x=1785327138;
  h=date:from:to:cc:subject:message-id;
  bh=extTeBmOFxErPAvamzZP0379z9fB0kk2jvjFqWptSco=;
  b=gi1fQkXVYglMK6s3/oC/nVD6OWdK4cmcUwjkOXeYAuDySzw6TY4jYQVn
   +6RTNK0BNiUnH8ULJ/doB7MqM2bdeFRBHOZThdvdAtv+er5+R0rxnKX+y
   ovao7D8DvsyZQTt1QJ8vZFT7F6HQwhHOBX009QzdvIBTl+88JxenzIRDA
   lE8SCmTuqfIgYgQpToequuUV2wgvNJRIh+nPfrgh0gA/8VX7WJNKVgSqb
   UyKu7nwOLQlB0vGmaKKsaoKfUfePZeKShuyKWgY1BHuw2GwLhTLtkyRM+
   EL00q+bvpdSHbN6aBHnIvtOrE9rfMgEfL6pqx628RQbqHmq1hPsZK6edT
   Q==;
X-CSE-ConnectionGUID: ggpwDmJYSkeZUW6+9uLyEQ==
X-CSE-MsgGUID: 4JQJ8iCYTuytAOkkoxpRRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="73507390"
X-IronPort-AV: E=Sophos;i="6.16,349,1744095600"; 
   d="scan'208";a="73507390"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 05:12:16 -0700
X-CSE-ConnectionGUID: MxMsDwhzQdiXQp99IYzdqw==
X-CSE-MsgGUID: pwCTCyvoQEmJncFQzoilbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,349,1744095600"; 
   d="scan'208";a="163032720"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 29 Jul 2025 05:12:15 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ugjBk-0001Gl-34;
	Tue, 29 Jul 2025 12:12:12 +0000
Date: Tue, 29 Jul 2025 20:11:49 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 b88313f2a6c3b6de0d4a9b08ddae4f4bfe704a15
Message-ID: <202507292037.VidDI1uq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: b88313f2a6c3b6de0d4a9b08ddae4f4bfe704a15  Bluetooth: hci_sync: Avoid adding default advertising on startup

elapsed time: 923m

configs tested: 120
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250729    gcc-8.5.0
arc                   randconfig-002-20250729    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250729    gcc-15.1.0
arm                   randconfig-002-20250729    clang-19
arm                   randconfig-003-20250729    clang-22
arm                   randconfig-004-20250729    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250729    clang-17
arm64                 randconfig-002-20250729    gcc-10.5.0
arm64                 randconfig-003-20250729    clang-22
arm64                 randconfig-004-20250729    gcc-11.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250729    gcc-15.1.0
csky                  randconfig-002-20250729    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250729    clang-22
hexagon               randconfig-002-20250729    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250729    gcc-12
i386        buildonly-randconfig-002-20250729    clang-20
i386        buildonly-randconfig-003-20250729    clang-20
i386        buildonly-randconfig-004-20250729    clang-20
i386        buildonly-randconfig-005-20250729    gcc-12
i386        buildonly-randconfig-006-20250729    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250729    gcc-15.1.0
loongarch             randconfig-002-20250729    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250729    gcc-8.5.0
nios2                 randconfig-002-20250729    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250729    gcc-10.5.0
parisc                randconfig-002-20250729    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250729    clang-22
powerpc               randconfig-002-20250729    gcc-8.5.0
powerpc               randconfig-003-20250729    gcc-11.5.0
powerpc64             randconfig-001-20250729    clang-22
powerpc64             randconfig-002-20250729    clang-16
powerpc64             randconfig-003-20250729    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250729    clang-22
riscv                 randconfig-002-20250729    clang-17
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250729    gcc-8.5.0
s390                  randconfig-002-20250729    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250729    gcc-14.3.0
sh                    randconfig-002-20250729    gcc-9.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250729    gcc-8.5.0
sparc                 randconfig-002-20250729    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250729    clang-22
sparc64               randconfig-002-20250729    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250729    gcc-12
um                    randconfig-002-20250729    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250729    gcc-12
x86_64      buildonly-randconfig-002-20250729    gcc-12
x86_64      buildonly-randconfig-003-20250729    clang-20
x86_64      buildonly-randconfig-004-20250729    gcc-12
x86_64      buildonly-randconfig-005-20250729    clang-20
x86_64      buildonly-randconfig-006-20250729    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250729    gcc-8.5.0
xtensa                randconfig-002-20250729    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
