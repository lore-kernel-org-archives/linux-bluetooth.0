Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082529;
	b=3C2fn6CUbStQLTirt9KoBMbjFG4goDew0XYmdrgizCoaVvGpiLXxgL4Pc9naErs/kmc0
	 u+DpDiKNb7JDDWgKNHNS/Njf+s5K0QqvKsdWmYRXh6i8ztFZvF12bdytMgWuu9iz4RarI
	 R86eUSMfcpfNASKEcutnv4RG/ADcT6CGzz4//JbVhoibok4URU8TOAZfae8TKUHmypZWI
	 QZBrZePDiLPe7PvPZs1zLsJCst6cu1Ftv80LdZeQOXUIOlw7rexQLLByOMYXvF80DDdH/
	 sgtqYthhursVPViiG9aFPW4Ks5H4mL2wKIb+2lL6c55WJWVsYnOV1Zhz4tjW1wpPVjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082529;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=9jeHYXFD/G2sqoXTusHDwSBnCnK5o2IhDchYKKEWk3k=;
	b=P+DqIm4trWOapNK2EqTuyr22+K6lzynGtPKWZUUyQ1XrEavTDQaXkWG8SaZiwTLu8wWG
	 grpczr/x40bXawC1wSzKvvqph3pd8noQdcAqR2p3GSrMKuvicSBLCNQ4ZPAPzDnVsVVD2
	 MWbIubCRRz5gfu4QAO6OlAc5BYN5SpXxXCylF0RZMXTXyOZS1j6AwT/n3h3V3dEdmBWr7
	 /OIKH+13GsnN4xI0MXrOdbDUjiO7d5aK3SHja2fWKTLWL24h8s+6257iStFmuDAhbg8AI
	 Uk4ozK+k9NHND5wG1cCHeBr4u9AkP0oIpqS2tXssq1uQqV8Akaniv0DifglykODlfmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bpSKm6XG;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7D2606A334;
	Thu, 19 Nov 2026 10:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA7D2606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bpSKm6XG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795082529; x=1826618529;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DWkBTpM0y5NrhB+kpM3SMygitfJv9C34lAuaaT4Q2p8=;
  b=bpSKm6XGR0LoAsH/wLSElPW/qN5fESjtRg/av75kuqpK7GZJiOl5NBfV
   C18fz+iQTt5ndXHzUZfyatwC4GP8v6bMaLTKOFznjhYMT6+Fv/nAA6ax+
   TN5jdc0sZFbOklDVEflJnCY+Xv2GqOdfrbMTPwinZ7nh+sW7+sF7iGZn4
   hY6NJVezYWY7HQcmJu3tH5zrq6NPK8ZZ2a8vJ0dcIDry3/koxFO7FEPou
   gqMN7FT2c40WV11B8Jli8ExZWm0JLI1VAaWGqhHyvJgC0lP1Sefn+RFi5
   EksDHc1qZ6eTr73jESbzUjF+0KWNmkZwi/ByPaz3tzD9UvQjEzlty0JRQ
   Q==;
X-CSE-ConnectionGUID: syjfW4F4Tyi77msTj+HaDA==
X-CSE-MsgGUID: fDHF5lPJRVqb1y/2PjJw2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3934238"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3934238"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 02:02:08 -0800
X-CSE-ConnectionGUID: GvLWE86WRIi7QQa7a/d5hg==
X-CSE-MsgGUID: g8xzbAROQdeFreWrGvZalw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10261660"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 19 Nov 2026 02:02:05 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xTyxu-00000001Fb0-49ld;
	Thu, 19 Nov 2026 10:02:02 +0000
Date: Thu, 19 Nov 2026 18:01:43 +0800
From: kernel test robot <lkp@intel.com>
To: Mohammed Alquraini <mohammed.saad.alquraini@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	Mohammed Alquraini <mohammed.saad.alquraini@gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: check security before completing a
 deferred BR/EDR accept
