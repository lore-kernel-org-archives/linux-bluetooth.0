Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890094;
	b=b9IFX5xLx2MRSTCLfICSnMyt4zUY2dM3aYqcJ9V4e6n7MnXFh+OoTC4lCYAFJGBi3QLA
	 fPbJaSGyxjwqxljWasvvqZ3dkUI9BCOQZE9KSc/s5CNxr/UsR1rkISrwbfPYgs+g8XI1L
	 FsWpM430d7pDU4NOjs5Rz8ZZymNxTeidg/sgxerobIoqu2TfRAbgukJelExQ36N7/c3Mm
	 uOW9LknGOdQiG6xLvk6ilIiuKCxzegkWOdSx0dzOOcCjGlNoNCMp8vdrpenWSzzhoorlj
	 Q/f5k7O4nOYF4NvODh8cMZmAenEPcr6BywvC9trU6UyADtq0LYQziAzO9VoqDqHwMYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890094;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=+KEO8mCidqSQviZa7+VsKyZl/2osmPqVxDkGw1K3410=;
	b=W908Bb85L+fY1+9VUpaC7Xto39s6MIXvyrsT8PMhxXy2wTSQSb8LdSKTV28x5ukoeikB
	 ArNtpo193CzRroIXCfRxwqVFJKx6lxL4mi0rXDAl2b8o9SvnVPEaSzBcYdg43oizr4PEz
	 m33qeJMmb64pbHjOZ12PB5Z+noRZWEK5/k4MJ1eU18mx4diamh8NtXChaXZZu+ESxWWNE
	 RS8hD2ougnwb0gFjWsyDJMfvR9kTeuSz49lUgHtPfz88yeZse7Ok+udXapCKWfoSHTIvn
	 pEs709PwBWr8TIy7G+Gd0sFnCzHxskB9+lh+bAhohlB7/oVXZKLTk2ZaV9sOzZQTYGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LZW6tDxs;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9881E606A31B
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 14:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9881E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LZW6tDxs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793890094; x=1825426094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LcqnTFFjXD7S999oBGGwZsDLxCeSNRsnNa/cTmTmO2w=;
  b=LZW6tDxsZvV2oFvfh1eubyYgXK5Iy7deCVVBqN5Qt+9PUjRr+qrxWkG/
   YuD0ubFqkKF9ifiXlSkuuVJ/7KG5m9hOFZvEx7bJjMn8b8cktrzp34K61
   KPZRCC/kh49189DYMHF+MV9xIcakk+AD3QiciuJE/7XrRvtFw0CHfLBaB
   Dfdn1ltOA+GjuQ1KyxJUBe8ttZ8j4UDxHuOxMabpp/0zzU+gteL8+asE9
   EQP7VgU2r0vF9NdTNVEw6MzK2OjB5yprinxoBumN9tn1HKINYj3fAnsgg
   rYvIv1/adoiyKEnMlHdp1SKkb39OtqEBs6yZnO52GfxxuLC8r19K283B1
   g==;
X-CSE-ConnectionGUID: FUMUKILNS8qjjVDubBhFLg==
X-CSE-MsgGUID: zPE2k8VzQV6FavBQVfoGHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2674334"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2674334"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 06:48:13 -0800
X-CSE-ConnectionGUID: r9Olhf3/Re6x1iMuA+Petg==
X-CSE-MsgGUID: sznsQMtNSRayjim39ZIgFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7033010"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 05 Nov 2026 06:48:11 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xOyl7-00000000mL7-1mJF;
	Thu, 05 Nov 2026 14:48:09 +0000
Date: Thu, 5 Nov 2026 22:47:14 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 6/6] Bluetooth: Add EKS Opportunistic Encryption
 support
Message-ID: <202611052210.pgQkfWp2-lkp@intel.com>
References: <20261104221321.1200529-7-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104221321.1200529-7-luiz.dentz@gmail.com>

