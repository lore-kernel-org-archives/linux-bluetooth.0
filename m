Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125D3C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Mar 2022 02:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbiCVC7O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Mar 2022 22:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbiCVC7N (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Mar 2022 22:59:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17B6331475
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Mar 2022 19:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647917866; x=1679453866;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dHnxNN43lARjwNXToebB4BjwDOW3nLlcrbol9K6zvlo=;
  b=HVKPWqbY9lBzY5i/DcSU8bJRVPzqxcdNTyP8OmQ8S0q8qDyj2HheI7lF
   eg0GAy7JrZAlWmPFse+uofYMuFoV3IgqdAfBqawIDKppEa6z74+SH82fW
   2L8M7IUyq/GAz1jlbj0b4CzzEagVUmu2Mb+xDW01wpKqLmFvCpNY4Uck4
   RqNlOBcMWRS0o4yaTJ8SszSN42blVFAxKHFZqGusuMD1hcehX/+T6ymJG
   7fAVWLrby/wuieR+J23R/e0ptd3mptN0q9at3CA3ZDzH4o3JiokS0HUU+
   VKOpd8l/hSGgPTtliANd1EbiPOhwk3JTLHQE+9IR9DWeuJd6SjZYZtikU
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="320909642"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="320909642"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 19:57:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="515169744"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 21 Mar 2022 19:57:43 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWUiM-000IO7-Gl; Tue, 22 Mar 2022 02:57:42 +0000
Date:   Tue, 22 Mar 2022 10:56:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 033465911fe5ccef6d7ad34a6d7e53cbd78c40e0
Message-ID: <62393af9.pebGZr29zbORJcXK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 033465911fe5ccef6d7ad34a6d7e53cbd78c40e0  Bluetooth: btbcm: Support per-board firmware variants

elapsed time: 724m

configs tested: 97
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
m68k                             alldefconfig
riscv                    nommu_k210_defconfig
m68k                       m5475evb_defconfig
openrisc                  or1klitex_defconfig
powerpc                 mpc837x_mds_defconfig
mips                         rt305x_defconfig
um                               alldefconfig
arc                            hsdk_defconfig
mips                        vocore2_defconfig
xtensa                    xip_kc705_defconfig
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a013-20220321
x86_64               randconfig-a012-20220321
x86_64               randconfig-a014-20220321
x86_64               randconfig-a011-20220321
x86_64               randconfig-a016-20220321
x86_64               randconfig-a015-20220321
i386                 randconfig-a013-20220321
i386                 randconfig-a011-20220321
i386                 randconfig-a012-20220321
i386                 randconfig-a014-20220321
i386                 randconfig-a016-20220321
i386                 randconfig-a015-20220321
arc                  randconfig-r043-20220322
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
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
arm                     am200epdkit_defconfig
arm                        spear3xx_defconfig
powerpc                        fsp2_defconfig
i386                 randconfig-a003-20220321
i386                 randconfig-a004-20220321
i386                 randconfig-a005-20220321
i386                 randconfig-a001-20220321
i386                 randconfig-a006-20220321
i386                 randconfig-a002-20220321
x86_64               randconfig-a002-20220321
x86_64               randconfig-a003-20220321
x86_64               randconfig-a001-20220321
x86_64               randconfig-a004-20220321
x86_64               randconfig-a005-20220321
x86_64               randconfig-a006-20220321
riscv                randconfig-r042-20220322
s390                 randconfig-r044-20220322
hexagon              randconfig-r045-20220322
hexagon              randconfig-r041-20220322

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
