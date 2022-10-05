Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B937BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Oct 2022 11:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJEL6N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Oct 2022 07:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiJEL6M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Oct 2022 07:58:12 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932CF2018B
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Oct 2022 04:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664971091; x=1696507091;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=MfVvlepJy271JWI4hHT4E5SwYOyxotWVUrp3tVwsnoI=;
  b=hQ5wkAdDpNc7Sl+Xd5VoOgdYfCQW3kx/mfdHNlkXkAxvvZ+rJ2/CMgiV
   2ndhnjgWJ22VeUy+6rMOjXIr9jlvamrW7aZYaaA/MgjTZCo4U3zf0H4OH
   mxHtXeiCXjIyk8Lo6/aK431KZMGZnR3ghKAYPz5O0ua0JDP9vqf6YhB91
   z6a/yxmtTPLXXN8ZnnlkfUhtQGvLk+H1XWmRKm2p9pMwnAfwmOWfyT3gQ
   IUi8LdYzmMWdCnHJ6Tn6PNDPcpX1R8l/tMzIU5GqiFky+Yf8th3+K19MY
   yRpi2hXkrOV2kgGPZan4EvP7n65hJwblDBGlR+D5LGSdFwkgqyYBzLPjR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="367256651"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="367256651"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 04:58:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="869375654"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="869375654"
Received: from lkp-server01.sh.intel.com (HELO d4f44333118a) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 05 Oct 2022 04:58:09 -0700
Received: from kbuild by d4f44333118a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1og32P-0001ET-0c;
        Wed, 05 Oct 2022 11:58:09 +0000
Date:   Wed, 05 Oct 2022 19:58:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 89f9f3cb86b1c63badaf392a83dd661d56cc50b1
Message-ID: <633d714b.NOLGIpXHFVPPsxyP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 89f9f3cb86b1c63badaf392a83dd661d56cc50b1  Bluetooth: L2CAP: Fix use-after-free caused by l2cap_reassemble_sdu

elapsed time: 724m

configs tested: 81
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                              allyesconfig
s390                                defconfig
alpha                            allyesconfig
s390                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
m68k                             allyesconfig
m68k                             allmodconfig
s390                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a011-20221003
x86_64                              defconfig
x86_64                           rhel-8.3-syz
sh                               allmodconfig
i386                 randconfig-a016-20221003
i386                 randconfig-a012-20221003
i386                 randconfig-a014-20221003
i386                 randconfig-a015-20221003
i386                 randconfig-a013-20221003
arm                                 defconfig
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a011-20221003
i386                                defconfig
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a014-20221003
x86_64                               rhel-8.3
x86_64               randconfig-a012-20221003
x86_64               randconfig-a013-20221003
x86_64               randconfig-a015-20221003
x86_64               randconfig-a016-20221003
x86_64                           allyesconfig
i386                             allyesconfig
arm                              allyesconfig
riscv                randconfig-r042-20221003
arm64                            allyesconfig
arc                  randconfig-r043-20221003
arc                  randconfig-r043-20221002
s390                 randconfig-r044-20221003
csky                              allnoconfig
arc                               allnoconfig
alpha                             allnoconfig
riscv                             allnoconfig
ia64                             allmodconfig
powerpc                     stx_gp3_defconfig
sh                             shx3_defconfig
powerpc                    adder875_defconfig
arm                       imx_v6_v7_defconfig
mips                            ar7_defconfig
ia64                      gensparse_defconfig
m68k                                defconfig
powerpc                     taishan_defconfig
riscv                            allyesconfig
mips                        vocore2_defconfig
i386                          randconfig-c001

clang tested configs:
i386                 randconfig-a003-20221003
i386                 randconfig-a002-20221003
i386                 randconfig-a001-20221003
i386                 randconfig-a006-20221003
i386                 randconfig-a005-20221003
i386                 randconfig-a004-20221003
hexagon              randconfig-r041-20221003
hexagon              randconfig-r045-20221003
riscv                randconfig-r042-20221002
x86_64               randconfig-a003-20221003
hexagon              randconfig-r041-20221002
x86_64               randconfig-a002-20221003
s390                 randconfig-r044-20221002
x86_64               randconfig-a001-20221003
hexagon              randconfig-r045-20221002
x86_64               randconfig-a004-20221003
x86_64               randconfig-a005-20221003
x86_64               randconfig-a006-20221003
arm                        neponset_defconfig
powerpc                          allyesconfig
riscv                          rv32_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
