Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E4AC28B2B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Aug 2022 12:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbiHQM5X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Aug 2022 08:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbiHQM5W (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Aug 2022 08:57:22 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AE14BD0F;
        Wed, 17 Aug 2022 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660741041; x=1692277041;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=gGvQk8xFeEmpv0nXW5obr1EDDK798Me5zo7icMHQssw=;
  b=c9/lC2x79u+k9TexzRBZ1TghD36dvuQ8si+mXG59ZmimNRm8DFspwCIW
   S0zw7I1YbgY/v4gHU2HxJM8VgjRe8SxHc2C/2u7HYJS5ZshURoz6Lpq/z
   AT/Ald2Y4+a3/lPLyyzGPm7lG4ubztRRmklVdM+KP1XaIbwkDf4Eo3l9a
   CQt69hpR++GyatV4epPeuBGFRmBikNPFUQ71SqqsqWI60E1PD8GXfp0pB
   HxVTneCPgS4eHB2xKzmQ0K788PrVCTyyYotFyV8W0JhVDyKVYcy/5jwmB
   I+uEkrRMFsBmXYq1G9uLua73TA+ErIEGsWgPuB1KELUp/RsV5LyI6hrVg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="290054299"
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="290054299"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 05:57:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="558115505"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 17 Aug 2022 05:57:19 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOIbm-0000vo-28;
        Wed, 17 Aug 2022 12:57:18 +0000
Date:   Wed, 17 Aug 2022 20:56:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-hardening@vger.kernel.org,
        linux-bluetooth@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:pending-fixes] BUILD SUCCESS WITH WARNING
 5ca89432fef1fe21d205e71455a40b6b97459a12
Message-ID: <62fce58c.9A5vnRh+2zBuRSbk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git pending-fixes
branch HEAD: 5ca89432fef1fe21d205e71455a40b6b97459a12  Merge branch 'for-linux-next-fixes' of git://anongit.freedesktop.org/drm/drm-misc

Warning reports:

https://lore.kernel.org/linux-mm/202208110453.zEneXTnn-lkp@intel.com

Warning: (recently discovered and may have been fixed)

arch/m68k/include/asm/string.h:64:25: warning: '__builtin_memcmp' specified bound 6 exceeds source size 0 [-Wstringop-overread]
include/linux/fortify-string.h:44:33: warning: '__builtin_memcmp' specified bound 6 exceeds source size 0 [-Wstringop-overread]
include/net/bluetooth/bluetooth.h:347:16: warning: 'memcmp' specified bound 6 exceeds source size 0 [-Wstringop-overread]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- m68k-allyesconfig
|   `-- arch-m68k-include-asm-string.h:warning:__builtin_memcmp-specified-bound-exceeds-source-size
|-- m68k-randconfig-r003-20220816
|   `-- arch-m68k-include-asm-string.h:warning:__builtin_memcmp-specified-bound-exceeds-source-size
|-- mips-allyesconfig
|   `-- include-linux-fortify-string.h:warning:__builtin_memcmp-specified-bound-exceeds-source-size
`-- openrisc-randconfig-r021-20220815
    `-- include-net-bluetooth-bluetooth.h:warning:memcmp-specified-bound-exceeds-source-size

elapsed time: 803m

configs tested: 59
configs skipped: 2

gcc tested configs:
arc                  randconfig-r043-20220815
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
i386                 randconfig-a003-20220815
arm                                 defconfig
i386                                defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a001-20220815
arc                              allyesconfig
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a002-20220815
x86_64               randconfig-a003-20220815
i386                 randconfig-a001-20220815
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           allyesconfig
x86_64               randconfig-a002-20220815
alpha                            allyesconfig
i386                 randconfig-a004-20220815
m68k                             allyesconfig
i386                 randconfig-a006-20220815
x86_64               randconfig-a006-20220815
x86_64               randconfig-a005-20220815
arm64                            allyesconfig
i386                 randconfig-a005-20220815
x86_64               randconfig-a004-20220815
arm                              allyesconfig
mips                             allyesconfig
i386                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig
ia64                             allmodconfig
csky                              allnoconfig
arc                               allnoconfig
alpha                             allnoconfig
riscv                             allnoconfig
i386                 randconfig-c001-20220815
m68k                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220815
hexagon              randconfig-r045-20220815
riscv                randconfig-r042-20220815
s390                 randconfig-r044-20220815
x86_64               randconfig-a013-20220815
x86_64               randconfig-a012-20220815
x86_64               randconfig-a011-20220815
x86_64               randconfig-a015-20220815
x86_64               randconfig-a014-20220815
x86_64               randconfig-a016-20220815
i386                 randconfig-a012-20220815
i386                 randconfig-a011-20220815
i386                 randconfig-a013-20220815
i386                 randconfig-a014-20220815
i386                 randconfig-a015-20220815
i386                 randconfig-a016-20220815
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
