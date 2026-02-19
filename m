Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2417F24729A
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 23:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771543675; cv=none; b=XWLEeUFUKLqbzX9VJQ+aNXNLJZqTUijWT2Tw96wXn+qEAU6frGsxwPbckyBOC/zbuseWrfv4nZTUJx9Md5FHLtpaHJvTy4alyQbR+A1NmzxItDXKz4c8bfJPyxPd6837yqBG6dedkz8JN07KeCkasCFW6NGRGGSBx/gokdi4sDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771543675; c=relaxed/simple;
	bh=jXgZj8unO6P2PplmWStZGN6nPD48ID7J7BYeCyxEeD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImF2wBCGKfAgsk3kXQ5VD04YVTGV6XHgYqnAip/oQiNy0pN15UiXiEahbB+PNgOJZM4BvBd/7+cUIiriBzsgvSMi2iJz/W3yewjgd02NNGhE2N7N7Q7s+ZhiBu8Spxdb7o4gTGWQMAyPKf9gUUTshJKjSmiHt3hhIBMl6/hwxBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jHG/DMAP; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jHG/DMAP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771543673; x=1803079673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jXgZj8unO6P2PplmWStZGN6nPD48ID7J7BYeCyxEeD4=;
  b=jHG/DMAP9qHZiMDGsDN+uBwjNEeLwFfasmOkSfNn6bfNbZydRgQX+Lka
   rBCwmCqmK3bJG5ELy0IfLq44fJl4FhKjuaMecSu3wmlXoIu4Mv6u11S1P
   7mPfgKA8PfyNhqioLuNbaoIwH/i11p+opj0bOlDu3E8UY+iHcILzkcyXa
   py4iRk3+TerbanSXUoYpCGF+DhsdgZRHmuJGSb8ULYVT3eFShhEQpkv0R
   NFrbv+D5a1cw/SRgvtq3jb5o/fpX/sdn8f1+Mq/iZc6XgwD6Rby33C6BT
   nGeCOxaZ24jh9J4ZWa4+iwxzRCGMxL0Xnqh6RnHhcP3wAAUYaUG0XaPnj
   g==;
X-CSE-ConnectionGUID: VbAEBmW/SqKPyuKOPRfFZg==
X-CSE-MsgGUID: uLN/rqokR4OX2GFYJVbMkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72626951"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="72626951"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 15:27:53 -0800
X-CSE-ConnectionGUID: 5NFS/llARbqbm5f2XCKjug==
X-CSE-MsgGUID: trAE4vkDSuqDtdd/HT+DYg==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 19 Feb 2026 15:27:51 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vtDQz-000000013dA-1Tf7;
	Thu, 19 Feb 2026 23:27:49 +0000
Date: Fri, 20 Feb 2026 07:27:43 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] Bluetooth: L2CAP: Fix not checking output MTU is
 acceptable on L2CAP_ECRED_CONN_REQ
Message-ID: <202602200748.VaqQIrnz-lkp@intel.com>
References: <20260219183343.3167089-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219183343.3167089-1-luiz.dentz@gmail.com>

