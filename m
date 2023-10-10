Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2D1CD8C9D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Oct 2023 14:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjJJOxC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Oct 2023 10:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbjJJOw4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Oct 2023 10:52:56 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7569BCC
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 07:52:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpJfqqhgPaE2DZRoH8OhMd+/Q5KUY5+AEDn9mt9uPW/I5gbh2a+5AYZe6oVIWUnZkwZEPgFEz+NO1H7SFDcfwneT7kvVjB/t+ffUllKM5ze0vjk+gbmsp5abZ8jrgpQWPcGCkr/Oz9Ex6aol2uC+WZXWINVag8CUGSpLjDkBham7rqTjiGJWliza36FJUMJr+hDQMy2cJAQs0rmHVmEC+86ZOGVLvqXYqGpEB/ukjRMSdcWRKBSvsy52JGNLmPoK4zGC5rL1XCLvDGV+X7oVv0uY9Fa6ncgK/u49L1YgeeGZL2WV8XHdx6ts6thaArzBQOAaBCWEFCxIHjgJqCWPDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pe8RH2KKM8pNSyxDUQftOk8izU4bvea8Fz6bk8NNC2g=;
 b=F5AI9sQGoTpLhZYhTJIkrIRkGmnE4WH+8Fn/xMUPHcycZ03kZNSdjR7cbEcd9ZN+ROZ831CFS8wVUS7zbHefIBySypDioEoVrotowFVgybBGOdLOUz3/AEoDhtf1T/rP1THXVtWWIZVzX1Yu7wFGQUUvae9nJGer3WR9lDqaJY/XcsxPke7bYCWsE1Vr50FpS1ff6VkrPJY85PhfulOKol/L1lhMIUBBCmbK+CLTV5dIN/z71vLYK58NA4y4cJt8fl9M9/EQ8L1AggQq9lCWKnfzztvygPDowF43qVly91vXwdt8r0J+NxK1Ra6n5TkWZOjQ1F/fwA0rhY14+An2Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pe8RH2KKM8pNSyxDUQftOk8izU4bvea8Fz6bk8NNC2g=;
 b=HaWA6Jvqw6DfH/bOJNSfJqAbpDFzFG9rN/BFUv5krJ+B42NF1t/1uxvQk2tYNRkZF0olSyPljahL76h8hhVu3ofDhqPq6TclSCzVB9pvAXrotC/9NtEZZtBeQGnTMDPUZQbkxPxPUIKrY4TxxhcmBUAVuo3IwybRo7D2wSdXj5k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com (2603:10a6:10:ca::21)
 by DB9PR04MB9792.eurprd04.prod.outlook.com (2603:10a6:10:4c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Tue, 10 Oct
 2023 14:52:51 +0000
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::c031:474b:cd00:5f95]) by DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::c031:474b:cd00:5f95%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 14:52:51 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com,
        iulia.tanasescu@nxp.com
