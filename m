Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F05AC636CC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Feb 2023 09:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjBOJrI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Feb 2023 04:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbjBOJrE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Feb 2023 04:47:04 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F84336695
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Feb 2023 01:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676454419; x=1707990419;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=i9iLAV5lRPcGzG1ES7f2+HQH7iJn9TaP/9ivry6FwNA=;
  b=ZIj8NpzAkjcg9B9xFiQZ2jhXjQlRJ+8iPFMh7l9sLiDtJanuHNgelE6h
   6YFuXvcLh03FeWXUcyDgonf4+rIxFSR4t9WMleJY08OtbxIwU6s8C+Tbs
   zDXI+nPtseqs1CcFPr63akc6eJSPt3pZ7EDja92Z+3IKfMpWVgoEJ44qR
   ks9f8Eh4nsZ95vbzWq2CX68BTbZ3Q2LXMWaEWtmpaNzzW/+zPjgY9E00d
   mJPvRHZA40PzCAKYhKc+6RV9grpU8KNgRWG8dcrpTs+qQ81ZODLaIWuXX
   uc/hdaV+RrlBlwyxmekZcpQvNfZNgwlyzmaEcYWYLDrk30tkugq+fhu56
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="417606191"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="417606191"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 01:46:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="662861354"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="662861354"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 15 Feb 2023 01:46:42 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pSEN7-0009Ff-1O;
        Wed, 15 Feb 2023 09:46:41 +0000
Date:   Wed, 15 Feb 2023 17:46:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 dbf27f4a6adb530999726340bd133a22f57779c9
Message-ID: <63eca9ee.7tPuo2VX2wPyeV5u%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: dbf27f4a6adb530999726340bd133a22f57779c9  Bluetooth: btusb: Do not require hardcoded interface numbers

elapsed time: 725m

configs tested: 91
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                            allyesconfig
alpha                               defconfig
arc                              allyesconfig
arc                                 defconfig
arc                  randconfig-r043-20230212
arc                  randconfig-r043-20230213
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm                      footbridge_defconfig
arm                          iop32x_defconfig
arm                  randconfig-r046-20230212
arm                            zeus_defconfig
arm64                            allyesconfig
arm64                               defconfig
csky                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                                defconfig
i386                 randconfig-a011-20230213
i386                 randconfig-a012-20230213
i386                 randconfig-a013-20230213
i386                 randconfig-a014-20230213
i386                 randconfig-a015-20230213
i386                 randconfig-a016-20230213
ia64                             allmodconfig
ia64                                defconfig
loongarch                        allmodconfig
loongarch                         allnoconfig
loongarch                           defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                        mvme147_defconfig
mips                             allmodconfig
mips                             allyesconfig
mips                 decstation_r4k_defconfig
mips                           gcw0_defconfig
nios2                               defconfig
parisc                           alldefconfig
parisc                              defconfig
parisc64                            defconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                randconfig-r042-20230213
riscv                          rv32_defconfig
s390                             allmodconfig
s390                             allyesconfig
s390                                defconfig
s390                 randconfig-r044-20230213
sh                               allmodconfig
sh                          rsk7264_defconfig
sh                           se7712_defconfig
sparc                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64               randconfig-a011-20230213
x86_64               randconfig-a012-20230213
x86_64               randconfig-a013-20230213
x86_64               randconfig-a014-20230213
x86_64               randconfig-a015-20230213
x86_64               randconfig-a016-20230213
x86_64                               rhel-8.3

clang tested configs:
arm                  randconfig-r046-20230213
arm                           spitz_defconfig
hexagon              randconfig-r041-20230212
hexagon              randconfig-r041-20230213
hexagon              randconfig-r045-20230212
hexagon              randconfig-r045-20230213
i386                 randconfig-a001-20230213
i386                 randconfig-a002-20230213
i386                 randconfig-a003-20230213
i386                 randconfig-a004-20230213
i386                 randconfig-a005-20230213
i386                 randconfig-a006-20230213
powerpc                 mpc8313_rdb_defconfig
powerpc                      obs600_defconfig
riscv                randconfig-r042-20230212
s390                 randconfig-r044-20230212
x86_64               randconfig-a001-20230213
x86_64               randconfig-a002-20230213
x86_64               randconfig-a003-20230213
x86_64               randconfig-a004-20230213
x86_64               randconfig-a005-20230213
x86_64               randconfig-a006-20230213

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
