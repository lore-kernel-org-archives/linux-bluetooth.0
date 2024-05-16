Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDCF156872
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 18:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715882419; cv=none; b=KEYWz5pyMFNoCOOVQze6kaxwXjbOOCpPeaDP03K6tIR3MYUlpzUmndF4Ft5JPyabjYfMqAMjqSym3e0ig3UHwNXIrdHzeUSCw5VNp9wGJOun/+vECB2xw39OzOstgzcxQn9pWMCFHSltNhcmRmIbwl3vXFGIh8LbgmcBZegDtrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715882419; c=relaxed/simple;
	bh=iaDHJuxHt6fQ1RwbpV1dlnnNNKv19Oq6gDaC1wR8nk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9r3JlqoITjUXFeKkWluqFDDcO0PObg5p7naIHrUrkrBsztYnEJhMjivcnrxehBFw6nMhlgg60b5fwijtiVXQJPFQhKbWPjvOdN893j6oQhwQv1n9sBcSenpd2/QxZnyy1+0AtzYEhwBJeR6Ly3SYm+nnFCHPckexl1tOx1Q0TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eLQ8goYZ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eLQ8goYZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715882418; x=1747418418;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iaDHJuxHt6fQ1RwbpV1dlnnNNKv19Oq6gDaC1wR8nk0=;
  b=eLQ8goYZliJ4sLJRUgyqN2OfPOndbWIAFzQAJ8fAsA1gGUAgCTfoh1cf
   r2XMLpisQbDpwwK9vn4bY0OTJ69WM1aMeSaregL/Non2Msqin2r88xNi/
   GMYHeqFwbsPdFAQzgd3ELljioGJzCUE+q5byskW5+oSYHoIvPMV34AI/4
   7S8v6vrLnNFuqYujjM38XPROeoGYHJsHGdHa/D3aLvxAc/X92rzUUnuoq
   y6PnT7Itab95IJ6KoOj7/L+9VDQYnX4oy+fWZYzkV7TMLma8YTFWxcThN
   teT2+kJZf3Ooyr+DbE5yL9pi/GEaaBlFD1X/nN4CM2jOfEu/9AiYuI9S9
   g==;
X-CSE-ConnectionGUID: ocMxXckeRLuSKs2F27FIMg==
X-CSE-MsgGUID: UNQwjmLmQcGwuvonjlLeFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="12135767"
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="12135767"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 11:00:18 -0700
X-CSE-ConnectionGUID: rUhTT5DmR+GM1qPja/9XfA==
X-CSE-MsgGUID: WmNVxPhzQaKrBXUj2pLZHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="68970580"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 16 May 2024 11:00:15 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7fOm-000EYP-2Q;
	Thu, 16 May 2024 18:00:12 +0000
Date: Fri, 17 May 2024 01:59:56 +0800
From: kernel test robot <lkp@intel.com>
To: Kiran K <kiran.k@intel.com>, linux-bluetooth@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com, vijay.satija@intel.com,
	Kiran <kiran.k@intel.com>
Subject: Re: [PATCH v2 1/3] Bluetooth: btintel_pcie: Print Firmware Sequencer
 information
Message-ID: <202405170103.plLziF5k-lkp@intel.com>
References: <20240516131510.904787-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516131510.904787-1-kiran.k@intel.com>

Hi Kiran,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on linus/master next-20240516]
[cannot apply to v6.9]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kiran-K/Bluetooth-btintel_pcie-Fix-irq-leak/20240516-210509
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20240516131510.904787-1-kiran.k%40intel.com
patch subject: [PATCH v2 1/3] Bluetooth: btintel_pcie: Print Firmware Sequencer information
config: loongarch-randconfig-001-20240516 (https://download.01.org/0day-ci/archive/20240517/202405170103.plLziF5k-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240517/202405170103.plLziF5k-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405170103.plLziF5k-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/bluetooth/hci_ldisc.c:34:
>> drivers/bluetooth/btintel.h:378:13: warning: 'btintel_print_fseq_info' defined but not used [-Wunused-function]
     378 | static void btintel_print_fseq_info(struct hci_dev *hdev)
         |             ^~~~~~~~~~~~~~~~~~~~~~~


vim +/btintel_print_fseq_info +378 drivers/bluetooth/btintel.h

   377	
 > 378	static void btintel_print_fseq_info(struct hci_dev *hdev)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
