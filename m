Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C45AC4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Oct 2023 15:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344827AbjJaP4D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Oct 2023 11:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344832AbjJaP4C (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Oct 2023 11:56:02 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A494FDA
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Oct 2023 08:55:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkjaHDuEn9G6QLDuOUy8EZsS/dOjgeKk+MdGjyJZVM210STTeoQJfSlBjsbT2jpr8Sxt+icvvSvoH5Nw51/aqzBRSdy76pgP57ACHicIfdEYqu7WX5WYRXoT9TVAmYp8ntP7VlVyNRsWiPwKN6SU9QmQtxRwoOFKDcHMzErR6aNpRIU2/ahykiOzFQWt/eUAitwGTnm2ZM69OyxpTm/DCIu7r8G6fBb6/S5/xe1/Xt5SgH2UoWZcclkOX3w3n/D+vRl3gwRnZBdthuOEH+m0DdUn4Ul0xUOA5Rj/J18BCiiVPGw7Yo2UXu2AqKyDyoRa/2ZiXcDL9AbhH9brXlb6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/MoR3CeKgusR4AD2j8Im/7Sgya094xGwNBknJJYytk=;
 b=iM8w8NtueqLWbPiCpICz9PmZdx0DvF7BvpUPh/u8cHMk3zSHGn9ipAF5ebmb8L5llh2NdzWDRZ69U9fnXvdU5eBYvPyZ6waJAB7eoXEu22a23a/37Nnbhc4gt/SUOUyEjo7VjuphZ7bJw17/mYQZI98s6sAO8YyYPcRdDMuzk/QyvqTbIZaSkYrHFBkgvRAh+BDe7x/iviV+7UEzSmwfQXkVI3JdA/RkFwQ8Ov9I28nJ4aIw5NcEzbuFrqhfEOiNLI+rJDYWmKbUNpqv/q+/THL9FgsHAnqfLvKrjQTKedDkr3yYrsWr0bFssWkHu2BIhWI2tgKPhYjFoxNE0LLvvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/MoR3CeKgusR4AD2j8Im/7Sgya094xGwNBknJJYytk=;
 b=GvLuNyj88jp98KV/G1kyw8IlwWOod9oavh2bwOsu4cYFaPvc/Mk5sjjMR7bP//7iJRQ8+uUbizIt1hf73nY+v9c/WJeSdB9ljsWhQblfmHTc/L6TyWHVGcDEu8x0UAduqCSP0o0wBPjjSDEDgOoznyIi0HciNyYJTuVnF8wNUgM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com (2603:10a6:10:ca::21)
 by VE1PR04MB7440.eurprd04.prod.outlook.com (2603:10a6:800:1b2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Tue, 31 Oct
 2023 15:55:54 +0000
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a]) by DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a%7]) with mapi id 15.20.6933.009; Tue, 31 Oct 2023
 15:55:54 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        iulia.tanasescu@nxp.com
