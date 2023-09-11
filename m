Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E913EE7FF4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Sep 2023 07:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbjIKHsZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Sep 2023 03:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjIKHsY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Sep 2023 03:48:24 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1EBCFD
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 00:47:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ks3zMaNrTwRLW/wZzBcIcXtLbd0NOEtuzlEpqeGP1tz1zixbOnpnMXxedvGXOtwKHgkuwAfyXdMNYYglarIcAtkIEAORURGfFmNc97NCch0enq/k9VOKel9KkCkMzquKuZVsc8nFhImFTvhVfzfbH4DULvgYk+3QCrzRNR2HVSgb0wSaama/zxboCKOwxCzx1MfglqB+m7s27OdgC6434wzUSxASK+vv5zcVR+BXWjRAoFDLsVG+NbjptfAyFWxe0uzXsICceM42zKAAW2A2QyKG+p9mmXpt826jaWkCcmO0E0hyLD46/amzGxOc/0leM02Mz3YsMrfRPf35xzZe0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iKU5510dISMwt7VzCJeP3wnjJ9lNrq0onUiD1j3zUE=;
 b=GI4fLquZCZ42o8Fv8Uhz00GczbGhnQeJMbxdiRrEVfNZECjQ8S5LYaPh904LqfdbjwH8vfTkt6OrS9nvrsEhfmXo3eovgN/X9pRFYMtpzH3eMSQxTUdcNVb8qym9yFX/vTspePJr8QpoxI00B4LSE23IgK/V7G4rbZmozi3qg99r2IVTw7C6otg22TUO4sevFNvEIGY1Kou7VNymI20uGD8VhxJ5cwzxu7mIwLtNjCMhV6iHIgcpG8gOBHdjA3i7Ed1tGKXAa3o/2Q7n2iMkmxLMHfpBksHCQYV6WpalCYY95uNh6Naud7U4CoKyT+W2s2IGA2s4zfvHeKxHj57NTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iKU5510dISMwt7VzCJeP3wnjJ9lNrq0onUiD1j3zUE=;
 b=GEWhRY7vi+CkPvOcpXh8kdah+00eiaun/NxOPkJzMkn26Eu6H7w1rEv9cHE9KHphUcpLJybw3v0e6AjL3GcIOwDt3MYOftHrEiVx+iHeLPAYFZr5ek9k7wtNhOsyEZpwCgoS343lc473X39fBJgRHaw9QT/YJwcYRyzGkfTPZVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by AM0PR04MB7155.eurprd04.prod.outlook.com (2603:10a6:208:194::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 11 Sep
 2023 07:47:35 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::7318:7662:8c18:ead5]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::7318:7662:8c18:ead5%7]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 07:47:34 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com,
        luiz.dentz@gmail.com
