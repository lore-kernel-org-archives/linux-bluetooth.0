Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350FBE784BF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Oct 2023 15:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238132AbjJBPeJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Oct 2023 11:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238123AbjJBPeH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Oct 2023 11:34:07 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2087.outbound.protection.outlook.com [40.107.241.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7DBAC
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Oct 2023 08:34:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdKFBFuxnElij99u3caiSbWR2SacVEkJGWjQbBYzX/7GukUV77wn5XFK34nMF/dJuuY22YOCfZ8xcr7To29f87WMPGw3KEaGKOb/68GvuUEQZQh6iwkVt1Gv+vMy/+Kv+OSUKp/QtKQhPMtk8R94+p1utu9sg9QDKuGC9nOXkos/5j6S/bxkX8YvMaqVVuo5FqMBeuEECwlOiXN/Pig1n3wGf/1bSdh0SHWlagYyL86ZUXf9v/q2rc+RHoKaYSlvDArjqXMqf9b2t9pZUMVJa07pex2wEfI9xd8q0OVVpvq32ItH3SlPCUeZSCpoCtZJXUfGRNqlVBm3c0z3iLlFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NaF4ya0ulJWcROa3yivS9ItCkXLU83x/5+W87QhvTsg=;
 b=CmMgO2LibxdIACUPOH0R07cfYJ+32j3hSlDrAZv1zfw/mWJ8afRYnyB3P5fm1/r4Q2qO5MORTZPIgRGiLKluRCJprE6lp7W+2mRUCY2HKbdJ1hGyc6gCmkjR0K5O0fer8YG/2Kefu+ykhBtCPjGBe0zVmHutITp64/rM+GBnEEELuOOK07jE0d13w1RQbpBXDyukf+fdD1ngUDRQN3TrVXdfIebjRiY6yoScbfZLXjt9oO8nttJ3EFFljf6zReA6sGG3VlxFwgDvsZm4ezeNIG0VQgIld1GAJr5Gj0AbXJrpjpNvlG9djfHTRp2lQBJxERyS32vJSFy9yDJMoWQKsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaF4ya0ulJWcROa3yivS9ItCkXLU83x/5+W87QhvTsg=;
 b=JA1a1d1bASkmJ9PBJgl6kmUB/ToTK28e/qzkIGTnEPZFcO6n/Zq1W+QwKfzjI/OHZGhr8OUc7tUnereGGvssj5+EbZxKi5neNFcd7LliEjbc4m7mSBDLdPzJ2RBE/oVs/3PQdL30lB7kNl7Z5Xecd53xbOsq7f0q2iHsHoAdr1k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU2PR04MB8839.eurprd04.prod.outlook.com (2603:10a6:10:2e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Mon, 2 Oct
 2023 15:34:01 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6838.024; Mon, 2 Oct 2023
 15:34:01 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com
Subject: [PATCH v2 1/3] shared/bap:Update stream enable/disable flow bcast src
Date:   Mon,  2 Oct 2023 18:33:50 +0300
Message-Id: <20231002153352.3163-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231002153352.3163-1-iulia.tanasescu@nxp.com>
References: <20231002153352.3163-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0051.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::28) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU2PR04MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b81b1f-fb11-4789-29fe-08dbc35d0069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cYAlwtOstpFaHBgeeihmKTOC9ARd3jA+f9AggAT1u5P5kRmZZwc7vvDLqDjr4i5ISNP2dF1m2JJr20dFN9CQS+OQUNHLILkljouOAz//BsFXhKDDsFsyWROc2gar1tPKRqSXLp3+3NBU1LD+NS3BYdazCr1djuRW/fYCwNtKaI3PLJLwgd8YrziaVvDmSz1TDcpxoVjkt0W7i69nkS1HvqpjTTytHLRLUwzNfiWaRNwwSRwg4iPh+otYau81AKtbHjw/txGyi5F32E//NXTeliFYddz90pLpBBEv5CeHY9kTdsNcBoV4qjjfbSAybGWrPpF8Y74I7uOnARY6zPJHUzSZArNkqVeIcvWwldxBbh/lBM2O8zs++fDPS6lcXd3sMEMHGCYn3AXKLjH+x9r46cm35QQXbqmS2MR7cub1TEv2N6SKj3v+eN8F9SPB5AKxUhof7gvSgS69cUwFif+oa8w4TF43rAznr3yi0sW3c+J2Kzounp4z3T/rj117ovQOd852q2y6AL1qqRs/tFEWPyRoEUcvb+CqbVINJlXuV4soNH9+gt38LDJHSB2hBObc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(346002)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(36756003)(2906002)(41300700001)(6916009)(316002)(66476007)(86362001)(4326008)(8676002)(8936002)(44832011)(5660300002)(66556008)(66946007)(15650500001)(83380400001)(6486002)(2616005)(1076003)(478600001)(26005)(38100700002)(6666004)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mZK/MA23UeVeXsCoQa5Xv1+gqOo7imRzO8GZMQrnYvkbHJHujWGj/qPQ44gj?=
 =?us-ascii?Q?rALUCzdhKAEVzoRhSpVpT6vA0Mt7gAcvNDSdPE+QmoL0h9TM1q5f+TsRPkvs?=
 =?us-ascii?Q?Mcx7HRIuKACBDAk2pSmcfAFXrfwoNG9z51PrVt7Hwr0J1M/aS+n2OkSnCfW4?=
 =?us-ascii?Q?d0viGdDKN3nGR5+Qy9uWWIXdU/VwmMtq9QCSphgVOJFj68osa1mPaG6sSz8V?=
 =?us-ascii?Q?qampUg+wVTu2dz9kS4F4hpKOzEJ0smBnT8RA9Cq2hqe0AzoLuROXJ2Tf3r2W?=
 =?us-ascii?Q?K5pFixLXK0KgfirlLIhwP26Ks8f2+1jstFElgKX6DHQhBptXewhuSdnhbglJ?=
 =?us-ascii?Q?Ca1DuInkAMeiHfKOmp0/GTXeLK9w5w+KbTHU3Yu6uYYDDplE3PeRF2QT6VoI?=
 =?us-ascii?Q?Z+vHrORL9W470Gz9BTLlKLBQkD4IKIpPnXUF6f+Kk1yBZRV2oWSWaqADU9rB?=
 =?us-ascii?Q?oGqhfdaJJZgoCadZkAN1iz8otrUpQ1IkNEM8SzLv6jTjrI8O2j66R6ia8TJk?=
 =?us-ascii?Q?EtQEY9CAj5/gsMVtFFaMa3RKLogo6v9yBioAPwcwimR8VT12U+w9ZnhNmCvF?=
 =?us-ascii?Q?x0bUa263i7T/VAEhR1Hot6TcT6cZ1hFyiQ5u+LzrnNu8dmI+VSEia8V7VjM/?=
 =?us-ascii?Q?uvSmUkUZdz7h9ir3lGtwX3MmrEzUT76B3opRxH9OHiv+3guGAqYoeBPNMEEt?=
 =?us-ascii?Q?fCKfjJ+fWCGWc9gMs1YrHK3MkglabSVZK3D+A+mH387NwJURIZh+MXAANpR3?=
 =?us-ascii?Q?QrPotGbwNGurB7DB5443T7MUgA6Gec4jhqi3o5ekGQi782izhTpNSKjhpBST?=
 =?us-ascii?Q?dexQ1YX1tTaXSPMFhMZKvCroEonDW/RhIFa70qo0OwbbGTOteBLV4JHq8p72?=
 =?us-ascii?Q?s6m206W7gxD3kkUuV4KEONcKATDTUlffOz32V8cbHJ/ZOSEdpfwpnjQLs8MV?=
 =?us-ascii?Q?ir3JCb93Vb132LGJi1VYI8g5xTsheNkRt4xsLd+zIlB/c6yJufNIvImymydN?=
 =?us-ascii?Q?7eAReHrkaCzJe0lrgKUu9A0tStPQ0QWbwFxcKGgzzEPMhNCEEo3aG83NltMw?=
 =?us-ascii?Q?2WR1PL22Uq9ued6m6EfkSBs2zndK4fKm21oKTCTvAOTODIZn1B/aN+4/PkWf?=
 =?us-ascii?Q?1ubGELTxdADysrBzzc16j+dH0Ty5ma475jE/IGLbXLghmffs7AKYGU/xYo+N?=
 =?us-ascii?Q?5O0Exz8EiN16bKEfEZ0PLy+3na068uMUWD/PGtkacQlIoy8hxcypr6/xvusm?=
 =?us-ascii?Q?8NQ4+AGj5pYIU84eIcAKEbh/Wk8GrZZxVPYMG4MCiwsP0jPheCsSP2nqxoyU?=
 =?us-ascii?Q?cKYlZ1jusE0Iu9Ks1VZdCA2ve1pUMvOphb5f+BS5NYBBnsjdoRQjX3pTw+Js?=
 =?us-ascii?Q?YqhXKJKz5xebOhjfolWMyj/PCpDQzXPw/w7UXaOphwxyr4qoz9jQNkZLTKJ/?=
 =?us-ascii?Q?A+5QzsRHlVAlWzY+Th3yJyNe2LGasjS43eC0W8oWnt/2YJ+MN+8xrcS0RW0R?=
 =?us-ascii?Q?7psL51sjXgfKWEBNlojyaUw2akVUnJS5abvcthrqKWPsZfOFvwIkHdq0OBLF?=
 =?us-ascii?Q?KOkbmcJ27HZ94EKMAN2pBRY1YD5UJaw2WQWeEGvQQudtUFqVshjM6wCWM4SW?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b81b1f-fb11-4789-29fe-08dbc35d0069
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 15:34:01.0571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7lmYpDauWWzb08gibS/2Nv2kBmttWBV0jwguXlo73TL741PRGiXu9HSrdA/0w+Ntfx80I3z0dcA3lKbThSFtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8839
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>

Update stream enable/disable flow for BAP broadcast source

---
 src/shared/bap.c | 100 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 30 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 9e9ea1472..925501c48 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1331,6 +1331,11 @@ static void stream_set_state_broadcast(struct bt_bap_stream *stream,
 	ep->old_state = ep->state;
 	ep->state = state;
 
+	DBG(bap, "stream %p dir 0x%02x: %s -> %s", stream,
+			bt_bap_stream_get_dir(stream),
+			bt_bap_stream_statestr(stream->ep->old_state),
+			bt_bap_stream_statestr(stream->ep->state));
+
 	bt_bap_ref(bap);
 
 	for (entry = queue_get_entries(bap->state_cbs); entry;
@@ -1347,6 +1352,9 @@ static void stream_set_state_broadcast(struct bt_bap_stream *stream,
 	case BT_ASCS_ASE_STATE_IDLE:
 		bap_stream_detach(stream);
 		break;
+	case BT_ASCS_ASE_STATE_RELEASING:
+		bap_stream_io_detach(stream);
+		break;
 	}
 
 	bt_bap_unref(bap);
@@ -1492,7 +1500,12 @@ static void ep_config_cb(struct bt_bap_stream *stream, int err)
 		return;
 
 	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BCAST) {
-		stream_set_state_broadcast(stream, BT_BAP_STREAM_STATE_CONFIG);
+		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SINK)
+			stream_set_state_broadcast(stream,
+						BT_BAP_STREAM_STATE_QOS);
+		else if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
+			stream_set_state_broadcast(stream,
+						BT_BAP_STREAM_STATE_CONFIG);
 		return;
 	}
 
@@ -4914,8 +4927,13 @@ unsigned int bt_bap_stream_enable(struct bt_bap_stream *stream,
 		queue_foreach(stream->links, bap_stream_enable_link, metadata);
 		break;
 	case BT_BAP_STREAM_TYPE_BCAST:
-		stream_set_state_broadcast(stream,
-					BT_BAP_STREAM_STATE_STREAMING);
+		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SINK)
+			stream_set_state_broadcast(stream,
+						BT_BAP_STREAM_STATE_CONFIG);
+		else if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
+			stream_set_state_broadcast(stream,
+						BT_BAP_STREAM_STATE_STREAMING);
+
 		return 1;
 	}
 
