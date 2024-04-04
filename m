Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2115.outbound.protection.outlook.com [40.107.21.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A515483A0A
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712230895; cv=fail; b=t5mFlKCV81htgTj4PI2su/txb1JNp9U/irn1snuOjV3ld5Xq2ihLsoGTR49DIUGmiTx6gXKUtXVEBdKzgWFzwnQirj/NB2Q+siPCW7HyXC1bSecWFJrcOboz9blQDe63FYoMTTy/8HS0lL95kXtAePEwO2v/uKqmAYbJyS8YimU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712230895; c=relaxed/simple;
	bh=l9sOdYXIihnKxG3b9JJ/W7PMJ7bORjYf/mwo6eYP8CY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=meLqLIGvROTtiKEJ4gtGF6egSFF8npC3GxX2DKR0rJTKfSrXSOJtXzvpUGwzZ3+PCLda4btv1CPowVaVwNjXZN9TKFVN+H7n6GJge0es8v8xsPqI9IcEd0MNqaE7kbYNOBRRvcQVfsCh0e0YcxI9tNjM/TH8zPDNX/ducSXwPMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AcXWVvGl; arc=fail smtp.client-ip=40.107.21.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AcXWVvGl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2mcnUm4rmzcy0mgQxPhXbPe+IXX9ucVFDqZMC699v7DykdEhAZS9+rpPUXFyAxM5Wxg8sgOtgcWP+vXZ2MaPGJ5Be9JvRu5mREsoSIt4Ekl8f3+gHRg/npGg/jfxwbE2R2lQ8ZzT8cTwJn7IWROXEZvDXerYdI+rAWLYXKcWMRUAUFXPAVEWyAQQ1DEY5uQjtpStQ/OhTe38hPbim8IUt7eKSwhlnG+iurcjDQy8JchsbNtiy6LMvY4B5sCUFFalVTqgOOKxjogeQKyxwiqxC7ljpQrS4Kyxnm4rSDHQ8U0lA0BtjuJ0BPyXUXutf+xW87wSLX55MoiduIiXibFzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hda8y0MGDXQi3/w8040VUnrydqBquzD20ZLwcx34OKs=;
 b=NR0aS1v7xdltWr2sxUQbOnMoPjPfyq8DnINlzW2UVI5FBAqSRe+kh0JHt9sMIAj8+v2shDO00g2WcLjUzW4cDibH8/gyf+xSkKrPDadWQhyPth/pjpfjmXMdWRSj0HRDXZx4TBHzEebhUg1LHdufQApBBENO7+I78psbkTUlc8ik2lIDBAMQWmV2F6nmF0NujWSUkRdDi8JNIy+MIW7wCEGZDZH5nUzeJKM4hybOqf5LrKyt2xZVZ36RM7GLb8EMc7eiUvZ8j4pzidxd24y/0DYSKYPnfxOp7NLHUFQ5xUQIwDmWU3hx86spnz/2qVzUpQx8ANEju/AT61THCfnF+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hda8y0MGDXQi3/w8040VUnrydqBquzD20ZLwcx34OKs=;
 b=AcXWVvGlYHxirfIB5KZcsIwCOfufeGyGt8jgbVQ+rq8tIkep6waOU7Divm+26gEQKLBcaYjNJfrvGQ1rQVFC/TZxR1GvX+8O6DQglvCNxO2tAIWU7Sw55wugjJQ9RgJrtzqIkJP0Xk8B1iaWx91migcnL3Ik0x243rDVTV+n2Zw=
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com (2603:10a6:20b:654::9)
 by PA1PR04MB10443.eurprd04.prod.outlook.com (2603:10a6:102:450::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 11:41:27 +0000
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::5fa0:979d:f0e1:a28e]) by AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::5fa0:979d:f0e1:a28e%3]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 11:41:27 +0000
From: Mahesh Talewad <mahesh.talewad@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: devyani.godbole@nxp.com,
	luiz.dentz@gmail.com,
	sarveshwar.bajaj@nxp.com,
	mahesh.talewad@nxp.com
