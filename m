Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C78A1BDC8
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 22:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715379159; cv=none; b=F6HThTGaS7HhiulfGA8XOiBoNUKVPYC0rEstAv5TDl9lvscsMpd3kkNIYKZ6gyy8k2MmxaCPIBAmNsPYI/J6QOgEx5qrF4I94rebozjcj9Eot2LmGTauww/zPgdK3j3PSWJjUP9O7aH/FKtpA9WSlXpbruYmLbERr1aoSGWxB9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715379159; c=relaxed/simple;
	bh=CBjw0RHx7SJF0qYeY7R/Dmz9Bf+XASAExiSRT3ukPDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBiVGIP72k9MBCn+2X/OH4oH1e2ivZIULsxWAxak5acddhEToJxkY7pNd6EYNq9NGWC6iUVeKD3ih8B8KFnrdcGk2VuZscqeSzAdiJxlI9dEKQpitpjpXZDNCLRi336Rv+KQNzZ8+kPF8BKlpOiBTnBMqVo98pCy5vVm2RieHnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E0XAdk21; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E0XAdk21"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715379156; x=1746915156;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CBjw0RHx7SJF0qYeY7R/Dmz9Bf+XASAExiSRT3ukPDc=;
  b=E0XAdk21EcQgI49qVdZgMm00wOpJ0tKlUVu/SHLc4d5jYndzm8inl5f4
   xI1h+yHOLV5f0gN77rrJFTs1AEzGtUvEfjZsj8t0Q3o7lcEhlqOAebL2I
   Fp8bWb2obqcoRNDPGA77uzS0BE3HakdnVcq8sXMOgRYqV+4MC7nysYJl3
   lT0rAbdO1+yRZ085JfmU1Z6//dFinykwtXUyu96tHEj8hdSkrCaYz5D4T
   R0MKYawfJf3hRzuHk2q5YH9ZRWeGMie7oIFaJ7mmREhTeBaJD/HnpBJsP
   YrFlqG3UKQiT77dCyzfxncoxp55zYF3yD/xqeUIZ5N3T2xaa2IAdyzNfF
   w==;
X-CSE-ConnectionGUID: ca0hsmR+Qk6gGLpsDAlCYA==
X-CSE-MsgGUID: dFq/Qhq7TT6pr1WOpbKJ+g==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="15213769"
X-IronPort-AV: E=Sophos;i="6.08,152,1712646000"; 
   d="scan'208";a="15213769"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 15:12:36 -0700
X-CSE-ConnectionGUID: jaMgVNYZTUeEsCdt9MhDLw==
X-CSE-MsgGUID: xU/PrQDkSCC6cA4UdFZ2Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,152,1712646000"; 
   d="scan'208";a="29755742"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 10 May 2024 15:12:34 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5YTg-0006cv-1B;
	Fri, 10 May 2024 22:12:32 +0000
Date: Sat, 11 May 2024 06:11:41 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3] Bluetooth: MGMT: Make MGMT_OP_LOAD_CONN_PARAM update
 existing connection
Message-ID: <202405110542.nDEonveB-lkp@intel.com>
References: <20240510143645.1408056-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510143645.1408056-1-luiz.dentz@gmail.com>

Hi Luiz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on bluetooth/master linus/master v6.9-rc7 next-20240510]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luiz-Augusto-von-Dentz/Bluetooth-MGMT-Make-MGMT_OP_LOAD_CONN_PARAM-update-existing-connection/20240510-223834
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20240510143645.1408056-1-luiz.dentz%40gmail.com
patch subject: [PATCH v3] Bluetooth: MGMT: Make MGMT_OP_LOAD_CONN_PARAM update existing connection
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240511/202405110542.nDEonveB-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240511/202405110542.nDEonveB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405110542.nDEonveB-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/bluetooth/mgmt.c:7922:6: warning: variable 'i' is uninitialized when used here [-Wuninitialized]
           if (i > 1)
               ^
   net/bluetooth/mgmt.c:7896:7: note: initialize the variable 'i' to silence this warning
           int i;
                ^
                 = 0
   1 warning generated.


