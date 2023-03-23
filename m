Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB67C6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 16:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjCWQ3J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjCWQ26 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 12:28:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70C8211EC
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 09:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679588935; x=1711124935;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=F1ZwP1dD2eqTi51mmydbrRQTayv2TxxG+u1d266pioI=;
  b=MWa3QZyV8I4g75SCH/T5TyNon0Dz/2TBNhv1WaZzVN84eIatEVtKdFIu
   o8kPgZXOFDYWZSnMmLGE5pBbqJSGCPG0vCnqh1YJIfalCwc1DDja0eUvk
   sJsxc4CHb6HyV/OVfzPCrGIdIAp9/BoAo52QwsWqjU0a5PsFcP1NPHp5F
   PGAhz77k157M9IocLA/tirQYSR9zzJDOVXdC0AMzMBf9QUE1VhfFPB02V
   mszutMkA9upjeWR2Yo+sNAvUw0dd1o24Nzv/8lisZeI/QQtcTbTZK+tD2
   wUo6EBY5s5MdBg6pUa+qtI7b7RRcxgPLlQ8NeydsSftE8/i7dxautidrH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="337051395"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="337051395"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 09:25:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="806322982"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="806322982"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 23 Mar 2023 09:25:39 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfNkr-000EWU-1v;
        Thu, 23 Mar 2023 16:25:33 +0000
Date:   Fri, 24 Mar 2023 00:24:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 db0fc80ec686774f1ca4606e752bf42af1f1cd97
Message-ID: <641c7d49.ahfaimsUA+b8ErYR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: db0fc80ec686774f1ca4606e752bf42af1f1cd97  Bluetooth: NXP: select CONFIG_CRC8

elapsed time: 948m

configs tested: 141
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r014-20230322   gcc  
alpha                randconfig-r021-20230322   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230323   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r023-20230322   gcc  
arc                  randconfig-r031-20230322   gcc  
arc                  randconfig-r043-20230322   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                        neponset_defconfig   clang
arm                  randconfig-r023-20230322   clang
arm                  randconfig-r026-20230322   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230322   clang
arm64                randconfig-r025-20230322   gcc  
arm64                randconfig-r031-20230322   clang
csky                                defconfig   gcc  
csky                 randconfig-r003-20230322   gcc  
csky                 randconfig-r024-20230322   gcc  
csky                 randconfig-r026-20230322   gcc  
hexagon      buildonly-randconfig-r006-20230323   clang
hexagon              randconfig-r003-20230322   clang
hexagon              randconfig-r004-20230322   clang
hexagon              randconfig-r011-20230322   clang
hexagon              randconfig-r015-20230322   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a014   gcc  
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r005-20230323   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r005-20230322   gcc  
ia64                 randconfig-r025-20230322   gcc  
ia64                 randconfig-r033-20230322   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r016-20230322   gcc  
loongarch            randconfig-r026-20230322   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230322   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                 randconfig-r013-20230322   gcc  
m68k                 randconfig-r015-20230322   gcc  
microblaze   buildonly-randconfig-r004-20230322   gcc  
microblaze   buildonly-randconfig-r006-20230322   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r003-20230322   gcc  
mips                 randconfig-r021-20230322   clang
mips                 randconfig-r034-20230322   gcc  
mips                           xway_defconfig   gcc  
nios2        buildonly-randconfig-r001-20230322   gcc  
nios2        buildonly-randconfig-r005-20230322   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r035-20230322   gcc  
openrisc             randconfig-r023-20230322   gcc  
openrisc             randconfig-r032-20230322   gcc  
openrisc             randconfig-r036-20230322   gcc  
parisc       buildonly-randconfig-r001-20230323   gcc  
parisc       buildonly-randconfig-r006-20230323   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r006-20230322   gcc  
parisc               randconfig-r013-20230322   gcc  
parisc               randconfig-r031-20230322   gcc  
parisc               randconfig-r036-20230322   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r003-20230322   gcc  
powerpc                      obs600_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r005-20230322   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230322   clang
riscv                randconfig-r006-20230322   clang
riscv                randconfig-r042-20230322   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r005-20230323   clang
s390                                defconfig   gcc  
s390                 randconfig-r001-20230322   clang
s390                 randconfig-r003-20230322   clang
s390                 randconfig-r022-20230322   gcc  
s390                 randconfig-r044-20230322   gcc  
sh                               allmodconfig   gcc  
sh                                  defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                   randconfig-r012-20230322   gcc  
sh                   randconfig-r016-20230322   gcc  
sh                   randconfig-r034-20230322   gcc  
sh                           se7722_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230322   gcc  
sparc64      buildonly-randconfig-r002-20230322   gcc  
sparc64              randconfig-r022-20230322   gcc  
sparc64              randconfig-r024-20230322   gcc  
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
x86_64                        randconfig-k001   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r011-20230322   gcc  
xtensa               randconfig-r015-20230322   gcc  
xtensa               randconfig-r022-20230322   gcc  
xtensa               randconfig-r024-20230322   gcc  
xtensa               randconfig-r035-20230322   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
