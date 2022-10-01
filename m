Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2041C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 Oct 2022 22:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiJAWtC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 1 Oct 2022 18:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiJAWtB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 1 Oct 2022 18:49:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8F53FD56
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Oct 2022 15:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664664540; x=1696200540;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Nxm0np6kurDRMT01FzEPbkvWl7G2UzSu5yaWycWGReM=;
  b=HD2ABC8q1suJxT8Xw2ah5d5swPnyOFTFY++2yhxsHGjWQ+QwLS6HcxD/
   WuOyYG88Q2snez3RApgtAfyctZUiIExOq0fwiXrw+/5W8XO4Bz47hJDzk
   c4c+m/OWQgdwJwDOaFp9r+QyXTVxbqM950/dKpHGIoHf4BkDNy6ZMklL/
   8Ce80jY9mvdl4+C8QjwmsWU8F8QB0yOIKFMDBdRE5GmowIj5/fdzYObck
   vhCKTyQH8qPNJObDZxralkCVhpuYD1Pw3AO6uF98CfP6PzNnCKodPVp3S
   TL+XE3DC4lY48jLPi0GNpYOP7MmDBHDn+UrqAuZLkAXY/jv8uZVE1XYmV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="289583651"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="289583651"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2022 15:49:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="798328348"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="798328348"
Received: from lkp-server01.sh.intel.com (HELO 14cc182da2d0) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Oct 2022 15:48:59 -0700
Received: from kbuild by 14cc182da2d0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oelI2-0002p7-1p;
        Sat, 01 Oct 2022 22:48:58 +0000
Date:   Sun, 02 Oct 2022 06:48:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 6abf0dae8c3c927f54e62c46faf8aba580ba0d04
Message-ID: <6338c3b9./Fl8Wru/2cp1i/X5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 6abf0dae8c3c927f54e62c46faf8aba580ba0d04  Bluetooth: hci_sync: Fix not indicating power state

elapsed time: 1258m

configs tested: 76
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
powerpc                           allnoconfig
x86_64                          rhel-8.3-func
i386                                defconfig
um                           x86_64_defconfig
i386                          randconfig-a001
um                             i386_defconfig
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a003
s390                             allmodconfig
s390                                defconfig
x86_64                              defconfig
i386                          randconfig-a005
x86_64                        randconfig-a013
arm                                 defconfig
x86_64                        randconfig-a011
i386                             allyesconfig
s390                             allyesconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a015
s390                 randconfig-r044-20221001
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
arc                  randconfig-r043-20221001
x86_64                        randconfig-a002
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a006
sh                               allmodconfig
x86_64                        randconfig-a004
arm                              allyesconfig
arm64                            allyesconfig
i386                          randconfig-a014
powerpc                          allmodconfig
mips                             allyesconfig
i386                          randconfig-a012
riscv                randconfig-r042-20221001
i386                          randconfig-a016
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
m68k                             allyesconfig
i386                 randconfig-a003-20220926
i386                 randconfig-a001-20220926
i386                 randconfig-a006-20220926
i386                 randconfig-a004-20220926
i386                 randconfig-a005-20220926
i386                 randconfig-a002-20220926
ia64                             allmodconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
hexagon              randconfig-r045-20221001
x86_64                        randconfig-a012
i386                          randconfig-a006
x86_64                        randconfig-a014
hexagon              randconfig-r041-20221001
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64               randconfig-a016-20220926
x86_64               randconfig-a012-20220926
x86_64               randconfig-a014-20220926
x86_64               randconfig-a013-20220926
x86_64               randconfig-a011-20220926
x86_64               randconfig-a015-20220926
hexagon              randconfig-r041-20220925
hexagon              randconfig-r041-20220926
hexagon              randconfig-r045-20220925
hexagon              randconfig-r045-20220926
riscv                randconfig-r042-20220926
s390                 randconfig-r044-20220926

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
