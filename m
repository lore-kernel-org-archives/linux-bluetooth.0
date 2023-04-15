Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E819C77B70
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Apr 2023 19:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjDOT5B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 15 Apr 2023 15:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjDOT5A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 15 Apr 2023 15:57:00 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5C73C1E
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Apr 2023 12:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681588619; x=1713124619;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=BsqcwTb29t+ecsLPdT88WnACkI0CiayqjoMbKxxbnXk=;
  b=OEHRvJIPXERLXSizdBAUOampwy4TB/nc18y7/YMZTlN+zzhV5BORYwI3
   V1OQUBpk8ZMPyDueLodthdfhReg5zn7cAjwG/MQco//1qSbf0rDSWo1JK
   KggssmrQuHkNgH/TlZLom7+I476ijRutu+uYB8Jrc58TG2f5uc+GFE5cc
   KQzRxXqV8T8uYnEqlLaZ2UEpsolaRD8ghPFY/w3BF90y1xGDlYvaU0kVN
   wGBxbv8Jc1MpnP/cSmn27kJHpuRpq3gnrdsKiuvtaqy4ppXSJ/Ue2S2Dk
   tTx/NZnFBWv1OjYTIegQRud6FpTzgoOu+Kmx/Cq0Tfh/jVKhJjqpYzdN4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10681"; a="324300844"
X-IronPort-AV: E=Sophos;i="5.99,200,1677571200"; 
   d="scan'208";a="324300844"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2023 12:56:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10681"; a="692822670"
X-IronPort-AV: E=Sophos;i="5.99,200,1677571200"; 
   d="scan'208";a="692822670"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 15 Apr 2023 12:56:57 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pnm0y-000bJH-08;
        Sat, 15 Apr 2023 19:56:52 +0000
Date:   Sun, 16 Apr 2023 03:55:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 492cf2b505d66b2bc0b50dae1d5e5921978f4802
Message-ID: <643b014c.d1fHXzJxSr/dQbPv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 492cf2b505d66b2bc0b50dae1d5e5921978f4802  Revert "Bluetooth: btsdio: fix use after free bug in btsdio_remove due to unfinished work"

elapsed time: 1324m

configs tested: 50
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                           omap1_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc                 xes_mpc85xx_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                         microdev_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                               defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
