Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012054.outbound.protection.outlook.com [52.101.66.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344881C9ECC
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Aug 2024 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332395; cv=fail; b=unEEbcF08zxde5IV7hwI+uTP0VKu1R7dPV3f4BsFozX8iWS5NTvf41f6RJ3ZHVkhrKN99oBouNL0tiUw3GAwI8nqdc8PAa7DzJHkprQ1pURENVwUMJ4cofKa4+9fujdTplMfY9BW61mue2n+Zo0rgVKTeJRNclvXM8aPKKnTGjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332395; c=relaxed/simple;
	bh=IDLawUEyvX3s1kl+lmawmPvc8zXhR0vZvVKZhYumhdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U4mcWyYtgrs4TcUAUwdyJmp2FwWo+vJXEvGYnRmYZWjXzu80g/vItpi6BdFv2DWPW5DKCkeNZD3XAIu5tO1ecLlBnSnGV/J4TIpw6bX6MxlMuT0ivn2vRhvcdatByDFAUeknPxR2fIwQi7MFUQlqGp+hypDDCjHXqi+/ZKvR3vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pi2Dv5hT; arc=fail smtp.client-ip=52.101.66.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pi2Dv5hT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHstri68lL91+XudmJ5v0kSHvLCGKYE5J0iw7kuEv+55wGHSo/5iqe2vZ9UHIBv8XmaIuiMr51+reS9K8c+Go3fN6kTgjnTugbVma/qLBlEgWNTLRvjkz+OvL1lNf2Doy85xqmAs3i2Z2XMtREL2L6wHfDTJrtwd+fn4wjNAV7cMt6kkN+XHMCiOxM/g+7ieolWfW4AvVsLC+niU8EV+96Tc9IRWApPNp3HDkmhDR+2mWm68/1ijl7CsS6KIiWnDLHmgRfEZLhrUh67YBoxG+1LY+YVF7W0PAs4sma4Fs+Nuu232MuNTNPWyLlr9W9iPvCs2VybYfjEMV8D9LwKkGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yi6f/mQOkXTT2HCAmu98ROPUTLGLhJFYiPnzUa3oRGk=;
 b=Q3Nwrj/xDMT5ANJ15JU+hEMtx+5DXhX+boW6CJoAboGbo7egdq2eSym0tbJLX4v5nmh8DUVG9E+5MZQW8L2QKQ2DsLsdursQutZTlwnedmChhnhyyrgCHeCEtLrCTdStTF8gA2ooW3vBwFG4I8jrjvNiaIMowe8+FtNb1k/9MCdh97pnXQWcrGz7g+IcnCvhh2pJpQ/V7ZajCOzE9XoUQGE3++KoBmJbSWX+V/xc19rOPp5gAaBEMqQTwlIOtmtvT9rtkIYYFAeRPPA+5D+u8Osqn/kH5fYEaXKGgtSH/Bpkj7hZkDHuD9L9cSy2U8qTq77EUC4DXfuUwUlYh7RUNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yi6f/mQOkXTT2HCAmu98ROPUTLGLhJFYiPnzUa3oRGk=;
 b=Pi2Dv5hTWHYlPLtiK8kTAXee+1GgSnYWvWSwmAzo8cd01D1Rw+buFfaeR+QRzl2nSx0X2fCucQkOFUoZB+1Q1Wk1+RT6gs14FkhbUGUV7XDl2//uW6I15RUEpVv8+Vlc0B7xCMxE/r0mLmV7AsNqoZklctGyHrmAy1pXIn/xV0G3FqMAbr4vpyv4rR1q8SPciK2Bz5D9RX5iEYcmTuvKmObhpD+/UiZnBkab9UwcVBdNt8N8kBw1+51U+orJwIRxYg64+SRlrDdYT5Bzd+aqSdkusZ4jVLxF2yueCl33jkzV+fM2h7JFoBPFAjzcH1bPwUeZxIBemXSeYEiBxyzt+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by VI0PR04MB10565.eurprd04.prod.outlook.com (2603:10a6:800:25b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 13:13:05 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 13:13:05 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 8/8] bap: Refresh qos stored in setup before doing BIG sync
Date: Thu, 22 Aug 2024 16:12:32 +0300
Message-Id: <20240822131232.531952-9-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240822131232.531952-1-vlad.pruteanu@nxp.com>
References: <20240822131232.531952-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0034.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::15) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|VI0PR04MB10565:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a663e63-6574-475f-daad-08dcc2ac28da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pkEzkIZdfR46L/9UmnKQK+4a1qHV4hqYrpguJjbk1smXtT4ggFicR2ePyGCx?=
 =?us-ascii?Q?8x/C05mrUOxm/2tFgmePECbR13JbyZHWp6zVvvNA5/77IHM3EsP4KH8E1k0E?=
 =?us-ascii?Q?jxPakMn6m6HONaiX55zxTRuQQu4FAYL6nPyPZA2Ck9dKNeNKD84zVDR7iM9r?=
 =?us-ascii?Q?N/bHip+tidK9lKIkwrgwGs0QudhThNVB6w+NH+7Q9uoDPiv29abIm6oUE+jw?=
 =?us-ascii?Q?Ne6m+QE2lhwECnWC7ZulpGIi5QZujf4OYVM6BqTaju5nYHtFcZcl3CxPXaFn?=
 =?us-ascii?Q?BQtNIw6xMbHMT0JvNJQheMMRb3GFiHZRWmPia15TWtKpDMWU98mauRsTo6Tc?=
 =?us-ascii?Q?b048UH3dfW1JOj5Ng+YUhzAxtzCxE8ymTkg1xZAupy/o0qBTRkbCRmED0pbd?=
 =?us-ascii?Q?I0kS5eTBs0ohYQWNxwdwc1wd+GuaVJfGOqM8sy2VcN3F1b7pwtjGln8fYj0s?=
 =?us-ascii?Q?kt4H/dQ9nlxZ470hHon56X339EH+3jGicZq+zAJQesH2kGfeMsIUOoO57Ecq?=
 =?us-ascii?Q?3NZyqogqCNq74ivfOGulIB8aDMz0xT8aqwWKt1j9yBPromvu5/EyW8cJRGOh?=
 =?us-ascii?Q?EjoMkoQ+cjFyyhPmMCWAdNGuBMw+30QQjH7D8J3OxnhssZGwW667fDBPh7Re?=
 =?us-ascii?Q?ULDBK0nh8NWCSK6nQVtpBUBl40jCG1MZ1kTQQjhYAlRM3487D3RWo/DgvzSw?=
 =?us-ascii?Q?JKsKGjTqzDM+nvAfHxGqvIreSAXk2wYDhDZIJ2hpgU3Nd3+By/1H6tMGIIH+?=
 =?us-ascii?Q?NIMIQDCrthCqpLRvFI+M5UN35nOhvpMCHtoTwZ/yeZAAKavf8cgKYOXxvCxM?=
 =?us-ascii?Q?LaqaXbhS3HM3G2s5SMPHPSndgSCDy5vVN7nCgcVVa7dZMVVMf4p6fFh5OwrV?=
 =?us-ascii?Q?fQTqPJixl4astTUagiyeQgABKkQIHZZh0X2NTfpyRaAhggjQoN2WYJzQc1ds?=
 =?us-ascii?Q?DRxAcSxej9pMwNQyvSaDTaPS4IjcdWPxVuzWqQpgJPn8MQL9kiJd/COGoWtz?=
 =?us-ascii?Q?hakoEjRPzYfIGkEPl8HyP1VlHSIbmCFmEoBhGFi2IXS+agav2fCND8namzsF?=
 =?us-ascii?Q?MgHvYS2PrVG0RWXyViitMnZ0yIXuHqaFEPBBh6iTpXKazV0FDeW7DyhFMFlG?=
 =?us-ascii?Q?0D+UGZCJ7eTO98s4tJGZsmMa0jnPw+4h3MrYLuUPz4xgCetIMDI6zsEe8pZX?=
 =?us-ascii?Q?/yXz1KqmaDGwI3+MlCqpAWSlYybrevL5dWEOHrlMRvW3cVpdlSeA8duLV79c?=
 =?us-ascii?Q?gxibdrjFAldnB9BHGkp/faQLRUJB7oQVeGKLxY8NdB8nVJk3e0HNh33HwNfX?=
 =?us-ascii?Q?e98pQP11fOySMlMZ2R+tfhIkxnhMoyuLSLDVZAmQYLdDaPdtSUf8ca6JfxRd?=
 =?us-ascii?Q?R30XvDpgZgeRKzfVCWHzWTYscD1UKic7gBMj2lJNnDWI+AWWGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U1/nv4aqoZ7+Pya3GH8rHHkuJUok6FTDv11sCJ8N3jH5bvhjtrdym7mpDEj8?=
 =?us-ascii?Q?COtJWm8iYq2czTmQ82FamYDVsW32DsWijKiZuDFFkv3r6cJQDYeVKoFrIDvF?=
 =?us-ascii?Q?cEPOwTRBOx9KZYV/+cNc6DS/JBIB9g/HsqM1z6x5AvYAIUBlMm/PyXoKQLT5?=
 =?us-ascii?Q?+nXa0dKjgbv8bPKA8Dt/XSF1vB+XlH1tsGFwbJ5uD5ibnea/TQLstHQgWZbx?=
 =?us-ascii?Q?huATduDeYFZQ/fxlse1LLHBa1wmL8Yk/jyAMsOrb3RIYds+YCzFAQJKc/4b0?=
 =?us-ascii?Q?7vtuYWxY+zHLmg8YZ0hMHGH6iMc2MaMofA0IjqUjrB76cSrXS83z3v0WmmpU?=
 =?us-ascii?Q?59Owj7t+qbezmwIGFI5XtL5yEhX1gS49sDU13PRRtQQdGp2dOMqZHDR98Y26?=
 =?us-ascii?Q?ge60Mn2dIVpjj8JEfH7nDMqDhnab/weXI3CETKikaiXGcpcSeFfhsberDGGz?=
 =?us-ascii?Q?kS3vv7yo70uID1RvtRaQ/xRfyHl8TzfYE4vX9/jMPPNp115fA3OfXZjfFiHJ?=
 =?us-ascii?Q?ll//vs40RO5py7kfRvrlhTafaXwSAisGFDwWtoitpv3hm+3skWGWMeaSUCHH?=
 =?us-ascii?Q?E7FsUkt/PqaKUfgNGwfYbEuN07hgKddcqoFe2ZHL4m9VFW190FQ8gw5l/Xbd?=
 =?us-ascii?Q?MzHtCbzg7LJJdcp5JnjVQ1p5PcPo5j4X1eLR/gL8KEISpChAbm6UnHwcIXt3?=
 =?us-ascii?Q?3PzfdZyB6FrxDguDFa4FCsL5CYNcfgIP2mnlfeQRW+OJet+6T8qGU1FGN4qH?=
 =?us-ascii?Q?eIbC9VxQ1Dz4pIrO1tfD3tHxAMlAykTx7RExCwIGDWRPa0JDQLwBUCnSuw+p?=
 =?us-ascii?Q?QlOejRRCnP38Cto360cg2jGq8mBdi30RI8i+Wir4s16B6q5CAn534o//7076?=
 =?us-ascii?Q?ZBzWM+GaunuBzUxkJSRfSuOAznUo8dSoMcAFwhHAwqtfe3+zYfZ7eTxwL1cf?=
 =?us-ascii?Q?VNgf+rusqB0PRuxQDx4efHwOSj+PFh8EJbD0ZXoPSiCh9lWCAAVZ7qb0y9U+?=
 =?us-ascii?Q?00I+bsNXfdu2QSMPeyEQaibaUHmDuFTzwO7pqTvhyIGp3VQfjT9ZtxGW8Ty3?=
 =?us-ascii?Q?Q4zfmCG3sxsZUFMUrqbmI18IypL0uJuY63oSimkg9r9D2sEP6GEbMaxkgDMi?=
 =?us-ascii?Q?nwAqUlcY3lLgCgPS2ZpjtuhmI4Mg4FLWsFzsXO9kUiwxPTgIkYAGUjjYNJbl?=
 =?us-ascii?Q?dnxj3AKv+ujNnxUzwxmn1MK5/uzLA88BGFnZ1P7/SgMt6aC9WAh+EPqIf7M+?=
 =?us-ascii?Q?1cOD58FL3bjPtlnFWmoGvAwEcIwOryHBnWF7PcWkMW19p0UP1rEF6MpCkuaq?=
 =?us-ascii?Q?hQ83fciyflG+Oyk4o1S0cqcUy+/TO3Teo/JQGbmQ+RwFfPUm9nVx148AfUet?=
 =?us-ascii?Q?Gfk9b+Mfu/4x+YuVgWRSh+7eOrIAdOTrDEbjY6JHmbtVJQjfzw5Ark9Ppnk4?=
 =?us-ascii?Q?UeiiG+Gq8AltTBea0YxBYC0MQjMTJnPV9jqBRDQ27ADQ1p2IPCW49RAlZnEn?=
 =?us-ascii?Q?D9oQYt4Cgota20Vbz2rG4waOtSprK+TLa6HS8Zq9HURLS5J8aYwudMnezX9B?=
 =?us-ascii?Q?YLyGjXK6dTKOds0JVeqs/52/x0uBeP5kafVoWqO8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a663e63-6574-475f-daad-08dcc2ac28da
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 13:13:05.7058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfoHUd6QSUsyMGrEgwPcX9zKItSWZa0Y7iHadTXAhuLKOVYCMyFmw+rW0Zj47LurrY4Zt1CDQFx3nfcsU6ewUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10565

When syncing to an encrypted stream, after setting the broadcast
code, the qos values stored in the setup must be refreshed so that
they reflect this change.
---
 profiles/audio/bap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index a2c5a546d..80ed1a7ea 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -3066,6 +3066,8 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 	iso_bc_addr.bc_bis[0] = bis_index;
 	iso_bc_addr.bc_num_bis = 1;
 
+	/* Refresh qos stored in setup */
+	setup->qos = *bt_bap_stream_get_qos(setup->stream);
 	/* Set the user requested QOS */
 	memset(&qos, 0, sizeof(qos));
 	qos.bcast.big = setup->qos.bcast.big;
-- 
2.40.1

