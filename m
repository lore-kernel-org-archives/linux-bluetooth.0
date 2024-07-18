Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A42012C473
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2024 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721304641; cv=none; b=KlPUq6JH7QlOsS9BUjeoO4ZgROZT4iUBkO02oPQzpE/4GCFYCI9jlrLI9UOMvAs2t4niXEOhP66RHpBE+RUw6lgIFCJup+Tyzl4znsVvuqwluOfEUWqP/zztz9IEtPMr6w5DvRqNAbzIQ1iaOU2Dbc/rMsa8WtN8JjL1Su+MFjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721304641; c=relaxed/simple;
	bh=I/LcjQ1JMyen09mY5m7CZHMzU+lGlHEOtHzyuzyh5B8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RMhtoKqb7nZEiELi8h84dYuLnOb/Lpfz6JtfEmOA5Pkqgnx6CjEk6YDCl6YMsIPQdgJOprHRebrCVaK4UiprJbuypKLexMG8OVfBGJ2oVtpcwbMqmfDtsBFDbk0nSpujz+CMQNGJ/wOMtSrSVKafdaiVacjPVF/uZgAN0CEQ0XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K3gT28/N; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K3gT28/N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721304639; x=1752840639;
  h=date:from:to:cc:subject:message-id;
  bh=I/LcjQ1JMyen09mY5m7CZHMzU+lGlHEOtHzyuzyh5B8=;
  b=K3gT28/NfipWaeBpserciHJ0ukt0urtUZKSgdIF87FzTMyDYJl4hxOen
   8bDPUvrB/7Mf7Qwsjs6OyYqY2UjzU0Gu3z1+E40HuqjWMz0FQuuDpgUO0
   uVDWqSvVlmm8WgWEZrQ3h0YlUq161Lp+YfB0nPEMtY4fJgrhqHi10RCjy
   AutGdp1vFd+oh62bm4DFuw2XDKtOZO421L7bgHTB+qe5Y6sG//PvHNA0Z
   Hmd8xbEyOr0TQ2lqCNrNOGbkt1KjQbzjEcR/dWZptiFDx9rilVoXOzTed
   aZbQ84jYYvZx17eWaagJuIKeDRfe8BczxwCvXu/9Sv15rLZQ4AWcgSXti
   w==;
X-CSE-ConnectionGUID: QriNcNSZSDG1VMzhdoMhkA==
X-CSE-MsgGUID: C/0imuslT+6lx+kc8Rxe8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="21764631"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="21764631"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 05:10:38 -0700
X-CSE-ConnectionGUID: OgrOlP46TpGpOM2dTswkwQ==
X-CSE-MsgGUID: 9g9FcaOTQwKGPkhxcNydXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="55587853"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 18 Jul 2024 05:10:37 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUPxz-000hDs-0L;
	Thu, 18 Jul 2024 12:10:35 +0000
Date: Thu, 18 Jul 2024 20:10:20 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD REGRESSION
 54dd4796336de8ce5cbf344db837f9b8448ebcf8
Message-ID: <202407182017.s3aT6Gyx-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 54dd4796336de8ce5cbf344db837f9b8448ebcf8  Bluetooth: hci_sync: Fix suspending with wrong filter policy

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arm64-randconfig-051-20240718
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
`-- i386-randconfig-006-20240718
    |-- ERROR:usb_alloc_urb-drivers-bluetooth-btmtk.ko-undefined
    |-- ERROR:usb_anchor_urb-drivers-bluetooth-btmtk.ko-undefined
    |-- ERROR:usb_control_msg-drivers-bluetooth-btmtk.ko-undefined
    |-- ERROR:usb_free_urb-drivers-bluetooth-btmtk.ko-undefined
    `-- ERROR:usb_submit_urb-drivers-bluetooth-btmtk.ko-undefined

elapsed time: 937m

configs tested: 184
configs skipped: 4

