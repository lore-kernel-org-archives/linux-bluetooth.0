Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6737C19E97F;
	Thu, 20 Nov 2025 08:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763628110; cv=none; b=POPFrpBf5dg04jWNXhby71vCsYUS8fYee27ciZOmKuG22pCiblJnHnb+khZSJdVYhoNOOi0plYkOUDquVQB5HLz7ZpYRlYzpLTbUzkv4m65Glkhvh+DKP2ztr4L+p5e2fOrxBQgVzHDANvqc0OtEjRcwxLjMfKfiGAgSxrwIT7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763628110; c=relaxed/simple;
	bh=Ln5LkTT3o0AfWlQ5iicRUcxWe1hITpvjDkaxm020QHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDABJ8oSOcv8ZY7Gve1LrfdcTJoCYSnpkR5UNoVUhJ9RCkAcdbxQ6TWfvloE2cU8YglXhQSNvE7pSVP17erC9ov01M3SrER0bnw8HtyBgB/yJmWxru7MfiOZdEN891wUwo6Ukjh7vOBtocwgn+1UujSzjm9egEzPTdY/McJF3co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iUHrx8c/; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iUHrx8c/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763628107; x=1795164107;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ln5LkTT3o0AfWlQ5iicRUcxWe1hITpvjDkaxm020QHg=;
  b=iUHrx8c/+AEBq31P4XN/r/V92EgkX9EB9CZTvNGa+oxz1eV76zDmQtjg
   BT00DhCsE6C1PWnafZB8ZnZ5EyW0Q5ptcIlU7hdoDbM695y6ged4ilqmI
   rmicACoVpPcKuzU8HpA6AOrVVhIMJoFOtL+Tclx9Ll6fF7/4e1u+kL9/2
   3yJsQofsiqFIW1ap/c+Z62OtL+4ZmIPm34+Om3MiqOU5igieBzvsO3Pqr
   ycJCE1d6/Q5TAvKuLW1IPQZW7vXK4osrM1lAF/oc7UVMRa3sa+PvSV4AV
   OPgQf1YSaRFCVNyjxygveEdXzeJj7O8v2qSRdv+2zmc72RyR4QNOW0s7f
   Q==;
X-CSE-ConnectionGUID: TfE30p9CSxWzHFff0ZRFyw==
X-CSE-MsgGUID: UN6qcXj4TlC1h7BVwEADeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="68295789"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="68295789"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 00:41:47 -0800
X-CSE-ConnectionGUID: bUJBjJyBQqWMPTgnEtl6XQ==
X-CSE-MsgGUID: KgbeTF9mRQqeNiNmzwjFOg==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 20 Nov 2025 00:41:45 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vM0EY-0003mZ-28;
	Thu, 20 Nov 2025 08:41:42 +0000
Date: Thu, 20 Nov 2025 16:40:43 +0800
From: kernel test robot <lkp@intel.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com, dmitrii.lebed@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: Re: [PATCH v1 09/11] Bluetooth: btnxpuart: Add command encryption
 for sensitive HCI commands
Message-ID: <202511201407.MPGCEuhy-lkp@intel.com>
References: <20251118142025.1982263-10-neeraj.sanjaykale@nxp.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118142025.1982263-10-neeraj.sanjaykale@nxp.com>

Hi Neeraj,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on bluetooth-next/master linus/master v6.18-rc6 next-20251119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Neeraj-Sanjay-Kale/Bluetooth-btnxpuart-Add-firmware-metadata-parsing-for-secure-interface/20251118-223605
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20251118142025.1982263-10-neeraj.sanjaykale%40nxp.com
patch subject: [PATCH v1 09/11] Bluetooth: btnxpuart: Add command encryption for sensitive HCI commands
config: x86_64-randconfig-103-20251119 (https://download.01.org/0day-ci/archive/20251120/202511201407.MPGCEuhy-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511201407.MPGCEuhy-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/bluetooth/btnxpuart.c:2720:12-19: WARNING opportunity for kmemdup

vim +2720 drivers/bluetooth/btnxpuart.c

  2698	
  2699	static struct sk_buff *nxp_crypto_encrypt_cmd(struct hci_dev *hdev,
  2700						      struct sk_buff *skb)
  2701	{
  2702		struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
  2703		__le16 vendor_opcode = __cpu_to_le16(HCI_NXP_SHI_ENCRYPT);
  2704		u8 nonce[GCM_AES_IV_SIZE];
  2705		u8 tag[NXP_ENC_AUTH_TAG_SIZE];
  2706		u8 *enc_data;
  2707		u8 sub_opcode = 0x10;
  2708		int ret;
  2709		u32 plen, enc_data_len;
  2710		struct nxp_tls_traffic_keys *keys = &nxpdev->crypto.keys;
  2711	
  2712		if (skb->len > NXP_MAX_ENCRYPT_CMD_LEN) {
  2713			bt_dev_err(hdev, "Invalid skb->len: %d", skb->len);
  2714			return skb;
  2715		}
  2716	
  2717		nxp_data_calc_nonce(keys->h2d_iv, nxpdev->crypto.enc_seq_no, nonce);
  2718	
  2719		enc_data_len = skb->len;
> 2720		enc_data = kzalloc(skb->len, GFP_KERNEL);
  2721		if (!enc_data)
  2722			return skb;
  2723		memcpy(enc_data, skb->data, skb->len);
  2724	
  2725		ret = nxp_aes_gcm_encrypt(hdev, enc_data, enc_data_len, tag,
  2726					  keys->h2d_key, nonce);
  2727		if (ret) {
  2728			kfree(enc_data);
  2729			return skb;
  2730		}
  2731	
  2732		kfree_skb(skb);
  2733	
  2734		plen = enc_data_len + NXP_ENC_AUTH_TAG_SIZE + 1;
  2735		skb = bt_skb_alloc(plen, GFP_ATOMIC);
  2736		if (!skb) {
  2737			kfree(enc_data);
  2738			return ERR_PTR(-ENOMEM);
  2739		}
  2740		hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
  2741		skb_put_data(skb, &vendor_opcode, 2);
  2742		skb_put_data(skb, &plen, 1);
  2743		skb_put_data(skb, &sub_opcode, 1);
  2744		skb_put_data(skb, enc_data, enc_data_len);
  2745		skb_put_data(skb, tag, NXP_ENC_AUTH_TAG_SIZE);
  2746	
  2747		nxpdev->crypto.enc_seq_no++;
  2748		kfree(enc_data);
  2749		return skb;
  2750	}
  2751	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
