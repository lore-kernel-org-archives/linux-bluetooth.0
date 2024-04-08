Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2090.outbound.protection.outlook.com [40.107.105.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF2C1CD21
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Apr 2024 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712586489; cv=fail; b=TnyMRre6iC4bVFRakvfiHYcCOws8YutJtukwwdQseYBFJlpCxakhWBZRAnkzcCPwyrnH+C4wGoOztyhwFjrpYO2S49w3/pxcT/wuP6d6V166KakmnIoE9gFv+VhnfJXxh8LcGVOIO8W71f72TekWdzHuj0Ec6hRneraILcviakc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712586489; c=relaxed/simple;
	bh=KnPyBahRR1XAvHVDMglXXg9yCGhfU627lT5YLf58/00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kGxnbNXO44Y2pssL1Ht1X+urckTc02zPn4QWJWkjsucUj/7Om/GB+xY4TjG0dtLDicBH7w0Kuk6Spfqoon2+hPto/1mrWeTFUXOzPCU7JUPJww6EbPCV1ziLJ1DFeFEDfKZLOICJEMMvIbg/8PA0NrHL4wkwIAeAfKLsJlymkC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mOhgLFJj; arc=fail smtp.client-ip=40.107.105.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mOhgLFJj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzZziShDIhBhF736JLgCC+z3amWbTbvC+ReAAOGmKr/JGrF4McuW1W5AuvvIfg9Brgn7Hk4be6TwTq59utyK460JWdCY8HfInJu6gRSikOuuKYFavPrzt1CjHKBFipGq1Dkrgld7TxfU8PNfLS03Y877I7POKBeS3XNJGIAF3x32B/5909lpoqv6rADxOq92lPoV95bM4DTuJz47Eq+5ldceBGoWKNXZ9fl2Sr1YjQkgUxLAe1QC8EHyAuZH+AL4nunQbozOlO33FKSsoenzmlXeni6/yF/dZFY12WpP0joDCvog6LsRj3OP0Zw4qYZZZHmcoMBSWxmqERggpB0f5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUD70ZlPBPx5AOcnY2pUDIX25z1Wh/EOXFSbPoWvArs=;
 b=nVe9Jm3Cz+Gp62nc2qkU9794GfkZPZg5k3ucUEQajaKLtrfAHsAj2kbCr7zGCaafLPf/7YBwUKnU0aVU16XdYoHrgXczZWYTtesFKDqyTSBrB5RPzXF5N8wy02Qg5FZnpOsDm2XtQtCXo0TzaIoQAAelxFizs/Gb2Dik5DimUkfW2H+GOK3k3Pfjq3TyVM4Cr3jrAMnV9lw3A/Be46J4aG+40nysR77i5+bbPrKdN+YHFIEeB44EO4dgBmvB5zgcYu0qjcP9gd8+GSHNuuFkWrpAHVlyo7+Jq8kNLyJiKapvljoYw3VV+jVz7AJWCzHZQwDuq7yVvpAIdzkM4hLMWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUD70ZlPBPx5AOcnY2pUDIX25z1Wh/EOXFSbPoWvArs=;
 b=mOhgLFJjfqOsdAd3S8UPZ4HXXbL6M8hfIi5gTE30yuQVxZ9P9dOV+PHmK6u2oNYSitnSuu2J798gLvi0+aZz68JqXIQ9xInnvW8yQ3eqZ5RIiWFgFI8K05nCw4HZYXRAdLxailg5lI/s9PLbkr2DjHWmoPv8bpCR5hqAp4ycWVg=
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by AM9PR04MB8924.eurprd04.prod.outlook.com (2603:10a6:20b:40b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 14:28:04 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707%4]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 14:28:04 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 1/1] bap: Replace global bcast_pa_requests with a queue for each adapter
Date: Mon,  8 Apr 2024 17:27:24 +0300
Message-Id: <20240408142724.12511-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240408142724.12511-1-vlad.pruteanu@nxp.com>
References: <20240408142724.12511-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::20) To VI1PR04MB5389.eurprd04.prod.outlook.com
 (2603:10a6:803:d8::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|AM9PR04MB8924:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pHVxSEPnBSe8QfLuqBk77b1JXhGZ0K9WcCfJ27jChQN31O8I/Wyt1jGn1MccL5jWZzORIbsUH2rPpV5Bj0lDXAK2oW7QRqi2jSKID8OF9mdqra5UZt+wi3lCT+iKuXXeuVqW85oIzPsmid6jG7lctvCZdnSg+sAufMROFdDyau+OxwCh0sUS9GSd6orywtE2dNO1LWuKCfwRLjz2H8LCd2EdXW5dUMFIzBCmJ5R5U+Oo2hoDztecIUPO0AkeG+BCfqlyKoB13ug0mizjqJSlbXNBzcgfl01CJs8fQ/WRLfgWlzDpyc5u4ZGs0Y0qgntG181QANoTF8nf2njyszKozCW4sjwTF2+MbGgib95OQHo0z0l2nShyFpv28+Ocr9OuUyXoU45kbolalPIgVq/6tP19KMM4WqonCQ9IQVicTVs3ZleucoYws1vT4skERHWej1DQkheDLM664eLHwvX3Xq6bUxnDjVSLKp/L4Wr1UJXPEdIeMn7//ICg0D/0SCtN1uCh2nhrx1BxdYSmUQSa6IKRkiD5WygK6QTKSgG3TkIHWQAqF698VFmSgSUtj/EcKt39LrywwDe/I+SvtGNlC8eRklPxSf0hHW/rxLCLqpCzJpY5W/CHRpczDH0pdr66rlMPhYi0UcUUPzhJCmq+jd2tBKzE4Fj3TFFP77LMCpcr0J4tLC8fBJ7AEL83uJeWAaN+nuBwoOGXZj6A74+4N//pN4dzQCKyZSS3yyd6xLg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ByY1BeHzevBpX1GpPtepAmoOWB+hB0gk7R9etjUWyvCM4p3C/vt2zPqC83MZ?=
 =?us-ascii?Q?nD2Umbe+9/j1zZwCQWbP4DR8lLqrMZscHiZ4D+9gwExkUxjH9MnHQ5t8KAM8?=
 =?us-ascii?Q?yKxZuiqgeXM9s+6x0vP2XmjYIMAo1AyY/YgbhcIKZlfB69y8DMVlwOTpS6f9?=
 =?us-ascii?Q?1yrGXZtaMfiZNuPUwXJKuil6dcvTLsvik28dOVnKpLR5nKBbn+jpvkl7Sebw?=
 =?us-ascii?Q?i/F3/Kfx/rkFdv87zFyOfCJmVh/N/S8/PM4lCG66AJFljSKvl+nqePSyn83u?=
 =?us-ascii?Q?68D5x3Xo3jcrykw66FB0OPxJyvSOaoZJ36LpQhHRtPSl+L1+eb9iutdRtS2P?=
 =?us-ascii?Q?KHq8vEzC88Xltij8qfGLyVExQ17mBn/vVx67N2bWjdT1Ya7SC5NL+e73Nn9X?=
 =?us-ascii?Q?Zek2YyK0Rmw8ZFFcxoo+yQWp2gVzeJn1gwOAsGE/F3Z6+kT/UypzABoQTeH0?=
 =?us-ascii?Q?AG741AsoudcVHnRusDpRWcfHQtDENLdK1vxnBSdMNfZ6iuUMzudunrMbDbov?=
 =?us-ascii?Q?uO5U7Ba+Sv1QHoEii0xkEWk7ftB+Aw6yNdu3TJX/TD56bC2c+GqMT1IelKHe?=
 =?us-ascii?Q?vvs1Z1UnSgICxhxFSoa4Dj8Uws43eOOGuP051poswbJ+VaCkvTcUdlts6yoR?=
 =?us-ascii?Q?y64DqPknE2Tl+dPc1dFJrm+sV3RtSKAaXbUFJODoj7iIRGqWqeVx6Qr+qazo?=
 =?us-ascii?Q?UIX4a9/sMVxfypr0+V5iL1aoyoEVScGwVRsSPoqvLkafsLebU1fO/KhDS2+i?=
 =?us-ascii?Q?U7lBIuBQVx1oFh5U9uVG5kYQcCLmL0beQvVM4Sa3Qi2FGOwb8XPo9PRZD621?=
 =?us-ascii?Q?d3ScvFX72QjsI+h5nmeYK48+CfNjvdLTDkoQqesSs3sftfusIZgN16m+TvTp?=
 =?us-ascii?Q?I7bWUKlItYPNsfivJtL8B9E76WMuag/U2QS92XYOjhOb5znBOSG/qBiX2apI?=
 =?us-ascii?Q?20Jn0TiIrVptQjc/thdCOEdGMEsAypfEYSP4ouIbGU6qqzplczLyxc6/5Cqu?=
 =?us-ascii?Q?gSijNr9CPU/wQQFuyibKTlrT9DUp/7OgiCPfg1qxp4P/MxfVEGkAf7JpYsd+?=
 =?us-ascii?Q?/o/7aRo87DZSgny/ulN1GyQcnxiul8/iks4psJE1L/gTrstsLK/vnHJEgRKx?=
 =?us-ascii?Q?XsbjT2FwFo8JNHHvi/uo95ZMPZLZke5g8FndY1WjKM/R+pyvMUZBdx2K0Ekp?=
 =?us-ascii?Q?EB/MX/RKAL9QAN9cqG4em3RzqQeZhakatpgeE3r/3WYbdx+EQbxBqygjHtaZ?=
 =?us-ascii?Q?OxOnZOmBdtGrPNu1zM0T8i8b6I7z3/Sr/73JK1grCI33lA8KouSOpC9EQR2w?=
 =?us-ascii?Q?jCA7mbwRY1oXiL+2i8Hp53wFwxK4tV9+AMrMaBAwHY/8XCuL13Ir+y6dQdIz?=
 =?us-ascii?Q?RnGV9Kx1/yT+kwB93ENR94RdYCrg+Ig6cHxjElSaI63lBuP4Xwp0T3KnftLQ?=
 =?us-ascii?Q?hZucdOPP8W6PBZpv/7D4lpFBbUeNfAgB2UeLauvTJwqXjKpeHt1Ys8uMSjTU?=
 =?us-ascii?Q?iNzx8YSGx72A6ZgNqUrlIXrOZFFLVt2md0ITLikVFH4lLmVb3rll4tFYQoRo?=
 =?us-ascii?Q?F80jvqxSW12r8R4vcWFHEPQ1OPRcK4jO6OHAqPZ6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da62c831-d861-4e90-2064-08dc57d81a13
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 14:28:04.3321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPDNqyBJcDxbalA3m9kee5DJEbcjiq1V/xALHfl2jkPpTw9Nb2KslwGzepqaDTajfUwSulbSf6UdyHTpdy+VSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8924

This patch replaces the old global implementation of the bcast_pa_requests
queue with one that stores the queue per adapter. The pa_timer has also
been modified to be per adapter. The timer is now stopped when the queue is
empty. The bcast_pa_requests queue, along with the pa_timer_id are now
stored in the bap_data structure. Each adapter already has a coresponding
entry in the sessions queue. Operations on the old bcast_pa_requests have
been modified to be made on the appropriate bap_data entry.

The bap_bcast_remove function has also been updated to remove from the
queue entries of devices that were freed.
---
 profiles/audio/bap.c | 109 +++++++++++++++++++++++++++++++------------
 1 file changed, 79 insertions(+), 30 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index db0af7e7c..82c6cf313 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -107,6 +107,8 @@ struct bap_data {
 	struct queue *snks;
 	struct queue *bcast;
 	struct queue *streams;
+	struct queue *bcast_pa_requests;
+	unsigned int pa_timer_id;
 	GIOChannel *listen_io;
 	int selecting;
 	void *user_data;
@@ -127,8 +129,6 @@ struct bap_bcast_pa_req {
 };
 
 static struct queue *sessions;
-static struct queue *bcast_pa_requests;
-static unsigned int pa_timer_id;
 
 /* Structure holding the parameters for Periodic Advertisement create sync.
  * The full QOS is populated at the time the user selects and endpoint and
@@ -965,15 +965,25 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
+static bool match_adapter_entry(const void *data, const void *match_data)
+{
+	const struct bap_data *bdata = data;
+	const struct btd_adapter *adapter = match_data;
+
+	return (bdata->user_data == adapter) && (bdata->device == NULL);
+}
+
 static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 {
 	struct bap_bcast_pa_req *req = user_data;
 	struct bap_setup *setup = req->data.setup;
+	struct bap_data *bap_data = queue_find(sessions,
+			match_adapter_entry, setup->ep->data->adapter);
 	int fd;
 
 	DBG("BIG Sync completed");
 
-	queue_remove(bcast_pa_requests, req);
+	queue_remove(bap_data->bcast_pa_requests, req);
 
 	/* This device is no longer needed */
 	btd_service_connecting_complete(setup->ep->data->service, 0);
@@ -1109,6 +1119,7 @@ static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
 	GError *err = NULL;
 	struct bap_bcast_pa_req *pa_req = user_data;
 	struct bap_data *data = btd_service_get_user_data(pa_req->data.service);
+	struct bt_bap *bap = data->bap;
 	struct bt_iso_base base;
 	struct bt_iso_qos qos;
 
@@ -1130,12 +1141,13 @@ static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
 	g_io_channel_unref(data->listen_io);
 	g_io_channel_shutdown(io, TRUE, NULL);
 	data->listen_io = NULL;
-	queue_remove(bcast_pa_requests, pa_req);
+	data = queue_find(sessions, match_adapter_entry, data->adapter);
+	queue_remove(data->bcast_pa_requests, pa_req);
 
 	/* Analyze received BASE data and create remote media endpoints for each
 	 * BIS matching our capabilities
 	 */
-	parse_base(data->bap, &base, bap_debug);
+	parse_base(bap, &base, bap_debug);
 }
 
 static bool match_data_bap_data(const void *data, const void *match_data)
@@ -2015,25 +2027,37 @@ static void pa_and_big_sync(struct bap_bcast_pa_req *req);
 
 static gboolean pa_idle_timer(gpointer user_data)
 {
-	struct bap_bcast_pa_req *req = user_data;
+	struct bap_data *bap_data = user_data;
+	struct bap_bcast_pa_req *req =
+				queue_peek_head(bap_data->bcast_pa_requests);
 	bool in_progress = FALSE;
 
+	/* If the queue is empty, stop the timer. It will be started,later on,
+	 * if any new requests arrive.
+	 */
+	if (req == NULL) {
+		/* Set the adapter's pa_timer id to 0. This will later be
+		 * used to check if the timer is on or off.
+		 */
+		bap_data->pa_timer_id = 0;
+		/* Stop the adapter's pa_timer by returning FALSE */
+		return FALSE;
+	}
+
 	/* Handle timer if no request is in progress */
-	queue_foreach(bcast_pa_requests, check_pa_req_in_progress,
+	queue_foreach(bap_data->bcast_pa_requests, check_pa_req_in_progress,
 			&in_progress);
 	if (in_progress == FALSE) {
-		req = queue_peek_head(bcast_pa_requests);
-		if (req != NULL)
-			switch (req->type) {
-			case BAP_PA_SHORT_REQ:
-				DBG("do short lived PA Sync");
-				short_lived_pa_sync(req);
-				break;
-			case BAP_PA_BIG_SYNC_REQ:
-				DBG("do PA Sync and BIG Sync");
-				pa_and_big_sync(req);
-				break;
-			}
+		switch (req->type) {
+		case BAP_PA_SHORT_REQ:
+			DBG("do short lived PA Sync");
+			short_lived_pa_sync(req);
+			break;
+		case BAP_PA_BIG_SYNC_REQ:
+			DBG("do PA Sync and BIG Sync");
+			pa_and_big_sync(req);
+			break;
+		}
 	}
 
 	return TRUE;
@@ -2043,15 +2067,25 @@ static void setup_accept_io_broadcast(struct bap_data *data,
 					struct bap_setup *setup)
 {
 	struct bap_bcast_pa_req *pa_req = new0(struct bap_bcast_pa_req, 1);
+	struct bap_data *bap_data = queue_find(sessions,
+		match_adapter_entry, data->adapter);
+
+	/* Timer could be stopped if all the short lived requests were treated.
+	 * Check the state of the timer and turn it on so that this requests
+	 * can also be treated.
+	 */
+	if (bap_data->pa_timer_id == 0)
+		bap_data->pa_timer_id = g_timeout_add_seconds(
+		PA_IDLE_TIMEOUT, pa_idle_timer, bap_data);
 
 	/* Add this request to the PA queue.
-	 * We don't need to check the queue here and the timer, as we cannot
-	 * have BAP_PA_BIG_SYNC_REQ before a short PA (BAP_PA_SHORT_REQ)
+	 * We don't need to check the queue here, as we cannot have
+	 * BAP_PA_BIG_SYNC_REQ before a short PA (BAP_PA_SHORT_REQ)
 	 */
 	pa_req->type = BAP_PA_BIG_SYNC_REQ;
 	pa_req->in_progress = FALSE;
 	pa_req->data.setup = setup;
-	queue_push_tail(bcast_pa_requests, pa_req);
+	queue_push_tail(bap_data->bcast_pa_requests, pa_req);
 }
 
 static void setup_create_ucast_io(struct bap_data *data,
@@ -2878,6 +2912,8 @@ static int bap_bcast_probe(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
 	struct btd_adapter *adapter = device_get_adapter(device);
+	struct bap_data *bap_data = queue_find(sessions,
+						match_adapter_entry, adapter);
 	struct bap_bcast_pa_req *pa_req =
 			new0(struct bap_bcast_pa_req, 1);
 
@@ -2886,12 +2922,10 @@ static int bap_bcast_probe(struct btd_service *service)
 		return -ENOTSUP;
 	}
 
-	/* First time initialize the queue and start the idle timer */
-	if (bcast_pa_requests == NULL) {
-		bcast_pa_requests = queue_new();
-		pa_timer_id = g_timeout_add_seconds(PA_IDLE_TIMEOUT,
-					pa_idle_timer, NULL);
-	}
+	/* Start the PA timer if it isn't active */
+	if (bap_data->pa_timer_id == 0)
+		bap_data->pa_timer_id = g_timeout_add_seconds(
+		PA_IDLE_TIMEOUT, pa_idle_timer, bap_data);
 
 	/* Enqueue this device advertisement so that we can do short-lived
 	 */
@@ -2899,17 +2933,31 @@ static int bap_bcast_probe(struct btd_service *service)
 	pa_req->type = BAP_PA_SHORT_REQ;
 	pa_req->in_progress = FALSE;
 	pa_req->data.service = service;
-	queue_push_tail(bcast_pa_requests, pa_req);
+	queue_push_tail(bap_data->bcast_pa_requests, pa_req);
 
 	return 0;
 }
 
+static bool remove_service(const void *data, const void *match_data)
+{
+	struct bap_bcast_pa_req *pa_req = (struct bap_bcast_pa_req *)data;
+
+	if (pa_req->type == BAP_PA_SHORT_REQ &&
+		pa_req->data.service == match_data)
+		return true;
+	return false;
+}
+
 static void bap_bcast_remove(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
-	struct bap_data *data;
+	struct btd_adapter *adapter = device_get_adapter(device);
+	struct bap_data *data = queue_find(sessions,
+						match_adapter_entry, adapter);
 	char addr[18];
 
+	queue_remove_if(data->bcast_pa_requests, remove_service, service);
+
 	ba2str(device_get_address(device), addr);
 	DBG("%s", addr);
 
@@ -3035,6 +3083,7 @@ static int bap_adapter_probe(struct btd_profile *p,
 
 	data->bap = bt_bap_new(btd_gatt_database_get_db(database),
 					btd_gatt_database_get_db(database));
+	data->bcast_pa_requests = queue_new();
 	if (!data->bap) {
 		error("Unable to create BAP instance");
 		free(data);
-- 
2.40.1