Subject: [PATCH BlueZ v2 1/1] Increase autoconnect timeout max from 16.384s to 20.480s
Date: Thu,  4 Apr 2024 14:40:54 +0300
Message-Id: <20240404114054.4987-2-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404114054.4987-1-mahesh.talewad@nxp.com>
References: <20240404114054.4987-1-mahesh.talewad@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096::11) To
 AS5PR04MB9754.eurprd04.prod.outlook.com (2603:10a6:20b:654::9)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR04MB9754:EE_|PA1PR04MB10443:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/5D612nCx1QRqgOf5L3CEljAgvQDdKbFWuCewxze0+ygNsv14wPmm/dS17/7iTYDRK1jjNSK2xz8W8NbYKn/RaU1ezkftjK7SDp45JbwV5amJxqikyOtzf2nMowSKC7wwlNOl7fXyFvwlyJfsr+eAKXXvHfYRDqYu0zXTutN78RGTmn8pFlZNPNm2y80fauxVlNUIfx7giFOnLe2OPsrkqll+adw5aDjgLD7H8hDv6rQeINAP4iXMHC70yC6e6nFUjhfs2bLypc5kVHX/3BPHoSkcLP12PgUx1C1cDjmVl7NDiccu92JqV3MPtqq6YK/WPoeDVGoXsrbCfb/SZwHHFjQPMNMifiQPAsbWwmjYLOLZJ0cI+1rcVsFfBfi4PV6ATEA/n7KTOJk+PTm0n5l1JGdQMPonz1PHhqveCKX8sGBieD6g0QBXVJvz4SBwhiNrjyFruroIcP6yO2TBmJ5E/gzHZ72/AiHXE72aH47Zcd6lAAN1nnQrFPIChgS0oYV75rkeKcSwcoVNqFyPXT/CgGvYPxHSPT7kpCNQedWkEAXZtOnyCmEx4iob6juGcxuWxCuC/lsyTpT4AjbE59Q71jAbnE+8P3W1HVKCHTo5rVDoqOC+tUi07qJORIiWpEUocmbmoUW6H8uDTVwUSgWsFKQdJ7o6Z75WjnrF73qbJ4Aj1R6xSUFe5Q8P/jscU6seLLFZeGVfimAjbgmlLoLXQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR04MB9754.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ljnfFPufk2iOhSE2j7n29gOknRCpFZibs5kLVINxVk1peHVQ0TJNQUHKBDyo?=
 =?us-ascii?Q?zxZEcrIGrGCXMsIp96mSEK2uLhk1uixdf0pjjNtQEFwm5BVZnn9yz+0kcvaA?=
 =?us-ascii?Q?tC0mo3GfVfKSykBD8mvtfAQj7a9FzAfsZKd9OSB/xXQORZ24RJlsV2xNnYL8?=
 =?us-ascii?Q?3ycgUPswy14EcwUAZp1qoFjehrBDE7ty7sth2Gd6qYPasVn7SMW3m/JbN0PT?=
 =?us-ascii?Q?45461vKZe+NxNS/ieB7uKBXAZpVRnYqdd2tv+8S2sihsVvkkVwCqCjfLE5Gn?=
 =?us-ascii?Q?nKGQMjWH83pHNX+NjYwT1yvIA6RNQwJZLiXtMFqg1ZeU6jQCw6Yz96IVcMk/?=
 =?us-ascii?Q?VW21v6UXtzHZnxB2rarXAY1A5Eq29CUGNlsRf3rXC2/yGAy9CM0GI3HIAqPI?=
 =?us-ascii?Q?IYxwU5sfrFBvw8Rn4QbWoxNC/y0SPy6LglL/Nc9Lp21qEKU59MzBQE9cQE7b?=
 =?us-ascii?Q?d14iP1RrO8j/bHgQlTE6Jbia8p98IG2/ZokcbkSlIvHoVCxFO0j4olTg/n9R?=
 =?us-ascii?Q?THwhZgM80zm+58WCCeO3Qt1DigxoNv5OmdAgZ550CvrvuVGQVQ7hBQAlKSOP?=
 =?us-ascii?Q?qokT2CLqQ4DVseRtXwMRjfN1tz4A7LoGp/RXI+yeZ19le1Ky8dfGx8zhHj6D?=
 =?us-ascii?Q?c4pwdbzmwdIDz51wCcm7SwM7Q7aKMjO3ZN5iKya7aMtA0QwAe+6d3Ie3G30k?=
 =?us-ascii?Q?F/fhGVluneq/IkFAnLgjKnRTYx27gVLvHzfIkf3bBTrYvyqxork+iv8LAP7E?=
 =?us-ascii?Q?OquRJSayRN/gEp0jZMHFEcHl7/9b0ERy7ShEVIAEKPFZFSdtTVURckW/aj0r?=
 =?us-ascii?Q?HAe/7zBQKdmMAiG5JAble/laoU7ANN1qMBUk8xU0Ya722pH5BodMNuZPYWym?=
 =?us-ascii?Q?HOaYsMz7U5AQ7Suv1wkRDBjw7JjN+mpLWAJjjRYjB1amlx5vpYkWBhfSq74K?=
 =?us-ascii?Q?eR2RZmKsWscDAhBad6rZzvVBlrnNOvG2F0NawbH/wXaFulJgKhk5m3RqVPhd?=
 =?us-ascii?Q?iKl3JaWqPsiJbBf9ykw6oKhS4yzIyvJzSMLewhmeG5zjTMP85cCKD0EOQhky?=
 =?us-ascii?Q?dMWBu2kLXARI9SnMx3DulBZJA9LoWQoYzDQpk9XEeeJIocFg+kabqkdm/FR5?=
 =?us-ascii?Q?5Rm/JKNK073PAscAmc+tvgewLWo2k5xMAt7fmSmHIN2wo46ljA0K8D+hMJ5S?=
 =?us-ascii?Q?O6BHpcaufA1iNNeZufYB+YRaIvWz5mAwxZWMc/XWnf/mDQUTNT1bk6NvE9Kf?=
 =?us-ascii?Q?rN1dtu1lPFsa5SE23iOE6c/K0CiOHz48sNkwAmCshfpIjDBxQDhCf5z1sRR9?=
 =?us-ascii?Q?gXA3KvIRAmGVMji08go+ya5tgMUpLx70/OZbWS+/bGDtmZ5kQ8f3fuQnunmR?=
 =?us-ascii?Q?fznBSJWZmfbByqpcWmXnk/bG+TRRQwRtMsfW7BsAwBq2BhkfJYNbqyWWPqZa?=
 =?us-ascii?Q?pbxLno7F4nQoqt0lmPgNpXDpq/Oa3MckQNQwngdY9K9y9JdeOiGmczyTMoVF?=
 =?us-ascii?Q?Jmp8KGMx5B9D99bNUURcUHj7cGlH+boWOOaNjwRy7jqv9dEf7Va0AXlYrPpE?=
 =?us-ascii?Q?9tcvuKNzytcKVEGGrlzb2bX4P7RCPPPlKKpl6yVfg0xmN7VpIzXjYYI+vqbB?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f591f88-082c-45f1-07ff-08dc549c29ff
