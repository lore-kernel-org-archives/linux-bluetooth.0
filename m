Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B6920DC5
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jul 2024 20:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720815170; cv=none; b=qQOJ1uWqgM4+oYpZilhI3zYx4RsxHSB4aoFHIkQGG14HxcLFtzt7/ger+7q58gznENHH+KUechefDsET6GLKnHO+ZMuAMa43SypuUiMqXg3LjnI6zTLKRKihNawxYuBfLuo26Jd893N9EqlBnb/JY6ua5OpopH2k+LbGwvDlV38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720815170; c=relaxed/simple;
	bh=vRi2MO+n9WMPzSGsKi9s8toTUQmlPsdWg242vrmjvJo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hoBP90CJyYhfSQ+hLbTnvuXs57prpNnEhHhxADuZNKYX2NNjGvWfk+gNptiLZpZwIAOcV8fNFwMOPSLtvk/cS9vOcFPzndNr22bKjZLaDc20I1XERa/RuIapX3YUXOY3BqiUtqGXxHvw6I5ggDbS9zHR71iIqODv8KRS+X387qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jfOiqbUl; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jfOiqbUl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720815168; x=1752351168;
  h=date:from:to:cc:subject:message-id;
  bh=vRi2MO+n9WMPzSGsKi9s8toTUQmlPsdWg242vrmjvJo=;
  b=jfOiqbUlf2NMz4rXbu4UP+ixpYXTE4uGo+zDnwy5pmMDhVanU4+/KQas
   039j7nhsN2nQdG9txvpyBSRGpSo9UjzWVDBpcPVT6fFUQeb5ZMzfAfwet
   68v5IN9yvU97YHml+6tL5V2dAWhHyrBa2/cFKy0BfFb4bUO38bg6WhgAB
   6Ql3pzm0walFysYEm0hjGed/0kxGLCEzQmMXjHfAvrFrO4FDy6wZaPrcz
   ZoNFKwBXDcfn8MafQ2TWHUiqLyvcBNfY3GK26yPLjkgUXqkzLfobz40Dh
   RZtyzdp3hGr5pf/HMggNLc5HcGJQ5Rzwf6IQ8dmFW8loCLUqT88deCQpH
   w==;
X-CSE-ConnectionGUID: 2WudF/K8TzOzgxZbr2Nkow==
X-CSE-MsgGUID: M90LuDP1SH65niVM1jovUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="12528471"
X-IronPort-AV: E=Sophos;i="6.09,203,1716274800"; 
   d="scan'208";a="12528471"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 13:12:47 -0700
X-CSE-ConnectionGUID: j7PiKcNvRRa/hV0tRzPcxg==
X-CSE-MsgGUID: CK3ginG1TjmIZ8etmtw94Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,203,1716274800"; 
   d="scan'208";a="54197308"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 12 Jul 2024 13:12:46 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSMdH-000bEd-2m;
	Fri, 12 Jul 2024 20:12:43 +0000
Date: Sat, 13 Jul 2024 04:11:52 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD REGRESSION
 f14c0bb78769f2670fdd8bcd28ca5543a7601c33
Message-ID: <202407130447.hW6DP5OG-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: f14c0bb78769f2670fdd8bcd28ca5543a7601c33  Bluetooth: hci_qca: Fix build error

Error/Warning: (recently discovered and may have been fixed)

