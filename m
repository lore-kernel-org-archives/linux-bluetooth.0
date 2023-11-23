Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LmicK89Z"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2064.outbound.protection.outlook.com [40.107.247.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6B0D54
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Nov 2023 07:10:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYeYBwWi83aP8oJ/T5nu/K5AGCDUiJG8kA58DbZvJoi6dijQ9RvMlbnNAkpvHsgv2GU6ZuRTEnEFWS6wsDDE49GARlD8hLyLksCS285t4Dr6eFp1Sb4NX+QT01ArvAqCeBbIAzaULOpcsnVfUs1NFgrhH37rzBuflU2EPhwxJrJx0DOz6R/s0wg8Q74wNDEPr3ixfJ2rNC4GgyuOVPtnFC9/VMsBiYEhtByLbvBsopJmpeY7aFPaxIlARLhs7qOeLJBUc4sSa811QNRJvU+Y2pQjnwBhrnZnekxFmaQT7046oasCaUPIyTkWf19bKFtG0xX38VA+x+Qp579VLb0kVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5o/EBiPBu/tEzObrt1VQSFTsiM0lJ4w3xJaZgEBT098=;
 b=THkOCKat/iN4W8FI4pbuQgOaBfejUGRr5NkbUNUtVEw6GDuh2ztbbpxAUlxdDYVwIWDjQn3JgdlJLs+dUcMuPz+MOGkirw+jyuCl2zNju7R5C00yIhATiYFQSReTSdqV0W05K5SxI7BcQcWBMu/GmjHqljIhO95KgJWiOLkyHkHNHhzTpv32KZ8vmQIgnAmYvmRfzduZihdEwjzwdsjYbMzRyJqhIu9WrLvchY+OPc0amtY3gBzEBIGOYPe2fVOglgec7IuIxRlXw3SV6qnHvJPAAv1JaR3trLjtnuTtbUvJ1mDaA6dW26//yS+4Qo8DjfqPscJj5LdpQGe5Rxw0kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5o/EBiPBu/tEzObrt1VQSFTsiM0lJ4w3xJaZgEBT098=;
 b=LmicK89ZBOdkns5hM1g3jbV3XMf+Jtw91sOVndpTcwhndXXFOh3Uc3OxFbWWMXt4U8Gy32yPEyeXXEBtPBG1BlNvPNuGwwdcbnP5Gne2VK4XqmgIFHouQRaSfc7ajsauANFxiCCM7SfR/qtkR53IvxGMSEXSUhqd6PYugrKUYGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by VI1PR04MB6928.eurprd04.prod.outlook.com (2603:10a6:803:12e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 15:10:49 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c38d:98a0:a823:d88a]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c38d:98a0:a823:d88a%6]) with mapi id 15.20.7046.012; Thu, 23 Nov 2023
 15:10:49 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v5 4/5] audio/transport.c: Add support for multiple BISes
