Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB386ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Oct 2022 09:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiJ1JRf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Oct 2022 05:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiJ1JRd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Oct 2022 05:17:33 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F681C5A74
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Oct 2022 02:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666948652; x=1698484652;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=OivfaCnWZsDapgkmEeZJ9GHc49aMUBUWx8qY6VcYNBU=;
  b=D5R04Kq9fHYx3Zqz8t56xYNhYGHMAwjc8C08bxCriiLm6goMtyTLx5Ui
   6XRLNWei5co/PwftDFi8LT5FaCibyKlsfS6O5m7/ueHL13PsBg3Jd8m0K
   SuNykWwP/gXHsyUuTB6eB8Epkev+/MEtx2QfKzGAIns0kvGR7DJfkjVBn
   1994lMtjEPKoCozoWcYRefPmbO5dv14/kU+RkSih96Oy5/uU+ObYBlV4g
   9rY6l9uO+4h3Zi1CoAGjbwXjS9m6Y0lpYbaUK3AH9xj3+f80cWZQcFUBI
   eRVMTs8s/3j8qXfDQlcRJGMeA4fSsoO7HSdB8ur5bJcmUHCNTlv2+suj/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="288845613"
X-IronPort-AV: E=Sophos;i="5.95,220,1661842800"; 
   d="scan'208";a="288845613"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 02:17:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="701670846"
X-IronPort-AV: E=Sophos;i="5.95,220,1661842800"; 
   d="scan'208";a="701670846"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 28 Oct 2022 02:17:28 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ooLUW-0009ji-0f;
        Fri, 28 Oct 2022 09:17:28 +0000
Date:   Fri, 28 Oct 2022 17:16:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 aa02d16d9c085f348ce56b51b58039101746c4aa
Message-ID: <635b9e05.f6iRyfrbnD29WupM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: aa02d16d9c085f348ce56b51b58039101746c4aa  Bluetooth: btusb: Default CONFIG_BT_HCIBTUSB_POLL_SYNC=y

elapsed time: 722m

configs tested: 64
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                              defconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                    rhel-8.3-kselftests
s390                                defconfig
x86_64                           allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
s390                             allyesconfig
x86_64                         rhel-8.3-kunit
powerpc                          allmodconfig
x86_64                           rhel-8.3-kvm
ia64                             allmodconfig
x86_64                           rhel-8.3-syz
sh                               allmodconfig
i386                                defconfig
i386                          randconfig-a001
x86_64                        randconfig-a013
x86_64                        randconfig-a011
alpha                            allyesconfig
x86_64                        randconfig-a002
arc                              allyesconfig
i386                          randconfig-a014
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a012
x86_64                        randconfig-a004
i386                          randconfig-a016
arc                  randconfig-r043-20221028
arm                                 defconfig
arc                  randconfig-r043-20221027
m68k                             allmodconfig
riscv                randconfig-r042-20221028
s390                 randconfig-r044-20221028
i386                             allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
m68k                             allyesconfig
x86_64                        randconfig-a015
arc                  randconfig-r043-20221026
s390                 randconfig-r044-20221026
riscv                randconfig-r042-20221026

clang tested configs:
x86_64                        randconfig-a012
i386                          randconfig-a013
x86_64                        randconfig-a014
i386                          randconfig-a011
i386                          randconfig-a002
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a006
hexagon              randconfig-r041-20221027
i386                          randconfig-a015
hexagon              randconfig-r041-20221028
i386                          randconfig-a004
hexagon              randconfig-r045-20221028
hexagon              randconfig-r045-20221027
s390                 randconfig-r044-20221027
riscv                randconfig-r042-20221027

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
