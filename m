Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56A1C25B48
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Oct 2023 14:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345342AbjJZOv2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Oct 2023 10:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbjJZOvZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Oct 2023 10:51:25 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2042.outbound.protection.outlook.com [40.107.7.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC571B1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Oct 2023 07:51:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+qe3UnUI96hi7kFS0kimAfG0k9YI5Q54Kqy2zAemzU3H8eCjrJH7pAXhFVDUwifuHl8b+rMNqNC5ECqg4uadkkOMAqrBNhZXDemTM83h7Qf7JDKq18IvOLnM8lFrU7NoM3FLR3VYQGAmD5YgMgjJMYP/ZcQ+UiXT9ljE2py+3/Qebng+mcb9DzEt0Gmcdat/aE2gQ4EQnkJANcwdNabYnduhwTJNBz61GFzvd45QFbRkzOHusxgzdcC8IfeIC4xuH6gehnYbJG073yrqQ9LXryUan5Jmcf1DKXFMao0J+Y9VY4IaPgdhsoRYs/WKJYJeVvWOfFG8qunNCvGVjABuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PStRI6Sc+im+fV1R3VxEWQmhdSb+AUVAfa0PshTOKY0=;
 b=VzwO42HCjwmeSs/3OAC4c1M4OjhpDMnQvLZlcfUl1RY1qaHXTmHiWjh7PlBL6YH1woT1uSbfref8xne1xHzG8iaeqxfTYkwek7YEwC3ihPVwuFMi5PNizkKB75U2IHG7jwlTyupYoUmM4NV9QECR8UiCyaAughi9zUyUDkcHDgrE2I9HtLSv9gva+/g5oYqJ0Nq1Wafd1mXKHs331uXVxQI1uJBZWhKO0oS/HOj+J6jpqZVz9B65xmW6waKYsEIcZu4OlaggZvdBzAHOPWp59MoiCpv188cQrysYHSqoBQWFTEnRHNLJif3Vfh/CWP50eGwWJN1uPvqZ6pTDFQs+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PStRI6Sc+im+fV1R3VxEWQmhdSb+AUVAfa0PshTOKY0=;
 b=CF67fyFTK9i4DsltYPg6s1+kzJt0A+WzOVSkRw+U4rHVjpr8CBsxu4HwjndGb3vjUHNfhmdfAcJMC0n6VguvaeoCi1FQ2KRN+boo1ScTeMa1YcF45+XwXJKm0s17yASiQY5s4Nwd6QGC4lk4YBBwHGzlbI5cBNhf/blPkNrXgg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com (2603:10a6:10:ca::21)
 by DB9PR04MB9939.eurprd04.prod.outlook.com (2603:10a6:10:4c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.10; Thu, 26 Oct
 2023 14:51:13 +0000
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a]) by DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a%7]) with mapi id 15.20.6933.009; Thu, 26 Oct 2023
 14:51:13 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        iulia.tanasescu@nxp.com
