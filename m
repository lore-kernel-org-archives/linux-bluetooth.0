Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795271782;
	b=5EV3MJhlD6OMQa8xjwJtmSmD3UdCSDPpI0L1U+CGw7cUMdYh/O3A7mowDW9QG+oOFA/h
	 OP9p2U9vIY3tFSdmnW9DjdjI4npcSLLhx9nAwi6MgVF8O8R6Q3XI7qUIVWq1GZhseTz2Q
	 JP6aSVZhIimPWTTmmucguaObDFNJqu18K7HVPlgTpC/4CoTGCMPikferbeEyJoeMNhNiD
	 lSDnpfo03KzQ0yZmemXwF++VZ05luR3s8OlqZqODd7rjT+TIwxi8XZ7qwfnnilwvGTL+i
	 fzYcQpxEHRuRMFWB3il2nmY1lUujEcqDCfn34QrkzWSMo9nCpzU7QMRVUNPj/ZlawAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795271782;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=9nQN9/l1aeG2iZov/Qhemo8zZWreFmt6kut8e31XMuE=;
	b=O8n+crEVPg6yRgx21SKvqYMwZNbHRr0ZqbRVhzC76RWXaqhiW6qQUNUrRqj4ZMlb6YrT
	 H/ZsTNWLO3Q8VbedGfv649eK1ORAsXrvJKVIs0NRB3d2u773LQH3Smk0LCDJT4yfSAY+E
	 TElF0Yf3mB7rTayEBzti16INzibUNBIaMC/OkSOSj1+tsmgoeD3K2Y/QAxVgxtAb4Mu7n
	 uuSgRL4BW/JiWn1prLCgPiqI4WcQqyyMNXrXx8h3Z3F3IVjdBysqIKPd77tx0VghJ9wCN
	 UdrKb5yl2+i5kh1nQu02J2f9mG1/og5odzE2gKxCKDjqkbg2f0q+tY4SJwqLFszMTLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YI1C9cQV;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E6F606A320;
	Sat, 21 Nov 2026 14:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76E6F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YI1C9cQV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795271781; x=1826807781;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xL0K9+vP4paEUFHi3kZBlqtEBtHHC2I2LVqXj1ogESQ=;
  b=YI1C9cQVRWEefACB+yUM5x7upnxL7/PSWAagA9gtdm3pKotC9YDIjVDm
   DwVbghp1QVHM3aV+vPZvS6hx38u2iaE6V0KOT5CWLPjQigsSUNIf/k7VM
   HNo3plraVSqWSaZ5U/V0DbZuKFYn3+WF3IfxDOP9nMIXqn/24uxuKlnHC
   /Z7GnNsuvtjy3wbo6/D/tfdoYMrvEDczMcbCu8kJg87wMFXHar+eA1r8G
   CtD4p/yu0pcZfbA+l7NU3zHabp9JMttJoyWfVlU6+flkkmNjxmMd5fPj4
   rdQr7opHJGXSFDXvJyt8SI1ShPH27e121Jmlrez5UeX1tTSC1mSfVV0GJ
   w==;
X-CSE-ConnectionGUID: 80EpGjQaQcOS3ZEcprHHPw==
X-CSE-MsgGUID: H8FjuDpuQO+/P5Biqi7s4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11973"; a="4218603"
X-IronPort-AV: E=Sophos;i="6.27,225,1787036400"; 
   d="scan'208";a="4218603"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2026 06:36:21 -0800
X-CSE-ConnectionGUID: 1axwqobeQn2jJjEb45OZyw==
X-CSE-MsgGUID: vPr88j40SBuTdy5qzWllUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,225,1787036400"; 
   d="scan'208";a="12748062"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa011.fm.intel.com with ESMTP; 21 Nov 2026 06:36:18 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xUmCN-00000001K8t-1GOx;
	Sat, 21 Nov 2026 14:36:15 +0000
Date: Sat, 21 Nov 2026 22:35:14 +0800
From: kernel test robot <lkp@intel.com>
To: Hilda Wu <hildawu@realtek.com>, marcel@holtmann.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, alex_lu@realsil.com.cn,
	jason_mao@realsil.com.cn, zoey_zhou@realsil.com.cn,
	max.chou@realtek.com, kidman@realtek.com, arunr@valvesoftware.com
Subject: Re: [PATCH v10 1/2] Bluetooth: btrtl: Add firmware format v3 support
Message-ID: <202611212209.wBWI3Z2q-lkp@intel.com>
References: <20261120082636.3834168-2-hildawu@realtek.com>
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
In-Reply-To: <20261120082636.3834168-2-hildawu@realtek.com>

Hi Hilda,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth/master]
[also build test ERROR on bluetooth-next/master]
[cannot apply to linus/master v7.4-rc3 next-20261119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hilda-Wu/Bluetooth-btrtl-Add-firmware-format-v3-support/20261120-162635
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20261120082636.3834168-2-hildawu%40realtek.com
patch subject: [PATCH v10 1/2] Bluetooth: btrtl: Add firmware format v3 support
config: i386-randconfig-1003-20261121 (https://download.01.org/0day-ci/archive/20261121/202611212209.wBWI3Z2q-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261121/202611212209.wBWI3Z2q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611212209.wBWI3Z2q-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: btrtl_recv_event
   >>> referenced by btusb_main.c:2995 (drivers/bluetooth/btusb_main.c:2995)
   >>>               drivers/bluetooth/btusb_main.o:(btusb_recv_event_realtek) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
