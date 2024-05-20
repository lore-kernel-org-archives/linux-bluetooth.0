Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2045.outbound.protection.outlook.com [40.107.104.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F1613776D
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716222492; cv=fail; b=suVhyS7raHqMVPlW1Plmj8Zf6vJeWAvQKjK8ja1W9GDCWj5c/yPJUEafIKvDNlDrmJOtouhra3xXl1PFwwpsTtKR+vENdulTn92pjogf6AgFH+vBne/FMvb7ZT2i7n8koIqmB9mmxmZ3jy4pTeIdW0CzEOnuTPsFDvKeGf1XrOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716222492; c=relaxed/simple;
	bh=ToP/O856QOj6gcvoMgFGX5N1I5bvOWQGRvGlq9Fx8+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m0drKKsHJJwrb0JsmJvalysDPvy4S4cfKKDrUJJbI3a0LlEc9ZPBeX0OmfNz6VrewFmSSf+ohxEa/FkHRzCzg3fX5+ZmPo9DLqYXQf/UfGHkuU9dRywmYleixU/Pu2LAdsgRBQ1e66lvCMQIu+/fTWCvsuVHr2CQ38ezLA5TR60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cPBZcMlW; arc=fail smtp.client-ip=40.107.104.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cPBZcMlW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4U9NUH84Go5aVDsKoG+UiqxxRWhRs+DmAnNbN+BN0QujddQR39CJ+0YTKHEji6rZFpH7dqEHzlXhTfWp5RhKvUa5joX3p2aKsbAMqGWGgaLFR4LlOxhXA2rAORwMKUJSGjr5dVBxVMonKWhBV/bwAZ2d6donvUbcOwTim1hiK+Y0b2G+4Lk5+WxQ72NDTyCB0ajo9fD40l4z5FuUGp2e6mWRbBBo3lvGywfuN0zGSQwWzG804zOfLFOPVU44HCaE+GE6hNvTryp0OUtbOf7+Q1HluKi+oPT24Mgtb3/7WJrJhmZF1BoObhs7yRnzdH9K3B3Etf2zMGpddzfbpa0Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOiuB0RXLR6NGYM+hO8ZJeXrMvzNZaU0T35sjPoztRk=;
 b=SF393t3yjHjGUUohC8YOvh5icYNcsIIfK8TXcpKaMvsTnCst0uC1hwWmv9eUsoT9NKmkPiYeYe44YQsTfkxr6ql8XAo9DgPagOgNvd3Av50KQQhG5lGmFBys+a+CE+XLc36XnMIMk6RGnssafYWHYtHujlW2xP9QhAex0EsJscYG5lNMcvjQhGHtv6ZSrmRp8WkyR2OQC92gXth3jZynMntTNatLb+n1iQGgNY1SfUWRb830ugi4kks6SkyLea0i4rUSXLFKNPOjqEKGxTGtrQPbwR8JTDn8IEJzQb+VthCXVp4BMaMOVzV9YGbWPmT266SmIlz6LxI2MZgJVkGl3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOiuB0RXLR6NGYM+hO8ZJeXrMvzNZaU0T35sjPoztRk=;
 b=cPBZcMlWI2fAjzYhBH5R+V1ZpoX5FOzIxFNiLCFxiuRffKd3IsalY4Uc9RK0heGm0acpBpEVS9XChwWk/VWdvpu0rEyHfxG1iTi+/1Jh/uET28YUEc/ehq0ku0BqQSc6H84Tf0KldSe4IXOGybh7xmF1F1zhMQ/TCd1KcGAbxgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 16:28:08 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::81ed:c7d0:c2f6:8ce4]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::81ed:c7d0:c2f6:8ce4%7]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 16:28:08 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 2/2] bap: Update BAP Broadcast Source state machine states
