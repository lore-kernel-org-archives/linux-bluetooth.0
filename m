Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4CE78B4E
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Sep 2024 04:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726201057; cv=none; b=bj8JjFGD8A5bnWQfV9rCTQfODejccUGS8iooRJQ0CzxvReF/mJvh2t7yJonrLExzJqvqf+hsQLV3nHnqWEYqAn97TjFSpMH9rZ7cPW+bf+8bcfFmR79t+4AOg3L3rt78l51LwjVTwjqG2TC3ndFyTYhEpiFcvwpuHwY/lMMkZ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726201057; c=relaxed/simple;
	bh=EpdHpZFDKM10d3kQHw+GuaxEYxE5eEki6OWFTfxcAeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hu9MDlrZnIH3QMvLYWtZQGksozsDk4xYzr3Ek2ZLf38DE8P5nH+HPWyOpJJS3kUtWjc2mimXL/Nlqq2ono7mk8LInBJa2BnT+pA9nbkfz5tTRhF72f4w5vcExLy6p2PK/pbF025HNFR1YkiEo/2oUlMYJAT73/GNN31K48VTp18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sb/IvM7F; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sb/IvM7F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726201055; x=1757737055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EpdHpZFDKM10d3kQHw+GuaxEYxE5eEki6OWFTfxcAeM=;
  b=Sb/IvM7F6iSIMWUMd2VuvFRlvX5vTHTU0M4ZSfjueQaSdif1WkrUC/5g
   rZQrPshq52nwfHmPPzOVFlpQqcj/fvjGudXDe4aP3KvH8NJQZpESV1kb0
   SxC7gimGMEZCUdowIg6tvuTWA3Wv2nnXO1qaIT8dvocYLJOGEVz0deERg
   1djhZpJl5GCm+LVcH6+/W+ELrZGwk6HJTuCF+A5z0G1DF4o+Enb+PnPEl
   CORynqRPVC2LHDH4fsbG10nRsS0I7QHR7lN+h7bP4sqDyQD4jW6z4R+PG
   6nN87OM7L78m6F6+dHhQtvnU/+JTNRFEOJQYLSTtPsvEeUHw+fbub5dOR
   A==;
X-CSE-ConnectionGUID: bX3DkHOQT1yTB44LXPsQFA==
X-CSE-MsgGUID: TgpPJ+vhT7atLHYwNTeUIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="42564406"
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="42564406"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 21:17:35 -0700
X-CSE-ConnectionGUID: 7ZlYBhWgQS6LBQSOPcOHNg==
X-CSE-MsgGUID: 7rErM16vTPCmMkPHJwZm3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="67766195"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 12 Sep 2024 21:17:33 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soxkR-0005zq-0N;
	Fri, 13 Sep 2024 04:17:31 +0000
Date: Fri, 13 Sep 2024 12:16:33 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1] Bluetooth: MGMT: Fix possible crash on
 mgmt_index_removed
Message-ID: <202409131212.VOjz2kzX-lkp@intel.com>
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
[also build test ERROR on bluetooth/master linus/master v6.11-rc7 next-20240912]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luiz-Augusto-von-Dentz/Bluetooth-MGMT-Fix-possible-crash-on-mgmt_index_removed/20240913-004604
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20240912164454.2996352-1-luiz.dentz%40gmail.com
patch subject: [PATCH v1] Bluetooth: MGMT: Fix possible crash on mgmt_index_removed
config: openrisc-randconfig-r071-20240913 (https://download.01.org/0day-ci/archive/20240913/202409131212.VOjz2kzX-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240913/202409131212.VOjz2kzX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409131212.VOjz2kzX-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/bluetooth/mgmt.c: In function 'cmd_complete_rsp':
>> net/bluetooth/mgmt.c:1459:33: error: 'struct mgmt_pending_cmd' has no member named 'hdev'
    1459 |         hci_cmd_sync_dequeue(cmd->hdev, NULL, cmd, NULL);
         |                                 ^~


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
