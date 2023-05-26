Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4107C7EE29
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 May 2023 00:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjEZAQI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 May 2023 20:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjEZAQG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 May 2023 20:16:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237B8194
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 May 2023 17:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685060165; x=1716596165;
  h=date:from:to:cc:subject:message-id;
  bh=Gz8ADW91hgHr9a6X/w6Z8xFo3z7zuIVARp33iqErh3I=;
  b=FtsBoUTl0CI4qLufc43vOz/kB12XZhmTjxtBwo7ciTyTIe9XWS5Yub9n
   me0f9mGB2LjOeGfzQZHTS5ubHWJcz6LBuKcHzTE9v5PDb4eMvURtQ3FT+
   /T0Xlxii7kmTf4WkOinp8lsV1TSusBw9QAK8rsE32NzPBZIO87GZlpZV1
   UbEDYBiHnhOBpmYvQC9QH80z+qWqLveGHpmFgeVre0LHre/5A3f4i8rT4
   8D5r/xOlHpuIwWoMfnAfyoOBj3sbmcrDyvM7Q2wy4h3cHDM902nbJqDhQ
   lNR4/ctQEVlgie+7s1X47jJadwMNbGVlBfy6EnTCPUBhPhOgYL3Pn6upY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="382310654"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="382310654"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 17:16:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="682528894"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="682528894"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 25 May 2023 17:16:03 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q2L7i-000G9p-1s;
        Fri, 26 May 2023 00:16:02 +0000
Date:   Fri, 26 May 2023 08:16:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 b7e415f145f7675fe2533776fd97de66dbe518f6
Message-ID: <20230526001601.X27ij%lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: b7e415f145f7675fe2533776fd97de66dbe518f6  Bluetooth: Fix use-after-free in hci_remove_ltk/hci_remove_irk

elapsed time: 1332m