Subject: [PATCH v2 4/5] profiles/audio/transport.c: Add support multiple BIS
Date:   Tue, 31 Oct 2023 17:55:34 +0200
Message-Id: <20231031155535.228994-5-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031155535.228994-1-silviu.barbulescu@nxp.com>
References: <20231031155535.228994-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0046.eurprd03.prod.outlook.com
 (2603:10a6:803:118::35) To DBBPR04MB6331.eurprd04.prod.outlook.com
 (2603:10a6:10:ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB6331:EE_|VE1PR04MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: 429f8c25-27ae-483c-8a9f-08dbda29dd14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F9WgL+8ycw+8qOf4JMsd9Rj7mbYc/SxXIW4jJmjkCfE8Oa6KT6Drq0xx6z09qbufIoPyTphU/6lPaXJBcRa65aVwML44i/lX7IpXP6/HbraCygaR2Us/8d9kXn4kQ8+iaqgJUYtdK7pdEIuPW8RnmxHRW0z/3yLUSVgfR3e1qKbdU7L8CxNRqhftmFkNonMDJsNkc7apIhgGAemRwLZfBxiMyCr+DTrlQUasFlT5d6tLxq0lZKtd2bsJBjX0wFJB0YBS3VLUkDicPHoeRDd2Q9DFUEbahLK3P996aeoctU23HVdFqk2YVzhvET3ZEHPMkX6ODEOtBHL2M3QkEJ2DWlyVq7CYMu1MWUrsrAW8LDzowlhHbCIKXaYRtkSxbIIAO47YMHOMUQ2HxwnOBlc7oUB+8VdKAXeZytJJQa/SKO7W+8OAfNdAAOZyJqs0JuGPOFlb+BX4u+s+6WRi600X3S2I/XqaxSzraDCsN59gO03SQhR8n1KlYpBegUv+DUMBg4r5+BPYsimexhOMZfIjZRqzPS0YmwPKqSMM/nYC9p5h8e7j9fS6UzsWId2IiZ4LHeh7hX8BMmDKSyY5sL0wmoJ53gaNDcV2xJHM2l1xJ8P6PLqp7bshBrKRgTCMTKXS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(66946007)(66556008)(66476007)(6916009)(316002)(26005)(8676002)(4326008)(8936002)(83380400001)(5660300002)(41300700001)(38100700002)(6486002)(478600001)(6506007)(36756003)(2906002)(6512007)(86362001)(6666004)(2013699003)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HdLewdWByl9hFmFsuJKuFh+zbYcWPttEmix9DoYIWaLzBzTpXi4dUJfQoyTr?=
 =?us-ascii?Q?2gqOAn0cI7wFFe/4lqySkB1lEmR3xQf/S9FS+JFHhvwdwNUdh1V6xSJXQEnt?=
 =?us-ascii?Q?UoNaQDIWb9j40Oci/iW+RoCjHKBxPl85pPvgmsTLbabnmPOAJzQYjKBIwhry?=
 =?us-ascii?Q?X2ZaGUeANhQEX7dPSgTqB6yPKBdNLmGi5eSoZHeRLUMw1UOBiGnYAMXoXvVo?=
 =?us-ascii?Q?YhhW13xTNBXmFzmgrChWTJprgbXSG1X2cQf/EUgjYpOOYSPZcpf1ulgX/3E6?=
 =?us-ascii?Q?fGg3otrkAGvrnao3IWQKwza3MluS9W5YuHFc+9XYA1FaY+5xkX7GWb43u4x6?=
 =?us-ascii?Q?QFaSpgZfDZZnMsrTObeR7b/tg9HpppgeFMb1Hfmtifs1BOwzq4KNUSCF5TFJ?=
 =?us-ascii?Q?T/ChkG9WTgOuWHKkAv3o8RNO2fJkX6sNnhfx7WITt/93v2102TjsTEWjS/dI?=
 =?us-ascii?Q?Nl+t5Onqg9zsVIJwK/FDG8B7SQP/ToJM2EzA2t6OTxpwauPkuhMHeV5cBMc3?=
 =?us-ascii?Q?bAGlaXr/iUix2ipN+0msZRW5bOFpMAN92JNq+yj/no2K1TuuExsFxHIkPWE5?=
 =?us-ascii?Q?vycz8yWbkK/qA8EXhbkn2fFVVbD6mIDD846P1ZVrj2OLQVuDDM2dSAkDJUWR?=
 =?us-ascii?Q?vujVg/hKqIK58DyZu0EjxByNnoIu+LIJXqiiTKLQTpLip/YLA1DJ/ryNBEaE?=
 =?us-ascii?Q?C+003kpNycM8eT8uxWw2YwYIlJ8nsdA3ST2GtO9x4YRks0QHyGdI8Ew7ufWE?=
 =?us-ascii?Q?OVg3Mi8oAS+U9rBfn7OaBkT+mwTu/AQJTwtXcmURXvEJ5Exei3jP5rXxpFsW?=
 =?us-ascii?Q?Yz4Jz8t4kzhZDzuOLau7bSbUL5TmG/1qdjtOruLtokkmfxUQPDK0EzTjIIj1?=
 =?us-ascii?Q?yDozsmHyqndzQaxuF4uzg6lzsZ3+pow+wMt4wzA3oEjORN4Lg3kKad4Rpz4G?=
 =?us-ascii?Q?ueUlHTyUkrUalKkrmKIQ6YtRFVZ4X5sZ4bJF1HCjJXxQAFyu0rSUkOqXrzPI?=
 =?us-ascii?Q?APsDHuGOjjkvtty8GUTOYjFWsfpxXLVvvwhsspbx05e9ZC7Y/VQzRJQ9rtY6?=
 =?us-ascii?Q?XJREm3tl4o22eXVaOro0Z7bEY4TlWRZ+Y9dh9d2yL8+JnW5ATDI1rewptayM?=
 =?us-ascii?Q?JAIX9dvdk0rY0cPGdAqKXiJPlyxbEGLVJ8NXJ04+c5RD3ii3g8efLBIXOrZm?=
 =?us-ascii?Q?EYjiup4e5wxzzY76TyV60bjxSLA4a97lMhctZk1dv70t4bhOYicE6x4BHYQH?=
 =?us-ascii?Q?1e3Iu3JbMHFaNbMn2hE2eIp9BVObdtdpGHj917YKEeDM9GsiP61ZTt92/ceG?=
 =?us-ascii?Q?er0RHUd0fNK4EVdBXbBdW1v9xn+BsKP3lT3KneqeVj2I/Poyj5uqmklPrsXa?=
 =?us-ascii?Q?/tMpYq7vZF8uuuzpfwix9L0yFzh+ZBkeY1OQk3+VkWtMN2ptoQECJmcHtjaR?=
 =?us-ascii?Q?eeV4EqbbGCAWts7xaayaY6zGvXCCF6Mxi1a334zn53AdWRRUly1JMiPfLGIO?=
 =?us-ascii?Q?U5TJhEXzQg19aSF+9oi9Z1++UNQOtatK2elr6G/HjLo3yJzNpcFlIvI86iCq?=
 =?us-ascii?Q?LH/Es1hSkM80YBov6seLkCN+SG5zRZPNP0fA1d/ILdqjsQgwHg7GpYAwONre?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 429f8c25-27ae-483c-8a9f-08dbda29dd14
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 15:55:54.2273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RCKrQ6FEAATZsFtaPIx8crjlRZw6IeWa51eokz+7fCpqBIjiO6cM2X0L7cqTOPLRumaONCUua7LE3FQhDuBchfxWfp4BLgQ/mQMAzPT7GDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7440
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add support for bcast multiple BISes

---
 profiles/audio/transport.c | 59 ++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 23ea267f6..eaafd8a35 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -163,7 +163,9 @@ find_transport_by_bap_stream(const struct bt_bap_stream *stream)
 		struct bap_transport *bap;
 
 		if (strcasecmp(uuid, PAC_SINK_UUID) &&
-				strcasecmp(uuid, PAC_SOURCE_UUID))
+				strcasecmp(uuid, PAC_SOURCE_UUID) &&
+				strcasecmp(uuid, BCAA_SERVICE_UUID) &&
+				strcasecmp(uuid, BAA_SERVICE_UUID))
 			continue;
 
 		bap = transport->data;
