Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43020C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Mar 2023 22:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjCTWuG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 18:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCTWuF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 18:50:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B6223649
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 15:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679352603; x=1710888603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JgQS1F3wYa0FlxJrgU1mmVVbhshy8+BlyBvEm4DNbws=;
  b=FtYUHWGPmSpjrdlbZxTif47AAI3Shh2c5tb4YRdAM22+plRZpR7m1rR6
   wO1Y5zfDnR8TrIu2zsL5NYmen6DI7gcjg34cMjANNBtdyeA9y6AMAydUC
   +sd86piAu0mExTWDmh3iTONE1QREUCAxThh4W6doIJQgNBIKt/Fc/gVfj
   J3lfAyN+2LVGUbLYoGOLuNaU8GJlgRb32GC/Zo909Uzcp1jjSAxN9ylRr
   YHRxx3BxsJSr8L6dO28TiQJ7sA0naB3PqG2/Rw+6lNPv49WdPstYqxxl7
   ftGs8Ckc+xux0X6w6it7OfQSguDkZEhTL91IyhuJHOdM6sa/dK3O/gwQa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="341156046"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="341156046"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 15:50:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="770380696"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="770380696"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Mar 2023 15:50:00 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peOKF-000BNK-2J;
        Mon, 20 Mar 2023 22:49:59 +0000
Date:   Tue, 21 Mar 2023 06:49:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>,
        linux-bluetooth@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: Re: [PATCH 1/1] Bluetooth: Split bt_iso_qos into dedicated structures
Message-ID: <202303210652.rxBfO9uo-lkp@intel.com>
References: <20230320143608.25399-2-iulia.tanasescu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320143608.25399-2-iulia.tanasescu@nxp.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Iulia,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on dd41882582a9ab19938598179386b81b793b4a5c]

