Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9399853363
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 06:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720594040; cv=none; b=WzE6FIXqPcdUQMG0OcqJajmum6lpZ/djzaSCeN4cQdNK4Pe44FybaFGJ/Zj72wIzBE4LfbyZdFYf4XNZBF43pQsh+puG63SGukakmhKfozIJ1EHKKJUJK2I2pGfVPlVNDdxKAKVqua+6tzu+jcF+1b/gljDv8nYlKN4PEYg45ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720594040; c=relaxed/simple;
	bh=K9xu/9TxrKY8Z2qnYYHnwqm5GCbALUUBSc81ZhnI8Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WZ21+8wNUcXNE0TkyBi8Uv4lIuyoPFOl0Fovb1WV4WFS1Ky2kwLMHKJBXtpJti4hrkEd7Dtair4ZtKh7A+lwF9pfEz/uRmZ8INYWK1bjL8utoN5DKOTSRiQGKIPylfMJe2G+KCmkPx3wQgpUTBIQxFlaLHHkLRFdeRAE3qCu+5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jGb+J5By; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jGb+J5By"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720594039; x=1752130039;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K9xu/9TxrKY8Z2qnYYHnwqm5GCbALUUBSc81ZhnI8Ek=;
  b=jGb+J5By7RJ8UWjApztvqMeoAhOY3HEhUspWVbAYjfZyKXb0eoxZiznG
   71cSx691eQH8i76V+PwtOzqYotWDeh/K8zRT7Tf8YYNK4h5baPnXOHUrU
   SqIF12O8FyW4rUx0Xofp7EJwCIuGUe/1A0twtehPvJ4suXAAujxEHILS1
   sg+6uVM4+lLcilNGsO0RIUS4rmCukAD+3hegZcIdZyXZTkzPH1JBLY+q8
   Fw1x9FVjO8Dv+xt55finBvrRysyV1WojZE4GqCKVur549jc3UPGM1t9ZZ
   mzYZh6NFgW3lYhwvxNsgHul/yQ9mSdRu0ruI5xFrYgq4g7MmYNlCJE3aS
   A==;
X-CSE-ConnectionGUID: hyO9LPmRTVOmeZgjFWCg5Q==
X-CSE-MsgGUID: 2aLir/WURJGYFdQzuHBiGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="17592804"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="17592804"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 23:47:18 -0700
X-CSE-ConnectionGUID: pVmkoOA0TlSYO+un3Kw2Cw==
X-CSE-MsgGUID: XslqL9j8To2iDu0BBzXDsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="52703750"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 09 Jul 2024 23:47:16 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRR6g-000XYY-2A;
	Wed, 10 Jul 2024 06:47:14 +0000
Date: Wed, 10 Jul 2024 14:46:20 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Lu <chris.lu@mediatek.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: [bluetooth-next:master 69/76] alpha-linux-ld:
 drivers/bluetooth/btmtk.c:787:undefined reference to `usb_control_msg'
Message-ID: <202407101459.c9PTRDH1-lkp@intel.com>
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
commit: 314f1c00d267185dfeadc44bee5c7494603720ba [69/76] Bluetooth: btmtk: move btusb_mtk_[setup, shutdown] to btmtk.c
config: alpha-randconfig-c032-20221023 (https://download.01.org/0day-ci/archive/20240710/202407101459.c9PTRDH1-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240710/202407101459.c9PTRDH1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407101459.c9PTRDH1-lkp@intel.com/

All errors (new ones prefixed by >>):

   alpha-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_submit_wmt_recv_urb':
   drivers/bluetooth/btmtk.c:528:(.text+0xd7c): undefined reference to `usb_alloc_urb'
   alpha-linux-ld: drivers/bluetooth/btmtk.c:528:(.text+0xda0): undefined reference to `usb_alloc_urb'
   alpha-linux-ld: drivers/bluetooth/btmtk.c:558:(.text+0xe2c): undefined reference to `usb_anchor_urb'
   alpha-linux-ld: drivers/bluetooth/btmtk.c:558:(.text+0xe78): undefined reference to `usb_anchor_urb'
   alpha-linux-ld: drivers/bluetooth/btmtk.c:559:(.text+0xe88): undefined reference to `usb_submit_urb'
   alpha-linux-ld: drivers/bluetooth/btmtk.c:559:(.text+0xe90): undefined reference to `usb_submit_urb'
   alpha-linux-ld: drivers/bluetooth/btmtk.c:567:(.text+0xea8): undefined reference to `usb_free_urb'
   alpha-linux-ld: drivers/bluetooth/btmtk.c:567:(.text+0xeb0): undefined reference to `usb_free_urb'
   alpha-linux-ld: drivers/bluetooth/btmtk.c:564:(.text+0xf58): undefined reference to `usb_unanchor_urb'
   alpha-linux-ld: drivers/bluetooth/btmtk.c:564:(.text+0xf60): undefined reference to `usb_unanchor_urb'
   alpha-linux-ld: drivers/bluetooth/btmtk.c:547:(.text+0xf98): undefined reference to `usb_free_urb'
   alpha-linux-ld: drivers/bluetooth/btmtk.c:547:(.text+0xf9c): undefined reference to `usb_free_urb'
   alpha-linux-ld: drivers/bluetooth/btmtk.c:534:(.text+0xfb0): undefined reference to `usb_free_urb'
   alpha-linux-ld: drivers/bluetooth/btmtk.c:534:(.text+0xfbc): undefined reference to `usb_free_urb'
   alpha-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_wmt_recv':
   drivers/bluetooth/btmtk.c:505:(.text+0x12d0): undefined reference to `usb_anchor_urb'
   alpha-linux-ld: drivers/bluetooth/btmtk.c:505:(.text+0x12d8): undefined reference to `usb_anchor_urb'
   alpha-linux-ld: drivers/bluetooth/btmtk.c:506:(.text+0x12e8): undefined reference to `usb_submit_urb'
   alpha-linux-ld: drivers/bluetooth/btmtk.c:506:(.text+0x12f0): undefined reference to `usb_submit_urb'
   alpha-linux-ld: drivers/bluetooth/btmtk.c:515:(.text+0x1520): undefined reference to `usb_unanchor_urb'
   alpha-linux-ld: drivers/bluetooth/btmtk.c:515:(.text+0x1528): undefined reference to `usb_unanchor_urb'
   alpha-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_reg_read':
   drivers/bluetooth/btmtk.c:787:(.text+0x16c0): undefined reference to `usb_control_msg'
>> alpha-linux-ld: drivers/bluetooth/btmtk.c:787:(.text+0x1700): undefined reference to `usb_control_msg'
   alpha-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_uhw_reg_write':
   drivers/bluetooth/btmtk.c:735:(.text+0x1d4c): undefined reference to `usb_control_msg'
   alpha-linux-ld: drivers/bluetooth/btmtk.c:735:(.text+0x1d80): undefined reference to `usb_control_msg'
   alpha-linux-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_uhw_reg_read':
   drivers/bluetooth/btmtk.c:758:(.text+0x1eb0): undefined reference to `usb_control_msg'
   alpha-linux-ld: drivers/bluetooth/btmtk.o:drivers/bluetooth/btmtk.c:758: more undefined references to `usb_control_msg' follow

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
