Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9892C6FA86
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Sep 2022 09:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiIOJMA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Sep 2022 05:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiIOJL6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Sep 2022 05:11:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C7D98A44
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Sep 2022 02:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663233117; x=1694769117;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=lEIA4rjVi3QwksNHFtO/tRqQTysTvVksh+rNROV+dPY=;
  b=SAzGYb4dSYOYwqPl24/Uf4eXRCNR87uPk3TNLxcAG/eQ5wMaqlTs4VQ9
   ohcNUA2RBwrt5tUeKBGKGLYnmoSx/BhFP4iHpRyge5SXWPYjjkZP9hW90
   eEfTpvq6ZpMRCo2ZCeBYWSGwtUWkGPsPBxMTbwsylUiPKzYE6kwAPl7Vi
   FcMWip8tBTyCPAxksXwLVDK+HDnZY6Fa0rmns+Wp7nMv8yiKZ1oFb45SG
   P+CKYzCd1kOmvL/R7JdNmMGzdXm8U2qNlMwRMX/uWHFQsmp5zXSRwzx0r
   /qr1zfQAG9+FC2904xcEno5WxZTSs/xOOTrBT/jRJ2/8lTiXoqo9fg4wR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="384953308"
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="384953308"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 02:11:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="759560386"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 15 Sep 2022 02:11:47 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYkuR-0000G3-10;
        Thu, 15 Sep 2022 09:11:47 +0000
Date:   Thu, 15 Sep 2022 17:11:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 9afc675edeeb34d281675f1d5a217d27c5a1a3db
Message-ID: <6322ec3d.YjItPucVuDVDFcZp%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 9afc675edeeb34d281675f1d5a217d27c5a1a3db  Bluetooth: hci_sync: allow advertise when scan without RPA

elapsed time: 720m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                        randconfig-a004
um                           x86_64_defconfig
x86_64                        randconfig-a002
arc                  randconfig-r043-20220914
um                             i386_defconfig
arc                                 defconfig
s390                             allmodconfig
x86_64                        randconfig-a006
alpha                               defconfig
s390                                defconfig
i386                          randconfig-a001
x86_64                              defconfig
x86_64                               rhel-8.3
arm                                 defconfig
s390                             allyesconfig
i386                                defconfig
m68k                             allmodconfig
x86_64                           allyesconfig
i386                          randconfig-a003
arc                              allyesconfig
i386                          randconfig-a005
alpha                            allyesconfig
m68k                             allyesconfig
arm                              allyesconfig
powerpc                           allnoconfig
arm64                            allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                          rhel-8.3-func
i386                             allyesconfig
x86_64                         rhel-8.3-kunit
i386                          randconfig-a016
powerpc                          allmodconfig
x86_64                           rhel-8.3-kvm
sh                               allmodconfig
mips                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a013
ia64                             allmodconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a015

clang tested configs:
hexagon              randconfig-r041-20220914
x86_64                        randconfig-a005
x86_64                        randconfig-a001
hexagon              randconfig-r045-20220914
x86_64                        randconfig-a003
riscv                randconfig-r042-20220914
s390                 randconfig-r044-20220914
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
