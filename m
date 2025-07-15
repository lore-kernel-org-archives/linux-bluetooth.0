Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65A5249E5
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 00:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752538363; cv=none; b=b/9rTpe98wsnWUDEnS8C14qXY4PjD0+qwqkl/G71ZFaoayLZz6YdoarUfZRozKy9jMFN4HFeMUXF+4khM9DUdtMb4t4NJPsBtGzlvpznwdjnRaRWI22bvhFNhUJfaRVhSsAEQ0weozd4Qfc3gddZRq6+EpoN11bYuM01yVcav10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752538363; c=relaxed/simple;
	bh=j9V2XeZ/WyEslZsdpjNSs69uSu0GwuWu57I/uXIFR/A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cFyGQed8MfZrj1QtKAwWMSqfoLTP/OlDTkPuGttLjCu5F70Z2Xl24Gqf2tWj4cZ0gUnCRdG/LCwLLMn4WSjbmixWmsaqvYLmTAYFV4ACar+zMHLSTFV2tx1nb7xjku5L9FKRKY/auu6XIlfSais9umFGKR2+1SeEnJxhmT1Fh+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H3jy/xvP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3jy/xvP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752538362; x=1784074362;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=j9V2XeZ/WyEslZsdpjNSs69uSu0GwuWu57I/uXIFR/A=;
  b=H3jy/xvPpsxsywCAcnXgoMclSa3UEb2tBxttiMvRZvp2MzzEdwviO21Z
   XhVfN0hM9KtVDGE7a0LomsI6WZD2p0Gdh9eLKQ40N2mehf6ghqHvHVZ+8
   wBkOd2VkTEpyjvhq+3dnX2BxKGSCQ908dJawUusBuQ8tlW6xeGppkKX7R
   SdhZy1OOIEcgLK4t3QJtKTfYm0lYBS42YkMu1APUscRXpf8sFESjd6Kgt
   Fqj1zfDgs1IPqRpl5n/+GpUCTQYzLygqcwiI/fveGeLZNyMyQHOy7V3fT
   87oyBbSzNH2KMnNMo+2zjgVwUEsoCVoum5uTio3dyaMQ9es3E3yxfOIUI
   w==;
X-CSE-ConnectionGUID: nr12L9b0R+uEQayR0NPQUw==
X-CSE-MsgGUID: 9eJoBStjTU6KsueKlg/mGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53856484"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="53856484"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 17:12:41 -0700
X-CSE-ConnectionGUID: JWmWg0XzQ6GNgHUUw9DuEw==
X-CSE-MsgGUID: nKOkFt9ERumjKLVciQ1OQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="156709230"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 14 Jul 2025 17:12:39 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubTHh-0009T9-1N;
	Tue, 15 Jul 2025 00:12:37 +0000
Date: Tue, 15 Jul 2025 08:11:40 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Eggers <ceggers@arri.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [bluetooth-next:master 90/90] drivers/bluetooth/hci_ll.c:652:48:
 error: no member named 'quirks' in 'struct hci_dev'
