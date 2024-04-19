Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2044.outbound.protection.outlook.com [40.107.8.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AC413A871
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 18:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550087; cv=fail; b=BLqIsvtcv/nyFQEV8K+CWWiA5M16c5ep+Kop9GOKPcHVCwBZ5dOmIBRb/tropIq4uBHDPjLFo81P8BBPNeFu3Ykiet4USljCsrfDLp2EU86MJhHV4GoGFwWhDe4FCirQASGOpleKBCNpUGpbVC8JTTPpYUVtYSVXRuwhMqSJqOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550087; c=relaxed/simple;
	bh=MafsYK6ls0hz0gTSs0VWUg0K1SxAjbCQIcFc7AL1u+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ROHXyzk4W9sCSgjeAwyzH4cMCTk5c7nidsK9H05SIha/hDsYymYa3MEv5nw9Z3SOOELIWELTFWElwZVvFEYGdxjUwq+sRLxcpnfQKJNPVKAvO71qbG6PVVkQ951YpxEDUyliNPjJ/7cYeknitqF2BY1i6UXi7YCFkmkBESKT/mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DobPPSyB; arc=fail smtp.client-ip=40.107.8.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DobPPSyB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oe9LtGAzsqOVmslkXqV/irDhcXc6C7lKZaQP6R0bTk139yAlVuBJZb93//k8Va6FA/PhddgAZddKIZhQdIdhiBTWPnq4qCFZNMuBGkWj39lQpXKw0EpL+KgA3diElpKb+5aTOuXGKXVJ6jb/RY0VL85NddTEYxk0/9SvT5mhNDsWeD3htoyMu3GHZ1jNz8fSJDfRpgSlmS5gpk2zLwHB0g97OhjrZA/BgyBp51SuuR5LaisM+rHmfKjvZ/ZGy7nuBs5tw3AvwJy92aAk5TXyuKlUuSr8fvmzECcqVCZKPCHZTjIDybIF3hkwMfBt7iCtMhxDTz7taE6Ugz66Ymp49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hy2A4NSuCLkPBDBldkkhYHsBtbphNfKet7P8yGw2z5I=;
 b=IfhH/G0V26LHJ4ckEbmrt7iT14wBVJZAwscg2PrqF/MKH4aZSP6/+B9nnWh2n+aSB8xCixvdDhqKxSyRc45VyRYSCODbWRJfAOX1MXI2iIDTxmK8DNtPW1pCHzjuzofc0SekU+XdqdL6HlUAycUrJNX2hQK+5rFmPN/GREeU4cC45ZEeupxaiIuY/IKutYrv4xAmSt3E3HEiLuetOSGlISAyelCj188LKENdQNwqQII78fHtQbKMaKL1Ert9Z/64ctYduyjfSqSx2AT9FUKJmQ2rPHowgUhNKI3mNiwgcMvpGAdkjujJGxF243GF+eKtQcrJNDyjMM64u706U2ki8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hy2A4NSuCLkPBDBldkkhYHsBtbphNfKet7P8yGw2z5I=;
 b=DobPPSyB+KtVLyZdO0LudYwU2USSJeXJqHflWGAHzVv4o7SSjOEZfWSigcpuLiGck/bqtyL9v8r/xfuaqQSS47v2LdIJnv/Xz/+coeL5bHrANOvA6tXYfbILdLuHW7qsXXBmdjWwqSdSXhZ0ctBEiq0MWNfzY4JpyUO1xqXxsBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by DBAPR04MB7381.eurprd04.prod.outlook.com (2603:10a6:10:1a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 18:08:01 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::fa84:407b:3889:82a2]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::fa84:407b:3889:82a2%5]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 18:08:01 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ 1/5] shared/bap: Allow NULL bap endpoint in streams