Subject: [PATCH 5/6] profiles/audio/transport.c: Add support for multiple BISes
Date:   Thu, 26 Oct 2023 17:50:46 +0300
Message-Id: <20231026145047.4637-6-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231026145047.4637-1-silviu.barbulescu@nxp.com>
References: <20231026145047.4637-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::15) To DBBPR04MB6331.eurprd04.prod.outlook.com
 (2603:10a6:10:ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB6331:EE_|DB9PR04MB9939:EE_
X-MS-Office365-Filtering-Correlation-Id: eb1eeae7-7c05-4061-c95c-08dbd632fff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aWwvXnMHxga5h0KuefkoMbums9F/E6zRifRSGSRqRtG3c6p3ptW/hRGMTnUipRc1hRm0RDS2kD9m+ZaHfokeT1brEMXpis5g4gfAwKrXq+BGrOAlVOpzCVDj5wMallryupVfFXjd65UUum/TZfFfnXljm0frsBJNaTa/wJHCkHbIHyer9SS9GZMrouzAXk7+jafvqWFW9iIYIAh2s161xWraiH174rU5ijNlk34ju4PjaUKufSb2Pcfu4I8SlUBRyJ8BHGaTgKgxl+6EUpheAxMDRzuSU8dx9f4zogi3/V2VmcbCMWtfV0zPjbRtgOOWjMHuDVUqE2nBQo0pIaRcQGDozZZaIVs0gIj7kOgurxAmw9XfYmAlkrEYIm7+OC9LyIhOzCLyJv8/GmH/rXkfFSHFXOvIAX6IxnQ7v6Gwi+it653Qj+pDC7LUFSCPozek2e5dCbWgZoE492DaxhN+s6C0ZtGi4zI02n/Sd4QXY9BZiYI9v/me1GjDheOlGy/F5G+IkvoZBvDKcM9LlVfk7+ZUL62PZ46TmpfR4/e7VIsiKaQDvaI+1V/nnrcsT/j5l7P0dcOQW0LQpEiIpbw2Yd7h7ebsHKocqsqiViKhVTsASIrSbz11F7PVljhu+wE0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(66556008)(66946007)(316002)(41300700001)(66476007)(478600001)(6916009)(4326008)(6506007)(6512007)(6666004)(8676002)(8936002)(6486002)(1076003)(26005)(5660300002)(2616005)(83380400001)(2906002)(2013699003)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?emXqsPv3Rw8p1Zl5kqmE6zrXQ51cZVh9nbpcRKeG3A03bGfUGR3o70pLa8T2?=
 =?us-ascii?Q?yxikJ9ezItaBUgrY+7m4HGj+dE7TIenoQtz0g+k3cpNmLsUsPNKns85VLMZU?=
 =?us-ascii?Q?FTdYA9k7e1IibG4UCF3G1iEfkpnpth3q3W/5KSSZKkKSVtIw+MHbtdY4iNEg?=
 =?us-ascii?Q?tM2GptS5steJ0TVpH2h0AKitvs8FMX31R5Tzwc2Pydj6Ih9exAKqmf9JPwW1?=
 =?us-ascii?Q?6ZT7yC0CZS09g6PmpUP56Jcwwa+IXOjrk+yAW5IJ375C0tlG0NrJo0s1f9Pl?=
 =?us-ascii?Q?CNHzPB6EltysqUZJXW5GLHV/wBtmFBYsSiidd39gUauYZN+0YhhShxF7a5GL?=
 =?us-ascii?Q?z0tpueJP4EBNa7X/hl5R5LGmm83DrUZThzMzmZLhWUvk5StKwzlhvd0AoVM9?=
 =?us-ascii?Q?2ztMUzKCDbzjrmJNWBlUIgDe6p7/YTmg8PKYnNiTQcpvHvWWBVeLDGIgGtA4?=
 =?us-ascii?Q?/yTn/SthB/N6RxS3TAyTNj1BLrtoDla4aL1mh2fxxWV3zMgbDaLfbE2Asg4F?=
 =?us-ascii?Q?ZzFE8RpIs3GLBpnk40+KjYEPCwUsoe4i5t6sM0iz1s51Zhxb1cnP+mUeFqHv?=
 =?us-ascii?Q?1DcFuXx3VaBvNAXXPjRvK5A44mhmEpdsJt9CbnbO2uAuOh5hxHQzC01emZPA?=
 =?us-ascii?Q?bbnpD/UF+wYy0MtrVXemsjqRwOp+EgQJibFIyzGLPeQkwNAj4slezmfLRhfj?=
 =?us-ascii?Q?94QqBjIDdth2zxTJO6XetfU//7xVQpQpdFLu3LEr79yzvn9jWlRU/n2Kwk9p?=
 =?us-ascii?Q?sxpOLnJPAJi0ZRz5g+vq4M5sCXl6MHK22rAignNaHK0DhJ9TjFyjAGSGrO1Z?=
 =?us-ascii?Q?UM07qdL/e2BpNo5G/RainN4hMpejs6LfYwM0bkxqxWytDKUC/9WpBlDU013s?=
 =?us-ascii?Q?NcB2uSFzRcd18nRYPwpJwZq4py4MSlUK2MLJqek1ScyzpDAIvyNFl78YLx5F?=
 =?us-ascii?Q?IpPOlXSpDG7qPgsOSoOW4wJJ1IKuh83p3vjWPMPVXI4B27Ob7cB/2cBWMu9d?=
 =?us-ascii?Q?MyHoqyKpZR2dxBdguMr4T8M3FatYN/NDx0PKSz/k1zTiEFtRsziNS/bqr79D?=
 =?us-ascii?Q?DlUTQ8ZjzXVePSCAhBO0jc8STl96Z5HLiBecFuYPqE4x1vUdSYsMPYBmpShG?=
 =?us-ascii?Q?ClUZSkIstSbetPuEzczOK0qk6Zh/rCo17/kMZbu6ruL4VsyJCbmbZf/CbWHj?=
 =?us-ascii?Q?lMb4z1tAdnp7fbkwm0I+Uf4qYr9BUwSiAg1UMWbJDp28z6vxTznhXyl7VJ9x?=
 =?us-ascii?Q?2ysA6bZP49AQTxdjy43RyM+DJ2rVVDayh0GNJ/HgUqF9cEjDJd/yxXfPZk5K?=
 =?us-ascii?Q?XjtVRCrperZdx0GygMy4yTizo17us2OD7Cpx4P3nzHfdM/i6/Fz8cwEcTa/y?=
 =?us-ascii?Q?0hc1lij+1Mrs3OuQWMoF+m7taqXNs4g7D4rqVIrI2kplL0ZdclLbWpktUN/7?=
 =?us-ascii?Q?hfWDWh0ltboVIaM4AU2DlOh+RbgEmM7Bk1cHt1S4ylkHHe7RnOmByF8fUv/M?=
 =?us-ascii?Q?R5u/8TaK5EFIUXEeT9iHOYAl8D1VFpKAVGyKiNgdc5Q91+DFRPd7NzrlLBoK?=
 =?us-ascii?Q?OkFVRtmj0/qEu+hSdG5m/f0d8gVLe+DjPi2aWZgw3+ROcN/gPEdd0/9i4iKy?=
 =?us-ascii?Q?8w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1eeae7-7c05-4061-c95c-08dbd632fff1
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:51:13.6934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6GqbuOlZVUUcCxtzvbiKBkNPnkt89fcCCUmnEaYALPdXjWsblXMpU6Qwa04+iufxcHlbcmgr6secdg9NZyWBvEDpxFjzwPK7L6hTRcMqkrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9939
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add support for multiple BISes in broadcast source and sink

---
 profiles/audio/transport.c | 49 ++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 23ea267f6..dff73e0f7 100644
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
@@ -686,7 +692,11 @@ static gboolean get_device(const GDBusPropertyTable *property,
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
 
@@ -1272,7 +1282,9 @@ static bool match_link_transport(const void *data, const void *user_data)
 	if (!transport)
 		return false;
 
-	bap_update_links(transport);
+	if (bt_bap_stream_get_type((struct bt_bap_stream *)stream) ==
+						BT_BAP_STREAM_TYPE_UCAST)
+		bap_update_links(transport);
 
 	return true;
 }
@@ -1378,7 +1390,9 @@ static guint resume_bap(struct media_transport *transport,
 	if (bap->resume_id)
 		return 0;
 
-	bap_update_links(transport);
+	if (bt_bap_stream_get_type(bap->stream) ==
+					BT_BAP_STREAM_TYPE_UCAST)
+		bap_update_links(transport);
 
 	switch (bt_bap_stream_get_state(bap->stream)) {
 	case BT_BAP_STREAM_STATE_ENABLING:
@@ -1416,7 +1430,9 @@ static guint suspend_bap(struct media_transport *transport,
 	else
 		transport_set_state(transport, TRANSPORT_STATE_IDLE);
 
-	bap_update_links(transport);
+	if (bt_bap_stream_get_type(bap->stream) ==
+					BT_BAP_STREAM_TYPE_UCAST)
+		bap_update_links(transport);
 
 	return bt_bap_stream_disable(bap->stream, bap->linked, func, owner);
 }
@@ -1491,9 +1507,10 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
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
@@ -1510,7 +1527,7 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 			bap_update_bcast_qos(transport);
 		break;
 	case BT_BAP_STREAM_STATE_RELEASING:
-		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SINK)
+		if (!bt_bap_stream_io_dir(stream))
 			return;
 		break;
 	}
@@ -1555,7 +1572,9 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
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