Date: Mon, 20 May 2024 19:27:57 +0300
Message-Id: <20240520162757.78187-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240520162757.78187-1-silviu.barbulescu@nxp.com>
References: <20240520162757.78187-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0054.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::18) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AS4PR04MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: b34256f0-cfa9-47c3-9a6a-08dc78e9d553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p7VbS+KyY94XezsFvsccxq5aef2PSYfqNoz9Qos32Tj+MBHKzg0Iia68rXyi?=
 =?us-ascii?Q?e/Vk5qkdL2gAL0HKsImSFC+KoekiNuOedm6VsP8SrJpLs0Vg7xXXLa8cEM2S?=
 =?us-ascii?Q?WuHwUSjM411JLhD6fumKQbTeyECU4P/gkVt2U6//H+qIKTdq7SdNynjDJirh?=
 =?us-ascii?Q?WD8IVGLMQHW7FnMklJeHePA0pQqCF2hzuDq69vs1L1mjILJhuGZHEfMqtjCO?=
 =?us-ascii?Q?OdpuDnqWNfa/4bqATFmstGHALTFph8V2GZbnlz07twCRK7XL4/fIaoZPl6iN?=
 =?us-ascii?Q?wgMaPWZEOVdPGfskolrttidhe74sKjX1pFQ/JJ6iNb3iKFGPj1T6q7fJGFls?=
 =?us-ascii?Q?Je3Fj2nEA7sBB+gTICCNkTkcyviLtJjcyzR9v/RnD2FAsEqNpatDP707TZYq?=
 =?us-ascii?Q?vv3SdU1nIibaRd4fjFwAxy1+r9nn6liRVCgYwVS652HSf4qu+3vIAWkub0jU?=
 =?us-ascii?Q?4o7azF4liG6UWLC0iApJTwCJ2CWVzTc+ftC2h98QbYOOVD62h7xb9iThVuF2?=
 =?us-ascii?Q?yc9KzCXBYh2hIYA+nra0cPVn2KzKgkGKhZNM0yBZctbFftT+htBpYKffcHs8?=
 =?us-ascii?Q?CokBllg18cAHx+k8f6y7m7GWineavHH6ErlMCBmyLKY2Sqeq1FXsYWae9C5L?=
 =?us-ascii?Q?F34aZr/JqPMcq+8eW4DW7tFJeGGNDrZKcsj5mU/85g4ITYH2VQrEesQ7qEZm?=
 =?us-ascii?Q?2TxQPb83xiMaqoOTZn9tdmUmcocXYwGyfhNYG6jeexWAFLJ2lVfb/Bb3gK43?=
 =?us-ascii?Q?Se7HPMdUFDjzCtACdwQ6dB+DmVLahzBJ8XO7ZX0kWNWLUgRjnCybjrJiXbMM?=
 =?us-ascii?Q?v3WHwVPYURX2ao9oJ3chxlW5I7S7MJBXMVOUUJlfM0ZvHKIlf4CTBjnDLA/a?=
 =?us-ascii?Q?3mEdWyoX4lyDMwgO7aJJnLMRdux5676m+2741mLsv2o8g8TqQ9/JtRgejd0p?=
 =?us-ascii?Q?r5yB2HDyE5wihUAOOhNkXugndFzadSkkjRp/p84C7jOo0KW4zr6xhgdhmbDD?=
 =?us-ascii?Q?PiWoarWRnqo1lhgQc+TjzoBS1ye6elA/eDcmNV/XAiF/LdqilczY8ephlBVI?=
 =?us-ascii?Q?UkB9a9Qwep0YB7zn1/kx1ILZOKU7MFJ3ZH0PjYIBeAWX9MPDC2ucwo5epRLp?=
 =?us-ascii?Q?t8Lz2umbwxapiEDu9coRbgWh2eYs2QntLaEepztbzF4BKSleFHyxEC3gd9bN?=
 =?us-ascii?Q?SnIu50PM4AWv+OuZkbowa4s+VwOaZ3MFZDXkC2LMJVrYsy/kvYTdxGUExM4/?=
 =?us-ascii?Q?QMfDT+IE0Oc3EUo+1uFgL3q6CCO3bkgQQqp88urSWQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LQBP+9vZLdC+sFZ3iWigI3KCGBiwuIYLS8RQ8y+G3y8Qi6tDK5w+Vs5p+Xn7?=
 =?us-ascii?Q?I2iiWlWVw80FcpPAp0hma6N0Ja0q7OuXn8SnwaLfjDi3Pyq6slOCaMdxbDZ1?=
 =?us-ascii?Q?LPn6tM7Sv6JjoxSXHXhVSkkfJxY6rKlOtjX/9gzkMpPAHIeNaYiuVmkPUQGf?=
 =?us-ascii?Q?7FJRZ9ZYem7B2UFMnTWzzXMBJHK6qfnVfAaxgiCShgp1O0lyH4VU5NdAD2fL?=
 =?us-ascii?Q?+hvZ4QTToYLh+bksaZ9viY6iGVEklO+30Rj9abds69GXGgBXQ8Lu/DG3Cegl?=
 =?us-ascii?Q?1nxXAJgWqvj5xRnvqxtF5c+9D4/+sg4FryMphKbQO1U1/MVd5hRX1tEvqcts?=
 =?us-ascii?Q?0Zri/KVAAlakLklmhwUnvcQ9y8lJUbAKwvJh7fqDt2h3xV5ZLSoQXsux1RVN?=
 =?us-ascii?Q?T2xBFxDPCJdhhUgRCV+DbQwTxFV9XFjVFQwd7fgfeQZbSzxAc+MeeRG+Uzij?=
 =?us-ascii?Q?/hNCLyDBdNiDi7lcIJa967L7cpDCViOD/lvufVNCgMy/QUEpAZiJypXCWryP?=
 =?us-ascii?Q?UvGUMO4nt7dGtgxFxY2HXm47iSOvxQIFPeBCWwVuXQIMvQMxWp3Vxkf1s8QD?=
 =?us-ascii?Q?gx9fIozFEek6568p7lDxCMC+95scxQX8xh2mXEVZZeaGHrXhBPS1BAnYIfSt?=
 =?us-ascii?Q?cyOxu8SyUzBLtYGjmI3Fciif+5HiYCroGJGQ5tlwhnAR0YgQaRHafstzXKdA?=
 =?us-ascii?Q?iIu9P+ESQu9TmL0Pz0HuqSfTW3HHerYIhJDXmKsa1c7T3lUzYfKOGoqWqpH5?=
 =?us-ascii?Q?JLyAO0oAG14DZKnlBPuTRnJ3ULVX2+HdFvk/CF2QJmBZkrn+DiJ4RZUuPe+0?=
 =?us-ascii?Q?2yA6xKqlyv/eUlTJfnLjU0KkkTiFm4tDcmvZ/9qVNaizNmEpkGhloTTBKOMc?=
 =?us-ascii?Q?tTVbs/nXDCx95ocmWKY75PV6QSjufxCKEoDROth06sylS75TuETZldTqVeru?=
 =?us-ascii?Q?JSMkcIHrok2ZOdgMCBM9buAVzEWnV3JC8/CUGltqvZo6g1BfcyCIzlQiyDc5?=
 =?us-ascii?Q?TQofQ3ccnzzliSYUORE1A3bAW2kKDy5M6QQPWKAIZS5ICM+/8mDPRvXXa487?=
 =?us-ascii?Q?9o0O72JSCyDzX3Nfx5K1GQiKZIrDwOkIZzKBgyenov9QrIzyyR1FwuGlOxIo?=
 =?us-ascii?Q?d8mtpJwTxu0kHXtJ1HLo4MNGxwjmutvMFuKao7o/bjO8qUwsmkMqr55W3xFx?=
 =?us-ascii?Q?nQuW6eYOfjF+ua2V1ZQhSYyHIL2UEdGFMhKkNuvBNci/LZBfwyTBFAwVEe8f?=
 =?us-ascii?Q?oqWddrJ67xmnx8a3/dCxEtPvtiLHv1XfnpIIcJlLNVgJu6+VwS1tcOUwjwgR?=
 =?us-ascii?Q?2TMOkrhKcqjoxknGp7KlA57wqXYaDgIFgmMrPpYtCWaETT5DKT3o0Jr5kvh1?=
 =?us-ascii?Q?3rzzUaGEbXc+pjC+yFQ3dl7MJDvNi3vhNbXPZfwYxAbNipv2+l9tleN6pX4r?=
 =?us-ascii?Q?9KO/BLmqyehfd/twAPQcUpkepoJdx7fUZAnEsK0ywLuohXa1qleiNQmyXAQf?=
 =?us-ascii?Q?IUM6XWoCLgPhO5HhbpmDWmYPR9DOl2u8SvXYURjNMJkMtDcRLb5brqBWohuK?=
 =?us-ascii?Q?w5ZoDfZUR0iEgaiHWy0bIOq74fHzd6nY7yjEebxEjkvPpCAbb98ISaDnHb6y?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34256f0-cfa9-47c3-9a6a-08dc78e9d553
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 16:28:08.2586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlcosqTSlL3a5KSPuQj94gEb+wDwbO5HiypbRpLGvKN+QnCzfIrbOEblj0jNxyf3WDuvSKvTrhwMEDwbB9WvqVZIJvpOL+kpqXFODax4lII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9436

