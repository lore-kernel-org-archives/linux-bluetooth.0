Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87865C64EC4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Mar 2023 22:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCHWgF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Mar 2023 17:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjCHWgE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Mar 2023 17:36:04 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4C065135
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Mar 2023 14:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678314963; x=1709850963;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Z+mRmcdu4owuAxyEKDP0l6LB5uFH9k0ozK/EBhHmYDc=;
  b=GanKLcqMPG6hgLBL3ZGhmHZixy2B5ZmnRPzrSefX8bs1HA7UZCm+BITU
   x1McDzdo4cjN1JxG65MQatZ7jndCJ9m29CF9cZ9WCHeWJT5S7yDKbt4o4
   1vS8RfawSXyU3tdkYph6aHEegEpaPZOcqZrePUx2qVNdd4UA8ZJJ6Raxv
   i8g3tP0blUIhNtlRu3U02PikPPd3gpzE1RW3vtlhsQYuvMFXXh6RYK05C
   An7+iP7exlHv0Pxrwb14ipvcDuflsLwCNsqYkMH8UTZ4QU0rUnrdE3A68
   66NWvtsgBo0HRPl1hNRXNzmBro6DHmLLItrSMZ1ZeYrHREVPAfypEH2NY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="336307171"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="336307171"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 14:36:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="851294099"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="851294099"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Mar 2023 14:36:01 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pa2O8-0002Rw-2S;
        Wed, 08 Mar 2023 22:36:00 +0000
Date:   Thu, 09 Mar 2023 06:35:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 0e21956501c0d8a15f9fc4164b2eb7769dff7700
Message-ID: <64090dc6.7RL5PJFKuICjtQRy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 0e21956501c0d8a15f9fc4164b2eb7769dff7700  Bluetooth: Convert MSFT filter HCI cmd to hci_sync

elapsed time: 1445m

configs tested: 98
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r032-20230305   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r002-20230305   gcc  
arc          buildonly-randconfig-r006-20230306   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r002-20230305   gcc  
arc                  randconfig-r034-20230305   gcc  
arc                  randconfig-r043-20230306   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r001-20230306   clang
arm                  randconfig-r005-20230306   clang
arm                  randconfig-r015-20230305   clang
arm                  randconfig-r036-20230305   gcc  
arm                  randconfig-r046-20230306   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r003-20230306   gcc  
arm64        buildonly-randconfig-r005-20230305   clang
arm64        buildonly-randconfig-r006-20230305   clang
arm64                               defconfig   gcc  
arm64                randconfig-r021-20230305   gcc  
arm64                randconfig-r026-20230306   clang
csky         buildonly-randconfig-r004-20230306   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r025-20230306   gcc  
csky                 randconfig-r035-20230305   gcc  
csky                 randconfig-r036-20230306   gcc  
hexagon              randconfig-r013-20230305   clang
hexagon              randconfig-r014-20230306   clang
hexagon              randconfig-r023-20230305   clang
hexagon              randconfig-r041-20230306   clang
hexagon              randconfig-r045-20230306   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a006-20230306   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r012-20230305   gcc  
ia64                 randconfig-r021-20230306   gcc  
ia64                 randconfig-r022-20230306   gcc  
ia64                 randconfig-r033-20230306   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r013-20230306   gcc  
loongarch            randconfig-r031-20230306   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r035-20230306   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r022-20230305   clang
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230306   gcc  
nios2                randconfig-r016-20230306   gcc  
openrisc     buildonly-randconfig-r001-20230306   gcc  
openrisc             randconfig-r014-20230305   gcc  
parisc       buildonly-randconfig-r002-20230306   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r004-20230305   gcc  
powerpc              randconfig-r004-20230306   gcc  
powerpc              randconfig-r016-20230305   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r024-20230305   gcc  
riscv                randconfig-r042-20230306   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230306   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r001-20230305   gcc  
sh                   randconfig-r012-20230306   gcc  
sparc        buildonly-randconfig-r003-20230305   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230306   gcc  
sparc                randconfig-r011-20230306   gcc  
sparc                randconfig-r023-20230306   gcc  
sparc64              randconfig-r004-20230305   gcc  
sparc64              randconfig-r006-20230305   gcc  
sparc64              randconfig-r024-20230306   gcc  
sparc64              randconfig-r034-20230306   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r005-20230306   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
