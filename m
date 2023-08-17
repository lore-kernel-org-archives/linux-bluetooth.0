Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5E8C27C7A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Aug 2023 11:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350111AbjHQLNx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Aug 2023 07:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350190AbjHQLNs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Aug 2023 07:13:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EC8210D
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 04:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692270827; x=1723806827;
  h=date:from:to:cc:subject:message-id;
  bh=beWrw9+9TEaZvvF8TjVpTLW17P7kSZo4Ipszyi+Oac4=;
  b=jBrjZrcta8IKd99ToZevKz0sSEdWGZzoBqT0HXQRLxhHsTbMSWf1gWoF
   j24nNGtWu/wo2tUxEnn/H1mxbECVTUFTFLFkBoZ3kqmwDYYcqbYhFOeQh
   Ll64H+0q0bSXvjgynUeA7bnt+ClsC/iVxy2HXP4bOud1AU8oCTqGzgq/j
   n2Z5ezMwnC1HM6mezbr3wIUKvNZ0gtGx/GWKt4wQUEjEsaX6ok4Xq3XdF
   hJfkv57PDb9jVLw38f3LcYxoSkgCAdBJLDA7HkpLJjhQyZURMaSuiEJGH
   ERpWdFs6/tF4s4juBl1MwS0N3KrWWK4qfV9jb0hMrsBmHoF0+ZSIuco2A
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403761724"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="403761724"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 04:13:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="878188675"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 17 Aug 2023 04:13:49 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWawi-00014X-2q;
        Thu, 17 Aug 2023 11:13:44 +0000
Date:   Thu, 17 Aug 2023 19:12:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 ef6d9b23aa589073cff4371135d017724728ae9f
Message-ID: <202308171945.WjHPH9IX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: ef6d9b23aa589073cff4371135d017724728ae9f  Bluetooth: qca: add support for WCN7850

elapsed time: 731m

configs tested: 106
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r006-20230817   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r011-20230817   gcc  
arc                  randconfig-r022-20230817   gcc  
arc                  randconfig-r043-20230817   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r014-20230817   clang
arm                  randconfig-r046-20230817   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r005-20230817   gcc  
csky                 randconfig-r033-20230817   gcc  
hexagon              randconfig-r032-20230817   clang
hexagon              randconfig-r041-20230817   clang
hexagon              randconfig-r045-20230817   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230817   clang
i386         buildonly-randconfig-r005-20230817   clang
i386         buildonly-randconfig-r006-20230817   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230817   clang
i386                 randconfig-i002-20230817   clang
i386                 randconfig-i003-20230817   clang
i386                 randconfig-i004-20230817   clang
i386                 randconfig-i005-20230817   clang
i386                 randconfig-i006-20230817   clang
i386                 randconfig-i011-20230817   gcc  
i386                 randconfig-i012-20230817   gcc  
i386                 randconfig-i013-20230817   gcc  
i386                 randconfig-i014-20230817   gcc  
i386                 randconfig-i015-20230817   gcc  
i386                 randconfig-i016-20230817   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r013-20230817   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r021-20230817   gcc  
m68k                 randconfig-r031-20230817   gcc  
m68k                 randconfig-r036-20230817   gcc  
microblaze           randconfig-r001-20230817   gcc  
microblaze           randconfig-r012-20230817   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r026-20230817   clang
nios2                               defconfig   gcc  
openrisc             randconfig-r004-20230817   gcc  
openrisc             randconfig-r016-20230817   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r034-20230817   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r023-20230817   gcc  
riscv                randconfig-r042-20230817   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230817   gcc  
sh                               allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230817   gcc  
sparc                randconfig-r024-20230817   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230817   clang
x86_64       buildonly-randconfig-r002-20230817   clang
x86_64       buildonly-randconfig-r003-20230817   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r003-20230817   clang
x86_64               randconfig-x001-20230817   gcc  
x86_64               randconfig-x002-20230817   gcc  
x86_64               randconfig-x003-20230817   gcc  
x86_64               randconfig-x004-20230817   gcc  
x86_64               randconfig-x005-20230817   gcc  
x86_64               randconfig-x006-20230817   gcc  
x86_64               randconfig-x011-20230817   clang
x86_64               randconfig-x012-20230817   clang
x86_64               randconfig-x013-20230817   clang
x86_64               randconfig-x014-20230817   clang
x86_64               randconfig-x015-20230817   clang
x86_64               randconfig-x016-20230817   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
