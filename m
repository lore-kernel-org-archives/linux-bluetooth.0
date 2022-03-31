Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C25C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Mar 2022 01:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiCaBKH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiCaBKG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Mar 2022 21:10:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D09311174
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 18:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648688899; x=1680224899;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+V17MVUwaSi7C8Ot3jWRI3TolMILWDpL7Yiqd0daaiI=;
  b=MbMSUwj/hT3TCHiHMfL3neJxPeGVN2mhOgtOniQbbIIzApt/GvPewGII
   6qt3Z4yuGpyjOPdsfeg0VM48rVa1lLsXpzeZu2eyPyq0JbV9Zy+MKi6To
   TLHu5+2LwpNiYAZI9kfVq9IvrWwuYqjrJ5Slcm0jDFbbFIGzXX0h0z5//
   DLC2GGq4XWlHaDM9tDWqE7+Cqg2itZ8bPlIuLSVsZNFi4hJDGsfDHmhBm
   g2BixpWH56VjhLDgbSoOHohaKNydlqVvgHsJknIP1TeozLqLwHFAC0z76
   PFrQR+0TkCMZ1gj4fEsbUm0qZj7riBCEOYLu5paZ8bkAMrE+VIvi9yoHv
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="239611296"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="239611296"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 18:08:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="547080466"
Received: from lkp-server02.sh.intel.com (HELO 56431612eabd) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 30 Mar 2022 18:08:17 -0700
Received: from kbuild by 56431612eabd with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZjIO-0000ir-QO;
        Thu, 31 Mar 2022 01:08:16 +0000
Date:   Thu, 31 Mar 2022 09:07:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 300cf0bfb43e3fd3ff23c72ef48714c9d3421166
Message-ID: <6244fede.8xOj7KP//L4ZpG8R%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 300cf0bfb43e3fd3ff23c72ef48714c9d3421166  Bluetooth: fix dangling sco_conn and use-after-free in sco_sock_timeout

elapsed time: 2242m

configs tested: 71
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
i386                          randconfig-c001
powerpc                      makalu_defconfig
mips                         db1xxx_defconfig
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
alpha                            allyesconfig
csky                                defconfig
alpha                               defconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
h8300                            allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
s390                                defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
arc                              allyesconfig
nios2                               defconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit

clang tested configs:
hexagon                             defconfig
powerpc               mpc834x_itxgp_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                 randconfig-a014-20220328
i386                 randconfig-a012-20220328
i386                 randconfig-a016-20220328
i386                 randconfig-a015-20220328
i386                 randconfig-a011-20220328
i386                 randconfig-a013-20220328

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