Update BAP Broadcast Source state machine states

---
 profiles/audio/bap.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 06dc4e254..65684cac4 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -2474,7 +2474,7 @@ static uint8_t get_streams_nb_by_state(struct bap_setup *setup)
 			 */
 			return 1;
 		else if (bt_bap_stream_get_state(ent_setup->stream) !=
-				BT_BAP_STREAM_STATE_CONFIG)
+				BT_BAP_STREAM_STATE_ENABLING)
 			/* Not all streams form a BIG have received transport
 			 * acquire, so wait for the other streams to.
 			 */
@@ -2516,8 +2516,12 @@ static void bap_state_bcast_src(struct bt_bap_stream *stream, uint8_t old_state,
 			queue_remove(data->streams, stream);
 		break;
 	case BT_BAP_STREAM_STATE_CONFIG:
-		if (!setup || setup->id)
-			break;
+		// TO DO Reconfiguration
+		break;
+	/* On transport acquire use BT_BAP_STREAM_STATE_ENABLING
+	 * as a substate of BT_BAP_STREAM_STATE_CONFIG
+	 */
+	case BT_BAP_STREAM_STATE_ENABLING:
 		/* If the stream attached to a broadcast
 		 * source endpoint generate the base.
 		 */
@@ -2855,8 +2859,7 @@ static void bap_connecting_bcast(struct bt_bap_stream *stream, bool state,
 
 		setup->qos.bcast.big = iso_qos.bcast.big;
 		setup->qos.bcast.bis = iso_qos.bcast.bis;
-		bt_bap_stream_config(setup->stream, &setup->qos, setup->caps,
-							NULL, NULL);
+		bt_bap_stream_qos(setup->stream, &setup->qos, NULL, NULL);
 	}
 
 	DBG("stream %p fd %d: BIG 0x%02x BIS 0x%02x", stream, fd,
-- 
2.40.1

