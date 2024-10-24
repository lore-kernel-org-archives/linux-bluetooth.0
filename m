Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2060.outbound.protection.outlook.com [40.107.249.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F145C1CACC9
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767791; cv=fail; b=K0nwSPn4yiLwkyZhX8CF6gLCvEqV/6XFCb4JhUNdjVvUJZmkeQCriqVZlP/tBrswagRjGuQ2AMiHg7zcdQwLfEXEOoiH8v/z9LaUzGYwnjl8SbgrqfEVsRMuCIyJdBZdY7dxPTDybn44d7ZbyM4ublhNZVGoGcG/hy7OlqPb2Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767791; c=relaxed/simple;
	bh=Y+Tp06REaj1ZhgxLQ9xgZOrTOq9JjDdglNUd3ZuumY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CZEnyQxyErN/SuWChzIfeDqqEZTUtST4ToaJZVRy4hWHjO6qD/j1ehz2AlKAois1fnbi4LCX7UEEQnoXCL26QROV0rM9cKGk3hyMbjXrjGFG01SNDytAP5iAMNNVTIcsu6YCD4uLzMHJ6ur+2Iv8a6usO+b9kkjWkrs6e+bore4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wi59HJF9; arc=fail smtp.client-ip=40.107.249.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wi59HJF9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQ0HRPDwUsnkrqrA1SlprfVA0MB6UtkGESXXG9MDZ2Co76Ux9spPkegL1zISHTMFxTXbvRKP/vuzlmaLAKPudvwn9Yh9oiL8M1wlZ3OU+f13/JyZgmZY0SOtcubXdyhvpIA3HktewN63zSXRUR5rFLjkWYEBTYnALiWuNrQm2bjgO6zM67oau4Hwe9to1hJTbvV7qI3P2+DJqS67yyC86UDB/U1ruKGemIFvcmlPtrI7qdrJRr0tHjFkiUc7uAjR1xV0RKdhRdUrXDF8Xq5nNSwJrg49bTvid2GrEjTD84mSQcvQSABLd9zkEW/HOaHgBAM023xQL9Wxso+ZTqZcKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VC6Yq2BvZVY7sLR6HMyH2kJTyj9o2gTdDAX53tA16Lo=;
 b=dqegDN6mqjx3wfWKnhCzaA02k6lmzV9fj9fHLvDZfZ8y3U34/XDU23Zr2AeG04/DZTTeCFo89ssJSO9y76y7y0Ns/h/53MbFb8F8IWstQfhKwOV0GjktVc/MvH1OtYZF3xGpkRHjwhqnYca/WTJQHNxXwEVb27hn+n6egYkhZR9pm4/UjiWi9abMdc9Gjs+inLzB4MEUeLna8MzhscsQOGLZCEPHymrtAJ2nmPyj2obyAl+IdagUmON0+wuZcl8OjFJzx+SX1D354yYmNlV2H2TXXOKcKdOrdxm3+KgJm/L5bnufWcHZi4A12Jqj7/s6UASH1Yq+KoPFPf78SXfokg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VC6Yq2BvZVY7sLR6HMyH2kJTyj9o2gTdDAX53tA16Lo=;
 b=Wi59HJF9jzVu+Z8rSISixzyL+aZlc56kc5tSIplpZcPM+A7jlp9Th77opznO2EFvRJnXrpWZcw6/Go8UsiGlo/jC1VSE6e7C7XvoeBSPZMSQCS5u+vObKWq+DHOp/Zke4gWu7nmPiQqStuomsJ58oRcYQAhOWGfL9872xCFbPFD8soGbIVE6FEVWBKvRRZ3UbIDJKsaL4wR7KBdioH1OA94UkIIIDZtwVQYIbNEoibDpm1dU1jjygel5x92wh/dp4pwmJ79qbF6QvtE4JS/7w0S6PM9Pd2H3X4f45ZYW4Vy2sErmBo5cYBbFfbYcBBz1i6KE4At3D9ip2KhbK6yh3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS4PR04MB9622.eurprd04.prod.outlook.com (2603:10a6:20b:4cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Thu, 24 Oct
 2024 11:03:00 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 11:03:00 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 05/14] bap: Add support for syncing to multiple BISes
Date: Thu, 24 Oct 2024 14:02:14 +0300
Message-ID: <20241024110223.77254-6-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241024110223.77254-1-iulia.tanasescu@nxp.com>
References: <20241024110223.77254-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::6) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS4PR04MB9622:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fa382b8-2141-44a6-6620-08dcf41b6c83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P6QOomn8Gq6mKv0q+anPIG5skE6y6gRwyxWwXi57/mXWk00Tb8LXumBgCjaE?=
 =?us-ascii?Q?x6LOI7rE1b6gcCqEnWefWsRyHT8slJSqrz5qH05R1vVSp5pokegKrjsAL3PZ?=
 =?us-ascii?Q?9WRGfjKMAAc49ua1q5yKdMscgx/IRVMseMMfQsEpEEI3hWsF84XKNmGiLuxZ?=
 =?us-ascii?Q?VJo6hhJ8TlKN5Ft2oZQb+6WL/XspNcQpzHnfCf4H97byRU1rvvce54PjUq/U?=
 =?us-ascii?Q?2XZqr9giN1/r/08O/cCuHleT2sA4Z6S9ahmCLsF1apn42gaFWX02z4ZsPRKU?=
 =?us-ascii?Q?M1gTPhYa2Q8gxqCRDyEdAz82FaWynNnH9HkbmZjWloMlExvCcHk8YFVW955O?=
 =?us-ascii?Q?zozix9oYI+8TcAeJgl8KoOBlH5OOHJxEuUsbhXCOIGCXVXoQGMJ0Tlf/uE8H?=
 =?us-ascii?Q?YuFvoR0rPe7h8qzM7ikZ24AUPYW0P5You7joPN3WtgsP92OXXV79bycqfuc9?=
 =?us-ascii?Q?AcO7gFmKrFVrYm6jG3QZ7grFkNEs+JEiSK3+WJuxwkG00W/ihO1rptyURwkp?=
 =?us-ascii?Q?qSm3+TjRMnEiFJvMKZB6YgBwAyvQZHSRYrKGLqrk2QsjIGkij6hxxLhnAZ9D?=
 =?us-ascii?Q?9lIugGcnONBNcPWWNZimiISgo3J2CFGwZUmfNXMFd4DRciH7KaZpKHd/CzBN?=
 =?us-ascii?Q?WobsHYOspaYdi4JjylueKpYah3BL8O9Z/sN5WXO0OT9b4D5XqhQYukgY1Kvf?=
 =?us-ascii?Q?BIgUZTTFEMY/xM8O6YDUhGUGxDkkK1E++xjuwkpzsdnsUpPF98+IIZlSFpJv?=
 =?us-ascii?Q?x90lxnNrntAxKaw/b3lVV6cXsONgkXFtlTxJvfoGtR0b/OhnH9CVUOAXaNsS?=
 =?us-ascii?Q?HgzSxO9AevDG3v8pX84tJJvNQ5KrINXvuzJyLki5sVlLhJgiQL7v4ARvmUAb?=
 =?us-ascii?Q?IpoYwOXrES3EW7xtwIHE8QiSLUfzqqHY2DPH7vhM7Hy4xAfwVVTGwximtFec?=
 =?us-ascii?Q?uJ+WZRdGUhSJHSCWnf16F6/09t5J9ba2wfMBu2FGmo/k7FPESHhCeAuZH5mo?=
 =?us-ascii?Q?q84Gi0CXZ/CIsBCea46JbLlSaAKNjKCLZ2XXPEieyjwfuHNbJg+2kpGn2Qdc?=
 =?us-ascii?Q?u0OW7yeBiIplizvbF/GCFuR/7il+i2EE+i3gj9ha88D4O5X+EuKZbo00iht4?=
 =?us-ascii?Q?qsVqYQ0K2kIM76H4YqQSddqsJd/JL4euLQxJs4+atS8+AxnGGQ0fKvI48D4G?=
 =?us-ascii?Q?0WHhlU9UPOsTQPzoIw6JSBC18Z8ALWNYDVlNi/oBlEVshAoUhV1x06Qgocw2?=
 =?us-ascii?Q?BUENAVH1zHWaMaKWfy9pNyJ1bvDCSAwlGD6cdx67/t+ZG//Z1VoKxtFd2zUK?=
 =?us-ascii?Q?7dd9tUBG4/wS1Wk5XhIJTxyOhldTRX1WDW73ebulhl5HPkfZnnr3TsSjVVY0?=
 =?us-ascii?Q?ifmXu+4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MEyS+jDFownKCnv6Xv71vpS9j7TJbzV694q6LubOJoqcsHy3oqrP95Nngkfr?=
 =?us-ascii?Q?s26Jf4MHBTO2/dXQWGAqJwmfO+zH2N4Bt2cJ3lQj/Wz1P5JGL79KbQGBUdaR?=
 =?us-ascii?Q?1lgQ5CtNiiiLGAROnLJ1bvV1NMKm2cpNdiA1x9bzb5VvbU+KETb4yjmgrv57?=
 =?us-ascii?Q?21aYSr8ESiXF12AfnRH+dSx+ebTkqLhCxdYTfqHjwudvyOV9s7rvUOBUyuFr?=
 =?us-ascii?Q?KUl2LOTZu7UDua3qecXgqVgrzMw6ocItEq+DFSu8+/o7WKaO/fX2DhF+3vyq?=
 =?us-ascii?Q?yNiMjtRZgoNnBSQoRqCOO8q0Bsses2NK1N+SVYG/CItjYj8hqHvXP0bJobWQ?=
 =?us-ascii?Q?J6hYz4abTdBRb37tvlR8XBcH2Wj/TMNAPDeVYxonqmn+Fh9qP3GURcFMFsmO?=
 =?us-ascii?Q?NKUNTzveMPnDYZmXF8ov/NTQhsBU4vUOzCv+U+f9U/9wLK8Hfc5nN0kPz6KY?=
 =?us-ascii?Q?WjQwkBvP6syu1UPUY+X2Xa45QduVn+udQjtNPbq3nCx97CrXUCFOZZuqmgcI?=
 =?us-ascii?Q?LhFsQwyvbv6mVLHo7Ntpc76VAssHwofMgfBfsPyvRyJOi5zrTYQEg5Eo14kt?=
 =?us-ascii?Q?Q6Ed5MB3OqxYVGfOn1VFY6E2fb3wq2Pp7aig5KF7cvlWm/OHkpsmFIF1Cjj9?=
 =?us-ascii?Q?91fFgsgnG/XTM4CbtXlx16sXkJhc5ruY9v6LqtqfLhdL889SLkGeIXInHr+E?=
 =?us-ascii?Q?O6y0Xc6syVFSoR3q4wHoSWGKiQ7zQX5MQ+GlKzq7StSHzEWRWmtR2eQintR7?=
 =?us-ascii?Q?J7ecjBZyImicYnYGGtOqNSpWWq2Cl0Bh+qgHipqjG0Ntciqhzq6p6/w3YxUc?=
 =?us-ascii?Q?NUJqJFrgvn61C+12jh1fGPeG+1xdrRqsIY4AKVjoaIZhxAfwxzpxFiT4iI3M?=
 =?us-ascii?Q?rRsmoaYJsDqwJQEqBCIeWTOFgeV0s4rH0fh6rj0S2OiTpl/anfPKQoQXsyIW?=
 =?us-ascii?Q?xrKuEZYowMw/oMAPYCpfqbMJWQHTi4OCMJJFb86OsCidmvs9Qrzfth5oSY+Z?=
 =?us-ascii?Q?XTmOaAqZIpO1VNH4NzXOqdL4kjJCkriI28gmc+L1lsdo3v7oCVy/ErF+AoTk?=
 =?us-ascii?Q?lKEIaJPCwyrx+AD9a1Sb49Sz7s9FLkzZzBVdE4u6u70EsguClr2k2SL6A0LE?=
 =?us-ascii?Q?Ob2vay0xPQklVOPjrWhrdJUGB7rK6gi2dUK25tV9HWq7ogIixSXjnJV1L3Qo?=
 =?us-ascii?Q?/hGkZ5kHc1paNO7Qq814CbR61hDZVeeF+R4S2IofTlCpD+jAofoRackdScze?=
 =?us-ascii?Q?lAbBggzey+Z2DHWKyZAiWb+pZ0OoF4ngy8aHnKOdw60LTjJk4ZLJ/53xJJgh?=
 =?us-ascii?Q?No9p1neSjwydPc8Sn6lqmoOr2sh3pc/NfgNUF1BfcOZDx8Qs7KiQdbExxLvv?=
 =?us-ascii?Q?Ni/7j9+5M4LtITr+DsDEZPp3dpEcP8Cg/ro2DimcI1BCKBCt5sywBcPCc1Il?=
 =?us-ascii?Q?8sEMHNPUZzpCQfNKyeQK4TCuE0XnaYlXrEn6Vti8bdnnMhdC1uQQCrTo383R?=
 =?us-ascii?Q?tExM3U3lDYNlsnW5Ryw/PWXw3W+t/cfxUElQV8RLlFTXFm6gCVCNfenvrRUr?=
 =?us-ascii?Q?iAZ1jEf+cgPfD1klZQYo5up8Dsy5EwphISCHRXvUW/fdlaCh8DNTiriJexSp?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa382b8-2141-44a6-6620-08dcf41b6c83
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 11:03:00.2611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/+WKtG0kLWolMLZ5rNIcj1XNUG8svouq5VgLNRRfcXU6GuO0HpZGaxLkzN7SGVYo13E/kVYsVs6IU0wIiR7Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9622

