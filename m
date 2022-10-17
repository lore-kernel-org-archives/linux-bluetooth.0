Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99BBC4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Oct 2022 02:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiJQCVX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 16 Oct 2022 22:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiJQCVW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 16 Oct 2022 22:21:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590BF2C66A
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Oct 2022 19:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665973281; x=1697509281;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dSdxKaLTrrYG6PPfDQmk0PA1+5j6GPhZU2BVeLgPSDQ=;
  b=VFm1WhWPuP9Nvq+JcDBo54jbpuUgREN7cYFI7oX7gykcgCJHKoRAH0M+
   u5qax6EQAyYH/YIl3CIb8ewdS3tfqh0AgbmAVODmPLmCFmvnZegDZVkvQ
   HyuRP6Bkc9w7/MfRQw3V2AcJC+oUq0pZUe07ABTKrKpmgyHWpVq6qtdaW
   iT5GZzriDgwfvZmkdU7/kFkW0M4PwCql6knPpJ1zXxNBDlsDe75OJiCoK
   706G9eOoOj/DLiqP84GgadmJ9HeCSOZKkrw/MAiVQM8vgKhqYvsjaJZoe
   bwNyW92ny7ypsdeya/CCnvTG5A0aOKpzbTiyIVaJ0XnpsputOBZTVl6/x
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="369878435"
X-IronPort-AV: E=Sophos;i="5.95,190,1661842800"; 
   d="scan'208";a="369878435"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2022 19:21:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="717330580"
X-IronPort-AV: E=Sophos;i="5.95,190,1661842800"; 
   d="scan'208";a="717330580"
Received: from lkp-server02.sh.intel.com (HELO 8556ec0e0fdc) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Oct 2022 19:21:19 -0700
Received: from kbuild by 8556ec0e0fdc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1okFkk-00003m-2T;
        Mon, 17 Oct 2022 02:21:18 +0000
Date:   Mon, 17 Oct 2022 10:21:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 9fe208c7117dd3d00a13d1a54aad108e2af6ad17
Message-ID: <634cbc1d.81IHucDa7Ab1hHKo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 9fe208c7117dd3d00a13d1a54aad108e2af6ad17  Bluetooth: hci_qca: only assign wakeup with serial port support

elapsed time: 4536m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                              defconfig
i386                                defconfig
sh                               allmodconfig
x86_64                        randconfig-a002
x86_64                           rhel-8.3-kvm
riscv                randconfig-r042-20221012
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a004
x86_64                           rhel-8.3-syz
arc                  randconfig-r043-20221012
x86_64                               rhel-8.3
m68k                             allmodconfig
x86_64                        randconfig-a006
m68k                             allyesconfig
s390                 randconfig-r044-20221012
alpha                            allyesconfig
arc                              allyesconfig
i386                          randconfig-a001
i386                             allyesconfig
i386                          randconfig-a003
x86_64                           allyesconfig
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arm                                 defconfig
x86_64                        randconfig-a015
arm64                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                     haps_hs_smp_defconfig
powerpc                     tqm8548_defconfig
openrisc                         alldefconfig
openrisc                    or1ksim_defconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r041-20221012
hexagon              randconfig-r045-20221012
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
