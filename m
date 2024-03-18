Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE0D38DCC
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2024 12:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710765463; cv=fail; b=MiOy8x6jXHkO5EUEX7fnsYwvukp/vw5xsUY1KyKCDhO+ru8jdPBc2vTWfzgAgEB5tNidbEz5t/f6QUsTHN5UWyrhmPCR0rMQfqbTGpXrK76YZdrwCLbzBNECKjoJFxdscHRaKXAyOpWV062Bb0eGm1iC0TsLTtM2VXdYWs7qy6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710765463; c=relaxed/simple;
	bh=VRqty2miBEaGCNneSQRY2aSqIZUqazovy2+Pv/7m64s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m7+CZ9xtsa4cplsTt7Lus4igBum1YBOroeR18sbucfa2PUjclXiFZU++10kS2jct4R9kaozhas1g4SOuJpWSQnYXj0stDOM58CrbwYKvuQ9IyWQv5UIJfo6ZKxlf2ziXqR4UbOEGVVp0bzsCWZu15nLVLV+Ut8XAcqwO8CBGRkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=eEHFK+wm; arc=fail smtp.client-ip=40.107.21.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eEHFK+wm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgaUZsCwigvdFvVLmX2mcP4cjtaJkJ5n9RO01DN0hlHvP7vl7+I0VmnNnHTs+cl7BIKYf0pR4ran6DuEG0Yc6Wd3uvPelYLtocsGFCRQzjuJDQE9mCVYsVgSQ5liwCvir/+mC2mH1s85hnxKBtloZFIka4zmocixta336HxbH58BOXXedTM77u4OeU/mh8XxpyQby1jCwcF6jQQB/D50dszI/kRo0vI+/zPtwG0T9Hwm1zLUp12eDpSiaTd9Wf7qjIZNMbo6fEMtUqfxmofM3tzS0ZB7hu2uHGdQSg/+DiBayyt6ziF/ZEiDT/iapZMH+gu3ifq8Dek0QWWaezKX7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nABPjqF3qSQlCqX5dx1Pg11WNbXQBlxGMe54BrNEeg0=;
 b=iPMvG+SBs+bPb4IBC1iqHB3JTT1gF/dyoQWVPyxLlO90/8yEoUMBB0soYkQgxXbiSrXh5LXNnNH6PtEeAGio7TLB6cjbpv4WGueKcRXDVjIojM6+r9qMf3c54cDR+v5JCKV7D2K1BkTPSrCzrVm9lIMWowBZKRIt7UC5FnswwTV4WcURx4zHg1OERYgAarKJ/U9Tsd0wXMfrjwu3IFppmvssbNk9kbPZ7lwL0YBD5PLFox4RrLDkQdw1YsadqXU5HFQy64co7Oj/6wWY4aVX81lC/5hjTtTfV4WNFzjFFm4NeZV2eYxqvXEiJtNLB2lWFlUVH6e2SFDbYTR4zSia9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nABPjqF3qSQlCqX5dx1Pg11WNbXQBlxGMe54BrNEeg0=;
 b=eEHFK+wm3GzTzIY4OA61UJUJATQ5arV9fNTfww4LKxSJDpW4EsmvQ+jf1ODTQkHSoMyuVoTsFkUUUZutPy6nABKBG5Dk4oXL+7FSmRuBeWv8L+o2FXtenAafrPWkBsTXwfXBemDQd8jPMN+8n6405NJA0KipM2AHvJCJfQfw2lU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com (2603:10a6:20b:654::9)
 by VI0PR04MB10162.eurprd04.prod.outlook.com (2603:10a6:800:244::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.23; Mon, 18 Mar
 2024 12:37:37 +0000
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::5fa0:979d:f0e1:a28e]) by AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::5fa0:979d:f0e1:a28e%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 12:37:37 +0000
From: Mahesh Talewad <mahesh.talewad@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: devyani.godbole@nxp.com,
	mahesh.talewad@nxp.com,
	luiz.dentz@gmail.com,
	sarveshwar.bajaj@nxp.com
