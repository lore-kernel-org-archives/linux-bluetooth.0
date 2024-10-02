Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2080.outbound.protection.outlook.com [40.107.104.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7C11D0174
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Oct 2024 13:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876130; cv=fail; b=WlB0JHEDqnrmhmSwtlrcGQDENfM3iUwOsQ+GqH+qb1j8e4obSsjWpATuML8TqgHlAEDM5nafgB+6wVloo+Gnfvz6WiVyO1yZPrlXkHFs5u1vp1nHC4FHyhw+yms9xG3Ymn9cpJ5Mi7iHfv9mRHw67jYfskDypE9UUj940cFZm90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876130; c=relaxed/simple;
	bh=S8MVyFHZ6U4GzxvUDm+dPXh/VidishlUoVm25uHHW00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HEwOUs9MpKJajzQUBKTETMtMei4BZ7yVQyoGpjti7qCDdBhDrVwK2QFGxfMKit9eTDfI4iH5GibufdYQB19Xk1EHFe+XQiYhur7n9KbMWKTpO2SKJtHgUqu8rBlhisZaCKCuXGyg9DeNLoA4qAhE9DWiZIFZxFm58KY4vW7Oswg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HFfJ45V5; arc=fail smtp.client-ip=40.107.104.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HFfJ45V5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLfDyqFZfov3capxRR8RMXVWe2mG/jcZje8dFbud0EhFDSAF8VXWKdpuNdnGRo0lofPIfExuKi46DhyD/60pe/X4W8lzr/NIdOTG0Dpvjpfy0kQPyXCiGOZtaS5qNAJIkvqXO7HzUwx7xuHMorB2NnB32JsbrmGt7jHURUFfncgI2645zIddYBxO7SbgAgbCb8XeutaAnzxrqu6es4tM+UoziejsZxritDm2tF3g6+jQR2Ns70pf6UoGMNc939pu2oj46aVKGqSp/786cEN8C05vyh8TVDb3cTdc5W7Z03+5MoI7EgrWHyEgg7t5cvTZnGNSs5Bu4hXBHMJpICMHJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zg5X605sku1VsOOAx+CcnB04fsXedGYON/d6EcXzHPk=;
 b=hlZYshlpKFh1rq0ArvwprdkNRG2nPJ2CZthaPWSsFBflVXijtF2+1v0Bi9loLB9ScdQ+AhV+fbNpHXzt/DSK021wDRZ9RDizqElZmViwByTkGu6dW5dxxSjx6xSjY6ICyFe2w0wQJ9DF4g8qsu4zqh/zK8OgDZnGGC1wbmPrR1TXDKoWQeKb4jyrtWTBmNChQ2DfDUUzK8Q37jh0p4mt2zAil16ES82ZeivzUYo83UYxk5moP8t5w5UcOQ0YicB+2j+naILSVJ+/T72ktrtHBujwfIf0viCOY3NT/MssveXknQyWgfMysCeYJ6Tw8TDlKH1DlG3hRiUJzVCe57W6wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zg5X605sku1VsOOAx+CcnB04fsXedGYON/d6EcXzHPk=;
 b=HFfJ45V5Fu/1dPTIQ9+f/3hokmSrRVTjFPvQ1XGp1UmUyG+uIgnpUo/ZgG19McSyjX1EDWLOqah12V3WvLgoUPRt4afkgykOxUvWtrV9bEAP7wwPBZR27GdIax0/voCjC47CVGY+q5MEiQ8sy91kHK+N8r5RRLYVdTzFgp27SnuXua3v1IFQDc0ZUa58l1nrXf8hOvEZFDdX4fw/E3Q5XTyZ1ZF/KSaZcOh69xG9HrvtLYU1EWlQn0erPfyvVnJ5loHPUTjvTA5lJSfkQCs2PM8/PnFd6lYKNP8VfLFq5n/MPk1/rMb1mW+JO3xOLCTWCCQmOFV+385HBthgc9reLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB9365.eurprd04.prod.outlook.com (2603:10a6:102:2a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Wed, 2 Oct
 2024 13:35:25 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8026.014; Wed, 2 Oct 2024
 13:35:25 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] shared/bap: Fix load of misaligned address error
Date: Wed,  2 Oct 2024 16:35:06 +0300
Message-ID: <20241002133506.16834-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241002133506.16834-1-iulia.tanasescu@nxp.com>
References: <20241002133506.16834-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0027.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::37) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB9365:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b0547a9-aed8-40c0-1f31-08dce2e71276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dktgrUXPGs747IfgZFLjavvqVZhRow5xvTUpXQ2QWb3VY1hVL+jxw1dhEeHG?=
 =?us-ascii?Q?xuQA7ZOdHpBU6F2LzwfITSZ1Wtz9l+HPi0oNE+TJXpDXenYblC/I1ISJL9JB?=
 =?us-ascii?Q?1JHgRVmDpAqjZKyT78hlhKZn0qnW+A+Z8sQBjjpZSZD3TKZ7p6UTi0SmVTFd?=
 =?us-ascii?Q?3cPcyTSxJD/UUR2XYFmbbzM7zsm2rhDyFxdylDBS1JehYHKmzuXpEGBG748m?=
 =?us-ascii?Q?PCiwnqykvoViIZFxSUPuUkRRVEj6DGdi4uhFOtSe3Jnzo0hLwGKb7tW4CzlS?=
 =?us-ascii?Q?PtOUOlVhbqLByRsIMdxkuO4nAqjJ2+/kkXqSGY1scpUpDJw6U4wy5dm06oTX?=
 =?us-ascii?Q?JOpBhhNhWQYUPvE6e/h3bBbFilcapLXIGG4qLc4f84U9zQo7U26BYYc6RqfS?=
 =?us-ascii?Q?iF+Tkcy2kspn+nIKUh9LzL4adUejypfF/rTUTSo5XhSkj0ampdHsGB5HROyQ?=
 =?us-ascii?Q?RZORK6h2K9TnulWarE0HCNfBZ1LjVzLnjvGRxyAGwMnXJnCYpmBa+55FYYC3?=
 =?us-ascii?Q?G3KzTOagpNrE+eEmTG6EEvQp0zJAZEvscpXkNn6pUUyxvFSVoT0Og39W+WMB?=
 =?us-ascii?Q?9JnkvR8q8o5nqTbNtMVRmMTpzMtPGFa1dha++szfJVt+ilDkcp2saC3ctDzP?=
 =?us-ascii?Q?94Exlmd4t9dOyNxAZXOKbBKwTO5kPyFFTwULw9qkNLPs7Cje+yL7H+hEbGny?=
 =?us-ascii?Q?cjfcLLTXm5Dlj72yHcARmQwUW9stLckyp/lle5WtXeitI0dRrQaakmSEwqQN?=
 =?us-ascii?Q?loEbMTf6Bz1Rav2Jv7RyjAZU/2+tzT9TBmPkl7gUlfpMUpfm3hngcmkQuocH?=
 =?us-ascii?Q?2GX0981NIw+FaDt9PTlsqQ4CGNkxI1qq65wVhJdbwe4BFucEYmOFuTuOPJLT?=
 =?us-ascii?Q?cIdjCVpg3meQrx5Ct8nHA9wnjXi1lWNuSvmT7+s+HqUyOxIJBig0LZo8jEes?=
 =?us-ascii?Q?cGtFm5BeNkihvdW1lVO5+9jeLQ8d0nJ7+OK2gxixgRLWMaesF/kxrTLoqYdH?=
 =?us-ascii?Q?1RdadIfIa5b9XOFVZ04jOdGhp3HMUqrTsyTJl/xSZ8lHqaCyKxX+sBg4kGUH?=
 =?us-ascii?Q?8wj1LLS7acaErINCUcDCCTbdEvUII0/ROATwo8r+P/1u3QIRg65eg0S41HPP?=
 =?us-ascii?Q?32+Oq4bZw7BI84or9KmF+mGkI6xG75EIkfEU8mCusQxSSBPkbHwB5+6XcBzH?=
 =?us-ascii?Q?5QVsiReiKf2Sl93sKtNHhCDSCYFwUCumw0IhrWHuhcb85898oBpebnm9zLpV?=
 =?us-ascii?Q?jIiK2e4UVXkOnI2KX13nmAG7okTLeuCpnnTATPC62fZ0wis4pdbEYtM1spRJ?=
 =?us-ascii?Q?ATdVUdLg51TPWhuguxL6ftksY+y5hCum9VlRFO8iqEyZ1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y0AQJA1+b3ZzwibmvorGbqTsJgiYMu27u7QSLmko8wugvSPh5Xmn/oyU4duo?=
 =?us-ascii?Q?lxmxyhiNuJIJm1KrInzYsj3aeG4q3PTj47HELiPr1klbrQ6uD9xBx0bof17e?=
 =?us-ascii?Q?rHLDjmdc/El1O7g3jcAPOx0nE2c6ZMl6nrvpJDZCnEh+9gRcWcyGxqJOG7YP?=
 =?us-ascii?Q?LygrbOdbJwh3ZR8LJBCsRdQPWdl7vUGGBW07hjY4vgSBHGEt7IInD+1yz4d7?=
 =?us-ascii?Q?4qz0kvJc+FFbBfg86IWSP1hHXb8i0kVmNcy3pn+1/gjhoBrr4rzaUNYHnIPn?=
 =?us-ascii?Q?nY1fvw/cwNZZbrHkpdo+XbGaGE9+8O3+L6GM/VDN3kyUD2m7G4ifo60lmT84?=
 =?us-ascii?Q?AeM8fSMNclx12hYZCBGUw00lfxeNcXAMSfVv2SUdWewhZjC8GbHPpakUw/Bn?=
 =?us-ascii?Q?Bb5FsCOco4UUMjgzywieF6/r3I+hHbNDt6chmvzCDS9P3xnCY7zbJmsFxoV/?=
 =?us-ascii?Q?MP/WUFaX6Yr+ADDU6Np6jrcwxcwYERLI80jnj52/xVABxglzPB/mveQU6wcA?=
 =?us-ascii?Q?vB9jS2OkxHBDW8cYyUiBVP2YITtZnS4es5gPQ7sPcRG+fzZ8yHSWC7eXCu5f?=
 =?us-ascii?Q?FvPSYg+m4HqR2WRPIeKRraqUuIt3IwaCOn3yD7BXiJRexaSDIcBxPakPbB80?=
 =?us-ascii?Q?sDFBtTLYPxW9gCy3BEZXIZ0Pf0ZQLOIlvSFyFugS0F2rbHMPHfhxkMgNMuXM?=
 =?us-ascii?Q?IGvBz6cvrj5a48XeKlndb/v5Mq1uBS9oxRa+MimSY1b/d8pIurcHDpCMYWBJ?=
 =?us-ascii?Q?r1f3ZwDOrVRKdwHbL2eXIGHHv+31rIp80sweoEjLUWp+IxqB5VgJ7LjToZsl?=
 =?us-ascii?Q?lUNpfyO34TCVBL4qAo98G69pcMV9BkzmZEB3nfjdVLM4QFJVxvwGfXLvJiYI?=
 =?us-ascii?Q?RbNcSfhkuod9eAlZjdFXGK+6vKZh7IR8meA8K7oJCNDYh0YnbHw+aEs/84Qm?=
 =?us-ascii?Q?NoAuZXZt40AZmCAx88ET+ltHEhYPNGzb6xmEbYSNmjvT3i+iwkFrzFRqSbS2?=
 =?us-ascii?Q?Ty3U0QDCZ3vFjg2T7HDVTGwpNKBGf11WrwKOtysQ//EpSq+nC1lKqNFXca0K?=
 =?us-ascii?Q?CLf/mWQUe1BD8pTx6bxRxPpS5Jg5YX+q5kjgjvrr/L7LMcTyIu78x9AfWzcL?=
 =?us-ascii?Q?8jMLa2Wjx7ePM3UlOlgshwRYDopXr8PSYFBoRvmmdqJK4VuLR6Yhr3jUPYA1?=
 =?us-ascii?Q?6vLAt7wS42+w/GncvKkRLKVSF6eddvgyvQHzXFx5fHobXDoHTcIzeACpjlOS?=
 =?us-ascii?Q?oh+Qoi80W/SU5qscDEeKV8jT+yhg2JBlfOzFIuJqwsCBvM6K+S22LkDwit1y?=
 =?us-ascii?Q?7uO/KgtSDhJ3OWBn1NvC+BPgr1qawMBgPQIe4eFoEa4xxozUz6ycUHcRUn87?=
 =?us-ascii?Q?69rvxd04+ztoFuMqOCA5nudHP+99xQdiwnxIqjL6CWBvufskebV+vXwDG+3m?=
 =?us-ascii?Q?Ilwmt1hIrsIkc6M0hMGKFGB9B2p0Tjw21TWvMqA2cuy0BwFiLEbLesWeTC4I?=
 =?us-ascii?Q?yh3UlFoOl6Dx7gH9OtKGcEaBMyYGH/NtVq7O68TgGPsPS27PioMTnh72Pa/E?=
 =?us-ascii?Q?QFFkE+CkVVykEFH+MHme/KO8+Tom0KbQx8KN1cNd0xTlp/+yknCj+PzBUWKy?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0547a9-aed8-40c0-1f31-08dce2e71276
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 13:35:25.6692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPhbohIJLT4TvC1/ooRNkMLclCrmuq9C1EbBlpB7KnUpI93N1Cq/94alFLQZi6kz7+rHc/5aXZ3ziACsW6lt/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9365