@@ -4933,30 +4951,40 @@ unsigned int bt_bap_stream_start(struct bt_bap_stream *stream,
 	if (!bap_stream_valid(stream))
 		return 0;
 
-	if (!stream->client) {
+	switch (bt_bap_stream_get_type(stream)) {
+	case BT_BAP_STREAM_TYPE_UCAST:
+		if (!stream->client) {
+			if (stream->ep->dir == BT_BAP_SINK)
+				stream_start(stream, NULL);
+			return 0;
+		}
+
 		if (stream->ep->dir == BT_BAP_SINK)
-			stream_start(stream, NULL);
-		return 0;
-	}
+			return 0;
 
-	if (stream->ep->dir == BT_BAP_SINK)
-		return 0;
+		memset(&start, 0, sizeof(start));
 
-	memset(&start, 0, sizeof(start));
+		start.ase = stream->ep->id;
 
-	start.ase = stream->ep->id;
+		iov.iov_base = &start;
+		iov.iov_len = sizeof(start);
 
-	iov.iov_base = &start;
-	iov.iov_len = sizeof(start);
+		req = bap_req_new(stream, BT_ASCS_START,
+					&iov, 1, func, user_data);
 
-	req = bap_req_new(stream, BT_ASCS_START, &iov, 1, func, user_data);
+		if (!bap_queue_req(stream->bap, req)) {
+			bap_req_free(req);
+			return 0;
+		}
 
-	if (!bap_queue_req(stream->bap, req)) {
-		bap_req_free(req);
-		return 0;
+		return req->id;
+	case BT_BAP_STREAM_TYPE_BCAST:
+		stream_set_state_broadcast(stream,
+					BT_BAP_STREAM_STATE_STREAMING);
+		return 1;
 	}
 
-	return req->id;
+	return 0;
 }
 
 static void bap_stream_disable_link(void *data, void *user_data)
@@ -4996,24 +5024,36 @@ unsigned int bt_bap_stream_disable(struct bt_bap_stream *stream,
 		return 0;
 	}
 
-	memset(&disable, 0, sizeof(disable));
+	switch (bt_bap_stream_get_type(stream)) {
+	case BT_BAP_STREAM_TYPE_UCAST:
+		memset(&disable, 0, sizeof(disable));
 
-	disable.ase = stream->ep->id;
+		disable.ase = stream->ep->id;
 
-	iov.iov_base = &disable;
-	iov.iov_len = sizeof(disable);
+		iov.iov_base = &disable;
+		iov.iov_len = sizeof(disable);
 
-	req = bap_req_new(stream, BT_ASCS_DISABLE, &iov, 1, func, user_data);
+		req = bap_req_new(stream, BT_ASCS_DISABLE, &iov, 1, func,
+							user_data);
 
-	if (!bap_queue_req(stream->bap, req)) {
-		bap_req_free(req);
-		return 0;
-	}
+		if (!bap_queue_req(stream->bap, req)) {
+			bap_req_free(req);
+			return 0;
+		}
 
-	if (disable_links)
-		queue_foreach(stream->links, bap_stream_disable_link, NULL);
+		if (disable_links)
+			queue_foreach(stream->links, bap_stream_disable_link,
+							NULL);
 
-	return req->id;
+		return req->id;
+
+	case BT_BAP_STREAM_TYPE_BCAST:
+		stream_set_state_broadcast(stream,
+					BT_BAP_STREAM_STATE_RELEASING);
+		return 1;
+	}
+
+	return 0;
 }
 
 unsigned int bt_bap_stream_stop(struct bt_bap_stream *stream,
-- 
2.39.2

