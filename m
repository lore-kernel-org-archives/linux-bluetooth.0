Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E8C1411ED
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 14:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713363967; cv=fail; b=kKlfEvXucD0UGmrECVcETVF8E+LA1EeHXt6rjd414ld3DHDB+TE1S8p9DvuLzswVPdpBipq+Qs9m6KUiIfky/n/Mo7mej4mw+rJOu5O4v0qg8gqzgVloQnbxy55e8uLTz2cwx0TVEV+0F5UdWPMw8HxpgN422KqiNit8CfKwVyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713363967; c=relaxed/simple;
	bh=Xl5FvrHbEDCrqnx84qFMImeYoAyCOr0XhtmG79j+XFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tknISW4DWcLveZVtg7H1c0gE84DO34M5acyhiR39nDzVfrcfMkfIAEW3yPUfpmGQAXY/IA/QBH4gCbiJ0E7oeaSYXHrufbvfHBuY5dWzERg56czfwDaS52yf9ih6yTEC+gyACT9bdEbwVE6cUUeTlUPmX1qQiZAcQf9poIaCZLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PqYCJJY7; arc=fail smtp.client-ip=40.107.7.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PqYCJJY7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FL4CdfstAsyli/VtsnvJ4f9DfntLPOAmGlCxGVDca+0Tmo0U0KPdm/Vr9t93BcD6dGRVeuRi9OjJzyvsb3TYZRnuEjMXvMSG76e7Unb4DFNq1CXD9oAY5yAqEctkE1EUrOHDa5Pr6t4R6YTw9fS6tPfToqVd0+BfguOYalyakyeb1JmN4RoiBQeSWaPDLPqA1HKS0egjqJn7T952zVKj3XOGTBrljoy9uC5CRkEowa5cjX+20eGeysNxMfXhYSj4b8dO31dEUUqw0+cDl5N61XOoKUI4fOAX7aOF6tgRTDxAVWVBL8+aZsMdJwfPzpltV8d+wl1jj3FvM0Svpu5bzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s81JU3C1DQQQnC2Gy9eOSjKfecucSk3KzT2743bjxQk=;
 b=CzjS+FiQ13Fev9sZTx+FWEQ+yjPpdDZ9BjeV9bFskdX59qh0HE/EVlbC4TOpuAIVgJxXWmtGkjMvmIpG+Emhj0LQZ8mFvl0fIE3ldR8JipF4xY6rp2F1jlqH/ldGSpm9FxWPOyuKLfKRNkK8Mp3VuJ7UwaHRV6TNGveDva7jipiCtJyYOvY6PQHlDiKuIhJ08+bFPzloewaV17RC3EzrJ5wcb3drBXcqaB4yQU2uNiDYCHMs3Uuxd2QW8W3yDg6cKSFhBKnf3DB7arP0/Ov/tZbsGAjrwFVf8bhric4cwRVPe5TtOCpisDJZhQ+ehBB6VwhCyj2vCfX25afSUjGR8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s81JU3C1DQQQnC2Gy9eOSjKfecucSk3KzT2743bjxQk=;
 b=PqYCJJY7bZiZUvf03Lnv6/sC5ZLeiu3O/KgqshrkkKUPDD9zzYCFH0SgqLj0zxoMXkoh/lJ5/KmR4G94bLiaTjO+lhKgBsQTr0Go2PPhEnoZPZSaM7Kx4S/E+Zvld/A7/klyoOw+iUozFzC4v/CZY/YKyaKAfBq5yixIR/lgFt0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by PA4PR04MB7504.eurprd04.prod.outlook.com (2603:10a6:102:e6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 14:26:01 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 14:26:01 +0000
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
Date: Wed, 17 Apr 2024 17:25:37 +0300
Message-Id: <20240417142537.6523-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240417142537.6523-1-vlad.pruteanu@nxp.com>
References: <20240417142537.6523-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1PR01CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:102::16) To VI1PR04MB5389.eurprd04.prod.outlook.com
 (2603:10a6:803:d8::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|PA4PR04MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d6641f-8036-460f-3150-08dc5eea4e71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bUO3Vu5wMdCJM7OjN6XV2/mnwIEYzGLwABJPcZCToHMylTUB4kZ4nWnLZYNr+fou18FsTumYvYZZOUrfiIu+sdM3NFAcaOSdkOG6Sya+PKBfE1dPC+eqSeJcyS/llSbkktB1cYE1UjIAndwKMQSsdasUCggmGlhIRpthjJY7pD+yzsQdmpo1gsSiirt0UGUhD5g8qGBS9X2a4IiOdGW2N6zQlM/FN6Kxnek7KbkPUmPW5JB/cBtQun8kVJGibMueNrqzFG4/UA+aVZyceJWlTJNFfkuGsTtOYAI3Mopcx5GN6230Ph5qOt0IWb0VPd8VKDh9yBMyQG5Gl4rCs88tGtEyNcLT/QJb2ZBDJDp6s0jWkgbsK9xmJwBEcldHR/4udTdaY7XJijskuODdljWEtYYEFqSqY9kRJtNwHCDrHLlhulXNjJ1cSeJXrXiF/IN8fRO5yAgAZLPQKdtN1b0H81eeNbvKK4klk3qLZ+dG7MjpKERBZmSRQ7Bf0qmmWh1cU1MoIwYwpp59DGP5UuuGKNI99xrxFNlHJPpoMCk/AhmRGpqDwoFB5m82aGMQN8EJ6PmaL9MWGDLlYGFtptafsxFPH5aPgqN8YoX1HQFsutiL51tV63PfsTYm8ltArVwq1FuhJhDeYPVM6rIsD0NG+yDo28UP0KlJ2S3MRe73eaL7+nSJRD/kLollMVltA1gVeODPQ6Dtl3bBzHdrGusk2Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(376005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fV2+9PePHQ8e9hdGxQ+7g9lwkdaDjQvwXUG1BsW/uEq2OUH4+N3o67f7vNMN?=
 =?us-ascii?Q?W0+NPDYDif2ADkxb+DgGQGlEZdAo6jzIFaVeASSSFk80TgSik6c/OYusCvPg?=
 =?us-ascii?Q?TIstcfh0Z/UuEf80BdSXz5J2hi8N1s4LtGQWlcOWXGi1eychyd2N0L+mMYX3?=
 =?us-ascii?Q?Ra/kggHevX8dGSruoqCKkC1pVtMzsPR74/QTQdfIJRJl5qznBhH3PFe5ePFC?=
 =?us-ascii?Q?jZz1FMrn14ksAAAj+jUcet7ZovRSrbk2HJJEIoRykTPMtDvL6hDAX3QUavQB?=
 =?us-ascii?Q?wqyM/a8J9gPh+6RAUwbirme9L10QsbRcHqXiJWgxedrW6oPoYkIX6UAI7wU5?=
 =?us-ascii?Q?uqUr93mNGCQAQBEHyI/uoRRMZF+GmB7v0mT9MUT5eaDTIHmnZyptdGegseOy?=
 =?us-ascii?Q?xW/Zxx92xM8FfzIcnzM3PkwT/u1y1wscUMG5q7PGxzwpBqUi8IGp/VMtCQ/8?=
 =?us-ascii?Q?UO/j81ZW7Bi0GMe6AQPY54tioZMisdOMvPvwWNKOtaK2Ph7alkHrzZo1tKko?=
 =?us-ascii?Q?ZH5ZwwSwiNRA1cvUo4MxbzVu29t5P7NJgXFe4fy0vKrXp/KKGRiSL6T+Cgia?=
 =?us-ascii?Q?SIPjE4uozv5PX2notopvChZVmPnJM7gw4V/r0Mwl1m+7x4yjnh0+V2rGcp4L?=
 =?us-ascii?Q?O1Ip4pF3u/HQ8ZNCX3vnLGl/C5+j83usb1efEJ5RdBHUwle8dsJVD22FS7dJ?=
 =?us-ascii?Q?GScoaDF7NLaRfZn6ZtqgEL4BUEOTq4dHiuQeVk598lT60OzuQM6wr3uCdIVg?=
 =?us-ascii?Q?Uj+8QewiCbKexX3aSkSo1ltG9IdK9RqP4yWIXsvitKtcBcCH1DiFKHq0K3x1?=
 =?us-ascii?Q?+eDVTGPixZdINw2bkGlXUBOurXqMgxA8+IfYD8fIfFuAisIxGN6XIU07sRZU?=
 =?us-ascii?Q?djhnE5CU9IXOW77hTbDuVm/wqjST5JnKk7Y2iDNvoEpISndZdM4LkCqRWl1l?=
 =?us-ascii?Q?4cwlgI3iN9z2XwNyHrx40+/w3IcFapW7sakXHIKx6KxCHzSvCnLn67VxqLFH?=
 =?us-ascii?Q?KuWlzSjKkafvJO6k4jF4eWI68gM3XgFbPwm/vhnQuf1y3KMhplJ5c9kNPaSR?=
 =?us-ascii?Q?3pEQMnnDKSvwlTeQ/wjNPcZjT3J8CNFBWtNXmF+n7yloP5gXqjwQw6X4R/lv?=
 =?us-ascii?Q?Jc2Cv2Fg6uc4BLFYeBXlLHkYLbwhfqBtqYxyx/32b2G9oBiAUEBB9vUTuuX7?=
 =?us-ascii?Q?XihFO3S6/5Lk4HFxtj0Q6g5YmcD9zYTeMC58yWcRiTZxZU62mMtGT+N3CqsH?=
 =?us-ascii?Q?3JTpr8/N4LrHd+wS0pPhBi1+TvlRpPpItuidGGApJQ/Hyh05NZmFtpiGgiP0?=
 =?us-ascii?Q?QQj+gFm6qOY3qpradVVJ2N2aibnm31A16GQtrhPh7aSTmhM1hk98UWYQtgIb?=
 =?us-ascii?Q?h/mldJL2YxzRKuOuA6flL7v2qU2dVUj+2iy/FmT8Iku6P4RmNS5SMtBMjlQp?=
 =?us-ascii?Q?f+n0I4uFowRmSwSsckGvkfQWq/NOyox7YXzdWe1RXoAs4yJ2GqnGRUrpgq+b?=
 =?us-ascii?Q?rgr2HxxfrPxvXK6LVYNTXW6oq3xCRh5qf4yABO5WFHMz5IC20ZgH48/PKfxE?=
 =?us-ascii?Q?wBaQPLhT7MASC7JLrPmGEEte2FDkm3H1LGi95pDc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d6641f-8036-460f-3150-08dc5eea4e71
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 14:26:01.3075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RjFZ37KFdT/cmWnACiL9G2IrAMhG54UPL+EFx1AfdnqXrX18MKLuGZHgvaMur/NvXqcZNqUWYZoSiDppdMmDOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7504

This patch replaces the current implementation that uses a global
bcast_pa_requests queue and instead creates a queue and a timer for
each adapter.

The queue for a specific adapter, the timer's id and the adapter's id
form a new struct called pa_timer_data. For each adapter a new instance
of this struct is created and inserted into the global queue, pa_timers.

Operations on the old bcast_pa_requests queue have been modified such
that:
1) based on the adapter_id, the correct entry in the pa_timers queue is
retrieved
2) the operation can be called on the bcast_pa_requests queue from the
resulting pa_timer_data instance

