Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pdonDNZO"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2048.outbound.protection.outlook.com [40.107.249.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE951D48
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Nov 2023 13:59:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/JJqj27Auq+/M27LKOmXaj+9xauTQqQ4SdXikPsfznVj0/w5KlgpKlL3PG5M8Ce9illo9wzjAJSxY3a5x78VpKnjvwoAZXe0j1cF4k7CH84+KuwNk4e4XkmNFpkzj4ejajcLRR3UYqH+dHubVNtrf1Hl6+rKFskAEVu8QcXb0c7YGiiuWX4Q5Vs+NhULdNlcq13OeOTjnJue6ipZsFXfkzmxt1Rtw9qJ0tvKyos3HJu1LRDXAhWcl3/EiU09URK4mkibAvmOdMeiH1OM4vgx5KmQ6/CzvhCeqlw1quwyymm752Ubi42veCLNTyx2U+OgKTHrKytxu3JRrUo31vgPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5o/EBiPBu/tEzObrt1VQSFTsiM0lJ4w3xJaZgEBT098=;
 b=JYjIa3Dqcl0YXQM3Jng1OGcR7c2YYZqea1vhuN5Khk3cze07O5jHDpWIiT/VPoHYgJo9Co5GZPAQG0HPHOFod+8W9x//fsSLzoNfjF43G4jyNyDK8lRjj6+maOIV7xmIR5I1K4VGXebU7VWh0aySO8zCtGD+kyPSNXTprPwiLRegXgjp9RuScUxcAlKkr0ATD7f+l8k2FHyu9Ir0tSqz9+9E7IffFvS5iNN0I54Ar3NsuPiXFyG2Q0uw2DO7DZJrFvg6A/X4jqKEqTPt+RsMwEmmrvr7Hvfgg3b9GrhpWXXgzcjCUGLgqbLAVXj5Fhbn8tKGlhcux8g90kP+Bwk+lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5o/EBiPBu/tEzObrt1VQSFTsiM0lJ4w3xJaZgEBT098=;
 b=pdonDNZOCnnfwsdx7tAV3Ngmw8BFSgZM9CVeUVTDmkmFvWviVyl+m8qszNjUlCDiheE7amlYtZMXBfmFOsPpqhZ82b+0nYbqiRRY/XDf6aWGei1eRSrCKKLRN0k8kTVRgWrsDze6RP+zUl39RfWS+AxotL/bwVWXjjj3q/DlXfY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by PAXPR04MB8335.eurprd04.prod.outlook.com (2603:10a6:102:1c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.14; Thu, 23 Nov
 2023 21:59:50 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c38d:98a0:a823:d88a]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c38d:98a0:a823:d88a%6]) with mapi id 15.20.7046.012; Thu, 23 Nov 2023
 21:59:50 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v6 4/5] audio/transport.c: Add support for multiple BISes
