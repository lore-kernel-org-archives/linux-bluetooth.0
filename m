Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A1B195F1A
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 10:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722336837; cv=fail; b=fIpd1pF3oQ2xbk7uVDqhEJo241kIwKpi0vgyUZq0zTI2fOqHH2cnFNWXOQ8kyWadJDswstlYD38HjUAR2o1PKPjeOIyR0sho98zMXZynAOm1eUqccWYrdcCtczXYgD+Wp6/TvVaw/e353Js7kGZSdUAj0ZccQVfpBQXWLNbsfe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722336837; c=relaxed/simple;
	bh=aVmowX1NEhg5dR+IH+Xzm1eNAI+KbAsjyQitcneknuc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YoUyVTWe0hMznd7VuDgq4EhPo8NbzAB79ShS8xbbG5x43oPlL4jQ19dQiBrlyGQF8WS1NS64oexojWbwMIJfsZ+p3kYSBUWVYTGsczKnmTKyv+mJoY0T5a1CzD0/5d6d9vGKd59CkCbq78lslgQABsL3P8g+3oaUgV/7mArjWj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nO9bWIVu; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nO9bWIVu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jb5VOyJEjMH0r0JPq1Mr1zEeRsUN7m+8jUm38P/O7HDDuwigdDA2DUS5HgPgs4t128w1Y4gAr+/gPaWf9lYdPC4cMKSMTI8TobBvGJc7cahDCtenVv7TooMql6P+X4sC8O++kC8jic/zPrw77cnLfv3y5h5zWSfKqQH1m0G0QuHaKSr2efpS1fq0M6ghQlGfar0MeqZMWOcV9n4IP9hV0DPhlGDI0uw5yQm54EzFSc7C3xRxMUKFZFl5piSnLulfFXSyzs0weUKUSXzr8nk+Src+mxAyCfjGr9/hum/21e5AMfmVpmSeBbd+9hXTfzWLQ2PP/uWG2JUIHAcRjsaJGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ibspa8MfsaDoUvawYmeKFht3/zKIG8PQkARdRNkorI=;
 b=yW4IQUOZA/Yvln+2XgQvPG0wQ/RDxnsniZ/JQEj+Vsn78cbA5+9nRaHrRdvc/GLZhDf92+UP8tZxjsgteipdAWIO9m0DoKmCIpnSC35bJMXQ8u/6Id8xjQ1Zs/u2u5vwDiRCgimABUNe2HCZsRZHPjpsqvJbETKf9PTWrH6Xuc0axbhVlQHubMK026B7jVBCwCoE/3WyIainC2Db/INv3UyvWPFF4a0Nqf+CUatQsGULBGymTgambrUP9fLDuL4L09IgkcPKjxjSiyAWdjIj7tTP7VCjVM2e58cp85z3m4tgCSdppP8kJJV5m2bp9RpZAYh8itPI2bFWEq5r7TO/Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ibspa8MfsaDoUvawYmeKFht3/zKIG8PQkARdRNkorI=;
 b=nO9bWIVuHbgX0TzXYHEYNCVCrDe1Y3Ao6QbGuZFCz/NVVRYQkA9OxfDFrdPSC2+la0vSg4nnOoAn3qCwDBKOhJpjzUwMyi2zj8e+l6UIfTJ0ypAR1LOIt5r+79cLz21hia5RGpQ4q/vy4okE8u8kV4kSxoKduM7CWWORHk117g04dmZOwDT7yC9kXuVnDplKSQ0B17Ov02eXIbLnqbRNTB0etrhwNX1YUrkx56R/YwfsDZe56ONdS3ZFzDL02JfwVG+qJGgJM45iCcOFeUpgNBQijKkIjhJMSQDtY5Dw5PlJ7NNxs3Nd0G9VpopvrLoIzJ+/FZenZzENm2NGQb5neg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PAWPR04MB10007.eurprd04.prod.outlook.com (2603:10a6:102:387::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 10:53:50 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 10:53:50 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v3 1/8] doc/media: Add 'broadcasting' state and 'select' method
