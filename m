Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2059.outbound.protection.outlook.com [40.107.104.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E43146D6C
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 07:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719300444; cv=fail; b=oVWf/yFQBPyaNZIKyRhS90+5YFNM/wSUcjCXaG8G2t2KHB6m5AUd4G0Eq1mcaJ+re3Z+tMZpun+yuJAzl927mU2P6AGpBwqeOE+D5+GES5OxO/T21hCETyiuVz3B4CN0YZDkz1Y6LZfQX/Su2GesfuA6qTrcZ5HYtGcZaB0Akfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719300444; c=relaxed/simple;
	bh=cNkm6LpCNWpoB7AL5WYUR7eDLH7lGIMFabnAEApklAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FVzx84Bfdg1nRTbT0BGjzPSzYh9YosYQM+DjNR9350cTSGdHa3DwgGPCuFQkB1kMPezFCniCxwz5MRjQsNLAs/PEQtrdX8GFWYQpi4HFjPIR3lY0y4A9gnckJeUB8/CBf75PZBOwX+J8RwDU0DMA6L6e9Z1hmfPlOy1o+KiJjWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gJ1Nz2U0; arc=fail smtp.client-ip=40.107.104.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gJ1Nz2U0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQtQUwnRFIQzSsXtq3Xb7LZ72+4X0DYmf5pIciJOXSUvboDzqx86omfeSlFRFlkQSXU/1YWHdYCuMyiRaOOZu7Nr6qCCd7fgugg5+GD2OMIAtP9MpT/OEtnyzPqrWvBJnJwLV97C/6sG1vbmewr59Hb7ei8wGCPVAE1g5Ikep0M+fsUDGOnE1AlQJ/LmERIPWKvGsuJpMQ10qMAtUNiEQ1GlfkouudMjmFrae3Gtc3ZBReAeqRJFhvGOE4GBSvGVwe4guf2r4tegpy14hM7Prki6r8/FvzNOLEI0VfAqSTPKr4fjnQeb4A1FHCHE6kOXy08NAUWeS0o2G1LRsCKs2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCPG37JCTkmJlAobAu7KlHEpb8p4OOz6/81rbpshf5g=;
 b=NLIO6Ai14Gz4Pq7voihJFd4RhcRL//QePCwPM1lBhXSPHBGqGR/l/2HSas9ONdKms0Jakr5gr7DXvSZLN1LUZ45Zxjsi6o2+UQEInTlrDKKbLMZDBKJhD+hvPSilv9R3GBO2Sf6qa+CreiA4QzKyP5GHlmC1cJgx7gCaT3oeNulnMBijqiDlU9mTL+tanoZRuqflKuMcH6nDJ/pNVtn389g//yZZYz19Pp1WTjFXTI4qlIFFsXtf6nlxv7aCDLViaoa+LE4SPM3WKF/Qn0LkXHlPIdCodpLnJr++ShUR0+tnqTyZFqhOOfOG8ZnOceyBm8vdWgHKO+dQVgIFQtn6yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCPG37JCTkmJlAobAu7KlHEpb8p4OOz6/81rbpshf5g=;
 b=gJ1Nz2U074BQteRdrxAbXjik4UcsHICx7EbXAbVsCuAl6cCo/awy0LE4WNHLha7iGR+RUFYGmRJ9yg2uC0x0okTE1EGiIa1STPSyfbRpgmbSWACL8GSroo85nFsXamQcsX7TDY0bZESFjsA4mLZLvbrxd3k37GI3dhoYe+D0hdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GVXPR04MB10431.eurprd04.prod.outlook.com (2603:10a6:150:1eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 07:27:20 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 07:27:20 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 1/5] shared/lc3: Rename LC3_BASE
Date: Tue, 25 Jun 2024 10:27:07 +0300
Message-Id: <20240625072711.7011-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240625072711.7011-1-iulia.tanasescu@nxp.com>
References: <20240625072711.7011-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0031.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::20) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GVXPR04MB10431:EE_
X-MS-Office365-Filtering-Correlation-Id: 00f78739-738c-4c15-becf-08dc94e83fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3sjRkGIypU9gVq4IcY7ZGdvabZUrqkVGy6WqStnOM9u+2isG5GIxdbextICy?=
 =?us-ascii?Q?XJ+OEEx6GxcD8wxb7K3ZhhBGj0rdfVCNMGHknFL/edLbP+jZWCVKfxn+M4gS?=
 =?us-ascii?Q?LUVLvtMOOefeb+c1Z7MavzkqchAXTJF04uUEnP5ryKZIVaPTJJsY/c+c9Z+R?=
 =?us-ascii?Q?ty6mKyk2Q45kJX45YNo3zJGOBOuTD47RK81hZXsul28XLxU/6qU8n0QOYZso?=
 =?us-ascii?Q?8fLA9y1P1zr0vA+YnwQfbpkX/jnsiVvw2RDlHt1K8/lKYl7molNBHIBYkkfL?=
 =?us-ascii?Q?CIGcgCahmjSR99KhiNjlZNF2abYU13K+dmYn496YnJuJoylug+FVTglhC5SO?=
 =?us-ascii?Q?WKAJqmUIpwg7LQwkijqUdYURVswrIbH1mudojNZ5OlnhsgvixuVtqbb6qbZk?=
 =?us-ascii?Q?C6/HWfN1ssRTJBj5M+V8xTTcVBryWp2NdfXyWRiWNIxt7+SGxYKZPIPUtzEC?=
 =?us-ascii?Q?TUPkjVbjOmeyuN3mvHdSPuOqn080iqWbPlHmyqbq9OkspOUt4UeHcKzlFelN?=
 =?us-ascii?Q?MU3i9qvygPb1VDS9ZWxFKeH3rEQw1WZwINBL3Cphrbnjg7KtYVkcoq2Ogi2W?=
 =?us-ascii?Q?4apXB/OjjrxHxzDXrYyEk8hq5rR5OMImn/2cslVbk5ccGV4Batz8n/kRHMb6?=
 =?us-ascii?Q?nk2JOSY9CTzXZRj0Fc7eIFuQV2TwU1XFQnaFt7Az+jzE4CBwNLo0cniYZDyc?=
 =?us-ascii?Q?QacJAldBMIMYL3C8E1KS43EeqMiAor0fWYXzY7L67sthNRB9ORcONTJQJrqU?=
 =?us-ascii?Q?3UoDBb2EzhicDVmFlFLNcrhd8FGEKgSpkYMLngM5fB6IVoGQtHBwou+7uwfg?=
 =?us-ascii?Q?7RlUg7v0B4fkTR9WXZYU4fDeM1+g3jy421iteZwgeBppNNW1wlufljHv7vxc?=
 =?us-ascii?Q?FlzzSVO33nT0R6XP6VruEnWxbGGLsITNozDoc1apDhigYkyX65QRqpYPDt/d?=
 =?us-ascii?Q?nBX64wK+J2sxLmmJcg/AyCu3SVvTWFRtjbJ9qVL/tv0ePcFVrRRh2As/hTXP?=
 =?us-ascii?Q?nVfIedd+J1Dl8Ttgr86/XsLXSUrW+dqSUPWkYFHKMmZ86v0j3b1xZq1fOtKo?=
 =?us-ascii?Q?7nyTtJxzRMYPOubkau/9PCVI+IoBDZ53pMK2q0OO4U6I4uBmo6stPIH4SK/z?=
 =?us-ascii?Q?pZ+4ZpXoCVBYf95kLgNtOQqZ2XPb1sibbKUX74rbW1JCC8gsaJkwDPDSJH/S?=
 =?us-ascii?Q?vi8NrP4SthNyc6yxd+sxlrZpyQH4FJzV9Qwh+bfcjFvH2veezDPyw+LIwvdf?=
 =?us-ascii?Q?zg8nYSz8WLbtZzrE48tHF1GaFqd8K8V1Wh042NOHfTad/B4CqU7KeCfn1Y1V?=
 =?us-ascii?Q?kirdpZSNduK3xoMwJ7xqkEZlXhWQusYxT+frHaLXHNDdsw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qm24MSclHZcdNeIs2qfq5lnpkLv5imiic/aonqcUg7UGsu8dij2J+vHoymhX?=
 =?us-ascii?Q?L90Xw6/8if0+AEaDNfspLUThjz8gMSV3Q9X9lc06EJW3bKkNjDSqn7hj3njM?=
 =?us-ascii?Q?oiGQJAq8Ag1BzVL7pOcRcoIXLHBCE+fhKPi5d42KjF2XFxNU/JA7RglOk2Kq?=
 =?us-ascii?Q?bBB8kn+f03edCHptfdXhO+Wk/yTyzkEry3zDfb+OKJgmC2faAPNdUXVu80MJ?=
 =?us-ascii?Q?y4ItyPkkr3dSgecl52mdVBFHkvcteOk+WKMpTwAXftAMPniCx0arwX9kTgpq?=
 =?us-ascii?Q?85pfHIEp54oKPR+bNWw2+OuRTP0zW7M3uVKmUzQX7NLAwKpsfK9N2BiUqqsN?=
 =?us-ascii?Q?bn1/9fllOT1crKuyo/Wx7Fa1BFgQAeyC36jgGfC/gOrRCzIYc38tZt2XXubf?=
 =?us-ascii?Q?2o4yyQt9Oo6UBU5frcCeXUkQZNlkkDF6p4JoHjWj/IBjDXN5Tu4odne8lFxX?=
 =?us-ascii?Q?KENfwJqys1lHiwG9h+D3+pNs5HY0pXCCpBwtDCLMrsgIaSy3o3NSSgltdTBH?=
 =?us-ascii?Q?Ujs4nHj9a6W2pU1sHGug37CD73gHTEgbO+1CpSxBnNfKvAy7ywQJWtyiBbLF?=
 =?us-ascii?Q?mmdIkpv2iwOeJILKOPq21SOf0QKVRbLzVzM6V16zbUylNAPi4pFa5FMQa3rN?=
 =?us-ascii?Q?qw9pQzOrgG4bMPrVXrYhm9LImZEnAkSqt7MvEETEfFSfA+XGitR8wE6nyMMR?=
 =?us-ascii?Q?KlAnHwZbUBkNaBBTd3ADFunagqkHUe5Y/mAfokjk15ZjCJBQJq+QioQ2gqAX?=
 =?us-ascii?Q?XQ/5gs+bmmHGeEtgXDpFLHLmKmC8h0XKE6eOTEubK2uG4WsWbcLklXzH9I3i?=
 =?us-ascii?Q?tbRzocQIbeO4Y25Px9CxPSI8u7IbkZCJ3nBKK5Tjpxjks620UNCTwUKNZluh?=
 =?us-ascii?Q?stnlMkWj9/FB9bzy12bKh9+XoTZRBp4YV9nTb7zNuecWo/aZr4UY97Nj6N8q?=
 =?us-ascii?Q?HjadsDpG9S97A//fQ9Qjv1MR6YwANM61rmq2/Q9yXw1a9w4dKELTc2D2kO2O?=
 =?us-ascii?Q?ZbAC/O/SBV56hyi/vnVDTXldmlH9WCqASCYIUJa0lBd0NhkoIrxgFAt1bwUl?=
 =?us-ascii?Q?x00ZLde8FPqXC22uJyloF2OhnaswSHSAT/JD2DC04CYvw5Cr/tzNMkMVni1t?=
 =?us-ascii?Q?v4xE0AXDiGzM945VrAEouqXo3gO8Qh71ZoWWF15Lp/Iok+b2NpaQ16fdodMb?=
 =?us-ascii?Q?sUqO05Un7k/Ng597uuKtOYZ1+LS6QRhahN4zxDWZCcaUMG2moZS7os0Udipi?=
 =?us-ascii?Q?U8Jd06oO6//K9zraeYQnvr7YRDjJ5CXR35fL19aKpv4OXDan6lRDb+nHwGoP?=
 =?us-ascii?Q?jWYzsrPm/rIuN33ZBeC2TSjIfgdRfb/6jmjCe6/IhFUy8yaNeCwSPjCqwGE1?=
 =?us-ascii?Q?SO5dgfrYnqzHuG7t+xe1ib2+2YBeYjbXgHeKSxGnTGUxkQvpvZ6C5ysSB5N8?=
 =?us-ascii?Q?w+NmKvE/2tzTn6PJ0AwZaixXcrPxl5afAR9E60F3YBDf3aokutb+1etex4LK?=
 =?us-ascii?Q?lBUPWOCqF1YVBypNfO34imDzKpba6CEsVmYrgr5mkG35Ux7Yjb97MOJL85Xt?=
 =?us-ascii?Q?9yQHxDuAXk9i8dbnTwEC4gexHsgo4ozXLdWSK+8w9EnlxskeqJqj9s2ygGYs?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f78739-738c-4c15-becf-08dc94e83fc4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 07:27:20.4116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDYK3kHs+ECmkdVpt0x9jJALpTA/pAgmk67GtBEOTkQkxd+ywLgW7dO9kpF6b12cI6fwlTDVp43KuZWQCspSbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10431