vim +/i +7922 net/bluetooth/mgmt.c

  7888	
  7889	static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
  7890				   u16 len)
  7891	{
  7892		struct mgmt_cp_load_conn_param *cp = data;
  7893		const u16 max_param_count = ((U16_MAX - sizeof(*cp)) /
  7894					     sizeof(struct mgmt_conn_param));
  7895		u16 param_count, expected_len;
  7896		int i;
  7897	
  7898		if (!lmp_le_capable(hdev))
  7899			return mgmt_cmd_status(sk, hdev->id, MGMT_OP_LOAD_CONN_PARAM,
  7900					       MGMT_STATUS_NOT_SUPPORTED);
  7901	
  7902		param_count = __le16_to_cpu(cp->param_count);
  7903		if (param_count > max_param_count) {
  7904			bt_dev_err(hdev, "load_conn_param: too big param_count value %u",
  7905				   param_count);
  7906			return mgmt_cmd_status(sk, hdev->id, MGMT_OP_LOAD_CONN_PARAM,
  7907					       MGMT_STATUS_INVALID_PARAMS);
  7908		}
  7909	
  7910		expected_len = struct_size(cp, params, param_count);
  7911		if (expected_len != len) {
  7912			bt_dev_err(hdev, "load_conn_param: expected %u bytes, got %u bytes",
  7913				   expected_len, len);
  7914			return mgmt_cmd_status(sk, hdev->id, MGMT_OP_LOAD_CONN_PARAM,
  7915					       MGMT_STATUS_INVALID_PARAMS);
  7916		}
  7917	
  7918		bt_dev_dbg(hdev, "param_count %u", param_count);
  7919	
  7920		hci_dev_lock(hdev);
  7921	
> 7922		if (i > 1)
  7923			hci_conn_params_clear_disabled(hdev);
  7924	
  7925		for (i = 0; i < param_count; i++) {
  7926			struct mgmt_conn_param *param = &cp->params[i];
  7927			struct hci_conn_params *hci_param;
  7928			u16 min, max, latency, timeout;
  7929			u8 addr_type;
  7930			bool update;
  7931	
  7932			bt_dev_dbg(hdev, "Adding %pMR (type %u)", &param->addr.bdaddr,
  7933				   param->addr.type);
  7934	
  7935			if (param->addr.type == BDADDR_LE_PUBLIC) {
  7936				addr_type = ADDR_LE_DEV_PUBLIC;
  7937			} else if (param->addr.type == BDADDR_LE_RANDOM) {
  7938				addr_type = ADDR_LE_DEV_RANDOM;
  7939			} else {
  7940				bt_dev_err(hdev, "ignoring invalid connection parameters");
  7941				continue;
  7942			}
  7943	
  7944			min = le16_to_cpu(param->min_interval);
  7945			max = le16_to_cpu(param->max_interval);
  7946			latency = le16_to_cpu(param->latency);
  7947			timeout = le16_to_cpu(param->timeout);
  7948	
  7949			bt_dev_dbg(hdev, "min 0x%04x max 0x%04x latency 0x%04x timeout 0x%04x",
  7950				   min, max, latency, timeout);
  7951	
  7952			if (hci_check_conn_params(min, max, latency, timeout) < 0) {
  7953				bt_dev_err(hdev, "ignoring invalid connection parameters");
  7954				continue;
  7955			}
  7956	
  7957			/* Detect when the loading is for an existing parameter then
  7958			 * attempt to trigger the connection update procedure.
  7959			 */
  7960			if (!i && param_count == 1) {
  7961				hci_param = hci_conn_params_lookup(hdev,
  7962								   &param->addr.bdaddr,
  7963								   addr_type);
  7964				if (hci_param)
  7965					update = true;
  7966				else
  7967					hci_conn_params_clear_disabled(hdev);
  7968			}
  7969	
  7970			hci_param = hci_conn_params_add(hdev, &param->addr.bdaddr,
  7971							addr_type);
  7972			if (!hci_param) {
  7973				bt_dev_err(hdev, "failed to add connection parameters");
  7974				continue;
  7975			}
  7976	
  7977			hci_param->conn_min_interval = min;
  7978			hci_param->conn_max_interval = max;
  7979			hci_param->conn_latency = latency;
  7980			hci_param->supervision_timeout = timeout;
  7981	
  7982			if (update) {
  7983				struct hci_conn *conn;
  7984	
  7985				conn = hci_conn_hash_lookup_le(hdev, &hci_param->addr,
  7986							       addr_type);
  7987				if (conn && conn->role == HCI_ROLE_MASTER &&
  7988				    (conn->le_conn_min_interval != min ||
  7989				     conn->le_conn_max_interval != max ||
  7990				     conn->le_conn_latency != latency ||
  7991				     conn->le_supv_timeout != timeout))
  7992					hci_cmd_sync_queue(hdev, conn_update_sync,
  7993							   hci_param, NULL);
  7994			}
  7995		}
  7996	
  7997		hci_dev_unlock(hdev);
  7998	
  7999		return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_LOAD_CONN_PARAM, 0,
  8000					 NULL, 0);
  8001	}
  8002	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
