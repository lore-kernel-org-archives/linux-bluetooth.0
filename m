Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFC6C433B4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 May 2021 07:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2060613F2
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 May 2021 07:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhEOHeu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 15 May 2021 03:34:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:5780 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230508AbhEOHeu (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 15 May 2021 03:34:50 -0400
IronPort-SDR: iT7PcnhNJ2FcQcgEllD61wRcRtitLxw8O2RZcuObOm91/jmKi2Ez+Kbv0H+J7f95gEQUnZMcmj
 4+WRdZNjJQxA==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="261505490"
X-IronPort-AV: E=Sophos;i="5.82,301,1613462400"; 
   d="scan'208";a="261505490"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2021 00:33:36 -0700
IronPort-SDR: GCmu7oKmIah3ORF7wW8zF0nr6rPA/sqTwBlOfjRCxFi6MfH5uRLpaLBenyqEv8q2Hh+WZdghSl
 hSHUd89VGvUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,301,1613462400"; 
   d="scan'208";a="438264890"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 15 May 2021 00:33:35 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lhonm-00012u-Hb; Sat, 15 May 2021 07:33:34 +0000
Date:   Sat, 15 May 2021 15:33:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 8bf7111b4bda00ae82e2de0cd871af997c3f2e9b
Message-ID: <609f7940.xAdxICH3EogcVEJ0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 8bf7111b4bda00ae82e2de0cd871af997c3f2e9b  Bluetooth: Shutdown controller after workqueues are flushed or cancelled

elapsed time: 789m

configs tested: 132
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                         apsh4a3a_defconfig
arc                         haps_hs_defconfig
sh                          r7785rp_defconfig
m68k                        m5272c3_defconfig
powerpc                     skiroot_defconfig
arm                        spear3xx_defconfig
mips                           ip28_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                    maltaup_xpa_defconfig
arm                       versatile_defconfig
mips                         tb0226_defconfig
mips                        vocore2_defconfig
openrisc                  or1klitex_defconfig
powerpc                    amigaone_defconfig
sh                          sdk7786_defconfig
powerpc                 mpc832x_mds_defconfig
sh                           se7206_defconfig
m68k                        mvme16x_defconfig
mips                      pistachio_defconfig
arm                          ixp4xx_defconfig
arm                        oxnas_v6_defconfig
arm                      jornada720_defconfig
powerpc                     mpc5200_defconfig
parisc                generic-64bit_defconfig
arm                         lpc32xx_defconfig
arm                            mps2_defconfig
arm                           sama5_defconfig
powerpc                     tqm8548_defconfig
mips                           ip22_defconfig
arm                       mainstone_defconfig
openrisc                            defconfig
arm                        mvebu_v5_defconfig
arc                           tb10x_defconfig
sparc64                          alldefconfig
openrisc                    or1ksim_defconfig
x86_64                            allnoconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210514
i386                 randconfig-a001-20210514
i386                 randconfig-a004-20210514
i386                 randconfig-a005-20210514
i386                 randconfig-a002-20210514
i386                 randconfig-a006-20210514
x86_64               randconfig-a012-20210515
x86_64               randconfig-a015-20210515
x86_64               randconfig-a011-20210515
x86_64               randconfig-a013-20210515
x86_64               randconfig-a016-20210515
x86_64               randconfig-a014-20210515
x86_64               randconfig-a004-20210514
x86_64               randconfig-a003-20210514
x86_64               randconfig-a001-20210514
x86_64               randconfig-a005-20210514
x86_64               randconfig-a002-20210514
x86_64               randconfig-a006-20210514
i386                 randconfig-a016-20210515
i386                 randconfig-a014-20210515
i386                 randconfig-a011-20210515
i386                 randconfig-a012-20210515
i386                 randconfig-a015-20210515
i386                 randconfig-a013-20210515
i386                 randconfig-a016-20210514
i386                 randconfig-a014-20210514
i386                 randconfig-a011-20210514
i386                 randconfig-a012-20210514
i386                 randconfig-a015-20210514
i386                 randconfig-a013-20210514
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210515
x86_64               randconfig-a003-20210515
x86_64               randconfig-a001-20210515
x86_64               randconfig-a005-20210515
x86_64               randconfig-a002-20210515
x86_64               randconfig-a006-20210515
x86_64               randconfig-a015-20210514
x86_64               randconfig-a012-20210514
x86_64               randconfig-a011-20210514
x86_64               randconfig-a013-20210514
x86_64               randconfig-a016-20210514
x86_64               randconfig-a014-20210514

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
