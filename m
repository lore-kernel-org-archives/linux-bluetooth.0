Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C25AC4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Nov 2023 15:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377029AbjKBP7B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Nov 2023 11:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377051AbjKBP66 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Nov 2023 11:58:58 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBBF18C
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Nov 2023 08:58:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhBnr3ru3Ie73NoH2jK8xHcA2LhyiG7Z1XjpCMwHXID+KyhVLh3UqBoKr0h3BLGScdQSlq9nLyOmiN1OWukbkNdqmbk+I+oFJMEUOXaHuH9oh0ylX/vCqv+0W/q7HadHmc0PY7QcU+dGjZeRyjatW+fwgS8aGxzb2cfyTxZRPi/KQD1RcA9SOjL9kFcfmOOyLbs/zvDgXMZuwRN9pFzPKX4Amu5IO0HVzuje32smtzcC+Nk6sE+CqGcL4aC0o1xQWSNbePnw1RAiFQr3qZzSpvJV4o0mIY9q3+QMWXdZQAAQOaF6fDbe/hb8FZTXbGFxoE+QqfC03D7vJhqAfGWKIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/MoR3CeKgusR4AD2j8Im/7Sgya094xGwNBknJJYytk=;
 b=B7RtKhTkQgMK2C5DvP3855TN6hHioNGtluxPApDL2MLRQd4eIytz//ltZpgnB7ImI15ocXKLSWIhK3CJyI4EXoxlwe9Ndpo5pSvCefpbHdDrHCb7adzbERlRBFI/QeynraGSLn1MUXAlOtG/Ahf0gCnZzIwaYNgkUcg+mgJPvy5kbi0VRhymBGHTxGZJ57G/k/Da2v3do6epXNy4F8p7aF4+w+lMs8gWtJhJMK0KRAIokjk5zFtMAPfSnYf8Sw298oudR1E2lwx/vkFmvq+REpCO6VeUlEovVFt0zS8tLgFjCz1IzbI4+tR2a7Jow/hRUxt2+UuBe2SR8oN307tq9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/MoR3CeKgusR4AD2j8Im/7Sgya094xGwNBknJJYytk=;
 b=OXMSdrg5wy7o4PjdHYjrqrublbbrInZUCH45Kxb5WvkAdL0XMZ/TLieFZqC+MGXTsryU/7H/efIieyAoTQM1JH9OS+f0aVWEaIwBHsr/k4BXFKn0uAdijXB6G6IcxiteSxfDWF2AKornwRN9HxkZDPTMfpwHeJAcCyxjKj4Fna8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com (2603:10a6:10:ca::21)
 by PAXPR04MB9005.eurprd04.prod.outlook.com (2603:10a6:102:210::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.18; Thu, 2 Nov
 2023 15:58:42 +0000
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a]) by DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a%7]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 15:58:42 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        iulia.tanasescu@nxp.com
Subject: [PATCH v3 4/5] profiles/audio/transport.c: Add support multiple BIS
Date:   Thu,  2 Nov 2023 17:58:26 +0200
Message-Id: <20231102155827.4219-5-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231102155827.4219-1-silviu.barbulescu@nxp.com>
References: <20231102155827.4219-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0308.eurprd07.prod.outlook.com
 (2603:10a6:800:130::36) To DBBPR04MB6331.eurprd04.prod.outlook.com
 (2603:10a6:10:ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB6331:EE_|PAXPR04MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: 3008d46c-f8ac-4d7a-8839-08dbdbbc963c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OHDibp9NU+tTYegAQupIHq13dme3WxJBsS91248v+B2YUh9X70Ymlb2g+K9Tz7kZX5t/nCdDyzhibMOa1VCWWuIvGPA17fdQWCXh+gzKY4QPZP6hYFaJK7sZZvv5wPj/jbtP1wGXCqHLwPn09+skBzmZh0N+zRaEEomeS7rnEKlW0OBfJKxw6OkgEjFMt54dDDTkPcwR5OTLO6aeQG/9Zc+97frZ7AsrltYHzpguoeFYJIlF/uziEOwQBx7Yp1IrSahqDzfiu1joJtdoguHB9SQUokkYEFoCNPeNS/WdcWrgVl0zSXLOKlhJbqxFUkV92u0T/zDyzkT9KMaV4vjeHCqGCzD1KZJSq5ijhvtHRevE5fEqdLo98dww2k55dYzzfZo+C/vgqvug5YIZ0CK2qpD32dyp0jj3d87kjtAz/k/5GjYf1m7bnTGYlvl58r8Ff55Y7wY9DUIYcDpe7SuRQ6VnhlgPW0uKyF3MvEf2itaosoASy7WntMCn8fXvTo6Wl+d47zkpE9bUJlZdiNlz2JxbojZ1T9QFL2gVp72LLcPDA7h5bOFNZp/CF/XVLVdhuQRoaxRztVU/4kqKpIQVr2LepaaArU5G5Nz4TaC5pm53y9QvDxE99dJlO7iBBjDa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(6512007)(1076003)(478600001)(6506007)(83380400001)(6666004)(8936002)(8676002)(66946007)(41300700001)(5660300002)(66556008)(6486002)(2616005)(66476007)(6916009)(316002)(4326008)(38100700002)(2013699003)(86362001)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P5MjFvXeToxfcyaAnQDNmxSyDXV8BgxmpoAJszIw4XrdQTu3YKqDzjW4GWfd?=
 =?us-ascii?Q?FtikWNWvqK/iR56oJnvWIyXH9iooBmTJ70A2LyNiIyOZVrTU3Dh2+tiHANoS?=
 =?us-ascii?Q?JF4d98Io5tw5VGcxe0UqI+dQSbHwwdBR8VxlCycWGG3XsFCRZMS4XOT/jQdJ?=
 =?us-ascii?Q?W5CANcCacl81oc2kb//NVpeL7wJ5o+5j0BK6sr46jhS8ZnhJriWAgk1ljp/Q?=
 =?us-ascii?Q?aDoLA/kZtQSfOoz+dy3io5jDZVOVlIqKH8r25QMQaNdtRCzWpjba6G/CVDRP?=
 =?us-ascii?Q?svwCCZBTFL0zKD9pqdKTCCk9n7k2xxPW7LQJg1f8azzI2H6ZaY19P2hWBCg0?=
 =?us-ascii?Q?/ZZ+d5D1+SG36k06nLjSkyrV3fUg+ykyVpSIQlcUqGZrzXI4f25o6G1dnrPu?=
 =?us-ascii?Q?uBAgmPyzd7smdnV/g/F4TDh5RlJE875gCcC3LTTKH5LJN3sUGEElH64bbJoO?=
 =?us-ascii?Q?4tm3TKroDTjboJ7o5ytuyIO0HaaEbT5dL62j4moBfqPY2XghFmkR3xDrch+2?=
 =?us-ascii?Q?9jrdM9jJfWQrruvxNiF4Qv0/Git6OKCBE+ZXNP/8zEfwKDrPhFWVrgIfd0Uq?=
 =?us-ascii?Q?f7vSD7ZZ+U7AF3VNzoTKWi21myIAALZaAoQGtf/CYRRjjmsR1VEhiyYI9S8D?=
 =?us-ascii?Q?fXmniGJPnNo2u8NhfsdZQt+/MRDzd93bdmbFh1n4okvCjeOcJbng3O+yWNZn?=
 =?us-ascii?Q?DoAUAIKl2w1efM0w4OLf0/n5+IMm8IL5GM0q8mp0ie8AsSbi5bCoPT52//R2?=
 =?us-ascii?Q?GpusO8Reeh+aebkYucAnO1EAJzZ+Lcrok2DP/LYpVL037QIsUWtT+yNWqtl4?=
 =?us-ascii?Q?PvAbkK8UrbJ7f5OnJ5FyFD2tEqF8N0yIT9ufNjzWBSybYGQCtcoYQdZpOfwm?=
 =?us-ascii?Q?qTv8csJFHdjIzqC46w+b7rUbKmhXk4oZhan3KHkqH7Y9tsGw85ZSCCcpOTp0?=
 =?us-ascii?Q?/paw7dVAE1FFlQrkJjvXbIZ4D+vkHZGj83RuHsT08ZVNoxI3X0ujTX93sAtn?=
 =?us-ascii?Q?26ZoxPGMrxSYHn8/YivT7OyXr1Dn+0yo1eR4DJmibqstIVNXTsaccvDAzCnc?=
 =?us-ascii?Q?UDpBpOtUbHm4aUwCxAefFE6SGsCA7111P1nJzAKvLBIMwAWwnVlXCJZzUTbu?=
 =?us-ascii?Q?+E5MvZ43T3itKWO80fgdlhDr+gJC1eiHUWGnSUpXsWd5iBdo6ar2vquRwWeu?=
 =?us-ascii?Q?m4TKWUrNS1bpWBS1s5Zo0Y46+nQ7uKeAaPvlTTbqiaBu5p2r+wAhbeEXztLw?=
 =?us-ascii?Q?o2h8Y2b9ZN1diiLscp850uJqKxGK589xeFrm12g9IemnHPxYwyX1XU7ewNeD?=
 =?us-ascii?Q?1JCL9N8d3bnKIofGw5I2vpNTcTex9QJR83jL6KQEnmZWC3fSP2owuLa0vB5k?=
 =?us-ascii?Q?Ry0ueNxHFE+r4jmqAKH5bUs59w9TagCbwu1EaAAr67E7dfqKkQd++tj52Zfx?=
 =?us-ascii?Q?QTwHR3giAhZJiD5xj9ZzLPiGU6hIRlrZiEiyi4h/wVXKG6SLWsocJ9aXo3K/?=
 =?us-ascii?Q?5e/LEA1bxBSrOvpoO+XiCbzGSrH2n3jERs61N3logpaFk6lQDs5mDTjTdvsI?=
 =?us-ascii?Q?T1N+7WjQBl+Nkwq0bHfcxT6sm4zfZkgdz6jpRdgqx87FrR1r0DzuPlE+GtTW?=
 =?us-ascii?Q?uw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3008d46c-f8ac-4d7a-8839-08dbdbbc963c
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 15:58:42.7526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNbSi1Dy6pEc/fHZwSsAIVF52O/x9ET1e9uklXq7kzUbclgJ8wxZAKnzcnCaBfZn4k7RyuzYnUUECGdG1eQfNNDfnr54l7NIDoajbqhqEUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9005
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