Date: Tue, 30 Jul 2024 13:53:06 +0300
Message-Id: <20240730105313.403238-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240730105313.403238-1-vlad.pruteanu@nxp.com>
References: <20240730105313.403238-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0212.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::27) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|PAWPR04MB10007:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f5c5162-cc38-4823-a66a-08dcb085daab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a1xXPQ+tysqP/Pde6/MGGojKl8a/DwY6zAR0PB2mghe2E3qc2Dc/8oo9q5Bi?=
 =?us-ascii?Q?vNI8TSqQ9NHVcn6wzucPxZ+EBXEGVL6pVVwWoaNVz5m3XiCoTmSFeWL5Gm1x?=
 =?us-ascii?Q?RqVOVoeIrLmZRKvKQL8rELzMzxFX6v+JiN4kvdqBzYGSVA0RT4f3QEBmZshE?=
 =?us-ascii?Q?FWGfS3FNRTjHKsUnrqQA++jPYAligqm4Dsee8nd395/63dLIInGJsAa3kvG8?=
 =?us-ascii?Q?fB+0dRUR5p1qZ4udqM7i9ooLBtEp0Qlak7RkeA5f8zMxxNBUQkqn77c6/9SO?=
 =?us-ascii?Q?m7H6810QjicPx93TE1niEiKJnOigE8+EobyXyU9Aco4yNbO+FSaV2pDJkA90?=
 =?us-ascii?Q?aAVdZLCqjUFt7O5HC8Oad3szv5IEAUfdWkRCwZepLGxN/+GQbBmIWNW5QUF5?=
 =?us-ascii?Q?6fSKff2hHG8HAOdtmq6qMddAx4KBkBQ67OQBRYwUs3zA1w4uT29ZhDQL8Hhc?=
 =?us-ascii?Q?jdZbZIQReFe4j/QYdjC4Q5Xrs0G5OXjSEuYGnCyE9TEXmXLPkrM4gXgIe1Jr?=
 =?us-ascii?Q?wXLrweDUGkRnmgcXsuuX++Tyk0SkMb+5r7HutTw72wshF8xR9LHNXg1IGpZm?=
 =?us-ascii?Q?DvezFK8epSpd1OU4Ns4zY2IiP2w7R1GATtGacalb16m1K86qpzboYmO6GgXm?=
 =?us-ascii?Q?NRgdy7n778oVCPiki9yjyFBIyoVjEL98hHhJIkO9dfBVaFQiSutdVyknLLE2?=
 =?us-ascii?Q?FNoXkTzQCCxHPQsTObE4HS6UQq+jU5J1NaF9SRRQv5A6bbq70mI72Xp4NPol?=
 =?us-ascii?Q?RQS+lLHuyQ/k0SyJmSPf+R3eVk7smJ9M09QAH1hKL15ObpVp9g9ti6VO6z14?=
 =?us-ascii?Q?X+2jSNrU4rHGOn8QbC6UvQm+YyfcVZgqVuweBu6S32Ilxz8DOJTO9J54sKBU?=
 =?us-ascii?Q?LF+okixPFK4sgSpMGE4uyVtAftavWfpLL32DOfTZs77h6hIGZ8hbuxCx53Iq?=
 =?us-ascii?Q?dVxBetk4vtFeB4Z5BsDlkJFgGVzNXvLaB0cM3OyVlTv8OE5eAfNSGS3uxSpg?=
 =?us-ascii?Q?t5Fh26SY4xppdtBtCKSNwG0an3v2YsvoMJYSDg2JptOYsXPHwLgcvHZjW0/5?=
 =?us-ascii?Q?N78H1G84pAHqplChSwS7728xZ/jh6rSRnzHjdPR4DPCojJIvX61/iBmcPDCK?=
 =?us-ascii?Q?1kaaMMr7kOOd07qlfo1aPpaXwZxblfKWsRklUR6zzYN+KEP+7Kx+5Me5f3yW?=
 =?us-ascii?Q?hDX5t12FT52i+PVZ5S4ohgNzMLakNAm9DGuMXxs4sDRGKU5IFdiuo/itUE6E?=
 =?us-ascii?Q?s6tHrFQfU9jtOjCSCnuITm/duA2xU1V9JSxT0hqWFJIHrAdKNprYAJM5TQh9?=
 =?us-ascii?Q?IkLEsK+/cORdG3LDO5JpYvRAb63fSqNJCSRPzeXxyc1O9STMBSMTVOSCZ5S5?=
 =?us-ascii?Q?0saj9ZoMXYuqwFV00n4TlCIanDSQWrWwLH/OXKjt4FsGVUvuxw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4CeybePYtqODwYT3uwsOdY6FV6IwwOasezBi+HUiKniVBy4jgP0OzMLFhKX4?=
 =?us-ascii?Q?zrCpEfNbiaoCQpea33SoRZDt58uVzs2LtZBS2luMQT/vh44AoJ1tsbAsmyNW?=
 =?us-ascii?Q?OKgabcFu1aVQ+9uRkftVtv98/4iIHFYV9UulhvhiASOoC6iQV52by2lAEmWh?=
 =?us-ascii?Q?iLvmN48V4e5FqvzQqc2hihkcFZdv3EWJ+hyGX5iUeAor3082Fv0A1/cmiIwu?=
 =?us-ascii?Q?6/PBzRs90l4nm/2ZfGdHdtO1vsUoWbNgiDS9wpFcAKHYIAPipCz4mvbqKxWH?=
 =?us-ascii?Q?B5Kj7yB66yjT4TS/pgygCk1P5c8BYjEyvwvBSIf5syapRuZ9ASVuCHKQUQRl?=
 =?us-ascii?Q?Y2zkL9dynxRU426wVre7SjXtIktlQtJK0O+xf1JyiBGniZz2+rjL//22W2AR?=
 =?us-ascii?Q?c36oDeivpd4asgaLL+LtNebHHNg8HXOmI7MJnBQIIhXRiPKYXNlqC/6cJC/E?=
 =?us-ascii?Q?Pgby8psi+YUzYQtyvQ5YhM46v6XLe9eNwCMe4yp12LrjU6JAVONYUFACBmN8?=
 =?us-ascii?Q?XDhaeJeZAunZBQkOTC1A/HmhqkqOk1IeArIY4Ipu9p6P7EXRLbIPuPs1UtNF?=
 =?us-ascii?Q?mizCtYmxi7GWu5p5DngD941D2+v2C24770OlFjtdZ7Yv4WFbTl9PeFHC8DHw?=
 =?us-ascii?Q?KnK/1Ip2V0c+dW93vN8A29DFz6+2fU99DYY0BV++9hjCVe7urhhnHQkO5Ipk?=
 =?us-ascii?Q?1uE0tsnQivzuE0yKf88mznvxuyLee6p7+FU1/OEY+c+2+E8FVmj5elSp4ucp?=
 =?us-ascii?Q?bAJvgcCB7FENtH0WxvdNv6iMLT+K2uVIgBRb2yxiJWOMx9EtXZ/zHogKS1E5?=
 =?us-ascii?Q?42aFveyGS/BAhwWcsne+8m6wpYlQN3e25sphDuQbFiSuteI9aNqX9KePW8WB?=
 =?us-ascii?Q?ZPEh+uA8KMj+jPPY2LROjNdshwtAGnehYomSXuPoHmUbXIEg4rMPzhwoiE/G?=
 =?us-ascii?Q?lx8dl30AJ+CVOYDKV7laiPAMJpfrxEbSM6LazeyA44Pkz2MyBxhQRjeI78FT?=
 =?us-ascii?Q?uBwD/AiMmmXd5YCxTCs5p0xofcA7+uc8TlIi7tEEW1riHs+xbYTqpLjBDH1t?=
 =?us-ascii?Q?zRjAsjKUCOEatlXLm3MIUQ7o9uetkKs1kJhPWQcF+n5p2MLPWiXAOBi6yPt3?=
 =?us-ascii?Q?JgjzMOd9BZle/i1MlOKS3eCgE1wRJ09NZqyvboCzt3EnQB9MTKAFy4c+B7i4?=
 =?us-ascii?Q?KHm+6q4xg5basB7An47XxirJ/TJ7lNeIezdpvHM9RZQ4X+l6HGe5whGnFS5z?=
 =?us-ascii?Q?G9ZJ5/DjzPMaAu+RV6n/p0zkdAGb07G1/Nq7oFO6nvulVxPDDwzB5RhMwkHs?=
 =?us-ascii?Q?CFNfE9gqwtfiYkU+JDB+kOmKlchkAiKPljmTTbTvmPr3K3raPQ31pf+z05Tn?=
 =?us-ascii?Q?ppmflBwp/JuPWpu9m46JsXSBrx9Yb/IXFviGjd+TkoOPy2iGi9IZfj8AqoiW?=
 =?us-ascii?Q?rX1RpnuRqQKncRil1k48HPZ/L2A1oEKNL21Tg/bt5krOXh7RwksGVPviESjy?=
 =?us-ascii?Q?MaZ+pcp5uQ73XJ+jNFQNyUA2uWpklzWUVoAowrSYD+X/G2Su/SYA/J+G+jAs?=
 =?us-ascii?Q?Q0jfGyVOBRxh8NOmJXn6bQP+QFphosfDa4mjj+UU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5c5162-cc38-4823-a66a-08dcb085daab
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 10:53:32.7590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpiknrqv2ndzyZNM8EIXrsqHFXk1xZdIwbQkypkFZRdCo9QTdDLpbm+TfSPeSaOImahIVp7WU7uwi024VUjJIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10007

