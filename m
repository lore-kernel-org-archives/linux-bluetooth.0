Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2060.outbound.protection.outlook.com [40.107.241.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7792912A165
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706912; cv=fail; b=H38eqvS9wtFHiOVzUH7ieb0uAmZtL5K7YVEVme3ZYYV3HQ2EbXWl048kj9Dnjck4RrTya4CPYVonByYjafkymOQ8k5uQGkGY8Q1etWXET565B5D61E8JoEum8xA0e5jTc10x2kUhq1xqm1l7RbYW2EVvZJRKRgnW1Df2Elkt/8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706912; c=relaxed/simple;
	bh=6cAgCzQZXJJrFUW+5N96GJzk39C2NNuQLps5t31aFGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lykN02jbZ4R0/FrtBhsL+LTme0K1I+pb3LM9IRMLbYSFwCe6MT3UKhwmxlweQWbMtC94RFRqF5LLBJ2ckd0yJwO3lGdSakkCOpAXcAC/+qpOmtv8vcHUDPjj4xYNA+w+XBlxtmm0nPGwiwpH5l5Hw/Lw3qXDmYO1AmIUN2+kykQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KLldnGZG; arc=fail smtp.client-ip=40.107.241.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KLldnGZG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DW49u1ZGw1G9B1un5FwIp/OkJKYekbks3Ylb4ofa4S5f9o1qKh6IFpXvpai3nAUyHbHgV/4Au5Gxeee7rqFlG54YGOTGJTRCAmC5HrtKhp3XqQXVNECPKZHeuK2yjl4lBREA2/SoE6wDAtT5brnpKbP88J2qTgLD2ycKteHEbxmefvyPpJpOaiwDr3nymiwQwuZ86lOvtSBYCiZnUgdMNeRZu06yVGIVnpmhzZ7CAnt+Qdj8Cujr6n4uC8zJIABvb70iTrA7eDmi1gcflqdt6M5l2wYeMyeecXVa6tBDYoJ7V1ymcI2AvlPHoo+uFxn0xTz2FyxC8HqYzAnbv19/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFclAjxT4PeTaR/tuvwh4CBCCPBRA8PjnH8r5D+525Y=;
 b=NsspZvmcvLyLisXo3E1Jeh31JLR6SJSIjcpEBBrb79e6QB27sF3iP5HvFg3DJpCR5PlGdH+a/sujQuTpB6I+EXWwCXM7sVlHUmsLxPppopyUJq6AFU1cLZhe0E5DBaEh+j/IX8xzetAn+QwRtLzrpWplOmp+unqzrEBvOVjhwadoGSO7fF4N3XXXV2kSb8Y5MO3BUddm3bZ3rOZ3P5ugtspIVr7oZKHAHHjzTC+bWUP8c4fZUfNemuBwEFEUL4ISWrFhpWh0Am5XDY3w5VvBpDGp58jfl4jGyLFD7oapnbRL6p78+rRXO41/LIhm5KULLhStH7ww9PwG+QKwn+yz0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFclAjxT4PeTaR/tuvwh4CBCCPBRA8PjnH8r5D+525Y=;
 b=KLldnGZGP2fYPpW0XCX6iAV+CyWueQADhY/fu4VlfjOe/3IntujH+SIi+pdjK5CTz0DEakaUAvIX46rGqLJuQxQ7BVhI24s97Fwa/z82s7VfGc5JzXvbCn5jrzTKvB8SVt6KfCVTaY/dBrOwTZoHE8CZYDbwdD1DxuTkZ+JH69w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by DB9PR04MB8479.eurprd04.prod.outlook.com (2603:10a6:10:2c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 16:48:26 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 16:48:26 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v4 5/5] bap: Set generated BASE on all setups from the same BIG
Date: Fri, 23 Feb 2024 18:48:13 +0200
Message-Id: <20240223164813.66484-6-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240223164813.66484-1-silviu.barbulescu@nxp.com>
References: <20240223164813.66484-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0030.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::16) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|DB9PR04MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: 549dd00b-e1e7-41c9-0f8c-08dc348f4190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YXMoVpx+qspCNtHp7THiMHJkQoKTzOuT0EYwGIMCW6M9ArHz8pcxtm2PBemcKtTSQfkvQoFTo6V7cfGBfLaAcGs/pz9fpxlDKq9OXOkaSzDkL/6mPfGoaKWzS5uEQfZB7vCej3fjP0eaunHM4VrjS1ONgzX7naKq6sLFLg1p1GJThwsQ4NBMkNEDVFw5XE9fQzANV4UpI9116JaA6OHitRBLiBmoc7zuJPPTwAdMUGindqPloslcQR0EM4zRHVEg+nMiOkpejuDqpnYI7WCocehMtbKjIXVToMdFEKcs0RFMwLZchUA6vgo5nxv7EdJivuvbgRMcwVHhoymJG2lDXFgQNjieTM+O5vgxcRQ3QcORig9fM4CWyaz+SyRRx3ZvzW7gQNB9AyWv2n8vwYAe3DwVgCwYWt2r93GQFoLEqUIzTxYWXvaFT/t/gh2rqVWRyaYZhfLYG+JFqHWcngOJQyUs3sUncNXo+kC7fwZLQI5w7AMe5VfCFLviFmacQ6ktb34+TwM8/X6MjAA9RU5uLXeJDIqqO21Xzrk+ZQH/Zfc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZWLA5AiCF/VeBwlbsGuX0vp/Ym/o7430rFEbBrTMzEjaKEbU+8khO7SFdf+/?=
 =?us-ascii?Q?+sXc4LiRNibYfb1kUyK/dwJY1Gdk9nwUS9b52dcjCmVMrrizJ0DV65CMScI5?=
 =?us-ascii?Q?7vk5rPd6/e0zQjHrAySEBBUYs0oGC/DHVKpDYMvTaW9Wm/RaCjbMs0d09g0L?=
 =?us-ascii?Q?XSKEYg8RBPqMBzRBE/TSaCeEKLOV1GMBTbWGAAFZ1hP1uQmEXLOqerLnmn15?=
 =?us-ascii?Q?k67VzYZH+i4HCc4QrgSetOyWAQHPqVuG37XIDmWRtqInxZvuYRmnJE05Jkd/?=
 =?us-ascii?Q?U35Tljn7Qv5woT1t7PcM/PJZR3/Uu+lC1EZOp3aXraFASb7iWq+VAjvVAVqJ?=
 =?us-ascii?Q?NTuXadqozCIMkuWvyvAp+jXM91afqbOug3PAVZAPwkV1vYFnbLWjOMWvy9eQ?=
 =?us-ascii?Q?Rqi5wT9xSuOoFgDqL7PaDhlQzrHo2SxREDIEo9iN6o9kKIISrYFOH7PDHq9S?=
 =?us-ascii?Q?4c4Qaa4omSrDnmXqCrNlMpkEVyZT8KCck/RKoIjgpEYNXLo8DypkOqxEfd6V?=
 =?us-ascii?Q?fuA182TE2JSjR+0SiusiVjdcXCcnFNrQjZi5Vd/Uq8OBIVAQKn+TqAU/8lG/?=
 =?us-ascii?Q?m0QuUCvYAASThn2mj6BApkdSH2EaHPfGrS24/CwtrHlEmGqWIuG3la2GH2D3?=
 =?us-ascii?Q?8BQV3ftCEPHjU64cg1SfMFgi7iz9NUTxN6c/6SKbqYvUpUOVpTa8qCXJqxmR?=
 =?us-ascii?Q?eOHcg1O6D4JfTc7fypDv4bMevZvUrnhAckR2etWmx37XvBa1D8qu/10Xfq7P?=
 =?us-ascii?Q?JZhb0rWABWQMYgKvzVFBzt817vjCSNXtOKv/0Zba/urxqpSlNl7tL6b9Cg0s?=
 =?us-ascii?Q?ExVObg+5guceuLLhbNjg3JOkgJz/HJ53SNzoetREW72b+y7jm4Ci8QmSqR50?=
 =?us-ascii?Q?/W5ESNuEd7Rk55N0QiFiO5bdSEC+AuQynHhoe4fxiEuw4nRHohap9mjP+A+E?=
 =?us-ascii?Q?M+zvNN066esdCMSSqZuvxEKfgJfd+sWNvVQY51V19WO8RcvmAdsbOpEjPria?=
 =?us-ascii?Q?Baiw1Nd0vhY3h/9DTqht1qZc6ESfv3AQCwjFS5aLTm7F52JZx0BAcuT2byI/?=
 =?us-ascii?Q?a8qchDEt4blfSQTAfN2zRNB3ODU/lqKUYONHghFaJI4Qmiw1RIHI1srUIy/Z?=
 =?us-ascii?Q?bFjfj3is6SKoRFFrocunmV63GTTwkxJc6SxSOMl4GlSK/hPP/Xy/LIEByK1C?=
 =?us-ascii?Q?YS0dRvEh4mhXooxaycRWta6Sy8O2rVzZSpDA6pLJ38pmQJBk+w8McagcgWZ0?=
 =?us-ascii?Q?YGBsPJncSLEBQ+3pe2PHBVnab6W50aauCSdpsnU7sLKUUVmLwQ0+xoZwLHOh?=
 =?us-ascii?Q?keJqdTPYAfX9wKUqnQCPmwyi6cULOxG8eXNBxJWktVxZ/5lHBS5YyKkSGW+D?=
 =?us-ascii?Q?emvDjZke7TYAk8LRbcKYNEa9p3dZf4/YkMAsYew+U9Na7DfR6LpUcYnFKXJa?=
 =?us-ascii?Q?oLeQcEKklWzVWt41uGJqx0/tp7qU9R+ZflLV0vd2+wJ+xhSs/ek3ZQH4VbSW?=
 =?us-ascii?Q?2AhNQaU/zRffVWmCEH2ZjkHZkEmMaxjHx/ftF0nXAaTETj9MBn6h2+VbC01d?=
 =?us-ascii?Q?q66cBdTzNHkpH7QESBO5ZssI8xZPFh0Y/QWTJg69grLFwzY/O9pU2K3cafCQ?=
 =?us-ascii?Q?kA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 549dd00b-e1e7-41c9-0f8c-08dc348f4190
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 16:48:26.5733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfGOapFwkxTBZI0DS/GYQBYCoDn9hbvpcSx4Nq78aUHBtAcna5B57G+xwMq5+40SaSjl9O3hErELymLTbbt4O+unikuOCeZLRSyPu3as/Us=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8479

