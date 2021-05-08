Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71302C433ED
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 May 2021 09:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 511A361426
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 May 2021 09:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhEHJpw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 8 May 2021 05:45:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:21364 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhEHJps (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 8 May 2021 05:45:48 -0400
IronPort-SDR: RqB4x8BJ5TDcfQJxsBGscJmDi3OeF6DeS0v8DSb6JeI85kCRW+Mo2SebKq8cdNLm+UaQ8AWKzO
 1r06cnfHnV6A==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="198551056"
X-IronPort-AV: E=Sophos;i="5.82,283,1613462400"; 
   d="scan'208";a="198551056"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2021 02:44:43 -0700
IronPort-SDR: 3xHX4Q9I2Mmy1kIXjKVOpfGV81nftgjsY14pr7VNS+Z73wxxKRzn0TwUCPpfFiXt7tiSCEn6V0
 N8nwoFY1wy5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,283,1613462400"; 
   d="scan'208";a="608508132"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 May 2021 02:44:41 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lfJVp-000Bdd-9l; Sat, 08 May 2021 09:44:41 +0000
Date:   Sat, 08 May 2021 17:44:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 da68ad722e54ce86fa6f87829cf60d12201cdfaa
Message-ID: <60965d84.rnvYsEeR89gKJBgg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: da68ad722e54ce86fa6f87829cf60d12201cdfaa  Bluetooth: btqca: Don't modify firmware contents in-place

elapsed time: 784m

configs tested: 72
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                       maple_defconfig
mips                           ip27_defconfig
powerpc64                           defconfig
xtensa                              defconfig
um                            kunit_defconfig
arm                        oxnas_v6_defconfig
mips                      fuloong2e_defconfig
sh                        apsh4ad0a_defconfig
arm                            dove_defconfig
ia64                      gensparse_defconfig
powerpc                     kilauea_defconfig
powerpc                      makalu_defconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20210508
x86_64               randconfig-a003-20210508
x86_64               randconfig-a001-20210508
x86_64               randconfig-a002-20210508
x86_64               randconfig-a006-20210508
x86_64               randconfig-a004-20210508

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
