Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2075.outbound.protection.outlook.com [40.107.241.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73835195391
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jun 2024 10:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669563; cv=fail; b=GTa8Xskl8jf+kO7k8egpvylrEgwG0eZvU297N9JLXdenouBUXOulWT1N7uVcY+PDw4x0xImT4gcVKgMruT84I+M5YfzLuNFOsQkLKdZdiWUKVtXi1bHpAkqg0bIid2L629IT5nCkWOjybCU0v1RU2TY/Q9mAI+t32cyn8HIVCBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669563; c=relaxed/simple;
	bh=DZz2+fKtjV2mK0A3xBxVj6yy8WyC16Dd24CLMatOgio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ygjzre7/maIRPdwDjcUiMo0vWPeSmMbBlxU5CbDFOAJJaJ+pjGAnDTzy4VgxNWAgKapf6il/FnE3L2N5M39uTb0Li1tXpBlGm8KlU3be7wK2g8XJ6IRKTl7hqorGzdKuZGU9OugLJpEQqBx1lfkHkWz0W9NRepNRw7arGAyRDwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cNAzy8Ze; arc=fail smtp.client-ip=40.107.241.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cNAzy8Ze"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDqhqTLhNmL4/PhMaNYLNz4iboiLwukrWQey8IZGsDkDrOg/sYt2/ncBzh3OcNZLorZuzxjNJxEgs3Bb+4SR9B1ckRXYKOV5Xm5GXDyTHtQqfrevLQHcq1+VjdXNDSHAeL7klZE9++nipZwCO+N/IWT6jmZfI1HFD1IFxAxelKGt8N4rzA4H2/arYGc26uo4D6T9RxoECyd8Rk6eerPREnsKoqsAoXIo2Z7BcRssmsHMuxDkMP8v76NsDCgDij3thd/FC87OBplzqjM+dTVMSwY1R4gkntP/cepG217WhoCRHth4YNEkXSoJjLvmrtduY22hPNw3SxPQSYI/f7uxiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmuvce2D46eFcsIEV9BiNshu/516pgVSogRgg82sMRs=;
 b=Rw57Inj+owZVbb6tZrPA42KtjnAsXLjaQnZ1d//WuWeF1UtdlDhdZ4AB1RhRwm8htP4KQEJULw/KXnGIAYmjpcBDSRvXlS62Gp9EQ1Lcl8cxKQktNwSLqCRr08WWXW8vY3GvNFnupKW++mblHwZ/G9oa/jYsbdD+8Wcy5xPP2ZdAfgJSVdKxgNsePiSsq7dYJBQL4Mkyj+zwB+SFlLe4R16Wm9LZZCS+ApJSZutj+uJ0SWNZ/U3lBIV4L6hKzTAVmIF1J6iAzzfSoeyGGJYUo+rUvfR2G1Qx3Ja1R7ZDZvS4S9jDuRVLI/m1o50Mv9L2QNrYt5P93yZPFf6B6tZBjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmuvce2D46eFcsIEV9BiNshu/516pgVSogRgg82sMRs=;
 b=cNAzy8ZeJmFqZdDmQtg+xjK0VuGeT9k7o+R43sAyepdtFRIVZT28Gaef9er2ZD3v7FT276W+TGRMqarrBek4ty0o2nA3O1VAVAPNnfa/HX/iLJpTXUqNL95u/qIQnR+Daj1vf6niLiBY0uHun01bs7b3cyOGBHv+qSNI5lXoGrY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM0PR04MB7027.eurprd04.prod.outlook.com (2603:10a6:208:191::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 10:25:59 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 10:25:59 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/2] test-bap: Add Broadcast Source STR MBIS tests
Date: Thu,  6 Jun 2024 13:25:41 +0300
Message-Id: <20240606102541.5395-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606102541.5395-1-iulia.tanasescu@nxp.com>
References: <20240606102541.5395-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P250CA0023.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::28) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM0PR04MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: f40ab772-86e4-4aea-3c62-08dc86130eeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+0/VezfuNivTH03/qmaYqE4w5sB4fqr0UPT9dmeOp9NjIIUzvA+YMN/OWPxP?=
 =?us-ascii?Q?SYH5RezujN+rGozVk7oiRRXtLlXGjYvse5yEOMDo3lTRcVAOFL9su46X2vuj?=
 =?us-ascii?Q?XsUUovL3HpMx5BlpTJS1eAf/OL1+sHl9JA0LRIyJGlO4FUAh2YNNh1YXZncC?=
 =?us-ascii?Q?EQS7ErshokiBH7IpiYPF4vEq/PThndklBBoqLtMr8SeC61kWlgNpQTxLIyrK?=
 =?us-ascii?Q?INdnr4kRng4mZlUp4ZSJe3DdG4kjA11LyHWXBKBBHZF4B8+XF+Wnj5uTmoXD?=
 =?us-ascii?Q?KK1MQAisWBGbrVAZ6rrsdvfT2fylOu7qhfATVv5gpGVx+CqKlS9ZhFY7fJIX?=
 =?us-ascii?Q?ephQcECfqdLAxbnVxlUl7CKkYENwRTxygJSR8rUtvkH15N6NOF865dlY2x2B?=
 =?us-ascii?Q?OXmoJmvy2+zWhWgcOjKdXLvKLY6Af6wrGkklagzw9BF9bfnLNe7DUTMhqRhI?=
 =?us-ascii?Q?IHTMDDXvt4oNRtvo4/DB3Sf0ZTLArH9u9fAKVaYfHbFnlX0U6ZvkoIBtsUBB?=
 =?us-ascii?Q?404saq6oOHfWddR3cuNBEhZImSMQzW34FOT8fQoxtI68BDdE1PEKuDxdD07I?=
 =?us-ascii?Q?LYnHhZEm6/BwwHhgUb6oGGpbRSlSYdF7Iwe7b8uMDq0vVOmyX/HN0hgNgs97?=
 =?us-ascii?Q?rFbG269Nhju+UhJOnnMyevuxHS25YvMWQ3I0P9g1QGWexFgUl/LAsA/XP+Zv?=
 =?us-ascii?Q?MRZZYxaucESv99e804FPKN7JnZKeBX/2uKmJcmlHgDRbSk8Nk/Sqhp3M3SMc?=
 =?us-ascii?Q?RfNrCfzeTiQSTXJjSoYxZocvkskC2hNp+a4HiaGtVbsm4xiEtf5RYFYaRY/r?=
 =?us-ascii?Q?jwW4+3q3UgExaYP4+JJvneTixIN992AHdvj7fpCRLFRszZQb+vFoyH7IqFuC?=
 =?us-ascii?Q?c7ud+nJBBB2N/sp4UOF+I4FWPbsvkPLsLN3AsxPghjz8d1Tu9cFKpOoj6HRK?=
 =?us-ascii?Q?JNZqfFKoEDEdxs/CmaJ/Q8jk0BfMltpnJqqAiVhDutuWj6jGQUBePSgs/O7v?=
 =?us-ascii?Q?mZrVRUg5KnQjhmASvvaPJHJkmea4UOXJ9niw/jGmZRc6+fpzsNZPRCHdJ2Ln?=
 =?us-ascii?Q?jStimAGI50pbqb1QG0AEcEK+gvk67dMjHx5M8MehQ0+HXIbDfxu/d9AM5gIW?=
 =?us-ascii?Q?0qQt1KDkYn2qpdxzgzipLyfAAhWw8kXthP0VL3VYSpjVgyqG1bSDHRjmcYko?=
 =?us-ascii?Q?jgb3R5pPRor3uHEcsXE9/QTljKjwH2JCYoLVJ+8U8QOs7l9xluIdfiQvye5E?=
 =?us-ascii?Q?uvQsygisb1Z5Dn659/2vRTFohzmgeknOqDc2chjAlYqzBUz+uoZOq4QL3tfD?=
 =?us-ascii?Q?XbdEE8r0OFd8MRKN8hzrR7YR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1IYP0eRa8I+X1teUeKrQUAItCh3wO2q1zpJcNejqPDKstcm9T4kL8EfeqPH1?=
 =?us-ascii?Q?1CLEoyflFzK7vTi2KwJrBwSmC5m5SSYn8mITeBBTwACL0w7f5JOwBp/jbo15?=
 =?us-ascii?Q?s8/VPgW3LoQLCm+oMwD3SsWC+Vl87I82qIHWmz5m0Fj5HhufqkEDIW7JT8QY?=
 =?us-ascii?Q?RN8GuaRfCI/SWABz6SzCZZnFOiPObwtJ4SbiXudsl30hYzNincwknJ/xiwWB?=
 =?us-ascii?Q?jiibY83X26nuFNEo0eaOio4PiHNcEiAKRmrBS8oOx6wSfyKETnax/aUtb7iE?=
 =?us-ascii?Q?i7PRmQNE1nPHpvInEPkVR84mK1Yabj/ZxWCvlL1QrO78a8IOMcqNnt5j55ct?=
 =?us-ascii?Q?ccga9WsBEIQidMj27wVSuXYz2q6odv+EyUzlhqF/wjMBpsFyPBA6POXbhpvr?=
 =?us-ascii?Q?FI9CVX2cQ+9qhxjwJZfz8Fbm1C4LAHRhxpz9FGT8CmCNxwbbzjjJQgyyYV2X?=
 =?us-ascii?Q?pELA7s+Oxlz7o5yTVAha2dmgG4kqzMGzdjxtQDjBPqK5a+jg7t0GEm9Rwaxo?=
 =?us-ascii?Q?so1Ffql6Pdaa3wO498/yd+zLvRFpWG/bGmvbQ/t4Zc4u5+SS2WDmcYddCBVs?=
 =?us-ascii?Q?eGBnCn5zTTXd6Gsg9gbtoHmAdSfFgefUd7UMFSPlwXKIK94vSPEY//K3MELU?=
 =?us-ascii?Q?kLr41ERe2jDciYIbVqTlM1KRWPaQVPFcMvRAjQQon5UvfFvMJd9dnjYxOyLK?=
 =?us-ascii?Q?N7IO9JxH0sU2q7MHHm6/AdaBEBa1ljrSWRnS89+8m2GPjiIOIyND87Le1lcJ?=
 =?us-ascii?Q?tEFXjr823K6omSpMfr/Uu1NQPSz57Xu8sRCpudNEc82ZQtoBCdgzSMCEstMQ?=
 =?us-ascii?Q?lB1Lck5IQ60qi89JP7GMBwlrjpOdGV4/njn5xSsz3AGAnxIVbjhUctU+WbAF?=
 =?us-ascii?Q?QUfovnXng9iMOPkRR9x94R3Zdtd1zc7ZncBB3O7qpahQb63n75L8kJpswAYS?=
 =?us-ascii?Q?FxoGnTY0rl89W6yzQ8fWtPLcZ+QpsqFdfg646mUgUrfab2NL+gtU+Xx9GE5M?=
 =?us-ascii?Q?wUaRla5TDhtOvOBHXSmob7yvg2mNObw5DEfFJqzOTvPmVfDlNihRhzbI1JWI?=
 =?us-ascii?Q?tMYLvEDraeQ7kEj2WC8qCYCnEQ2rn0JfB6Hx05Z4HQPT07P3DF4u3uUFglzS?=
 =?us-ascii?Q?HOSasGP/X/J9zUGkBMjN1pVH36xPuwNWPIquz3P0s/QiL+BL10W01ZNLrF0r?=
 =?us-ascii?Q?VZK6jRC9aRf1PC4WyiHOX3kWBihE+pMFSQjvvVItEg6fldfM8SvkiEAn+726?=
 =?us-ascii?Q?8jU8f+D9k9ylcLiWqHTS9EgBfZDo8ssuigUuCcKq0CAcbFfoAPEJ25fvHuqy?=
 =?us-ascii?Q?1oxOVqxq/5xHhcSluW2rJKhZbyWgdVhc9qdssH4IXiXRO7e3exP1uKBiGStQ?=
 =?us-ascii?Q?KayCFtnQkgzwa7BeqRkkWo/7DU+B6y2DeSRove5X95cpIAJRP59AffZKjLyU?=
 =?us-ascii?Q?gBiY/tP5Q3Zb+/OaNOfz/H0oCc43DXQpp3413UHiaQ3gmNN3U11h35Qbgx7/?=
 =?us-ascii?Q?qaeIegkzFXjVG2GBzvY/tHk87uL0BkAbXKzHdREBeUnMaHZ86l5LiWxy5wVD?=
 =?us-ascii?Q?LaS2LyWGeazyRjf3LLvTZ9tz3+Z8dqgRPXouLkd8twSjdvHXSpqG6zwr5KVy?=
 =?us-ascii?Q?jQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f40ab772-86e4-4aea-3c62-08dc86130eeb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 10:25:59.4249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMIZE6pW6EVlqUfM0zkSwIIeKplwRErrGAQ5WqTIa7Z4tW58N9OnGCCkF+tjJSvbc20EMBBij+B8AHx5pL9eqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7027

