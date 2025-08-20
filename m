Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86212264AD
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755714695; cv=none; b=RpjZM9tJ7hKsJMs05lqVxW6k22IcCgp/dI70706UEdxBhBcO7hhTdpth6y4dNouoT36vymIYev+2BNoKltnrRSLvBDJJDsWgIAEaO/jQ/JNPhPosPXoCEOf8EBtCWnCVHZ08lURrSEVGpYsXAPDMBzZnfdJqMnKxpcuyCIvQtOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755714695; c=relaxed/simple;
	bh=Rya3y2YKZ29lgm/PE1ZNdCwg7xAblesrAsh2cMfptIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFB4vvExbi6ItC9pnGczH1eGgRqPNfhQkxk0i1zUp0Q907CFv0307IhslNzVtFL4441VtzFRHbc9lLbqF502iZw+OC/VocB83jVzBf0LAwbfiKtTD9+tX9lBwcKLwdQz7gtz4Gz/IEDwuQUGElMAUGc1LcP/iup7HG28rLL19kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TOGRURXN; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TOGRURXN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755714692; x=1787250692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rya3y2YKZ29lgm/PE1ZNdCwg7xAblesrAsh2cMfptIQ=;
  b=TOGRURXNjgJEXEI6dd1LYYSdJRn8ipq7aDqZs6drkCUGHxCuiv2nUpWw
   S0vf9heORed8g7q4RjzqgPULhWNkJczkV6kT/CeUUPs3URrae5k31x6Yh
   RnwjMF4yq3cEs3zegNy4daluayS999sOekU9qe3/IEUgwUvRUYhBmSO9d
   ngJM91t4xPbgAaHNfAH1KZCvDFNK6Jyo7VAmJ0XN/RUNS0IwU4yhjaCX0
   UANbFtfF44WBkjwb+GWtqkFyT/V3dlFog9A0uCK/WhOZEPohFZ6Xsavz2
   FcOifZWhMUuB9pvmX2xnT7MZu78ZG/y8k1qe8K3Oo0F30FcFPFB0qdShT
   Q==;
X-CSE-ConnectionGUID: XK24Nh7RRBmNn7cON3iZLg==
X-CSE-MsgGUID: vFxJQVFeQV2tW/d9FFHRcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="60620374"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="60620374"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 11:31:32 -0700
X-CSE-ConnectionGUID: 8xEyT9RARWm8NeyB1s6xgQ==
X-CSE-MsgGUID: 4c9T0/IoTBmdjGHzwnu8FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="167406818"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 20 Aug 2025 11:31:29 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uonao-000JbB-2w;
	Wed, 20 Aug 2025 18:31:26 +0000
Date: Thu, 21 Aug 2025 02:31:14 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1] Bluetooth: MGMT: Fix not exposing debug UUID on
 MGMT_OP_READ_EXP_FEATURES_INFO
Message-ID: <202508210258.dagzqWcm-lkp@intel.com>
References: <20250820145829.1766185-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820145829.1766185-1-luiz.dentz@gmail.com>

