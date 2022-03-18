Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A360AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Mar 2022 00:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiCRAQD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Mar 2022 20:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiCRAQD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Mar 2022 20:16:03 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3702BC1E0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Mar 2022 17:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647562485; x=1679098485;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=MlumUUz8QVrRYOyMQhAeCTrHe/ywq0Qo7mYkSLluwTw=;
  b=KmGXDWMypg+SVTe+u122qP+bfG9xCZjpGS6VBmIzmAS2Fq7bEb16nECc
   K8tHGoUO1e5bJ341fDdf7ggpxYjyYKXGzalEsNlFFi0FbxLF+UWQ5msEP
   XVTvOnrtF8lT63QAaSd8S+oWxMkxZiQyXfNrLjX5ho9AmadytPLbTBzAg
   fFQP+rYYnz2xF4GbluWaFP2C+yUKKxsVqmvRNCc+sI0RJ/S7ZuWNRgHLh
   RypJxSBm7wKomfYRfpzTXgEPuht4npPCy0FMzouy6nitqVFlJ1kul2UZi
   BJussrdlHK7gVo5Wfo3b8DBjk1O3ovNx5AGvCYCAqE0Dhe6AbAwqE025o
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="239175262"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="239175262"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 17:14:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="715241883"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 17 Mar 2022 17:14:44 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nV0GR-000EG7-EA; Fri, 18 Mar 2022 00:14:43 +0000
Date:   Fri, 18 Mar 2022 08:14:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 255a55aaccb17fee3fa947c7eadf76d0e693da79
Message-ID: <6233cedc.I4DogiFO2ilTzfyr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 255a55aaccb17fee3fa947c7eadf76d0e693da79  Bluetooth: mt7921s: Add WBS support

elapsed time: 729m

configs tested: 105
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
arm                             pxa_defconfig
sh                   rts7751r2dplus_defconfig
nios2                         10m50_defconfig
sh                               alldefconfig
powerpc                       holly_defconfig
mips                       capcella_defconfig
sparc                            alldefconfig
sh                ecovec24-romimage_defconfig
powerpc                    adder875_defconfig
alpha                               defconfig
m68k                            q40_defconfig
mips                           xway_defconfig
sh                            migor_defconfig
mips                     decstation_defconfig
arm                  randconfig-c002-20220317
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                                defconfig
parisc64                            defconfig
s390                             allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a002
x86_64                        randconfig-a004
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220317
riscv                randconfig-r042-20220317
s390                 randconfig-r044-20220317
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
arm                    vt8500_v6_v7_defconfig
mips                        qi_lb60_defconfig
powerpc                     mpc512x_defconfig
arm                          pxa168_defconfig
powerpc                     tqm5200_defconfig
arm                          ixp4xx_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r041-20220317
hexagon              randconfig-r045-20220317

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