Hi Luiz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on bluetooth/master linus/master v6.19 next-20260219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luiz-Augusto-von-Dentz/Bluetooth-L2CAP-Fix-not-checking-output-MTU-is-acceptable-on-L2CAP_ECRED_CONN_REQ/20260220-023511
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20260219183343.3167089-1-luiz.dentz%40gmail.com
patch subject: [PATCH v2] Bluetooth: L2CAP: Fix not checking output MTU is acceptable on L2CAP_ECRED_CONN_REQ
config: loongarch-randconfig-001-20260220 (https://download.01.org/0day-ci/archive/20260220/202602200748.VaqQIrnz-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project e86750b29fa0ff207cd43213d66dabe565417638)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260220/202602200748.VaqQIrnz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602200748.VaqQIrnz-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/bluetooth/l2cap_sock.c:1038:16: warning: variable 'mtu' is uninitialized when used here [-Wuninitialized]
    1038 |                 chan->omtu = mtu;
         |                              ^~~
   net/bluetooth/l2cap_sock.c:889:9: note: initialize the variable 'mtu' to silence this warning
     889 |         u16 mtu;
         |                ^
         |                 = 0
   1 warning generated.


vim +/mtu +1038 net/bluetooth/l2cap_sock.c

   878	
   879	static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
   880					 sockptr_t optval, unsigned int optlen)
   881	{
   882		struct sock *sk = sock->sk;
   883		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
   884		struct bt_security sec;
   885		struct bt_power pwr;
   886		struct l2cap_conn *conn;
   887		int err = 0;
   888		u32 opt, phys;
   889		u16 mtu;
   890		u8 mode;
   891	
   892		BT_DBG("sk %p", sk);
   893	
   894		if (level == SOL_L2CAP)
   895			return l2cap_sock_setsockopt_old(sock, optname, optval, optlen);
   896	
   897		if (level != SOL_BLUETOOTH)
   898			return -ENOPROTOOPT;
   899	
   900		lock_sock(sk);
   901	
   902		switch (optname) {
   903		case BT_SECURITY:
   904			if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED &&
   905			    chan->chan_type != L2CAP_CHAN_FIXED &&
   906			    chan->chan_type != L2CAP_CHAN_RAW) {
   907				err = -EINVAL;
   908				break;
   909			}
   910	
   911			sec.level = BT_SECURITY_LOW;
   912	
   913			err = copy_safe_from_sockptr(&sec, sizeof(sec), optval, optlen);
   914			if (err)
   915				break;
   916	
   917			if (sec.level < BT_SECURITY_LOW ||
   918			    sec.level > BT_SECURITY_FIPS) {
   919				err = -EINVAL;
   920				break;
   921			}
   922	
   923			chan->sec_level = sec.level;
   924	
   925			if (!chan->conn)
   926				break;
   927	
   928			conn = chan->conn;
   929	
   930			/* change security for LE channels */
   931			if (chan->scid == L2CAP_CID_ATT) {
   932				if (smp_conn_security(conn->hcon, sec.level)) {
   933					err = -EINVAL;
   934					break;
   935				}
   936	
   937				set_bit(FLAG_PENDING_SECURITY, &chan->flags);
   938				sk->sk_state = BT_CONFIG;
   939				chan->state = BT_CONFIG;
   940	
   941			/* or for ACL link */
   942			} else if ((sk->sk_state == BT_CONNECT2 &&
   943				    test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) ||
   944				   sk->sk_state == BT_CONNECTED) {
   945				if (!l2cap_chan_check_security(chan, true))
   946					set_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags);
   947				else
   948					sk->sk_state_change(sk);
   949			} else {
   950				err = -EINVAL;
   951			}
   952			break;
   953	
   954		case BT_DEFER_SETUP:
   955			if (sk->sk_state != BT_BOUND && sk->sk_state != BT_LISTEN) {
   956				err = -EINVAL;
   957				break;
   958			}
   959	
   960			err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
   961			if (err)
   962				break;
   963	
   964			if (opt) {
   965				set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
   966				set_bit(FLAG_DEFER_SETUP, &chan->flags);
   967			} else {
   968				clear_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
   969				clear_bit(FLAG_DEFER_SETUP, &chan->flags);
   970			}
   971			break;
   972	
   973		case BT_FLUSHABLE:
   974			err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
   975			if (err)
   976				break;
   977	
   978			if (opt > BT_FLUSHABLE_ON) {
   979				err = -EINVAL;
   980				break;
   981			}
   982	
   983			if (opt == BT_FLUSHABLE_OFF) {
   984				conn = chan->conn;
   985				/* proceed further only when we have l2cap_conn and
   986				   No Flush support in the LM */
   987				if (!conn || !lmp_no_flush_capable(conn->hcon->hdev)) {
   988					err = -EINVAL;
   989					break;
   990				}
   991			}
   992	
   993			if (opt)
   994				set_bit(FLAG_FLUSHABLE, &chan->flags);
   995			else
   996				clear_bit(FLAG_FLUSHABLE, &chan->flags);
   997			break;
   998	
   999		case BT_POWER:
  1000			if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED &&
  1001			    chan->chan_type != L2CAP_CHAN_RAW) {
  1002				err = -EINVAL;
  1003				break;
  1004			}
  1005	
  1006			pwr.force_active = BT_POWER_FORCE_ACTIVE_ON;
  1007	
  1008			err = copy_safe_from_sockptr(&pwr, sizeof(pwr), optval, optlen);
  1009			if (err)
  1010				break;
  1011	
  1012			if (pwr.force_active)
  1013				set_bit(FLAG_FORCE_ACTIVE, &chan->flags);
  1014			else
  1015				clear_bit(FLAG_FORCE_ACTIVE, &chan->flags);
  1016			break;
  1017	
  1018		case BT_CHANNEL_POLICY:
  1019			err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
  1020			if (err)
  1021				break;
  1022	
  1023			err = -EOPNOTSUPP;
  1024			break;
  1025	
  1026		case BT_SNDMTU:
  1027			if (!bdaddr_type_is_le(chan->src_type)) {
  1028				err = -EINVAL;
  1029				break;
  1030			}
  1031	
  1032			/* Only allow setting output MTU when not connected */
  1033			if (sk->sk_state == BT_CONNECTED) {
  1034				err = -EISCONN;
  1035				break;
  1036			}
  1037	
