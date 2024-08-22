Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012016.outbound.protection.outlook.com [52.101.66.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC6C1C9DD7
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Aug 2024 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332379; cv=fail; b=LX+auoY859W3+7kSydbOPlcCII/wP3Y4Su02YbPntNvPSgXzmCssZ/RwrYAIkSQXptYOstoFUXNlLhgWqvaoQkeYN9gDtv3hEi4slMh2M0DE4b6bP7X5Vl3nS8pYPFCbn4GbUXPm5x2qumV9U/IVkfGxDJyYHWg6rtmFKHepvmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332379; c=relaxed/simple;
	bh=jJx/HJ4oyiZSbsojYq9nWLI8CC0iSABsdLsiDvBv9lM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tzz5ZOV5rhtO40dcZ6rR9Iqq9QzXPpjt84apqJwHs2oUwXMF+g5COCPSVWnVJrRC/mmlGY027zL6NqE/skWeTUS0HfI2riLRjH0iVWWhhIFNEsjBBpHFaxeGY9FZYfT+DRLFZ1EholQNvjBNM6ZnaxJ4SO1YjgdLhU7TIb710f8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oOtfkT1p; arc=fail smtp.client-ip=52.101.66.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oOtfkT1p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nn7yrXpPYjqCM8Q+RCBwDoryqtYEAZpkA/JJIwrTeSLvRE4ywt/JgR6j3OQZ/YSdtimfU1Frd46FEON475eSh3NTxDdNDToc67FqRD8fnji9Qd380XDfiQBp93T1BUtsbNdBT2BOzvv3uPWij9DD80hWDnLgPWiyFdA4oon0pXeSYOC6pHNejdi02ptYAE7qTKWVFQblTDJnFj8ibUvhYwLs6vdcAZ+gtlA5W8vCvVRsGRzMEhp7VA+Nu68iwdF4/Io1abrcj64oxLnzHr7UaLXu9D5SQx3P/zls04eAqmJ+H0JZ11AOXQ3qzHeJhnY7ylZ8eBjlGBdGTl/1lwRmSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RC94fB2eIIipFeark4V+xoIwA31K9XXoqF6QVedwCx0=;
 b=nduKs3trvdEY1sFtf5SPtjAX7udh9grGX9grZy3F7bQIcXBp8W2iXISiCIjRFv4jfoUNI5ozIPnGl49Un+wHeP/dIWNHmii7cHArS1m8yq7b/+9lAjtekf6MpaHS4T05D2Ahv2f5gw8XZEgkfbx/YZbsuOEeuNE+b37Kp7XDGxXsubDyABEqKmQREjNvrv2DCVVPy+acQFgwQ7zMDBIK7gXI4oVgchJinyMHxGwEHptBZLy1fkRbymNN1SmoKM28+eadw063cuXaCqM8bAoWfLK0iSQCEkdnebNPO3/b3wOfrgg5Bsia3ooDRb6d/T4GNCTvnK0LftUEWfOxi7w/IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RC94fB2eIIipFeark4V+xoIwA31K9XXoqF6QVedwCx0=;
 b=oOtfkT1p08gPfY2C3q9ptheKZvv4MIRfbJ+tKCb4ttHeFtjFpeLsIgPN3Z5I6kipeN8nJQBQ9vnhJZQ5W/cnh7dGdDMf9WCpla8yqDlUAkVmHxgBAVio/gOubzG0FBizy4DWIqlUx3f7SRndxtt7tuTcB9leA/wJRqrCoFq4kJaw4C0HTHsW5d5wmfOxAIXzaaUPmHoqAEvkUTOZyIfxRT6BBr1eol67u9M72g5vnhsYZ/6BpmG1ru7x3BiHgXkNm6w7b8jfgxDoI41xCQct4z+H5dqmXAo4XPG+BiYn59dBcOcWHSCnJCMwOdt1nLstoLn8Z6uP1F9KkVhIGb0Wng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by VI0PR04MB10565.eurprd04.prod.outlook.com (2603:10a6:800:25b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 13:12:55 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 13:12:54 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 1/8] doc/media: Add Encryption and BCode fields to QoS property
Date: Thu, 22 Aug 2024 16:12:25 +0300
Message-Id: <20240822131232.531952-2-vlad.pruteanu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b87fe718-9eeb-443c-0a25-08dcc2ac226a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xLWIMdxAIPIHNjHnLOa+wcaQHbsGP89xgHw5uOFfO4lPNGwu9h9CGpigcIni?=
 =?us-ascii?Q?YVBSH/g/CdwcaXy3NPQbZvVDi+rvgDIhh+ww7TcpwQoUheBsBrTL7Vc4wpit?=
 =?us-ascii?Q?lHVZN3K6FfPjZ6AjibzwC8WJ+ou0Pa0WIQkH2wr5Bw+1a1pfsauWAZYQctTR?=
 =?us-ascii?Q?KDe3ACHqFteSU58A2dPLjhKnuMVnKhpIHpuTCwH3LGuXBv9fU3tG9ljBnb0P?=
 =?us-ascii?Q?OW0cVjC73duyQuGV2oNlkIkwguBQqbTEypBqQq8r72dCcXP4dzH4+d2BeTtL?=
 =?us-ascii?Q?hdpvTHAxuF8cDPLvWXDPlr2Gz87vTr2+jxJxHdH5Krr7Sj/rQ4BIRWo+EOMQ?=
 =?us-ascii?Q?3fTpocZMZC4ZFjv+NYD0ObeQUZKqNlOy0Y4TELjPEpv71Z4Ibi+J5Zhktz9h?=
 =?us-ascii?Q?usnC77VcRQuym4cCO3ZT46xpx+Uxe2yPq02o/AK3FdJzfX23FO143vc9kfyL?=
 =?us-ascii?Q?kNw0qkrkEDDtmwsTPvbpS/qcKf/2Ukj4vaFe00A7L302V9KpUJ4B/1zRrJHG?=
 =?us-ascii?Q?I55SdMiUwwVPqszxeUkbguO9jXY8YfWgjvw+Z9sF4tWJkex504S0bHHwIal+?=
 =?us-ascii?Q?+rV4r/e6EdDKw4YmuFYN82/9Fo+IsSWFk561ZAP7Ly7+soZT9r1lJyX0sqRZ?=
 =?us-ascii?Q?rouPgYPulD5tOoDPC9xvOne3eQfnfxdAcijT+DR2bGiH6JqrudVD3GGhiHQi?=
 =?us-ascii?Q?K32bEy0rRgtxMn+q+5N4IUApneoYe3Hv04vuXlCT1R3/EcGu+A0I7xMiZLU9?=
 =?us-ascii?Q?CxUw1ZRs0gCAxq2wU0hR2IbA1gE2s9luOk2VEbxeUcvqkp+jWF1ytLoCekUn?=
 =?us-ascii?Q?tKUb53QXRrBcMJTa5H0J2VBqzsLc8dXkmStBltvZQ1ri+Kp/gdsj5Dn1w2TK?=
 =?us-ascii?Q?2RvGZbmKbvFU4vfatTpjeNZLDFW7NRfp/x9u+TTjJwrOQATEdSVc5mOTm7+w?=
 =?us-ascii?Q?dRZ122Col7jwP4AuGO2DPyS4MpbuO20jWw3mDCnXoybJMl65T4ZkH3IR8p91?=
 =?us-ascii?Q?QHVznbeKW3pBkyAhNn3SyqSX/6RTybb8W2dtwJ/wUfOqNsKrdbg6KCoZsuA5?=
 =?us-ascii?Q?QmKaVW7Dhn/XMRCLJt6OX6QWPYh03R4HgycDlXaZYuvfSPPi4R+1ZA4WrMh8?=
 =?us-ascii?Q?ZTZ/i81DDlWbShSV9c4F+GDdRRugGbopG9qZuIG9+ltxpNkx6svlxlChEIZv?=
 =?us-ascii?Q?ym+8v41Q9ZJIUedJHU/lRj5TLOVHRj+DriC2sakM2RfwaKHDXBVevnzJ/i0L?=
 =?us-ascii?Q?rYK1w5cKoBfStDR4sW2oeeiAx1qjgcNr/bpylJX/Q5uqcGefepdym4Lw1fkH?=
 =?us-ascii?Q?+3pm+AO6Dh3kg24JGhHiqtAcp0WfGBB/u67LcGxM5AIfx1xmFR2aJzVdm1tS?=
 =?us-ascii?Q?Ch3ipWtevTjOQCqq0Q/obtds+TdReazMM/1OviTdchajMVclbQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HjBXm6VcSBgI8LxtXo2jIKrOmc2SHht4JvlpvDHJbMvGlGX8j8MwvdSiBL5i?=
 =?us-ascii?Q?QhIQ2YLf/Kel9eCg0pr+1bVqZSNsvJQQm7sB2SAKxP7v+CWb7fCubUci1Q3Q?=
 =?us-ascii?Q?46jH1QjB1VROYelCtpPVKa6J/GCNoXq/FKxqhWEtMZjdEkvmhAmAz4GV+7cv?=
 =?us-ascii?Q?dvJQtMTJjJ5dq//ptb6WJCfRBmnYklqOzv3YNSdEyeXooWFCP48d6Zs7gIHt?=
 =?us-ascii?Q?oDMRykR7QY/tnCuQpw8hTzCZNW4b1sB3GreQMBsNm+YhhZzfnGSMtYjgxTkK?=
 =?us-ascii?Q?8s1z3s7NMNr5IHxNgo4gXfxR2/gc0iWcMGG5dQKwIV8AxbDHiDB4u5YQ1UyJ?=
 =?us-ascii?Q?GzU3ADvkTZntSO+WQh35CRHoM3GK/zutt5nTBN7ZL9H6mSTcOMEz/oFYpWy7?=
 =?us-ascii?Q?2n8V7BMwJloUzDSvEfaGaDn1gkBzUlHwbzpKaMp5YCRhuLhqCxUrd4XctOZ5?=
 =?us-ascii?Q?tj9lUa7q3s24i/ydmyqWpEIXsYzAdljarmzXJ0bObgXKZyhiYyfiJqUeJ0Jf?=
 =?us-ascii?Q?gDw0fzE3XWJcQUW0njctaGr/ckqg/X5bS8jJ3T2rJRpiqUxKoSeA/+oCAFJi?=
 =?us-ascii?Q?Ld50WK+WIRAa3V4qhOXBsR4PL18b7Wxdq/SYJv0X0vggAQ25umwDvt21Ky+9?=
 =?us-ascii?Q?0sqWvfvsU6X1/8Ei8qVZGhh3q9EBdTw/5IKlxdTiah1g7wE+rLgzwFuOfo0O?=
 =?us-ascii?Q?NrQXSWp0pWK0zv1Ny+igl+sKTUWfk70cgel7Ld3mSKSRVSv+DFJCMzjS1YjC?=
 =?us-ascii?Q?dyWi/Pv0heEnMyKEM4jmNDzRBrUsRR8oKrIfq3TSCUn8to1S72uyc9sGF6Yh?=
 =?us-ascii?Q?HGzQ40MlkeOX2A4EFEbS2RMhudVajz7cvrIJv7hoCIf9k5exsbGDN7ocB8Bs?=
 =?us-ascii?Q?v5bpTEvzK9IaLIVnroO3ZUI17orZZP0bRRupjeLFxXM68nut31UGXmpFnVjP?=
 =?us-ascii?Q?P03MmDJ3jpQofyAfeDzL/68UvKTcCpUq7T/0iJb3Ixv7JXop6DY7Basa2T5J?=
 =?us-ascii?Q?n/pKxINO9OiZBePIFhT/dUm4m8wU3oFV3DGjNEgcX143RQ4YF5v0i+lfJe84?=
 =?us-ascii?Q?eaGD27fV+HJP+xj/zMFZMxwBK1KMzh1Komo3/oK9xxHKq899ykaprKMg2zoh?=
 =?us-ascii?Q?IBsqu0tK71KWQM+x4ZCWMHPdQF9CWxhTMiX19p4AI9U0Wl38Flvg0g64LJi1?=
 =?us-ascii?Q?d5Nt8EkqIpd8xnom6mRz23cyq4RrTKW3qSaH8EmsVNG+a7SqYuepu5w3doSr?=
 =?us-ascii?Q?6Qu0lQI9b3lXILEDWHRM9hRcnfRH70Y60T1DW6obNctGe7GaHqyQxOL7tKkp?=
 =?us-ascii?Q?X91xyZZsuyMmB9cXZSXSJpWk1Wu5OPFNpf0pQ6qOcYQcBWneJ9Gzf6GdfKz2?=
 =?us-ascii?Q?Ij33/f8MrRUuwo7Gl43ytC+Y+V3OQw1wVsd+6BIKyNAktPu6DW6VlQnZ93A+?=
 =?us-ascii?Q?nwPaKsTVd4HH1fFMCGCzHVjGIaBa3f0UjK38beGUtq2NKpzK09mJUePSlxbp?=
 =?us-ascii?Q?qW8riS5d3pIWHPYmHZrcc418GUPYee27IMasePPnIWCTuoMIw3cU/SLdiZ5+?=
 =?us-ascii?Q?u1kGFdIbN0hUGRLZZg5POr1kh9rhW+Y65tg7s+cT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b87fe718-9eeb-443c-0a25-08dcc2ac226a
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 13:12:54.9109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wd9aDwjLQmjYm1Yvl91e0KoBvC6H1E2AWJgCE6mJPPvLvNh1Zsh7uLyhCgv4N5wdfXBMgTd6Pa8zP3Ri2olZJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10565

This adds the missing QoS fields, Encryption and BCode.
---
 doc/org.bluez.MediaTransport.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransport.rst
index eb3e04ae2..b53c0cd26 100644
--- a/doc/org.bluez.MediaTransport.rst
+++ b/doc/org.bluez.MediaTransport.rst
@@ -242,6 +242,14 @@ dict QoS [readonly, optional, ISO only, experimental]
 
 		Indicates configured framing.
 
+	:array{byte} BCode:
+
+		Indicates the string used for encryption/decryption.
+
+	:byte encryption:
+
+		Indicates if the stream is encrypted.
+
 	:byte Options:
 
 		Indicates configured broadcast options.
-- 
2.40.1

