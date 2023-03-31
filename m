Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E781C76196
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Mar 2023 06:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCaGi3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Mar 2023 02:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCaGi3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Mar 2023 02:38:29 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3908FA269
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 23:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680244708; x=1711780708;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=eQNr+0otKIE+Qt5PusY6x7gyLGVSzXYmU3c6te4gCVQ=;
  b=lz+HKIiV+p6L80/BLT6ueKtYQZ+17x1fK6I9kghiqLj+661YVrmcexOS
   cVMGSY8bPzD/1ektn1cjoEhoe0NPG0LsN4H79Uax+tUiIGz14BZPETABb
   xICc6fp13jW1XvFx3YTOt7hQjQebW5sz3BfHzSE2KGuRtrdtqyLFpbiGq
   AGUAIUOZhUKQKc2DQIll1YwOpa/33SAokWx0/omg6x21JS3DphY51cMFp
   bKjQ36Wef3SN7XZaOGduHnj4vA7dxbfidgo2Xs5z8jCf/wI1fwk7fDAGQ
   KRkw0Gj1Onr2C9VR8+1TnvoL6/8TYG71okoYEK09WL9GMuuP/l0jZpPks
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="329906517"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="329906517"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 23:38:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="774247972"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="774247972"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Mar 2023 23:38:26 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pi8P3-000LYi-1v;
        Fri, 31 Mar 2023 06:38:25 +0000
Date:   Fri, 31 Mar 2023 14:38:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 0b93eeba44548b15b44f63e5ea820fd5dab0a835
Message-ID: <64267fd5.kT2jxcTQ61xsxCJX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 0b93eeba44548b15b44f63e5ea820fd5dab0a835  Bluetooth: btintel: Add Intel devcoredump support

elapsed time: 729m

configs tested: 103
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r005-20230329   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r025-20230329   gcc  
arc                  randconfig-r043-20230329   gcc  
arc                  randconfig-r043-20230330   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230329   gcc  
arm                  randconfig-r046-20230330   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230329   gcc  
csky                 randconfig-r031-20230329   gcc  
csky                 randconfig-r034-20230329   gcc  
hexagon              randconfig-r001-20230329   clang
hexagon              randconfig-r041-20230329   clang
hexagon              randconfig-r041-20230330   clang
hexagon              randconfig-r045-20230329   clang
hexagon              randconfig-r045-20230330   clang
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
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230329   gcc  
loongarch            randconfig-r015-20230329   gcc  
loongarch            randconfig-r036-20230329   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230329   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r005-20230329   gcc  
microblaze           randconfig-r016-20230329   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r021-20230329   gcc  
nios2                               defconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230329   gcc  
parisc               randconfig-r022-20230329   gcc  
parisc               randconfig-r032-20230329   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r003-20230329   gcc  
powerpc              randconfig-r026-20230329   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230329   clang
riscv                randconfig-r042-20230330   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r003-20230329   clang
s390                                defconfig   gcc  
s390                 randconfig-r044-20230329   clang
s390                 randconfig-r044-20230330   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r006-20230329   gcc  
sh                   randconfig-r023-20230329   gcc  
sparc        buildonly-randconfig-r004-20230329   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r024-20230329   gcc  
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
xtensa               randconfig-r033-20230329   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
