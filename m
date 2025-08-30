Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E98C2D0C64
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 Aug 2025 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756574965; cv=none; b=NTvPrE7+pjt3zxrQbZj86tgWHk0KGUztMQk7OkPVwNEI/XlrmmgOk5QzcNwqFLFdKcEjy8/S6DRQlXC7A5p/SBc4am7Ybi8EVmMe5tkoN6yJDAYToWnCEurwMHVeGOeFNJlvHm3sdoigvj4i6HnvbhTtAyzyrX47SZ2crsfESPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756574965; c=relaxed/simple;
	bh=8lI7XrnXcwI8I1CcQQDuAugMF3T9TugA+2rT2skzMoo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fWvDNxC0MyCxdeuwZKR52C9iVFnn3CALwRoSDX9Vv5vMDwxLKW5yfhoI5+vrVJCqKFlc9HNf5antpCE3Gxaz1+a688C6DLC6FsLE6eJs7C+s4fJ5YGS/QVxWut1tyy+oEObKgZ01gAGgyBYSQka4/ph5j6hB0XaTUxn10TyG+vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j+MfQS3Z; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+MfQS3Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756574964; x=1788110964;
  h=date:from:to:cc:subject:message-id;
  bh=8lI7XrnXcwI8I1CcQQDuAugMF3T9TugA+2rT2skzMoo=;
  b=j+MfQS3Zm9WIEjjZdq7pNSUso9+0j7VDvWOhz2idTKFO7+V6TaWefZpb
   ViJ+VI8WnGPq4BQ9A3HUKpbm+dtCw87H7d+JpZ24PaivmRNGsh6Q68WUH
   FwF+tPO5L+WH+fiJejH3+761VefH1tNpzbqGBYEVKxlmyQu2RKEqre813
   5Heca6foPNvhmG2oTelBCsePNh53IZq1xdPQlixNoh9GDIUNll0zj8imZ
   s5zhzX09R+mGCYEbokc/ncYSrPL0g7TpESKXbSGS76bZLjsY9fV8GcZs0
   7bZh+r7Wq9Ac904nphvi0Qv73PUpQcy9cN0OfiR00561Mwt2lREIpGEcG
   g==;
X-CSE-ConnectionGUID: Q3t4hmJKTryVXCoqib/3PA==
X-CSE-MsgGUID: zrQFgiXSQT6vRkgRXzSeYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="58981779"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="58981779"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2025 10:29:23 -0700
X-CSE-ConnectionGUID: bEijporaT/mJ8BWst0tYqA==
X-CSE-MsgGUID: QmUAXTDLRqW+qDgkjaZGrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="175900196"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 30 Aug 2025 10:29:21 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1usPNm-000VZj-2V;
	Sat, 30 Aug 2025 17:29:04 +0000
Date: Sun, 31 Aug 2025 01:27:59 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD REGRESSION
 02925b3b935e2203077ec974b93bf2d5f84ab754
