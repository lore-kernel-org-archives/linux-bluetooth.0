Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE304582BAF
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 19:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789069217; cv=none; b=AqO/ur+8eZTSjoefjYU04czsUc1yX5SgboF2kz7QkesJhW1GePQcP6xqBVrTL/B7b4UBbvu5NYd9w8JEKBj/zBCTOHdK2dqF69BDsbNQ5HeDXk2Ywuo4QVBSiNNBrCwZaLuvo7B9JROkqt07EFoICBjcAKoeTOHtoxx9IoMj1xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789069217; c=relaxed/simple;
	bh=7BVNj7Db5p0JLjkG36r/6CwJQuFCLOFzGnuRXCZTSmA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=f17oZLYbZ8buvvk9+eW9cNcjbZce+8CsIK7OpGS6UasvJBzQzZ/twWtXs9oNkSAifE5HpZ3nbyN92IAvjFzSXqkk205q2TSsK1wV+7spelk9qp8i2htCUrFlFBAYUPk5CbnSUkdpptcTP8eB/cbV1qXvGz6QkBG6x9Ji4nUsydY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PyaLfIvy; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PyaLfIvy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789069216; x=1820605216;
  h=date:from:to:cc:subject:message-id;
  bh=7BVNj7Db5p0JLjkG36r/6CwJQuFCLOFzGnuRXCZTSmA=;
  b=PyaLfIvyLG6Z34SRDZuHFY+dTs7VxkRBVpz8q1Vfk4v1WRCWkJAd3Wh7
   Lzs8RJTIVt8guKt7TcAKH61H/ACJAR3Q71sfKTJv+Eu+bpXuZhFxpuXaI
   v+sU1ueE+hC7yROBGn9aL1O5ubhj/hfukryiN83m7Q2cuoHmpEYjJ3uPe
   UkesxwBUzG0f9WgfIcUZtIpHQCiBWKwrPzZ1VLU2dUvlO6TSVRfb4tvSQ
   BzUyRp9Yw1DW9Vf08WRa5xR+YzlLAFDZJ1bgFZwyfU8sYnixAOFkbOU68
   fbRzuBxbjZ1L0dNlokhv/YlX/3QtO3ivUXPX26kxOO8VMU47emL6lsJV7
   g==;
X-CSE-ConnectionGUID: tVEiWzBvSOKwZQ4WuTse1Q==
X-CSE-MsgGUID: GbmiyoM+RuyDmCL6m8DFAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89402272"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="89402272"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 12:40:15 -0700
X-CSE-ConnectionGUID: W1SLepJpTreZJSNVj+PwRg==
X-CSE-MsgGUID: rAptZySjT1ue1UwN+MP4Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="60161"
Received: from lkp-server02.sh.intel.com (HELO 0a3643a6ed9d) ([10.239.97.151])
  by fmviesa011.fm.intel.com with ESMTP; 10 Sep 2026 12:40:14 -0700
Received: from kbuild by 0a3643a6ed9d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x4kd2-000000000U9-0CZT;
	Thu, 10 Sep 2026 19:40:12 +0000
Date: Fri, 11 Sep 2026 03:39:07 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 1b737f2ef1686d0e5a7661eaeb097aad53ea7040
Message-ID: <202609110302.lJlsRbX8-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 1b737f2ef1686d0e5a7661eaeb097aad53ea7040  Bluetooth: btmtk: Replace magic numbers with WMT packet flag enum

elapsed time: 1404m

configs tested: 64
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    clang-24
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    clang-24
arc          allyesconfig    gcc-16.1.0
arm           allnoconfig    gcc-16.1.0
arm          allyesconfig    clang-24
arm64        allmodconfig    clang-24
arm64         allnoconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
csky          allnoconfig    gcc-16.1.0
hexagon      allmodconfig    clang-24
hexagon      allmodconfig    gcc-16.1.0
hexagon       allnoconfig    gcc-16.1.0
i386         allmodconfig    clang-22
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-16.1.0
i386         allyesconfig    clang-22
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch    allmodconfig    clang-24
loongarch     allnoconfig    gcc-16.1.0
m68k         allmodconfig    gcc-16.1.0
m68k          allnoconfig    gcc-16.1.0
m68k         allyesconfig    clang-24
microblaze    allnoconfig    gcc-16.1.0
microblaze   allyesconfig    gcc-16.1.0
mips         allmodconfig    gcc-16.1.0
mips          allnoconfig    gcc-16.1.0
mips         allyesconfig    gcc-16.1.0
nios2        allmodconfig    clang-20
nios2         allnoconfig    clang-24
openrisc     allmodconfig    clang-20
openrisc      allnoconfig    clang-24
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    clang-24
parisc       allyesconfig    clang-17
parisc       allyesconfig    gcc-16.1.0
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    clang-24
riscv        allmodconfig    clang-24
riscv         allnoconfig    clang-24
riscv        allyesconfig    clang-24
s390         allmodconfig    clang-17
s390         allmodconfig    clang-24
s390          allnoconfig    clang-24
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    clang-24
sh           allyesconfig    clang-17
sh           allyesconfig    gcc-16.1.0
sparc         allnoconfig    clang-24
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-17
um            allnoconfig    clang-24
um           allyesconfig    gcc-14
um           allyesconfig    gcc-16.1.0
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-24
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    clang-24
xtensa       allyesconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
