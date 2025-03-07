Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048E61DFF8
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Mar 2025 02:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741313083; cv=none; b=IC9y/zO5XGYm16MW+NqMbv1PcoxyEBehIvTaMZEtg/LvK2MwCuP1FHsiOYa1CPdCaolbdJan5RdQA+rD2vd4QT8aphMmjPALlV5jKkKTNdnueBkc9Cum36srnXNA8zFn9KXRE42mubocjz9/e6d2dyquCGewwoj01/58+oPUPjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741313083; c=relaxed/simple;
	bh=bpGSGxPqKqhelnhrxz3eWTpgjlz+pymbAsoKYg720fc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fLHcArjlf8eGDSuz4L/fnKu+W3Z35yphsjAHKh7e0IyTo/7Tw679u31RGJNufk0WIuvB3VT6Zu5iu6en6jH077ZJmj47SESZ9c/eOg74wSSCEO8hlIJniBh72/PKNIsA0gK+PiEsMPhi2b96Ze+bRBIZrGvAF/t8VP//Q755MUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kTjQDZ9n; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kTjQDZ9n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741313081; x=1772849081;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bpGSGxPqKqhelnhrxz3eWTpgjlz+pymbAsoKYg720fc=;
  b=kTjQDZ9nV2TD0CsIV8l5KLC2xyAEUaB8JpRegfjEKN4I9HNpD0c1G6Cj
   ERbX9MCuPNutVWuJoXIHAfp0dndWVxqy1TWUM7Jy8jSciAVtaGoKTOr6G
   d6/8WgnjlL5USKn/3D3bU4Yltl1QzLxPketYrcFCCkzoH8hsfldlCzwMU
   CcoFRU05HZ8Uo7GicmQBalXRPZaMvHFIQOVw25gBCNxDXvuLgMvEVCWU7
   +O9koY0btOrmg7Q1lM53ITg/WI7VKZD+aiHfL2Ge94aP3ntci1sa+dt/m
   MVPJU29tFmYnXVhlCd+paZTyLKWrg53sJjJcmwbvrvOF3TlE3EwWL1B7C
   A==;
X-CSE-ConnectionGUID: bJGYLy6kQF+WVV15EaUZ1w==
X-CSE-MsgGUID: J1bai4LjSviXzKiNWbY8BA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42208948"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42208948"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 18:04:41 -0800
X-CSE-ConnectionGUID: ezDq5dK+TbWs9DMgZLM/qQ==
X-CSE-MsgGUID: JyWY8C5tQOqJ5EjDNbCyHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119117246"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 06 Mar 2025 18:04:39 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqN4l-000NvI-2M;
	Fri, 07 Mar 2025 02:04:35 +0000
Date: Fri, 7 Mar 2025 10:04:26 +0800
From: kernel test robot <lkp@intel.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [bluetooth-next:master 40/43] drivers/bluetooth/btnxpuart.c:1683:15:
 error: 'struct hci_dev' has no member named 'cmd_timeout'; did you mean
 'cmd_timer'?
Message-ID: <202503070916.OR4VIRZh-lkp@intel.com>
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
commit: b21ae0e8b43797d7c9c3ae1d97a0257686e24005 [40/43] Bluetooth: btnxpuart: Add support for HCI coredump feature
config: sh-randconfig-002-20250307 (https://download.01.org/0day-ci/archive/20250307/202503070916.OR4VIRZh-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250307/202503070916.OR4VIRZh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503070916.OR4VIRZh-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/bluetooth/btnxpuart.c: In function 'nxp_serdev_probe':
>> drivers/bluetooth/btnxpuart.c:1683:15: error: 'struct hci_dev' has no member named 'cmd_timeout'; did you mean 'cmd_timer'?
    1683 |         hdev->cmd_timeout = nxp_cmd_timeout;
         |               ^~~~~~~~~~~
         |               cmd_timer


vim +1683 drivers/bluetooth/btnxpuart.c

  1629	
  1630	static int nxp_serdev_probe(struct serdev_device *serdev)
  1631	{
  1632		struct hci_dev *hdev;
  1633		struct btnxpuart_dev *nxpdev;
  1634	
  1635		nxpdev = devm_kzalloc(&serdev->dev, sizeof(*nxpdev), GFP_KERNEL);
  1636		if (!nxpdev)
  1637			return -ENOMEM;
  1638	
  1639		nxpdev->nxp_data = (struct btnxpuart_data *)device_get_match_data(&serdev->dev);
  1640	
  1641		nxpdev->serdev = serdev;
  1642		serdev_device_set_drvdata(serdev, nxpdev);
  1643	
  1644		serdev_device_set_client_ops(serdev, &btnxpuart_client_ops);
  1645	
  1646		INIT_WORK(&nxpdev->tx_work, btnxpuart_tx_work);
  1647		skb_queue_head_init(&nxpdev->txq);
  1648	
  1649		init_waitqueue_head(&nxpdev->fw_dnld_done_wait_q);
  1650		init_waitqueue_head(&nxpdev->check_boot_sign_wait_q);
  1651	
  1652		device_property_read_u32(&nxpdev->serdev->dev, "fw-init-baudrate",
  1653					 &nxpdev->fw_init_baudrate);
  1654		if (!nxpdev->fw_init_baudrate)
  1655			nxpdev->fw_init_baudrate = FW_INIT_BAUDRATE;
  1656	
  1657		set_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
  1658	
  1659		crc8_populate_msb(crc8_table, POLYNOMIAL8);
  1660	
  1661		/* Initialize and register HCI device */
  1662		hdev = hci_alloc_dev();
  1663		if (!hdev) {
  1664			dev_err(&serdev->dev, "Can't allocate HCI device\n");
  1665			return -ENOMEM;
  1666		}
  1667	
  1668		nxpdev->hdev = hdev;
  1669	
  1670		hdev->bus = HCI_UART;
  1671		hci_set_drvdata(hdev, nxpdev);
  1672	
  1673		hdev->manufacturer = MANUFACTURER_NXP;
  1674		hdev->open  = btnxpuart_open;
  1675		hdev->close = btnxpuart_close;
  1676		hdev->flush = btnxpuart_flush;
  1677		hdev->setup = nxp_setup;
  1678		hdev->post_init = nxp_post_init;
  1679		hdev->send  = nxp_enqueue;
  1680		hdev->hw_error = nxp_hw_err;
  1681		hdev->shutdown = nxp_shutdown;
  1682		hdev->wakeup = nxp_wakeup;
> 1683		hdev->cmd_timeout = nxp_cmd_timeout;
  1684		SET_HCIDEV_DEV(hdev, &serdev->dev);
  1685	
  1686		if (hci_register_dev(hdev) < 0) {
  1687			dev_err(&serdev->dev, "Can't register HCI device\n");
  1688			goto probe_fail;
  1689		}
  1690	
  1691		if (ps_setup(hdev))
  1692			goto probe_fail;
  1693	
  1694		hci_devcd_register(hdev, nxp_coredump, nxp_coredump_hdr, NULL);
  1695	
  1696		return 0;
  1697	
  1698	probe_fail:
  1699		hci_free_dev(hdev);
  1700		return -ENODEV;
  1701	}
  1702	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
