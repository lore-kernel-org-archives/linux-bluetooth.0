Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCC2E784BC
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Oct 2023 15:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238135AbjJBPeP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Oct 2023 11:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238123AbjJBPeO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Oct 2023 11:34:14 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2041.outbound.protection.outlook.com [40.107.241.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DD9BD
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Oct 2023 08:34:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBSR3qBdyAozPoM5gSVUxhzxF5JzJmsDYoxus954yIgddZYT472U0sf5etJgO3sZF/MZDY4sjIFGyeTch+SzqtnJACfNw/D9knK0LW2RE6YwV1+YE010WqgbVXxcIK+yh8QrnO4QNcdmtMuLiFhl4CJS0uCZ1wUgYNWJjKAwHhr3vOZ9RR5Ksu6lTwabPahiBJG4QZa3DyqAFv3s3vFHc9EXeFki2W3fTM2qU4/Kum8wCVAR9QaNoirDJVhSW+H+IosHhessp9swmr8pJodFDTGnZwNvCobrejsvIr6UXaf+Ia3TgvCRR2RiiDQutx10IFJsv/nwnJyrvrXvF0SCsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiPDUswL6jCg5ollJgqjcCO4jzlrHvAH0G0HqFV3/QM=;
 b=TnM3y7ipwCfS5L9jjdImjq5ahEcsc1eAU/UP/GRw1xRokjGJp6bo7QkfOCu+pi1+GXHuody7G0F1qJ/1VV62/eo24QTFNNej3HNhQ2X98HrXtRFInV4SSH0RT8bffabZt6wBsmSluJAYKfeyGqxiNqRKS1FekDDlnkJa8PsU1sfa6e7GRZ1Njeajei7Zm7/hRsu5IWq4wGZd3oeq1FPynnDfpf9+uI7cTp0GBXC9DjUC2ivS3WNLKEj95JXOlT/FDdX6JphySIAmGeRcqX9ZMkI5uq55TCfga+m8dM+HbpatLocJu8FFmECk/xNKG29vB0yBvMJL3r0xPRvBi5Jbuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiPDUswL6jCg5ollJgqjcCO4jzlrHvAH0G0HqFV3/QM=;
 b=rqTNlanD15B8+zgCYwYqsGW73MJwD9jl1qYqUg7vrXPKVZTlKb/dxoqbSa2E9cPDFMKM/wT4m+KKniOLLj+vmDV6zFAJWiBA5uvgpSAYFqw5A+Wqykw11V7TRR8LHUz0yt3tSQyGDt4a+tHz6udhx3ZzFu35pUsgQdN8kVKZe9E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU2PR04MB8839.eurprd04.prod.outlook.com (2603:10a6:10:2e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Mon, 2 Oct
 2023 15:34:07 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6838.024; Mon, 2 Oct 2023
 15:34:07 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com
Subject: [PATCH v2 3/3] bap:Update transport acquire/release flow for bcast src
Date:   Mon,  2 Oct 2023 18:33:52 +0300
Message-Id: <20231002153352.3163-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231002153352.3163-1-iulia.tanasescu@nxp.com>
References: <20231002153352.3163-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0035.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::48) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU2PR04MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: 265e739f-012d-4da6-e20a-08dbc35d043c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D5gfJB11V8/LSEiRnGkW/MoVrcP76cQJrHtNxV/3mnpc9vWjYA8vWD/e1lGNfQ+XF/gsroqiEKYSVU4qb5WCaUQ4wNw1VmC2bALFtr2ac4mGoQ9ssFS36C2LElIvTY9Z8WtuEj76ZnG6e5UnE43sMYYwQc+bMgL6Tiu1pbNx8fbTS4xaE7joHNw80/0oGgXPo41fQQrMOyCZVjhJxE4fcZcDkGMJgAnN4tjwQGigngukQJ9odbQYz1Q2ildOClJSP1qLHI9RqmiZH1F71fNlY2OxXojj6TK0jIgfmVnL54jBr9qYveJ+bbFutwDsKHh9u1a5ZPVrG9iLKz9OsOdKpP3MZ+REFr18QD7f8hKOv7antovONfkC5LVsL0YqY5tmaH8D0YyuEWI9NVtWlSWQ9XKHYlk+ke5902ClX8xn7nrkbZko9Au3vHzP2Wg0S/4C+NQxHhF90P96xZNNEWF5uDLD6O47x/YbRZ9qadlqS+w/rVc7F109GxW8BOQlqNtgY3NvJvDIHG8x65BO9wFCgeb83nn/jgj+WIy3EQ9mvUihhWVYfdMFcEbqYwIuTlZ/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(346002)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(36756003)(2906002)(41300700001)(6916009)(316002)(66476007)(86362001)(4326008)(8676002)(8936002)(44832011)(5660300002)(66556008)(66946007)(15650500001)(83380400001)(6486002)(2616005)(1076003)(478600001)(26005)(38100700002)(6666004)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6FGkAbpSwyuj8FuMRj4ofliUyBh6v4wrfBcH/Vtp9Z7FlmEQ0T6TzRvl/tlG?=
 =?us-ascii?Q?noa4Ocylo1CVpgkdCxFKGtOlN6N8bLSfmNSGJtL3jAeuvqO6aHuK0cTfwk9k?=
 =?us-ascii?Q?n22mWGT2TVJ+W7UZVuyV0Ak1rRDZbBKmBKSwDgRDipiWE1tZqS8qrpG5z3Z9?=
 =?us-ascii?Q?t4qj39fDzs+nGeYzJ5/SGOMOdS7TqrZkRZQ5j/eldgbKn9sHuwdmG4wpfbWD?=
 =?us-ascii?Q?NJk8/LdJx8m4ClxtUf07lZQHkBwqLQnx+jRNciPIxaREU82tfk32zzbrjr2n?=
 =?us-ascii?Q?zSAqrov1a2gFR8nNbUC+44KF9Ham6YZPy3rPxMWEKzZYH7lSYGcnX7KBzZeI?=
 =?us-ascii?Q?blIGJ7cwjZZbQGPSU8kSqZeGB9wTzXApQPTHh7xs7T91C4zmKFNwf69uLUhm?=
 =?us-ascii?Q?VnE2N8MfDBJWgt8URt9YXBCTAVxtn96ifrJYJ6j0IOS9DDgD4cSY+Td8rzSZ?=
 =?us-ascii?Q?wk0aqNv7PioXivDCPor/3sI+uteFghqr782aytIkZPpjG8AMYZZ6PfImfZjD?=
 =?us-ascii?Q?RkQlmEgJAXfE8RpRU0Alz9L22qX1y3muVXCAfwv78yWA5ej8bLzS5sJ0pUsf?=
 =?us-ascii?Q?gePQkNcDfbyzsIz97vi3OEZrt5Iz10nfuPfHrHVbu63TNavlCBDIPkk6Y6+T?=
 =?us-ascii?Q?c026C4jNtiL6XH1/AgoBP2zpnP0WbGL1HC5tj7KVQAXwh6F/KoBYDOPKWcLv?=
 =?us-ascii?Q?T3u3NBIChg00Yb6FwbCtAyX7abhTlNAenuYtRmuaL9wnRG6WWWl5eSFNsYPq?=
 =?us-ascii?Q?jBR1m86nAFm7r+0EZ9+GLJPLNAVN+/UdEeRGNNbvZOhagme0cGkwkzyWHOom?=
 =?us-ascii?Q?yzdS3jEZflUEfU+BNBjA6tCUJ13SK9BqORcp9ZmbxQSyS0bQ0yeyU4Q58vys?=
 =?us-ascii?Q?XYDw+XVxXDHMXCp2LwRgtsPb8u8pkhvFZrvYSMxorJtRvGbBTyS6dSFifUHp?=
 =?us-ascii?Q?6WSW8Y6jPL/B0/EiOnTlcgFIUZkrk+8MLcdC0POdb5NjPs7EVmVmPUfP1sEA?=
 =?us-ascii?Q?IlkcExv1U6QktazW5+Z6SONiHnMn6YxqiYaCZl1pXNSNIr7r02uAHxjSyw4G?=
 =?us-ascii?Q?i+FEGMDKbQnQqxlpoVktLvkgVL1jC5CuXxPdllzEgMOlYrsuK9OLEPijCD8v?=
 =?us-ascii?Q?fmsReDh9Ag0y9Is+z2ZTM1hydxPkxhqoWlWNaveET1z+HpBYgiLQqz06oCqy?=
 =?us-ascii?Q?Xz+lmgRGDwQfln1PQzqSFFkkeYwr9MD4GeC6QdaSHmMyjTjSdYqSGTxcOlEb?=
 =?us-ascii?Q?Kk9xrmYchsiUWcMbt5Lt1op7CS5mlK0HAIk9bjIIVS0H2VYrVG1a1VfmExix?=
 =?us-ascii?Q?kPTittpXPvGhhjuDM5s9WVpNn6kxQeFiJ7njKztaau2DbI48p6GayNcRIdQ1?=
 =?us-ascii?Q?55uLqaaVNLaYxBMFTas41Gj3npGGUKVKNSPGm++sSDDThjMOeBhh3MFNm3ug?=
 =?us-ascii?Q?3CzVnbRCZRLJduUU90uD3fGyAzr8eY5a1sbTbbz1vQKfu3zdx3FlXvDGhDgV?=
 =?us-ascii?Q?WE1pm6MXjxFZ3MHAJ71Zya2S9lqlaa6eL44eRJA2QydJpJ/yI8aJsXqC52E8?=
 =?us-ascii?Q?EYbRV7iM/GJcLHZ+VLcN7ihyl0PZU9NB48ZDzdUQ/OvXNzxcYA5aHDkTAIXX?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 265e739f-012d-4da6-e20a-08dbc35d043c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 15:34:07.4493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UC3+jFqzs60kPkplmrL47/c7tgFaYcmkGukiQkjtNyasaFjsrDXOmZSoSzAI866VTVie/Hp+Gp3zDDyeYwEF1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8839
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>

Update transport acquire/release flow for BAP bcast source

---
 profiles/audio/bap.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 48a1a4f86..9a46b16ab 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1328,6 +1328,10 @@ static void iso_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	fd = g_io_channel_unix_get_fd(chan);
 
 	if (bt_bap_stream_set_io(stream, fd)) {
+		if (bt_bap_stream_get_type(stream) ==
+						BT_BAP_STREAM_TYPE_BCAST) {
+			bt_bap_stream_start(stream, NULL, NULL);
+		}
 		g_io_channel_set_close_on_unref(chan, FALSE);
 		return;
 	}
@@ -1887,18 +1891,16 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 		}
 		break;
 	case BT_BAP_STREAM_STATE_QOS:
-		bap_create_io(data, ep, stream, true);
+		if (bt_bap_stream_get_type(stream) ==
+					BT_BAP_STREAM_TYPE_UCAST) {
+			bap_create_io(data, ep, stream, true);
+		}
 		break;
 	case BT_BAP_STREAM_STATE_ENABLING:
 		if (ep)
 			bap_create_io(data, ep, stream, false);
 		break;
 	case BT_BAP_STREAM_STATE_STREAMING:
-		if (bt_bap_stream_get_type(stream) ==
-				BT_BAP_STREAM_TYPE_BCAST) {
-			if (ep)
-				bap_create_io(data, ep, stream, false);
-		}
 		break;
 	}
 }
@@ -2116,6 +2118,8 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 
 			ep->qos.bcast.big = qos.bcast.big;
 			ep->qos.bcast.bis = qos.bcast.bis;
+			bt_bap_stream_config(ep->stream, &ep->qos,
+					ep->caps, NULL, NULL);
 		}
 
 		DBG("stream %p fd %d: BIG 0x%02x BIS 0x%02x", stream, fd,
-- 
2.39.2

