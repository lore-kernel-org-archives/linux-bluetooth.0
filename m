Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2048.outbound.protection.outlook.com [40.107.6.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C6B3A1B6
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 May 2024 07:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796482; cv=fail; b=orisdQ0NikxeI0Yny3qcAU5V/hHPrB5kNHWqlje0vSnbOsL9OVhZdshjlRixB/rcputoXlt8FxlSFLs+bDGA+bPndo6upirxxVFeDWeHenkAf+vPZR1dMRg1NQzqeYh4iixd+KTuduXAEPTY7+Y9LCz6KRby77JseRaNv38jLI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796482; c=relaxed/simple;
	bh=Bp2p/cuPgyJ2j0vslNig35ZKmtAEA4Bk9oRt9nJgQg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=onhH8ZSWxII5GpcmelsQTS7pFXW1w/fkzBpXPYjKIVHd+yEv98yi2vEbofvFDvRbZvDQ7Udd46LaMWf8nPLHaSnN6iKDD1pHEXXIcaBx3AFnuHyWzuYQAv0C6R9NHP89gAbL88YbjA/u3m9MLkTB3f/r00B1dTDNFxDX+0DmmGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=aO1qpG5v; arc=fail smtp.client-ip=40.107.6.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aO1qpG5v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYdoti3Ue5NrAZXs3pQ+WWBFm9FUi0hyIeWgImc4/Zo7LjjP6MI7pcJfQCw5V4vdqdBWXyYJnK6AqU3mQTXoy2JsktWINuLYrLAsDNiGskbnWq1a0RlpiDzwrLlEYU0JJcAhefZovfDxORpewunL16U/nrpbTQrUswCdKOKc9WknkCKt13VV6Z/WCJe5wjZkOLtxb8H8PKTXRdUdtIzSyUowtNK+6D2YonEzK2JyZI3xlj++LMyh8h3aagD8wGiFvDKQecHNmu/fpVsasCF1+tsyFiskt9JAtClY9jfcPgTDDFfcx9TQuzCQp1LX/ImxSLXSXifyJmsXs6s7qKwowA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQHXE/HxLqVTnaRnvdEYUIRzv6kvDAjdnREaFDEG+d8=;
 b=ntIdjpAci8uBqVLJexxVIPjKDHJJAUduAwDdlML4QORfFGDKhOlhAbB0ZaZZYzRwvprZO+qD8BergFMNDBurcSZQf7oSrMslKkhRW97zbx/NZT3KOMBCL2xOuFesgq4VGwqfLFB+qPrYmA/6Z38PlnZSekD9AvLEq39SkfbF3FrKGs2/55O3M3CfFQv5jI5QbDfLCXT2gN7uI6cdfRUu/jr8sYwQIAX29/K2YLv6bohMl2wqyHrQJ59RHOt2/tTXXT5TbbrkjRT8xc7+lxchta3FpcTPaxxvqqqsvxXLzhwZ0MapplNhIjvoOg/cv2FAmB7Z8MDYtE7qYYrjpiolRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQHXE/HxLqVTnaRnvdEYUIRzv6kvDAjdnREaFDEG+d8=;
 b=aO1qpG5v+aqtvT2P5Euknknz8dHBKpiuwm8Y77RgStRQILJ8Cf0xXsMNaIyvpy/bxztLs6jHvU4XStb00GyDMNYLSG10skdtw1G1vTfmn9D+NTvNK9GoJEhFHaECW/w7z08JFYY2shlZddoyyCWTgrkg4Bc6EFZlLzRan2MtBQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBBPR04MB7836.eurprd04.prod.outlook.com (2603:10a6:10:1f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Mon, 27 May
 2024 07:54:38 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 07:54:37 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/6] shared/bap: Fix potential stream access after free
Date: Mon, 27 May 2024 10:54:18 +0300
Message-Id: <20240527075422.18953-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240527075422.18953-1-iulia.tanasescu@nxp.com>
References: <20240527075422.18953-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0082.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::35) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBBPR04MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: a9223ef2-7877-4035-5736-08dc7e2241d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ji9gWxVDMFRZAPo3pcsoJaaas0q9rzyNNl6nimlQD/Rc2HpEctcNguej6EKl?=
 =?us-ascii?Q?Qx6j04xYbfNw7mYap6Mv2msbZLhKcWuavvxJU8prQBPfY1/STa9Noa7ImGgg?=
 =?us-ascii?Q?SJelbtREXGy9qCZgj9vXqkT6fdrmSGBKJMa/i5Yjw8t7GiKE65vAJvuu/stt?=
 =?us-ascii?Q?VtR9hbnyn4IMpjp5mR5o7ZZHpY+E5DXJHQVF7KnBKScvQzeYPbZD2UfHgUxl?=
 =?us-ascii?Q?WV5W1jvw4fK6H4aCZSWGlp1pfY6DQnS4qolCgHpmtdKUg8xLMAuRJ8VdSGvU?=
 =?us-ascii?Q?3eUau3ikCWOWBZt8u+IP+tm9/4nbYhnOAFEccK8a74nqbVBpRgAQB++g4f8m?=
 =?us-ascii?Q?p37ANupn4ibd/Ya/ruRpLF/ZOvN8wMJA/1hF0tUy9I84glpKR5BdrcmrBJg6?=
 =?us-ascii?Q?tgdSBE2UffEvxdlz6iKB+L+JOl9TAUZE/tQHZaQJPq3G+B5ShWxBiNYccrsP?=
 =?us-ascii?Q?JtG8aypbT4RD1HTFm4LFq1My6iDQSQGTcztAg5h9brDbFnSdIVwNQ8TNjFB0?=
 =?us-ascii?Q?3o/iUUxmz1BsH1CeHJcL/3gb9mDpkpg2t5FcITC2gW7rkof4GMSTeBcqUH5c?=
 =?us-ascii?Q?XJrU/lR0U3b1aUVgdO5nnRTKhCbPXodWmyfagArLOIh626wLeifVmFib2fa4?=
 =?us-ascii?Q?NOGMaQ8cjYuTm8A4TbtWHTfmYw4V3aHkp+kedzIGTLCtXv75iyTnkxRa7U2n?=
 =?us-ascii?Q?8boeIHzTQwGGposUqHCm688cdp/HdkGLhwPt1wDOf8nFUDKg4LCK/TVv7PNs?=
 =?us-ascii?Q?6LdUbY9ZNLDkbBmtHnjZT7fjrp6lOBnG63zAHAofjhADegIx0NkkIm/xd3EL?=
 =?us-ascii?Q?ASLLUsqI1UFhqSibANBQTquHn9aNqmU/avtM+dCM3kDuG+88MxER0sUau1zO?=
 =?us-ascii?Q?FJw+5bInTM1NcAiq9HOXCHiRsW0J1BEZ8qCjuKC+VUTW/9zFIeBrFsk3+OFX?=
 =?us-ascii?Q?kcFF8+kpT8EYCnDBn6IuVIGk/ngh7V2+DdlSABkmqqYSyyHiJzy+ckJoav6J?=
 =?us-ascii?Q?YV5nGsQBiodz7Vz1oMpHizgTqqJlYBzX31tV1yWMJACLhMqDLYc4+fJdPOQq?=
 =?us-ascii?Q?3Hb494l2xwtRjOD8ifguaaURZ8zu6TFREHoyPG1LTUcEU/SKu5Ej+Eq13PoK?=
 =?us-ascii?Q?CkCUdQfAeyiTKR1PXThzMd1utjchRb+bLy65p2fk7iSMKxOzPluiNSPxnZgL?=
 =?us-ascii?Q?qeno0WflCLG/PZEErN24KRbpPg+lRCy8bHQte81+Y41EehZeU5MOIyuOkpzH?=
 =?us-ascii?Q?hjQDFBjZxzWwiJeRYS/slLi9ZFBJL5ajCr4SuNS59Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i0UK1FFmPbblh2ifBDxVEhtIsokx94MCU18g7lwcQEg/o7Lw7UYQtl13oT9h?=
 =?us-ascii?Q?7R2mauPXIwM8ywS2AzvAbAUXcRKr91IhmXuDF5hcNVoo8650NSkFDcimvMZg?=
 =?us-ascii?Q?52HmblQozEWQGq82kadGdD53g32eXFEU7LRx4yLMQE+gaaxCYIPszsa83r4F?=
 =?us-ascii?Q?wfavDw82Mr6B1sHRVDA0hxZYcSP0yoEuGfUUl7I6aw2FnuW2lPK6wqSiLdop?=
 =?us-ascii?Q?egCsujYOwfFFDZVYg5/Lne5fOTMvS9dU1OBaMMuTfX+ZYEPLnxF/kczOeSQy?=
 =?us-ascii?Q?oQ7IME7iwsW2TaWIhBUHVQoEWkKoQmqbGeb3dLohAKkKwLgVqRtDZSIyclnp?=
 =?us-ascii?Q?wQhjLPSpnMwH5S9mpJwI0are3gHLuBHTbDCRImwePkaZZ3gJPVJT4VLO7NEC?=
 =?us-ascii?Q?Wm+H4v0AcZcWfiJJ1uJ6w0rl1labQXs99160qekDBDx+0rECn+JsPkHXwz0O?=
 =?us-ascii?Q?u5aCLK7AL+MlMrXBkh8Lg2behYhTRLQrRHOTEkvg5XmYKH3MUDNnGdcQt1AK?=
 =?us-ascii?Q?AhVoh9Vp9bzVCOS+1OOTNbuF/yMHmMVdMmS82lzlPAmYhOP8iW8ho1ec2PP6?=
 =?us-ascii?Q?+rdpvC8pUhGdgcc71xbqrm44lRUGcOU7rXmQGn2OS2t0+S69jsIllUOGsyo7?=
 =?us-ascii?Q?4EdtfpTlPs3ierIg3corCniCtmvjoEpkUHmBBNpWBw5OtA5akmnogtlL/dHt?=
 =?us-ascii?Q?bsEQMBOH0c4Q1uJ1hIloYwLcJva0ZVCzB9JvjCyTY+arb2BaLBMDPb1MFs7O?=
 =?us-ascii?Q?xp74AcQ8hNDC/9kXa5Q6/cH/KnS1cdy+kvaT8L2E/6K7D5PL75XLVOzn5eko?=
 =?us-ascii?Q?FwuNDfEPlLbVo4njwY31x+VjRZx9rlGxJZXGUlNa5s+BUcnCDiv6NHu6UJVu?=
 =?us-ascii?Q?BwC/u+c4SMzC3Hg7LcyLLS4febOYHOKMrsuP6B2EsH2z2CG1rHuDajmyY7dx?=
 =?us-ascii?Q?74ZdagObMVDKsIbR9pfCEJSFNnAffmn5nEK37gihlE7h7b6jAV8cM6HFZuSW?=
 =?us-ascii?Q?NuCCH3PDEKUOpwLAarxI61Dg8n/nVxyi5L3Sgeuw/mqQXuGhsKGym9ltdWth?=
 =?us-ascii?Q?p5BBWskMAH8Sz2LX0ZXuS7zmvVeL0OCyZ5EiUD8ehRmsV3LEKg+axVbfpFcS?=
 =?us-ascii?Q?KU3cJHptYWRxZxznbZb9n/X/rZx8oLyj4pRXwh2I4Ty2JxM7O1fmemI0djiN?=
 =?us-ascii?Q?HX4jXVIdPXEqvrCMUFk6/fcXGBqiHX/XFdvtlK1gL23ndfj1tI3bAPZqDcvR?=
 =?us-ascii?Q?JbSVVpKznOQUiLhj21gL9qxHqt/U+sXHgMZ8YHz4ThTyF4FfTjRIuVdaT5DE?=
 =?us-ascii?Q?gZ0L+S6LgD/obJwHuKulIEFoQuGBAsU/8kc8nM1Gwl0cJ3Ba9Yo1a3qz9e8B?=
 =?us-ascii?Q?MK+xTxB+zgufxubOoUznfEA4knJlY2JXOo5ldMLeG26lelfnpoij37ehOTHc?=
 =?us-ascii?Q?4ELkQMpy4LohRu+2DLMQolIiqst7vNjbaGQYHhZDn8jjKN2qcyrLrVJFT924?=
 =?us-ascii?Q?Z+7MePoMXMhQc2k/AYBuULOqDO6PbmtwsMbkCoAm21epca5orQnVsxqQE3Wn?=
 =?us-ascii?Q?UaV5WGsMFIAZXHHCY+RDOHBs2MVVSkSFEmuxeq3lVwcd/rdnbZl50rgHtV0h?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9223ef2-7877-4035-5736-08dc7e2241d4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 07:54:37.9112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g3k71U0gXMM4SS9kIx5gbuxdH9CTzUSjUDvpTJC1gX9KzGn7bUnM19a2OExIgKHlS68lilXn03YSm7CAA7N6Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7836

