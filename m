Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932AB3358C5
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 19:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766517745; cv=none; b=NLBNVX7CE4kaA52D7bpC50R6Ca6fTF0Yyyo/iD1COpEBtQBNrlfjjugw5+6OW5Tx1Ys1zDwcPZg4nfQ5CcsNX5aNOgIKq2eZIj0axAd6H9GzvlrbnGfQKGEzyg3UdXI5uGh+bJaVK0dq17OUmGnnqk/Zax361wgYvqPUxvIerqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766517745; c=relaxed/simple;
	bh=ipaG+EKlrnvDrkHJyMXFLyciXtY65IKRIPB8RbaJ+pc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pJDg+PdjUz9Q6NyrH1tBbYHBkM2lsTusAt5vLiZYAhYl3phy7fHskeuY6ZMI2xrqfLBazYtmazV+GpY21laErWr2+4WDW7SX09rc9npufMDaoBnoVZVP8mbF4qcbhEm7+nBUyZCy5k5b7W7WBgDVI/+AStwcfDg4UoeCQEK84r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K56ZZ9pW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K56ZZ9pW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766517744; x=1798053744;
  h=date:from:to:cc:subject:message-id;
  bh=ipaG+EKlrnvDrkHJyMXFLyciXtY65IKRIPB8RbaJ+pc=;
  b=K56ZZ9pWAsFb1NLgHleFAPQb6mb43ifnDKDQ72t4f5pKo0yRWC4b3wnE
   LJ4F8eokyzsfMZAPRWGRdXB+8KwOi4QguCEqkPcNqktx38ivV433tKEfK
   kpVC681wHrbgv2LDtCxkRC605lTjdOx2kgZiwzKvhH1I7g/6j7ZjNvUQJ
   fXhCnUOboM1Pkb27rENEswtc+FQrtC8Bs74OU07WlZKHAdysCxsno0nYn
   sKXeTIkDi/btIUHUsb3GGCSt0MQ0DDH+l1UpYjKhRwQYaPf3xelCtw6Pj
   cyD7CbSMJzHEfIBQVA0zsArrF5h6oeqbO7CR9CHwXEinJ1T963mZIDwcD
   g==;
X-CSE-ConnectionGUID: XSV74EaqSoKBACgRnrby2Q==
X-CSE-MsgGUID: tRxX8ctzRd+7Hv0Go3o4eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="85785694"
X-IronPort-AV: E=Sophos;i="6.21,171,1763452800"; 
   d="scan'208";a="85785694"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 11:22:23 -0800
X-CSE-ConnectionGUID: M24lcugzQLedfwAyl8fZXA==
X-CSE-MsgGUID: GRdcYequSZ+kFU1sPvgaGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,171,1763452800"; 
   d="scan'208";a="199506611"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 23 Dec 2025 11:22:22 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vY7xb-000000002IX-2BXo;
	Tue, 23 Dec 2025 19:22:19 +0000
Date: Wed, 24 Dec 2025 03:21:59 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master 41/41]
 net/bluetooth/hci_sync.c:7510:6-13: WARNING: kzalloc should be used for cp,
 instead of kmalloc/memset
Message-ID: <202512240329.yzdnKHSG-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   1d7a8fd800eb96f1175ddc3517822900c382cb80
commit: 1d7a8fd800eb96f1175ddc3517822900c382cb80 [41/41] Bluetooth: L2CAP: Add support for setting BT_PHY
config: i386-randconfig-051-20251223 (https://download.01.org/0day-ci/archive/20251224/202512240329.yzdnKHSG-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512240329.yzdnKHSG-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> net/bluetooth/hci_sync.c:7510:6-13: WARNING: kzalloc should be used for cp, instead of kmalloc/memset

vim +7510 net/bluetooth/hci_sync.c

  7504	
  7505	int hci_le_set_phy(struct hci_conn *conn, u8 tx_phys, u8 rx_phys)
  7506	{
  7507		struct hci_dev *hdev = conn->hdev;
  7508		struct hci_cp_le_set_phy *cp;
  7509	
> 7510		cp = kmalloc(sizeof(*cp), GFP_KERNEL);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
