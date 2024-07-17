Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E5A1BC39
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jul 2024 08:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721205485; cv=none; b=C8SGqPm/PM0CrG3vPBPsKyn+XLp4w5EaHZtB49xXo3rn33r8jot9Dl1phiTzXSmBKFk6oL4oE9QCSyhuYfcKkpa0vLskJPKa1kqDKW1xG2ZREL0XBut1RQXnalxWTg+wEm9KNlbD2xFBWpWgABa5llU5scoaIo2T0LTbDa3WVrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721205485; c=relaxed/simple;
	bh=vymAvaXabtHVbciZLPNrJpCkcdBnqiIuX10qyb9XI28=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KMSmSvEBsfHdVhimp85oC0PdCQ9chr55dA9VXBreey3Rg368vo+ySjLEwDPaKobT+Vwp72ln4CNzxyaQ0AIiaDhWCHFF9tWuc5RH7FA/PbBC6yaLt4Di7lLXiJW26C69KiKTbqoNmJJMPqJJphu8p2XYkiFDvp4KGwb4E3g/k5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bopRBrw4; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bopRBrw4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721205483; x=1752741483;
  h=date:from:to:cc:subject:message-id;
  bh=vymAvaXabtHVbciZLPNrJpCkcdBnqiIuX10qyb9XI28=;
  b=bopRBrw4NOwShmY51/EGml8yZdZ98H/n9iLL4PJlJqxWqQGlAKcl7OhM
   CAjtapsxFUkxZWecWfD01GDvW+bBygLvn5FfdEQwUoEzsUbPVvEHX2jYZ
   hpbyMRIdWr+4HuU86RglGbLfC6CPQMW+YCxfhf6yUdYk5WCnrBbFWqVA5
   3m1vAv+6knu/zeUyugUvf9VtlrsbSNvHGTsFPYfgoO2eutVe4M/OjGIKt
   FbaqSTFrwwpkslQQL+6DUm1o6/UTVde0h8VRF6EPS75LCb//9Qk5FYSaB
   u/uv6DO+baUlNHee0gF66oeGLPu5eKt0srMvM2O1RjCBMvXUjUrZI02Mx
   w==;
X-CSE-ConnectionGUID: jjdFVN6HQKWsS8847VsIEg==
X-CSE-MsgGUID: rMAe4wHtTOWIUirwIoej6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="29277415"
X-IronPort-AV: E=Sophos;i="6.09,214,1716274800"; 
   d="scan'208";a="29277415"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 01:38:03 -0700
X-CSE-ConnectionGUID: hzeZEMjqR6SjBXCmQ4Td+Q==
X-CSE-MsgGUID: 90DNkYMSTrOvNvvtcu98JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,214,1716274800"; 
   d="scan'208";a="54505488"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 17 Jul 2024 01:38:02 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sU0Ah-000g9b-1N;
	Wed, 17 Jul 2024 08:37:59 +0000
Date: Wed, 17 Jul 2024 16:37:11 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD REGRESSION
 0c9b6e2f7742d52437d477f4ed045fa0b4d55f44
