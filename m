Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2042.outbound.protection.outlook.com [40.107.247.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDBA1527A7
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 08:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730449440; cv=fail; b=lnVkgQQI3HMUsiqgVVKspMzc4SVmJJKDx87E3eeVNWKJmvP3HJrir+2GqEhcYJLJXeDemwgN4q1zxJK3nrQpblSAzXaQiKHNu+zuLo0LQmvG41QbcDMYqX7CQriXu+Wp0cV7nnp/cWW5gkhfZfhovy5iK6UOabMUSj+5O/wEi3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730449440; c=relaxed/simple;
	bh=eMDCRcRqrQ1CzV0rNTahCYBPa8ceUnG0ByZhbEtGz3M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eC3L4hUm+k8HGf5TlnOQZQRuX+8/XnsoIrGguZhEcSRsgdTaxBNjZI+AXIejNbEYtwEZ6nBmgJLvL0+k6XXiYt03WTdk8T6V3P304IwcFCyu13I6NMJzvRZe1oPv0AL4NMvmyzIE+xfmP9AcSDtpxgLOAtToDzBjaU99fQXvAyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OD/lsJot; arc=fail smtp.client-ip=40.107.247.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OD/lsJot"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7lcXcVb1vh5B9mgsT3RMkhWwaNUdbqM1+nBEECO0pN/82cr24VIZGGM2HPZtjvqg0JrT21RS83taDgpOGgY5FzdXMi9LZD5uyRNJYlBK+vfN47Fs6tlY87Nh0SyWjDQNb8KYBOJVXWepwl/QKg1SHHxHaFdXdxYujtci/EnwgbgxxIiydaK5xod8IeSDNMmCJ+H/KiMU13ezWK+qH2DVdpLcjCOFhGqEXbhTmpK6AffC/re4W9V2Dj4eusnDwlUtR/1o0e08hwhSnygczRKQ1EvWmItPpCTghDti9z5z9hLpf3Gy1NqlnvNJYvih5DuSP6UOzk8WJipjfbt1mdJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eciZcsN2SGB4DJTMwL9yepsfBe9bGmROlS2BNz/7dI=;
 b=v7p3i4GDjO1tGgP4EBqqhTB9vqmkMPQbU5ASf6JeLSA6N8CjBJKt/9VF3I2yJYpXYDX7f4PGRhLbdfgtTOk4IMMj+Li9U9ohswy5Fro9AuANjWje+Dp7a536RgtNwA1iA1uJRxcP23E/6vvVINOZ8lY11jKV5B21EczRecHwd67Jdk9AsuXNW5etJKEr91sbzb2mvVbUPfhblOWQqXp+EEO66+ek5LXf3Wci76TZNZdC+k4LOYVmBQYMPkfowhPy/A7TnR7XJG1U0qY9ogXcezpvOgTrsPeuF3UqMJRrZCPzelW56tLjc5DrSvc+I7Ghd/tL/4aCPnqepbWDJ4kMpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eciZcsN2SGB4DJTMwL9yepsfBe9bGmROlS2BNz/7dI=;
 b=OD/lsJothUcg3OL4qnCy1Vr5iVE4eVP8FfJnRdfQD3bsGTVrOfhmi4gnhD/lbHlj/VbDw64setU+7IpJoqxvS6Tx03JAgwpifRhzNKcg3a6Ar/RzaW87S9b0tlaN5vslkspR19r4vKCrKdtzch7DDbBFX25ufEhmuHxxdE+pJHKlR49Ws9kcOpVvNge4l/UYvo7H9qrLHzF0Y6QE6VUT1aW5eLEMdaX5yvyaJWGORJejQZzplpSFlJqsiu2GDHQQL8U8BTpWn6oXn6O0UAuLQx+O7zr6nIKHSOpbmiwD1nzBO2SyjPXo0VeGH83Y047dPRgAhLp/btCGnAQMx+7Adw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7921.eurprd04.prod.outlook.com (2603:10a6:20b:247::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 08:23:54 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 08:23:54 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/4] Bluetooth: ISO: Order PA/BIG sync commands
Date: Fri,  1 Nov 2024 10:23:35 +0200
Message-ID: <20241101082339.4278-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0033.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::6) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: 728edca9-90a6-4bf7-5008-08dcfa4e8645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0XiN/1qZNoRX0Eh4+aRR5GHwDXH8tXX2amqT9e2eKr6iXmz9jG4nBixSPAS9?=
 =?us-ascii?Q?4YfUuM+8bepF2AlV9t6hrlteH3jsc8XDjJ5wdvSN4EnxWTP72tSXBHeRlmfC?=
 =?us-ascii?Q?+LIWH9FSlgWENRtuoGDU0i0/2/Xk4srqd3gkeNryaydGhJLBSCvQls3gJeMG?=
 =?us-ascii?Q?Irse83iTi9feT7kvZbAp6Kc/dqe8zYP+NTtNPOhlwhQD22T0QONyM+8y+OkM?=
 =?us-ascii?Q?O/doPQcfbmZreI+40SQpc7q2V5zl7EnhYdmv2IeAW0yu/J+9nUuGpWLbPXDH?=
 =?us-ascii?Q?65HdhuNUk09vMR/J4tbKRuHrAoqgw9LGYQkx3nZoznxTfHGce8B/7cePSb9B?=
 =?us-ascii?Q?2b8vjCALvb3WatBVJ05TA/uoPberoptqKDJT37jM+7St2D5kx3BKobh/Kx0b?=
 =?us-ascii?Q?P41XPG1BYTIfrBG4Bv/69rpdC37FEYDvvFXHQgDXcnkGFg/Q5qpZDpbMEtjd?=
 =?us-ascii?Q?Qq7h2KS5x1gpi3NfXMjwnLHoQNdS0yEiF35x+D6FL0VNj92b3AOFvZ7s8TFV?=
 =?us-ascii?Q?e/FaSWQ25o7yrT9tiW/c2wYHz7Yj/WB/wnuHoTrIJFlY1qsqkfptVs7yQwmV?=
 =?us-ascii?Q?Qle9ddWVvo/M4cDADis1XtMnyrWMlfqCi3qXfq7s2Q3a3lh0e7xBClAnk9XJ?=
 =?us-ascii?Q?xUHT1l/Ck2l0fiscnQF6iozMWIvDjEiJE8CNMME0Hy/GoSilhFS3MhCM41zQ?=
 =?us-ascii?Q?2FTPYBHVjZ3zT1bUofP8aOa1vZBy7MTrN9UN2JsP8diV6Fm8vKj3cTcjpdw/?=
 =?us-ascii?Q?F5XG9PLCwTCOxhRe9D24p9vzuG56Tc4iOYDRp5+zJXct0JdU8brmuVry/Uak?=
 =?us-ascii?Q?96IGDyeZMlUIKeKKZTWPvTJzMnJSsDyM/vlH5D8zTJa7vDFueSaQUw06T2dv?=
 =?us-ascii?Q?9GpnWiW4KaCOqX6F8oQaS613JjRdKVY3t4ZFvFVCBmGjBgM10BQQD0/dXgE5?=
 =?us-ascii?Q?yDuVaSXR0mWn3nfByFdTrKmQAWRc01X0r6d8po9wpf5hgOJWH/ZTy/wh/u3b?=
 =?us-ascii?Q?vAtTJlAvVOEeBPpNJJqyTnTcQFxP8AVWE1cwm592Ozh4/9QbEETJ1gpCS2Kj?=
 =?us-ascii?Q?UsosvA7OIiewDmXJygYn/DwqkLJ2kBMnrnJoILiKHm9J6L5lrNC1pWF9tox+?=
 =?us-ascii?Q?LkkiPzYc2YJI0AO36QtuynWaTEAidwxa3hoXKcZ7A0Q0rubt0m5GZegmzwr/?=
 =?us-ascii?Q?+c1k3aD8YVExymIfMtoSFooT9L12Kd/hcBPG+fIyVJUaviEQoUmV5Qc4N8+J?=
 =?us-ascii?Q?BF+CEVAe6hlOfDtIda7tyXe6fsan1Y9+je4Q4qrUIBSAZ2uhdmUPCaIaLx6o?=
 =?us-ascii?Q?fVKXb4l+wEz7O0Dye5/mBBJ+abcFsV6XgxSHAC7zTNdA25WImWWDQXI5659U?=
 =?us-ascii?Q?H+5VxfE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/8t32qXa6bjX2TXm9IkCDlhIVOKdk/axSz3rrQTUztyyaMQqFGywoi5P92KV?=
 =?us-ascii?Q?K4SB2Hg4oiBHiWcdc93QQ9XhjV52k/J4gwxYzb7Q5Q5hkWe4UumxG13+zh3g?=
 =?us-ascii?Q?3/nO8JvjIzOpPeuVExcYirqhcKFeIiU/yk4QCdBTxX7YOPtF7bP+sV7Utbhn?=
 =?us-ascii?Q?uQDgs1tLcFk0jEFwt5ZPgney6qd9INEmANYG0A3ytl2EZCCRHbEcWxVXwH1G?=
 =?us-ascii?Q?4k5cHvInCBzWgd8ZP6yjN8oMvuWVKIYnWRVa7wYNfVzK/MFvoGCKhHwtjPX8?=
 =?us-ascii?Q?Kt7NO4kCylHPRFzFxWs8tvA3ByOwaRWnusmX/ouHstcfGA/pLO85XUmwduDM?=
 =?us-ascii?Q?xnDxRY59E9GWYpOCTmzaTnfZt752PNSUjkoOTglq6fFtg4Ml9uK0clPQQm2l?=
 =?us-ascii?Q?rNUhBPQZpnp8bskDBN48+V2SzYYzpyK4J8oGahMsmWFraJAQslD6e6Inwbqh?=
 =?us-ascii?Q?tUEFJn0EqWkKuJ4W58SmZu3RrDJzjcYb5TBhtojZH3zt8AFjcv2csDttbonw?=
 =?us-ascii?Q?YMbQfvMA/rD0pSDo95/XYxKB8mUUuA4ibD2KGc6iYsq4oUTrI+C2PH4NmEti?=
 =?us-ascii?Q?tJM2gVHlY2HjvhVfVuEHePYKQBrYoSfJrLVIwf4P6MD7dHb/6WOgf22EIPd5?=
 =?us-ascii?Q?PE6tWWPBghRHwlrPNyKXfjvcy4IwWI0EPIdHLS2etf+kzrspUakPO2JnIcZp?=
 =?us-ascii?Q?y9KmywRquak+booXCOytraExFzpFisX9LNwZkjakV/fnF5E8Wymn2RS1ZoAe?=
 =?us-ascii?Q?ZdFmIT1fyfxXmZQSPBmVsqAdKIb0a98eF/YPLt25AQHXPq9o8ByZeDNYiFmT?=
 =?us-ascii?Q?hb1wIH4hQgIoWoEik6dKq5eqcHupA7bdqbcUbmZSE+XG6ulkSkhiPZ8NlyR7?=
 =?us-ascii?Q?KeQIUIOu6Ze3YIi/5ZPDbyWCDeXEL0OW8+uz8LCHoOU1HrclQeyczHSDj7MN?=
 =?us-ascii?Q?zcaAxZj9hlElD61RJ+iv8fff4HV+HSrUcTW+F+WXlMxnaWC8qeD9V3/LnDfz?=
 =?us-ascii?Q?Xwsp3IAOIh6P/RZD7elR9kOrL6Vwj7PnqdNI9+h3QIUcwMQbWkBc4EJBQbH8?=
 =?us-ascii?Q?05l8ltixZp0SUdpJhLRTA3ahhG7diWGqZueAljxnWDzjPnJ9tvOPv/0sibya?=
 =?us-ascii?Q?QQb4yQr8TNsD5btDCwTVpdOWeeOXKhS8gtxKtxRm0guKJ0i2aPO5VH+QKu3D?=
 =?us-ascii?Q?W5cVkdyXsWS0l478S9TwhaZ4zs3YfwL4fCgLXSl2n7ycFd3ZrsfJ1G9eji/j?=
 =?us-ascii?Q?zJUeV7D9QeR7Qcap6wJFAd0QVwmC4SEH2arMyGu0IYL2o7rE9zNnFtIMRhuc?=
 =?us-ascii?Q?042h7/K4l+NZrl4N7hw/cfPggShjNbdrqG7U44Q0R6cRdX+ZjnlJpuhv0iEj?=
 =?us-ascii?Q?tiTcwUDpzHNaTiC9cUS1xnadulTNdpAiyLK71aIqmCw2ZTB9rOG7srDQg4s0?=
 =?us-ascii?Q?3/mshCPQTKhH1S+Q8PTQNSYu+M+cdaX/IWOx8uOlcacp5mQWE0viLtyBIKG1?=
 =?us-ascii?Q?ioSzX3FOwKFASQVQktlOfe0aYun85rKTqHH0+zO54qlduIrfaWwcUCpY/1hA?=
 =?us-ascii?Q?c3UoTdfNbq23mWd0FhY1bXEw+xnX8p0No8PCrKGUIyG7W4PDZ+8j7jmcJg8L?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 728edca9-90a6-4bf7-5008-08dcfa4e8645
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 08:23:54.8393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bsovj2KyvTE+oBGRGboIMPuYFy8h7+0YogEZys0SFNAxZlCnHDz7RGXcTY0/wi6QHdQLR6hK/gFXBlJzRdbBPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7921