Message-ID: <202508310142.DigBIrAX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 02925b3b935e2203077ec974b93bf2d5f84ab754  Bluetooth: Fix use-after-free in l2cap_sock_cleanup_listen()

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202508300413.OnIedvRh-lkp@intel.com

    drivers/bluetooth/bpa10x.c:77:33: error: array type has incomplete element type 'struct h4_recv_pkt'
    drivers/bluetooth/bpa10x.c:77:33: warning: 'bpa10x_recv_pkts' defined but not used [-Wunused-variable]
    drivers/bluetooth/bpa10x.c:77:49: error: array has incomplete element type 'const struct h4_recv_pkt'
    drivers/bluetooth/bpa10x.c:78:11: error: 'H4_RECV_ACL' undeclared here (not in a function)
    drivers/bluetooth/bpa10x.c:78:4: error: use of undeclared identifier 'H4_RECV_ACL'
    drivers/bluetooth/bpa10x.c:79:11: error: 'H4_RECV_SCO' undeclared here (not in a function)
    drivers/bluetooth/bpa10x.c:79:4: error: use of undeclared identifier 'H4_RECV_SCO'
    drivers/bluetooth/bpa10x.c:80:11: error: 'H4_RECV_EVENT' undeclared here (not in a function)
    drivers/bluetooth/bpa10x.c:80:4: error: use of undeclared identifier 'H4_RECV_EVENT'
    drivers/bluetooth/bpa10x.c:99:23: error: call to undeclared function 'h4_recv_buf'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    drivers/bluetooth/bpa10x.c:99:37: error: implicit declaration of function 'h4_recv_buf' [-Werror=implicit-function-declaration]
    drivers/bluetooth/btmtksdio.c:442:33: error: array type has incomplete element type 'struct h4_recv_pkt'
    drivers/bluetooth/btmtksdio.c:442:33: warning: 'mtk_recv_pkts' defined but not used [-Wunused-variable]
    drivers/bluetooth/btmtksdio.c:442:46: error: array has incomplete element type 'const struct h4_recv_pkt'
    drivers/bluetooth/btmtksdio.c:443:11: error: 'H4_RECV_ACL' undeclared here (not in a function)
    drivers/bluetooth/btmtksdio.c:443:22: error: field name not in record or union initializer
    drivers/bluetooth/btmtksdio.c:443:4: error: 'H4_RECV_ACL' undeclared here (not in a function); did you mean 'IP_RECVTTL'?
    drivers/bluetooth/btmtksdio.c:443:4: error: use of undeclared identifier 'H4_RECV_ACL'
    drivers/bluetooth/btmtksdio.c:444:11: error: 'H4_RECV_SCO' undeclared here (not in a function)
    drivers/bluetooth/btmtksdio.c:444:4: error: 'H4_RECV_SCO' undeclared here (not in a function)
    drivers/bluetooth/btmtksdio.c:444:4: error: use of undeclared identifier 'H4_RECV_SCO'
    drivers/bluetooth/btmtksdio.c:445:11: error: 'H4_RECV_EVENT' undeclared here (not in a function)
    drivers/bluetooth/btmtksdio.c:445:4: error: 'H4_RECV_EVENT' undeclared here (not in a function); did you mean 'BPF_PERF_EVENT'?
    drivers/bluetooth/btmtksdio.c:445:4: error: use of undeclared identifier 'H4_RECV_EVENT'
    drivers/bluetooth/btmtksdio.c:493:34: error: dereferencing pointer to incomplete type 'const struct h4_recv_pkt'
    drivers/bluetooth/btmtksdio.c:493:34: error: invalid use of undefined type 'struct h4_recv_pkt'
    drivers/bluetooth/btmtksdio.c:493:34: error: subscript of pointer to incomplete type 'const struct h4_recv_pkt'
    drivers/bluetooth/btmtksdio.c:493:48: error: invalid use of undefined type 'struct h4_recv_pkt'
    drivers/bluetooth/btmtksdio.c:493:52: error: invalid use of undefined type 'const struct h4_recv_pkt'
    drivers/bluetooth/btmtkuart.c:231:33: error: array type has incomplete element type 'struct h4_recv_pkt'
    drivers/bluetooth/btmtkuart.c:231:33: warning: 'mtk_recv_pkts' defined but not used [-Wunused-variable]
    drivers/bluetooth/btmtkuart.c:231:46: error: array has incomplete element type 'const struct h4_recv_pkt'
    drivers/bluetooth/btmtkuart.c:232:11: error: 'H4_RECV_ACL' undeclared here (not in a function)
    drivers/bluetooth/btmtkuart.c:232:4: error: use of undeclared identifier 'H4_RECV_ACL'
    drivers/bluetooth/btmtkuart.c:233:11: error: 'H4_RECV_SCO' undeclared here (not in a function)
    drivers/bluetooth/btmtkuart.c:233:4: error: use of undeclared identifier 'H4_RECV_SCO'
    drivers/bluetooth/btmtkuart.c:234:11: error: 'H4_RECV_EVENT' undeclared here (not in a function)
    drivers/bluetooth/btmtkuart.c:234:4: error: use of undeclared identifier 'H4_RECV_EVENT'
    drivers/bluetooth/btmtkuart.c:371:18: error: call to undeclared function 'h4_recv_buf'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    drivers/bluetooth/btmtkuart.c:371:32: error: implicit declaration of function 'h4_recv_buf' [-Werror=implicit-function-declaration]
    drivers/bluetooth/btmtkuart.c:371:32: error: implicit declaration of function 'h4_recv_buf' [-Wimplicit-function-declaration]
    drivers/bluetooth/btnxpuart.c:1741:33: error: array type has incomplete element type 'struct h4_recv_pkt'
    drivers/bluetooth/btnxpuart.c:1741:33: warning: 'nxp_recv_pkts' defined but not used [-Wunused-variable]
    drivers/bluetooth/btnxpuart.c:1741:46: error: array has incomplete element type 'const struct h4_recv_pkt'
    drivers/bluetooth/btnxpuart.c:1742:11: error: 'H4_RECV_ACL' undeclared here (not in a function)
    drivers/bluetooth/btnxpuart.c:1742:4: error: 'H4_RECV_ACL' undeclared here (not in a function); did you mean 'IP_RECVTTL'?
    drivers/bluetooth/btnxpuart.c:1742:4: error: use of undeclared identifier 'H4_RECV_ACL'
    drivers/bluetooth/btnxpuart.c:1743:11: error: 'H4_RECV_SCO' undeclared here (not in a function)
    drivers/bluetooth/btnxpuart.c:1743:4: error: 'H4_RECV_SCO' undeclared here (not in a function)
    drivers/bluetooth/btnxpuart.c:1743:4: error: use of undeclared identifier 'H4_RECV_SCO'
    drivers/bluetooth/btnxpuart.c:1744:11: error: 'H4_RECV_EVENT' undeclared here (not in a function)
    drivers/bluetooth/btnxpuart.c:1744:4: error: 'H4_RECV_EVENT' undeclared here (not in a function); did you mean 'BPF_PERF_EVENT'?
    drivers/bluetooth/btnxpuart.c:1744:4: error: use of undeclared identifier 'H4_RECV_EVENT'
    drivers/bluetooth/btnxpuart.c:1745:11: error: 'H4_RECV_ISO' undeclared here (not in a function)
    drivers/bluetooth/btnxpuart.c:1745:4: error: 'H4_RECV_ISO' undeclared here (not in a function); did you mean 'IP_RECVTOS'?
    drivers/bluetooth/btnxpuart.c:1745:4: error: use of undeclared identifier 'H4_RECV_ISO'
    drivers/bluetooth/btnxpuart.c:1759:19: error: call to undeclared function 'h4_recv_buf'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    drivers/bluetooth/btnxpuart.c:1759:19: error: implicit declaration of function 'h4_recv_buf'; did you mean 'sg_set_buf'? [-Werror=implicit-function-declaration]
    drivers/bluetooth/btnxpuart.c:1759:26: error: implicit declaration of function 'h4_recv_buf' [-Werror=implicit-function-declaration]

