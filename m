Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66183221F10;
	Thu,  6 Mar 2025 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279081; cv=none; b=nPttkcBBNNjR6boVpBV+TCWKGzjyM/wyomtnQorq5LpPHFHXNlk925YCrF0TB11Vold6hGRUHGcm3deAppH8TJeeJYcTal/mcgpVjm4PbqvqTCPrikT49n4cO4huM3AUOGxKyzn0U8403KW5LRYmSGVzIGUBvoYQs1/v/4Z6jr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279081; c=relaxed/simple;
	bh=IsYlA1pLnu2lPgka8Es27hJXGLId8UclLTRhAvqtl8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wus85pHDpkDecNJBrsMvYY7fM4cylTLuC1bLybtrsRB/XFx+ZMxWRIq7cN/C+m4uyc9SQGQyLv8B0vSQRzVzPIrq6eQDBGGgJ4q3DbAWrHDbgUiXCS6yZhIpAWYYrmnhNZukh+5qUD8IIwL9FgbgHmKrv873oLwaYqXuEGl4e1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KcIRlrAO; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KcIRlrAO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741279080; x=1772815080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IsYlA1pLnu2lPgka8Es27hJXGLId8UclLTRhAvqtl8M=;
  b=KcIRlrAOEAZjib2uZWmpjlNsxFsU78c5/CS/1fIn6SVKVu8mwJgijPcB
   3bDaEPDQjAZC2Bhp1p7USdcdVOfd7QwAy5j0yP6zHRDB3+BXwyEaO8dpY
   6esWpinfhqEteN0N0uGsxp/nP8B3dFRcd5/dzGdsJpGhE+G9AYY2GeZUj
   Mh9Is2AM5luIfqio6VsBZ5NsHUFRjwNCCfaK1x+WJcNXrFVC6j0bzVRRb
   4lcEbVE+fFzFZZawT1EOwVHlGqbT/hlR1DlW666L2ciuEZvuUhxwTplkV
   hnAlW0kV4NKVPg1s1Y0Csf9A2FXY7oKO33NcBRGzqXOT7MtrTz+nYDgl6
   A==;
X-CSE-ConnectionGUID: YMV6RP5IQqeCojx6iqPTRQ==
X-CSE-MsgGUID: HuI0S3qgQSCWmGudMR085g==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42327332"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="42327332"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 08:37:59 -0800
X-CSE-ConnectionGUID: gg3mW5X9R8iM0K5KgoVBdw==
X-CSE-MsgGUID: MTPC3i0RR5mJXDT9hO30xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="123659819"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 06 Mar 2025 08:37:56 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqEE7-000NIg-2g;
	Thu, 06 Mar 2025 16:37:46 +0000
Date: Fri, 7 Mar 2025 00:36:27 +0800
From: kernel test robot <lkp@intel.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com, neeraj.sanjaykale@nxp.com
Subject: Re: [PATCH v1 2/3] Bluetooth: btnxpuart: Handle bootloader error
 during change baudrate
Message-ID: <202503070049.8e6dNvjC-lkp@intel.com>
References: <20250305134523.40111-2-neeraj.sanjaykale@nxp.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305134523.40111-2-neeraj.sanjaykale@nxp.com>