tested configs:
alpha                            alldefconfig   gcc-13.3.0
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                            hisi_defconfig   gcc-13.3.0
arm                          moxart_defconfig   gcc-14.1.0
arm                         nhk8815_defconfig   gcc-14.1.0
arm                           spitz_defconfig   gcc-13.3.0
arm                       versatile_defconfig   gcc-13.3.0
arm                        vexpress_defconfig   gcc-14.1.0
arm                         vf610m4_defconfig   gcc-13.3.0
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240718   gcc-11
i386         buildonly-randconfig-002-20240718   gcc-11
i386         buildonly-randconfig-002-20240718   gcc-7
i386         buildonly-randconfig-003-20240718   gcc-11
i386         buildonly-randconfig-003-20240718   gcc-13
i386         buildonly-randconfig-004-20240718   clang-18
i386         buildonly-randconfig-004-20240718   gcc-11
i386         buildonly-randconfig-005-20240718   gcc-11
i386         buildonly-randconfig-005-20240718   gcc-9
i386         buildonly-randconfig-006-20240718   gcc-11
i386         buildonly-randconfig-006-20240718   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240718   gcc-11
i386                  randconfig-001-20240718   gcc-13
i386                  randconfig-002-20240718   gcc-11
i386                  randconfig-002-20240718   gcc-13
i386                  randconfig-003-20240718   clang-18
i386                  randconfig-003-20240718   gcc-11
i386                  randconfig-004-20240718   clang-18
i386                  randconfig-004-20240718   gcc-11
i386                  randconfig-005-20240718   clang-18
i386                  randconfig-005-20240718   gcc-11
i386                  randconfig-006-20240718   clang-18
i386                  randconfig-006-20240718   gcc-11
i386                  randconfig-011-20240718   gcc-11
i386                  randconfig-011-20240718   gcc-13
i386                  randconfig-012-20240718   gcc-11
i386                  randconfig-012-20240718   gcc-13
i386                  randconfig-013-20240718   gcc-10
i386                  randconfig-013-20240718   gcc-11
i386                  randconfig-014-20240718   clang-18
i386                  randconfig-014-20240718   gcc-11
i386                  randconfig-015-20240718   clang-18
i386                  randconfig-015-20240718   gcc-11
i386                  randconfig-016-20240718   gcc-11
i386                  randconfig-016-20240718   gcc-13
loongarch                        alldefconfig   gcc-14.1.0
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                         amcore_defconfig   gcc-13.3.0
m68k                                defconfig   gcc-13.2.0
m68k                        mvme16x_defconfig   gcc-14.1.0
m68k                           virt_defconfig   gcc-13.3.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                         cobalt_defconfig   gcc-13.3.0
mips                         db1xxx_defconfig   gcc-14.1.0
mips                  decstation_64_defconfig   gcc-14.1.0
mips                           ip27_defconfig   gcc-13.3.0
mips                        maltaup_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
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
powerpc                 canyonlands_defconfig   gcc-13.3.0
powerpc                   microwatt_defconfig   gcc-13.3.0
powerpc                 mpc834x_itx_defconfig   gcc-13.3.0
powerpc                  mpc866_ads_defconfig   gcc-14.1.0
powerpc                      ppc64e_defconfig   gcc-14.1.0
powerpc                      ppc6xx_defconfig   gcc-13.3.0
powerpc                     tqm8548_defconfig   gcc-13.3.0
powerpc                 xes_mpc85xx_defconfig   gcc-14.1.0
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                         apsh4a3a_defconfig   gcc-13.3.0
sh                        apsh4ad0a_defconfig   gcc-13.3.0
sh                                  defconfig   gcc-14.1.0
sh                         ecovec24_defconfig   gcc-14.1.0
sh                        sh7763rdp_defconfig   gcc-13.3.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240718   gcc-11
x86_64       buildonly-randconfig-002-20240718   gcc-11
x86_64       buildonly-randconfig-003-20240718   gcc-11
x86_64       buildonly-randconfig-004-20240718   gcc-11
x86_64       buildonly-randconfig-005-20240718   gcc-11
x86_64       buildonly-randconfig-006-20240718   gcc-11
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240718   gcc-11
x86_64                randconfig-002-20240718   gcc-11
x86_64                randconfig-003-20240718   gcc-11
x86_64                randconfig-004-20240718   gcc-11
x86_64                randconfig-005-20240718   gcc-11
x86_64                randconfig-006-20240718   gcc-11
x86_64                randconfig-011-20240718   gcc-11
x86_64                randconfig-012-20240718   gcc-11
x86_64                randconfig-013-20240718   gcc-11
x86_64                randconfig-014-20240718   gcc-11
x86_64                randconfig-015-20240718   gcc-11
x86_64                randconfig-016-20240718   gcc-11
x86_64                randconfig-071-20240718   gcc-11
x86_64                randconfig-072-20240718   gcc-11
x86_64                randconfig-073-20240718   gcc-11
x86_64                randconfig-074-20240718   gcc-11
x86_64                randconfig-075-20240718   gcc-11
x86_64                randconfig-076-20240718   gcc-11
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                  audio_kc705_defconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
