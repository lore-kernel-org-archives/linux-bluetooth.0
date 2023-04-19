Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872A7C77B73
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Apr 2023 09:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjDSJFC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Apr 2023 05:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbjDSJFB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Apr 2023 05:05:01 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EF212C93
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 02:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681895087; x=1713431087;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=cegqetK41f/aFa5gtmOJO7pFJPrjhokxgTmkkbUxOxo=;
  b=FcLgjMkIIwZQ9TTvHPMAXWA8ueOvluBD+1y0DCRqDyP/JuN/IUo+Wq7L
   mD7ycCjqFyY461mozC/VozEOotLO+/V3jCtiu1z9gRjxXx4gJscHOzlmX
   9EV5iiQTohx8OHf6QOCQZDLAfdLi0PhaKGFqImkzWGTBtoNJMrwb+cAJG
   5G6pC1aJIGN0cHxdnpq8+0ARHwlfJ7SCbzx+xzanJVT8HHHOPLk1iaQ9c
   2BrU6Gn+S5r1tkhxWcANQ8sv2/FmMpYUO33AusXyd7jbhdeLaFcPKGU6Z
   agX4cjRi7CPpgHSYFPylx8vuFOkq0j2vyGQ8Z7QwXeOv1RpCpu2OKmiCA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="348148241"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="348148241"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 02:04:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="691425593"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="691425593"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 19 Apr 2023 02:04:45 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pp3k4-000el9-2j;
        Wed, 19 Apr 2023 09:04:44 +0000
Date:   Wed, 19 Apr 2023 17:04:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 183d1a0466eb3e75cb9e60f031cac2a4f2dffb80
Message-ID: <643fae98.6JQ338yv8f3rL7mN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 183d1a0466eb3e75cb9e60f031cac2a4f2dffb80  Bluetooth: btnxpuart: Fix sparse warnings

elapsed time: 721m

configs tested: 82
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r032-20230416   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r011-20230416   gcc  
arc                  randconfig-r035-20230416   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r012-20230416   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r016-20230416   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r015-20230416   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                 randconfig-a011-20230417   clang
i386                 randconfig-a012-20230417   clang
i386                 randconfig-a013-20230417   clang
i386                 randconfig-a014-20230417   clang
i386                 randconfig-a015-20230417   clang
i386                 randconfig-a016-20230417   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r013-20230417   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r015-20230417   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r014-20230416   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r012-20230417   gcc  
sh                   randconfig-r013-20230416   gcc  
sh                   randconfig-r014-20230417   gcc  
sh                   randconfig-r036-20230416   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230417   gcc  
sparc                randconfig-r016-20230417   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230417   gcc  
x86_64               randconfig-a002-20230417   gcc  
x86_64               randconfig-a003-20230417   gcc  
x86_64               randconfig-a004-20230417   gcc  
x86_64               randconfig-a005-20230417   gcc  
x86_64               randconfig-a006-20230417   gcc  
x86_64               randconfig-a011-20230417   clang
x86_64               randconfig-a012-20230417   clang
x86_64               randconfig-a013-20230417   clang
x86_64               randconfig-a014-20230417   clang
x86_64               randconfig-a015-20230417   clang
x86_64               randconfig-a016-20230417   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
