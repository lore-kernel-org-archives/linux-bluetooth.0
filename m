Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2083.outbound.protection.outlook.com [40.107.247.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C862E202F80
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 12:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858964; cv=fail; b=FTjU/iusbcf4JA6FVFfCAb5ONFrPtQgHhyOWZD/9jaR0i1FbcdxgNcv3M1m0Okhvs9muptntT3N7DwvVQZ5ifEKZ0McLFZfLL7N0r8ZThcenUixXCMZFRG3QLnKOuFeteIPCCtoepnqryc9ILFwQagyeGzwu8q4t+eaft7HBVUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858964; c=relaxed/simple;
	bh=172d8i8/zHicvfv8mroJyrMbtl7MeOWvVjr2WBMQSH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VctmXs5v/30MX+shDR80T/7N8H0B3XK/sfo5AXazD01MuFRabQUAhXHgVeuumHbp1yWHlNSjr0tKLMgqapQE1VHHOOlBjsndZRTcr6S3usS6ubZEoYQyDUrN23/7pvntPjuqZDVkgOwz9iyNDUYCWkDUznCVzEBEqs5L/8727YQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GAlo6/0Z; arc=fail smtp.client-ip=40.107.247.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GAlo6/0Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zvyv0M9hT+kWJSHdLaRahNTp41K1TUJmtClsBoNauSmzyp0VBftT/rBe0KlPZdSsFXCSfWvWvTNguS7402JaTtdZeivK/6sZfL9gXaJMACHZK54RZbNYSmQI4k4vZBQ6uFafHfIyawM2FhfF8iHahFVcgfGJBrHThVLbwrv1GWzhU+9xJ7B94sakwzxyporYppCWMpytIeVJnuhMi+ml7boBeNipCHplIP7CnE/RbzotlRBCXAG9CDrs5zMk55y375WChaDhZ+TUoaL9EFYa8stOM7laytjqWclkNdzxeuGWK4LC/EhpAQcrphI4Rp8Urk5bdktHU8kj2Rxz+y8cGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqvVCmP5C3DRSJ0975nWdThfMmLvqcPyJT8hORJkPrY=;
 b=AuhvdcqjyBlDTi2yy/7hR3AgD/qG4Cbio9NYd4DHIWVrCFRuoKMdrtEAdP5MQvnGFFHVGExYvlWeOK/GwTpTkO4zaI7TZnwI0sZU71isex1xJDRCWQthzzZO6UAFqrdIskTSmR+GvjuglasLgCorf43HhP/PVtDHrV/iB1l7rDzrBxa/cTJOuV4PQlnnqEXsccInEf4xOSpUe2HC8M5yPuk6pTvXYhosMKXlZfjCDHnr9aD1ot22jZgfqg0Be6r0RcbH0IFzwvfrpE1fJ7XpRTCqIX66ypeyXRu1/tNv/jt4g1Jjk95J8G5dZ4nBsweCnJH3LxdCjdne+znSuRTwZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqvVCmP5C3DRSJ0975nWdThfMmLvqcPyJT8hORJkPrY=;
 b=GAlo6/0Z9hs4zqM4L4NTHYdcY0j5y47PLmubR4RRMo7NtPwq43FKf8lWNF8tL7xJ9jPLJ4BXyfLj/Li3eYGxLpbatgpO03B7VJyK6s97KeS598Q2jei9U/8gYm1JJj86VUVZVmid9GZccIVLoeA/V1b2IkRTBwzBy+8e8UcIwO66Ba4PN7B+vas9U7p4AMhtoTctlv1Q34U4U5iho3MDsmQWpRfv0C0T4Av94hJlkExVG9aHjzYTErDa4cERrAJ2BTS5ec0XRDWASuWIUXl4m4W0M1od7HwzX38rOp5CWZlHFZIwGyvyTYPvy+UPXX/oHgvkE1aVyjwyMVGgXFd1ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI2PR04MB11052.eurprd04.prod.outlook.com (2603:10a6:800:272::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 12:22:34 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 12:22:34 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 12/14] client/player: Handle acquiring broadcast links
Date: Fri, 25 Oct 2024 15:21:44 +0300
Message-ID: <20241025122146.17925-13-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025122146.17925-1-iulia.tanasescu@nxp.com>
References: <20241025122146.17925-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0006.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::11) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI2PR04MB11052:EE_
X-MS-Office365-Filtering-Correlation-Id: f248a1f8-6fc4-46aa-e02b-08dcf4efb4ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VuynRQYMKFMeJkbLgyHP1AOTn41cuxvyGb34VGU/GBe52jLXorQ5cCeQMMQu?=
 =?us-ascii?Q?1FXgMAApr8dNTJFkJ5umqEZrCLxuzrTSatw2ntvNclhr0IyEM0vNNlUtJ84P?=
 =?us-ascii?Q?/7nQl0S4NY/qwA1mgkbC53ip78SBrQRCF5n4W7CuUo/Dv8Fu+HNo3d8VTcBa?=
 =?us-ascii?Q?2LPiIhV/ngSnmZlhhFjBXMOIgfQAGOk9eHHFredI4bj5FJOpJCa8NazIRRNb?=
 =?us-ascii?Q?CeOGKVHDdT6kSk9GqqPZZWfQn9fPevbVBIA6IQCfpqYHcUxJpIKOHEz6RIPS?=
 =?us-ascii?Q?i2pj3c95YEZLBQzX1aO3lgQdzf1v8NIwa2UoYVQRUGlm12ACipOvn/w9pyZX?=
 =?us-ascii?Q?pHqkfUCRclxwQVJoZMlFyvEWh4n0+TY9jNja7B+JWbtHGxkZNF7exq94fz8J?=
 =?us-ascii?Q?Zqu8X+XZyfGFCWAiWIBdo3hgYGnwMHE/ZgUTRj98r5Qs0nvgZRjxde0qPINW?=
 =?us-ascii?Q?auAy6OxXAl/egmxiY9+Ir25KrOJ1q6rmwJBjBb5JK37ZViQmHI2pdqfmrDTV?=
 =?us-ascii?Q?ipsRPr4A2rbXq1cn/8E8MHYVH89cVJZSTId284cP999ZcU9yXAPjEbIqMKcX?=
 =?us-ascii?Q?dcTw7AEiiEIWBH7cwUtV4+RoU/KON9I7GumldujNYssX/neiVNhJe03jIBvO?=
 =?us-ascii?Q?rcJ8rhX0QQtDUXmy2Sf0chlPrhcyZARYQSmDIreFrzcJAH3hgyy7/3crRMIg?=
 =?us-ascii?Q?F9h6WdOq45H1SP/5r6ykZu5A2RRYhorAUJeJDX08xqU2RUOCApQr/TpEFIe8?=
 =?us-ascii?Q?sb528iyMCkRJVvpWhCIX5iTu/zxQLYkRn3SxrR5c2HkjFL9Lq1d6rA7fjpw3?=
 =?us-ascii?Q?WrgYrhbTnBY5pVIszE3PeV4S8m6vrIlACZrm8ZfJ8gVeX3KGfGogaS23BsY7?=
 =?us-ascii?Q?+rg6xWrdrJvJDhtIRlu1cMQG39NIhNvItY4DaxCdE1bjQK716C2BuUaHqsCs?=
 =?us-ascii?Q?kLYVGUwHQKUopJr4oNnY/z7/W6QoCdwW4qBENN0tKgdJuNpAe2ry10xlQHRG?=
 =?us-ascii?Q?nS3VpE2153mBolvchUCsiN+meWquSg4nmDB/WrtYOcozTYNR8Q6SF6NJ0L6C?=
 =?us-ascii?Q?xw7gADqVBQTpwVIyBC3xm0wHDdbnuVZ2itNm66QZ8zhQ9pUGGVi9hhD9gz7B?=
 =?us-ascii?Q?K19zP8UFalPQDICdQ7MCgxdNLxC9RPofi/vzl4hrCYB7bADBrAUngIR58E4v?=
 =?us-ascii?Q?JJcmid+ucusJKJFOvTpMvoxddJ5Zaa7VYvp8SJLm2dXZ0Jsrvvs7BvuhAMOS?=
 =?us-ascii?Q?Rp0a8GiFM+0RwfdrbPkp5AoO7Yhx/ZBJeueJBALTzMdneo8tvLlnGDcbayVc?=
 =?us-ascii?Q?xfsEndskBTxuY/SrtMzBj3LLaushpR5Q+uxqjFPzUffjaPz9C9Z+Qo861rTZ?=
 =?us-ascii?Q?jSdjMbQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jEEFVqcsM85UJAYuzsLp5oWc7YvM6vgFOghT7NUqVnF6r9y4COgxj56m2ipU?=
 =?us-ascii?Q?3AlD/4pCcOqUCvcSHM7ot95FUAEGPYJAz+pxFLjFAxzs9MTBB5AWqYePu34a?=
 =?us-ascii?Q?BR9gng5DZ+VfCGa5aQ0HIlQ31t7CDDubgwhQBNfoFNNWbaGeGz9NhqIKodcO?=
 =?us-ascii?Q?5vSPWojLvp3T6gdFuPA8sd0iTcb0KJVULNoW4PJKEkj0nVc6tJxLu9LKx/Ka?=
 =?us-ascii?Q?omdn9Zgk7Cwv9vRJ9gfatM8upK9Igoiy8K0Ib8bXm74Dz24RHBenaW3nNO5t?=
 =?us-ascii?Q?ZPBGDdLOrwOCKYJgfIdy17+E9tIIJqLzfENov4OyvAResDFXHOBIMiSHh3ZP?=
 =?us-ascii?Q?WUjWLzHC4D0BMRrbAjgX6pAvN4w9tYLdRo/PtqmED+4ur2gaLRn5TVC04zge?=
 =?us-ascii?Q?ewRAN2+OvvkVLuKqO6vW821otYEL7AgYYSIdZSSJHg43RJFR50H4O27MNK6h?=
 =?us-ascii?Q?ZwY++kOYi6oMOhgHA/DsYa5vN8ZRPxqoQfdm4CJzSDlCgppQKm9gN+ptlpSK?=
 =?us-ascii?Q?U7vhOCEcpz7PreMvu4dM2SaRSVFHNQhoNFpSmev5HWfLSi0HpFDTj6/pl6GN?=
 =?us-ascii?Q?xY2ljsXLFusbIGRYzRjKTGbHaSJLr/ZklRplHRI5zc5cl+4PhNbwLaUxYDqi?=
 =?us-ascii?Q?pacrkEW0C/yvkMqKnUub3MZuIfI2vCCYoQdJATFDm2ftnRmAf9S0O1oLk94y?=
 =?us-ascii?Q?JO0jg/A5W0OBTmjkAYx6tg+Dg+pl76zGsSkO2ALL+orPHpdlnE2b0F7ucWB6?=
 =?us-ascii?Q?EJcEx9cSyg0lgu2S+w4Xd4MybOpLknR+EaqbELoP4niMlxNcUS4LLAXCgQ59?=
 =?us-ascii?Q?zoe8rIoZA5jLkIdQVC1e5IgR87LaBHUULEKYilN7MnlYWhNr80bgDlEZHFzX?=
 =?us-ascii?Q?hMVoVnM0cDtu1rSwIQLs6f6E4O3D0os4pXYVEgygytMTvL1MYE2ZGIopCoPE?=
 =?us-ascii?Q?SxpLBs7l+b6P6x7LRA5NgYsRF0ZFn4CMPYHBbfxZwEHGvCI/qCwawE4v+OJI?=
 =?us-ascii?Q?tnNCMI5yT2ADPEYqsPKkvxyeQHU88WQLzvgxg9hgydua98GanpOBljmc8MEM?=
 =?us-ascii?Q?5qEfsAtRPw3foPdAlvO8tXUDbAwywIzyWBHcLiucUGCkVOUwVHyB2oQnAp1K?=
 =?us-ascii?Q?vzLfq85vqX2i85wDdX1+EkQPkvgtoYeuY4xnilfBylqSTOdNk4hKomArckG+?=
 =?us-ascii?Q?85nxY/xao0znkZYQdUge6BJRVoTJMUpB4h4ruqUd+JhPWmawi/A0vAQdshrM?=
 =?us-ascii?Q?Cb+Osscoutsgns5orDGDxd8KRQMVhGltrcxJu3kJ55uOICb7G/tAlF0htYxE?=
 =?us-ascii?Q?JfDH+yj2vgzVipRP+mYA2a0i5jipN6i8lDLEUDFN243j5DlZr+Go/ZVVHDVV?=
 =?us-ascii?Q?Jc117URgwOgYIpqvIR3iFAQb7melKUTrI9To1LEBDBLVmarUp0S0ELgey1DR?=
 =?us-ascii?Q?dQlhcPdvvrc14ZJqZOdUi9tvq1+URoRIOD3ZSTOx+bBeU2xhz3p2xZj2k2kf?=
 =?us-ascii?Q?TtXS03hQJZSTi7zV5IEHsCt5yv3n8cV5g3kMpg4A1f5T8p4AtKSWtxIcGcUi?=
 =?us-ascii?Q?D/52l0jY+Uq6CbrjsJOauQ3McLLh9StRoIZQRtxNdRSpzDf2ZTjBUMHr18yY?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f248a1f8-6fc4-46aa-e02b-08dcf4efb4ce
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 12:22:34.8290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elCtcTpYzDLlU/4D3Um3KZzw435p/TpHceneILxL4QOE48FmgAVMEjACafV+qbprzMbeYx0zTzwhZrh7SdTc3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11052

