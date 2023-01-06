Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954F0C3DA7A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Jan 2023 12:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjAFMrS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Jan 2023 07:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbjAFMrI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Jan 2023 07:47:08 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D70E714BA
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Jan 2023 04:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673009228; x=1704545228;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=k58MGkr2JtX6Nx8vc2j/QU2fj3TnnTMhOrw4fZ5qrQ8=;
  b=lgBKFEerGkoz5Najet/ZwuLVyeBs7AJuoA0No0GM5z2dgDdTGBVTu64I
   +E/ZI9+aFXb4khr+vGGO5TMAl7MDB3EWm9YpalSSt9BvH+wOhv8GxsdgE
   TPQsqcN41E/49R+8eve7BnnIv0TRUAwDqH80ToHtkt1exHA4ZtioKkbuL
   SXVgVVMyi4OkWltoQsb6M3frP13O7Llh79CJd1/gKYxPXPV67k71ZmoZ9
   SV8PZBhrTjidcaUQRANJdiw6L/d/+rxzNxntSuWXYWCSh4nrneidq84jC
   060ZYY8CNjozMle42uHs7K42SHWJ8a3mjhKpD9OjBq5PpUoolJirU18nt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="408721971"
X-IronPort-AV: E=Sophos;i="5.96,305,1665471600"; 
   d="scan'208";a="408721971"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 04:47:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="984664732"
X-IronPort-AV: E=Sophos;i="5.96,305,1665471600"; 
   d="scan'208";a="984664732"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 06 Jan 2023 04:47:06 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pDm7l-0003Ns-2x;
        Fri, 06 Jan 2023 12:47:05 +0000
Date:   Fri, 06 Jan 2023 20:46:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 5d043a6a43b6dfd695c8098a51c8fa8efbf95157
Message-ID: <63b8182c.ES31ofUOI2ctjP7M%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 5d043a6a43b6dfd695c8098a51c8fa8efbf95157  Bluetooth: hci_conn: Fix memory leaks

elapsed time: 726m

configs tested: 78
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                        randconfig-a013
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a011
arc                  randconfig-r043-20230105
x86_64                        randconfig-a015
i386                          randconfig-a005
ia64                             allmodconfig
s390                 randconfig-r044-20230105
x86_64                        randconfig-a004
x86_64                        randconfig-a002
riscv                randconfig-r042-20230105
x86_64                        randconfig-a006
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-c001
arc                                 defconfig
powerpc                           allnoconfig
um                           x86_64_defconfig
alpha                               defconfig
um                             i386_defconfig
i386                                defconfig
arm                                 defconfig
x86_64                           rhel-8.3-bpf
x86_64                              defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
s390                             allmodconfig
x86_64                    rhel-8.3-kselftests
sh                               allmodconfig
s390                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arm                              allyesconfig
alpha                            allyesconfig
arm64                            allyesconfig
arc                              allyesconfig
csky                                defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                             allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
s390                             allyesconfig
m68k                        m5407c3_defconfig
loongarch                           defconfig
arm                          lpd270_defconfig

clang tested configs:
i386                          randconfig-a002
x86_64                        randconfig-a012
i386                          randconfig-a004
x86_64                        randconfig-a014
arm                  randconfig-r046-20230105
x86_64                        randconfig-a016
hexagon              randconfig-r041-20230105
hexagon              randconfig-r045-20230105
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                          rhel-8.3-rust
mips                malta_qemu_32r6_defconfig
s390                 randconfig-r044-20230106
hexagon              randconfig-r041-20230106
hexagon              randconfig-r045-20230106
riscv                randconfig-r042-20230106

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
