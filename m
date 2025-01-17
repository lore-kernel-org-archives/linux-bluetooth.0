Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013045.outbound.protection.outlook.com [40.107.162.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5571F1FFC5B
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737122823; cv=fail; b=s51yTqZy9S+dalxlZqpc091ILq423DunkRDbCkeB+EgimFsBvcBE6zrTMAbqLdUCsDUcRON7h8WNWKXURXxen5RDOrIXN/bhfYI7qZ6zFFiX6r8P7pAL2hLB7NB7Zck1jJ2blu1NBso/OL3IEYOIMHlsGAQdk4vVJlCAbL0idPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737122823; c=relaxed/simple;
	bh=1hqs7Ymm0Zc6AMGm/ok5wrRfgBicZaqVDL9L/5u/IHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qKefQnzaTHSHf0RnKTdNA2jwprJeL7lWtRmH2v/FadTb/muQqkMOl+DyR53uMVoalb/MZWxBMO+AFwEeIAx0joRrTE3EK/MM+nCYpfmGsrQpx5DLfGTRxqhrHZJxluR1jYxWNW9221l9zzmhM9N7LmmKt1yn7S+Rv2SnPGT5V7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lbfelFL2; arc=fail smtp.client-ip=40.107.162.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lbfelFL2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ec9GUff+j7ZKwK65xDBGD/2GHHNMjRccFHQ3hHEFfSCZvouHGOVdEBbnnTeZxOCgEQxkFQt+DmX9wXajzQrHB9RdD2/w7FSkb77UV7iq7Q/rZnyXlSZ/jwrN/k3MHd9/3J9pt/aFpOui/vcawhGUVQwk2N1eFsG0rqJZ7Hqw91PL/w5y0hKPLtYZuLJegGhPPYzBqZA35ZBARG9G7sccvBfaH/vN2cbQdSX6ZEabr4l6wXd75OGn6RGk3aDjQ5yoLbUivNZ2ZFl2XXOigbYXNv/OHLEJdz8r/HnOHnHpirWHKRTlct66oMo8Wddv6tQMbwQ2x3QbsqR5lZGddWorpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8aWeYrV7zfyYLj6SwuXJh6GKyuTuC38HMeSiTDtuOY=;
 b=LwWCU05kpXBR18MqZFQm84XcIg7HmfSmiL9xtPUfR0c5jeb1JJ10fm3jZstJH/iYLqJRBzbDTIwQER+wjExn1zG4p/IvwL6y/vziMJCfF+RuyyPIFPLoBRSRfFLbUUhd4IKjdYIfJLBMfzxWVijGftZka1GyY23ckGxCt5bNjtcqbpyT+N2ot7EB+A166T7iIpmuy/6QIILLHGbVuNZ0JHvccK2S/XjaMEAL+AWUs9TRW0r9h0hcSap5LX0togeKwqbUaWOIl/8TU9c3yV/+1AVlnDoMPuRd6KNOfEm6oofZY+Ff6LnXE4cQSz8yDJ3OnRo1TJcjWwj7ikt55a61eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8aWeYrV7zfyYLj6SwuXJh6GKyuTuC38HMeSiTDtuOY=;
 b=lbfelFL2wzzCxnG6Vbop1/fjbFU98kpSTZ73h4lQlxjoIU6/glXkBqKC1CoQpmeKbPa6Xu20tIAKj1iGyycQl47Yzy1XVj0EMzMiW2zS1iOIr+Aciha0BnGRbJabY/UuC4jmgHYntqshwwgrBwlxMaUV1AyU9OZobXVZtQVC7IHZhwroLOap1RU671LVx84pRrc9lVKPTSYpFfkMyG/CycvBHA4i4eWkx07I9pXOiJyB/TCHr+E8l8HGoUo5WZ8JNnlBMYPocxpIUd6LolForL90JX3sipUtnM9bkV9TeBJZAkRLg11/1JuuIt7mvn3RhMeaAn3F/+XBzgrOAOadIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com (2603:10a6:102:20c::19)
 by GVXPR04MB10201.eurprd04.prod.outlook.com (2603:10a6:150:1b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 14:06:59 +0000
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::d39b:a5b:8f24:ae30]) by PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::d39b:a5b:8f24:ae30%6]) with mapi id 15.20.8335.017; Fri, 17 Jan 2025
 14:06:59 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/2] shared/bap: Append extra L3 LTVs to BIS config
