Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2040.outbound.protection.outlook.com [40.107.249.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AF61B395F
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731667126; cv=fail; b=VyZYzEanTkRW8nrMd0zpKLSn1nBr9hgIN2irklXv2ZtTtwo6O08l9PTAAF+uzGBgU3DUPQwNB0a53RdV4+tb6wRQyjGYFHiPS9TFZdGSzoCFbPCTHkKYIhxdgjq35SeWDbLATIFcRiLbA0f7Ih/zE9NBaJybtTNpCPK0jS2WV4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731667126; c=relaxed/simple;
	bh=X2xniRXMkv+9g0J+1c0zuZqK7CNSU/MD+HHm0GgBMz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hFrlEmBpxbsVpwg9J4kO+dtRyEeOn0+FfVtEL0ngxvsJIqd7T29qoRfvVp/bc/e/j14Vp61XpVeSaZAYZfJFw/RwV/VGoKzV5PeTItVCgCEg7FNkAy4kLa00593jG9UK1VBAJVB/e3dI0NjBPv/F+7lY6egDLJMIa/l4IZMg6do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ANBi7pEm; arc=fail smtp.client-ip=40.107.249.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ANBi7pEm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZi7deLh8eJOTCp02MjJzKlS5WZbyrZpBAsCbQM87EopOebydAxOO5zHme8P2JSuBurGIEKhzOkaDkx8SqSWCzLm+kCtprTwGGJl41Y+h66bCXJlq0apWKwcd5trSlhp/A2ybT/P/CyU24l2WyQkc4kQUg0aKA2cWZTm7gZO2vC2zt8uqa/XpXMmuwtCwn5mwcPZvWTfli4o2gHTRnvq+cGQPSFGGZCGHb7iS6TCGFmnP97436sovw7mwnoLy3IBzDrTOjoz/Tpbs/MA4VLAsGm5r8mh/cNiij+HhWENHwdf84Mjh6hWf1XqkhxYGwVSoMhn2QS6+PgIPQPtPjg/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcrZJh1RhZ+GNE7Doep2ScydcWMjfplntHedbZn1P7Y=;
 b=M426Zi49ISB9xXCXo4/f87bHpjni43LNJ8NbEuFzTFvLzxChtWMGFkxRlEZoEalr5qp1UL52/TRzuWGwa6D24OQpA7jPpIa0+woTiJyl24wrLAQur5BIpzxs1QW7K7kmW2X7JPOIUFyzQimnBCv0LyGWSfG3HI2aAJAilRlREfi/l5ivGgxY2oOUSvJ/vDlWryrhYD7xQO8BjkNMjrbv5ROaLK1fSgN+ZFVfHzqpS5EIsOEaW7Zr5506U5zD2xo+zEaRyR04l786mbfm4ztPJa0Kloq1+ioe4E5JsmAVBS0C3j/28eZxoHeyOnpNxDIuL/kr371qkMXMMFOs8587jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcrZJh1RhZ+GNE7Doep2ScydcWMjfplntHedbZn1P7Y=;
 b=ANBi7pEmDHL/4Y9TRX5a07eqQvNJWfRCBwo/X4/JdHJLjrlX91euoH4i8GoUEVX+cbg7sGUuskN9EQpq9MDUAvMla19AkkIxcPuMaSDMXWofLyDnupK/nnSZvFvRzmprCTAW977AG56aFFluhg9BbTnrH+oWG3iVatWAxW4yR7XvjQxMg8lEoyjTTlbIYjMoDhvp60Mmrv9rwFBoVr75/aEE8pU1RgwOF8djt7KXYfLt6bhQ34rrb3xs5KEH8cFmDG35CLzYippBxjJ7iaQNhcc0XF0lmtjQBaxZY/2dF9YxwXygFhUYpYcECeyCTp/vBuivttuRUZy03TCqkP1kDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU2PR04MB8776.eurprd04.prod.outlook.com (2603:10a6:10:2e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 10:38:41 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 10:38:41 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 3/6] bap: Add helpers to convert iso_qos to/from bap_qos
Date: Fri, 15 Nov 2024 12:38:21 +0200
Message-ID: <20241115103825.19761-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241115103825.19761-1-iulia.tanasescu@nxp.com>
References: <20241115103825.19761-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0014.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::14) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU2PR04MB8776:EE_
X-MS-Office365-Filtering-Correlation-Id: 231e932c-5d4c-484d-2db4-08dd0561ac23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q3c6sYoabQa/BJ6PBp44EPAH8OTmiHjSvB8VZ5QkavuFjneMybAILFey5Ybh?=
 =?us-ascii?Q?zvVNKyJkOr8bUS3l09OJVyTkTL5fV9QmcsZlEFPXC1byJpQFq17B777+27PI?=
 =?us-ascii?Q?LYoG5Av9NM1PfsYFXNmObjZ7UCt2cOhrPzSj+KBLdG3VDRZGJKBu+WJdV1PB?=
 =?us-ascii?Q?mDIZhcnlXQfcDFKcckzVxMSH6SQi2KK1/jfbcP2T6lsYPP7zpf9zx8r4KnnX?=
 =?us-ascii?Q?F8/XRbeZd7ZHHTQ1zXXBrFlXpHIB97VwD//98pbrLTxLgjXBmU1d5uD5dAGm?=
 =?us-ascii?Q?aa3KBlOSvQ9GbSGdxPjc/AI9QAuvgtnXu2aivbIGg49UUK2FMGb5rba+hf5L?=
 =?us-ascii?Q?3V+0PBFnkkTt5JzFgweVa6vXE+M/RCehEtMu1NHGBB5w4C9y6xkM2DZ8Vsd/?=
 =?us-ascii?Q?/RLksC3f2I23vs/bu3Vs/xgkd7sHcpVRowhaLpXpaDrgtlZUOf2L+8HbgmZR?=
 =?us-ascii?Q?ZRPs+rgROTbEjx2jG+9Aujj9AgcfcKX0OotWt4WJorsnIT5bS8SUx1u3ReNp?=
 =?us-ascii?Q?NlI7sBzxEWn8P+3zI0uMxc2G6DM9ymvjco4efhskJIwOrwoONrSAvS6oz4x3?=
 =?us-ascii?Q?b76A4y8aDVSTS4V8gW2X02wJ0SpxbWKyi2LcEjHQWH8K5CbMKmVMxgKmrNEE?=
 =?us-ascii?Q?xTtEIiUMg36zXvN/Rdc0yGWadacgcxFeFUffdsI5jdDDr0I8zL4yip1le7dF?=
 =?us-ascii?Q?DRk7xjettGIZK9wivBuorqzwcEKlQMmc3BBUpzd4O5aBJQYJMnxIuX+TxLHF?=
 =?us-ascii?Q?+fPBf2wGy8A86B57m0xYVb+ZEHiEuIjWy6Ai7Fzj3NN0xrTNW8Zqz57JNXZC?=
 =?us-ascii?Q?WEnGmK15zaoJTJwnB6lkBBOjwkRuuXYLs3f2XVaanmfqf9gRwYQkKSnforXr?=
 =?us-ascii?Q?sIiK3WZSYBUoA+u2rJlDU1grrqW35kHD032WFAEToCsmHyJZAiozpwoNIZZx?=
 =?us-ascii?Q?9GFXBYdZpoIYzd8QpEuXxqzIc8iP8ufbkc3vneLsOuGm0PQM1Z45Qg+RFcGV?=
 =?us-ascii?Q?ZuKpqdymFiN4O45+9RYc/vZS6TYUMQkU9WG2Ggyhx3GOexld8bZVM+8ayRiS?=
 =?us-ascii?Q?APe+zxMhMys5jZcaB9L208/BAYIE1D9c20V2B2Yxtx1vzwwfcL4wLG4lGzwu?=
 =?us-ascii?Q?RQEWgn8mGJXXrbzAF8S40y3sGPP8KDxd7RbSO9L82lWGzYH6D1yzZy7qcflu?=
 =?us-ascii?Q?b2I++ZpQQj93SdEzsQS9p7GyDv+KJhBRVaM9PcYCTpVRg53CbLWcQxZWqViQ?=
 =?us-ascii?Q?aMHuWwvvBj2Is1/d4D9+R7FXXrvbIlDNbKpMXQeNqAIQOJkLD5hrfTVvychY?=
 =?us-ascii?Q?pcUK8xlSB5kkjGApF5UcZsXn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mae0fKFq1Ai7EwCYbXoEEmoEUMD/+o2B2GuV9TVVYB2bjR0nHEjbJFxajL/M?=
 =?us-ascii?Q?cWRFZrBQAf8NBimiYm2QaJm6osVnTl6u4gP/aUghZM/uxv5FLEgGNQ06iPBq?=
 =?us-ascii?Q?cz3NfC+eSorC4XP9UJOrhvOdvMO/kvEdPDLVX4EAoxtYdEFDIp9p6fyOfJDs?=
 =?us-ascii?Q?cvi1GwMQXvh+xsQHnHq3cK2tXzOkjEOLVtUvEbZFz4z9ayRWNobUF1PL5IKe?=
 =?us-ascii?Q?jje9CcyLKjFtNHFmAlgvK5l00itGiS/0uAblZ4G2IMrDp1F6Ug/q/P3ITnHf?=
 =?us-ascii?Q?rQWTsA/FGLI0lsV330Uyu7ctt06bKYjhheb+YiaOO0HBTWHpRv35R0xem2Tz?=
 =?us-ascii?Q?Xa5A2xv0xQx8Gz9cBdl86vCUk1rvktLh97oF2Yn0RdSvjdc9HeYpPtuBfnO9?=
 =?us-ascii?Q?hXEMIaDBwlK5qGceDRpTAurWFHIuAmkXm+bO5IbfD+zmWHPjV6UqEIBQZyNA?=
 =?us-ascii?Q?NvrYYtRdzucx/e7apj0+Kliz2J8ApfnVtcqdn3dmw8MGi66VUypFdOs9wqo4?=
 =?us-ascii?Q?FqGj/p64BRZ7bJoX7H99YbsE1M3gYLf5yl7WVRSDrIcVfUClLpqkzDmvHtqH?=
 =?us-ascii?Q?MJuMwkYfWtaMVZozVZ86J89+sq8DMMUX/4GI8T/bnfB8CmpqMwldYBu3mHoz?=
 =?us-ascii?Q?otF0iH0b4uRoN5JP/EE9eLIEmFCB3P/kvNXzH/c41ZLfGF1IQtg+G0K739II?=
 =?us-ascii?Q?DqezMINdsmHn83HKY5NQhUk263HOlKTEMdpRrEihaxFGcbxUL8jzbwT3XgHx?=
 =?us-ascii?Q?D6zihYNoYynQqHxzMBp4N+3Wy6X5uA66pIJF5XG7TVFmmj+o0o7BajfX/5H4?=
 =?us-ascii?Q?61gprqc9MKZrFoefgvsE+Y6lTMiHBd8DQvENsQtaKFPhsmsHWwI8Dp2YZHi8?=
 =?us-ascii?Q?FDibVV0XxBVIb7KYi/kQvlSp+cnNhVBUfnb7pXKiNlMD01YmYLEqKVASmg9B?=
 =?us-ascii?Q?P38dXBSfmQlXyqvh4NTpydjTAqoKyumHqUkwZWh6wUB+rXvVscc4PmYKP5vf?=
 =?us-ascii?Q?LyQo8H3WfgIiNX5FrQOKS/SKEJUUHfyWp9YozIRNAZOldODFVeibGJVFHNyN?=
 =?us-ascii?Q?P3KJTopKpSzeRYrKgBCpun2rrnd4HmCEArAOg85NuVDuyBFysEN0mIlN3De5?=
 =?us-ascii?Q?nfn4yS3I3eUNSpNgZij1yFukhR3vbRaQqdpsmM7u6FbH8NvaeoLpE16jCOwt?=
 =?us-ascii?Q?Nec9fITty2eyV/ttqd5dcyVC1/phRwLPmJySry1tcxcdIhR+oYB2JMCx8o+B?=
 =?us-ascii?Q?Xbuw0sFx/dspAPyJjqRqzTN/YbK6yZi8gVbcxsl+xlIqfq21lQ2Wn7Ik0Oxd?=
 =?us-ascii?Q?fQT+x95LBLDo3aZr1YngNFjjDBKpJse7NZVLeLpcC7AxoYUmJNdYIjVCiLKR?=
 =?us-ascii?Q?K0X9s3Kk27jOIAhTB49irj0QlZqYtJK9WUa/yzpRqcGTxQsa7TaGl7IV1iwp?=
 =?us-ascii?Q?MprxjidyfE2zh+ytAtN2ZJm70yf3b2wKI6cyQZzSAAfxDCr6isb9H4PY4s77?=
 =?us-ascii?Q?s+JOHHKdDbvASCHZK8FDCHIVvIGUhbCsYjEjap8wNu8BrpGhyvo/TvAXtoyB?=
 =?us-ascii?Q?sO+DkZnPuB3X+uS7e4ED39FCBO9sPiMGDG05myJdwiLukRJxn2JRkJ/QyHcH?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 231e932c-5d4c-484d-2db4-08dd0561ac23
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 10:38:41.6904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A2pc6ToCPwjXdct7J82gT01GYUWEz1yGlhct3Fn/ZJ7hcau2q9ktvWKktByy8x6+fZ+lXiXt1CAs7xPJeQDqPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8776

