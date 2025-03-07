Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6A412C544
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Mar 2025 03:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741316858; cv=none; b=A0yqpoZHPuHNmddHey4719fd+HSseGdIeRIS9hbWHNEE7daNScvqyfbCKrGo6Hg1UDpJtbY62rviockVeyNDYlLJMn7d6IarjgcE2KQiJxizG5fGVRwzM5eCEsJiNH6+eIFP6Znd9ik/09O3UV+WOcncSSmnSm2+ne/sdejua48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741316858; c=relaxed/simple;
	bh=zBA/rve+OzwGglyw63IgF3tdc7F9t6iiAi0HAWHvJUg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JT+iWZYX/7tOXpcA+OknWTRvRmh5+akz102iiPgLga5j+5JtQWfU4vfTXIZ7jaywAO7Rq6CkAFK24DryhPsRuf25J+nIF7J+g7oYRXZD0tFg74YutPZ+ka2173kvIanU1xbHw1tuHuuJiA6oKxb/HEAi3Olb2zH4R3WwoB9Rz/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D78wdx6i; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D78wdx6i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741316856; x=1772852856;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zBA/rve+OzwGglyw63IgF3tdc7F9t6iiAi0HAWHvJUg=;
  b=D78wdx6ivk2GaO7zonl5BOu46SqN7p2aSHViTfSC/zL+QfvhveqFrK66
   eS2B3YousSsryMKma9qdpJgm5yUXt/SwdoOSznVBBsoLUgg1IVfL/vJoX
   W91moNrmMxqePAu4o41Yzl2krsxw/pOwoGLwaF85o0O7p5NmDd69x1cWW
   PYomxKStO5y5pZc1171fWMLcmDgWng2iQj+XVIiGzAclo/b2TGQrCwmoM
   v6FnsvsN1rzZ3AtgP/dA4K5C/msqTfrQufzTiDQ+hVtmmAMkwCjyNrCjL
   NuXRdJC2tIkYRWGVdr4OyG4OPakEJ/ubBevQb2uEbDlCh6pEd1ubrGUzn
   A==;
X-CSE-ConnectionGUID: JoQScj0MQCWwXzsLDaBhDA==
X-CSE-MsgGUID: sT57BBk5Q0e8ra06TsPkZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53754592"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="53754592"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 19:07:35 -0800
X-CSE-ConnectionGUID: gHEwxg6CSy+mUc6cC2igMw==
X-CSE-MsgGUID: d1iKPzCaTFCpnEkCkzKApA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="119204905"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 06 Mar 2025 19:07:33 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqO3f-000O7M-03;
	Fri, 07 Mar 2025 03:07:31 +0000
Date: Fri, 7 Mar 2025 11:07:29 +0800
From: kernel test robot <lkp@intel.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Johan Korsnes <johan.korsnes@remarkable.no>,
	Kristian Krohn <kristian.krohn@remarkable.no>
Subject: [bluetooth-next:master 42/43] drivers/bluetooth/btnxpuart.c:1322:36:
 error: 'skb' undeclared
Message-ID: <202503071045.5Ac2pLEW-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   8968f507940cad09c8e2ecc4631f90d62709e17b
commit: 228c506481ea3f6ac5538188517c4a6f9feb5a26 [42/43] Bluetooth: btnxpuart: Add support to set BD address
config: sh-randconfig-002-20250307 (https://download.01.org/0day-ci/archive/20250307/202503071045.5Ac2pLEW-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250307/202503071045.5Ac2pLEW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503071045.5Ac2pLEW-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/bluetooth/btnxpuart.c:21:
   drivers/bluetooth/btnxpuart.c: In function 'nxp_set_bdaddr':
>> drivers/bluetooth/btnxpuart.c:1322:36: error: 'skb' undeclared (first use in this function)
    1322 |                            PTR_ERR(skb));
         |                                    ^~~
   include/net/bluetooth/bluetooth.h:264:52: note: in definition of macro 'BT_ERR'
     264 | #define BT_ERR(fmt, ...)        bt_err(fmt "\n", ##__VA_ARGS__)
         |                                                    ^~~~~~~~~~~
   drivers/bluetooth/btnxpuart.c:1321:17: note: in expansion of macro 'bt_dev_err'
    1321 |                 bt_dev_err(hdev, "Reset before setting local-bd-addr failed (%ld)",
         |                 ^~~~~~~~~~
   drivers/bluetooth/btnxpuart.c:1322:36: note: each undeclared identifier is reported only once for each function it appears in
    1322 |                            PTR_ERR(skb));
         |                                    ^~~
   include/net/bluetooth/bluetooth.h:264:52: note: in definition of macro 'BT_ERR'
     264 | #define BT_ERR(fmt, ...)        bt_err(fmt "\n", ##__VA_ARGS__)
         |                                                    ^~~~~~~~~~~
   drivers/bluetooth/btnxpuart.c:1321:17: note: in expansion of macro 'bt_dev_err'
    1321 |                 bt_dev_err(hdev, "Reset before setting local-bd-addr failed (%ld)",
         |                 ^~~~~~~~~~
   drivers/bluetooth/btnxpuart.c: In function 'nxp_serdev_probe':
   drivers/bluetooth/btnxpuart.c:1724:15: error: 'struct hci_dev' has no member named 'cmd_timeout'; did you mean 'cmd_timer'?
    1724 |         hdev->cmd_timeout = nxp_cmd_timeout;
         |               ^~~~~~~~~~~
         |               cmd_timer
>> drivers/bluetooth/btnxpuart.c:1673:18: warning: unused variable 'ba' [-Wunused-variable]
    1673 |         bdaddr_t ba = {0};
         |                  ^~


vim +/skb +1322 drivers/bluetooth/btnxpuart.c

  1308	
  1309	static int nxp_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
  1310	{
  1311		union nxp_set_bd_addr_payload pcmd;
  1312		int err;
  1313	
  1314		pcmd.data.param_id = 0xfe;
  1315		pcmd.data.param_len = 6;
  1316		memcpy(pcmd.data.param, bdaddr, 6);
  1317	
  1318		/* BD address can be assigned only after first reset command. */
  1319		err = __hci_cmd_sync_status(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
  1320		if (err) {
  1321			bt_dev_err(hdev, "Reset before setting local-bd-addr failed (%ld)",
> 1322				   PTR_ERR(skb));
  1323			return err;
  1324		}
  1325	
  1326		err = __hci_cmd_sync_status(hdev, HCI_NXP_SET_BD_ADDR, sizeof(pcmd),
  1327				     pcmd.buf, HCI_CMD_TIMEOUT);
  1328		if (err) {
  1329			bt_dev_err(hdev, "Changing device address failed (%d)", err);
  1330			return err;
  1331		}
  1332	
  1333		return 0;
  1334	}
  1335	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
