Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700C417B400
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Sep 2024 05:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726205379; cv=none; b=ubFv5FXWAUI9ePWnZwKHNp4ITFJP+wMGPBgpKRpICqBncknlC2ANAkTXU6Qfbb5/+bj2068kpTwAaRJgBsJv4K4BQN1rAowkbcrZggIJaRqmlRXjmEpvJs7PcFwvb4n33xs7bGIMYSV0w3iJFdTT/QpY4HIA1ABKpSFwKDOVK24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726205379; c=relaxed/simple;
	bh=oZ6M4pTD4oSlItcuflxFMv3uiQ9/2J3rMvHi70Xj3LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2bRjMVukVBizSOSWwhCGlnlFmIcn8vUmwkbEm1SXgpPb3uq8h8B4T97cjPBRdUCH9W9ixPatOmvcjOOPN8ijyfY44cB18oAhKi2K9zCjNKhdQal6ikBGejV5aso7lZiIydAuHRwbssqFhmPNYhgpOg49LWQXegWyG5VCPv9i1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BiLCKbih; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BiLCKbih"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726205376; x=1757741376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oZ6M4pTD4oSlItcuflxFMv3uiQ9/2J3rMvHi70Xj3LA=;
  b=BiLCKbih+5j+gMswsF5eoY+sMfnCdc0PrVLXH9wkC32uEhBS2iuBatvT
   s04YDAMX/mMVzhSJ4ewZ0nfbWl5o9sTcXmK9POx1IOY4DRxsNaBeXuuUp
   jCZJ4iY2qGq80qas2K1djyJren5NOqV59Q91/QPgi3WMEMi7F62ZUNTiY
   Hy6XX+hsIihhQgC0KkLLI8tdhiIqmyWCC89N+hl8Ko9yAd63GbTLKUKq8
   hUsgGk870+5rG33522cq6J48W+gabg9Wm0yhyE2aexgOco0cIInfsraxl
   Hq6cLzrbNoZxf0aKk0U+MmCWlNF/ggT/HRkdJ+NNQFKL3NzKRl1UfED+E
   Q==;
X-CSE-ConnectionGUID: fkOGjhqkRkyccRbshHhe8Q==
X-CSE-MsgGUID: 4b6vjP8kQnmL+a9ZR3aW4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="25190250"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="25190250"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 22:29:36 -0700
X-CSE-ConnectionGUID: Y0e2ByUoTRSF6u2ryCuEww==
X-CSE-MsgGUID: y/3z5rAkQP+mR0DBby+Waw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="72047679"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 12 Sep 2024 22:29:35 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soys8-00062o-2j;
	Fri, 13 Sep 2024 05:29:32 +0000
Date: Fri, 13 Sep 2024 13:29:13 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1] Bluetooth: MGMT: Fix possible crash on
 mgmt_index_removed
Message-ID: <202409131332.j8QQVdrT-lkp@intel.com>
References: <20240912164454.2996352-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912164454.2996352-1-luiz.dentz@gmail.com>

Hi Luiz,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth-next/master]
[also build test ERROR on bluetooth/master linus/master v6.11-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luiz-Augusto-von-Dentz/Bluetooth-MGMT-Fix-possible-crash-on-mgmt_index_removed/20240913-004604
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20240912164454.2996352-1-luiz.dentz%40gmail.com
patch subject: [PATCH v1] Bluetooth: MGMT: Fix possible crash on mgmt_index_removed
config: i386-buildonly-randconfig-001-20240913 (https://download.01.org/0day-ci/archive/20240913/202409131332.j8QQVdrT-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240913/202409131332.j8QQVdrT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409131332.j8QQVdrT-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/bluetooth/mgmt.c:1459:28: error: no member named 'hdev' in 'struct mgmt_pending_cmd'
    1459 |         hci_cmd_sync_dequeue(cmd->hdev, NULL, cmd, NULL);
         |                              ~~~  ^
   1 error generated.


vim +1459 net/bluetooth/mgmt.c

  1453	
  1454	static void cmd_complete_rsp(struct mgmt_pending_cmd *cmd, void *data)
  1455	{
  1456		/* dequeue cmd_sync entries using cmd as data as that is about to be
  1457		 * removed/freed.
  1458		 */
> 1459		hci_cmd_sync_dequeue(cmd->hdev, NULL, cmd, NULL);
  1460	
  1461		if (cmd->cmd_complete) {
  1462			u8 *status = data;
  1463	
  1464			cmd->cmd_complete(cmd, *status);
  1465			mgmt_pending_remove(cmd);
  1466	
  1467			return;
  1468		}
  1469	
  1470		cmd_status_rsp(cmd, data);
  1471	}
  1472	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
