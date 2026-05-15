Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A31282F0E
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778868497; cv=none; b=dQpPaPX2+GvcFy0rH8hltT1tGLUH2KQQ9yaHfQZG1ZiPIvdER6J3W80Bf43Hb5203vaF8JRmU5VFOkOGhB8LLbe1BiD2dSrDfLCJ3KmN+vFPs/5fLH/B7D1qrMXAy70d3OFDZG4dkPYj1797qUtz3betpbvVYLAmySxjY6MwD+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778868497; c=relaxed/simple;
	bh=07iLCp3PGbOm3wKmwlbwbUueWf941mE9LiAgG55fUjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AH+9rr9dGFD4vbkf/sKOhQooRqziHLL2xWGiWfTuRv1ikb6SbVxr/hFCMDq8e8nr2htytAnpbAUsqyOTfCFb4+Kb4lOzx2+sBXxi08enEjn/JYky79Ov6lTHLV7g7Is47NEO1/qMkAnmxEqiLfUSU4u3CaTRmSRYoas57WGJmgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g3wV1w6H; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g3wV1w6H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778868496; x=1810404496;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=07iLCp3PGbOm3wKmwlbwbUueWf941mE9LiAgG55fUjk=;
  b=g3wV1w6HS81fBJLqLJFjSn/T3EOcg3u7WBzjXkN0uUHhlocx9w9Witnd
   LBI5XCC6THlrsXYdCjEnjcBYLbnZl1N0YQV73G5QXt+8Ki2opICOvri+B
   mfmdB1I6RU1mxI8CWeJ7zSVn6ZK+Vwsyyonug5AAaI/gfm767QO3HSf1Z
   2sVTE68k8xgqXFndvOg1DjCJEpGAZ16r8xJ2QTsBbj9EfkyJysiY5RmdT
   QcFTG9fS5i67NqtHCAGkXvshEgCRa+34cyPhgArsgahY5TSq0Bqro/ZzO
   HbuwNKeO6KriUGTWL16p97CADuhFK0bF5hVck+aYngU/BL14xfHqx6/Iz
   A==;
X-CSE-ConnectionGUID: X5PpUR3tTxmib+DjMmh8Kg==
X-CSE-MsgGUID: trEz5XQmQWSbngYgAaIf8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="90523708"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="90523708"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 11:08:15 -0700
X-CSE-ConnectionGUID: fDOnf0xzRDeipB2i9pXtkg==
X-CSE-MsgGUID: GI+LoBb4Qeu0mC4f1CrFHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="243095787"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by orviesa004.jf.intel.com with ESMTP; 15 May 2026 11:08:14 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNwxI-0000000094b-1oRi;
	Fri, 15 May 2026 18:08:12 +0000
Date: Fri, 15 May 2026 20:08:11 +0200
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 2/2] Bluetooth: MGMT: Add SCI setting bit(25)
Message-ID: <202605152004.a78xmK2S-lkp@intel.com>
References: <20260506160651.1585012-2-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506160651.1585012-2-luiz.dentz@gmail.com>

Hi Luiz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on bluetooth/master linus/master v7.1-rc3 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luiz-Augusto-von-Dentz/Bluetooth-MGMT-Add-SCI-setting-bit-25/20260515-083218
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20260506160651.1585012-2-luiz.dentz%40gmail.com
patch subject: [PATCH v2 2/2] Bluetooth: MGMT: Add SCI setting bit(25)
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260515/202605152004.a78xmK2S-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260515/202605152004.a78xmK2S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605152004.a78xmK2S-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/bluetooth/hci_sync.c:4942:7: warning: logical not is only applied to the left hand side of this comparison [-Wlogical-not-parentheses]
    4942 |                 if (!min == 0 || grp->min < min)
         |                     ^    ~~
   net/bluetooth/hci_sync.c:4942:7: note: add parentheses after the '!' to evaluate the comparison first
    4942 |                 if (!min == 0 || grp->min < min)
         |                     ^
         |                      (       )
   net/bluetooth/hci_sync.c:4942:7: note: add parentheses around left hand side expression to silence this warning
    4942 |                 if (!min == 0 || grp->min < min)
         |                     ^
         |                     (   )
   net/bluetooth/hci_sync.c:4945:7: warning: logical not is only applied to the left hand side of this comparison [-Wlogical-not-parentheses]
    4945 |                 if (!max == 0 || grp->max > max)
         |                     ^    ~~
   net/bluetooth/hci_sync.c:4945:7: note: add parentheses after the '!' to evaluate the comparison first
    4945 |                 if (!max == 0 || grp->max > max)
         |                     ^
         |                      (       )
   net/bluetooth/hci_sync.c:4945:7: note: add parentheses around left hand side expression to silence this warning
    4945 |                 if (!max == 0 || grp->max > max)
         |                     ^
         |                     (   )
   2 warnings generated.


vim +4942 net/bluetooth/hci_sync.c

  4921	
  4922	/* Set Default Connection Rate Parameters if command is supported, SCI feature
  4923	 * bit is marked as supported and at least one of the supported SCI groups
  4924	 * exists.
  4925	 */
  4926	static int hci_le_set_def_rate_sync(struct hci_dev *hdev)
  4927	{
  4928		struct hci_cp_le_set_def_rate cp;
  4929		struct sci_group *grp, *tmp;
  4930		__u16 min = 0, max = 0;
  4931	
  4932		if (!(hdev->commands[48] & BIT(6)) || !le_sci_capable(hdev) ||
  4933		    list_empty(&hdev->sci_groups))
  4934			return 0;
  4935	
  4936		memset(&cp, 0, sizeof(cp));
  4937	
  4938		/* Iterate over the SCI groups and find the widest supported connection
  4939		 * interval range to maximize compatibility with peer devices.
  4940		 */
  4941		list_for_each_entry_safe(grp, tmp, &hdev->sci_groups, list) {
> 4942			if (!min == 0 || grp->min < min)
  4943				min = grp->min;
  4944	
  4945			if (!max == 0 || grp->max > max)
  4946				max = grp->max;
  4947		}
  4948	
  4949		cp.interval_min = cpu_to_le16(min);
  4950		cp.interval_max = cpu_to_le16(max);
  4951	
  4952		/* HOG 1.2 Table 7.4. Modes with recommended parameter values suggests
  4953		 * subrate 1-4 for all modes so use that as default.
  4954		 */
  4955		cp.subrate_min = cpu_to_le16(0x0001);
  4956		cp.subrate_max = cpu_to_le16(0x0004);
  4957	
  4958		/* HIP 1.2 Table 7.5. Modes with recommended parameter values suggests
  4959		 * max latency of 0 for all modes expect low power.
  4960		 */
  4961		cp.max_latency = 0x0000;
  4962	
  4963		/* HIP 1.2 Table 7.5. Modes with recommended parameter values suggests
  4964		 * continuation number 1 for full range.
  4965		 */
  4966		cp.cont_num = cpu_to_le16(0x0001);
  4967	
  4968		/* HOG 1.2 Table 7.4. Modes with recommended parameter values states
  4969		 * that link supervision timeout should be: Greater than or equal to
  4970		 * (1 + Peripheral Latency) x Subrate max x Connection Interval max x 2.
  4971		 */
  4972		cp.supv_timeout = cpu_to_le16((1 + 0) * 0x0004 * max * 2 / 10);
  4973	
  4974		cp.min_ce_len = cpu_to_le16(min);
  4975		cp.max_ce_len = cpu_to_le16(max);
  4976	
  4977		return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_DEF_RATE,
  4978					     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
  4979	}
  4980	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
