Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C078361DD1;
	Thu, 15 Jan 2026 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768479188; cv=none; b=GIN7v92VqpeOhzX6dc7+OBTMhvESIysfl1TOFIbx2znXSDCwwjL/qRWHgKTP4NvsgE3zjb2O0fWnOh5rONV3f/MQs8oWspObvzt8Yxbr7aoDilI3jUZkFOLwiRq4AgndZlMZC/Jp8xTHGhnkSkDILkkeuerLeL+8ujS9A7FfRRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768479188; c=relaxed/simple;
	bh=hBTMrcSNNS/bWH2d/dVTbvlc8bZQD7LtO0TVDzmiJeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDDuCbE3DmhURd49F8mBMv694E4tNxMxDZpbXMBkRsPGTfaZ00lR/n+tkbc1OASAItOVVds8KjmU9gDiY7qTp/5vDeSyc1XdZlN4D7THk1tlMEn9L1oTioftD6IEy+R+8G8mnNVoTA3lTeZy0VxJoPFfvvZlkse1TGRxl1HSkfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=In3Moc5E; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="In3Moc5E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768479184; x=1800015184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hBTMrcSNNS/bWH2d/dVTbvlc8bZQD7LtO0TVDzmiJeA=;
  b=In3Moc5EzBLUM56mxJDaSQqg/N+CmeDgr/xjWlPvVQm868kmFFy8lT9R
   SLkwpv7RSn9DrdOBm7XKRB8FXcdXCTtM7bxu5ggJy6tNiHQgdMxTBdQDR
   nCNY8pweJ7kHSVeKDNTVSlKnViJCM1DPGcEyNYJm/xiWY+QpL1qTvKsU0
   44F9GflpHgFHJQ8uBTJ/7sKKju+iTqCizW6nAJ56MYNRP/QYNordYQvtn
   DAsTcEIdb7VkY9fvVEjTDCDJ28WGk2hvFkU/3QqOIirvd6v2klbL3IUbr
   XCBLyys3da5+QbLzbaCsdDkzmxW+cIYN7+DvklX2VcAZ9NGyxcO09ce3H
   Q==;
X-CSE-ConnectionGUID: 5H+xaFtATy+KV5ta43Bhsw==
X-CSE-MsgGUID: 7WE8Qm7SSDmmBky/ix5PLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69518462"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="69518462"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 04:13:03 -0800
X-CSE-ConnectionGUID: MUf9d4NISPKBXfxEEks8vg==
X-CSE-MsgGUID: mSUBeS0VSCmCXJvsW7koJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="205352071"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 15 Jan 2026 04:13:02 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgMDj-00000000Hvq-3QyT;
	Thu, 15 Jan 2026 12:12:59 +0000
Date: Thu, 15 Jan 2026 20:12:25 +0800
From: kernel test robot <lkp@intel.com>
To: Jerry Wu <w.7erry@foxmail.com>, marcel@holtmann.org
Cc: oe-kbuild-all@lists.linux.dev, johan.hedberg@gmail.com,
	luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, w.7erry@foxmail.com
Subject: Re: [PATCH] Bluetooth: Perform careful capability checks in
 hci_sock_bind()
Message-ID: <202601152017.DD5KpHFj-lkp@intel.com>
References: <tencent_2FAB909645504A5E0FDC88F125E139242C05@qq.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_2FAB909645504A5E0FDC88F125E139242C05@qq.com>