4.14.3 Broadcast Audio Stream with Multiple BISes - Source

     Test Purpose:
     Verify that a Broadcast Source IUT can stream multiple
     BISes to a Broadcast Sink.

     Test Case Configuration:
     BAP/BSRC/STR/BV-18-C [BSRC, Multiple BISes, LC3 8_1]
     BAP/BSRC/STR/BV-19-C [BSRC, Multiple BISes, LC3 8_2]
     BAP/BSRC/STR/BV-20-C [BSRC, Multiple BISes, LC3 16_1]
     BAP/BSRC/STR/BV-21-C [BSRC, Multiple BISes, LC3 16_2]
     BAP/BSRC/STR/BV-22-C [BSRC, Multiple BISes, LC3 24_1]
     BAP/BSRC/STR/BV-23-C [BSRC, Multiple BISes, LC3 24_2]
     BAP/BSRC/STR/BV-24-C [BSRC, Multiple BISes, LC3 32_1]
     BAP/BSRC/STR/BV-25-C [BSRC, Multiple BISes, LC3 32_2]
     BAP/BSRC/STR/BV-26-C [BSRC, Multiple BISes, LC3 44.1_1]
     BAP/BSRC/STR/BV-27-C [BSRC, Multiple BISes, LC3 44.1_2]
     BAP/BSRC/STR/BV-28-C [BSRC, Multiple BISes, LC3 48_1]
     BAP/BSRC/STR/BV-29-C [BSRC, Multiple BISes, LC3 48_2]
     BAP/BSRC/STR/BV-30-C [BSRC, Multiple BISes, LC3 48_3]
     BAP/BSRC/STR/BV-31-C [BSRC, Multiple BISes, LC3 48_4]
     BAP/BSRC/STR/BV-32-C [BSRC, Multiple BISes, LC3 48_5]
     BAP/BSRC/STR/BV-33-C [BSRC, Multiple BISes, LC3 48_6]
     BAP/BSRC/STR/BV-34-C [BSRC, Multiple BISes, VS]

     Pass verdict:
     If the Codec ID is LC3, the IUT sends encoded LC3 audio
     data in BIS Data PDUs on each synchronized BIS.

     If the Codec ID is a vendor-specific Codec ID, the IUT
     sends BIS Data PDUs on each synchronized BIS. The parameters
     included in the Codec_Specific_Configuration data are as
     defined in TSPX_VS_Codec_Specific_Configuration.

     If the Codec ID is LC3, each parameter included in
     Codec_Specific_Configuration data is formatted in an LTV
     structure with the length, type, and value specified in
     Table 4.83.

