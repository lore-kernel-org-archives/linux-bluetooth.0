Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A7C194A73
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Oct 2025 11:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759575908; cv=none; b=sSTXXET9iQRWr3dYnXzVyE00yx7WtzDDXc9/52tb6+cc9t3t4nbrQ3FDHjwNg/TSJrZ1SycOonWEt9uhoh/2rQRe55uZyhMzKl5qEHvzWNMdTzSdK9hoYa1EEZP8f9wc/QlpoXJiEGS6AjXdPIurZspbpy6aigQtd+c9iHAkafY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759575908; c=relaxed/simple;
	bh=YymLoYoPxYqvFLQAZRwL4A8Jz0tVFPJthzVjTRWUfG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pB32qjSXOGolM/jh2vA+p0DHQtpGryALjTW2yVRxL79doguFHiHi3pALJSdXKJvWMS+xxpEaNvG0Hd5K7YCq/qHAqIpdDLcM+e/bugyAJWiL/ML6x6bVj6UbUyq8BRaRK5IscqVAgEWp1dfhCSCdMWI59CRGh4HHMz73pnyiX7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TEL4wm11; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TEL4wm11"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759575906; x=1791111906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YymLoYoPxYqvFLQAZRwL4A8Jz0tVFPJthzVjTRWUfG8=;
  b=TEL4wm11ug45Wy8k3je/AVv5Icg4DdawsJKeUZlpPAaOFcdHpS+MfhrB
   GKzcHm6qlRdJMH6iF+PyN0W7+dpwoBYHN1P+c9U/upay/0ARuVWJ0h4ck
   B71Hg6I/gIMZB/VEpJMMTnJwrf4sGqUvtXcVdf1SxtXrqyezoOuUxVF9V
   ZQc/FGpCQqQ5ctMyti207tuhS1FNLmvi1detFs4thu/qYK3yYNUiV+9lI
   +HonQE673CAOkEzHZjFedwZZFNLruO6FvTqq8n2p8pm8j0xQxvpWULZqb
   xe0MYlXh1NmAPhmZ8YaUtqP51KoMpG9EaFH7loF/2Yj8esJp32K0L6vtS
   g==;
X-CSE-ConnectionGUID: fh7Ds5uPTJmkpmXWbrZiDA==
X-CSE-MsgGUID: 05NyrnVfQeiKaUXsol4ZAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="72512349"
X-IronPort-AV: E=Sophos;i="6.18,315,1751266800"; 
   d="scan'208";a="72512349"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2025 04:05:05 -0700
X-CSE-ConnectionGUID: wt0CGFRcSHamzpgFhX/3+g==
X-CSE-MsgGUID: PErs7qIgQByWncuDO3a+oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,315,1751266800"; 
   d="scan'208";a="179411758"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 04 Oct 2025 04:05:04 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v504U-0005ER-0E;
	Sat, 04 Oct 2025 11:05:02 +0000
Date: Sat, 4 Oct 2025 19:04:06 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 3/5] Bluetooth: ISO: Add support to bind to trigger
 PAST
Message-ID: <202510041823.Gu7nrN3J-lkp@intel.com>
References: <20251003153424.470938-3-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003153424.470938-3-luiz.dentz@gmail.com>

Hi Luiz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on bluetooth/master linus/master v6.17 next-20251003]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luiz-Augusto-von-Dentz/Bluetooth-hci_core-Introduce-HCI_CONN_FLAG_PAST/20251003-233649
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20251003153424.470938-3-luiz.dentz%40gmail.com
patch subject: [PATCH v1 3/5] Bluetooth: ISO: Add support to bind to trigger PAST
config: openrisc-randconfig-r123-20251004 (https://download.01.org/0day-ci/archive/20251004/202510041823.Gu7nrN3J-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251004/202510041823.Gu7nrN3J-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510041823.Gu7nrN3J-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/bluetooth/hci_sync.c:7256:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [usertype] handle @@     got unsigned short [usertype] handle @@
   net/bluetooth/hci_sync.c:7256:19: sparse:     expected restricted __le16 [addressable] [usertype] handle
   net/bluetooth/hci_sync.c:7256:19: sparse:     got unsigned short [usertype] handle
   net/bluetooth/hci_sync.c:7273:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [usertype] handle @@     got unsigned short [usertype] handle @@
   net/bluetooth/hci_sync.c:7273:19: sparse:     expected restricted __le16 [addressable] [usertype] handle
   net/bluetooth/hci_sync.c:7273:19: sparse:     got unsigned short [usertype] handle

vim +7256 net/bluetooth/hci_sync.c

  7245	
  7246	static int hci_le_past_set_info_sync(struct hci_dev *hdev, void *data)
  7247	{
  7248		struct past_data *past = data;
  7249		struct hci_cp_le_past_set_info cp;
  7250	
  7251		if (!hci_conn_valid(hdev, past->conn) ||
  7252		    !hci_conn_valid(hdev, past->le))
  7253			return -ECANCELED;
  7254	
  7255		memset(&cp, 0, sizeof(cp));
> 7256		cp.handle = past->le->handle;
  7257		cp.adv_handle = past->conn->iso_qos.bcast.bis;
  7258	
  7259		return __hci_cmd_sync_status(hdev, HCI_OP_LE_PAST_SET_INFO,
  7260					     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
  7261	}
  7262	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