Message-ID: <202407171605.Q76xieqE-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 0c9b6e2f7742d52437d477f4ed045fa0b4d55f44  Bluetooth: btmtk: Fix kernel crash when entering btmtk_usb_suspend

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "usb_control_msg" [drivers/bluetooth/btmtk.ko] undefined!
btmtk.c:(.text+0x8a4): relocation truncated to fit: R_NIOS2_CALL26 against `usb_alloc_urb'
btmtk.c:(.text+0x8a4): undefined reference to `usb_alloc_urb'
btmtk.c:(.text+0x8d4): relocation truncated to fit: R_NIOS2_CALL26 against `usb_free_urb'
btmtk.c:(.text+0x970): relocation truncated to fit: R_NIOS2_CALL26 against `usb_anchor_urb'
btmtk.c:(.text+0x97c): relocation truncated to fit: R_NIOS2_CALL26 against `usb_submit_urb'
btmtk.c:(.text+0x9c4): relocation truncated to fit: R_NIOS2_CALL26 against `usb_unanchor_urb'
btmtk.c:(.text+0xc74): undefined reference to `usb_anchor_urb'
include/asm-generic/unaligned.h:47:(.text+0xbde): undefined reference to `usb_control_msg'
include/linux/fortify-string.h:233:(.text+0x1cbe): undefined reference to `usb_set_interface'
mipsel-linux-ld: drivers/bluetooth/btmtk.c:(.text+0x2be8): undefined reference to `usb_kill_anchored_urbs'
nios2-linux-ld: btmtk.c:(.text+0x8d4): undefined reference to `usb_free_urb'
nios2-linux-ld: btmtk.c:(.text+0x970): undefined reference to `usb_anchor_urb'
nios2-linux-ld: btmtk.c:(.text+0x97c): undefined reference to `usb_submit_urb'
nios2-linux-ld: btmtk.c:(.text+0x9c4): undefined reference to `usb_unanchor_urb'
powerpc-linux-ld: drivers/bluetooth/btmtk.c:1147:(.text.btmtk_intr_complete+0x1a4): undefined reference to `usb_submit_urb'
powerpc-linux-ld: drivers/bluetooth/btmtk.c:1157:(.text.btmtk_intr_complete+0x230): undefined reference to `usb_unanchor_urb'
powerpc-linux-ld: drivers/bluetooth/btmtk.c:1181:(.text.btmtk_submit_intr_urb+0x80): undefined reference to `usb_free_urb'
powerpc-linux-ld: drivers/bluetooth/btmtk.c:1195:(.text.btmtk_submit_intr_urb+0x128): undefined reference to `usb_anchor_urb'
powerpc-linux-ld: drivers/bluetooth/btmtk.c:1197:(.text.btmtk_submit_intr_urb+0x134): undefined reference to `usb_submit_urb'
powerpc-linux-ld: drivers/bluetooth/btmtk.c:1202:(.text.btmtk_submit_intr_urb+0x17c): undefined reference to `usb_unanchor_urb'
riscv32-linux-ld: btmtk.c:(.text+0x279a): undefined reference to `usb_kill_anchored_urbs'
riscv32-linux-ld: drivers/bluetooth/btmtk.c:84:(.text+0x1bd0): undefined reference to `usb_kill_anchored_urbs'
riscv32-linux-ld: include/linux/skbuff.h:2718:(.text+0x175e): undefined reference to `usb_submit_urb'
riscv64-linux-ld: include/linux/usb.h:1974:(.text+0xc4e): undefined reference to `usb_control_msg'

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arm-randconfig-003-20240717
|   |-- ERROR:usb_alloc_urb-drivers-bluetooth-btmtk.ko-undefined
|   |-- ERROR:usb_anchor_urb-drivers-bluetooth-btmtk.ko-undefined
|   |-- ERROR:usb_free_urb-drivers-bluetooth-btmtk.ko-undefined
|   `-- ERROR:usb_submit_urb-drivers-bluetooth-btmtk.ko-undefined
|-- arm64-randconfig-051-20240717
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
|-- i386-randconfig-006-20240716
|   `-- ERROR:usb_control_msg-drivers-bluetooth-btmtk.ko-undefined
|-- i386-randconfig-011-20240717
|   |-- ERROR:usb_alloc_urb-drivers-bluetooth-btmtk.ko-undefined
|   |-- ERROR:usb_anchor_urb-drivers-bluetooth-btmtk.ko-undefined
|   |-- ERROR:usb_control_msg-drivers-bluetooth-btmtk.ko-undefined
|   |-- ERROR:usb_free_urb-drivers-bluetooth-btmtk.ko-undefined
|   `-- ERROR:usb_submit_urb-drivers-bluetooth-btmtk.ko-undefined
|-- mips-randconfig-r006-20230804
|   `-- mipsel-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_kill_anchored_urbs
|-- nios2-randconfig-001-20240717
|   |-- btmtk.c:(.text):relocation-truncated-to-fit:R_NIOS2_CALL26-against-usb_alloc_urb
|   |-- btmtk.c:(.text):relocation-truncated-to-fit:R_NIOS2_CALL26-against-usb_anchor_urb
|   |-- btmtk.c:(.text):relocation-truncated-to-fit:R_NIOS2_CALL26-against-usb_free_urb
|   |-- btmtk.c:(.text):relocation-truncated-to-fit:R_NIOS2_CALL26-against-usb_submit_urb
|   |-- btmtk.c:(.text):relocation-truncated-to-fit:R_NIOS2_CALL26-against-usb_unanchor_urb
|   |-- btmtk.c:(.text):undefined-reference-to-usb_alloc_urb
|   |-- btmtk.c:(.text):undefined-reference-to-usb_anchor_urb
|   |-- nios2-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_anchor_urb
|   |-- nios2-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_free_urb
|   |-- nios2-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_submit_urb
|   `-- nios2-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_unanchor_urb
|-- powerpc-buildonly-randconfig-r004-20220420
|   |-- powerpc-linux-ld:drivers-bluetooth-btmtk.c:(.text.btmtk_intr_complete):undefined-reference-to-usb_submit_urb
|   |-- powerpc-linux-ld:drivers-bluetooth-btmtk.c:(.text.btmtk_intr_complete):undefined-reference-to-usb_unanchor_urb
|   |-- powerpc-linux-ld:drivers-bluetooth-btmtk.c:(.text.btmtk_submit_intr_urb):undefined-reference-to-usb_anchor_urb
|   |-- powerpc-linux-ld:drivers-bluetooth-btmtk.c:(.text.btmtk_submit_intr_urb):undefined-reference-to-usb_free_urb
|   |-- powerpc-linux-ld:drivers-bluetooth-btmtk.c:(.text.btmtk_submit_intr_urb):undefined-reference-to-usb_submit_urb
|   `-- powerpc-linux-ld:drivers-bluetooth-btmtk.c:(.text.btmtk_submit_intr_urb):undefined-reference-to-usb_unanchor_urb
|-- riscv-buildonly-randconfig-r003-20220819
|   `-- riscv32-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_kill_anchored_urbs
|-- riscv-randconfig-p002-20221104
|   |-- include-asm-generic-unaligned.h:(.text):undefined-reference-to-usb_control_msg
|   |-- riscv32-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_kill_anchored_urbs
|   `-- riscv32-linux-ld:include-linux-skbuff.h:(.text):undefined-reference-to-usb_submit_urb
`-- riscv-randconfig-r022-20230727
    |-- include-linux-fortify-string.h:(.text):undefined-reference-to-usb_set_interface
    `-- riscv64-linux-ld:include-linux-usb.h:(.text):undefined-reference-to-usb_control_msg

