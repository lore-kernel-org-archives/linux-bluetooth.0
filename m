Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A41D71B5B;
	Thu,  6 Jun 2024 23:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717718007; cv=none; b=JTSVSWnl70kxrcq8v81YpKgCdhdeVDvTqoFqDPQWW9vSM9AxNV8FP1zC8TDT+bka6ORBbHs6JBAwkRqbk8VoKVmXypGZQbhXaX9rMCQWtI332HoA5b1u6vSgjqeNSRaJYDhCNNjG+zKpjNAS0JTqKaDFe5+dlkP1fMh2vO67L9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717718007; c=relaxed/simple;
	bh=E/psiguQLxhslxk3Ia2n2N/Obzi4NeEoU2JEow9x5zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duBEGQQE8tn0aUd0BfQw4OfpFrlsIjxJItsWLFOD7Iifm6VKbp/4qTkWo58+s45wjDr/m9L0dTtdktwkk+zTjYr0mhbhQ/EdE0RiGo87+TR8dz2LlLguV11tyoroqzcG9lUGDzUbVtKyQ0AwSJ6mqqezdAG4sXrZGWjBsxE46GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VdUsvxNc; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VdUsvxNc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717718006; x=1749254006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E/psiguQLxhslxk3Ia2n2N/Obzi4NeEoU2JEow9x5zs=;
  b=VdUsvxNc5mZQB+HrpNGPIbvVIXwkUXWNSzfErSeLSAqpJbfAfD/JWsW+
   lSAJyuK+5FlSrgc3iEpIStd7Qx5Zh6qLTVqunXi6QKjgxhE3RsJUtoU6m
   wd4ySzwpTy/28c1nv/f41zhV7tlQuU6TkE+KtLzH/4CbAlLPzIu9F6JNU
   ikoR0/k5BaY8DPqINtB7TskN8JCe6IZuWlWhL5AfVVK1nUt29i9YdZzXd
   tSonMZW0+DguskG5GuQ8YdP5JQz3TrDkg9VFTdVnFnKUSgayV3xQDRrwI
   jiY8R16jtT9/5ofKvLfQ3/o+bhbBQrHhIZCiskkAOsdMd/wihDLFQtRxi
   w==;
X-CSE-ConnectionGUID: wMuYTFsBSTGS6BHNUv63jw==
X-CSE-MsgGUID: Osxiw/cWTHiMTstJmnf+7w==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14256665"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14256665"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 16:53:26 -0700
X-CSE-ConnectionGUID: qzxj3XGARuOCaxb2qIW7vg==
X-CSE-MsgGUID: ZUVJ06S5QWeSRKnoNgHKqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="69310958"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 06 Jun 2024 16:53:23 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFMv2-0003se-2y;
	Thu, 06 Jun 2024 23:53:20 +0000
Date: Fri, 7 Jun 2024 07:52:33 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Lu <chris.lu@mediatek.com>, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Von Dentz <luiz.dentz@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Sean Wang <sean.wang@mediatek.com>,
	Deren Wu <deren.Wu@mediatek.com>,
	Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-mediatek <linux-mediatek@lists.infradead.org>,
	Chris Lu <chris.lu@mediatek.com>
Subject: Re: [PATCH v4 4/4] Bluetooth: btusb: mediatek: add ISO data
 transmission functions
Message-ID: <202406070759.EDNrdv4q-lkp@intel.com>
References: <20240606114321.30515-5-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606114321.30515-5-chris.lu@mediatek.com>

Hi Chris,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth-next/master]
[also build test ERROR on next-20240606]
[cannot apply to bluetooth/master linus/master v6.10-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Lu/Bluetooth-net-add-hci_iso_hdr-function-for-iso-data/20240606-194619
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20240606114321.30515-5-chris.lu%40mediatek.com
patch subject: [PATCH v4 4/4] Bluetooth: btusb: mediatek: add ISO data transmission functions
config: x86_64-buildonly-randconfig-003-20240607 (https://download.01.org/0day-ci/archive/20240607/202406070759.EDNrdv4q-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406070759.EDNrdv4q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406070759.EDNrdv4q-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/bluetooth/btusb.c:28:
>> drivers/bluetooth/btmtk.h:259:9: error: incompatible pointer to integer conversion returning 'void *' from a function with result type 'int' [-Wint-conversion]
     259 |         return ERR_PTR(-EOPNOTSUPP);
         |                ^~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +259 drivers/bluetooth/btmtk.h

   256	
   257	static int btmtk_isopkt_pad(struct hci_dev *hdev, struct sk_buff *skb)
   258	{
 > 259		return ERR_PTR(-EOPNOTSUPP);
   260	}
   261	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
