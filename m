Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D6B3C39
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jul 2024 01:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721438096; cv=none; b=fJBngeiiLbtcFkiU3VI4M0HMDhqjw2SqtrIY6tMJz8cJwNQUeAiGAI07LbvmKNzqVnmOt49avqv9W1JJolxYb8++Akdlt4ZzGFxtDKCt7Zf3KQk1pwzZgYNSQ+LLmT14gqP8/oOlqkO8hMqTS2g58xGjVXu6ZgtiITUGN1FgEkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721438096; c=relaxed/simple;
	bh=EiwzmvPrc6O0rACpHwhYJJ7C4u4suDuZgWg4IcUDI9c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Mb8aZh3dVE4ouQbA64BQskcafK6qVc/xRnzlhWet3Y9vxXi+HPpOFfmDSIq7Rq76XxrMwPO8B2y+KNCRGl81fqPiSSFmTB0iBFJF1aOaLJp0LmcoSzK1JV4mxJgGugVg0JyNm9tW8M8FmwoaFkXXdvvGh/90X9i/5DfD86KhLhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h+YXG/iE; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+YXG/iE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721438095; x=1752974095;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EiwzmvPrc6O0rACpHwhYJJ7C4u4suDuZgWg4IcUDI9c=;
  b=h+YXG/iEVLA7QtbdDjinqepiGb/lP82TFbzqF82KYkwLJ5+dlEP8M88f
   zEZjJdxV92jNmNEUyQuWLTuFcwYAqpU8R1BxAkPIQnyz7lHlVjG0u7Lqc
   m74cndkw567tRE/yIRDJfi6yHaff+GLuEXq7IHwhwdO9peAsPspLgav80
   +Nnk4ewPlAp6qt+KUIQn5wITjEzRcoc92KHvrdSIivczLSkS+EYQgZNey
   9aqoQCyP+AROtMKi8LFePgNe55dTM4Pzq6lXT9uZs7YzQdeOYKnF5nzhh
   AYJUnERoZDFRqlNccN39dGqLwn0AZB9TKweoQmoAm6HYYFSUZNlRtPEPc
   w==;
X-CSE-ConnectionGUID: k37dTJ8XTpeC+aLe1Q8rzg==
X-CSE-MsgGUID: XgNf2cOlSD6bNO90E594KA==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="29695491"
X-IronPort-AV: E=Sophos;i="6.09,222,1716274800"; 
   d="scan'208";a="29695491"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 18:14:54 -0700
X-CSE-ConnectionGUID: dGiujs/QRKurGH+KpIKb1A==
X-CSE-MsgGUID: vvaxMoHITeu+ucVrWWsMQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,222,1716274800"; 
   d="scan'208";a="51555266"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 19 Jul 2024 18:14:52 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUygU-000ij8-1F;
	Sat, 20 Jul 2024 01:14:50 +0000
Date: Sat, 20 Jul 2024 09:13:59 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Lu <chris.lu@mediatek.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [bluetooth-next:master 74/74] drivers/bluetooth/btusb.c:2705:15:
 error: implicit declaration of function 'btmtk_usb_subsys_reset'
