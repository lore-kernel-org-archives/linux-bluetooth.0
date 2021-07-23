Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6DEC41537
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 07:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0A8160EFD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 07:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbhGWGwD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jul 2021 02:52:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:34437 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233477AbhGWGwB (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jul 2021 02:52:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="297401006"
X-IronPort-AV: E=Sophos;i="5.84,263,1620716400"; 
   d="scan'208";a="297401006"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 00:32:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,263,1620716400"; 
   d="scan'208";a="663020525"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jul 2021 00:32:33 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m6pfd-0001No-6a; Fri, 23 Jul 2021 07:32:33 +0000
Date:   Fri, 23 Jul 2021 15:32:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 64832df2ac056f111b51aaebbe54a996e0fce7f1
Message-ID: <60fa708d.0DHOuxoXVhiaSvp7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 64832df2ac056f111b51aaebbe54a996e0fce7f1  Bluetooth: btusb: Add support for Foxconn Mediatek Chip

elapsed time: 724m

configs tested: 113
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210722
mips                      pic32mzda_defconfig
arm                          iop32x_defconfig
sh                              ul2_defconfig
arm                              alldefconfig
arm                     davinci_all_defconfig
um                           x86_64_defconfig
m68k                        m5407c3_defconfig
sh                        sh7763rdp_defconfig
sparc                       sparc32_defconfig
powerpc                     kilauea_defconfig
powerpc                      ep88xc_defconfig
powerpc                    mvme5100_defconfig
arm                     am200epdkit_defconfig
powerpc                   currituck_defconfig
mips                          ath79_defconfig
mips                   sb1250_swarm_defconfig
powerpc                    ge_imp3a_defconfig
ia64                        generic_defconfig
arm                         orion5x_defconfig
m68k                          atari_defconfig
powerpc                 mpc832x_mds_defconfig
arm                           u8500_defconfig
mips                           ci20_defconfig
m68k                            q40_defconfig
powerpc                      obs600_defconfig
sh                          sdk7780_defconfig
mips                           rs90_defconfig
powerpc                     tqm8540_defconfig
powerpc                     powernv_defconfig
mips                    maltaup_xpa_defconfig
arm                      integrator_defconfig
arm                            mps2_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                     pq2fads_defconfig
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
x86_64               randconfig-a003-20210722
x86_64               randconfig-a006-20210722
x86_64               randconfig-a001-20210722
x86_64               randconfig-a005-20210722
x86_64               randconfig-a004-20210722
x86_64               randconfig-a002-20210722
i386                 randconfig-a005-20210722
i386                 randconfig-a003-20210722
i386                 randconfig-a004-20210722
i386                 randconfig-a002-20210722
i386                 randconfig-a001-20210722
i386                 randconfig-a006-20210722
i386                 randconfig-a016-20210722
i386                 randconfig-a013-20210722
i386                 randconfig-a012-20210722
i386                 randconfig-a011-20210722
i386                 randconfig-a014-20210722
i386                 randconfig-a015-20210722
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210722
x86_64               randconfig-b001-20210722
x86_64               randconfig-a011-20210722
x86_64               randconfig-a016-20210722
x86_64               randconfig-a013-20210722
x86_64               randconfig-a014-20210722
x86_64               randconfig-a012-20210722
x86_64               randconfig-a015-20210722

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
