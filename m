Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFCF215F49
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734705107; cv=fail; b=g1Ew7b2AFZNXQufWuVuWYv4km2xqgMALAd1F+Tfj+UHObIYOSSOuJ4r5gYfC5JSJgAGxJgubL83hiwGVk5KeTplsHWvW+8MsYLEJbPchDiztqCEAuNBFYxSf90sLZTNeW0Rv845T6h3bPA/ssb6qanrbCKl1QNfz+LejMWpMza8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734705107; c=relaxed/simple;
	bh=FCaL0szTL7jwDDxr9vd4ZeDd8vmCQNA9OXrxuTWGfTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t2byjWPmOQycNRtkmH1O8Rnx7/jSFZsngm9DnQcfEsGH5D0iKMvQ+dOFn1qk934zo6YWLmOvsrO6Nt6lotOysX1W93M1I0mVQnS60fdg6P16+8nzw9nbC5gUD05o/B4w6FDeGeSfEo/UvmKrlqY10H5zBF+maRnzoNkme/dNcZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JhLq1w4A; arc=fail smtp.client-ip=40.107.22.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JhLq1w4A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6rS8RTKOwxt1sqn9F2jcMv00ItcAa8sAHn2FeptKa73KpyZfHRqqdyPwdF816qf19bUe9c0KJ8tAv0yz1scOCALfNpCQq78p1KGjXQO2xxO+FNmHF0g13hYSinTkY5X52fOdE2phjvwvgAgZ3CV60EmfV4VI0yQqaYIsaoMlzT0INZMIW8x253XEfmAH45HHBO987O1+ajlJB9oO7kWxOUmSQr7leuTH0spSMtxCbjqXTQzrc2YHN8i9SxnUQy/4meuPLrwTEUdw8gRGYwT+PxT/aoO5hZs4CrnIzBStA03F/hDAdsnm+XnYBh3vQi7qGaY6Tm8al6NNuImqjZafg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sxb/OyCrhXCfuKRbfNkJV2CC6hrj8X+F6xviD1AG8C4=;
 b=dyXbJol+ez7z88+3+hXWaVtLPom0zrDQcjSDdw+NV6T3ucYB17IiglprGfT++10QRbwsYYzKp16PSy/bSjRQT2G0TyrUyx3orCHw2oBWrRayTO7NGcBb952vMdo3RhRG8Q5klEpO3eJtfzmrM9yPhjYBk0SULxQJL+vLg4njlkIaMoM76X80z9MOrPO1kRqQoc/FZhNu3unBqOP6OKXjU5ks8EhR/tDWfjtrm20bZ2Bg/AxYTyODErs2305rc2yqASwoOJU91PRHhQtb4tksxCvxvvblnJ2nMyy9BRyrfPU6D/fuL+GUC2cb3ofphNlbBgvGOqq7oDeK8cw1LuQcFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sxb/OyCrhXCfuKRbfNkJV2CC6hrj8X+F6xviD1AG8C4=;
 b=JhLq1w4A0ZEfcHT8N35hfiWs2xX8g+Tam1KMAYEXRyGSRR6vf0gjatuH19SZ6Nc0LabZopdPin7ttRGp00oLOVhANDegGUpbAx64x5FOa0Sg6oWIIuqYvHyDNjjt1qjOXzo3qBk+MEaAVJXuV6g0rIFd9eHX05KH6Q29uDXjadwHNoCNmYi5q+G20LpeGqc3Dvr9y9GkegJlgEmGWNu+M5/P0XbpNKklCxxyT6oSCb+2h8t8vNAXs/Pal9kjBPrTXYJRYNbzvkakA5EmqXr8RfI9AnZq6ieHND42qx8jDfyKKYsPdfrRwyFoc1so+pfjdf8BYaa5AV5m+a6jRBYY2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GV1PR04MB10105.eurprd04.prod.outlook.com (2603:10a6:150:1a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Fri, 20 Dec
 2024 14:31:42 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 14:31:41 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 6/6] bass: Handle Modify Source opcode