Hi Neeraj,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on bluetooth-next/master linus/master v6.14-rc5 next-20250306]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Neeraj-Sanjay-Kale/Bluetooth-btnxpuart-Handle-bootloader-error-during-change-baudrate/20250305-214856
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20250305134523.40111-2-neeraj.sanjaykale%40nxp.com
patch subject: [PATCH v1 2/3] Bluetooth: btnxpuart: Handle bootloader error during change baudrate
config: i386-buildonly-randconfig-001-20250306 (https://download.01.org/0day-ci/archive/20250307/202503070049.8e6dNvjC-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250307/202503070049.8e6dNvjC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503070049.8e6dNvjC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/bluetooth/btnxpuart.c:1104:6: warning: variable 'len' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    1104 |         if (!req->error) {
         |             ^~~~~~~~~~~
   drivers/bluetooth/btnxpuart.c:1168:28: note: uninitialized use occurs here
    1168 |         nxpdev->fw_v3_prev_sent = len;
         |                                   ^~~
   drivers/bluetooth/btnxpuart.c:1104:2: note: remove the 'if' if its condition is always true
    1104 |         if (!req->error) {
         |         ^~~~~~~~~~~~~~~~
    1105 |                 nxp_send_ack(NXP_ACK_V3, hdev);
    1106 |                 if (nxpdev->timeout_changed == cmd_sent)
    1107 |                         nxpdev->timeout_changed = changed;
    1108 |                 if (nxpdev->baudrate_changed == cmd_sent)
    1109 |                         nxpdev->baudrate_changed = changed;
    1110 |         } else {
         |           ~~~~~~
    1111 |                 nxp_handle_fw_download_error(hdev, req);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1112 |                 if (nxpdev->timeout_changed == cmd_sent &&
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1113 |                     req->error == NXP_CRC_RX_ERROR) {
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1114 |                         nxpdev->fw_v3_offset_correction -= nxpdev->fw_v3_prev_sent;
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1115 |                         nxpdev->timeout_changed = not_changed;
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1116 |                 }
         |                 ~
    1117 |                 /* After baudrate change, it is normal to get ACK Timeout error */
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1118 |                 if (nxpdev->baudrate_changed == cmd_sent &&
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1119 |                     req->error == NXP_CRC_RX_ERROR) {
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/bluetooth/btnxpuart.c:1101:6: warning: variable 'len' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    1101 |         if (!req || !nxpdev->fw)
         |             ^~~~~~~~~~~~~~~~~~~
   drivers/bluetooth/btnxpuart.c:1168:28: note: uninitialized use occurs here
    1168 |         nxpdev->fw_v3_prev_sent = len;
         |                                   ^~~
   drivers/bluetooth/btnxpuart.c:1101:2: note: remove the 'if' if its condition is always false
    1101 |         if (!req || !nxpdev->fw)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
    1102 |                 goto free_skb;
         |                 ~~~~~~~~~~~~~
>> drivers/bluetooth/btnxpuart.c:1101:6: warning: variable 'len' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
    1101 |         if (!req || !nxpdev->fw)
         |             ^~~~
   drivers/bluetooth/btnxpuart.c:1168:28: note: uninitialized use occurs here
    1168 |         nxpdev->fw_v3_prev_sent = len;
         |                                   ^~~
   drivers/bluetooth/btnxpuart.c:1101:6: note: remove the '||' if its condition is always false
    1101 |         if (!req || !nxpdev->fw)
         |             ^~~~~~~
   drivers/bluetooth/btnxpuart.c:1097:6: warning: variable 'len' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    1097 |         if (!process_boot_signature(nxpdev))
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bluetooth/btnxpuart.c:1168:28: note: uninitialized use occurs here
    1168 |         nxpdev->fw_v3_prev_sent = len;
         |                                   ^~~
   drivers/bluetooth/btnxpuart.c:1097:2: note: remove the 'if' if its condition is always false
    1097 |         if (!process_boot_signature(nxpdev))
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1098 |                 goto free_skb;
         |                 ~~~~~~~~~~~~~
   drivers/bluetooth/btnxpuart.c:1094:11: note: initialize the variable 'len' to silence this warning
    1094 |         __u16 len;
         |                  ^
         |                   = 0
   4 warnings generated.


vim +1104 drivers/bluetooth/btnxpuart.c

27489364299a2d Neeraj Sanjay Kale     2024-06-14  1089  
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1090  static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1091  {
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1092  	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1093  	struct v3_data_req *req;
9e080b53dafae5 Luiz Augusto von Dentz 2023-04-17  1094  	__u16 len;
9e080b53dafae5 Luiz Augusto von Dentz 2023-04-17  1095  	__u32 offset;
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1096  
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1097  	if (!process_boot_signature(nxpdev))
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1098  		goto free_skb;
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1099  
9e080b53dafae5 Luiz Augusto von Dentz 2023-04-17  1100  	req = skb_pull_data(skb, sizeof(*req));
689ca16e523278 Neeraj Sanjay Kale     2023-03-16 @1101  	if (!req || !nxpdev->fw)
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1102  		goto free_skb;
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1103  
27489364299a2d Neeraj Sanjay Kale     2024-06-14 @1104  	if (!req->error) {
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1105  		nxp_send_ack(NXP_ACK_V3, hdev);
5bf71799df5728 Neeraj Sanjay Kale     2025-03-05  1106  		if (nxpdev->timeout_changed == cmd_sent)
5bf71799df5728 Neeraj Sanjay Kale     2025-03-05  1107  			nxpdev->timeout_changed = changed;
5bf71799df5728 Neeraj Sanjay Kale     2025-03-05  1108  		if (nxpdev->baudrate_changed == cmd_sent)
5bf71799df5728 Neeraj Sanjay Kale     2025-03-05  1109  			nxpdev->baudrate_changed = changed;
27489364299a2d Neeraj Sanjay Kale     2024-06-14  1110  	} else {
27489364299a2d Neeraj Sanjay Kale     2024-06-14  1111  		nxp_handle_fw_download_error(hdev, req);
5bf71799df5728 Neeraj Sanjay Kale     2025-03-05  1112  		if (nxpdev->timeout_changed == cmd_sent &&
5bf71799df5728 Neeraj Sanjay Kale     2025-03-05  1113  		    req->error == NXP_CRC_RX_ERROR) {
5bf71799df5728 Neeraj Sanjay Kale     2025-03-05  1114  			nxpdev->fw_v3_offset_correction -= nxpdev->fw_v3_prev_sent;
5bf71799df5728 Neeraj Sanjay Kale     2025-03-05  1115  			nxpdev->timeout_changed = not_changed;
5bf71799df5728 Neeraj Sanjay Kale     2025-03-05  1116  		}
5bf71799df5728 Neeraj Sanjay Kale     2025-03-05  1117  		/* After baudrate change, it is normal to get ACK Timeout error */
5bf71799df5728 Neeraj Sanjay Kale     2025-03-05  1118  		if (nxpdev->baudrate_changed == cmd_sent &&
5bf71799df5728 Neeraj Sanjay Kale     2025-03-05  1119  		    req->error == NXP_CRC_RX_ERROR) {
5bf71799df5728 Neeraj Sanjay Kale     2025-03-05  1120  			nxpdev->fw_v3_offset_correction -= nxpdev->fw_v3_prev_sent;
5bf71799df5728 Neeraj Sanjay Kale     2025-03-05  1121  			nxpdev->baudrate_changed = not_changed;
5bf71799df5728 Neeraj Sanjay Kale     2025-03-05  1122  		}
27489364299a2d Neeraj Sanjay Kale     2024-06-14  1123  		goto free_skb;
27489364299a2d Neeraj Sanjay Kale     2024-06-14  1124  	}
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1125  
9e080b53dafae5 Luiz Augusto von Dentz 2023-04-17  1126  	len = __le16_to_cpu(req->len);
9e080b53dafae5 Luiz Augusto von Dentz 2023-04-17  1127  
5bf71799df5728 Neeraj Sanjay Kale     2025-03-05  1128  	if (nxpdev->timeout_changed != changed) {
5bf71799df5728 Neeraj Sanjay Kale     2025-03-05  1129  		nxp_fw_change_timeout(hdev, len);
5bf71799df5728 Neeraj Sanjay Kale     2025-03-05  1130  		nxpdev->timeout_changed = cmd_sent;
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1131  		goto free_skb;
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1132  	}
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1133  
5bf71799df5728 Neeraj Sanjay Kale     2025-03-05  1134  	if (nxpdev->baudrate_changed != changed) {
5bf71799df5728 Neeraj Sanjay Kale     2025-03-05  1135  		if (nxp_fw_change_baudrate(hdev, len)) {
5bf71799df5728 Neeraj Sanjay Kale     2025-03-05  1136  			nxpdev->baudrate_changed = cmd_sent;
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1137  			serdev_device_set_baudrate(nxpdev->serdev,
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1138  						   HCI_NXP_SEC_BAUDRATE);
b0310d6ed684b8 Neeraj Sanjay Kale     2023-04-19  1139  			serdev_device_set_flow_control(nxpdev->serdev, true);
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1140  			nxpdev->current_baudrate = HCI_NXP_SEC_BAUDRATE;
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1141  		}
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1142  		goto free_skb;
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1143  	}
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1144  
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1145  	if (req->len == 0) {
2684dd614ccf08 Neeraj Sanjay Kale     2024-05-15  1146  		bt_dev_info(hdev, "FW Download Complete: %zu bytes",
9e080b53dafae5 Luiz Augusto von Dentz 2023-04-17  1147  			   nxpdev->fw->size);
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1148  		clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1149  		wake_up_interruptible(&nxpdev->fw_dnld_done_wait_q);
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1150  		goto free_skb;
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1151  	}
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1152  
9e080b53dafae5 Luiz Augusto von Dentz 2023-04-17  1153  	offset = __le32_to_cpu(req->offset);
9e080b53dafae5 Luiz Augusto von Dentz 2023-04-17  1154  	if (offset < nxpdev->fw_v3_offset_correction) {
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1155  		/* This scenario should ideally never occur. But if it ever does,
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1156  		 * FW is out of sync and needs a power cycle.
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1157  		 */
9e080b53dafae5 Luiz Augusto von Dentz 2023-04-17  1158  		bt_dev_err(hdev, "Something went wrong during FW download");
9e080b53dafae5 Luiz Augusto von Dentz 2023-04-17  1159  		bt_dev_err(hdev, "Please power cycle and try again");
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1160  		goto free_skb;
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1161  	}
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1162  
e3c4891098c875 Neeraj Sanjay Kale     2024-05-15  1163  	nxpdev->fw_dnld_v3_offset = offset - nxpdev->fw_v3_offset_correction;
e3c4891098c875 Neeraj Sanjay Kale     2024-05-15  1164  	serdev_device_write_buf(nxpdev->serdev, nxpdev->fw->data +
e3c4891098c875 Neeraj Sanjay Kale     2024-05-15  1165  				nxpdev->fw_dnld_v3_offset, len);
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1166  
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1167  free_skb:
5bf71799df5728 Neeraj Sanjay Kale     2025-03-05  1168  	nxpdev->fw_v3_prev_sent = len;
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1169  	kfree_skb(skb);
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1170  	return 0;
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1171  }
689ca16e523278 Neeraj Sanjay Kale     2023-03-16  1172  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
