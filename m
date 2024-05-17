Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2082.outbound.protection.outlook.com [40.107.6.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C10E3D546
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715949317; cv=fail; b=hq86ypTO1YXx0N6oZq6oEgWRVxqIZ1VbU6JvhE0tCBqO9nY6nz2G+6Xddr3awa5rfceaU7OKICdLqg7Od197O3cXY2fFCU1pxQEjl8LMfj2O41vOuyYF3vlGepGrJDLjREd6to3kMPdJdCc/Wi2NBoW2boCNdRm68W6CGSmL1xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715949317; c=relaxed/simple;
	bh=dIEGoQh3tcZXqmdjGBl8GlhKWEUDlt5KJo+9a+6Mqcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SotdFIgs2cnnwy1bkhMHtJX+A+1S98QXRuiWmrNdONodjLv4YSiCputkXoYABmpxmgvPOUIKs2210AYjtbpQnL5Gj+LsqVuZ37aR1aWna7VfZ3KZjo4y6efS0ltT13J8bAuZIdYNknymAVX61T52Rg64j9yVLRoFmf7EvYCiGeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qQW30vXE; arc=fail smtp.client-ip=40.107.6.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qQW30vXE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9jSS/rYJaH0Lw4wu+RAZa3gQkKlrn4g4TUqMzH4bAuPzOgcCZ4U5Ke4TC4F9CgNAepX75WGqzZoiMdn69UVwZJR6tL/kMSZMsTWm6hTTSkbi+wdDkIM2TdJH8qIX2/OxmLBHLpH+CmQRIkaNQwA44zh9ydxjpTk5kuLfl7woXUP71mibrX/yjRvTDKj9X1B9mLXpsKjvpyX/ROhEeJ6ZzrM08cWrwYwlBuxt5c0jLjuVpFzN/jP5q2dnDndGGdhzPUSj8QTc0PXRbpIjOijag40+24iFIpYhIU1PVmepc+HZngeXvVwzlsz14Xv+E5mNspYJnghfzcw0hu3xNOEOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dp8j/1Oa0UWhpTWzPpaV5vDFjMwlY8Rk00XQLnRPIj8=;
 b=EOduranyh5IjuJ53M6bSqia6xcWo9rW9Rop9xDnHtfptEqo+vaxNU36hI72IrOYihtW5BxFMjOQtRcL3OA3NHuSvVIP2c9xXiIyowTzy04FB8nAOSMt7sQWgftJfv/g20rglDi9HNiW27qlZ2oGGlEdc5AsQjrQUm4JRu0vxYmPcJ2d1grQBGC/JbmNp6ooBQyopaUtvsLxwRT74DCk4VWcQyNJOTv8hjuN6Kf+5XmTNi6TfJLC53+DTl0yW7nlVgYVLrMWWg/lnTstZ/YRMlbCjEXTAipENIH/+UtbhRbSxm8TiY2w8JPcHNMIjCjnIcGL0GDxrUdJ9XzLcJUjMtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dp8j/1Oa0UWhpTWzPpaV5vDFjMwlY8Rk00XQLnRPIj8=;
 b=qQW30vXEB4emyYLzSlIuHZCvGRAbvSaRJ+fLmYpbpiBQgbCjMVK4152K9FkdAlr4aNdR2r0dAkuf4zOTzATp3UGC+KmmHvdUeBnuCF7RHsB+ccCY3GMXejszGrNFWVrfR5jCVMq+f1K8dV0yUGRnLNatv+B5eqWYgGovfRl2InQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU2PR04MB8934.eurprd04.prod.outlook.com (2603:10a6:10:2e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Fri, 17 May
 2024 12:35:13 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 12:35:12 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/5] shared/bap: Handle NULL caps at bis verify
Date: Fri, 17 May 2024 15:34:32 +0300
Message-Id: <20240517123436.146332-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240517123436.146332-1-iulia.tanasescu@nxp.com>
References: <20240517123436.146332-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0012.eurprd04.prod.outlook.com
 (2603:10a6:208:122::25) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU2PR04MB8934:EE_
X-MS-Office365-Filtering-Correlation-Id: 74964baa-9def-434a-9c0e-08dc766dcc23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wCr2g6ZTh1O7k2Z1NIhdE2GcOhpo48gexTso6ewCP5rwyiy6YOrJeqA8Tn3p?=
 =?us-ascii?Q?jaZiCm+NgWe1GbYCBP4e2bv0lW/v++zdhs8P5RkR+5K0Yy8qC1U4mjc7LkEK?=
 =?us-ascii?Q?cnon1j4k/VpcaX+CNb00uJ7Sv39SG3Ddmzhc9LSxEggE+SeRHJ9Rd/OdhNZc?=
 =?us-ascii?Q?yk7RA93Nf41up6RBDMVQ+MesYWTZQq1VIj8zonR1PpBdOifAjQu+LZ+X74RX?=
 =?us-ascii?Q?Rnbmu0/FXMNVqREVCG559d4KoRbHaOHT6vd1fdjmTYaAqut0rT1CBxTA2eKM?=
 =?us-ascii?Q?gBeoGMA7THmDFu5vh4YmG5zwp6HCXA6ETEyJZaLREHGL8y8Hsgz+sCNnR4nl?=
 =?us-ascii?Q?OtBKaqbpWe4LmTSaMcB7bOTH1+gBrF/kyy+uYvc5msdBM0izIV7bdorGyGMd?=
 =?us-ascii?Q?6Q3DAeGOCkfgyO0Gyv+k0xzjJ/dYR4QFhHKTjERtd9Db8vUXo9v0uCnUnFvQ?=
 =?us-ascii?Q?ugKETzzn9S1Ml+n8YHxXdnaWevgqh09E59oPoOpGiRGz64XNRpcTGYjEdKuT?=
 =?us-ascii?Q?HSyA9kLbG03UXqJvIQ8Rsw4s/KMdbuvYUvbwuF6n6bg7k+8WMUTZ3S2BvXDs?=
 =?us-ascii?Q?N8og4UuSHVTmO9bY1opttey1if2UDQScTik22qrdgr+ytCBT7cBDdjfRkIN9?=
 =?us-ascii?Q?56M6xOQCb5yKSuEdL5uPzQIUYLBXhblrgVhJkDNWgucqawVh0peJSL8BYD2R?=
 =?us-ascii?Q?AaT1PC9aAfRJTCv1dRuoeceLIMloZzejTSMNdTYnsEVhlZI4m/uiZdtrFAmZ?=
 =?us-ascii?Q?o5iA13Pg3N6JU3rI8mZ7fpCllk4tnG47TfVyXxkE/SMaPU4pnziFPop8HPTi?=
 =?us-ascii?Q?zDzET8LyDN7cxMcz6//IDJfhjnMeip4teeZqsEfctABCJ6toWTyPm9668Bzg?=
 =?us-ascii?Q?pxbgDXzhD1ksJ76WTax8s3fTOhzrzf2Drq6UvdbpvMtR0jLmp+xrRglsBadx?=
 =?us-ascii?Q?5eNyU3AbezJv5UcGRRUs1V5tqRfvVgSP1pLOhCFib4drDRdQiIqiPD+cepWp?=
 =?us-ascii?Q?cC2y97DWpYk7F8sU3u0Lc/FuxtThWw/UGYT//iZrSHyLaAGmnLtcRwdg4jJj?=
 =?us-ascii?Q?WM1/rOocE6HMGIQZXyX/I3AbkMxZt9fPnaAMyvxGWx1Oon3Dy1UR6i/BdBpd?=
 =?us-ascii?Q?GEVLJZgGWnTgOOCmt4UFiIwwo7s+bO9G8C8Lu07YFqW9pT7QIREua9xAvtnd?=
 =?us-ascii?Q?VXz7x0EQFXVsUtJzFW1LAp7QfSFnHigWVGcRP+Fm7zU2OlzNuq6F2hTyHDKR?=
 =?us-ascii?Q?tAkqk4begKZtYYJtKo6P9eh9jRPE06sWy5mLQlHLfw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/N7cKKd9oKN005877Z2pblSxpTedRiKuWiQbaH5MSVH7aofSUFaRkwU6qx6Y?=
 =?us-ascii?Q?S9rBQoZyv3WWw5eOVkzcn/4kUje7rCIVsxiAYe52KjRewrdZqiGBR+PsnZEI?=
 =?us-ascii?Q?vAbyLH3zDnmTtm/N8qw42UoT12kO/fXRXDJvjfbPDXF81mvnzI3wYNjl3j+E?=
 =?us-ascii?Q?bF+vL+3N4UkwS/OSVXymFceYiTeWTAR/etV6HS2BkJWE83weuZuP81ITagcl?=
 =?us-ascii?Q?ummXeXIkz7zyFQX2kqtKJJ1W9VHrYhG5LanA/i/JN2cWY3pBlFxZAMHk3BCO?=
 =?us-ascii?Q?uHCf0tvcfJR1ZjuVQz5xbeokuFHsXeCx+QTcYHyywkQkfgSEFXxOmmt1qULH?=
 =?us-ascii?Q?+/vpQAx/0Z2CbsS+af+XWoFFbBjLJ47lwkY6Jg6Vpqm9A6IgSWaxXJs49aHg?=
 =?us-ascii?Q?PiyLcj+z4zz4MpxUedXS5Qd1zAEyph48O33qAG4H0dxxtTiGit0XCMy4Ldxr?=
 =?us-ascii?Q?/v5OK9i17liRX7qwTP0GkXZLvoTOgiNZTwLjQZrqiYiwaz5devpV3f3TR/KL?=
 =?us-ascii?Q?iK89LmysU9zgsfSd/Nq+G4ascEth15hpMlN/gl06m2rsGIMA7h3mKu4rOkZt?=
 =?us-ascii?Q?ugYlb3SalxJbB1/Ur+THWt286ncMj7pwud5hyMhrTKoK+qiL3J0mA65PchZg?=
 =?us-ascii?Q?qxdtQCpVMZTjYAO3q3Hi1Gl07YCBZOmJpAlCk37HukqU8yGENorDczeQJwlZ?=
 =?us-ascii?Q?0yeETws+AoDowBUgfU1Yjb8109Y2PVTgxlxxOKRc6+Fi/4atxmbR0muFT3zY?=
 =?us-ascii?Q?DxrOJkxowCSqchQrhHCBgEtlTFHaMWHaM2ypnO9V7k02LhglOg4dD5YGMXBS?=
 =?us-ascii?Q?nCq0rZxX3VdnXOmGsK2MAeEAeorAUPlybDiXiAAVGKX3XoBAz1/YM7EZxEww?=
 =?us-ascii?Q?Ab2Dg1rzVh17Kcp4zx2eLKu679P6i7O8E/F+ox4BQAiMjk5utlw468dacQkH?=
 =?us-ascii?Q?FX6r8ZRdxZS4Xl1qjwXhn4HigZ5b+Z5r+SFmELrmnrluH68g0ZtnnwS2kSDT?=
 =?us-ascii?Q?MSDbAFwi9/Jh2IYAo6EzoT9jp9RknnOhS2YMDMn0ApMR0JkKCTPt7XxEhkZz?=
 =?us-ascii?Q?r82apGQRPqP7qMvyT64deOZHtiak+NFA5lNgwt17OHpdlemLFVsge29YsrV3?=
 =?us-ascii?Q?uUr/bCs4nlz45m+tZi05G3tr5mnpx8O6Zg5CJpZ9z75aVkfedZR2D5sCMokn?=
 =?us-ascii?Q?7lmFxG6nsO+c8dJRI6TCQiETc2NblQER2NWAWPoxJraGTnzJxwLfGXBOIpOm?=
 =?us-ascii?Q?cYg9VobeBD8oAQ84v0Uk6QEY1JL3S5Lh3qjFIuntdCV/P6Sv6WNhyWelUUE5?=
 =?us-ascii?Q?Z8yUdpguJMKrDjZT9ThpjW42EddtMUzxqY177MC3ZmzkuwB5MEti4aoCbGKx?=
 =?us-ascii?Q?D1oayrQgSJwIAlDVvV5PR3vGdPxOMy4sTRn+W+h1JYpXbfWOy4ibyoIf1rmf?=
 =?us-ascii?Q?Wuq8/t4GUaNSQrweDw+cFeWZlii5r+KHlR2wYe7EVua0t6kEkqeAG7eRs51V?=
 =?us-ascii?Q?OSk5Fx7YngVkjTldHDU7wwvIAuP9sTG3bKDdq31zkoeN592Bedjn0dp0UC1H?=
 =?us-ascii?Q?9lcfwlde9Xd7MslGIREVCJBzisitiemXEgzjWR3PybdpWK19UI8b+3x2cZ/Y?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74964baa-9def-434a-9c0e-08dc766dcc23
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 12:35:12.9191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4bqAltkQ4SFLO5t7/Tsuifv2gu4HneD3XXTAQz/bErwSSq/iW9qp1xQfthYK7WMU2dc6F0kBw6xDm1lZIn6GLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8934

This updates bt_bap_verify_bis to handle NULL L2 and/or L3 caps.
---
 src/shared/bap.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 38c353a6d..40ce16d75 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6531,6 +6531,20 @@ void bt_bap_verify_bis(struct bt_bap *bap, uint8_t bis_index,
 	struct bt_ltv_extract merge_data = {0};
 	struct bt_ltv_match match_data;
 
+	if (!l2_caps)
+		/* Codec_Specific_Configuration parameters shall
+		 * be present at Level 2.
+		 */
+		return;
+
+	if (!l3_caps) {
+		/* Codec_Specific_Configuration parameters may
+		 * be present at Level 3.
+		 */
+		merge_data.result = util_iov_dup(l2_caps, 1);
+		goto done;
+	}
+
 	merge_data.src = l3_caps;
 	merge_data.result = new0(struct iovec, 1);
 
@@ -6542,6 +6556,7 @@ void bt_bap_verify_bis(struct bt_bap *bap, uint8_t bis_index,
 			NULL,
 			bap_sink_check_level2_ltv, &merge_data);
 
+done:
 	/* Check each BIS Codec Specific Configuration LTVs against our Codec
 	 * Specific Capabilities and if the BIS matches create a PAC with it
 	 */
-- 
2.39.2