Date: Fri, 20 Dec 2024 16:31:06 +0200
Message-ID: <20241220143106.27443-7-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220143106.27443-1-iulia.tanasescu@nxp.com>
References: <20241220143106.27443-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0129.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::26) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GV1PR04MB10105:EE_
X-MS-Office365-Filtering-Correlation-Id: efe1ff89-de9d-44d9-d6ba-08dd21030570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PYs1IvfSUwlO1Q/Z8nXW+FK+D/m4s6RILwYDR1pXRgl1M6CKFtCi2pAAlJ+l?=
 =?us-ascii?Q?dD20ayPwfjUyOgX4xuDm7o/4GfGxjrs7VgcHCBeVIKoN5TlySUpIC+3BBpS5?=
 =?us-ascii?Q?6MJx2RjqK5607WAnu/J+bHmgoItYqWdwVA9M/R41PaupqlwrQ+JQuBJUqrnM?=
 =?us-ascii?Q?vl4gDU0jTuper2Ww548BJ18s9QNho4dmF2upCYjw0OLA5DCFISfmFhrPnh6n?=
 =?us-ascii?Q?gwUV7bGegzP32ggnMSrWQNypgRioS8i7Ta7mkKf3FdDYR3BaWf6pMeBRZbQt?=
 =?us-ascii?Q?VzD14EbrXQTXu1zyZejtjynFtytDMnWPzAv2WYAkYcvcSEI3QR6wiHtMtw7c?=
 =?us-ascii?Q?Hn3rKsFvA1MBc9HL3/tCqSV57pwvYoBPrdXNGgpZUfw9wipMq4I3RXxfoNH3?=
 =?us-ascii?Q?C0TmuOZgVe29n3mtjGeBYuHGyUWQwEwt6LUAUtx9d/wD+bRfrWYCkl5Eyb3V?=
 =?us-ascii?Q?wjAzHt7M4XtcAWTOHRlvR8xY4BMUpNZrYlrMFpyi5muCvWt7GuPIJ2acO7O7?=
 =?us-ascii?Q?axcFuSZDAmQZ7jAubJICwZX6N9uLMmKmtzVRqr35DdUCGRzIumSUluCFeLBE?=
 =?us-ascii?Q?tORHqfjfUHlc3byWqoKPUa4Iox9K/1ntuQR9Qkf8OvVkgIx19jCnEXPpnvqF?=
 =?us-ascii?Q?oeGf/tAtPE6T2xaD/UAOYoFZFdh2PtuwXLrdupdfTdszD3SzJzioGpsigc4U?=
 =?us-ascii?Q?/7YeYETL+FFh9ULr4Fp9PYqlD7CO9e6TY5vuT8zKxH4t8ZiIaQ7VzUJH/QV4?=
 =?us-ascii?Q?Mb3NqAc6ndrUfR/w1+UPHfcrLQFlXMlNPNLbDri5/prkg9YdBqqtSkyiCuI+?=
 =?us-ascii?Q?ORsYJ50NZ3lunRbX/maKSz2qsQ6pc8SYwA7CQWXSdyxyVH4s22j7TZdj6592?=
 =?us-ascii?Q?b+niDmIz1FAEQlct8Qmfwszmqm4cWfVpPHJ21udTtLuzNhNhGFsX5npVXF3o?=
 =?us-ascii?Q?3ewNzC/WTjGBqBXd3xVBJMlP07+gfCJZWFJ4cOHnMES2HLZANZJWgqedIr2g?=
 =?us-ascii?Q?PALDlLXhp3csPbRrPV2tNRfbPHcgz+MRlxfrwc6mtVETDalEXHE8Ldogn+rj?=
 =?us-ascii?Q?aWD3ddYq6Cao5rALsOPq6y8ZacGcOp409HrxA0bYjwq2zOSLXGYN7Epy4CdF?=
 =?us-ascii?Q?DUkQzIJ9jy7E74CM2jvc3ypAxVirupk3bpUNHtNfUV7g/wgfTLbbVdi6vmFk?=
 =?us-ascii?Q?Ok6Xr3zsHR1VzQUzhnrLODiN250MbHair+fohfZZQ6gePAdM9+O4CVRDz7I/?=
 =?us-ascii?Q?E2HDqR7UtIi29fj0rUsDC2PGX/TsSUrEZap5+dUZ0Ny7OxrMT6DD7k6LZFRG?=
 =?us-ascii?Q?3orypE9zed1W5T8vV05ixWpIWqEBAVAC6v3skHPJOD5GSEFWEeUUXpMguNyh?=
 =?us-ascii?Q?yN6GKebYpleIi2BQ31UjUqhJyoDK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d2zMuAvhCjfDoS/cD781MIDYJ9eAmOAwMae1HAKLQ1eaNMuW/BHooi8jvoPU?=
 =?us-ascii?Q?ljGXc9oUb5eDSg3IjkUQSqd3r3GY0O9V8dzX4ORSePz3Ld6Ca+7bH9hIbVYA?=
 =?us-ascii?Q?Ccd7Bpo6Clmg/S0L0vnd/JDPhN8u7hSi2WHMxUkYaL1z5jLzzo+s6k6Zy/Tq?=
 =?us-ascii?Q?7kJEpvr4JBZEz3iyWIMrNMEs+mCk+U5bOZ9pQnfQBFBhmFiIKxGCzhuxYl41?=
 =?us-ascii?Q?7mRVP2DtGrKqJxzCFEgrkkTLRCtJ4k76YPsxAQBL5q9LPXfZQNU4nnBjE+fO?=
 =?us-ascii?Q?FB/SvklOixIjyG7eV4VZHZzNsc0/9/8Eywm3JKVBkV4IRFXi9e2aZl2jrVZv?=
 =?us-ascii?Q?g3URVI80lVtrARiPs17omZnb0df09zS1uC8BMoYj1amApq3AUJdsDyyNiUyw?=
 =?us-ascii?Q?kfSswbZF3aCZiFcF8yvs2ApNU4Opc6VQ748PTFX/5cR2PHoVTgJYNnUoShwD?=
 =?us-ascii?Q?YBPqoPwba/MbpW2/qYwMvuo9vyaWvPBItsyBOkxeMmh4BQRpcLbJbZKbC5V2?=
 =?us-ascii?Q?kCYZXy4nOWKX9/ZjOOjj+AMqnpTvqX8npl9SBXkLwNl6wNPJtE/rBBquujZ2?=
 =?us-ascii?Q?d0+0ohRwtPtYUATtBjIKNhphSVlFHUCSZW1TAI/63d2B93xHVZ4nh8AoTBJn?=
 =?us-ascii?Q?6VYvFK/17n2gDx33EChbXB6V1E0qd83IuaYmeGNJ4fUURXJrZdGFNKbU9jjd?=
 =?us-ascii?Q?KI2oNoT1HWMiqMSF7+8Gw/UjyJk5+PAnbOhPGmNTo+BCJ5Rx0nHcLo2wW1Vm?=
 =?us-ascii?Q?OSlvmTl2ebBEbssUps6AKcPHX3Kofe28lUlQd4v60DYqFwCpKPgdFnsOtYO9?=
 =?us-ascii?Q?nuBzMDnRv6Pib+8PYo42u6tvG5vSh3V6a5k8n0cDIjg5okG7xZ3VR+bNlEFj?=
 =?us-ascii?Q?ZX5ePVRrn+1dcBmPrqdm1LJqinB6XcrN/EJjiQURD7YwL41Mo6ZbbmeZ5Y0o?=
 =?us-ascii?Q?hU5VOGRn75x6A9xDzXzR5/986XxUsAm/FjnD92tQTRRf+0u3B5NHoifqiMgZ?=
 =?us-ascii?Q?zBBNlDrPnW/jISg1TnvbkB1cKiYhkxjuBE5ZlP1FHWbRXrKl7gtWiJDZccDY?=
 =?us-ascii?Q?MQ55pLPogYq/yvTBJ5HWanio3BHaI+Si6qNJ4E86CdEXAOTGuqM1bz6SBExu?=
 =?us-ascii?Q?LvTfeoknFtXet2yOzbCf0Ywx+VCcd0hdb+lRCmoDjob709D9uy5ulT29RbX2?=
 =?us-ascii?Q?g4pCMaGWlZTBJ/Nw3JODbfDG1U9uvFfHDzFfo0r48Qt8/fg0zdQnARtyoN4Y?=
 =?us-ascii?Q?RS2kQniP3J/JQrPxD5+nUid8eOXb8VT9yr18ieSF0xNYER16KSVEl0VeYvZZ?=
 =?us-ascii?Q?zcEmTn+U1TqsxknJxeMzhjG94yiZ4bAJd+tdrNL3c/sjThpgf2wO3GVzJiO8?=
 =?us-ascii?Q?PuHJeUzUSgMj/o3SFuaQZwWLYded5TKSSmuDo4gfyXu+KqdKL5f/Mje5X79f?=
 =?us-ascii?Q?AvjicUcg0mYqmHRHK1vdR+pR+iDn4wvrcc4i4NVYqIbUbmTSDM4Emc0JhwPQ?=
 =?us-ascii?Q?ey/YU/mUcxyJwKUPFBYNTiPCZhFbjAwYT4jiXOGQegU3hqYNPXVs/c5HTNtt?=
 =?us-ascii?Q?aGGRpOE2n6Jd7BV6hjOx7oOvQZ/WmYS4j826yiPc9Z4saWb7MYmk3NWDPQFz?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe1ff89-de9d-44d9-d6ba-08dd21030570
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 14:31:41.8624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: teCHnr6nWsTGBeGdZWN0Zzq5p7b8kf2Z2fbSpZ2fwsp/pVRq4W+xW6hdAYwj+mlWUYCSO5TNT5CCHjoEhMev1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10105

