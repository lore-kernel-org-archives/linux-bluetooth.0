Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83DF22579B;
	Fri, 30 May 2025 11:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748605819; cv=none; b=YXJZWaBu4ecSDUnS/0RPUV/DVAA28znB0TfJ969WGQrbzfTrUEh7Bekc+aaMoxQcYQCYk33QF2jn2Gbz6loYGGTXIlIzUeEsB4VecvDsWb1VZG4X375R/LloYU4hPfv7WO5pDgChSxccZIhaPEABDHKRmjjyrCY5knnWrb+2tuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748605819; c=relaxed/simple;
	bh=fz3ZQSWr7CY1akxZLr471YVGDzGqo++bGWSlgdU6ahw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7x2oyhduiHEVSZg//1S5nWsi53Xvivml/XbwTkfp0jn91eWuuL36AhbCdC3i7QRfwBvq3MSf09gHZ0ktLJIqRBh+OSV7XNheOpHhttaTnOfqRDSz02BcDNekyB1Ok39dfwS9+rGY1JH+2PU4V9LtsSyuuArqo8xnLhiA6t+LjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ePLDMET0; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ePLDMET0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748605818; x=1780141818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fz3ZQSWr7CY1akxZLr471YVGDzGqo++bGWSlgdU6ahw=;
  b=ePLDMET0IoI8Ue0dAHLJUJQx3aqTnlFFryrDrdvP7jdfd0ikCVfrZfAI
   jvYStHp8H4+j3QCyURZaS9JXC3uYeI92DZdbN3oSnnLD/Yfwwthb5NEZU
   Lo3Y7l3MzTxxG+9mTj6q6/mS+7GOgoNVQyIaK1maGUYvMfMIpGonI+eSw
   Z83VvsojGz6QJM1ruELKsXvnszJ10lXu4LgySgQdWlMIbu+Xo45LwGdao
   HK0CJCDkkH1ofRZZa1+cSejBvPQp9t01iL3XAojMTcFEbltZF+6nvXro5
   ulGWjHj+PZe7Gd3YLWo/3dRHJdZp16dXgnOOAQaBkiGEwYUkbZiNeqUdc
   Q==;
X-CSE-ConnectionGUID: FuSBA4z2QIaF58kaVpX9PQ==
X-CSE-MsgGUID: Liy4hCN7TQqbwgFi/Bzgyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="50565722"
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; 
   d="scan'208";a="50565722"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 04:50:15 -0700
X-CSE-ConnectionGUID: Mdc9ZpEFTCq33nDfnQxj5g==
X-CSE-MsgGUID: Gu9Gr+uqRoC3L7F7Kr3HGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; 
   d="scan'208";a="174858935"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 30 May 2025 04:50:11 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKyFV-000Xbw-1S;
	Fri, 30 May 2025 11:50:09 +0000
Date: Fri, 30 May 2025 19:49:28 +0800
From: kernel test robot <lkp@intel.com>
To: Hilda Wu <hildawu@realtek.com>, marcel@holtmann.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, max.chou@realtek.com,
	alex_lu@realsil.com.cn
Subject: Re: [PATCH 2/2] Bluetooth: btrtl: Add enhanced download support
Message-ID: <202505301910.8q5W0vf5-lkp@intel.com>
References: <20250529124816.4186320-3-hildawu@realtek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529124816.4186320-3-hildawu@realtek.com>

