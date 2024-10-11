Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40F2198A30
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728665910; cv=none; b=AQvf2A0WBTlVHfCPIBE/yo98Y1gkoq3L3aHnvoj3LxRDWdW3V8KG2ur3BDL8ZR8edE/x2ZhOx8MCwz0lr2WLP4NcjAHjCrn+Oogs0KhGRjFmD1c1xjt7BB3O2iAiJocZKpKVZx/PmmQVs9zwWtvBW3UxS2nvSQphnOAYXvLbag8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728665910; c=relaxed/simple;
	bh=EiEJxctOOCn5A5BQvV65RfraGcViaPPoKW8bXHLAdLo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bE3w9PEIxHgGwAtlUhjqdu0p3ZfjhWi8Kvm2s+BLmq9o8p0bJ7sdbeCVZAHtmqv5wPGNyRXpGPLW8Ix0J8+mpHDSpAGV9Mb8iWyKothc3QrocrfeoGjToe3/2VCdvETHC5xF0ZfZ+j2l8dhKxz4RDeU19DxC31t3rA3QVV8jxJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lbEDh0rz; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lbEDh0rz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728665909; x=1760201909;
  h=date:from:to:cc:subject:message-id;
  bh=EiEJxctOOCn5A5BQvV65RfraGcViaPPoKW8bXHLAdLo=;
  b=lbEDh0rzHsUhAjsEpEIi3v4vsESMnJYOJqnZf9t1SmQmXr63ocnKJfdm
   U/eV06pz+KmLtt7CPJ3T7MhaIo0IUiPVxj2ztQdF5cyoNhCIKMnQBBeqD
   juz2ojxrlCm5BhNBM2cdAj35NFPisqNOBRpMZJDr2uN/kG3VP5ccT7vDJ
   dE7+kOHp+9q3kb2UR5jzmTMXnvKK9yEM6nfe6+VFnUi9zFGNyFU97FtRN
   L+NOFcnLY78BLp6hYmKR6ZZRAgBpbJsmfGZk/twr+bFCX0rH/iphQSksT
   BzsGcNj6HBnCwmHk3Fvz+QqKAQ1WLSxahbEqE3LOtEG8j16Zumji4dsya
   A==;
X-CSE-ConnectionGUID: g4Yu94paSx2bJyFHB1iI+A==
X-CSE-MsgGUID: 5lpKY0OEQpe5Gzgb/Axe9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39198327"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="39198327"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 09:58:28 -0700
X-CSE-ConnectionGUID: jNrLZ/OlTNm1EwSpX418CA==
X-CSE-MsgGUID: hm6NASQ8RzG5tBNuGPhsWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="77060634"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 11 Oct 2024 09:58:27 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szIy9-000CWN-0B;
	Fri, 11 Oct 2024 16:58:25 +0000
Date: Sat, 12 Oct 2024 00:57:45 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 7285f89d6a95ef21dcd5b918364ab4aa6e5fd3ed
Message-ID: <202410120033.A2wMIOQz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 7285f89d6a95ef21dcd5b918364ab4aa6e5fd3ed  Bluetooth: hci_core: Fix not checking skb length on hci_scodata_packet

elapsed time: 984m

configs tested: 65
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha            allnoconfig    gcc-14.1.0
alpha           allyesconfig    clang-20
arc             allmodconfig    clang-20
arc              allnoconfig    gcc-14.1.0
arc             allyesconfig    clang-20
arm             allmodconfig    clang-20
arm              allnoconfig    gcc-14.1.0
arm             allyesconfig    clang-20
arm64           allmodconfig    clang-20
arm64            allnoconfig    gcc-14.1.0
csky             allnoconfig    gcc-14.1.0
hexagon         allmodconfig    clang-20
hexagon          allnoconfig    gcc-14.1.0
hexagon         allyesconfig    clang-20
i386            allmodconfig    clang-18
i386             allnoconfig    clang-18
i386            allyesconfig    clang-18
i386               defconfig    clang-18
loongarch       allmodconfig    gcc-14.1.0
loongarch        allnoconfig    gcc-14.1.0
m68k            allmodconfig    gcc-14.1.0
m68k             allnoconfig    gcc-14.1.0
m68k            allyesconfig    gcc-14.1.0
microblaze      allmodconfig    gcc-14.1.0
microblaze       allnoconfig    gcc-14.1.0
microblaze      allyesconfig    gcc-14.1.0
mips             allnoconfig    gcc-14.1.0
nios2            allnoconfig    gcc-14.1.0
openrisc         allnoconfig    clang-20
openrisc        allyesconfig    gcc-14.1.0
openrisc           defconfig    gcc-12
parisc          allmodconfig    gcc-14.1.0
parisc           allnoconfig    clang-20
parisc          allyesconfig    gcc-14.1.0
parisc             defconfig    gcc-12
powerpc         allmodconfig    gcc-14.1.0
powerpc          allnoconfig    clang-20
powerpc         allyesconfig    gcc-14.1.0
riscv           allmodconfig    gcc-14.1.0
riscv            allnoconfig    clang-20
riscv           allyesconfig    gcc-14.1.0
riscv              defconfig    gcc-12
s390            allmodconfig    gcc-14.1.0
s390             allnoconfig    clang-20
s390            allyesconfig    gcc-14.1.0
s390               defconfig    gcc-12
sh              allmodconfig    gcc-14.1.0
sh               allnoconfig    gcc-14.1.0
sh              allyesconfig    gcc-14.1.0
sh                 defconfig    gcc-12
sparc           allmodconfig    gcc-14.1.0
sparc64            defconfig    gcc-12
um              allmodconfig    clang-20
um               allnoconfig    clang-20
um              allyesconfig    clang-20
um                 defconfig    gcc-12
um            i386_defconfig    gcc-12
um          x86_64_defconfig    gcc-12
x86_64           allnoconfig    clang-18
x86_64          allyesconfig    clang-18
x86_64             defconfig    clang-18
x86_64                 kexec    gcc-12
x86_64              rhel-8.3    gcc-12
x86_64         rhel-8.3-rust    clang-18
xtensa           allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
