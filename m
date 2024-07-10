Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C232918FC89
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720612170; cv=none; b=iedkNN0Liz30KcKBRlJ6NWlCJxUdJByZ6prILRB81nAjiZa+15oKN8rUDT4gIfSRDczBVeEdTnGvrh5jWMxK9iZE/kMRLycB0244n+zXCMnp/PEp5H866wveJRFzMILg+DFYa0WuYeOuPUayGUwAdxn5Rgu80iiZ2jjx/fCfZL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720612170; c=relaxed/simple;
	bh=/5uKIty+TpIj/uX6nGORuTkqPgy+Ew+0v9aI7LW2VFY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=vCzqTmjgz3gpjq4mBXic9LpTe30/3fvl+TxQkV91f2qn2uqmyyHDZDM93TWveBQgRWo7rbCVDtgM+P662NfkeFR6tGwC8M8fEElh7bAMTWPS49y8/1a7eFnjGa14e0X6Enm2UA29rka2EYOSL8krkhzLn5dRnNfKo9xlMTirYE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FdlUkHcO; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdlUkHcO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720612169; x=1752148169;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/5uKIty+TpIj/uX6nGORuTkqPgy+Ew+0v9aI7LW2VFY=;
  b=FdlUkHcOb8J0Y9hzk6aQFwvaDukmh2krK0yQbkb/Cyk6RerlNngdreKc
   iiLd/yTpNX16HS/zDOff5bZfHT+3dlMY8dljsT7EqQ8a6O4nTsqU5dM/c
   SNd/cY8uQ2/+KfOHADucQfdyrUXaBr6zyJBH8MFqptTL7u6ZBOJXVCyCf
   8YzNBtVR+rB7b+mLYLutpRWl6fmtgYgf1Eex/ptiDGoMez5Mj2qB5KZxI
   3w01445puBjABy4PUyLeDXRwhU7Bt6Z7j9HZaTeBonAHNnzNtQiYXcMgj
   SIVlrOiLuHflMGXcVWgdyLzl3DxcahD8fyqWBWczkDSuXCrbcGNfzZYZH
   w==;
X-CSE-ConnectionGUID: 3e4CrFTZQpqhxT1aKw7gdg==
X-CSE-MsgGUID: 8D7w1f0wTZmoyjACMnrjSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="28519336"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="28519336"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 04:49:28 -0700
X-CSE-ConnectionGUID: WV/mza3aTY2VhEJoMx0OWw==
X-CSE-MsgGUID: RR4iyj9JS0yrt6ZEPpFkiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="48262392"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 10 Jul 2024 04:49:26 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRVp6-000XoY-0Y;
	Wed, 10 Jul 2024 11:49:24 +0000
Date: Wed, 10 Jul 2024 19:49:21 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Lu <chris.lu@mediatek.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: [bluetooth-next:master 70/76]
 drivers/bluetooth/btmtk.c:943:(.text+0x610): relocation truncated to fit:
 R_AARCH64_CALL26 against undefined symbol `usb_disable_autosuspend'
Message-ID: <202407101945.vawx3IuB-lkp@intel.com>
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
commit: 91d0ac304edffdf78012b6b57b6f94d8cf95a07f [70/76] Bluetooth: btmtk: move btusb_recv_acl_mtk to btmtk.c
config: arm64-randconfig-r036-20211103 (https://download.01.org/0day-ci/archive/20240710/202407101945.vawx3IuB-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240710/202407101945.vawx3IuB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407101945.vawx3IuB-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_recv_acl':
   drivers/bluetooth/btmtk.c:943:(.text+0x610): undefined reference to `usb_disable_autosuspend'
