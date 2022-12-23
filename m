Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5470CC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Dec 2022 12:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbiLWMyR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Dec 2022 07:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLWMyP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Dec 2022 07:54:15 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F9A1E722
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Dec 2022 04:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671800054; x=1703336054;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=6FFnF6avXI+qREBLvmZYujuVkfY2Hw1J4UOZtoZav2o=;
  b=e74/3em8DkOZB9sRHqDjQCIpwrRtWoWao0kjNqux9UE1xup4kcp6WDU+
   Ni71p+kEJ7m80rs3ILOQqtVv1aNbDIpYZNkKrVSIepXHO8HegsBP+BLTg
   a1uc5smcmu52G5qPhxAqp3eG0TrHFOTr1JoW3W+uJS8s3qCSvK6ZaA6fX
   oAJ9p0SYEbG8Tr5hghzGcCBFZ4bGAZYugSVe/HXNhP8BT97L7F+T0F8ZO
   /7hoIq15xFAgUehY2Y6lVbXQAtDpO6ndgaM8anKvK6LhBR3+FqihvVf0F
   4/WgBWalSPHjKbIGVSiGlUX9FgI7Z2OuXYN+saQJER29AyIyb5/oRKAa+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="406566081"
X-IronPort-AV: E=Sophos;i="5.96,268,1665471600"; 
   d="scan'208";a="406566081"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2022 04:54:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="720636739"
X-IronPort-AV: E=Sophos;i="5.96,268,1665471600"; 
   d="scan'208";a="720636739"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 23 Dec 2022 04:54:13 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p8hYy-000CgL-0l;
        Fri, 23 Dec 2022 12:54:12 +0000
Date:   Fri, 23 Dec 2022 20:53:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 711d2d5f3b42c3e9658371089d400758cc54f307
Message-ID: <63a5a4e6.ftlpuqB3DCm3MfRh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 711d2d5f3b42c3e9658371089d400758cc54f307  Bluetooth: hci_sync: Fix use HCI_OP_LE_READ_BUFFER_SIZE_V2

elapsed time: 722m

configs tested: 67
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
alpha                               defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                              defconfig
x86_64                        randconfig-a015
x86_64                               rhel-8.3
i386                                defconfig
x86_64                           allyesconfig
i386                             allyesconfig
ia64                             allmodconfig
m68k                             allyesconfig
x86_64                         rhel-8.3-kunit
sh                               allmodconfig
m68k                             allmodconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
arc                              allyesconfig
arm                                 defconfig
alpha                            allyesconfig
mips                             allyesconfig
x86_64                           rhel-8.3-kvm
i386                 randconfig-a004-20221219
powerpc                          allmodconfig
x86_64               randconfig-a003-20221219
i386                 randconfig-a001-20221219
x86_64               randconfig-a001-20221219
x86_64               randconfig-a004-20221219
i386                 randconfig-a003-20221219
s390                                defconfig
i386                 randconfig-a002-20221219
x86_64               randconfig-a006-20221219
x86_64               randconfig-a005-20221219
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a006-20221219
x86_64                          rhel-8.3-func
i386                 randconfig-a005-20221219
s390                             allmodconfig
x86_64               randconfig-a002-20221219
arm                              allyesconfig
riscv                randconfig-r042-20221218
arm64                            allyesconfig
arc                  randconfig-r043-20221219
arm                  randconfig-r046-20221219
arc                  randconfig-r043-20221218
s390                 randconfig-r044-20221218
s390                             allyesconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                          rhel-8.3-rust
arm                  randconfig-r046-20221218
hexagon              randconfig-r041-20221218
hexagon              randconfig-r045-20221219
hexagon              randconfig-r041-20221219
hexagon              randconfig-r045-20221218
riscv                randconfig-r042-20221219
s390                 randconfig-r044-20221219
i386                 randconfig-a014-20221219
i386                 randconfig-a012-20221219
i386                 randconfig-a013-20221219
i386                 randconfig-a015-20221219
i386                 randconfig-a016-20221219
i386                 randconfig-a011-20221219

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
