Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NNb3sqEh"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2044.outbound.protection.outlook.com [40.107.241.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A43CF
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Nov 2023 04:08:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pza5C4iXvqvd0bmt3QL+0ekRxbsvu4bidkbImxDOxZK/FGDGYn+ONOIokTHsuXK9mWM7Q2UeRiXGeOzqZILQgqwirqp3IVsQ/GklaSk/gqy3Tghhy8vBICtai60h1P7jaYq2X4DyhJhdzcJckjh+BsF0G6ILOyJmLyud+696UNi7PSLlD5SWD4nFViLA9+C6lKc4AlXsCoi4pEmmlE4cPBTzEIxrAlCsmtRuY6QO3I3aHhFIETN2cWWrGwwFtTN6aCMxNsay6YKbyVbP3fIhqnl9M7lEY/OloDG9inymZfczf80yaTITM2cgg1t1W3W9wiOllFJ8/PQcgNWUkFFZXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5o/EBiPBu/tEzObrt1VQSFTsiM0lJ4w3xJaZgEBT098=;
 b=WQPlh8KTjUkHx/G9CQI5rT7eZq31Xbl7V35htRFzLPE+MoynzyGXVuAbXcd8HTcoiNJaRL/9vIQaU+MUuZcYtWiw6l6KY9RpSYMmjiYi5Z6KCfFtaDHoPhdvHyL7briEKytwYTACXlHIYmPAXPpI83itMGSuJ9BxYyxRA9/+2bfQcPtfMliMbxHtn4DTXgtLpft00ff2PrFI1LOdTD4UOMcufF7Url1Cagqzm8Dt1C8Uvr0O+Xo/QqhWbBBNSR9PUlrda1RmgpHTjBufvyyyLpogq8/qY6ZKNaSpY00fAXeCflYpdokVWC275Ka2dFNt1ZkNRIpA/PrqLtwLh8JVsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5o/EBiPBu/tEzObrt1VQSFTsiM0lJ4w3xJaZgEBT098=;
 b=NNb3sqEhbI3KLvllI6weVxbh3qO60YrNhEUxCXHUp5Z1G4VSnUJTft2LOxD+d4FE0vYlHaC+oOP72X67XKn0j5AgRYLiB7vma6OypEINwhDNEazj9NudFSs81LSe5zDl9TnfQ6ygRexy0OAZodSE5OVQsNurtO7lf/NYeGLiukM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by PA4PR04MB7966.eurprd04.prod.outlook.com (2603:10a6:102:c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Mon, 20 Nov
 2023 12:08:46 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c38d:98a0:a823:d88a]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c38d:98a0:a823:d88a%6]) with mapi id 15.20.7025.014; Mon, 20 Nov 2023
 12:08:46 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v4 4/5] audio/transport.c: Add support multiple BISes
