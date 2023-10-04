Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393B6E8FDD9
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Oct 2023 07:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbjJDH5I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Oct 2023 03:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241605AbjJDH5G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Oct 2023 03:57:06 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2071.outbound.protection.outlook.com [40.107.7.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F51E10C
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Oct 2023 00:57:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQOPZDG1fyK+uM9z74s0oGoH6yQpIaHJpHx/Lu6/gGY0dt4ScOWpoRN0NG0av/ePxQHS2EC19W4TlF5DbxhOozmh62+EdLVqVQRnzApipkn7ryc0DCcqbgE30IIIYaOB5ByZoCidxjGI5ugpLIjIoStvAKWNkuOhNofo5M6JmsfqUuv052ZNSVvsV+gFDta/8Dx+61alSlU8uIiwzVe+kEggx3DQnCUweNz/ScB4vPKzPlor2v+KJNziFIucFgDhbtVklPhWq978O2NP9WWVWjsXMui/i/uGQsymWNVCHhdu6qf+SURJmm4WMB0L9YnLIQlDxb6TmMVqBT0cHWJM8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pe8RH2KKM8pNSyxDUQftOk8izU4bvea8Fz6bk8NNC2g=;
 b=DMlEELLegfSG03djlugf83MFZMCZWJRA4Bc/cctpaZsTvWJLpF7lvx9Zzebk15v72ANVEE494MJKtOc/JpH9plMCPws7GYX1o6qvh4MnEmoWq97KU9k7m5j65NlmalQW9ODR61h8q/8CzHvHOpIlspZQurdd0sbUVFXQC4eBRiARNG9rXwY9Zurxi1X90ilq27Zj/EwC6u8uoCkNFlhJI5rTcs8WLq8sIvbX3SM2JZL5/bzvOTlgbSZk8fi54wWUhXh/hlUiYGJjNy7exDH2YC/EEWZvSCpilo11O8mvMIrsO6Z+6YiuvD3NJQTLS5TVfcwDFZz3VSqF4ve1HFHVDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pe8RH2KKM8pNSyxDUQftOk8izU4bvea8Fz6bk8NNC2g=;
 b=PgYUG2xej9V6h3s/a6zTEeONstmgSVWnwbwbVYkoOKqshuc+H1NrpDNYEePQ+iV1kBnmcn/Ozv7zl1rz9Y3vdfPph1oACT6pc8G7ZKNpIGurEm3Us7qBZV3i5Z5nj+nwqvbSH2FD/q6JUSr/O4LWARUOd12EtMREzgOkThsMpyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com (2603:10a6:10:ca::21)
 by AS5PR04MB10017.eurprd04.prod.outlook.com (2603:10a6:20b:67c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Wed, 4 Oct
 2023 07:56:57 +0000
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::c031:474b:cd00:5f95]) by DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::c031:474b:cd00:5f95%4]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 07:56:57 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Subject: [PATCH v3 1/2] transport: Update transport release flow for bcast src
Date:   Wed,  4 Oct 2023 10:56:45 +0300
Message-Id: <20231004075646.4277-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004075646.4277-1-silviu.barbulescu@nxp.com>
References: <20231004075646.4277-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::11) To DBBPR04MB6331.eurprd04.prod.outlook.com
 (2603:10a6:10:ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB6331:EE_|AS5PR04MB10017:EE_
X-MS-Office365-Filtering-Correlation-Id: c3e77c42-c144-4a44-15ea-08dbc4af7b65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0z3hqUWka7xDR2uRdJp2FLRLgKJ+Ef5ekSwjYcXhP6t4lXAKmOne5sYNQBvlYxfRd5KQs2naIqoZl+buGaEVjMzAbJGFNcajiWL7syXCNVLx9Zg7xw5XDR4tNg/iP/bpZjBZf+P1WO/5qQDRHA/3/3/crqWv3TDET43lVBhw+d/2TxrZ4akqbMQRstlJK5R7eEewuEOwAXUBNajZcYw/Es+Ey8gmkjNCCntQLaypb1zwx/QPtx06ZU7LMGSBa6bEBlMGnRwXY69VcdnjoFY/C7fp1KB3KF9npRm5f/0xfPiXy0edJ4VQ2mmDxr+4gPS4yL68kDkEcdTXICwhcX7XJJXCHJRd42w1r5hNiWb408YH9t6MaGwDH4OFm4+eSu2TsIUlA53emqbXTpG1UzmccC5yU6zZ1AtnO2leZmJZnhM4Q1UNZI5GNpXY4QRItugDjgMn2ye1DMk3cPmjqUMR2QYwSYi1hrm7Kw8vujM0p0WlQaswsNDyzvOM0p2R+ZOWAAgIwY5Ig03JSxGhSL2QAbcyHYx5j1nP2xnTLyiDsRXbvqUYbEJWJImB5lXsEKRt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(376002)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(83380400001)(6486002)(6666004)(478600001)(1076003)(15650500001)(2616005)(26005)(6506007)(6512007)(2906002)(5660300002)(6916009)(66556008)(4326008)(8676002)(86362001)(36756003)(66476007)(8936002)(41300700001)(66946007)(38100700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ubXm3Alh9I9xXEGykRphqYdsXLIqEwWBH127Z0A3IrXlUG9eAsl7D7/4EpvZ?=
 =?us-ascii?Q?XOmHOeJWO+iJufST8bfj9MI64uZwDOi+8dERktR9i5s/rlLbeNq7mYeFouoC?=
 =?us-ascii?Q?xRRI/F9sYS9rZIZw7zcfE68bPKwR+/c5m6qoSv8XDfyMmS2dtXRyKyb4yCEv?=
 =?us-ascii?Q?73gS5akNgsmfeWD1UHsOFFuwqAbCHWLDNQ9Ph+tKPQ/TICi82yGrP5Zdi3BO?=
 =?us-ascii?Q?hAtWMQPJxaLpNNn8RvQQrE8U19YVpowx1ecFWU0T+C2OVmiVFuIGreY9xftc?=
 =?us-ascii?Q?4qJt5x1lCI8PrAOY3e3IPpEdky9shMy9njaRNI92nPyKfM+rgc3yLXYRJdSY?=
 =?us-ascii?Q?rSZVd7IIIFyrhKijpyCOyi8LtfNKP+n/6QfqajfPlwwEsceb+ckbkUElGN1p?=
 =?us-ascii?Q?N7V13Bv591WTjwLuyc7oeSfvFoKf08X8oGu5MOR6Yj9xHdQ3sb5EpUOLSHDY?=
 =?us-ascii?Q?53GliLH7JNF8DTIdhUbZBZdfiSM+5C4r9ckwRnLKN7sV6xhffWHoQtJ9+GAy?=
 =?us-ascii?Q?NVIeDOMmz5LockcttQ7lOt0E521VDzJ3tdSvMA5RmWqlv+3gNhmaMdNwFgh/?=
 =?us-ascii?Q?MDg+OpskuQxtBMNffcY/U85lZWszr1qItnzOQmbljjOjxrLpgpO4E+cTh98y?=
 =?us-ascii?Q?iAq1otaiQNiofYRuSlE6rTceI9JCZ4rOb850EtFKZXmwmZZVPxcGoBv4PpGB?=
 =?us-ascii?Q?1KgN8qsWdQ0bTouDCj/xmqTwPsBSbYSJglFNuZ1ldksrFi0jJhbOratzCu0R?=
 =?us-ascii?Q?kcAblyvqewx8LR36/978aNRdtT5AbJbSNanZ/JX5rgzxkfPM2S+Mc6HliNSX?=
 =?us-ascii?Q?N1UeHyIy/7vMfojbE7iW7QjZ8Bm//8O/v6XCBuq8wcd/2Qx5KebA3Y+ZWzNT?=
 =?us-ascii?Q?Rx7KnrX+kZ2X5fW7a6ucKkMv5aWhPrFvMkVAhlxq7Zfim3YE6YzJX67EUJHD?=
 =?us-ascii?Q?cy4cULwhAPikTafbev7ZP6jAvfoqYu8al290h9hBKfAt5/yLJ6JTOid5NV/Y?=
 =?us-ascii?Q?Ji4eNzHs+u6S+L5ECkIvIg2wnGSRGhyKhkRgYQiNeWF7xRz1dYU2nQymlTji?=
 =?us-ascii?Q?LAs4fZWsqNUyAaq8Xc4M39e29dxfjno6IK48WGFwcJvhreVUwgidpWkbgMkz?=
 =?us-ascii?Q?aWxQNnAuQeMaT7llrFDU3qgOjKoMjw0ancRxkxxHvGDXPc9JqFAUW6Hd5taP?=
 =?us-ascii?Q?BjIzZSRERIM1veW1DAbju+50H64i5EaXv6QmVALGJf4VEjum3eieykP2Z5Oz?=
 =?us-ascii?Q?NriX2iSf2MZYEhR7kxeUcTHnTb+t0NsjXUlkXLE6r4/jKYRRaT+XsPqA77xv?=
 =?us-ascii?Q?rt+WViNyYz0uO0Ito3XUHuiWAh5TCLM0By1ux+NGCSx42oNlRKuPH1yiblQ3?=
 =?us-ascii?Q?zm5ihdkSBELyuchtnXROiGVqLVwWKkn7/ApGL8ohZUXqiV+fd7MPhkhVYzx2?=
 =?us-ascii?Q?FJlLtOYpCJ0Nm05avfNvDDOB/SpbOZRqcyMniKiIKn7G5ad1JqctZeULivYD?=
 =?us-ascii?Q?83ip5JKUGYmbRYK7iCd1IzBTnTtZv4/oq2aPMbnL5+wDDPV7lOS0sBFobVx7?=
 =?us-ascii?Q?ymjgBBkyrrjOZj2HOR8zo4jEmgUR4L1a6x8/4O59t8J4l6cdD0VO/UayBOeQ?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e77c42-c144-4a44-15ea-08dbc4af7b65
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 07:56:57.3597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9uvvSteRdTqP21I5OhnVZWWXS7SyNvxvZo4ZEP+OV6DoIF9CaG7yZl+WmwVffZZHiv2jl5N51Z7Q8NeWGkoc5+IoAAZI2LU9l8YdBCYAudA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10017
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Update transport release flow for broadcast source

---
 profiles/audio/transport.c | 65 ++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 1e03b7b51..23ea267f6 100644
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
@@ -1499,9 +1505,14 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 			return;
 		break;
 	case BT_BAP_STREAM_STATE_STREAMING:
-		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
+		if ((bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE) ||
+			(bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SINK))
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

