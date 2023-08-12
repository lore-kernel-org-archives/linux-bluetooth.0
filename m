Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A080AC04A94
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Aug 2023 08:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbjHLIVI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Aug 2023 04:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjHLIVG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Aug 2023 04:21:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFDC2108
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Aug 2023 01:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691828469; x=1723364469;
  h=date:from:to:cc:subject:message-id;
  bh=eXlB/ze+IE5HuOLwqJqzB05UK7mgIZmaMRNe18SzPOs=;
  b=GAlEtO4u5+dubG1wNt69cMBpnGnHEZjgEo65PHYlccpa+drN3Rcgn+Ku
   cDyHh+YT9yZCze/mwhUTGFXgrhxJ1Naevg2R75puHItyk1EDu5W9CPiHk
   gKWDIqUUktsE1bWDr6N6svrEubbCS14Wz4YNlAF7TjuOMqMRlhaV2BgsL
   w9uqh6FzdIljEg/uPFKIYCn+SCgxzuAl7I+p4bqoSHxoS4Q4aaoHDLmp8
   7hcXBdFBJ9XyMJwNN5AkWb7o9IuM+vQWN8zGotwZCTN4xshN1Ie8sjm7E
   uabSb1lwFRkgaTFhHIC6PY/FiqDgTX31xtodXKHAYUdSxM+f2ZrKS31Ra
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="375523066"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="375523066"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2023 01:21:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="767906972"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="767906972"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 12 Aug 2023 01:21:07 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUjru-0008PO-39;
        Sat, 12 Aug 2023 08:21:06 +0000
Date:   Sat, 12 Aug 2023 16:20:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 b5793de3cfaefef34a1fc9305c9fe3dbcd0ac792
Message-ID: <202308121636.F40kFPXj-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: b5793de3cfaefef34a1fc9305c9fe3dbcd0ac792  Bluetooth: hci_conn: avoid checking uninitialized CIG/CIS ids

elapsed time: 724m

configs tested: 107
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r031-20230812   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r012-20230812   gcc  
arc                  randconfig-r024-20230812   gcc  
arc                  randconfig-r043-20230812   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230812   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r032-20230812   gcc  
hexagon              randconfig-r041-20230812   clang
hexagon              randconfig-r045-20230812   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230812   gcc  
i386         buildonly-randconfig-r005-20230812   gcc  
i386         buildonly-randconfig-r006-20230812   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230812   gcc  
i386                 randconfig-i002-20230812   gcc  
i386                 randconfig-i003-20230812   gcc  
i386                 randconfig-i004-20230812   gcc  
i386                 randconfig-i005-20230812   gcc  
i386                 randconfig-i006-20230812   gcc  
i386                 randconfig-i011-20230812   clang
i386                 randconfig-i012-20230812   clang
i386                 randconfig-i013-20230812   clang
i386                 randconfig-i014-20230812   clang
i386                 randconfig-i015-20230812   clang
i386                 randconfig-i016-20230812   clang
i386                 randconfig-r006-20230812   gcc  
i386                 randconfig-r014-20230812   clang
i386                 randconfig-r022-20230812   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230812   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r003-20230812   gcc  
microblaze           randconfig-r013-20230812   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r015-20230812   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r026-20230812   gcc  
openrisc             randconfig-r002-20230812   gcc  
openrisc             randconfig-r005-20230812   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230812   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r036-20230812   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230812   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r025-20230812   clang
s390                 randconfig-r044-20230812   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r034-20230812   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r016-20230812   gcc  
sparc64              randconfig-r021-20230812   gcc  
sparc64              randconfig-r035-20230812   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230812   gcc  
x86_64       buildonly-randconfig-r002-20230812   gcc  
x86_64       buildonly-randconfig-r003-20230812   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r033-20230812   gcc  
x86_64               randconfig-x001-20230812   clang
x86_64               randconfig-x002-20230812   clang
x86_64               randconfig-x003-20230812   clang
x86_64               randconfig-x004-20230812   clang
x86_64               randconfig-x005-20230812   clang
x86_64               randconfig-x006-20230812   clang
x86_64               randconfig-x011-20230812   gcc  
x86_64               randconfig-x012-20230812   gcc  
x86_64               randconfig-x013-20230812   gcc  
x86_64               randconfig-x014-20230812   gcc  
x86_64               randconfig-x015-20230812   gcc  
x86_64               randconfig-x016-20230812   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
