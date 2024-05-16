Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD647146A72
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864658; cv=fail; b=W2HR1ssFEQ/JzpUllfLrY33lQRP5Z/O062us5rWCzsli+71Vpz1lFd8TtHU+zsXbsG4fMFWCLXvOvXqg9DVqMUGd4e8PUwm8lbhBdHsXGgMot8HumeD8Zygjduyc+tdPmIzhgi381UQ3fEc/3l52vPMhoxGI7uYEIFBMk/ZkQhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864658; c=relaxed/simple;
	bh=AuXAhhZaUgWTaG4OyyPAY6Q5l1tIdVe0fOq7UlBJdIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jJyuS90sVfKINL52tRKASmOJ5Ta47YcD6VG5VapJHE5sndrHKiEvOjtGKvflVLTOtsiyXErtdnZf/wPTTmRrwgtZbWeyXUbvdkCi2vC1a9FbGsDvUlOCTwqUpzU2lvT0MOXaS7Cdgh6DZd4zEhjXKR/z55qAQ4b0Usvss/B4ePI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ezo5NooO; arc=fail smtp.client-ip=40.107.20.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ezo5NooO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcJZ3YnpSk6OweUYYHPCkicQ+DovzHW5ssYCxus8lzLFoLqTabKSk5ijZEmRGUsFocwF8VzfjOvFnT01U/qe9lNs8UsA6yVQg/3zqxQea1TSAXp+ePSHn/pis0gzBGcv/e6danWkX1lDzIyFZZez0cBSZmfpjZx894oFp9UmtcRbNCOwUb3X5S4VrTvJEvCgZUlhge5fbu50c8u3WOJSgJpkAYHUBi0Z8IJvrn5xbVUbHpUmpkXKJn42GklxsQlRFrM7rzwaw6lus3Cnscgkjz1tJtLcnoQxVF+OugZMU9/6Wwlgg+vF6mp34c7eFTMk98Zhm6EKapzV5rhUDzZDTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3ZkqtllrkAODd7p2UrxVx7FlM4lxG2QgQjtLpurZGI=;
 b=YFkfrsnr5MNcr8/iGprXiavZ3G6O7JM6GTLUv3oaUvogP/BxtKH5me5f8NKd4ctW7idKYntJukm4ggJWbg8bciA51WVDf1cATICJTr/5rLIkLIXi0ariuC/rSXPR6I3vjcjQP4Itdf7RcSAobzrpAYnwE68s927SNao0R+gBzzP6Ai5NwbW6+tSs30O2IXz3mTTMN9ts5jSwsheekjZxqJIQOdfJItrUCl5Lnr/0Dywra9bSpLXxslKXYy7q6vj3zGjyPacZqstoYRq0E3ymheFItg9BcW3UDoxwdsHGoD2vaoGR3XMJJgX9G129HCT8BQaTwjASEZSGb4JplVbgMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3ZkqtllrkAODd7p2UrxVx7FlM4lxG2QgQjtLpurZGI=;
 b=Ezo5NooOrRt5AWBQ2e/J88aGiaId1YuePB1yfuiF9BoJoiVyW4tvF98RFeMulj5yy/QdiXPonRQRF71TqwODseBEAYlzItw2iymo8umO6/UsplrvetDg/xVKGWntRFyxdSiMTDixA6/a7gBAUoEjP2Qsb9Zmu0TXJ027ZHW53lk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by AS8PR04MB8564.eurprd04.prod.outlook.com (2603:10a6:20b:423::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 13:04:09 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::b7d3:ac7a:a87b:5fbd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::b7d3:ac7a:a87b:5fbd%7]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 13:04:05 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v5 1/6] shared/bap: Update stream management to avoid PACs
