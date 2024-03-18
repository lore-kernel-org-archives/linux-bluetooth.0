Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEBF54BCB
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2024 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710779948; cv=fail; b=Z3Qn50eSYPh1QG5IxwSfBxYPCdL2zAldsJC2KsrQV5GJpjkfDU2ZuSI+8cUT8TFtxTuM6qLWqHQPLK5pYzGiKHRCT/r02ZAZvQarGBH+XxtiVQPNzYKK3sDeDddZ8E7a7iEpr7TFpc0hLYfKxgN3AWXXytCajsPZqZOZ4syC0Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710779948; c=relaxed/simple;
	bh=eAgKjABbhwqNWH+UaGnCnRqpEndnR5qT1kGZAalTP1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DO43a/DHcRQsneriXHEkxLMe+OoG5gxRoJj7RleGbDrgV1WpMdjpWKMug49nJeVFieoH5vDN1L4GqKXWWDDmPcRtrPUmgN2ajI0XegNqe1Iy/+oySTWJ61Ip1xckvL4pMyNr/+DhSkeguhM/C9ydWoRXq+/LqgbCGJ5r+xyBacA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=j5s/Vesx; arc=fail smtp.client-ip=40.107.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="j5s/Vesx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzSULKbqXpIUhvDNET73zqDYK4x9H8VKICyT9Joq9SlcY3C4M8dmfsIgLIfeJ5PrXrxlDa7ihG6U4Ie4Q5xYbZKWx/wFWelgc9W4/fXYUP0ndGYtb16xA8NdkRDEfv/4NwfII0fN77Cjo7owketCznZIAjogZEBidHuiWRUhaizO73YyKDCSuwiNTPtReWQl4tKHGQRq5ID2RaXNa9QzsFPkjhAmj1r6zxuH+Wm2zex8h8OMqo12/XvodSbAzMMzXfJsye2ryhiPOIjNEc0pbMquLRDFcBv1wEOHRvhkTOhQcxhVEmpc4H1NRzEaV1QH5v/gh9YOuktmJTKc6B2wgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUri8zYSJLUizV/zO1hj8hGHu0uOBbun70T/K9Phfkw=;
 b=kAYHoieASNxICBiaHd1bDm4K2m1H/ofpk3K8k1ACfKfYY+wH2gAe5WIftQx2UHKsQz5lVq3AmflySqkDhSq7RCsq9EuZiTE4dKY77pLmsUOJPsal8VzQogDyeumujF0xt9PZ5LWYMAz2jthxKm2oicTafB/HL9AtObPEhTMJN6+2ewUf35BmpuopWiP/zAN1u+msG/sH1HHs5qma/wcQaQxM6iUOmZNJb6FdUzzFj/P+I4JauZuyd3q3urjxaofVm7jfeqVKEuNgQGLTKeH084gQIx2xf7cjBsOIB+iDVpJqGXPQ7m8SZ1IIbyzO9WJ8Qslp4MEbeHipsC2xZeVlTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUri8zYSJLUizV/zO1hj8hGHu0uOBbun70T/K9Phfkw=;
 b=j5s/Vesxi3b/MPI7smNFLd4cmQtoQNYdpXqqJjp1RWGj6NrTObPBEjEhT6gz4/oBQfbjwK6ZLryCo2B3EJV3kH84x3WXg+IhwlV+riL85zYj+mV2A7QD1Cv7jaGJbcFvHcd1KO4sycPhhF0PFMQejF4Ajx63w57wEara942muvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by DU2PR04MB9132.eurprd04.prod.outlook.com (2603:10a6:10:2f7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 16:39:03 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 16:39:03 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v4 3/5] bap: Broadcast source reconfiguration support added
