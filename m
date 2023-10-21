Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69006CDB474
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Oct 2023 03:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjJUDox (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Oct 2023 23:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJUDow (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Oct 2023 23:44:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0298D76
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 20:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697859887; x=1729395887;
  h=date:from:to:cc:subject:message-id;
  bh=b1SHD204tZhxlsF9hEmPZIpxu01M4/CgirGSVPJLtQM=;
  b=Qc6JNKWfkK4wP+dobZjaT6ck3RKSw/xtrwtkKf5PFUwS6ZWG/sdLEUxy
   oVSMNLA0+ID0Iyes+Mr2wOWUxaV2m/lX6qwP7n4obH3qtjz2OkakyExxc
   68lDsOy43PtfwrXpXNDphklYAQFWP5Q/Re1BLQ5f//Ve9qVWstcCj2EFG
   BuM63bSa6viy87iFLSdvV/Lv9vx7aKv/GACpea4f3VP8XvrU4qOT31e2I
   jgVQsoH/mzTO16qoQLGvHpXgx8zSdkY65counBXX5cxOMedUMzSPGgqXq
   IkPbMPLVqn/G3W/rURgRyTZBi4WV6caqAGkWc7NE1QpX2uWxB9VcfF+9f
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="376985412"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="376985412"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 20:44:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="751119002"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="751119002"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 20 Oct 2023 20:44:46 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qu2up-0004La-2I;
        Sat, 21 Oct 2023 03:44:43 +0000
Date:   Sat, 21 Oct 2023 11:44:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 8a589c6d138e0f9d63d3adc49b8f80fe059d8274
Message-ID: <202310211157.z9xjH3sE-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 8a589c6d138e0f9d63d3adc49b8f80fe059d8274  Bluetooth: hci_sync: Fix Opcode prints in bt_dev_dbg/err

elapsed time: 3301m

configs tested: 132
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231019   gcc  
arc                   randconfig-001-20231020   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231019   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                              allnoconfig   gcc  
i386         buildonly-randconfig-001-20231019   gcc  
i386         buildonly-randconfig-002-20231019   gcc  
i386         buildonly-randconfig-003-20231019   gcc  
i386         buildonly-randconfig-004-20231019   gcc  
i386         buildonly-randconfig-005-20231019   gcc  
i386         buildonly-randconfig-006-20231019   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231019   gcc  
i386                  randconfig-002-20231019   gcc  
i386                  randconfig-003-20231019   gcc  
i386                  randconfig-004-20231019   gcc  
i386                  randconfig-005-20231019   gcc  
i386                  randconfig-006-20231019   gcc  
i386                  randconfig-011-20231019   gcc  
i386                  randconfig-012-20231019   gcc  
i386                  randconfig-013-20231019   gcc  
i386                  randconfig-014-20231019   gcc  
i386                  randconfig-015-20231019   gcc  
i386                  randconfig-016-20231019   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231019   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231019   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231019   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231019   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231019   gcc  
x86_64       buildonly-randconfig-002-20231019   gcc  
x86_64       buildonly-randconfig-003-20231019   gcc  
x86_64       buildonly-randconfig-004-20231019   gcc  
x86_64       buildonly-randconfig-005-20231019   gcc  
x86_64       buildonly-randconfig-006-20231019   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231019   gcc  
x86_64                randconfig-002-20231019   gcc  
x86_64                randconfig-003-20231019   gcc  
x86_64                randconfig-004-20231019   gcc  
x86_64                randconfig-005-20231019   gcc  
x86_64                randconfig-006-20231019   gcc  
x86_64                randconfig-011-20231020   gcc  
x86_64                randconfig-012-20231020   gcc  
x86_64                randconfig-013-20231020   gcc  
x86_64                randconfig-014-20231020   gcc  
x86_64                randconfig-015-20231020   gcc  
x86_64                randconfig-016-20231020   gcc  
x86_64                randconfig-071-20231020   gcc  
x86_64                randconfig-072-20231020   gcc  
x86_64                randconfig-073-20231020   gcc  
x86_64                randconfig-074-20231020   gcc  
x86_64                randconfig-075-20231020   gcc  
x86_64                randconfig-076-20231020   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
