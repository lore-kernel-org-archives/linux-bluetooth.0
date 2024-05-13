Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED89514D2AA
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 May 2024 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715601025; cv=fail; b=HFZPc2rLCIISSV8L7R9w/7sQwFtii8F6p7EZSm3Ubq15ZcPQ9bXkAjyXl+XwjrXGLFhgoUagBN1FF+J6qvP1ROHJfAZMOUG56N2Q9VSB4bYWMFU2vM6+cs2shSczKD2jYqEYdqmLKRT/s79Xo81GAoyaPuLojOnGH7ORqEZVKa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715601025; c=relaxed/simple;
	bh=HIjnikaQyznTv9GgqmXIhZSQHzhh4WPxJ0K9UpxYB4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MzEACNuJT+59RC0s0cD/x4QKZBZHWQWloQ5PFoqxt5wl5RnrCCFaNODbi5ZumWEre5oH5rzCnewbgUU3cbNZK/U7oni7Dd6wSLFPqMa/EPZ7w6rkzp+GEDmasVZyDWE/9M5MAjSk3Rl1IqJ6w74Jjtp4Lh1HU3eAJn1DN0g3+dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ok3ttJQP; arc=fail smtp.client-ip=40.107.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ok3ttJQP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzAhhB9KcI/o97FiDBsP3D6ip51UHvvRUnRTphIR/euskWh8dxboS510UHvaGDzOTud6mrqRZtNZDcdqLOL9AHsu7yWSW8syPpfKsTaW3/mEevuH+Yeyd0op/K2Em5kXlrsXI+AcJMblJK7FZR/AaG7CRaf1tWinNUS8GXPFLMKwy+m+s4lIdcpVajP0KrFdHzafSuOqWzb3YJrDjFNaySD5JfIbxV5l2Ja+qcc7OpxWeumholUTvqkJJcZXWGbCobyux1emjWHO6Ta87ogBr0Cm5R2bw19bYksrsaoAfLnOAqbVRq98pdh2xwDpPduwiXHMy7q7M4olEmLGBSlUeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbP9HN7skxzqNB6olgCozr9/Nc/lBFTaZJ2dEFaAfco=;
 b=QB7uj6p/8zBK11+undKSXZfXn4CEnsy9a1lhtl1c9Qq7ZTuPCf4pzNAVEc4px5rdaUZk0s5iIJu3IzV8ItcFp94D4JT+CyES8qUKU9kt4yq8eilG8EIm5+migZXMFue/WM+Bts0BhEaRN4o4qt2ESUNu/eoD0j1wBnZLNgxKUxsC2q2aSJZ28X/CeffnzYtpT7I+HBSac5Rk9QiCUhsifeFS+XtjVej2HvHRYcPFymHGf3OFH+tJJIxQwl8+LdJKIq0CMAKqoC39MXWrsCddSL5V58Zmbu3q2NDZhJ1IVyflfe7dZudaxMstuaB93Mtst8+gPQzGymJGHUGnemjRrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbP9HN7skxzqNB6olgCozr9/Nc/lBFTaZJ2dEFaAfco=;
 b=Ok3ttJQPCmPPbSzkeZ5pR0Tra76HyBA1i0plS+437EaG9jvfNbpwfyqshO7Uh+7p812rPW4SSw7KiSSf87luR7r/o5toLkou0oIzNXcYG7KjJqsYnYxt+W+u0Xi9uUMsiPowE7r+aTZJFOpD3R9vGCs/MU/0XCVGZVO09gr83ss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by DB9PR04MB8430.eurprd04.prod.outlook.com (2603:10a6:10:24f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 11:50:20 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::b7d3:ac7a:a87b:5fbd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::b7d3:ac7a:a87b:5fbd%7]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 11:50:20 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v3 1/2] shared/bap: Update stream management to avoid PACs
