Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6063BC6370A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Dec 2022 14:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiLHO1L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Dec 2022 09:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiLHO0I (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Dec 2022 09:26:08 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2708243AD7
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Dec 2022 06:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670509558; x=1702045558;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=W/71Z1pes46QShrM57JqxjHqqEVJVBsNcvNEyNCCEZk=;
  b=MT+GvApmHl9bbI4XRpyxUSgdrdNfiC07mC88e5vZt1vWppP2ZX/0QBSq
   28MKmNPiI+XkmOh1F9m5CEbuPD3Alb8jZRPTYvHc80XKbyWZQvcXWQCus
   mfwxSBKCfm/PdpzjLXvZUfgXya7ygFeahgVb/KZk1mObIdTa5q8kqD5Yh
   n86cbGAQ8fpD1RpHuzf/R/ECWHFfTAFva1tms4g/Qv795LpNWjlKxGd1o
   KqwIiM1pp0VvbEVyN7Ahw9x1dsDEoMTyB/GHalkAdgJQx4vtXHN57MuRj
   cRtjsB5EZFZo/4Pb7pvn9BuO9u5BXum2xW4LpGzVVJdFUuknVBYTngwqv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="297537119"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="297537119"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 06:25:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="679546587"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="679546587"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Dec 2022 06:25:46 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p3HqL-0001Bw-1i;
        Thu, 08 Dec 2022 14:25:45 +0000
Date:   Thu, 08 Dec 2022 22:25:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 894e4bc8d8074eafacc9df90730f9eb164441299
Message-ID: <6391f3d5.2ZHcKFdpk2Cdnwmt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 894e4bc8d8074eafacc9df90730f9eb164441299  Bluetooth: RFCOMM: don't call kfree_skb() under spin_lock_irqsave()

elapsed time: 720m

configs tested: 66
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
um                             i386_defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
alpha                            allyesconfig
x86_64                           rhel-8.3-kvm
arc                              allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                               rhel-8.3
x86_64                        randconfig-a015
x86_64                              defconfig
arc                  randconfig-r043-20221207
x86_64                          rhel-8.3-rust
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                                defconfig
riscv                randconfig-r042-20221207
s390                 randconfig-r044-20221207
i386                          randconfig-a014
x86_64                           allyesconfig
ia64                             allmodconfig
i386                          randconfig-a012
i386                          randconfig-a016
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                             allyesconfig
x86_64                            allnoconfig
i386                          randconfig-c001

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
arm                  randconfig-r046-20221207
hexagon              randconfig-r041-20221207
hexagon              randconfig-r045-20221207
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-k001
arm                           omap1_defconfig
powerpc                    ge_imp3a_defconfig
arm                         socfpga_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
