Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D5FC19F2A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Aug 2022 11:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbiHKL2u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Aug 2022 07:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbiHKL2u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Aug 2022 07:28:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CAE65806
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 04:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660217329; x=1691753329;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=LrifTz9KYmc+apX1OJBFn4zf+n8RvhsHM+fo+76Uyxo=;
  b=R5qwMXSaS00O1uS+T7kW8jK1DpgKNj/1IrrxWWKDQGOVQdX1OOyGRGPz
   Gj4U5rXCYmJaW11kh1jlT1hit24O2tMMFQGtjAO9PG597afOX8abDPChy
   sPwo8on/R3u10GE2+lmmM2BNeQit0/MyedJmyaehqHH7tXNeIdH8FeVyP
   93znb3ZvDGTFGOi6uj16VhAksfEHPS5QPTNO+4KLRZMiTdgjKNu9LKcLQ
   W4JPRwhYjUtjmrAVCWqxR4aMOOF2zdaOR9V1Bwts1HkCdTlEiD63ww0tB
   +LohXDdEpPPIg1cv2QNs48cMGQdUdQPzLmWg1csSLAf5XBZrbF2bp7a3U
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="291322016"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="291322016"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 04:28:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="581635445"
Received: from lkp-server02.sh.intel.com (HELO cfab306db114) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 11 Aug 2022 04:28:47 -0700
Received: from kbuild by cfab306db114 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oM6Mp-00008Z-0E;
        Thu, 11 Aug 2022 11:28:47 +0000
Date:   Thu, 11 Aug 2022 19:28:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 84a0a27ea39a9caed74d80a78666a91a9ea5e12b
Message-ID: <62f4e7da.BplhCnLAy/u3pigz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 84a0a27ea39a9caed74d80a78666a91a9ea5e12b  Bluetooth: hci_event: Fix vendor (unknown) opcode status handling

elapsed time: 713m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                              defconfig
i386                             allyesconfig
i386                          randconfig-a001
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                          randconfig-a003
arm                                 defconfig
x86_64                        randconfig-a004
i386                          randconfig-a005
x86_64                        randconfig-a002
riscv                randconfig-r042-20220810
powerpc                           allnoconfig
x86_64                        randconfig-a013
x86_64                          rhel-8.3-func
x86_64                        randconfig-a011
x86_64                         rhel-8.3-kunit
arc                  randconfig-r043-20220810
x86_64                        randconfig-a006
s390                 randconfig-r044-20220810
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a014
arm                              allyesconfig
x86_64                        randconfig-a015
powerpc                          allmodconfig
x86_64                           rhel-8.3-syz
i386                          randconfig-a012
mips                             allyesconfig
arm64                            allyesconfig
x86_64                           rhel-8.3-kvm
i386                          randconfig-a016
sh                               allmodconfig
ia64                             allmodconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
hexagon              randconfig-r041-20220810
i386                          randconfig-a006
x86_64                        randconfig-a001
i386                          randconfig-a013
x86_64                        randconfig-a016
i386                          randconfig-a015
x86_64                        randconfig-a003
x86_64                        randconfig-a012
hexagon              randconfig-r045-20220810
x86_64                        randconfig-a005
i386                          randconfig-a011
x86_64                        randconfig-a014

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
