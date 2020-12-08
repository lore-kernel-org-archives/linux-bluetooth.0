Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EBCC4361B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 04:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5C4C21D81
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 04:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgLHESg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Dec 2020 23:18:36 -0500
Received: from mga17.intel.com ([192.55.52.151]:28039 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbgLHESg (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Dec 2020 23:18:36 -0500
IronPort-SDR: z4hlq609I0HNAhIvqCdoSj6F4jKSznE28eYeDNwr8jfihFXV4HDMUvhY0qPvWbV/+JYrH+Pbdc
 v1gAFtbpQ+zw==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="153639138"
X-IronPort-AV: E=Sophos;i="5.78,401,1599548400"; 
   d="scan'208";a="153639138"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 20:17:55 -0800
IronPort-SDR: HkIkiNRkZeTcAmwNlPfzRdgC69pkeFG/6eaHxVSWaqhOEOupr3efF0l3bDPwLAmCjPgyej1jCs
 v8k7ok1VH+/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,401,1599548400"; 
   d="scan'208";a="407457302"
Received: from lkp-server01.sh.intel.com (HELO d624d5343356) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Dec 2020 20:17:54 -0800
Received: from kbuild by d624d5343356 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kmURl-00000z-PO; Tue, 08 Dec 2020 04:17:53 +0000
Date:   Tue, 08 Dec 2020 12:17:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johan Hedberg <johan.hedberg@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 02be5f13aacba2100f1486d3ad16c26b6dede1ce
Message-ID: <5fcefe54.rpFtwTocwyuiRlrY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git  master
branch HEAD: 02be5f13aacba2100f1486d3ad16c26b6dede1ce  MAINTAINERS: Update Bluetooth entries

elapsed time: 734m

configs tested: 134
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
powerpc                      walnut_defconfig
arm                         palmz72_defconfig
arm                          simpad_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                      arches_defconfig
um                             i386_defconfig
arm                   milbeaut_m10v_defconfig
m68k                       bvme6000_defconfig
nios2                               defconfig
nds32                               defconfig
powerpc                     tqm8555_defconfig
arc                          axs103_defconfig
sh                   sh7724_generic_defconfig
arm                              zx_defconfig
arm                          ep93xx_defconfig
xtensa                  audio_kc705_defconfig
arm                            dove_defconfig
powerpc                  mpc885_ads_defconfig
mips                           ip28_defconfig
powerpc                     pq2fads_defconfig
powerpc                 mpc832x_rdb_defconfig
c6x                         dsk6455_defconfig
m68k                        m5272c3_defconfig
mips                malta_kvm_guest_defconfig
powerpc                       maple_defconfig
sparc                            alldefconfig
sh                            migor_defconfig
arm                      jornada720_defconfig
m68k                          hp300_defconfig
s390                          debug_defconfig
arm                             ezx_defconfig
mips                            gpr_defconfig
microblaze                          defconfig
microblaze                    nommu_defconfig
arm                  colibri_pxa300_defconfig
powerpc                     powernv_defconfig
m68k                        mvme16x_defconfig
arm                           tegra_defconfig
powerpc                     tqm8540_defconfig
sh                                  defconfig
powerpc                      pasemi_defconfig
arc                         haps_hs_defconfig
arm                        multi_v5_defconfig
mips                           ci20_defconfig
powerpc                      chrp32_defconfig
mips                         db1xxx_defconfig
m68k                       m5249evb_defconfig
arc                        nsim_700_defconfig
arm                       omap2plus_defconfig
arm                         lpc18xx_defconfig
sh                          sdk7780_defconfig
m68k                       m5275evb_defconfig
mips                         tb0287_defconfig
m68k                             alldefconfig
um                            kunit_defconfig
arm                           omap1_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                        fsp2_defconfig
powerpc                       eiger_defconfig
sh                            hp6xx_defconfig
sh                   sh7770_generic_defconfig
x86_64                              defconfig
riscv                             allnoconfig
m68k                             allyesconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20201207
i386                 randconfig-a004-20201207
i386                 randconfig-a001-20201207
i386                 randconfig-a002-20201207
i386                 randconfig-a006-20201207
i386                 randconfig-a003-20201207
x86_64               randconfig-a016-20201207
x86_64               randconfig-a012-20201207
x86_64               randconfig-a014-20201207
x86_64               randconfig-a013-20201207
x86_64               randconfig-a015-20201207
x86_64               randconfig-a011-20201207
i386                 randconfig-a014-20201207
i386                 randconfig-a013-20201207
i386                 randconfig-a011-20201207
i386                 randconfig-a015-20201207
i386                 randconfig-a012-20201207
i386                 randconfig-a016-20201207
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201207
x86_64               randconfig-a006-20201207
x86_64               randconfig-a002-20201207
x86_64               randconfig-a001-20201207
x86_64               randconfig-a005-20201207
x86_64               randconfig-a003-20201207

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
