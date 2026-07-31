Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0983E317B
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 14:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507775; cv=none; b=k8Huoy1xHJRHd0vA/HiUzYhjOMVK9aXnkL+EsYRoCAnlOlVQPMS1mzgZHcAJpLHsPceYOX64HZ7NG6HbbBiMEOPRMBnjLa0otoBAIjZ6/FGPWtg0dTASfC/AY8PHZe+v7R/ImvWk27qDUsD++KkbkQwhcJNhqzYMhqClAZ3Qp14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507775; c=relaxed/simple;
	bh=ftHZDS072FmLvb1JRwqCYDhjCN8/mQyuHC6BjTEgibc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MtW7WAuXBqlwXnwM145aijG86vj5JVWRoJn/KyMDJMX0jqZZhOh24cmNnJIOsFy/Mx5LtLQCChMCo1fPyqJnUx2D3tm3ctBhJqy79PFVmxAUm3+es7B6jPzmb1fNEryoLPoe3JaxrGFI7g4Wa0JRBFkJ3s7+iDIXbWxGQGaTcU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HbfgmwMr; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HbfgmwMr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785507774; x=1817043774;
  h=date:from:to:cc:subject:message-id;
  bh=ftHZDS072FmLvb1JRwqCYDhjCN8/mQyuHC6BjTEgibc=;
  b=HbfgmwMrIbcWNRefHdb7gv3e1jys1U/ZMmKzYXzdg07kT3gN5cgUoacT
   GQVYDzGC7N94WhH9RBUjr4onpuOIShfzqJcmJsnFgCVMIX1USpuj6b6Bs
   AknH3uwF314IOjDMHn54cfmTrtXvqBuUU7Snx1j6m2KE9tShKEoK8C6c6
   4M8l/pT/uw1oIo/nT0r5YE+r7aNvNXGn76CKwA++tVpNrJrhad/aSCfyK
   aUDXfASsuNFkHnnZN/aK79GBhy19mi8+2RigSF1p+uFi3CN0G2yW/61bY
   9VfS8dlGkZXQGsVX+DAPFL351cxDtHqoLzxCrWT+iIIhkRh+IdFUyg1RN
   w==;
X-CSE-ConnectionGUID: bTixdfmTRJiUd1MibrqgQQ==
X-CSE-MsgGUID: VwbMiV1xSZ2PJ6KK9GJJLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="86149357"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="86149357"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 07:22:53 -0700
X-CSE-ConnectionGUID: LclXo1/fTDilNq33JtWOuQ==
X-CSE-MsgGUID: PxEitMAUT/epvacm4OE9pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="264858523"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 31 Jul 2026 07:22:52 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wpo8Q-000000001Cl-1pgn;
	Fri, 31 Jul 2026 14:22:50 +0000
Date: Fri, 31 Jul 2026 22:22:38 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 735a14a2a4426760c5ff41ef3db5543fececcb75
Message-ID: <202607312225.Nid0ILV4-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 735a14a2a4426760c5ff41ef3db5543fececcb75  Bluetooth: Add MGMT Load Connection Subrate command

elapsed time: 802m

configs tested: 15
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                  allnoconfig    gcc-16.1.0
alpha                 allyesconfig    gcc-16.1.0
alpha                    defconfig    gcc-16.1.0
arc                   allmodconfig    gcc-16.1.0
arc                   allyesconfig    gcc-16.1.0
arm        milbeaut_m10v_defconfig    clang-16
csky                  allmodconfig    gcc-16.1.0
i386                  allmodconfig    gcc-14
loongarch                defconfig    clang-24
nios2                 allmodconfig    gcc-11.5.0
nios2                  allnoconfig    gcc-11.5.0
parisc                allmodconfig    gcc-16.1.0
parisc                allyesconfig    gcc-16.1.0
parisc                   defconfig    gcc-16.1.0
sh                       defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