In bap_bcast_set_state, state->func might trigger the stream to be
released, thus the stream would have been freed before reaching the
switch. After calling stream->func, the stream reference should not
be accessed anymore, apart from when the stream has not yet been
released and those cases will be handled inside the switch.

This commit also handles the case when stream ops might lead to a
state machine that ends with stream release, so the stream should
avoid being accessed after the ops are executed.
---
 src/shared/bap.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 1d9f59f21..ec54da341 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2051,7 +2051,7 @@ static void bap_bcast_set_state(struct bt_bap_stream *stream, uint8_t state)
 	}
 
 	/* Post notification updates */
-	switch (stream->state) {
+	switch (state) {
 	case BT_ASCS_ASE_STATE_IDLE:
 		if (stream->ops && stream->ops->detach)
 			stream->ops->detach(stream);
@@ -5293,6 +5293,7 @@ unsigned int bt_bap_stream_config(struct bt_bap_stream *stream,
 					void *user_data)
 {
 	unsigned int id;
+	struct bt_bap *bap;
 
 	if (!bap_stream_valid(stream))
 		return 0;
@@ -5303,9 +5304,11 @@ unsigned int bt_bap_stream_config(struct bt_bap_stream *stream,
 	if (!bt_bap_ref_safe(stream->bap))
 		return 0;
 
+	bap = stream->bap;
+
 	id = stream->ops->config(stream, qos, data, func, user_data);
 
-	bt_bap_unref(stream->bap);
+	bt_bap_unref(bap);
 
 	return id;
 }
@@ -5565,6 +5568,7 @@ unsigned int bt_bap_stream_enable(struct bt_bap_stream *stream,
 					void *user_data)
 {
 	unsigned int id;
+	struct bt_bap *bap;
 
 	if (!bap_stream_valid(stream))
 		return 0;
@@ -5575,10 +5579,12 @@ unsigned int bt_bap_stream_enable(struct bt_bap_stream *stream,
 	if (!bt_bap_ref_safe(stream->bap))
 		return 0;
 
+	bap = stream->bap;
+
 	id = stream->ops->enable(stream, enable_links, metadata, func,
 					user_data);
 
-	bt_bap_unref(stream->bap);
+	bt_bap_unref(bap);
 
 	return id;
 }
@@ -5588,6 +5594,7 @@ unsigned int bt_bap_stream_start(struct bt_bap_stream *stream,
 					void *user_data)
 {
 	unsigned int id;
+	struct bt_bap *bap;
 
 	if (!bap_stream_valid(stream))
 		return 0;
@@ -5598,9 +5605,11 @@ unsigned int bt_bap_stream_start(struct bt_bap_stream *stream,
 	if (!bt_bap_ref_safe(stream->bap))
 		return 0;
 
+	bap = stream->bap;
+
 	id = stream->ops->start(stream, func, user_data);
 
-	bt_bap_unref(stream->bap);
+	bt_bap_unref(bap);
 
 	return id;
 }
@@ -5611,6 +5620,7 @@ unsigned int bt_bap_stream_disable(struct bt_bap_stream *stream,
 					void *user_data)
 {
 	unsigned int id;
+	struct bt_bap *bap;
 
 	if (!bap_stream_valid(stream))
 		return 0;
@@ -5621,9 +5631,11 @@ unsigned int bt_bap_stream_disable(struct bt_bap_stream *stream,
 	if (!bt_bap_ref_safe(stream->bap))
 		return 0;
 
+	bap = stream->bap;
+
 	id = stream->ops->disable(stream, disable_links, func, user_data);
 
-	bt_bap_unref(stream->bap);
+	bt_bap_unref(bap);
 
 	return id;
 }
-- 
2.39.2