Hi Luiz,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth-next/master]
[also build test ERROR on bluetooth/master linus/master v6.17-rc2 next-20250820]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luiz-Augusto-von-Dentz/Bluetooth-MGMT-Fix-not-exposing-debug-UUID-on-MGMT_OP_READ_EXP_FEATURES_INFO/20250820-230851
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20250820145829.1766185-1-luiz.dentz%40gmail.com
patch subject: [PATCH v1] Bluetooth: MGMT: Fix not exposing debug UUID on MGMT_OP_READ_EXP_FEATURES_INFO
config: csky-randconfig-001-20250821 (https://download.01.org/0day-ci/archive/20250821/202508210258.dagzqWcm-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250821/202508210258.dagzqWcm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508210258.dagzqWcm-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/bluetooth/mgmt.c: In function 'read_exp_features_info':
>> net/bluetooth/mgmt.c:4470:25: error: implicit declaration of function 'bt_dbg_get' [-Werror=implicit-function-declaration]
    4470 |                 flags = bt_dbg_get() ? BIT(0) : 0;
         |                         ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/bt_dbg_get +4470 net/bluetooth/mgmt.c

af6bcc1921ff0b Brian Gix              2022-09-01  4451  
a10c907ce0e5e1 Marcel Holtmann        2020-05-06  4452  static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
a10c907ce0e5e1 Marcel Holtmann        2020-05-06  4453  				  void *data, u16 data_len)
a10c907ce0e5e1 Marcel Holtmann        2020-05-06  4454  {
af6bcc1921ff0b Brian Gix              2022-09-01  4455  	struct mgmt_rp_read_exp_features_info *rp;
af6bcc1921ff0b Brian Gix              2022-09-01  4456  	size_t len;
a10c907ce0e5e1 Marcel Holtmann        2020-05-06  4457  	u16 idx = 0;
15d8ce05ebec37 Alain Michaud          2020-07-07  4458  	u32 flags;
af6bcc1921ff0b Brian Gix              2022-09-01  4459  	int status;
a10c907ce0e5e1 Marcel Holtmann        2020-05-06  4460  
a10c907ce0e5e1 Marcel Holtmann        2020-05-06  4461  	bt_dev_dbg(hdev, "sock %p", sk);
a10c907ce0e5e1 Marcel Holtmann        2020-05-06  4462  
af6bcc1921ff0b Brian Gix              2022-09-01  4463  	/* Enough space for 7 features */
af6bcc1921ff0b Brian Gix              2022-09-01  4464  	len = sizeof(*rp) + (sizeof(rp->features[0]) * 7);
bb20da18ce936a Yihao Han              2022-09-19  4465  	rp = kzalloc(len, GFP_KERNEL);
af6bcc1921ff0b Brian Gix              2022-09-01  4466  	if (!rp)
af6bcc1921ff0b Brian Gix              2022-09-01  4467  		return -ENOMEM;
af6bcc1921ff0b Brian Gix              2022-09-01  4468  
50912f8b707c67 Luiz Augusto von Dentz 2025-08-20  4469  	if (IS_ENABLED(CONFIG_BT_FEATURE_DEBUG)) {
15d8ce05ebec37 Alain Michaud          2020-07-07 @4470  		flags = bt_dbg_get() ? BIT(0) : 0;
e625e50ceee18b Marcel Holtmann        2020-05-06  4471  
e625e50ceee18b Marcel Holtmann        2020-05-06  4472  		memcpy(rp->features[idx].uuid, debug_uuid, 16);
e625e50ceee18b Marcel Holtmann        2020-05-06  4473  		rp->features[idx].flags = cpu_to_le32(flags);
e625e50ceee18b Marcel Holtmann        2020-05-06  4474  		idx++;
e625e50ceee18b Marcel Holtmann        2020-05-06  4475  	}
e625e50ceee18b Marcel Holtmann        2020-05-06  4476  
76d0685bbac8ae Luiz Augusto von Dentz 2021-12-22  4477  	if (hdev && hci_dev_le_state_simultaneous(hdev)) {
76d0685bbac8ae Luiz Augusto von Dentz 2021-12-22  4478  		if (hci_dev_test_flag(hdev, HCI_LE_SIMULTANEOUS_ROLES))
15d8ce05ebec37 Alain Michaud          2020-07-07  4479  			flags = BIT(0);
15d8ce05ebec37 Alain Michaud          2020-07-07  4480  		else
15d8ce05ebec37 Alain Michaud          2020-07-07  4481  			flags = 0;
15d8ce05ebec37 Alain Michaud          2020-07-07  4482  
76d0685bbac8ae Luiz Augusto von Dentz 2021-12-22  4483  		memcpy(rp->features[idx].uuid, le_simultaneous_roles_uuid, 16);
15d8ce05ebec37 Alain Michaud          2020-07-07  4484  		rp->features[idx].flags = cpu_to_le32(flags);
15d8ce05ebec37 Alain Michaud          2020-07-07  4485  		idx++;
15d8ce05ebec37 Alain Michaud          2020-07-07  4486  	}
15d8ce05ebec37 Alain Michaud          2020-07-07  4487  
258f56d11bbbf3 Joseph Hwang           2021-11-02  4488  	if (hdev && (aosp_has_quality_report(hdev) ||
258f56d11bbbf3 Joseph Hwang           2021-11-02  4489  		     hdev->set_quality_report)) {
ae7d925b5c0432 Joseph Hwang           2021-08-15  4490  		if (hci_dev_test_flag(hdev, HCI_QUALITY_REPORT))
823f3bc4e2eca7 Marcel Holtmann        2021-09-28  4491  			flags = BIT(0);
823f3bc4e2eca7 Marcel Holtmann        2021-09-28  4492  		else
ae7d925b5c0432 Joseph Hwang           2021-08-15  4493  			flags = 0;
823f3bc4e2eca7 Marcel Holtmann        2021-09-28  4494  
ae7d925b5c0432 Joseph Hwang           2021-08-15  4495  		memcpy(rp->features[idx].uuid, quality_report_uuid, 16);
ae7d925b5c0432 Joseph Hwang           2021-08-15  4496  		rp->features[idx].flags = cpu_to_le32(flags);
ae7d925b5c0432 Joseph Hwang           2021-08-15  4497  		idx++;
ae7d925b5c0432 Joseph Hwang           2021-08-15  4498  	}
ae7d925b5c0432 Joseph Hwang           2021-08-15  4499  
7f7fd17ed7c522 Marcel Holtmann        2021-09-28  4500  	if (hdev && hdev->get_data_path_id) {
ad933151832855 Kiran K                2021-09-07  4501  		if (hci_dev_test_flag(hdev, HCI_OFFLOAD_CODECS_ENABLED))
7f7fd17ed7c522 Marcel Holtmann        2021-09-28  4502  			flags = BIT(0);
7f7fd17ed7c522 Marcel Holtmann        2021-09-28  4503  		else
ad933151832855 Kiran K                2021-09-07  4504  			flags = 0;
7f7fd17ed7c522 Marcel Holtmann        2021-09-28  4505  
ad933151832855 Kiran K                2021-09-07  4506  		memcpy(rp->features[idx].uuid, offload_codecs_uuid, 16);
ad933151832855 Kiran K                2021-09-07  4507  		rp->features[idx].flags = cpu_to_le32(flags);
ad933151832855 Kiran K                2021-09-07  4508  		idx++;
ad933151832855 Kiran K                2021-09-07  4509  	}
ad933151832855 Kiran K                2021-09-07  4510  
ccf74f2390d60a Luiz Augusto von Dentz 2020-01-16  4511  	if (IS_ENABLED(CONFIG_BT_LE)) {
3ca23aaba210e4 Luiz Augusto von Dentz 2025-08-04  4512  		flags = iso_inited() ? BIT(0) : 0;
ccf74f2390d60a Luiz Augusto von Dentz 2020-01-16  4513  		memcpy(rp->features[idx].uuid, iso_socket_uuid, 16);
ccf74f2390d60a Luiz Augusto von Dentz 2020-01-16  4514  		rp->features[idx].flags = cpu_to_le32(flags);
ccf74f2390d60a Luiz Augusto von Dentz 2020-01-16  4515  		idx++;
ccf74f2390d60a Luiz Augusto von Dentz 2020-01-16  4516  	}
ccf74f2390d60a Luiz Augusto von Dentz 2020-01-16  4517  
af6bcc1921ff0b Brian Gix              2022-09-01  4518  	if (hdev && lmp_le_capable(hdev)) {
af6bcc1921ff0b Brian Gix              2022-09-01  4519  		if (hci_dev_test_flag(hdev, HCI_MESH_EXPERIMENTAL))
af6bcc1921ff0b Brian Gix              2022-09-01  4520  			flags = BIT(0);
af6bcc1921ff0b Brian Gix              2022-09-01  4521  		else
af6bcc1921ff0b Brian Gix              2022-09-01  4522  			flags = 0;
af6bcc1921ff0b Brian Gix              2022-09-01  4523  
af6bcc1921ff0b Brian Gix              2022-09-01  4524  		memcpy(rp->features[idx].uuid, mgmt_mesh_uuid, 16);
af6bcc1921ff0b Brian Gix              2022-09-01  4525  		rp->features[idx].flags = cpu_to_le32(flags);
af6bcc1921ff0b Brian Gix              2022-09-01  4526  		idx++;
af6bcc1921ff0b Brian Gix              2022-09-01  4527  	}
af6bcc1921ff0b Brian Gix              2022-09-01  4528  
a10c907ce0e5e1 Marcel Holtmann        2020-05-06  4529  	rp->feature_count = cpu_to_le16(idx);
a10c907ce0e5e1 Marcel Holtmann        2020-05-06  4530  
a10c907ce0e5e1 Marcel Holtmann        2020-05-06  4531  	/* After reading the experimental features information, enable
a10c907ce0e5e1 Marcel Holtmann        2020-05-06  4532  	 * the events to update client on any future change.
a10c907ce0e5e1 Marcel Holtmann        2020-05-06  4533  	 */
a10c907ce0e5e1 Marcel Holtmann        2020-05-06  4534  	hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
a10c907ce0e5e1 Marcel Holtmann        2020-05-06  4535  
af6bcc1921ff0b Brian Gix              2022-09-01  4536  	status = mgmt_cmd_complete(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
a10c907ce0e5e1 Marcel Holtmann        2020-05-06  4537  				   MGMT_OP_READ_EXP_FEATURES_INFO,
a10c907ce0e5e1 Marcel Holtmann        2020-05-06  4538  				   0, rp, sizeof(*rp) + (20 * idx));
af6bcc1921ff0b Brian Gix              2022-09-01  4539  
af6bcc1921ff0b Brian Gix              2022-09-01  4540  	kfree(rp);
af6bcc1921ff0b Brian Gix              2022-09-01  4541  	return status;
a10c907ce0e5e1 Marcel Holtmann        2020-05-06  4542  }
a10c907ce0e5e1 Marcel Holtmann        2020-05-06  4543  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