The timers are created and stopped on a per adapter basis. A timer is
stopped if the adapter's pa_req queue is empty. A pa_timer_id equal
to 0 means that the timer is stopped.

The bap_bcast_remove function has been updated to remove from the
pa_req queue entries of devices that were freed. pa_req that are already
in progress are treated by the bap_data_free function.

This patch also fixes a crash that occurs when a device is freed before
the pa_idle_timer handles it's entry in the pa_req queue. The following
log was obtained while running an Unicast setup:

==105052==ERROR: AddressSanitizer: heap-use-after-free on address
0x60400001c418 at pc 0x55775caf1846 bp 0x7ffc83d9fb90 sp 0x7ffc83d9fb80
READ of size 8 at 0x60400001c418 thread T0
0 0x55775caf1845 in btd_service_get_device src/service.c:325
1 0x55775ca03da2 in short_lived_pa_sync profiles/audio/bap.c:2693
2 0x55775ca03da2 in pa_idle_timer profiles/audio/bap.c:1996
---
 profiles/audio/bap.c | 115 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 97 insertions(+), 18 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index db0af7e7c..df0c35a6f 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -126,9 +126,14 @@ struct bap_bcast_pa_req {
 	} data;
 };
 
+struct pa_timer_data {
+	struct btd_adapter *adapter;
+	unsigned int pa_timer_id;
+	struct queue *bcast_pa_requests;
+};
+
 static struct queue *sessions;