Date: Thu, 16 May 2024 16:03:55 +0300
Message-Id: <20240516130400.16713-2-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240516130400.16713-1-andrei.istodorescu@nxp.com>
References: <20240516130400.16713-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0053.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::17) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|AS8PR04MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2ed7a6-1f51-4a68-9927-08dc75a8aa7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oC6oZxJvkrFBlZYyR1PzqNgiSz02BWd7ZSE0RMgQK7mvwh9r4ydAdg8dcbP+?=
 =?us-ascii?Q?Y4aSIOBiK8LfycREySUgIuxLZeOEQIQzlo3VUJeujIIquoAeQADVACXhTEyZ?=
 =?us-ascii?Q?t3dD1tBHWBOp7gplaf8S8t+VK2YqTUKkh9roSueSG5c/TmP+JEMo/L6/A3f8?=
 =?us-ascii?Q?+YXJMzmuv8fwHwOlwObEweyQp1HzE9pix+Ack7hnAno2RFWX4S/3t8a8Ldp6?=
 =?us-ascii?Q?HREOJ/U1mTTlmI4+fS7rg1PQ1bOKwl8JK5L9H5vgvcRCAFp45Ih6kSX+Fr+u?=
 =?us-ascii?Q?HH72m1YbDZwy8kfFfGxU80WQxaSo5F67OCYmHrW3bpgVfcS03faI8Z4v/2KZ?=
 =?us-ascii?Q?Sh63qExL2TLP5vPyksKkNKO7xXzs3LxhkqDG7aafcdtqhLI99jqzaRJyXVD4?=
 =?us-ascii?Q?CzjDWX3lqwOAtqBxuS/MgoRjGjv8p9U/3+fPKoKzdBaMDPcUlzg7V7q3Ve4S?=
 =?us-ascii?Q?Z3UPBaUzwpUFWztYQxJV2R3LCPKYDRcqQTknwfthXhQPDQOftlGv1TIvtgvG?=
 =?us-ascii?Q?a0kL5GVEf0+tvLensmbq2WiCx10fgEGLYDGwFJg3x7pLs64ibYDsT/8CYo5q?=
 =?us-ascii?Q?pOf8APNY04Z/dMg1WEEcErlPKLbaRjRIhMPfTFHqzdb8uUekabSPpnOQg99M?=
 =?us-ascii?Q?6p4O/mwF6o/ygzkJC7aMsTGqAJFVYZMks1SYTYff4x14r8OnoMiqgFj5qZ37?=
 =?us-ascii?Q?gjxuMPpNnlT5DikkaWi++QBIchU+WU5qe4Z2RAX/2t1hTUTbRORc1Vlv/Hp/?=
 =?us-ascii?Q?bPKONkFLvZ8UWrR6KJY+73zx89oPwgBAJOIYrCPH84W4J+klqMZcQ8vYBPxH?=
 =?us-ascii?Q?QkG/RCxms3VzbUVgj790YtsyibwrTaLVxc60VxoZU48JsLxrLbgIpa/N7igI?=
 =?us-ascii?Q?0Srkt5rDfAdqpB9PhUd3i6VKIJzNSikHt5sCSzOL5fAkbI17i1JReL/PzlE0?=
 =?us-ascii?Q?k9cFd+lWMIdR4c7xVniS+aJQz4MBn3NW/UzhkP5Y5lMo6dwRD0JhTR9ATfkp?=
 =?us-ascii?Q?aLeOAexTvKSsEznkivj/i+GJgUjsjt+Rh2iY0TZLER+hJqxom7Q3+8/oDK+k?=
 =?us-ascii?Q?WOuzNWYTFTdijkBuQcm1VWWBDptYYw23JZMHDexHu0HwmUXSUoo/2ixC0SEn?=
 =?us-ascii?Q?hZabrE9j+1kyKEFTjKTTUsT9hOFjQyhESg2uyGeIA3QynEaz0JkF+m3cA9Zy?=
 =?us-ascii?Q?s7j+WjbKrcviI8hE5V+iw8HbFdPvV69q1apGdoqOMHUXxF7xGzzgHNQyyuK+?=
 =?us-ascii?Q?kHNKjOIp8xkp8x4SKIqXN0rXEffC0FwgjTUtYt6zOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Exx/buMjhxI0G7b/1zkNGiR1yLmXPjt8HGXJhs1DEW1VeFSb+s+ZQJaCalQF?=
 =?us-ascii?Q?poeziNsNqg2S4NCSuvEs2pQcbukeXn/RvTNDxTSJG8Jiwnsk3M/nsRhHCEgS?=
 =?us-ascii?Q?6RlXWPa2r+4SlTXqdF3T+ZI/EwaFm0CnvBkj/SdysylKoSrcpJr9vFxQGUgh?=
 =?us-ascii?Q?2/FKvNeDYeNlBQE6xETwh860HY4iIztQ/jwSMyYlORHeg1e8yk6VPd4IaxM8?=
 =?us-ascii?Q?FS5PLA4b1uo8oPDp5UeLw66sKJfQEizotcxeNkPS07nu1j38Oef6ctP9dsHq?=
 =?us-ascii?Q?4pe/VbLbgR3Gt1SFp0TT9rpOKrgzJ/G5bf5+1Ks+wlFHSzcEnLaspaoTG1/c?=
 =?us-ascii?Q?nJfThHVgQisFwt+Q49uXhlufLsvy29uE14IK//LYClBskdpjWDje1P7eqypi?=
 =?us-ascii?Q?PD23RmxXxAD7tWxaq7ETB9ZCHUV7nbkTw6ec1VdbYRz5pvfBpvCH8GMYNSuG?=
 =?us-ascii?Q?AFjLKfzopstsQ45pBz2EGn9dHgrIameXjpWS3mhww5rpHtYUsg1nqZVS1Zdf?=
 =?us-ascii?Q?89VZRSZ2HkoeML9UA2Hom+jPheqOVvFHNuWLyDaBSgj1RAouqFi7nE5n3x/V?=
 =?us-ascii?Q?4xoxloB3bHRe/Nyl54+Crb9qesYXlNxETe9X/O0F+AuBmUg77rWa2cRwQMJY?=
 =?us-ascii?Q?biKV5EQmz3pdGfclVGt8NYwdokdYCVHzbE4PnXbuiMmd28gJCH3lcEcQanRC?=
 =?us-ascii?Q?zfvE8GoNSC1WGxqlFDKC2L81qMMEO3C3WWqcyzw9XM9rYEFNMnD+5fSirVcI?=
 =?us-ascii?Q?2ClRJAJfeXCKc1j+8JIo62LcrL7puNQGMWZvFliLEAs7nj92VJY9jKgmT2LZ?=
 =?us-ascii?Q?Icf36ozvzASLtG3fpmk7swGvV0AFgyezRbYkY//GrtYvu48g1509x7BvdYSE?=
 =?us-ascii?Q?/RHx+DnoKnLPJ8o8Ic+DTI5kjXKwVxrlslcpdbLF99mKUgwe9FYUslH7VyLG?=
 =?us-ascii?Q?PGZyVwM1u5VHGdhwsGU9TguRmEFlnHz1caa34EgPv05jx/62R8MypKYBDwb0?=
 =?us-ascii?Q?zwuOl6Y/FC0hpreabW5BwQAQN9WZDDmuSKe5jjSbgxw5DVCEtnri+IEWjNHv?=
 =?us-ascii?Q?8cmNhUpNcSRZJNDmYltJKtdZVLGoCdjQVwZBrcEZwuK1xv0ecx2y2KIwBRuD?=
 =?us-ascii?Q?1pFDInDbpiwuXUFM1XDfjCvdSZ0ZpVl5I3Dx1evPTfvgdsYS5RUyQBFj6v8A?=
 =?us-ascii?Q?EAPy4kZPPENdHRXxj59MavkbkNODcZ4k8tBIdWGoRDZ1mTgZ4hTVFKkP/AxP?=
 =?us-ascii?Q?pQF97QS2CQQkAN2bo+m/j/h+l32enhrJsfMt6YVVMQa/yJQVOaTypV+rbLk+?=
 =?us-ascii?Q?FXY/qgDCx5rxWh2Kxf/+/8e6bEJSxFU3eGJv5bMD0CuFu775OZL8oP/rBDdT?=
 =?us-ascii?Q?JlcjEysFbAOObpbuwNpYnS9/OBdLCQDj2fRsERSBrZqwgSuV4roe9nFeABvF?=
 =?us-ascii?Q?6WnG8vTZsHQz5szA/gW+J1cuvRz9GspUV5cksRL0HsuD2DpT3oMEpTpCxeiY?=
 =?us-ascii?Q?alMvbveMZ9DEVmn7Kv+paYMg8US4UjCpohEjcQCSO5fD7sf6hNxdZ4pNDBfA?=
 =?us-ascii?Q?ybNKBjZjA3CQWbTphW7/Ux/v/zkHAaBAsIxwjv1GI+elnHGHwWDp6QTw2FKI?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2ed7a6-1f51-4a68-9927-08dc75a8aa7a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 13:04:05.6077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zP9LwAQfwUUJsh31JwyvX8V01benjstKJ75g1UXZKSFeClODl+cisygxMt9jPJdPstksm7c8bmnhxnxIsJ08ru191CCmjQ7CuW10rjPpusE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8564

