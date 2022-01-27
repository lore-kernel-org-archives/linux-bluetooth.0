Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA02C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jan 2022 04:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbiA0E2n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jan 2022 23:28:43 -0500
Received: from mga06.intel.com ([134.134.136.31]:10886 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229846AbiA0E2m (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jan 2022 23:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643257722; x=1674793722;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GRzjr345E/NfNpnlHyNrzTbCvi6E2qekJaqjPfFnYnA=;
  b=SsAHvn4rke5u4zUt8hZkV4iXUlEZN0t3hVw3N6WNtub9FUBVXIslYh3I
   YjFJrA4HXuHfRcwAIl7vlNf7dW1Sm7XWa98kO59R02dCYezAtQaUf/DT/
   G8OOGfq3k9Yn5n3wmf41bTECSD8Ig60VRK8OwOZqtukY9ZbvDHTf9ViA5
   WkW37VC9B/rMOnIut3K9qdaptlmkl0QelynwfclOTjFmZ+98ipopbQ6mT
   7KWa/y/iJpWudGxcpgZkRvuTk83UbQyuMjm+1XA5ZaHcI53nzzUkziVvQ
   VnJgvBm7Gnt5v5JiQqa4D2xktYgC9CYDDOs3lnCkcee0outWXtHFadAh4
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="307460207"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="307460207"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 20:28:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="696493195"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 26 Jan 2022 20:28:40 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCwOm-000M6B-1j; Thu, 27 Jan 2022 04:28:40 +0000
Date:   Thu, 27 Jan 2022 12:28:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 adce573b927adf827f2f8627f05c2ba90031ebc9
Message-ID: <61f21f66.vqmfEY4eDCanPN5b%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: adce573b927adf827f2f8627f05c2ba90031ebc9  Bluetooth: hci_h5: Add power reset via gpio in h5_btrtl_open

elapsed time: 729m

configs tested: 170
configs skipped: 3

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
m68k                         apollo_defconfig
arc                    vdk_hs38_smp_defconfig
mips                  decstation_64_defconfig
sh                         ecovec24_defconfig
m68k                            q40_defconfig
powerpc                 linkstation_defconfig
arm                         s3c6400_defconfig
m68k                           sun3_defconfig
arm                        oxnas_v6_defconfig
m68k                          multi_defconfig
sparc64                          alldefconfig
h8300                    h8300h-sim_defconfig
arm                         nhk8815_defconfig
powerpc                       ppc64_defconfig
m68k                        stmark2_defconfig
xtensa                  nommu_kc705_defconfig
sparc                            allyesconfig
mips                         rt305x_defconfig
arm                            zeus_defconfig
nios2                         10m50_defconfig
xtensa                              defconfig
sh                ecovec24-romimage_defconfig
mips                       capcella_defconfig
arm                          pxa910_defconfig
arm                          simpad_defconfig
m68k                          hp300_defconfig
nds32                               defconfig
m68k                       m5249evb_defconfig
arm                             rpc_defconfig
mips                        bcm47xx_defconfig
xtensa                  audio_kc705_defconfig
mips                         cobalt_defconfig
powerpc                      makalu_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      mgcoge_defconfig
arm                        keystone_defconfig
mips                           ip32_defconfig
arm                         lubbock_defconfig
arm                          pxa3xx_defconfig
powerpc                      pasemi_defconfig
m68k                       m5208evb_defconfig
mips                             allmodconfig
i386                             alldefconfig
sh                             espt_defconfig
m68k                         amcore_defconfig
mips                 decstation_r4k_defconfig
s390                          debug_defconfig
m68k                        mvme16x_defconfig
xtensa                       common_defconfig
sh                            migor_defconfig
openrisc                 simple_smp_defconfig
powerpc                      tqm8xx_defconfig
h8300                            alldefconfig
arm                           corgi_defconfig
powerpc                  iss476-smp_defconfig
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
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20220124
x86_64               randconfig-a003-20220124
x86_64               randconfig-a004-20220124
x86_64               randconfig-a005-20220124
x86_64               randconfig-a006-20220124
x86_64               randconfig-a001-20220124
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
riscv                    nommu_k210_defconfig
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
arm                          imote2_defconfig
mips                         tb0219_defconfig
mips                          malta_defconfig
powerpc                 mpc836x_mds_defconfig
mips                     loongson2k_defconfig
arm                        neponset_defconfig
powerpc                     kmeter1_defconfig
powerpc                    socrates_defconfig
arm                           omap1_defconfig
powerpc                     skiroot_defconfig
i386                             allyesconfig
powerpc                      walnut_defconfig
powerpc                        fsp2_defconfig
powerpc                      katmai_defconfig
riscv                          rv32_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a011-20220124
x86_64               randconfig-a013-20220124
x86_64               randconfig-a015-20220124
x86_64               randconfig-a016-20220124
x86_64               randconfig-a014-20220124
x86_64               randconfig-a012-20220124
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
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
riscv                randconfig-r042-20220126
hexagon              randconfig-r045-20220126
hexagon              randconfig-r041-20220126

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
