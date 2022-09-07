Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BC2C38145
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Sep 2022 19:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiIGTIB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Sep 2022 15:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiIGTH3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Sep 2022 15:07:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB587B1B99
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Sep 2022 12:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662577648; x=1694113648;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=3/ER42hmf9qupIO4y4TraL1zS8BTy6uURJyiJY0NT9c=;
  b=ATG1+KSBa7QKeZIkjJ/+RFY9IbhuIs4kkJroZRVrS3s3IWyBbOahxoFB
   ecmwwga6NRDqovwygCaUL1Q5CrKvdRglXj4HQT0ayxgElJHkJknX2hBne
   q0TAiVetwmbsFNkQd5RilD3ABffxiPu3KHof9y33SsLXpduYmDTDc5s+l
   Pl7Q7GtkLJrk0D6bt44UesvoXjgBcmRLr/SA87B9doRuBUKXhxQKaCZzV
   /XXl2aGGtXDgmTC3ujMxQ80hkNsO2ggrNS3JsDmiQwkKsq72twWvE7wQH
   HdRU39BH3aQCFdP+FoU6yElccNbGzOjmUX76kzeaZYxpXid58aanzoTq4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="295707156"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="295707156"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 12:07:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="647754259"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 07 Sep 2022 12:07:26 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oW0OT-0006sZ-2h;
        Wed, 07 Sep 2022 19:07:25 +0000
Date:   Thu, 08 Sep 2022 03:07:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 c1631dbc00c1e432713396aaa10d8bd825822db0
Message-ID: <6318ebda.RL3uPpza8l5W7xH2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: c1631dbc00c1e432713396aaa10d8bd825822db0  Bluetooth: hci_sync: Fix hci_read_buffer_size_sync

elapsed time: 1333m

configs tested: 47
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220906
riscv                randconfig-r042-20220906
s390                 randconfig-r044-20220906
powerpc                           allnoconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
i386                                defconfig
x86_64                              defconfig
sh                               allmodconfig
x86_64                               rhel-8.3
i386                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                        randconfig-a015
mips                             allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
powerpc                          allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a002
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a006
i386                          randconfig-a014
x86_64                        randconfig-a004
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a003
i386                          randconfig-a001
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
x86_64                           rhel-8.3-syz
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220906
hexagon              randconfig-r045-20220906
x86_64                        randconfig-a016
x86_64                        randconfig-a001
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a003
i386                          randconfig-a011
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