Date: Mon, 13 May 2024 14:50:13 +0300
Message-Id: <20240513115014.36484-2-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240513115014.36484-1-andrei.istodorescu@nxp.com>
References: <20240513115014.36484-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0028.eurprd04.prod.outlook.com
 (2603:10a6:208:122::41) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|DB9PR04MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: ad161a31-0214-45ea-1f71-08dc7342ddcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ap40fcnDcvt5AXrx4to4lN3tHB6viPle5lT+ksSpNDRTZ9EBt50yZNXe8/aF?=
 =?us-ascii?Q?NTYTxaihLCcgcRAEOpFiIEk+m43W8npAT+410EMiDDDhLsIkPetvcQ5WrRIl?=
 =?us-ascii?Q?rL/zPZ8KxbMJZYSwwo+vqfFDtoMhvYr8QER5qoVwzqbVhQFtWy88OwRzWmY8?=
 =?us-ascii?Q?hETqkRQIIVpD3/a9iRjgSC7qb68nq+J0zoqHr5IvImgT5S7V1ueZwhKCQSC+?=
 =?us-ascii?Q?znS247nE4rkqGkuEztUFDaTywr0k8HIWsBRE9ZAOzuAXiakEzUCim9BtFpVz?=
 =?us-ascii?Q?7YTZ5EP2wspWGoJZOrkZuxIv44aKtWwNJUbPRKCvl1B4aC2djW9MXNNf2HcM?=
 =?us-ascii?Q?rFtm6S2rAO/QSXqvPxMcvuXWLI00EWgwRhrrZtwLbv/tLBcnBIUynSL++1D6?=
 =?us-ascii?Q?1/wNNLmkU12psNIp0ExrjtI0iYP80BWl1bMMfY5pzPP/2nen9WABnHqRG4nS?=
 =?us-ascii?Q?ISbc/jFANhftnqkcz+mGwpH6iGt9AnPfE+C7UIlo7/cP2D0bVylA87DbyeaO?=
 =?us-ascii?Q?SFzEcee/Jb99uBH6lN45c31LKmGemwGsuH1jf8lINx145buNkkpiRGT4S+Pd?=
 =?us-ascii?Q?iuRVqg+HW6PSubzdHLJbN4dOYlaivtNj/e0VJ+MbHYVAVY/n3kcZPL2oUR0k?=
 =?us-ascii?Q?i4FnbyYBS/y61uSSIJvMsXEEBnuqJB0vXT11Xvl0Fv93A61Jwsns9zHQ3CKH?=
 =?us-ascii?Q?tkrH2+jJ4SLXU6PeeaJ05/atelVcwBFNK9z1sP4YGy5A7BOV0TzWhX9Gr9ZY?=
 =?us-ascii?Q?ceH920T0+Q+7KcC74s0OCL6VQwO7wxsH72zgCYG1zaP31yLB7ZrVhHV5VntX?=
 =?us-ascii?Q?JWBNFGxoEgYXDS7aQqBiT+Jyc+avpa4Qnxb+HaU2rgdVrCX8zqqTrDoBHGX/?=
 =?us-ascii?Q?YmpAQc2Ko86J9k2GHqEdIh2oPd6MgcbE7HpzsDfYwwhbmrt97PjyUX6COAL5?=
 =?us-ascii?Q?LMbNawIadBY6dANu9xx1leXA3aPEHJkOWt6U92tQEWUu6E2fKOVl4UurvOaZ?=
 =?us-ascii?Q?KaH+7mflOpfHPeqDs0af/8mGli5bHIDQDET1jPzG69xrbTM/Wb/LD05cbkFT?=
 =?us-ascii?Q?RdrF2NJyOehGzmOmwN4y5JrT4QK/hW1oUI1K/1WfmKbieXp5iDD0SIgtv+B4?=
 =?us-ascii?Q?82UQlwuq72BXjg2p5O5WktdG1KHaTjF56vkUcTMBu5jvy07EG/TRobF/Ja3y?=
 =?us-ascii?Q?fQavG1VT1z0AMy8Ocqkdk4XOrw6hcFuRe8mPnOJwaf/nIPeipgsj6fkGKQ4X?=
 =?us-ascii?Q?wheQqLo/I4rmEmOG9RlmYYrxZ9WLKTnPJlZNtIVVPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vdb9OeOz5npH7Tirb7/EI/MgB8fB4nO307oYWxcWNNqqAExy32wt2xECosV3?=
 =?us-ascii?Q?HamYyPlHs7YZnwAj1vDKqgChz9WhVuX5afh8lNxfUqvrJRCsY5oWDAxeKRoe?=
 =?us-ascii?Q?LlYY9ZXXYgOhoVm+J8Nmy5MsPDZTz5Fm4CzPu72PFyhPG77T66os5rU5C5lR?=
 =?us-ascii?Q?xNb5PVCceA9QBHzVfdJSH5tx12OzOTXGDBIY7ioEVtPdBVnIGyHkH0fDuCre?=
 =?us-ascii?Q?1IGdXOr6sX2QNRxzsOr01flZld3OnVvokrBp056W/5WtA+R9RqJwLqrIAOEk?=
 =?us-ascii?Q?KMGheCHMSv35hHbXnLYhegHYBCUipBBJWyAwEm8MlpWapAi6TX//X0n1WKA4?=
 =?us-ascii?Q?vr4fK8Gt/QrPcwvWjlw3VoFAImmK7Mw0x342dP+U9wzjY3/4KYJts+WGwJoc?=
 =?us-ascii?Q?aM6OGS/1WydWMbF+HoSJV0dGUKarW9SerhgB0cMvgvxxiL4nsauyp6cF4xd2?=
 =?us-ascii?Q?QCNsZgPJGfp2//N9euouZGsAi386L13BmgS2teqrEjkGOx+EdhirhnxpAFlG?=
 =?us-ascii?Q?Le9VJ5imhV1CIDaYwXP292Q654jL4T3GiNx70rd8D0sD8huAD3x+0hcpVX+u?=
 =?us-ascii?Q?622Wq+6wQTS03DGl7t9ZfwGTSq5+bhLz06h/L6aLuWQF9G3a2GdiY98g6GUe?=
 =?us-ascii?Q?0P0NUJBbFIrf+vFMpCoiOGZmoanjC65kffdNkOC9lVZcWpT3bXXHh4txen8r?=
 =?us-ascii?Q?1kD5LZWIhY5s3P7lJZFrj4LIocSXBlTg41eJuohZnuxp6ZrmyHl73/wiozju?=
 =?us-ascii?Q?4JIiHfCmoFkbUsFNQBggQ9h8e04f3NK8xujis2lWTeV3A/VVm+f2iYtTn6LD?=
 =?us-ascii?Q?bMdl7kAlo1MnZPHzU4A/Z3Rp8mMJdwo7p/tpTngvV/Sdrb7Gq/OCMqAkmNk3?=
 =?us-ascii?Q?GMN8i7Ij61OxSCH8cSKz7hyhUuY/R8ewI4bP8X1jtQhV2uTCidHH5DyKpWct?=
 =?us-ascii?Q?aRqSZ0/0FadyUlC8I7VFEJGOcNSceVKzOjnf4ujLMdJOQsG62/nZpxCwK1u8?=
 =?us-ascii?Q?0k0CWJs5UHr20aXN8drjlm+pv8wZLIoSi/g/V6jPNF3Z5pYwo+XGVSlblSgZ?=
 =?us-ascii?Q?sZaURxAAe21CPIBafs8cqPxI12x4luHfg85OWHsyWCXnAfq+QsKXKG+ywp9g?=
 =?us-ascii?Q?7YYjmWFfEsdARhC7sPb0n5njCCFYZaSfjwu1mOiBANF7gWPBrNepi2G2UWJq?=
 =?us-ascii?Q?E8AC1R+812NeMHfPK3r9xVOZBeZAW7L8Adz0UnC0ucCNjWXhEvGt6vrg5vL0?=
 =?us-ascii?Q?V4CRBUeGmxNkf2Xtd99Xz9xkRgWtvQ3YjiorxeVxi7b0bZ1IGMngi3vKYdJP?=
 =?us-ascii?Q?jO7qnueyEa0T7FrYcvow40a+wnskc4aMMNvO1UCqwhhJHUL+8JTZi2RIBN2B?=
 =?us-ascii?Q?P1RMl94F6N/bHFJhAU2PYJFr1h3A8wuw5XZ1Hp6VcKh6TvlfNglMEDwogmG8?=
 =?us-ascii?Q?EzbICn8l8cL3yyEA3x5qKqeZLDXnqvdbX/GF5Fhk5DaPBMapILqDa/UmAiia?=
 =?us-ascii?Q?Td+ZidFmEaaedEEuYdhMLyufGykXt3K3UfArW0TiOl0K7rWzMWa1NDWC64Xm?=
 =?us-ascii?Q?MDQDtFOGCNgtCVmVg+xNTMpvMgjn+8C/OsODWT2wYx4NTtOi+hXUcVoljogE?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad161a31-0214-45ea-1f71-08dc7342ddcd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 11:50:20.7397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1ix/jcu/ySb8gOhreefhPglg0ZXZshtoosiR+7q+uXv3nK0PfTiCPVH3sM7funCeICQ5lpw417oAXuAHhuQrM4F9drTc2h0JspDjv+QDmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8430