This fixes the "load of misaligned address" error that appears when
parsing PAC caps:

src/shared/bap.c:6497:7: runtime error: load of misaligned address
0x502000063639 for type 'uint16_t', which requires 2 byte alignment

0x502000063639: note: pointer points here
 02 03 05  04 1a 00 f0 00 02 03 01  02 11 00 00 08 00 00 00  a3 00 00
              ^                        00 00 00 00 00  01 00 00 00 01

src/shared/bap.c:6498:7: runtime error: load of misaligned address
0x502000063639 for type 'uint16_t', which requires 2 byte alignment

0x502000063639: note: pointer points here
 02 03 05  04 1a 00 f0 00 02 03 01  02 11 00 00 08 00 00 00  a3 00 00
              ^                        00 00 00 00 00  01 00 00 00 01
---
 src/shared/bap.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 72f0f8a03..00c3b9ff6 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6484,8 +6484,8 @@ static void check_pac_caps_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
 
 	switch (t) {
 	case BAP_FREQ_LTV_TYPE:
-		mask = *((uint16_t *)v);
-		mask = le16_to_cpu(mask);
+		mask = get_le16(v);
+
 		if (mask & (1 << (bis_v[0] - 1)))
 			compare_data->data32 |= 1<<t;
 		break;
@@ -6494,12 +6494,10 @@ static void check_pac_caps_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
 			compare_data->data32 |= 1<<t;
 		break;
 	case BAP_FRAME_LEN_LTV_TYPE:
-		min = *((uint16_t *)v);
-		max = *((uint16_t *)(&v[2]));
-		frame_len = *((uint16_t *)bis_v);
-		min = le16_to_cpu(min);
-		max = le16_to_cpu(max);
-		frame_len = le16_to_cpu(frame_len);
+		min = get_le16(v);
+		max = get_le16(v + 2);
+		frame_len = get_le16(bis_v);
+
 		if ((frame_len >= min) &&
 				(frame_len <= max))
 			compare_data->data32 |= 1<<t;
-- 
2.43.0