This adds a handler for the Modify Source opcode.

A Broadcast Assistant might write the Modify Source opcode to request
the Scan Delegator to terminate or establish sync with some BISes.

If required to terminate sync with specific BISes, the Scan Delegator
must unlink and release the streams, leaving the others active. If
required to sync to a new BIS, the Scan Delegator must redo BIG sync
with a new array of BIS indeces. All active streams must be unlinked
and disabled, and the new stream should be configured. Then, the
user can select and acquire the streams, which will recreate the ios.
---
 profiles/audio/bass.c | 146 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 145 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 0904748a2..3a37d6711 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -335,6 +335,8 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 	GError *gerr = NULL;
 	struct bt_bap_qos *bap_qos = bt_bap_stream_get_qos(stream);
 	struct bt_iso_qos qos;
+	struct bass_setup *setup = queue_find(dg->setups,
+				match_setup_stream, stream);
 
 	if (dg->bap != bap)
 		return;
@@ -392,6 +394,10 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 			 */
 			bt_bass_clear_bis_sync(dg->src, bis);
 		break;
+	case BT_BAP_STREAM_STATE_IDLE:
+		bt_bass_clear_bis_sync(dg->src, bis);
+		setup->stream = NULL;
+		break;
 	}
 }
 
@@ -417,6 +423,44 @@ static void setup_configure_stream(struct bass_setup *setup)
 			NULL, NULL);
 }
 