Set the BASE generated in BlueZ on all setups from the same BIG,
and use defer to inform the kernel when to create the BIG.

---
 profiles/audio/bap.c | 212 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 196 insertions(+), 16 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 2c7daa6d4..38577bcf3 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -950,8 +950,12 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	if (dbus_message_iter_get_arg_type(&props) != DBUS_TYPE_DICT_ENTRY)
 		return btd_error_invalid_args(msg);
 
-	/* Disconnect IOs if connecting since QoS is going to be reconfigured */
-	ep_close(ep);
+	/* Broadcast source supports multiple setups, each setup will be BIS
+	 * and will be configured with the set_configuration command
+	 * TO DO reconfiguration of a BIS.
+	 */
+	if (bt_bap_pac_get_type(ep->lpac) != BT_BAP_BCAST_SOURCE)
+		ep_close(ep);
 
 	setup = setup_new(ep);
 
@@ -987,7 +991,6 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK)
 			setup->msg = dbus_message_ref(msg);
 		else {
-			setup->base = bt_bap_stream_get_base(setup->stream);
 			setup->id = 0;
 		}
 
@@ -1853,7 +1856,7 @@ static void setup_connect_io(struct bap_data *data, struct bap_setup *setup,
 static void setup_connect_io_broadcast(struct bap_data *data,
 					struct bap_setup *setup,
 					struct bt_bap_stream *stream,
-					struct bt_iso_qos *qos)
+					struct bt_iso_qos *qos, int defer)
 {
 	struct btd_adapter *adapter = data->user_data;
 	GIOChannel *io = NULL;
@@ -1890,7 +1893,7 @@ static void setup_connect_io_broadcast(struct bap_data *data,
 			BT_IO_OPT_MODE, BT_IO_MODE_ISO,
 			BT_IO_OPT_QOS, qos,
 			BT_IO_OPT_BASE, &base,
-			BT_IO_OPT_DEFER_TIMEOUT, false,
+			BT_IO_OPT_DEFER_TIMEOUT, defer,
 			BT_IO_OPT_INVALID);
 
 	if (!io) {
@@ -2019,9 +2022,6 @@ static void setup_create_bcast_io(struct bap_data *data,
 
 	memset(&iso_qos, 0, sizeof(iso_qos));
 
-	if (!defer)
-		goto done;
-
 	iso_qos.bcast.big = setup->qos.bcast.big;
 	iso_qos.bcast.bis = setup->qos.bcast.bis;
 	iso_qos.bcast.sync_factor = setup->qos.bcast.sync_factor;
@@ -2038,9 +2038,10 @@ static void setup_create_bcast_io(struct bap_data *data,
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
@@ -2128,11 +2129,135 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 	}
 }
 
+/* This function will call setup_create_io on all BISes from a BIG.
+ * The defer parameter will be set on true on all but the last one.
+ * This is done to inform the kernel when to when to start the BIG.
+ */
+static bool create_io_bises(struct bap_setup *setup,
+				uint8_t nb_bises, struct bap_data *data)
+{
+	const struct queue_entry *entry;
+	struct bap_setup *ent_setup;
+	bool defer = true;
+	uint8_t active_bis_cnt = 1;
+
+	for (entry = queue_get_entries(setup->ep->setups);
+				entry; entry = entry->next) {
+		ent_setup = entry->data;
+
+		if (bt_bap_stream_get_qos(ent_setup->stream)->bcast.big !=
+				bt_bap_stream_get_qos(setup->stream)->bcast.big)
+			continue;
+
+		if (active_bis_cnt == nb_bises)
+			defer = false;
+
+		setup_create_io(data, ent_setup, ent_setup->stream, defer);
+		if (!ent_setup->io) {
+			error("Unable to create io");
+			goto fail;
+		}
+
+		active_bis_cnt++;
+	}
+
+	return true;
+
+fail:
+	/* Clear the io of the created sockets if one
+	 * socket creation fails.
+	 */
+	for (entry = queue_get_entries(setup->ep->setups);
+				entry; entry = entry->next) {
+		ent_setup = entry->data;
+
+		if (bt_bap_stream_get_qos(ent_setup->stream)->bcast.big !=
+				bt_bap_stream_get_qos(setup->stream)->bcast.big)
+			continue;
+
+		if (setup->io)
+			g_io_channel_unref(setup->io);
+	}
+	return false;
+}
+
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
+/* Function checks the state of all streams in the same BIG
+ * as the parameter stream, so it can decide if any sockets need
+ * to be created. Returns he number of streams that need a socket
+ * from that BIG.
+ */
+static uint8_t get_streams_nb_by_state(struct bap_setup *setup)
+{
+	const struct queue_entry *entry;
+	struct bap_setup *ent_setup;
+	uint8_t stream_cnt = 0;
+
+	if (setup->qos.bcast.big == BT_ISO_QOS_BIG_UNSET)
+		/* If BIG ID is unset this is a single BIS BIG.
+		 * return 1 as create one socket only for this BIS
+		 */
+		return 1;
+
+	for (entry = queue_get_entries(setup->ep->setups);
+				entry; entry = entry->next) {
+		ent_setup = entry->data;
+
+		/* Skip the curent stream form testing */
+		if (ent_setup == setup) {
+			stream_cnt++;
+			continue;
+		}
+
+		/* Test only BISes for the same BIG */
+		if (bt_bap_stream_get_qos(ent_setup->stream)->bcast.big !=
+				bt_bap_stream_get_qos(setup->stream)->bcast.big)
+			continue;
+
+		if (bt_bap_stream_get_state(ent_setup->stream) ==
+				BT_BAP_STREAM_STATE_STREAMING)
+			/* If one stream in a multiple BIS BIG is in
+			 * streaming state this means that just the current
+			 * stream must have is socket created so return 1.
+			 */
+			return 1;
+		else if (bt_bap_stream_get_state(ent_setup->stream) !=
+				BT_BAP_STREAM_STATE_CONFIG)
+			/* Not all streams form a BIG have received transport
+			 * acquire, so wait for the other streams to.
+			 */
+			return 0;
+
+		stream_cnt++;
+	}
+
+	/* Return the number of streams for the BIG
+	 * as all are ready to create sockets
+	 */
+	return stream_cnt;
+}
+
 static void bap_state_bcast(struct bt_bap_stream *stream, uint8_t old_state,
 				uint8_t new_state, void *user_data)
 {
 	struct bap_data *data = user_data;
 	struct bap_setup *setup;
+	bool defer = false;
+	uint8_t nb_bises = 0;
 
 	DBG("stream %p: %s(%u) -> %s(%u)", stream,
 			bt_bap_stream_statestr(old_state), old_state,
@@ -2153,14 +2278,69 @@ static void bap_state_bcast(struct bt_bap_stream *stream, uint8_t old_state,
 			queue_remove(data->streams, stream);
 		break;
 	case BT_BAP_STREAM_STATE_CONFIG:
-		if (setup && !setup->id) {
-			setup_create_io(data, setup, stream, true);
+		if (!setup || setup->id)
+			break;
+		if (bt_bap_stream_io_dir(stream) ==
+				BT_BAP_BCAST_SOURCE) {
+			/* If the stream is attached to a
+			 * broadcast sink endpoint.
+			 */
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
+				queue_foreach(setup->ep->setups,
+					iterate_setup_update_base, setup);
+			}
+			/* The kernel has 2 requirements when handling
+			 * multiple BIS connections for the same BIG:
+			 * 1 - setup_create_io for all but the last BIS
+			 * must be with defer true so we can inform the
+			 * kernel when to start the BIG.
+			 * 2 - The order in which the setup_create_io
+			 * are called must be in the order of BIS
+			 * indexes in BASE from first to last.
+			 * To address this requirement we will call
+			 * setup_create_io on all BISes only when all
+			 * transport acquire have been received and will
+			 * send it in the order of the BIS index
+			 * from BASE.
+			 */
+			nb_bises = get_streams_nb_by_state(setup);
+
+			if (nb_bises == 1) {
+				setup_create_io(data, setup,
+				stream, defer);
+				if (!setup->io) {
+					error("Unable to create io");
+					if (old_state !=
+						BT_BAP_STREAM_STATE_RELEASING)
+						bt_bap_stream_release(stream,
+								NULL, NULL);
+				}
+				break;
+			} else if (nb_bises == 0)
+				break;
+
+			if (!create_io_bises(setup, nb_bises, data)) {
+				if (old_state !=
+					BT_BAP_STREAM_STATE_RELEASING)
+					bt_bap_stream_release(stream,
+						NULL, NULL);
 			}
 		}
 		break;
-- 
2.39.2

