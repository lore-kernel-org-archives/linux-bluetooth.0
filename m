Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57ECC28B2B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Aug 2022 12:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244473AbiHRMCy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Aug 2022 08:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244216AbiHRMCx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Aug 2022 08:02:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5409D43E5C;
        Thu, 18 Aug 2022 05:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660824172; x=1692360172;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=6twQQ5L7960+uNl0KcmdGE2Ed2A3YzdgfJUxFWVxd6s=;
  b=N9gwZXKgn0AvKzVz9JiDMtmUWej0UxHn4bg46qJYo6YEKNr3MZjn8Nbp
   +hHI95ko9NCxwdrgvCMFGMG44Wz1MHtEv4aOZML/xRYnS3MEbzqj5w1rC
   GDcHCIjYUp6HW6GGDATgpOj1Dk/u896zPTTSDt1jmL6NETJfqnyWSuJYr
   S7C15yE27omVby6SENTfVHkCEZBIG8b/lcdBaqpA2cAKcz3WPmRAKk88R
   bOYTqmcN3xRAeCg/T5/ts94QfXKl+ffWc1nBouPpMkRofqBF+R5zJuomm
   YTRknTEFbOvjYqRkrpkNsTSUEjN/3CszFq3NOk+7Pg0Uh45kxshlO2yzW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="272506615"
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="272506615"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 05:02:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="558503024"
Received: from lkp-server01.sh.intel.com (HELO 6cc724e23301) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Aug 2022 05:02:46 -0700
Received: from kbuild by 6cc724e23301 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOeEX-0000Td-1a;
        Thu, 18 Aug 2022 12:02:45 +0000
Date:   Thu, 18 Aug 2022 20:02:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-hardening@vger.kernel.org,
        linux-bluetooth@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:pending-fixes] BUILD SUCCESS WITH WARNING
 bb8b9a4857726b532eaaa9d31c8acfb451227fbf
Message-ID: <62fe2a52.MDlOyFV1+MFSyOaw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git pending-fixes
branch HEAD: bb8b9a4857726b532eaaa9d31c8acfb451227fbf  Merge branch 'for-linux-next-fixes' of git://anongit.freedesktop.org/drm/drm-misc

Warning reports:

https://lore.kernel.org/linux-mm/202208110453.zEneXTnn-lkp@intel.com

Warning: (recently discovered and may have been fixed)

arch/m68k/include/asm/string.h:64:25: warning: '__builtin_memcmp' specified bound 6 exceeds source size 0 [-Wstringop-overread]
include/linux/fortify-string.h:44:33: warning: '__builtin_memcmp' specified bound 6 exceeds source size 0 [-Wstringop-overread]
include/net/bluetooth/bluetooth.h:347:16: warning: 'memcmp' specified bound 6 exceeds source size 0 [-Wstringop-overread]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- m68k-allmodconfig
|   `-- arch-m68k-include-asm-string.h:warning:__builtin_memcmp-specified-bound-exceeds-source-size
|-- m68k-allyesconfig
|   `-- arch-m68k-include-asm-string.h:warning:__builtin_memcmp-specified-bound-exceeds-source-size
|-- m68k-randconfig-r031-20220818
|   `-- arch-m68k-include-asm-string.h:warning:__builtin_memcmp-specified-bound-exceeds-source-size
|-- mips-allyesconfig
|   `-- include-linux-fortify-string.h:warning:__builtin_memcmp-specified-bound-exceeds-source-size
`-- openrisc-randconfig-r013-20220818
    `-- include-net-bluetooth-bluetooth.h:warning:memcmp-specified-bound-exceeds-source-size

elapsed time: 722m

configs tested: 58
configs skipped: 2

gcc tested configs:
x86_64                        randconfig-a004
arc                              allyesconfig
x86_64                        randconfig-a002
i386                                defconfig
arm                                 defconfig
alpha                            allyesconfig
um                           x86_64_defconfig
x86_64                              defconfig
m68k                             allyesconfig
um                             i386_defconfig
m68k                             allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arm                              allyesconfig
x86_64                               rhel-8.3
arm64                            allyesconfig
x86_64                        randconfig-a015
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
arc                  randconfig-r043-20220818
i386                          randconfig-a005
x86_64                           rhel-8.3-syz
i386                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           allyesconfig
s390                 randconfig-r044-20220818
powerpc                           allnoconfig
powerpc                          allmodconfig
riscv                randconfig-r042-20220818
mips                             allyesconfig
i386                          randconfig-a014
sh                               allmodconfig
i386                          randconfig-a012
i386                          randconfig-a016
ia64                             allmodconfig
arc                               allnoconfig
alpha                             allnoconfig
csky                              allnoconfig
riscv                             allnoconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r041-20220818
hexagon              randconfig-r045-20220818
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
