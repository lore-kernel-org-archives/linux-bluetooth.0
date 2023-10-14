Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0946CDB465
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Oct 2023 09:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjJNJTG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 14 Oct 2023 05:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjJNJTF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 14 Oct 2023 05:19:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8839DC2
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Oct 2023 02:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697275144; x=1728811144;
  h=date:from:to:cc:subject:message-id;
  bh=3wQVtgduTcG7BntVm/xUvZ5iYuII09fhEicfcQjdo2Y=;
  b=TsGePcTb6uVpL5mMIGyjb9YstrvIQAj8TgK4feHk7WpnBZXTZFzaRBNP
   tWrXoTUrXtmmpLDt7C9XZGVKkdobAPYIaEoIZgo+M2mjUMQhmOSilO8Md
   se1uQRKBk+q3ZzScAFX9T0bfc9QXOY6cmjcISWBoWlyWsrHUzFfnGskgJ
   1fzsxPxZNT6SgW0wdY2gc1U+8N6NbweZDCkOLFuTA9sMWRJZAwg9IZlUW
   +7CbYuURH07x7rx0ta7SuEeHxYGRtbFuGD0jYoAKsG3o3PHuPY4h9ze7k
   cBD46fLD0rKwzZUFFOa2N6jn58fJUjFvIPXCCAqWfUQ+kEEKDVVGoBxYz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="385155451"
X-IronPort-AV: E=Sophos;i="6.03,224,1694761200"; 
   d="scan'208";a="385155451"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2023 02:19:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="754993469"
X-IronPort-AV: E=Sophos;i="6.03,224,1694761200"; 
   d="scan'208";a="754993469"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 14 Oct 2023 02:19:02 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qranU-0005yj-1k;
        Sat, 14 Oct 2023 09:19:00 +0000
Date:   Sat, 14 Oct 2023 17:18:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 8fa4c368ba691e6d92bc7a71279ed4ce5f1a6a1d
Message-ID: <202310141742.0Hhdg9d4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 8fa4c368ba691e6d92bc7a71279ed4ce5f1a6a1d  Bluetooth: ISO: Copy BASE if service data matches EIR_BAA_SERVICE_UUID

elapsed time: 2187m

configs tested: 139
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
arc                   randconfig-001-20231013   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   clang
arm                                 defconfig   gcc  
arm                   randconfig-001-20231013   gcc  
arm                   randconfig-001-20231014   gcc  
arm                         socfpga_defconfig   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231013   gcc  
i386                  randconfig-001-20231014   gcc  
i386                  randconfig-002-20231013   gcc  
i386                  randconfig-002-20231014   gcc  
i386                  randconfig-003-20231013   gcc  
i386                  randconfig-003-20231014   gcc  
i386                  randconfig-004-20231013   gcc  
i386                  randconfig-004-20231014   gcc  
i386                  randconfig-005-20231013   gcc  
i386                  randconfig-005-20231014   gcc  
i386                  randconfig-006-20231013   gcc  
i386                  randconfig-006-20231014   gcc  
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231013   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                           ip27_defconfig   clang
mips                        maltaup_defconfig   clang
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
parisc                generic-64bit_defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                    sam440ep_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231013   gcc  
riscv                 randconfig-001-20231014   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231013   gcc  
s390                  randconfig-001-20231014   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231014   gcc  
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
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231013   gcc  
x86_64                randconfig-001-20231014   gcc  
x86_64                randconfig-002-20231013   gcc  
x86_64                randconfig-002-20231014   gcc  
x86_64                randconfig-003-20231013   gcc  
x86_64                randconfig-003-20231014   gcc  
x86_64                randconfig-004-20231013   gcc  
x86_64                randconfig-004-20231014   gcc  
x86_64                randconfig-005-20231013   gcc  
x86_64                randconfig-005-20231014   gcc  
x86_64                randconfig-006-20231013   gcc  
x86_64                randconfig-006-20231014   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