Remove PAC logic for BAP Broadcast Sink stream creation.
---
 src/shared/bap.c | 63 +++++-------------------------------------------
 1 file changed, 6 insertions(+), 57 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 1316d7c73d02..919ecbb6a016 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2005,10 +2005,7 @@ static unsigned int bap_bcast_enable(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
-	if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
-		stream_set_state(stream, BT_BAP_STREAM_STATE_STREAMING);
-	else
-		stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
+	stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
 
 	return 1;
 }
@@ -5287,7 +5284,6 @@ void bt_bap_cancel_select(struct bt_bap_pac *lpac, bt_bap_pac_select_t func,
 
 static struct bt_bap_stream *bap_bcast_stream_new(struct bt_bap *bap,
 					struct bt_bap_pac *lpac,
-					struct bt_bap_pac *rpac,
 					struct bt_bap_qos *pqos,
 					struct iovec *data)
 {
@@ -5298,71 +5294,24 @@ static struct bt_bap_stream *bap_bcast_stream_new(struct bt_bap *bap,
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
 
-	match.lpac = lpac;
-	match.rpac = rpac;
-
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
@@ -5415,7 +5364,7 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 	if (bt_bap_get_att(bap))
 		return bap_ucast_stream_new(bap, lpac, rpac, pqos, data);
 
-	return bap_bcast_stream_new(bap, lpac, rpac, pqos, data);
+	return bap_bcast_stream_new(bap, lpac, pqos, data);
 }
 
 struct bt_bap *bt_bap_stream_get_session(struct bt_bap_stream *stream)
-- 
2.40.1

