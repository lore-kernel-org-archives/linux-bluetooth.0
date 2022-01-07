Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC4CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jan 2022 22:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiAGWWU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jan 2022 17:22:20 -0500
Received: from mga14.intel.com ([192.55.52.115]:1174 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230326AbiAGWWT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jan 2022 17:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641594139; x=1673130139;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=BT+jXPR5pGh571frl1kO5RtR8nCsvrNXEc9RaIOewXg=;
  b=nbgVsaras7dyXq7/RSVwYAoT9M3D9tYj9c25IUdy5i0OKv0xYqb3jvwY
   RwdwZ0oxjCTYcBfdbobm0xMPIuiwHq4f4nmtvqPh1/tUr1lhICeslgGZQ
   rOaix+raZtKl5JryFH0SwkJ8Z2YsGZxqRwsKazBbiuFnokOr2NRxhwEUR
   rkuXSsGk9pWfXeU6bsEKi3sUKA2g0puOGCFvfmJzAjOk7j/MrZP2yuCVf
   /IbU6Zbxl9cVpsAOoCV8XrKM/qQrqarYOufAJsqn8kTjHok8Cl3XhEA3Z
   tBaqLEHt1qrpW1IiXIjGUmgRQXtTQPmCzrc8BOtmwMxnkXBSPBGxiBHxu
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="243150934"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="243150934"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 14:22:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="471445575"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Jan 2022 14:22:17 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5xcm-000J5Y-VT; Fri, 07 Jan 2022 22:22:16 +0000
Date:   Sat, 08 Jan 2022 06:21:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 b9f9dbad0bd1c302d357fdd327c398f51f5fc2b1
Message-ID: <61d8bcee.s+yJbE8/qfNT9/mA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: b9f9dbad0bd1c302d357fdd327c398f51f5fc2b1  Bluetooth: hci_sock: fix endian bug in hci_sock_setsockopt()

elapsed time: 795m

configs tested: 99
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220107
m68k                            q40_defconfig
powerpc                        warp_defconfig
arm                       multi_v4t_defconfig
sh                           se7619_defconfig
m68k                       m5475evb_defconfig
powerpc                 linkstation_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                         assabet_defconfig
arm                         cm_x300_defconfig
h8300                            alldefconfig
arm                          simpad_defconfig
um                           x86_64_defconfig
sh                        sh7785lcr_defconfig
powerpc                  iss476-smp_defconfig
h8300                            allyesconfig
powerpc                    sam440ep_defconfig
um                             i386_defconfig
arm                  randconfig-c002-20220107
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
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                               defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20220107
x86_64               randconfig-a001-20220107
x86_64               randconfig-a004-20220107
x86_64               randconfig-a006-20220107
x86_64               randconfig-a002-20220107
x86_64               randconfig-a003-20220107
i386                 randconfig-a003-20220107
i386                 randconfig-a005-20220107
i386                 randconfig-a004-20220107
i386                 randconfig-a006-20220107
i386                 randconfig-a002-20220107
i386                 randconfig-a001-20220107
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
powerpc                     skiroot_defconfig
x86_64               randconfig-a012-20220107
x86_64               randconfig-a015-20220107
x86_64               randconfig-a014-20220107
x86_64               randconfig-a013-20220107
x86_64               randconfig-a011-20220107
x86_64               randconfig-a016-20220107
i386                 randconfig-a012-20220107
i386                 randconfig-a016-20220107
i386                 randconfig-a014-20220107
i386                 randconfig-a015-20220107
i386                 randconfig-a011-20220107
i386                 randconfig-a013-20220107
s390                 randconfig-r044-20220107
hexagon              randconfig-r041-20220107
hexagon              randconfig-r045-20220107
riscv                randconfig-r042-20220107

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
