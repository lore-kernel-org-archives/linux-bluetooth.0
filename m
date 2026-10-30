Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793342075;
	b=jPsZYNAYG/nu3067dFVOKCftWkqGK99I4MoMYWc6etCkHpz1HOpTUo4RLhVyq0Jdoy+e
	 gpXZVGA5krqHtADJE5tOZsa06LBneBThDaGCkh4Kh7cwZzxeG7wM8DEtVoNCkb5VxYEFD
	 ivvQhEODRKAUG33/3Z+cF3fRDiEUYNHvSYbUYwq28kvuVNN5YdUaT6UmpQATpn8D9kTDq
	 4MATR8PO8EqZQlbW3rfSp0ig0t8/Y1DudlqmJLQnAtGfnnHWjjhQ0L+xGKR9/CYSE2Zxn
	 gf9ekHJWUa2xdMgazWU1TAT7O5CCBnaBliSWtHnANoWVI2JWvPsFyzTy23UEj8VdamQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793342075;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=4cq7DC5qHtPKK2zJxY8VxDWBX5d4IPQHWqse1EYbGGA=;
	b=4tHWIw3klEw7l0aAoSkTKpFtzuR43vbGBgHFOOIo7ny04vCHhO2YAbTPPvz/5rEDaj8n
	 mH93mRPNrqhfu7ChENisFXLdJcLq5dqUTMguuoa0J7bhbuWbjAgrACxINGmgopfzyWboh
	 IYmX7adc970vOp/Qt+gAqy+IquAufK64tlnavvDm5jqMUVwpS6LFJQmYQhM/27sHTjxph
	 QFvOR2cb3kHaqDtYHnw20NCYgmcsgwuvoHvkVOYY6O7bXy72+VmdQ6xj8n3crSSHC4ALF
	 KLJWZZf92ESiXajQ2gsLoOIRR7fMrghpNmNkQYgIFp5w/2rvnkr0dCm2uLnH+j53gyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WEB02Ynz;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30178606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 06:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30178606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WEB02Ynz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793342073; x=1824878073;
  h=date:from:to:cc:subject:message-id;
  bh=IlPVmKx0D9D9ns3VSjtIvuuZBKRL9GSpSb8HNgvMCW4=;
  b=WEB02YnzvY2uzJsk7ko2dIERdhzWjsLG5Mz7xbDbN9EHPQKJB9db68tE
   0zLMgpQgLKTbSGPAKdI10T8VCgcYjyNmFysj3Z6aV1qvHLwI6JTSFAFyU
   HHg0W1+wqKtnMBDtTEA22ihv/Sx5Ar/CZB/yqUFQtlKEuRv1dA+2ukSao
   19cM6A5KDtnNNkFeMqWrJBI73RIkasIcMGgWuHiUGFXberjmhlogvOstQ
   hmYDPFQl5c81rIlrX5/ww+IPmqWR4qT8yYGNsbbB5UanyyRFCpWmu3MlF
   bCkZzroUrSgt5IljJcWlB8gZeKonM+FivKDb0Ao4F3oXt55Yhs5//Ryji
   g==;
X-CSE-ConnectionGUID: AXrjWOlKRJy3zUCYKCzYvA==
X-CSE-MsgGUID: dXMBRW2kTrGGfigNthoNdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2099585"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="2099585"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 23:34:32 -0700
X-CSE-ConnectionGUID: JKop21OhQ5ytkO+KlZodcg==
X-CSE-MsgGUID: pvD4dJqAQN2DkUQc1NBDUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5481440"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 29 Oct 2026 23:34:31 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xMgC4-00000000bOC-2mCl;
	Fri, 30 Oct 2026 06:34:28 +0000
Date: Fri, 30 Oct 2026 14:34:14 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 1081a6ef8f1e0661fd52eb3f878691b0b96cdff9
Message-ID: <202610301410.aj6aUGGA-lkp@intel.com>
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
branch HEAD: 1081a6ef8f1e0661fd52eb3f878691b0b96cdff9  Bluetooth: btintel: check FIPS status before firmware download

elapsed time: 1727m

configs tested: 50
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha               allnoconfig    gcc-16.2.0
alpha              allyesconfig    gcc-16.2.0
arc                 allnoconfig    gcc-16.2.0
arc                allyesconfig    gcc-16.2.0
arm                 allnoconfig    clang-17
arm64               allnoconfig    gcc-16.2.0
csky               allmodconfig    gcc-16.2.0
csky                allnoconfig    gcc-16.2.0
hexagon            allmodconfig    clang-24
hexagon             allnoconfig    clang-24
i386                allnoconfig    gcc-14
loongarch           allnoconfig    clang-20
m68k               allmodconfig    gcc-16.2.0
m68k                allnoconfig    gcc-16.2.0
microblaze          allnoconfig    gcc-16.2.0
microblaze         allyesconfig    gcc-16.2.0
mips               allmodconfig    gcc-16.2.0
mips                allnoconfig    gcc-16.2.0
mips               allyesconfig    gcc-16.2.0
nios2              allmodconfig    gcc-11.5.0
nios2               allnoconfig    gcc-11.5.0
openrisc           allmodconfig    gcc-16.2.0
openrisc            allnoconfig    gcc-16.2.0
parisc             allmodconfig    gcc-16.2.0
parisc              allnoconfig    gcc-16.2.0
parisc             allyesconfig    gcc-16.2.0
powerpc            allmodconfig    gcc-16.2.0
powerpc             allnoconfig    gcc-16.2.0
riscv               allnoconfig    gcc-16.2.0
s390               allmodconfig    clang-24
s390                allnoconfig    clang-24
s390               allyesconfig    gcc-16.2.0
sh                 allmodconfig    gcc-16.2.0
sh                  allnoconfig    gcc-16.2.0
sh                 allyesconfig    gcc-16.2.0
sparc               allnoconfig    gcc-16.2.0
sparc64            allmodconfig    clang-20
um                 allmodconfig    clang-17
um                  allnoconfig    clang-17
um                 allyesconfig    gcc-14
x86_64              allnoconfig    clang-22
x86_64                    kexec    clang-22
x86_64                 rhel-9.4    clang-22
x86_64             rhel-9.4-bpf    gcc-14
x86_64            rhel-9.4-func    clang-22
x86_64      rhel-9.4-kselftests    clang-22
x86_64           rhel-9.4-kunit    gcc-14
x86_64             rhel-9.4-ltp    gcc-14
xtensa              allnoconfig    gcc-16.2.0
xtensa             allyesconfig    gcc-16.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
