Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2077.outbound.protection.outlook.com [40.107.103.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF94F21D5A9
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Mar 2025 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362336; cv=fail; b=CvLb8DLhde/xmTqvHt0sq2DhZko2z8de5kDN5Kyuh+wa0SVyTm3Y5PAlnkEP3z6Asfb+6FllGUTLDWRnGF0s3iead99CIbx8ZyqSLNFrK1bNDGF6j8HJnTPup9dujE9dkzw+qG9DucZqJmGqxl9RAq2ES3V18J0hTLlC3kvnXtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362336; c=relaxed/simple;
	bh=Tmevk1YolWsT8QaOmitiyYwl1MqlJ0ovl3B5dHe4gWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AAaPSsZLcK4SO+JO5dPcEVe6n3hIYR2HIr9iHsMOojsSj3h4SCKQDhGJzgEMQxlnSFFnk6hJ5Bs1nlGcepGyNFpo30TVhViSEX8Bfp7JNiRUzIGZ5P8PcznUB2sIZkmigJYg15yNM3mpSwcdKyV+DHGqBwo+pDtz03ZeUxTHw+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q4ISkK0F; arc=fail smtp.client-ip=40.107.103.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q4ISkK0F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=As7XsX1uVd+u9G6o1TS7pfplALI4xqI+MXMQ8KPxhjJa04gqTCO8N5Qn8K8up1RJK0eevgC6rDLc+piWjjuMuBKIx/V1UuEeeJ5deO+Pm8MQVy7WtDAwSQAI9LFhNCNtEPp6Xs1DcDcZYpvCwt5yGr0nrExfx2wRhodMEwSIbSaA/WCqcL8YZCcxwNLSBCkMmWMRsTIpanlZHPF0hafrIbKEdZlqwcXWfHFz+Z3vkvD6KWq4md5mAYVq/J/xOTlsX9CfMYT6l+aHHAg79xlekdmZLcLFniz3BRLxCvhBsSd6sJwu46DL+P4YSW1LdQFOve8JVunk+I4L9n8cTR0OHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VL+pIp/IkPBnR3q5a1IHiSg2MNEMlJSyz/azogNn2Q=;
 b=OXujSXDl8tiqnpcf4YcqsNe5wKGvAXiXvHPng+oS6QCD15xtbGvGNRIL0QxHSod+yLCI2kh9PvaqxWAgbO4TDtgl/cvIFJD25onum3c+GraGRkmmudsSzAj0yEI4hc/pnaJyTWqve2rathy33noiKqw67Bgh+XIjzPosltmOr4nffthOuAZqCf1W9+XUPJb3deDf1dpIk3iBGnywSVrlKD1RPy5Ndv20T0AhixU29WmwPuQvosmaVBWQHWxKLMOS7FXTfG1wBsDuECZZGJYyFx2Pybe+Wgq08TxfkX6exlahPo9N6+lO5BwfKvpwgl3eSf6dR3RbGDu3BvnPW0SaAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VL+pIp/IkPBnR3q5a1IHiSg2MNEMlJSyz/azogNn2Q=;
 b=Q4ISkK0FefqRNo5uixvYxnTJwnJAYhvMJWU+gfhBl+c3P5aK/Je0u21693DN74FbcXZKikmLF4YSJyAXWtpe3PUmxjwynhOFwgw7oa9sftNBXsk9aUQqzl6p3FbveMRPOpRj0l5ELqcaiC/ohmkS9QcqRn9AWpl6Ulb7HOBzzPU2GXdxYsvbh6v0zGZIFEmqTLDS3GxnxBpoLSW7QsVlGpfRZQHzFV23aigYBtFuEIDegTAS/xGdtwyXvgkt+0kni7tCnVlr0WLI2FpXNYgaYljPHtCyZhknY1wLTHNeXjBS+SxxZVcFaVMG0ErPhMgelrzBNsuM7P6APp81hQCOcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB7727.eurprd04.prod.outlook.com (2603:10a6:102:e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 15:45:32 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8511.019; Fri, 7 Mar 2025
 15:45:32 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 5/6] bap: Remove interface
Date: Fri,  7 Mar 2025 17:44:56 +0200
Message-ID: <20250307154457.85751-6-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307154457.85751-1-iulia.tanasescu@nxp.com>
References: <20250307154457.85751-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0187.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::12) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 03cfad3a-539a-4d7c-e33a-08dd5d8f17d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EfOGPuyiBECCjI9kz1skIVhOOOCCtt6a0o3Vzsl892ZCFn60DWbjKGo6Gn28?=
 =?us-ascii?Q?gjK/SaF/3Re0yGklvf1EC+4WAuBLO4x6LjhUfKtbWvvt4miDnDY4ZID/8GAe?=
 =?us-ascii?Q?cPcgBAZWnNcWVAafwpPcKmGFJIjGuI+uwNwHoi3wi2pUdDK/nsIVMfKGil+O?=
 =?us-ascii?Q?J1LkAyqdcMQi6tLHtW3pHTbxcgMpDMY81gsF3Ha5nsqk8L/eyi/1qnHqzuWY?=
 =?us-ascii?Q?AvbZ8NwrOtSbrHRrk/dhVWPUPSxy+/yME/iV8YRY1+9queQVeSi8lLRQyVy0?=
 =?us-ascii?Q?+mqRsx+w3uGDmLd69ppRAevgqT9fipfekcK3QSFGyu1WYCFgJ6amTjra1vHy?=
 =?us-ascii?Q?POcDcuqdYaKr+9SHQTRyzQxUNx8Cao9G7yDCvEn+ScOb/e/7oNL0WszHxeil?=
 =?us-ascii?Q?BHOWS9ies64kmzbDWAcjT0d4j1jdwjRyTcwPjQUTZ87ZC2OpFprlWz6TiEkT?=
 =?us-ascii?Q?Qxws1SK4ew8pZFEHxEHZlsgqdoUapPbpY9ERQylqjUHzvLA2FqS179fIKchK?=
 =?us-ascii?Q?M94V6sw6wYmT20RPeoAPqqeQcLKOBIC+1bXF4SV8mux09WDQrg1t2SH9Gczc?=
 =?us-ascii?Q?FM65ijlwBzl50R00h0iB/+yM1IT1NUMTu9rym/igWzsF8/LY8yE6Rv82tHIP?=
 =?us-ascii?Q?uHi/B7uNj2h/0a0eyW0kQNEmqmUC+I+pdI8XxxCp8gu43FyOhh1AiW0ZVF5l?=
 =?us-ascii?Q?JOaHqsjdwVnoS3Prw679v3B0x03tbsmT60t3lZaHaFSUcQPMDujcIlzynUHF?=
 =?us-ascii?Q?vSOBMjrke+4QR5MKAMabrizve/3XMv+kT9H2TCFQuh/aI+iFtcQs74+lLE8o?=
 =?us-ascii?Q?zzqhSVqkvitW5JA11bdG/7l8a/KYmAcZb9HGO523gZRGh8dqy+cVh3plLRrn?=
 =?us-ascii?Q?iUvuHch3udYZi/8ZF1UZBP7xS9lLH92lclGEqHZL6GLTh5JeWSJs7jZ1/8Wy?=
 =?us-ascii?Q?ZQ7YgnAuhN6cCQeODYw2UdlUz20UxrmTxxsOd9+Wsoubq1sdXTyDfRnxSIvU?=
 =?us-ascii?Q?kCoK5ZPiEpNKFUWt6lO5JRuoMOGbkjaH4+/x6xtuZsUXGVq7eQ4j+025uahF?=
 =?us-ascii?Q?gI7KvhRf094x+eijcKUc87fcf93kDz6sq2HtfRudm0Mt2I+QSGctP0AqpnGl?=
 =?us-ascii?Q?nNKK9e4zONOLbH8yegOrlSB7lgv/G0l8Gsr/e9X3mLLUAcaoLntO4UVp59uY?=
 =?us-ascii?Q?229a6saWx+NBDJZpl0qKsAsJmUqQDSeBs2NxMEDTwr5XHKmcDu5iBEcjeZaB?=
 =?us-ascii?Q?Q35j4YKNnnRIlAa0NcBDiD9uKzZOPf/dLBY2f+QW4SXbHSkk8ncqt5q6U/8Y?=
 =?us-ascii?Q?y9bBr3zgKRf9qnwwTwjxITKRtf1FJ83I4cBX15X/tR8r+ApbzLzwLc6Rgf7e?=
 =?us-ascii?Q?RGEox6bZeoBLvqxj0Vctd0tOcVqr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?16Fr4ZjM+zdAXWsJWx3BowAk+/vLQx/w6NeE6D1H9y9tvGhnLrOnDmS7regb?=
 =?us-ascii?Q?ckcOdjogEBvr7K+Ho1xTAdZYTJtS0AJYRkmPgwQhvvhSdNFDJoO6YqzwLXI7?=
 =?us-ascii?Q?vU2R4mOwSjDPJNrAN3mfh9QaPUit/ohJZ5nHPLUPuPPKDVD4xVtYpf0UQsJ0?=
 =?us-ascii?Q?vmlRU6ygiZTJT2xXJjZZ9ozPXdl0Oe8zG+omLhRNN2IKHWmzTEQMQVUMNPXS?=
 =?us-ascii?Q?ggMi8sJ/a8FMIFe+h68B0n+19tpszn+pbVkY8l28p7xl/S2xzsgCqDFWk8tB?=
 =?us-ascii?Q?Y0v9pxHTKbAe/uz/puQxKTJ7rNaRgdcc8q58Sg+AjDfyzodQzkfQmTzq1ZGX?=
 =?us-ascii?Q?rAhldpv2bMjRqgM27DXJQIl3Wc2wVJ5t3lT3D2Fz/RRlDlhEwiABba8BVX5K?=
 =?us-ascii?Q?7oE3mcmnk/uC+WHFWG6dypmVUWesm7+2BHX/iQpsLwmxNsrXXAOTDz1mVBam?=
 =?us-ascii?Q?gwJN8XQ14Mp7lf7QADYQAWVPBMTbnpV5LLUz5c2YVISYo+GrXxn4U1oTWldn?=
 =?us-ascii?Q?d47I+xljmcLYgf3e1qCsLSdsPelAgk33qrmPrrxNZFw5syBU/WCmunl4qAkg?=
 =?us-ascii?Q?+BmiXzcBujfkfrO0SQi2fs8uD8fp1pim2J3zXDHfevdeuv5fzfte4KInCYeO?=
 =?us-ascii?Q?ETb7MmIKcqeSNWNdoSX3QXEQR55czTPUENXNmQRUNV67djtXCdvJC8X+SgBy?=
 =?us-ascii?Q?H0MUek3BjJbuuLQkYL0ecz7L97JeUQOKL60Jb1wsK7FgY+hPfjCMBSBAOKGD?=
 =?us-ascii?Q?v2xfhGEMDAw9zLyzujvYm5B0jZ4cMFe/y1IyHWM9yxKZDL6n67GpY6zmqIFH?=
 =?us-ascii?Q?Bor7nZVjsmCJB6pFpJceFat4DDckPXpLlyohjZkCVni6gUXGbiHtHNdQGxNe?=
 =?us-ascii?Q?cJ5lcCy+LBv88SoQcfwXll/iFbsye1Z2Nl8V8BlTffUSnNNBqvzP5W/TzHRh?=
 =?us-ascii?Q?QOM22wY8OUsEGYwGd8M+BpxN+sUeT8PvjktwRETsfqsXSqBReewB6wb+qkUB?=
 =?us-ascii?Q?/BywBDqRYyfw2u6sQ9t5ClyzOmnWWYnUSL6MVgRkY77lDXpgj+4KbNr2nNke?=
 =?us-ascii?Q?wf8TkQ27e/7J/gZGL7zxKjvchlY9+Bqmxchkk5ijuU1aD4RPzY6NB0am8t9S?=
 =?us-ascii?Q?Cd/fUjcgwJLaWTonokz1Ay6qYI0GolK53Q6GvP+A/9XfLxiB2s/cRlrHw2NJ?=
 =?us-ascii?Q?/S3YSlMR36rUDeyP4LQP7U1dD9DfnFFLN22hAcFQ+COsjACGLUyx/mbu+3Lb?=
 =?us-ascii?Q?yKlp6qcgF0aIxQ/YBo0NaNJl7GHkNO5cpDugQWTMCBQeh2oR1Ayh81vDzttr?=
 =?us-ascii?Q?srxcJCmAlhX7MrmA8Ut3DJ6mj2ULNOhnNJzS+PyRjwc0GYMb50apBxplbrdD?=
 =?us-ascii?Q?CGhvJw9p8mOzr9NdwAfHkrwGUurJZCzM/m3UDxo+U06zkgWPJlrgf0MsWrrw?=
 =?us-ascii?Q?AWVc2YnvFrh+VnlkE2OT9G55sSd90AlAtvHESgX4YvQykvQWsC2ByTh/3Hjc?=
 =?us-ascii?Q?Xd0iAYOytUum5v70hfdSBST2aj4qQRrDtOdu+9O/0IxGsvxTGv4C6hpQRMXk?=
 =?us-ascii?Q?Cvep1hsdP16gDn4r1PTPEeRWw+oyUcyx3z20pqa8Ldl8LI8JV2k9Y/R010Uf?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03cfad3a-539a-4d7c-e33a-08dd5d8f17d8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:45:31.9370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/P4bqaOe2dCJ6YP0RoL5xBVeEwDTBMcgttaqdJuvuAqoEE7hGe9gmVIEa5Lcokmhx8onYZhXpLVxj3DUkVdRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7727