>> drivers/bluetooth/btmtk.c:943:(.text+0x610): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_disable_autosuspend'
   aarch64-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_submit_wmt_recv_urb':
   drivers/bluetooth/btmtk.c:528:(.text+0x648): undefined reference to `usb_alloc_urb'
   drivers/bluetooth/btmtk.c:528:(.text+0x648): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_alloc_urb'
   aarch64-linux-ld: drivers/bluetooth/btmtk.c:534:(.text+0x678): undefined reference to `usb_free_urb'
   drivers/bluetooth/btmtk.c:534:(.text+0x678): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_free_urb'
   aarch64-linux-ld: drivers/bluetooth/btmtk.c:558:(.text+0x714): undefined reference to `usb_anchor_urb'
   drivers/bluetooth/btmtk.c:558:(.text+0x714): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_anchor_urb'
   aarch64-linux-ld: drivers/bluetooth/btmtk.c:559:(.text+0x720): undefined reference to `usb_submit_urb'
   drivers/bluetooth/btmtk.c:559:(.text+0x720): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_submit_urb'
   aarch64-linux-ld: drivers/bluetooth/btmtk.c:564:(.text+0x758): undefined reference to `usb_unanchor_urb'
   drivers/bluetooth/btmtk.c:564:(.text+0x758): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_unanchor_urb'
   aarch64-linux-ld: drivers/bluetooth/btmtk.c:567:(.text+0x760): undefined reference to `usb_free_urb'
   drivers/bluetooth/btmtk.c:567:(.text+0x760): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_free_urb'
   aarch64-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_reg_read':
   drivers/bluetooth/btmtk.c:787:(.text+0x8a0): undefined reference to `usb_control_msg'
   drivers/bluetooth/btmtk.c:787:(.text+0x8a0): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_control_msg'
   aarch64-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_uhw_reg_write':
   drivers/bluetooth/btmtk.c:735:(.text+0x944): undefined reference to `usb_control_msg'
   drivers/bluetooth/btmtk.c:735:(.text+0x944): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_control_msg'
   aarch64-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_uhw_reg_read':
   drivers/bluetooth/btmtk.c:758:(.text+0xa08): undefined reference to `usb_control_msg'
   drivers/bluetooth/btmtk.c:758:(.text+0xa08): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_control_msg'
   aarch64-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_hci_wmt_sync':
   drivers/bluetooth/btmtk.c:607:(.text+0xffc): undefined reference to `usb_autopm_get_interface'
   drivers/bluetooth/btmtk.c:607:(.text+0xffc): additional relocation overflows omitted from the output
   aarch64-linux-ld: drivers/bluetooth/btmtk.c:615:(.text+0x105c): undefined reference to `usb_autopm_put_interface'
   aarch64-linux-ld: drivers/bluetooth/btmtk.c:622:(.text+0x10b4): undefined reference to `usb_autopm_put_interface'
   aarch64-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_wmt_recv':
   drivers/bluetooth/btmtk.c:505:(.text+0x1ad0): undefined reference to `usb_anchor_urb'
   aarch64-linux-ld: drivers/bluetooth/btmtk.c:506:(.text+0x1adc): undefined reference to `usb_submit_urb'
   aarch64-linux-ld: drivers/bluetooth/btmtk.c:515:(.text+0x1b1c): undefined reference to `usb_unanchor_urb'


vim +943 drivers/bluetooth/btmtk.c

   932	
   933	int btmtk_usb_recv_acl(struct hci_dev *hdev, struct sk_buff *skb)
   934	{
   935		struct btmtk_data *data = hci_get_priv(hdev);
   936		u16 handle = le16_to_cpu(hci_acl_hdr(skb)->handle);
   937	
   938		switch (handle) {
   939		case 0xfc6f:		/* Firmware dump from device */
   940			/* When the firmware hangs, the device can no longer
   941			 * suspend and thus disable auto-suspend.
   942			 */
 > 943			usb_disable_autosuspend(data->udev);
   944	
   945			/* We need to forward the diagnostic packet to userspace daemon
   946			 * for backward compatibility, so we have to clone the packet
   947			 * extraly for the in-kernel coredump support.
   948			 */
   949			if (IS_ENABLED(CONFIG_DEV_COREDUMP)) {
   950				struct sk_buff *skb_cd = skb_clone(skb, GFP_ATOMIC);
   951	
   952				if (skb_cd)
   953					btmtk_process_coredump(hdev, skb_cd);
   954			}
   955	
   956			fallthrough;
   957		case 0x05ff:		/* Firmware debug logging 1 */
   958		case 0x05fe:		/* Firmware debug logging 2 */
   959			return hci_recv_diag(hdev, skb);
   960		}
   961	
   962		return hci_recv_frame(hdev, skb);
   963	}
   964	EXPORT_SYMBOL_GPL(btmtk_usb_recv_acl);
   965	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