Date: Fri, 17 Jan 2025 16:06:32 +0200
Message-ID: <20250117140632.120501-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117140632.120501-1-iulia.tanasescu@nxp.com>
References: <20250117140632.120501-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0022.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::14) To PAXPR04MB8909.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::19)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8909:EE_|GVXPR04MB10201:EE_
X-MS-Office365-Filtering-Correlation-Id: e6490cfe-8108-40f6-5e03-08dd3700354d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vnTp4ix4sux4gkYIMf3t+VjQY1FBmPhWoFBlftKLMEOtffHPwtSg2nKn2lGT?=
 =?us-ascii?Q?EU7wr8JAMy9Idu8DwzAdXnw6UZVwcVjbxfC7ZiRIVEMLioqMgdAT74z0cxcl?=
 =?us-ascii?Q?I2tRGgSbN8+2KRHdtVsVjWuC3bJHlvh6vg0z7ZrWp8mOZbUyh2tT2cRJws+6?=
 =?us-ascii?Q?BAbQzbHG3bR3r/+WbC+GGv/7hQpFcDizue7nBqpvFktDASxGY37rGcLh4lmj?=
 =?us-ascii?Q?hxuBrWrvmGMKCkxTrkWgEVvUtlwGlPslby/q57Gt7OFDrx1P3v8mBaB+VMa/?=
 =?us-ascii?Q?k51Ptk4IN5hbpbDa92CJltDJWp+u2+8TEhl+jAF+IeJSUnEZRPxy1kfcWidH?=
 =?us-ascii?Q?AttSOi2TiMMjcxCE7vn5LSYc4teHWB8Qwug3TIjutyZDszGA6v9MHc4Hy8hT?=
 =?us-ascii?Q?fEeRl1qVAnG/rx8FrHQ4Lo0/kHbiTSlgt/f+VNshGTdZdU5itIvenw58MmzG?=
 =?us-ascii?Q?qCChnB+eMoHHcAirkHBsz2cos9DplYetnTREsUtLepyry9mFXHcmOymw5t7u?=
 =?us-ascii?Q?GusWbQ3oi20OPKprh4Bnep53EN0vEcegdFsSURTCHCHIibLFl+2YYoJPD7ls?=
 =?us-ascii?Q?NCNQu6gqvxmI6ffVWf2Ed5R1IZB7XH8iEvbHmbh6Ok4pZR53Ag9ORiA8Z+ua?=
 =?us-ascii?Q?+NwueJg9XJzgr7IU0cd3AYYOzDnh3m8O8igPNXKJXvnlDJAofqLSev6I3nA0?=
 =?us-ascii?Q?oyJpzzdUqLSv4EKdpaxsL/TdPqfFU1RvENBIlx9PcDBeIyg70H1ZEsLNlK8v?=
 =?us-ascii?Q?eZmeUqMhA6BRIFsRXggvhShsjsvftKXjyCRkidTCZ3IrcZsIrABy9G5lNied?=
 =?us-ascii?Q?X9SlkJw7invJ9Un146Ir/0QlWUY+HgW6/McwPCDvDGHRsUTgtE4vcZCj/B2W?=
 =?us-ascii?Q?XLct1T68Jda4mlKF1lJCp9QzMHfhnvekQW6t/SXYbpur2R+tNdVSnQBzwG94?=
 =?us-ascii?Q?38YuffHfqjjgRoIT1b4wU0V0+GcHQSFlLpsetY3kg9ht/TuCUr4LWTcd6A/M?=
 =?us-ascii?Q?roCpSSiICtG4VKT13nuJlBhi5KeKGlzviP90mr2SV86R0DcNUfyjPmE4RASf?=
 =?us-ascii?Q?FxajGEf4TLmB8gpUmSdskW4f9/TaNdW175aQFScl6/l8QtbiEe0wVJWDimys?=
 =?us-ascii?Q?gnVA0MhSrRlOkzTEU96TQ/l5S75walrDwYh5/D4vzT570AYYnO/BxLspJ6FU?=
 =?us-ascii?Q?kGBXlWeEtNWGydKCLuu4GA8wMC31dVSrFTfq+1oC5obeW1rKlIB9Em7Z7L1O?=
 =?us-ascii?Q?EgFQouSLikceHG3Jkpc7WTiPqe4M6XwtWXNy02hDthGZBoYVGsj4hw/cQ7PC?=
 =?us-ascii?Q?UuoVZqk7RbBNBIkbSPI4VQmnyNPqSt/SEWUKqFm+GOekDS5QjVRhmBQ65xg5?=
 =?us-ascii?Q?Qnu/ZV58quE51TgtwRBMwjDRKorB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tbtxms0EaLx80eoSAILna04aok65JOGwCyvB8pZiRFep+MDqVq+ws+w9CwpQ?=
 =?us-ascii?Q?Yb4R8EG756F7+kaOXhuPDIgbBO6HHIRLvIH1vxGf5l+nHnuLgqz42hosWD1q?=
 =?us-ascii?Q?HTfkOZMdHytyBdV/RzEavKcJCyHiBjrcTOICvFGUcXlAgaGtq0eZK2h+bfkV?=
 =?us-ascii?Q?rOT+Coo8S27cfP9EwBud3yO7mD+c02BRHvsXa6diekRPxHqeDzt6k3QUTWaY?=
 =?us-ascii?Q?7YzOTIvu1mcJkiGUHaLD9n1Xzkf3DFYq0XuS9v3z11UineHcHTNk8em3OpoC?=
 =?us-ascii?Q?dJ7Nucu+79FbaoYkdzsze2AW/WpuFm93bDR0f6+Ex5S9mjnokU3CyEsHEmyn?=
 =?us-ascii?Q?mSMETNf/2kiqrXR0+SVrcLP+ZKaFepp6fOrKHUpeKGR2SPlaWPNWZIPskmJ+?=
 =?us-ascii?Q?6gN9r3cxhrR0GjhN9txn1/c+S8mhgI8hzXMl+sBPplTw6StfNd05vchzgxX8?=
 =?us-ascii?Q?XG9+BvfBrYy+ZXMZDOpCc3nI9oqaZvkWAVB5N98ZpiYMIgO+LQoAVcPwScyB?=
 =?us-ascii?Q?2bA+2IgK+QYRvVRiX5DajKOHb9dnxRdnoTCZHvIF5G+iHa23KG6FM6G1Zax/?=
 =?us-ascii?Q?rbtAfpGMKhx8NyBphXcj3ErzH2dSqPnF1uVIjBjUPtOPYkhkPPgXaORzWUKk?=
 =?us-ascii?Q?tT9usDMvRP5MDo4+yG3ABGNcGAKltcRltdtlDJFFPxcfGfsnLQcfwq25V5rp?=
 =?us-ascii?Q?Q7gCuKssFc5XrwbrDLtL1FBhCbNAAQ47WlX8DpS2q1B4RUwRysmiXRa7ignB?=
 =?us-ascii?Q?Wtoh+oBagAdVyO2Mw3FBRnsbVXB3aYHzSHryf5MiakHzneuz9EtFPl4hWaGG?=
 =?us-ascii?Q?XigWzeM64upruGO46RCdi9zWw8EKpCUQT2ugeeVeE8KdmDuBNIJ/nSwDp+hu?=
 =?us-ascii?Q?7y5GCzPJ0hBIU2UuROTrHEPP9dBqlR3yfZQX1x3q1IeZd0VxGLRGpsTVUzfR?=
 =?us-ascii?Q?ptVvlKB0EaQH4XA9QRawFiHFqTcCn24FTsA9guslB0Kl+87W0l5xhAYZ1UO6?=
 =?us-ascii?Q?a6RC7dyPJbkqyOx8LQHrq8lO2oWYalTYV9m5DTO6I3rZTkxh64/cfvNq5Rtg?=
 =?us-ascii?Q?GC9q/G2PlbCNltIrBzkSaS7W4YTRtNbvRDIi2TwfyfqEo23GlwLiiNu9QJGZ?=
 =?us-ascii?Q?guNaw8tno8LbhhozfgsIeZgvDcAXk0TJirCBhXekOrOFiN4HPrkIESZbqSHn?=
 =?us-ascii?Q?THGzPNvO2WmdPDvkjsA/9+vDt8tXDviGDD8TKE6Vav9Ejp8oKLJdDMIb42dR?=
 =?us-ascii?Q?lxurgIONCuu9q4iHHk3twgIfsuYJPIwFp/IW5me+2AYwTHqnGgh4EmmPr/VJ?=
 =?us-ascii?Q?pCtKyD6xHr5CECInHk88h3PwbvbgICoiCdNv9G/SEtJD6bfEH9i7HB4MS0mh?=
 =?us-ascii?Q?2km321mkushloVmdZ/LhFksA3iytzEeOHdbFg2/MObuRjnqv/w3MUu+cSk0Q?=
 =?us-ascii?Q?duJ8+DVKVuDyYiSl/kjO/TAhdKsAy2Ub+vjQmnmdvvQRj0FEIxVvC2WCbV02?=
 =?us-ascii?Q?JBYtirWvJN4P0ZAFGBkR4nM0k1QcpIVoT09WoI+knx2mFkt8mUOGG84MhutZ?=
 =?us-ascii?Q?OQ4bNUxAuWvhzl22pQFgW40oCjbNde4ciPa0thiUbpmhOFYjrd8C0YUCn2kV?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6490cfe-8108-40f6-5e03-08dd3700354d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 14:06:59.3487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zU2QF6l+UQZK2M7OMqjiW8pmw9EC1fByOF49S65OBBUQksOg6nhVfCxuusaEtx3t/T/g4iMjRtX8jBurEdVX5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10201

