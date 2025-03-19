Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7509A252912
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742380712; cv=fail; b=BkJJPnYrPt243sVf1zlbreDpMgZcdPljIpYD67GYeKWqoNNBOr1nb7ZNmzne2pdgOPEJzowFpDJhg8o841crob8k2lc1WNycterU03h87QCSuMv1u4GrWDYOXcrXvgednWgBXpxICk8FgVfDdZGjCa5IWSuFrRgB9+3fn7Huxg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742380712; c=relaxed/simple;
	bh=/FYWtueBur7TBQtEwvP2ONG0/3LY5wONG3uhzJRa5Ys=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IyvpIe7+ZNAP3bo5arZ0P5htW8G9VyVSC//Rc+54O1hGbiPEvLhwp9BxVVb4Sb+BnCwr0LqJZH3dVDSFa5xGT30OH3s7x6IDqEbG9BjU4j9vJBoCCsQ6ppl/GVZSgn1TKUxcEZg2s14abMDF6br1y3OMTEebbNAxVHiVRXiysqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=fwGi6eQK; arc=fail smtp.client-ip=52.101.70.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="fwGi6eQK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0pMlkjyV15JJYEr09Uzi66auVqjrda1m7E60jkaTxHfjinPGh//1l6YRe14Ug9vZqlhewRDqChmI8dPFFkAZwqwuM3spkRvuD11FJ3G07RAvhVCAOiZ35CFUMljAKWGrZQVqJOsbeR4UoC1Ru4WqVAHiKG3ut2koNFstn4ajDsDvva+t1O9ZDAGVGfvb0fU9EuZXpmHOF9FkATCxm8ukDjS1ZlPMqiH6Qzt1l/97ppxGfjQ0oEZhtWojrTmZcQjFUINeryK7zTP+Ry5KPmiKun0QoZcSybLICEf8UHXCSsysqz3VWMHAHBswZA6IATKY0ImcGP9JCh1iT/FIUla9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOyfQDC2SaaZBKJP1grO9/Lwo8Fyb6eTUFMKlmtD8dc=;
 b=WQAypOIgl6O60dG7fFLBaVyQKHWMXHURM97fhAuOZOSNnqBdhLA//TMQ15Q9tofnYMKUJBCpnFNdW3VF6qtdon6dsCbk2aiRV49MxeUKF8opC1I70TZC6nwXwSosExyNZGLuasXZa70r6yX5/rLkMOEjofaXz8bphI25iEoe4NmQpMjDccpUGiKezXCWDiVfi7zAXRDuJTqRoy6BjfJ7JAhNuczUmEyDON/uabTodGlxqmRHxyGPsivHEH+ihAOXaQIWlxkgrQE8LwbEKm6gikhFPUnHUH4+pF4ZFG7krcTRAGMIu8aVl/CpxbaQnp3VlEkJRW+DuvD9dEu/T6P0Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOyfQDC2SaaZBKJP1grO9/Lwo8Fyb6eTUFMKlmtD8dc=;
 b=fwGi6eQK3ViWOWUZopUTqPQzdb/jn+P5hELNUTd2feS+UeN08evCD00tpDdwCCgjxKXTijS78sbHSOh3f7MAACUQlohFxY1Y9g6HXOj8dWIlpLzTYMqOU+8RsuNAEqnmzoGylOH9LlnvTuzWx+lEZe/BMgot+yngg0HSqk38J7Q=