This adds a new state for transports created by the Broadcast
Sink. Such transports will remain  in the 'idle' state until the
user calls 'select' on them, at which point they will be moved to
'broadcasting'. This allows the user to select the desired BIS as
the audio server automatically acquires transports that are in this
state.
---
 doc/org.bluez.MediaTransport.rst | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransport.rst
index 6e95df8f2..2a3fc6411 100644
--- a/doc/org.bluez.MediaTransport.rst
+++ b/doc/org.bluez.MediaTransport.rst
@@ -7,7 +7,7 @@ BlueZ D-Bus MediaTransport API documentation
 --------------------------------------------
 
 :Version: BlueZ
-:Date: September 2023
+:Date: July 2024
 :Manual section: 5
 :Manual group: Linux System Administration
 
@@ -51,6 +51,20 @@ void Release()
 
 	Releases file descriptor.
 
+void Select_transport()
+`````````````
+
+	Applicable only for transports created by a broadcast sink. This moves
+	the transport from 'idle' to 'broadcasting'. This allows the user to
+	select which BISes he wishes to sync to via a 2 step process:
+	1) the user calls this method, changing the transport's state to idle
+	2) the audio server detects that the transport is in the 'broadcasting'
+	state and automatically acquires it
+
+	Possible Errors:
+
+	:org.bluez.Error.NotAuthorized:
+
 Properties
 ----------
 
@@ -84,6 +98,8 @@ string State [readonly]
 
 	:"idle": not streaming
 	:"pending": streaming but not acquired
+	:"broadcasting": streaming but not acquired, applicable only for transports
+		created by a broadcast sink
 	:"active": streaming and acquired
 
 uint16 Delay [readwrite, optional]
-- 
2.40.1

