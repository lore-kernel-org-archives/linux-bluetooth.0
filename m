Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245F6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jan 2022 12:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiAFMuS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jan 2022 07:50:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:29222 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229838AbiAFMuR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jan 2022 07:50:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641473417; x=1673009417;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GbuCc6w3OWBsic1ZGuYBlM7p5mwZmjmnEuT0sTXG+Qs=;
  b=W1bMW+HDV4Ibl5xy143pMqsqQBEus1tqs1f2hkskASB1d4JXXwodWfOu
   AhHnAl7k/hYCLB9J8kWVuIB4GVG3fRaHKnjy/p/uplz7Xs0AthCMGNsqg
   saXXS9cDDl3Fr7gVTnY+Fk9evf3HEdNRKXr+G+yOnWo0ab5tUEjFztYcZ
   c9LAK35/S4YQwXIlEwt0lhuWuX3VO42LYjCDQjDIzOJHq52sXYp/0b4hl
   3Ncdm23bJaBer6A86TalVYCdsRbdCINJnDD4D/G1E1VFo4TaIVM0FkICd
   6DOU0M58pZlzu6E8DSa5+ohRv5+lVm8g8kLenaw9v+Zlacq7ZWYW6KXW2
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="306002293"
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="306002293"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 04:50:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="470935119"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 Jan 2022 04:50:16 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5SDf-000HfA-FD; Thu, 06 Jan 2022 12:50:15 +0000
Date:   Thu, 06 Jan 2022 20:49:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 4e4f325a0a55907b14f579e6b1a38c53755e3de2
Message-ID: <61d6e575.6g5baRg9jm8e7VoD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 4e4f325a0a55907b14f579e6b1a38c53755e3de2  net: gemini: allow any RGMII interface mode

elapsed time: 1004m

configs tested: 62
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                  randconfig-c002-20220105
arm                  randconfig-c002-20220106
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                          rv32_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
i386                 randconfig-a003-20220106
i386                 randconfig-a005-20220106
i386                 randconfig-a004-20220106
i386                 randconfig-a006-20220106
i386                 randconfig-a002-20220106
i386                 randconfig-a001-20220106

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
