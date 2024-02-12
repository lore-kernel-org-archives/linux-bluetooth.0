Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2077.outbound.protection.outlook.com [40.107.6.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC753CF68
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751970; cv=fail; b=F5ZTLRljGMrX6aEkxPI6KBMX3GCxJS/Nitpp1TFYubucJ3JVPzySfY2+aBjhDa7cnrHXklyk0O0F5hjeqgdJtM3uT3k2PThlh+4WmjPmoWiJDMDF0c7+JDmgTVkKfxN2hDKcJwBjia4gUaH6hgB8MtEawfB3FMeHNSDEMLMScSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751970; c=relaxed/simple;
	bh=RzlkD6KNOZmKLx+zCox2q23qA0sp8u9N6cpEE3sZkhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C3HSQ6CBMP1toK7Qf4yWon3XaCXg+KhbS6xDOtPBJa3k49ymod1Kl62htqtVmCZdWfySGmT6c4xEwK6PhJQRBnTSDHxD/S48qiZdKAYyj0DQRoF0EMsxi2O+ty/8YlqVmvbsNcNDca5CYudzLYkTFXhAX3Dx9bBPqQj4Jvtq6Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=j7OdPOag; arc=fail smtp.client-ip=40.107.6.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="j7OdPOag"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaHLZg34F0ckB8PjvP3KHngUMJu2hoRLiBMrAG5ZR9W45i7CKTAkxZRcmk5p3UpE/ZdqXxZqY3et6MtdNRGgalG2zkPv+shOhHjhjcGA2VD0ljVNjSBN4Ri8u7JzDDS+B0amX/PStixHN4qbUjIJ/ucyz82bjBPoxnGuRLgaKr+gESrEPV5wsv91dnOndqJSwd9vjbURpHiKnarvCFO69/3GIJ45dd1vN9T1IYpKwvtApLckw53qC3CGpBCzExWMfM0vr9wyy9/59/0/Pw9waAo2ZwN0HQ9Kk4yvP6Fl+SMZZCc4RVFfHj0rvtvMlfcPo7/jn793jjlvP+zSMEW8JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ojkTCw59GfNc8LVZA0S1aZrC/JiN/eM8zfl+bIHyak=;
 b=Go2ClnpL5v8PzlzVxNl+lvVUeoKN0Cu3X7O+/lbCc9+DUxFxgvBfohNVnLY9USxB0vJc9W/TUrONjwO7BtOhoIida+cD1+FX8kGtzlt/zqnVlBw/WuOcAb83oJet2QS0DiTYwYvQerkjdqFMsp0e3DXUX/cAgk088oCxWliZHYN/BYt6z7q20q6hkpwQFt5DXttTyetrQjyn8OKVYE+KkUdhlxp6tj1WKoQKGNEsP9luQ1A+AcZxJjuyoqKH6GEtUxxHeHFeKkkJ94yOuBoR5DAEice1SBm+TemNhS6plXW0/oNx3tX/jvX5FSTMXyly4xRWns7iA+cHQU6nle1FhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ojkTCw59GfNc8LVZA0S1aZrC/JiN/eM8zfl+bIHyak=;
 b=j7OdPOaggQM8Ympc/N8p/DAZY/qkYFdnULdmi74jg7wUMz/zu1zaVIt1Ry1KaWk2/cGQBPoSdZRgfgVG1LnX6RychgAqZKNNwK4Ob+1MDwXMgfhzURFjwCUbf0gtRVEYWNjTgh10QSMYK2W6M4uJwMujPtwTSJOuUWT3Kzm31iQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by PAXPR04MB8301.eurprd04.prod.outlook.com (2603:10a6:102:1c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.33; Mon, 12 Feb
 2024 15:32:40 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7270.025; Mon, 12 Feb 2024
 15:32:40 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v2 6/7] bap: Set generated BASE on all setups from the same BIG
Date: Mon, 12 Feb 2024 17:32:21 +0200
Message-Id: <20240212153222.8191-7-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212153222.8191-1-silviu.barbulescu@nxp.com>
References: <20240212153222.8191-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0085.eurprd05.prod.outlook.com
 (2603:10a6:208:136::25) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|PAXPR04MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: eeef9b64-6e96-45a3-bc59-08dc2bdfd90e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3AJJdkjSGySUCOmCGHu3RANuQ33SGdatWYWxuDxlUhkgULqfpCjlGADFeYl8dEjHBfKD42C+kqpvHk33dcQ6+BMflmBZjyzMjC8WpF2/54tM+ynArA0++RQqMxNh6WvtNBoiWmPIGZ6kftd1R2Q1K7Mtw1hnGvulo4kAWZFMIwS1Mr04Mc6/Z154FciTEMwKnu5ktXJOvHJYsOK2z8cWew+PQknnp+JBiuFpbRoRVs62hoz8ELTDVj24hz66Ki3hfrBspgBrBv9D6baada1g+qbn1KZkOnSHcBzDmK63zEYrlgwTlSib/PEgShs1EwLxGBQM/c6RdekY1xDOHGeWYyvhhUieSZ17hpZE6va+kUS+NrM+xmSBW4JrGugWhDfON6fhotsodrulhBrPtq8M5hYPOTSFuSpKzptush3lXJyEvYs3N/DD/dM0Y6SF2mFlaZEelOwqfsqjyXbP9xfLjpM1ChZR8WD0IklWV13NUs0fHmRe88xNkOOpuRbOlIF7MlkdfH5EnCoJAFA17f8be+vD72hkaL3vqblxFSv5zylc6tomXrLrGr7vD8F/0XOT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(346002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6666004)(316002)(2906002)(5660300002)(66556008)(66476007)(4326008)(66946007)(86362001)(8936002)(8676002)(6916009)(6512007)(6506007)(478600001)(26005)(2616005)(41300700001)(1076003)(36756003)(6486002)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M46klUuI49TpQqVrTq4X5ChjYYBAZTlD5YnzP2WnRih8UCdUbbBZXDznBUXY?=
 =?us-ascii?Q?E4yQMjX62e/j52F0GNtxCkuRmA1ArNkFHgbv0PhEZAfdjCTsfPWnIPgZRApJ?=
 =?us-ascii?Q?PCJLfnpCi5vNj6JwbcPao0x2Y8fq5HhphmPaC5g+NugRCLGU7h2obWJT9O+/?=
 =?us-ascii?Q?QNGwNehzdagrWzcH8yibYcCT2ukWMM0M+6OuHhfHVvS/mELgidcx5uCr2aqL?=
 =?us-ascii?Q?RUlHv7821AVHL8zVlt2emUhQAnjmnyrmb1wT1Fp2AEO8dYmq9Db4FcudJdTO?=
 =?us-ascii?Q?gECiD5el2PQjlyU/M5Z/fDtUZfy22EL0ZDxNWNt4FgCXZCWC2i2BHIMjGdC9?=
 =?us-ascii?Q?UelyRz1wkaihAh8paHKVLCGpwt+Z1G5Bu5p0Fo+3owf31MGJGvrbub1TB0pG?=
 =?us-ascii?Q?cLBFpNLGQAQujwbKfioAo6I3brXiwt5woi7DryQOcYrbaWd4IH2mQOPcTYoy?=
 =?us-ascii?Q?R8Wb7GqMtYhvvTKN6lLhuKFWgr4DEqW/Yu6nJh2zzSO83+9HkafVN273sK5n?=
 =?us-ascii?Q?64YC9L6J9txE7trBygoI2i6qC8ppnuNhlKZbtPw5T0mmZ99uipOVTRgw1UbL?=
 =?us-ascii?Q?El9t1mjDi6EFOobS2iaaKAbmaCy29BuXEIJnUVgJwQS0k8fF8Shg7fUo75FH?=
 =?us-ascii?Q?6bfGq1sUVle8J7z7mJs6WKuxZn5l2+wk4gBAz3lajqsxuozoRvHyk531Sp5P?=
 =?us-ascii?Q?pzLKr5mN2mwcQ0U1McNc7UpFVTXNJCwWO01LxG5SKdkRmgTA10T8fa+NqHzl?=
 =?us-ascii?Q?0F/PoP+a7TEa8v7sKOErALPnVedOiGg6qMDYmFQyDyk5TE+QdKf3/91Bv84b?=
 =?us-ascii?Q?VhngNRj//gTUc8pBLLE5uF6SHDW0KsqtZlcq9erKgASLcXqrBzMrIlr7cSOM?=
 =?us-ascii?Q?BPCSn9JTvRW/xgDSx2OLafAXZCRfvyO858Gok2khgG1m3gJ0tOfxb6UEGHBi?=
 =?us-ascii?Q?R0deUqCISscaOHTAQwSzMM/bwTzSezXwtWN0UTHXbv/ayBaClF2YiZ4siv+s?=
 =?us-ascii?Q?+W7NoaAjLP07TCV7bRFxmRP8LQbbg5xUA/5c53/0kn1tJwDeh0cFacShA1LW?=
 =?us-ascii?Q?Qevl9n/QirmCuu65EP9EhpgIY+4TY5NY1LZTj1WNpDUbEs8zrf9ir/N1xl0C?=
 =?us-ascii?Q?paD2/BQyEg1K2fwZbJHAIvnikx1IHmgEOUCGk8cDDGXNFs5exaK4V0RXKgxq?=
 =?us-ascii?Q?l4ZvbPIUWITA1W9HC1BzfjAoYfcIHoC73csYeX/y/PuSeuM+JXdZo93FCW8w?=
 =?us-ascii?Q?yB+W2O7ESxEqHVLjMBamcdTVv7Og8LjY87iOz0PJ+UX4zXd3klbZd46Ndphd?=
 =?us-ascii?Q?2+LItyTQ8mpcF0KCsF03T2GEvkHgvgYuyd3XQgN8YR2OejI0IUf6Gbb//sBm?=
 =?us-ascii?Q?ODeonuYDMO3wTdxF+1PFHgC9CD1wPqqDCHJsbnK8NseodomQC45TWGYJXLrg?=
 =?us-ascii?Q?Mr5AfF5jY13+asjdFFnMbcYVlLoQotNboilM5irlGXH1jUqb8zAdhXqutOBh?=
 =?us-ascii?Q?KqnACn4Uz8Y41lWy23scSCfYCiEODqtAgvM6ja753kl0xhkPtDF+UF0HtPeR?=
 =?us-ascii?Q?5RqKh0+9v0xQxrbUBs6a15EM4HYjRCPrx/GwEmSJk3l5CTqGo7GRgkq8pKWp?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeef9b64-6e96-45a3-bc59-08dc2bdfd90e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 15:32:40.0460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOD6Xk7LbP2913uXnRlvxTGNZGEa5kY6dHtY533/xefh0njRKvhfNTi9vcKLELwp4hke6kebAI54Jp7/V8j+9LvWFp0d/bqOoGN37tYuILc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8301

Set the BASE generated in BlueZ on all setups from the same BIG,
and use defer to inform the kernel when to create the BIG.
---
 profiles/audio/bap.c | 159 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 145 insertions(+), 14 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index cf1c53b30..3a53873e5 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -926,6 +926,29 @@ static void setup_free(void *data)
 	free(setup);
 }
 
