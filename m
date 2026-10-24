Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792860303;
	b=vHqJdcVtYPeDL0jrBWHeEvQuuvL9yKovD0PfqLnvVA5A4kTIBnojAzUjZgYfOGoR17dA
	 s5sv7TYTYL1AVgR83fxrErJF2f7Lp4DcMS/wRnVu1yvQxulQR1yoCXfhyFe+3+JxLdRzJ
	 IAQxBJF+7m3jnKrUfGHEsfwSOoNTBrJNZ2Yq8hgIUet6XBsEbtZ+41dPVP4jmdXwOqntT
	 n2z/mC2pSfXDhVz/D66PmT2Mkuk8AHaMRJ5siZjALDTUHrxyDUAmY6szSgyh5BNVnJple
	 0MSwxiwraCMELMqOzouqaL1kQq5pecCh7cK5iTiX5ny2ieIUuGkri0HDpKRKLhWUznQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792860303;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=bTQo7vMxv/2vnEdEfnwsh47/mtSxjfDKLUpxkiqGmmQ=;
	b=2C+Uq+RmCcoAZZLLUiF5U+BZmzz52y7MFqyZorixPX3oI5T4qxgnQmDQYLNEP6aUJzst
	 OaAszlcSkc6fb2g4cfwlPDLLPTCNBK1lry12+hxMfHG36SaAtxureduZpicG0RmzJ8ASy
	 0yc1xfRCDqITMHDwDuvlDQQ/wOpNLhXEFMhA4KX00tzelo+vzsRIAyxQceGXHLYA1z8CD
	 P/iS3CYTFtD1buREGGqvmDEDsWQevGv74PaRJO57IUHbsztpaHkc+5MiRnKAA5bQg60H/
	 9OnX+OfIKKjqhF+QVH1LgYXOkMtKklP6c4B1voVWeEsmG0pIsevYL4oiZ7FcmMeNQmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="cAD44/GA";
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBE9606A31B
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 16:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FBE9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cAD44/GA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792860302; x=1824396302;
  h=date:from:to:cc:subject:message-id;
  bh=DQpciXC1RyNrvhBxcSl5P4AVzpCwnf+B1zqKxOuurS4=;
  b=cAD44/GAR7c9IkYOwz91iN6TS3pjzJuE7xp3XdRVOFKxQoKBi9UkkCys
   gV6JgJDXfyWT0yvUo992neUMOn1bz5s0XIYND+W98IgFEhbhGTVMQSpT8
   8vY8+HUBNvEmGw1TNNVws3F8c6ACYAXL8U2DtU6r8bzdSjapKY/fEPlbc
   nOFEC+7kolJvSz8RL8tvatr60x3WMfszBCt0iUNX76rJ4FnLVSPK1W7Gg
   RCLZu1GrBLNiLUXCD8NqQv0v0LY6Hwy1hWqhlARy2UPOWZc3xCWMRc3Bm
   GAAre4axMB3Jp/BTUt3vEgVu2oEDTKqhWgmubQ2DLcmOteay4NYpH86Ym
   Q==;
X-CSE-ConnectionGUID: 4l+5JFe9R36V8Ps7ktFnnQ==
X-CSE-MsgGUID: riG6xuCxRIWWAOdn9SEOmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11945"; a="1492244"
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="1492244"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2026 09:45:01 -0700
X-CSE-ConnectionGUID: 3drmyPc1T8yZLit4f0B3NA==
X-CSE-MsgGUID: eCIDIuDJTHy7QEFWH7lOFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="3765597"
Received: from igk-lkp-server01.igk.intel.com (HELO 58ca8a381a5c) ([10.211.93.152])
  by orviesa007.jf.intel.com with ESMTP; 24 Oct 2026 09:44:59 -0700
Received: from kbuild by 58ca8a381a5c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xKerY-000000003Pj-2kiz;
	Sat, 24 Oct 2026 16:44:56 +0000
Date: Sat, 24 Oct 2026 18:44:43 +0200
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master 138/152]
 drivers/bluetooth/btintel_pcie.h:569:2: warning: field  within 'struct
 btintel_pcie_dump_range' is less aligned than 'union
 btintel_pcie_dump_range::(anonymous at
 drivers/bluetooth/btintel_pcie.h:569:2)' and is usually due to 'struct
 btintel_pcie_dump_ran...
Message-ID: <202610241822.0XYZitPj-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   47d4d9f67e92d56ef3965f2727f9c98a5a611368
commit: 20357497f44ee392117dd4a6eed8cd53d5abdbd7 [138/152] Bluetooth: btintel_pcie: Allow COMPILE_TEST without ACPI
config: arm-randconfig-r2111-20261024 (https://download.01.org/0day-ci/archive/20261024/202610241822.0XYZitPj-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project a808f8ea7fdc61ead417bfe55e8ef5f728776aeb)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261024/202610241822.0XYZitPj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610241822.0XYZitPj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/bluetooth/btintel_pcie.c:30:
>> drivers/bluetooth/btintel_pcie.h:569:2: warning: field  within 'struct btintel_pcie_dump_range' is less aligned than 'union btintel_pcie_dump_range::(anonymous at drivers/bluetooth/btintel_pcie.h:569:2)' and is usually due to 'struct btintel_pcie_dump_range' being packed, which can lead to unaligned accesses [-Wunaligned-access]
     569 |         union {
         |         ^
   1 warning generated.


vim +569 drivers/bluetooth/btintel_pcie.h

07e6bddb54b48e Kiran K                 2025-03-03  563  
9ea41cd5a63975 Chandrashekar Devegowda 2026-09-04  564  /* Per-fragment range descriptor for dump regions.
9ea41cd5a63975 Chandrashekar Devegowda 2026-09-04  565   * Binary-compatible with iwl_fw_ini_error_dump_range.
9ea41cd5a63975 Chandrashekar Devegowda 2026-09-04  566   */
9ea41cd5a63975 Chandrashekar Devegowda 2026-09-04  567  struct btintel_pcie_dump_range {
9ea41cd5a63975 Chandrashekar Devegowda 2026-09-04  568  	__le32	range_data_size;
9ea41cd5a63975 Chandrashekar Devegowda 2026-09-04 @569  	union {
9ea41cd5a63975 Chandrashekar Devegowda 2026-09-04  570  		__le32	internal_base_addr;
9ea41cd5a63975 Chandrashekar Devegowda 2026-09-04  571  		__le64	dram_base_addr;
9ea41cd5a63975 Chandrashekar Devegowda 2026-09-04  572  		__le32	page_num;
9ea41cd5a63975 Chandrashekar Devegowda 2026-09-04  573  	};
9ea41cd5a63975 Chandrashekar Devegowda 2026-09-04  574  	__le32	data[];
9ea41cd5a63975 Chandrashekar Devegowda 2026-09-04  575  } __packed;
9ea41cd5a63975 Chandrashekar Devegowda 2026-09-04  576  

:::::: The code at line 569 was first introduced by commit
:::::: 9ea41cd5a6397544620c185d52d23ec556e37d02 Bluetooth: btintel_pcie: unified decoder coredump format

:::::: TO: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
:::::: CC: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