This adds support for acquiring linked broadacast transports: Each link
should be acquired separately, unlike unicast.
---
 client/player.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/client/player.c b/client/player.c
index 188378175..81d967a28 100644
--- a/client/player.c
+++ b/client/player.c
@@ -4812,13 +4812,15 @@ static void transport_set_acquiring(GDBusProxy *proxy, bool value)
 
 	ep_set_acquiring(ep, proxy, value);
 
-	link = find_link_by_proxy(proxy);
-	if (link) {
-		ep = find_ep_by_transport(g_dbus_proxy_get_path(link));
-		if (!ep)
-			return;
+	if (!ep->broadcast) {
+		link = find_link_by_proxy(proxy);
+		if (link) {
+			ep = find_ep_by_transport(g_dbus_proxy_get_path(link));
+			if (!ep)
+				return;
 
-		ep_set_acquiring(ep, link, value);
+			ep_set_acquiring(ep, link, value);
+		}
 	}
 }
 
@@ -4919,12 +4921,14 @@ static void transport_acquire(GDBusProxy *proxy, bool prompt)
 	if (!ep || queue_find(ep->acquiring, NULL, proxy))
 		return;
 
-	link = find_link_by_proxy(proxy);
-	if (link) {
-		ep = find_ep_by_transport(g_dbus_proxy_get_path(link));
-		/* if link already acquiring wait it to be complete */
-		if (!ep || queue_find(ep->acquiring, NULL, link))
-			return;
+	if (!ep->broadcast) {
+		link = find_link_by_proxy(proxy);
+		if (link) {
+			ep = find_ep_by_transport(g_dbus_proxy_get_path(link));
+			/* if link already acquiring wait it to be complete */
+			if (!ep || queue_find(ep->acquiring, NULL, link))
+				return;
+		}
 	}
 
 	if (ep->auto_accept || !prompt) {
-- 
2.43.0

