Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27407C64ED6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Feb 2023 09:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjB1J6g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Feb 2023 04:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjB1J6f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Feb 2023 04:58:35 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2E2E3A3
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Feb 2023 01:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677578314; x=1709114314;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=WhuXLdG/eUSGz6G446wS6huk0wOODvPxODGzAlS7qO0=;
  b=iPYYIedWnxnLVudxSqkzJQEyWOHCbV6Xo+/TPV43lI59rRIDBLlYNYPG
   OjBOBqrpkjKATEWdS09N5cNrW1OHA453BUmZyODcaC975cuKvnT9pQGOW
   f6ge4mAXvTp1K/yI6ysr+4WXeWq6qUYccE4F0S58fZASiuBuSTtpn9yCS
   r8K1iPT178m+u7IX6ejfWJMl1zRmiYuHgnX79aE51weWB8pMmZEDP9b4z
   QT/+j58ADR3y+s5qOP5Ndni2RHoWQWaQ4k8k7nOCF+zYflIyXaMEsHmWX
   RFqvASzbXR8dvd/V591TTYqyZ3cy47Hqt1vXqRxneyPym/fz4i3/u0sZ0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="398877083"
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; 
   d="scan'208";a="398877083"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 01:58:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="706522996"
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; 
   d="scan'208";a="706522996"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 28 Feb 2023 01:58:28 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pWwkd-0005Iz-22;
        Tue, 28 Feb 2023 09:58:27 +0000
Date:   Tue, 28 Feb 2023 17:58:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 e16f2ec5cf3a500c5c082d4cad5bd8a234c86361
Message-ID: <63fdd035.SkTdKs5c+6/G2m/j%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: e16f2ec5cf3a500c5c082d4cad5bd8a234c86361  Bluetooth: ISO: fix timestamped HCI ISO data packet parsing

elapsed time: 725m

configs tested: 60
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r004-20230226   gcc  
arm64                               defconfig   gcc  
csky         buildonly-randconfig-r002-20230226   gcc  
csky         buildonly-randconfig-r003-20230226   gcc  
csky         buildonly-randconfig-r004-20230227   gcc  
csky                                defconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r006-20230227   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a011-20230227   gcc  
i386                 randconfig-a012-20230227   gcc  
i386                 randconfig-a013-20230227   gcc  
i386                 randconfig-a014-20230227   gcc  
i386                 randconfig-a015-20230227   gcc  
i386                 randconfig-a016-20230227   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
microblaze   buildonly-randconfig-r005-20230227   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
parisc       buildonly-randconfig-r002-20230227   gcc  
parisc       buildonly-randconfig-r006-20230226   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sparc        buildonly-randconfig-r001-20230226   gcc  
sparc        buildonly-randconfig-r001-20230227   gcc  
sparc                               defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r005-20230226   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