This adds public BAP helpers to convert iso_qos to bap_qos and reversed.
This is needed for the BASS plugin to handle the Scan Delegator (BASS
Server) role internally (to create/handle BAP streams when receiving the
Add Source command from a Broadcast Assistant).
---
 profiles/audio/bap.c | 93 +++++++++++++++++++++++++-------------------
 profiles/audio/bap.h |  5 +++
 2 files changed, 58 insertions(+), 40 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index dbea59776..8635c383d 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1041,6 +1041,57 @@ static void print_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
 	util_hexdump(' ', v, l, user_data, NULL);
 }
 
+void bap_qos_to_iso_qos(struct bt_bap_qos *bap_qos,
+				struct bt_iso_qos *iso_qos)
+{
+	memset(iso_qos, 0, sizeof(*iso_qos));
+
+	iso_qos->bcast.big = bap_qos->bcast.big;
+	iso_qos->bcast.bis = bap_qos->bcast.bis;
+	iso_qos->bcast.sync_factor = bap_qos->bcast.sync_factor;
+	iso_qos->bcast.packing = bap_qos->bcast.packing;
+	iso_qos->bcast.framing = bap_qos->bcast.framing;
+	iso_qos->bcast.encryption = bap_qos->bcast.encryption;
+	if (bap_qos->bcast.bcode && bap_qos->bcast.bcode->iov_base)
+		memcpy(iso_qos->bcast.bcode, bap_qos->bcast.bcode->iov_base,
+				bap_qos->bcast.bcode->iov_len);
+	iso_qos->bcast.options = bap_qos->bcast.options;
+	iso_qos->bcast.skip = bap_qos->bcast.skip;
+	iso_qos->bcast.sync_timeout = bap_qos->bcast.sync_timeout;
+	iso_qos->bcast.sync_cte_type = bap_qos->bcast.sync_cte_type;
+	iso_qos->bcast.mse = bap_qos->bcast.mse;
+	iso_qos->bcast.timeout = bap_qos->bcast.timeout;
+	memcpy(&iso_qos->bcast.out, &bap_qos->bcast.io_qos,
+			sizeof(struct bt_iso_io_qos));
+}
+
+void bap_iso_qos_to_bap_qos(struct bt_iso_qos *iso_qos,
+				struct bt_bap_qos *bap_qos)
+{
+	bap_qos->bcast.big = iso_qos->bcast.big;
+	bap_qos->bcast.bis = iso_qos->bcast.bis;
+	bap_qos->bcast.sync_factor = iso_qos->bcast.sync_factor;
+	bap_qos->bcast.packing = iso_qos->bcast.packing;
+	bap_qos->bcast.framing = iso_qos->bcast.framing;
+	bap_qos->bcast.encryption = iso_qos->bcast.encryption;
+	if (bap_qos->bcast.encryption)
+		bap_qos->bcast.bcode = util_iov_new(iso_qos->bcast.bcode,
+						sizeof(iso_qos->bcast.bcode));
+	bap_qos->bcast.options = iso_qos->bcast.options;
+	bap_qos->bcast.skip = iso_qos->bcast.skip;
+	bap_qos->bcast.sync_timeout = iso_qos->bcast.sync_timeout;
+	bap_qos->bcast.sync_cte_type =
+			iso_qos->bcast.sync_cte_type;
+	bap_qos->bcast.mse = iso_qos->bcast.mse;
+	bap_qos->bcast.timeout = iso_qos->bcast.timeout;
+	bap_qos->bcast.io_qos.interval =
+			iso_qos->bcast.in.interval;
+	bap_qos->bcast.io_qos.latency = iso_qos->bcast.in.latency;
+	bap_qos->bcast.io_qos.phy = iso_qos->bcast.in.phy;
+	bap_qos->bcast.io_qos.rtn = iso_qos->bcast.in.rtn;
+	bap_qos->bcast.io_qos.sdu = iso_qos->bcast.in.sdu;
+}
+
 static void create_stream_for_bis(struct bap_data *bap_data,
 		struct bt_bap_pac *lpac, struct bt_iso_qos *qos,
 		struct iovec *caps, struct iovec *meta, char *path)
