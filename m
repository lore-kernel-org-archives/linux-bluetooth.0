Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FC5C6FD19
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Mar 2023 22:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjCJWZC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Mar 2023 17:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjCJWYv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Mar 2023 17:24:51 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF4DD58A1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 14:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678487084; x=1710023084;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=idVipGJUy2/+AmLL8Xf4kiH8DboKVAwX7sV+YTD/diY=;
  b=FAhv0sX1rCoubyY/IUiBzep0fZgfFTTG7LHTlIJIysF4NznpyyeLw5Co
   bJ1yJc07qTS2ASzfsJYPJ200975sqD4ihVc2NhUEWaZqlPDy3wM+jfxfz
   JQypY9LTp7hFk+zfzIADxIplMMXX7sg3hy3IbWDfc1SGu7ExmfK9dxaKH
   MQ4CSaq1tm7TBZ9J7bYsIXI5SFboY3CmCmLSohSupFhTbirP5EtWWh+2p
   0oxk+tOBuGQM+fNIFGGidjVL7zFAWVf7TSkHysELrfbafNARRaxxrgzMe
   vNHYgof7EaCh2najCof4+m5w2oaZpBq2bxInF9Oqz+58k6BC2wIHX03Hg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="423107601"
X-IronPort-AV: E=Sophos;i="5.98,251,1673942400"; 
   d="scan'208";a="423107601"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 14:24:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="821235608"
X-IronPort-AV: E=Sophos;i="5.98,251,1673942400"; 
   d="scan'208";a="821235608"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2023 14:24:30 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1palA5-000487-3D;
        Fri, 10 Mar 2023 22:24:29 +0000
Date:   Sat, 11 Mar 2023 06:23:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 048379740637f105075884228e4f35f8d5580c8e
Message-ID: <640badff.rldhtpTKXz4tLgEJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 048379740637f105075884228e4f35f8d5580c8e  Bluetooth: btqcomsmd: Fix command timeout after setting BD address

elapsed time: 1291m

configs tested: 106
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r032-20230308   gcc  
alpha                randconfig-r036-20230308   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r025-20230308   gcc  
arc                  randconfig-r043-20230308   gcc  
arc                  randconfig-r043-20230310   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r035-20230308   clang
arm                  randconfig-r046-20230308   gcc  
arm                  randconfig-r046-20230310   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r034-20230308   gcc  
csky         buildonly-randconfig-r006-20230308   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r015-20230308   gcc  
hexagon              randconfig-r041-20230308   clang
hexagon              randconfig-r041-20230310   clang
hexagon              randconfig-r045-20230308   clang
hexagon              randconfig-r045-20230310   clang
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
ia64                 randconfig-r013-20230308   gcc  
ia64                 randconfig-r024-20230308   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r033-20230308   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r023-20230308   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230308   gcc  
openrisc     buildonly-randconfig-r002-20230308   gcc  
openrisc             randconfig-r004-20230308   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r005-20230308   clang
powerpc              randconfig-r021-20230308   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230308   gcc  
riscv                randconfig-r022-20230308   clang
riscv                randconfig-r026-20230308   clang
riscv                randconfig-r042-20230308   clang
riscv                randconfig-r042-20230310   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230308   clang
s390                 randconfig-r044-20230310   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r011-20230308   gcc  
sh                   randconfig-r012-20230308   gcc  
sparc        buildonly-randconfig-r004-20230308   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r006-20230308   gcc  
sparc64              randconfig-r001-20230308   gcc  
sparc64              randconfig-r005-20230308   gcc  
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
xtensa               randconfig-r002-20230308   gcc  
xtensa               randconfig-r016-20230308   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
