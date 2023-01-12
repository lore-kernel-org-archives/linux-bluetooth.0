Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0325C54EBD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Jan 2023 09:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240103AbjALJNX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Jan 2023 04:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240009AbjALJLR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Jan 2023 04:11:17 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43802959E
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jan 2023 01:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673514420; x=1705050420;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2ZmwAG5yevUfEDewstk/11u6drAwGUU9z7QtUob/UfE=;
  b=GMor0HHvqKYABlOWoyYuyNZXDdR0d37oy7E6C+cbWBIz/Vrx19p/9Rjy
   kwyPGtZxABWq2vx40Ftz1NS22JmIZmTTgW5rKAaCN9nHZP4VMTtQKYgJb
   xb5qxddOn9k8MpvHAYNTm4D9h+e01liPWyk4Ts1pkjFEH49wYD3Bbf4Qf
   r3gA1kDyaCTwtSlrqz6278C6ldWZkgJPfP1s/xfGlgAM9GQraXGpFJX9H
   DWdgvOl7xk8yDC15RZX/RoOkiTLAAhbpLnXwjsqwRP+VevTLm/X5k6vG8
   Rq7FeiWpY3nm1dAeVbX58Dp5CCSv45VRlDGvGa5XdzVfmkOsfoYO/lLtj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="323712459"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="323712459"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 01:06:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="800132711"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="800132711"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jan 2023 01:06:32 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pFtXb-0009zP-1D;
        Thu, 12 Jan 2023 09:06:31 +0000
Date:   Thu, 12 Jan 2023 17:06:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 7ed38304a6332c9e182fea91463bd1142877e568
Message-ID: <63bfcd8f.Uck1ESlUUBS86mxA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 7ed38304a6332c9e182fea91463bd1142877e568  Bluetooth: Fix possible deadlock in rfcomm_sk_state_change

elapsed time: 724m

configs tested: 95
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
powerpc                           allnoconfig
m68k                             allyesconfig
i386                                defconfig
arc                                 defconfig
m68k                             allmodconfig
x86_64                           rhel-8.3-syz
arc                              allyesconfig
x86_64                              defconfig
x86_64                         rhel-8.3-kunit
alpha                               defconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
alpha                            allyesconfig
um                             i386_defconfig
x86_64                           rhel-8.3-bpf
ia64                             allmodconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20230110
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
x86_64                           allyesconfig
arm                                 defconfig
i386                             allyesconfig
sh                               allmodconfig
x86_64                          rhel-8.3-func
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
mips                             allyesconfig
x86_64                    rhel-8.3-kselftests
powerpc                          allmodconfig
i386                          randconfig-a016
s390                 randconfig-r044-20230110
riscv                randconfig-r042-20230110
x86_64                        randconfig-a006
s390                                defconfig
arm64                            allyesconfig
s390                             allmodconfig
arm                              allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
s390                             allyesconfig
i386                          randconfig-c001
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
arm                          simpad_defconfig
arm                           stm32_defconfig
loongarch                 loongson3_defconfig
m68k                         amcore_defconfig
arm                        multi_v7_defconfig
sh                              ul2_defconfig
m68k                             alldefconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                    klondike_defconfig
sh                ecovec24-romimage_defconfig
sparc                       sparc64_defconfig
powerpc                      mgcoge_defconfig
openrisc                 simple_smp_defconfig
arm                          gemini_defconfig
powerpc                     tqm8548_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec

clang tested configs:
hexagon              randconfig-r041-20230110
x86_64                        randconfig-a014
x86_64                        randconfig-a012
i386                          randconfig-a013
x86_64                        randconfig-a016
i386                          randconfig-a011
arm                  randconfig-r046-20230110
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a005
i386                          randconfig-a015
hexagon              randconfig-r045-20230110
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
arm                         s5pv210_defconfig
hexagon                          alldefconfig
powerpc                     ksi8560_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
