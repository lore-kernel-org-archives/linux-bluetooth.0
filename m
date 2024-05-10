Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2044.outbound.protection.outlook.com [40.107.105.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241DD5E099
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 13:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715348121; cv=fail; b=LmIt0x5r2mL8qoWvh7tpCR6SNLsvPebPj7OIJuwOMFD206V7sEFA+GBQ1kOgkpdDw4uK2TPQTSVSk/toGw/AEenDU/TAfqif5VC8YrO+o4765SlgRzrBDhsu2/OW+g09P5+zCM0Low+BaFdK2YPl/5mJML6Lhs4ocVWQ8nHBf/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715348121; c=relaxed/simple;
	bh=HIjnikaQyznTv9GgqmXIhZSQHzhh4WPxJ0K9UpxYB4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D3BsuwyxR76treI/DwiR2ukTkT4mdk22QSnYsOKTscahaLo0Y9IvXYvExAL8l+JTsVpV++aE7Y0Di7CjTAjc6mWw1qO9L8YLVIeq4eqr4hQyL6vDGyYPo457Leq5A4NQsTsM+7BQZpEOvbZEJYpyNttSjI9xK4EUX4Exu7akrUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OTk2YOh3; arc=fail smtp.client-ip=40.107.105.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OTk2YOh3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8ziXAyEUVYcbKMSuorQEADSgxSwBt3DGeUUVCv4ebmk5TPq3IAVU2XnuivCjldzLQ68W025b1FV6m13+6B1Sbi06ab6qDMhfayG3E2nLV60UhHer2+esSbgIr8yrgCrZheCqa/Nhs+D8GX13Lqf8eSTt9a65P2Z0Rh7XSs2+/g7a6WmQ9QwHdgnzYbFvlsmIFda4+XuJw6w9qZcjxD3peorpa5Nqo2aFxaH1xGNR5C2txg1mqdwRqFeEoFKL+FBxqgnwjoDMULMn9iS7LsM84p1jOxUlUrIwOMW9Q5Ybrl4pRgxSkh/HrApGfe6SBjjBJ44O7Lleq1UsoVyLqtrEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbP9HN7skxzqNB6olgCozr9/Nc/lBFTaZJ2dEFaAfco=;
 b=dIzSv7cMwJNXIctAfK6JO1bY+FVyfY9/8wLuRTuLOXDeE+FBt23GwuqDilneJSYI9iCBiDPkOQ14CN7nhu0Xa0iHsvQuM324sSKk42pLsYLlnb6qgqjyHzmQrAqd8hJ7Gq00oCPvrR9jEcWftm9gxQi+2Iq72mQRMMSreTz/E8CsKg7j/U8u7sjORZesd7D8XCzw/AKvihqJkTudFjxXrcTX/s+dEJVjkH6ur/e141SeTfB6zkGRxjuUI/cU6G1JmsAp4Gkm62WUllrmWcHe08Al4LF0acaZH/XsVy9O49iN/lRUWFmvcXaPLB8NXfMb/gBIlYn1GTWaMOAEBwAofQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbP9HN7skxzqNB6olgCozr9/Nc/lBFTaZJ2dEFaAfco=;
 b=OTk2YOh36eZ19J24drZWHHsq+QIOmNUYOh/x4XkXg/WMflYFiBXHG7M96PJ00qccecPrOvXUGJ/ewAStT/nKGFM1qK4/oB8ZZPpKSDVjs7cV8p8wNkk7UjJFev4hHEKkgeFFKDLgmK+H+yvXXCHbPnkfbtLyFfcKhUam+HM1kyk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by AS8PR04MB9192.eurprd04.prod.outlook.com (2603:10a6:20b:44f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 13:35:10 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::b7d3:ac7a:a87b:5fbd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::b7d3:ac7a:a87b:5fbd%7]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 13:35:10 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ 1/2] shared/bap: Update stream management to avoid PACs
Date: Fri, 10 May 2024 16:35:03 +0300
Message-Id: <20240510133504.26047-2-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240510133504.26047-1-andrei.istodorescu@nxp.com>
References: <20240510133504.26047-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0064.eurprd03.prod.outlook.com (2603:10a6:208::41)
 To AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|AS8PR04MB9192:EE_
