Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD51EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Dec 2021 06:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240264AbhLHGhD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Dec 2021 01:37:03 -0500
Received: from mga14.intel.com ([192.55.52.115]:51906 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235346AbhLHGhC (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Dec 2021 01:37:02 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="237994724"
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="237994724"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 22:33:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="462649131"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 07 Dec 2021 22:33:28 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muqW8-0000AR-22; Wed, 08 Dec 2021 06:33:28 +0000
Date:   Wed, 8 Dec 2021 14:32:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH] Bluetooth: hci_sync: Add hci_le_create_conn_sync
Message-ID: <202112081458.7Shk6qTD-lkp@intel.com>
References: <20211208020553.219387-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208020553.219387-1-luiz.dentz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

I love your patch! Perhaps something to improve:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on next-20211207]
[cannot apply to bluetooth/master v5.16-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Luiz-Augusto-von-Dentz/Bluetooth-hci_sync-Add-hci_le_create_conn_sync/20211208-100714
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
config: arc-buildonly-randconfig-r002-20211207 (https://download.01.org/0day-ci/archive/20211208/202112081458.7Shk6qTD-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/edb4c612dda2cb67f35cfe5a1c3bd0b38918aa80
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Luiz-Augusto-von-Dentz/Bluetooth-hci_sync-Add-hci_le_create_conn_sync/20211208-100714
        git checkout edb4c612dda2cb67f35cfe5a1c3bd0b38918aa80
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash net/bluetooth/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/bluetooth/hci_sync.c:5120:5: warning: no previous prototype for 'hci_le_ext_create_conn_sync' [-Wmissing-prototypes]
    5120 | int hci_le_ext_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/hci_le_ext_create_conn_sync +5120 net/bluetooth/hci_sync.c

  5119	
> 5120	int hci_le_ext_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn,
  5121					u8 own_addr_type)
  5122	{
  5123		struct hci_cp_le_ext_create_conn *cp;
  5124		struct hci_cp_le_ext_conn_param *p;
  5125		u8 data[sizeof(*cp) + sizeof(*p) * 3];
  5126		u32 plen;
  5127	
  5128		cp = (void *) data;
  5129		p = (void *) cp->data;
  5130	
  5131		memset(cp, 0, sizeof(*cp));
  5132	
  5133		bacpy(&cp->peer_addr, &conn->dst);
  5134		cp->peer_addr_type = conn->dst_type;
  5135		cp->own_addr_type = own_addr_type;
  5136	
  5137		plen = sizeof(*cp);
  5138	
  5139		if (scan_1m(hdev)) {
  5140			cp->phys |= LE_SCAN_PHY_1M;
  5141			set_ext_conn_params(conn, p);
  5142	
  5143			p++;
  5144			plen += sizeof(*p);
  5145		}
  5146	
  5147		if (scan_2m(hdev)) {
  5148			cp->phys |= LE_SCAN_PHY_2M;
  5149			set_ext_conn_params(conn, p);
  5150	
  5151			p++;
  5152			plen += sizeof(*p);
  5153		}
  5154	
  5155		if (scan_coded(hdev)) {
  5156			cp->phys |= LE_SCAN_PHY_CODED;
  5157			set_ext_conn_params(conn, p);
  5158	
  5159			plen += sizeof(*p);
  5160		}
  5161	
  5162		return __hci_cmd_sync_status(hdev, HCI_OP_LE_EXT_CREATE_CONN,
  5163					     plen, data, HCI_CMD_TIMEOUT);
  5164	}
  5165	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