This removes the BAP plugin interface and updates the BAP and
BASS plugins to use shared/bap APIs.
---
 Makefile.plugins      |  2 +-
 profiles/audio/bap.c  | 57 ++-----------------------------------------
 profiles/audio/bap.h  | 13 ----------
 profiles/audio/bass.c |  6 ++---
 4 files changed, 5 insertions(+), 73 deletions(-)
 delete mode 100644 profiles/audio/bap.h

diff --git a/Makefile.plugins b/Makefile.plugins
index 43e665432..bae4363d0 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -113,7 +113,7 @@ endif
 
 if BAP
 builtin_modules += bap
-builtin_sources += profiles/audio/bap.h profiles/audio/bap.c
+builtin_sources += profiles/audio/bap.c
 endif
 
 if BASS
diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 1889e1a1e..a37e62f76 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -56,8 +56,6 @@
 #include "src/log.h"
 #include "src/error.h"
 
-#include "bap.h"
-
 #define ISO_SOCKET_UUID "6fbaf188-05e0-496a-9885-d6ddfdb4e03e"
 #define PACS_UUID_STR "00001850-0000-1000-8000-00805f9b34fb"
 #define BCAAS_UUID_STR "00001852-0000-1000-8000-00805f9b34fb"
@@ -1053,57 +1051,6 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 	}
 }
 