Date: Thu, 23 Nov 2023 23:59:34 +0200
Message-Id: <20231123215935.73501-5-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123215935.73501-1-silviu.barbulescu@nxp.com>
References: <20231123215935.73501-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7b::15) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|PAXPR04MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f5740e-6f05-4c91-8af3-08dbec6f8432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h6/sukt91m7UzJ7jJms0BjeAShUmoSOqEWOQswNcEzVDcEwUDx7COVKiGp++7zPAoku6BUm+Gxe5G4Saj7C2WdUOesnWJ6d9RgMxImjiweUMsNhHvZOwU7bQFfh1S+BgMddGJxS49zb8ekGEFxRYZ3A/LWv2waq1J2vPhBRC35nz13tFeiVH+0aXi06kyaC1CH+ZWtWW/dgIR8AWofalb0iPLxLbiz2SJaGWBtE4PhHmww35YFOe733WyHNjXMm2B42MRtxHSW4DMXw2WqN8Yz+h1EqKMVPzDW1MchAOVY0xA6oxvudM9P6epjcsh3eSSEvW85DuhKTgYNfWN9UESU6kT4E675rlTP5TaxZgQaqFyJs3M3+tyiMVoAjsf4oTVEczA/5RLZHeq8+8+tfXcqSwalO8ORdKAILzhNLZjs1xF5c4ZVC3Oa44e7GYYZ3MvrWgig+vcCIT69qWR/weNgFwLN+MmfKoaawITk1bSn6/0dJjfjjfPfbyedIqqO7lucTSEOU8+Qi7dSFIr0hh/Ppy7bhA7ISHBHOgdq3rXiJYechxALyeyRE3Sw0VT4Z4oohWp6BKZeDwv+ZLwR9AgpMvBKREPn0Y8w3u319z3H8mVJ34+wwkQwH988P7cqFe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(2616005)(316002)(66476007)(6916009)(66556008)(6512007)(1076003)(26005)(66946007)(8676002)(8936002)(83380400001)(478600001)(6486002)(6666004)(4326008)(6506007)(5660300002)(2906002)(38100700002)(41300700001)(2013699003)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LBpjdNRV4QxCe3A/PFjaEig2aSu+yuM5SDSm0eyF+aCkhMDE4wnnVrB4cykH?=
 =?us-ascii?Q?HwfqjjQT+xAI0e+FHNTLV4ogYSQ+EvP8l5J0rdqC2ifZXEjgD8EG+q66/kq2?=
 =?us-ascii?Q?z+OrmvlMv5dwA1g1QlYbfb/LuLtlfmZhUoBjKI4yX5gFcTeiG6tT9+mfu8hx?=
 =?us-ascii?Q?pGFN7sheIopOVouo6arcEyBdjJUhrTLfi2fwIM5a11ITPzdPRzP4uOF1cMrQ?=
 =?us-ascii?Q?BJc9N27AIi+v1KF9jTOLD5+8yO7+bRA5RUUhcSvRiGroBDck2E1i0VJYaSW2?=
 =?us-ascii?Q?Taz0RDVJzI+X1JOjNccduFK3UDmH7SWhvl1zX/alKBn1nFRryUOmY0Wx5G1o?=
 =?us-ascii?Q?1uLjGqLiepmIwW56jISXzi0OHqHij4VSONAItUUWpgQGrvsnh2vF4HvH5d3a?=
 =?us-ascii?Q?PTtZaYkWIDBPb9InAqfCRKN42i/Y2CMnqkM6KVj/0edYlwlod81x9swGeMbS?=
 =?us-ascii?Q?pxTR5cXvhTvBkvtXv8GyJEpMy89MwUoI2EtozzngAgIyOvX5C6XhDfk2KPU7?=
 =?us-ascii?Q?3LxOOwcXmdT01D3PCRfMXS+TDnogj8oO4NZFt4JJCGnIwcso9/p40/IoG1j/?=
 =?us-ascii?Q?28XzUhL9WdSVo2tdDVXBNgxUYObi9mzuxl34KP2X4HUpO097BSCtPoo4VpyJ?=
 =?us-ascii?Q?KQBSH+T5oyrjfkAsYn5s4cn7hq4LC9C0hMbobiydVoT4HBUi5OKchIGQHGtA?=
 =?us-ascii?Q?K2EbipNVg4CL4w2eIf47wW3OmK1Sy9Mqfd7dQ6KnlYCx8IpV4CbIsQpfq/ZN?=
 =?us-ascii?Q?4kuZjUVrI6BCC7KWwqKvHztO2C/7Wwu7s6GBL4su4cyNU072Leyb03CuIRFA?=
 =?us-ascii?Q?qCZqRpDs3lzgns2VGbMXbcD7MThtGYIxREgnLE9ByFrjeIpHupzus/Xpy4yE?=
 =?us-ascii?Q?ojRXEHrRKD903CasIaGkvGwP5JfSUx6ev1SHlv0eeO0RiAMeSG/qOTOKVQOk?=
 =?us-ascii?Q?+SdLQ0tTfAfCY64pkaR67So0DgFB3DpBrGjyew2PgmjmHI+wmDHIi1ZvCwds?=
 =?us-ascii?Q?YB1SUJCEmVgmPw1cRH0e0fLS6x08ATvW6Fg2oJ5FfbLJSoXpxXZzVPwbn0Zu?=
 =?us-ascii?Q?LypaIg/jGn36vcj9/fM4WT/+FiQCgVjg72TF7WjSnA9Aot9GmeGu20xAMtmC?=
 =?us-ascii?Q?9MeeaKvnPTl4VB788FiC28zLPyh+CQ104iW8FKXmXunNj1BSxEWO7zUAIkYl?=
 =?us-ascii?Q?1Ah0VcsdWaLt1835hZlGjNXVl1OfiUWSUi0ISEpvYOirO2J1zSHMc/unM3dS?=
 =?us-ascii?Q?8GZocStTQxzOXdWBiNeuhxkAzlU1X/mdKS08JG5Bq7li0JLf50dclI3AiXjP?=
 =?us-ascii?Q?tTFp2k5BsJ4Iig5aeR0EZCuhXHC0/GXoktF3mMKNZOizUkzJt4oOZJrx2XJk?=
 =?us-ascii?Q?aS0xdr/8Szkso5BuaG/7wKn7AO/ncJHQQh6S37Yj4YA33c3m9jjjQmpzFXFp?=
 =?us-ascii?Q?2XRKr5I+q+LDF86ohvm9QVHuPxJ9LWmbDvoyZ5TYHQyUCZrqgylV+pv5/Fge?=
 =?us-ascii?Q?o/PF9H7ID/18aC+JmzTJLclZjezfhyZbe0K8js+ptmONd9tLg4OE+Goq+obS?=
 =?us-ascii?Q?ROcdDlzaTjgD10LrfrYmlRUv8unDLGtm2MbL7T6o2Jl6Y+7bLyFtGvkCBarH?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f5740e-6f05-4c91-8af3-08dbec6f8432
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 21:59:50.7947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NnzCid7ozQ8jrt+GR3DcyjeePg079JgqSrKWJs7AQ6b4dGiOdEWJZYFy01ZJCX5fgLoBXNl5073j/V6cEmW2QAgnqhLG2Vz11S16RRC2gio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8335

