Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AFF27FD5D;
	Sat, 22 Nov 2025 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763809447; cv=none; b=ghoThtpFzHJhaTUQ7gxMzjqyYjSn+zU6TLeEHCgSQC6usecHuEETx38KUcSN/wpzl+NlMk0n//NXclVmibDIaTpYbPM1R5kuASVAe+qCNPYVAfrys+q/HSF6FQcl2HYSaS7cDOrTcIZOIiwXdxm/APiOw/AXh3xF5RntTqnAaf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763809447; c=relaxed/simple;
	bh=fr6TYfA9ke42ULzPksMgAJfvqCTcwtV5RLJDcDTeJQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olLuo52tYkGg+aGNPtfIOmvpTclPliPWP//out3yYjtww3zMvZIIla1kCfD4jL76HPKV6/3EbC9emJybad0IPHQWNvqP4COPFNudgED+YSrBoAg22Ujphgc58CQ39tuPJMwRxEUuzXNDrLVgQjyihCtcbm38ffNfDWMYv/jfMRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cfzFzObT; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cfzFzObT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763809446; x=1795345446;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fr6TYfA9ke42ULzPksMgAJfvqCTcwtV5RLJDcDTeJQU=;
  b=cfzFzObT8R6M/0DNKG8e7xmjxCaVsQrx3fXowfkisv1VpYLC75+N5Aro
   HRR2cTvQpXP3PUKhB5euCNAhSj5X6lutovG6snMN8hWNf0raGpGJr3gX1
   ZHQPAShsinEe9Gi7uMGZadq1ZdLFTcE5Z57/JI5kaPR9BvCWXuM3yF2Wx
   ZrpEyNH36Ju6LCgCb8mVY0Yup6RujTpftg4Ndj+VtFU65ZAr9Pceb8Z8m
   p3QNdEPQeqIxO0VMYhApOxPFDXC6WY2UUmgKy214SKVtnbxBqt7l0N43B
   rjSl2B+EqUE8CQQmRKdHPPAXX8wW1rc1i/0MLQBghUpsNjcjc0QbjqG94
   A==;
X-CSE-ConnectionGUID: oEI3uyxXQn+glZFWQlxWiw==
X-CSE-MsgGUID: 02dbE757QOqVkX6jkdakog==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="91368766"
X-IronPort-AV: E=Sophos;i="6.20,218,1758610800"; 
   d="scan'208";a="91368766"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2025 03:04:06 -0800
X-CSE-ConnectionGUID: h3AlV2dYRNW2ADFN0d1rwQ==
X-CSE-MsgGUID: ewSiDoWNTUSt/RVkjZyeQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,218,1758610800"; 
   d="scan'208";a="191778344"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 22 Nov 2025 03:04:03 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMlPM-0007QZ-24;
	Sat, 22 Nov 2025 11:04:00 +0000
Date: Sat, 22 Nov 2025 19:03:40 +0800
From: kernel test robot <lkp@intel.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com, sherry.sun@nxp.com, dmitrii.lebed@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: Re: [PATCH v1 07/11] Bluetooth: btnxpuart: Add device authentication
Message-ID: <202511221835.jzKFsvPM-lkp@intel.com>
References: <20251118142025.1982263-8-neeraj.sanjaykale@nxp.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118142025.1982263-8-neeraj.sanjaykale@nxp.com>

Hi Neeraj,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on bluetooth-next/master linus/master v6.18-rc6 next-20251121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Neeraj-Sanjay-Kale/Bluetooth-btnxpuart-Add-firmware-metadata-parsing-for-secure-interface/20251118-223605
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20251118142025.1982263-8-neeraj.sanjaykale%40nxp.com
patch subject: [PATCH v1 07/11] Bluetooth: btnxpuart: Add device authentication
config: arm-randconfig-001-20251122 (https://download.01.org/0day-ci/archive/20251122/202511221835.jzKFsvPM-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9e9fe08b16ea2c4d9867fb4974edf2a3776d6ece)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251122/202511221835.jzKFsvPM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511221835.jzKFsvPM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/bluetooth/btnxpuart.c:459:29: warning: field host_hello within 'struct nxp_tls_host_hello_payload::(anonymous at drivers/bluetooth/btnxpuart.c:457:2)' is less aligned than 'struct nxp_tls_host_hello' and is usually due to 'struct nxp_tls_host_hello_payload::(anonymous at drivers/bluetooth/btnxpuart.c:457:2)' being packed, which can lead to unaligned accesses [-Wunaligned-access]
     459 |                 struct nxp_tls_host_hello host_hello;
         |                                           ^
>> drivers/bluetooth/btnxpuart.c:513:32: warning: field host_finished within 'struct nxp_tls_host_finished_payload::(anonymous at drivers/bluetooth/btnxpuart.c:511:2)' is less aligned than 'struct nxp_tls_host_finished' and is usually due to 'struct nxp_tls_host_finished_payload::(anonymous at drivers/bluetooth/btnxpuart.c:511:2)' being packed, which can lead to unaligned accesses [-Wunaligned-access]
     513 |                 struct nxp_tls_host_finished host_finished;
         |                                              ^
   2 warnings generated.


vim +513 drivers/bluetooth/btnxpuart.c

   455	
   456	union nxp_tls_host_hello_payload {
   457		struct {
   458			u8 msg_type;
 > 459			struct nxp_tls_host_hello host_hello;
   460		} __packed;
   461		u8 buf[113];
   462	};
   463	
   464	struct nxp_tls_device_info {
   465		__le16 chip_id;
   466		__le16 device_flags;
   467		u8 reserved[4];
   468		u8 uuid[NXP_DEVICE_UUID_LEN];
   469	};
   470	
   471	struct nxp_tls_signature {
   472		u8 sig[64];        /* P-256 ECDSA signature, two points */
   473	};
   474	
   475	struct nxp_tls_finished {
   476		u8 verify_data[32];
   477	};
   478	
   479	struct nxp_tls_device_hello {
   480		struct nxp_tls_message_hdr hdr;
   481		__le32 reserved;
   482		u8 random[32];
   483		u8 pubkey[NXP_TLS_ECDH_PUBLIC_KEY_SIZE];
   484		/* Encrypted portion */
   485		struct {
   486			struct nxp_tls_device_info device_info;
   487			struct nxp_tls_signature device_handshake_sig;   /* TLS Certificate Verify */
   488			struct nxp_tls_finished device_finished;
   489		} enc;
   490		u8 auth_tag[NXP_ENC_AUTH_TAG_SIZE];   /* Auth tag for the encrypted portion */
   491	};
   492	
   493	struct nxp_tls_data_add {
   494		u8 version;        /* NXP_TLS_VERSION */
   495		u8 reserved[5];    /* zeroes */
   496		__le16 len;
   497	};
   498	
   499	struct nxp_tls_host_finished {
   500		struct nxp_tls_message_hdr hdr;
   501		__le32 reserved;
   502		/* Encrypted portion */
   503		struct {
   504			struct nxp_tls_signature reserved2;
   505			struct nxp_tls_finished host_finished;
   506		} enc;
   507		u8 auth_tag[NXP_ENC_AUTH_TAG_SIZE];   /* Auth tag for the encrypted portion */
   508	};
   509	
   510	union nxp_tls_host_finished_payload {
   511		struct {
   512			u8 msg_type;
 > 513			struct nxp_tls_host_finished host_finished;
   514		} __packed;
   515		u8 buf[125];
   516	};
   517	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
