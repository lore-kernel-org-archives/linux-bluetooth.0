Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013008.outbound.protection.outlook.com [52.101.83.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9B730FF06;
	Tue, 13 Jan 2026 07:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768290454; cv=fail; b=pT7MT25b4bePZzmHbkx3/PD/gjkazFiTDdj9UvEsdAK1mJI8fMH5B0AhhZimCDBKvtGCokLhb2agxifHWQNHjsNuEPAjLwj1LU1UtAHDpI35Sc4GahT5lmWpGTzShWD+a6C62XrPEkSlviBV2ryxWmzjjsMOm2+OVF1sspgLOKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768290454; c=relaxed/simple;
	bh=km4rF4bUyuzo0BOALXZNdiZPw+ibd8um95ktiwdxCBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D/wVxr54NH3TP8l0hDcR3Jl2FQC6q96mPOqxhTqWQ4O4FEHx3V2z11Dve8nRjlqNv0cy1GofC946dah61qD0Od2tGoh9dHByeNGA+7v/egD7T70Ckz75k4K2/RXHOqwANQjxZM1PuXLomUS8RknZkaOl7cbBT/HiIFOkk7d5rIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T2+1bzpz; arc=fail smtp.client-ip=52.101.83.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T2+1bzpz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sk8fJxIxp3l+hzKNo7xCzRV4vcBJK8mXFmBbf7UdpmCq6eGugcTcbA0QzHFICmkqia9E1gGrDj1X2Ov4oudekuQhL53yXsosaVMabFIFIlUdNXOeiZBb428ONrRHd1iWMEGss/cSv95LoCizONFhho+DdxU2Tb7nKWNyPEYTUWXzkKf3pL9GtFpokju2nCkz1YJAs0grw59ySrgwmvAuWHOiF7NHS10cOBSFXSNwWs5bL5F3Txge3AroJ07iWbb3ixwwkKavj5jcWFgtVVuNzAMWzXm9oW3lzWbm3hfdmKrDlZuHDU8EiBaOFF5PIH1xYtVl6NHLY0JwI+60GKoV1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmk5HxOxbST06yXZAnFLte9/3JclGzg5IaB5E33aOb4=;
 b=BNGHfsyHdHtD1l9VUsA6NPRpn6ZgsyRel5T9mpcVwi2r+dJU1wavyHcWmry/a0m7N0B44yKtjKDGcJQQmbo4DWQIU2zhWSNrTcOm36xmZwuw7W000qWRtnjl/O4yN6mdt9z/7ygSRLAPNCCs39afS9kBn5oy9LhyBLguv+dqFHZAuLOQKHbW5wHJKt7Y2q0sT0J7brFphih/HxERZnyHFgcR+zJTOIE9d0+3oCJKxVrkI114kQceXcjCtbq2z63UT1yZkWNKe5WdGMUH5L1HUmPxWwiCUtmUGhOY6Nfrn3HtKbKo+5smiQV9MIkl2WaOkcylrUBDOVjioNgXhPhFrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmk5HxOxbST06yXZAnFLte9/3JclGzg5IaB5E33aOb4=;
 b=T2+1bzpzpuLZv9mFedLoyS+Ji0n+HhSEgq2T2z0hV9spsq8ve+G3ZaU+Oka0JqBK3Dqfi4FPfv55orpTYLKMsL0wOU6389Evgj4zsDvx2dsltte66yC77ftUhy0EwKHkD3gU0mTvmR41SmtSmwGHFvwTGEBlcxOENHVQ4hBg9I9HUSvJm6OkEFISy3zS8RKdfZs04luV7nsVPqdoXO/ILfzcCH+sLjmbJItc2JSAAzgnBfK25sojacmxALbC6aDJHnr2pXuMkjPuTz9035BhxQEo74cPaqjXV93TRSpRqy3aDuSrZm05ks2fa1c2O+2q5QC5QMBC19DBdji6LgXZwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PAXPR04MB8144.eurprd04.prod.outlook.com (2603:10a6:102:1cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Tue, 13 Jan
 2026 07:47:11 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.9520.003; Tue, 13 Jan 2026
 07:47:11 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/11] Bluetooth: btnxpuart: Select crypto algorithms for secure interface
Date: Tue, 13 Jan 2026 13:17:18 +0530
Message-ID: <20260113074718.2384043-12-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113074718.2384043-1-neeraj.sanjaykale@nxp.com>
References: <20260113074718.2384043-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::38) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|PAXPR04MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: 65a00d34-b80b-4d8e-47cc-08de5277f603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EZTtKaR7G6vDeAhJCeeiCrBrtbZzNtd2pExCOUJBzSd5f1BN9lfd54U49fyi?=
 =?us-ascii?Q?VocAiIkKTNYBtgeRWcnivmpc9eHkUacNfnA5TgazoM4MOlylPkirUCCR3lVt?=
 =?us-ascii?Q?ve/w/PMvzZipPkCDC8ab4OrXqG7z3pNAxQMzgRhDVsf24EaMdUT4jx/kqXgf?=
 =?us-ascii?Q?5VdM4vapKC5XwSXTIEybA3azb3q8YzJ5J04w1DSDilvKprkM6zTzZFeyToxD?=
 =?us-ascii?Q?spom9dDjRNzriaMwJ11JwYPoQI8ZvWnj4sBgU9mZLC1iyxycj0ke4/HXQbon?=
 =?us-ascii?Q?GL18KjkW3ZHnkKCuh0kuVn33a/10wtPH41qWlXVkYsisYF4viJYXEGZJ5GOP?=
 =?us-ascii?Q?h1hPxPEwcN8tqoJuNQOxALt0kVaVElexg6+pFtymW0LRpWE45FRmGcbsCenl?=
 =?us-ascii?Q?kcLo63oECcwr11V7lfXO2G5DYkHTkcLbWqMbnfSdFLgBkW0Re0KjvWVmBJyL?=
 =?us-ascii?Q?3Mp1inVfvT12pUoa4f6Rjo2P20AsqMF14Int37kIwVLLRUKPvGQLB5/fhPMh?=
 =?us-ascii?Q?VRVqKOJSGDyd3hz4Cii02cqQBWDO1kQZLIsgnbCZHQjHrGNd2sYiEY/c2MIk?=
 =?us-ascii?Q?TJA/m8ujEhKzw0KMeL656611x7M3qkw7KZ0uBSbEt0jICGyNMuOPs7+fhX4E?=
 =?us-ascii?Q?+JFplLQVdEtfiYLUjbmu7bIi+M7M1pz+BtZeNJrAOiNL8m9ZaGLnzN/rnrsw?=
 =?us-ascii?Q?O3Hdz3Iwd7WscByglRWO2hVrgpn9D5mam9BdjB2y0SakdZH5omv1TAPOxZeo?=
 =?us-ascii?Q?1KIuMjL5x/t+pz10ymFIiTKmaSLq1TtOR6Fos+S9TUb26F9siXBJsJbsR8ZY?=
 =?us-ascii?Q?dsOv012AJPyI6LuYpV6mGLl98Z+44qZ7xrsavR6CeYSbo+CpnLgbnLBDSI+G?=
 =?us-ascii?Q?pnQrOKVJuvNw1E6bFBp3zXQ/AxZHuredtqgD9CKzP7NgMbYmbzwTM/Ke9ZUH?=
 =?us-ascii?Q?4FkZvvnACuZYEoe1OMPzCQWGYn0oMej5Gw4UFH0ZI4KUooG9uNJXI+bBwbrB?=
 =?us-ascii?Q?45NiqaicsVp4/2lByri2zFkis0zhz4KTy8+76PH21EiGIenXN9NwICbbncSS?=
 =?us-ascii?Q?fLRkbBHxHCdDfCj62c0iztmM6KBqZFfajLFcgafawUk38ckah77mYzWt1Zkd?=
 =?us-ascii?Q?V8y2dcS4Hy0wm9IGYqDX2ZCAlrcm/7f1cWEdPXnY4ouak4fVEVBR2FCDnwp2?=
 =?us-ascii?Q?yXaDhdxh52KUpnjjOgOx79JJDueqIkkOLw+WHVLxrzfd3+/kiZDGCz34037u?=
 =?us-ascii?Q?rA8Sni2d9+eNwUm3nZ1uLW7oxfn4zMHPygffkjSeFXso3DtQYQqcCZC8AyYf?=
 =?us-ascii?Q?6mMWBhqMvzqhLIF3Bx+JFCe2iNzgUH0iOWVdBJUq3F3XQhlSw839ac9+LEqZ?=
 =?us-ascii?Q?FUo7BeZnBOGVEy+bpglLE0yl34v98cXzSkvY8c1/k9rTUYL/S405CwuPZYbA?=
 =?us-ascii?Q?PaAFQhv8VF/weEFbP8n8ksUFwIKUTpi/iJSnQiiArC/Lja7LXuhTLGFvdV5b?=
 =?us-ascii?Q?Q4Xuy+KQ+4ASK2t8V6tOiQaigkXr4PKD3Mbr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/YeJjySyucb0B/70rP5ahTeMtsEQ8fsg1nJbKKdA65MTwLF0NNXiRBJUKjEK?=
 =?us-ascii?Q?VmOUhuIAz+QKX90aa3c9r/LjxJdlgCMUVzzCdx97h0uZxf1uM2NevI8sfJvk?=
 =?us-ascii?Q?WpG128hzDLoNythIS8D05M/FPNjx5qJS20+MZgCpM2TMa5ZnS+/CvJCFkMmn?=
 =?us-ascii?Q?JP/4K9BTNwyM87C+AC5X6HjamhMnLexo4Lm805Aaxep5tIufoCdjlFuKWrOi?=
 =?us-ascii?Q?SVO4NyOPoqh+QcA9dpuyFTpzuiVBVZ2aDeXYAtOI2+Vdl5JCPlAnDPVf4YQo?=
 =?us-ascii?Q?8AG/w/5vcVyFFH5OPMmxDVRZt4Rd2ovzsfSEcCWbz/2u0mn08eP7fXvOlnb3?=
 =?us-ascii?Q?nSqOdWhXIyzCAaIDJDPHeK6J0Vrtkbyvt3mcL6FkjT3C7A+xTbHzvYRPD/A9?=
 =?us-ascii?Q?gob7Sf1aZb4kcpj2hOSYjAc+fAR2rhVEWlhGrmcbpZHubGQEdfAyIS7AuqqW?=
 =?us-ascii?Q?bqIpZi6AEMSJd20YYdepM2lezjyobxi4qxofcEg4vMb3Reo2dXvRZT6fhggI?=
 =?us-ascii?Q?FezfQXjzeuVoeyRP4OlQuI4AO5m8q4KsEGJsfidgpOjcs6zdm34iWzwYvZol?=
 =?us-ascii?Q?QJQiT5CjK7U6OHclUM3qXy9LCphFSsojfT1twCBdUJ6kDh3rlh8mic+z3zD4?=
 =?us-ascii?Q?/idb5n2LuDEPIWH58nZ0zF/G3Y2bCMmEGYkIXEqJhaI9uUQ+O9QjcNdAJUmd?=
 =?us-ascii?Q?ZjxJZ0bcCXk/P2NU9la7ebR8U3zv6vEAZHSG+bqCSuAXbYApTHD7mnHhsVur?=
 =?us-ascii?Q?8Cge84hxZnNZ+I9Q1n6XyOBkVm9dUHRJ3Ja8mHerJJiN99QRj2PtTbz5pkoM?=
 =?us-ascii?Q?s5iW/bVNZVmn6U43EoLMzjLmgpcwfrvH+sSgEXpueotzTYmjzM368dEjO+jo?=
 =?us-ascii?Q?qj8rGPe/Lqe/nU1M5nMAY7PFf4XVYklvgb2vChMsHsL0o25CPOcDZiMw/+eK?=
 =?us-ascii?Q?j73Zz0wIxxgZcz67lzs+ghER5Jhz+Wdqw/K6eqHj7Y21hUU98sMuXKmW2ppk?=
 =?us-ascii?Q?PCDDJhtAm8bJHH3l4Pwti2zhz8IIA4MWL+MsYIrNPCFZcuoZNykHS5YC268S?=
 =?us-ascii?Q?ue6LQzMTA3UcATDjUket37QUQayQX3XJ+/nmmFXrwShpFMhkVoqi10ZskOie?=
 =?us-ascii?Q?0RsxOsVxLAKrq3EbSxWYMd73sbO4K6x/wiByGQi2YkAHfWT+YRQ8bZEiDm1/?=
 =?us-ascii?Q?zYWSk3QkA681hnAKh8AaNz9c+rjoVYUyzZwB0fx6tmkasO3BafW0eSS9357q?=
 =?us-ascii?Q?UKBibRpRu1FOdU59bhvQseZKKQ140Q4Lke853MuRVdCeAHGtss2jwPK0IGvQ?=
 =?us-ascii?Q?eIoZEpOcpJA64iazq24qIFRU4jk2IwyUkG+rsWqLDO9x4d3+1pWZqqgd3yd0?=
 =?us-ascii?Q?5ioH2xGLqPgPYcDXLQuBfMmY9MCPhSq7O8f1I91RJbNUI8XcbYmZZp3CiiG8?=
 =?us-ascii?Q?1RT+5W/atIw8G+vxS4Tt6Z5aeBxPeyMgzqaTg1tWljcOnDP66hM7ws9wafio?=
 =?us-ascii?Q?Eq1rBCvmSnPAhYtdteCn0+/Etn4YL7z/eon9ynYeU75zTEDgNjiM8LNPUJUd?=
 =?us-ascii?Q?eA+aMVXmP8l3n08Ftr5xj0nvCdrPmtIQoqxXIOVpnel3H9feBtgUQ4gPmrzZ?=
 =?us-ascii?Q?EYk0ilQXk9vgl6y31CfMyLiEnFzen84ARKP/Fvc/1sjLr8Q6qw/to6ZCNJ5K?=
 =?us-ascii?Q?LyYij705KDXB3ZFsIGeIrLl9e/egwdA7ap2MpVtHW5oe/qxQW80P4AteY51A?=
 =?us-ascii?Q?801Htzz75i+qN6HqUfIKADo0onUBcGQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a00d34-b80b-4d8e-47cc-08de5277f603
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 07:47:11.8306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJYw4CESGqoflwLo+KiSv/7AcTxf2Qjwu/sCvzpajgdacayugYRTdUeePnbbab1cLPlBY4zWpJ7KNZVzYXxcMPutyHGGcmYaFRvDiut81i8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8144

This adds crypto dependencies (ECDSA, ECDH, AES-GCM, SHA256, HMAC)
needed for TLS-based secure host interface authentication and
encryption.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index c5d45cf91f88..ccbd2e13977e 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -493,6 +493,13 @@ config BT_NXPUART
 	select BT_HCIUART_H4
 	select CRC32
 	select CRC8
+	select CRYPTO
+	select CRYPTO_ECDSA
+	select CRYPTO_ECDH
+	select CRYPTO_AES
+	select CRYPTO_GCM
+	select CRYPTO_SHA256
+	select CRYPTO_HMAC
 	help
 	  NXP is serial driver required for NXP Bluetooth
 	  devices with UART interface.
-- 
2.43.0