Hi Luiz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on bluetooth/master]
[cannot apply to linus/master v7.3 next-20261030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luiz-Augusto-von-Dentz/Bluetooth-Add-initial-support-for-HDT-PHY/20261104-171316
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20261104221321.1200529-7-luiz.dentz%40gmail.com
patch subject: [PATCH v3 6/6] Bluetooth: Add EKS Opportunistic Encryption support
config: arm-defconfig (https://download.01.org/0day-ci/archive/20261105/202611052210.pgQkfWp2-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 812626a41399a1d464a0d69627ab45c83b8ebfb9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261105/202611052210.pgQkfWp2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611052210.pgQkfWp2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/bluetooth/hci_sync.c:8779:6: warning: calling function 'smp_pairing_in_progress' requires holding mutex 'hci_conn_hash_lookup_handle(hdev, data->handle)->hdev->lock' exclusively [-Wthread-safety-precise]
    8779 |         if (smp_pairing_in_progress(conn)) {
         |             ^
   net/bluetooth/hci_sync.c:8779:6: note: found near match 'hdev->lock'
   1 warning generated.


vim +8779 net/bluetooth/hci_sync.c

  8754	
  8755	/* The opportunistic encryption is queued when the connection is set up, so
  8756	 * by the time it runs the connection may be gone, already encrypted, have
  8757	 * SMP encryption pending or SMP pairing in progress, so check again right
  8758	 * before sending the command and leave the link to SMP in those cases.
  8759	 *
  8760	 * HCI_CONN_OPP_ENCRYPT, without HCI_CONN_ENCRYPT, marks the request in
  8761	 * flight. HCI_CONN_ENCRYPT_PEND is not used for it, so SMP is not blocked
  8762	 * by it: SMP pairing over a link being encrypted works, and the encryption
  8763	 * started by SMP afterwards replaces the opportunistic key.
  8764	 */
  8765	static int hci_le_eks_oppt_encrypt_sync(struct hci_dev *hdev, void *data)
  8766	{
  8767		struct hci_cp_le_enable_encrypt_v2 *cp = data;
  8768		struct hci_conn *conn;
  8769		int err;
  8770	
  8771		hci_dev_lock(hdev);
  8772	
  8773		conn = hci_conn_hash_lookup_handle(hdev, le16_to_cpu(cp->handle));
  8774		if (!conn || conn->state != BT_CONNECTED ||
  8775		    test_bit(HCI_CONN_ENCRYPT, conn->flags) ||
  8776		    test_bit(HCI_CONN_ENCRYPT_PEND, conn->flags))
  8777			goto unlock;
  8778	
> 8779		if (smp_pairing_in_progress(conn)) {
  8780			bt_dev_dbg(hdev, "SMP in progress, skipping hcon %p", conn);
  8781			goto unlock;
  8782		}
  8783	
  8784		if (test_and_set_bit(HCI_CONN_OPP_ENCRYPT, conn->flags))
  8785			goto unlock;
  8786	
  8787		/* Use the MIC length requested by now, or the default one if unset */
  8788		cp->mic_len = conn->req_mic_len ? conn->req_mic_len :
  8789						  hdev->hdt_def_mic_len;
  8790	
  8791		bt_dev_dbg(hdev, "starting EKS opportunistic encryption hcon %p", conn);
  8792	
  8793		hci_dev_unlock(hdev);
  8794	
  8795		err = hci_le_enable_encrypt_v2_sync(hdev, data);
  8796		if (!err)
  8797			return 0;
  8798	
  8799		/* No result will come for a command that was not sent or failed */
  8800		hci_dev_lock(hdev);
  8801	
  8802		conn = hci_conn_hash_lookup_handle(hdev, le16_to_cpu(cp->handle));
  8803		if (conn && !test_bit(HCI_CONN_ENCRYPT, conn->flags))
  8804			clear_bit(HCI_CONN_OPP_ENCRYPT, conn->flags);
  8805	
  8806		hci_dev_unlock(hdev);
  8807	
  8808		return err;
  8809	
  8810	unlock:
  8811		hci_dev_unlock(hdev);
  8812		return 0;
  8813	}
  8814	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
