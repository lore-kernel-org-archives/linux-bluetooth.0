Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AB6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jan 2022 07:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbiAGHOq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jan 2022 02:14:46 -0500
Received: from mga03.intel.com ([134.134.136.65]:63362 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230430AbiAGHOp (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jan 2022 02:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641539685; x=1673075685;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=f+8vLBLt0TQFz08amzL2EQvQrqpZ1DaFr430Kg60XEw=;
  b=O3gzhRxzvCRoOviRbztMQkKQO6Jx+6Tupq1Pqwymoby+VTjqqwxRuw8X
   gxyJKtTvKPefpvrbWOCfMBDNOERDDP8K1b5hG2ZFcHTCL4ZpLQ2a9HzeC
   hO+XX2Jttf+Pt9khTnqKEcgsi4MU5IDQpBEH34ip0E5hwd688qTpqlW/w
   MfDS8P5gTnIw5NVcIVdqx3io8l69Lx8ESKzg597skPh8U79nlb3QsL3rh
   6i2f5DJRz4thAouT+nVcZsdAcMyleYY/sU4qB3AyfNvwp2ZABbd1tO/HX
   g7LtNnxHUtYaehaeCuLFlET6oa6sHvhuaNN2lBy1D9O8asK+eCaE5bCtT
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="242775229"
X-IronPort-AV: E=Sophos;i="5.88,269,1635231600"; 
   d="scan'208";a="242775229"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 23:14:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,269,1635231600"; 
   d="scan'208";a="513698713"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 06 Jan 2022 23:14:43 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5jSV-000IOP-9c; Fri, 07 Jan 2022 07:14:43 +0000
Date:   Fri, 07 Jan 2022 15:14:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 72279d17df54d5e4e7910b39c61a3f3464e36633
Message-ID: <61d7e83b.LUwmNFRNY2SsCbpT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 72279d17df54d5e4e7910b39c61a3f3464e36633  Bluetooth: hci_event: Rework hci_inquiry_result_with_rssi_evt

elapsed time: 1002m

configs tested: 83
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
arm                  randconfig-c002-20220106
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
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
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
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a005-20220107
x86_64               randconfig-a001-20220107
x86_64               randconfig-a004-20220107
x86_64               randconfig-a006-20220107
x86_64               randconfig-a002-20220107
x86_64               randconfig-a003-20220107
x86_64               randconfig-a012-20220106
x86_64               randconfig-a013-20220106
x86_64               randconfig-a011-20220106
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                    rhel-8.3-kselftests

clang tested configs:
arm                          pcm027_defconfig
riscv                    nommu_virt_defconfig
arm                  colibri_pxa270_defconfig
i386                 randconfig-a003-20220106
i386                 randconfig-a005-20220106
i386                 randconfig-a004-20220106
i386                 randconfig-a006-20220106
i386                 randconfig-a002-20220106
i386                 randconfig-a001-20220106
x86_64               randconfig-a012-20220107
x86_64               randconfig-a015-20220107
x86_64               randconfig-a014-20220107
x86_64               randconfig-a013-20220107
x86_64               randconfig-a011-20220107
x86_64               randconfig-a016-20220107
hexagon              randconfig-r041-20220107
hexagon              randconfig-r045-20220107
riscv                randconfig-r042-20220107
s390                 randconfig-r044-20220107

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