Hi Jerry,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth/master]
[also build test ERROR on bluetooth-next/master linus/master v6.19-rc5 next-20260115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jerry-Wu/Bluetooth-Perform-careful-capability-checks-in-hci_sock_bind/20260109-100553
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/tencent_2FAB909645504A5E0FDC88F125E139242C05%40qq.com
patch subject: [PATCH] Bluetooth: Perform careful capability checks in hci_sock_bind()
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20260115/202601152017.DD5KpHFj-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260115/202601152017.DD5KpHFj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601152017.DD5KpHFj-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/capability.h:16,
                    from include/linux/cred.h:11,
                    from include/linux/sched/signal.h:10,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs/super_types.h:13,
                    from include/linux/fs/super.h:5,
                    from include/linux/fs.h:5,
                    from include/linux/compat.h:17,
                    from net/bluetooth/hci_sock.c:26:
   net/bluetooth/hci_sock.c: In function 'hci_sock_bind':
>> include/uapi/linux/capability.h:205:30: error: passing argument 1 of 'sk_capable' makes pointer from integer without a cast [-Wint-conversion]
     205 | #define CAP_NET_ADMIN        12
         |                              ^~
         |                              |
         |                              int
   net/bluetooth/hci_sock.c:1262:32: note: in expansion of macro 'CAP_NET_ADMIN'
    1262 |                 if (sk_capable(CAP_NET_ADMIN))
         |                                ^~~~~~~~~~~~~
   In file included from include/net/bluetooth/bluetooth.h:30,
                    from net/bluetooth/hci_sock.c:32:
   include/net/sock.h:3023:36: note: expected 'const struct sock *' but argument is of type 'int'
    3023 | bool sk_capable(const struct sock *sk, int cap);
         |                 ~~~~~~~~~~~~~~~~~~~^~
>> net/bluetooth/hci_sock.c:1262:21: error: too few arguments to function 'sk_capable'; expected 2, have 1
    1262 |                 if (sk_capable(CAP_NET_ADMIN))
         |                     ^~~~~~~~~~
   include/net/sock.h:3023:6: note: declared here
    3023 | bool sk_capable(const struct sock *sk, int cap);
         |      ^~~~~~~~~~
>> include/uapi/linux/capability.h:205:30: error: passing argument 1 of 'sk_capable' makes pointer from integer without a cast [-Wint-conversion]
     205 | #define CAP_NET_ADMIN        12
         |                              ^~
         |                              |
         |                              int
   net/bluetooth/hci_sock.c:1430:32: note: in expansion of macro 'CAP_NET_ADMIN'
    1430 |                 if (sk_capable(CAP_NET_ADMIN))
         |                                ^~~~~~~~~~~~~
   include/net/sock.h:3023:36: note: expected 'const struct sock *' but argument is of type 'int'
    3023 | bool sk_capable(const struct sock *sk, int cap);
         |                 ~~~~~~~~~~~~~~~~~~~^~
   net/bluetooth/hci_sock.c:1430:21: error: too few arguments to function 'sk_capable'; expected 2, have 1
    1430 |                 if (sk_capable(CAP_NET_ADMIN))
         |                     ^~~~~~~~~~
   include/net/sock.h:3023:6: note: declared here
    3023 | bool sk_capable(const struct sock *sk, int cap);
         |      ^~~~~~~~~~
--
   In file included from include/linux/capability.h:16,
                    from include/linux/cred.h:11,
                    from include/linux/sched/signal.h:10,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs/super_types.h:13,
                    from include/linux/fs/super.h:5,
                    from include/linux/fs.h:5,
                    from include/linux/compat.h:17,
                    from hci_sock.c:26:
   hci_sock.c: In function 'hci_sock_bind':
>> include/uapi/linux/capability.h:205:30: error: passing argument 1 of 'sk_capable' makes pointer from integer without a cast [-Wint-conversion]
     205 | #define CAP_NET_ADMIN        12
         |                              ^~
         |                              |
         |                              int
   hci_sock.c:1262:32: note: in expansion of macro 'CAP_NET_ADMIN'
    1262 |                 if (sk_capable(CAP_NET_ADMIN))
         |                                ^~~~~~~~~~~~~
   In file included from include/net/bluetooth/bluetooth.h:30,
                    from hci_sock.c:32:
   include/net/sock.h:3023:36: note: expected 'const struct sock *' but argument is of type 'int'
    3023 | bool sk_capable(const struct sock *sk, int cap);
         |                 ~~~~~~~~~~~~~~~~~~~^~
   hci_sock.c:1262:21: error: too few arguments to function 'sk_capable'; expected 2, have 1
    1262 |                 if (sk_capable(CAP_NET_ADMIN))
         |                     ^~~~~~~~~~
   include/net/sock.h:3023:6: note: declared here
    3023 | bool sk_capable(const struct sock *sk, int cap);
         |      ^~~~~~~~~~
>> include/uapi/linux/capability.h:205:30: error: passing argument 1 of 'sk_capable' makes pointer from integer without a cast [-Wint-conversion]
     205 | #define CAP_NET_ADMIN        12
         |                              ^~
         |                              |
         |                              int
   hci_sock.c:1430:32: note: in expansion of macro 'CAP_NET_ADMIN'
    1430 |                 if (sk_capable(CAP_NET_ADMIN))
         |                                ^~~~~~~~~~~~~
   include/net/sock.h:3023:36: note: expected 'const struct sock *' but argument is of type 'int'
    3023 | bool sk_capable(const struct sock *sk, int cap);
         |                 ~~~~~~~~~~~~~~~~~~~^~
   hci_sock.c:1430:21: error: too few arguments to function 'sk_capable'; expected 2, have 1
    1430 |                 if (sk_capable(CAP_NET_ADMIN))
         |                     ^~~~~~~~~~
   include/net/sock.h:3023:6: note: declared here
    3023 | bool sk_capable(const struct sock *sk, int cap);
         |      ^~~~~~~~~~


vim +/sk_capable +205 include/uapi/linux/capability.h

607ca46e97a1b65 David Howells 2012-10-13  204  
607ca46e97a1b65 David Howells 2012-10-13 @205  #define CAP_NET_ADMIN        12
607ca46e97a1b65 David Howells 2012-10-13  206  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