Subject: [PATCH 2/2] bap:Update transport acquire/release flow for bcast source
Date:   Mon, 11 Sep 2023 10:47:11 +0300
Message-Id: <20230911074711.62493-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911074711.62493-1-silviu.barbulescu@nxp.com>
References: <20230911074711.62493-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0018.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::23) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|AM0PR04MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: bb36803c-bd7d-4177-459e-08dbb29b5c97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XJ0DWhgewmhaQq5qfHNT8PKuuDfMEYuPg7kg1FUmZi/2HNGxW39cqqhBgVNUw/z6gfEcFjjvIP+yyRuL4y/niO6Gln+QrD/b6Y28QuFbMB0l6c42/80E56vLReTh8RM6M1BnR5YiRqXHTGXO14HzGTSpiLaoN4pQp2IjrOOKRFIFwiNWvaXpqKsC098/nf8x05C/Z8FMHgfKaTieUhc9QtIHxuuDwWv8mQJHObPlTEjUYiZ6f9sgchNUVG8xZOj2W9lBJW2M508LLXDvOJhDx9CZF7xHtJOXXIlXHLt4eBi8sdk6q3benq9o3+Y65AIEy9G0i1I71Pnkz4TdjP/iKshDzqDKvMHvNnV2sVRfmNrG5qLQ5V8ISS75jCALkXTiLYFa7jgoiRgMSzwKnwm6Qv/ALJKnxtTyBaJAnpqWs/XC5EU2k9F4u9cvbR9+/XkCtwPt1f6GsIfjxzNx9Jc5Xg+L+XRtbqizkERII9Bvp95gxHVCEaWvdq8IY+/1sxeSXJpgz8gYlx4+WG0iJQcAN9BFCkbsHWmKNQRihk1OI8tOQfkjyBIs6UrCQ4SMdo/9Utu3O6RwRdwJdqeItFtjUL35ktGLHLOEs+ZTdyrdrlnVGo/CE/s1OQVv07Py7+Zq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199024)(186009)(1800799009)(6666004)(6512007)(86362001)(52116002)(6486002)(6506007)(1076003)(26005)(2616005)(38350700002)(38100700002)(5660300002)(4326008)(8676002)(8936002)(2906002)(15650500001)(41300700001)(36756003)(66476007)(66556008)(66946007)(316002)(6916009)(478600001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EQNZrofzslJ49VHDzZPcCTqcloghmpH8XRk5VQ1gcyCFRIECwUCecVlEw/0a?=
 =?us-ascii?Q?E4t+rrSezUTVpz5SJT8Gs9LKc7DlCcS4n+yvVbeVlA5S2D8d5tlCFF+b1Zwd?=
 =?us-ascii?Q?OTpMx0yyZJyjj6QioxYPEWezop7RE9hnpAgKmEoSasXoKxO6I9hoB8JjdXHP?=
 =?us-ascii?Q?3UXG9CqTiwaH9GO+LMa2UKODdJuG8gTOriv62jfotp/B/5/EL8PQhdDUzEpn?=
 =?us-ascii?Q?Utg2u5q2/VYWr6AD+K5w0BA/KrfuqxHT7bV6ODv06J5ONSH1gebW1+FYSbd+?=
 =?us-ascii?Q?ZDn+fEnV6G7MxQDjkWIKomOzp6gtK67o8ERtKM4NK8tLJ5EMOJuiGklQFfJE?=
 =?us-ascii?Q?W7AawkOAFB2ku51A52esXUIIi1b1oPlW4WdVcxYknkHAdeKFgdA+T5sZrfMN?=
 =?us-ascii?Q?piy9S/o+DAowaxnpAFxg2KjcCknykzlHl/twHyPZNNtifl4SIw8Ee4sJhEZF?=
 =?us-ascii?Q?rd4GJKiIkFHkmDyVZB3gRnl75LM44kL45ZtAHhPOMdVYC0HfORXrZEQ7o+ei?=
 =?us-ascii?Q?Ixib422cTyFhrx985o8lTr5qQ1lvEc/xxViqMjM1pHK38yf11woLzFoDF9FJ?=
 =?us-ascii?Q?B2OzqjFRg4br+RIyYFsaiNvgyrzNF0Qc8ttdeMbvxSKEzthKy+d1mcfjRH1l?=
 =?us-ascii?Q?FMDMgsveuxGhPq9aF/IgwVK+gpX8zEiaqHucWgp0D3PEhH7c8/R8cyA4scMd?=
 =?us-ascii?Q?9pCFAZui1Bv2yCmOqk9c5RL5cmBaCe0ivxNLmbnjhk8vlsWrfvMx+LjNaIwF?=
 =?us-ascii?Q?rtBUw76eM2uX07arao8wRzSE3by8AppIzFTi4t3PYD1BVyvTwDOdkGm2kl41?=
 =?us-ascii?Q?AAqks50h6pExbhLjPsmnBQJ6r4ECtSOdPNUjQFmGMCq2x+hVEu7eEIFd7fM9?=
 =?us-ascii?Q?j0GoHIitXZeZ1fKCDx3f0p8LfTsc7UEAN8gWMh/A2+vSIAW8hBhuuONgOF/p?=
 =?us-ascii?Q?eNFQZPnpxXYLYKERzzDx9pOzuWx+jEQhMiH5Ot8eXCNaW/8fVKfx5Ci/2YAG?=
 =?us-ascii?Q?78qYTyNF2wJiE3TJDoPi80p1apA54SoiD7/NFk0c5UsmgFBfvYuHJN6U90C+?=
 =?us-ascii?Q?0wZn++hwm2d1mM/dK/adVgfS5M+NshOV3oxTqtCrgYxjxVMlBAvKY6jDMhEz?=
 =?us-ascii?Q?Bvgt+om4TtJryLMn0jR7lsginFVznjJ1q0R4H+LXkxwuRkYuvH/HPs27S9oY?=
 =?us-ascii?Q?gM3AyG1uQBySihogYWE8Sl/gtlGx4VoO/qa+zUdAnvOECfC0K3cqxZXmImAR?=
 =?us-ascii?Q?J8hR0cNU6MMJDCMhOKgiZu8CHzZNCo81WOn/JWSHvgCj5L67oLcZnAAMfAYN?=
 =?us-ascii?Q?vICJC4egnz5fXuxGTLygiD0hpcqOt7QpIQGdZPZvrH1Z8A81RPKAsxZEc9Tv?=
 =?us-ascii?Q?VV975umQY/4UcNV5LrvCsSKpWmKsmLIpxToObE7QMbLhYl5GAnDDV8f9iT/j?=
 =?us-ascii?Q?0nMbx/jQQl+LPLhoPStq9OtAah1cTvfZozOeD9fTPPE70BUXE3y7ABpTsdOE?=
 =?us-ascii?Q?mUJy0Srz8xrvneVTf2WR2qeszq8BHiSb+rJl+Eu+yOgf+MP6zZ/vLjpPTHKB?=
 =?us-ascii?Q?rVPntKL96MjEZspR8TE+evtDdgIM6RJsh1FrQgpRLI1JkeaVJ6bL84nHvxWq?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb36803c-bd7d-4177-459e-08dbb29b5c97
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 07:47:34.7942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPjc45PwFYq+RpPDkk+gqfHIn4eh8aAa2rrqNZIu8lJ7Za7spinzmiqure6tq0/F8kFji0lua7mgfy4c/jujlIZbLgp3J1HgQtX4Ea6oeTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7155
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Update transport acquire/release flow for BAP bcast source

---
 profiles/audio/bap.c       | 27 ++++++++++++-----
 profiles/audio/transport.c | 62 ++++++++++++++++++++++----------------
 2 files changed, 56 insertions(+), 33 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index ee90426b9..d21cfafc5 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -653,7 +653,12 @@ static void bap_io_close(struct bap_ep *ep)
 	DBG("ep %p", ep);
 
 	fd = g_io_channel_unix_get_fd(ep->io);
-	close(fd);
+	if (bt_bap_stream_get_type(ep->stream) ==
+				BT_BAP_STREAM_TYPE_BCAST) {
+		shutdown(fd, SHUT_RDWR);
+	} else {
+		close(fd);
+	}
 
 	g_io_channel_unref(ep->io);
 	ep->io = NULL;
@@ -1176,6 +1181,10 @@ static void iso_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	fd = g_io_channel_unix_get_fd(chan);
 
 	if (bt_bap_stream_set_io(stream, fd)) {
+		if (bt_bap_stream_get_type(stream) ==
+						BT_BAP_STREAM_TYPE_BCAST) {
+			bt_bap_stream_streaming(stream);
+		}
 		g_io_channel_set_close_on_unref(chan, FALSE);
 		return;
 	}
@@ -1712,6 +1721,12 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 		} else
 			queue_remove(data->streams, stream);
 		break;
+	case BT_BAP_STREAM_STATE_RELEASING:
+		if (bt_bap_stream_get_type(stream) ==
+					BT_BAP_STREAM_TYPE_BCAST) {
+			bap_io_close(ep);
+		}
+		break;
 	case BT_BAP_STREAM_STATE_CONFIG:
 		if (ep && !ep->id) {
 			bap_create_io(data, ep, stream, true);
@@ -1735,18 +1750,16 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
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
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index dd923b03e..6466e8291 100644
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
+		}
+
 	return NULL;
 }
 
@@ -1631,32 +1663,6 @@ static guint resume_bap(struct media_transport *transport,
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
@@ -1763,6 +1769,10 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
 			bap_update_bcast_qos(transport);
 		break;
+	case BT_BAP_STREAM_STATE_RELEASING:
+		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SINK)
+			return;
+		break;
 	}
 
 	io = bt_bap_stream_get_io(stream);
-- 
2.34.1

