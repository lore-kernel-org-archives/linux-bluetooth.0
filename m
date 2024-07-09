Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AF119EEA5
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542708; cv=none; b=FUsUSa86z5GhQpulrMM/esOC2Pfs+VNBxiCREy3GrEXRL/WPtnixl4EHu239S3yr3x7D1+twUD6sCQK4y9ZHPdfqvO6eNzmytLslFsOFInXYhhMxYct/4HK5N0rQmSVb2rkfyuBTrQudA9kqaRxlYACcArM2nkWYFeB3KOHkjhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542708; c=relaxed/simple;
	bh=XcQ49hqGAOVM4dEwjUrILHKdEQRjWjwuZRldnwSqrNI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Se7SKfbuSCX6FxZssscW04WI6xbVfhxwVGSNPeHVybUwHaESuiiuGpAOpVq3SHEG8BFiOZON+YrnUzCHJTTIy/Efa0Du9ke8+iq/jlhzjJ/qUAt3/OkuheK7VPf7Th6L1g15YgxeklLF+Ajh0yA3AcVr5ddqCCvEdoc8JUW8naU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gh1/6NFA; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gh1/6NFA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720542706; x=1752078706;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XcQ49hqGAOVM4dEwjUrILHKdEQRjWjwuZRldnwSqrNI=;
  b=Gh1/6NFADd0bejhzLFP8BXQmS9JJNEkrnO9H/6RrVmzocwyoFejV6tyT
   tTmbpIMmbd3QzibNBl38GL5OhtCygXs5aycg5oIVws3PScfJUdk1ox2Lc
   Of1+YI1Ec3y5vEDOnNim0wssG1e41nRwgoTlqyRWPwJ8Yh2NTAbI4LwBb
   CsNSSOBge7J8SrJ7HoNlgysnDnwEHpjcEr5su+vWuoKTxHV1t4nIo3G2R
   8AZVrzW9DZ3CQZgCwkPySrbvfGjUOxdboNiFiSNMtNCv/b7vm3TKJW7Jw
   Jgsq4A4GOlRSTMtefvfIPGEWgujnqVZONr3KIYKRpVau7sT5ib7C0MvSy
   w==;
X-CSE-ConnectionGUID: hWFZ84aNTHiK2Lme/yq4+g==
X-CSE-MsgGUID: Mnx0ge6rSmuNUTSIEGv+wA==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="35244063"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="35244063"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 09:31:46 -0700
X-CSE-ConnectionGUID: fx2Foft1R7W4MvuJ46gQVQ==
X-CSE-MsgGUID: nbMLG6UoQEScEfWB/PyVEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="52855151"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 09 Jul 2024 09:31:44 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRDkj-000Wt0-1W;
	Tue, 09 Jul 2024 16:31:41 +0000
Date: Wed, 10 Jul 2024 00:30:54 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Lu <chris.lu@mediatek.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [bluetooth-next:master 71/76] sh4-linux-ld:
 drivers/bluetooth/btmtk.c:1237:undefined reference to
 `usb_kill_anchored_urbs'
Message-ID: <202407100005.eDlKsDOu-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   c6052c312e85011cd31237804900013f63420403
commit: 7eac027d1b204b4d0c8acb2bf21e443f8a078cbf [71/76] Bluetooth: btusb: mediatek: add ISO data transmission functions
config: sh-buildonly-randconfig-r006-20220515 (https://download.01.org/0day-ci/archive/20240710/202407100005.eDlKsDOu-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240710/202407100005.eDlKsDOu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407100005.eDlKsDOu-lkp@intel.com/

All errors (new ones prefixed by >>):

   sh4-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_submit_wmt_recv_urb':
   drivers/bluetooth/btmtk.c:573:(.text+0x754): undefined reference to `usb_alloc_urb'
   sh4-linux-ld: drivers/bluetooth/btmtk.c:573:(.text+0x760): undefined reference to `usb_free_urb'
   sh4-linux-ld: drivers/bluetooth/btmtk.c:573:(.text+0x778): undefined reference to `usb_anchor_urb'
   sh4-linux-ld: drivers/bluetooth/btmtk.c:573:(.text+0x77c): undefined reference to `usb_submit_urb'
   sh4-linux-ld: drivers/bluetooth/btmtk.c:573:(.text+0x78c): undefined reference to `usb_unanchor_urb'
   sh4-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_submit_intr_urb':
   drivers/bluetooth/btmtk.c:1208:(.text+0x8c8): undefined reference to `usb_alloc_urb'
   sh4-linux-ld: drivers/bluetooth/btmtk.c:1208:(.text+0x8d0): undefined reference to `usb_free_urb'
   sh4-linux-ld: drivers/bluetooth/btmtk.c:1208:(.text+0x8e0): undefined reference to `usb_anchor_urb'
   sh4-linux-ld: drivers/bluetooth/btmtk.c:1208:(.text+0x8e4): undefined reference to `usb_submit_urb'
   sh4-linux-ld: drivers/bluetooth/btmtk.c:1208:(.text+0x8f4): undefined reference to `usb_unanchor_urb'
   sh4-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_suspend':
   drivers/bluetooth/btmtk.c:1268:(.text+0x95c): undefined reference to `usb_kill_anchored_urbs'
   sh4-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_hci_wmt_sync':
   drivers/bluetooth/btmtk.c:671:(.text+0xae0): undefined reference to `usb_autopm_get_interface'
   sh4-linux-ld: drivers/bluetooth/btmtk.c:671:(.text+0xaec): undefined reference to `usb_autopm_put_interface'
   sh4-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_recv_acl':
   drivers/bluetooth/btmtk.c:966:(.text+0xde0): undefined reference to `usb_disable_autosuspend'
   sh4-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_isointf_init.constprop.0':
   drivers/bluetooth/btmtk.c:1237:(.text+0xfa8): undefined reference to `usb_set_interface'
>> sh4-linux-ld: drivers/bluetooth/btmtk.c:1237:(.text+0xfc0): undefined reference to `usb_kill_anchored_urbs'
   sh4-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_wmt_recv':
   drivers/bluetooth/btmtk.c:520:(.text+0x11b4): undefined reference to `usb_anchor_urb'
   sh4-linux-ld: drivers/bluetooth/btmtk.c:520:(.text+0x11b8): undefined reference to `usb_submit_urb'
   sh4-linux-ld: drivers/bluetooth/btmtk.c:520:(.text+0x11c8): undefined reference to `usb_unanchor_urb'
   sh4-linux-ld: drivers/bluetooth/btmtk.o: in function `alloc_mtk_intr_urb':
   drivers/bluetooth/btmtk.c:1054:(.text+0x12bc): undefined reference to `usb_alloc_urb'
   sh4-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_reg_read':
   drivers/bluetooth/btmtk.c:803:(.text+0x1350): undefined reference to `usb_control_msg'
   sh4-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_uhw_reg_write':
   drivers/bluetooth/btmtk.c:748:(.text+0x13f8): undefined reference to `usb_control_msg'
   sh4-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_uhw_reg_read':
   drivers/bluetooth/btmtk.c:777:(.text+0x14cc): undefined reference to `usb_control_msg'
   sh4-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_intr_complete':
   drivers/bluetooth/btmtk.c:1159:(.text+0x1788): undefined reference to `usb_anchor_urb'
   sh4-linux-ld: drivers/bluetooth/btmtk.c:1159:(.text+0x178c): undefined reference to `usb_submit_urb'
   sh4-linux-ld: drivers/bluetooth/btmtk.c:1159:(.text+0x17a0): undefined reference to `usb_unanchor_urb'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
