Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29E1C6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 19 Mar 2023 04:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjCSEvG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 19 Mar 2023 00:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjCSEvF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 19 Mar 2023 00:51:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7ED76BE
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Mar 2023 21:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679201464; x=1710737464;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AztZtCPUy+yp3fx9qFcyEf6ymo4tR3urJ+pX2tb/2tk=;
  b=Vq54BD+1uZ9frNdR50TD0Uz4SPkKVgpcXoFFl61vKPpIOKAjUDJgNLvh
   R1dIDjgY69x7eh3P1eBVhum5jyy/Gr4RMiPmBtZ4GSV99fXEYhz+6L/fA
   Vgi4hya34g0lhC0rBhv6PeP8hFw5nxPr/HExSXpcAR9Whqg+XGAhzy5Gq
   wKEQ7OhvrYYSXw8VXR+5mZjrOfOAz1ufTQN81MozFPnRR/sEo7eqbi+NU
   dt7qR0qImJoUWnl148yLB9yjYEwhdycCjdZedZH3YI/aosJHqCeS5u7vK
   arSrFA3txWwZMDInTuPE1+t3T9notNxXSBy2Xwdxe2HM6e0ht6sOf6EKQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="340839422"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="340839422"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 21:51:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="926587152"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="926587152"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 18 Mar 2023 21:51:01 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdl0X-000AP2-0R;
        Sun, 19 Mar 2023 04:51:01 +0000
Date:   Sun, 19 Mar 2023 12:50:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [bluetooth-next:master 57/57] drivers/bluetooth/btnxpuart.c:844:36:
 sparse: sparse: incorrect type in argument 3 (different base types)
Message-ID: <202303191207.FqEn5Fdd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   3e662aa4453a38568731c6319319a3a85e2f2f96
commit: 3e662aa4453a38568731c6319319a3a85e2f2f96 [57/57] Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets
config: arm64-randconfig-s052-20230319 (https://download.01.org/0day-ci/archive/20230319/202303191207.FqEn5Fdd-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=3e662aa4453a38568731c6319319a3a85e2f2f96
        git remote add bluetooth-next https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
        git fetch --no-tags bluetooth-next master
        git checkout 3e662aa4453a38568731c6319319a3a85e2f2f96
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/bluetooth/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303191207.FqEn5Fdd-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/bluetooth/btnxpuart.c:681:23: sparse: sparse: restricted __le16 degrades to integer
   drivers/bluetooth/btnxpuart.c:690:82: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned short [usertype] req_len @@     got restricted __le16 [usertype] len @@
   drivers/bluetooth/btnxpuart.c:690:82: sparse:     expected unsigned short [usertype] req_len
   drivers/bluetooth/btnxpuart.c:690:82: sparse:     got restricted __le16 [usertype] len
   drivers/bluetooth/btnxpuart.c:694:84: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned short [usertype] req_len @@     got restricted __le16 [usertype] len @@
   drivers/bluetooth/btnxpuart.c:694:84: sparse:     expected unsigned short [usertype] req_len
   drivers/bluetooth/btnxpuart.c:694:84: sparse:     got restricted __le16 [usertype] len
   drivers/bluetooth/btnxpuart.c:708:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] requested_len @@     got restricted __le16 [usertype] len @@
   drivers/bluetooth/btnxpuart.c:708:23: sparse:     expected unsigned int [usertype] requested_len
   drivers/bluetooth/btnxpuart.c:708:23: sparse:     got restricted __le16 [usertype] len
   drivers/bluetooth/btnxpuart.c:787:78: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned short [usertype] chipid @@     got restricted __le16 [usertype] chip_id @@
   drivers/bluetooth/btnxpuart.c:787:78: sparse:     expected unsigned short [usertype] chipid
   drivers/bluetooth/btnxpuart.c:787:78: sparse:     got restricted __le16 [usertype] chip_id
   drivers/bluetooth/btnxpuart.c:810:74: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned short [usertype] req_len @@     got restricted __le16 [usertype] len @@
   drivers/bluetooth/btnxpuart.c:810:74: sparse:     expected unsigned short [usertype] req_len
   drivers/bluetooth/btnxpuart.c:810:74: sparse:     got restricted __le16 [usertype] len
   drivers/bluetooth/btnxpuart.c:815:76: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned short [usertype] req_len @@     got restricted __le16 [usertype] len @@
   drivers/bluetooth/btnxpuart.c:815:76: sparse:     expected unsigned short [usertype] req_len
   drivers/bluetooth/btnxpuart.c:815:76: sparse:     got restricted __le16 [usertype] len
   drivers/bluetooth/btnxpuart.c:834:16: sparse: sparse: restricted __le32 degrades to integer
   drivers/bluetooth/btnxpuart.c:843:55: sparse: sparse: restricted __le32 degrades to integer
>> drivers/bluetooth/btnxpuart.c:844:36: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long [usertype] @@     got restricted __le16 [usertype] len @@
   drivers/bluetooth/btnxpuart.c:844:36: sparse:     expected unsigned long [usertype]
   drivers/bluetooth/btnxpuart.c:844:36: sparse:     got restricted __le16 [usertype] len

vim +844 drivers/bluetooth/btnxpuart.c

   794	
   795	static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
   796	{
   797		struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
   798		struct v3_data_req *req;
   799	
   800		if (!process_boot_signature(nxpdev))
   801			goto free_skb;
   802	
   803		req = (struct v3_data_req *)skb_pull_data(skb, sizeof(struct v3_data_req));
   804		if (!req || !nxpdev->fw)
   805			goto free_skb;
   806	
   807		nxp_send_ack(NXP_ACK_V3, hdev);
   808	
   809		if (!nxpdev->timeout_changed) {
   810			nxpdev->timeout_changed = nxp_fw_change_timeout(hdev, req->len);
   811			goto free_skb;
   812		}
   813	
   814		if (!nxpdev->baudrate_changed) {
   815			nxpdev->baudrate_changed = nxp_fw_change_baudrate(hdev, req->len);
   816			if (nxpdev->baudrate_changed) {
   817				serdev_device_set_baudrate(nxpdev->serdev,
   818							   HCI_NXP_SEC_BAUDRATE);
   819				serdev_device_set_flow_control(nxpdev->serdev, 1);
   820				nxpdev->current_baudrate = HCI_NXP_SEC_BAUDRATE;
   821			}
   822			goto free_skb;
   823		}
   824	
   825		if (req->len == 0) {
   826			bt_dev_dbg(hdev, "FW Downloaded Successfully: %zu bytes", nxpdev->fw->size);
   827			clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
   828			wake_up_interruptible(&nxpdev->fw_dnld_done_wait_q);
   829			goto free_skb;
   830		}
   831		if (req->error)
   832			bt_dev_dbg(hdev, "FW Download received err 0x%02x from chip", req->error);
   833	
   834		if (req->offset < nxpdev->fw_v3_offset_correction) {
   835			/* This scenario should ideally never occur. But if it ever does,
   836			 * FW is out of sync and needs a power cycle.
   837			 */
   838			bt_dev_err(hdev, "Something went wrong during FW download. Please power cycle and try again");
   839			goto free_skb;
   840		}
   841	
   842		serdev_device_write_buf(nxpdev->serdev,
   843					nxpdev->fw->data + req->offset - nxpdev->fw_v3_offset_correction,
 > 844					req->len);
   845	
   846	free_skb:
   847		kfree_skb(skb);
   848		return 0;
   849	}
   850	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