If the Host issues the HCI_LE_Periodic_Advertising_Create_Sync
command while another is pending, the Controller shall return the
error code Command Disallowed (0x0C) (Bluetooth Core spec 5.3,
Vol 4, Part E, page 2493). The same applies for the HCI_LE_BIG_
Create_Sync command (Bluetooth Core spec 5.3, Vol 4, Part E,
page 2586).

This patch updates the way PA/BIG sync commands are handled, by
waiting for the previous command to complete before handling a
new one.

Iulia Tanasescu (4):
  Bluetooth: ISO: Do not emit LE PA Create Sync if previous is pending
  Bluetooth: ISO: Fix matching parent socket for BIS slave
  Bluetooth: ISO: Do not emit LE BIG Create Sync if previous is pending
  Bluetooth: ISO: Update hci_conn_hash_lookup_big for Broadcast slave

 include/net/bluetooth/hci.h      |   4 +-
 include/net/bluetooth/hci_core.h |  75 +++++++++++-
 net/bluetooth/hci_conn.c         | 204 +++++++++++++++++++++++--------
 net/bluetooth/hci_event.c        |  40 +++++-
 net/bluetooth/iso.c              |  24 +++-
 5 files changed, 290 insertions(+), 57 deletions(-)


base-commit: dff8a64238a3f951dbf0930bac915eec7cae8200
-- 
2.43.0

