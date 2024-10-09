Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3793238DD3
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Oct 2024 04:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728449972; cv=none; b=Otap8M6tCr1kx8WPBLaisuxmYYdF6Rjb6+Tisftclhp+VgqFIdW7s6rA7RfxPpayTyLS6YjR7l26jMDDArdgKwWYBm6BNmiTUlv9E5+hbbfjQdjRwWh185uqcS8EDTAYSm32ysw8bovPpffXTunwPZRwSQQW82kH+MsdFUM34Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728449972; c=relaxed/simple;
	bh=D1K0zNs2VLrfrw8EZiBoNOnliTn0ioPcv0weP2ltOTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1aYaKpa2r2IvjHtlZSZoE1E3X2Swix1DWghbcya7oNMv9aqlPfdBDsV8JtF1TiCflp+pxrN/g1aFUgpJriQpayjrc+BlBYqJ4bzDLefHF9PCQ/KTVLgIXzjCsFiBrY+JPiuqwVEwU5QCEUO0rbcsvvkoOQFwnpcqFVRB8fkr4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZQd1xzf; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZQd1xzf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728449970; x=1759985970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D1K0zNs2VLrfrw8EZiBoNOnliTn0ioPcv0weP2ltOTg=;
  b=dZQd1xzfKexM/M1cpOLTOnzJ94DQ0ZEw3u3ZQP+rlrEfPRlQ0wS8KrgH
   cWkrApgcNnNHPEszKZSwAbxyQ1IFOmdmHI1mQK9H180oY3teZHMBnwA1j
   gBft98DWRQbxQ0dbPa9115eWLkLZe3id61HAzM0SEy3AFncaNjXuTKqXn
   LTiA9b5AsDCrP8x2YnyM2CMCKDvirMp3Ryl9vPNv9ltKrc6z2fMWBJTgJ
   CxnGu2HmHnBDKAVmMnPfBUCWJBugJgM7mJdawn3UGI19G/urtHg4YcTGK
   eC4EBht7bUk5GERExNC3uMTfXXGP++nXy0iiyOL7S5qrV7V37JRs/y3L/
   A==;
X-CSE-ConnectionGUID: Sn/BsrgvShOWOKBSF5T/1g==
X-CSE-MsgGUID: L0cIIVMTROSsvF3bdtBTyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="15348136"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="15348136"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 21:59:29 -0700
X-CSE-ConnectionGUID: +KSim3ZxQE+rp+jWPzO2pg==
X-CSE-MsgGUID: 35afDs9JR7yOWruXhROr4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="76232807"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 08 Oct 2024 21:59:29 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syOnF-0008ka-2Z;
	Wed, 09 Oct 2024 04:59:25 +0000
Date: Wed, 9 Oct 2024 12:58:49 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 2/2] Bluetooth: hci_core: Fix not checking skb length
 on hci_scodata_packet
Message-ID: <202410091240.Pm3POYhz-lkp@intel.com>
References: <20241008154005.595169-2-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008154005.595169-2-luiz.dentz@gmail.com>

Hi Luiz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on bluetooth/master linus/master v6.12-rc2 next-20241008]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luiz-Augusto-von-Dentz/Bluetooth-hci_core-Fix-not-checking-skb-length-on-hci_scodata_packet/20241008-234120
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20241008154005.595169-2-luiz.dentz%40gmail.com
patch subject: [PATCH v1 2/2] Bluetooth: hci_core: Fix not checking skb length on hci_scodata_packet
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20241009/202410091240.Pm3POYhz-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241009/202410091240.Pm3POYhz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410091240.Pm3POYhz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:31,
                    from include/linux/rfkill.h:33,
                    from net/bluetooth/hci_core.c:29:
   net/bluetooth/hci_core.c: In function 'hci_scodata_packet':
>> include/net/bluetooth/bluetooth.h:280:16: warning: format '%s' expects argument of type 'char *', but argument 4 has type 'unsigned int' [-Wformat=]
     280 |         BT_DBG("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
         |                ^~~~~~
   include/linux/printk.h:355:21: note: in definition of macro 'pr_fmt'
     355 | #define pr_fmt(fmt) fmt
         |                     ^~~
   include/linux/dynamic_debug.h:248:9: note: in expansion of macro '__dynamic_func_call_cls'
     248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:250:9: note: in expansion of macro '_dynamic_func_call_cls'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call'
     269 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:589:9: note: in expansion of macro 'dynamic_pr_debug'
     589 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   include/net/bluetooth/bluetooth.h:268:33: note: in expansion of macro 'pr_debug'
     268 | #define BT_DBG(fmt, ...)        pr_debug(fmt "\n", ##__VA_ARGS__)
         |                                 ^~~~~~~~
   include/net/bluetooth/bluetooth.h:280:9: note: in expansion of macro 'BT_DBG'
     280 |         BT_DBG("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
         |         ^~~~~~
   net/bluetooth/hci_core.c:3825:9: note: in expansion of macro 'bt_dev_dbg'
    3825 |         bt_dev_dbg(hdev, "%s len %d handle 0x%4.4x flags 0x%4.4x", skb->len,
         |         ^~~~~~~~~~
>> include/net/bluetooth/bluetooth.h:280:16: warning: format '%x' expects a matching 'unsigned int' argument [-Wformat=]
     280 |         BT_DBG("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
         |                ^~~~~~
   include/linux/printk.h:355:21: note: in definition of macro 'pr_fmt'
     355 | #define pr_fmt(fmt) fmt
         |                     ^~~
   include/linux/dynamic_debug.h:248:9: note: in expansion of macro '__dynamic_func_call_cls'
     248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:250:9: note: in expansion of macro '_dynamic_func_call_cls'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call'
     269 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:589:9: note: in expansion of macro 'dynamic_pr_debug'
     589 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   include/net/bluetooth/bluetooth.h:268:33: note: in expansion of macro 'pr_debug'
     268 | #define BT_DBG(fmt, ...)        pr_debug(fmt "\n", ##__VA_ARGS__)
         |                                 ^~~~~~~~
   include/net/bluetooth/bluetooth.h:280:9: note: in expansion of macro 'BT_DBG'
     280 |         BT_DBG("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
         |         ^~~~~~
   net/bluetooth/hci_core.c:3825:9: note: in expansion of macro 'bt_dev_dbg'
    3825 |         bt_dev_dbg(hdev, "%s len %d handle 0x%4.4x flags 0x%4.4x", skb->len,
         |         ^~~~~~~~~~


vim +280 include/net/bluetooth/bluetooth.h

9b392e0e0b6d02 Luiz Augusto von Dentz 2022-03-03  272  
6f558b70fb39fc Loic Poulain           2015-08-30  273  #define bt_dev_info(hdev, fmt, ...)				\
9b392e0e0b6d02 Luiz Augusto von Dentz 2022-03-03  274  	BT_INFO("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
594b31ea7dc610 Frederic Danis         2015-09-23  275  #define bt_dev_warn(hdev, fmt, ...)				\
9b392e0e0b6d02 Luiz Augusto von Dentz 2022-03-03  276  	BT_WARN("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
6f558b70fb39fc Loic Poulain           2015-08-30  277  #define bt_dev_err(hdev, fmt, ...)				\
9b392e0e0b6d02 Luiz Augusto von Dentz 2022-03-03  278  	BT_ERR("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
6f558b70fb39fc Loic Poulain           2015-08-30  279  #define bt_dev_dbg(hdev, fmt, ...)				\
9b392e0e0b6d02 Luiz Augusto von Dentz 2022-03-03 @280  	BT_DBG("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
6f558b70fb39fc Loic Poulain           2015-08-30  281  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