This adds support for a Broadcast Sink to synchronize to multiple BISes
from a Source.

BISes selected by the user need to be linked together and then enabled one
by one. The first enabled stream will enqueue all its links in a request
for PA and BIG sync. After BIG sync is established, the confirm callback
will be called for each BIS io created in the kernel. Each fd will be set
inside the corresponding link, even the links that have not yet been
enabled. The enabled links will be started as soon as the fds are ready.
---
 profiles/audio/bap.c | 169 +++++++++++++++++++++++++++----------------
 1 file changed, 108 insertions(+), 61 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 4d250db52..a02c58d13 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -134,11 +134,13 @@ enum {
 struct bap_bcast_pa_req {
 	uint8_t type;
 	bool in_progress;
+	struct bap_data *bap_data;
 	union {
 		struct btd_service *service;
-		struct bap_setup *setup;
+		struct queue *setups;
 	} data;
 	unsigned int io_id;	/* io_id for BIG Info watch */
+	GIOChannel *io;
 };
 
 static struct queue *sessions;
@@ -997,27 +999,34 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 {
 	struct bap_bcast_pa_req *req = user_data;
-	struct bap_setup *setup = req->data.setup;
+	struct bap_setup *setup;
 	int fd;
-	struct bt_bap *bt_bap = bt_bap_stream_get_session(setup->stream);
-	struct btd_service *btd_service = bt_bap_get_user_data(bt_bap);
-	struct bap_data *bap_data = btd_service_get_user_data(btd_service);
+	struct bap_data *bap_data = req->bap_data;
 
 	DBG("BIG Sync completed");
 
-	if (setup->io) {
-		g_io_channel_unref(setup->io);
-		g_io_channel_shutdown(setup->io, TRUE, NULL);
-		setup->io = NULL;
-	}
+	/* The order of the BIS fds notified from kernel corresponds
+	 * to the order of the BISes that were enqueued before
+	 * calling bt_io_bcast_accept.
+	 */
+	setup = queue_pop_head(req->data.setups);
 
-	/* This device is no longer needed */
-	btd_service_connecting_complete(bap_data->service, 0);
+	if (queue_isempty(req->data.setups)) {
+		/* All fds have been notified. Mark service as connected. */
+		btd_service_connecting_complete(bap_data->service, 0);
 
-	fd = g_io_channel_unix_get_fd(io);
+		if (req->io) {
+			g_io_channel_unref(req->io);
+			g_io_channel_shutdown(req->io, TRUE, NULL);
+			req->io = NULL;
+		}
 
-	queue_remove(bap_data->adapter->bcast_pa_requests, req);
-	free(req);
+		queue_remove(bap_data->adapter->bcast_pa_requests, req);
+		queue_destroy(req->data.setups, NULL);
+		free(req);
+	}
+
+	fd = g_io_channel_unix_get_fd(io);
 
 	if (bt_bap_stream_set_io(setup->stream, fd)) {
 		g_io_channel_set_close_on_unref(io, FALSE);
@@ -2265,6 +2274,8 @@ static void setup_accept_io_broadcast(struct bap_data *data,
 {
 	struct bap_bcast_pa_req *req = new0(struct bap_bcast_pa_req, 1);
 	struct bap_adapter *adapter = data->adapter;
+	struct queue *links = bt_bap_stream_io_get_links(setup->stream);
+	const struct queue_entry *entry;
 
 	/* Timer could be stopped if all other requests were treated.
 	 * Check the state of the timer and turn it on so that this request
@@ -2281,7 +2292,21 @@ static void setup_accept_io_broadcast(struct bap_data *data,
 	 */
 	req->type = BAP_PA_BIG_SYNC_REQ;
 	req->in_progress = FALSE;
-	req->data.setup = setup;
+	req->bap_data = data;
+
+	req->data.setups = queue_new();
+
+	/* Enqueue all linked setups to the request */
+	queue_push_tail(req->data.setups, setup);
+
+	for (entry = queue_get_entries(links); entry;
+							entry = entry->next) {
+		struct bt_bap_stream *stream = entry->data;
+
+		queue_push_tail(req->data.setups,
+				bap_find_setup_by_stream(data, stream));
+	}
+
 	queue_push_tail(adapter->bcast_pa_requests, req);
 }
 
@@ -2647,6 +2672,15 @@ static void bap_state_bcast_src(struct bt_bap_stream *stream, uint8_t old_state,
 	}
 }
 
+static bool link_enabled(const void *data, const void *match_data)
+{
+	struct bt_bap_stream *stream = (struct bt_bap_stream *)data;
+	uint8_t state = bt_bap_stream_get_state(stream);
+
+	return ((state == BT_BAP_STREAM_STATE_ENABLING) ||
+			bt_bap_stream_get_io(stream));
+}
+
 static void bap_state_bcast_sink(struct bt_bap_stream *stream,
 				uint8_t old_state, uint8_t new_state,
 				void *user_data)
@@ -2680,7 +2714,17 @@ static void bap_state_bcast_sink(struct bt_bap_stream *stream,
 			setup_io_close(setup, NULL);
 		break;
 	case BT_BAP_STREAM_STATE_ENABLING:
-		setup_create_io(data, setup, stream, defer);
+		/* Create stream io if not already created and if no
+		 * link has been enabled or started.
+		 *
+		 * The first enabled link will create and set fds for
+		 * all links.
+		 */
+		if (!bt_bap_stream_get_io(stream) &&
+			!queue_find(bt_bap_stream_io_get_links(stream),
+							link_enabled, NULL))
+			setup_create_io(data, setup, stream, defer);
+
 		break;
 	}
 }
@@ -3044,63 +3088,69 @@ static int pa_sync(struct bap_bcast_pa_req *req)
 	return 0;
 }
 
-static void iso_do_big_sync(GIOChannel *io, void *user_data)
+static void append_setup(void *data, void *user_data)
 {
-	GError *err = NULL;
-	struct bap_bcast_pa_req *req = user_data;
-	struct bap_setup *setup = req->data.setup;
-	struct bt_bap *bt_bap = bt_bap_stream_get_session(setup->stream);
-	struct btd_service *btd_service = bt_bap_get_user_data(bt_bap);
-	struct bap_data *data = btd_service_get_user_data(btd_service);
-	struct sockaddr_iso_bc iso_bc_addr;
-	struct bt_iso_qos qos;
-	char *path;
-	int bis_index = 1;
+	struct bap_setup *setup = data;
+	struct sockaddr_iso_bc *addr = user_data;
+	char *path = bt_bap_stream_get_user_data(setup->stream);
+	int bis = 1;
 	int s_err;
 	const char *strbis = NULL;
 
-	DBG("PA Sync done");
-
-	if (setup->io) {
-		g_io_channel_unref(setup->io);
-		g_io_channel_shutdown(setup->io, TRUE, NULL);
-		setup->io = io;
-		g_io_channel_ref(setup->io);
-	}
-
-	/* TODO
-	 * We can only synchronize with a single BIS to a BIG.
-	 * In order to have multiple BISes targeting this BIG we need to have
-	 * all the BISes before doing bt_io_bcast_accept.
-	 * This request comes from a transport "Acquire" call.
-	 * For multiple BISes in the same BIG we need to either wait for all
-	 * transports in the same BIG to be acquired or tell when to do the
-	 * bt_io_bcast_accept by other means
-	 */
-	path = bt_bap_stream_get_user_data(setup->stream);
-
 	strbis = strstr(path, "/bis");
-	if (strbis == NULL) {
+	if (!strbis) {
 		DBG("bis index cannot be found");
 		return;
 	}
 
-	s_err = sscanf(strbis, "/bis%d", &bis_index);
+	s_err = sscanf(strbis, "/bis%d", &bis);
 	if (s_err == -1) {
 		DBG("sscanf error");
 		return;
 	}
 
-	DBG("Do BIG Sync with BIS %d", bis_index);
+	DBG("Do BIG Sync with BIS %d", bis);
+
+	addr->bc_bis[addr->bc_num_bis] = bis;
+	addr->bc_num_bis++;
+}
+
+static void setup_refresh_qos(void *data, void *user_data)
+{
+	struct bap_setup *setup = data;
+
+	setup->qos = *bt_bap_stream_get_qos(setup->stream);
+}
+
+static void iso_do_big_sync(GIOChannel *io, void *user_data)
+{
+	GError *err = NULL;
+	struct bap_bcast_pa_req *req = user_data;
+	struct queue *setups = req->data.setups;
+	struct bap_setup *setup = queue_peek_head(setups);
+	struct bap_data *data = req->bap_data;
+	struct sockaddr_iso_bc iso_bc_addr = {0};
+	struct bt_iso_qos qos;
+
+	DBG("PA Sync done");
+
+	if (req->io) {
+		g_io_channel_unref(req->io);
+		g_io_channel_shutdown(req->io, TRUE, NULL);
+		req->io = io;
+		g_io_channel_ref(req->io);
+	}
 
 	iso_bc_addr.bc_bdaddr_type = btd_device_get_bdaddr_type(data->device);
 	memcpy(&iso_bc_addr.bc_bdaddr, device_get_address(data->device),
 			sizeof(bdaddr_t));
-	iso_bc_addr.bc_bis[0] = bis_index;
-	iso_bc_addr.bc_num_bis = 1;
 
-	/* Refresh qos stored in setup */
-	setup->qos = *bt_bap_stream_get_qos(setup->stream);
+	/* Append each linked BIS to the BIG sync request */
+	queue_foreach(setups, append_setup, &iso_bc_addr);
+
+	/* Refresh qos stored in setups */
+	queue_foreach(setups, setup_refresh_qos, NULL);
+
 	/* Set the user requested QOS */
 	memset(&qos, 0, sizeof(qos));
 	qos.bcast.big = setup->qos.bcast.big;
@@ -3142,10 +3192,7 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 static void pa_and_big_sync(struct bap_bcast_pa_req *req)
 {
 	GError *err = NULL;
-	struct bap_setup *setup = req->data.setup;
-	struct bt_bap *bt_bap = bt_bap_stream_get_session(setup->stream);
-	struct btd_service *btd_service = bt_bap_get_user_data(bt_bap);
-	struct bap_data *bap_data = btd_service_get_user_data(btd_service);
+	struct bap_data *bap_data = req->bap_data;
 
 	req->in_progress = TRUE;
 
@@ -3160,7 +3207,7 @@ static void pa_and_big_sync(struct bap_bcast_pa_req *req)
 	}
 
 	DBG("Create PA sync with this source");
-	setup->io = bt_io_listen(NULL, iso_do_big_sync, req,
+	req->io = bt_io_listen(NULL, iso_do_big_sync, req,
 			NULL, &err,
 			BT_IO_OPT_SOURCE_BDADDR,
 			btd_adapter_get_address(bap_data->adapter->adapter),
@@ -3171,7 +3218,7 @@ static void pa_and_big_sync(struct bap_bcast_pa_req *req)
 			BT_IO_OPT_MODE, BT_IO_MODE_ISO,
 			BT_IO_OPT_QOS, &bap_sink_pa_qos,
 			BT_IO_OPT_INVALID);
-	if (!setup->io) {
+	if (!req->io) {
 		error("%s", err->message);
 		g_error_free(err);
 	}
-- 
2.43.0