Date: Fri, 19 Apr 2024 21:07:48 +0300
Message-Id: <20240419180752.96699-2-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240419180752.96699-1-andrei.istodorescu@nxp.com>
References: <20240419180752.96699-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0302CA0022.eurprd03.prod.outlook.com
 (2603:10a6:205:2::35) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|DBAPR04MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: 6403d382-6521-48f9-6007-08dc609ba697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8L/m3bS2R7oSjHXiJ2s33h4V4bVquMl3uEQqYmGFmwdyYoPTDtTbI3k+J4DQtTsuMtrV9K6um6rH7i79LxFmrD52QA6QGAmcpxvAkzG7YPL7WOKaIySLD7RGW9MPuAnRJQIWO5vD1gQLxtNma6VkGyfK5ufRCVlGpCDTUUl2CiD1In+EdznGkZ9CxSakGEamiu6usNKCd8ZdS7zBeXKgcXk2h2dJoMEWvyWbWaVNmg5PWCTMKilardR9Nnv+wFlg4aQxgVZDAChSYQCZJ1xblzgsN8GgsHYc0zrSRJgNhHZswCTuZxmPwa6Rvk2Ke32bHkRRPf0mGbYx9oqDWvTl3RGVZXJq3/TgNEJUlvJmBV/ReCgxK2tPTi61PtDAz4WXb/gHGJOG86DuJLh/KZ6sj5MFvPfWfAPosTPjFYpOF0K5Td5qtprUjqCcn2PSF3uZF+PyIE5T/iL0l56G8USDZ2RwbdKZGrT0+zxCMM5DcyXX2Ezz+HI+zLnsQr9lljMHdmfXSCMbIPP7vf199ySjEpzBRAh9FDxiOU/wNgAu/UipNQyhW6ho2aO5scEUzOXR0q/1L7T/n6E/DhrNO8UivHqLGSnHag4I6E5CKEIEzKhsd9JI3zSdPaVQ6klBLxylGw0Y85eaGY0ZOuEuPDGjUxfnemjwG+1IygczR0EI/XI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iBQMvasjYFd7ggb2JoaoxikZuOdFpeZK4AEl9R95iQbhI3qXoxfbDPQO00hn?=
 =?us-ascii?Q?GBTHtgW+aQsDDWrF9rT1Lr7tG6L1xG3YbdQsqKTGrovaTM51uK7WbrxKSnDW?=
 =?us-ascii?Q?/EK0XDfKuGpMxE9EhK8Cup0D830/O0VncrfVoLrpl1qI+o925X4u+Kx1Q0qP?=
 =?us-ascii?Q?NMBLrpUqNEyEpdi6sIasuG5668DFO7D+zlkrYl9rzle1SV/DG6CnjrKY3xkJ?=
 =?us-ascii?Q?QlFWwBwgCt+3NhTk8GQx8whhUNcwqVfDyL1wmjBO3ZvloEmI8YbPSlwW7vxD?=
 =?us-ascii?Q?yQ0uzIsJu623JhXTxzQ6qcjWOiTjsFCkeqDtsdwa3few6lT8TyDixZvoDb7z?=
 =?us-ascii?Q?mTD4T7znZgPL26MhjYy8l6+gAGOSm0raeGEyl/KXjLHBuT/NaFm4s4gGf3xG?=
 =?us-ascii?Q?nwRQ+YwmJ3FGp4Ala6Yc63E6S5hpcLH5eVVQm5QVOjRZr/pN0HFFJh1BX7yC?=
 =?us-ascii?Q?o9ompPrFk30UdhITX+/wuN50Q0lsSca4l8J3as9yO9sEuGeH3J2yprZyeQSq?=
 =?us-ascii?Q?vFbzM+iMbqfed4a7w8PX4U/Ub60TLXk38B45vHpZMHrkHWq7KAGphKTYyoZ6?=
 =?us-ascii?Q?ba28rY3Afj1Po049uVOPVc2PZQPiFsev3qk9dp7f9j4Fbp+Qy1zCkxZOcxlW?=
 =?us-ascii?Q?CsRNKVWvfWoC1jK76twzC0/PTaNYXeQ8XN7CIAU7GnVZSuXgdMhzP2RJadwh?=
 =?us-ascii?Q?sGMN4c4iGh4b4BNDbj7eqfamFqF2ynDrcd1J/F6SHxc57FBUaka3JeYJuLs8?=
 =?us-ascii?Q?lpwJ8AFSmIdZmI1sB3yfZXR1hg/nAkMraIyTCQPm8aN/mmOuEVvtceVB0JvZ?=
 =?us-ascii?Q?I782tO10fUTXaFhsS1htjY0LoR99qHyCAMy/rYxHTLt4td2IIjMR08YW0oUB?=
 =?us-ascii?Q?fLMHVTEGgGCzbr0zSe4z5+wl+Bta9cgywxX7oyk3cH8Es/KNlT2xW/KF4PAt?=
 =?us-ascii?Q?tQWLmoqEcMp1qp9gksezw9j/G/dag5bkNgpcwzzkf6UpZXLMeHV6QK+x4Wkl?=
 =?us-ascii?Q?mxGEAibNtYLQVYDLYFZDWTlLWTKVgrR0I9XWwiMIRuZZjiPorWOshcLq5QrN?=
 =?us-ascii?Q?X/41/aYVoYGmpImZj2sXWReMIX9pqKQ2QX9zGIcWoe2vi1qik0SI43vQ86U7?=
 =?us-ascii?Q?RmjmmDq/ZA61dLgnClZIBxerLyBPxMU5EQmGFZQSYmR07IAtzUY+5UQ5DkeD?=
 =?us-ascii?Q?N5N4WVZcw4s1BpHZgGokW57dOz+tbprjGdLw+bqpMuKsyNkQmxB7I04vuDf6?=
 =?us-ascii?Q?B/B6JLiK/adXLOgopghdYMDk2lGbv1bCfTHB1m1vE6NY6RWyrK0Lx21afVPJ?=
 =?us-ascii?Q?2Gj0mO8hfdylFYxK6VK8xODTKuyN7mr6Wq8Ur6KVc+BjdExn6rb9387PQCGj?=
 =?us-ascii?Q?W+w2dkoAlv5GQ2EkYyqoarTJyaVMDVebwEE9scwBP0cFmciIgKuue1Im4DUZ?=
 =?us-ascii?Q?3NaUgYOugUaOZht9LXf8vtkIXQjjxbtAa/u8UuqIDS/ZcLS8VW/7Ca+Y5Ch9?=
 =?us-ascii?Q?6gWztfz8mltUZLvMEm7jpEd7E6/yWhMgfi3uAM7LOrqw0BT3JPi9ZGwkKIAS?=
 =?us-ascii?Q?2goiujpZxPWGJnDrH2tHviZ/CgvzykvjyFJON+sSyVxzhpZ9sp4I91t9b2Hv?=
 =?us-ascii?Q?0g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6403d382-6521-48f9-6007-08dc609ba697
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 18:08:01.2921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1vmMaMyx5SOvMfimJiC/VMcmjCfYKKaAdpMagy8cNbMWpKLfVKVVXV+53cSgwn5syOkE0/CUMISH/uCO897+SAtg6qgIp63Fsdq3zSYoe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7381