Hi Hilda,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on bluetooth-next/master linus/master v6.15 next-20250530]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hilda-Wu/Bluetooth-btrtl-Firmware-format-v3-support/20250529-205020
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20250529124816.4186320-3-hildawu%40realtek.com
patch subject: [PATCH 2/2] Bluetooth: btrtl: Add enhanced download support
config: i386-buildonly-randconfig-004-20250530 (https://download.01.org/0day-ci/archive/20250530/202505301910.8q5W0vf5-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250530/202505301910.8q5W0vf5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505301910.8q5W0vf5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/bluetooth/btrtl.c:1339:7: warning: format specifies type 'unsigned long' but the argument has type 'unsigned int' [-Wformat]
    1338 |                 bt_dev_err(hdev, "got invalid cmd complete, %u %lu", skb->len,
         |                                                                ~~~
         |                                                                %u
    1339 |                            sizeof(*ev));
         |                            ^~~~~~~~~~~
   include/net/bluetooth/bluetooth.h:280:42: note: expanded from macro 'bt_dev_err'
     280 |         BT_ERR("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
         |                       ~~~                       ^~~~~~~~~~~
   include/net/bluetooth/bluetooth.h:265:45: note: expanded from macro 'BT_ERR'
     265 | #define BT_ERR(fmt, ...)        bt_err(fmt "\n", ##__VA_ARGS__)
         |                                        ~~~         ^~~~~~~~~~~
   drivers/bluetooth/btrtl.c:2071:1: error: function definition is not allowed here
    2071 | {
         | ^
   drivers/bluetooth/btrtl.c:2113:1: error: function definition is not allowed here
    2113 | {
         | ^
   drivers/bluetooth/btrtl.c:2172:1: error: function definition is not allowed here
    2172 | {
         | ^
   drivers/bluetooth/btrtl.c:2199:1: error: function definition is not allowed here
    2199 | {
         | ^
   drivers/bluetooth/btrtl.c:2219:1: error: function definition is not allowed here
    2219 | {
         | ^
   drivers/bluetooth/btrtl.c:2246:1: error: function definition is not allowed here
    2246 | {
         | ^
   drivers/bluetooth/btrtl.c:2286:1: error: function definition is not allowed here
    2286 | {
         | ^
   drivers/bluetooth/btrtl.c:2404:48: error: expected '}'
    2404 | MODULE_FIRMWARE("rtl_bt/rtl8922au_config.bin");
         |                                                ^
   drivers/bluetooth/btrtl.c:1878:1: note: to match this '{'
    1878 | {
         | ^
   1 warning and 8 errors generated.


vim +1339 drivers/bluetooth/btrtl.c

  1322	
  1323	static int btrtl_enhanced_download_mode_enable(struct hci_dev *hdev,
  1324						struct btrtl_device_info *btrtl_dev)
  1325	{
  1326		struct hci_rp_enhanced_download_mode *ev;
  1327		struct sk_buff *skb;
  1328		u16 opcode = 0xfc1f;
  1329		u8 val = 1;
  1330		int ret = -EINVAL;
  1331	
  1332		skb = __hci_cmd_sync(hdev, opcode, 1, &val, HCI_CMD_TIMEOUT);
  1333		if (IS_ERR(skb)) {
  1334			bt_dev_err(hdev, "send %04x error (%lu)", opcode, PTR_ERR(skb));
  1335			return -EIO;
  1336		}
  1337		if (skb->len != sizeof(*ev)) {
  1338			bt_dev_err(hdev, "got invalid cmd complete, %u %lu", skb->len,
> 1339				   sizeof(*ev));
  1340			goto err;
  1341		}
  1342		ev = (struct hci_rp_enhanced_download_mode *)skb->data;
  1343		if (ev->status) {
  1344			bt_dev_err(hdev, "got invalid status 0x%02x", ev->status);
  1345			goto err;
  1346		}
  1347		btrtl_dev->handle = le16_to_cpu(ev->handle);
  1348		btrtl_dev->acldata_pkt_len = le16_to_cpu(ev->acldata_pkt_len);
  1349		kfree_skb(skb);
  1350	
  1351		bt_dev_info(hdev, "enhanced download mode enabled, handle %04x, acl %u",
  1352			    btrtl_dev->handle, btrtl_dev->acldata_pkt_len);
  1353	
  1354		return 0;
  1355	err:
  1356		kfree_skb(skb);
  1357		return ret;
  1358	}
  1359	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
