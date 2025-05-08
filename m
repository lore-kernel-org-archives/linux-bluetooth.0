Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E897195FE8;
	Thu,  8 May 2025 06:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746687272; cv=none; b=Q1tEKhyolTEBQ90L+6m8D09ao3FeJ/6qZfFQ1miXoaSrYFEdfm35yINMSRKJA1yiDHUgMf7X9eUXIAXU54n6OHZPj7ReubgHwrGo+z4GjhFapCe7kpBQP+dNIUCq6c85nLZ6iM4Vu/h8leuz60uV8j3njPg1flSQQHjOawdTHwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746687272; c=relaxed/simple;
	bh=eRZIKtysuS6oTcrjeE85a1+Xwq0Zc6EtWiLFsCUxq20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDjecmCmr/WH9mEGasg71pS8Nx1yvnun0InMNQwXVQ2WqlC8KEovoIg9bKsXBgy/nKMntPHHYRgp2TLWPUeVRK/EeAqPl9lla/RusyvyFQQswslt7D5Q2K6BxRZqlvLSjZSW/GTc+5MvoD1hYp0g5j5HETA/pGxKqTQd19KUW9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ccndsvSv; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ccndsvSv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746687272; x=1778223272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eRZIKtysuS6oTcrjeE85a1+Xwq0Zc6EtWiLFsCUxq20=;
  b=ccndsvSvvu9PSlOKL16573hY9QpfCgyfX8tFjDCqItOn0loAw416PosA
   8doaatKMyoV9UmIlk7USWmeB5ZeyRNHe3TQrFZQBjk/CKCUlcAapmK50U
   G5lpwmLOLGFWtGFQNfn3Yh6hlPXtEr34sfm7t6s/H2eYkE2lPTPyPqC4W
   dJHVsvw9tdD9lK/p4CiwnH9rZo+CgI4Jn5l30DxqU1sQZS7vw2MBf0kR1
   Oyiv6MW/GzIu9OO22X/dIPX1tAiKSw5DaOSe+wfFGIcIbUqUn4bxX3l0x
   YDzfLRT0GJnXzkzkzq/Folzs0SPOUNuN8IzsvrmteIPck6UrjTmOp1vO+
   A==;
X-CSE-ConnectionGUID: ImxGJ9MBTZmvOn0yc7+4Aw==
X-CSE-MsgGUID: yTe75xBXQkCCAMmkL+zR5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="59441404"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="59441404"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 23:54:31 -0700
X-CSE-ConnectionGUID: zjAAhvi/SFCAlbDqxA/ZUQ==
X-CSE-MsgGUID: 9XKYUGeJRBOc703HN88BZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="137130582"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 07 May 2025 23:54:28 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCv9G-000Aip-0g;
	Thu, 08 May 2025 06:54:26 +0000
Date: Thu, 8 May 2025 14:54:25 +0800
From: kernel test robot <lkp@intel.com>
To: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yang Li <yang.li@amlogic.com>
Subject: Re: [PATCH] Bluetooth: fix socket matching ambiguity between BIS and
 CIS
Message-ID: <202505081427.1Y3wyo7v-lkp@intel.com>
References: <20250507-iso-v1-1-6f60d243e037@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507-iso-v1-1-6f60d243e037@amlogic.com>

Hi Yang,

kernel test robot noticed the following build errors:

[auto build test ERROR on f3daca9b490154fbb0459848cc2ed61e8367bddc]

url:    https://github.com/intel-lab-lkp/linux/commits/Yang-Li-via-B4-Relay/Bluetooth-fix-socket-matching-ambiguity-between-BIS-and-CIS/20250507-153347
base:   f3daca9b490154fbb0459848cc2ed61e8367bddc
patch link:    https://lore.kernel.org/r/20250507-iso-v1-1-6f60d243e037%40amlogic.com
patch subject: [PATCH] Bluetooth: fix socket matching ambiguity between BIS and CIS
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20250508/202505081427.1Y3wyo7v-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250508/202505081427.1Y3wyo7v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505081427.1Y3wyo7v-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/bluetooth/hci_event.c: In function 'hci_le_per_adv_report_evt':
>> net/bluetooth/hci_event.c:6469:60: error: 'ISO_LINK' undeclared (first use in this function); did you mean 'SCO_LINK'?
    6469 |         mask |= hci_proto_connect_ind(hdev, &pa_sync->dst, ISO_LINK, &flags);
         |                                                            ^~~~~~~~
         |                                                            SCO_LINK
   net/bluetooth/hci_event.c:6469:60: note: each undeclared identifier is reported only once for each function it appears in
   net/bluetooth/hci_event.c: In function 'hci_le_big_info_adv_report_evt':
   net/bluetooth/hci_event.c:7055:60: error: 'ISO_LINK' undeclared (first use in this function); did you mean 'SCO_LINK'?
    7055 |         mask |= hci_proto_connect_ind(hdev, &pa_sync->dst, ISO_LINK, &flags);
         |                                                            ^~~~~~~~
         |                                                            SCO_LINK


vim +6469 net/bluetooth/hci_event.c

  6449	
  6450	static void hci_le_per_adv_report_evt(struct hci_dev *hdev, void *data,
  6451					      struct sk_buff *skb)
  6452	{
  6453		struct hci_ev_le_per_adv_report *ev = data;
  6454		int mask = hdev->link_mode;
  6455		__u8 flags = 0;
  6456		struct hci_conn *pa_sync;
  6457	
  6458		bt_dev_dbg(hdev, "sync_handle 0x%4.4x", le16_to_cpu(ev->sync_handle));
  6459	
  6460		hci_dev_lock(hdev);
  6461	
  6462		pa_sync = hci_conn_hash_lookup_pa_sync_handle
  6463				(hdev,
  6464				le16_to_cpu(ev->sync_handle));
  6465	
  6466		if (!pa_sync)
  6467			goto unlock;
  6468	
> 6469		mask |= hci_proto_connect_ind(hdev, &pa_sync->dst, ISO_LINK, &flags);
  6470		if (!(mask & HCI_LM_ACCEPT))
  6471			goto unlock;
  6472	
  6473		if (!(flags & HCI_PROTO_DEFER))
  6474			goto unlock;
  6475	
  6476		if (ev->data_status == LE_PA_DATA_COMPLETE &&
  6477		    !test_and_set_bit(HCI_CONN_PA_SYNC, &pa_sync->flags)) {
  6478			/* Notify iso layer */
  6479			hci_connect_cfm(pa_sync, 0);
  6480	
  6481			/* Notify MGMT layer */
  6482			mgmt_device_connected(hdev, pa_sync, NULL, 0);
  6483		}
  6484	
  6485	unlock:
  6486		hci_dev_unlock(hdev);
  6487	}
  6488	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