Date: Mon, 18 Mar 2024 18:38:51 +0200
Message-Id: <20240318163853.68598-4-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240318163853.68598-1-silviu.barbulescu@nxp.com>
References: <20240318163853.68598-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0028.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::33) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|DU2PR04MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8deb3f-6e42-4c1d-105c-08dc4769ebfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nlW+rzpSKzEfRJ3o3nuVK/dlTXUgdiYNfapHzZY5czCG2dxvTR5x+77pqaRDqdz6KKSFOMUxXkS//GDWio4//UAsoB59rRO8RCPnpAxaB4p3vPXucOI/1o5vb30KCeH/riMzcNLOfJabVwdKmV2r0QON2uNeSFNzaA6XxIW6bx7ZLVBvXQd6i7KHe3hfKVFNg/rPMDvmWtROHNw8Al5YmVSRWmLFZDiq1vWizKaRvzXig6Q1jtJfxtvtcEU4xap2ucmtSbwFyHOviX/DcAOy87yothx4PLmqFUvBeAOODi13auftIH8MXI6KohkOKhhFksGlRwz2aTFyJPt3keuWdL6XEci/u7kPg6Fgznns+FD3y9+qBYPE8wyQcNpvpee0uyYmZMNy/6z43FF7Fsz0v+HfkPNP/n++zsgONqaBbwa7QxzTV4jtNgrfXJeYhBp09ZUmHF8DqOXZ6YLMBUNLv26e2S8uzj0HTTVnAkpWtcPEGSzU/sutchh2bT7hvnxjMSSG5HFcv05ZAnWBttTfWE5XsyyUHzkcYoWv6+eGEb2yO89CUG2VuSAXMsE4b1bKxE+0EaLje/qyklMC2EnwXHA2axtguJAuI6KUzFRiB14TyY0RaL+ebgrvVOcFq3SH6ql1FBJjGVtFzUisJjPeoQPujBWvYp52XOSUKXUqYQA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f/B3MnHk/H8FeTFX1DgAQyQGR5QxV3x1UeWE/qBCzWv6X6gBnWxI8d6PbY6m?=
 =?us-ascii?Q?FMYYCFbWF9S1q03V0a3mjJn1uJbFUzFPQACtmo3eomhpSGmapoz8GdKK44/5?=
 =?us-ascii?Q?nMpzgMlXNDPW3NJWDnNbUMygk/C5a5iB2xsPTTTCNFdh5NnLxlnmSM3fB1F5?=
 =?us-ascii?Q?n+rSi54Lfa1yM1ZYYAlFBm+UXJl1ZonFm5uz4jAcxkiLwrhtyzFsiAs0yw7X?=
 =?us-ascii?Q?gEL5dw2ysOxFJLTe2EGVOISeVNM7YWoo1pYE39iLUNSc2CbfgIExhmtHB7oP?=
 =?us-ascii?Q?TdtiPKJ8aA3WNJ2clFukd1Yh72P9r65C/hY7/pSnUUUxH62M7itFge6ief2x?=
 =?us-ascii?Q?Kwq8wf/nRbsUXgs89gMU3nQ0QH5vTweW+UqIzqp7mTPSQ2KtTHGbaR79gJ/f?=
 =?us-ascii?Q?fYp1CWbv9bbglkIvyoiCIRBdrUf16WPFTB4x2u+LGrKYt+QhnguVS0gdvueb?=
 =?us-ascii?Q?9DInwZbTY120Z/F1yCR3QA02LhTLeaL467Ju7v1mdJfMDtM8H3mpOgileDfE?=
 =?us-ascii?Q?TPdSU/dH1gwafaK/GEkS+JUXgvUHGmuoi/GOexhgXarFIGt100Js9xYjkkSm?=
 =?us-ascii?Q?igFgSVBs/RHUUfw3WruSQkSkgmle3f+3TSCUh0ApbIA/+CA0tjNN7JzOxuP8?=
 =?us-ascii?Q?n4IULRQshHQ1i0fjYYOqUS3E1BBDuVLHB+qwGGn6w1ac537rmx6FwYtsu0gM?=
 =?us-ascii?Q?Bw2pK/2iojJhVF2kZoi4DSVG9UiQNlcr77KqlXaxPM/V+zFf84baMU3p7+Ca?=
 =?us-ascii?Q?k2+y8c3nr8zF1exsCTI6qp2ppL/rfIMf4KCmdWQXwiAEUD4ak/SEY/e6ooZa?=
 =?us-ascii?Q?czo/sbdo1F6OyEDJWqHCGN4W9EMIL2usHjcAjfDGxsREQxNOJk7xB7qWMLt6?=
 =?us-ascii?Q?Az+pUqing+cDca4tN2VoHAO7DmIsXtlfzNU+g2dYGkhhAzFinZ8Cb9Mzckju?=
 =?us-ascii?Q?GDdG2mhy7NOBBgVDc+S0kfHf6vlg4mIe7FbJ8WeAp+hiZ3NgsHPfG2sSo5Sg?=
 =?us-ascii?Q?+ykxR6xDq7RdGCjndzdqLIhPTjxrmomPoHdbtpBFcIpSzoOFQB1xRT2SXdgf?=
 =?us-ascii?Q?/LL+f2Bzt6XbKAZvUxIQ5ke6iWUfABRLUnBqbu7lpwyAGVeGhL/ff+WnIOEX?=
 =?us-ascii?Q?flU4sYUqH1HVqcnsz2htYfh7ww82DLogemhAlVAsMb+6wy3k0i6FGeVXjLC9?=
 =?us-ascii?Q?nyXhKllv5Mv6mX5CkYGGTsnJa2pdPf+VLSf0pHHv4EL6cdRM1cW3nT7tP1zQ?=
 =?us-ascii?Q?0DmqiV/apkWSJR3CfElmC3rznlEVsDdA/WZ8gweiXfXJjxJr33hcpyR5ceHy?=
 =?us-ascii?Q?dXfwXej05JD8Ga6XtAvwN3frrMuJBTrUU++zJjxAQmajYdHV2x8T4ES/Yy5X?=
 =?us-ascii?Q?TGzgsvn7cdk9oq+wU7MDdJAx6fRcbGChWk7Ree4MX1mYL0nmN4F2EIaN/qGA?=
 =?us-ascii?Q?Ub+HimO7O7h1qQdXUBts05YoJ2V8MQPYZk3AvSql+Xv5d/57rU1OJBCKPSkc?=
 =?us-ascii?Q?f9VX4mwapz/b+kSoB9HoM+2R9SD+eWjJAZQFxkKceF33685VtmRnVgMk3b3B?=
 =?us-ascii?Q?X07bbmNlvQ067iZvVBeS/GuI66fFvGnQFELS0/QRijxH6zZv9wMrQV0CD+jP?=
 =?us-ascii?Q?BQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8deb3f-6e42-4c1d-105c-08dc4769ebfa
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 16:39:03.7166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRShQKgwIu6O973Fhg+88ZfBZXXmGhsB+qlM0l5EBUVfYhDrIwOvlbNZ2OjrY7JnFrTVIB+cD9ZDVaY3RoQd0mn3rYBj2czoHdHBkwcsfgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9132