X-MS-Office365-Filtering-Correlation-Id: 56c241ae-c295-44ec-c81e-08dc70f6039b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hpw1YYREEXpbfKoc+4E70144xOtuoFg3i4YWn02gjFbh1XEYMVMWMo762/fU?=
 =?us-ascii?Q?v28MCij6VE4NqJ2inWkcQemGdNDNFZz/6WD5+7NfyGrEeRA15i4SU60OhgXY?=
 =?us-ascii?Q?+6jd+5BXwhRu0uL+J+8JZ55bQ4d64IC5q0/fZ+ZNgKLZYNZEaXI1sfimawbk?=
 =?us-ascii?Q?v4EI9iR5ASGxoUaaJvVmpuWP0REXPF2o+HnsmduYwAM+PQeebC04nosGDWxO?=
 =?us-ascii?Q?JX1bqmGvVfSFzbyoIDDwu69RQF8RvRY/Xuzuqzc0tOsWKbhpYpDMnnWg9BWH?=
 =?us-ascii?Q?ULzHW8n3A8ChDorc6f6C7vnnVSshVrXUG0WmoAl3JIqc+4IIkGyx96SsB5XY?=
 =?us-ascii?Q?7DqLjw+vVdYIGeCpCBBRnSb/wIUhPkyCktCTDORISYKIY+cn+rg5XAPFbHrp?=
 =?us-ascii?Q?0//UZ+41Iswb0BvgcxeYEze3Qsf8qoRk6teTM0y+hcjGIXAqUzOQdaPrNVek?=
 =?us-ascii?Q?JXIzXWETfcScR1WLsou7cBlDbsa/lxtcTsmgBkLASEa+lV9G+DRFN9Cz3XVI?=
 =?us-ascii?Q?QQl0fTpC3aE5KyffNw+AK4QXGuw4t9cRUVdbVpZcE/MJRw17eD7JTl7FwRRB?=
 =?us-ascii?Q?hZHG7v2+tUnH16NJgNxtBkKQgsUp5qhmqbHTjgD2hLxB8tJK8aYJrpLpje1G?=
 =?us-ascii?Q?hLFlyspZkuKyLIneMSIFqhkXVMwcVxnFquylkIHBPbBstADjK+N6m65Bz79+?=
 =?us-ascii?Q?KkYCFVoWwwEZgbspg4yvxe3Phv6HJGLSqgmnrNwL2Zmzgz2qVdUe5vPlHJKH?=
 =?us-ascii?Q?pBgzKg9XGZfG88euzQhv6OjlRcip0xJm6TUuZuNnMstn1J0UsB3VaRGr8OPU?=
 =?us-ascii?Q?qK+u8BlGn1gCbilMjDHo3U0JR2/JKL7w4316f1o/mEu89B5xPVbrQ3ExQDIV?=
 =?us-ascii?Q?GF5UgJHnbIMhxupwe2iUaER8ZHVhKF71G0OzqiqRuDKb5+ShKgyH+rV703eU?=
 =?us-ascii?Q?s6Sr25QwSDaPWDtvNY5RJRsPaFxdu3qv2gq6e3CkySBw8xprMTKepKqWfPQX?=
 =?us-ascii?Q?5pvaiRq7o/qUbq43PLHV4kDmK0iT+7uWdOtv1QZb7tluyHirAI4I9MYRcQYn?=
 =?us-ascii?Q?EQmN6v4CP4lPdUWHbYzvFmL8lvHkJPRWuxRg90oC+lW1VWNA+OrB7uf81QS6?=
 =?us-ascii?Q?P53NYB32wBR7QdOFjLOvA7r7n5rEfstlELxhFNf4731HcaIHpl0N1wsRRJAd?=
 =?us-ascii?Q?K2xQwJOv9cQ7rSqUdfjIFQiycq8LcTaPkIo1PM4csNkNfkmb+tZXOImHPA9B?=
 =?us-ascii?Q?ILp8Pqrg0cRbdeTq0oig8vPY74i4uT4/j7UGxohSww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wp932tlVXA5x+KJNVihAQUjq6coQ09M95m2qNYmt/+IWtnUDvZEwR1DO3yPi?=
 =?us-ascii?Q?uN1y3o+Z6A7Wn2V1j6z+tTe0YdsySHet8ALPGqa2To9PsWtZEdA1ZN5P8Z10?=
 =?us-ascii?Q?/7MkGaD9Ih2GJhdYkfZqPWHIMzCkpQer+OQrjyAoohBcQrbzfwVDNPO9Qocp?=
 =?us-ascii?Q?/UYYNAh7PzChOpJc1eGpYWDpAN5f3QSnMHmsYU7krZgTWvpccE5klRXWuKJE?=
 =?us-ascii?Q?9YGbVI2uIsZQT64HEBtFVZnWaAfFkfmtVfNv69yJ5B9/8SBv6r0OuESlMeWP?=
 =?us-ascii?Q?a3nTseUWajvHPz8/bcnFrFx/VZEeExFWfFPHO/PCVHt8rtVATn6a+cZ9QJxa?=
 =?us-ascii?Q?8p7XGa5UBJyZX6gZA4it5fIKwU+vFRI0eYybmRPf+09n6wzmOmZR3lWyTeQ7?=
 =?us-ascii?Q?sAEk+kg4uH/jGqdeQIUfhCFQgJTcRlDd3GxTq0vFeBYLLOKDMSkbCQmCxMXT?=
 =?us-ascii?Q?lxymKTjW0JmtkoGsCdgqUQVPN3dSDv8r3IMK1tfP911LMCK9qPb8LJamcAGR?=
 =?us-ascii?Q?gnENNDzf+DxYyYCPvFQhbwggGBRxQ09Ov63GtzhS4ZbDHmFA4glRzq5v5UqE?=
 =?us-ascii?Q?SVDfQ7gx8mBT8iR+n53cryFXUAOOo1YaB1qpSTv5ika1eW7LrNW6LUU+qzf3?=
 =?us-ascii?Q?xkRL5kZnGLGHbDdXvcp1ihZlH40Ip/0f9Q5I+fVUWpwaqh9evFdt1V9NKuc1?=
 =?us-ascii?Q?qf01Im8d1EJKBtj349lt5mNeQU0dnYwjT+aO9Mc5xtHaXnpvAjMWO2ewzlAl?=
 =?us-ascii?Q?UtqvrKElJBH2sm/Y+gifjGHT2pyCGCgYesklGAhdmayVfaNR0ot/kBKLcpME?=
 =?us-ascii?Q?7aC60ib0/xVmY2yiDdGvcFmqsPy0ccAw5AQUIXLss4iYcRYyFNdYskyPayMG?=
 =?us-ascii?Q?pFASoDiZKhUYl3ObpUxb6k6wa2J+UQ6S7PPg/IuKuj3zBybvejPnL8ZPSLuq?=
 =?us-ascii?Q?kbsJBL4dPFllSECz+2BTkmtaKKnkiEnGm0hEITK3Pi3q7nm+nATSrELuY4tG?=
 =?us-ascii?Q?RZ7af1WxrYaI9y43NeHiMSvfHCz855G/ePUfdmQdY8OJujmysSJUhGgf9y/c?=
 =?us-ascii?Q?NxAqlm9AjgAAB1HfQDJbokB+ljwDP83A5sB5GEA9JlViHJ5FEXAQpqII86N/?=
 =?us-ascii?Q?/EOzmUuDYSQqc9D2+9ZFAwKrGBlOiGkUBA6GnHRryjFio4bWOBP1IVUz3NYj?=
 =?us-ascii?Q?s621GUAHk2IFfa362rZUjOqvh/sZgZTwbKs2XqU4ZkntvCaKC/YVSkBUQftn?=
 =?us-ascii?Q?R5jIRQSgaczMN7o/yt35sHzOm3/ZlSc76YtpiuQKuHPzFhpAY6j6HVTYsmqx?=
 =?us-ascii?Q?ZfJYLwaHSbI+gkjDpfb69ahXOo3bk68ylFjMKe+CM7gr2pHhntoZvyawTKoJ?=
 =?us-ascii?Q?sq8aZh5Po1+gfnP6D9f5dq7x9weFlTPGQiiGVTJkSt3ZHXqcSFrTGoqcW8A5?=
 =?us-ascii?Q?8CgE8OrHoD3rOoRBBeMmHQ1k1dDWtnsqfvPPG5wUovmWZa+q3T/c9w9QRziC?=
 =?us-ascii?Q?ap1FLtxAvf+Objj62Ug/sCdUvJMysm5GjXEduLbdBIBMv06ckYKjCoj5M0So?=
 =?us-ascii?Q?jZ2ItcZNkJwx7h5mtsp+RqSQO2qyq+vPDhNleUZyhRqVbL8tFE/5YJ+Q3mKX?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c241ae-c295-44ec-c81e-08dc70f6039b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 13:35:10.6723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhkTeQ1mYXDaVtx+rcsZk7Bv1P4PEJ9G4wejb8IRURTHLeC/7YYN/HO9Li7TBRa/Es3oC8aG3uioiTQAywbeMOQUikk4owTrmz5cCPHi6Lc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9192

Remove PAC logic for BAP Broadcast Sink stream creation.
---
 src/shared/bap.c | 63 +++++-------------------------------------------
 1 file changed, 6 insertions(+), 57 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 818326f45dd2..ff3e36a6fbc2 100644
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