configs tested: 248
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r015-20230524   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r043-20230524   gcc  
arc                  randconfig-r043-20230525   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g4_defconfig   clang
arm                                 defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                  randconfig-r005-20230524   clang
arm                  randconfig-r021-20230525   clang
arm                  randconfig-r025-20230524   gcc  
arm                  randconfig-r031-20230524   clang
arm                  randconfig-r046-20230524   gcc  
arm                           sama5_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r023-20230524   clang
csky         buildonly-randconfig-r006-20230524   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230525   gcc  
hexagon              randconfig-r022-20230525   clang
hexagon              randconfig-r034-20230524   clang
hexagon              randconfig-r041-20230524   clang
hexagon              randconfig-r045-20230524   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r006-20230525   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230524   gcc  
i386                 randconfig-i001-20230525   clang
i386                 randconfig-i002-20230524   gcc  
i386                 randconfig-i002-20230525   clang
i386                 randconfig-i003-20230524   gcc  
i386                 randconfig-i003-20230525   clang
i386                 randconfig-i004-20230524   gcc  
i386                 randconfig-i004-20230525   clang
i386                 randconfig-i005-20230524   gcc  
i386                 randconfig-i005-20230525   clang
i386                 randconfig-i006-20230524   gcc  
i386                 randconfig-i006-20230525   clang
i386                 randconfig-i011-20230524   clang
i386                 randconfig-i011-20230525   gcc  
i386                 randconfig-i012-20230524   clang
i386                 randconfig-i012-20230525   gcc  
i386                 randconfig-i013-20230524   clang
i386                 randconfig-i013-20230525   gcc  
i386                 randconfig-i014-20230524   clang
i386                 randconfig-i014-20230525   gcc  
i386                 randconfig-i015-20230524   clang
i386                 randconfig-i015-20230525   gcc  
i386                 randconfig-i016-20230524   clang
i386                 randconfig-i016-20230525   gcc  
i386                 randconfig-i051-20230524   gcc  
i386                 randconfig-i051-20230525   clang
i386                 randconfig-i052-20230524   gcc  
i386                 randconfig-i052-20230525   clang
i386                 randconfig-i053-20230524   gcc  
i386                 randconfig-i053-20230525   clang
i386                 randconfig-i054-20230524   gcc  
i386                 randconfig-i054-20230525   clang
i386                 randconfig-i055-20230525   clang
i386                 randconfig-i056-20230525   clang
i386                 randconfig-i061-20230524   gcc  
i386                 randconfig-i061-20230525   clang
i386                 randconfig-i062-20230524   gcc  
i386                 randconfig-i062-20230525   clang
i386                 randconfig-i063-20230524   gcc  
i386                 randconfig-i063-20230525   clang
i386                 randconfig-i064-20230524   gcc  
i386                 randconfig-i064-20230525   clang
i386                 randconfig-i065-20230524   gcc  
i386                 randconfig-i065-20230525   clang
i386                 randconfig-i066-20230524   gcc  
i386                 randconfig-i066-20230525   clang
i386                 randconfig-i071-20230524   clang
i386                 randconfig-i071-20230525   gcc  
i386                 randconfig-i072-20230524   clang
i386                 randconfig-i072-20230525   gcc  
i386                 randconfig-i073-20230524   clang
i386                 randconfig-i073-20230525   gcc  
i386                 randconfig-i074-20230524   clang
i386                 randconfig-i074-20230525   gcc  
i386                 randconfig-i075-20230524   clang
i386                 randconfig-i075-20230525   gcc  
i386                 randconfig-i076-20230524   clang
i386                 randconfig-i076-20230525   gcc  
i386                 randconfig-i081-20230524   clang
i386                 randconfig-i081-20230525   gcc  
i386                 randconfig-i082-20230524   clang
i386                 randconfig-i082-20230525   gcc  
i386                 randconfig-i083-20230524   clang
i386                 randconfig-i083-20230525   gcc  
i386                 randconfig-i084-20230524   clang
i386                 randconfig-i084-20230525   gcc  
i386                 randconfig-i085-20230524   clang
i386                 randconfig-i085-20230525   gcc  
i386                 randconfig-i086-20230524   clang
i386                 randconfig-i086-20230525   gcc  
i386                 randconfig-i091-20230524   gcc  
i386                 randconfig-i091-20230525   clang
i386                 randconfig-i092-20230524   gcc  
i386                 randconfig-i092-20230525   clang
i386                 randconfig-i093-20230524   gcc  
i386                 randconfig-i093-20230525   clang
i386                 randconfig-i094-20230524   gcc  
i386                 randconfig-i094-20230525   clang
i386                 randconfig-i095-20230524   gcc  
i386                 randconfig-i095-20230525   clang
i386                 randconfig-i096-20230524   gcc  
i386                 randconfig-i096-20230525   clang
ia64         buildonly-randconfig-r001-20230524   gcc  
ia64                 randconfig-r014-20230524   gcc  
ia64                 randconfig-r021-20230524   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r013-20230525   gcc  
loongarch            randconfig-r024-20230524   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                 randconfig-r002-20230524   gcc  
m68k                 randconfig-r004-20230525   gcc  
m68k                 randconfig-r035-20230524   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r003-20230524   clang
mips                     cu1830-neo_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230525   gcc  
nios2                randconfig-r032-20230524   gcc  
openrisc             randconfig-r003-20230524   gcc  
parisc       buildonly-randconfig-r004-20230524   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230524   gcc  
parisc               randconfig-r004-20230524   gcc  
parisc               randconfig-r005-20230525   gcc  
parisc               randconfig-r006-20230524   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc              randconfig-r022-20230524   clang
powerpc              randconfig-r033-20230525   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r013-20230524   clang
riscv                randconfig-r042-20230524   clang
riscv                randconfig-r042-20230525   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230524   clang
s390                                defconfig   gcc  
s390                 randconfig-r044-20230524   clang
s390                 randconfig-r044-20230525   gcc  
sh                               allmodconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                   randconfig-r033-20230524   gcc  
sparc        buildonly-randconfig-r005-20230524   gcc  
sparc                               defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230525   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230524   gcc  
x86_64               randconfig-a001-20230525   clang
x86_64               randconfig-a002-20230524   gcc  
x86_64               randconfig-a003-20230524   gcc  
x86_64               randconfig-a003-20230525   clang
x86_64               randconfig-a004-20230524   gcc  
x86_64               randconfig-a004-20230525   clang
x86_64               randconfig-a005-20230524   gcc  
x86_64               randconfig-a005-20230525   clang
x86_64               randconfig-a006-20230524   gcc  
x86_64               randconfig-a006-20230525   clang
x86_64               randconfig-a011-20230525   gcc  
x86_64               randconfig-a012-20230525   gcc  
x86_64               randconfig-a013-20230525   gcc  
x86_64               randconfig-a014-20230525   gcc  
x86_64               randconfig-a015-20230525   gcc  
x86_64               randconfig-a016-20230525   gcc  
x86_64               randconfig-r011-20230524   clang
x86_64               randconfig-r012-20230524   clang
x86_64               randconfig-r015-20230525   gcc  
x86_64               randconfig-r034-20230525   clang
x86_64               randconfig-x051-20230525   gcc  
x86_64               randconfig-x052-20230525   gcc  
x86_64               randconfig-x053-20230525   gcc  
x86_64               randconfig-x054-20230525   gcc  
x86_64               randconfig-x055-20230525   gcc  
x86_64               randconfig-x056-20230525   gcc  
x86_64               randconfig-x061-20230524   clang
x86_64               randconfig-x061-20230525   gcc  
x86_64               randconfig-x062-20230524   clang
x86_64               randconfig-x062-20230525   gcc  
x86_64               randconfig-x063-20230524   clang
x86_64               randconfig-x063-20230525   gcc  
x86_64               randconfig-x064-20230524   clang
x86_64               randconfig-x064-20230525   gcc  
x86_64               randconfig-x065-20230524   clang
x86_64               randconfig-x065-20230525   gcc  
x86_64               randconfig-x066-20230524   clang
x86_64               randconfig-x066-20230525   gcc  
x86_64               randconfig-x071-20230524   gcc  
x86_64               randconfig-x071-20230525   clang
x86_64               randconfig-x072-20230524   gcc  
x86_64               randconfig-x073-20230524   gcc  
x86_64               randconfig-x073-20230525   clang
x86_64               randconfig-x074-20230524   gcc  
x86_64               randconfig-x074-20230525   clang
x86_64               randconfig-x075-20230524   gcc  
x86_64               randconfig-x075-20230525   clang
x86_64               randconfig-x076-20230524   gcc  
x86_64               randconfig-x081-20230524   gcc  
x86_64               randconfig-x081-20230525   clang
x86_64               randconfig-x082-20230524   gcc  
x86_64               randconfig-x082-20230525   clang
x86_64               randconfig-x083-20230524   gcc  
x86_64               randconfig-x083-20230525   clang
x86_64               randconfig-x084-20230524   gcc  
x86_64               randconfig-x084-20230525   clang
x86_64               randconfig-x085-20230524   gcc  
x86_64               randconfig-x085-20230525   clang
x86_64               randconfig-x086-20230524   gcc  
x86_64               randconfig-x086-20230525   clang
x86_64               randconfig-x091-20230525   gcc  
x86_64               randconfig-x092-20230525   gcc  
x86_64               randconfig-x093-20230525   gcc  
x86_64               randconfig-x094-20230525   gcc  
x86_64               randconfig-x095-20230525   gcc  
x86_64               randconfig-x096-20230525   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r012-20230525   gcc  
xtensa               randconfig-r014-20230525   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
