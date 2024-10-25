Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2066.outbound.protection.outlook.com [40.107.249.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1DC1F9431
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 12:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858955; cv=fail; b=a07Xj3IIEsTJ6UZS9gOktNp2KzMwS4wMgG8w/jG4PO+7/QdDK6Jt9jBxgb6V9of7WXRijStUhQEfgrea3qEsBmhT36Dk9iOI2L0VLnT5J/Bk24zkGDLcIJAoXKYoq/uM8mPlEcgEW16HaFFOu1wxxeeqBOFR8rG6XNorTf1acFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858955; c=relaxed/simple;
	bh=k0Grb85DTW9s6DmTJ4E2hrhFh7HxL63dPPfQupsqcbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j4zHf6sasA7ft9ac9EPIbSgPlFhpBE9ldlHdviPPXwDtFGgwlm8Hp3ZP2yM2LDzd9+kaj3NmfpZ9/14bDrzQN9wgMmGjnAb5MHonaHcWKXd1itllj8Z/VfbQOiXGs7X/GIQUOQHodudyQothyWEy6PJYVgwWcHWyc0Cuul0HNp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LeEg+OHW; arc=fail smtp.client-ip=40.107.249.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LeEg+OHW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wvMKlt2zxkbVUkCToayaO1PK+o3lrAOPMh3v+bQZQvDkqY7zFtBdBJfPvXkaQ3JTzNkLvlJd8Y4WmfTWD0kNudz4j93vdewdUea9WsySi74ApqIZ7DBv4oxYTkhO8Gx60ikxkz6GEUUxTpmv3wvSZXy2W/u8zQoVs4mGIi6AeTd2Lw1Z3+85at6DuX4B5EFEOSOXenUVAcxgZ30ho74gLOZuj9YlIt/CeU9ECmauiLhEHpWbDreaZvxArnVUmSkwDDgcp6GmKKTAWlO8kHn9Wohf4ioh2SsLgp61bMSY4i5POF9tQHE6nmZmmCFTmMyG+vFbMvR9fxLAGfTk2HIbeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeE1jA4drqJpvzCxsPahhw1a3hwWv+XOKINVATxOngk=;
 b=nFJeo+71BEGce2m6Rou82MzJ+BIlB60Q1XyfghYAsYltsMwf88DFQG3KjiKbsfFy7Uw3QuHYNBNsy7ITs3YVt7tZ8j3iQNcz1XAXlJXlIYBlw4J+sMvJ7Wrv2rFx0tC9aNGSk+StCZSGFZHUtiP6QXPhL7ND8LzyQ1CZb/Hijt2w2qZczf9DqFSOlr2bBoOD8zS9plDbyIdZg9CMdKfbBiJvOUms6wBeYCQ7Z2bLtWYDXPDAF4np5/KsIAKnQSAMyqEngDjjFD61cFy076iz0367pFz+n4StK2ThJEcxf9XeuUJuH3L7E1/PNg9IytLwkdnjZ6P5UdBr/ny9pk0QAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeE1jA4drqJpvzCxsPahhw1a3hwWv+XOKINVATxOngk=;
 b=LeEg+OHWlCj47SmcB1c2lueOkQyLrq1H5H9ZfM7eRbm0Jp4cMvrESxeVkinYeN3ypnyN+pUbKGBym9kwEX3moOU9EHKmRqZi1g5Sv275klqVOAxsNZTrlYakF5rQrLkKwu7axfEPR5R9H2e1S0pc4CAQnpFj7gbFvK/pb9CwQdHxyQ05HhcP+/8/Hk349JTytDZHKO+E+kAGY5ZupTQw4pLf2oW5jqpnRsYzQS1RWBNuPpYV2fLBvpoS1MCibnU7dsYHLdJQpmlLAJviL/DJydzk6PuwWiA/Ija0RXwTXtS+cg5kAemfP2NY819vI4HilvBDnmhRWqwrwU4k0BjzkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI2PR04MB11052.eurprd04.prod.outlook.com (2603:10a6:800:272::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 12:22:25 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 12:22:25 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 06/14] shared/bap: Handle multiple bcast sink streams
Date: Fri, 25 Oct 2024 15:21:38 +0300
Message-ID: <20241025122146.17925-7-iulia.tanasescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c534aeb7-eb15-4624-dd30-08dcf4efaf1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fLrPemtrJGZsluj8ODR2Y2Qsig8QHoJ0PVf+gOdmxOobyK1mP+1r/FXXeIF+?=
 =?us-ascii?Q?o/K3sUBuitOY7wsAAGHoGVgeFeufSovA6vlQ2BsMqI9KZIBvinD++5a9DujG?=
 =?us-ascii?Q?AS6f4NEUZmThF3DS8doFAduZDTOoYhMsv6JfaIl/RT4VRts0Qj0E8919Iq5D?=
 =?us-ascii?Q?96I04FKWfLGoITX/1O/fX9H3vaQcZ89zHOxlubtMH1pKaXcVZ9Wk6rtNrKAG?=
 =?us-ascii?Q?5SJBcVdJdRFrkhyHF2WRc5c38dIKk1xHM0+aHAw63YQmjsTaGCalTWBI4po0?=
 =?us-ascii?Q?pdLpIc+Qw+PldBGnqrJ5EFH7PpbTF2oPcQE0N89RgLDOK4OK4+1xYjlo1mPS?=
 =?us-ascii?Q?4KtOpsSWTQhtaukygv9gF6V9zTDxtcl0IIcdr9XsTQetIvjgpNI6kef0guIc?=
 =?us-ascii?Q?BjtHSPO+zE2E6h4QdKzTJx1q0oc/vjhjkFizeMi7BNR/InxFKVD/i1MVxkqs?=
 =?us-ascii?Q?sAztHT0wRqoNRnAqp/GdcV4GHCOU+7FGQJZweRiMH9QOVAKWszDKTZEz86jT?=
 =?us-ascii?Q?XDuwOun/gKLjxl69HG4UvmnNnoDELilapZI461dhpi9P1pPHUL17nHY82fF4?=
 =?us-ascii?Q?lpp0W1CyKyI8z52smRg5zpsWjrJGOCEjxagCYk76W3Fcaj3gTo/7uTqYmSjh?=
 =?us-ascii?Q?qr+6XinVQ76vzW829eeOdmWZQwJ2p8k16lKTrBEWauDzw/IUKKTS06cQUBZ6?=
 =?us-ascii?Q?/OAHCC4pehg6OE7PCIwec1zqKJZZ+yXRScMDT2neq0ARpFBfLGrEhs6fLJWe?=
 =?us-ascii?Q?Ia3BDZXCXrqEncVzuqRKN6ogI01aUNUHYvyKKaen6csE//opU2vFvJFe9KFR?=
 =?us-ascii?Q?LTStd2JL8ELTGaUgv26HNilXMzoGexL+mA7yEWY//wgfYl0OU3sU3OVNtMMz?=
 =?us-ascii?Q?YgzIPf0WESNYcmBQ8EljCalEABFSJdLIaVUYT92VTbFjoD4lNGvlcFf9fY0B?=
 =?us-ascii?Q?Xc00j4HekGPVZ/QEqRPpwRrwfakCQnV1VhmBknzrJ0v/yX/ISRiOTzwZnBmO?=
 =?us-ascii?Q?ukhS3OrPBHJ+ij6DWeiBw09oBpdMbttYAm7GnvnTktQ6sNkGBbyLfTADQxUO?=
 =?us-ascii?Q?ovneQSb29VrAhmEVllNghNhlo7Wf8horURl2dQISei+Z4E7ecRHc/z+8N1kG?=
 =?us-ascii?Q?V+s9csg2NOdqoFJPUjtfEWwJc7A9hDMrr+Ft+Bd5ytAA2OX0S2PvJahfg2CO?=
 =?us-ascii?Q?8vpIFhbuAO1z7u7Zz1eSzugBlijMiHphNftChfEKwXbQ2RssLReHWe7AytPm?=
 =?us-ascii?Q?03Xo8ErUsa9OJ47pq5cumTLpS9RbRrurfr/naSbYpclIg+6YYWbvxiFw8qDe?=
 =?us-ascii?Q?NrAF4M6jRWNT0AolocFXoIZenM5DZAYr/jTb/6dCvw1WbdQQexhPdteBQOjk?=
 =?us-ascii?Q?gZ1cI2g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gcZMP26XjBBYH8I+DzUazkHkPhMV29B7f9CuT8QV/PvHcMVNJNwsUgS/L1x5?=
 =?us-ascii?Q?j21E8UEnjHXuWweCpJ5jIT5xMxvTIcfgZzw5Z/ldYXLJEa/ynolYxcJDsLmD?=
 =?us-ascii?Q?DH4PsYDN9eIRj7NLndXJZ4AUDnumy0e3ORxDtJtBUR/mYK+XGvzQh3ykBQzN?=
 =?us-ascii?Q?ubj7AXkpnjhIDAgWf2odbHTAD3nEznu2rOb92HOEBYZZgpQA/JAogguDBWwh?=
 =?us-ascii?Q?JLsNBaxyvsU/7Uz6JnLpUHwZam4DRSjFbU8RYtVg6SSEhMAD1ky4VAyc32Ak?=
 =?us-ascii?Q?Gj7GM++Tn8wS0YUan/be/T3DU5P9mZUYnt+ox9itn9D5ed+bYQkN1u4vo3em?=
 =?us-ascii?Q?ACpD7BSBdqm9pBefSIhmU/ngww56+OnGiNrykmM1pluoS6SvqMEhS0ELQZFJ?=
 =?us-ascii?Q?qkoc1qpG3h4bDPh4tPRU6/mPLeR8S6W+ZvZQmTvALXIyhlJqrDTG1oMfuDjQ?=
 =?us-ascii?Q?BcrCBQ59bPqS+U2nH+w3CPuYdJnQqS1UrvDzxTu0lobb9KTWbfiwXjAy+zf5?=
 =?us-ascii?Q?USf2CSjxUEQsB2JDFVcaUIaIRTEnONkI+oaqJ4ae2cknr4JoVYf3yjSi3O8I?=
 =?us-ascii?Q?X/fgaAJjDrN1vJeKqkfBSVc8xvkDpVOmEqPOi8blUbZe1zQ0Szq3MNU8ST8J?=
 =?us-ascii?Q?IisKCaD9cSY0DQzAjGdm4ItpN0th+sH3l6qNKZKnPNVuYx3SYe/03ykEX/4X?=
 =?us-ascii?Q?4zY4NYluH7arii6p7Bz76HLn5RY7qcwVSQTWYxaIlIBJx6M8ROQLBrBU2n27?=
 =?us-ascii?Q?+n5NoHNy9boVz0RoTXCgqk7WACXlFJrkWE1BDWnlnMso2Xr1mN1Sgoma/Gv+?=
 =?us-ascii?Q?FrTYYSLAUs192nkYkx5MkTc+eOi0Lw/wU3QFwBtPItPjS8UmcjrcNH/jqInf?=
 =?us-ascii?Q?0GUS3fGILPMIXRKri96CEarnwZ1gy1LmWQ/CMsrDpBwUAgEVnmkxE9epKIUm?=
 =?us-ascii?Q?KDFEOBLxU2Re7WfdFh8b4ewjPdHGUOJSUiBEMMS0eJxGgq7HzdhESYFX5Isy?=
 =?us-ascii?Q?kkXRYlZgvsnrfLSjbtaEREtkjMYZYmW2NvyScHyBjZAAD9fuO89jSsUmEYMt?=
 =?us-ascii?Q?mt0szUgdRQFaVu1a3WYkWlFdErzPEUtg8ogwCwYtonm9ScTfTGJkBEJJGWA5?=
 =?us-ascii?Q?8+O9xnMr/mOQGKXMHRZrcZJNjO4XXy3PlvJUO7VL9BsyvTqdhh9Me4K0n1c5?=
 =?us-ascii?Q?ZYWR4yB90OAwH0pKtHLp0Y2BiNej5JKWCZ593N7/lzNZiauRye9IMmzMA9Nu?=
 =?us-ascii?Q?pu6Z1Yk824HwOKkCrUV5lYNHx5oJJcvsV+EmMjqbH3jAiYh1cmK5yBMqI4x3?=
 =?us-ascii?Q?dsIj6sNiHhnGzDCUI7O6Sm5LortiWKeJVp1hERHNusHEcRZgcslCukvxCbNy?=
 =?us-ascii?Q?AnG9QWz3Mj8rdhZvuuo6EojnoO5nFJ+d2HEGhmjR9Ipqg/SqdnTbI/LFf6h/?=
 =?us-ascii?Q?oGToQGA6Lfj3A0zgT9JEYcdusYlvjs1KMQO/gDq6XxwwlAuWw5mRL/GLFeUL?=
 =?us-ascii?Q?TAaYXrsZlEY9t8G2Ewu2qZArwYtlJ66V9521o1aXRgZsIhfi1l0dX7wbEBDJ?=
 =?us-ascii?Q?IZwxX9ua5xydtRSnmOvcoCPMLiMZ702XBh/QU6CdyW2G4ixxKtdTakxvSqRO?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c534aeb7-eb15-4624-dd30-08dcf4efaf1c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 12:22:25.3977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qqQjaRKGqb+x7E3SSZ+rKaOFPZMj5jrasBun8pxVCO28oo5W0Yjp/v3wj7R2k7kh6o7dn+T+VbKie2NbKB5jbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11052

This adds shared/bap support for enabling and starting multiple Broadcast
Sink streams. Stream enabling should fail if any other Broadcast Sink
streams are in the process of enabling or have been enabled for the same
source. Also, a stream that has been enabled and already has the fd set
should be started on the spot.
---
 src/shared/bap.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index b314b4b99..dad510aec 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2195,6 +2195,12 @@ static void bap_bcast_set_state(struct bt_bap_stream *stream, uint8_t state)
 		bap_stream_io_detach(stream);
 		stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
 		break;
+	case BT_ASCS_ASE_STATE_ENABLING:
+		if (bt_bap_stream_get_io(stream))
+			/* Start stream if fd has already been set */
+			bt_bap_stream_start(stream, NULL, NULL);
+
+		break;
 	}
 
 	bt_bap_stream_unref(stream);
