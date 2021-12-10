Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C71C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Dec 2021 20:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242495AbhLJU34 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Dec 2021 15:29:56 -0500
Received: from mga01.intel.com ([192.55.52.88]:16428 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234738AbhLJU34 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Dec 2021 15:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639167980; x=1670703980;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=7uUDcBnRnrGXo8MIqxyzVybzFU4ldto/frwe7FBzlfY=;
  b=Q8wHJSu+PTfPUgrf33/nZob5wGdh9my2SqXue6Dq/dP4c9LJfKps7b5g
   OTAhFsxHRfyMVu5ga/a792Sv3GPUgrp/j0I2zWjDMtwSkimp3qutx2Kjx
   NmlIAW1Py+gVSixjlAXAiLKMxH+AK8soC2uxirbFozZL+bM1Cjjnzh4w+
   ONV8tamL3YIMAPADUIldDicdbSN6Bktuj8U0Ots3qxZ/s6fy/4QWRFVab
   CHQLgASqJYhN0vIudok8NbG6Lw6+1SXc/StCUQsFZzPUFVnAeKHNBol5O
   tfp1WGbyZHSLa6cGDdltsV68ZkSsriknDB0cF3h/KJWf6q+JbgCR21IcI
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="262551079"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="262551079"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 12:26:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="659750815"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 10 Dec 2021 12:26:17 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvmTB-0003f1-9Y; Fri, 10 Dec 2021 20:26:17 +0000
Date:   Sat, 11 Dec 2021 04:25:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 375c44d939ba1314a77c5ae2702f49454c1ad021
Message-ID: <61b3b7bd.oqeCljQRQmNky8Qy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 375c44d939ba1314a77c5ae2702f49454c1ad021  Bluetooth: btusb: Add two more Bluetooth parts for WCN6855

elapsed time: 1995m

configs tested: 65
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                  randconfig-c002-20211209
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
s390                             allmodconfig
s390                                defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a006-20211209
x86_64               randconfig-a005-20211209
x86_64               randconfig-a001-20211209
x86_64               randconfig-a002-20211209
x86_64               randconfig-a004-20211209
x86_64               randconfig-a003-20211209
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                    rhel-8.3-kselftests

clang tested configs:
hexagon              randconfig-r045-20211209
s390                 randconfig-r044-20211209
hexagon              randconfig-r041-20211209
riscv                randconfig-r042-20211209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