---
 src/shared/bap.c | 54 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 14 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 71eadbdb68b1..6328ff35f3c3 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2115,7 +2115,8 @@ static struct bt_bap_stream *bap_stream_new(struct bt_bap *bap,
 	stream = new0(struct bt_bap_stream, 1);
 	stream->bap = bap;
 	stream->ep = ep;
-	ep->stream = stream;
+	if (ep != NULL)
+		ep->stream = stream;
 	stream->lpac = lpac;
 	stream->rpac = rpac;
 	stream->cc = util_iov_dup(data, 1);
@@ -2209,6 +2210,7 @@ static void bap_stream_set_io(void *data, void *user_data)
 	struct bt_bap_stream *stream = data;
 	int fd = PTR_TO_INT(user_data);
 	bool ret;
+	uint8_t state;
 
 	if (fd >= 0)
 		ret = bap_stream_io_attach(stream, fd, false);
@@ -2218,7 +2220,12 @@ static void bap_stream_set_io(void *data, void *user_data)
 	if (!ret)
 		return;
 
-	switch (stream->ep->state) {
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BCAST)
+		state = stream->state;
+	else
+		state = stream->ep->state;
+
+	switch (state) {
 	case BT_BAP_STREAM_STATE_ENABLING:
 		if (fd < 0)
 			bt_bap_stream_disable(stream, false, NULL, NULL);
@@ -5424,7 +5431,8 @@ uint8_t bt_bap_stream_get_state(struct bt_bap_stream *stream)
 	if (!stream)
 		return BT_BAP_STREAM_STATE_IDLE;
 
-	if (stream->lpac->type != BT_BAP_BCAST_SOURCE)
+	if (stream->lpac->type != BT_BAP_BCAST_SOURCE &&
+			stream->lpac->type != BT_BAP_BCAST_SINK)
 		return stream->ep->state;
 	else
 		return stream->state;
@@ -5611,7 +5619,13 @@ uint8_t bt_bap_stream_get_dir(struct bt_bap_stream *stream)
 	if (!stream)
 		return 0x00;
 
-	return stream->ep->dir;
+	if (stream->ep)
+		return stream->ep->dir;
+
+	if (bt_bap_pac_get_type(stream->lpac) == BT_BAP_BCAST_SINK)
+		return BT_BAP_BCAST_SOURCE;
+	else
+		return BT_BAP_BCAST_SINK;
 }
 
 uint32_t bt_bap_stream_get_location(struct bt_bap_stream *stream)
@@ -5623,15 +5637,17 @@ uint32_t bt_bap_stream_get_location(struct bt_bap_stream *stream)
 
 	pacs = stream->client ? stream->bap->rdb->pacs : stream->bap->ldb->pacs;
 
-	if (stream->ep->dir == BT_BAP_SOURCE)
-		return pacs->source_loc_value;
-	else if (stream->ep->dir == BT_BAP_SINK)
-		return pacs->sink_loc_value;
-	else
-		/* TO DO get the location values from metadata
-		 * for brodcast source and sink
-		 */
-		return stream->bap->ldb->pacs->source_loc_value;
+	if (stream->ep) {
+		if (stream->ep->dir == BT_BAP_SOURCE)
+			return pacs->source_loc_value;
+		else if (stream->ep->dir == BT_BAP_SINK)
+			return pacs->sink_loc_value;
+	}
+
+	/* TO DO get the location values from metadata
+	 * for brodcast source and sink
+	 */
+	return stream->bap->ldb->pacs->source_loc_value;
 }
 
 struct iovec *bt_bap_stream_get_config(struct bt_bap_stream *stream)
@@ -5841,7 +5857,17 @@ uint8_t bt_bap_stream_io_dir(struct bt_bap_stream *stream)
 	if (!stream)
 		return 0x00;
 
-	dir = stream->ep->dir;
+	if (stream->ep)
+		dir = stream->ep->dir;
+	else {
+		uint8_t pac_type = bt_bap_pac_get_type(stream->lpac);
+
+		if (pac_type == BT_BAP_BCAST_SINK)
+			dir = BT_BAP_BCAST_SOURCE;
+		else
+			dir = BT_BAP_BCAST_SINK;
+
+	}
 
 	if (stream->link)
 		dir |= stream->link->ep->dir;
-- 
2.40.1