@@ -1050,28 +1101,7 @@ static void create_stream_for_bis(struct bap_data *bap_data,
 	setup = setup_new(NULL);
 
 	/* Create BAP QoS structure */
-	setup->qos.bcast.big = qos->bcast.big;
-	setup->qos.bcast.bis = qos->bcast.bis;
-	setup->qos.bcast.sync_factor = qos->bcast.sync_factor;
-	setup->qos.bcast.packing = qos->bcast.packing;
-	setup->qos.bcast.framing = qos->bcast.framing;
-	setup->qos.bcast.encryption = qos->bcast.encryption;
-	if (setup->qos.bcast.encryption)
-		setup->qos.bcast.bcode = util_iov_new(qos->bcast.bcode,
-						sizeof(qos->bcast.bcode));
-	setup->qos.bcast.options = qos->bcast.options;
-	setup->qos.bcast.skip = qos->bcast.skip;
-	setup->qos.bcast.sync_timeout = qos->bcast.sync_timeout;
-	setup->qos.bcast.sync_cte_type =
-			qos->bcast.sync_cte_type;
-	setup->qos.bcast.mse = qos->bcast.mse;
-	setup->qos.bcast.timeout = qos->bcast.timeout;
-	setup->qos.bcast.io_qos.interval =
-			qos->bcast.in.interval;
-	setup->qos.bcast.io_qos.latency = qos->bcast.in.latency;
-	setup->qos.bcast.io_qos.phy = qos->bcast.in.phy;
-	setup->qos.bcast.io_qos.rtn = qos->bcast.in.rtn;
-	setup->qos.bcast.io_qos.sdu = qos->bcast.in.sdu;
+	bap_iso_qos_to_bap_qos(qos, &setup->qos);
 
 	queue_push_tail(bap_data->bcast_snks, setup);
 
@@ -3160,24 +3190,7 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 	queue_foreach(setups, setup_refresh_qos, NULL);
 
 	/* Set the user requested QOS */
-	memset(&qos, 0, sizeof(qos));
-	qos.bcast.big = setup->qos.bcast.big;
-	qos.bcast.bis = setup->qos.bcast.bis;
-	qos.bcast.sync_factor = setup->qos.bcast.sync_factor;
-	qos.bcast.packing = setup->qos.bcast.packing;
-	qos.bcast.framing = setup->qos.bcast.framing;
-	qos.bcast.encryption = setup->qos.bcast.encryption;
-	if (setup->qos.bcast.bcode && setup->qos.bcast.bcode->iov_base)
-		memcpy(qos.bcast.bcode, setup->qos.bcast.bcode->iov_base,
-				setup->qos.bcast.bcode->iov_len);
-	qos.bcast.options = setup->qos.bcast.options;
-	qos.bcast.skip = setup->qos.bcast.skip;
-	qos.bcast.sync_timeout = setup->qos.bcast.sync_timeout;
-	qos.bcast.sync_cte_type = setup->qos.bcast.sync_cte_type;
-	qos.bcast.mse = setup->qos.bcast.mse;
-	qos.bcast.timeout = setup->qos.bcast.timeout;
-	memcpy(&qos.bcast.out, &setup->qos.bcast.io_qos,
-			sizeof(struct bt_iso_io_qos));
+	bap_qos_to_iso_qos(&setup->qos, &qos);
 
 	if (!bt_io_set(io, &err,
 			BT_IO_OPT_QOS, &qos,
diff --git a/profiles/audio/bap.h b/profiles/audio/bap.h
index 98bea558c..ab35a3775 100644
--- a/profiles/audio/bap.h
+++ b/profiles/audio/bap.h
@@ -19,3 +19,8 @@ void bap_scan_delegator_probe(struct btd_device *device);
 bool parse_base(struct bt_iso_base *base, struct bt_iso_qos *qos,
 		util_debug_func_t func, bap_stream_cb_t handler,
 		void *user_data);
+
+void bap_iso_qos_to_bap_qos(struct bt_iso_qos *iso_qos,
+				struct bt_bap_qos *bap_qos);
+void bap_qos_to_iso_qos(struct bt_bap_qos *bap_qos,
+				struct bt_iso_qos *iso_qos);
-- 
2.43.0