Message-ID: <202507150810.nsWLqAW3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   be736f5f89d519e58057ee40c3e09fbfc711d4dc
commit: be736f5f89d519e58057ee40c3e09fbfc711d4dc [90/90] Bluetooth: hci_dev: replace 'quirks' integer by 'quirk_flags' bitmap
config: arm-randconfig-001-20250715 (https://download.01.org/0day-ci/archive/20250715/202507150810.nsWLqAW3-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 16534d19bf50bde879a83f0ae62875e2c5120e64)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250715/202507150810.nsWLqAW3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507150810.nsWLqAW3-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/bluetooth/hci_ll.c:652:48: error: no member named 'quirks' in 'struct hci_dev'
     652 |                 set_bit(HCI_QUIRK_INVALID_BDADDR, &hu->hdev->quirks);
         |                                                    ~~~~~~~~  ^
   arch/arm/include/asm/bitops.h:191:49: note: expanded from macro 'set_bit'
     191 | #define set_bit(nr,p)                   ATOMIC_BITOP(set_bit,nr,p)
         |                                                                 ^
   arch/arm/include/asm/bitops.h:183:52: note: expanded from macro 'ATOMIC_BITOP'
     183 |         (__builtin_constant_p(nr) ? ____atomic_##name(nr, p) : _##name(nr,p))
         |                                                           ^
>> drivers/bluetooth/hci_ll.c:652:48: error: no member named 'quirks' in 'struct hci_dev'
     652 |                 set_bit(HCI_QUIRK_INVALID_BDADDR, &hu->hdev->quirks);
         |                                                    ~~~~~~~~  ^
   arch/arm/include/asm/bitops.h:191:49: note: expanded from macro 'set_bit'
     191 | #define set_bit(nr,p)                   ATOMIC_BITOP(set_bit,nr,p)
         |                                                                 ^
   arch/arm/include/asm/bitops.h:183:68: note: expanded from macro 'ATOMIC_BITOP'
     183 |         (__builtin_constant_p(nr) ? ____atomic_##name(nr, p) : _##name(nr,p))
         |                                                                           ^
   drivers/bluetooth/hci_ll.c:656:49: error: no member named 'quirks' in 'struct hci_dev'
     656 |                         set_bit(HCI_QUIRK_INVALID_BDADDR, &hu->hdev->quirks);
         |                                                            ~~~~~~~~  ^
   arch/arm/include/asm/bitops.h:191:49: note: expanded from macro 'set_bit'
     191 | #define set_bit(nr,p)                   ATOMIC_BITOP(set_bit,nr,p)
         |                                                                 ^
   arch/arm/include/asm/bitops.h:183:52: note: expanded from macro 'ATOMIC_BITOP'
     183 |         (__builtin_constant_p(nr) ? ____atomic_##name(nr, p) : _##name(nr,p))
         |                                                           ^
   drivers/bluetooth/hci_ll.c:656:49: error: no member named 'quirks' in 'struct hci_dev'
     656 |                         set_bit(HCI_QUIRK_INVALID_BDADDR, &hu->hdev->quirks);
         |                                                            ~~~~~~~~  ^
   arch/arm/include/asm/bitops.h:191:49: note: expanded from macro 'set_bit'
     191 | #define set_bit(nr,p)                   ATOMIC_BITOP(set_bit,nr,p)
         |                                                                 ^
   arch/arm/include/asm/bitops.h:183:68: note: expanded from macro 'ATOMIC_BITOP'
     183 |         (__builtin_constant_p(nr) ? ____atomic_##name(nr, p) : _##name(nr,p))
         |                                                                           ^
   4 errors generated.


vim +652 drivers/bluetooth/hci_ll.c

aa0993986932fe David Lechner 2017-12-12  607  
371805522f8709 Rob Herring   2017-04-13  608  static int ll_setup(struct hci_uart *hu)
371805522f8709 Rob Herring   2017-04-13  609  {
371805522f8709 Rob Herring   2017-04-13  610  	int err, retry = 3;
371805522f8709 Rob Herring   2017-04-13  611  	struct ll_device *lldev;
371805522f8709 Rob Herring   2017-04-13  612  	struct serdev_device *serdev = hu->serdev;
371805522f8709 Rob Herring   2017-04-13  613  	u32 speed;
371805522f8709 Rob Herring   2017-04-13  614  
371805522f8709 Rob Herring   2017-04-13  615  	if (!serdev)
371805522f8709 Rob Herring   2017-04-13  616  		return 0;
371805522f8709 Rob Herring   2017-04-13  617  
371805522f8709 Rob Herring   2017-04-13  618  	lldev = serdev_device_get_drvdata(serdev);
371805522f8709 Rob Herring   2017-04-13  619  
aa0993986932fe David Lechner 2017-12-12  620  	hu->hdev->set_bdaddr = ll_set_bdaddr;
aa0993986932fe David Lechner 2017-12-12  621  
371805522f8709 Rob Herring   2017-04-13  622  	serdev_device_set_flow_control(serdev, true);
371805522f8709 Rob Herring   2017-04-13  623  
371805522f8709 Rob Herring   2017-04-13  624  	do {
d54fdcf9244cec David Lechner 2017-12-02  625  		/* Reset the Bluetooth device */
371805522f8709 Rob Herring   2017-04-13  626  		gpiod_set_value_cansleep(lldev->enable_gpio, 0);
371805522f8709 Rob Herring   2017-04-13  627  		msleep(5);
371805522f8709 Rob Herring   2017-04-13  628  		gpiod_set_value_cansleep(lldev->enable_gpio, 1);
844c79bd599518 Xiaolei Wang  2020-11-10  629  		mdelay(100);
d54fdcf9244cec David Lechner 2017-12-02  630  		err = serdev_device_wait_for_cts(serdev, true, 200);
d54fdcf9244cec David Lechner 2017-12-02  631  		if (err) {
d54fdcf9244cec David Lechner 2017-12-02  632  			bt_dev_err(hu->hdev, "Failed to get CTS");
d54fdcf9244cec David Lechner 2017-12-02  633  			return err;
d54fdcf9244cec David Lechner 2017-12-02  634  		}
371805522f8709 Rob Herring   2017-04-13  635  
371805522f8709 Rob Herring   2017-04-13  636  		err = download_firmware(lldev);
371805522f8709 Rob Herring   2017-04-13  637  		if (!err)
371805522f8709 Rob Herring   2017-04-13  638  			break;
371805522f8709 Rob Herring   2017-04-13  639  
371805522f8709 Rob Herring   2017-04-13  640  		/* Toggle BT_EN and retry */
371805522f8709 Rob Herring   2017-04-13  641  		bt_dev_err(hu->hdev, "download firmware failed, retrying...");
371805522f8709 Rob Herring   2017-04-13  642  	} while (retry--);
371805522f8709 Rob Herring   2017-04-13  643  
371805522f8709 Rob Herring   2017-04-13  644  	if (err)
371805522f8709 Rob Herring   2017-04-13  645  		return err;
371805522f8709 Rob Herring   2017-04-13  646  
0e58d0cdb3eb6e David Lechner 2017-12-12  647  	/* Set BD address if one was specified at probe */
0e58d0cdb3eb6e David Lechner 2017-12-12  648  	if (!bacmp(&lldev->bdaddr, BDADDR_NONE)) {
0e58d0cdb3eb6e David Lechner 2017-12-12  649  		/* This means that there was an error getting the BD address
0e58d0cdb3eb6e David Lechner 2017-12-12  650  		 * during probe, so mark the device as having a bad address.
0e58d0cdb3eb6e David Lechner 2017-12-12  651  		 */
0e58d0cdb3eb6e David Lechner 2017-12-12 @652  		set_bit(HCI_QUIRK_INVALID_BDADDR, &hu->hdev->quirks);
0e58d0cdb3eb6e David Lechner 2017-12-12  653  	} else if (bacmp(&lldev->bdaddr, BDADDR_ANY)) {
0e58d0cdb3eb6e David Lechner 2017-12-12  654  		err = ll_set_bdaddr(hu->hdev, &lldev->bdaddr);
0e58d0cdb3eb6e David Lechner 2017-12-12  655  		if (err)
0e58d0cdb3eb6e David Lechner 2017-12-12  656  			set_bit(HCI_QUIRK_INVALID_BDADDR, &hu->hdev->quirks);
0e58d0cdb3eb6e David Lechner 2017-12-12  657  	}
0e58d0cdb3eb6e David Lechner 2017-12-12  658  
371805522f8709 Rob Herring   2017-04-13  659  	/* Operational speed if any */
cef456cd354ef4 Adam Ford     2019-10-02  660  	if (hu->oper_speed)
cef456cd354ef4 Adam Ford     2019-10-02  661  		speed = hu->oper_speed;
cef456cd354ef4 Adam Ford     2019-10-02  662  	else if (hu->proto->oper_speed)
cef456cd354ef4 Adam Ford     2019-10-02  663  		speed = hu->proto->oper_speed;
cef456cd354ef4 Adam Ford     2019-10-02  664  	else
cef456cd354ef4 Adam Ford     2019-10-02  665  		speed = 0;
cef456cd354ef4 Adam Ford     2019-10-02  666  
cef456cd354ef4 Adam Ford     2019-10-02  667  	if (speed) {
cef456cd354ef4 Adam Ford     2019-10-02  668  		__le32 speed_le = cpu_to_le32(speed);
cef456cd354ef4 Adam Ford     2019-10-02  669  		struct sk_buff *skb;
7c6ca1201e5e87 David Lechner 2017-12-03  670  
cef456cd354ef4 Adam Ford     2019-10-02  671  		skb = __hci_cmd_sync(hu->hdev, HCI_VS_UPDATE_UART_HCI_BAUDRATE,
cef456cd354ef4 Adam Ford     2019-10-02  672  				     sizeof(speed_le), &speed_le,
cef456cd354ef4 Adam Ford     2019-10-02  673  				     HCI_INIT_TIMEOUT);
cef456cd354ef4 Adam Ford     2019-10-02  674  		if (!IS_ERR(skb)) {
cef456cd354ef4 Adam Ford     2019-10-02  675  			kfree_skb(skb);
cef456cd354ef4 Adam Ford     2019-10-02  676  			serdev_device_set_baudrate(serdev, speed);
cef456cd354ef4 Adam Ford     2019-10-02  677  		}
cef456cd354ef4 Adam Ford     2019-10-02  678  	}
371805522f8709 Rob Herring   2017-04-13  679  
371805522f8709 Rob Herring   2017-04-13  680  	return 0;
371805522f8709 Rob Herring   2017-04-13  681  }
371805522f8709 Rob Herring   2017-04-13  682  

:::::: The code at line 652 was first introduced by commit
:::::: 0e58d0cdb3eb6e06416bcc1af3605993c6a07656 Bluetooth: hci_ll: Add optional nvmem BD address source

:::::: TO: David Lechner <david@lechnology.com>
:::::: CC: Marcel Holtmann <marcel@holtmann.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
