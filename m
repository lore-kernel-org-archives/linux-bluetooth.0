Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA28B17C205
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720602266; cv=none; b=UemfZ33d3bYtnxCmzPCLbocj9UOGDiKkceS5cCR7gBg7emTCskhpNY/LT/aotFDxnMwwxfuW6jVN6hpkUjqtU4u5g1HMR1m8PqPd5ko/PjuV4alLZSqaZ645Boz4qUwFlDgLKkRtrNOfP3NLKIXtbSaEGNApL/YDb7NF+6zDypM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720602266; c=relaxed/simple;
	bh=7ckFKilvgUPRik/YHqQhF77xUfFYyERQAt6doyodLY8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F5fFHl92Z3X8L4kHrLiEatIujSCedusK7PVONZFtLBBcO2Q738gsytyngoYUuwEvG49d1WCYiG9a/osWZmHftlky/At2iadIJ/2Ar1qeGI+i5AD5VzXFPPVcK/ledGuN5GzchkkdQIM4KVoP6f7enxhBIQFQFgddT/Ru4xaTvyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=efwKJjya; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="efwKJjya"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720602264; x=1752138264;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7ckFKilvgUPRik/YHqQhF77xUfFYyERQAt6doyodLY8=;
  b=efwKJjyaCs5tM814T9fXyDoqjvUj3Xlt967nBegOvAfnVElp0MptFq62
   wJMNptjut6cqFfYHA7RxchRz8tC0nLztJN6Wk6gU+53NjeS4PR3+9z8Uh
   SAVZ4DPFGt9OpHEP6v+1D7Zmehcek34aTOOdrRQGcYhqOss/gntzxsd1s
   fNyDDI+KZ2Yu+t/Ibd3yRsIDbxOE+JXDHEH4aTQd0kcvWaZjhHlZzGInL
   3QdvYQU4aA6ZCM7kvCRa67CRiRzK3BDa4fHyCxIoS4najtNvWuw+W5JYl
   QYBesAgHzFrehKSj4tPbX7V4mD6hHyM/yWafR+PJJXzuZRnml30RLZbr8
   A==;
X-CSE-ConnectionGUID: 7Z/xFqqCTcemD2rRs0+OqQ==
X-CSE-MsgGUID: 021i72AgSaS3Iu+Fa0F+QQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="17608366"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="17608366"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 02:04:23 -0700
X-CSE-ConnectionGUID: s7le77dOTW6r7HsgZj3BrQ==
X-CSE-MsgGUID: RDATyD+DTBONMrzY43y1BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="48031631"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 10 Jul 2024 02:04:21 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRTFL-000Xfi-2i;
	Wed, 10 Jul 2024 09:04:19 +0000
Date: Wed, 10 Jul 2024 17:03:45 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Lu <chris.lu@mediatek.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: [bluetooth-next:master 70/76] xtensa-linux-ld: btmtk.c:undefined
 reference to `usb_disable_autosuspend'
Message-ID: <202407101633.wEKPo5yr-lkp@intel.com>
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
config: xtensa-randconfig-c031-20230322 (https://download.01.org/0day-ci/archive/20240710/202407101633.wEKPo5yr-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240710/202407101633.wEKPo5yr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407101633.wEKPo5yr-lkp@intel.com/

All errors (new ones prefixed by >>):

   xtensa-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_set_bdaddr':
   btmtk.c:(.text+0x89c): undefined reference to `usb_alloc_urb'
   xtensa-linux-ld: btmtk.c:(.text+0x8a0): undefined reference to `usb_free_urb'
   xtensa-linux-ld: btmtk.c:(.text+0x8a4): undefined reference to `usb_anchor_urb'
   xtensa-linux-ld: btmtk.c:(.text+0x8a8): undefined reference to `usb_submit_urb'
   xtensa-linux-ld: btmtk.c:(.text+0x8ac): undefined reference to `usb_unanchor_urb'
   xtensa-linux-ld: btmtk.c:(.text+0x8b8): undefined reference to `usb_alloc_urb'
   xtensa-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_reset_sync':
   btmtk.c:(.text+0x8e3): undefined reference to `usb_free_urb'
   xtensa-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_coredump_notify':
   btmtk.c:(.text+0x956): undefined reference to `usb_free_urb'
   xtensa-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_coredump':
   btmtk.c:(.text+0xa0e): undefined reference to `usb_anchor_urb'
   xtensa-linux-ld: btmtk.c:(.text+0xa1a): undefined reference to `usb_submit_urb'
   xtensa-linux-ld: btmtk.c:(.text+0xa50): undefined reference to `usb_unanchor_urb'
   xtensa-linux-ld: btmtk.c:(.text+0xa58): undefined reference to `usb_free_urb'
   xtensa-linux-ld: btmtk.c:(.text+0xa70): undefined reference to `usb_autopm_get_interface'
   xtensa-linux-ld: btmtk.c:(.text+0xa74): undefined reference to `usb_autopm_put_interface'
   xtensa-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_submit_wmt_recv_urb':
   btmtk.c:(.text+0xb43): undefined reference to `usb_autopm_get_interface'
   xtensa-linux-ld: btmtk.c:(.text+0xb7e): undefined reference to `usb_autopm_put_interface'
   xtensa-linux-ld: btmtk.c:(.text+0xb9b): undefined reference to `usb_autopm_put_interface'
   xtensa-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_hci_wmt_sync':
   btmtk.c:(.text+0xf70): undefined reference to `usb_disable_autosuspend'
>> xtensa-linux-ld: btmtk.c:(.text+0xfcf): undefined reference to `usb_disable_autosuspend'
   xtensa-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_process_coredump':
   btmtk.c:(.text+0x127b): undefined reference to `usb_anchor_urb'
   xtensa-linux-ld: btmtk.c:(.text+0x1286): undefined reference to `usb_submit_urb'
   xtensa-linux-ld: btmtk.c:(.text+0x12cf): undefined reference to `usb_unanchor_urb'
   xtensa-linux-ld: btmtk.c:(.text+0x12d8): undefined reference to `usb_control_msg'
   xtensa-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_recv_acl':
   btmtk.c:(.text+0x133a): undefined reference to `usb_control_msg'
   xtensa-linux-ld: btmtk.c:(.text+0x13f0): undefined reference to `usb_control_msg'
   xtensa-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_wmt_recv':
   btmtk.c:(.text+0x149c): undefined reference to `usb_control_msg'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
