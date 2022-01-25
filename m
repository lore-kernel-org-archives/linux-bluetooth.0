Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832CDC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 16:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449234AbiAYQvU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jan 2022 11:51:20 -0500
Received: from mga03.intel.com ([134.134.136.65]:58948 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1586588AbiAYQt6 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jan 2022 11:49:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643129398; x=1674665398;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=vTn832Kkjr6j5glHYzhpbDnbyrdZKVpGvaDT3L7o9Lw=;
  b=j98NfkmQV1PSO2NS/p1fal59s6WIrjiXMylBVpY3babc02uBHr67/VCV
   U/StJZR4fQtSiRZDzBKb3DbjrUVXXtv2WEDNMmSWcEsrBwUJROF5RpgZS
   w2bA3JyqiB3Ec78EHvnq57IBnoaAsFgefEQK6s02ZTNR+U6Xfb6VxrV3s
   hdkDAsf2QUsDhFpZNhN6RyqxTbxSLt/BhZ4HDYgs1jpTGkSpwakHvQBCk
   5PFcLpXWX4wAhv4OYA41VQps/+7NvcOX15+CAw3Y3Mp6xrGJZqAhTuE4H
   RwTul7gaQlOfXSf7b+yTzwWr9BjVcLMbPCo0ZBlVF23M1U05ELZMPZknP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="246293044"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="246293044"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 08:48:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="769092050"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 25 Jan 2022 08:48:10 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCOzJ-000KBd-Ma; Tue, 25 Jan 2022 16:48:09 +0000
Date:   Wed, 26 Jan 2022 00:47:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 d5ebaa7c5f6f688959e8d40840b2249ede63b8ed
Message-ID: <61f0299a.M2hmXnKqOd1fTTqY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: d5ebaa7c5f6f688959e8d40840b2249ede63b8ed  Bluetooth: hci_event: Ignore multiple conn complete events

elapsed time: 724m

configs tested: 168
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220124
powerpc              randconfig-c003-20220124
sh                 kfr2r09-romimage_defconfig
mips                         bigsur_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                     rainier_defconfig
mips                      maltasmvp_defconfig
powerpc                    sam440ep_defconfig
arc                            hsdk_defconfig
sh                           se7722_defconfig
mips                     decstation_defconfig
sparc                       sparc64_defconfig
powerpc                      ppc6xx_defconfig
mips                            gpr_defconfig
arc                          axs101_defconfig
xtensa                    xip_kc705_defconfig
powerpc                     asp8347_defconfig
sh                          kfr2r09_defconfig
nios2                         10m50_defconfig
powerpc                     sequoia_defconfig
arm                           h5000_defconfig
riscv                    nommu_k210_defconfig
m68k                          atari_defconfig
openrisc                            defconfig
csky                                defconfig
powerpc                     tqm8548_defconfig
sh                           se7206_defconfig
ia64                          tiger_defconfig
arm                       multi_v4t_defconfig
arm                        trizeps4_defconfig
arm                        mvebu_v7_defconfig
arm                           viper_defconfig
powerpc                 mpc8540_ads_defconfig
sh                         microdev_defconfig
arm                             ezx_defconfig
mips                       bmips_be_defconfig
xtensa                generic_kc705_defconfig
openrisc                         alldefconfig
sh                           sh2007_defconfig
sh                          r7780mp_defconfig
mips                  maltasmvp_eva_defconfig
sh                             shx3_defconfig
powerpc                           allnoconfig
parisc                generic-32bit_defconfig
openrisc                  or1klitex_defconfig
riscv             nommu_k210_sdcard_defconfig
m68k                        m5272c3_defconfig
arc                          axs103_defconfig
powerpc                    amigaone_defconfig
arm                            lart_defconfig
arc                         haps_hs_defconfig
mips                        bcm47xx_defconfig
xtensa                          iss_defconfig
arm                  randconfig-c002-20220124
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a002-20220124
x86_64               randconfig-a003-20220124
x86_64               randconfig-a001-20220124
x86_64               randconfig-a004-20220124
x86_64               randconfig-a005-20220124
x86_64               randconfig-a006-20220124
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                 randconfig-a002-20220124
i386                 randconfig-a005-20220124
i386                 randconfig-a003-20220124
i386                 randconfig-a004-20220124
i386                 randconfig-a001-20220124
i386                 randconfig-a006-20220124
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220125
arc                  randconfig-r043-20220125
arc                  randconfig-r043-20220124
s390                 randconfig-r044-20220125
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220124
riscv                randconfig-c006-20220124
i386                 randconfig-c001-20220124
powerpc              randconfig-c003-20220124
mips                 randconfig-c004-20220124
x86_64               randconfig-c007-20220124
mips                  cavium_octeon_defconfig
mips                        omega2p_defconfig
powerpc                    mvme5100_defconfig
arm                         lpc32xx_defconfig
riscv                          rv32_defconfig
powerpc                     tqm8560_defconfig
powerpc                     ppa8548_defconfig
mips                        bcm63xx_defconfig
mips                           mtx1_defconfig
powerpc                   lite5200b_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                     tqm5200_defconfig
mips                       lemote2f_defconfig
powerpc                        icon_defconfig
mips                     cu1830-neo_defconfig
arm                        neponset_defconfig
mips                           ip22_defconfig
arm                     davinci_all_defconfig
mips                     cu1000-neo_defconfig
powerpc                      ppc44x_defconfig
arm                              alldefconfig
mips                           ip28_defconfig
riscv                    nommu_virt_defconfig
x86_64               randconfig-a011-20220124
x86_64               randconfig-a013-20220124
x86_64               randconfig-a015-20220124
x86_64               randconfig-a016-20220124
x86_64               randconfig-a014-20220124
x86_64               randconfig-a012-20220124
i386                 randconfig-a011-20220124
i386                 randconfig-a016-20220124
i386                 randconfig-a013-20220124
i386                 randconfig-a014-20220124
i386                 randconfig-a015-20220124
i386                 randconfig-a012-20220124
riscv                randconfig-r042-20220124
hexagon              randconfig-r045-20220124
hexagon              randconfig-r041-20220124
hexagon              randconfig-r045-20220125
hexagon              randconfig-r041-20220125

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