Test Summary
------------
BAP/BSRC/STR/BV-18-C [BSRC, Multiple BISes, LC3 8_1] Passed
BAP/BSRC/STR/BV-19-C [BSRC, Multiple BISes, LC3 8_2] Passed
BAP/BSRC/STR/BV-20-C [BSRC, Multiple BISes, LC3 16_1] Passed
BAP/BSRC/STR/BV-21-C [BSRC, Multiple BISes, LC3 16_2] Passed
BAP/BSRC/STR/BV-22-C [BSRC, Multiple BISes, LC3 24_1] Passed
BAP/BSRC/STR/BV-23-C [BSRC, Multiple BISes, LC3 24_2] Passed
BAP/BSRC/STR/BV-24-C [BSRC, Multiple BISes, LC3 32_1] Passed
BAP/BSRC/STR/BV-25-C [BSRC, Multiple BISes, LC3 32_2] Passed
BAP/BSRC/STR/BV-26-C [BSRC, Multiple BISes, LC3 44.1_1] Passed
BAP/BSRC/STR/BV-27-C [BSRC, Multiple BISes, LC3 44.1_2] Passed
BAP/BSRC/STR/BV-28-C [BSRC, Multiple BISes, LC3 48_1] Passed
BAP/BSRC/STR/BV-29-C [BSRC, Multiple BISes, LC3 48_2] Passed
BAP/BSRC/STR/BV-30-C [BSRC, Multiple BISes, LC3 48_3] Passed
BAP/BSRC/STR/BV-31-C [BSRC, Multiple BISes, LC3 48_4] Passed
BAP/BSRC/STR/BV-32-C [BSRC, Multiple BISes, LC3 48_5] Passed
BAP/BSRC/STR/BV-33-C [BSRC, Multiple BISes, LC3 48_6] Passed
BAP/BSRC/STR/BV-34-C [BSRC, Multiple BISes, VS]      Passed
---
 unit/test-bap.c | 354 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 346 insertions(+), 8 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index c37f7676f..30c223d16 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -6972,27 +6972,86 @@ static void test_bsnk_str(void)
 		NULL, test_bcast, &cfg_bsnk_str_vs_mbis, IOV_NULL);
 }
 
