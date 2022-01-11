Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B515C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Jan 2022 05:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343853AbiAKFd2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Jan 2022 00:33:28 -0500
Received: from mga09.intel.com ([134.134.136.24]:11698 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbiAKFd2 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Jan 2022 00:33:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641879208; x=1673415208;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=KfeAcZiuUZwjGql5vC+b/gi/diDRNs8B6Si2R6c7QW8=;
  b=CxF/5dBuftGPTsHlNadDx/Av58wKMbelJMXFIx7pekRljqHUgD1FCOt/
   B0NlAxAb5f10DMnwYruKVX3DoAEOlpjjWkq8RCewcJimUyJs/vwu4jFy1
   S760rRJs6JNxNmod4Hso2aLZVt7tFvz75yOV9wFopjpyInBS45d6aYer+
   /HZ7Xlo/rJqOZZiiZ1Vt2r1GnUwmMwEROgbnI7N6edKZISejKlOuYX9CL
   OTAjapSc884Co6peejliABPsWIDXceoJmTh8yewk20eQmnULXVDzA0WaJ
   vFodknPsRa5rcA7HORxBuwpWn1O04CXohV8x7W1T4G1XdNdO7ea3op3i8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="243202938"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="243202938"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 21:33:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="472337487"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 10 Jan 2022 21:33:26 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n79mg-0004Pk-7U; Tue, 11 Jan 2022 05:33:26 +0000
Date:   Tue, 11 Jan 2022 13:33:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 386f626adda81d224f7229e31ebdefcd616b2ff2
Message-ID: <61dd1699.fLsJT9jNVwasPQy7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 386f626adda81d224f7229e31ebdefcd616b2ff2  Bluetooth: btmtksdio: clean up inconsistent error message in btmtksdio_mtk_reg_read

elapsed time: 734m

configs tested: 54
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
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
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
