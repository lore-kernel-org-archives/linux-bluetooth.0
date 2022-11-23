Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C58C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Nov 2022 03:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbiKWDR6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Nov 2022 22:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbiKWDRx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Nov 2022 22:17:53 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE66CCE1A
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 19:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669173471; x=1700709471;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=fcSiowrySn1j4AVw4Eoxb9/JM4TURztw223DJcP8XMc=;
  b=m4JMM1wESA1V+uxRuiPfalcaCaEt9n7DdHrnG7zbDJyRFYrEwvaPB6XS
   8tLGhkeDujqHiizZTQbvmjHK+NeoCvI3dE61aluQlmhyjBoByjIBAP7Tx
   7Wtns19MKw5Lr+/0FmaP90Q3lZtNPzbSmbcjc2eJcv8KVaT4QKUFfz18H
   09YGdwkZ+/F7iE76fl7HqikN/H5bnh8mSpxdfYACixf0r98+72xNd7m7h
   Zlng8NO2ts5wHFNMWEWNa3+WbDCRr0CN5wRcpedSpxoTWluFJ4oNOpmC+
   MCZ3VU4QBqyvjvCbyVSEe6gSq29GCKgACQWMmnSRGl2jC3mdcA5qtUACw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="315790917"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="315790917"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 19:17:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="672712240"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="672712240"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 22 Nov 2022 19:17:47 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oxgGg-0002AE-29;
        Wed, 23 Nov 2022 03:17:46 +0000
Date:   Wed, 23 Nov 2022 11:17:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 f492d22c0e7fb242ff68b61ea86b78ff1f031e59
Message-ID: <637d90c8.tSvOos8uJMsoveeA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: f492d22c0e7fb242ff68b61ea86b78ff1f031e59  dt-bindings: bluetooth: broadcom: add BCM43430A0 & BCM43430A1

elapsed time: 1528m

configs tested: 52
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                           x86_64_defconfig
um                             i386_defconfig
s390                                defconfig
s390                             allmodconfig
powerpc                           allnoconfig
s390                             allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
ia64                             allmodconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                              defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                           allyesconfig
arc                  randconfig-r043-20221121
riscv                randconfig-r042-20221121
s390                 randconfig-r044-20221121
i386                                defconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
m68k                             allyesconfig
i386                             allyesconfig
x86_64               randconfig-a012-20221121
x86_64               randconfig-a011-20221121
x86_64               randconfig-a013-20221121
x86_64               randconfig-a015-20221121
x86_64               randconfig-a016-20221121
x86_64               randconfig-a014-20221121
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20221121
hexagon              randconfig-r045-20221121
x86_64               randconfig-a004-20221121
x86_64               randconfig-a001-20221121
x86_64               randconfig-a003-20221121
x86_64               randconfig-a002-20221121
x86_64               randconfig-a005-20221121
x86_64               randconfig-a006-20221121

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
