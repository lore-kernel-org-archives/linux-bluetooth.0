Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512E074C08;
	Sun,  9 Mar 2025 11:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741519063; cv=none; b=Avf1SN6ZKXRobITOX15vJQ5FbZSaC2c6rhq4vmi9y2Vu1Gmhb/kz6NcaCSerUsBKtsdJJ9d4oi9YOQxAAewcp6u7QJDlLaKj8BlVJO2s+0H3aD8f+mW3pck96fvCTwXia04PzQc4JbWtRAl9Lgk41UM9+fh8L2QKXIlPCqFGIeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741519063; c=relaxed/simple;
	bh=QSf+jvHlxj/q/MmnvoCuSlyJ7jRPtTkcssl0GlRqrOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZP1r9K2Hzb7F0en7Gxa2B6CQTz4KTEyPPnRLJKKjl58K9jgTrwa6TAHFg7uMap9QGWdh3isrnts3HQig9SLVi5g7WRdcL5dZc+PPh8axgv/mb7hIxmQuf/qaubGD+KYsinIeUHghPJIIQSgAxgyzUssWEsd/hRpPJjE/gmAbDaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RiZ855jm; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RiZ855jm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741519061; x=1773055061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QSf+jvHlxj/q/MmnvoCuSlyJ7jRPtTkcssl0GlRqrOE=;
  b=RiZ855jmQWBSz26S4zRkb7igb0MhIoLDl/cG7mUMOj1fmsaK0+Yc2t6Q
   A0RzMiUD3zYr6eWtyRR5YZpgY+hWpa8B184Br87513F57xfNfgxbkweaJ
   7JHmiPQCYZu6eGlHkzbbzHsWrCUSzt/P4NoILqTzpQeIqS8coxMpTVfLj
   KqHhLynN/7kbTO+lvKtx9dwryi0AwNuZxf6YO0D8CluvX54SbpgfGt+9z
   OKQsGqGLkFolPRwHhhm3NAK3c/XbA21DEaLXkjxwKd/qGP4xvDmjcBDmC
   uKjuH5AeR60lFH0SUQRuVc0CeVyKbbRYpqL4io0CLCtnG7491AM0IRcdk
   w==;
X-CSE-ConnectionGUID: arb/cAIPQz+UU8daj++qPQ==
X-CSE-MsgGUID: 5Enr/MEwTPCdgMIcF+wyYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42637762"
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="42637762"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 04:17:40 -0700
X-CSE-ConnectionGUID: 8vBYysMdRN67j6N62vJNtw==
X-CSE-MsgGUID: 4wn1WTrARm2da30ZvQlYVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="142962768"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 09 Mar 2025 04:17:39 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trEf2-00032E-1e;
	Sun, 09 Mar 2025 11:17:36 +0000
Date: Sun, 9 Mar 2025 19:16:38 +0800
From: kernel test robot <lkp@intel.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: Re: [PATCH v2 2/3] Bluetooth: btnxpuart: Handle bootloader error
 during cmd5 and cmd7
Message-ID: <202503091936.x9Evtskg-lkp@intel.com>
References: <20250306180931.57705-2-neeraj.sanjaykale@nxp.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306180931.57705-2-neeraj.sanjaykale@nxp.com>

