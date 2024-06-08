Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F3F37171;
	Sat,  8 Jun 2024 06:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717828886; cv=none; b=MD/Zp0BvXiZzxedqV5fe8GAD13I9StuzS1ZN13Q73JoIMVQ5tErgSNn8C8tt/AkkcElKMElX9wIuDwyF1Ui+4jVRi8zx1I6UxL7MI91Kf30/sblzB2VZx1v7DBu8wqwZUS2LSMvESTwdKwuIw8rrE8vmD4RrIIbE/t8V3eiCsIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717828886; c=relaxed/simple;
	bh=Pz6JJDnPVbtOuWZggs2YrW4Hk1PhUbc/pSMDPeFzVXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GV6fSGR8uNfbln9pycu2RBnwN6GAOyMWrJJLkCfwikLInlvgoBwg742t2wr+RbfEPnBYC3SgsFyTfzULrLh7o5jgfhQk9s/AprR5Ky0U2pKrvFGixd2ndJ8DiM3AhMPpzwYkyAmSVak2L+8UzWwIv0j6s83S2fAidiCBw80NLAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fe/MMIjY; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fe/MMIjY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717828884; x=1749364884;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pz6JJDnPVbtOuWZggs2YrW4Hk1PhUbc/pSMDPeFzVXU=;
  b=Fe/MMIjYj0zjAkBoCRykAShfbUk27ih2UKbKQuCLlC+FgmEqJXVv5TYv
   Cdh+BlmJoTSnd3cvosLnu5e7iXoWDtwQGtHEZPAq7g6qQb8jc0dOlWooE
   tBnqvhQMim9bF3kJhCWtsqqeACxyC0AEaMZkTrFIaHZKLpZ4dRoPuANOl
   fIe94vapiw0/nwEiDsVW2sZZkOnc9gF0pj9y22AXQxV7zSF7gZirMI7ws
   /kG7tNjVG4pykDu7oDO9L+bw4Ud2C62xwRNGzV6tb1pXFA1LH0DhCviBQ
   sQ1vuBZmkTe8Hk9U9cmh3+7Jzsav7NrWhKUAN37Y9T4rT5PYOdDc8D58R
   Q==;
X-CSE-ConnectionGUID: dDSRFuDxRvSZiZnImSWmqQ==
X-CSE-MsgGUID: qcRaFsUuRCupiW2Zwa4uqA==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="25665528"
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="25665528"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 23:41:24 -0700
X-CSE-ConnectionGUID: rQiIXXhXQLam8mUrsUe/EQ==
X-CSE-MsgGUID: HQDi8NehR1GPayLwmC8BdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="39212369"
Received: from lkp-server01.sh.intel.com (HELO 472b94a103a1) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 07 Jun 2024 23:41:21 -0700
Received: from kbuild by 472b94a103a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFplO-0001CA-1c;
	Sat, 08 Jun 2024 06:41:18 +0000
Date: Sat, 8 Jun 2024 14:40:30 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Lu <chris.lu@mediatek.com>, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Von Dentz <luiz.dentz@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Sean Wang <sean.wang@mediatek.com>,
	Deren Wu <deren.Wu@mediatek.com>,
	Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-mediatek <linux-mediatek@lists.infradead.org>,
	Chris Lu <chris.lu@mediatek.com>
Subject: Re: [PATCH v4 4/4] Bluetooth: btusb: mediatek: add ISO data
 transmission functions
Message-ID: <202406081451.S72dkwTp-lkp@intel.com>
References: <20240606114321.30515-5-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606114321.30515-5-chris.lu@mediatek.com>

Hi Chris,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on next-20240607]
[cannot apply to bluetooth/master linus/master v6.10-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Lu/Bluetooth-net-add-hci_iso_hdr-function-for-iso-data/20240606-194619
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20240606114321.30515-5-chris.lu%40mediatek.com
patch subject: [PATCH v4 4/4] Bluetooth: btusb: mediatek: add ISO data transmission functions
config: arm-omap2plus_defconfig (https://download.01.org/0day-ci/archive/20240608/202406081451.S72dkwTp-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240608/202406081451.S72dkwTp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406081451.S72dkwTp-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/bluetooth/btusb.c:28:
   drivers/bluetooth/btmtk.h: In function 'btmtk_isopkt_pad':
>> drivers/bluetooth/btmtk.h:259:16: warning: returning 'void *' from a function with return type 'int' makes integer from pointer without a cast [-Wint-conversion]
     259 |         return ERR_PTR(-EOPNOTSUPP);
         |                ^~~~~~~~~~~~~~~~~~~~


vim +259 drivers/bluetooth/btmtk.h

   256	
   257	static int btmtk_isopkt_pad(struct hci_dev *hdev, struct sk_buff *skb)
   258	{
 > 259		return ERR_PTR(-EOPNOTSUPP);
   260	}
   261	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