btmtk.c:(.text+0x5fc): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_alloc_urb'
btmtk.c:(.text+0x658): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_free_urb'
btmtk.c:(.text+0x7c8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_anchor_urb'
btmtk.c:(.text+0x7d4): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_submit_urb'
btmtk.c:(.text+0x814): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_unanchor_urb'
btmtk.o:(.text+0x10a4): undefined reference to `usb_anchor_urb'
btmtk.o:(.text+0x6d4): undefined reference to `usb_alloc_urb'
btmtk.o:(.text+0xd50): undefined reference to `usb_control_msg'
include/asm-generic/preempt.h:59:(.text+0x22ee): undefined reference to `usb_anchor_urb'
include/linux/usb.h:1399:(.text+0x1072): undefined reference to `usb_set_interface'
microblaze-linux-ld: btmtk.o:(.text+0x728): undefined reference to `usb_free_urb'
microblaze-linux-ld: btmtk.o:(.text+0x824): undefined reference to `usb_anchor_urb'
microblaze-linux-ld: btmtk.o:(.text+0x834): undefined reference to `usb_submit_urb'
microblaze-linux-ld: btmtk.o:(.text+0x890): undefined reference to `usb_unanchor_urb'
mipsel-linux-ld: btmtk.c:(.text+0x1100): undefined reference to `usb_autopm_put_interface'
powerpc-linux-ld: drivers/bluetooth/btmtk.c:1224:(.text+0x2c64): undefined reference to `usb_kill_anchored_urbs'
sh4-linux-ld: btmtk.c:(.text+0x774): undefined reference to `usb_autopm_put_interface'

Unverified Error/Warning (likely false positive, please contact us if interested):

arch/arm64/boot/dts/qcom/sm8650-qrd.dtb: bluetooth: 'vddrfa1p8-supply' is a required property
arch/arm64/boot/dts/qcom/sm8650-qrd.dtb: bluetooth: 'vddrfacmn-supply' is a required property
arch/arm64/boot/dts/qcom/sm8650-qrd.dtb: bluetooth: 'vddwlcx-supply' is a required property
arch/arm64/boot/dts/qcom/sm8650-qrd.dtb: bluetooth: 'vddwlmx-supply' is a required property

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arm64-randconfig-051-20240712
|   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5-vision-mezzanine.dtb:bluetooth:vddbtcmx-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5-vision-mezzanine.dtb:bluetooth:vddrfa0p8-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5-vision-mezzanine.dtb:bluetooth:vddrfa1p2-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5-vision-mezzanine.dtb:bluetooth:vddrfa1p7-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5-vision-mezzanine.dtb:bluetooth:vddrfacmn-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5.dtb:bluetooth:vddbtcmx-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5.dtb:bluetooth:vddrfa0p8-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5.dtb:bluetooth:vddrfa1p2-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5.dtb:bluetooth:vddrfa1p7-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5.dtb:bluetooth:vddrfacmn-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-sm8650-qrd.dtb:bluetooth:vddrfa1p8-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-sm8650-qrd.dtb:bluetooth:vddrfacmn-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-sm8650-qrd.dtb:bluetooth:vddwlcx-supply-is-a-required-property
|   `-- arch-arm64-boot-dts-qcom-sm8650-qrd.dtb:bluetooth:vddwlmx-supply-is-a-required-property
|-- arm64-randconfig-r025-20230108
|   |-- btmtk.c:(.text):relocation-truncated-to-fit:R_AARCH64_CALL26-against-undefined-symbol-usb_alloc_urb
|   |-- btmtk.c:(.text):relocation-truncated-to-fit:R_AARCH64_CALL26-against-undefined-symbol-usb_anchor_urb
|   |-- btmtk.c:(.text):relocation-truncated-to-fit:R_AARCH64_CALL26-against-undefined-symbol-usb_free_urb
|   |-- btmtk.c:(.text):relocation-truncated-to-fit:R_AARCH64_CALL26-against-undefined-symbol-usb_submit_urb
|   `-- btmtk.c:(.text):relocation-truncated-to-fit:R_AARCH64_CALL26-against-undefined-symbol-usb_unanchor_urb
|-- microblaze-randconfig-r012-20220906
|   |-- btmtk.o:(.text):undefined-reference-to-usb_alloc_urb
|   |-- btmtk.o:(.text):undefined-reference-to-usb_anchor_urb
|   |-- btmtk.o:(.text):undefined-reference-to-usb_control_msg
|   |-- microblaze-linux-ld:btmtk.o:(.text):undefined-reference-to-usb_anchor_urb
|   |-- microblaze-linux-ld:btmtk.o:(.text):undefined-reference-to-usb_free_urb
|   |-- microblaze-linux-ld:btmtk.o:(.text):undefined-reference-to-usb_submit_urb
|   `-- microblaze-linux-ld:btmtk.o:(.text):undefined-reference-to-usb_unanchor_urb
|-- mips-randconfig-r022-20220106
|   `-- mipsel-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_autopm_put_interface
|-- parisc-randconfig-001-20240712
|   |-- (.text):undefined-reference-to-usb_alloc_urb
|   |-- (.text):undefined-reference-to-usb_anchor_urb
|   |-- (.text):undefined-reference-to-usb_control_msg
|   |-- (.text):undefined-reference-to-usb_kill_anchored_urbs
|   |-- (.text):undefined-reference-to-usb_set_interface
|   |-- hppa-linux-ld:(.text):undefined-reference-to-usb_anchor_urb
|   |-- hppa-linux-ld:(.text):undefined-reference-to-usb_free_urb
|   |-- hppa-linux-ld:(.text):undefined-reference-to-usb_kill_anchored_urbs
|   |-- hppa-linux-ld:(.text):undefined-reference-to-usb_submit_urb
|   `-- hppa-linux-ld:(.text):undefined-reference-to-usb_unanchor_urb
|-- powerpc-randconfig-r003-20230723
|   `-- powerpc-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_kill_anchored_urbs
|-- riscv-randconfig-r034-20220801
|   |-- include-asm-generic-preempt.h:(.text):undefined-reference-to-usb_anchor_urb
|   `-- include-linux-usb.h:(.text):undefined-reference-to-usb_set_interface
`-- sh-randconfig-r013-20230817
    `-- sh4-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_autopm_put_interface

elapsed time: 1398m

configs tested: 134
configs skipped: 2

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240712   gcc-13.2.0
arc                   randconfig-002-20240712   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-14.1.0
arm                   randconfig-001-20240712   clang-19
arm                   randconfig-002-20240712   clang-19
arm                   randconfig-003-20240712   gcc-14.1.0
arm                   randconfig-004-20240712   clang-15
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240712   gcc-14.1.0
arm64                 randconfig-002-20240712   gcc-14.1.0
arm64                 randconfig-003-20240712   clang-19
arm64                 randconfig-004-20240712   clang-17
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240712   gcc-14.1.0
csky                  randconfig-002-20240712   gcc-14.1.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240712   clang-14
hexagon               randconfig-002-20240712   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240712   gcc-9
i386         buildonly-randconfig-002-20240712   clang-18
i386         buildonly-randconfig-003-20240712   clang-18
i386         buildonly-randconfig-004-20240712   clang-18
i386         buildonly-randconfig-005-20240712   gcc-11
i386         buildonly-randconfig-006-20240712   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240712   clang-18
i386                  randconfig-002-20240712   clang-18
i386                  randconfig-003-20240712   clang-18
i386                  randconfig-004-20240712   clang-18
i386                  randconfig-005-20240712   clang-18
i386                  randconfig-006-20240712   clang-18
i386                  randconfig-011-20240712   clang-18
i386                  randconfig-012-20240712   clang-18
i386                  randconfig-013-20240712   clang-18
i386                  randconfig-014-20240712   gcc-10
i386                  randconfig-015-20240712   gcc-10
i386                  randconfig-016-20240712   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240712   gcc-14.1.0
loongarch             randconfig-002-20240712   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240712   gcc-14.1.0
nios2                 randconfig-002-20240712   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240712   gcc-14.1.0
parisc                randconfig-002-20240712   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc               randconfig-001-20240712   clang-15
powerpc               randconfig-002-20240712   clang-19
powerpc               randconfig-003-20240712   clang-19
powerpc64             randconfig-001-20240712   clang-19
powerpc64             randconfig-002-20240712   clang-19
powerpc64             randconfig-003-20240712   gcc-14.1.0
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                 randconfig-001-20240712   clang-19
riscv                 randconfig-002-20240712   gcc-14.1.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                  randconfig-001-20240712   gcc-14.1.0
s390                  randconfig-002-20240712   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                    randconfig-001-20240712   gcc-14.1.0
sh                    randconfig-002-20240712   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64               randconfig-001-20240712   gcc-14.1.0
sparc64               randconfig-002-20240712   gcc-14.1.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                    randconfig-001-20240712   clang-19
um                    randconfig-002-20240712   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240712   clang-18
x86_64       buildonly-randconfig-002-20240712   clang-18
x86_64       buildonly-randconfig-003-20240712   clang-18
x86_64       buildonly-randconfig-004-20240712   clang-18
x86_64       buildonly-randconfig-005-20240712   clang-18
x86_64       buildonly-randconfig-006-20240712   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240712   gcc-12
x86_64                randconfig-002-20240712   gcc-13
x86_64                randconfig-003-20240712   gcc-12
x86_64                randconfig-004-20240712   clang-18
x86_64                randconfig-005-20240712   gcc-13
x86_64                randconfig-006-20240712   clang-18
x86_64                randconfig-011-20240712   clang-18
x86_64                randconfig-012-20240712   clang-18
x86_64                randconfig-013-20240712   clang-18
x86_64                randconfig-014-20240712   gcc-13
x86_64                randconfig-015-20240712   clang-18
x86_64                randconfig-016-20240712   clang-18
x86_64                randconfig-071-20240712   gcc-13
x86_64                randconfig-072-20240712   gcc-11
x86_64                randconfig-073-20240712   clang-18
x86_64                randconfig-074-20240712   gcc-9
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240712   gcc-14.1.0
xtensa                randconfig-002-20240712   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