This renames LC3_BASE to LC3_TYPE_BASE, so the meaning
of the define is more clear.
---
 src/shared/lc3.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/shared/lc3.h b/src/shared/lc3.h
index 95aa21702..abd9b29a3 100644
--- a/src/shared/lc3.h
+++ b/src/shared/lc3.h
@@ -12,9 +12,9 @@
 
 #define LC3_ID			0x06
 
-#define LC3_BASE		0x01
+#define LC3_TYPE_BASE		0x01
 
-#define LC3_FREQ		(LC3_BASE)
+#define LC3_FREQ		LC3_TYPE_BASE
 #define LC3_FREQ_8KHZ		BIT(0)
 #define LC3_FREQ_11KHZ		BIT(1)
 #define LC3_FREQ_16KHZ		BIT(2)
@@ -32,7 +32,7 @@
 					LC3_FREQ_44KHZ | \
 					LC3_FREQ_48KHZ)
 
-#define LC3_DURATION		(LC3_BASE + 1)
+#define LC3_DURATION		(LC3_TYPE_BASE + 1)
 #define LC3_DURATION_7_5	BIT(0)
 #define LC3_DURATION_10		BIT(1)
 #define LC3_DURATION_ANY	(LC3_DURATION_7_5 | LC3_DURATION_10)
@@ -40,12 +40,12 @@
 #define LC3_DURATION_PREFER_10	BIT(5)
 
 
-#define LC3_CHAN_COUNT		(LC3_BASE + 2)
+#define LC3_CHAN_COUNT		(LC3_TYPE_BASE + 2)
 #define LC3_CHAN_COUNT_SUPPORT	BIT(0)
 
-#define LC3_FRAME_LEN		(LC3_BASE + 3)
+#define LC3_FRAME_LEN		(LC3_TYPE_BASE + 3)
 
-#define LC3_FRAME_COUNT		(LC3_BASE + 4)
+#define LC3_FRAME_COUNT		(LC3_TYPE_BASE + 4)
 
 #define LC3_CAPABILITIES(_freq, _duration, _chan_count, _len_min, _len_max) \
 	UTIL_IOV_INIT(0x02, LC3_FREQ, _freq, _freq >> 8, \
-- 
2.39.2

