Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B4B23BB
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 04:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724732932; cv=none; b=LY6vybhJfet3RcX9tIDC64/4KkFG/nGJK48PZsXwHePAPRT8ZvwdlqAwBpSP8YgEQ/a8q3IJAPgvdetpBQfNvEx1t6SeFURq77FWL4P11Gtx0TcC8kbf4sIuHMBLBzfjSrjgVrY+j8VLZF+pU4qz7jU0o/izTFmT4lhKhTZe1Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724732932; c=relaxed/simple;
	bh=O81vLQlf92sQ50dNd2e7DMFDmvbPgY1rr+oCb3gEz3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/+OO1sD2NLnTWr44dDNF7HMCeB+qoP4WAIJhsT2VJ8NBzQpCzFZ7rjcW9l8Y5murWHlJE/COzrsih1DlFqsAmd+BQNKtUP2VRthKlNx7TMPUjVaswM7F+QvNfELHsjW7hFcCXpu1a+Rp/TAKvvp3MaBr1HlFwDvpiNqodmE8H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UGHkhkKQ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UGHkhkKQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724732930; x=1756268930;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O81vLQlf92sQ50dNd2e7DMFDmvbPgY1rr+oCb3gEz3c=;
  b=UGHkhkKQPMK3Nf67d8uzaJrXgx8sM0lN+CTAQsKdQdfoVHwbR+hyDxmd
   s/AmcYFhnjOnQSXo/sB++nlY0C9kYPi6u6FAp/gRGnQpGxGierLJIM6WG
   U5cFYErqs9UgyIXseQ4Aqeo/E0TLfdqNHxWqzjAOlQ5YaTNMZTwpkC+wZ
   n9PkfyVtRxEMuKHDNQ8AfCgRqTtsyVnDXDLAi2sNCZV718LKKCxD4fPEP
   o5itdeYbYiNklUbI89grkoiEXu6NIBbVLmvatTsVKBtjGwXME/SJ3ZCLK
   DS++NHJnKIwWS/+rNJTojjVM54maMOhL33nfNHMZKVfvEH4SExYsYGNT4
   g==;
X-CSE-ConnectionGUID: XWLtnQajTo6I3nDwUMbbjA==
X-CSE-MsgGUID: REyvIOBmR0OJeZ4joSonew==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="34596300"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="34596300"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 21:28:49 -0700
X-CSE-ConnectionGUID: LqEFLe1/SUa8/ZufO7Aj8w==
X-CSE-MsgGUID: c7HfL0rOTSyvEeZlaPuY6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="100234090"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 26 Aug 2024 21:28:48 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sinoz-000Hus-31;
	Tue, 27 Aug 2024 04:28:45 +0000
Date: Tue, 27 Aug 2024 12:28:42 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 2/2] Bluetooth: MGMT: Fix not generating command
 complete for MGMT_OP_DISCONNECT
Message-ID: <202408271234.sY3VKVIg-lkp@intel.com>
References: <20240826202518.524007-2-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826202518.524007-2-luiz.dentz@gmail.com>

Hi Luiz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on bluetooth/master linus/master v6.11-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luiz-Augusto-von-Dentz/Bluetooth-MGMT-Fix-not-generating-command-complete-for-MGMT_OP_DISCONNECT/20240827-042615
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20240826202518.524007-2-luiz.dentz%40gmail.com
patch subject: [PATCH v2 2/2] Bluetooth: MGMT: Fix not generating command complete for MGMT_OP_DISCONNECT
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240827/202408271234.sY3VKVIg-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408271234.sY3VKVIg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408271234.sY3VKVIg-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/bluetooth/mgmt.c:9709:13: warning: 'disconnect_rsp' defined but not used [-Wunused-function]
    9709 | static void disconnect_rsp(struct mgmt_pending_cmd *cmd, void *data)
         |             ^~~~~~~~~~~~~~


vim +/disconnect_rsp +9709 net/bluetooth/mgmt.c

f7520543ab4034 Johan Hedberg 2011-01-20  9708  
3b0602cd01a571 Johan Hedberg 2015-03-06 @9709  static void disconnect_rsp(struct mgmt_pending_cmd *cmd, void *data)
8962ee74be48df Johan Hedberg 2011-01-20  9710  {
8962ee74be48df Johan Hedberg 2011-01-20  9711  	struct sock **sk = data;
8962ee74be48df Johan Hedberg 2011-01-20  9712  
f5818c2241247c Johan Hedberg 2014-12-05  9713  	cmd->cmd_complete(cmd, 0);
8962ee74be48df Johan Hedberg 2011-01-20  9714  
8962ee74be48df Johan Hedberg 2011-01-20  9715  	*sk = cmd->sk;
8962ee74be48df Johan Hedberg 2011-01-20  9716  	sock_hold(*sk);
8962ee74be48df Johan Hedberg 2011-01-20  9717  
a664b5bc77fbc8 Johan Hedberg 2011-02-19  9718  	mgmt_pending_remove(cmd);
8962ee74be48df Johan Hedberg 2011-01-20  9719  }
8962ee74be48df Johan Hedberg 2011-01-20  9720  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