Date: Thu, 23 Nov 2023 17:10:32 +0200
Message-Id: <20231123151033.22898-5-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123151033.22898-1-silviu.barbulescu@nxp.com>
References: <20231123151033.22898-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0091.eurprd04.prod.outlook.com
 (2603:10a6:208:be::32) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|VI1PR04MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: c827ceb4-376b-416b-8395-08dbec366050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XCb1IUN+9LynhCVcqADF+5LnN5pEj7Xl4lg0tOXOgVUvhD6cqixmppy7maQqmibm7eDkZCjt1sHjuzoVur1WIzsgz3kUj5wkDSfq3JYaPZNNPzz4u24jf3ZjhFILeYHgSc4Yh+0pHyaTZo9fA07FfxnIgsmNNiHljQPBs2nWfT3gDc6oUMtjPvkFiGUMUY1GgGin9Pp3QAIfCDu+aDRlpLcr5mQJqdW+Jp7Nv27wEcFcNy0sMUUFCavhwX4VG2NChFynezSQlAlyzhyYuvBpKBTNLrdhzlFb9PNL4wQX/K38CBf3UbOyMsB0dUzGD2ePYpTOUwy6Dlanlvk74IG9nO7qBa8k0B7W/6TZnWEWqmpYC1uEnm4j3oUpUwFgg987u7iN7IJezaLcnTOpQPID06hBbqGUQFlhMznkK+OCgd8Q27oM9xiijB10cEZm+D9X9yoxNJkcNBZCBtmyiCl3UxXrz140mcq55ywUj28a4g/kygTgUxTXQvEZ5fhj9Nef/Y9vs7qlQRR64EewuuffAtrf+/tSOvzqAw98YXGx4BGRRiDww0uRU0nW14sHVXgrM9Zr86hPlCjgn1WEfXBWg8zmIxaCwWuTi/t7z7leS2Sv5JCcj78x6vgnxWVkq9rn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2616005)(6512007)(6506007)(26005)(6486002)(1076003)(2013699003)(8676002)(8936002)(2906002)(5660300002)(36756003)(4326008)(41300700001)(66556008)(86362001)(66476007)(66946007)(316002)(6916009)(478600001)(6666004)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MmPPYILk6xPABzUcqshVk8XQudzP4PAkgHs27Tmc5R57Gv3Ph0IDJH9gXHqO?=
 =?us-ascii?Q?ezKed8TZ335H8toh1b4T8gzzGD/l1fC3eHc46kKJHAr+PfRbI+w9b6GA+/+7?=
 =?us-ascii?Q?DNG5HZn/+tjrWGIocha4B1wTURayMQjDTAsxvX3GVR1uszvHMtHO+nZNEz4u?=
 =?us-ascii?Q?tMMYPQNIWhl5lg4WsSCMbasSYUe2uxgOMrp58KVFhx0AgNRCP2lTo76gRYx7?=
 =?us-ascii?Q?ovQkzy4Jj/C9ORW/7/cvkyyYLxd3nhUn5MIaT/+Hra7JqhE+DiSgOqFXvNNt?=
 =?us-ascii?Q?oUe6QPrZmPQphvTfGY1jkdhs441XCkd87jItKe88+xQLskX7L97KxD7KjHO0?=
 =?us-ascii?Q?PWUiNsBLOIliKt0lsI8w6gM2N6zp2GtqwJO4Pj+lRVszOmYvvdcZJas3PL6n?=
 =?us-ascii?Q?92BrStaAP10pKiaVAWUVszTprA5zjMytHdW/imSVfxKnhPOb/4gITBTrzRAK?=
 =?us-ascii?Q?+YvM35/eSqBLa2+OLkeKd9D52BNmxxq5pG7tuatcagnLu0FXx0oCdCY0Gay/?=
 =?us-ascii?Q?02F3HACBlF67EtNS4n2hukD8RB7JIRbnrzhjXbpiVysMgCZUCzEk1yYbyF/S?=
 =?us-ascii?Q?HCs5Lq9dM6niwrax/Dq1TMupRUcHJT4ljqpmEdUXTLMFjTOEPRcv8MvgCLht?=
 =?us-ascii?Q?5RmIMmylkAG3pj6ls7reX5EDmYsmwyL/drkNtwU3uIgeVebu/eRfFmV8b79x?=
 =?us-ascii?Q?t9H2/mLA9ofUxkKWGuQ7Pxf2ek9uhoTs5Et9pdqGciMrBagzYAWpiCVN7ktv?=
 =?us-ascii?Q?80bsIupL0jqxpajX8TQ8Fldnzz2/q210YEBZl3Iclg9hXwPPqSxYKbzW0bIr?=
 =?us-ascii?Q?+MZW1u/PQMBOTai+WKiqG4DZk3xLd6C7WSKTrWGEJv07SgF1EgpNDRnuF4vK?=
 =?us-ascii?Q?3VHIePjQKfl13KmYLnUYAqwppzaMNfLmqeKd1qOkxPGobWwxXNGHQiXnyDUg?=
 =?us-ascii?Q?YOTwY5g3nHUhddgZU7eggCrSV+uxHy48/tT6vEVyjU81Pex2VAXsbOB3SPsg?=
 =?us-ascii?Q?xZt5BS5sJSVIrnXo0cgPOJwqJ3BGKAjDHhhEYDpPQHk0TYAYR4Br8CFkuaAX?=
 =?us-ascii?Q?vN1OaNCsk4btFrJ8hs3Ji+9Uudt3xW4WDLSjI6MBqnBlop74WrXsZ3fwUxRV?=
 =?us-ascii?Q?wZ4zDuyQQ7bjosi1Z3SoKu3r/dPlp3bb0wZZpVcPTQUjV/NIFOs5AmaJcAug?=
 =?us-ascii?Q?17dNqr7jNPE37xX23tpHh10Qd2n6JT2Unsp7CPgKYPy3hdiWHPstHKcBSWct?=
 =?us-ascii?Q?TlOaL3wGGHmO+ZD//i62/kAhAiLNuJ+/aQmYhS/BehLEF2lOMB8zoy//1+bn?=
 =?us-ascii?Q?kcDeFezoWNtLlYbzoldNuUf0EQkxoFRqWnDMw5OTuLyhLfRIJFIkxABMBvJv?=
 =?us-ascii?Q?ZnCcQjbeVmifaehmNo49r8jLLxQ5oCNSqcFkLhJDbvjNSCNuyOgm1gDgkGWx?=
 =?us-ascii?Q?YlKXtpnNiL5SLcmk0s0j3ZLCAKkAMAMVlxkxmYKAM70DhaROXvtMNSOHgha3?=
 =?us-ascii?Q?CEVfrlSjVJTJTC3ztxixw3UySERVFVWNZ33jtTkWktgfWZiKR8mjarTjZJI4?=
 =?us-ascii?Q?Ahj66NoergZXSqnWKqa3zkRmODBf9jjWFdh9nQTyA+Skh5bHG8gzAwygBQNz?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c827ceb4-376b-416b-8395-08dbec366050
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 15:10:49.2758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dMsxTiLd+kBpQ4ds7p4RA1OhWxPWIDd64e6XZtg21nclrragMvMHJxGCoGzfC7OGkUuVpXd+y9DtCwSD3qrJEpXfTDYfaMq6hU2fjqMPpfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6928

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

