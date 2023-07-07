Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E0DEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jul 2023 08:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjGGI3A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jul 2023 04:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjGGI26 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jul 2023 04:28:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D96990
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jul 2023 01:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688718537; x=1720254537;
  h=date:from:to:cc:subject:message-id;
  bh=KIk5hXo3X4LoPvZy67ec8q+HyAxpGC06+fAbx4jVsOw=;
  b=BxBSOxaVtRejHVmCw7VdjV+RLwg/Pd82yPko132yCso6rxUA5chzpZWY
   idVyi+vEcljHChf+uIxAH3INlCgurDwNIN2PTmiNtGFhgcv/+mPC/qV/o
   z0qCo5tf9DAMkG3dWyWil/srd8Bqka0xOBx+vkwe841L4lL9eWq8hVJkc
   yx+rdcVhTEBOs8drI11EhwfP9d62zieMqlA+Cm7Idxp49emuB20Lh8Thv
   wj3Mp7COh1rhAeEoECZlwl21REE1gmmaqcvDLyT4gPkEkw1QQcMWS0zV6
   nM6VV/eJt3GpbniUMTsl89EQQIJIb8w7glF+oC/hEd4htVJlmNrK/hA58
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="450192655"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="450192655"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 01:28:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="719879184"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="719879184"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 07 Jul 2023 01:28:55 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qHgpi-0001ta-1q;
        Fri, 07 Jul 2023 08:28:54 +0000
Date:   Fri, 07 Jul 2023 16:28:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 70ec552ac638bc0bf47ef44e6bdd703af81965f4
Message-ID: <202307071644.4UovKFVR-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 70ec552ac638bc0bf47ef44e6bdd703af81965f4  Bluetooth: hci_sync: Don't double print name in add/remove adv_monitor

elapsed time: 722m

configs tested: 140
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230707   gcc  
alpha                randconfig-r014-20230707   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                  randconfig-r043-20230707   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                        neponset_defconfig   clang
arm                  randconfig-r013-20230707   gcc  
arm                  randconfig-r021-20230707   gcc  
arm                  randconfig-r046-20230707   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r023-20230707   clang
csky                                defconfig   gcc  
hexagon              randconfig-r041-20230707   clang
hexagon              randconfig-r045-20230707   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230707   gcc  
i386         buildonly-randconfig-r005-20230707   gcc  
i386         buildonly-randconfig-r006-20230707   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230707   gcc  
i386                 randconfig-i002-20230707   gcc  
i386                 randconfig-i003-20230707   gcc  
i386                 randconfig-i004-20230707   gcc  
i386                 randconfig-i005-20230707   gcc  
i386                 randconfig-i006-20230707   gcc  
i386                 randconfig-i011-20230706   gcc  
i386                 randconfig-i012-20230706   gcc  
i386                 randconfig-i013-20230706   gcc  
i386                 randconfig-i014-20230706   gcc  
i386                 randconfig-i015-20230706   gcc  
i386                 randconfig-i016-20230706   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                            q40_defconfig   gcc  
microblaze           randconfig-r015-20230707   gcc  
microblaze           randconfig-r024-20230707   gcc  
microblaze           randconfig-r033-20230707   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                            ar7_defconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                           ip22_defconfig   clang
mips                          malta_defconfig   clang
mips                    maltaup_xpa_defconfig   gcc  
mips                 randconfig-r012-20230707   gcc  
mips                       rbtx49xx_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r034-20230707   gcc  
nios2                randconfig-r035-20230707   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r016-20230707   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      arches_defconfig   gcc  
powerpc                      chrp32_defconfig   gcc  
powerpc                   motionpro_defconfig   gcc  
powerpc                      ppc40x_defconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
powerpc              randconfig-r001-20230707   gcc  
powerpc              randconfig-r011-20230707   clang
powerpc              randconfig-r036-20230707   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                  storcenter_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r032-20230707   gcc  
riscv                randconfig-r042-20230707   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r022-20230707   clang
s390                 randconfig-r044-20230707   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r003-20230707   gcc  
sh                   randconfig-r026-20230707   gcc  
sh                            shmin_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230707   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64              randconfig-r025-20230707   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230707   gcc  
x86_64       buildonly-randconfig-r002-20230707   gcc  
x86_64       buildonly-randconfig-r003-20230707   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r006-20230707   gcc  
x86_64               randconfig-x001-20230707   clang
x86_64               randconfig-x002-20230707   clang
x86_64               randconfig-x003-20230707   clang
x86_64               randconfig-x004-20230707   clang
x86_64               randconfig-x005-20230707   clang
x86_64               randconfig-x006-20230707   clang
x86_64               randconfig-x011-20230707   gcc  
x86_64               randconfig-x012-20230707   gcc  
x86_64               randconfig-x013-20230707   gcc  
x86_64               randconfig-x014-20230707   gcc  
x86_64               randconfig-x015-20230707   gcc  
x86_64               randconfig-x016-20230707   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