Hi Neeraj,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on linus/master v6.14-rc5 next-20250307]
[cannot apply to bluetooth-next/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Neeraj-Sanjay-Kale/Bluetooth-btnxpuart-Handle-bootloader-error-during-cmd5-and-cmd7/20250307-021228
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20250306180931.57705-2-neeraj.sanjaykale%40nxp.com
patch subject: [PATCH v2 2/3] Bluetooth: btnxpuart: Handle bootloader error during cmd5 and cmd7
config: microblaze-randconfig-r123-20250309 (https://download.01.org/0day-ci/archive/20250309/202503091936.x9Evtskg-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250309/202503091936.x9Evtskg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503091936.x9Evtskg-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/bluetooth/btnxpuart.c:1113:24: sparse: sparse: restricted __le16 degrades to integer
   drivers/bluetooth/btnxpuart.c:1119:24: sparse: sparse: restricted __le16 degrades to integer

vim +1113 drivers/bluetooth/btnxpuart.c

  1089	
  1090	static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
  1091	{
  1092		struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
  1093		struct v3_data_req *req;
  1094		__u16 len = 0;
  1095		__u32 offset;
  1096	
  1097		if (!process_boot_signature(nxpdev))
  1098			goto free_skb;
  1099	
  1100		req = skb_pull_data(skb, sizeof(*req));
  1101		if (!req || !nxpdev->fw)
  1102			goto free_skb;
  1103	
  1104		if (!req->error) {
  1105			nxp_send_ack(NXP_ACK_V3, hdev);
  1106			if (nxpdev->timeout_changed == cmd_sent)
  1107				nxpdev->timeout_changed = changed;
  1108			if (nxpdev->baudrate_changed == cmd_sent)
  1109				nxpdev->baudrate_changed = changed;
  1110		} else {
  1111			nxp_handle_fw_download_error(hdev, req);
  1112			if (nxpdev->timeout_changed == cmd_sent &&
> 1113			    req->error == NXP_CRC_RX_ERROR) {
  1114				nxpdev->fw_v3_offset_correction -= nxpdev->fw_v3_prev_sent;
  1115				nxpdev->timeout_changed = not_changed;
  1116			}
  1117			/* After baudrate change, it is normal to get ACK Timeout error */
  1118			if (nxpdev->baudrate_changed == cmd_sent &&
  1119			    req->error == NXP_CRC_RX_ERROR) {
  1120				nxpdev->fw_v3_offset_correction -= nxpdev->fw_v3_prev_sent;
  1121				nxpdev->baudrate_changed = not_changed;
  1122			}
  1123			goto free_skb;
  1124		}
  1125	
  1126		len = __le16_to_cpu(req->len);
  1127	
  1128		if (nxpdev->timeout_changed != changed) {
  1129			nxp_fw_change_timeout(hdev, len);
  1130			nxpdev->timeout_changed = cmd_sent;
  1131			goto free_skb;
  1132		}
  1133	
  1134		if (nxpdev->baudrate_changed != changed) {
  1135			if (nxp_fw_change_baudrate(hdev, len)) {
  1136				nxpdev->baudrate_changed = cmd_sent;
  1137				serdev_device_set_baudrate(nxpdev->serdev,
  1138							   HCI_NXP_SEC_BAUDRATE);
  1139				serdev_device_set_flow_control(nxpdev->serdev, true);
  1140				nxpdev->current_baudrate = HCI_NXP_SEC_BAUDRATE;
  1141			}
  1142			goto free_skb;
  1143		}
  1144	
  1145		if (req->len == 0) {
  1146			bt_dev_info(hdev, "FW Download Complete: %zu bytes",
  1147				   nxpdev->fw->size);
  1148			clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
  1149			wake_up_interruptible(&nxpdev->fw_dnld_done_wait_q);
  1150			goto free_skb;
  1151		}
  1152	
  1153		offset = __le32_to_cpu(req->offset);
  1154		if (offset < nxpdev->fw_v3_offset_correction) {
  1155			/* This scenario should ideally never occur. But if it ever does,
  1156			 * FW is out of sync and needs a power cycle.
  1157			 */
  1158			bt_dev_err(hdev, "Something went wrong during FW download");
  1159			bt_dev_err(hdev, "Please power cycle and try again");
  1160			goto free_skb;
  1161		}
  1162	
  1163		nxpdev->fw_dnld_v3_offset = offset - nxpdev->fw_v3_offset_correction;
  1164		serdev_device_write_buf(nxpdev->serdev, nxpdev->fw->data +
  1165					nxpdev->fw_dnld_v3_offset, len);
  1166	
  1167	free_skb:
  1168		nxpdev->fw_v3_prev_sent = len;
  1169		kfree_skb(skb);
  1170		return 0;
  1171	}
  1172	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