elapsed time: 735m

configs tested: 146
configs skipped: 4

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                      axs103_smp_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                     haps_hs_smp_defconfig   gcc-13.2.0
arc                            hsdk_defconfig   gcc-13.2.0
arc                    vdk_hs38_smp_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                        mvebu_v7_defconfig   gcc-13.2.0
arm                        neponset_defconfig   gcc-13.2.0
arm                           omap1_defconfig   gcc-13.2.0
arm                           sama7_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                             alldefconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240717   clang-18
i386         buildonly-randconfig-002-20240717   clang-18
i386         buildonly-randconfig-003-20240717   clang-18
i386         buildonly-randconfig-004-20240717   clang-18
i386         buildonly-randconfig-005-20240717   clang-18
i386         buildonly-randconfig-006-20240717   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240717   clang-18
i386                  randconfig-002-20240717   clang-18
i386                  randconfig-003-20240717   clang-18
i386                  randconfig-004-20240717   clang-18
i386                  randconfig-005-20240717   clang-18
i386                  randconfig-006-20240717   clang-18
i386                  randconfig-011-20240717   clang-18
i386                  randconfig-012-20240717   clang-18
i386                  randconfig-013-20240717   clang-18
i386                  randconfig-014-20240717   clang-18
i386                  randconfig-015-20240717   clang-18
i386                  randconfig-016-20240717   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                         10m50_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-14.1.0
powerpc                   currituck_defconfig   gcc-13.2.0
powerpc                    ge_imp3a_defconfig   gcc-13.2.0
powerpc                   lite5200b_defconfig   gcc-13.2.0
powerpc                     mpc512x_defconfig   gcc-13.2.0
powerpc                 mpc834x_itx_defconfig   gcc-13.2.0
powerpc               mpc834x_itxgp_defconfig   gcc-13.2.0
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240717   gcc-13
x86_64       buildonly-randconfig-002-20240717   gcc-13
x86_64       buildonly-randconfig-003-20240717   gcc-13
x86_64       buildonly-randconfig-004-20240717   gcc-13
x86_64       buildonly-randconfig-005-20240717   gcc-13
x86_64       buildonly-randconfig-006-20240717   gcc-13
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240717   gcc-13
x86_64                randconfig-002-20240717   gcc-13
x86_64                randconfig-003-20240717   gcc-13
x86_64                randconfig-004-20240717   gcc-13
x86_64                randconfig-005-20240717   gcc-13
x86_64                randconfig-006-20240717   gcc-13
x86_64                randconfig-011-20240717   gcc-13
x86_64                randconfig-012-20240717   gcc-13
x86_64                randconfig-013-20240717   gcc-13
x86_64                randconfig-014-20240717   gcc-13
x86_64                randconfig-015-20240717   gcc-13
x86_64                randconfig-016-20240717   gcc-13
x86_64                randconfig-071-20240717   gcc-13
x86_64                randconfig-072-20240717   gcc-13
x86_64                randconfig-073-20240717   gcc-13
x86_64                randconfig-074-20240717   gcc-13
x86_64                randconfig-075-20240717   gcc-13
x86_64                randconfig-076-20240717   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                       common_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