url:    https://github.com/intel-lab-lkp/linux/commits/Iulia-Tanasescu/Bluetooth-Split-bt_iso_qos-into-dedicated-structures/20230320-223805
base:   dd41882582a9ab19938598179386b81b793b4a5c
patch link:    https://lore.kernel.org/r/20230320143608.25399-2-iulia.tanasescu%40nxp.com
patch subject: [PATCH 1/1] Bluetooth: Split bt_iso_qos into dedicated structures
config: x86_64-randconfig-a005-20230320 (https://download.01.org/0day-ci/archive/20230321/202303210652.rxBfO9uo-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/656a3f84716d5b683951fe8c2cdc3fd17a09950c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Iulia-Tanasescu/Bluetooth-Split-bt_iso_qos-into-dedicated-structures/20230320-223805
        git checkout 656a3f84716d5b683951fe8c2cdc3fd17a09950c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303210652.rxBfO9uo-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/bluetooth/iso.c:1306:3: error: expected expression
                   struct bt_iso_unicast_qos unicast_qos;
                   ^
>> net/bluetooth/iso.c:1314:36: error: use of undeclared identifier 'unicast_qos'
                   len = min_t(unsigned int, sizeof(unicast_qos), optlen);
                                                    ^
>> net/bluetooth/iso.c:1314:36: error: use of undeclared identifier 'unicast_qos'
   net/bluetooth/iso.c:1315:21: error: use of undeclared identifier 'unicast_qos'
                   if (len != sizeof(unicast_qos)) {
                                     ^
   net/bluetooth/iso.c:1320:34: error: use of undeclared identifier 'unicast_qos'
                   memset(&unicast_qos, 0, sizeof(unicast_qos));
                                                  ^
   net/bluetooth/iso.c:1320:11: error: use of undeclared identifier 'unicast_qos'
                   memset(&unicast_qos, 0, sizeof(unicast_qos));
                           ^
   net/bluetooth/iso.c:1320:11: error: use of undeclared identifier 'unicast_qos'
   net/bluetooth/iso.c:1320:11: error: use of undeclared identifier 'unicast_qos'
   net/bluetooth/iso.c:1322:26: error: use of undeclared identifier 'unicast_qos'
                   if (copy_from_sockptr(&unicast_qos, optval, len)) {
                                          ^
   net/bluetooth/iso.c:1327:27: error: use of undeclared identifier 'unicast_qos'
                   if (!check_unicast_qos(&unicast_qos)) {
                                           ^
   net/bluetooth/iso.c:1332:29: error: use of undeclared identifier 'unicast_qos'
                   iso_pi(sk)->unicast_qos = unicast_qos;
                                             ^
   net/bluetooth/iso.c:1337:3: error: expected expression
                   struct bt_iso_bcast_sink_qos sink_qos;
                   ^
>> net/bluetooth/iso.c:1345:36: error: use of undeclared identifier 'sink_qos'
                   len = min_t(unsigned int, sizeof(sink_qos), optlen);
                                                    ^
>> net/bluetooth/iso.c:1345:36: error: use of undeclared identifier 'sink_qos'
   net/bluetooth/iso.c:1346:21: error: use of undeclared identifier 'sink_qos'
                   if (len != sizeof(sink_qos)) {
                                     ^
   net/bluetooth/iso.c:1351:31: error: use of undeclared identifier 'sink_qos'
                   memset(&sink_qos, 0, sizeof(sink_qos));
                                               ^
   net/bluetooth/iso.c:1351:11: error: use of undeclared identifier 'sink_qos'
                   memset(&sink_qos, 0, sizeof(sink_qos));
                           ^
   net/bluetooth/iso.c:1351:11: error: use of undeclared identifier 'sink_qos'
   net/bluetooth/iso.c:1351:11: error: use of undeclared identifier 'sink_qos'
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.


vim +1306 net/bluetooth/iso.c

  1275	
  1276	static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
  1277				       sockptr_t optval, unsigned int optlen)
  1278	{
  1279		struct sock *sk = sock->sk;
  1280		int len, err = 0;
  1281		u32 opt;
  1282	
  1283		BT_DBG("sk %p", sk);
  1284	
  1285		lock_sock(sk);
  1286	
  1287		switch (optname) {
  1288		case BT_DEFER_SETUP:
  1289			if (sk->sk_state != BT_BOUND && sk->sk_state != BT_LISTEN) {
  1290				err = -EINVAL;
  1291				break;
  1292			}
  1293	
  1294			if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
  1295				err = -EFAULT;
  1296				break;
  1297			}
  1298	
  1299			if (opt)
  1300				set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
  1301			else
  1302				clear_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
  1303			break;
  1304	
  1305		case BT_ISO_UNICAST_QOS:
> 1306			struct bt_iso_unicast_qos unicast_qos;
  1307	
  1308			if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND &&
  1309			    sk->sk_state != BT_CONNECT2) {
  1310				err = -EINVAL;
  1311				break;
  1312			}
  1313	
> 1314			len = min_t(unsigned int, sizeof(unicast_qos), optlen);
  1315			if (len != sizeof(unicast_qos)) {
  1316				err = -EINVAL;
  1317				break;
  1318			}
  1319	
  1320			memset(&unicast_qos, 0, sizeof(unicast_qos));
  1321	
  1322			if (copy_from_sockptr(&unicast_qos, optval, len)) {
  1323				err = -EFAULT;
  1324				break;
  1325			}
  1326	
  1327			if (!check_unicast_qos(&unicast_qos)) {
  1328				err = -EINVAL;
  1329				break;
  1330			}
  1331	
  1332			iso_pi(sk)->unicast_qos = unicast_qos;
  1333	
  1334			break;
  1335	
  1336		case BT_ISO_BCAST_SINK_QOS:
  1337			struct bt_iso_bcast_sink_qos sink_qos;
  1338	
  1339			if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND &&
  1340			    sk->sk_state != BT_CONNECT2) {
  1341				err = -EINVAL;
  1342				break;
  1343			}
  1344	
> 1345			len = min_t(unsigned int, sizeof(sink_qos), optlen);
  1346			if (len != sizeof(sink_qos)) {
  1347				err = -EINVAL;
  1348				break;
  1349			}
  1350	
  1351			memset(&sink_qos, 0, sizeof(sink_qos));
  1352	
  1353			if (copy_from_sockptr(&sink_qos, optval, len)) {
  1354				err = -EFAULT;
  1355				break;
  1356			}
  1357	
  1358			if (!check_bcast_sink_qos(&sink_qos)) {
  1359				err = -EINVAL;
  1360				break;
  1361			}
  1362	
  1363			iso_pi(sk)->sink_qos = sink_qos;
  1364	
  1365			break;
  1366	
  1367		case BT_ISO_BCAST_SOURCE_QOS:
  1368			struct bt_iso_bcast_source_qos source_qos;
  1369	
  1370			if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND &&
  1371			    sk->sk_state != BT_CONNECT2) {
  1372				err = -EINVAL;
  1373				break;
  1374			}
  1375	
  1376			len = min_t(unsigned int, sizeof(source_qos), optlen);
  1377			if (len != sizeof(source_qos)) {
  1378				err = -EINVAL;
  1379				break;
  1380			}
  1381	
  1382			memset(&source_qos, 0, sizeof(source_qos));
  1383	
  1384			if (copy_from_sockptr(&source_qos, optval, len)) {
  1385				err = -EFAULT;
  1386				break;
  1387			}
  1388	
  1389			if (!check_bcast_source_qos(&source_qos)) {
  1390				err = -EINVAL;
  1391				break;
  1392			}
  1393	
  1394			iso_pi(sk)->source_qos = source_qos;
  1395	
  1396			break;
  1397	
  1398		case BT_ISO_BASE:
  1399			if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND &&
  1400			    sk->sk_state != BT_CONNECT2) {
  1401				err = -EINVAL;
  1402				break;
  1403			}
  1404	
  1405			if (optlen > sizeof(iso_pi(sk)->base)) {
  1406				err = -EOVERFLOW;
  1407				break;
  1408			}
  1409	
  1410			len = min_t(unsigned int, sizeof(iso_pi(sk)->base), optlen);
  1411	
  1412			if (copy_from_sockptr(iso_pi(sk)->base, optval, len)) {
  1413				err = -EFAULT;
  1414				break;
  1415			}
  1416	
  1417			iso_pi(sk)->base_len = len;
  1418	
  1419			break;
  1420	
  1421		default:
  1422			err = -ENOPROTOOPT;
  1423			break;
  1424		}
  1425	
  1426		release_sock(sk);
  1427		return err;
  1428	}
  1429	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
