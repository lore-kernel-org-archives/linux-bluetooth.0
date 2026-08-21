Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8985B25B09C
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 02:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787278113; cv=none; b=Jol9d3xJCb4NhOVgRntet8x+MoW1Qf9noApYZ/ZgSzfjUxVBlMYynEN7XYn1Kecua/mtAo9d1FKF1nE0l2sRy0CyYDplUuzdU5YS4UbgM6YFwdpuBYj9BPEaLMggQ6eWbG+2tnpAMnV1kKjkYH07QZ+/Ey1dac0Q0FHdShQ2BK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787278113; c=relaxed/simple;
	bh=EY8f7mMl7Jb3WM+8SCHqjQIb4VW/E4r1B9aqM9zr8z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GggQt0+59fS4gjyFazyMzxzKWPVBb3PqNwMHCOzSfppZsZDTATFYLdtvdWKDsvtQdjiNnzWbgaYNdwhUXdU6D/8PCRMD46kuPfn8dkpP8ygSIb61MtSwmxPIdMhhpijcJwXLMPgtzqqgt5HpCLhoK5z89XLrKz0fVI+kElIZSUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XITcvujg; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XITcvujg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787278111; x=1818814111;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EY8f7mMl7Jb3WM+8SCHqjQIb4VW/E4r1B9aqM9zr8z0=;
  b=XITcvujgSC3ifTfAPQuWev2yxbDS2ItJ9Jk5Bie4AsQM1Hxz/E3MILqW
   +Ls/Dtto5XXHFlcZohw244V6IoU/mn1PsEJ2Wk7UTOcqsRPwqsvr2DaVA
   8sv0DAFacZtXQKVwnOrdY/HeN5hegU2WNh7Xr1qb/b/XkCyCBtn9KOsdY
   OfFsUXSLD2pRXO6dXITNxGX92sqFKiAMqtcGkjyQZ+IeTg3W+fiANEznK
   ilyYKcB0sK3aM1YFzrUNaSYSLWWzZAC1lLz+f7cJfIPTuE+sWhjAtmOuc
   DNtohtBM+F6y6mVxPfOecQyjPlGf4OlMBo1xfTKJLtS/LvyLauVNEAByM
   Q==;
X-CSE-ConnectionGUID: 6xq3nQmsR2Sot//X7TjRag==
X-CSE-MsgGUID: VODT5AeJQLOGr/0BkvxYjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87738905"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="87738905"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 19:08:31 -0700
X-CSE-ConnectionGUID: ipCF3s3WRZudb1I0MtLmkQ==
X-CSE-MsgGUID: tAXbIGWvRcy+oWvlyg0w9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="264904581"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 20 Aug 2026 19:08:29 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wxEgE-00000000p1Z-2EDn;
	Fri, 21 Aug 2026 02:08:26 +0000
Date: Fri, 21 Aug 2026 10:08:06 +0800
From: kernel test robot <lkp@intel.com>
To: David Marlin <dmarlin@redhat.com>, linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	David Marlin <dmarlin@redhat.com>,
	Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Bluetooth: hci-core: fix "declaration does not declare
 anything" error
