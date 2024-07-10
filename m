Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724C31B86F3
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 10:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720605868; cv=none; b=SRjbKcjkvYFybjqfmll9NWZfdzjly8QweBNoVS/RelwBVEUQCoyviyFUMXAUww8Y+pa+0oc4vDBbL5Pgu2c0Vz+P3OSmUFHx1b1ewnxiFQKULiNNrlnm3oQDb5y/+TxAAaMSB2nFHCiTGshPvC3oRWW7tXzDoaO4vwJfe/+YvWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720605868; c=relaxed/simple;
	bh=mUWgFqhHUwkwmoaUVqVtT7iR5lN8Jw0QHcnbLoagMUY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jlXOZ2CEuaFrstNTu5Gp03lVBYoI63O80zJpenWV5NZDebNBZrvxEiiOuCDDAeC3vtsNVws1BMQt46WldR0MVZCUg3byk7v9nAxIwePTnD0Z64PAu3dJKm8DWT6oCaFm/PS72BW8wl/iF5fd7Cf2Il6vPJlTDkTnxms2f1F0V2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPeG0PDq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPeG0PDq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720605865; x=1752141865;
  h=date:from:to:cc:subject:message-id;
  bh=mUWgFqhHUwkwmoaUVqVtT7iR5lN8Jw0QHcnbLoagMUY=;
  b=RPeG0PDqnMQmYt1eUtwgFfSM64SVEAn+sS0vwbxOSDqEfvobF/Zi0wpe
   mIjDre/FobWE57qU9PRmgKaOgsVvS7RLSvCUvvbL1/d+3/UcOL/jXeLCl
   Ck1YKh6mJU/cnCd8nK4GJ9ry/KSUeJBF3lQGDHx3blYKIZK0dfVoFM36g
   st1KWcLl3b/GPzcd87gfecbiNvfdBsoJUulZUqynApirSGptVJ7325pRL
   ANedJnTPkQ1gLvt9gsqX3j6yPpsD16g8o3cXguMeNOQsVO6Q+6YQQDfqR
   rYDUSD53IbsSR3VGGJD0CjRaQjG7mmY9WArQVyDLXuIC4NJFw3sbMSkTL
   w==;
X-CSE-ConnectionGUID: LmokyEEmRuCVMRiz6U6uYA==
X-CSE-MsgGUID: blrxxOsVTfq3pSuepjvasQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="18120668"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="18120668"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 03:04:24 -0700
X-CSE-ConnectionGUID: WOwc6HP9T4m2slbwRAZmTg==
X-CSE-MsgGUID: +SSsE7jRRVu4MvpnwGE3wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="48261822"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 10 Jul 2024 03:04:23 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRUBR-000XiM-0a;
	Wed, 10 Jul 2024 10:04:21 +0000
Date: Wed, 10 Jul 2024 18:03:44 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD REGRESSION
 c6052c312e85011cd31237804900013f63420403
Message-ID: <202407101830.ylFvMri1-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: c6052c312e85011cd31237804900013f63420403  Bluetooth: btnxpuart: Add system suspend and resume handlers

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202407100005.eDlKsDOu-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202407100518.06Xxq5PK-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202407101459.c9PTRDH1-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202407101633.wEKPo5yr-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