Remove PAC logic for BAP Broadcast Sink stream creation.
---
 src/shared/bap.c | 63 +++++-------------------------------------------
 1 file changed, 6 insertions(+), 57 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 818326f45dd2..ff3e36a6fbc2 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2005,10 +2005,7 @@ static unsigned int bap_bcast_enable(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
-	if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
-		stream_set_state(stream, BT_BAP_STREAM_STATE_STREAMING);
-	else
-		stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
+	stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
 
 	return 1;
 }
@@ -5287,7 +5284,6 @@ void bt_bap_cancel_select(struct bt_bap_pac *lpac, bt_bap_pac_select_t func,
 
 static struct bt_bap_stream *bap_bcast_stream_new(struct bt_bap *bap,
 					struct bt_bap_pac *lpac,
-					struct bt_bap_pac *rpac,
 					struct bt_bap_qos *pqos,
 					struct iovec *data)
 {
@@ -5298,71 +5294,24 @@ static struct bt_bap_stream *bap_bcast_stream_new(struct bt_bap *bap,
 	if (!bap)
 		return NULL;
 
-	if (!rpac && (lpac->type != BT_BAP_BCAST_SOURCE)
-		&& queue_isempty(bap->remote_eps))
-		return NULL;
-
-	if (lpac && rpac) {
-		if ((rpac->type != BT_BAP_BCAST_SOURCE)
-			&& (!bap_codec_equal(&lpac->codec, &rpac->codec)))
-			return NULL;
-	} else {
-		uint8_t type;
-
+	if (lpac->type == BT_BAP_BCAST_SOURCE) {
 		match.lpac = lpac;
-		match.rpac = rpac;
+		match.rpac = NULL;
 		memset(&match.codec, 0, sizeof(match.codec));
 
-		if (rpac)
-			type = rpac->type;
-		else if (lpac) {
-			switch (lpac->type) {
-			case BT_BAP_BCAST_SOURCE:
-				type = BT_BAP_BCAST_SINK;
-				break;
-			case BT_BAP_BCAST_SINK:
-				type = BT_BAP_BCAST_SOURCE;
-				break;
-			default:
-				return NULL;
-			}
-		} else
-			return NULL;
-
-		bt_bap_foreach_pac(bap, type, match_pac, &match);
+		bt_bap_foreach_pac(bap, BT_BAP_BCAST_SINK, match_pac, &match);
 		if ((!match.lpac) || (!lpac))
 			return NULL;
-		if (!match.rpac && (lpac->type != BT_BAP_BCAST_SOURCE))
-			return NULL;
 
 		lpac = match.lpac;
-		rpac = match.rpac;
-	}
 
-	match.lpac = lpac;
-	match.rpac = rpac;
-
-	if (lpac->type != BT_BAP_BCAST_SOURCE) {
-		/* Check for existing stream */
-		ep = queue_find(bap->remote_eps, find_ep_pacs, &match);
-		if (!ep) {
-			/* Check for unused ASE */
-			ep = queue_find(bap->remote_eps, find_ep_unused,
-					&match);
-			if (!ep) {
-				DBG(bap, "Unable to find unused ASE");
-				return NULL;
-			}
-		}
-		stream = ep->stream;
-	} else {
 		ep = queue_find(bap->remote_eps, find_ep_source, NULL);
 		if (!ep)
 			return NULL;
 	}
 
 	if (!stream)
-		stream = bap_stream_new(bap, ep, lpac, rpac, data, true);
+		stream = bap_stream_new(bap, ep, lpac, NULL, data, true);
 
 	return stream;
 }
@@ -5415,7 +5364,7 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 	if (bt_bap_get_att(bap))
 		return bap_ucast_stream_new(bap, lpac, rpac, pqos, data);
 
-	return bap_bcast_stream_new(bap, lpac, rpac, pqos, data);
+	return bap_bcast_stream_new(bap, lpac, pqos, data);
 }
 
 struct bt_bap *bt_bap_stream_get_session(struct bt_bap_stream *stream)
-- 
2.40.1

