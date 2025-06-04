Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5D028DB61
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Jun 2025 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749045178; cv=none; b=g/nnfCmGamT0FKjKqMf0S/yiPF8tuHMr64Pze8HCkO/KJv6No/4tW9iNjXyrAoI61Vhp1L81scXnCLt8nd2BO4UicJ0Vf7C1U3pOGKc1gQmICZU0EwMFbVeV9ojfBKwQRzi6WwcYRHtaeT/JxuU2+cGzIeOFdgRYBIxUQK+2j5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749045178; c=relaxed/simple;
	bh=tCRsh4i/qFBwxf1gxWNMIlO8VNBJWhH29EoM4uoVv4I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=s6ZfJt2mHLcXJ93/NTFnxxsviZYQU8zKm5qoHrjNDwBTlX3wQVfo/NqjQLZ/zGsWuJj2hm9+15Flj7XyZwYran+YC8c/4LOKrUx64dMcCgqoaF31NtrpF/Lr6U8j8L5cXFsBcEaxTRuEav2V4PFPOAufNkCkP7LraIx8ToSxtzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WQKUz3Bu; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQKUz3Bu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749045177; x=1780581177;
  h=date:from:to:cc:subject:message-id;
  bh=tCRsh4i/qFBwxf1gxWNMIlO8VNBJWhH29EoM4uoVv4I=;
  b=WQKUz3BuiH7H/n0OBOeIAvsBByC2wS4lt1ofx1wWdAb54hNY+Q8K1/9p
   WJPw1FKoNZOk7v0FLuuZcBprAf6PH74C0vIjgyvLwa6IHSVhJ94tAzw8M
   lVa/N/Rb2m842K+2AxbGa4MoWP4V17C7zkr6hHbltxvnjkiOoB5u48aYf
   oEvjI/NRvIfT8FSTd4OuG7B6UKBK8N3wf6Li+jz1XXHgltcHbFi/n0Sqy
   3Khq6E6nVz/UXtDk8+y4X2AmLM72iM96qkmEdXuI8/SDS6BsGpkN096WR
   T7HbesZo6cAjV+3dRhuFrwEkcoZRw8HYjUdi3tiIveMBO/NvfuJ58u8MS
   A==;
X-CSE-ConnectionGUID: u3GFsCRKRy2e1L0CrdXNgA==
X-CSE-MsgGUID: 8dThV5xER5q3v4ZX18AS2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="61394285"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="61394285"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 06:52:57 -0700
X-CSE-ConnectionGUID: /+SFsRwSS0KEYE4H3Jys/g==
X-CSE-MsgGUID: plaINk0nSZq4or+EXwsovQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="182368336"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 04 Jun 2025 06:52:56 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uMoY1-0003B7-1z;
	Wed, 04 Jun 2025 13:52:53 +0000
Date: Wed, 04 Jun 2025 21:52:28 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 fa2c8bfe6794411c18231d94213484122c3bff50
Message-ID: <202506042118.wBWkZmzS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: fa2c8bfe6794411c18231d94213484122c3bff50  Bluetooth: btintel_pcie: Reduce driver buffer posting to prevent race condition

elapsed time: 1397m

configs tested: 35
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha        allyesconfig    gcc-15.1.0
arc          allmodconfig    gcc-15.1.0
arc          allyesconfig    gcc-15.1.0
arm          allmodconfig    gcc-15.1.0
arm          allyesconfig    gcc-15.1.0
arm64        allmodconfig    clang-19
hexagon      allmodconfig    clang-17
hexagon      allyesconfig    clang-21
i386         allmodconfig    gcc-12
i386          allnoconfig    gcc-12
i386         allyesconfig    gcc-12
i386            defconfig    clang-20
loongarch    allmodconfig    gcc-15.1.0
m68k         allmodconfig    gcc-15.1.0
m68k         allyesconfig    gcc-15.1.0
microblaze   allmodconfig    gcc-15.1.0
microblaze   allyesconfig    gcc-15.1.0
openrisc     allyesconfig    gcc-15.1.0
parisc       allmodconfig    gcc-15.1.0
parisc       allyesconfig    gcc-15.1.0
powerpc      allmodconfig    gcc-15.1.0
powerpc      allyesconfig    clang-21
riscv        allmodconfig    clang-21
riscv        allyesconfig    clang-16
s390         allmodconfig    clang-18
s390         allyesconfig    gcc-15.1.0
sh           allmodconfig    gcc-15.1.0
sh           allyesconfig    gcc-15.1.0
sparc        allmodconfig    gcc-15.1.0
um           allmodconfig    clang-19
um           allyesconfig    gcc-12
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64          defconfig    gcc-11
x86_64      rhel-9.4-rust    clang-18

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