Message-ID: <202407200917.Dv9hKccL-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   52828ea60dfdd05246fc92dedfad1c8bbfa2dd66
commit: 52828ea60dfdd05246fc92dedfad1c8bbfa2dd66 [74/74] Bluetooth: btmtk: Fix btmtk.c undefined reference build error
config: csky-randconfig-001-20240720 (https://download.01.org/0day-ci/archive/20240720/202407200917.Dv9hKccL-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240720/202407200917.Dv9hKccL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407200917.Dv9hKccL-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/bluetooth/btusb.c: In function 'btusb_mtk_reset':
>> drivers/bluetooth/btusb.c:2705:15: error: implicit declaration of function 'btmtk_usb_subsys_reset' [-Wimplicit-function-declaration]
    2705 |         err = btmtk_usb_subsys_reset(hdev, btmtk_data->dev_id);
         |               ^~~~~~~~~~~~~~~~~~~~~~
   drivers/bluetooth/btusb.c: In function 'btusb_send_frame_mtk':
>> drivers/bluetooth/btusb.c:2720:23: error: implicit declaration of function 'alloc_mtk_intr_urb' [-Wimplicit-function-declaration]
    2720 |                 urb = alloc_mtk_intr_urb(hdev, skb, btusb_tx_complete);
         |                       ^~~~~~~~~~~~~~~~~~
>> drivers/bluetooth/btusb.c:2720:21: error: assignment to 'struct urb *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    2720 |                 urb = alloc_mtk_intr_urb(hdev, skb, btusb_tx_complete);
         |                     ^
   drivers/bluetooth/btusb.c: In function 'btusb_mtk_setup':
>> drivers/bluetooth/btusb.c:2749:16: error: implicit declaration of function 'btmtk_usb_setup' [-Wimplicit-function-declaration]
    2749 |         return btmtk_usb_setup(hdev);
         |                ^~~~~~~~~~~~~~~
   drivers/bluetooth/btusb.c: In function 'btusb_mtk_shutdown':
>> drivers/bluetooth/btusb.c:2760:16: error: implicit declaration of function 'btmtk_usb_shutdown'; did you mean 'btusb_mtk_shutdown'? [-Wimplicit-function-declaration]
    2760 |         return btmtk_usb_shutdown(hdev);
         |                ^~~~~~~~~~~~~~~~~~
         |                btusb_mtk_shutdown
   drivers/bluetooth/btusb.c: In function 'btusb_probe':
>> drivers/bluetooth/btusb.c:3869:34: error: 'btmtk_usb_recv_acl' undeclared (first use in this function); did you mean 'btusb_recv_acl'?
    3869 |                 data->recv_acl = btmtk_usb_recv_acl;
         |                                  ^~~~~~~~~~~~~~~~~~
         |                                  btusb_recv_acl
   drivers/bluetooth/btusb.c:3869:34: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/bluetooth/btusb.c:3870:33: error: 'btmtk_usb_suspend' undeclared (first use in this function)
    3870 |                 data->suspend = btmtk_usb_suspend;
         |                                 ^~~~~~~~~~~~~~~~~
>> drivers/bluetooth/btusb.c:3871:32: error: 'btmtk_usb_resume' undeclared (first use in this function)
    3871 |                 data->resume = btmtk_usb_resume;
         |                                ^~~~~~~~~~~~~~~~


vim +/btmtk_usb_subsys_reset +2705 drivers/bluetooth/btusb.c

ceac1cb0259de6 Chris Lu  2024-07-04  2682  
4c0c28f2bbec0c Hao Qin   2024-05-15  2683  static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
4c0c28f2bbec0c Hao Qin   2024-05-15  2684  {
4c0c28f2bbec0c Hao Qin   2024-05-15  2685  	struct btusb_data *data = hci_get_drvdata(hdev);
d3e6236053958a Chris Lu  2024-07-04  2686  	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
4c0c28f2bbec0c Hao Qin   2024-05-15  2687  	int err;
4c0c28f2bbec0c Hao Qin   2024-05-15  2688  
4c0c28f2bbec0c Hao Qin   2024-05-15  2689  	/* It's MediaTek specific bluetooth reset mechanism via USB */
5c5e8c52e3cafa Chris Lu  2024-07-04  2690  	if (test_and_set_bit(BTMTK_HW_RESET_ACTIVE, &btmtk_data->flags)) {
4c0c28f2bbec0c Hao Qin   2024-05-15  2691  		bt_dev_err(hdev, "last reset failed? Not resetting again");
4c0c28f2bbec0c Hao Qin   2024-05-15  2692  		return -EBUSY;
4c0c28f2bbec0c Hao Qin   2024-05-15  2693  	}
25b6d7593a3af7 Jing Cai  2023-06-29  2694  
4c0c28f2bbec0c Hao Qin   2024-05-15  2695  	err = usb_autopm_get_interface(data->intf);
4c0c28f2bbec0c Hao Qin   2024-05-15  2696  	if (err < 0)
4c0c28f2bbec0c Hao Qin   2024-05-15  2697  		return err;
4c0c28f2bbec0c Hao Qin   2024-05-15  2698  
ceac1cb0259de6 Chris Lu  2024-07-04  2699  	if (test_bit(BTMTK_ISOPKT_RUNNING, &btmtk_data->flags))
ceac1cb0259de6 Chris Lu  2024-07-04  2700  		btusb_mtk_release_iso_intf(data);
ceac1cb0259de6 Chris Lu  2024-07-04  2701  
4c0c28f2bbec0c Hao Qin   2024-05-15  2702  	btusb_stop_traffic(data);
4c0c28f2bbec0c Hao Qin   2024-05-15  2703  	usb_kill_anchored_urbs(&data->tx_anchor);
4c0c28f2bbec0c Hao Qin   2024-05-15  2704  
5c5e8c52e3cafa Chris Lu  2024-07-04 @2705  	err = btmtk_usb_subsys_reset(hdev, btmtk_data->dev_id);
4c0c28f2bbec0c Hao Qin   2024-05-15  2706  
4c0c28f2bbec0c Hao Qin   2024-05-15  2707  	usb_queue_reset_device(data->intf);
5c5e8c52e3cafa Chris Lu  2024-07-04  2708  	clear_bit(BTMTK_HW_RESET_ACTIVE, &btmtk_data->flags);
25b6d7593a3af7 Jing Cai  2023-06-29  2709  
25b6d7593a3af7 Jing Cai  2023-06-29  2710  	return err;
25b6d7593a3af7 Jing Cai  2023-06-29  2711  }
25b6d7593a3af7 Jing Cai  2023-06-29  2712  
ceac1cb0259de6 Chris Lu  2024-07-04  2713  static int btusb_send_frame_mtk(struct hci_dev *hdev, struct sk_buff *skb)
ceac1cb0259de6 Chris Lu  2024-07-04  2714  {
ceac1cb0259de6 Chris Lu  2024-07-04  2715  	struct urb *urb;
ceac1cb0259de6 Chris Lu  2024-07-04  2716  
ceac1cb0259de6 Chris Lu  2024-07-04  2717  	BT_DBG("%s", hdev->name);
ceac1cb0259de6 Chris Lu  2024-07-04  2718  
ceac1cb0259de6 Chris Lu  2024-07-04  2719  	if (hci_skb_pkt_type(skb) == HCI_ISODATA_PKT) {
ceac1cb0259de6 Chris Lu  2024-07-04 @2720  		urb = alloc_mtk_intr_urb(hdev, skb, btusb_tx_complete);
ceac1cb0259de6 Chris Lu  2024-07-04  2721  		if (IS_ERR(urb))
ceac1cb0259de6 Chris Lu  2024-07-04  2722  			return PTR_ERR(urb);
ceac1cb0259de6 Chris Lu  2024-07-04  2723  
ceac1cb0259de6 Chris Lu  2024-07-04  2724  		return submit_or_queue_tx_urb(hdev, urb);
ceac1cb0259de6 Chris Lu  2024-07-04  2725  	} else {
ceac1cb0259de6 Chris Lu  2024-07-04  2726  		return btusb_send_frame(hdev, skb);
ceac1cb0259de6 Chris Lu  2024-07-04  2727  	}
ceac1cb0259de6 Chris Lu  2024-07-04  2728  }
ceac1cb0259de6 Chris Lu  2024-07-04  2729  
a1c49c434e1505 Sean Wang 2019-06-02  2730  static int btusb_mtk_setup(struct hci_dev *hdev)
a1c49c434e1505 Sean Wang 2019-06-02  2731  {
a1c49c434e1505 Sean Wang 2019-06-02  2732  	struct btusb_data *data = hci_get_drvdata(hdev);
5c5e8c52e3cafa Chris Lu  2024-07-04  2733  	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
0b70151328781a Jing Cai  2023-06-29  2734  
5c5e8c52e3cafa Chris Lu  2024-07-04  2735  	/* MediaTek WMT vendor cmd requiring below USB resources to
5c5e8c52e3cafa Chris Lu  2024-07-04  2736  	 * complete the handshake.
ccfc8948d7e4d9 Hao Qin   2024-05-15  2737  	 */
5c5e8c52e3cafa Chris Lu  2024-07-04  2738  	btmtk_data->drv_name = btusb_driver.name;
5c5e8c52e3cafa Chris Lu  2024-07-04  2739  	btmtk_data->intf = data->intf;
5c5e8c52e3cafa Chris Lu  2024-07-04  2740  	btmtk_data->udev = data->udev;
5c5e8c52e3cafa Chris Lu  2024-07-04  2741  	btmtk_data->ctrl_anchor = &data->ctrl_anchor;
5c5e8c52e3cafa Chris Lu  2024-07-04  2742  	btmtk_data->reset_sync = btusb_mtk_reset;
ccfc8948d7e4d9 Hao Qin   2024-05-15  2743  
ceac1cb0259de6 Chris Lu  2024-07-04  2744  	/* Claim ISO data interface and endpoint */
ceac1cb0259de6 Chris Lu  2024-07-04  2745  	btmtk_data->isopkt_intf = usb_ifnum_to_if(data->udev, MTK_ISO_IFNUM);
ceac1cb0259de6 Chris Lu  2024-07-04  2746  	if (btmtk_data->isopkt_intf)
ceac1cb0259de6 Chris Lu  2024-07-04  2747  		btusb_mtk_claim_iso_intf(data);
ceac1cb0259de6 Chris Lu  2024-07-04  2748  
5c5e8c52e3cafa Chris Lu  2024-07-04 @2749  	return btmtk_usb_setup(hdev);
a1c49c434e1505 Sean Wang 2019-06-02  2750  }
a1c49c434e1505 Sean Wang 2019-06-02  2751  
a1c49c434e1505 Sean Wang 2019-06-02  2752  static int btusb_mtk_shutdown(struct hci_dev *hdev)
a1c49c434e1505 Sean Wang 2019-06-02  2753  {
ceac1cb0259de6 Chris Lu  2024-07-04  2754  	struct btusb_data *data = hci_get_drvdata(hdev);
ceac1cb0259de6 Chris Lu  2024-07-04  2755  	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
ceac1cb0259de6 Chris Lu  2024-07-04  2756  
ceac1cb0259de6 Chris Lu  2024-07-04  2757  	if (test_bit(BTMTK_ISOPKT_RUNNING, &btmtk_data->flags))
ceac1cb0259de6 Chris Lu  2024-07-04  2758  		btusb_mtk_release_iso_intf(data);
ceac1cb0259de6 Chris Lu  2024-07-04  2759  
5c5e8c52e3cafa Chris Lu  2024-07-04 @2760  	return btmtk_usb_shutdown(hdev);
a1c49c434e1505 Sean Wang 2019-06-02  2761  }
a1c49c434e1505 Sean Wang 2019-06-02  2762  

:::::: The code at line 2705 was first introduced by commit
:::::: 5c5e8c52e3cafaa6f71efd44a42a674271e5b3ad Bluetooth: btmtk: move btusb_mtk_[setup, shutdown] to btmtk.c

:::::: TO: Chris Lu <chris.lu@mediatek.com>
:::::: CC: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
