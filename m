Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D89C001B0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Aug 2023 15:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbjHJPIb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Aug 2023 11:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbjHJPIa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Aug 2023 11:08:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02DF2686
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Aug 2023 08:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691680110; x=1723216110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j1eJcU+Wp+UDTBxlpC5tXTYQ+z6Qross9BmF4GN/Zro=;
  b=e+aVy54A2JvUZNRtkAcNHvOgVfT24I/cbpomIwVnlCdKnf5UyHAQzgKD
   hjIvVHRj4TIiuN8R1wnc/GV6H8A0xX+802mbFfR/0PRPDGfNRqFrTah72
   r2oik5zlYVM42AQRoTs4twSJZCab5/WhQXJEssCCe2Cr/9ycoRhk33V58
   6qTOKO1QI7ZNEbtgb4G9QYQ9up8yqrdFBeTU3v2r7KxsZIXsw2v7acKIp
   Pi64MdoaNQKuzebrwCZeSdHGv+rFnQSqeL1eJubrXrxntJz+IFwIssuzW
   +9A3Vs6Ld9633NI/sML2PuXZNnKyx9ptVlqx86Ew9otChlhRWgf2PuWz9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="361564411"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="361564411"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 08:08:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="822275065"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="822275065"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Aug 2023 08:08:12 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qU7Gl-00074i-37;
        Thu, 10 Aug 2023 15:08:11 +0000
Date:   Thu, 10 Aug 2023 23:08:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lokendra Singh <lokendra.singh@intel.com>,
        linux-bluetooth@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com, luiz.von.dentz@intel.com,
        kiran.k@intel.com, seema.sreemantha@intel.com,
        Lokendra Singh <lokendra.singh@intel.com>
Subject: Re: [PATCH v1] Bluetooth: btintel: Send new command for PPAG
Message-ID: <202308102242.EKYkZi8t-lkp@intel.com>
References: <20230810105502.27012-1-lokendra.singh@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810105502.27012-1-lokendra.singh@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Lokendra,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on bluetooth/master linus/master v6.5-rc5 next-20230809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lokendra-Singh/Bluetooth-btintel-Send-new-command-for-PPAG/20230810-185334
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20230810105502.27012-1-lokendra.singh%40intel.com
patch subject: [PATCH v1] Bluetooth: btintel: Send new command for PPAG
config: x86_64-randconfig-x011-20230810 (https://download.01.org/0day-ci/archive/20230810/202308102242.EKYkZi8t-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230810/202308102242.EKYkZi8t-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308102242.EKYkZi8t-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/bluetooth/btintel.c: In function 'btintel_set_ppag':
   drivers/bluetooth/btintel.c:2404:36: error: storage size of 'ppag_cmd' isn't known
    2404 |         struct hci_ppag_enable_cmd ppag_cmd;
         |                                    ^~~~~~~~
>> drivers/bluetooth/btintel.c:2404:36: warning: unused variable 'ppag_cmd' [-Wunused-variable]


vim +/ppag_cmd +2404 drivers/bluetooth/btintel.c

  2399	
  2400	static void btintel_set_ppag(struct hci_dev *hdev, struct intel_version_tlv *ver)
  2401	{
  2402		struct btintel_ppag ppag;
  2403		struct sk_buff *skb;
> 2404		struct hci_ppag_enable_cmd ppag_cmd;
  2405		acpi_handle handle;
  2406	
  2407		/* PPAG is not supported if CRF is HrP2, Jfp2, JfP1 */
  2408		switch (ver->cnvr_top & 0xFFF) {
  2409		case 0x504:     /* Hrp2 */
  2410		case 0x202:     /* Jfp2 */
  2411		case 0x201:     /* Jfp1 */
  2412			bt_dev_warn(hdev, "PPAG not supported for Intel CNVr (0x%3x)",
  2413				    ver->cnvr_top & 0xFFF);
  2414			return;
  2415		}
  2416	
  2417		handle = ACPI_HANDLE(GET_HCIDEV_DEV(hdev));
  2418		if (!handle) {
  2419			bt_dev_info(hdev, "No support for BT device in ACPI firmware");
  2420			return;
  2421		}
  2422	
  2423		memset(&ppag, 0, sizeof(ppag));
  2424	
  2425		ppag.hdev = hdev;
  2426		ppag.status = AE_NOT_FOUND;
  2427		acpi_walk_namespace(ACPI_TYPE_PACKAGE, handle, 1, NULL,
  2428				    btintel_ppag_callback, &ppag, NULL);
  2429	
  2430		if (ACPI_FAILURE(ppag.status)) {
  2431			if (ppag.status == AE_NOT_FOUND) {
  2432				bt_dev_dbg(hdev, "PPAG-BT: ACPI entry not found");
  2433				return;
  2434			}
  2435			return;
  2436		}
  2437	
  2438		if (ppag.domain != 0x12) {
  2439			bt_dev_warn(hdev, "PPAG-BT: Bluetooth domain is disabled in ACPI firmware");
  2440			return;
  2441		}
  2442	
  2443		/* PPAG mode
  2444		 * BIT 0 : 0 Disabled in EU
  2445		 *         1 Enabled in EU
  2446		 * BIT 1 : 0 Disabled in China
  2447		 *         1 Enabled in China
  2448		 */
  2449		if((ppag.mode & 0x01) != BIT(0) && (ppag.mode & 0x02) != BIT(1)) {
  2450			bt_dev_warn(hdev, "PPAG-BT: EU, China mode are disabled in CB/BIOS");
  2451			return;
  2452		}
  2453	
  2454		/* HCI_Intel_PpagEnable_CMD - opcode: 0xFE0B
  2455		 * ppag_enable_flags - ppag mode
  2456		 */
  2457		ppag_cmd.ppag_enable_flags = ppag.mode;
  2458	
  2459		skb = __hci_cmd_sync(hdev, 0xfe0b, sizeof(ppag_cmd), &ppag_cmd, HCI_CMD_TIMEOUT);
  2460		if (IS_ERR(skb)) {
  2461			bt_dev_warn(hdev, "Failed to send PPAG Enable (%ld)", PTR_ERR(skb));
  2462			return;
  2463		}
  2464		bt_dev_info(hdev, "PPAG-BT: Enabled (Mode %d)", ppag.mode);
  2465		kfree_skb(skb);
  2466	}
  2467	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