Received: from AM9P250CA0021.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:21c::26)
 by DU0PR03MB8140.eurprd03.prod.outlook.com (2603:10a6:10:353::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 10:38:22 +0000
Received: from AMS0EPF00000190.eurprd05.prod.outlook.com
 (2603:10a6:20b:21c:cafe::23) by AM9P250CA0021.outlook.office365.com
 (2603:10a6:20b:21c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 10:38:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF00000190.mail.protection.outlook.com (10.167.16.213) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 10:38:21 +0000
Received: from N9W6SW14.arri.de (10.30.5.20) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Wed, 19 Mar
 2025 11:38:21 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 5/5] shared/bap: fix printf format mismatch
Date: Wed, 19 Mar 2025 11:37:24 +0100
Message-ID: <20250319103724.10433-5-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319103724.10433-1-ceggers@arri.de>
References: <20250319103724.10433-1-ceggers@arri.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000190:EE_|DU0PR03MB8140:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec7ec08-0be0-4424-2ed3-08dd66d22ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kpnD2a7t9+tsaaLLYznPOPDMPd24D7B07iR5cax6RAus9LTFYKvmVd8ZInOO?=
 =?us-ascii?Q?M6cpQBmt+YjlhmHy5ElJBzeU2Y1GlJFsstnaNw/maFxxlJJlR7pfelnQc2Ho?=
 =?us-ascii?Q?SYGkgWkTTTFRhYCaTeYxrJqm4wTszuJ7bs8+ThWP7Qm/aAv7R8g82GD2xo+T?=
 =?us-ascii?Q?QviRxMMInuHzhiL47y0ovQ7hh4ReFFZHZc861ghIXCsoeVkiKzFTZ4eY8EMV?=
 =?us-ascii?Q?ju/fXJUk7LiFDKlzT8Oo+QlOrKlLOeIY4e1mnkIx1NLNqpHgaWPuc/szjFFO?=
 =?us-ascii?Q?1wcVqa3Mn2gRB06nZkCCZ36U1CFJoKLSpw+VlCJF6lS15BRodl2H4leJ3V3y?=
 =?us-ascii?Q?othSlvui+TBKa8qaDbOHNWu4YGCDyF4/AW3pT3bzyU8We9oQ6aIRFm32/Iuq?=
 =?us-ascii?Q?RDMwA/D1yGMwYaPe35dRMDDs70jisKJsfqExkTNvrbA2NqiE5Lp2DRTCjsM9?=
 =?us-ascii?Q?pdI2iPwKGsYzJqzadQWGkTLcKWCN/DUlT99XKciiKYJqCdTxD7R+8AZM2/e4?=
 =?us-ascii?Q?T9UGSbcF3Tuz+Ds40Ey+0kIG1Me4zDp9pZOuBPrVJQW1SPLUsSDmFK2mt6jR?=
 =?us-ascii?Q?Hatw07QEbfBi8ovDIdGSRiTfuz3vd5W29nCn6QBxvBpzyUj2de9pkbVXzhUl?=
 =?us-ascii?Q?DhAj6O1zMBimww/mVhQx3Uf8oaw1VoepGy4NMUJT2w+31lrqG9CZ5/mr+84F?=
 =?us-ascii?Q?f9c1db4k8ehWpZPvIzh/Tp7fdWLW+22xz64g/gY4I89u/2feu9p0GUmrVW8m?=
 =?us-ascii?Q?12XjefLKVkDadCxT7RTs1eVx8Evw+487FO7AnKVSFEt++yDREwP4tWQPtjjV?=
 =?us-ascii?Q?oJcwdiZxg9ua6UMbim7TAHrWYgfbRgjDYpOCDUewIMqecA2VcxmwW72cVXJD?=
 =?us-ascii?Q?vxo0gW+1TKz3XUppyDfn3uEpcx7Zet++npYj81L29EAKZXI7njOCWFskIxhO?=
 =?us-ascii?Q?z/FjWQhNsdLWDfYpoASFxNHo0SwGxTevfhHrki9djChL/TTx8pokRKvDbAow?=
 =?us-ascii?Q?SqY9ooM8xU4THeY6gU5z0TWa2DAO3v7xiJeRxU6yJFcZfkMRCKKlQbOEslRR?=
 =?us-ascii?Q?yphsvn70mlYGLvItndhVOJzRvjEgCAJOphDKDunNmkecsFb+SoO2pNtogQ+u?=
 =?us-ascii?Q?aKGMqu+FKbkB4w6ZnzqOKQCDcmr/fxnKO16LZvqgQrQQIYaNxelk7WHeCCaN?=
 =?us-ascii?Q?9TeMlQW1QGFaqaH5Sfd+Z902F+h69irZEoMAxpaQFLxTMSDcu4OTRR7u5wWN?=
 =?us-ascii?Q?q6WIiaNiINB2FOwfzjgvP2//BZqdSp2nJ3NTASJ+aljirQtng+04U2h6ZMbc?=
 =?us-ascii?Q?xhci5/Tqpa5L9HexdmZFai9w5bIGO7r3Mzy1sIKQBtYHUq9BjUaWhpqCJnrW?=
 =?us-ascii?Q?v/E6ui383ukB09J9RjcSPUEGf67443zg4GnCD2axkBICZgNKTiReE/oQeMwy?=
 =?us-ascii?Q?ezLdRbx4x3I=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 10:38:21.7486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec7ec08-0be0-4424-2ed3-08dd66d22ba6
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000190.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8140

struct iovec::iov_len is 'size_t' rather than 'long int'.
https://man7.org/linux/man-pages/man3/iovec.3type.html
---
 src/shared/bap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 1cf0fcfb9b79..5d4d69d2925b 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -7313,7 +7313,7 @@ bool bt_bap_parse_base(struct iovec *iov,
 	uint8_t sgrps;
 	bool ret = true;
 
-	util_debug(func, NULL, "BASE len: %ld", iov->iov_len);
+	util_debug(func, NULL, "BASE len: %zd", iov->iov_len);
 
 	if (!util_iov_pull_le24(iov, &delay))
 		return false;
@@ -7359,7 +7359,7 @@ bool bt_bap_parse_base(struct iovec *iov,
 		l2_cc.iov_len = l2_cc_len;
 
 		/* Print Codec Specific Configuration */
-		util_debug(func, NULL, "CC len: %ld", l2_cc.iov_len);
+		util_debug(func, NULL, "CC len: %zd", l2_cc.iov_len);
 		bt_bap_debug_config(l2_cc.iov_base, l2_cc.iov_len,
 								func, NULL);
 
-- 
2.43.0