Message-ID: <202608211016.aKSwZC8Y-lkp@intel.com>
References: <20260814051032.261320-1-dmarlin@redhat.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814051032.261320-1-dmarlin@redhat.com>

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth-next/master]
[also build test ERROR on bluetooth/master linus/master v7.2 next-20260819]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Marlin/Bluetooth-hci-core-fix-declaration-does-not-declare-anything-error/20260814-001012
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20260814051032.261320-1-dmarlin%40redhat.com
patch subject: [PATCH] Bluetooth: hci-core: fix "declaration does not declare anything" error
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20260821/202608211016.aKSwZC8Y-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 935bfc708590c60147a79c7df145bb6e68b1d388)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260821/202608211016.aKSwZC8Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608211016.aKSwZC8Y-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/bluetooth/hci_codec.c:151:17: error: operand of type 'struct hci_std_codecs_hdr' where arithmetic or pointer type is required
     151 |         if (skb->len < flex_array_size(std_codecs, codec, std_codecs->num)
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:419:24: note: expanded from macro 'flex_array_size'
     419 |         __builtin_choose_expr(__is_constexpr(count),                    \
         |                               ^~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:323:47: note: expanded from macro '__is_constexpr'
     323 |         (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                      ^~~
>> net/bluetooth/hci_codec.c:157:16: error: invalid operands to binary expression ('__u8' (aka 'unsigned char') and 'struct hci_std_codecs_hdr')
     157 |         for (i = 0; i < std_codecs->num; i++) {
         |                     ~ ^ ~~~~~~~~~~~~~~~
   net/bluetooth/hci_codec.c:164:16: error: operand of type 'struct hci_std_codecs_hdr' where arithmetic or pointer type is required
     164 |         skb_pull(skb, flex_array_size(std_codecs, codec, std_codecs->num)
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:419:24: note: expanded from macro 'flex_array_size'
     419 |         __builtin_choose_expr(__is_constexpr(count),                    \
         |                               ^~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:323:47: note: expanded from macro '__is_constexpr'
     323 |         (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                      ^~~
>> net/bluetooth/hci_codec.c:220:17: error: operand of type 'struct hci_std_codecs_v2_hdr' where arithmetic or pointer type is required
     220 |         if (skb->len < flex_array_size(std_codecs, codec, std_codecs->num)
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:419:24: note: expanded from macro 'flex_array_size'
     419 |         __builtin_choose_expr(__is_constexpr(count),                    \
         |                               ^~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:323:47: note: expanded from macro '__is_constexpr'
     323 |         (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                      ^~~
>> net/bluetooth/hci_codec.c:226:16: error: invalid operands to binary expression ('__u8' (aka 'unsigned char') and 'struct hci_std_codecs_v2_hdr')
     226 |         for (i = 0; i < std_codecs->num; i++) {
         |                     ~ ^ ~~~~~~~~~~~~~~~
   net/bluetooth/hci_codec.c:232:16: error: operand of type 'struct hci_std_codecs_v2_hdr' where arithmetic or pointer type is required
     232 |         skb_pull(skb, flex_array_size(std_codecs, codec, std_codecs->num)
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:419:24: note: expanded from macro 'flex_array_size'
     419 |         __builtin_choose_expr(__is_constexpr(count),                    \
         |                               ^~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:323:47: note: expanded from macro '__is_constexpr'
     323 |         (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                      ^~~
   6 errors generated.


vim +151 net/bluetooth/hci_codec.c

8961987f3f5fa2f Kiran K     2021-09-07  119  
8961987f3f5fa2f Kiran K     2021-09-07  120  void hci_read_supported_codecs(struct hci_dev *hdev)
8961987f3f5fa2f Kiran K     2021-09-07  121  {
8961987f3f5fa2f Kiran K     2021-09-07  122  	struct sk_buff *skb;
8961987f3f5fa2f Kiran K     2021-09-07  123  	struct hci_rp_read_local_supported_codecs *rp;
8961987f3f5fa2f Kiran K     2021-09-07  124  	struct hci_std_codecs *std_codecs;
8961987f3f5fa2f Kiran K     2021-09-07  125  	struct hci_vnd_codecs *vnd_codecs;
8961987f3f5fa2f Kiran K     2021-09-07  126  	struct hci_op_read_local_codec_caps caps;
8961987f3f5fa2f Kiran K     2021-09-07  127  	__u8 i;
8961987f3f5fa2f Kiran K     2021-09-07  128  
828cea2b71de501 Chethan T N 2022-11-22  129  	skb = __hci_cmd_sync_sk(hdev, HCI_OP_READ_LOCAL_CODECS, 0, NULL,
828cea2b71de501 Chethan T N 2022-11-22  130  				0, HCI_CMD_TIMEOUT, NULL);
8961987f3f5fa2f Kiran K     2021-09-07  131  
8961987f3f5fa2f Kiran K     2021-09-07  132  	if (IS_ERR(skb)) {
8961987f3f5fa2f Kiran K     2021-09-07  133  		bt_dev_err(hdev, "Failed to read local supported codecs (%ld)",
8961987f3f5fa2f Kiran K     2021-09-07  134  			   PTR_ERR(skb));
8961987f3f5fa2f Kiran K     2021-09-07  135  		return;
8961987f3f5fa2f Kiran K     2021-09-07  136  	}
8961987f3f5fa2f Kiran K     2021-09-07  137  
8961987f3f5fa2f Kiran K     2021-09-07  138  	if (skb->len < sizeof(*rp))
8961987f3f5fa2f Kiran K     2021-09-07  139  		goto error;
8961987f3f5fa2f Kiran K     2021-09-07  140  
8961987f3f5fa2f Kiran K     2021-09-07  141  	rp = (void *)skb->data;
8961987f3f5fa2f Kiran K     2021-09-07  142  
8961987f3f5fa2f Kiran K     2021-09-07  143  	if (rp->status)
8961987f3f5fa2f Kiran K     2021-09-07  144  		goto error;
8961987f3f5fa2f Kiran K     2021-09-07  145  
8961987f3f5fa2f Kiran K     2021-09-07  146  	skb_pull(skb, sizeof(rp->status));
8961987f3f5fa2f Kiran K     2021-09-07  147  
8961987f3f5fa2f Kiran K     2021-09-07  148  	std_codecs = (void *)skb->data;
8961987f3f5fa2f Kiran K     2021-09-07  149  
8961987f3f5fa2f Kiran K     2021-09-07  150  	/* validate codecs length before accessing */
8961987f3f5fa2f Kiran K     2021-09-07 @151  	if (skb->len < flex_array_size(std_codecs, codec, std_codecs->num)
8961987f3f5fa2f Kiran K     2021-09-07  152  	    + sizeof(std_codecs->num))
8961987f3f5fa2f Kiran K     2021-09-07  153  		goto error;
8961987f3f5fa2f Kiran K     2021-09-07  154  
8961987f3f5fa2f Kiran K     2021-09-07  155  	/* enumerate codec capabilities of standard codecs */
8961987f3f5fa2f Kiran K     2021-09-07  156  	memset(&caps, 0, sizeof(caps));
8961987f3f5fa2f Kiran K     2021-09-07 @157  	for (i = 0; i < std_codecs->num; i++) {
8961987f3f5fa2f Kiran K     2021-09-07  158  		caps.id = std_codecs->codec[i];
8961987f3f5fa2f Kiran K     2021-09-07  159  		caps.direction = 0x00;
828cea2b71de501 Chethan T N 2022-11-22  160  		hci_read_codec_capabilities(hdev,
828cea2b71de501 Chethan T N 2022-11-22  161  					    LOCAL_CODEC_ACL_MASK | LOCAL_CODEC_SCO_MASK, &caps);
8961987f3f5fa2f Kiran K     2021-09-07  162  	}
8961987f3f5fa2f Kiran K     2021-09-07  163  
8961987f3f5fa2f Kiran K     2021-09-07  164  	skb_pull(skb, flex_array_size(std_codecs, codec, std_codecs->num)
8961987f3f5fa2f Kiran K     2021-09-07  165  		 + sizeof(std_codecs->num));
8961987f3f5fa2f Kiran K     2021-09-07  166  
8961987f3f5fa2f Kiran K     2021-09-07  167  	vnd_codecs = (void *)skb->data;
8961987f3f5fa2f Kiran K     2021-09-07  168  
8961987f3f5fa2f Kiran K     2021-09-07  169  	/* validate vendor codecs length before accessing */
8961987f3f5fa2f Kiran K     2021-09-07  170  	if (skb->len <
8961987f3f5fa2f Kiran K     2021-09-07  171  	    flex_array_size(vnd_codecs, codec, vnd_codecs->num)
8961987f3f5fa2f Kiran K     2021-09-07  172  	    + sizeof(vnd_codecs->num))
8961987f3f5fa2f Kiran K     2021-09-07  173  		goto error;
8961987f3f5fa2f Kiran K     2021-09-07  174  
8961987f3f5fa2f Kiran K     2021-09-07  175  	/* enumerate vendor codec capabilities */
8961987f3f5fa2f Kiran K     2021-09-07  176  	for (i = 0; i < vnd_codecs->num; i++) {
8961987f3f5fa2f Kiran K     2021-09-07  177  		caps.id = 0xFF;
8961987f3f5fa2f Kiran K     2021-09-07  178  		caps.cid = vnd_codecs->codec[i].cid;
8961987f3f5fa2f Kiran K     2021-09-07  179  		caps.vid = vnd_codecs->codec[i].vid;
8961987f3f5fa2f Kiran K     2021-09-07  180  		caps.direction = 0x00;
828cea2b71de501 Chethan T N 2022-11-22  181  		hci_read_codec_capabilities(hdev,
828cea2b71de501 Chethan T N 2022-11-22  182  					    LOCAL_CODEC_ACL_MASK | LOCAL_CODEC_SCO_MASK, &caps);
8961987f3f5fa2f Kiran K     2021-09-07  183  	}
8961987f3f5fa2f Kiran K     2021-09-07  184  
8961987f3f5fa2f Kiran K     2021-09-07  185  error:
8961987f3f5fa2f Kiran K     2021-09-07  186  	kfree_skb(skb);
8961987f3f5fa2f Kiran K     2021-09-07  187  }
9ae664028a9ea83 Kiran K     2021-09-07  188  
9ae664028a9ea83 Kiran K     2021-09-07  189  void hci_read_supported_codecs_v2(struct hci_dev *hdev)
9ae664028a9ea83 Kiran K     2021-09-07  190  {
9ae664028a9ea83 Kiran K     2021-09-07  191  	struct sk_buff *skb;
9ae664028a9ea83 Kiran K     2021-09-07  192  	struct hci_rp_read_local_supported_codecs_v2 *rp;
9ae664028a9ea83 Kiran K     2021-09-07  193  	struct hci_std_codecs_v2 *std_codecs;
9ae664028a9ea83 Kiran K     2021-09-07  194  	struct hci_vnd_codecs_v2 *vnd_codecs;
9ae664028a9ea83 Kiran K     2021-09-07  195  	struct hci_op_read_local_codec_caps caps;
9ae664028a9ea83 Kiran K     2021-09-07  196  	__u8 i;
9ae664028a9ea83 Kiran K     2021-09-07  197  
828cea2b71de501 Chethan T N 2022-11-22  198  	skb = __hci_cmd_sync_sk(hdev, HCI_OP_READ_LOCAL_CODECS_V2, 0, NULL,
828cea2b71de501 Chethan T N 2022-11-22  199  				0, HCI_CMD_TIMEOUT, NULL);
9ae664028a9ea83 Kiran K     2021-09-07  200  
9ae664028a9ea83 Kiran K     2021-09-07  201  	if (IS_ERR(skb)) {
9ae664028a9ea83 Kiran K     2021-09-07  202  		bt_dev_err(hdev, "Failed to read local supported codecs (%ld)",
9ae664028a9ea83 Kiran K     2021-09-07  203  			   PTR_ERR(skb));
9ae664028a9ea83 Kiran K     2021-09-07  204  		return;
9ae664028a9ea83 Kiran K     2021-09-07  205  	}
9ae664028a9ea83 Kiran K     2021-09-07  206  
9ae664028a9ea83 Kiran K     2021-09-07  207  	if (skb->len < sizeof(*rp))
9ae664028a9ea83 Kiran K     2021-09-07  208  		goto error;
9ae664028a9ea83 Kiran K     2021-09-07  209  
9ae664028a9ea83 Kiran K     2021-09-07  210  	rp = (void *)skb->data;
9ae664028a9ea83 Kiran K     2021-09-07  211  
9ae664028a9ea83 Kiran K     2021-09-07  212  	if (rp->status)
9ae664028a9ea83 Kiran K     2021-09-07  213  		goto error;
9ae664028a9ea83 Kiran K     2021-09-07  214  
9ae664028a9ea83 Kiran K     2021-09-07  215  	skb_pull(skb, sizeof(rp->status));
9ae664028a9ea83 Kiran K     2021-09-07  216  
9ae664028a9ea83 Kiran K     2021-09-07  217  	std_codecs = (void *)skb->data;
9ae664028a9ea83 Kiran K     2021-09-07  218  
9ae664028a9ea83 Kiran K     2021-09-07  219  	/* check for payload data length before accessing */
9ae664028a9ea83 Kiran K     2021-09-07 @220  	if (skb->len < flex_array_size(std_codecs, codec, std_codecs->num)
9ae664028a9ea83 Kiran K     2021-09-07  221  	    + sizeof(std_codecs->num))
9ae664028a9ea83 Kiran K     2021-09-07  222  		goto error;
9ae664028a9ea83 Kiran K     2021-09-07  223  
9ae664028a9ea83 Kiran K     2021-09-07  224  	memset(&caps, 0, sizeof(caps));
9ae664028a9ea83 Kiran K     2021-09-07  225  
9ae664028a9ea83 Kiran K     2021-09-07 @226  	for (i = 0; i < std_codecs->num; i++) {

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
