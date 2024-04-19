Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2054.outbound.protection.outlook.com [40.107.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF71813B5B5
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 18:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550089; cv=fail; b=fCyD9KSXxHjJG1DkkAZUB3JkdaqFYPmIxWWL6+7ilkibHxsRRGsUnbLHSCGes8mBMcm3JSQyg1rI8k2dEBxbSFx0TrPNb6s/+ztLnhC2EYSniW0jqDrmshs02VyfJkyr+vPy85mdpZNlVw9b6ku9J+frJxkUKfqa4qbGN64VZgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550089; c=relaxed/simple;
	bh=epB83WXDzDRRwwg04pkoF6XG4xVuJw9LgMcc+sDEDH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fSSgJk6Yuzs0TCZ5WpuTQl5ySAeb6PUQqUPNPxMymLP8riCXjc/yGAtkOp3eCd06FWWfq/+l4EgRFhStOnYPCBFLUTt2E9LA7A4PKfC0L6Qgx0ts29PLChRiGmDExW6Odkt11BMuda2HVbi5+OEF6ueNlPMKWGDb3s9GsmxvYfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BhmiochT; arc=fail smtp.client-ip=40.107.6.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BhmiochT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkDYcvcDP9fzVOACMD4uZepM2fJpYGHQU6y5vBd5REawf2h/c6n8Xtp3WkS/R/LrjPqsZCOk/CaGCh0HqpEEOIE/nEpWgnvUgUV2M88R3ILs2YYgDK4XCy02iZDMcfR9WBaxem+Ba8AP3Ao+swLlD1qLi28gst9BPKR5RatQQhxqV0edvuijwQi3EcxM+axhb3X1hUTBE6bhQ7Eu2IHXKBtopDYTn+g1d0cxVrwPIEvQtv/GD7T4hvJa5cejNPJcqKV132IctM9qGzoaTaNp8XIQFe0CWiiC2jsSVDrvoDVzRTf9BppRDrMC8BE5mI0JNfilo6ubiqOg3QBM21d6YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1Ds/vQuWsCzab4E21263OEA3BhKPOsrKcZN9uH5jJI=;
 b=KA6ccbW5aWSIflUlrMGk+IvM/KDhcGfmb9+PwS0Tc04MfTypF/aFjTXyakm7Fgy0Ro639kOs+b4WhfG677zZ4AA4giNhSGo44zgscJc6D9QmdEV9p+m50oOZnoQewMFzNg+0xvEZhBwn6cZkYkaBuoUa/vO1Z8RlbzgOJ3VDJ6hFTWbU7Yoxvv7pndZszXsdrPykh2KCMvQFPHlhYn/7nKNroSRI0u6/U3Vkr0m3na/qVqBlWfnmQgXMoilMQzSzSy/NjnF/4PlOXWPrJ5UGDVOIRW7fqGvHhNO1QO/5HFMMb4/rEerEXsMdWrK3ZsO5hIm4vJgqLa8O1oH6bSzt5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1Ds/vQuWsCzab4E21263OEA3BhKPOsrKcZN9uH5jJI=;
 b=BhmiochTk2paQE45kWySTC9Twxc3HbPuQzokz/OS6jdOrglMp94jn4Dx41xsy0ThIqfIXGRTItmcA5P83UMrXzRm6ah5E5zm8if4UsRIrPNEl/xkuLpEdl7BtmLVuILpICWxA9zxxjO3W5bIPIChw768k100+MnCOdz77S9uYEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by PA1PR04MB10261.eurprd04.prod.outlook.com (2603:10a6:102:467::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.48; Fri, 19 Apr
 2024 18:08:05 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::fa84:407b:3889:82a2]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::fa84:407b:3889:82a2%5]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 18:08:04 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ 3/5] shared/bap: Update stream management to avoid PACs