Subject: [PATCH BlueZ v1 1/1] LE Create Connection command timeout increased to 20 secs from 4 secs
Date: Mon, 18 Mar 2024 14:37:12 +0200
Message-Id: <20240318123712.9729-2-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318123712.9729-1-mahesh.talewad@nxp.com>
References: <20240318123712.9729-1-mahesh.talewad@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0033.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::46) To AS5PR04MB9754.eurprd04.prod.outlook.com
 (2603:10a6:20b:654::9)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR04MB9754:EE_|VI0PR04MB10162:EE_
X-MS-Office365-Filtering-Correlation-Id: c02ed091-70a3-4abc-9b23-08dc474831a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	txPB1kldxcj3ZAheVrwYw8CxHOCy/yhMHBd06vjqpyC8Q6OQPww6BbA5L/6BQ63fE1ANcIj7ZxrkpmaqgZRMtaKmhj3p6YeFjZb6TqovyyWkiIMMq814PlpsAyDzgMEvEtUGu6Azrel33RgF2/ynvI+6Z8JStuCtAxRW1Q5buiZbm1omeB65U4JfAlgG05wp4dd4hGBXCAI1R9/3WXTg2djnH4lXEbVXW11yWAz95EQ1GFRLrbr2cr/4Gyq+CKJK4kSyhkXjayMqxu4QldtGZ/RyRy8hlQ1fzsCuFKxP5nYzhh+m1yZkhfCeujOODemxb59V62kpfoVgDEbbfg5Rk5OO6b1L8JK4me1snRDxoLKF2Zu6E61wFrl4uGLbqedv+ODbORN8CcwusbADBimiPv3HkvNG4tmNi+/y3aUIrvD6hFAanFCYjz9kCPMvlSGUZeHCkSgoE45gulDcW3xIK2MrdiKh1Ycl/RoR7xPl0HE26tk/JzsI0BOdf7DZYsMlqh4XoXQ0E712J4lQaiXbsfXVYoEBx6uF3YPP0AX/2LpQUVdE+RWWWdD2uITw6XQP+lLS9lIcXN8G09cE55t+Xj0+1h11hS/M4WSypRBvFOdFdjyIiAJ9ndceDaSFRJrpf8+Xqq/Jx49NXoraxAdxAhbBHAi6bNQnBJRiDWEABIyWx1wODOASOn/Xr9f9qAQ/rTsG5ZuNJAVBRmm71KVUaQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR04MB9754.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yTtKZYPv698YIdSW4CQ04re/bxq5Ay8PKef2iTfc8Ezb0ltGiLWwYLbVYu7o?=
 =?us-ascii?Q?jBlJKNelO3lthXLPkFrvpWx4ZBAynKzbeQXnoy80TpdpdsWtxt56+dZ+TEBJ?=
 =?us-ascii?Q?9ykrYvha1E0usSY03dEyR02bvHY28q1rH/rl3Lq0fM35x/mgSGr8Caf4SOYl?=
 =?us-ascii?Q?C7xO2bC9e6yxLsIBEm+bKiWpG3C3GSbuHxjx3Kgq2tsgR3HM00IcRRVgHmoT?=
 =?us-ascii?Q?XUnoGGzZI9AwzkvFs+LauBVd1WGaTsSe6/QDgy1+CWRGI0s9W2nQlNxdKc3X?=
 =?us-ascii?Q?rPhdrtaTbWte0CMZw+L9aIxBdpri/uDneRN0iKJHITK1HALunbkJK9iRJ6N+?=
 =?us-ascii?Q?2y1T7qISh3Y8j0woWrfF+odAfJudkawXSlCW8Q1fZMyOsF0zrzvw/CC7mLnH?=
 =?us-ascii?Q?GHzkIBmj14zy+aQa4/lGY76vA7pjJSUPK2NPERyP9KyhycuDzOaFpbKSaYx6?=
 =?us-ascii?Q?b5IqFZpcPr8xyEC9NI2hsyBIpt3+sqNSken77eWmvXJyI1B8WdLoq7vQuykU?=
 =?us-ascii?Q?oHibmzYPd1X/zzSSqpFkTqPlM4XAZLY5lFA/jfB1+0KGzz/8I7sYQfVnGI60?=
 =?us-ascii?Q?9FC6/NO9s/9M6aQ5w2Oo6Be7JIiG08ZldHctzns9zslsDqa10w4lImFQkWHC?=
 =?us-ascii?Q?d+FE3Gi1AgxE7qU2MHehoDwZzPjvmJyUcbKuz99Im0xodUowLN4fgSjpXQ4G?=
 =?us-ascii?Q?iiybaQWlT2Fy2G3cMM35KSNVF+XknVe2gQ9rGqL8ZrEJX5YWT75Vdy8zVXyB?=
 =?us-ascii?Q?9kZiGXDcr6fH9TOLDhExoVpzEM7eyg3pqpAAZaZ70i/7hwAV2qpslh34GZCn?=
 =?us-ascii?Q?zQ1DWuAvENpFK7y6w6ludbNvmw75mmn1xzt5v5m2wdibOfPog9R3HRF9jl7T?=
 =?us-ascii?Q?+f0rftlLN3kCwA87FhtbOfpFj4/WCmzWq9oeQza7dMlyWVC9JxS/Dpz/iyx1?=
 =?us-ascii?Q?ttuZ2/3MW/XiJcpOTuJrdjB0jYvMu1aUJr+6J0g+BCxR8WoQKFEejJ+vqihf?=
 =?us-ascii?Q?pW/pcOCdgdLi8x5eH8BSrK0u2zIRUs8JVOQfpbUgaXGHLuhHEnrAjgyhhitp?=
 =?us-ascii?Q?dUdhhc5XXQCEkrSTz7HqzGOnVDVZNFZipt1itxEsPr0mJWl2v+TFadpBTrCS?=
 =?us-ascii?Q?jiUc0hD+zTIp1+YTXq64N/APISpf7oHnFfffFLWxbtNdO/t2+2fHt+V/apvw?=
 =?us-ascii?Q?iMYQvxHMTHvFV/VwR1+JhiGcil7KIzjEmY+SD+EmqS7ENDKNje+zAaSIA2YR?=
 =?us-ascii?Q?lYS2LPumNXz7IWxBBKyn1OjAPrUKQFgKtkhSWU7+sdyKdpHV+g3VUDBcBVIm?=
 =?us-ascii?Q?lzml2GKFcIToOU895RMTmQvC/H803FNHEEDHHtjKkP4O9FmPyPxgvW1EvDHO?=
 =?us-ascii?Q?CPOCT1+1DpgQfdF5X93ErDys+4GxruHCbYUCTAfD8RWzdfHt78qnGWwTpkcn?=
 =?us-ascii?Q?22OH9b4htRkXtHflIqiN0BmS6B0oCUIt3MoPDZBsjqDkgFRMCpZt9kEj0I1T?=
 =?us-ascii?Q?NfWKpbXZiu7Z/kpBGtGA3nfT8BS+Ndr+wGbNQqNYZsqYxtbkNAWDross8Z1U?=
 =?us-ascii?Q?lIYb9Vf2nmijgWjf51id+EwiBLv9UgIUpgcBc2G3RO7QFdJPM0HcRSbf9uB5?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c02ed091-70a3-4abc-9b23-08dc474831a1
X-MS-Exchange-CrossTenant-AuthSource: AS5PR04MB9754.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 12:37:37.7235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEl5hSYQ8ELw24XMHJo5d5OHBCGZ2Um1qgySY4LGmQ+LyNLOekLej8ovTnaVyqUexXrdO21DMnCGlyLq+8njMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10162

 - As per specs LE Connection timeout is 20 secs but in implementation,
   it was 4 secs. Hence increased this timeout to 20 Secs.

Signed-off-by: Mahesh Talewad <mahesh.talewad@nxp.com>
---
 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4ae224824012..06fe5f6b9546 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6067,7 +6067,7 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 	}
 
 	conn = hci_connect_le(hdev, addr, addr_type, addr_resolved,
-			      BT_SECURITY_LOW, hdev->def_le_autoconnect_timeout,
+			      BT_SECURITY_LOW, HCI_LE_CONN_TIMEOUT,
 			      HCI_ROLE_MASTER);
 	if (!IS_ERR(conn)) {
 		/* If HCI_AUTO_CONN_EXPLICIT is set, conn is already owned
-- 
2.34.1