Error/Warning ids grouped by kconfigs:

recent_errors
|-- i386-buildonly-randconfig-004-20250830
|   |-- drivers-bluetooth-btmtkuart.c:error:H4_RECV_ACL-undeclared-here-(not-in-a-function)
|   |-- drivers-bluetooth-btmtkuart.c:error:H4_RECV_EVENT-undeclared-here-(not-in-a-function)
|   |-- drivers-bluetooth-btmtkuart.c:error:H4_RECV_SCO-undeclared-here-(not-in-a-function)
|   |-- drivers-bluetooth-btmtkuart.c:error:array-type-has-incomplete-element-type-struct-h4_recv_pkt
|   |-- drivers-bluetooth-btmtkuart.c:error:implicit-declaration-of-function-h4_recv_buf
|   `-- drivers-bluetooth-btmtkuart.c:warning:mtk_recv_pkts-defined-but-not-used
|-- i386-randconfig-003-20250830
|   |-- drivers-bluetooth-btmtksdio.c:error:array-has-incomplete-element-type-const-struct-h4_recv_pkt
|   |-- drivers-bluetooth-btmtksdio.c:error:subscript-of-pointer-to-incomplete-type-const-struct-h4_recv_pkt
|   |-- drivers-bluetooth-btmtksdio.c:error:use-of-undeclared-identifier-H4_RECV_ACL
|   |-- drivers-bluetooth-btmtksdio.c:error:use-of-undeclared-identifier-H4_RECV_EVENT
|   |-- drivers-bluetooth-btmtksdio.c:error:use-of-undeclared-identifier-H4_RECV_SCO
|   |-- drivers-bluetooth-btmtkuart.c:error:array-has-incomplete-element-type-const-struct-h4_recv_pkt
|   |-- drivers-bluetooth-btmtkuart.c:error:call-to-undeclared-function-h4_recv_buf-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-bluetooth-btmtkuart.c:error:use-of-undeclared-identifier-H4_RECV_ACL
|   |-- drivers-bluetooth-btmtkuart.c:error:use-of-undeclared-identifier-H4_RECV_EVENT
|   `-- drivers-bluetooth-btmtkuart.c:error:use-of-undeclared-identifier-H4_RECV_SCO
|-- i386-randconfig-004-20250830
|   |-- drivers-bluetooth-bpa1.c:error:array-has-incomplete-element-type-const-struct-h4_recv_pkt
|   |-- drivers-bluetooth-bpa1.c:error:call-to-undeclared-function-h4_recv_buf-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-bluetooth-bpa1.c:error:use-of-undeclared-identifier-H4_RECV_ACL
|   |-- drivers-bluetooth-bpa1.c:error:use-of-undeclared-identifier-H4_RECV_EVENT
|   `-- drivers-bluetooth-bpa1.c:error:use-of-undeclared-identifier-H4_RECV_SCO
|-- i386-randconfig-011-20250830
|   |-- drivers-bluetooth-bpa1.c:error:H4_RECV_ACL-undeclared-here-(not-in-a-function)
|   |-- drivers-bluetooth-bpa1.c:error:H4_RECV_EVENT-undeclared-here-(not-in-a-function)
|   |-- drivers-bluetooth-bpa1.c:error:H4_RECV_SCO-undeclared-here-(not-in-a-function)
|   |-- drivers-bluetooth-bpa1.c:error:array-type-has-incomplete-element-type-struct-h4_recv_pkt
|   |-- drivers-bluetooth-bpa1.c:error:implicit-declaration-of-function-h4_recv_buf
|   |-- drivers-bluetooth-bpa1.c:warning:bpa1_recv_pkts-defined-but-not-used
|   |-- drivers-bluetooth-btmtkuart.c:error:H4_RECV_ACL-undeclared-here-(not-in-a-function)
|   |-- drivers-bluetooth-btmtkuart.c:error:H4_RECV_EVENT-undeclared-here-(not-in-a-function)
|   |-- drivers-bluetooth-btmtkuart.c:error:H4_RECV_SCO-undeclared-here-(not-in-a-function)
|   |-- drivers-bluetooth-btmtkuart.c:error:array-type-has-incomplete-element-type-struct-h4_recv_pkt
|   |-- drivers-bluetooth-btmtkuart.c:error:implicit-declaration-of-function-h4_recv_buf
|   |-- drivers-bluetooth-btmtkuart.c:warning:mtk_recv_pkts-defined-but-not-used
|   |-- drivers-bluetooth-btnxpuart.c:error:H4_RECV_ACL-undeclared-here-(not-in-a-function)
|   |-- drivers-bluetooth-btnxpuart.c:error:H4_RECV_EVENT-undeclared-here-(not-in-a-function)
|   |-- drivers-bluetooth-btnxpuart.c:error:H4_RECV_ISO-undeclared-here-(not-in-a-function)
|   |-- drivers-bluetooth-btnxpuart.c:error:H4_RECV_SCO-undeclared-here-(not-in-a-function)
|   |-- drivers-bluetooth-btnxpuart.c:error:array-type-has-incomplete-element-type-struct-h4_recv_pkt
|   |-- drivers-bluetooth-btnxpuart.c:error:implicit-declaration-of-function-h4_recv_buf
|   `-- drivers-bluetooth-btnxpuart.c:warning:nxp_recv_pkts-defined-but-not-used
|-- nios2-randconfig-002-20250830
|   |-- drivers-bluetooth-btmtksdio.c:error:H4_RECV_ACL-undeclared-here-(not-in-a-function)
|   |-- drivers-bluetooth-btmtksdio.c:error:H4_RECV_EVENT-undeclared-here-(not-in-a-function)
|   |-- drivers-bluetooth-btmtksdio.c:error:H4_RECV_SCO-undeclared-here-(not-in-a-function)
|   |-- drivers-bluetooth-btmtksdio.c:error:array-type-has-incomplete-element-type-struct-h4_recv_pkt
|   |-- drivers-bluetooth-btmtksdio.c:error:dereferencing-pointer-to-incomplete-type-const-struct-h4_recv_pkt
|   |-- drivers-bluetooth-btmtksdio.c:error:field-name-not-in-record-or-union-initializer
|   |-- drivers-bluetooth-btmtksdio.c:error:invalid-use-of-undefined-type-struct-h4_recv_pkt
|   `-- drivers-bluetooth-btmtksdio.c:warning:mtk_recv_pkts-defined-but-not-used
|-- sparc-randconfig-001-20250830
|   |-- drivers-bluetooth-btmtksdio.c:error:H4_RECV_ACL-undeclared-here-(not-in-a-function)
|   |-- drivers-bluetooth-btmtksdio.c:error:H4_RECV_EVENT-undeclared-here-(not-in-a-function)
|   |-- drivers-bluetooth-btmtksdio.c:error:H4_RECV_SCO-undeclared-here-(not-in-a-function)
|   |-- drivers-bluetooth-btmtksdio.c:error:array-type-has-incomplete-element-type-struct-h4_recv_pkt
|   |-- drivers-bluetooth-btmtksdio.c:error:invalid-use-of-undefined-type-const-struct-h4_recv_pkt
|   |-- drivers-bluetooth-btmtksdio.c:error:invalid-use-of-undefined-type-struct-h4_recv_pkt
|   `-- drivers-bluetooth-btmtksdio.c:warning:mtk_recv_pkts-defined-but-not-used
|-- sparc-randconfig-r054-20250830
|   |-- drivers-bluetooth-btnxpuart.c:error:H4_RECV_ACL-undeclared-here-(not-in-a-function)
|   |-- drivers-bluetooth-btnxpuart.c:error:H4_RECV_EVENT-undeclared-here-(not-in-a-function)
|   |-- drivers-bluetooth-btnxpuart.c:error:H4_RECV_ISO-undeclared-here-(not-in-a-function)
|   |-- drivers-bluetooth-btnxpuart.c:error:H4_RECV_SCO-undeclared-here-(not-in-a-function)
|   |-- drivers-bluetooth-btnxpuart.c:error:array-type-has-incomplete-element-type-struct-h4_recv_pkt
|   |-- drivers-bluetooth-btnxpuart.c:error:implicit-declaration-of-function-h4_recv_buf
|   `-- drivers-bluetooth-btnxpuart.c:warning:nxp_recv_pkts-defined-but-not-used
|-- x86_64-randconfig-077-20250830
|   |-- drivers-bluetooth-btmtksdio.c:error:array-has-incomplete-element-type-const-struct-h4_recv_pkt
|   |-- drivers-bluetooth-btmtksdio.c:error:subscript-of-pointer-to-incomplete-type-const-struct-h4_recv_pkt
|   |-- drivers-bluetooth-btmtksdio.c:error:use-of-undeclared-identifier-H4_RECV_ACL
|   |-- drivers-bluetooth-btmtksdio.c:error:use-of-undeclared-identifier-H4_RECV_EVENT
|   |-- drivers-bluetooth-btmtksdio.c:error:use-of-undeclared-identifier-H4_RECV_SCO
|   |-- drivers-bluetooth-btmtkuart.c:error:array-has-incomplete-element-type-const-struct-h4_recv_pkt
|   |-- drivers-bluetooth-btmtkuart.c:error:call-to-undeclared-function-h4_recv_buf-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-bluetooth-btmtkuart.c:error:use-of-undeclared-identifier-H4_RECV_ACL
|   |-- drivers-bluetooth-btmtkuart.c:error:use-of-undeclared-identifier-H4_RECV_EVENT
|   |-- drivers-bluetooth-btmtkuart.c:error:use-of-undeclared-identifier-H4_RECV_SCO
|   |-- drivers-bluetooth-btnxpuart.c:error:array-has-incomplete-element-type-const-struct-h4_recv_pkt
|   |-- drivers-bluetooth-btnxpuart.c:error:call-to-undeclared-function-h4_recv_buf-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-bluetooth-btnxpuart.c:error:use-of-undeclared-identifier-H4_RECV_ACL
|   |-- drivers-bluetooth-btnxpuart.c:error:use-of-undeclared-identifier-H4_RECV_EVENT
|   |-- drivers-bluetooth-btnxpuart.c:error:use-of-undeclared-identifier-H4_RECV_ISO
|   `-- drivers-bluetooth-btnxpuart.c:error:use-of-undeclared-identifier-H4_RECV_SCO
`-- xtensa-randconfig-002-20250830
    |-- drivers-bluetooth-btmtkuart.c:error:H4_RECV_ACL-undeclared-here-(not-in-a-function)
    |-- drivers-bluetooth-btmtkuart.c:error:H4_RECV_EVENT-undeclared-here-(not-in-a-function)
    |-- drivers-bluetooth-btmtkuart.c:error:H4_RECV_SCO-undeclared-here-(not-in-a-function)
    |-- drivers-bluetooth-btmtkuart.c:error:array-type-has-incomplete-element-type-struct-h4_recv_pkt
    |-- drivers-bluetooth-btmtkuart.c:error:implicit-declaration-of-function-h4_recv_buf
    `-- drivers-bluetooth-btmtkuart.c:warning:mtk_recv_pkts-defined-but-not-used

