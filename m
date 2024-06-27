Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4180F19AA42;
	Thu, 27 Jun 2024 18:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719512718; cv=none; b=YBFFNno8LW5zVg0nryrwYKsQ/RjM88zPYZ3Qez4h4wfeq72RA2DLEQyWrRUn2mtkrS0VN9Q2TyfLoEDi6m4C8Kxkv5EMCKgLFB9hb0udv+kcv8QKqH7++1rASUyul2W4NTa+1sPEVz7oepEx0n3ehe1xT/XplbVXBH4bTFr3XcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719512718; c=relaxed/simple;
	bh=1Ajy1en2qPpu1h+fHYclENO/17vYGHDO6/UafbA2Eyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFjyN2fa03tuEH6vv3KjqqwVkohLoQvH46hvty548wyrycZo8OBZfNhqA5y6vqmcMIBtEDr8YRGtmnqpvM2GGuyrGkJ5P3fn84ksul3KzvCuK+n3Q18M88qr6/QKe2klv8x5sun3JGIAojUdpk7mjCGGG25vQ6k5tC3xww+flCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k+aseVKe; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k+aseVKe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719512716; x=1751048716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1Ajy1en2qPpu1h+fHYclENO/17vYGHDO6/UafbA2Eyw=;
  b=k+aseVKejOBt6dW2eIJ20m3jbySZdk2NXfAbbd163ROSSyuTG42XX3EP
   TigkV6kNjSm0tEz7YsP2g5CzpwrjkOZz+EQ8DV8I9dcNOW6SRqysn9/by
   FlBBTr3mttHqh0Iv5oiTfYDcyfINmjQfj0HLTWlfD9iQ4BFsNGJsyIp0a
   /wioGQ2YqEtF9ndQVUqcc8Qd1rbhYlAEFV8d0zC4WdiRSClJ6ScTkQQWv
   /4G9BSmtBz7oytrDv+GtHYP5e03jyJvJPMXoonelG54j7/RdiDNES4QVX
   y5/IAwg5ActhL1H7ydIUf/boFohmK5o5H1L/C9jLXYzyOPCKRHwU+IPcE
   Q==;
X-CSE-ConnectionGUID: pJnL7xc7SNGqiMy6b5h8+Q==
X-CSE-MsgGUID: 6Ke7XxyPREyMl8fkcvRSkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16488369"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="16488369"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 11:25:15 -0700
X-CSE-ConnectionGUID: ahlKCS5gSKyDs0rBA+MtJg==
X-CSE-MsgGUID: ivEELg1lQLe/k2fFRQLdeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="44303023"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 27 Jun 2024 11:25:13 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMtny-000GQA-36;
	Thu, 27 Jun 2024 18:25:10 +0000
Date: Fri, 28 Jun 2024 02:25:06 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Lu <chris.lu@mediatek.com>, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Von Dentz <luiz.dentz@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Sean Wang <sean.wang@mediatek.com>,
	Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-mediatek <linux-mediatek@lists.infradead.org>,
	Chris Lu <chris.lu@mediatek.com>
Subject: Re: [PATCH v5 8/8] Bluetooth: btusb: mediatek: add ISO data
 transmission functions
Message-ID: <202406280211.EtaVcgeY-lkp@intel.com>
References: <20240626025329.26424-9-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626025329.26424-9-chris.lu@mediatek.com>

Hi Chris,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on next-20240626]
[cannot apply to bluetooth/master linus/master v6.10-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Lu/Bluetooth-btusb-mediatek-remove-the-unnecessary-goto-tag/20240626-114003
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20240626025329.26424-9-chris.lu%40mediatek.com
patch subject: [PATCH v5 8/8] Bluetooth: btusb: mediatek: add ISO data transmission functions
config: mips-lemote2f_defconfig (https://download.01.org/0day-ci/archive/20240628/202406280211.EtaVcgeY-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240628/202406280211.EtaVcgeY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406280211.EtaVcgeY-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/bluetooth/btusb.c:28:
   drivers/bluetooth/btmtk.h: In function 'alloc_mtk_intr_urb':
>> drivers/bluetooth/btmtk.h:274:24: warning: passing argument 1 of 'PTR_ERR' makes pointer from integer without a cast [-Wint-conversion]
     274 |         return PTR_ERR(-EOPNOTSUPP);
   In file included from include/linux/kernfs.h:9,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/dmi.h:6,
                    from drivers/bluetooth/btusb.c:9:
   include/linux/err.h:49:61: note: expected 'const void *' but argument is of type 'int'
      49 | static inline long __must_check PTR_ERR(__force const void *ptr)
         |                                                 ~~~~~~~~~~~~^~~
>> drivers/bluetooth/btmtk.h:274:16: warning: returning 'long int' from a function with return type 'struct urb *' makes pointer from integer without a cast [-Wint-conversion]
     274 |         return PTR_ERR(-EOPNOTSUPP);
         |                ^~~~~~~~~~~~~~~~~~~~
   drivers/bluetooth/btmtk.h: At top level:
   drivers/bluetooth/btmtk.h:256:13: warning: 'btmtk_fw_get_filename' defined but not used [-Wunused-function]
     256 | static void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id,
         |             ^~~~~~~~~~~~~~~~~~~~~
   drivers/bluetooth/btmtk.h:251:12: warning: 'btmtk_process_coredump' defined but not used [-Wunused-function]
     251 | static int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
         |            ^~~~~~~~~~~~~~~~~~~~~~
   drivers/bluetooth/btmtk.h:245:12: warning: 'btmtk_register_coredump' defined but not used [-Wunused-function]
     245 | static int btmtk_register_coredump(struct hci_dev *hdev, const char *name,
         |            ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/bluetooth/btmtk.h:235:12: warning: 'btmtk_setup_firmware' defined but not used [-Wunused-function]
     235 | static int btmtk_setup_firmware(struct hci_dev *hdev, const char *fwname,
         |            ^~~~~~~~~~~~~~~~~~~~
   drivers/bluetooth/btmtk.h:229:12: warning: 'btmtk_setup_firmware_79xx' defined but not used [-Wunused-function]
     229 | static int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/PTR_ERR +274 drivers/bluetooth/btmtk.h

   270	
   271	static struct urb *alloc_mtk_intr_urb(struct hci_dev *hdev, struct sk_buff *skb,
   272					      usb_complete_t tx_complete)
   273	{
 > 274		return PTR_ERR(-EOPNOTSUPP);
   275	}
   276	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