> 1038			chan->omtu = mtu;
  1039			break;
  1040	
  1041		case BT_RCVMTU:
  1042			if (!bdaddr_type_is_le(chan->src_type)) {
  1043				err = -EINVAL;
  1044				break;
  1045			}
  1046	
  1047			if (chan->mode == L2CAP_MODE_LE_FLOWCTL &&
  1048			    sk->sk_state == BT_CONNECTED) {
  1049				err = -EISCONN;
  1050				break;
  1051			}
  1052	
  1053			err = copy_safe_from_sockptr(&mtu, sizeof(mtu), optval, optlen);
  1054			if (err)
  1055				break;
  1056	
  1057			if (chan->mode == L2CAP_MODE_EXT_FLOWCTL &&
  1058			    sk->sk_state == BT_CONNECTED)
  1059				err = l2cap_chan_reconfigure(chan, mtu);
  1060			else
  1061				chan->imtu = mtu;
  1062	
  1063			break;
  1064	
  1065		case BT_PHY:
  1066			if (sk->sk_state != BT_CONNECTED) {
  1067				err = -ENOTCONN;
  1068				break;
  1069			}
  1070	
  1071			err = copy_safe_from_sockptr(&phys, sizeof(phys), optval,
  1072						     optlen);
  1073			if (err)
  1074				break;
  1075	
  1076			if (!chan->conn)
  1077				break;
  1078	
  1079			conn = chan->conn;
  1080			err = hci_conn_set_phy(conn->hcon, phys);
  1081			break;
  1082	
  1083		case BT_MODE:
  1084			if (!enable_ecred) {
  1085				err = -ENOPROTOOPT;
  1086				break;
  1087			}
  1088	
  1089			BT_DBG("sk->sk_state %u", sk->sk_state);
  1090	
  1091			if (sk->sk_state != BT_BOUND) {
  1092				err = -EINVAL;
  1093				break;
  1094			}
  1095	
  1096			if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
  1097				err = -EINVAL;
  1098				break;
  1099			}
  1100	
  1101			err = copy_safe_from_sockptr(&mode, sizeof(mode), optval,
  1102						     optlen);
  1103			if (err)
  1104				break;
  1105	
  1106			BT_DBG("mode %u", mode);
  1107	
  1108			err = l2cap_set_mode(chan, mode);
  1109			if (err)
  1110				break;
  1111	
  1112			BT_DBG("mode 0x%2.2x", chan->mode);
  1113	
  1114			break;
  1115	
  1116		default:
  1117			err = -ENOPROTOOPT;
  1118			break;
  1119		}
  1120	
  1121		release_sock(sk);
  1122		return err;
  1123	}
  1124	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
