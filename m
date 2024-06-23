Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A06183066
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Jun 2024 16:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719160384; cv=none; b=bO6MTYDBi7zMieoxRpNnuuaRrvUXI1GcH51FX5+ACrQerI34yzPTFd007qLFcnfgURuE4Ft1yZJF4G02ZoMuWPStfRsSYOz7RAwsMG9DcmNVVN5udstyIK1PSLUB0EqpWCTn3PF8yICw9K0VsOdUELvsLH/IARQKxQx3nD3r68g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719160384; c=relaxed/simple;
	bh=EoLJFBcrR1dFkZJTUJyFJvTrAH8u/n7jEVFKaVbaYVY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hr//Ba3DmrrJiy+KsVBNgTi2drWceMcRe8be/6mLpWUQZFYqAXWqoJkRurjJR3X+d4lDvE/igW7cYxDtP57OlHK2f20BkgFxBMLoFT6wW37p33JY5UONXDvw9IniW+hdv+vWVEjv3tpeP6cUwlJlaJaIzdAeZMfQNExn1llQS5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VxVYgXXN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VxVYgXXN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719160382; x=1750696382;
  h=date:from:to:cc:subject:message-id;
  bh=EoLJFBcrR1dFkZJTUJyFJvTrAH8u/n7jEVFKaVbaYVY=;
  b=VxVYgXXNK1LTqcclW0QNJqk/AfoSQ2kRqogmLu5mSZx5XKnnxxmlFq9a
   xRbcuGIzSgezstHCN7W36FrcWDb2/sce5GI84DGej2KIrk1zAk8xQQY2n
   GB80zM0jI8o5XftfFHVjXEs5xt6DgmSx8zvhH5512S4pPIlSj/2mRMjQs
   aupLGi33D2FieNVHUcORLyaK4z8sSSAeEUy8pGbMFn6V2NsuDCcOFb/JS
   Ub/1/zGf9jEYOkgnRi9xwvlQ4XzwQA36gBzKtOsXKgKxOMM4OXfbcQBem
   pAuBG3B5hViNw56DCAB61x3fhdcsTjCN3y1zVNEujbeZOUmpW07HzC2eV
   w==;
X-CSE-ConnectionGUID: 9vEfGnORRN6MuJyUSOHjlw==
X-CSE-MsgGUID: 5lJQk1Y3T5SjUMM+KIbYPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="27264716"
X-IronPort-AV: E=Sophos;i="6.08,260,1712646000"; 
   d="scan'208";a="27264716"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 09:33:02 -0700
X-CSE-ConnectionGUID: o9MzEELlRsG1gz5zRx+Ohw==
X-CSE-MsgGUID: HWOO6bmSRXu0mrht71+A/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,260,1712646000"; 
   d="scan'208";a="74283041"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 23 Jun 2024 09:33:01 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sLQ9C-000Adq-0o;
	Sun, 23 Jun 2024 16:32:58 +0000
Date: Mon, 24 Jun 2024 00:32:35 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS WITH WARNING
 4029dba6b6f105e052272bed37bc82f0ce3e0de3
Message-ID: <202406240033.1qBVt7cw-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 4029dba6b6f105e052272bed37bc82f0ce3e0de3  Bluetooth: qca: use the power sequencer for QCA6390

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202406210706.WvRRDs6P-lkp@intel.com

Warning: (recently discovered and may have been fixed)

arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dtb: bluetooth: 'vddbtcmx-supply' is a required property
arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dtb: bluetooth: 'vddrfa0p8-supply' is a required property
arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dtb: bluetooth: 'vddrfa1p2-supply' is a required property
arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dtb: bluetooth: 'vddrfa1p7-supply' is a required property
arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dtb: bluetooth: 'vddrfacmn-supply' is a required property
arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb: bluetooth: 'vddbtcmx-supply' is a required property
arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb: bluetooth: 'vddrfa0p8-supply' is a required property
arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb: bluetooth: 'vddrfa1p2-supply' is a required property
arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb: bluetooth: 'vddrfa1p7-supply' is a required property
arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb: bluetooth: 'vddrfacmn-supply' is a required property

Warning ids grouped by kconfigs:

