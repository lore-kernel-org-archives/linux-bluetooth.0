Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B03FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 May 2022 06:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbiEKGOe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 May 2022 02:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiEKGOc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 May 2022 02:14:32 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2DC1E780E
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 May 2022 23:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652249671; x=1683785671;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fOQm9sMLAQfrwE5YjT3GqlCZj40MIkQKIqMV8yNeiZk=;
  b=biGwEJ/WcDyPKSvwoVmFiyINEUgiV0rQYdL1bfoQ8Te5ePDpq1F7rlGZ
   wgbKhT2Hem+liOTAuwUfM5q72zQnqR2hc0nE/XVAVkGl38ZAHb7xDmdU+
   x4EaVVfPIJ6c92C7UHGWKzBPU7mmGdtiOrwE9+rM2cOl93Bt7O5w/AibZ
   jQhmmb9gVA/PoVDh8qNHoMNoiw3XTMZ2RmVrTGjYDZVNTJCSrw7jQkrCO
   r9px6AVCuqLd6N6xtbyaoa3jYhH4QQkwCiNh/kvyp4DvBrCWtXrLRYgt5
   wVSBZAEEE8yif1v+zDDyma86RaIn3y1Z8bXeYeW8UQXYxQmQy7jevG0ih
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="356024235"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="356024235"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 23:14:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="670235200"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 10 May 2022 23:14:29 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nofcC-000In2-Nb;
        Wed, 11 May 2022 06:14:28 +0000
Date:   Wed, 11 May 2022 14:14:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brian Gix <brian.gix@intel.com>, linux-bluetooth@vger.kernel.org
Cc:     kbuild-all@lists.01.org, marcel@holtmann.org, luiz.dentz@gmail.com,
        brian.gix@intel.com
Subject: Re: [PATCH v3 1/2] Bluetooth: Implement support for Mesh
Message-ID: <202205111458.9JnirKIH-lkp@intel.com>
References: <20220510214325.633935-2-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510214325.633935-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on bluetooth-next/master v5.18-rc6 next-20220510]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Brian-Gix/Add-Mesh-functionality-to-net-bluetooth/20220511-054524
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
config: i386-randconfig-s002-20220509 (https://download.01.org/0day-ci/archive/20220511/202205111458.9JnirKIH-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/bea4eccd2f7e8b93f2fba58d72cd4803105baf4f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Brian-Gix/Add-Mesh-functionality-to-net-bluetooth/20220511-054524
        git checkout bea4eccd2f7e8b93f2fba58d72cd4803105baf4f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash net/bluetooth/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   net/bluetooth/mgmt.c:4093:29: sparse: sparse: restricted __le16 degrades to integer
   net/bluetooth/mgmt.c:4832:9: sparse: sparse: cast to restricted __le32
>> net/bluetooth/mgmt.c:10112:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le64 [usertype] instant @@     got unsigned long long [usertype] instant @@
   net/bluetooth/mgmt.c:10112:21: sparse:     expected restricted __le64 [usertype] instant
   net/bluetooth/mgmt.c:10112:21: sparse:     got unsigned long long [usertype] instant

vim +10112 net/bluetooth/mgmt.c

 10060	
 10061	static void mesh_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr,
 10062			              u8 addr_type, s8 rssi, u32 flags, u8 *eir,
 10063				      u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len,
 10064				      u64 instant)
 10065	{
 10066		struct sk_buff *skb;
 10067		struct mgmt_ev_mesh_device_found *ev;
 10068		int i, j;
 10069	
 10070		if (!hdev->mesh_ad_types[0])
 10071			goto accepted;
 10072	
 10073		/* Scan for requested AD types */
 10074		if (eir_len > 0) {
 10075			for (i = 0; i + 1 < eir_len; i += eir[i] + 1) {
 10076				for (j = 0; j < sizeof(hdev->mesh_ad_types); j++) {
 10077					if (!hdev->mesh_ad_types[j])
 10078						break;
 10079	
 10080					if (hdev->mesh_ad_types[j] == eir[i + 1])
 10081						goto accepted;
 10082				}
 10083			}
 10084		}
 10085	
 10086		if (scan_rsp_len > 0) {
 10087			for (i = 0; i + 1 < scan_rsp_len; i += scan_rsp[i] + 1) {
 10088				for (j = 0; j < sizeof(hdev->mesh_ad_types); j++) {
 10089					if (!hdev->mesh_ad_types[j])
 10090						break;
 10091	
 10092					if (hdev->mesh_ad_types[j] == scan_rsp[i + 1])
 10093						goto accepted;
 10094				}
 10095			}
 10096		}
 10097	
 10098		return;
 10099	
 10100	accepted:
 10101		skb = mgmt_alloc_skb(hdev, MGMT_EV_MESH_DEVICE_FOUND,
 10102				     sizeof(*ev) + eir_len + scan_rsp_len);
 10103		if (!skb)
 10104			return;
 10105	
 10106		ev = skb_put(skb, sizeof(*ev));
 10107	
 10108		bacpy(&ev->addr.bdaddr, bdaddr);
 10109		ev->addr.type = link_to_bdaddr(LE_LINK, addr_type);
 10110		ev->rssi = rssi;
 10111		ev->flags = cpu_to_le32(flags);
 10112		ev->instant = instant;
 10113	
 10114		if (eir_len > 0)
 10115			/* Copy EIR or advertising data into event */
 10116			skb_put_data(skb, eir, eir_len);
 10117	
 10118		if (scan_rsp_len > 0)
 10119			/* Append scan response data to event */
 10120			skb_put_data(skb, scan_rsp, scan_rsp_len);
 10121	
 10122		ev->eir_len = cpu_to_le16(eir_len + scan_rsp_len);
 10123	
 10124		mgmt_event_skb(skb, NULL);
 10125	}
 10126	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
