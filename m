Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACE3394473;
	Thu, 15 Jan 2026 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768479193; cv=none; b=PJWcGO8xHkx+gTtSTJXks3SlMnIPTr76nh7thP5z7gALnwRGCSitOyaRI4YeO4N3b5mGhE43HCMzZPPrI8Kw4cvd6lp3tfnsSHRxWu2sIGTHNtXK6MLOlShmG069dJo3a0I55is1/4RrQRR1HNB0UdKAib/lEDPjDgxYqhkjzok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768479193; c=relaxed/simple;
	bh=eGf/0D/IM7ZXDZf/Bu6ATzxNE1y3CzylF3sYmtu3E+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNeH0fNsPP5uDTBbbN01FfUnHiYU8CwfDbg2lc5uYj5ixeXec1nyWCFCHSfeZqIns2yTLTdQaxj6TEPX6NqjkwUMC++WFmCneZ0qgq04YvI9jekGlB7DkdYCFlTpAZdyp8cEztkX1ju0u4MnC2hW6ZASizAMBxwTkh9HOriyEqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A385LQov; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A385LQov"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768479188; x=1800015188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eGf/0D/IM7ZXDZf/Bu6ATzxNE1y3CzylF3sYmtu3E+c=;
  b=A385LQovgrR6B/fpWiVo0aLVy8yPDUXAaBNqm1q53e2PGS6zx2BOy5/5
   miEuhyljPwGhe7LUFP8iueKzep6FQBhcgzhNOnzXFC8gL43swsECShX4S
   l0B+w35Lq2VRGT8H+CajAAdLsUcYybcsNZRXP1vV/9UGTPKnDHWHD7qe+
   uqhc5VCKmQKxdhANqMp00GvZkngjRnwaHDNFFSGk790FMaAZI6A/IBH7P
   cGQuWa3Zc9uKkCNxq9yRybEA0u3FgJjkGofmsgAuwmQivssAnEsTOIjxQ
   p4rDFYPFFF1AAyHz3PlEgyIKlYitYt5Q7SSbyYDi2tvD1uWv4CeYE27XL
   A==;
X-CSE-ConnectionGUID: Z30oq/UfQzqvMyvLHiaGKw==
X-CSE-MsgGUID: yj8soTaURSqKhIekcw+7jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69518468"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="69518468"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 04:13:04 -0800
X-CSE-ConnectionGUID: knDXh2aSRTCHOvjG7gmWmA==
X-CSE-MsgGUID: i39+hqsjQoKkIULGG0PMGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="205352070"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 15 Jan 2026 04:13:02 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgMDj-00000000Hvo-3L5p;
	Thu, 15 Jan 2026 12:12:59 +0000
Date: Thu, 15 Jan 2026 20:12:17 +0800
From: kernel test robot <lkp@intel.com>
To: Jerry Wu <w.7erry@foxmail.com>, marcel@holtmann.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	johan.hedberg@gmail.com, luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	w.7erry@foxmail.com
Subject: Re: [PATCH] Bluetooth: Perform careful capability checks in
 hci_sock_bind()
Message-ID: <202601151957.xmjlRkZB-lkp@intel.com>
References: <tencent_2FAB909645504A5E0FDC88F125E139242C05@qq.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_2FAB909645504A5E0FDC88F125E139242C05@qq.com>