-static struct queue *bcast_pa_requests;
-static unsigned int pa_timer_id;
+static struct queue *pa_timers;
 
 /* Structure holding the parameters for Periodic Advertisement create sync.
  * The full QOS is populated at the time the user selects and endpoint and
@@ -965,15 +970,25 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
+static bool pa_timer_match_adapter(const void *data, const void *match_data)
+{
+	struct pa_timer_data *pa_timer = (struct pa_timer_data *)data;
+
+	return pa_timer->adapter == match_data;
+}
+
 static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 {
 	struct bap_bcast_pa_req *req = user_data;
 	struct bap_setup *setup = req->data.setup;
+	struct pa_timer_data *pa_timer = queue_find(pa_timers,
+			pa_timer_match_adapter, setup->ep->data->adapter);
 	int fd;
 
 	DBG("BIG Sync completed");
 
-	queue_remove(bcast_pa_requests, req);
+	queue_remove(pa_timer->bcast_pa_requests, req);
+	free(req);
 
 	/* This device is no longer needed */
 	btd_service_connecting_complete(setup->ep->data->service, 0);
@@ -1111,6 +1126,8 @@ static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
 	struct bap_data *data = btd_service_get_user_data(pa_req->data.service);
 	struct bt_iso_base base;
 	struct bt_iso_qos qos;