X-MS-Exchange-CrossTenant-AuthSource: AS5PR04MB9754.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 11:41:27.8482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pXRRuvxDiCMq9Y0DqXVPtwawXwYnedFL3/x6ncEpRp7ynYUE3F+tJI8jraB1+UhGGYU+NOQHhl69w9DmlIzgow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10443

 - In current implementation Autoconnecttimeout max value is
   16384[0x4000] msecs.
 - Since some controllers need some more time to respond to cmd
   'LE Extended Create Connection' hence increased this
   Autoconnecttimeout max value to 20480[0x5000] msecs.

For ex:
- In some controllers, If we include LE-Coded PHY in the initiating
 PHY List, BLE INIT scheduler selects the 1M and Coded PHY scanning
 as an initiator in round robin manner, and due to this available
 bandwidth gets distributed between 1M and Coded PHY, and this
 results in longer time taken for connection establishment by
 the controller.
- If ref device is advertising at 1.5 sec intervals, with create
 connection timeout of 4 sec,  the controller gets only 2 opportunities
 for the connection. Without the inclusion of LE-coded PHY,
 DUT takes ~3.8 sec for the connection establishment.Hence as described
 in above point  with the inclusion of LE-coded PHY it is difficult to
 achieve 100% connection success with the device having
 adv interval of 1.5 sec.

Hence increased Autoconnecttimeout max value to 20480[0x5000] msecs.

Signed-off-by: Mahesh Talewad <mahesh.talewad@nxp.com>
---
 src/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/main.c b/src/main.c
index f774670e4..081a388ad 100644
--- a/src/main.c
+++ b/src/main.c
@@ -657,7 +657,7 @@ static void parse_le_config(GKeyFile *config)
 		  &btd_opts.defaults.le.autoconnect_timeout,
 		  sizeof(btd_opts.defaults.le.autoconnect_timeout),
 		  0x0001,
-		  0x4000},
+		  0x5000},  /*max val: 20480 msec*/
 		{ "AdvMonAllowlistScanDuration",
 		  &btd_opts.defaults.le.advmon_allowlist_scan_duration,
 		  sizeof(btd_opts.defaults.le.advmon_allowlist_scan_duration),
-- 
2.34.1