Hi Jerry,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth/master]
[also build test ERROR on bluetooth-next/master linus/master v6.19-rc5 next-20260115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jerry-Wu/Bluetooth-Perform-careful-capability-checks-in-hci_sock_bind/20260109-100553
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/tencent_2FAB909645504A5E0FDC88F125E139242C05%40qq.com
patch subject: [PATCH] Bluetooth: Perform careful capability checks in hci_sock_bind()
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20260115/202601151957.xmjlRkZB-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260115/202601151957.xmjlRkZB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601151957.xmjlRkZB-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/bluetooth/hci_sock.c:1262:31: error: too few arguments to function call, expected 2, have 1
    1262 |                 if (sk_capable(CAP_NET_ADMIN))
         |                     ~~~~~~~~~~              ^
   include/net/sock.h:3023:6: note: 'sk_capable' declared here
    3023 | bool sk_capable(const struct sock *sk, int cap);
         |      ^          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/bluetooth/hci_sock.c:1430:31: error: too few arguments to function call, expected 2, have 1
    1430 |                 if (sk_capable(CAP_NET_ADMIN))
         |                     ~~~~~~~~~~              ^
   include/net/sock.h:3023:6: note: 'sk_capable' declared here
    3023 | bool sk_capable(const struct sock *sk, int cap);
         |      ^          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +1262 net/bluetooth/hci_sock.c

  1187	
  1188	static int hci_sock_bind(struct socket *sock, struct sockaddr_unsized *addr,
  1189				 int addr_len)
  1190	{
  1191		struct sockaddr_hci haddr;
  1192		struct sock *sk = sock->sk;
  1193		struct hci_dev *hdev = NULL;
  1194		struct sk_buff *skb;
  1195		int len, err = 0;
  1196	
  1197		BT_DBG("sock %p sk %p", sock, sk);
  1198	
  1199		if (!addr)
  1200			return -EINVAL;
  1201	
  1202		memset(&haddr, 0, sizeof(haddr));
  1203		len = min_t(unsigned int, sizeof(haddr), addr_len);
  1204		memcpy(&haddr, addr, len);
  1205	
  1206		if (haddr.hci_family != AF_BLUETOOTH)
  1207			return -EINVAL;
  1208	
  1209		lock_sock(sk);
  1210	
  1211		/* Allow detaching from dead device and attaching to alive device, if
  1212		 * the caller wants to re-bind (instead of close) this socket in
  1213		 * response to hci_sock_dev_event(HCI_DEV_UNREG) notification.
  1214		 */
  1215		hdev = hci_pi(sk)->hdev;
  1216		if (hdev && hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
  1217			hci_pi(sk)->hdev = NULL;
  1218			sk->sk_state = BT_OPEN;
  1219			hci_dev_put(hdev);
  1220		}
  1221		hdev = NULL;
  1222	
  1223		if (sk->sk_state == BT_BOUND) {
  1224			err = -EALREADY;
  1225			goto done;
  1226		}
  1227	
  1228		switch (haddr.hci_channel) {
  1229		case HCI_CHANNEL_RAW:
  1230			if (hci_pi(sk)->hdev) {
  1231				err = -EALREADY;
  1232				goto done;
  1233			}
  1234	
  1235			if (haddr.hci_dev != HCI_DEV_NONE) {
  1236				hdev = hci_dev_get(haddr.hci_dev);
  1237				if (!hdev) {
  1238					err = -ENODEV;
  1239					goto done;
  1240				}
  1241	
  1242				atomic_inc(&hdev->promisc);
  1243			}
  1244	
  1245			hci_pi(sk)->channel = haddr.hci_channel;
  1246	
  1247			if (!hci_sock_gen_cookie(sk)) {
  1248				/* In the case when a cookie has already been assigned,
  1249				 * then there has been already an ioctl issued against
  1250				 * an unbound socket and with that triggered an open
  1251				 * notification. Send a close notification first to
  1252				 * allow the state transition to bounded.
  1253				 */
  1254				skb = create_monitor_ctrl_close(sk);
  1255				if (skb) {
  1256					hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
  1257							    HCI_SOCK_TRUSTED, NULL);
  1258					kfree_skb(skb);
  1259				}
  1260			}
  1261	
> 1262			if (sk_capable(CAP_NET_ADMIN))
  1263				hci_sock_set_flag(sk, HCI_SOCK_TRUSTED);
  1264	
  1265			hci_pi(sk)->hdev = hdev;
  1266	
  1267			/* Send event to monitor */
  1268			skb = create_monitor_ctrl_open(sk);
  1269			if (skb) {
  1270				hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
  1271						    HCI_SOCK_TRUSTED, NULL);
  1272				kfree_skb(skb);
  1273			}
  1274			break;
  1275	
  1276		case HCI_CHANNEL_USER:
  1277			if (hci_pi(sk)->hdev) {
  1278				err = -EALREADY;
  1279				goto done;
  1280			}
  1281	
  1282			if (haddr.hci_dev == HCI_DEV_NONE) {
  1283				err = -EINVAL;
  1284				goto done;
  1285			}
  1286	
  1287			if (!capable(CAP_NET_ADMIN)) {
  1288				err = -EPERM;
  1289				goto done;
  1290			}
  1291	
  1292			hdev = hci_dev_get(haddr.hci_dev);
  1293			if (!hdev) {
  1294				err = -ENODEV;
  1295				goto done;
  1296			}
  1297	
  1298			if (test_bit(HCI_INIT, &hdev->flags) ||
  1299			    hci_dev_test_flag(hdev, HCI_SETUP) ||
  1300			    hci_dev_test_flag(hdev, HCI_CONFIG) ||
  1301			    (!hci_dev_test_flag(hdev, HCI_AUTO_OFF) &&
  1302			     test_bit(HCI_UP, &hdev->flags))) {
  1303				err = -EBUSY;
  1304				hci_dev_put(hdev);
  1305				goto done;
  1306			}
  1307	
  1308			if (hci_dev_test_and_set_flag(hdev, HCI_USER_CHANNEL)) {
  1309				err = -EUSERS;
  1310				hci_dev_put(hdev);
  1311				goto done;
  1312			}
  1313	
  1314			hci_dev_lock(hdev);
  1315			mgmt_index_removed(hdev);
  1316			hci_dev_unlock(hdev);
  1317	
  1318			err = hci_dev_open(hdev->id);
  1319			if (err) {
  1320				if (err == -EALREADY) {
  1321					/* In case the transport is already up and
  1322					 * running, clear the error here.
  1323					 *
  1324					 * This can happen when opening a user
  1325					 * channel and HCI_AUTO_OFF grace period
  1326					 * is still active.
  1327					 */
  1328					err = 0;
  1329				} else {
  1330					hci_dev_clear_flag(hdev, HCI_USER_CHANNEL);
  1331					mgmt_index_added(hdev);
  1332					hci_dev_put(hdev);
  1333					goto done;
  1334				}
  1335			}
  1336	
  1337			hci_pi(sk)->channel = haddr.hci_channel;
  1338	
  1339			if (!hci_sock_gen_cookie(sk)) {
  1340				/* In the case when a cookie has already been assigned,
  1341				 * this socket will transition from a raw socket into
  1342				 * a user channel socket. For a clean transition, send
  1343				 * the close notification first.
  1344				 */
  1345				skb = create_monitor_ctrl_close(sk);
  1346				if (skb) {
  1347					hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
  1348							    HCI_SOCK_TRUSTED, NULL);
  1349					kfree_skb(skb);
  1350				}
  1351			}
  1352	
  1353			/* The user channel is restricted to CAP_NET_ADMIN
  1354			 * capabilities and with that implicitly trusted.
  1355			 */
  1356			hci_sock_set_flag(sk, HCI_SOCK_TRUSTED);
  1357	
  1358			hci_pi(sk)->hdev = hdev;
  1359	
  1360			/* Send event to monitor */
  1361			skb = create_monitor_ctrl_open(sk);
  1362			if (skb) {
  1363				hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
  1364						    HCI_SOCK_TRUSTED, NULL);
  1365				kfree_skb(skb);
  1366			}
  1367	
  1368			atomic_inc(&hdev->promisc);
  1369			break;
  1370	
  1371		case HCI_CHANNEL_MONITOR:
  1372			if (haddr.hci_dev != HCI_DEV_NONE) {
  1373				err = -EINVAL;
  1374				goto done;
  1375			}
  1376	
  1377			if (!capable(CAP_NET_RAW)) {
  1378				err = -EPERM;
  1379				goto done;
  1380			}
  1381	
  1382			hci_pi(sk)->channel = haddr.hci_channel;
  1383	
  1384			/* The monitor interface is restricted to CAP_NET_RAW
  1385			 * capabilities and with that implicitly trusted.
  1386			 */
  1387			hci_sock_set_flag(sk, HCI_SOCK_TRUSTED);
  1388	
  1389			send_monitor_note(sk, "Linux version %s (%s)",
  1390					  init_utsname()->release,
  1391					  init_utsname()->machine);
  1392			send_monitor_note(sk, "Bluetooth subsystem version %u.%u",
  1393					  BT_SUBSYS_VERSION, BT_SUBSYS_REVISION);
  1394			send_monitor_replay(sk);
  1395			send_monitor_control_replay(sk);
  1396	
  1397			atomic_inc(&monitor_promisc);
  1398			break;
  1399	
  1400		case HCI_CHANNEL_LOGGING:
  1401			if (haddr.hci_dev != HCI_DEV_NONE) {
  1402				err = -EINVAL;
  1403				goto done;
  1404			}
  1405	
  1406			if (!capable(CAP_NET_ADMIN)) {
  1407				err = -EPERM;
  1408				goto done;
  1409			}
  1410	
  1411			hci_pi(sk)->channel = haddr.hci_channel;
  1412			break;
  1413	
  1414		default:
  1415			if (!hci_mgmt_chan_find(haddr.hci_channel)) {
  1416				err = -EINVAL;
  1417				goto done;
  1418			}
  1419	
  1420			if (haddr.hci_dev != HCI_DEV_NONE) {
  1421				err = -EINVAL;
  1422				goto done;
  1423			}
  1424	
  1425			/* Users with CAP_NET_ADMIN capabilities are allowed
  1426			 * access to all management commands and events. For
  1427			 * untrusted users the interface is restricted and
  1428			 * also only untrusted events are sent.
  1429			 */
  1430			if (sk_capable(CAP_NET_ADMIN))
  1431				hci_sock_set_flag(sk, HCI_SOCK_TRUSTED);
  1432	
  1433			hci_pi(sk)->channel = haddr.hci_channel;
  1434	
  1435			/* At the moment the index and unconfigured index events
  1436			 * are enabled unconditionally. Setting them on each
  1437			 * socket when binding keeps this functionality. They
  1438			 * however might be cleared later and then sending of these
  1439			 * events will be disabled, but that is then intentional.
  1440			 *
  1441			 * This also enables generic events that are safe to be
  1442			 * received by untrusted users. Example for such events
  1443			 * are changes to settings, class of device, name etc.
  1444			 */
  1445			if (hci_pi(sk)->channel == HCI_CHANNEL_CONTROL) {
  1446				if (!hci_sock_gen_cookie(sk)) {
  1447					/* In the case when a cookie has already been
  1448					 * assigned, this socket will transition from
  1449					 * a raw socket into a control socket. To
  1450					 * allow for a clean transition, send the
  1451					 * close notification first.
  1452					 */
  1453					skb = create_monitor_ctrl_close(sk);
  1454					if (skb) {
  1455						hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
  1456								    HCI_SOCK_TRUSTED, NULL);
  1457						kfree_skb(skb);
  1458					}
  1459				}
  1460	
  1461				/* Send event to monitor */
  1462				skb = create_monitor_ctrl_open(sk);
  1463				if (skb) {
  1464					hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
  1465							    HCI_SOCK_TRUSTED, NULL);
  1466					kfree_skb(skb);
  1467				}
  1468	
  1469				hci_sock_set_flag(sk, HCI_MGMT_INDEX_EVENTS);
  1470				hci_sock_set_flag(sk, HCI_MGMT_UNCONF_INDEX_EVENTS);
  1471				hci_sock_set_flag(sk, HCI_MGMT_OPTION_EVENTS);
  1472				hci_sock_set_flag(sk, HCI_MGMT_SETTING_EVENTS);
  1473				hci_sock_set_flag(sk, HCI_MGMT_DEV_CLASS_EVENTS);
  1474				hci_sock_set_flag(sk, HCI_MGMT_LOCAL_NAME_EVENTS);
  1475			}
  1476			break;
  1477		}
  1478	
  1479		/* Default MTU to HCI_MAX_FRAME_SIZE if not set */
  1480		if (!hci_pi(sk)->mtu)
  1481			hci_pi(sk)->mtu = HCI_MAX_FRAME_SIZE;
  1482	
  1483		sk->sk_state = BT_BOUND;
  1484	
  1485	done:
  1486		release_sock(sk);
  1487		return err;
  1488	}
  1489	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
