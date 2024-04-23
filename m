Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBC91CFB2
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2024 06:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713854955; cv=none; b=D5JpJFeu04e2NA5V+zoVeisSxDpkqWwiHAV3ZXPAecj0G+xPAlP08/eJP1AMpRIY24erUEoGBRkljNFhNcH1cshJ33oPImVySiQk7IUsrLGJQ4H5idALT7v6lEeLLdXs7XYQb3URuaiwbbjWmi5q9w6je9wVxjaX+PP4TXGcLtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713854955; c=relaxed/simple;
	bh=rbT8zW5NQLcJQyMGY+L84RuXoNTDBXFC8MF2NSDQSdQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=aNKWoYwoz4L1NjjYicEKbc4ElYyRUpuq8UWicyZY9h904RxzYfFpSRjUCKVVQUGxJkSUbP+NM5AziVvCqY1Rfek/s2+q7WYJe23HTYCjSBvPHeFKxSnLbbq3g2ujhITnRLHf28E+52JyuUK3CiENBjKIyx+XQJfNQBZwSNdSreM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j+1HgL5t; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+1HgL5t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713854953; x=1745390953;
  h=date:from:to:cc:subject:message-id;
  bh=rbT8zW5NQLcJQyMGY+L84RuXoNTDBXFC8MF2NSDQSdQ=;
  b=j+1HgL5tnWgTud2BvetpL2Y9dmoU5N2R8IbQfxpMdPXKqL0+ygqvA4MP
   OTOoSRcJQrkK8aReFLvmrO5eLJ8Cd3MUctrum5juzh2yZ7BzXrNi05l8u
   NgYexJcTPUm0cRPC6LR8LjHfG47ZTct7hL5CJRcej/UYB9BfnLMqQpkt4
   ek2AS8i7uhYDxQPkn1PG+GjG7sN25v7gP1u5Fq9FZnYQVDDKcrEs00nuZ
   MY75meD7mjbN/p/19C7cvd29wLFoyYu7m/OmVVcSj+Ov+fwt08z8G0QB5
   9YBaC4/JLT9+rARqJdJ8MoOiNt8eL0fWQ9ifgy1TToYAtd+XSDQ7Wsvzq
   A==;
X-CSE-ConnectionGUID: UMDGZ9nCQJGWtLyyfpduKQ==
X-CSE-MsgGUID: B6xE+Qg+SBGnAnq6yIPRGw==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="20573654"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20573654"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 23:49:12 -0700
X-CSE-ConnectionGUID: vZb6S8+FSMSUqPNKKq/Ovw==
X-CSE-MsgGUID: u32qmZzOR+OSFg2jfm+KBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="55204192"
Received: from lkp-server01.sh.intel.com (HELO 01437695816f) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 22 Apr 2024 23:49:11 -0700
Received: from kbuild by 01437695816f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rz9xk-0000Ys-1T;
	Tue, 23 Apr 2024 06:49:08 +0000
Date: Tue, 23 Apr 2024 14:49:05 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 958efeeef2d3b90461e7e6a2eac80333c80812fa
Message-ID: <202404231400.gMQ92kGv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 958efeeef2d3b90461e7e6a2eac80333c80812fa  Bluetooth: Remove 3 repeated macro definitions

elapsed time: 868m

configs tested: 85
configs skipped: 3

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
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                                defconfig   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
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
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