+static void stream_unlink(void *data, void *user_data)
+{
+	struct bt_bap_stream *link = data;
+	struct bt_bap_stream *stream = user_data;
+
+	bt_bap_stream_io_unlink(link, stream);
+}
+
+static void bass_remove_bis(struct bass_setup *setup)
+{
+	struct queue *links = bt_bap_stream_io_get_links(setup->stream);
+
+	queue_foreach(links, stream_unlink, setup->stream);
+	bt_bap_stream_release(setup->stream, NULL, NULL);
+}
+
+static void setup_disable_streaming(void *data, void *user_data)
+{
+	struct bass_setup *setup = data;
+	struct queue *links = bt_bap_stream_io_get_links(setup->stream);
+
+	if (!setup->stream)
+		return;
+
+	if (bt_bap_stream_get_state(setup->stream) !=
+				BT_BAP_STREAM_STATE_STREAMING)
+		return;
+
+	queue_foreach(links, stream_unlink, setup->stream);
+	bt_bap_stream_disable(setup->stream, false, NULL, NULL);
+}
+
+static void bass_add_bis(struct bass_setup *setup)
+{
+	queue_foreach(setup->dg->setups, setup_disable_streaming, NULL);
+	setup_configure_stream(setup);
+}
+
 static void bis_handler(uint8_t bis, uint8_t sgrp, struct iovec *caps,
 	struct iovec *meta, struct bt_bap_qos *qos, void *user_data)
 {
@@ -566,8 +610,13 @@ static void setup_free(void *data)
 	util_iov_free(setup->meta, 1);
 	util_iov_free(setup->config, 1);
 
-	bt_bass_clear_bis_sync(setup->dg->src,
+	if (setup->stream) {
+		uint8_t state = bt_bap_stream_get_state(setup->stream);
+
+		if (state == BT_BAP_STREAM_STATE_STREAMING)
+			bt_bass_clear_bis_sync(setup->dg->src,
 					stream_get_bis(setup->stream));
+	}
 }
 
 bool bass_bcast_remove(struct btd_device *device)
@@ -1231,6 +1280,98 @@ static int handle_set_bcode_req(struct bt_bcast_src *bcast_src,
 	return 0;
 }
 
+static bool setup_match_bis(const void *data, const void *match_data)
+{
+	const struct bass_setup *setup = data;
+	const int bis =  PTR_TO_INT(match_data);
+
+	return setup->bis == bis;
+}
+
+static void bass_update_bis_sync(struct bass_delegator *dg,
+				struct bt_bcast_src *bcast_src)
+{
+	for (int bis = 1; bis < ISO_MAX_NUM_BIS; bis++) {
+		struct bass_setup *setup = queue_find(dg->setups,
+				setup_match_bis, INT_TO_PTR(bis));
+		uint8_t state;
+
+		if (!setup)
+			continue;
+
+		state = bt_bap_stream_get_state(setup->stream);
+
+		if (!setup->stream && bt_bass_check_bis(bcast_src, bis))
+			bass_add_bis(setup);
+		else if (setup->stream &&
+				state == BT_BAP_STREAM_STATE_STREAMING &&
+				!bt_bass_check_bis(bcast_src, bis))
+			bass_remove_bis(setup);
+	}
+}
+
+static int handle_mod_src_req(struct bt_bcast_src *bcast_src,
+			struct bt_bass_mod_src_params *params,
+			struct bass_data *data)
+{
+	struct bass_delegator *dg;
+	uint8_t sync_state;
+	int err = 0;
+
+	DBG("");
+
+	dg = queue_find(delegators, delegator_match_src, bcast_src);
+	if (!dg)
+		return -EINVAL;
+
+	err = bt_bass_get_pa_sync(bcast_src, &sync_state);
+	if (err)
+		return err;
+
+	switch (sync_state) {
+	case BT_BASS_SYNCHRONIZED_TO_PA:
+		if (params->pa_sync == PA_SYNC_NO_SYNC) {
+			g_io_channel_shutdown(dg->io, TRUE, NULL);
+			g_io_channel_unref(dg->io);
+			dg->io = NULL;
+
+			bt_bass_set_pa_sync(dg->src,
+				BT_BASS_NOT_SYNCHRONIZED_TO_PA);
+		} else {
+			bass_update_bis_sync(dg, bcast_src);
+		}
+		break;
+	case BT_BASS_NOT_SYNCHRONIZED_TO_PA:
+		if (params->pa_sync == PA_SYNC_NO_PAST) {
+			struct btd_adapter *adapter =
+					device_get_adapter(dg->device);
+			GError *err = NULL;
+
+			dg->io = bt_io_listen(NULL, confirm_cb, dg,
+				NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR,
+				btd_adapter_get_address(adapter),
+				BT_IO_OPT_SOURCE_TYPE,
+				btd_adapter_get_address_type(adapter),
+				BT_IO_OPT_DEST_BDADDR,
+				device_get_address(dg->device),
+				BT_IO_OPT_DEST_TYPE,
+				btd_device_get_bdaddr_type(dg->device),
+				BT_IO_OPT_MODE, BT_IO_MODE_ISO,
+				BT_IO_OPT_QOS, &bap_sink_pa_qos,
+				BT_IO_OPT_INVALID);
+			if (!dg->io) {
+				error("%s", err->message);
+				g_error_free(err);
+			}
+		}
+
+		break;
+	}
+
+	return 0;
+}
+
 static int cp_handler(struct bt_bcast_src *bcast_src, uint8_t op, void *params,
 		void *user_data)
 {
@@ -1244,6 +1385,9 @@ static int cp_handler(struct bt_bcast_src *bcast_src, uint8_t op, void *params,
 	case BT_BASS_SET_BCAST_CODE:
 		err = handle_set_bcode_req(bcast_src, params, data);
 		break;
+	case BT_BASS_MOD_SRC:
+		err = handle_mod_src_req(bcast_src, params, data);
+		break;
 	}
 
 	return err;
-- 
2.43.0

