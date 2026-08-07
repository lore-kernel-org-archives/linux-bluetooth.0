Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D920545D5DB
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 21:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786139948; cv=none; b=Dj22SbdW7r7Xs+IyEmnLEGZySdDEjsMkg4lXxuKgiLN8Phfh88WelV47fYiaD+GtQQ1aFtW2LJSrrUeVR2cxg9ExXzBctFMW4hD47gTYAPLZLjIpHWnfUYuKEuxOx/bDHRohVGnfQbq9RCjNFmuet7fOA2mOQhbYKuYbMXSgEzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786139948; c=relaxed/simple;
	bh=hk7WOPFGexw2dFr6VViLZDBWqvjjwzl+DCl93zQfOeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBtE8E+GYC82XCW8YUeaRjzT6yP60QU2actmM37WXWkko1sde0MNZSPXh5XX9VaQMBesFoNQBf76SDfFps6rfg7qEo7bde/o/2o1KuX68/4v3r+Z7tdWb10BTu1YIxJ024QvdtGhNPwBH91+/ML33AIgvwX1hAylEiHvxZjbW9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mIpTs5fv; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mIpTs5fv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786139946; x=1817675946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hk7WOPFGexw2dFr6VViLZDBWqvjjwzl+DCl93zQfOeY=;
  b=mIpTs5fvP3ElWJCuBBRNW+Iv/4QRWDSPQigWau69cgPvvawrbgAxKR96
   +8TIdvcjDas4kSR4hEmBTND3hfHn8bQLooMbr9igZxgH2325h6BdKe7XJ
   MaQqN732pwZLh3lxSXjPc+i38/WBdUeKwQwP5KT5Xdk33LtMqR01G4CVA
   IE6XK6QCthU1EGuLvIkuvOi4mYAYgUgi0A9B3YF2eThu1wjZILbBoyuqA
   OqZy+BcnZ7e21kU28z6guwwi2kPPGN9/H/TKFLQo/CoTTcEouXlrZcLZy
   w/8avz+GqB55IxzgCo0Y2jzmOvtfWYPyYtf+irR+/9QjhdX3LO+8NbVul
   A==;
X-CSE-ConnectionGUID: baxVdT7TTiGefjWZ5NSYXQ==
X-CSE-MsgGUID: jeyJR/OXTaS+Tl5AIJ5ThA==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="112302726"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="112302726"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 14:59:05 -0700
X-CSE-ConnectionGUID: gl9hgLbHS8KQnjuVv9/GyA==
X-CSE-MsgGUID: Jc1CxHnlRNyrEv85N+wH3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="287198458"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 07 Aug 2026 14:59:03 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wsSai-00000000JLy-0NNe;
	Fri, 07 Aug 2026 21:59:00 +0000
Date: Sat, 8 Aug 2026 05:58:27 +0800
From: kernel test robot <lkp@intel.com>
To: zhangchen200426@163.com, luiz.von.dentz@intel.com, yang.li@amlogic.com,
	tim.bird@sony.com, naga.akella@oss.qualcomm.com,
	gustavoars@kernel.org, pav@iki.fi
Cc: oe-kbuild-all@lists.linux.dev, zhangchen01@kylinos.cn,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: hci_event: Add
 HCI_Write_Link_Supervision_Timeout command/event structures