+	struct pa_timer_data *pa_timer = queue_find(pa_timers,
+				pa_timer_match_adapter, data->adapter);
 
 	DBG("PA Sync done");
 
@@ -1130,8 +1147,8 @@ static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
 	g_io_channel_unref(data->listen_io);
 	g_io_channel_shutdown(io, TRUE, NULL);
 	data->listen_io = NULL;
-	queue_remove(bcast_pa_requests, pa_req);
-
+	queue_remove(pa_timer->bcast_pa_requests, pa_req);
+	free(pa_req);
 	/* Analyze received BASE data and create remote media endpoints for each
 	 * BIS matching our capabilities
 	 */
@@ -2015,14 +2032,15 @@ static void pa_and_big_sync(struct bap_bcast_pa_req *req);
 
 static gboolean pa_idle_timer(gpointer user_data)
 {
-	struct bap_bcast_pa_req *req = user_data;
+	struct pa_timer_data *pa_timer = user_data;
+	struct bap_bcast_pa_req *req;
 	bool in_progress = FALSE;
 
 	/* Handle timer if no request is in progress */
-	queue_foreach(bcast_pa_requests, check_pa_req_in_progress,
+	queue_foreach(pa_timer->bcast_pa_requests, check_pa_req_in_progress,
 			&in_progress);
 	if (in_progress == FALSE) {
-		req = queue_peek_head(bcast_pa_requests);
+		req = queue_peek_head(pa_timer->bcast_pa_requests);
 		if (req != NULL)
 			switch (req->type) {
 			case BAP_PA_SHORT_REQ:
@@ -2034,6 +2052,14 @@ static gboolean pa_idle_timer(gpointer user_data)
 				pa_and_big_sync(req);
 				break;
 			}
+		else {
+			/* pa_req queue is empty, stop the timer by returning
+			 * FALSE and set the pa_timer_id to 0. This will later
+			 * be used to check if the timer is active.
+			 */
+			pa_timer->pa_timer_id = 0;
+			return FALSE;
+		}
 	}
 
 	return TRUE;
@@ -2043,15 +2069,25 @@ static void setup_accept_io_broadcast(struct bap_data *data,
 					struct bap_setup *setup)
 {
 	struct bap_bcast_pa_req *pa_req = new0(struct bap_bcast_pa_req, 1);
+	struct pa_timer_data *pa_timer = queue_find(pa_timers,
+				pa_timer_match_adapter, data->adapter);
+
+	/* Timer could be stopped if all the short lived requests were treated.
+	 * Check the state of the timer and turn it on so that this requests
+	 * can also be treated.
+	 */
+	if (pa_timer->pa_timer_id == 0)
+		pa_timer->pa_timer_id = g_timeout_add_seconds(
+		PA_IDLE_TIMEOUT, pa_idle_timer, pa_timer);
 
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
+	queue_push_tail(pa_timer->bcast_pa_requests, pa_req);
 }
 
 static void setup_create_ucast_io(struct bap_data *data,
@@ -2880,18 +2916,18 @@ static int bap_bcast_probe(struct btd_service *service)
 	struct btd_adapter *adapter = device_get_adapter(device);
 	struct bap_bcast_pa_req *pa_req =
 			new0(struct bap_bcast_pa_req, 1);
+	struct pa_timer_data *pa_timer =
+			queue_find(pa_timers, pa_timer_match_adapter, adapter);
 
 	if (!btd_adapter_has_exp_feature(adapter, EXP_FEAT_ISO_SOCKET)) {
 		error("BAP requires ISO Socket which is not enabled");
 		return -ENOTSUP;
 	}
 
-	/* First time initialize the queue and start the idle timer */
-	if (bcast_pa_requests == NULL) {
-		bcast_pa_requests = queue_new();
-		pa_timer_id = g_timeout_add_seconds(PA_IDLE_TIMEOUT,
-					pa_idle_timer, NULL);
-	}
+	/* Start the PA timer if it hasn't been started yet */
+	if (pa_timer->pa_timer_id == 0)
+		pa_timer->pa_timer_id = g_timeout_add_seconds(
+		PA_IDLE_TIMEOUT, pa_idle_timer, pa_timer);
 
 	/* Enqueue this device advertisement so that we can do short-lived
 	 */
@@ -2899,17 +2935,38 @@ static int bap_bcast_probe(struct btd_service *service)
 	pa_req->type = BAP_PA_SHORT_REQ;
 	pa_req->in_progress = FALSE;
 	pa_req->data.service = service;
-	queue_push_tail(bcast_pa_requests, pa_req);
+	queue_push_tail(pa_timer->bcast_pa_requests, pa_req);
 
 	return 0;
 }
 
+static bool match_service(const void *data, const void *match_data)
+{
+	struct bap_bcast_pa_req *pa_req = (struct bap_bcast_pa_req *)data;
+
+	if (pa_req->data.service == match_data)
+		return true;
+	return false;
+}
+
 static void bap_bcast_remove(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
+	struct btd_adapter *adapter = device_get_adapter(device);
+	struct pa_timer_data *pa_timer =
+			queue_find(pa_timers, pa_timer_match_adapter, adapter);
+	struct bap_bcast_pa_req *pa_req;
 	struct bap_data *data;
 	char addr[18];
 
+	/* Remove the corresponding entry from the pa_req queue. Any pa_req that
+	 * are in progress will be stopped by bap_data_remove which calls
+	 * bap_data_free.
+	 */
+	pa_req = queue_remove_if(pa_timer->bcast_pa_requests,
+						match_service, service);
+	if (pa_req)
+		free(pa_req);
 	ba2str(device_get_address(device), addr);
 	DBG("%s", addr);
 
@@ -3021,6 +3078,7 @@ static int bap_adapter_probe(struct btd_profile *p,
 	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
 	struct bap_data *data;
 	char addr[18];
+	struct pa_timer_data *pa_timer;
 
 	ba2str(btd_adapter_get_address(adapter), addr);
 	DBG("%s", addr);
@@ -3055,6 +3113,14 @@ static int bap_adapter_probe(struct btd_profile *p,
 
 	bt_bap_set_user_data(data->bap, adapter);
 	bap_data_set_user_data(data, adapter);
+
+	if (pa_timers == NULL)
+		pa_timers = queue_new();
+	pa_timer = new0(struct pa_timer_data, 1);
+	pa_timer->adapter = adapter;
+	pa_timer->bcast_pa_requests = queue_new();
+	queue_push_tail(pa_timers, pa_timer);
+
 	return 0;
 }
 
@@ -3063,11 +3129,24 @@ static void bap_adapter_remove(struct btd_profile *p,
 {
 	struct bap_data *data = queue_find(sessions, match_data_bap_data,
 						adapter);
+	struct pa_timer_data *pa_timer = queue_find(pa_timers,
+					pa_timer_match_adapter, adapter);
 	char addr[18];
 
 	ba2str(btd_adapter_get_address(adapter), addr);
 	DBG("%s", addr);
 
+	queue_remove_all(pa_timer->bcast_pa_requests,
+					NULL, NULL, free);
+	free(pa_timer->bcast_pa_requests);
+	queue_remove(pa_timers, pa_timer);
+	free(pa_timer);
+
+	if (queue_isempty(pa_timers)) {
+		queue_destroy(pa_timers, NULL);
+		pa_timers = NULL;
+	}
+
 	if (!data) {
 		error("BAP service not handled by profile");
 		return;
-- 
2.40.1

