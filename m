Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C9AEB64DC
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jul 2023 11:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjGFLAe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jul 2023 07:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjGFLAb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jul 2023 07:00:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C381BE3
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jul 2023 04:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688641226; x=1720177226;
  h=date:from:to:cc:subject:message-id;
  bh=AQNN4fbA8zpnd/AkTKHBeUR6dySTLfcBJQV/UD2gIBU=;
  b=GNOY+0JIPxdMR5pygsBWg70aw8vRbhV8sf4K2J6LmMdfG87O8DfupGIJ
   kkZv48O0lrs32P+dFNuYyx7hYmpHIADA+mhuitHq/3N2LcO7n1QHFNAMk
   YSpx3ct5Vd0yO04I3JrZJub6SVlQc55HUUIUW/2pldnAXqolBACLYimHx
   zvzM1z5QyqAYX+lP7eQERJcUj998u0eT5VncZuNA53IcEWOjHs8DhCNbR
   yld2WqDbGjupUwppfjSKX2kWp2vVTYxDu5xDvnUcA1FSY8ik4xRZ5GxuR
   Z9KwSibWRSHr43Vwu7QYMZsi0rVuIg/pGx2wov0vGVKOxDfcWKvvaAJsi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="394328910"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="394328910"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 04:00:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="719548130"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="719548130"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 Jul 2023 04:00:23 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qHMik-0001Gd-1o;
        Thu, 06 Jul 2023 11:00:22 +0000
Date:   Thu, 06 Jul 2023 19:00:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 22d2055a576d2d6a879599193de8252e50200db8
Message-ID: <202307061907.p31byf8i-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 22d2055a576d2d6a879599193de8252e50200db8  Bluetooth: hci_sync: Don't double print name in add/remove adv_monitor

elapsed time: 720m

configs tested: 120
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230706   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                          collie_defconfig   clang
arm                                 defconfig   gcc  
arm                       imx_v4_v5_defconfig   clang
arm                            mps2_defconfig   gcc  
arm                             mxs_defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                  randconfig-r025-20230706   clang
arm                  randconfig-r046-20230706   clang
arm                           sama7_defconfig   clang
arm                          sp7021_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r026-20230706   clang
hexagon              randconfig-r041-20230706   clang
hexagon              randconfig-r045-20230706   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230706   clang
i386         buildonly-randconfig-r005-20230706   clang
i386         buildonly-randconfig-r006-20230706   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230705   gcc  
i386                 randconfig-i002-20230705   gcc  
i386                 randconfig-i003-20230705   gcc  
i386                 randconfig-i004-20230705   gcc  
i386                 randconfig-i005-20230705   gcc  
i386                 randconfig-i006-20230705   gcc  
i386                 randconfig-i011-20230706   gcc  
i386                 randconfig-i012-20230706   gcc  
i386                 randconfig-i013-20230706   gcc  
i386                 randconfig-i014-20230706   gcc  
i386                 randconfig-i015-20230706   gcc  
i386                 randconfig-i016-20230706   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230706   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230706   gcc  
m68k                 randconfig-r005-20230706   gcc  
m68k                           sun3_defconfig   gcc  
microblaze           randconfig-r003-20230706   gcc  
microblaze           randconfig-r006-20230706   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r012-20230706   clang
nios2                               defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230706   gcc  
parisc               randconfig-r032-20230705   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                   lite5200b_defconfig   clang
powerpc                     mpc5200_defconfig   clang
powerpc                      ppc64e_defconfig   clang
powerpc              randconfig-r036-20230705   gcc  
powerpc                     redwood_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r016-20230706   gcc  
riscv                randconfig-r024-20230706   gcc  
riscv                randconfig-r042-20230706   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r031-20230705   gcc  
s390                 randconfig-r044-20230706   gcc  
sh                               allmodconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                   randconfig-r021-20230706   gcc  
sh                           se7751_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230706   gcc  
sparc64              randconfig-r022-20230706   gcc  
sparc64              randconfig-r035-20230705   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230706   clang
x86_64       buildonly-randconfig-r002-20230706   clang
x86_64       buildonly-randconfig-r003-20230706   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230706   gcc  
x86_64               randconfig-x002-20230706   gcc  
x86_64               randconfig-x003-20230706   gcc  
x86_64               randconfig-x004-20230706   gcc  
x86_64               randconfig-x005-20230706   gcc  
x86_64               randconfig-x006-20230706   gcc  
x86_64               randconfig-x011-20230706   clang
x86_64               randconfig-x012-20230706   clang
x86_64               randconfig-x013-20230706   clang
x86_64               randconfig-x014-20230706   clang
x86_64               randconfig-x015-20230706   clang
x86_64               randconfig-x016-20230706   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa               randconfig-r034-20230705   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