If a BIS is reconfigured, the metadata and codec capabilities are updated.
Also, the BASE is updated to reflect the update.

---
 profiles/audio/bap.c       | 76 ++++++++++++++++++++++++++++++++++++++
 profiles/audio/transport.c |  6 ++-
 src/shared/bap.c           | 11 +++++-
 3 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 964ba9c21..e508e03ba 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -580,6 +580,11 @@ static int setup_parse_bcast_qos(struct bap_setup *setup, const char *key,
 			return -EINVAL;
 
 		dbus_message_iter_get_basic(iter, &qos->bcast.big);
+	} else if (!strcasecmp(key, "BIS")) {
+		if (var != DBUS_TYPE_BYTE)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->bcast.bis);
 	} else if (!strcasecmp(key, "Options")) {
 		if (var != DBUS_TYPE_BYTE)
 			return -EINVAL;
@@ -884,6 +889,53 @@ static void setup_free(void *data)
 	free(setup);
 }
 
+static void iterate_setups(struct bap_setup *setup)
+{
+	const struct queue_entry *entry;
+	struct bap_setup *ent_setup;
+	uint8_t bis_cnt = 1;
+
+	for (entry = queue_get_entries(setup->ep->setups);
+				entry; entry = entry->next) {
+		ent_setup = entry->data;
+
+		if (setup->qos.bcast.big != ent_setup->qos.bcast.big)
+			continue;
+
+		util_iov_free(ent_setup->base, 1);
+		ent_setup->base = NULL;
+
+		if (setup->qos.bcast.bis == bis_cnt) {
+			bt_bap_stream_config(ent_setup->stream, &setup->qos,
+						setup->caps, NULL, NULL);
+			bt_bap_stream_metadata(ent_setup->stream,
+					setup->metadata, NULL, NULL);
+		}
+
+		bis_cnt++;
+	}
+}
+
+static bool verify_state(struct bap_setup *setup)
+{
+	const struct queue_entry *entry;
+	struct bap_setup *ent_setup;
+
+	for (entry = queue_get_entries(setup->ep->setups);
+				entry; entry = entry->next) {
+		ent_setup = entry->data;
+
+		if (setup->qos.bcast.big != ent_setup->qos.bcast.big)
+			continue;
+
+		if (bt_bap_stream_get_state(ent_setup->stream) ==
+				BT_BAP_STREAM_STATE_STREAMING)
+			return false;
+	}
+
+	return true;
+}
+
 static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -925,6 +977,30 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		util_iov_free(setup->metadata, 1);
 		setup->metadata = util_iov_dup(
 				bt_bap_pac_get_metadata(ep->rpac), 1);
