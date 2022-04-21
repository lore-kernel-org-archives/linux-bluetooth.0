Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221D2C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Apr 2022 06:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376315AbiDUGsP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Apr 2022 02:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385402AbiDUGrs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Apr 2022 02:47:48 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AF8110F
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Apr 2022 23:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523493; x=1682059493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NaDAyaqFVN3Q0DIBHztqleUCRttZ7Oxt3AQT71CDTCI=;
  b=H5gBtgO4eFMY6bZZ/qRXFvnqU9f4rTL4qOoxVbROulROhm+S71VoAhv7
   7MIaZ0cW2a+xXqJy1Zaj4tIdQFjZU7RN2c3Hp0WD1JcZ6Itd2YHkmTFVN
   aZCLizDDehfZPi+Dotaybbcm9IHvanKyYED7ealX8NHLI5K/8TH71hr/K
   OndKEDqmSJokuQ56pVsdT7aWjz2HNTVoX0UCCb5QLjvU0cI/aPFSTXtDN
   C9L9Qt5PLnI5ogGmSjJJVWmUF9yKoH34ik3o74uOWCxcsROzMwfdefZvH
   9Wy1whAEWMBYNeEnsphYPEfT3ypmq+C7uDzchNcJOJW5o9iJcZxk2clOG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="244190279"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="244190279"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:44:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="510918950"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 20 Apr 2022 23:44:52 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQYd-00081b-B3;
        Thu, 21 Apr 2022 06:44:51 +0000
Date:   Thu, 21 Apr 2022 14:43:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH] Bluetooth: hci_event: Fix checking for invalid handle on
 error status
Message-ID: <202204210838.G9CZnn9u-lkp@intel.com>
References: <20220420221433.2933868-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420221433.2933868-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

I love your patch! Yet something to improve:

