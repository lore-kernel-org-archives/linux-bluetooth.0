Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A375C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Mar 2022 05:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240014AbiCSFW2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Mar 2022 01:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbiCSFW1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Mar 2022 01:22:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351A71AA8EF
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Mar 2022 22:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647667263; x=1679203263;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=58zU1YBHsu8FsYaaOhpsgW5PY6b3MBCUeaiO2EnX4r4=;
  b=PSbE0u5LHZoeNXYNteCNyqq2BK37NLLbhc+mnvyCWTLs4fRcmk4Gob/M
   kCsHO38yHOeQJH9pmeKDk/ND9aq0VO9tS7FoXZgGvLluywQOGhr6uGlW+
   uM+Co52m7FfE1WzbBGAVqWuWYHjJRIGCh4joctdl9+nJTMGS5Yjq7mkWS
   upQccfe6T+zYn+ntdAA/KucKebsjglPl+gTe8GVB1kJ495ORwcR/9u+Oc
   l0lWxH3FyBVSX0cONz32f83HwXjeTcNrESyLcqGtAQKEyRiYE4XES9M/b
   cpIh5lMgztBVH6G9fhtJ/O4AxPnUhzjXLeshFNyz4bRFko6ZzwOyIknQ0
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="239436125"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="239436125"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 22:21:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="715788085"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 18 Mar 2022 22:21:01 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVRWO-000Fc9-T1; Sat, 19 Mar 2022 05:21:00 +0000
Date:   Sat, 19 Mar 2022 13:20:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 726c0eb7cb15be3e5fe9a9f1c8aad12c5cbe4675
Message-ID: <62356814.ksBe8ZwmU48JejLM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 726c0eb7cb15be3e5fe9a9f1c8aad12c5cbe4675  Bluetooth: ath3k: remove superfluous header files

elapsed time: 722m

configs tested: 141
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
arm64                            alldefconfig
arm                            xcep_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                         rt305x_defconfig
ia64                        generic_defconfig
arm                        keystone_defconfig
xtensa                           alldefconfig
arc                         haps_hs_defconfig
m68k                        m5307c3_defconfig
openrisc                         alldefconfig
arm                          lpd270_defconfig
parisc                           allyesconfig
mips                     decstation_defconfig
arm                      footbridge_defconfig
sh                              ul2_defconfig
m68k                             allyesconfig
arc                                 defconfig
mips                         mpc30x_defconfig
m68k                           sun3_defconfig
sh                        edosk7705_defconfig
powerpc                   motionpro_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                           sh2007_defconfig
powerpc                        cell_defconfig
ia64                             alldefconfig
arc                        vdk_hs38_defconfig
arm                          gemini_defconfig
xtensa                  nommu_kc705_defconfig
arm                           corgi_defconfig
ia64                          tiger_defconfig
powerpc                  storcenter_defconfig
alpha                            alldefconfig
arm                             rpc_defconfig
mips                       capcella_defconfig
sh                             espt_defconfig
sh                           se7619_defconfig
arm                        trizeps4_defconfig
powerpc                       maple_defconfig
alpha                               defconfig
mips                      maltasmvp_defconfig
sh                           se7705_defconfig
sh                          sdk7780_defconfig
powerpc                      bamboo_defconfig
arm                         lubbock_defconfig
arm                  randconfig-c002-20220318
arm                  randconfig-c002-20220317
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
csky                                defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
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
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
s390                 randconfig-r044-20220317
arc                  randconfig-r043-20220318
riscv                randconfig-r042-20220317
arc                  randconfig-r043-20220317
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
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220318
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220318
riscv                randconfig-c006-20220318
mips                 randconfig-c004-20220318
i386                          randconfig-c001
arm                  randconfig-c002-20220317
riscv                randconfig-c006-20220317
powerpc              randconfig-c003-20220317
mips                 randconfig-c004-20220317
mips                          ath79_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220318
hexagon              randconfig-r041-20220318
riscv                randconfig-r042-20220318
hexagon              randconfig-r041-20220317
s390                 randconfig-r044-20220318
hexagon              randconfig-r045-20220317
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