+	} else if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE) {
+		if (setup->qos.bcast.bis != BT_ISO_QOS_BIS_UNSET) {
+			if ((setup->qos.bcast.bis > queue_length(ep->setups)) ||
+					(setup->qos.bcast.bis == 0)) {
+				setup_free(setup);
+				return btd_error_invalid_args(msg);
+			}
+
+			/* Verify that no BIS in the BIG is in streaming state
+			 */
+			if (!verify_state(setup)) {
+				setup_free(setup);
+				return btd_error_not_permitted(msg,
+						"Broadcast Audio Stream state is invalid");
+			}
+
+			/* Find and update the BIS specified in
+			 * set_configuration command
+			 */
+			iterate_setups(setup);
+
+			setup_free(setup);
+			return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+		}
 	}
 
 	setup->stream = bt_bap_stream_new(ep->data->bap, ep->lpac, ep->rpac,
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 122c3339e..a060f8c61 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1643,8 +1643,12 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 		bap_update_links(transport);
 		if (!media_endpoint_is_broadcast(transport->endpoint))
 			bap_update_qos(transport);
-		else if (bt_bap_stream_io_dir(stream) != BT_BAP_BCAST_SOURCE)
+		else if (bt_bap_stream_io_dir(stream) != BT_BAP_BCAST_SOURCE) {
 			bap_update_bcast_qos(transport);
+			if (old_state == BT_BAP_STREAM_STATE_QOS)
+				bap_update_bcast_config(transport);
+		}
+
 		transport_update_playing(transport, FALSE);
 		return;
 	case BT_BAP_STREAM_STATE_DISABLING:
diff --git a/src/shared/bap.c b/src/shared/bap.c
index fd99cbbca..603d6d646 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1701,7 +1701,16 @@ static unsigned int bap_bcast_config(struct bt_bap_stream *stream,
 				     struct bt_bap_qos *qos, struct iovec *data,
 				     bt_bap_stream_func_t func, void *user_data)
 {
-	stream->qos = *qos;
+	if (qos) {
+		stream->qos = *qos;
+		stream->qos.bcast.bcode = util_iov_dup(qos->bcast.bcode, 1);
+	}
+
+	if (data) {
+		util_iov_free(stream->cc, 1);
+		stream->cc = util_iov_dup(data, 1);
+	}
+
 	stream->lpac->ops->config(stream, stream->cc, &stream->qos,
 			ep_config_cb, stream->lpac->user_data);
 
-- 
2.39.2

