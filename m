Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2E140D599
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 19:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341814; cv=none; b=NxwxHQxR6jsljfi1McsfxSSUXQD0bD/junNvLwC5/BUCJD/fVPVfxY9HBByzrzl7iVDNEU89m6iz47x3JMhTPQbs9R1BAu+1R3DnI8GjHXbOyNAC+nTvBad2CQfSNPJndYiVORjBTrXXN+PjBORWkjH1qaRa+Kz0urqZR2r21O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341814; c=relaxed/simple;
	bh=gskV1hJQCG80AV4sNz1PxU26bxcRffrp5JsfEjeOvlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pANU3zduti8DG0oJ9KC2I1NAGI5HP55RXmMa4kDzwcypLHQ5RhqxYDa8PboYDINBfWj12i+DTVH5ILdHdliXTM6MiieTd2VMI4jF3kI+1gwg4QnjtlADrciFc6OvAEIpU+joMXhxYEU3+M5738VFMK0bXLxS/V6Rcd4c44Lb3Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E+sE7W/R; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E+sE7W/R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787341810; x=1818877810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gskV1hJQCG80AV4sNz1PxU26bxcRffrp5JsfEjeOvlI=;
  b=E+sE7W/RrEoECdhy6ftdxKxI1wwsBnFGzwwNXZcCN13SKVS/iJ8Xwff0
   vi4BapoYI9ZE1+SkpCw9zbIoFUYuKHo/c/oLL1yqZKtbj6lKui7ZBfRe4
   CaM7X6cm8XncECV78xtBveAHI1u2aEmtXw6XviY+XD6Byu3a2Bxz/o845
   ZMKL8v2h8gpeoITXFs2iGb969gxyXVvXCTSA4Q58dnnTw7+GNpi82M086
   ZSVP0caDXWQYnCfXHvD9439Lu0EVoLy7HkDHp6q4JyckVxxF8mv0Yw2c7
   7R5BCxrwMb091crwcNc/r2DmLPMKg8YjLgiWvxtSZkt7aiXi6dvakhxf9
   g==;
X-CSE-ConnectionGUID: D1CSJ6t0Q76zCmSMqGABlw==
X-CSE-MsgGUID: /TwpxM/kREqzKu3X5kSAfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="98488868"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="98488868"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 12:50:07 -0700
X-CSE-ConnectionGUID: xkIZl3E1Tz6OWRhR/OsIqQ==
X-CSE-MsgGUID: fO2cT9PJQZqNZeZ/uqVhfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="270264721"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 21 Aug 2026 12:50:06 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wxVFa-00000000qOr-298q;
	Fri, 21 Aug 2026 19:50:02 +0000
Date: Sat, 22 Aug 2026 03:49:59 +0800
From: kernel test robot <lkp@intel.com>
To: Li Jun <lijun01@kylinos.cn>, marcel@holtmann.org, luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] bluetooth: pm: use SIMPLE_DEV_OPS for pm struct
Message-ID: <202608220346.df2N3qLw-lkp@intel.com>
References: <20260819054525.2325031-1-lijun01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819054525.2325031-1-lijun01@kylinos.cn>

Hi Li,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on bluetooth-next/master linus/master v7.2 next-20260820]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Jun/bluetooth-pm-use-SIMPLE_DEV_OPS-for-pm-struct/20260819-134525
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20260819054525.2325031-1-lijun01%40kylinos.cn
patch subject: [PATCH] bluetooth: pm: use SIMPLE_DEV_OPS for pm struct
config: powerpc-randconfig-r123-20260821 (https://download.01.org/0day-ci/archive/20260822/202608220346.df2N3qLw-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 935bfc708590c60147a79c7df145bb6e68b1d388)
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260822/202608220346.df2N3qLw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608220346.df2N3qLw-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/bluetooth/btmrvl_sdio.c:1729:1: sparse: sparse: symbol 'btmrvl_sdio_pm_ops' was not declared. Should it be static?

vim +/btmrvl_sdio_pm_ops +1729 drivers/bluetooth/btmrvl_sdio.c

  1728	
> 1729	SIMPLE_DEV_PM_OPS(btmrvl_sdio_pm_ops, btmrvl_sdio_suspend, btmrvl_sdio_resume);
  1730	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
