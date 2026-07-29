Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B7C4369A
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 00:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785285080; cv=none; b=Njhw7g/4PHEi9KR7Dm/u9yUVUJrZZX2PrjwAIWzLOmqhQua1ga8S11alh+H7OPEB9l1aHHGPpEOz4ZeemTTMPJurH/vJHnAZV4kZCXfDhAY+55MZnhYAFEJT8rDrgsj0921YYGkP3bsAmqp8rBlD9rTPDNL7y+eFVBZKU66VR2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785285080; c=relaxed/simple;
	bh=0vrX8e0vUswh1aNBdbAdhkn7LBgsDXbph2pVM4ethuA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ToIMAm3scNL8HRzFCiIsSIBDNfodd8gUthxLc2kfoM97fxtqubacibQslHDpOaAMYbX91Me/W1TdbovbvmapFRG8y6OehcFJ/lYIDA8i8RMPiFn2e1A7/2HGQFA2Il/ou29oy7REWKj2BspUFuUfYJe6mC6tpiK2WqZYkWTpR40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CZGPIsaH; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CZGPIsaH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785285078; x=1816821078;
  h=date:from:to:cc:subject:message-id;
  bh=0vrX8e0vUswh1aNBdbAdhkn7LBgsDXbph2pVM4ethuA=;
  b=CZGPIsaHHmcjuZFZpKU3Fx93MNEGWSx83+zr5MbNKikspj2+M6sz2NX3
   aJw/xpAcDU5UOglvFjezeQ+QQ1umOxAsLr5nlvq/R3roM7MShY2ivxFdx
   gqpNVLzdHDv+f9b9vAZJjHDUiaek1gQAjd6FGF+j6Gp91PCyXR0Amx4AV
   Rk0pdGCvq1STMD1Jv/1nT9DH0ynmQw2gU77mzieaUisi9gQsrwqwnkEbd
   8vF89sn2nQ+zIbAIM9SgQJS6/wpllSnGBKiipY8iYpoVmsPOJkQ6iC5w7
   mxoyd1qpY1Gcq5QhijzSHbnWoHkpZTkNzUySixRUrA0x8YJ+1kNV8mg69
   Q==;
X-CSE-ConnectionGUID: vKsx1BmJT1KAydpKEUorgQ==
X-CSE-MsgGUID: xilxl/cHRs2nXgx3B5ffhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="97395238"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="97395238"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 17:31:18 -0700
X-CSE-ConnectionGUID: o7B8zieDRO24JKi06ZmY0Q==
X-CSE-MsgGUID: imWg+K0EROyHYGdI+JWxdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="255939597"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 28 Jul 2026 17:31:17 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wosCY-00000000et9-46ld;
	Wed, 29 Jul 2026 00:31:14 +0000
Date: Wed, 29 Jul 2026 08:31:10 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 a7ef68421906a8b1c4204dda9b2e52b90f6fd2ba
Message-ID: <202607290855.XzXfUfTt-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: a7ef68421906a8b1c4204dda9b2e52b90f6fd2ba  Bluetooth: btintel_pcie: Add vendor_reset PCI sysfs for PLDR

elapsed time: 1415m

configs tested: 21
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
csky                            allmodconfig    gcc-16.1.0
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260729    gcc-14
i386       buildonly-randconfig-002-20260729    gcc-14
i386       buildonly-randconfig-003-20260729    gcc-14
i386       buildonly-randconfig-004-20260729    gcc-14
i386       buildonly-randconfig-005-20260729    gcc-14
i386       buildonly-randconfig-006-20260729    gcc-14
loongarch                          defconfig    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
parisc                          alldefconfig    gcc-16.1.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
sh                                 defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