+static void stream_count_config(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	uint8_t *streams = user_data;
+
+	if (bt_bap_stream_get_state(stream) == BT_BAP_STREAM_STATE_CONFIG)
+		(*streams)++;
+}
+
+static void stream_count_enabling(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	uint8_t *streams = user_data;
+
+	if (bt_bap_stream_get_state(stream) == BT_BAP_STREAM_STATE_ENABLING)
+		(*streams)++;
+}
+
+static void stream_enable(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+
+	bt_bap_stream_enable(stream, true, NULL, NULL, NULL);
+}
+
+static void stream_start(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+
+	bt_bap_stream_start(stream, NULL, NULL);
+}
+
 static void bsrc_state_str(struct bt_bap_stream *stream, uint8_t old_state,
 				uint8_t new_state, void *user_data)
 {
 	struct test_data *data = user_data;
+	uint8_t streams = 0;
 
 	switch (new_state) {
 	case BT_BAP_STREAM_STATE_CONFIG:
-		bt_bap_stream_enable(stream, true, NULL, NULL, NULL);
+		queue_foreach(data->streams, stream_count_config, &streams);
+
+		if (streams == data->cfg->streams)
+			/* After all streams have transitioned to CONFIG
+			 * state, enable each one.
+			 */
+			queue_foreach(data->streams, stream_enable, NULL);
 		break;
 	case BT_BAP_STREAM_STATE_ENABLING:
-		data->base = bt_bap_stream_get_base(stream);
+		queue_foreach(data->streams, stream_count_enabling, &streams);
 
-		g_assert(data->base);
-		g_assert(data->base->iov_len == data->cfg->base.iov_len);
-		g_assert(memcmp(data->base->iov_base, data->cfg->base.iov_base,
-				data->base->iov_len) == 0);
+		if (streams == 1) {
+			/* After the first stream has transitioned to ENABLING
+			 * state, bt_bap_stream_get_base will generate the
+			 * BASE from all previously configured streams.
+			 */
+			data->base = bt_bap_stream_get_base(stream);
+
+			g_assert(data->base);
+			g_assert(data->base->iov_len ==
+					data->cfg->base.iov_len);
+			g_assert(memcmp(data->base->iov_base,
+					data->cfg->base.iov_base,
+					data->base->iov_len) == 0);
+		}
 
-		bt_bap_stream_start(stream, NULL, NULL);
+		if (streams == data->cfg->streams)
+			/* After all streams have transitioned to ENABLING
+			 * state, start each one.
+			 */
+			queue_foreach(data->streams, stream_start, NULL);
 		break;
 	case BT_BAP_STREAM_STATE_STREAMING:
-		tester_test_passed();
+		queue_foreach(data->streams, stream_count_streaming, &streams);
+
+		if (streams == data->cfg->streams)
+			/* Test is completed after all streams have transitioned
+			 * to STREAMING state.
+			 */
+			tester_test_passed();
 		break;
 	}
 }
