Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793869883;
	b=zbwc6E6JiwYmh69qik3b7ToMc58m3RNxNLrxG/p7J1p9LIqm5TSIQYbeLJUug0cCv1Si
	 CPsP2Hr4crfnWG0Yfgn9mOod/VhIiu57o0h8fq3g8O572u+HeP7fwXZ1OsNc1O/xaVzLr
	 k5LsrDZrlAD4QhoQmEeBZohNLe1UK4ZxZf1AtUpW5NB8Ve0os/6fxcrEn70WB44YMkVS1
	 X5MtegqiAK+vt2Gl36mYONA54+CGZZYjttBZ8LiVmaFj6dV+owvRVOpTAUI6N+uzDRtA7
	 QNxp30UvDqWWqGYixvZSB3bp+STji+gaYTa9FyHHdKiU9KfoawMAZ4GBJiPWGwlZ/dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793869883;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=oUTkOjhpSta2G99V+EvRj5jWYOqvSjQ/adQtpHhKIwA=;
	b=4Qsm6d0aUK2knd1oG5GXfji/ID9QfZDUljb7TpOEbbZz32PJMLMtaUsl4uLT+pfEzfJ2
	 B0PcWc06PezrjINhKF4jam53UhoRRH4Z0xyN8e79raOMipHbqLZSL3ZarQeasiSBYgWm6
	 kCcE4v/YRcO+D5UYolojWuth591NIGOZNuVCpOtz/0pb+7Lw2d1jlG9qdNi0rQE9bVch4
	 9+VK19GxKDvzV9QW/df2og3YclFUeMiKhyxe8Amk3j/gcs0sVtsjXArSX4PMEOcuBdzmv
	 8x8WUQRtzobCx6okhZ/jmbi3hq/WZyK4pWs97kYknMDOFQjj3x4PVTMZCp+mB4gMzAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OOkERDIk;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD40606A32D;
	Thu,  5 Nov 2026 09:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FD40606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OOkERDIk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793869881; x=1825405881;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RlhKt0yBUlimxXsYRHNpAnCiVlMNcaFnOQtcMg7QbUY=;
  b=OOkERDIkUoRQ+Un8CLHvkU2ND/FrFZ1TdaYIU4aqsx/6VmipbhQ9je1Q
   tenwDvD04gLrfcGcnfXqOBdul7jzfCQutKidsEEPFDCS8ZeRT0jzNRMgz
   ozBDEaVOM+ldOdD54MSJVBJy/G5t4OpwgNx/zE2Rh3+2xCaoL1x/CjppI
   VxP2x4JYISTHZ5RrTG6J1FjBLKeWev86kgqyoFBbfpqeZQsI+5yahLQnq
   vpA5042LHvyNcJKKHyQ08g6MuqZeHRept/LMq2m6frJcLSn7QQuTy8vYM
   bAyEud3i8479kpFRNwITa4wzwVC8d708843whY1ir0JJ856+BbYgOi8dT
   A==;
X-CSE-ConnectionGUID: E7zfK6lBQIyUaf8d7LYwIw==
X-CSE-MsgGUID: 5RQJM1FrTiKiLmxwVEWC5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2655232"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2655232"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 01:11:20 -0800
X-CSE-ConnectionGUID: C1Le9xQ2Sh6VQxIkMkQ3Nw==
X-CSE-MsgGUID: wFUwFvH9SZmi8pDGQQmKCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="8819549"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa013.fm.intel.com with ESMTP; 05 Nov 2026 01:11:16 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xOtV3-00000000lzL-1HII;
	Thu, 05 Nov 2026 09:11:13 +0000
Date: Thu, 5 Nov 2026 17:10:48 +0800
From: kernel test robot <lkp@intel.com>
To: Andre Eikmeyer <dev@deq.rocks>, marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, sven@kernel.org, j@jannau.net,
	neal@gompa.dev, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, 66ton99@gmail.com,
	josemiguelo.ochoa@gmail.com, aditya.garg@linux.dev,
	Andre Eikmeyer <dev@deq.rocks>,
	Yossef Osman <Yossef.Osman@proton.me>
Subject: Re: [PATCH 2/4] Bluetooth: btbcm: clear vendor bits in LE
 advertising report types
Message-ID: <202611051954.fni86ioX-lkp@intel.com>
References: <20261104151601.70493-3-dev@deq.rocks>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104151601.70493-3-dev@deq.rocks>

Hi Andre,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 3f425f95ba3923d605f6a8b382e8fcdc59d479db]

url:    https://github.com/intel-lab-lkp/linux/commits/Andre-Eikmeyer/Bluetooth-btbcm-raise-ACL-priority-on-Apple-Broadcom-controllers/20261104-161558
base:   3f425f95ba3923d605f6a8b382e8fcdc59d479db
patch link:    https://lore.kernel.org/r/20261104151601.70493-3-dev%40deq.rocks
patch subject: [PATCH 2/4] Bluetooth: btbcm: clear vendor bits in LE advertising report types
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20261105/202611051954.fni86ioX-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261105/202611051954.fni86ioX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611051954.fni86ioX-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: drivers/bluetooth/hci_bcm.c:153 struct member 'acl_priority' not described in 'bcm_device'
>> Warning: drivers/bluetooth/hci_bcm.c:153 struct member 'adv_type_fixup' not described in 'bcm_device'
   Warning: drivers/bluetooth/hci_bcm.c:153 struct member 'acl_priority' not described in 'bcm_device'
>> Warning: drivers/bluetooth/hci_bcm.c:153 struct member 'adv_type_fixup' not described in 'bcm_device'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
