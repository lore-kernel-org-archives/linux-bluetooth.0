Return-Path: <SRS0=apyX=5I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EEEC54EEB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Mar 2020 17:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811AF20714
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Mar 2020 17:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgCWRbF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:31:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:24967 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727361AbgCWRbE (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Mar 2020 13:31:04 -0400
IronPort-SDR: qDOYna11EGW58qJMrb1cdsLYlIbllNO/m1UOeNNzmAChXGOyk7WxfIPLv6Ce2hx3dQKqQ4b/yC
 pcP5nVzFs5RA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 10:31:03 -0700
IronPort-SDR: PhVRXb+pnQjTToX4cEJut03Ts8ohTXfY4NnEKeKCSGJRMEoUCQu8rmpH8rNcjY6W4jCwWGUdUG
 Rkc7fI2Y1ROg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,297,1580803200"; 
   d="scan'208";a="392983699"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 23 Mar 2020 10:31:00 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jGQuj-0000k8-Ff; Tue, 24 Mar 2020 01:31:01 +0800
Date:   Tue, 24 Mar 2020 01:30:28 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     kbuild-all@lists.01.org,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] Bluetooth: btusb: Read the supported features of
 Microsoft vendor extension
Message-ID: <202003240100.nVNDVhCu%lkp@intel.com>
References: <20200323002820.v1.2.I4e01733fa5b818028dc9188ca91438fc54aa5028@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323002820.v1.2.I4e01733fa5b818028dc9188ca91438fc54aa5028@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao-chen,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on next-20200323]
[cannot apply to v5.6-rc7]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Miao-chen-Chou/btusb-Introduce-the-use-of-vendor-extension-s/20200323-165723
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-187-gbff9b106-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> net/bluetooth/hci_event.c:1793:32: sparse: sparse: cast to restricted __le16
>> net/bluetooth/hci_event.c:1810:47: sparse: sparse: cast to restricted __le64
   arch/x86/include/asm/bitops.h:77:37: sparse: sparse: cast truncates bits from constant value (ffffff7f becomes 7f)
   arch/x86/include/asm/bitops.h:77:37: sparse: sparse: cast truncates bits from constant value (ffffff7f becomes 7f)
   arch/x86/include/asm/bitops.h:77:37: sparse: sparse: cast truncates bits from constant value (ffffff7f becomes 7f)
   arch/x86/include/asm/bitops.h:77:37: sparse: sparse: cast truncates bits from constant value (ffffff7f becomes 7f)
   arch/x86/include/asm/bitops.h:77:37: sparse: sparse: cast truncates bits from constant value (ffffff7f becomes 7f)

vim +1793 net/bluetooth/hci_event.c

  1788	
  1789	static void hci_cc_msft_vnd_ext(struct hci_dev *hdev, struct sk_buff *skb)
  1790	{
  1791		struct msft_cmd_cmp_info *info = (void *)skb->data;
  1792		const u8 status = info->status;
> 1793		const u16 sub_opcode = __le16_to_cpu(info->sub_opcode);
  1794	
  1795		skb_pull(skb, sizeof(*info));
  1796	
  1797		if (status) {
  1798			BT_ERR("Microsoft vendor extension sub command 0x%2.2x failed",
  1799			       sub_opcode);
  1800			return;
  1801		}
  1802	
  1803		BT_DBG("%s status 0x%2.2x sub opcode 0x%2.2x", hdev->name, status,
  1804		       sub_opcode);
  1805	
  1806		switch (sub_opcode) {
  1807		case MSFT_OP_READ_SUPPORTED_FEATURES: {
  1808			struct msft_rp_read_supported_features *rp = (void *)skb->data;
  1809	
> 1810			hdev->msft_vnd_ext_features = __le64_to_cpu(rp->features);
  1811			hdev->msft_vnd_ext_evt_prefix_len = rp->msft_evt_prefix_len;
  1812			hdev->msft_vnd_ext_evt_prefix =
  1813				kmalloc(hdev->msft_vnd_ext_evt_prefix_len, GFP_ATOMIC);
  1814			if (!hdev->msft_vnd_ext_evt_prefix)
  1815				return;
  1816	
  1817			memcpy(hdev->msft_vnd_ext_evt_prefix, rp->msft_evt_prefix,
  1818			       hdev->msft_vnd_ext_evt_prefix_len);
  1819			BT_DBG("%s Microsoft vendor extension features 0x%016llx",
  1820			       hdev->name, hdev->msft_vnd_ext_features);
  1821			break;
  1822		}
  1823		default:
  1824			BT_ERR("%s unknown sub opcode 0x%2.2x", hdev->name,
  1825			       sub_opcode);
  1826			break;
  1827		}
  1828	}
  1829	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
