Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795728048;
	b=N8IvciqlqPKto/SUrHTDEGqtFBvkIflt791FpQqO2pgcOC7pFoNGYjj88IF/GgiEldMO
	 Z3bFI4iPcCmCSb7nq0L2AgHs+dFynw/9gAxIb4nhMQT/QSTM8kc/jK8C4WWt+HzswIIl/
	 e9vTC5z7FrF6xGpIv0wTJDMmuPJURNEqzrTjm224oqzk/yLUzF3GZ0VZQtNPiUUjxiuAT
	 9tlqewezRsz1OQhXZuO00PJYzAlIHN8ZisK3EXGuf2S8ETv4+quAExb8cyWCQvKfhUH10
	 CVmpSTa9BKRBk14wsl5m+N4u0Wc69O0NCE+qqnl8R9FSYh6uwIiMUmdr/5SKL8eTTbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795728048;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=wUGAxV18TnE+QmDGYMQkqkyWieWRUENOjOnE7cCymzw=;
	b=4lshgo5Sn5GkKPnYA51I2yn7oZnrTMZPcfUmv/DSQDVJmo/N/7z81u8+TCsP6mW0zSlS
	 gtZqym12MbYliqYyVfsFwCO8iDfbL/HTvd4zLhjBZWO5ATE4E/u3IUAKmbePTOKmafCGD
	 CuH/Y8AjBvDAJVRGDd0ezHJtsN1Abvj2YSQrW0/ER9S+FBW+10rFHLrJo9F2XyalUJcdS
	 ODgpw5pgaiR2B5mzwCCdr80Cs5jRSDjlfaosl4P+ugC2dLkjp110WCfeMd0izcAa+f6IE
	 I50/9R2iDYrgE0tRdFisiU5R/zylllej3jzPmPNUdbzbDif+XnxJrcodfgX54V9Jbiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Osyr6kHB;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E05606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 21:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99E05606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Osyr6kHB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795728047; x=1827264047;
  h=date:from:to:cc:subject:message-id;
  bh=TlAzBFQVb6G5KEIgsJaWMWvOQgxbyFP5nUazT8Ht5Dw=;
  b=Osyr6kHBqzTJ/dsYLnOIETNRVsohqRjWCWmwUZCaoFfuFRi3Pn8LhpyM
   LvfkFxM+I5KnWnPAtNrnRPnGJ2MS3JJ3IkExVWjs+8x4cDxtIJWyaFogj
   AaRgmEeaz+qdUk+wNOu/jsUymlmlEKS4kvsdgAS3MbA0uUp7EzJ22Db1w
   TmIcBsy7qfN7+flmZVUQrg/gERjtN2egNyGEHvAdc4MbucLWPsUJagC3b
   rOuXym7/5RrhVgTwFbGBSeQ+aAmcl9TenY/XhEOrBWufl/HMkM2B85kwQ
   AxVf88hU4RZKfMYOTt6r6i3f8OMqE42mcjDkUDu3g7FrQnEDV//WCNoU7
   Q==;
X-CSE-ConnectionGUID: CtRvK6YfTqOmkhfvElwRPw==
X-CSE-MsgGUID: rXYXrhYUTQ2gMuYjMmIKPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4551825"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4551825"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 13:20:47 -0800
X-CSE-ConnectionGUID: zE0mmOsGTXidYpBayQLh/A==
X-CSE-MsgGUID: +eseHOSQSP+CC5zD+8yTOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="12282311"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 26 Nov 2026 13:20:46 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xWgtM-00000001UuK-0E9K;
	Thu, 26 Nov 2026 21:20:32 +0000
Date: Fri, 27 Nov 2026 05:20:25 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS WITH UNVERIFIED
 WARNING f57f78086ab54f3b3122fbaeba2c842ba7bb6d00
Message-ID: <20261127052025.dX0g7rmg-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: f57f78086ab54f3b3122fbaeba2c842ba7bb6d00  Bluetooth: request LE data length for MT7922