@@ -312,9 +314,11 @@ static void media_transport_remove_owner(struct media_transport *transport)
 		media_request_reply(owner->pending, EIO);
 
 	transport->owner = NULL;
-	if (bap->linked)
-		queue_foreach(bt_bap_stream_io_get_links(bap->stream),
-				linked_transport_remove_owner, owner);
+	if (bt_bap_stream_get_type(bap->stream) ==
+					BT_BAP_STREAM_TYPE_UCAST)
+		if (bap->linked)
+			queue_foreach(bt_bap_stream_io_get_links(bap->stream),
+					linked_transport_remove_owner, owner);
 
 	if (owner->watch)
 		g_dbus_remove_watch(btd_get_dbus_connection(), owner->watch);
@@ -496,9 +500,11 @@ static void media_transport_set_owner(struct media_transport *transport,
 	DBG("Transport %s Owner %s", transport->path, owner->name);
 	transport->owner = owner;
 
-	if (bap->linked)
-		queue_foreach(bt_bap_stream_io_get_links(bap->stream),
-				linked_transport_set_owner, owner);
+	if (bt_bap_stream_get_type(bap->stream) ==
+					BT_BAP_STREAM_TYPE_UCAST)
+		if (bap->linked)
+			queue_foreach(bt_bap_stream_io_get_links(bap->stream),
+					linked_transport_set_owner, owner);
 
 	owner->transport = transport;
 	owner->watch = g_dbus_add_disconnect_watch(btd_get_dbus_connection(),
@@ -641,6 +647,7 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 	const char *sender;
 	struct media_request *req;
 	guint id;
+	const char *uuid;
 
 	sender = dbus_message_get_sender(msg);
 
@@ -669,9 +676,12 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 	req = media_request_create(msg, id);
 	media_owner_add(owner, req);
 
-	if (bt_bap_stream_get_type(bap->stream) ==
-			BT_BAP_STREAM_TYPE_BCAST) {
-		bap_disable_complete(bap->stream, 0x00, 0x00, owner);
+	uuid = media_endpoint_get_uuid(transport->endpoint);
+	if (!strcasecmp(uuid, BCAA_SERVICE_UUID) ||
+				!strcasecmp(uuid, BAA_SERVICE_UUID)) {
+		if (bt_bap_stream_get_type(bap->stream) ==
+						BT_BAP_STREAM_TYPE_BCAST)
+			bap_disable_complete(bap->stream, 0x00, 0x00, owner);
 	}
 
 	return NULL;
@@ -686,7 +696,11 @@ static gboolean get_device(const GDBusPropertyTable *property,
 	if (transport->device)
 		path = device_get_path(transport->device);
 	else
-		path = adapter_get_path(transport->adapter);
+		/*
+		 *Use remote endpoint path as fake device path
+		 *for broadcast source transport
+		 */
+		path = transport->remote_endpoint;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
 
@@ -1272,7 +1286,9 @@ static bool match_link_transport(const void *data, const void *user_data)
 	if (!transport)
 		return false;
 
-	bap_update_links(transport);
+	if (bt_bap_stream_get_type((struct bt_bap_stream *)stream) ==
+						BT_BAP_STREAM_TYPE_UCAST)
+		bap_update_links(transport);
 
 	return true;
 }
@@ -1378,7 +1394,9 @@ static guint resume_bap(struct media_transport *transport,
 	if (bap->resume_id)
 		return 0;
 
-	bap_update_links(transport);
+	if (bt_bap_stream_get_type(bap->stream) ==
+					BT_BAP_STREAM_TYPE_UCAST)
+		bap_update_links(transport);
 
 	switch (bt_bap_stream_get_state(bap->stream)) {
 	case BT_BAP_STREAM_STATE_ENABLING:
@@ -1416,7 +1434,9 @@ static guint suspend_bap(struct media_transport *transport,
 	else
 		transport_set_state(transport, TRANSPORT_STATE_IDLE);
 
-	bap_update_links(transport);
+	if (bt_bap_stream_get_type(bap->stream) ==
+					BT_BAP_STREAM_TYPE_UCAST)
+		bap_update_links(transport);
 
 	return bt_bap_stream_disable(bap->stream, bap->linked, func, owner);
 }
@@ -1491,9 +1511,10 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 		/* If a request is pending wait it to complete */
 		if (owner && owner->pending)
 			return;
-		bap_update_links(transport);
-		if (!media_endpoint_is_broadcast(transport->endpoint))
+		if (!media_endpoint_is_broadcast(transport->endpoint)) {
+			bap_update_links(transport);
 			bap_update_qos(transport);
+		}
 		else if (bt_bap_stream_io_dir(stream) != BT_BAP_BCAST_SOURCE)
 			bap_update_bcast_qos(transport);
 		transport_update_playing(transport, FALSE);
@@ -1510,7 +1531,7 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 			bap_update_bcast_qos(transport);
 		break;
 	case BT_BAP_STREAM_STATE_RELEASING:
-		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SINK)
+		if (!bt_bap_stream_io_dir(stream))
 			return;
 		break;
 	}
@@ -1555,7 +1576,9 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 	if (bap->stream != stream)
 		return;
 
-	bap_update_links(transport);
+	if (bt_bap_stream_get_type(bap->stream) ==
+					BT_BAP_STREAM_TYPE_UCAST)
+		bap_update_links(transport);
 }
 
 static void free_bap(void *data)
-- 
2.39.2