Message-ID: <202611191741.wWf1jeoY-lkp@intel.com>
References: <20261118213322.60067-1-mohammed.saad.alquraini@gmail.com>
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
In-Reply-To: <20261118213322.60067-1-mohammed.saad.alquraini@gmail.com>

Hi Mohammed,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on bluetooth-next/master linus/master v7.4-rc3 next-20261116]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mohammed-Alquraini/Bluetooth-L2CAP-check-security-before-completing-a-deferred-BR-EDR-accept/20261119-003322
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20261118213322.60067-1-mohammed.saad.alquraini%40gmail.com
patch subject: [PATCH] Bluetooth: L2CAP: check security before completing a deferred BR/EDR accept
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20261119/202611191741.wWf1jeoY-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 3b14d7c370558b46e5f0c6494a05c492e59bf32c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261119/202611191741.wWf1jeoY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611191741.wWf1jeoY-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/bluetooth/l2cap_sock.c:1256:14: warning: acquiring mutex 'sk->chan->conn->lock' that is already held [-Wthread-safety-analysis]
    1256 |         have_conn = l2cap_chan_lock_conn(chan);
         |                     ^
   net/bluetooth/l2cap_sock.c:1256:14: note: mutex acquired here
>> net/bluetooth/l2cap_sock.c:1281:5: warning: mutex 'sk->chan->conn->lock' is not held on every path through here [-Wthread-safety-analysis]
    1281 |                                 l2cap_chan_unlock_conn(chan, have_conn);
         |                                 ^
   include/net/bluetooth/l2cap.h:1016:2: note: expanded from macro 'l2cap_chan_unlock_conn'
    1016 |         ({                                                              \
         |         ^
   net/bluetooth/l2cap_sock.c:1256:14: note: mutex acquired here
    1256 |         have_conn = l2cap_chan_lock_conn(chan);
         |                     ^
   2 warnings generated.


vim +1256 net/bluetooth/l2cap_sock.c

ce60b9231b66710 Sebastian Urban        2024-05-01  1241  
32d86e048d8efed Pauli Virtanen         2026-08-29  1242  static int l2cap_sock_defer(struct sock *sk)
6898325923f9571 Gustavo Padovan        2011-02-04  1243  {
32d86e048d8efed Pauli Virtanen         2026-08-29  1244  	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
32d86e048d8efed Pauli Virtanen         2026-08-29  1245  	bool have_conn;
32d86e048d8efed Pauli Virtanen         2026-08-29  1246  	int err = 0;
6898325923f9571 Gustavo Padovan        2011-02-04  1247  
32d86e048d8efed Pauli Virtanen         2026-08-29  1248  	/* Fast path check */
32d86e048d8efed Pauli Virtanen         2026-08-29  1249  	lock_sock(sk);
32d86e048d8efed Pauli Virtanen         2026-08-29  1250  	if (sk->sk_state != BT_CONNECT2) {
32d86e048d8efed Pauli Virtanen         2026-08-29  1251  		release_sock(sk);
32d86e048d8efed Pauli Virtanen         2026-08-29  1252  		return 0;
32d86e048d8efed Pauli Virtanen         2026-08-29  1253  	}
32d86e048d8efed Pauli Virtanen         2026-08-29  1254  	release_sock(sk);
11770f41b8a7e12 Pauli Virtanen         2025-03-18  1255  
32d86e048d8efed Pauli Virtanen         2026-08-29 @1256  	have_conn = l2cap_chan_lock_conn(chan);
6898325923f9571 Gustavo Padovan        2011-02-04  1257  	lock_sock(sk);
6898325923f9571 Gustavo Padovan        2011-02-04  1258  
c5daa683f2d3315 Gustavo Padovan        2012-05-16  1259  	if (sk->sk_state == BT_CONNECT2 && test_bit(BT_SK_DEFER_SETUP,
c5daa683f2d3315 Gustavo Padovan        2012-05-16  1260  						    &bt_sk(sk)->flags)) {
32d86e048d8efed Pauli Virtanen         2026-08-29  1261  		err = 1;
32d86e048d8efed Pauli Virtanen         2026-08-29  1262  
32d86e048d8efed Pauli Virtanen         2026-08-29  1263  		if (!have_conn) {
32d86e048d8efed Pauli Virtanen         2026-08-29  1264  			release_sock(sk);
32d86e048d8efed Pauli Virtanen         2026-08-29  1265  			err = -ENOTCONN;
32d86e048d8efed Pauli Virtanen         2026-08-29  1266  		} else if (chan->mode == L2CAP_MODE_EXT_FLOWCTL) {
15f02b91056253e Luiz Augusto von Dentz 2020-03-02  1267  			sk->sk_state = BT_CONNECTED;
32d86e048d8efed Pauli Virtanen         2026-08-29  1268  			chan->state = BT_CONNECTED;
32d86e048d8efed Pauli Virtanen         2026-08-29  1269  			release_sock(sk);
32d86e048d8efed Pauli Virtanen         2026-08-29  1270  			__l2cap_ecred_conn_rsp_defer(chan);
32d86e048d8efed Pauli Virtanen         2026-08-29  1271  		} else if (bdaddr_type_is_le(chan->src_type)) {
3831971355d901c Johan Hedberg          2013-05-17  1272  			sk->sk_state = BT_CONNECTED;
32d86e048d8efed Pauli Virtanen         2026-08-29  1273  			chan->state = BT_CONNECTED;
32d86e048d8efed Pauli Virtanen         2026-08-29  1274  			release_sock(sk);
32d86e048d8efed Pauli Virtanen         2026-08-29  1275  			__l2cap_le_connect_rsp_defer(chan);
3831971355d901c Johan Hedberg          2013-05-17  1276  		} else {
e9a22bfeb7fdd1c Mohammed Alquraini     2026-11-19  1277  			/* Defer completion until security resolves. */
e9a22bfeb7fdd1c Mohammed Alquraini     2026-11-19  1278  			if (!l2cap_chan_check_security(chan, false)) {
e9a22bfeb7fdd1c Mohammed Alquraini     2026-11-19  1279  				set_bit(BT_SK_ACCEPTED, &bt_sk(sk)->flags);
e9a22bfeb7fdd1c Mohammed Alquraini     2026-11-19  1280  				release_sock(sk);
e9a22bfeb7fdd1c Mohammed Alquraini     2026-11-19 @1281  				l2cap_chan_unlock_conn(chan, have_conn);
e9a22bfeb7fdd1c Mohammed Alquraini     2026-11-19  1282  				return err;
e9a22bfeb7fdd1c Mohammed Alquraini     2026-11-19  1283  			}
8c1d787be4b62d2 Gustavo Padovan        2011-04-13  1284  			sk->sk_state = BT_CONFIG;
32d86e048d8efed Pauli Virtanen         2026-08-29  1285  			chan->state = BT_CONFIG;
32d86e048d8efed Pauli Virtanen         2026-08-29  1286  			release_sock(sk);
32d86e048d8efed Pauli Virtanen         2026-08-29  1287  			__l2cap_connect_rsp_defer(chan);
32d86e048d8efed Pauli Virtanen         2026-08-29  1288  		}
32d86e048d8efed Pauli Virtanen         2026-08-29  1289  	} else {
32d86e048d8efed Pauli Virtanen         2026-08-29  1290  		release_sock(sk);
3831971355d901c Johan Hedberg          2013-05-17  1291  	}
3831971355d901c Johan Hedberg          2013-05-17  1292  
32d86e048d8efed Pauli Virtanen         2026-08-29  1293  	l2cap_chan_unlock_conn(chan, have_conn);
32d86e048d8efed Pauli Virtanen         2026-08-29  1294  	return err;
6898325923f9571 Gustavo Padovan        2011-02-04  1295  }
6898325923f9571 Gustavo Padovan        2011-02-04  1296  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
