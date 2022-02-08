Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77563C35271
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Feb 2022 05:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238618AbiBHFdU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Feb 2022 00:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiBHF2T (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Feb 2022 00:28:19 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4EBC0401DC
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Feb 2022 21:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644298098; x=1675834098;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=fWunhf3KTWpn1/ZzxDyTD+ARL+o4YtF+bCfj9q0h+9o=;
  b=FqCJH5evTNHf71PEpAf6uXTtQLNv0gYUFiq9etX9SbWvJiPJb3/DhRJC
   WZo3TEAg32ntlUzmiLOZlgKPjBWkO8xJW63DBTx34+Tqxsp49y+rD0Vmf
   cw03B3ozb+9lLzSDjmkAo+8MtDM5l7FOIlX7kNrV+wI+43Pq/gvmA0Ilv
   S90r8QlcTKnru71kQCvGhMRgdhFxfoKkmzoJUOiPKgllOIhnHnz0Vsg6l
   Uf2aSjedrDL0BoX8CSJmgIXzfkcmVyiYTqB+jMzugGWFTtXtKqQZVUUV+
   Ke2T0VHBahXU5vb63xNtmGsS6YQOhnUft4aoBQNIAsHygLxfFPNnExM7L
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="247711339"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="247711339"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 21:28:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="525411883"
Received: from lkp-server01.sh.intel.com (HELO 9dd77a123018) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 07 Feb 2022 21:28:16 -0800
Received: from kbuild by 9dd77a123018 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHJ31-0001OV-AD; Tue, 08 Feb 2022 05:28:15 +0000
Date:   Tue, 08 Feb 2022 13:27:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 4840aa67576b598093d2c6fea8987d065f717bca
Message-ID: <6201ff5b.gvoGmgdcw6LTklfG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 4840aa67576b598093d2c6fea8987d065f717bca  Bluetooth: hci_core: Fix leaking sent_cmd skb

elapsed time: 724m

configs tested: 164
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220207
arm                             pxa_defconfig
arm                          iop32x_defconfig
arm                          exynos_defconfig
sparc                       sparc32_defconfig
s390                          debug_defconfig
sh                          kfr2r09_defconfig
powerpc                      arches_defconfig
um                               alldefconfig
mips                      loongson3_defconfig
arc                        nsimosci_defconfig
sh                               alldefconfig
sh                           se7751_defconfig
mips                            ar7_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                        cell_defconfig
sh                         ecovec24_defconfig
nios2                            alldefconfig
arm                           stm32_defconfig
sh                     magicpanelr2_defconfig
powerpc                      ep88xc_defconfig
powerpc                     ep8248e_defconfig
m68k                       m5249evb_defconfig
powerpc                    amigaone_defconfig
sh                           se7343_defconfig
xtensa                    xip_kc705_defconfig
mips                         tb0226_defconfig
ia64                         bigsur_defconfig
arm                        multi_v7_defconfig
m68k                         apollo_defconfig
arm                          lpd270_defconfig
sh                           se7724_defconfig
powerpc                     taishan_defconfig
mips                      maltasmvp_defconfig
powerpc                 linkstation_defconfig
csky                             alldefconfig
arm                         assabet_defconfig
mips                         bigsur_defconfig
arm                        realview_defconfig
arm                        mvebu_v7_defconfig
h8300                       h8s-sim_defconfig
sh                   sh7724_generic_defconfig
m68k                        m5307c3_defconfig
m68k                       m5275evb_defconfig
parisc                           allyesconfig
sh                          rsk7201_defconfig
m68k                       m5475evb_defconfig
m68k                        m5407c3_defconfig
arm                            zeus_defconfig
mips                      fuloong2e_defconfig
powerpc                  storcenter_defconfig
powerpc                      ppc6xx_defconfig
i386                                defconfig
arm                             ezx_defconfig
powerpc                       maple_defconfig
arc                     haps_hs_smp_defconfig
sh                          urquell_defconfig
powerpc                   currituck_defconfig
m68k                        stmark2_defconfig
arm                            lart_defconfig
mips                           xway_defconfig
powerpc                     tqm8548_defconfig
mips                            gpr_defconfig
powerpc                      pcm030_defconfig
arm                           corgi_defconfig
arc                         haps_hs_defconfig
powerpc                           allnoconfig
arm                  randconfig-c002-20220207
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
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a013-20220207
x86_64               randconfig-a016-20220207
x86_64               randconfig-a015-20220207
x86_64               randconfig-a012-20220207
x86_64               randconfig-a014-20220207
x86_64               randconfig-a011-20220207
i386                 randconfig-a012-20220207
i386                 randconfig-a013-20220207
i386                 randconfig-a015-20220207
i386                 randconfig-a014-20220207
i386                 randconfig-a016-20220207
i386                 randconfig-a011-20220207
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20220207
i386                 randconfig-c001-20220207
powerpc              randconfig-c003-20220207
x86_64               randconfig-c007-20220207
mips                 randconfig-c004-20220207
arm                  randconfig-c002-20220207
mips                          rm200_defconfig
mips                        maltaup_defconfig
powerpc                     mpc512x_defconfig
arm                        spear3xx_defconfig
arm                         shannon_defconfig
arm                       cns3420vb_defconfig
powerpc                      ppc44x_defconfig
mips                        workpad_defconfig
powerpc                    ge_imp3a_defconfig
mips                        bcm63xx_defconfig
mips                           mtx1_defconfig
arm                            dove_defconfig
arm                    vt8500_v6_v7_defconfig
arm                         mv78xx0_defconfig
mips                      maltaaprp_defconfig
x86_64               randconfig-a006-20220207
x86_64               randconfig-a004-20220207
x86_64               randconfig-a005-20220207
x86_64               randconfig-a003-20220207
x86_64               randconfig-a002-20220207
x86_64               randconfig-a001-20220207
i386                 randconfig-a005-20220207
i386                 randconfig-a004-20220207
i386                 randconfig-a003-20220207
i386                 randconfig-a006-20220207
i386                 randconfig-a001-20220207
i386                 randconfig-a002-20220207
hexagon              randconfig-r045-20220207
hexagon              randconfig-r041-20220207

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
