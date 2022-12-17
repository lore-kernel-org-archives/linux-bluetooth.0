Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB57C4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Dec 2022 10:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiLQKtC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Dec 2022 05:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiLQKs7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Dec 2022 05:48:59 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9A810076
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Dec 2022 02:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671274137; x=1702810137;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1zIE2W7WQRbKFOScp9o0l8w7ZU2pecxaPE8gwLCkkkQ=;
  b=cHNK2goyu8rZRNzVLKadCBJ4tut+8WfOST67J+8NCbttXbvQ2HuiET2n
   0zYwZ4/6nCgmrAmxqn+uB7UqtOoZJhlNRSHUs2IMj4TKgo0ltJG989mBZ
   5DDDwJYXrDwTYtz+NXdYZmKw82QJ1/WhL8NX1UNexN///+u21Gg7IU657
   GWDoHQ0VbxDUS08udIkNpMNJg5Zp3QTk+mWt/nfk/OD+PF0YAd6XpneAY
   6xZ7HmbE/W7gnX6JyoClge+ejmusBOmrgZmh2gn5CEchfcOOoNcX2iNrB
   qgap1OgbrXLQ2LRPUyk+cUDe9cBctt33c8qwgLGf8abAmdayru1oX15l4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="320296595"
X-IronPort-AV: E=Sophos;i="5.96,252,1665471600"; 
   d="scan'208";a="320296595"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2022 02:48:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="895538135"
X-IronPort-AV: E=Sophos;i="5.96,252,1665471600"; 
   d="scan'208";a="895538135"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 17 Dec 2022 02:48:56 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p6UkR-0007jA-1H;
        Sat, 17 Dec 2022 10:48:55 +0000
Date:   Sat, 17 Dec 2022 18:48:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 0bb039f39058f4b60bf791e36f13f0552728cd70
Message-ID: <639d9e72.PFOuelKpRBIlAx70%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 0bb039f39058f4b60bf791e36f13f0552728cd70  Bluetooth: Fix issue with Actions Semi ATS2851 based devices

elapsed time: 723m

configs tested: 57
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a013
x86_64                        randconfig-a011
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                        randconfig-a015
i386                          randconfig-a005
i386                                defconfig
arm                                 defconfig
x86_64                        randconfig-a002
x86_64                              defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
arm                              allyesconfig
i386                          randconfig-a014
ia64                             allmodconfig
x86_64                    rhel-8.3-kselftests
arm64                            allyesconfig
riscv                randconfig-r042-20221216
x86_64                               rhel-8.3
x86_64                           rhel-8.3-bpf
i386                          randconfig-a012
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
arc                  randconfig-r043-20221216
i386                          randconfig-a016
i386                             allyesconfig
x86_64                         rhel-8.3-kunit
s390                 randconfig-r044-20221216
x86_64                           rhel-8.3-kvm
x86_64                           allyesconfig
powerpc                           allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                            allnoconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a006
x86_64                        randconfig-a005
arm                  randconfig-r046-20221216
i386                          randconfig-a013
hexagon              randconfig-r041-20221216
x86_64                          rhel-8.3-rust
i386                          randconfig-a011
hexagon              randconfig-r045-20221216
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
