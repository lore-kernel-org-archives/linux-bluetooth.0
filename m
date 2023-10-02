Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209DBE743C3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Oct 2023 15:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238134AbjJBPeK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Oct 2023 11:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbjJBPeJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Oct 2023 11:34:09 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2087.outbound.protection.outlook.com [40.107.241.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F359EB7
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Oct 2023 08:34:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liFG0SDLI+metZX3yWqgCTYuxIv0csd/xywywjMO0rC61eaaY016nYEO3NpiJfHWOP5LjTeNaL1i/WurJSbsFwUPEm5wmL2coeu6rhJcFDKEEa2br1Ple+PAKeaPtDH/m001XFBnXgq3owZcYgnBm2xcln/5zCHJVS2S3ruNkprZtMQT1t84UFOOhU5cf64qZg09W0b2pDV1lTUlkHbJAxrz/KBDCAU66+6VBUAZc6MLeOueURbo4G7sXxVeIN7JvNhKXwU7eS2j5+9pahg7433n0ivOb6apUZrtaT6+DnKZhZV/RcKd4HN6oBx4EW8/34+UqnPjaJd87sj9lzbnDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kz5QI6WQMn6cnpEm0g/1seYaY0nchyG0MftLd55y+vI=;
 b=ZjfWEi5cvPt4n53AK3/31xbltEqTVpjkBXfQAf9/jFE3mC9xG6BDU2Z7pJ3klyE2mXCsmi8EmSeWBmTQUKzO0ECz7cn9UOR5ybL9LcnxkguWEeJ/lZezPSBVuwvfwLebVvh2Eq8JEGH9UgiE7TJu55U1C4Z9slVp+FtbELptY8t1MTyhMCuaNo8jwIUiD3Wssra+esFEfG/APXGR++wkAOICECbj0PQ27uoYqd42QJsnXiJkwwRjf1lOZpUdz77uc5zadfghKAt9GZFPRM6EMDaR6SojJYwdAe+u55+dKjKO/0q11A8XbCk7WhN6wAxdfdihvrvBEGKbvUWV9k6Iug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kz5QI6WQMn6cnpEm0g/1seYaY0nchyG0MftLd55y+vI=;
 b=Ht+534lGDmumYHDBrWntAERVonbuZ4kigfsrwZ/SSuw1sffa5OI2hbWG9494JCmGRqeasLDl1bz4xRPB/ImNY4jLWBg27YK5RmxwQseDnxJ7nCNY2hITMjBG3lH7dzr+797T0Qwi2qQRfo0UgKdvwW+jjUfqhqRO0m/p0IE7IWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU2PR04MB8839.eurprd04.prod.outlook.com (2603:10a6:10:2e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Mon, 2 Oct
 2023 15:34:04 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6838.024; Mon, 2 Oct 2023
 15:34:04 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com
Subject: [PATCH v2 2/3] transport: Update transport release flow for bcast src
Date:   Mon,  2 Oct 2023 18:33:51 +0300
Message-Id: <20231002153352.3163-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231002153352.3163-1-iulia.tanasescu@nxp.com>
References: <20231002153352.3163-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0502CA0008.eurprd05.prod.outlook.com
 (2603:10a6:803:1::21) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU2PR04MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: 74715c15-3f7d-4944-6fb6-08dbc35d026e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WY5HyawlAUD6NFchQxVSrQyY6zBcVwB7pnHi5mEMtnRLjkr5F69TN/7ZBPBbBz9TuxW3TiBSaFJc/LDFRLF8VXtaed1/fwA8C2bPKI4OnfYL6SGVf9DJN4s3YZG+qsYv6wD/njNhFSYsV/lG9Ha1+9ppmFiwaxWhC8/muxBMRJWGHjEvC75K/Ub+TmYQijFwRQiRzJZeri1gyrz2mRHZA1bbtucahh2wZGtUQ3zkBghiYqBnpmiv7/T93O8Xp3JDNOpCRPICkpK+/7yaP/mHxkzjFhMutMUz9swgJkW3nt7V22GooRBnRk5MTRBwginp1ZUEcErgFOOOD5Ao3j4uxKxkNCLStz5Pn47JEDV+BWNtMr+3Vb6VEtI+pM15vYzPrEGEeb71FONTLwt+3GRsakfez4gF+VqzrxxmrGRs5NhN5QUjuGUDiCnic5sAqGFfMZ3OcQeKWXtEAHII1kLmx7PJdE4pDXhkGc0P3T2zBNeVv3jWZCRnPWVuq6A35U5mUomTgLMUkpMRdbQBOQXTBsbjMIVy6YuHdNoAQRYYgx74cAFVAAupCpfWdqPE7OfE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(346002)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(36756003)(2906002)(41300700001)(6916009)(316002)(66476007)(86362001)(4326008)(8676002)(8936002)(44832011)(5660300002)(66556008)(66946007)(15650500001)(83380400001)(6486002)(2616005)(1076003)(478600001)(26005)(38100700002)(6666004)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zZ/8oSsEQCRZROfuglCizXHnEZSNNiTxMlCSHA6J9SkUCOcHp/FI3x/XG/rp?=
 =?us-ascii?Q?OrJ2VKCGuBauUVQODr6R+ErAl2NeWgED4Mw047y+JAE564WFUtrXI3wfnjus?=
 =?us-ascii?Q?dYvO7anyKzXpiq17X1Jyt20NxgXJwN8GJ6I3LCMhl3zIH5CmQUgEYRGqE62A?=
 =?us-ascii?Q?HYC+WI8j1w5f9jKP0bIwFrhKvpkMx9yuB7gsS4gOFEYDaZueUMQPrQq9nvHn?=
 =?us-ascii?Q?7S7lXfrratwQ37j5XC2gU0tXI1NQDA1Z6lZJE3jmTt64A/C2d/ZA+TOWh7+h?=
 =?us-ascii?Q?av3SyLkNpUa7R9ENguRpjO5G0KrgVUdbdaDoSRxQLFiGqw93L0R0ojDgNAcl?=
 =?us-ascii?Q?zRT5ztw2Xg0DEa2X5xXgMtGnLnBtxvEPmJMfj2V0kr+9kv7ISHOQfO7xk76b?=
 =?us-ascii?Q?vqJ2skWXaEsINRs6UBacT8jUfR42w+8wLgpqOG4WlxHB4BC1CL3F9UhuHKyP?=
 =?us-ascii?Q?SUPdiXF6nVoy9AeCGrtHE8L7e+NeYXzL5R+TzHWzbYDrbWyuOg6st0pNHYpC?=
 =?us-ascii?Q?gWys68R/JC4R+sxiOIZ1hYGw0M2YiRgs136yrmlXCC8T/sUFheAbhGHWWOA9?=
 =?us-ascii?Q?87PswKDR5y+SbICFSdU82MQXltYGLuBv/ch+Jpl0yjL5XJwcinslVKvL/NA8?=
 =?us-ascii?Q?fuwiTFpzcb+S2aUN+sZ95QeDYwxUUGGyWwyKvE2tuIixu/W5OUyjWaHKf4Kf?=
 =?us-ascii?Q?WmWa1hpPAJ6hldnvdvVd0Y2IvJJ/sUplAAvNbbXUGRCRNY+Jm/FOU9tqsiWG?=
 =?us-ascii?Q?+41OHVIfWkDYn3PRhCKJujGg0VeWU9lqvt9z8bO3FYd/KMRR5b7nO8EtkW1U?=
 =?us-ascii?Q?8cKdrt7RQ4FVm1KeC2d/apGqFF1IZFmDuV7+0V8BA5bSmyE5gYx0mtiq4fA1?=
 =?us-ascii?Q?XVct546RAsjh0dlzF5C8d4R366tcaPJGjwmZx8+nDQn0vNqHa4B6eMH0BkyE?=
 =?us-ascii?Q?wm3y6rXzwMbMSw3QbrYRLAtfcbv1qpxDqMDObyP6/RhpzuPd3aLM6ow2BKvq?=
 =?us-ascii?Q?tZVrJmozTwudtfMkHikMV2rc9u52Bi1EyqadPObYDJzZAoyeH9Aa2tz59xb5?=
 =?us-ascii?Q?mz/CRG3b6D5gWpgz1QiBqREU5Ic3MZvPvjCRW32c9Xwu48zIycktkJ9FTPs+?=
 =?us-ascii?Q?DyDXMl3dyWARfQKEaE9xe5ASO8ABtaEl7HUlX3SVSzjB0ujdcIW1+dfv4NOf?=
 =?us-ascii?Q?pEhngKL7ML0d+ntRUzSIn/KZVv9qwoMU5MrUmSU0frNer8eUSTF7Ei3+QdSx?=
 =?us-ascii?Q?/1s928tdAaCgHZ1sBoAFfcsnKfPzO2cBZhHAJ0D1Dd29XgdqP+igFjDdBJoX?=
 =?us-ascii?Q?QdHZuqJtJY6byN5bN4k0PZsQQJ1tjM78bWtLVNkabOS1NzaGGeKHtxnJiK06?=
 =?us-ascii?Q?ApT+aS/s7CoRplfRIz75eNKP8YSPKjH534WeM5F8FMxIqIl67mY8xbS6gUSu?=
 =?us-ascii?Q?1U+bVS72nwztl6feAEMkVFedT4imZe/SzFGzqfj3qxRRbMweSN7HxyrxRWIX?=
 =?us-ascii?Q?uHN3xONg0bN2O6g231wttF+voDyollnMS9hqSbrWCZaDvzu1DT2pU8w1Vban?=
 =?us-ascii?Q?4wpS7bpCrh2H3nTl4yeHMZkDuGVgkhHvrjwqiYkbs18S35MZZyN82vHPuYX4?=
 =?us-ascii?Q?AA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74715c15-3f7d-4944-6fb6-08dbc35d026e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 15:34:04.4961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKZcdCEDZAH2f2l/EDOm0zO2rfOcEwvt3/wVXlJWEAhXdQBBvA18TTMPXiDU1g2Sy52ZKpZ0VV2YgPiW77Dv+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8839
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>

Update transport release flow for broadcast source

---
 profiles/audio/transport.c | 63 ++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 1e03b7b51..646061358 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -606,11 +606,38 @@ static DBusMessage *try_acquire(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
+static void bap_stop_complete(struct bt_bap_stream *stream,
+					uint8_t code, uint8_t reason,
+					void *user_data)
+{
+	struct media_owner *owner = user_data;
+	struct media_request *req = owner->pending;
+	struct media_transport *transport = owner->transport;
+
+	/* Release always succeeds */
+	if (req) {
+		req->id = 0;
+		media_request_reply(req, 0);
+		media_owner_remove(owner);
+	}
+
+	transport_set_state(transport, TRANSPORT_STATE_IDLE);
+	media_transport_remove_owner(transport);
+}
+
+static void bap_disable_complete(struct bt_bap_stream *stream,
+					uint8_t code, uint8_t reason,
+					void *user_data)
+{
+	bap_stop_complete(stream, code, reason, user_data);
+}
+
 static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 					void *data)
 {
 	struct media_transport *transport = data;
 	struct media_owner *owner = transport->owner;
+	struct bap_transport *bap = transport->data;
 	const char *sender;
 	struct media_request *req;
 	guint id;
@@ -642,6 +669,11 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 	req = media_request_create(msg, id);
 	media_owner_add(owner, req);
 
+	if (bt_bap_stream_get_type(bap->stream) ==
+			BT_BAP_STREAM_TYPE_BCAST) {
+		bap_disable_complete(bap->stream, 0x00, 0x00, owner);
+	}
+
 	return NULL;
 }
 
@@ -1370,32 +1402,6 @@ static guint resume_bap(struct media_transport *transport,
 	return id;
 }
 
-static void bap_stop_complete(struct bt_bap_stream *stream,
-					uint8_t code, uint8_t reason,
-					void *user_data)
-{
-	struct media_owner *owner = user_data;
-	struct media_request *req = owner->pending;
-	struct media_transport *transport = owner->transport;
-
-	/* Release always succeeds */
-	if (req) {
-		req->id = 0;
-		media_request_reply(req, 0);
-		media_owner_remove(owner);
-	}
-
-	transport_set_state(transport, TRANSPORT_STATE_IDLE);
-	media_transport_remove_owner(transport);
-}
-
-static void bap_disable_complete(struct bt_bap_stream *stream,
-					uint8_t code, uint8_t reason,
-					void *user_data)
-{
-	bap_stop_complete(stream, code, reason, user_data);
-}
-
 static guint suspend_bap(struct media_transport *transport,
 				struct media_owner *owner)
 {
@@ -1499,9 +1505,12 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 			return;
 		break;
 	case BT_BAP_STREAM_STATE_STREAMING:
-		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
 			bap_update_bcast_qos(transport);
 		break;
+	case BT_BAP_STREAM_STATE_RELEASING:
+		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SINK)
+			return;
+		break;
 	}
 
 	io = bt_bap_stream_get_io(stream);
-- 
2.39.2