-void bap_qos_to_iso_qos(struct bt_bap_qos *bap_qos,
-				struct bt_iso_qos *iso_qos)
-{
-	memset(iso_qos, 0, sizeof(*iso_qos));
-
-	iso_qos->bcast.big = bap_qos->bcast.big;
-	iso_qos->bcast.bis = bap_qos->bcast.bis;
-	iso_qos->bcast.sync_factor = bap_qos->bcast.sync_factor;
-	iso_qos->bcast.packing = bap_qos->bcast.packing;
-	iso_qos->bcast.framing = bap_qos->bcast.framing;
-	iso_qos->bcast.encryption = bap_qos->bcast.encryption;
-	if (bap_qos->bcast.bcode && bap_qos->bcast.bcode->iov_base)
-		memcpy(iso_qos->bcast.bcode, bap_qos->bcast.bcode->iov_base,
-				bap_qos->bcast.bcode->iov_len);
-	iso_qos->bcast.options = bap_qos->bcast.options;
-	iso_qos->bcast.skip = bap_qos->bcast.skip;
-	iso_qos->bcast.sync_timeout = bap_qos->bcast.sync_timeout;
-	iso_qos->bcast.sync_cte_type = bap_qos->bcast.sync_cte_type;
-	iso_qos->bcast.mse = bap_qos->bcast.mse;
-	iso_qos->bcast.timeout = bap_qos->bcast.timeout;
-	memcpy(&iso_qos->bcast.out, &bap_qos->bcast.io_qos,
-			sizeof(struct bt_iso_io_qos));
-}
-
-void bap_iso_qos_to_bap_qos(struct bt_iso_qos *iso_qos,
-				struct bt_bap_qos *bap_qos)
-{
-	bap_qos->bcast.big = iso_qos->bcast.big;
-	bap_qos->bcast.bis = iso_qos->bcast.bis;
-	bap_qos->bcast.sync_factor = iso_qos->bcast.sync_factor;
-	bap_qos->bcast.packing = iso_qos->bcast.packing;
-	bap_qos->bcast.framing = iso_qos->bcast.framing;
-	bap_qos->bcast.encryption = iso_qos->bcast.encryption;
-	if (bap_qos->bcast.encryption)
-		bap_qos->bcast.bcode = util_iov_new(iso_qos->bcast.bcode,
-						sizeof(iso_qos->bcast.bcode));
-	bap_qos->bcast.options = iso_qos->bcast.options;
-	bap_qos->bcast.skip = iso_qos->bcast.skip;
-	bap_qos->bcast.sync_timeout = iso_qos->bcast.sync_timeout;
-	bap_qos->bcast.sync_cte_type =
-			iso_qos->bcast.sync_cte_type;
-	bap_qos->bcast.mse = iso_qos->bcast.mse;
-	bap_qos->bcast.timeout = iso_qos->bcast.timeout;
-	bap_qos->bcast.io_qos.interval =
-			iso_qos->bcast.in.interval;
-	bap_qos->bcast.io_qos.latency = iso_qos->bcast.in.latency;
-	bap_qos->bcast.io_qos.phy = iso_qos->bcast.in.phy;
-	bap_qos->bcast.io_qos.rtn = iso_qos->bcast.in.rtn;
-	bap_qos->bcast.io_qos.sdu = iso_qos->bcast.in.sdu;
-}
-
 static void create_stream_for_bis(struct bap_data *bap_data,
 		struct bt_bap_pac *lpac, struct bt_bap_qos *qos,
 		struct iovec *caps, struct iovec *meta, char *path)