Date: Fri, 19 Apr 2024 21:07:50 +0300
Message-Id: <20240419180752.96699-4-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240419180752.96699-1-andrei.istodorescu@nxp.com>
References: <20240419180752.96699-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0087.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::40) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|PA1PR04MB10261:EE_
X-MS-Office365-Filtering-Correlation-Id: 0def9772-d7e5-4501-517f-08dc609ba8c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kx5v5two4xpfiDfA5rqhWuEr50geuQyELo5YBJC31Cf/pKmwEn50RQCTA3i6?=
 =?us-ascii?Q?Rkim689/Mx3I1/3ZvHvlGZpcdVdmQagk8geQjbBApvn/uv/1wJckR1x6cT8k?=
 =?us-ascii?Q?wbw90GhG6Jso2VwgmilayYd6wKNVbcVaUp/cmohoM7w3CyzxrSslput2HSQy?=
 =?us-ascii?Q?9j4KqvYx+maUrKMiquL35fIxRyPfXAh8E/YbNm+CVk7oAKrDiEZ7GpanpgUC?=
 =?us-ascii?Q?Zu9iEbzotzMyMZcOaLzEO4g6Y/jDJ6E0CWFIut7xuLNlSVSRdeAAGHsUMo49?=
 =?us-ascii?Q?azv15Rb3UoBDxJg330qetlJjGM5U1U+fgdxT0/KtgebjRMdEe4ieIN8Pm2BM?=
 =?us-ascii?Q?jH/QornuiFrc/CW/S/8iBsOJIWsqZM1WjwZk9BbptdvhkjA+kK8Zj4nGh2rm?=
 =?us-ascii?Q?IWvjDz0Fn+GXUr3oKRn2BfR8dS47Kzg9Ty1+vRzvfm6iuEsFzBIuKMy7JHB5?=
 =?us-ascii?Q?isUffTiXxuI/WpJOvysiAUteWNW1L5auhT3+3+yGNs6Taep+rra+4CBZ/PkC?=
 =?us-ascii?Q?1BwZZvsvItvkjpcg7hztU5+BAgbkHUCa0mxufvCJHaPFYsTZbLHWdlOvsJfi?=
 =?us-ascii?Q?NfpwzK9j/WtcNZq72zKhNECAu5BnJqpwWwQjKlBFPDwVee/ZLSzx12R9VuLW?=
 =?us-ascii?Q?aadN65HAheCLqdndKV7XOLsdliWLM+1v70eTkZMG2oqrbyyM6nWRStdf5oiT?=
 =?us-ascii?Q?9i2m2wSxhfsxyv7tFZwVqewXu0DVMjzo/fWIFrblYRQHypCL/PXZXtO5YJuB?=
 =?us-ascii?Q?/Rs2PraJ2oqA8KmGWkmUT1rRFMFtAhnaY4aKm1aHD99jS0b1ORlyNbi6RpAC?=
 =?us-ascii?Q?xi+YDieyu2dZjIwCNZMvajXRwNxlfA4MTubs+ZFIuP81PNcs1/3+gkmU+iUR?=
 =?us-ascii?Q?YFYb+2imdz2DAa16Ipiw0pRPRnAQ5d+M4hjFByQ0t6FZfWuCtuXI55nl97uv?=
 =?us-ascii?Q?Ixp1JpGrs940A11+N0kqSAHimphMTgsihl4b2PLWYCPTdWc7snknK4JR24zE?=
 =?us-ascii?Q?ORNMPQPUdaxK3wjbzMR4SUv9lDVOtYkYbAQz5pe78qjlSt5jqVugqGcD//0c?=
 =?us-ascii?Q?3xpdRfroKUuLDvih6+tZSRyn0BUUD7oeBgTXsK5XFtNs0rFe3Z4fBjePL6cP?=
 =?us-ascii?Q?+eeFbakZRDfBqO7E4RdkYTNtqzxLcxAIEc/t0sQHtPtabKUKQDOvxUK1e/Vt?=
 =?us-ascii?Q?p7bmjgCeRB8+fWqAmBi3KdQmhEaP7hwM3lXRQyUFEBbxanWFd+Y6cJ9PRGNU?=
 =?us-ascii?Q?G7Kz+u50SlgeS/8ACw9IYhlEygDRPaf1w4qlOKPQFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jJJq1HK/eCvicnh7TCCudKpd/KY/konrtuS/dWnUFJbIYvBtSM3MLRmK0IMz?=
 =?us-ascii?Q?5t+z4SKLVynQ5qqrsp/HZb9Iy2sHu5zkLr+MXpKkoHMzlA3NGS1f5G/Wu7IT?=
 =?us-ascii?Q?LptJXZ/TB4fIq2Vj7sknNGbDaO1kv3g0GNm0y28cycEoDChsV/a5ubzdyScl?=
 =?us-ascii?Q?QFhHq77UhvQhUzcJ+rCmo5M8ote69xz9/v+G6gI85QXDb0I04IlpPU8jQBSQ?=
 =?us-ascii?Q?UA1L59X3DBG8806CNV6GTmA+5pDe95qY3/QPon7Zgjxd4n7PWOjtG1ZdYzfQ?=
 =?us-ascii?Q?Hsm1uvTbt6U5RoZDtwc95gRfho3RyidawyUrfDK5jyJiVH2yiy54ncqCYxhM?=
 =?us-ascii?Q?4n7ElVGPLK74Ef8agqWxlyJPYYIRH1eFsKEljwwJqsAdH8LKW+QDfAHnN0FD?=
 =?us-ascii?Q?eDJjrtP+8luLmf2xQYllp1cLs5cBIoAcRHjzCKAvD2XVl1vTRIErVzMMRApG?=
 =?us-ascii?Q?l7sp90BSH4LP6UCi3r+ZTmUEUleiruadrbboD29q64RiyCDd1Dk+b2vw+C7G?=
 =?us-ascii?Q?5Lbg4+1H30UTSeGVqnMHx2jEk2wwOR5BbE3AffD7NacsWMLvaa6UwVQ6Me/S?=
 =?us-ascii?Q?F+ZgJVDxKI2OEj0SQvzcVhfS8p6woDHwRMTpITNnrzowhOyShBRW9HTmvPMh?=
 =?us-ascii?Q?cITAMIFFNn2d15JLh+LJ1Zfxfd6SFi37fAnhBV57rA6G1c0na1FqOTDI0+yK?=
 =?us-ascii?Q?eWI7a7W2To5stUbrGxHiUggbFP/AoWhVYJM3XUw/7qQysZhHDWQgUgSI1Wel?=
 =?us-ascii?Q?xm6T55lbyS3aYkNvv7NtTI+t47Uvxt3C6z1P4i22C7JXuK6ma93NDHK/1Tcw?=
 =?us-ascii?Q?LWFutBVGvpoZkCqU6ZUl+qenHxyfRIDqMhm1a37tvbWfKvRDPKu2BMjC+7vE?=
 =?us-ascii?Q?U7NE3tW1AaY5masOIPFUoWDxSgUK3G4GybeuQqMa+YMkNpeyzfLJ5pOgkxIS?=
 =?us-ascii?Q?k8CCASKHBWMNMdxO1l++588hvfjXEvmQNFMosw/eCnfU5xBqJQkmrMPhbj9A?=
 =?us-ascii?Q?gErTWTrRe+/kR2jCwhzk6kbyv+ZbPPUajVUVr+7Xq2E9PxqgK2cyKvpaQXGS?=
 =?us-ascii?Q?mSxMiEj/B8kyoduSUd4vEbQdudPP0BB1azSSY6KXotdCXKL8v4BePkWDol/g?=
 =?us-ascii?Q?6HVHAj6c14PZiUy16sYIaOAUlxAZW/FoAOBD3oZAKkqVrAl2RVC+t7IMd40a?=
 =?us-ascii?Q?SsOi+kZ6xZCQF8OiONTcSBHi2seezIwb0WymFZW/WADNeCW/UHupdFX5AJSy?=
 =?us-ascii?Q?QYNsqRSKC40PlCx2tRNoZ8BGh19Uc2T9MjRQ9LlrnY9OA9kmvyDOo9KsFphh?=
 =?us-ascii?Q?kxqJPACs4QA8ctV/QuQmXXAltyvMwYllYmF4MBNNlV6Y+w81wuY6br6X1yh1?=
 =?us-ascii?Q?Peaf3Qb9kh0rbZQxy0lSTlWoHC3tVmcFL8onBSepm0/AqBTkZhjv5whks61z?=
 =?us-ascii?Q?IFIN7C8RbVf4ZmbnxV7Cq2+v8gZHj85tAU1XRIF3uPWx4+dE1zw2KzKvkkcR?=
 =?us-ascii?Q?rBZDDvZFbLMDxHInEPTcFlC1aNvDdLDOFMzAR0o7R9tECr2ResH4SrNK1u3S?=
 =?us-ascii?Q?uo7n1xXaHON2cRNkJZi+iD3TLqaE7b+u943IS/BvQEM9TDTdK03EYrLzDyJO?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0def9772-d7e5-4501-517f-08dc609ba8c6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 18:08:04.8962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zn2Gdfr9HZV6xEPnco2+vSejSkgc4L+kv6KsS9197TqRR9wr3gjyYwbff7IVyHkTFTlTQ5kjXwJtMn+LUTtQv22q0K+eJ2OYSOdxakKK32Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10261