Message-ID: <202608080528.0kc5JCoL-lkp@intel.com>
References: <20260724085406.1884991-1-zhangchen200426@163.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724085406.1884991-1-zhangchen200426@163.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on bluetooth/master linus/master v7.2-rc6 next-20260807]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/zhangchen200426-163-com/Bluetooth-hci_event-Add-HCI_Write_Link_Supervision_Timeout-command-event-structures/20260806-180202
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20260724085406.1884991-1-zhangchen200426%40163.com
patch subject: [PATCH v2] Bluetooth: hci_event: Add HCI_Write_Link_Supervision_Timeout command/event structures
config: riscv-randconfig-r111-20260807 (https://download.01.org/0day-ci/archive/20260808/202608080528.0kc5JCoL-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 16.1.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260808/202608080528.0kc5JCoL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608080528.0kc5JCoL-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   WARNING: invalid argument to '-march': '_zacas_zabha'
>> net/bluetooth/hci_event.c:3324:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [assigned] [usertype] timeout @@     got int @@
   net/bluetooth/hci_event.c:3324:36: sparse:     expected restricted __le16 [assigned] [usertype] timeout
   net/bluetooth/hci_event.c:3324:36: sparse:     got int
   net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
   include/net/bluetooth/hci.h:2985:47: sparse: sparse: array of flexible structures
   include/net/bluetooth/hci.h:3071:43: sparse: sparse: array of flexible structures

vim +3324 net/bluetooth/hci_event.c

  3187	
  3188	static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
  3189					  struct sk_buff *skb)
  3190	{
  3191		struct hci_ev_conn_complete *ev = data;
  3192		struct hci_conn *conn;
  3193		u8 status = ev->status;
  3194	
  3195		bt_dev_dbg(hdev, "status 0x%2.2x", status);
  3196	
  3197		hci_dev_lock(hdev);
  3198		hci_store_wake_reason(hdev, &ev->bdaddr, BDADDR_BREDR);
  3199	
  3200		/* Check for existing connection:
  3201		 *
  3202		 * 1. If it doesn't exist then it must be receiver/slave role.
  3203		 * 2. If it does exist confirm that it is connecting/BT_CONNECT in case
  3204		 *    of initiator/master role since there could be a collision where
  3205		 *    either side is attempting to connect or something like a fuzzing
  3206		 *    testing is trying to play tricks to destroy the hcon object before
  3207		 *    it even attempts to connect (e.g. hcon->state == BT_OPEN).
  3208		 */
  3209		conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
  3210		if (!conn ||
  3211		    (conn->role == HCI_ROLE_MASTER && conn->state != BT_CONNECT)) {
  3212			/* In case of error status and there is no connection pending
  3213			 * just unlock as there is nothing to cleanup.
  3214			 */
  3215			if (ev->status)
  3216				goto unlock;
  3217	
  3218			/* Connection may not exist if auto-connected. Check the bredr
  3219			 * allowlist to see if this device is allowed to auto connect.
  3220			 * If link is an ACL type, create a connection class
  3221			 * automatically.
  3222			 *
  3223			 * Auto-connect will only occur if the event filter is
  3224			 * programmed with a given address. Right now, event filter is
  3225			 * only used during suspend.
  3226			 */
  3227			if (ev->link_type == ACL_LINK &&
  3228			    hci_bdaddr_list_lookup_with_flags(&hdev->accept_list,
  3229							      &ev->bdaddr,
  3230							      BDADDR_BREDR)) {
  3231				conn = hci_conn_add_unset(hdev, ev->link_type,
  3232							  &ev->bdaddr, 0,
  3233							  HCI_ROLE_SLAVE);
  3234				if (IS_ERR(conn)) {
  3235					bt_dev_err(hdev, "connection err: %ld", PTR_ERR(conn));
  3236					goto unlock;
  3237				}
  3238			} else {
  3239				if (ev->link_type != SCO_LINK)
  3240					goto unlock;
  3241	
  3242				conn = hci_conn_hash_lookup_ba(hdev, ESCO_LINK,
  3243							       &ev->bdaddr);
  3244				if (!conn)
  3245					goto unlock;
  3246	
  3247				conn->type = SCO_LINK;
  3248			}
  3249		}
  3250	
  3251		/* The HCI_Connection_Complete event is only sent once per connection.
  3252		 * Processing it more than once per connection can corrupt kernel memory.
  3253		 *
  3254		 * As the connection handle is set here for the first time, it indicates
  3255		 * whether the connection is already set up.
  3256		 */
  3257		if (!HCI_CONN_HANDLE_UNSET(conn->handle)) {
  3258			bt_dev_err(hdev, "Ignoring HCI_Connection_Complete for existing connection");
  3259			goto unlock;
  3260		}
  3261	
  3262		if (!status) {
  3263			status = hci_conn_set_handle(conn, __le16_to_cpu(ev->handle));
  3264			if (status)
  3265				goto done;
  3266	
  3267			if (conn->type == ACL_LINK) {
  3268				conn->state = BT_CONFIG;
  3269				hci_conn_hold(conn);
  3270	
  3271				if (!conn->out && !hci_conn_ssp_enabled(conn) &&
  3272				    !hci_find_link_key(hdev, &ev->bdaddr))
  3273					conn->disc_timeout = HCI_PAIRING_TIMEOUT;
  3274				else
  3275					conn->disc_timeout = HCI_DISCONN_TIMEOUT;
  3276			} else
  3277				conn->state = BT_CONNECTED;
  3278	
  3279			hci_debugfs_create_conn(conn);
  3280			hci_conn_add_sysfs(conn);
  3281	
  3282			if (test_bit(HCI_AUTH, &hdev->flags))
  3283				set_bit(HCI_CONN_AUTH, &conn->flags);
  3284	
  3285			if (test_bit(HCI_ENCRYPT, &hdev->flags))
  3286				set_bit(HCI_CONN_ENCRYPT, &conn->flags);
  3287	
  3288			/* "Link key request" completed ahead of "connect request" completes */
  3289			if (ev->encr_mode == 1 && !test_bit(HCI_CONN_ENCRYPT, &conn->flags) &&
  3290			    ev->link_type == ACL_LINK) {
  3291				struct link_key *key;
  3292	
  3293				key = hci_find_link_key(hdev, &ev->bdaddr);
  3294				if (key) {
  3295					set_bit(HCI_CONN_ENCRYPT, &conn->flags);
  3296					hci_read_enc_key_size(hdev, conn);
  3297					hci_encrypt_cfm(conn, ev->status);
  3298				}
  3299			}
  3300	
  3301			/* Get remote features */
  3302			if (conn->type == ACL_LINK) {
  3303				struct hci_cp_read_remote_features cp;
  3304				cp.handle = ev->handle;
  3305				hci_send_cmd(hdev, HCI_OP_READ_REMOTE_FEATURES,
  3306					     sizeof(cp), &cp);
  3307	
  3308				hci_update_scan(hdev);
  3309			}
  3310	
  3311			/* Set packet type for incoming connection */
  3312			if (!conn->out && hdev->hci_ver < BLUETOOTH_VER_2_0) {
  3313				struct hci_cp_change_conn_ptype cp;
  3314				cp.handle = ev->handle;
  3315				cp.pkt_type = cpu_to_le16(conn->pkt_type);
  3316				hci_send_cmd(hdev, HCI_OP_CHANGE_CONN_PTYPE, sizeof(cp),
  3317					     &cp);
  3318			}
  3319	
  3320			if (conn->type == ACL_LINK && conn->role == HCI_ROLE_MASTER) {
  3321				struct hci_cp_write_link_supervision_timeout cp;
  3322	
  3323				cp.handle = ev->handle;
> 3324				cp.timeout = 0x1F40;	/* 8000 * 0.625ms = 5000ms */
  3325				hci_send_cmd(hdev, HCI_OP_WRITE_LINK_SUPERVISION_TIMEOUT,
  3326					     sizeof(cp), &cp);
  3327			}
  3328	
  3329		}
  3330	
  3331		if (conn->type == ACL_LINK)
  3332			hci_sco_setup(conn, ev->status);
  3333	
  3334	done:
  3335		if (status) {
  3336			hci_conn_failed(conn, status);
  3337		} else if (ev->link_type == SCO_LINK) {
  3338			switch (conn->setting & SCO_AIRMODE_MASK) {
  3339			case SCO_AIRMODE_CVSD:
  3340				if (hdev->notify)
  3341					hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_CVSD);
  3342				break;
  3343			}
  3344	
  3345			hci_connect_cfm(conn, status);
  3346		}
  3347	
  3348	unlock:
  3349		hci_dev_unlock(hdev);
  3350	}
  3351	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
