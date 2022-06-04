Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB35C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Jun 2022 10:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbiFDKad (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 4 Jun 2022 06:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiFDKac (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 4 Jun 2022 06:30:32 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A08D36B55
        for <linux-bluetooth@vger.kernel.org>; Sat,  4 Jun 2022 03:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654338632; x=1685874632;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=V5J1kQs4YGBIiiClAaQBghITW1ZUFoafiDQMrSJt7yc=;
  b=agrOhrz+AQAmrhPEDIDdlmjySBEPmhkhdR57HEE/OushcDcoLq4+ZfjL
   bKVC4XFRJezg6emKuqM2vdONybIJr6/GHwyNZ1rKxXa1Ly5K4X9AVsayy
   S7+Vwcw9YR9rSJdkvNvd5q2ojRjUHNN+HB/7uSCnLlQ7ssPVr6PhyphMA
   Hu1FI2eeuWGD35pDIwod+7VyCWuDpEgGEViNzElITdx5JCHfoIzN1dzMV
   JAvkhqcyQsUu8jRcuSr6qMQRY1dGv7EU2ZR9wRMPCJW0Yoi/mh3NREq8h
   CBd7P8LjJWbXbt+cp+ZvaLm9AiXj8kl+0xycFElmG26sRkuV22l5gApDs
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="275220452"
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="275220452"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 03:30:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="668800870"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jun 2022 03:30:30 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxR38-000AfZ-3M;
        Sat, 04 Jun 2022 10:30:30 +0000
Date:   Sat, 04 Jun 2022 18:29:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 dba7abaead13f9dbf4e946f874127eae427d9947
Message-ID: <629b341e.n6TTMCNzdCJBCJDm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: dba7abaead13f9dbf4e946f874127eae427d9947  Bluetooth: When HCI work queue is drained, only queue chained work

elapsed time: 1117m

configs tested: 79
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
mips                             allyesconfig
nios2                               defconfig
alpha                               defconfig
m68k                             allyesconfig
xtensa                           allyesconfig
csky                                defconfig
arc                              allyesconfig
sh                               allmodconfig
alpha                            allyesconfig
arc                                 defconfig
nios2                            allyesconfig
m68k                             allmodconfig
h8300                            allyesconfig
m68k                                defconfig
mips                             allmodconfig
parisc                              defconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
parisc64                            defconfig
riscv                               defconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
um                           x86_64_defconfig
sparc                            allyesconfig
um                             i386_defconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
powerpc                          allyesconfig
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
arm64                               defconfig
ia64                             allmodconfig
arm                              allmodconfig
ia64                                defconfig
arm                              allyesconfig
ia64                             allyesconfig
arm64                            allyesconfig
arm                                 defconfig
i386                          randconfig-a001
x86_64                        randconfig-a004
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a008
i386                          randconfig-a009
i386                          randconfig-a010
i386                          randconfig-a007
x86_64                        randconfig-a006
i386                          randconfig-a012
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
i386                          randconfig-a002
x86_64                        randconfig-a009
x86_64                        randconfig-a007
i386                          randconfig-a006
x86_64                        randconfig-a010
i386                          randconfig-a011
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a008
i386                          randconfig-a004
x86_64                        randconfig-a012

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
