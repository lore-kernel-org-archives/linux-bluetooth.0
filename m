Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96D7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 03:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A67B6058D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 03:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239045AbhJ0DR1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Oct 2021 23:17:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:39824 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239044AbhJ0DR0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Oct 2021 23:17:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="216975345"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="216975345"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 20:15:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="497649287"
Received: from lkp-server01.sh.intel.com (HELO 33c68f307df1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 26 Oct 2021 20:14:44 -0700
Received: from kbuild by 33c68f307df1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mfZOl-00009E-Tk; Wed, 27 Oct 2021 03:14:43 +0000
Date:   Wed, 27 Oct 2021 11:14:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 c603bf1f94d0ef8ce3ef081112eae13cd744ef17
Message-ID: <6178c411.wTd6p5+AfBJSnIY1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: c603bf1f94d0ef8ce3ef081112eae13cd744ef17  Bluetooth: btmtksdio: add MT7921s Bluetooth support

elapsed time: 2211m

configs tested: 52
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
m68k                                defconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
sh                               allmodconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                           allyesconfig
s390                                defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
