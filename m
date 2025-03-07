Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F50B1EB2A
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Mar 2025 02:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741313804; cv=none; b=oNEirRfeT7TvceSjTqE+LKEnQn/MQJ2uvkVw7BgH3gWflar+s0jUPdkNfyDazEZvUsSVrdS1fGPUDa3GZReinz+b0MgSnzOCNfxNf63ZQ6P4lbVmzOObZfRyiuw3SCRTa9p1K3gJLQ1uFrVNGPYHeFqR1Ww9H01/iSZ37KqH0QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741313804; c=relaxed/simple;
	bh=ZyOz/uYYyz/4EKksKGOyPQPJsAfnF6veO9NaJZPXjGw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oyv4S6+ZfS4bbxBhk9WZDT2q5HejvZLxn0SRqVFSYiF/VL8VwlVr5dwa8A0T05WDdUlzOl41n2u00wshbfMoHGoQVc6tmtKpeEeAtQBPjhvOqlBKFwsieyVH/Ge1TBggdR/eRnrQdcv5mGEQR0S7e0f09FK8XQ1l7U7mgpK4/48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5BoMT+A; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5BoMT+A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741313802; x=1772849802;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZyOz/uYYyz/4EKksKGOyPQPJsAfnF6veO9NaJZPXjGw=;
  b=Q5BoMT+Ai7ke8vQvNyENuDvQfVP5G1r6Y45zDRNWrUl5/mocCRwNhpQE
   2GH5jNOa2lcs1whpiQZ2h3JQ31dL3l7Ly7j0X4kaq/iTDdkeDGrS0ZbO5
   3Y79jmAaWOmO05CAx69LfMRiDrDTbm0+s1D0Y20auYfuQnaCpXbnaxOd5
   ImVEvBvDTAOzhmjHO9fA9nJgpISb3dZGLgUpBwNGBnCknrUzNvPGGyRey
   3ir2w18/vqdTeoGALSV6HGetTWMSYiK3dCThB31yPgNJg1CJiJSK2iNP8
   leFy2SJwo+1z6o6pmsyFql9P7UeOTILvQ5wstApHYvvggGh5xwdn++FCF
   w==;
X-CSE-ConnectionGUID: UiLf+CIDS8G/XsNrkxVzmA==
X-CSE-MsgGUID: 0vQi+UZ8TwGLXkuSLg5Ifg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="41603438"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="41603438"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 18:16:42 -0800
X-CSE-ConnectionGUID: XJlTi61CR2yzyZcjb20p5Q==
X-CSE-MsgGUID: h3JcmFGhRiG037c3y0o8vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119715707"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 06 Mar 2025 18:16:39 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqNGP-000NwD-0b;
	Fri, 07 Mar 2025 02:16:37 +0000
Date: Fri, 7 Mar 2025 10:15:41 +0800
From: kernel test robot <lkp@intel.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Johan Korsnes <johan.korsnes@remarkable.no>,
	Kristian Krohn <kristian.krohn@remarkable.no>
Subject: [bluetooth-next:master 42/43] drivers/bluetooth/btnxpuart.c:1322:15:
 error: use of undeclared identifier 'skb'
Message-ID: <202503071027.4Q1Nm5Zx-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   8968f507940cad09c8e2ecc4631f90d62709e17b
commit: 228c506481ea3f6ac5538188517c4a6f9feb5a26 [42/43] Bluetooth: btnxpuart: Add support to set BD address
config: x86_64-buildonly-randconfig-001-20250307 (https://download.01.org/0day-ci/archive/20250307/202503071027.4Q1Nm5Zx-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250307/202503071027.4Q1Nm5Zx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503071027.4Q1Nm5Zx-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/bluetooth/btnxpuart.c:1322:15: error: use of undeclared identifier 'skb'
    1322 |                            PTR_ERR(skb));
         |                                    ^
   drivers/bluetooth/btnxpuart.c:1724:8: error: no member named 'cmd_timeout' in 'struct hci_dev'; did you mean 'rpa_timeout'?
    1724 |         hdev->cmd_timeout = nxp_cmd_timeout;
         |               ^~~~~~~~~~~
         |               rpa_timeout
   include/net/bluetooth/hci_core.h:593:10: note: 'rpa_timeout' declared here
     593 |         __u32                   rpa_timeout;
         |                                 ^
   2 errors generated.


vim +/skb +1322 drivers/bluetooth/btnxpuart.c

  1308	
  1309	static int nxp_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
  1310	{
  1311		union nxp_set_bd_addr_payload pcmd;
  1312		int err;
  1313	
  1314		pcmd.data.param_id = 0xfe;
  1315		pcmd.data.param_len = 6;
  1316		memcpy(pcmd.data.param, bdaddr, 6);
  1317	
  1318		/* BD address can be assigned only after first reset command. */
  1319		err = __hci_cmd_sync_status(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
  1320		if (err) {
  1321			bt_dev_err(hdev, "Reset before setting local-bd-addr failed (%ld)",
> 1322				   PTR_ERR(skb));
  1323			return err;
  1324		}
  1325	
  1326		err = __hci_cmd_sync_status(hdev, HCI_NXP_SET_BD_ADDR, sizeof(pcmd),
  1327				     pcmd.buf, HCI_CMD_TIMEOUT);
  1328		if (err) {
  1329			bt_dev_err(hdev, "Changing device address failed (%d)", err);
  1330			return err;
  1331		}
  1332	
  1333		return 0;
  1334	}
  1335	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