Unverified Warning (likely false positive, kindly check if interested):

    https://lore.kernel.org/oe-kbuild/20261124042330.XroCvlEs-lkp@intel.com

    drivers/bluetooth/btintel_pcie.c:1038:3-13: second lock on line 1038

Warning ids grouped by kconfigs:

recent_errors
|-- loongarch-randconfig-r2108-20261125
|   `-- drivers-bluetooth-btintel_pcie.c:second-lock-on-line
`-- loongarch-randconfig-r2111-20261125
    `-- drivers-bluetooth-btintel_pcie.c:second-lock-on-line

elapsed time: 2919m

configs tested: 295
configs skipped: 0

tested configs:
alpha        randconfig-2000-20261125    gcc-12.5.0
alpha        randconfig-2000-20261125    gcc-8.5.0
alpha        randconfig-2001-20261125    gcc-8.5.0
alpha        randconfig-2200-20261125    gcc-10.5.0 smatch
alpha        randconfig-2200-20261126    gcc-9.5.0  smatch
alpha       randconfig-r2103-20261125    gcc-10.5.0 cocci
arc          randconfig-2000-20261125    gcc-10.5.0
arc          randconfig-2000-20261125    gcc-8.5.0
arc          randconfig-2001-20261125    gcc-10.5.0
arc          randconfig-2002-20261125    gcc-10.5.0
arc          randconfig-2002-20261125    gcc-16.2.0
arc          randconfig-2003-20261125    gcc-10.5.0
arc          randconfig-2004-20261125    gcc-10.5.0
arc          randconfig-2004-20261125    gcc-12.5.0
arc          randconfig-2005-20261125    gcc-10.5.0
arc          randconfig-2200-20261125    gcc-14.4.0 smatch
arc          randconfig-2200-20261126    gcc-8.5.0  smatch
arc         randconfig-r2103-20261125    gcc-16.2.0 cocci
arc         randconfig-r2109-20261125    clang-22   cocci
arc         randconfig-r2109-20261125    gcc-9.5.0  cocci
arc         randconfig-r2301-20261125    clang-24   sparse
arc         randconfig-r2310-20261126    gcc-8.5.0  sparse
arc         randconfig-r2311-20261126    gcc-8.5.0  sparse
arm          randconfig-2000-20261125    clang-17
arm          randconfig-2000-20261125    clang-22
arm          randconfig-2001-20261125    clang-22
arm          randconfig-2002-20261125    clang-17
arm          randconfig-2002-20261125    clang-22
arm          randconfig-2200-20261125    clang-21   smatch
arm          randconfig-2200-20261126    gcc-8.5.0  smatch
arm         randconfig-r2101-20261125    gcc-16.2.0 cocci
arm         randconfig-r2102-20261125    gcc-15.3.0 cocci
arm         randconfig-r2107-20261126    clang-17   cocci
arm         randconfig-r2108-20261126    clang-17   cocci
arm         randconfig-r2303-20261125    clang-24   sparse
arm         randconfig-r2308-20261126    gcc-8.5.0  sparse
arm64        randconfig-2000-20261125    clang-22
arm64        randconfig-2000-20261125    clang-24
arm64        randconfig-2001-20261125    clang-22
arm64        randconfig-2001-20261125    gcc-8.5.0
arm64        randconfig-2002-20261125    clang-17
arm64        randconfig-2002-20261125    clang-22
arm64        randconfig-2200-20261125    gcc-13.5.0 smatch
arm64       randconfig-r2306-20261125    gcc-13.5.0 sparse
arm64       randconfig-r2309-20261125    gcc-8.5.0  sparse
csky         randconfig-2000-20261125    gcc-14.4.0
csky         randconfig-2000-20261125    gcc-16.2.0
csky         randconfig-2001-20261125    gcc-14.4.0
csky         randconfig-2200-20261125    gcc-16.2.0 smatch
csky        randconfig-r2101-20261125    gcc-11.5.0 cocci
csky        randconfig-r2105-20261125    gcc-16.2.0 cocci
csky        randconfig-r2307-20261126    gcc-8.5.0  sparse
hexagon      randconfig-2000-20261125    clang-17
hexagon      randconfig-2000-20261125    gcc-14.4.0
hexagon      randconfig-2001-20261125    clang-24
hexagon      randconfig-2001-20261125    gcc-14.4.0
hexagon      randconfig-2200-20261125    clang-17   smatch
hexagon      randconfig-2200-20261126    clang-17   smatch
hexagon     randconfig-r2100-20261125    clang-17   cocci
hexagon     randconfig-r2104-20261125    gcc-16.2.0 cocci
hexagon     randconfig-r2303-20261125    clang-24   sparse
hexagon     randconfig-r2308-20261125    gcc-8.5.0  sparse
i386         randconfig-2000-20261125    clang-22
i386         randconfig-2000-20261125    gcc-14
i386         randconfig-2000-20261126    clang-22
i386         randconfig-2001-20261125    gcc-14
i386         randconfig-2001-20261126    clang-22
i386         randconfig-2002-20261125    gcc-14
i386         randconfig-2002-20261126    clang-22
i386         randconfig-2003-20261125    gcc-14
i386         randconfig-2003-20261126    clang-22
i386         randconfig-2004-20261125    clang-22
i386         randconfig-2004-20261125    gcc-14
i386         randconfig-2004-20261126    clang-22
i386         randconfig-2005-20261125    clang-22
i386         randconfig-2005-20261125    gcc-14
i386         randconfig-2005-20261126    clang-22
i386         randconfig-2100-20261125    clang-22   cocci
i386         randconfig-2101-20261125    clang-22   cocci
i386         randconfig-2102-20261125    clang-22   cocci
i386         randconfig-2103-20261125    clang-22   cocci
i386         randconfig-2104-20261125    clang-22   cocci
i386         randconfig-2104-20261125    gcc-14     cocci
i386         randconfig-2105-20261125    clang-22   cocci
i386         randconfig-2200-20261125    clang-22   smatch
i386         randconfig-2200-20261126    gcc-14     smatch
i386         randconfig-2300-20261125    clang-22   sparse
i386         randconfig-2301-20261125    clang-22   sparse
i386         randconfig-2302-20261125    clang-22   sparse
i386        randconfig-r2107-20261125    clang-22   cocci
loongarch    randconfig-2000-20261125    clang-19
loongarch    randconfig-2000-20261126    gcc-12.5.0
loongarch    randconfig-2001-20261125    clang-19
loongarch    randconfig-2001-20261125    gcc-16.2.0
loongarch    randconfig-2001-20261126    gcc-12.5.0
loongarch    randconfig-2200-20261125    clang-18   smatch
loongarch    randconfig-2200-20261126    gcc-14.4.0 smatch
loongarch   randconfig-r2108-20261125    clang-24   cocci
loongarch   randconfig-r2111-20261125    clang-24   cocci
m68k         randconfig-2000-20261125    gcc-8.5.0
m68k         randconfig-2001-20261125    gcc-11.5.0
m68k         randconfig-2001-20261125    gcc-8.5.0
m68k         randconfig-2200-20261125    gcc-15.3.0 smatch
m68k        randconfig-r2100-20261125    gcc-16.2.0 cocci
m68k        randconfig-r2107-20261125    gcc-10.5.0 cocci
m68k        randconfig-r2307-20261125    gcc-8.5.0  sparse
microblaze   randconfig-2000-20261125    gcc-12.5.0
microblaze   randconfig-2000-20261125    gcc-8.5.0
microblaze   randconfig-2001-20261125    gcc-10.5.0
microblaze   randconfig-2001-20261125    gcc-8.5.0
microblaze   randconfig-2200-20261125    gcc-8.5.0  smatch
microblaze   randconfig-2200-20261126    gcc-9.5.0  smatch
microblaze  randconfig-r2106-20261126    clang-17   cocci
microblaze  randconfig-r2111-20261126    clang-17   cocci
microblaze  randconfig-r2301-20261125    gcc-12.5.0 sparse
microblaze  randconfig-r2311-20261125    gcc-15.3.0 sparse
mips         randconfig-2000-20261125    gcc-14.4.0
mips         randconfig-2000-20261125    gcc-16.2.0
mips         randconfig-2000-20261126    gcc-16.2.0
mips         randconfig-2001-20261125    clang-17
mips         randconfig-2001-20261125    gcc-16.2.0
mips         randconfig-2001-20261126    gcc-16.2.0
mips         randconfig-2002-20261125    clang-24
mips         randconfig-2002-20261125    gcc-16.2.0
mips         randconfig-2002-20261126    gcc-16.2.0
mips         randconfig-2200-20261125    clang-24   smatch
mips        randconfig-r2110-20261125    clang-22   cocci
nios2        randconfig-2000-20261125    clang-19
nios2        randconfig-2000-20261125    gcc-8.5.0
nios2        randconfig-2000-20261126    gcc-12.5.0
nios2        randconfig-2001-20261125    clang-19
nios2        randconfig-2001-20261125    gcc-8.5.0
nios2        randconfig-2001-20261126    gcc-12.5.0
nios2        randconfig-2200-20261125    gcc-8.5.0  smatch
nios2        randconfig-2200-20261126    gcc-9.5.0  smatch
openrisc     randconfig-2000-20261125    gcc-12.5.0
openrisc     randconfig-2000-20261125    gcc-16.2.0
openrisc     randconfig-2000-20261126    gcc-16.2.0
openrisc     randconfig-2001-20261125    gcc-10.5.0
openrisc     randconfig-2001-20261125    gcc-16.2.0
openrisc     randconfig-2001-20261126    gcc-16.2.0
openrisc     randconfig-2002-20261125    gcc-16.2.0
openrisc     randconfig-2002-20261126    gcc-16.2.0
openrisc     randconfig-2200-20261125    gcc-10.5.0 smatch
openrisc     randconfig-2200-20261126    gcc-9.5.0  smatch
openrisc    randconfig-r2304-20261125    gcc-13.5.0 sparse
parisc       randconfig-2000-20261125    clang-19
parisc       randconfig-2000-20261125    gcc-10.5.0
parisc       randconfig-2000-20261126    gcc-12.5.0
parisc       randconfig-2001-20261125    clang-19
parisc       randconfig-2001-20261125    gcc-8.5.0
parisc       randconfig-2001-20261126    gcc-12.5.0
parisc       randconfig-2200-20261125    gcc-12.5.0 smatch
parisc       randconfig-2200-20261126    gcc-15.3.0 smatch
parisc      randconfig-r2300-20261125    clang-24   sparse
parisc      randconfig-r2300-20261125    gcc-15.3.0 sparse
parisc      randconfig-r2304-20261125    clang-24   sparse
parisc      randconfig-r2310-20261125    gcc-12.5.0 sparse
powerpc      randconfig-2000-20261125    clang-17
powerpc      randconfig-2000-20261125    gcc-9.5.0
powerpc      randconfig-2001-20261125    gcc-11.5.0
powerpc      randconfig-2001-20261125    gcc-9.5.0
powerpc      randconfig-2002-20261125    gcc-9.5.0
powerpc      randconfig-2200-20261125    gcc-11.5.0 smatch
powerpc      randconfig-2200-20261126    clang-24   smatch
powerpc     randconfig-r2110-20261125    clang-24   cocci
powerpc     randconfig-r2302-20261125    clang-24   sparse
powerpc     randconfig-r2306-20261126    gcc-8.5.0  sparse
powerpc     randconfig-r2307-20261125    clang-24   sparse
powerpc     randconfig-r2310-20261125    gcc-8.5.0  sparse
powerpc64    randconfig-2000-20261125    gcc-15.3.0
powerpc64    randconfig-2000-20261125    gcc-9.5.0
powerpc64    randconfig-2001-20261125    clang-17
powerpc64    randconfig-2001-20261125    gcc-9.5.0
powerpc64    randconfig-2002-20261125    clang-17
powerpc64    randconfig-2002-20261125    gcc-9.5.0
powerpc64    randconfig-2200-20261125    gcc-13.5.0 smatch
powerpc64    randconfig-2200-20261126    clang-24   smatch
powerpc64   randconfig-r2109-20261126    clang-17   cocci
powerpc64   randconfig-r2303-20261125    clang-24   sparse
powerpc64   randconfig-r2305-20261125    clang-17   sparse
riscv        randconfig-2000-20261125    gcc-13.5.0
riscv        randconfig-2001-20261125    gcc-13.5.0
riscv        randconfig-2001-20261125    gcc-8.5.0
riscv        randconfig-2002-20261125    gcc-13.5.0
riscv        randconfig-2002-20261125    gcc-8.5.0
riscv        randconfig-2003-20261125    gcc-11.5.0
riscv        randconfig-2003-20261125    gcc-13.5.0
riscv        randconfig-2004-20261125    gcc-13.5.0
riscv        randconfig-2004-20261125    gcc-8.5.0
riscv        randconfig-2005-20261125    clang-24
riscv        randconfig-2005-20261125    gcc-13.5.0
riscv        randconfig-2200-20261125    gcc-8.5.0  smatch
riscv        randconfig-2200-20261126    gcc-8.5.0  smatch
riscv       randconfig-r2105-20261125    clang-24   cocci
s390         randconfig-2000-20261125    clang-24
s390         randconfig-2000-20261125    gcc-8.5.0
s390         randconfig-2000-20261126    clang-24
s390         randconfig-2001-20261125    clang-24
s390         randconfig-2001-20261125    gcc-11.5.0
s390         randconfig-2001-20261126    clang-24
s390         randconfig-2002-20261125    clang-24
s390         randconfig-2002-20261126    clang-24
s390         randconfig-2003-20261125    clang-24
s390         randconfig-2003-20261125    gcc-8.5.0
s390         randconfig-2003-20261126    clang-24
s390         randconfig-2004-20261125    clang-24
s390         randconfig-2004-20261126    clang-24
s390         randconfig-2005-20261125    clang-20
s390         randconfig-2005-20261125    clang-24
s390         randconfig-2005-20261126    clang-24
s390         randconfig-2200-20261125    gcc-15.3.0 smatch
s390         randconfig-2200-20261126    gcc-16.2.0 smatch
s390        randconfig-r2102-20261125    gcc-16.2.0 cocci
s390        randconfig-r2110-20261126    clang-17   cocci
sh           randconfig-2000-20261125    gcc-14.4.0
sh           randconfig-2000-20261125    gcc-16.2.0
sh           randconfig-2000-20261126    gcc-9.5.0
sh           randconfig-2001-20261125    gcc-14.4.0
sh           randconfig-2001-20261126    gcc-9.5.0
sh           randconfig-2002-20261125    gcc-14.4.0
sh           randconfig-2002-20261125    gcc-16.2.0
sh           randconfig-2002-20261126    gcc-9.5.0
sh           randconfig-2003-20261125    gcc-14.4.0
sh           randconfig-2003-20261126    gcc-9.5.0
sh           randconfig-2004-20261125    gcc-14.4.0
sh           randconfig-2004-20261125    gcc-16.2.0
sh           randconfig-2004-20261126    gcc-9.5.0
sh           randconfig-2005-20261125    gcc-10.5.0
sh           randconfig-2005-20261125    gcc-14.4.0
sh           randconfig-2005-20261126    gcc-9.5.0
sh           randconfig-2200-20261125    gcc-14.4.0 smatch
sh           randconfig-2200-20261126    gcc-16.2.0 smatch
sh          randconfig-r2108-20261125    clang-22   cocci
sparc        randconfig-2000-20261125    gcc-16.2.0
sparc        randconfig-2000-20261125    gcc-8.5.0
sparc        randconfig-2001-20261125    gcc-16.2.0
sparc        randconfig-2001-20261125    gcc-8.5.0
sparc        randconfig-2200-20261124    gcc-11.5.0 smatch
sparc        randconfig-2200-20261125    gcc-14.4.0 smatch
sparc       randconfig-r2111-20261125    clang-22   cocci
sparc       randconfig-r2300-20261125    gcc-8.5.0  sparse
sparc       randconfig-r2308-20261125    gcc-16.2.0 sparse
sparc64      randconfig-2000-20261125    clang-24
sparc64      randconfig-2000-20261125    gcc-8.5.0
sparc64      randconfig-2001-20261125    gcc-8.5.0
sparc64      randconfig-2200-20261125    gcc-15.3.0 smatch
sparc64     randconfig-r2104-20261125    gcc-13.5.0 cocci
sparc64     randconfig-r2306-20261125    gcc-8.5.0  sparse
um           randconfig-2000-20261125    clang-17
um           randconfig-2000-20261125    gcc-8.5.0
um           randconfig-2001-20261125    clang-22
um           randconfig-2001-20261125    gcc-8.5.0
um           randconfig-2200-20261125    clang-17   smatch
um           randconfig-2200-20261126    gcc-12     smatch
um          randconfig-r2309-20261125    gcc-8.5.0  sparse
um          randconfig-r2309-20261126    gcc-8.5.0  sparse
x86_64                          kexec    clang-22
x86_64       randconfig-2000-20261125    gcc-14
x86_64       randconfig-2001-20261125    gcc-14
x86_64       randconfig-2002-20261125    gcc-14
x86_64       randconfig-2003-20261125    gcc-14
x86_64       randconfig-2004-20261125    gcc-14
x86_64       randconfig-2005-20261125    gcc-14
x86_64       randconfig-2100-20261125    clang-22   cocci
x86_64       randconfig-2100-20261125    gcc-13     cocci
x86_64       randconfig-2101-20261125    clang-22   cocci
x86_64       randconfig-2102-20261125    clang-22   cocci
x86_64       randconfig-2103-20261125    clang-22   cocci
x86_64       randconfig-2104-20261125    clang-22   cocci
x86_64       randconfig-2104-20261125    gcc-14     cocci
x86_64       randconfig-2105-20261125    clang-22   cocci
x86_64       randconfig-2105-20261125    gcc-14     cocci
x86_64       randconfig-2200-20261125    gcc-14     smatch
x86_64       randconfig-2300-20261125    clang-22   sparse
x86_64       randconfig-2301-20261125    clang-22   sparse
x86_64       randconfig-2302-20261125    clang-22   sparse
x86_64      randconfig-r2106-20261125    clang-22   cocci
x86_64      randconfig-r2106-20261125    gcc-14     cocci
x86_64      randconfig-r2302-20261125    gcc-14     sparse
x86_64                       rhel-9.4    clang-22
x86_64                   rhel-9.4-bpf    clang-22
x86_64                  rhel-9.4-func    clang-22
x86_64            rhel-9.4-kselftests    clang-22
x86_64                 rhel-9.4-kunit    clang-22
x86_64                   rhel-9.4-ltp    clang-22
x86_64                  rhel-9.4-rust    clang-22
xtensa       randconfig-2000-20261125    gcc-10.5.0
xtensa       randconfig-2000-20261125    gcc-14.4.0
xtensa       randconfig-2001-20261125    gcc-12.5.0
xtensa       randconfig-2001-20261125    gcc-14.4.0
xtensa       randconfig-2200-20261125    gcc-16.2.0 smatch
xtensa       randconfig-2200-20261126    gcc-11.5.0 smatch
xtensa      randconfig-r2305-20261125    clang-24   sparse
xtensa      randconfig-r2311-20261125    gcc-8.5.0  sparse

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
