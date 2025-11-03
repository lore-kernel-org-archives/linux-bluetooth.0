Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F7B23E25B;
	Mon,  3 Nov 2025 05:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762147472; cv=none; b=Q/S442Pq+1zJfapbcvpgNwU3YMSAQFaLhqy2wXEwXDhMm3JikkNWT4h2SxCYsS5M8gX8NwxmcpZhQzxrz04LOb2QjGn7YNss3YKq2999qlQbREstF0mOXmckvJZd/d96726yILjSCrvR46Hx5D96wu8dS5vv2Gq1llkJaqwaRZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762147472; c=relaxed/simple;
	bh=vtekGxNqhXtGTOf6dmBkq5nSZuUqmgZv0+huBUiriSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5b17ohZo/y8xZnjxNavlczzCYkK6NX+vue1Mk8dgXaZ78QRq6MNVug091xxeumbap0vMuauxJ9KFBwQ3CdKK4jm2K63xQR3PNFIg12er0rX6vrxfgrbLOLpMU5rIXLkS84W0ewLg+U6w5pWXfNALyZ9K+sVd+LQdUYZCHbdOt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RZvgHDti; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RZvgHDti"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762147470; x=1793683470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vtekGxNqhXtGTOf6dmBkq5nSZuUqmgZv0+huBUiriSc=;
  b=RZvgHDtipx0esA0zz5q1hYYjL8vpWk9oas2ShvKs0irvbw96h6vjStOH
   CuwI2dmtbehFitc1bHx/8uW0B+04Cxuba9PhuIkp0WFYjhwaoy3OulPZG
   Q7kdaNr1H1qhSULKwvomWW4+/4LrTWlPSCSgBV9TszLvTGk2FqHChweIT
   rZxNNDyN+P/cVJ/Ydd40a0fy2Uo/a/QcoR7bjQNnwwvy+gbo95H8nLCgz
   QiFghGgxvKCa5lyFKx1n950iYcOxm49hTECijmIYnxwvZjycDWXVdBRng
   63S5Y/Om5POfPMCrxWg6jZeCcfRNYz9dvsTAlJYb2WZUPU/wVVRFqiFG3
   A==;
X-CSE-ConnectionGUID: l3yqbM/pR3mzHoxkHl13Tg==
X-CSE-MsgGUID: ZvtkdzUrSQuPWGQ/VncYKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="74820375"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="74820375"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 21:24:30 -0800
X-CSE-ConnectionGUID: Rqt5InDDTxmiay36a8yHJQ==
X-CSE-MsgGUID: V7DyeiptQICbTuksykd4Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="191104512"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 02 Nov 2025 21:24:28 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vFn3J-000PqK-1p;
	Mon, 03 Nov 2025 05:24:25 +0000
Date: Mon, 3 Nov 2025 13:24:18 +0800
From: kernel test robot <lkp@intel.com>
To: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
	jukka.rissanen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] Bluetooth: 6lowpan: Don't hold spin lock over
 sleeping functions
Message-ID: <202511031234.Gw8GEsFK-lkp@intel.com>
References: <8736a4ce03f143b7a63cb99ab425e5403eafa9e4.1761998763.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736a4ce03f143b7a63cb99ab425e5403eafa9e4.1761998763.git.pav@iki.fi>

Hi Pauli,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth/master]
[also build test ERROR on bluetooth-next/master linus/master v6.18-rc4 next-20251031]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pauli-Virtanen/Bluetooth-6lowpan-fix-BDADDR_LE-vs-ADDR_LE_DEV-address-type-confusion/20251101-201123
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/8736a4ce03f143b7a63cb99ab425e5403eafa9e4.1761998763.git.pav%40iki.fi
patch subject: [PATCH 3/4] Bluetooth: 6lowpan: Don't hold spin lock over sleeping functions
config: x86_64-randconfig-071-20251103 (https://download.01.org/0day-ci/archive/20251103/202511031234.Gw8GEsFK-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251103/202511031234.Gw8GEsFK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511031234.Gw8GEsFK-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "l2cap_chan_hold_unless_zero" [net/bluetooth/bluetooth_6lowpan.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