(.text+0x11f4): undefined reference to `usb_anchor_urb'
(.text+0x6ec): undefined reference to `usb_alloc_urb'
(.text+0xc38): undefined reference to `usb_alloc_urb'
(.text+0xc90): undefined reference to `usb_anchor_urb'
(.text+0xe74): undefined reference to `usb_anchor_urb'
(.text+0xed8): undefined reference to `usb_alloc_urb'
/usr/bin/ld: btmtk.c:(.text+0xbed): undefined reference to `usb_autopm_put_interface'
aarch64-linux-ld: btmtk.c:(.text+0x14a4): undefined reference to `usb_autopm_put_interface'
aarch64-linux-ld: btmtk.c:(.text+0x1d38): undefined reference to `usb_kill_anchored_urbs'
aarch64-linux-ld: btmtk.c:(.text+0xc44): undefined reference to `usb_free_urb'
aarch64-linux-ld: btmtk.c:(.text+0xd94): undefined reference to `usb_anchor_urb'
aarch64-linux-ld: btmtk.c:(.text+0xda0): undefined reference to `usb_submit_urb'
aarch64-linux-ld: btmtk.c:(.text+0xdec): undefined reference to `usb_unanchor_urb'
aarch64-linux-ld: drivers/bluetooth/btmtk.c:532:(.text+0x3cc): undefined reference to `usb_free_urb'
aarch64-linux-ld: drivers/bluetooth/btmtk.c:556:(.text+0x468): undefined reference to `usb_anchor_urb'
aarch64-linux-ld: drivers/bluetooth/btmtk.c:557:(.text+0x474): undefined reference to `usb_submit_urb'
aarch64-linux-ld: drivers/bluetooth/btmtk.c:562:(.text+0x4ac): undefined reference to `usb_unanchor_urb'
aarch64-linux-ld: drivers/bluetooth/btmtk.c:613:(.text+0x830): undefined reference to `usb_autopm_put_interface'
alpha-linux-ld: (.text+0xc60): undefined reference to `usb_alloc_urb'
alpha-linux-ld: (.text+0xc9c): undefined reference to `usb_free_urb'
alpha-linux-ld: (.text+0xd30): undefined reference to `usb_anchor_urb'
alpha-linux-ld: (.text+0xd90): undefined reference to `usb_submit_urb'
alpha-linux-ld: (.text+0xe08): undefined reference to `usb_unanchor_urb'
alpha-linux-ld: drivers/bluetooth/btmtk.c:526:(.text+0xda0): undefined reference to `usb_alloc_urb'
alpha-linux-ld: drivers/bluetooth/btmtk.c:556:(.text+0xe2c): undefined reference to `usb_anchor_urb'
alpha-linux-ld: drivers/bluetooth/btmtk.c:557:(.text+0xe88): undefined reference to `usb_submit_urb'
alpha-linux-ld: drivers/bluetooth/btmtk.c:562:(.text+0xf58): undefined reference to `usb_unanchor_urb'
alpha-linux-ld: drivers/bluetooth/btmtk.c:565:(.text+0xea8): undefined reference to `usb_free_urb'
alpha-linux-ld: drivers/bluetooth/btmtk.c:787:(.text+0x1700): undefined reference to `usb_control_msg'
arm-linux-gnueabi-ld: btmtk.c:(.text+0xbf0): undefined reference to `usb_autopm_put_interface'
arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.c:556:(.text+0x516): undefined reference to `usb_anchor_urb'
arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.c:557:(.text+0x520): undefined reference to `usb_submit_urb'
arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.c:562:(.text+0x54c): undefined reference to `usb_unanchor_urb'
arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.c:565:(.text+0x52a): undefined reference to `usb_free_urb'
arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.c:620:(.text+0x792): undefined reference to `usb_autopm_put_interface'
btmtk.c:(.text+0xa80): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `usb_alloc_urb'
btmtk.c:(.text+0xad8): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `usb_free_urb'
btmtk.c:(.text+0xb90): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `usb_anchor_urb'
btmtk.c:(.text+0xb9c): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `usb_submit_urb'
btmtk.c:(.text+0xbf8): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `usb_unanchor_urb'
drivers/bluetooth/btmtk.c:506:(.text+0x1338): undefined reference to `usb_submit_urb'
drivers/bluetooth/btmtk.c:526:(.text+0x39c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_alloc_urb'
drivers/bluetooth/btmtk.c:532:(.text+0x3cc): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_free_urb'
drivers/bluetooth/btmtk.c:556:(.text+0x468): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_anchor_urb'
drivers/bluetooth/btmtk.c:557:(.text+0x474): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_submit_urb'
drivers/bluetooth/btmtk.c:562:(.text+0x4ac): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_unanchor_urb'
drivers/bluetooth/btnxpuart.c:1525:12: warning: 'nxp_serdev_suspend' defined but not used [-Wunused-function]
drivers/bluetooth/btnxpuart.c:1534:12: warning: 'nxp_serdev_resume' defined but not used [-Wunused-function]
hppa-linux-ld: (.text+0x1024): undefined reference to `usb_anchor_urb'
hppa-linux-ld: (.text+0xc9c): undefined reference to `usb_submit_urb'
hppa-linux-ld: (.text+0xcf0): undefined reference to `usb_unanchor_urb'
hppa-linux-ld: (.text+0xf4c): undefined reference to `usb_free_urb'
include/linux/pm_runtime.h:220:(.text+0x1328): undefined reference to `usb_anchor_urb'
include/linux/slab.h:660:(.text+0x48c): undefined reference to `usb_free_urb'
include/uapi/linux/usb/ch9.h:599:(.text+0x1240): undefined reference to `usb_kill_anchored_urbs'
loongarch64-linux-ld: drivers/bluetooth/btmtk.c:532:(.text+0x500): undefined reference to `usb_free_urb'
loongarch64-linux-ld: drivers/bluetooth/btmtk.c:556:(.text+0x5ac): undefined reference to `usb_anchor_urb'
loongarch64-linux-ld: drivers/bluetooth/btmtk.c:557:(.text+0x5b8): undefined reference to `usb_submit_urb'
loongarch64-linux-ld: drivers/bluetooth/btmtk.c:562:(.text+0x604): undefined reference to `usb_unanchor_urb'
loongarch64-linux-ld: drivers/bluetooth/btmtk.c:613:(.text+0xa54): undefined reference to `usb_autopm_put_interface'
m68k-linux-ld: drivers/bluetooth/btmtk.c:1177:(.text+0x18f0): undefined reference to `usb_free_urb'
m68k-linux-ld: drivers/bluetooth/btmtk.c:1195:(.text+0x19ae): undefined reference to `usb_anchor_urb'
m68k-linux-ld: drivers/bluetooth/btmtk.c:1224:(.text+0xe72): undefined reference to `usb_kill_anchored_urbs'
m68k-linux-ld: drivers/bluetooth/btmtk.c:557:(.text+0x536): undefined reference to `usb_submit_urb'
m68k-linux-ld: drivers/bluetooth/btmtk.c:562:(.text+0x57c): undefined reference to `usb_unanchor_urb'
microblaze-linux-ld: (.text+0x724): undefined reference to `usb_free_urb'
microblaze-linux-ld: (.text+0x7d0): undefined reference to `usb_anchor_urb'
microblaze-linux-ld: (.text+0x7e0): undefined reference to `usb_submit_urb'
microblaze-linux-ld: (.text+0x83c): undefined reference to `usb_unanchor_urb'
microblaze-linux-ld: drivers/bluetooth/btmtk.c:1224:(.text+0x2dc0): undefined reference to `usb_kill_anchored_urbs'
microblaze-linux-ld: drivers/bluetooth/btmtk.c:532:(.text+0x5fc): undefined reference to `usb_free_urb'
microblaze-linux-ld: drivers/bluetooth/btmtk.c:556:(.text+0x6e4): undefined reference to `usb_anchor_urb'
microblaze-linux-ld: drivers/bluetooth/btmtk.c:557:(.text+0x6f4): undefined reference to `usb_submit_urb'
microblaze-linux-ld: drivers/bluetooth/btmtk.c:562:(.text+0x750): undefined reference to `usb_unanchor_urb'
mips64el-linux-ld: btmtk.c:(.text+0x1318): undefined reference to `usb_autopm_put_interface'
mips64el-linux-ld: btmtk.c:(.text+0x35c4): undefined reference to `usb_kill_anchored_urbs'
mips64el-linux-ld: btmtk.c:(.text+0x7c8): undefined reference to `usb_free_urb'
mips64el-linux-ld: btmtk.c:(.text+0x8b4): undefined reference to `usb_anchor_urb'
mips64el-linux-ld: btmtk.c:(.text+0x8c0): undefined reference to `usb_submit_urb'
mips64el-linux-ld: btmtk.c:(.text+0x964): undefined reference to `usb_unanchor_urb'
or1k-linux-ld: btmtk.c:(.text+0x1774): undefined reference to `usb_kill_anchored_urbs'
or1k-linux-ld: btmtk.c:(.text+0xad8): undefined reference to `usb_free_urb'
or1k-linux-ld: btmtk.c:(.text+0xb90): undefined reference to `usb_anchor_urb'
or1k-linux-ld: btmtk.c:(.text+0xb9c): undefined reference to `usb_submit_urb'
or1k-linux-ld: btmtk.c:(.text+0xbf8): undefined reference to `usb_unanchor_urb'
powerpc64-linux-ld: btmtk.c:(.text+0xab4): undefined reference to `usb_anchor_urb'
powerpc64-linux-ld: btmtk.c:(.text+0xac4): undefined reference to `usb_submit_urb'
powerpc64-linux-ld: btmtk.c:(.text+0xadc): undefined reference to `usb_free_urb'
powerpc64-linux-ld: btmtk.c:(.text+0xb54): undefined reference to `usb_unanchor_urb'
riscv64-linux-ld: drivers/bluetooth/btmtk.c:556:(.text+0x7fe): undefined reference to `usb_anchor_urb'
riscv64-linux-ld: drivers/bluetooth/btmtk.c:557:(.text+0x80e): undefined reference to `usb_submit_urb'
riscv64-linux-ld: drivers/bluetooth/btmtk.c:562:(.text+0x86c): undefined reference to `usb_unanchor_urb'
riscv64-linux-ld: drivers/bluetooth/btmtk.c:565:(.text+0x81e): undefined reference to `usb_free_urb'
riscv64-linux-ld: drivers/bluetooth/btmtk.c:618:(.text+0xc9a): undefined reference to `usb_autopm_put_interface'
sh4-linux-ld: drivers/bluetooth/btmtk.c:1237:(.text+0xfc0): undefined reference to `usb_kill_anchored_urbs'
sparc64-linux-ld: btmtk.c:(.text+0x2488): undefined reference to `usb_kill_anchored_urbs'
sparc64-linux-ld: btmtk.c:(.text+0x5fc): undefined reference to `usb_free_urb'
sparc64-linux-ld: btmtk.c:(.text+0x6a0): undefined reference to `usb_anchor_urb'
sparc64-linux-ld: btmtk.c:(.text+0x6ac): undefined reference to `usb_submit_urb'
sparc64-linux-ld: btmtk.c:(.text+0x6fc): undefined reference to `usb_unanchor_urb'
sparc64-linux-ld: btmtk.c:(.text+0xce0): undefined reference to `usb_autopm_put_interface'
sparc64-linux-ld: drivers/bluetooth/btmtk.c:532:(.text+0x588): undefined reference to `usb_free_urb'
sparc64-linux-ld: drivers/bluetooth/btmtk.c:556:(.text+0x668): undefined reference to `usb_anchor_urb'
sparc64-linux-ld: drivers/bluetooth/btmtk.c:557:(.text+0x674): undefined reference to `usb_submit_urb'
sparc64-linux-ld: drivers/bluetooth/btmtk.c:562:(.text+0x6bc): undefined reference to `usb_unanchor_urb'
sparc64-linux-ld: drivers/bluetooth/btmtk.c:613:(.text+0xaec): undefined reference to `usb_autopm_put_interface'
xtensa-linux-ld: btmtk.c:(.text+0x8a0): undefined reference to `usb_free_urb'
xtensa-linux-ld: btmtk.c:(.text+0x8a8): undefined reference to `usb_submit_urb'
xtensa-linux-ld: btmtk.c:(.text+0x8ac): undefined reference to `usb_unanchor_urb'
xtensa-linux-ld: btmtk.c:(.text+0xa70): undefined reference to `usb_autopm_get_interface'
xtensa-linux-ld: btmtk.c:(.text+0xa74): undefined reference to `usb_autopm_put_interface'
xtensa-linux-ld: btmtk.c:(.text+0xfcf): undefined reference to `usb_disable_autosuspend'

Unverified Error/Warning (likely false positive, please contact us if interested):

(.head.text+0x5040): relocation truncated to fit: R_SPARC_WDISP22 against `.init.text'
(.init.text+0xa4): relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o
(.text+0x10e8): undefined reference to `usb_kill_anchored_urbs'
(.text+0x1334): undefined reference to `usb_control_msg'
(.text+0x13b8): undefined reference to `usb_control_msg'
(.text+0x1400): undefined reference to `usb_set_interface'
(.text+0x16cc): undefined reference to `usb_control_msg'
(.text+0x2124): undefined reference to `usb_set_interface'
(.text+0x2654): undefined reference to `usb_set_interface'
(.text+0x9d4): undefined reference to `usb_kill_anchored_urbs'
(.text+0xc64): undefined reference to `usb_kill_anchored_urbs'
alpha-linux-ld: (.text+0x10f8): undefined reference to `usb_kill_anchored_urbs'
alpha-linux-ld: (.text+0x1370): undefined reference to `usb_control_msg'
alpha-linux-ld: (.text+0x140c): undefined reference to `usb_set_interface'
hppa-linux-ld: (.text+0x223c): undefined reference to `usb_kill_anchored_urbs'
microblaze-linux-ld: (.text+0x2760): undefined reference to `usb_kill_anchored_urbs'
sparc-linux-ld: btmtk.c:(.text+0x9a0): undefined reference to `usb_anchor_urb'
sparc-linux-ld: btmtk.c:(.text+0x9ac): undefined reference to `usb_submit_urb'
sparc-linux-ld: btmtk.c:(.text+0x9c0): undefined reference to `usb_free_urb'
sparc-linux-ld: btmtk.c:(.text+0xa1c): undefined reference to `usb_unanchor_urb'

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allmodconfig
|   |-- drivers-bluetooth-btnxpuart.c:warning:nxp_serdev_resume-defined-but-not-used
|   `-- drivers-bluetooth-btnxpuart.c:warning:nxp_serdev_suspend-defined-but-not-used
|-- alpha-allyesconfig
|   |-- drivers-bluetooth-btnxpuart.c:warning:nxp_serdev_resume-defined-but-not-used
|   `-- drivers-bluetooth-btnxpuart.c:warning:nxp_serdev_suspend-defined-but-not-used
|-- alpha-randconfig-c032-20220728
|   |-- (.text):undefined-reference-to-usb_alloc_urb
|   |-- (.text):undefined-reference-to-usb_anchor_urb
|   |-- (.text):undefined-reference-to-usb_control_msg
|   |-- (.text):undefined-reference-to-usb_kill_anchored_urbs
|   |-- (.text):undefined-reference-to-usb_set_interface
|   |-- alpha-linux-ld:(.text):undefined-reference-to-usb_alloc_urb
|   |-- alpha-linux-ld:(.text):undefined-reference-to-usb_anchor_urb
|   |-- alpha-linux-ld:(.text):undefined-reference-to-usb_control_msg
|   |-- alpha-linux-ld:(.text):undefined-reference-to-usb_free_urb
|   |-- alpha-linux-ld:(.text):undefined-reference-to-usb_kill_anchored_urbs
|   |-- alpha-linux-ld:(.text):undefined-reference-to-usb_set_interface
|   |-- alpha-linux-ld:(.text):undefined-reference-to-usb_submit_urb
|   `-- alpha-linux-ld:(.text):undefined-reference-to-usb_unanchor_urb
|-- alpha-randconfig-c032-20221023
|   |-- alpha-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_alloc_urb
|   |-- alpha-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_anchor_urb
|   |-- alpha-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_control_msg
|   |-- alpha-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_free_urb
|   |-- alpha-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_submit_urb
|   `-- alpha-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_unanchor_urb
|-- arc-allmodconfig
|   |-- drivers-bluetooth-btnxpuart.c:warning:nxp_serdev_resume-defined-but-not-used
|   `-- drivers-bluetooth-btnxpuart.c:warning:nxp_serdev_suspend-defined-but-not-used
|-- arc-allyesconfig
|   |-- drivers-bluetooth-btnxpuart.c:warning:nxp_serdev_resume-defined-but-not-used
|   `-- drivers-bluetooth-btnxpuart.c:warning:nxp_serdev_suspend-defined-but-not-used
|-- arm-randconfig-r001-20230724
|   `-- arm-linux-gnueabi-ld:btmtk.c:(.text):undefined-reference-to-usb_autopm_put_interface
|-- arm-randconfig-r026-20230509
|   |-- arm-linux-gnueabi-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_anchor_urb
|   |-- arm-linux-gnueabi-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_autopm_put_interface
|   |-- arm-linux-gnueabi-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_free_urb
|   |-- arm-linux-gnueabi-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_submit_urb
|   `-- arm-linux-gnueabi-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_unanchor_urb
|-- arm64-randconfig-051-20240709
|   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5-vision-mezzanine.dtb:bluetooth:vddbtcmx-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5-vision-mezzanine.dtb:bluetooth:vddrfa0p8-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5-vision-mezzanine.dtb:bluetooth:vddrfa1p2-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5-vision-mezzanine.dtb:bluetooth:vddrfa1p7-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5-vision-mezzanine.dtb:bluetooth:vddrfacmn-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5.dtb:bluetooth:vddbtcmx-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5.dtb:bluetooth:vddrfa0p8-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5.dtb:bluetooth:vddrfa1p2-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5.dtb:bluetooth:vddrfa1p7-supply-is-a-required-property
|   `-- arch-arm64-boot-dts-qcom-qrb5165-rb5.dtb:bluetooth:vddrfacmn-supply-is-a-required-property
|-- arm64-randconfig-r005-20211129
|   |-- aarch64-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_anchor_urb
|   |-- aarch64-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_autopm_put_interface
|   |-- aarch64-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_free_urb
|   |-- aarch64-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_kill_anchored_urbs
|   |-- aarch64-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_submit_urb
|   `-- aarch64-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_unanchor_urb
|-- arm64-randconfig-r036-20211103
|   |-- aarch64-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_anchor_urb
|   |-- aarch64-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_autopm_put_interface
|   |-- aarch64-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_free_urb
|   |-- aarch64-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_submit_urb
|   |-- aarch64-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_unanchor_urb
|   |-- drivers-bluetooth-btmtk.c:(.text):relocation-truncated-to-fit:R_AARCH64_CALL26-against-undefined-symbol-usb_alloc_urb
|   |-- drivers-bluetooth-btmtk.c:(.text):relocation-truncated-to-fit:R_AARCH64_CALL26-against-undefined-symbol-usb_anchor_urb
|   |-- drivers-bluetooth-btmtk.c:(.text):relocation-truncated-to-fit:R_AARCH64_CALL26-against-undefined-symbol-usb_free_urb
|   |-- drivers-bluetooth-btmtk.c:(.text):relocation-truncated-to-fit:R_AARCH64_CALL26-against-undefined-symbol-usb_submit_urb
|   `-- drivers-bluetooth-btmtk.c:(.text):relocation-truncated-to-fit:R_AARCH64_CALL26-against-undefined-symbol-usb_unanchor_urb
|-- csky-randconfig-002-20240710
|   |-- drivers-bluetooth-btnxpuart.c:warning:nxp_serdev_resume-defined-but-not-used
|   `-- drivers-bluetooth-btnxpuart.c:warning:nxp_serdev_suspend-defined-but-not-used
|-- i386-randconfig-014-20240710
|   |-- drivers-bluetooth-btnxpuart.c:warning:nxp_serdev_resume-defined-but-not-used
|   `-- drivers-bluetooth-btnxpuart.c:warning:nxp_serdev_suspend-defined-but-not-used
|-- loongarch-randconfig-s043-20221009
|   |-- loongarch64-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_anchor_urb
|   |-- loongarch64-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_autopm_put_interface
|   |-- loongarch64-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_free_urb
|   |-- loongarch64-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_submit_urb
|   `-- loongarch64-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_unanchor_urb
|-- m68k-allmodconfig
|   |-- drivers-bluetooth-btnxpuart.c:warning:nxp_serdev_resume-defined-but-not-used
|   `-- drivers-bluetooth-btnxpuart.c:warning:nxp_serdev_suspend-defined-but-not-used
|-- m68k-allyesconfig
|   |-- drivers-bluetooth-btnxpuart.c:warning:nxp_serdev_resume-defined-but-not-used
|   `-- drivers-bluetooth-btnxpuart.c:warning:nxp_serdev_suspend-defined-but-not-used
|-- m68k-randconfig-r021-20220411
|   `-- m68k-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_kill_anchored_urbs
|-- m68k-randconfig-r026-20221002
|   |-- include-linux-slab.h:(.text):undefined-reference-to-usb_free_urb
|   |-- m68k-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_anchor_urb
|   |-- m68k-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_free_urb
|   |-- m68k-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_submit_urb
|   `-- m68k-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_unanchor_urb
|-- microblaze-randconfig-c032-20220823
|   |-- microblaze-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_anchor_urb
|   |-- microblaze-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_free_urb
|   |-- microblaze-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_submit_urb
|   `-- microblaze-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_unanchor_urb
|-- microblaze-randconfig-r006-20211104
|   `-- microblaze-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_kill_anchored_urbs
|-- microblaze-randconfig-r036-20220106
|   |-- (.text):undefined-reference-to-usb_alloc_urb
|   |-- (.text):undefined-reference-to-usb_anchor_urb
|   |-- (.text):undefined-reference-to-usb_control_msg
|   |-- (.text):undefined-reference-to-usb_kill_anchored_urbs
|   |-- (.text):undefined-reference-to-usb_set_interface
|   |-- microblaze-linux-ld:(.text):undefined-reference-to-usb_anchor_urb
|   |-- microblaze-linux-ld:(.text):undefined-reference-to-usb_free_urb
|   |-- microblaze-linux-ld:(.text):undefined-reference-to-usb_kill_anchored_urbs
|   |-- microblaze-linux-ld:(.text):undefined-reference-to-usb_submit_urb
|   `-- microblaze-linux-ld:(.text):undefined-reference-to-usb_unanchor_urb
|-- mips-randconfig-r003-20220507
|   |-- mips64el-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_anchor_urb
|   |-- mips64el-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_autopm_put_interface
|   |-- mips64el-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_free_urb
|   |-- mips64el-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_kill_anchored_urbs
|   |-- mips64el-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_submit_urb
|   `-- mips64el-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_unanchor_urb
|-- openrisc-allyesconfig
|   |-- drivers-bluetooth-btnxpuart.c:warning:nxp_serdev_resume-defined-but-not-used
|   `-- drivers-bluetooth-btnxpuart.c:warning:nxp_serdev_suspend-defined-but-not-used
|-- openrisc-randconfig-c043-20220720
|   |-- btmtk.c:(.text):relocation-truncated-to-fit:R_OR1K_INSN_REL_26-against-undefined-symbol-usb_alloc_urb
|   |-- btmtk.c:(.text):relocation-truncated-to-fit:R_OR1K_INSN_REL_26-against-undefined-symbol-usb_anchor_urb
|   |-- btmtk.c:(.text):relocation-truncated-to-fit:R_OR1K_INSN_REL_26-against-undefined-symbol-usb_free_urb
|   |-- btmtk.c:(.text):relocation-truncated-to-fit:R_OR1K_INSN_REL_26-against-undefined-symbol-usb_submit_urb
|   |-- btmtk.c:(.text):relocation-truncated-to-fit:R_OR1K_INSN_REL_26-against-undefined-symbol-usb_unanchor_urb
|   |-- or1k-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_anchor_urb
|   |-- or1k-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_free_urb
|   |-- or1k-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_kill_anchored_urbs
|   |-- or1k-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_submit_urb
|   `-- or1k-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_unanchor_urb
|-- parisc-allmodconfig
|   |-- drivers-bluetooth-btnxpuart.c:warning:nxp_serdev_resume-defined-but-not-used
|   `-- drivers-bluetooth-btnxpuart.c:warning:nxp_serdev_suspend-defined-but-not-used
|-- parisc-allyesconfig
|   |-- drivers-bluetooth-btnxpuart.c:warning:nxp_serdev_resume-defined-but-not-used
|   `-- drivers-bluetooth-btnxpuart.c:warning:nxp_serdev_suspend-defined-but-not-used
|-- parisc-randconfig-002-20231118
|   |-- (.text):undefined-reference-to-usb_alloc_urb
|   |-- (.text):undefined-reference-to-usb_anchor_urb
|   |-- (.text):undefined-reference-to-usb_control_msg
|   |-- (.text):undefined-reference-to-usb_kill_anchored_urbs
|   |-- (.text):undefined-reference-to-usb_set_interface
|   |-- hppa-linux-ld:(.text):undefined-reference-to-usb_anchor_urb
|   |-- hppa-linux-ld:(.text):undefined-reference-to-usb_free_urb
|   |-- hppa-linux-ld:(.text):undefined-reference-to-usb_kill_anchored_urbs
|   |-- hppa-linux-ld:(.text):undefined-reference-to-usb_submit_urb
|   `-- hppa-linux-ld:(.text):undefined-reference-to-usb_unanchor_urb
|-- powerpc64-randconfig-r054-20240223
|   |-- powerpc64-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_anchor_urb
|   |-- powerpc64-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_free_urb
|   |-- powerpc64-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_submit_urb
|   `-- powerpc64-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_unanchor_urb
|-- riscv-randconfig-r022-20220105
|   |-- drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_submit_urb
|   |-- include-linux-pm_runtime.h:(.text):undefined-reference-to-usb_anchor_urb
|   |-- include-uapi-linux-usb-ch9.h:(.text):undefined-reference-to-usb_kill_anchored_urbs
|   |-- riscv64-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_anchor_urb
|   |-- riscv64-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_autopm_put_interface
|   |-- riscv64-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_free_urb
|   |-- riscv64-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_submit_urb
|   `-- riscv64-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_unanchor_urb
|-- sh-allmodconfig
|   |-- drivers-bluetooth-btnxpuart.c:warning:nxp_serdev_resume-defined-but-not-used
|   `-- drivers-bluetooth-btnxpuart.c:warning:nxp_serdev_suspend-defined-but-not-used
|-- sh-buildonly-randconfig-r006-20220515
|   `-- sh4-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_kill_anchored_urbs
|-- sparc-buildonly-randconfig-r003-20220319
|   |-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
|   |-- (.init.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-symbol-leon_smp_cpu_startup-defined-in-.text-section-in-arch-sparc-kernel-trampoline_32.o
|   |-- sparc-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_anchor_urb
|   |-- sparc-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_free_urb
|   |-- sparc-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_submit_urb
|   `-- sparc-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_unanchor_urb
|-- sparc64-randconfig-001-20240710
|   |-- drivers-bluetooth-btnxpuart.c:warning:nxp_serdev_resume-defined-but-not-used
|   `-- drivers-bluetooth-btnxpuart.c:warning:nxp_serdev_suspend-defined-but-not-used
|-- sparc64-randconfig-r006-20230319
|   |-- sparc64-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_anchor_urb
|   |-- sparc64-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_autopm_put_interface
|   |-- sparc64-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_free_urb
|   |-- sparc64-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_submit_urb
|   `-- sparc64-linux-ld:drivers-bluetooth-btmtk.c:(.text):undefined-reference-to-usb_unanchor_urb
|-- sparc64-randconfig-r032-20230830
|   |-- sparc64-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_anchor_urb
|   |-- sparc64-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_autopm_put_interface
|   |-- sparc64-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_free_urb
|   |-- sparc64-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_kill_anchored_urbs
|   |-- sparc64-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_submit_urb
|   `-- sparc64-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_unanchor_urb
|-- um-randconfig-002-20240709
|   `-- usr-bin-ld:btmtk.c:(.text):undefined-reference-to-usb_autopm_put_interface
|-- x86_64-randconfig-071-20240710
|   |-- drivers-bluetooth-btnxpuart.c:warning:nxp_serdev_resume-defined-but-not-used
|   `-- drivers-bluetooth-btnxpuart.c:warning:nxp_serdev_suspend-defined-but-not-used
`-- xtensa-randconfig-c031-20230322
    |-- xtensa-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_autopm_get_interface
    |-- xtensa-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_autopm_put_interface
    |-- xtensa-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_disable_autosuspend
    |-- xtensa-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_free_urb
    |-- xtensa-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_submit_urb
    `-- xtensa-linux-ld:btmtk.c:(.text):undefined-reference-to-usb_unanchor_urb

elapsed time: 1147m

configs tested: 134
configs skipped: 1

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240710   gcc-13.2.0
arc                   randconfig-002-20240710   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-13.2.0
arm                   randconfig-001-20240710   clang-19
arm                   randconfig-002-20240710   gcc-13.2.0
arm                   randconfig-003-20240710   clang-19
arm                   randconfig-004-20240710   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-13.2.0
arm64                 randconfig-001-20240710   clang-19
arm64                 randconfig-002-20240710   clang-19
arm64                 randconfig-003-20240710   clang-17
arm64                 randconfig-004-20240710   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                  randconfig-001-20240710   gcc-13.2.0
csky                  randconfig-002-20240710   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240710   clang-19
hexagon               randconfig-002-20240710   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240710   clang-18
i386         buildonly-randconfig-002-20240710   gcc-13
i386         buildonly-randconfig-003-20240710   gcc-11
i386         buildonly-randconfig-004-20240710   gcc-11
i386         buildonly-randconfig-005-20240710   clang-18
i386         buildonly-randconfig-006-20240710   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240710   clang-18
i386                  randconfig-002-20240710   gcc-11
i386                  randconfig-003-20240710   gcc-13
i386                  randconfig-004-20240710   clang-18
i386                  randconfig-005-20240710   clang-18
i386                  randconfig-006-20240710   clang-18
i386                  randconfig-011-20240710   gcc-13
i386                  randconfig-012-20240710   gcc-12
i386                  randconfig-013-20240710   gcc-12
i386                  randconfig-014-20240710   gcc-13
i386                  randconfig-015-20240710   gcc-8
i386                  randconfig-016-20240710   clang-18
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch             randconfig-001-20240710   gcc-13.2.0
loongarch             randconfig-002-20240710   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                 randconfig-001-20240710   gcc-13.2.0
nios2                 randconfig-002-20240710   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                randconfig-001-20240710   gcc-13.2.0
parisc                randconfig-002-20240710   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   clang-19
powerpc               randconfig-001-20240710   gcc-13.2.0
powerpc               randconfig-002-20240710   clang-19
powerpc               randconfig-003-20240710   gcc-13.2.0
powerpc64             randconfig-001-20240710   gcc-13.2.0
powerpc64             randconfig-002-20240710   clang-15
powerpc64             randconfig-003-20240710   clang-19
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   clang-19
riscv                 randconfig-001-20240710   clang-19
riscv                 randconfig-002-20240710   clang-19
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                  randconfig-001-20240710   gcc-13.2.0
s390                  randconfig-002-20240710   gcc-13.2.0
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                    randconfig-001-20240710   gcc-13.2.0
sh                    randconfig-002-20240710   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc64               randconfig-001-20240710   gcc-13.2.0
sparc64               randconfig-002-20240710   gcc-13.2.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                    randconfig-001-20240710   gcc-13
um                    randconfig-002-20240710   clang-19
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240710   clang-18
x86_64       buildonly-randconfig-002-20240710   clang-18
x86_64       buildonly-randconfig-003-20240710   clang-18
x86_64       buildonly-randconfig-004-20240710   clang-18
x86_64       buildonly-randconfig-005-20240710   gcc-13
x86_64       buildonly-randconfig-006-20240710   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240710   gcc-13
x86_64                randconfig-002-20240710   clang-18
x86_64                randconfig-003-20240710   gcc-12
x86_64                randconfig-004-20240710   clang-18
x86_64                randconfig-005-20240710   clang-18
x86_64                randconfig-006-20240710   gcc-13
x86_64                randconfig-011-20240710   clang-18
x86_64                randconfig-012-20240710   clang-18
x86_64                randconfig-013-20240710   clang-18
x86_64                randconfig-014-20240710   clang-18
x86_64                randconfig-015-20240710   clang-18
x86_64                randconfig-016-20240710   gcc-13
x86_64                randconfig-071-20240710   gcc-13
x86_64                randconfig-072-20240710   clang-18
x86_64                randconfig-073-20240710   clang-18
x86_64                randconfig-074-20240710   gcc-7
x86_64                randconfig-075-20240710   clang-18
x86_64                randconfig-076-20240710   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240710   gcc-13.3.0
xtensa                randconfig-002-20240710   gcc-13.3.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