clang_recent_errors
`-- arm64-randconfig-051-20240620
    |-- arch-arm64-boot-dts-qcom-qrb5165-rb5-vision-mezzanine.dtb:bluetooth:vddbtcmx-supply-is-a-required-property
    |-- arch-arm64-boot-dts-qcom-qrb5165-rb5-vision-mezzanine.dtb:bluetooth:vddrfa0p8-supply-is-a-required-property
    |-- arch-arm64-boot-dts-qcom-qrb5165-rb5-vision-mezzanine.dtb:bluetooth:vddrfa1p2-supply-is-a-required-property
    |-- arch-arm64-boot-dts-qcom-qrb5165-rb5-vision-mezzanine.dtb:bluetooth:vddrfa1p7-supply-is-a-required-property
    |-- arch-arm64-boot-dts-qcom-qrb5165-rb5-vision-mezzanine.dtb:bluetooth:vddrfacmn-supply-is-a-required-property
    |-- arch-arm64-boot-dts-qcom-qrb5165-rb5.dtb:bluetooth:vddbtcmx-supply-is-a-required-property
    |-- arch-arm64-boot-dts-qcom-qrb5165-rb5.dtb:bluetooth:vddrfa0p8-supply-is-a-required-property
    |-- arch-arm64-boot-dts-qcom-qrb5165-rb5.dtb:bluetooth:vddrfa1p2-supply-is-a-required-property
    |-- arch-arm64-boot-dts-qcom-qrb5165-rb5.dtb:bluetooth:vddrfa1p7-supply-is-a-required-property
    `-- arch-arm64-boot-dts-qcom-qrb5165-rb5.dtb:bluetooth:vddrfacmn-supply-is-a-required-property

elapsed time: 4439m

configs tested: 86
configs skipped: 1

tested configs:
arc                        nsimosci_defconfig   gcc-13.2.0
arc                   randconfig-001-20240621   gcc-13.2.0
arc                   randconfig-002-20240621   gcc-13.2.0
arm                      jornada720_defconfig   clang-19
arm                         mv78xx0_defconfig   clang-19
arm                   randconfig-001-20240621   gcc-13.2.0
arm                   randconfig-002-20240621   gcc-13.2.0
arm                   randconfig-003-20240621   clang-19
arm                   randconfig-004-20240621   gcc-13.2.0
arm                         vf610m4_defconfig   gcc-13.2.0
arm                         wpcm450_defconfig   gcc-13.2.0
arm64                 randconfig-001-20240621   clang-15
arm64                 randconfig-002-20240621   clang-19
arm64                 randconfig-003-20240621   gcc-13.2.0
arm64                 randconfig-004-20240621   clang-19
csky                  randconfig-001-20240621   gcc-13.2.0
csky                  randconfig-002-20240621   gcc-13.2.0
hexagon               randconfig-001-20240621   clang-17
hexagon               randconfig-002-20240621   clang-16
i386         buildonly-randconfig-001-20240621   clang-18
i386         buildonly-randconfig-002-20240621   gcc-7
i386         buildonly-randconfig-003-20240621   clang-18
i386         buildonly-randconfig-004-20240621   clang-18
i386         buildonly-randconfig-005-20240621   clang-18
i386         buildonly-randconfig-006-20240621   clang-18
i386                  randconfig-001-20240621   clang-18
i386                  randconfig-002-20240621   gcc-13
i386                  randconfig-003-20240621   gcc-9
i386                  randconfig-004-20240621   gcc-13
i386                  randconfig-005-20240621   clang-18
i386                  randconfig-006-20240621   clang-18
i386                  randconfig-011-20240621   gcc-13
i386                  randconfig-012-20240621   gcc-13
i386                  randconfig-013-20240621   gcc-13
i386                  randconfig-014-20240621   clang-18
i386                  randconfig-015-20240621   gcc-13
i386                  randconfig-016-20240621   gcc-12
loongarch             randconfig-001-20240621   gcc-13.2.0
loongarch             randconfig-002-20240621   gcc-13.2.0
mips                     decstation_defconfig   gcc-13.2.0
mips                        qi_lb60_defconfig   clang-19
nios2                 randconfig-001-20240621   gcc-13.2.0
nios2                 randconfig-002-20240621   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240621   gcc-13.2.0
parisc                randconfig-002-20240621   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                        icon_defconfig   gcc-13.2.0
powerpc                 mpc832x_rdb_defconfig   gcc-13.2.0
powerpc                     ppa8548_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240621   clang-15
powerpc               randconfig-002-20240621   clang-19
powerpc               randconfig-003-20240621   clang-19
powerpc64             randconfig-001-20240621   clang-19
powerpc64             randconfig-002-20240621   clang-19
powerpc64             randconfig-003-20240621   clang-19
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240621   gcc-13.2.0
riscv                 randconfig-002-20240621   clang-19
s390                              allnoconfig   clang-19
s390                                defconfig   clang-19
s390                  randconfig-001-20240621   gcc-13.2.0
s390                  randconfig-002-20240621   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                    randconfig-001-20240621   gcc-13.2.0
sh                    randconfig-002-20240621   gcc-13.2.0
sparc                             allnoconfig   gcc-13.2.0
sparc                               defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240621   gcc-13.2.0
sparc64               randconfig-002-20240621   gcc-13.2.0
um                                allnoconfig   clang-17
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240621   gcc-13
um                    randconfig-002-20240621   gcc-9
um                           x86_64_defconfig   clang-15
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240621   gcc-13.2.0
xtensa                randconfig-002-20240621   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