elapsed time: 1448m

configs tested: 188
configs skipped: 4

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250830    gcc-8.5.0
arc                   randconfig-002-20250830    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                         orion5x_defconfig    gcc-15.1.0
arm                   randconfig-001-20250830    gcc-11.5.0
arm                   randconfig-002-20250830    clang-22
arm                   randconfig-003-20250830    clang-19
arm                   randconfig-004-20250830    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250830    gcc-10.5.0
arm64                 randconfig-002-20250830    clang-22
arm64                 randconfig-003-20250830    gcc-8.5.0
arm64                 randconfig-004-20250830    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250830    gcc-10.5.0
csky                  randconfig-002-20250830    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250830    clang-22
hexagon               randconfig-002-20250830    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250830    clang-20
i386        buildonly-randconfig-002-20250830    clang-20
i386        buildonly-randconfig-003-20250830    clang-20
i386        buildonly-randconfig-004-20250830    gcc-12
i386        buildonly-randconfig-005-20250830    clang-20
i386        buildonly-randconfig-006-20250830    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250830    clang-20
i386                  randconfig-002-20250830    clang-20
i386                  randconfig-003-20250830    clang-20
i386                  randconfig-004-20250830    clang-20
i386                  randconfig-005-20250830    clang-20
i386                  randconfig-006-20250830    clang-20
i386                  randconfig-007-20250830    clang-20
i386                  randconfig-011-20250830    gcc-12
i386                  randconfig-012-20250830    gcc-12
i386                  randconfig-013-20250830    gcc-12
i386                  randconfig-014-20250830    gcc-12
i386                  randconfig-015-20250830    gcc-12
i386                  randconfig-016-20250830    gcc-12
i386                  randconfig-017-20250830    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250830    clang-22
loongarch             randconfig-002-20250830    clang-18
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                        m5272c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          ath25_defconfig    gcc-15.1.0
mips                       bmips_be_defconfig    gcc-15.1.0
mips                           ip28_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250830    gcc-11.5.0
nios2                 randconfig-002-20250830    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250830    gcc-10.5.0
parisc                randconfig-002-20250830    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      katmai_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250830    gcc-15.1.0
powerpc               randconfig-002-20250830    clang-22
powerpc               randconfig-003-20250830    clang-22
powerpc                     tqm8548_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250830    clang-17
powerpc64             randconfig-002-20250830    gcc-14.3.0
powerpc64             randconfig-003-20250830    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv             nommu_k210_sdcard_defconfig    gcc-15.1.0
riscv                 randconfig-001-20250830    gcc-11.5.0
riscv                 randconfig-001-20250830    gcc-8.5.0
riscv                 randconfig-002-20250830    clang-22
riscv                 randconfig-002-20250830    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250830    clang-22
s390                  randconfig-001-20250830    gcc-11.5.0
s390                  randconfig-002-20250830    gcc-11.5.0
s390                  randconfig-002-20250830    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250830    gcc-11.5.0
sh                    randconfig-002-20250830    gcc-11.5.0
sh                    randconfig-002-20250830    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250830    gcc-11.5.0
sparc                 randconfig-001-20250830    gcc-13.4.0
sparc                 randconfig-002-20250830    gcc-11.5.0
sparc                 randconfig-002-20250830    gcc-8.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250830    gcc-11.5.0
sparc64               randconfig-002-20250830    clang-20
sparc64               randconfig-002-20250830    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250830    gcc-11.5.0
um                    randconfig-001-20250830    gcc-12
um                    randconfig-002-20250830    gcc-11.5.0
um                    randconfig-002-20250830    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250830    clang-20
x86_64      buildonly-randconfig-002-20250830    gcc-12
x86_64      buildonly-randconfig-003-20250830    clang-20
x86_64      buildonly-randconfig-004-20250830    gcc-12
x86_64      buildonly-randconfig-005-20250830    gcc-12
x86_64      buildonly-randconfig-006-20250830    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250830    gcc-11
x86_64                randconfig-002-20250830    gcc-11
x86_64                randconfig-003-20250830    gcc-11
x86_64                randconfig-004-20250830    gcc-11
x86_64                randconfig-005-20250830    gcc-11
x86_64                randconfig-006-20250830    gcc-11
x86_64                randconfig-007-20250830    gcc-11
x86_64                randconfig-008-20250830    gcc-11
x86_64                randconfig-071-20250830    gcc-12
x86_64                randconfig-072-20250830    gcc-12
x86_64                randconfig-073-20250830    gcc-12
x86_64                randconfig-074-20250830    gcc-12
x86_64                randconfig-075-20250830    gcc-12
x86_64                randconfig-076-20250830    gcc-12
x86_64                randconfig-077-20250830    gcc-12
x86_64                randconfig-078-20250830    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250830    gcc-11.5.0
xtensa                randconfig-001-20250830    gcc-12.5.0
xtensa                randconfig-002-20250830    gcc-11.5.0
xtensa                randconfig-002-20250830    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
