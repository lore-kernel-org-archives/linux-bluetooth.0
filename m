Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE05DC77B7A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 May 2023 14:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbjEaOHz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 May 2023 10:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbjEaOHk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 May 2023 10:07:40 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774B9E55
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 May 2023 07:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685541788; x=1717077788;
  h=date:from:to:cc:subject:message-id;
  bh=Q3jKy/mu0l1VX+yTKPMGvvGVtkoeV0UYYJ8aA7WNXeg=;
  b=JpYFIk6oiORANwg/8rTQb5vo+FXZKweNme/lA4kRHu/58CpxOkTN0g9x
   5Q5C89Uc8FKWnxcxClAwVVIuQBlhyfGWWjUmOOV6hQrDbNmb26YSiBJbB
   KHq2053DbR41J3solegZSDG1su0gd3KUTRjqGH6GI+W6yXKfDuQxtLxSg
   K6kpdzVHLQTu048NR7HLBIXUPBZLWT0W76nNJb0XoRjGlIIn5mzAId/lM
   6IuFtd1kgAZT4E49MS3wdAhz2O+GQaQJqYySNC+7A0iXLHtA5YbsWsJEE
   DeOsLSaKlRseGpG9KBjLMyc/Zgad4X03xApQHwiYN4ab5CT4daE3c/NPC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="357631006"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="357631006"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 06:56:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="819310994"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="819310994"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 31 May 2023 06:56:25 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4MJN-0001Nh-0R;
        Wed, 31 May 2023 13:56:25 +0000
Date:   Wed, 31 May 2023 21:56:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 533e9a458c7425809b4b92f09f8311dd5887f063
Message-ID: <20230531135601.BAe2v%lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 533e9a458c7425809b4b92f09f8311dd5887f063  Bluetooth: ISO: Add support for connecting multiple BISes

elapsed time: 1037m

configs tested: 64
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r034-20230531   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230531   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230531   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r036-20230531   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r006-20230531   clang
hexagon              randconfig-r022-20230531   clang
hexagon              randconfig-r041-20230531   clang
hexagon              randconfig-r045-20230531   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r023-20230531   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r026-20230531   gcc  
openrisc             randconfig-r005-20230531   gcc  
openrisc             randconfig-r035-20230531   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230531   gcc  
parisc               randconfig-r015-20230531   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r003-20230531   gcc  
powerpc              randconfig-r025-20230531   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230531   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230531   gcc  
s390                 randconfig-r031-20230531   gcc  
s390                 randconfig-r044-20230531   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r012-20230531   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230531   gcc  
sparc64              randconfig-r014-20230531   gcc  
sparc64              randconfig-r033-20230531   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