[auto build test ERROR on bluetooth-next/master]
[also build test ERROR on linus/master v5.18-rc3 next-20220420]
[cannot apply to bluetooth/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Luiz-Augusto-von-Dentz/Bluetooth-hci_event-Fix-checking-for-invalid-handle-on-error-status/20220421-061600
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
config: riscv-randconfig-r042-20220420 (https://download.01.org/0day-ci/archive/20220421/202204210838.G9CZnn9u-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/91a252b91692543d5f9536ebdf10f20a413a858f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Luiz-Augusto-von-Dentz/Bluetooth-hci_event-Fix-checking-for-invalid-handle-on-error-status/20220421-061600
        git checkout 91a252b91692543d5f9536ebdf10f20a413a858f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash net/bluetooth/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> net/bluetooth/hci_event.c:3071:7: error: use of undeclared identifier 'status'
           if (!status && __le16_to_cpu(ev->handle) > HCI_CONN_HANDLE_MAX) {
                ^
   net/bluetooth/hci_event.c:4693:7: error: use of undeclared identifier 'status'
           if (!status && __le16_to_cpu(ev->handle) > HCI_CONN_HANDLE_MAX) {
                ^
   2 errors generated.


vim +/status +3071 net/bluetooth/hci_event.c

  3064	
  3065	static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
  3066					  struct sk_buff *skb)
  3067	{
  3068		struct hci_ev_conn_complete *ev = data;
  3069		struct hci_conn *conn;
  3070	
> 3071		if (!status && __le16_to_cpu(ev->handle) > HCI_CONN_HANDLE_MAX) {
  3072			bt_dev_err(hdev, "Ignoring HCI_Connection_Complete for invalid handle");
  3073			return;
  3074		}
  3075	
  3076		bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
  3077	
  3078		hci_dev_lock(hdev);
  3079	
  3080		conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
  3081		if (!conn) {
  3082			/* Connection may not exist if auto-connected. Check the bredr
  3083			 * allowlist to see if this device is allowed to auto connect.
  3084			 * If link is an ACL type, create a connection class
  3085			 * automatically.
  3086			 *
  3087			 * Auto-connect will only occur if the event filter is
  3088			 * programmed with a given address. Right now, event filter is
  3089			 * only used during suspend.
  3090			 */
  3091			if (ev->link_type == ACL_LINK &&
  3092			    hci_bdaddr_list_lookup_with_flags(&hdev->accept_list,
  3093							      &ev->bdaddr,
  3094							      BDADDR_BREDR)) {
  3095				conn = hci_conn_add(hdev, ev->link_type, &ev->bdaddr,
  3096						    HCI_ROLE_SLAVE);
  3097				if (!conn) {
  3098					bt_dev_err(hdev, "no memory for new conn");
  3099					goto unlock;
  3100				}
  3101			} else {
  3102				if (ev->link_type != SCO_LINK)
  3103					goto unlock;
  3104	
  3105				conn = hci_conn_hash_lookup_ba(hdev, ESCO_LINK,
  3106							       &ev->bdaddr);
  3107				if (!conn)
  3108					goto unlock;
  3109	
  3110				conn->type = SCO_LINK;
  3111			}
  3112		}
  3113	
  3114		/* The HCI_Connection_Complete event is only sent once per connection.
  3115		 * Processing it more than once per connection can corrupt kernel memory.
  3116		 *
  3117		 * As the connection handle is set here for the first time, it indicates
  3118		 * whether the connection is already set up.
  3119		 */
  3120		if (conn->handle != HCI_CONN_HANDLE_UNSET) {
  3121			bt_dev_err(hdev, "Ignoring HCI_Connection_Complete for existing connection");
  3122			goto unlock;
  3123		}
  3124	
  3125		if (!ev->status) {
  3126			conn->handle = __le16_to_cpu(ev->handle);
  3127	
  3128			if (conn->type == ACL_LINK) {
  3129				conn->state = BT_CONFIG;
  3130				hci_conn_hold(conn);
  3131	
  3132				if (!conn->out && !hci_conn_ssp_enabled(conn) &&
  3133				    !hci_find_link_key(hdev, &ev->bdaddr))
  3134					conn->disc_timeout = HCI_PAIRING_TIMEOUT;
  3135				else
  3136					conn->disc_timeout = HCI_DISCONN_TIMEOUT;
  3137			} else
  3138				conn->state = BT_CONNECTED;
  3139	
  3140			hci_debugfs_create_conn(conn);
  3141			hci_conn_add_sysfs(conn);
  3142	
  3143			if (test_bit(HCI_AUTH, &hdev->flags))
  3144				set_bit(HCI_CONN_AUTH, &conn->flags);
  3145	
  3146			if (test_bit(HCI_ENCRYPT, &hdev->flags))
  3147				set_bit(HCI_CONN_ENCRYPT, &conn->flags);
  3148	
  3149			/* Get remote features */
  3150			if (conn->type == ACL_LINK) {
  3151				struct hci_cp_read_remote_features cp;
  3152				cp.handle = ev->handle;
  3153				hci_send_cmd(hdev, HCI_OP_READ_REMOTE_FEATURES,
  3154					     sizeof(cp), &cp);
  3155	
  3156				hci_req_update_scan(hdev);
  3157			}
  3158	
  3159			/* Set packet type for incoming connection */
  3160			if (!conn->out && hdev->hci_ver < BLUETOOTH_VER_2_0) {
  3161				struct hci_cp_change_conn_ptype cp;
  3162				cp.handle = ev->handle;
  3163				cp.pkt_type = cpu_to_le16(conn->pkt_type);
  3164				hci_send_cmd(hdev, HCI_OP_CHANGE_CONN_PTYPE, sizeof(cp),
  3165					     &cp);
  3166			}
  3167		} else {
  3168			conn->state = BT_CLOSED;
  3169			if (conn->type == ACL_LINK)
  3170				mgmt_connect_failed(hdev, &conn->dst, conn->type,
  3171						    conn->dst_type, ev->status);
  3172		}
  3173	
  3174		if (conn->type == ACL_LINK)
  3175			hci_sco_setup(conn, ev->status);
  3176	
  3177		if (ev->status) {
  3178			hci_connect_cfm(conn, ev->status);
  3179			hci_conn_del(conn);
  3180		} else if (ev->link_type == SCO_LINK) {
  3181			switch (conn->setting & SCO_AIRMODE_MASK) {
  3182			case SCO_AIRMODE_CVSD:
  3183				if (hdev->notify)
  3184					hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_CVSD);
  3185				break;
  3186			}
  3187	
  3188			hci_connect_cfm(conn, ev->status);
  3189		}
  3190	
  3191	unlock:
  3192		hci_dev_unlock(hdev);
  3193	
  3194		hci_conn_check_pending(hdev);
  3195	}
  3196	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
