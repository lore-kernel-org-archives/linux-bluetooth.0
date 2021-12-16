Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB9DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Dec 2021 15:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbhLPPuB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Dec 2021 10:50:01 -0500
Received: from mga11.intel.com ([192.55.52.93]:24071 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230358AbhLPPuA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Dec 2021 10:50:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639669800; x=1671205800;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dpvZtiIfoFNhT69As2FgtbPya+XR3H68mP5eiXA7W74=;
  b=KddsN6GK78NnYepPrDgTLayUYt6NuJtSrSP1lRyHVpesVcXrW7UsZbla
   xKqAG/vqF/55d3yJgyT5abV55u4w8B4GAixdRs2m7u9HhqhjPJ4UGRxYi
   Ranjx6I60N3lFJo7P0ib1d48MiTAMg5wz95Q13z2fQ/T3S+unOj/iXiut
   9nwkWeUSKae9LzRo02gQpupZu6tDEVHYlTDLIb8HToiSVa7rKsf10vSDd
   I2gKYPSE+hrXQlO7+fMAQWP/Pre666htbtVFdy8Wa5iiN9kEoF9hRiWVe
   xCB2rw1LECYSMmgvayIgCaS+FdxIzvGapoKamSde+5n3r7sQ5AblHYoiU
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="237064335"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="237064335"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 07:49:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="464733532"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 16 Dec 2021 07:49:09 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxt0G-0003PN-GY; Thu, 16 Dec 2021 15:49:08 +0000
Date:   Thu, 16 Dec 2021 23:48:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gerhard Engleder <gerhard@engleder-embedded.com>
Cc:     kbuild-all@lists.01.org, linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master 73/178] tsnep_main.c:undefined reference to
 `devm_ioremap_resource'
Message-ID: <202112162324.xLL408eY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   a33d805b322583a3505e95f3e57eada81cac34bd
commit: 403f69bbdbadb2e601f725be2d00b4ccc7b61c9d [73/178] tsnep: Add TSN endpoint Ethernet MAC driver
config: s390-randconfig-r035-20211216 (https://download.01.org/0day-ci/archive/20211216/202112162324.xLL408eY-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=403f69bbdbadb2e601f725be2d00b4ccc7b61c9d
        git remote add bluetooth-next https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
        git fetch --no-tags bluetooth-next master
        git checkout 403f69bbdbadb2e601f725be2d00b4ccc7b61c9d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: kernel/dma/coherent.o: in function `dma_init_coherent_memory':
   coherent.c:(.text+0xf8): undefined reference to `memremap'
   s390-linux-ld: coherent.c:(.text+0x236): undefined reference to `memunmap'
   s390-linux-ld: kernel/dma/coherent.o: in function `dma_declare_coherent_memory':
   coherent.c:(.text+0x974): undefined reference to `memunmap'
   s390-linux-ld: drivers/dma/fsl-edma.o: in function `fsl_edma_probe':
   fsl-edma.c:(.text+0x1b3c): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: fsl-edma.c:(.text+0x1d30): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/idma64.o: in function `idma64_platform_probe':
   idma64.c:(.text+0x3374): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_detach':
   main.c:(.text+0x128): undefined reference to `iounmap'
   s390-linux-ld: main.c:(.text+0x1c4): undefined reference to `iounmap'
   s390-linux-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_probe':
   main.c:(.text+0x614): undefined reference to `ioremap'
   s390-linux-ld: main.c:(.text+0x7fa): undefined reference to `ioremap'
   s390-linux-ld: main.c:(.text+0x8ac): undefined reference to `iounmap'
   s390-linux-ld: main.c:(.text+0x92e): undefined reference to `iounmap'
   s390-linux-ld: drivers/tty/ipwireless/main.o: in function `config_ipwireless':
   main.c:(.text+0xe56): undefined reference to `iounmap'
   s390-linux-ld: main.c:(.text+0xede): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/com90xx.o: in function `com90xx_exit':
   com90xx.c:(.exit.text+0xa6): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/com90xx.o: in function `check_mirror':
   com90xx.c:(.init.text+0x68): undefined reference to `ioremap'
   s390-linux-ld: com90xx.c:(.init.text+0xb0): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/com90xx.o: in function `com90xx_found':
   com90xx.c:(.init.text+0x1ba): undefined reference to `iounmap'
   s390-linux-ld: com90xx.c:(.init.text+0x356): undefined reference to `iounmap'
   s390-linux-ld: com90xx.c:(.init.text+0x578): undefined reference to `ioremap'
   s390-linux-ld: com90xx.c:(.init.text+0x782): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/com90xx.o: in function `com90xx_probe':
   com90xx.c:(.init.text+0x17c4): undefined reference to `ioremap'
   s390-linux-ld: com90xx.c:(.init.text+0x1bbe): undefined reference to `iounmap'
   s390-linux-ld: com90xx.c:(.init.text+0x299c): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/altera/altera_tse_main.o: in function `request_and_map':
   altera_tse_main.c:(.text+0x136a): undefined reference to `devm_ioremap'
   s390-linux-ld: drivers/net/ethernet/engleder/tsnep_main.o: in function `tsnep_probe':
>> tsnep_main.c:(.text+0x1de6): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/net/ethernet/fujitsu/fmvj18x_cs.o: in function `fmvj18x_get_hwinfo':
   fmvj18x_cs.c:(.text+0x1974): undefined reference to `ioremap'
   s390-linux-ld: fmvj18x_cs.c:(.text+0x1b4a): undefined reference to `iounmap'
   s390-linux-ld: fmvj18x_cs.c:(.text+0x1ba0): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/fujitsu/fmvj18x_cs.o: in function `fmvj18x_config':
   fmvj18x_cs.c:(.text+0x2620): undefined reference to `ioremap'
   s390-linux-ld: fmvj18x_cs.c:(.text+0x26ae): undefined reference to `iounmap'
   s390-linux-ld: fmvj18x_cs.c:(.text+0x2d50): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/fujitsu/fmvj18x_cs.o: in function `fmvj18x_detach':
   fmvj18x_cs.c:(.text+0x3012): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/smsc/smc91c92_cs.o: in function `smc91c92_config':
   smc91c92_cs.c:(.text+0x35da): undefined reference to `ioremap'
   s390-linux-ld: smc91c92_cs.c:(.text+0x464c): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/smsc/smc91c92_cs.o: in function `smc91c92_detach':
   smc91c92_cs.c:(.text+0x4ca4): undefined reference to `iounmap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
   cistpl.c:(.text+0x5aa): undefined reference to `ioremap'
   s390-linux-ld: cistpl.c:(.text+0x642): undefined reference to `iounmap'
   s390-linux-ld: cistpl.c:(.text+0x6b4): undefined reference to `iounmap'
   s390-linux-ld: cistpl.c:(.text+0x6e4): undefined reference to `ioremap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
   cistpl.c:(.text+0x22a2): undefined reference to `iounmap'
   s390-linux-ld: drivers/media/rc/ir-hix5hd2.o: in function `hix5hd2_ir_probe':
   ir-hix5hd2.c:(.text+0x6cc): undefined reference to `devm_platform_ioremap_resource'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