According to the BAP spec, the level 3 of the BASE contains codec
configuration LTVs specific to each BIS, in addition to the
configuration provided at level 2 (subgroup level) (v1.0.1,
section 3.7.2.2 Basic Audio Announcements).

Currently, when a Broadcast Sink parses the BASE discovered from a
Broadcast Source, level 3 LTV types that are not also present at
level 2 are not included in the final BIS cofiguration, causing
incorrect stream handling. This updates the BASE parsing logic to
consider level 3 LTVs.
---
 src/shared/bap.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 167501282..6ffeefa41 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4,7 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2022  Intel Corporation. All rights reserved.
- *  Copyright 2023-2024 NXP
+ *  Copyright 2023-2025 NXP
  *
  */
 
@@ -6921,6 +6921,24 @@ static void bap_sink_check_level2_ltv(size_t i, uint8_t l, uint8_t t,
 		util_ltv_push(merge_data->result, l, t, v);
 }
 
+static void bap_sink_append_level3_ltv(size_t i, uint8_t l, uint8_t t,
+		uint8_t *v, void *user_data)
+{
+	struct bt_ltv_extract *merge_data = user_data;
+
+	merge_data->value = NULL;
+	util_ltv_foreach(merge_data->result->iov_base,
+			merge_data->result->iov_len,
+			&t,
+			bap_sink_check_level3_ltv, merge_data);
+
+	/* If the LTV at level 3 was not found in merged configuration,
+	 * append value
+	 */
+	if (!merge_data->value)
+		util_ltv_push(merge_data->result, l, t, v);
+}
+
 static void check_local_pac(void *data, void *user_data)
 {
 	struct bt_ltv_match *compare_data = user_data;
@@ -7028,6 +7046,14 @@ struct iovec *bt_bap_merge_caps(struct iovec *l2_caps, struct iovec *l3_caps)
 			NULL,
 			bap_sink_check_level2_ltv, &merge_data);
 
+	/* Append LTVs at level 3 (BIS) that were not found at
+	 * level 2 (subgroup)
+	 */
+	util_ltv_foreach(l3_caps->iov_base,
+			l3_caps->iov_len,
+			NULL,
+			bap_sink_append_level3_ltv, &merge_data);
+
 	return merge_data.result;
 }
 
-- 
2.43.0