Set the stream to enabling for BAP Broadcast Sink, when the transport is
acquired.
Remove PAC logic for BAP Broadcast Sink stream creation.
---
 src/shared/bap.c | 60 +++++-------------------------------------------
 1 file changed, 6 insertions(+), 54 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 36f0b0a3b50a..d7a2f9381c53 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2006,7 +2006,7 @@ static unsigned int bap_bcast_enable(struct bt_bap_stream *stream,
 					void *user_data)
 {
 	if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
-		stream_set_state(stream, BT_BAP_STREAM_STATE_STREAMING);
+		stream_set_state(stream, BT_BAP_STREAM_STATE_ENABLING);
 	else
 		stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
 
@@ -5287,7 +5287,6 @@ void bt_bap_cancel_select(struct bt_bap_pac *lpac, bt_bap_pac_select_t func,
 
 static struct bt_bap_stream *bap_bcast_stream_new(struct bt_bap *bap,
 					struct bt_bap_pac *lpac,
-					struct bt_bap_pac *rpac,
 					struct bt_bap_qos *pqos,
 					struct iovec *data)
 {
@@ -5298,71 +5297,24 @@ static struct bt_bap_stream *bap_bcast_stream_new(struct bt_bap *bap,
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
-
-	match.lpac = lpac;
-	match.rpac = rpac;
 
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
@@ -5415,7 +5367,7 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 	if (bt_bap_get_att(bap))
 		return bap_ucast_stream_new(bap, lpac, rpac, pqos, data);
 
-	return bap_bcast_stream_new(bap, lpac, rpac, pqos, data);
+	return bap_bcast_stream_new(bap, lpac, pqos, data);
 }
 
 struct bt_bap *bt_bap_stream_get_session(struct bt_bap_stream *stream)
-- 
2.40.1

