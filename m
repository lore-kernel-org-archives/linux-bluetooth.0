Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217D1C4708E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Dec 2022 07:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiLGH3I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Dec 2022 02:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLGH3G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Dec 2022 02:29:06 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195CE27B04
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Dec 2022 23:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670398146; x=1701934146;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=cSlQIT5FUSIAPwCsDQy/C8FNH6pA0JDlV64yCZ5mazA=;
  b=AuuOsDGuo9XmYJ3oYB0h5JyGBcQ6nPXpEQRY3cHq3e8/AqnorXWsm3xS
   /gAdhJjS3EFHxWH4qq2flFFjRvShqIxZuEZUC5EZsKb/DH6V62dPNeM1I
   iA5/AmSR164LOzb6S9aPzhcfmOXfJFZyqZC85i7R4dNmymbtBRplSvFgG
   Ojb2aaVm1On9UYvUFGqLZ39jl9OrlxcwKtXbX+t9F7B1tM2N1kFkVsbDL
   i8YEq64a53aRkwTe79ebV5C/XHEKDWPLqOhPTl0ghBEYGgN0P/59Cdc6W
   sBe4TLde9asjfwjGlBvt7l7SKa7jtigz/dtbk2efc7VaPY+CRPkfB/Wx1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="314471304"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="314471304"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 23:29:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="715092651"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="715092651"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 06 Dec 2022 23:28:58 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p2orR-00003b-2Z;
        Wed, 07 Dec 2022 07:28:57 +0000
Date:   Wed, 07 Dec 2022 15:28:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 0dff4eccb2edae2754c8a0c7444bf843bd102720
Message-ID: <63904097.pvyj1Boqsd4E7x0Y%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 0dff4eccb2edae2754c8a0c7444bf843bd102720  Bluetooth: btusb: don't call kfree_skb() under spin_lock_irqsave()

elapsed time: 726m

configs tested: 60
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
um                           x86_64_defconfig
sh                               allmodconfig
um                             i386_defconfig
mips                             allyesconfig
powerpc                          allmodconfig
s390                             allyesconfig
x86_64                          rhel-8.3-rust
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
arm                  randconfig-r046-20221206
arc                  randconfig-r043-20221206
i386                                defconfig
ia64                             allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                              defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
i386                          randconfig-a014
x86_64                           rhel-8.3-syz
i386                          randconfig-a012
x86_64                         rhel-8.3-kunit
arm                                 defconfig
m68k                             allyesconfig
i386                          randconfig-a016
m68k                             allmodconfig
x86_64                           allyesconfig
alpha                            allyesconfig
arc                              allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
arm64                            allyesconfig
arm                              allyesconfig
i386                             allyesconfig

clang tested configs:
hexagon              randconfig-r041-20221206
hexagon              randconfig-r045-20221206
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
s390                 randconfig-r044-20221206
riscv                randconfig-r042-20221206
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
i386                          randconfig-a004
i386                          randconfig-a002
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
