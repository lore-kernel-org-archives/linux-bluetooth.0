Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3EBC0015E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Aug 2023 10:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjHCKDP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Aug 2023 06:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbjHCKCq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Aug 2023 06:02:46 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64356B2
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Aug 2023 03:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691056964; x=1722592964;
  h=date:from:to:cc:subject:message-id;
  bh=IuMEjoSTDvQGHnpYblU15YX6tL6guVGilVh11XvmsUg=;
  b=gGUTWk1X9wrpxY4eOvEkGkhfhj7hldrPoOfLrx8NGk57RaKkUON9yUos
   YIsr6y1LtNhJR7cS7DBlHAHWu1O/zMq77BNdYZkcoRd9OvFZ5xvvKfmTq
   NfJpl9QXLnbTFxZTG6DqCs/EVIZ4HjNxARwK5eauWf0fbEKBkmL5bYniH
   JddMQV7MiMs5vX6CNu5tznLCJVV9DlDEy95kibt+BzKn5Ln0GoKCA5Co4
   3mfAIyxG0aoEu5sbH8ehw25P5IWJfad9DD1tqKxYCiq0+hN129HwhU7PL
   qRTs3iZtfLCGiHIjygv7FmNjREPZhfjVB/75n7lsviodvW39KrxgzD5Wu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="350123807"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="350123807"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 03:02:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="976010905"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="976010905"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 03 Aug 2023 03:02:19 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qRV9u-000221-0X;
        Thu, 03 Aug 2023 10:02:18 +0000
Date:   Thu, 03 Aug 2023 18:01:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 c8573f208a1267021ecd4ed6fea7f548c864b2cf
Message-ID: <202308031819.IV6pAmiy-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: c8573f208a1267021ecd4ed6fea7f548c864b2cf  Bluetooth: Remove unused declaration amp_read_loc_info()

elapsed time: 727m

configs tested: 108
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r002-20230801   gcc  
arc                  randconfig-r043-20230731   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230731   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r033-20230731   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r012-20230731   clang
hexagon              randconfig-r015-20230731   clang
hexagon              randconfig-r041-20230731   clang
hexagon              randconfig-r045-20230731   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230731   gcc  
i386         buildonly-randconfig-r005-20230731   gcc  
i386         buildonly-randconfig-r006-20230731   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230801   gcc  
i386                 randconfig-i002-20230801   gcc  
i386                 randconfig-i003-20230801   gcc  
i386                 randconfig-i004-20230801   gcc  
i386                 randconfig-i005-20230801   gcc  
i386                 randconfig-i006-20230801   gcc  
i386                 randconfig-i011-20230801   clang
i386                 randconfig-i012-20230801   clang
i386                 randconfig-i013-20230801   clang
i386                 randconfig-i014-20230801   clang
i386                 randconfig-i015-20230801   clang
i386                 randconfig-i016-20230801   clang
i386                 randconfig-r005-20230801   gcc  
i386                 randconfig-r014-20230731   clang
i386                 randconfig-r024-20230731   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r022-20230731   gcc  
mips                 randconfig-r032-20230731   clang
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230731   gcc  
nios2                randconfig-r035-20230731   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r026-20230731   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r004-20230801   gcc  
riscv                randconfig-r025-20230731   clang
riscv                randconfig-r042-20230731   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230801   gcc  
s390                 randconfig-r021-20230731   clang
s390                 randconfig-r044-20230731   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r003-20230801   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r023-20230731   gcc  
sparc                randconfig-r034-20230731   gcc  
sparc64              randconfig-r013-20230731   gcc  
sparc64              randconfig-r016-20230731   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230731   gcc  
x86_64       buildonly-randconfig-r002-20230731   gcc  
x86_64       buildonly-randconfig-r003-20230731   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r006-20230801   gcc  
x86_64               randconfig-r036-20230731   gcc  
x86_64               randconfig-x001-20230731   clang
x86_64               randconfig-x002-20230731   clang
x86_64               randconfig-x003-20230731   clang
x86_64               randconfig-x004-20230731   clang
x86_64               randconfig-x005-20230731   clang
x86_64               randconfig-x006-20230731   clang
x86_64               randconfig-x011-20230731   gcc  
x86_64               randconfig-x012-20230731   gcc  
x86_64               randconfig-x013-20230731   gcc  
x86_64               randconfig-x014-20230731   gcc  
x86_64               randconfig-x015-20230731   gcc  
x86_64               randconfig-x016-20230731   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
