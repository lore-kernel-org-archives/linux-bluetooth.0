Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AECC678D5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Mar 2023 16:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjCDQJI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 4 Mar 2023 11:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjCDQJH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 4 Mar 2023 11:09:07 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CEEDBD0
        for <linux-bluetooth@vger.kernel.org>; Sat,  4 Mar 2023 08:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677946147; x=1709482147;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=nN2cbl7MB8HuZmm5FON3e14QNLQIqNWCB95l1jegwfI=;
  b=Lg9I22VHg5OMDW56kw4KKJTCh/K4goZhYYvBQymsPlICIWQl7wpK2noF
   b0dHsMRtxXBMqIzG9lBqyKaaSuWY5Fav4th2eZZrBWe7+3F8ZIaRy4h+d
   oM6OqhjK7pGFMEBKkj0KeyXIcCS0V9AJCCXIr6soEAGJ0kpvxOkOT6225
   2bjFheebmR6CRlL9PnyNk6xMUD3GCvmo3tvklzUFUpZlkspIS0VYftuLa
   R93JhTCyx67APJ2rFIxBE4SX4ny2a+3me3HyeppNLXLoWFpcMwhcu+RxE
   2DAJyZXjE07ekto7LzLdPEPdSWNxbX1G493a/15rGCxthkcjcdKhmTJ0I
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="362874229"
X-IronPort-AV: E=Sophos;i="5.98,233,1673942400"; 
   d="scan'208";a="362874229"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2023 08:08:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="1004913234"
X-IronPort-AV: E=Sophos;i="5.98,233,1673942400"; 
   d="scan'208";a="1004913234"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Mar 2023 08:08:57 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pYURM-0002Fg-1R;
        Sat, 04 Mar 2023 16:08:56 +0000
Date:   Sun, 05 Mar 2023 00:08:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 ee9b749cb9ad44e1f1b0a9c42fc006e58e06c7f6
Message-ID: <64036cff.ZneMihSYbmn2ZRmY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: ee9b749cb9ad44e1f1b0a9c42fc006e58e06c7f6  Bluetooth: btintel: Iterate only bluetooth device ACPI entries

elapsed time: 913m

configs tested: 102
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r003-20230302   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230302   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r005-20230302   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230302   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r012-20230303   clang
arm                  randconfig-r015-20230302   gcc  
arm                  randconfig-r032-20230302   clang
arm                  randconfig-r046-20230302   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r013-20230303   gcc  
arm64                randconfig-r035-20230302   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230302   gcc  
csky                 randconfig-r016-20230302   gcc  
csky                 randconfig-r021-20230303   gcc  
csky                 randconfig-r036-20230302   gcc  
hexagon      buildonly-randconfig-r001-20230302   clang
hexagon              randconfig-r002-20230302   clang
hexagon              randconfig-r025-20230303   clang
hexagon              randconfig-r041-20230302   clang
hexagon              randconfig-r045-20230302   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r012-20230302   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r004-20230302   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r014-20230303   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r013-20230302   gcc  
m68k                 randconfig-r014-20230302   gcc  
m68k                 randconfig-r024-20230303   gcc  
m68k                 randconfig-r033-20230302   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r006-20230302   clang
mips                 randconfig-r022-20230303   clang
mips                 randconfig-r026-20230303   clang
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230302   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r016-20230303   gcc  
riscv                randconfig-r042-20230302   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230302   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r006-20230302   gcc  
sparc                               defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r034-20230302   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