@@ -2205,11 +2211,40 @@ static unsigned int bap_bcast_get_state(struct bt_bap_stream *stream)
 	return stream->state;
 }
 
+static bool bcast_sink_stream_enabled(const void *data, const void *match_data)
+{
+	struct bt_bap_stream *stream = (struct bt_bap_stream *)data;
+	struct bt_bap_stream *match = (struct bt_bap_stream *)match_data;
+	uint8_t state = bt_bap_stream_get_state(stream);
+
+	if (stream == match)
+		return false;
+
+	if (queue_find(stream->links, NULL, match))
+		return false;
+
+	/* Ignore streams that are not Broadcast Sink */
+	if (bt_bap_pac_get_type(stream->lpac) != BT_BAP_BCAST_SINK)
+		return false;
+
+	return ((state == BT_BAP_STREAM_STATE_ENABLING) ||
+			bt_bap_stream_get_io(stream));
+}
+
 static unsigned int bap_bcast_sink_enable(struct bt_bap_stream *stream,
 					bool enable_links, struct iovec *data,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
+	struct bt_bap *bap = stream->bap;
+
+	/* The stream cannot be enabled if there is any other
+	 * unlinked stream for the same source that is in the
+	 * process of enabling or that has already been started.
+	 */
+	if (queue_find(bap->streams, bcast_sink_stream_enabled, stream))
+		return 0;
+
 	stream_set_state(stream, BT_BAP_STREAM_STATE_ENABLING);
 
 	return 1;
-- 
2.43.0

