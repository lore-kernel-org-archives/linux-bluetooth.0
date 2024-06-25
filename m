Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBFE149DF8
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 22:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719355266; cv=none; b=LAnicbpGJcJRVOh5jYu1uzQyjVSjk/TGf7xoQz8/nlbyz16yCq/qGOvd+TGFfOnFK1tUsDVsGHttiNVm2MLXJhhE2fOxDO7vC+O6zeQpgOVukYChZj8eZ1O3ud3PLoHIBGiwi38s33oN1+ahMRdOavh7AfoWJg5EVqAJ4oDEzs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719355266; c=relaxed/simple;
	bh=IkUPtooW7PIn5Eng5K+5TVL9JdofpoMiwShwsxi88MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfQH2Gho1Rtacm+/AM/8y39I2nkiU0CWEFOqpGgYJgODUiv62XCUfkilhK5ynqOcz45dFcnm2Ncy6yzyM38f68CLHQ/orJoJU5crKJa2P/B20woisShhXZyk7TIicDfrYfqN8zhItGmN4ru6hkkgFXNYYjohKpMR/AeVfa/iBBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hi2lVoKf; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hi2lVoKf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719355264; x=1750891264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IkUPtooW7PIn5Eng5K+5TVL9JdofpoMiwShwsxi88MI=;
  b=hi2lVoKfD77ZXyf5QTt4k5UynWT+DlxcarcdZFtYiwYtpYAhoPMme8P1
   xXYgVcU9LHRuX+Ju2V/G4g1+j7/MR5GK7GCVy42HhDET8DvDlgd+pYshF
   Gx7KJ4ShmoVIZd5XCF+z1Ya9YRmz8mKjjD/f9hBfzuhnG0BSx/kEevO/q
   9V3NQ8IBkhqL2ngOeeED6FjSTULFnmX/prYkGFwjNN4m1YdfAuBNI1Yba
   g+SZlt4NRQ1iSQB93Ns3h84MggArhbnBuTT6e17B2g7LR09NZWJvZ5cx9
   AiIOY9gZIBjEQbg1vYi360iPWvGXrbWUvT6oGw+eZTRxSyl6yQtpv07wH
   w==;
X-CSE-ConnectionGUID: 2OZ5vWsuQAWmT+LyZHFX0w==
X-CSE-MsgGUID: HYHtxLpWRJGqH0GR4BE78w==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="33858374"
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="33858374"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 15:41:03 -0700
X-CSE-ConnectionGUID: Ko//HmK9S9e0+x5Mkn4vNw==
X-CSE-MsgGUID: oI2S5gr5S7elevzA56k/aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="81335706"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 25 Jun 2024 15:41:02 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMEqR-000EmI-0z;
	Tue, 25 Jun 2024 22:40:59 +0000
Date: Wed, 26 Jun 2024 06:40:41 +0800
From: kernel test robot <lkp@intel.com>
To: Kiran K <kiran.k@intel.com>, linux-bluetooth@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com, Kiran K <kiran.k@intel.com>
Subject: Re: [PATCH v2] Bluetooth: btintel: Allow lowering of drive strength
 of BRI
Message-ID: <202406260659.fzB4yn3X-lkp@intel.com>
References: <20240621064419.2185652-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621064419.2185652-1-kiran.k@intel.com>

Hi Kiran,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth-next/master]
[also build test ERROR on next-20240625]
[cannot apply to bluetooth/master linus/master v6.10-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kiran-K/Bluetooth-btintel-Allow-lowering-of-drive-strength-of-BRI/20240625-161151
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20240621064419.2185652-1-kiran.k%40intel.com
patch subject: [PATCH v2] Bluetooth: btintel: Allow lowering of drive strength of BRI
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240626/202406260659.fzB4yn3X-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240626/202406260659.fzB4yn3X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406260659.fzB4yn3X-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/bluetooth/btintel.c: In function 'btintel_uefi_get_variable':
>> drivers/bluetooth/btintel.c:66:53: error: passing argument 4 of 'efi.get_variable' from incompatible pointer type [-Werror=incompatible-pointer-types]
      66 |         status = efi.get_variable(name, guid, NULL, &data_size, NULL);
         |                                                     ^~~~~~~~~~
         |                                                     |
         |                                                     size_t * {aka unsigned int *}
   drivers/bluetooth/btintel.c:66:53: note: expected 'long unsigned int *' but argument is of type 'size_t *' {aka 'unsigned int *'}
   drivers/bluetooth/btintel.c:76:53: error: passing argument 4 of 'efi.get_variable' from incompatible pointer type [-Werror=incompatible-pointer-types]
      76 |         status = efi.get_variable(name, guid, NULL, &data_size, data);
         |                                                     ^~~~~~~~~~
         |                                                     |
         |                                                     size_t * {aka unsigned int *}
   drivers/bluetooth/btintel.c:76:53: note: expected 'long unsigned int *' but argument is of type 'size_t *' {aka 'unsigned int *'}
   cc1: some warnings being treated as errors


vim +66 drivers/bluetooth/btintel.c

    49	
    50	static const guid_t btintel_guid_dsm =
    51		GUID_INIT(0xaa10f4e0, 0x81ac, 0x4233,
    52			  0xab, 0xf6, 0x3b, 0x2a, 0xc5, 0x0e, 0x28, 0xd9);
    53	
    54	static void *btintel_uefi_get_variable(efi_char16_t *name, efi_guid_t *guid)
    55	{
    56		void *data;
    57		efi_status_t status;
    58		size_t data_size = 0;
    59	
    60		if (!IS_ENABLED(CONFIG_EFI))
    61			return ERR_PTR(-EOPNOTSUPP);
    62	
    63		if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
    64			return ERR_PTR(-EOPNOTSUPP);
    65	
  > 66		status = efi.get_variable(name, guid, NULL, &data_size, NULL);
    67	
    68		if (status != EFI_BUFFER_TOO_SMALL || !data_size)
    69			return ERR_PTR(-EIO);
    70	
    71		data = kmalloc(data_size, GFP_KERNEL);
    72	
    73		if (!data)
    74			return ERR_PTR(-ENOMEM);
    75	
    76		status = efi.get_variable(name, guid, NULL, &data_size, data);
    77	
    78		if (status != EFI_SUCCESS) {
    79			kfree(data);
    80			return ERR_PTR(-ENXIO);
    81		}
    82	
    83		return data;
    84	}
    85	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