Subject: [PATCH v3 1/2] transport: Update transport release flow for bcast src
Date:   Tue, 10 Oct 2023 17:52:41 +0300
Message-Id: <20231010145243.4441-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231010145243.4441-1-silviu.barbulescu@nxp.com>
References: <20231010145243.4441-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0021.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::26) To DBBPR04MB6331.eurprd04.prod.outlook.com
 (2603:10a6:10:ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB6331:EE_|DB9PR04MB9792:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a0db67a-6a4e-4004-e1f2-08dbc9a0937e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +2BEzTK+beRznvIzpnAcPSFIYWWolokNzlTwTcsb5ob8MQgOlJY75vlPLa06JV72MLYgmueJoB3SQ9fT4CGlRAGwppNXQ4VgDdWmpW5zglqEwgiK3fIjqcCOgIkeDZRms+TEgZroYppcrhSv7r29OmHT2kdPxnobNiSqcJEzKow9IbvNiftGfvAmc7XkEQXQtzP26j4bRrAe3+l4qODJ/npEozLtiJJ8QtH5m077zvuUGC4Oucwb+GkeyodA9gd85YAcrQ9+jGonJzqZU7sgOtmcs0AScm8Hstbb+RjQ0ExlEKEnysdK9Q8AoLHp13UUe/2kWtcg107POPoJI+cqv4zBDtxbWSlSiD3pRdqANYwgToAo68AQPCF8PVAnjEMc1wcvtlo8fQjjJKTaPuRXx/V5tlyiIIeAko2HyrPUJN2bPsGS/vyom3a5Wx3HhkxRKcElAqUM8vSSm+nfEzkADpr4pwj9AJFSdwCTXVx5bTmtumt1gFfLckaD9Zf3u9NMJkkVmnDYkJ8rg7tUQw7ac6b/22v7haj9dbXD9KLOvz3CSC3Cowcpka1R6/suyFPu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(366004)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(478600001)(4326008)(8676002)(8936002)(6512007)(6506007)(6666004)(6486002)(6916009)(1076003)(316002)(2616005)(15650500001)(41300700001)(38100700002)(86362001)(26005)(2906002)(5660300002)(36756003)(83380400001)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VyNcMyPGwMzymyngEB0UTVmQIxdz3SmsgN2CLPMTMhmUyEfSWsZgGjhRAuni?=
 =?us-ascii?Q?gF50dI029QfNRSBlMxvT3bUK4gCes3ttqIXjljVCxRhdZPbsCEKTPwU51C79?=
 =?us-ascii?Q?kaRHQmvQ2GaBz0umV2uuPEEhPtG84ExCePv8Xvrthv1P+RxIWmV0RdHFi6Vh?=
 =?us-ascii?Q?Qu2KthT1NQqjhve6ay9/dnmLKSKR6NFiLz3PrYCZA8jJaiwGIz086GvSzPXg?=
 =?us-ascii?Q?OHNGlBpl1D4Zn8Z2YjRMCrs56nfHJgqVSLa5JmE295ceoQIAyjkA4wTOVqkb?=
 =?us-ascii?Q?47NYRXdRwE8dxt2xzzDzKUCrm9HD6rFaPhCwFUvNvBvpkuqpSYi65JC3c0Nl?=
 =?us-ascii?Q?1VGDQroNLH9p80Vk7/dTHCYexYXZzE/HmFiWT79L2aifWyGnXp6zpb4pG4zD?=
 =?us-ascii?Q?Bhts/rJxg389eIk08/0fBQmdwoe8mMtNCaVS3o9aqBRs3XkPHfcbvDKQTzQD?=
 =?us-ascii?Q?uNOqnTKu9kLahNOULdtmpU8AKcletFRxX7Djwl0Uvq1i6pvGWGnmoxfkwXPA?=
 =?us-ascii?Q?xF58ib6w+iZtuhINJF339o2Xk74WgHR3e9evXhOSJxufItLwo2BLaXBLp88S?=
 =?us-ascii?Q?EDPENmO7m/otKc/9cAsg05WA4xv6yRbWteLX/LQxPk1aW6vAmhYcF+hfhKJA?=
 =?us-ascii?Q?DdxQBgfnvIcaD6RN2HV81Et7Yxbi+IbWlBB8iYf/dcFLsAqkCsMR+dVW84cW?=
 =?us-ascii?Q?QmmrFUSSUDF6YBW2/VBX83V9Kcjf6ytqdXsUgN0zVWwVo+vV5eFpSSHkj9VN?=
 =?us-ascii?Q?q0StUbO1Cn+gYDB3N2lHCx6ZxrszdzKFIuATpTrLf3QQzvO5HWtFvQAajeyW?=
 =?us-ascii?Q?Pu7flI9hUf1m/mbITzJ6Z07i96FjP01efbxRGutbQOvIg+nHsB9gMREDnC9u?=
 =?us-ascii?Q?5R8tsIP8GKyN2URnOC+W5hn1GYYiLyUnYx7g/Jl57SCxQdqAaNHY7bXWIMBL?=
 =?us-ascii?Q?XJhfVfifD4Lg0SgtxPQvBe5+kCWejqWopF2qFbTKjKNc5D3wOk91Ih+xsYZT?=
 =?us-ascii?Q?6SyJ44hhOjMWNzR30htkfvuOX0ZPgwYwrLnboj1VaPXSWL9kQywsIyqAYuX3?=
 =?us-ascii?Q?hhGrfI9bKx7R/mt06kbmT1DFLEjCbShHsaEJviPsPPWL9H7mredX5nPO4KpY?=
 =?us-ascii?Q?ApScWHZslJg34TNi6htx/zqLS2jC+WxswODmHY/pcGiUix69GCz38lY1pKGZ?=
 =?us-ascii?Q?tiX4YFtW9llxnCZodnZGXocS7sPTSukqTcqf94gg2k3OZiYNFD5A9PMGHCwO?=
 =?us-ascii?Q?p4uH9AsAA45A2KJk5v6h3WH1RLIe7L82eqd+Nwp6RViTKnONh4EuNM7SWSL7?=
 =?us-ascii?Q?/7NZ7RBzCzWg75Zzwgw95I+R99QUMz94I2b7AbzbiTppcMnbYs4iebSQAwzc?=
 =?us-ascii?Q?uLTlO3amRZWfd5FHbFWcCfHF+vTNL5hXEnqfeVAvpWhQ2DZV4azAosSNWIB6?=
 =?us-ascii?Q?cIOz7bs0KoEA/QBLr7E3IBNKYYnFzVHaLaxgezAPu0VtIQ9YIq3fxX+fFDH3?=
 =?us-ascii?Q?cCPIL0I/nvx6yhrpzLnYcs8q9foIXUBwDD6Q/TwJToTtZ7TadY0XdCJN8sFK?=
 =?us-ascii?Q?9RnkkFIaMC8M+jBoSTN5TeRXYsrLnLB88Wa8CQ4dX5jqNj5lNdI0ZM/PXk7C?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0db67a-6a4e-4004-e1f2-08dbc9a0937e
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 14:52:51.1081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ADeGQRxjNsEn6fUZ0xC33CGQLsNU2Tmq6/e8/xZEP3heWab3vxm6D383Bg2KDwyCVe/u+0hfJ7tLi+abY9wHco9ZwyM54tPwQs+eJf0ju8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9792
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

