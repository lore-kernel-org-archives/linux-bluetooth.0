Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92694C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Mar 2022 07:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbiCZHbq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Mar 2022 03:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiCZHbp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Mar 2022 03:31:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D596554B6
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Mar 2022 00:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648279809; x=1679815809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OV9YWzfST4f2QUwBxvkzNpuNm2sMQrseHUCCEETmQ08=;
  b=JXd8a8FbK50bNRgluGif9lML+Sy7cpDmA+FhYVo9/rP+LIFUOE7z/Spf
   H+zx/s03RuWwONjPgAqQVnOo3bXfbhmN2Psxg3IDPEvQ+J2QuIMqYPCXu
   hfaQcfp6HprEK2q9IjG0CyT+JY9iUPO37SPEIaJxzGcdNIvmeGavaBfok
   01FGXLX8STlSBrQ6rVuX7UEv/QFMbkO1swkJ+LLXU8yJH0CouGzOriwZL
   S7EDj3StpkPagDdQxfdvfVA/BxpgXLOfjnuyhgyjFx+3rGB4IaGJ/sJe5
   toAnsArVON1SEu96C31z+7EZ7mIjCcaj5n2mcpn/Jk9S+UE7eYXBjhx1Z
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="238701923"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="238701923"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 00:30:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="520446047"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 26 Mar 2022 00:30:07 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nY0sA-000N8d-Vh; Sat, 26 Mar 2022 07:30:06 +0000
Date:   Sat, 26 Mar 2022 15:30:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH 2/2] Bluetooth: Print broken quirks
Message-ID: <202203261536.VslNAaC7-lkp@intel.com>
References: <20220325211314.425364-2-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325211314.425364-2-luiz.dentz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

I love your patch! Perhaps something to improve:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on next-20220325]
[cannot apply to bluetooth/master v5.17]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Luiz-Augusto-von-Dentz/Bluetooth-HCI-Add-HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN-quirk/20220326-051551
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220326/202203261536.VslNAaC7-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/5ca7f4a3fcd3584b663e15b4c3d8230918b8971d
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Luiz-Augusto-von-Dentz/Bluetooth-HCI-Add-HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN-quirk/20220326-051551
        git checkout 5ca7f4a3fcd3584b663e15b4c3d8230918b8971d
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> net/bluetooth/hci_sync.c:3837:3: sparse: sparse: symbol 'hci_broken_table' was not declared. Should it be static?

vim +/hci_broken_table +3837 net/bluetooth/hci_sync.c

  3833	
  3834	struct hci_broken {
  3835		unsigned long quirk;
  3836		const char *desc;
> 3837	} hci_broken_table[] = {
  3838		HCI_BROKEN(HCI_QUIRK_BROKEN_LOCAL_COMMANDS,
  3839			   "HCI Read Local Supported Commands not supported"),
  3840		HCI_BROKEN(HCI_QUIRK_BROKEN_STORED_LINK_KEY,
  3841			   "HCI Delete Stored Link Key command is advertised, "
  3842			   "but not supported."),
  3843		HCI_BROKEN(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING,
  3844			   "HCI Read Default Erroneous Data Reporting command is "
  3845			   "advertised, but not supported."),
  3846		HCI_BROKEN(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER,
  3847			   "HCI Read Transmit Power Level command is advertised, "
  3848			   "but not supported."),
  3849		HCI_BROKEN(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL,
  3850			   "HCI Set Event Filter command not supported."),
  3851		HCI_BROKEN(HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN,
  3852			   "HCI Enhanced Setup Synchronous Connection command is "
  3853			   "advertised, but not supported.")
  3854	};
  3855	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