Date: Mon, 20 Nov 2023 14:08:30 +0200
Message-Id: <20231120120831.5353-5-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120120831.5353-1-silviu.barbulescu@nxp.com>
References: <20231120120831.5353-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0073.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::14) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|PA4PR04MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e4a554a-f458-4148-3978-08dbe9c17248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+oIvdeh81tp5mxG+n6nY/hLbq/dsJvBE8WsV/qZr4UDfKh68S9V84SzneG2LrkWZW9XloIHUj8JS1AtCJZ6uHd+KzZcuo/pYIW+M861Xh0OCIDtA5k6e86KmI5HgH0FolLXRSgqy3IQ7Sv7tEz54petdVLm7+VqWg0Qo1iSCLI4SRnlETpOp7HcaO6kN8azl9o8dEIvnBwDfSNF75m3pMZQAGV1MLo6lAXXlJTxjDCU7Qn6x5fabtwv0T4Sq9BVKrEGa6f7+vYHj+5MhVNepGzQ9nP8VpZDh9pRpAQlnDeXAPin2CHFdLHYyp3FBKMR41tBPuPELWXHwPfN77QK4xa76l2Xw3lpBd855mAbA+m9x9mFMDIw9ofpc80vLBjLHyUXYM6SpADpa6s9xdvGU5mH/iAZ60SlHGcS6940pZQz61OLFwnsf+lLWOB8/oHshP0vrkIG5rtDx+gRV0sE3LrnZ6j0DUKZXaYIucwCikYFCwRY5kA3B5UwEn092+jbxO4iUajUZfTHRMjnzUQxX4JIwniOR2OmsyTBYfslq6uOUJktD4l8K2L0W99YK1dagU+xTMAU83gR/dqqx6lpU3cYl2Db4OUva2C625zb17KIOVn8Mn2A3ctsilKFZmAtu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(41300700001)(8936002)(8676002)(4326008)(5660300002)(66476007)(66556008)(66946007)(316002)(6916009)(38100700002)(6512007)(36756003)(6506007)(6666004)(86362001)(2013699003)(6486002)(478600001)(83380400001)(26005)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?98eggsTcgsMV+LNiVzWJhYW+XyroKIjFZejA61UN2LfrynqJfaLeX9EqD4HT?=
 =?us-ascii?Q?nZmoju3TMe2FKBmiZBXFfWBDmvye/Nj8cOiFfsjoPsV0JenG13CJm0DVBRL5?=
 =?us-ascii?Q?+/DGS8G0Kktz01JMQUftoW2rCkLtZksrByXNLBpNgYjZEPG+3Vp07T78/pMC?=
 =?us-ascii?Q?hqyfEPY0V2mTgsXi0Nj75HfJ+1U3k8pFPhG8OwinFt2hR1pB8vV8uRUdsJfj?=
 =?us-ascii?Q?8suNU94+5oAJ+KCNdHgXTx3RZyOVJg/rhf04DdMLVWxQ2LmUAVNPNk93N8TE?=
 =?us-ascii?Q?4Trk7xH7a2xFNnVmEIfwiNtgInhBJiJf6YuqNq/vBLaHJT3TPR0ZV0UsY+yh?=
 =?us-ascii?Q?zJgmZHWyHloPA3ICLfsda9HZXo5BEOl5Y+JQOn3KnHACXgrZFsYncoEKhhSP?=
 =?us-ascii?Q?HjeLwY9dU5bpqLjAWHsA6xeSOcGlUq4hXL/p1tIfW83RnSFwL/3D+CZeaiKA?=
 =?us-ascii?Q?ZMn5hrlzcqG8qZGzRGiJdatM7iB3wwpC5gF3nhpsDYHl82N++6BZbAEK2Yyd?=
 =?us-ascii?Q?EumEbODBqK/LVW+xDXBpxF5rtaUQJgBzZRXDQKP4GPmNgAufw4hUaDqdToBi?=
 =?us-ascii?Q?4XlAON4qXhUtvP7n5Txdi04JBCSNus5a+ssTKVyt2V3Buzv16OGsPce4quUX?=
 =?us-ascii?Q?hBeEpC/ZX2G9SQ6SP9MazdUuP/Zyfj6tBWV7oQm8BSDbOzG2IPlMvotmZZ/z?=
 =?us-ascii?Q?vWTYESWADOXqE6h0RNzWW1IraR9KtcV1CpjsUUtdrd1w5kA6FVgP5T9wLM9p?=
 =?us-ascii?Q?ymxi3QHjl7o8M9Ku4ChjoiXnCE+SKMIjlkx67nK//mTI6HrUmv7mHNNNn9OT?=
 =?us-ascii?Q?TPJaHa6w2utz0LdpBmzpUg7p7dEQUDFKDQd1vmSlxhavf/Z16AxEMJfM4aat?=
 =?us-ascii?Q?z+deZf1ZImxfKQZ1LFLdk0shc1qBq/JgN2IujWnAU66bPvoa5R3yRTSzJ7LB?=
 =?us-ascii?Q?RuMLduKL/NDBTSopTIIhAK4j1g24dODN70YAMZaZ/+FuNafh6Eyuq1Jt60z8?=
 =?us-ascii?Q?FAbl5d0Te+itVNaqRdNcr+PRd/PYcEVbqrdImhwFyqywzT56X2M7o+Ii3EWm?=
 =?us-ascii?Q?bhzARYMghTFRS7S6/G0DRgekymDYwIeZmZfUSW56CW7lgDdotcKNURPGkeZD?=
 =?us-ascii?Q?rmhnCF1yCifTI2MDxE+7XotlCGzcPrfXfON3FIfWuYCYHxkT2cM1z41MG+QW?=
 =?us-ascii?Q?TlMWcNJLrH8KlFgJ5SESBCpHeeSg2BK0WNZT8W/N7DmnUHDOoHvHQ0+3Mznw?=
 =?us-ascii?Q?UJke2bW6kZ9xgRD1iioPSAcwgsocVuTsgGrVoAbW31wOPfHKdcMK2Etw2ssg?=
 =?us-ascii?Q?p7zuNO70m3yxJLk/jfIuiOdKqufP9wEwzHGWW3dCRJfixajGtTup/yl3nSlU?=
 =?us-ascii?Q?9hqiQS3TkcYcyWNERoPbQH/SU4s/qK/6zjl5lhtd4jLHBauxknJ9QGMT9S6H?=
 =?us-ascii?Q?iQNXOwWcLNq3ZRmBOjPa+vgid9SIgGnPufpAlDcjIwv+G4YKyJ00Xo9Uo+zx?=
 =?us-ascii?Q?dHSAinL47FoUeaH5yMLAmw2no3UOJrSdokw3p4Q4Hex7oZ0jktpb36HU384a?=
 =?us-ascii?Q?ebBmMqyrRiK5nJDrJD4o+vGe/1loqZEHzWMhnROjAr8v75f4e2mpXm8OvDfS?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4a554a-f458-4148-3978-08dbe9c17248
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 12:08:46.0004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCm6/clKS+noFS80japFmWrmJ3nLwg/yi0WEqBuuNyMA2Oa1EWydWdOYyEi9jzLkb419sUu15f+anh3RMG4+1qx1xIM8BQ9N3GpsGL4uXdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7966

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

