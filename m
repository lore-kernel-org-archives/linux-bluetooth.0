Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2066.outbound.protection.outlook.com [40.107.249.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A151F9431
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 12:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858949; cv=fail; b=o/Mxy90XzpoY3Bw3xp+hL5pKX2lowYEeUxezuIRaKGj8jq6oumoIe+tyatrrHeon8AvuJBGIes9qezICNVi/oBlBJOeusI4u3AxEeY+xtkeH+Jt/BOjlA8YuPpyUqojytx2V3/qENjTtwLB8dqvT4Txkib3GlnO8qmpe57mfQDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858949; c=relaxed/simple;
	bh=8xRDB9ovg70a4f1MdIK0e6b5DL3X/61zNLqvC9bhEvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iOXSNKQJmEI248VXKdHl5wW7Y08cFnxZ+Gxoa8Xuj5o2/WGkxzQgpq9DT/UaRZT65rjj2GB3Xlsd5PBw2fnIBFT3h9nvcmcJ6G0p3tftt77dl9DdXCg1Wj+h0neNoKH/q7+k1THFwFBD/tuRJvLs6nkgjXBDD1D88wXrptXGCao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fsi23soj; arc=fail smtp.client-ip=40.107.249.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fsi23soj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwYWEvBgBAvdqqk9/djDwk1+FULMLZzBN2wK5tnEIun/dmSl3rrFhC6O/g30OXVg8ldmyBSqX1TitjJ0cFjq+L+uubFaQaLfxpoqsaFfogrT2MQLmieSxQcn4kuCKOQqVAacPiMQOaBr10NgCjtjySwjiBjzFGOqgCmNYsGCI45Lfzq6v/oYLfyanynj3E0XnRcZ8tIKbfyBx21pxb8xBQtv9SchgVJ2uqEgsQMa5RC1Y+UXtmKwVUB75sjIXNa42Kh5cMXFnlzve0Aay+wxM/77DUPq3n1dN/JpMIqO96TAXsM0fjm/jj+988grWfBG5UCXLX6P0GSHkmGR+snKDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YQM9ltIZsX/V+zLsBt/H6LU2t6pK3ly5daKehwnspE=;
 b=uI5IfwOqNLyPFLJz6jpp5O0N4YioYMVbrpopvVmV7TTGYTVMQSSDkCw0Q6K18gnvARIIEHYf44KpghJDrx0pTgrxIBZ4r8DmokTBIMiPPPR20K2yZ0uPHIR/j7qyBzomxL2B4KBpW74PnaymADKFmpjECdJDQkE8/nXlZhGaAVt54fO950+FUmLvWH3QJfOTLiArUhijF+ld4ir0dEdSU+ZBLPe56PfRq1DfEX1W09dpE7TGgnNjCgFtB7aidfvlItcnkcuLLBV5a/DFvAgY18U0PCVnQMUrxCzDHhUbQP6v+RArP1dl3HPe5I2zVK4oAIp5itOV0ed4bkFv3T94GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YQM9ltIZsX/V+zLsBt/H6LU2t6pK3ly5daKehwnspE=;
 b=Fsi23sojn1TY+8dDivPvqhT5mFQtof7e5jdgOMxifKdUVU2eynoV2dWqdW2i4b7VO1wHeAVCNod34sdtO5Uge4+kPdz+87UTEWSq7hVuRyoXL0zIpJ/IlUrEfcfLaqM/uzJwaFWh0tX6VZhGTkppiL83i4Kh7JLUM2MPacIqM/VGLp0722EvZFovjIvFFD0TgOnA2sZcW1juMU4i951Sv/SvCJlrtIDY1jcKXU1kls83CtrrYGrL9hPAj8+/k0SbojbCp7wjB2W3SEb3u1XBtySGgIDpHa34p132axghWgiEpK0pJnf01D3ShEuxCt9w+4MhiGIJnenuGzxg3+OYLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI2PR04MB11052.eurprd04.prod.outlook.com (2603:10a6:800:272::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 12:22:21 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 12:22:21 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 04/14] shared/bap: Use enabling state for bcast sink streams
Date: Fri, 25 Oct 2024 15:21:36 +0300
Message-ID: <20241025122146.17925-5-iulia.tanasescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7721b78e-28e3-4e05-6fd3-08dcf4efad16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O34gCAFlgw2EpXIVzDrari/ZWnJCigJWGYrUGoAyyGW8Nhehe1vhbJ+3CWeo?=
 =?us-ascii?Q?7B253NrOHOhSN1a/M6huvTLVa9yVQQcfiDU4/xk9GqKayzviCYWrt0xpz/I2?=
 =?us-ascii?Q?eyZ9d+SCuOF6fBxNOEAlbF6OKfKPK2bLo3kiHVJWI8QMrpzdeZWh1KmqbXUL?=
 =?us-ascii?Q?57Wugo6Ohaiy1efVEH141OjDQg/I5CEKcbk9lQDEXnzW2XnBPBa7c1dEw+8A?=
 =?us-ascii?Q?DlxICEAjswj/qn5ax5BQ/6xB5mTKFWDEprFLtG8KLCnvdKAILWgoJYtt/J51?=
 =?us-ascii?Q?Sp+jheYKYdnYMvW8kSTydgj3f7fC5jmHz1hxyNT0rmoqo3Jd7YjJz6m94GRx?=
 =?us-ascii?Q?tKiOVCxKB4RV3MV5XpwwJEabvcRraR3X/weoQBzx0fQ0XNYY+A6Z/ePhgDlq?=
 =?us-ascii?Q?yvbo9DgNDABY84Tmb6ovvJoQtYftDVA82amrMP8H+pM4lO9qz1mw7Xp9St+f?=
 =?us-ascii?Q?UEDE8cAsoQIDt+JUcShl6GW2o6z/6SUj/HdivpjKu9hqQK5+PNENJiG/uTuN?=
 =?us-ascii?Q?LvrSsL3xa/y3Tex8TP7UCRHVOGBthGc5ogrFhnIqdwwXboXH/EnuPefjZ7iy?=
 =?us-ascii?Q?Cs/QQP32UNMvdHqnUClNQE3XoMsiAprp4mVnwaW33f0zq6joDXN92/tFPZsV?=
 =?us-ascii?Q?c1Df/Ld4oOLvc/77uOmUxuObHrybWXbkzNjT+N2JE9MF5zMnjv6+IOOYiztk?=
 =?us-ascii?Q?cCiDzkurRoPANMtLGeWia6n0TU/CRU5aNlsQcr+coJ3kwb5LhgLqgc5/LdD3?=
 =?us-ascii?Q?aUq7ASsGDzjGqb4GAEvHyxGd4PJeHFK49Z8I5bPyFiviTHXK8vRDScGRt74w?=
 =?us-ascii?Q?rwe2o4VSL6Rsh6uSZuhWZwoBhHMKGaUdDLtonkE8/UCD97vRAHCgBQyLlN1R?=
 =?us-ascii?Q?ivjA2IwrRScM44/awWNhn92rx1v9cfaD6UYW0fJoJsTZHbycJc7sYQ/cwqnF?=
 =?us-ascii?Q?UyAceJWttvmKDPJA6SjWHHoYJgxi1DeqJocnkcctzvmSnfFxmt9jqnXj3sRK?=
 =?us-ascii?Q?mDhoIK9EXSZEUS23Uvf7X5q2jtGZcKlyxus+IwRO/mHtLJ51ZHSoHYZH4DOY?=
 =?us-ascii?Q?snbP9OOtgerm2COIz1DST8YJWkyC7VEA2uZHQYSc/sVXYi1B2XS+bye8yXQw?=
 =?us-ascii?Q?jsWsWMmcTNa2TABLEYDXZGb5yIxa7LA2qR1PCEV3iKcYwctpNjpqsXFM0Avf?=
 =?us-ascii?Q?lpfRlr/SJUnF3/xBs7vRrhAX11fjl+hzkwU57ZpM3ZDNvCVVT/uW+xON8thM?=
 =?us-ascii?Q?k/i9oHUseFfjOgwkzOM0CASeRPjH+IoGCp/0KO+/O+qkbJQSS/9Gvv9a9GsL?=
 =?us-ascii?Q?8zZ7oibamT82j9Fvk9cu5mGBDFVf+S/iQnfI+rxtQ2OcKNTNMMcDPMwL4+LO?=
 =?us-ascii?Q?+mTV+tw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QlbbUuE9QutrH+N7qn0dLgP6aAqYDCuK2tqYCumR9G4DGnvYp61oAwrrqZDq?=
 =?us-ascii?Q?DRkjvOYgVB0wheGgd3HFT0Q3ci2+WFjmx1OyvvGpBDhWXdKNFYnpG9aRzV/H?=
 =?us-ascii?Q?kW5WB7hHI1bmiBkvw8AmfSDe+HxRnW38bzCld9nz6BqGSJLB1DPtgIusThPK?=
 =?us-ascii?Q?EHMhettYL9vJlpqVusBTJ4Kd5vXTbJWzxw61MVpv0Xq6cHc9O3csqHnfMDo7?=
 =?us-ascii?Q?UEgGTv6LlkQETV4pIWZmOq7Z6tUHSPsDtf+IVhqJWPgNY38siFz5k2mAqQHL?=
 =?us-ascii?Q?4tWjLCx5jzilX5RJike6J7GH+4u66JiFkrx4pUfhgPsS1s+XNn9cDZHrtKV9?=
 =?us-ascii?Q?Bgvdj/tZfqLMxDRQn2rvranryqNaT9mnSpJDN/db4yBFOJptYxyStmoklC4w?=
 =?us-ascii?Q?550A2+4oHoNVHAul2dsIO4UiP+vf2HXvXBeIfkE3EQMaswQA7MEAe8L8aGjM?=
 =?us-ascii?Q?PoLsE/oS9nmYZafOdLllk/v2vsxM4876536+KnZLS3EhMqBg4lFBkb9HE0ZD?=
 =?us-ascii?Q?xTQe7eJ/zgTF4P/uEutKK8bETiINlMC9VsbLIrwMWepvCm2kqDWGbWmFL5Gj?=
 =?us-ascii?Q?dptBEphIRg94xvxK7tAGhRiLT5HkPk9uru8dU8wLt1OzskUSrwfx2yLBfCUp?=
 =?us-ascii?Q?Yco+ICAgYi6tDvaElkF9KIRnGBDEB8MWl1LZk83j4CdpgjF5XBHCCWOAm4u4?=
 =?us-ascii?Q?hKIq4e88j71Syb57vbgJmgvArdCi1dZnZVgl3dDgiehrwYKwTKHd5XISk5yt?=
 =?us-ascii?Q?sxNg+tw0buqZlQvRAiG+KdEpXFoM7GhkbguXjjQfcO6Scng+loYfvKaydKbT?=
 =?us-ascii?Q?6JOf4tPQxfVMQ1O+rm6niWn4JR2dIMAOswHb7aZCfhTy5QXURRbT5XBpcZQB?=
 =?us-ascii?Q?H4PUN/j6jNQvKDYse5mfr7HA/bY/i53lAKVYMocvDH6vcTu6uN9saqRBi/e7?=
 =?us-ascii?Q?30bCj/4/NVFNcFplyXJ/W8SopAqdJ1TF+Wsu7ZNTe1A/3GTcnn8R1c8k5RNK?=
 =?us-ascii?Q?HO0lacrCTGS2xysH1Q+t6wR8ZWGFVkMC0lcNnIUwcmANErsZjXq13Zs8Uqiz?=
 =?us-ascii?Q?ff1mBdeGVrmf2UQNwfmqe/kt0slpCwHR+HVWu/zKhQYoeTwos32tHrYwvvcn?=
 =?us-ascii?Q?sVEF33C0FwAYwvt0xnaXQPmjmAXMVaQdN9AurtQ1FV4HE0b7DU0GtWdy+2jR?=
 =?us-ascii?Q?Sxk/2u2G/pYN8FH2x2xC2oKAX5C4gQtwBCre4E7w4Ui+dtC4CVN6WEzG/BQm?=
 =?us-ascii?Q?Bb8EMjECMEfxX2SrTZ98oJ8ZsMP6LA7BeQW0/GmBxJQef7dJIRWm5yVEusCF?=
 =?us-ascii?Q?B9DjzP7mU3QY2vlrJhPQ8D3drO5Qugn8Afesb4xU0gLN9zsUqnoeSODCGp5k?=
 =?us-ascii?Q?kuuw2eMrsHTzMwyAMkjjpM6J3TTkDkFtGgvwm8hAluNFbrXarqPg23F/TdUW?=
 =?us-ascii?Q?QJuiCf6PiyFt87CtBuMU6zQxnDquspCiL2iw1St9kQYKd4mShE15SF66vazp?=
 =?us-ascii?Q?EsfB0rqO2Z2SWMvN4Mix0KueAWWjHen2xfMlMF+hJz2+HjuWnQl3hpjlMAX8?=
 =?us-ascii?Q?mEAMO9Mn4g5UxGr9p2NVI0DY8mitYNwVDyLsMR14sZRih2WE2SxMBsQuQi1J?=
 =?us-ascii?Q?oQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7721b78e-28e3-4e05-6fd3-08dcf4efad16
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 12:22:21.9203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlDX7hE8NNX69Qh6uGr+SbjF1MQtkyr9x1X/gpGqts/tNvOQ9qDOY/Wx5QnwKGqRe6m/V8SRvlGOy4m5aZgkCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11052

This updates the stream state transition from CONFIG to ENABLING,
on enable for Broadcast Sink streams. This is done to differentiate
between streams discovered in the BASE after short-lived PA sync
and streams that have been selected and enabled by the user.
---
 profiles/audio/bap.c | 13 +++++++++----
 src/shared/bap.c     |  2 +-
 unit/test-bap.c      |  7 ++++---
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index c45717ef2..81e1fb03e 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1020,7 +1020,6 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 	free(req);
 
 	if (bt_bap_stream_set_io(setup->stream, fd)) {
-		bt_bap_stream_start(setup->stream, NULL, NULL);
 		g_io_channel_set_close_on_unref(io, FALSE);
 		return;
 	}
@@ -2676,13 +2675,19 @@ static void bap_state_bcast_sink(struct bt_bap_stream *stream,
 	case BT_BAP_STREAM_STATE_CONFIG:
 		if (!setup)
 			break;
-		if (old_state ==
-				BT_BAP_STREAM_STATE_CONFIG)
-			setup_create_io(data, setup, stream, defer);
 		if (old_state ==
 				BT_BAP_STREAM_STATE_STREAMING)
 			setup_io_close(setup, NULL);
 		break;
+	case BT_BAP_STREAM_STATE_ENABLING:
+		/* For a Broadcast Sink, the ENABLING state suggests that
+		 * the upper layer process requires the stream to start
+		 * receiving audio. This state is used to differentiate
+		 * between all configured streams and the ones that have
+		 * been enabled by the upper layer. Create stream io.
+		 */
+		setup_create_io(data, setup, stream, defer);
+		break;
 	}
 }
 
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 17fedb397..b314b4b99 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2210,7 +2210,7 @@ static unsigned int bap_bcast_sink_enable(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
-	stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
+	stream_set_state(stream, BT_BAP_STREAM_STATE_ENABLING);
 
 	return 1;
 }
diff --git a/unit/test-bap.c b/unit/test-bap.c
index 9cfc8c403..0c190d7fe 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -6419,14 +6419,15 @@ static void bsnk_state_str(struct bt_bap_stream *stream, uint8_t old_state,
 
 			/* Enable stream */
 			bt_bap_stream_enable(stream, true, NULL, NULL, NULL);
-		} else if (old_state == BT_BAP_STREAM_STATE_CONFIG) {
-			/* Start stream */
-			bt_bap_stream_start(stream, NULL, NULL);
 		} else {
 			/* Other state transitions are invalid */
 			tester_test_failed();
 		}
 
+		break;
+	case BT_BAP_STREAM_STATE_ENABLING:
+		/* Start stream */
+		bt_bap_stream_start(stream, NULL, NULL);
 		break;
 	case BT_BAP_STREAM_STATE_STREAMING:
 		queue_foreach(data->streams, stream_count_streaming, &num);
-- 
2.43.0