+static void iterate_setup_update_base(void *data, void *user_data)
+{
+	struct bap_setup *setup = data;
+	struct bap_setup *data_setup = user_data;
+
+	if ((setup->stream != data_setup->stream) &&
+		(setup->qos.bcast.big == data_setup->qos.bcast.big)) {
+
+		if (setup->base)
+			util_iov_free(setup->base, 1);
+
+		setup->base = util_iov_dup(data_setup->base, 1);
+	}
+}
+
+static void iterate_endpoints(void *data, void *user_data)
+{
+	struct bap_ep *ep = data;
+	struct bap_setup *setup = user_data;
+
+	queue_foreach(ep->setups, iterate_setup_update_base, setup);
+}
+
 static struct bap_ep *ep_register_bcast(struct bap_data *data,
 					struct bt_bap_pac *lpac,
 					struct bt_bap_pac *rpac);
@@ -984,7 +1007,6 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK)
 			setup->msg = dbus_message_ref(msg);
 		else {
-			setup->base = bt_bap_stream_get_base(setup->stream);
 			setup->id = 0;
 			/* Create a new endpoint for a new BIS */
 			if (!ep_register_bcast(ep->data, ep->lpac, ep->rpac))
@@ -1858,7 +1880,7 @@ static void setup_connect_io(struct bap_data *data, struct bap_setup *setup,
 static void setup_connect_io_broadcast(struct bap_data *data,
 					struct bap_setup *setup,
 					struct bt_bap_stream *stream,
-					struct bt_iso_qos *qos)
+					struct bt_iso_qos *qos, int defer)
 {
 	struct btd_adapter *adapter = data->user_data;
 	GIOChannel *io = NULL;
@@ -1895,7 +1917,7 @@ static void setup_connect_io_broadcast(struct bap_data *data,
 			BT_IO_OPT_MODE, BT_IO_MODE_ISO,
 			BT_IO_OPT_QOS, qos,
 			BT_IO_OPT_BASE, &base,
-			BT_IO_OPT_DEFER_TIMEOUT, false,
+			BT_IO_OPT_DEFER_TIMEOUT, defer,
 			BT_IO_OPT_INVALID);
 
 	if (!io) {
@@ -2024,9 +2046,6 @@ static void setup_create_bcast_io(struct bap_data *data,
 
 	memset(&iso_qos, 0, sizeof(iso_qos));
 
-	if (!defer)
-		goto done;
-
 	iso_qos.bcast.big = setup->qos.bcast.big;
 	iso_qos.bcast.bis = setup->qos.bcast.bis;
 	iso_qos.bcast.sync_factor = setup->qos.bcast.sync_factor;
@@ -2043,9 +2062,10 @@ static void setup_create_bcast_io(struct bap_data *data,
 	iso_qos.bcast.timeout = setup->qos.bcast.timeout;
 	memcpy(&iso_qos.bcast.out, &setup->qos.bcast.io_qos,
 				sizeof(struct bt_iso_io_qos));
-done:
+
 	if (bt_bap_pac_get_type(setup->ep->lpac) == BT_BAP_BCAST_SOURCE)
-		setup_connect_io_broadcast(data, setup, stream, &iso_qos);
+		setup_connect_io_broadcast(data, setup, stream, &iso_qos,
+			defer);
 	else
 		setup_listen_io_broadcast(data, setup, stream, &iso_qos);
 }
@@ -2132,12 +2152,60 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 		break;
 	}
 }
+/*
+ * Function receives a list of streams ordered by BIS index
+ * and calls setup_create_io with defer true on all but the
+ * last one.
+ */
+static bool create_io_in_bis_order(struct bap_data *data,
+				struct queue *order_queue)
+{
+	const struct queue_entry *entry;
+	struct bt_bap_stream *stream;
+	struct bap_setup *setup;
+	bool defer = true;
+	uint8_t length = queue_length(order_queue);
+
+	for (entry = queue_get_entries(order_queue);
+				entry; entry = entry->next) {
+		stream = entry->data;
+		setup = bap_find_setup_by_stream(data, stream);
+
+		if (bt_bap_stream_get_qos(stream)->bcast.bis == length)
+			defer = false;
+
+		setup_create_io(data, setup, stream, defer);
+		if (!setup->io) {
+			error("Unable to create io");
+			goto fail;
+		}
+	}
+
+	return true;
+
+fail:
+	/* Clear the io of the created sockets if one
+	 * socket creation fails.
+	 */
+	for (entry = queue_get_entries(order_queue);
+				entry; entry = entry->next) {
+		stream = entry->data;
+		setup = bap_find_setup_by_stream(data, stream);
+
+		if (setup->io)
+			g_io_channel_unref(setup->io);
+	}
+
+	return false;
+}
 
 static void bap_state_bcast(struct bt_bap_stream *stream, uint8_t old_state,
 				uint8_t new_state, void *user_data)
 {
 	struct bap_data *data = user_data;
 	struct bap_setup *setup;
+	bool defer = false;
+	struct queue *order_queue = NULL;
 
 	DBG("stream %p: %s(%u) -> %s(%u)", stream,
 			bt_bap_stream_statestr(old_state), old_state,
@@ -2158,14 +2226,77 @@ static void bap_state_bcast(struct bt_bap_stream *stream, uint8_t old_state,
 			queue_remove(data->streams, stream);
 		break;
 	case BT_BAP_STREAM_STATE_CONFIG:
-		if (setup && !setup->id) {
-			setup_create_io(data, setup, stream, true);
+		if (!setup || setup->id)
+			break;
+		/* If the stream is attached to a
+		 * broadcast sink endpoint.
+		 */
+		if (bt_bap_stream_io_dir(stream) ==
+				BT_BAP_BCAST_SOURCE) {
+			setup_create_io(data, setup, stream, defer);
 			if (!setup->io) {
 				error("Unable to create io");
-				if (old_state != BT_BAP_STREAM_STATE_RELEASING)
-					bt_bap_stream_release(stream, NULL,
-								NULL);
-				return;
+				if (old_state !=
+					BT_BAP_STREAM_STATE_RELEASING)
+					bt_bap_stream_release(stream,
+							NULL, NULL);
+			}
+		} else {
+			/* If the stream attached to a broadcast
+			 * source endpoint generate the base.
+			 */
+			if (setup->base == NULL) {
+				setup->base = bt_bap_stream_get_base(
+						setup->stream);
+				/* Set the generated BASE on all setups
+				 * from the same BIG.
+				 */
+				queue_foreach(data->bcast,
+					iterate_endpoints, setup);
+			}
+			/* If there is only one BIS create the io
+			 * with defer false
+			 */
+			if (setup->qos.bcast.big == 0xFF) {
+				setup_create_io(data, setup,
+					stream, defer);
+				if (!setup->io) {
+					error("Unable to create io");
+					if (old_state !=
+						BT_BAP_STREAM_STATE_RELEASING)
+						bt_bap_stream_release(stream,
+								NULL, NULL);
+				}
+			} else {
+				/* The kernel has 2 requirements when handling
+				 * multiple BIS connections for the same BIG:
+				 * 1 - setup_create_io for all but the last BIS
+				 * must be with defer true so we can inform the
+				 * kernel when to start the BIG.
+				 * 2 - The order in which the setup_create_io
+				 * are called must be in the order of BIS
+				 * indexes in BASE from first to last.
+				 * To address this requirement we will call
+				 * setup_create_io on all BISes only when all
+				 * transport acquire have been received and will
+				 * send it in the order of the BIS index
+				 * from BASE.
+				 */
+				order_queue = bt_bap_get_streams_by_state(
+					setup->stream,
+					BT_BAP_STREAM_STATE_CONFIG);
+				if (!order_queue)
+					break;
+
+				if (!create_io_in_bis_order(data,
+								order_queue)) {
+					if (old_state !=
+						BT_BAP_STREAM_STATE_RELEASING)
+						bt_bap_stream_release(stream,
+							NULL, NULL);
+				}
+
+				queue_destroy(order_queue, NULL);
 			}
 		}
 		break;
-- 
2.39.2

