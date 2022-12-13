Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAC8C4167B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Dec 2022 10:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbiLMK2z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Dec 2022 05:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiLMK2k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Dec 2022 05:28:40 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A46962E0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Dec 2022 02:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670927319; x=1702463319;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=wSQrbtddT4M6q7MdUwpEl1US4OGX02bovM8CzapEG+w=;
  b=LGxVt45IxGn8c2ektJXXwPwHAMUHBsYszJDyCDbkvwg4XK8DNnwdTYIY
   u9ZJuU7oa9lYafUsLR3k0Wc9m+MQAcjNtHb8REuWGAOSwqE0WUxGX77Rp
   OTy4EoDVoFYUVWhNTRfUW2QcQKESYnIw4YCehfN0khOrNPeRdNe9DCkOo
   IoSNRDBYD8bie38Pad2D37B5C+3c4wO3OfEiqywcF/BSVaFgQQR8UbQ3D
   5Rg/l+GndzZhU7qIPSrernXQkX0vRdScAw+eP+g19/uQ/dN8aGesJaOcK
   L825rSwiKH9BBHOCkv35lrC9YKKH8+oW1UkNSFqkiVT3EP7YFQzhQ93A9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="404354488"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="404354488"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 02:28:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="712023774"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="712023774"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 13 Dec 2022 02:28:37 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p52Wb-0004Ex-0M;
        Tue, 13 Dec 2022 10:28:37 +0000
Date:   Tue, 13 Dec 2022 18:27:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 7aca0ac4792e6cb0f35ef97bfcb39b1663a92fb7
Message-ID: <639853a7.rVIo2JUJ1szurt+v%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 7aca0ac4792e6cb0f35ef97bfcb39b1663a92fb7  Bluetooth: Wait for HCI_OP_WRITE_AUTH_PAYLOAD_TO to complete

elapsed time: 721m

configs tested: 61
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                 randconfig-a013-20221212
i386                 randconfig-a014-20221212
i386                 randconfig-a012-20221212
i386                 randconfig-a011-20221212
arc                                 defconfig
i386                 randconfig-a015-20221212
alpha                               defconfig
i386                 randconfig-a016-20221212
um                           x86_64_defconfig
um                             i386_defconfig
s390                             allmodconfig
x86_64                              defconfig
s390                                defconfig
ia64                             allmodconfig
x86_64                          rhel-8.3-rust
x86_64                               rhel-8.3
s390                             allyesconfig
x86_64               randconfig-a011-20221212
x86_64                          rhel-8.3-func
x86_64               randconfig-a012-20221212
x86_64                           allyesconfig
x86_64                           rhel-8.3-bpf
x86_64                    rhel-8.3-kselftests
x86_64               randconfig-a014-20221212
x86_64                           rhel-8.3-syz
x86_64               randconfig-a013-20221212
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a015-20221212
x86_64               randconfig-a016-20221212
i386                                defconfig
arm                                 defconfig
arc                  randconfig-r043-20221212
s390                 randconfig-r044-20221212
riscv                randconfig-r042-20221212
powerpc                           allnoconfig
mips                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
powerpc                          allmodconfig
arm64                            allyesconfig
arm                              allyesconfig
sh                               allmodconfig
m68k                             allyesconfig
i386                             allyesconfig

clang tested configs:
i386                 randconfig-a002-20221212
i386                 randconfig-a003-20221212
i386                 randconfig-a001-20221212
i386                 randconfig-a004-20221212
i386                 randconfig-a006-20221212
i386                 randconfig-a005-20221212
x86_64               randconfig-a002-20221212
x86_64               randconfig-a001-20221212
x86_64               randconfig-a004-20221212
x86_64               randconfig-a003-20221212
x86_64               randconfig-a006-20221212
x86_64               randconfig-a005-20221212
arm                  randconfig-r046-20221212
hexagon              randconfig-r045-20221212
hexagon              randconfig-r041-20221212

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
