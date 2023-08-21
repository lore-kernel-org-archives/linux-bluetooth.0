Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200ADEE4993
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 13:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbjHUNE1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 09:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbjHUNE0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 09:04:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98B0E3
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 06:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692623061; x=1724159061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cI93qn5e3LNC5GFx2NC4TLSJmFd5o4x4tWtl4ZL61E4=;
  b=M52FoWLui6udvoH5caVim1UyYz1nnttRAtKzgCD4n9pQzmMETInbreX4
   BX2fyZLJqfC2rBMBoWMEddKLLL22aUyFkNqMzshcUnzSuS6wAXJU2l52z
   q4ljwFJi6/8/Kh9SwK0HeG/+iRpt/dzc54NE6SdnpEVyhKkqB3T+gpljp
   hBoEDNe6jZZ1BraUvDy6pzUyK7nBop5lco7y0PqBFtEgIS6rRm5aXl93g
   5e6KWj8EcQmqr3d6sPChsvk1CIaBaG4VFLXYzZzo3ch+PE6Md44FqvYkR
   /cu7wBXcAa1m2aETnS+VBP1T3l9GNQVoalhMzuwr/m0jz4ogDhL8bvCcg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="353898829"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="353898829"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 06:04:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="765361592"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="765361592"
Received: from lkp-server02.sh.intel.com (HELO 6809aa828f2a) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2023 06:04:18 -0700
Received: from kbuild by 6809aa828f2a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qY4Zt-0000VA-2e;
        Mon, 21 Aug 2023 13:04:17 +0000
Date:   Mon, 21 Aug 2023 21:03:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] Bluetooth: hci_core: Fix missing instances using
 HCI_MAX_AD_LENGTH
Message-ID: <202308212004.EXsdDWkd-lkp@intel.com>
References: <20230818212211.3207580-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818212211.3207580-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

kernel test robot noticed the following build errors:

[auto build test ERROR on linux-next/master]
[also build test ERROR on linus/master v6.5-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luiz-Augusto-von-Dentz/Bluetooth-hci_core-Fix-missing-instances-using-HCI_MAX_AD_LENGTH/20230821-102220
base:   linux-next/master
patch link:    https://lore.kernel.org/r/20230818212211.3207580-1-luiz.dentz%40gmail.com
patch subject: [PATCH] Bluetooth: hci_core: Fix missing instances using HCI_MAX_AD_LENGTH
config: i386-buildonly-randconfig-002-20230821 (https://download.01.org/0day-ci/archive/20230821/202308212004.EXsdDWkd-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230821/202308212004.EXsdDWkd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308212004.EXsdDWkd-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/bluetooth/eir.c:36:19: error: use of undeclared identifier 'dev'; did you mean 'hdev'?
           if ((max_adv_len(dev) - ad_len) < HCI_MAX_SHORT_NAME_LENGTH + 3)
                            ^~~
                            hdev
   include/net/bluetooth/hci_core.h:1854:19: note: expanded from macro 'max_adv_len'
           (ext_adv_capable(dev) ? HCI_MAX_EXT_AD_LENGTH : HCI_MAX_AD_LENGTH)
                            ^
   include/net/bluetooth/hci_core.h:1850:33: note: expanded from macro 'ext_adv_capable'
   #define ext_adv_capable(dev) (((dev)->le_features[1] & HCI_LE_EXT_ADV))
                                   ^
   include/linux/compiler.h:55:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                                                 ^
   include/linux/compiler.h:57:52: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                      ^
   net/bluetooth/eir.c:30:42: note: 'hdev' declared here
   u8 eir_append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
                                            ^
>> net/bluetooth/eir.c:36:19: error: use of undeclared identifier 'dev'; did you mean 'hdev'?
           if ((max_adv_len(dev) - ad_len) < HCI_MAX_SHORT_NAME_LENGTH + 3)
                            ^~~
                            hdev
   include/net/bluetooth/hci_core.h:1854:19: note: expanded from macro 'max_adv_len'
           (ext_adv_capable(dev) ? HCI_MAX_EXT_AD_LENGTH : HCI_MAX_AD_LENGTH)
                            ^
   include/net/bluetooth/hci_core.h:1850:33: note: expanded from macro 'ext_adv_capable'
   #define ext_adv_capable(dev) (((dev)->le_features[1] & HCI_LE_EXT_ADV))
                                   ^
   include/linux/compiler.h:55:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                                                 ^
   include/linux/compiler.h:57:61: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                               ^
   net/bluetooth/eir.c:30:42: note: 'hdev' declared here
   u8 eir_append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
                                            ^
>> net/bluetooth/eir.c:36:19: error: use of undeclared identifier 'dev'; did you mean 'hdev'?
           if ((max_adv_len(dev) - ad_len) < HCI_MAX_SHORT_NAME_LENGTH + 3)
                            ^~~
                            hdev
   include/net/bluetooth/hci_core.h:1854:19: note: expanded from macro 'max_adv_len'
           (ext_adv_capable(dev) ? HCI_MAX_EXT_AD_LENGTH : HCI_MAX_AD_LENGTH)
                            ^
   include/net/bluetooth/hci_core.h:1850:33: note: expanded from macro 'ext_adv_capable'
   #define ext_adv_capable(dev) (((dev)->le_features[1] & HCI_LE_EXT_ADV))
                                   ^
   include/linux/compiler.h:55:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                                                 ^
   include/linux/compiler.h:57:86: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                                        ^
   include/linux/compiler.h:68:3: note: expanded from macro '__trace_if_value'
           (cond) ?                                        \
            ^
   net/bluetooth/eir.c:30:42: note: 'hdev' declared here
   u8 eir_append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
                                            ^
   3 errors generated.


vim +36 net/bluetooth/eir.c

    29	
    30	u8 eir_append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
    31	{
    32		size_t short_len;
    33		size_t complete_len;
    34	
    35		/* no space left for name (+ NULL + type + len) */
  > 36		if ((max_adv_len(dev) - ad_len) < HCI_MAX_SHORT_NAME_LENGTH + 3)
    37			return ad_len;
    38	
    39		/* use complete name if present and fits */
    40		complete_len = strnlen(hdev->dev_name, sizeof(hdev->dev_name));
    41		if (complete_len && complete_len <= HCI_MAX_SHORT_NAME_LENGTH)
    42			return eir_append_name(ptr, ad_len, EIR_NAME_COMPLETE,
    43					       hdev->dev_name, complete_len + 1);
    44	
    45		/* use short name if present */
    46		short_len = strnlen(hdev->short_name, sizeof(hdev->short_name));
    47		if (short_len)
    48			return eir_append_name(ptr, ad_len, EIR_NAME_SHORT,
    49					       hdev->short_name,
    50					       short_len == HCI_MAX_SHORT_NAME_LENGTH ?
    51					       short_len : short_len + 1);
    52	
    53		/* use shortened full name if present, we already know that name
    54		 * is longer then HCI_MAX_SHORT_NAME_LENGTH
    55		 */
    56		if (complete_len)
    57			return eir_append_name(ptr, ad_len, EIR_NAME_SHORT,
    58					       hdev->dev_name,
    59					       HCI_MAX_SHORT_NAME_LENGTH);
    60	
    61		return ad_len;
    62	}
    63	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