@@ -7225,9 +7284,288 @@ static void test_bsrc_str_1b(void)
 		NULL, test_bcast, &cfg_bsrc_str_vs, IOV_NULL);
 }
 
+#define BASE_LC3_8_1_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_8_1, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+static struct test_config cfg_bsrc_str_8_1_mbis = {
+	.cc = LC3_CONFIG_8_1,
+	.qos = LC3_QOS_8_1_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_8_1_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+#define BASE_LC3_8_2_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_8_2, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+static struct test_config cfg_bsrc_str_8_2_mbis = {
+	.cc = LC3_CONFIG_8_2,
+	.qos = LC3_QOS_8_2_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_8_2_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+#define BASE_LC3_16_1_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_16_1, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+static struct test_config cfg_bsrc_str_16_1_mbis = {
+	.cc = LC3_CONFIG_16_1,
+	.qos = LC3_QOS_16_1_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_16_1_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+#define BASE_LC3_16_2_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_16_2, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+static struct test_config cfg_bsrc_str_16_2_mbis = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = LC3_QOS_16_2_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_16_2_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+#define BASE_LC3_24_1_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_24_1, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+static struct test_config cfg_bsrc_str_24_1_mbis = {
+	.cc = LC3_CONFIG_24_1,
+	.qos = LC3_QOS_24_1_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_24_1_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+#define BASE_LC3_24_2_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_24_2, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+static struct test_config cfg_bsrc_str_24_2_mbis = {
+	.cc = LC3_CONFIG_24_2,
+	.qos = LC3_QOS_24_2_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_24_2_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+#define BASE_LC3_32_1_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_32_1, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+static struct test_config cfg_bsrc_str_32_1_mbis = {
+	.cc = LC3_CONFIG_32_1,
+	.qos = LC3_QOS_32_1_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_32_1_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+#define BASE_LC3_32_2_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_32_2, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+static struct test_config cfg_bsrc_str_32_2_mbis = {
+	.cc = LC3_CONFIG_32_2,
+	.qos = LC3_QOS_32_2_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_32_2_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+#define BASE_LC3_44_1_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_44_1, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+static struct test_config cfg_bsrc_str_44_1_mbis = {
+	.cc = LC3_CONFIG_44_1,
+	.qos = LC3_QOS_44_1_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_44_1_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+#define BASE_LC3_44_2_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_44_2, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+static struct test_config cfg_bsrc_str_44_2_mbis = {
+	.cc = LC3_CONFIG_44_2,
+	.qos = LC3_QOS_44_2_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_44_2_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+#define BASE_LC3_48_1_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_48_1, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+static struct test_config cfg_bsrc_str_48_1_mbis = {
+	.cc = LC3_CONFIG_48_1,
+	.qos = LC3_QOS_48_1_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_48_1_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+#define BASE_LC3_48_2_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_48_2, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+static struct test_config cfg_bsrc_str_48_2_mbis = {
+	.cc = LC3_CONFIG_48_2,
+	.qos = LC3_QOS_48_2_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_48_2_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+#define BASE_LC3_48_3_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_48_3, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+static struct test_config cfg_bsrc_str_48_3_mbis = {
+	.cc = LC3_CONFIG_48_3,
+	.qos = LC3_QOS_48_3_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_48_3_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+#define BASE_LC3_48_4_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_48_4, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+static struct test_config cfg_bsrc_str_48_4_mbis = {
+	.cc = LC3_CONFIG_48_4,
+	.qos = LC3_QOS_48_4_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_48_4_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+#define BASE_LC3_48_5_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_48_5, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+static struct test_config cfg_bsrc_str_48_5_mbis = {
+	.cc = LC3_CONFIG_48_5,
+	.qos = LC3_QOS_48_5_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_48_5_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+#define BASE_LC3_48_6_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_48_6, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+static struct test_config cfg_bsrc_str_48_6_mbis = {
+	.cc = LC3_CONFIG_48_6,
+	.qos = LC3_QOS_48_6_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_48_6_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+#define BASE_VS_MBIS \
+	BASE(40000, 1, 2, 0xFF, 0x00, 0x00, 0x00, 0x00, \
+	VS_CFG, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+static struct test_config cfg_bsrc_str_vs_mbis = {
+	.cc = UTIL_IOV_INIT(VS_CC),
+	.qos = QOS_BCAST,
+	.base = UTIL_IOV_INIT(BASE_VS_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.vs = true,
+	.streams = 2,
+};
+
+/* Test Purpose:
+ * Verify that a Broadcast Source IUT can stream multiple BISes to
+ * a Broadcast Sink. The verification is performed for each set of
+ * parameters in turn, as specified in Table 4.82.
+ *
+ * Pass verdict:
+ * If the Codec ID is LC3, the IUT sends encoded LC3 audio data in
+ * BIS Data PDUs on each synchronized BIS.
+ *
+ * If the Codec ID is a vendor-specific Codec ID, the IUT sends BIS
+ * Data PDUs on each synchronized BIS. The parameters included in the
+ * Codec_Specific_Configuration data are as defined in
+ * TSPX_VS_Codec_Specific_Configuration.
+ *
+ * If the Codec ID is LC3, each parameter included in
+ * Codec_Specific_Configuration data is formatted in an LTV structure
+ * with the length, type, and value specified in Table 4.83.
+ */
+static void test_bsrc_str_2b(void)
+{
+	define_test("BAP/BSRC/STR/BV-18-C [BSRC, Multiple BISes, LC3 8_1]",
+		NULL, test_bcast, &cfg_bsrc_str_8_1_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-19-C [BSRC, Multiple BISes, LC3 8_2]",
+		NULL, test_bcast, &cfg_bsrc_str_8_2_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-20-C [BSRC, Multiple BISes, LC3 16_1]",
+		NULL, test_bcast, &cfg_bsrc_str_16_1_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-21-C [BSRC, Multiple BISes, LC3 16_2]",
+		NULL, test_bcast, &cfg_bsrc_str_16_2_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-22-C [BSRC, Multiple BISes, LC3 24_1]",
+		NULL, test_bcast, &cfg_bsrc_str_24_1_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-23-C [BSRC, Multiple BISes, LC3 24_2]",
+		NULL, test_bcast, &cfg_bsrc_str_24_2_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-24-C [BSRC, Multiple BISes, LC3 32_1]",
+		NULL, test_bcast, &cfg_bsrc_str_32_1_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-25-C [BSRC, Multiple BISes, LC3 32_2]",
+		NULL, test_bcast, &cfg_bsrc_str_32_2_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-26-C [BSRC, Multiple BISes, LC3 44.1_1]",
+		NULL, test_bcast, &cfg_bsrc_str_44_1_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-27-C [BSRC, Multiple BISes, LC3 44.1_2]",
+		NULL, test_bcast, &cfg_bsrc_str_44_2_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-28-C [BSRC, Multiple BISes, LC3 48_1]",
+		NULL, test_bcast, &cfg_bsrc_str_48_1_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-29-C [BSRC, Multiple BISes, LC3 48_2]",
+		NULL, test_bcast, &cfg_bsrc_str_48_2_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-30-C [BSRC, Multiple BISes, LC3 48_3]",
+		NULL, test_bcast, &cfg_bsrc_str_48_3_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-31-C [BSRC, Multiple BISes, LC3 48_4]",
+		NULL, test_bcast, &cfg_bsrc_str_48_4_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-32-C [BSRC, Multiple BISes, LC3 48_5]",
+		NULL, test_bcast, &cfg_bsrc_str_48_5_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-33-C [BSRC, Multiple BISes, LC3 48_6]",
+		NULL, test_bcast, &cfg_bsrc_str_48_6_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-34-C [BSRC, Multiple BISes, VS]",
+		NULL, test_bcast, &cfg_bsrc_str_vs_mbis, IOV_NULL);
+}
+
 static void test_bsrc_str(void)
 {
 	test_bsrc_str_1b();
+	test_bsrc_str_2b();
 }
 
 int main(int argc, char *argv[])
-- 
2.39.2