@@ -1197,7 +1144,7 @@ static gboolean big_info_report_cb(GIOChannel *io, GIOCondition cond,
 	iov.iov_len = base.base_len;
 
 	/* Create BAP QoS structure */
-	bap_iso_qos_to_bap_qos(&qos, &bap_qos);
+	bt_bap_iso_qos_to_bap_qos(&qos, &bap_qos);
 
 	bt_bap_parse_base(&iov, &bap_qos, bap_debug, bis_handler, data);
 
@@ -2962,7 +2909,7 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 	queue_foreach(links, setup_refresh_qos, data);
 
 	/* Set the user requested QOS */
-	bap_qos_to_iso_qos(&setup->qos, &qos);
+	bt_bap_qos_to_iso_qos(&setup->qos, &qos);
 
 	if (!bt_io_set(io, &err,
 			BT_IO_OPT_QOS, &qos,
diff --git a/profiles/audio/bap.h b/profiles/audio/bap.h
deleted file mode 100644
index 2bf93dd93..000000000
--- a/profiles/audio/bap.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright 2024 NXP
- *
- */
-
-void bap_iso_qos_to_bap_qos(struct bt_iso_qos *iso_qos,
-				struct bt_bap_qos *bap_qos);
-void bap_qos_to_iso_qos(struct bt_bap_qos *bap_qos,
-				struct bt_iso_qos *iso_qos);
diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 6f68b80f3..d987987ff 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -52,8 +52,6 @@
 #include "src/log.h"
 #include "src/error.h"
 
-#include "bap.h"
-
 #define BASS_UUID_STR "0000184f-0000-1000-8000-00805f9b34fb"
 #define BCAAS_UUID_STR "00001852-0000-1000-8000-00805f9b34fb"
 
@@ -370,7 +368,7 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 
 		queue_foreach(links, append_stream, &iso_bc_addr);
 
-		bap_qos_to_iso_qos(bap_qos, &qos);
+		bt_bap_qos_to_iso_qos(bap_qos, &qos);
 
 		if (!bt_io_set(dg->io, &gerr,
 				BT_IO_OPT_QOS, &qos,
@@ -532,7 +530,7 @@ static gboolean big_info_cb(GIOChannel *io, GIOCondition cond,
 	iov.iov_len = base.base_len;
 
 	/* Create BAP QoS structure */
-	bap_iso_qos_to_bap_qos(&qos, &bap_qos);
+	bt_bap_iso_qos_to_bap_qos(&qos, &bap_qos);
 
 	bt_bap_parse_base(&iov, &bap_qos, bass_debug, bis_handler, dg);
 
-- 
2.43.0