Add support for bcast multiple BISes in profiles/audio/transport.c

---
 profiles/audio/transport.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 23ea267f6..6f3dd68be 100644
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
@@ -312,8 +314,9 @@ static void media_transport_remove_owner(struct media_transport *transport)
 		media_request_reply(owner->pending, EIO);
 
 	transport->owner = NULL;
+
 	if (bap->linked)
-		queue_foreach(bt_bap_stream_io_get_links(bap->stream),
+		bt_bap_stream_foreach_link(bap->stream,
 				linked_transport_remove_owner, owner);
 
 	if (owner->watch)
@@ -497,7 +500,7 @@ static void media_transport_set_owner(struct media_transport *transport,
 	transport->owner = owner;
 
 	if (bap->linked)
-		queue_foreach(bt_bap_stream_io_get_links(bap->stream),
+		bt_bap_stream_foreach_link(bap->stream,
 				linked_transport_set_owner, owner);
 
 	owner->transport = transport;
@@ -641,6 +644,7 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 	const char *sender;
 	struct media_request *req;
 	guint id;
+	const char *uuid;
 
 	sender = dbus_message_get_sender(msg);
 
@@ -669,9 +673,12 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
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
@@ -686,7 +693,11 @@ static gboolean get_device(const GDBusPropertyTable *property,
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
 
@@ -1282,6 +1293,10 @@ static void bap_update_links(const struct media_transport *transport)
 	struct bap_transport *bap = transport->data;
 	struct queue *links = bt_bap_stream_io_get_links(bap->stream);
 
+	if (bt_bap_stream_get_type(bap->stream) !=
+					BT_BAP_STREAM_TYPE_UCAST)
+		return;
+
 	if (bap->linked == !queue_isempty(links))
 		return;
 
@@ -1491,9 +1506,10 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
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
@@ -1510,7 +1526,7 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 			bap_update_bcast_qos(transport);
 		break;
 	case BT_BAP_STREAM_STATE_RELEASING:
-		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SINK)
+		if (!bt_bap_stream_io_dir(stream))
 			return;
 		break;
 	}
-- 
2.39.2

