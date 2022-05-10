Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A31CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 May 2022 06:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbiEJGfn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 May 2022 02:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbiEJGfk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 May 2022 02:35:40 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681F520E0A2
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 May 2022 23:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652164304; x=1683700304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sGT6Lk6VZXkYvjn4lCkVzZ+1RF+pZif2jf3OmwjZypw=;
  b=OQcVwDygnNn5bkSz0LpO5/wD8vRnIMFtao/ca9JAn8F+4W9F1Wla5bPd
   e87osLKdhN8PtdO3/4IXJQGz+0l9UyYSlXpzCxr8JNUZoLvDMol0TOcfy
   244h0hBEq74ZgV+4PjifgYhN0UU1dJpIvvZq3qr8/H4dcRQxljDHVUjnP
   P+KpWgkfs9XmV6DMrOFW9geen2jM5vO6h0i21RpZIRmVRJ0W9Nwv/DYwk
   o28nGTHIqU6eYJGvJ4y9AwtFvdi2rtCNl4tgGiWmnkiRlD2Y/YATngV4z
   BdKjDA8nC7edNJaXppLS8+dPD7zqMvwqDlBi7fi3AN/RWoBBeXZafQIYb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="268943807"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="268943807"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 23:31:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="657502286"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 09 May 2022 23:31:42 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noJPJ-000HQI-Ia;
        Tue, 10 May 2022 06:31:41 +0000
Date:   Tue, 10 May 2022 14:31:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brian Gix <brian.gix@intel.com>, linux-bluetooth@vger.kernel.org
Cc:     kbuild-all@lists.01.org, marcel@holtmann.org, luiz.dentz@gmail.com,
        brian.gix@intel.com
Subject: Re: [PATCH v2 1/2] Bluetooth: Implement support for Mesh
Message-ID: <202205101417.mzQSH5lc-lkp@intel.com>
References: <20220509220512.482695-2-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509220512.482695-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on bluetooth-next/master v5.18-rc6 next-20220509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Brian-Gix/Add-Mesh-functionality-to-net-bluetooth/20220510-060608
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
config: arc-randconfig-s031-20220509 (https://download.01.org/0day-ci/archive/20220510/202205101417.mzQSH5lc-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/ec86301e787dba99c6afd77e40a4b5af142ef944
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Brian-Gix/Add-Mesh-functionality-to-net-bluetooth/20220510-060608
        git checkout ec86301e787dba99c6afd77e40a4b5af142ef944
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash net/bluetooth/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   net/bluetooth/mgmt.c:4102:29: sparse: sparse: restricted __le16 degrades to integer
   net/bluetooth/mgmt.c:4841:9: sparse: sparse: cast to restricted __le32
>> net/bluetooth/mgmt.c:10121:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le64 [usertype] instant @@     got unsigned int [usertype] instant @@
   net/bluetooth/mgmt.c:10121:21: sparse:     expected restricted __le64 [usertype] instant
   net/bluetooth/mgmt.c:10121:21: sparse:     got unsigned int [usertype] instant

vim +10121 net/bluetooth/mgmt.c

 10069	
 10070	static void mesh_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr,
 10071			       u8 addr_type, s8 rssi, u32 flags, u8 *eir, u16 eir_len,
 10072			       u8 *scan_rsp, u8 scan_rsp_len, u32 instant)
 10073	{
 10074		struct sk_buff *skb;
 10075		struct mgmt_ev_mesh_device_found *ev;
 10076		int i, j;
 10077	
 10078		if (!hdev->mesh_ad_types[0])
 10079			goto accepted;
 10080	
 10081		/* Scan for requested AD types */
 10082		if (eir_len > 0) {
 10083			for (i = 0; i + 1 < eir_len; i += eir[i] + 1) {
 10084				for (j = 0; j < sizeof(hdev->mesh_ad_types); j++) {
 10085					if (!hdev->mesh_ad_types[j])
 10086						break;
 10087	
 10088					if (hdev->mesh_ad_types[j] == eir[i + 1])
 10089						goto accepted;
 10090				}
 10091			}
 10092		}
 10093	
 10094		if (scan_rsp_len > 0) {
 10095			for (i = 0; i + 1 < scan_rsp_len; i += scan_rsp[i] + 1) {
 10096				for (j = 0; j < sizeof(hdev->mesh_ad_types); j++) {
 10097					if (!hdev->mesh_ad_types[j])
 10098						break;
 10099	
 10100					if (hdev->mesh_ad_types[j] == scan_rsp[i + 1])
 10101						goto accepted;
 10102				}
 10103			}
 10104		}
 10105	
 10106		return;
 10107	
 10108	
 10109	accepted:
 10110		skb = mgmt_alloc_skb(hdev, MGMT_EV_MESH_DEVICE_FOUND,
 10111				     sizeof(*ev) + eir_len + scan_rsp_len);
 10112		if (!skb)
 10113			return;
 10114	
 10115		ev = skb_put(skb, sizeof(*ev));
 10116	
 10117		bacpy(&ev->addr.bdaddr, bdaddr);
 10118		ev->addr.type = link_to_bdaddr(LE_LINK, addr_type);
 10119		ev->rssi = rssi;
 10120		ev->flags = cpu_to_le32(flags);
 10121		ev->instant = instant;
 10122	
 10123		if (eir_len > 0)
 10124			/* Copy EIR or advertising data into event */
 10125			skb_put_data(skb, eir, eir_len);
 10126	
 10127		if (scan_rsp_len > 0)
 10128			/* Append scan response data to event */
 10129			skb_put_data(skb, scan_rsp, scan_rsp_len);
 10130	
 10131		ev->eir_len = cpu_to_le16(eir_len + scan_rsp_len);
 10132	
 10133		mgmt_event_skb(skb, NULL);
 10134	}
 10135	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
