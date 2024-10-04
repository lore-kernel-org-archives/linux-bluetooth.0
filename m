Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389041D414F
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045356; cv=fail; b=GrqLhCPANt1MwZKcNed4WvlqFUMs4xPDsIA/DdgWhLyjPC6jncjMBcyz+pLhniQGmDOm9T/WCFgBzDLUn0AVNUMMhG2OC9U8wYFHzX5j7c8MDLaiDlurH6qtufYZQcJhiU98k46hH7QJdTqaIhFTz0EBbQifoWvGoPlQO1TNrfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045356; c=relaxed/simple;
	bh=9V5nz0iQvDZHprOomxwcwKQeSktgxhHp7EAc8fC2z60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZqRfGWcgzh7QggGaO53mGdKi0yAJYIOAJDw0zIVmbVE0Z5cQ+KdY5c5FD/7J6QU9kZjwFmphDFqbNjz2ny/pUt41u4MNZ8UWaXp010y/xnZhCzRe43tYXBhyaIA99WXQgREPgZ5fOSMJAt1H61hMPH7R0A8XhQdX43U4w3uBo3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TQZ16d6o; arc=fail smtp.client-ip=40.107.104.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TQZ16d6o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mH5j4sMxr/t9oRMZST/lLi2lGDPpxOgJsezKejklf1f6R+UpaAXbtYM8Z81eEeXiO9re60Pq6B5AuROhHA4tBc+Cba++7+a1QorDS1aCTWLybQZf9WPYJi7ih5eeutw8GdLF/sLappN3bVEsqKBz4tgwnybSdPuyvcaEQrb1WnjHzxvTBcfuMiGCcz7SSgH/zDqqVj+smHqgT30+lS3xIW/YXTADfD0VDndXto+pimZfgnBKXNNQRghNpou2KbiCEkU20pkJ3qggZ8YIBnZKDV9OXwiFh0JZAy5qEtWwE/f96c9A3uE+VqsHzUeygsNixpQO0BxV3wLMtx7520UzXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvo1Xh5B8/pATyDShifHKzsSNRJnE6903jqu9TPOF1o=;
 b=zJ/9CXxsy26T/4JDmRBDFykgok5YHaddDD5uaSHKFtLK2z0t5qyh1Sh9RxgIcdP9z+jxVOhO0O1g8OnUPM4kkZCaBHByjNLjH4XlIHSZRan28mammzU53EJB0UiBHm1q4wB9Hwx41u2u9HNSH/4NMGzV9hZae5ig9H+0DVl9J5zryoQMqLmmyxrYaAs0iMidjPKPeNFilQJV+/APeHvgc2GoPYmzXhc0mu4anXh4zgecDEmGcTet7mcjZoQlG748vmG9bX8mOFSKlkTxxYPrreC69P+RzkFNALupuZCd73ireS1xTeRae7XPAfau1k0s3w25qePtd3/eIAsAuZ6OrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvo1Xh5B8/pATyDShifHKzsSNRJnE6903jqu9TPOF1o=;
 b=TQZ16d6oxmgp0UudMAxlnx3jjGv7Y8voNeAtG2+kk1KGyOBKKbbk4pRs1+N5ROd10SMPNb9ILOwilESr0BSIWT35lZocVIu5qOKsbctLyg7nZS1vT4o7pN4i5h1xPlSiOyGdIezaeRHRRrALhLNuAdM4b6qoPUb0M3FFxIV0QG767uxKpjQbHmfQ2SuS3D2Po+YreedsoAEfhgTLCHN6veAzOyB4sDbPGzI+IjKYYyqORPeIJGDwOryauX+ElX7a1FHCRlqyENgQPJbhXO4HTIgoMSrwBmU3A50VdLjIAQ9Lc4ncBFlZek4kngiksSFkUaF4ejZqH2yCz3WFt5v9ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by VI2PR04MB11075.eurprd04.prod.outlook.com (2603:10a6:800:27a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 12:35:51 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 12:35:51 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 7/9] bap: Handle req to sync to multiple BISes
Date: Fri,  4 Oct 2024 15:35:21 +0300
Message-Id: <20241004123523.1012743-8-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241004123523.1012743-1-vlad.pruteanu@nxp.com>
References: <20241004123523.1012743-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0056.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::7) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|VI2PR04MB11075:EE_
X-MS-Office365-Filtering-Correlation-Id: 07193388-8ec5-4c84-e1d2-08dce47114b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vTgDSw6w/eGfkyLHnoFtxQk3eH+xFajCAYVQi5EZJosN4o1viumPaT3AY+64?=
 =?us-ascii?Q?7SSZV3QVciaqvz1InaWbdi64X6FgRnkLvf5IMGj94OdBOjhBeUIQrwGt1oqc?=
 =?us-ascii?Q?0Ag/nbu2GOPDBSfmBFdHphvOwg11r1LUgDLrvHPTSwnXNZpMvRvlfnqkG+iD?=
 =?us-ascii?Q?YKpl3fVy7dvLrfX4vkpgJENwBdbqx2i4w6is274iAiQNTaaYFJahTN4+u5z6?=
 =?us-ascii?Q?sr0nr9D81/UfefLaAXKr+o4KgYfQKNfLt4c2jS3rgX34WT9Ju8svwHCYl1+j?=
 =?us-ascii?Q?RGlXHoyCaG9zctILbNApdLZKXxJjw8WrlGBO4iIZ0ghhfnA0MOx52dUKNjSS?=
 =?us-ascii?Q?lhUjK012XZDtAloPzI9mmx+hnUKcC1vQxDfwShp3uny21VdXO6GElQg/jLvC?=
 =?us-ascii?Q?WnbKcBqLpAhY0U+o0wE89yl00F9Y1+C9TKmFlFUqUg4HPd6f/j/44U2DLbPv?=
 =?us-ascii?Q?YWgh+2Vu8pprfajXaO4oOI0Yx2p7ibv3YVXaiCvdwd0dNvaAd7mVLHduwgAk?=
 =?us-ascii?Q?gT/Kuo3nh7InYZDb3vpXM5J+Ecjwqpe+rdLGEGvq2TS+5Emiz1P/cFdfpllv?=
 =?us-ascii?Q?MhudDA1c0H8fLaXlAQq5lfL3n5/biZrjIHtMdeb+SUZkl8nH/1Evy1tyiXra?=
 =?us-ascii?Q?3FtrdzTbg6tSXeLY6wawM4cskwEDQ1wi5yQNGqWaOh6aJpvIYkzsIFSYliVy?=
 =?us-ascii?Q?ME54ooJs8Jt3P5tvBMvRbg9TJW00hcbu7woTomxk3vFAzU1n4gfsGUHGOiDQ?=
 =?us-ascii?Q?f5OjLWWiTcfqmooVQXajLHWfiYq0l5OVX1HjUe8EONUINbAeeUQbV4UDNqmg?=
 =?us-ascii?Q?KmraI+DM8EfRYVGK1nDN/yy/N7w3yukqaau8UGZCO/PwLnKUuWOz7QjxmXb1?=
 =?us-ascii?Q?RIXN8+5AAgbuvDs/xbTdoehXxK94YdWVlZ/qx+/f9ae4Gz+M2+GrS8p4NKCr?=
 =?us-ascii?Q?LqUcKc1suvpg3tAKB7+1NWruxn5jVtJgVeiTa4J2vrJeU5D+j9mOPm6GidkQ?=
 =?us-ascii?Q?gVmGeMpjsOKi17fhvQYmJm8ewSbzaBRZ8HWS3mNtGtPInkv13kJDaMpqpI5h?=
 =?us-ascii?Q?BNlgRlOTWTaK17v0e1fk1GDqJBXtWWf9BUJbrBuQbuQUQtSI5XG3/PQA/Aiu?=
 =?us-ascii?Q?Fif1gKPcGEFCxg9n0iVW/a9zGvBJD42yDRn0FIl3gmQHJgMZY9xfw+71bV67?=
 =?us-ascii?Q?RwtBNQEoJ8dIfW1PCcV0ytrnkqNyTst33cnwm9fQ+8jVF3yFMCI82k9cjLn4?=
 =?us-ascii?Q?7C3CRNUF3jFQzQyQ8nZ3kenPkEMmjB5UhC6Wh3lhhkgZKaCyD0bLI3yEAlNw?=
 =?us-ascii?Q?32Whqp/CuksiS5MgvQAjD+DnpXkstrgfjbT0VV7vNFARoA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4gHIqJam4p5OoKIIFV8hWFkF0++kROVvgbmPBuH1DcYq3LB9bV+Tz6W5QGXA?=
 =?us-ascii?Q?ge3BeO7Dzi7Btu6eoCT/cQ/3p+1A2if4bE2F4DxFkqp22lBM8iDPLMCYgoyk?=
 =?us-ascii?Q?cGmxyYezUYDPJtEFXQoBzdpcU5vYANkOMegSABYogu2LLCo8OCbIMt39k3jU?=
 =?us-ascii?Q?HwNTyMCjDupJafMJqfw/Gd+E01VSz6PxihZUmU+mPpVGyo6TW5/SQ3+caJ0J?=
 =?us-ascii?Q?p13IwqZv9xq8DdInZujS5GZBGc88k4YSi8afMKcU7tx9SCCnDQuDeKPPC+th?=
 =?us-ascii?Q?/bVbGq1Yi8eLjuWBC/OlDzwPoZgAMIzwmtAn5daqpvyFGAiERiJMrGpcSl74?=
 =?us-ascii?Q?laYwYpxG3FFIddkfYwothtfgEOKsVcZeWKc/fg4j8cjWrpFHOWhq9hh1WRPG?=
 =?us-ascii?Q?JzRyIBBKnLdj30ODx94Ereh8WfaaVdkPkk6X3ZKgkfMfMb0zD+eMmJd6pKuP?=
 =?us-ascii?Q?SAlaG2GKu2cYF/BDXauisBVqNC5Spp4ugHYoatUvxYnECuhhrb75Qg5gAGPN?=
 =?us-ascii?Q?HOY1pEsjJrAgHUe8e0LyRp56G1WcfqCdSPBy5zmHe47NIHEb+eAwYY45tJn1?=
 =?us-ascii?Q?jxCYjI26ZEBSuO+317d3Y6FU9ls10h13B8ZBMOUQVHWJ4HMkNDRDm75Oh7IZ?=
 =?us-ascii?Q?a9tovOoKdRj9hvohU0lFh4CBPiUwMv9Fa6WlIOs155b7PlcpY5VullhT8MKT?=
 =?us-ascii?Q?3fpF0xe+vioAXgZkwuCqpTWdsg3jCw+apvRVVbQ6GVKU13deSoZLhnGXgTH2?=
 =?us-ascii?Q?x480EChx8hL/4qO4M84hZxtp1DgztVkQVfRl7wd7hBKkb8WlC0k3zGN8FJPJ?=
 =?us-ascii?Q?s8mAmeD6QBYxB535LF42qgeb57RyzGbs0LS1gE4xtlGZBMc7wX1OiN5oKZot?=
 =?us-ascii?Q?iW6qhyahNz12EwrXLyImz0jd/es/MInnO2c9L4eWWyGqhQhkL7fA8iHBbBcE?=
 =?us-ascii?Q?CWGpCzB+8NRKrsLmcAyYOA2NthG4mA7DW4C6wkHN2ZUGkcDpVOJQSX4Rrxdg?=
 =?us-ascii?Q?ZeAf9jN4wLk2vAChFWVTNyul1PcJSzHvQmMQkEllHkv0Zo/amxOiK+Wq4Q33?=
 =?us-ascii?Q?AizlR0PQBoAWLAw8OwVCtfwhh7qHlKO0TWP2vkXGpnOFc9hfC2fvRanlUIhZ?=
 =?us-ascii?Q?MJW6u2IL19yPQqapbQubuga9O9cwIrnsP2cH0FMf0QVOf1eKuzBfejnAl+F6?=
 =?us-ascii?Q?rVhpferuWrVMHnJ/HXLaU2q7026f4hsAzmLXRLNraoZNvOm+GgI2tG3oaT04?=
 =?us-ascii?Q?pJXY36rllViLzbtEE6QmF9riOmI0DpIaoanmAbiE7nPJ9877h3n+LDaHbsrH?=
 =?us-ascii?Q?kVC0YowRHhE8x4AUM0QLZKUz6MnnP73HWI93mMXAv4soeg63rWMJvmk4nwcc?=
 =?us-ascii?Q?6bsdpvfGZke0//3XSsjrrbSK1M31Gw4WaCdgEoWE25jJqEuM0p/ToaLzUJPb?=
 =?us-ascii?Q?oMR43p60rWELvfNpfkQO3P7zngwS7OXS7Q8uyPfpxlwGMPzrlyc6nfW/+I80?=
 =?us-ascii?Q?EkPybTaAnsb5vlEEv4uIrM0U5NUQYj1t7tLs0lNCS15iuPTzL7GxEQ9yY5Ge?=
 =?us-ascii?Q?+V1LmAxojvs4RTvX4oK1kjJW0Uxynd4WW1z3uIhw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07193388-8ec5-4c84-e1d2-08dce47114b6
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 12:35:51.1250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dsj9t1EipMIoT0E3E1EQL+kFE5yfwa0obC1V58MYX08Nx3rqGavbP2HLWtLpnJaVhBPa4DJS5e2P3DyVpvJl2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11075

When syncing to multiple BISes from the same BIG, an acquire call
will be issued by the Audio Server for each BIS. These need to be
merged so that the controller will receive only one req which
includes all the BISes.

When a call to create a BIG sync request is received, a check is
performed to find if any streams are in RELEASING or PENDING
state. If there are, they are part of multiple BISes sync and the
audio server was not reacquired them yet. Otherwise, the request
is allocated and the num_bis and bc_bis are set, based on streams
in ENABLING state.
---
 profiles/audio/bap.c | 101 +++++++++++++++++++++++++++++--------------
 1 file changed, 68 insertions(+), 33 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 666d3324e..7251d8759 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1031,21 +1031,22 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 
 	DBG("BIG Sync completed");
 
-	if (setup->io) {
-		g_io_channel_unref(setup->io);
-		g_io_channel_shutdown(setup->io, TRUE, NULL);
-		setup->io = NULL;
+	req->iso_bc_addr.bc_num_bis--;
+	if (req->iso_bc_addr.bc_num_bis == 0) {
+		if (setup->io) {
+			g_io_channel_unref(setup->io);
+			g_io_channel_shutdown(setup->io, TRUE, NULL);
+			setup->io = NULL;
+		}
+		/* This device is no longer needed */
+		btd_service_connecting_complete(bap_data->service, 0);
+		queue_remove(bap_data->adapter->bcast_pa_requests, req);
+		queue_destroy(req->setups, NULL);
+		free(req);
 	}
 
-	/* This device is no longer needed */
-	btd_service_connecting_complete(bap_data->service, 0);
-
 	fd = g_io_channel_unix_get_fd(io);
 
-	queue_remove(bap_data->adapter->bcast_pa_requests, req);
-	queue_destroy(req->setups, NULL);
-	free(req);
-
 	if (bt_bap_stream_set_io(setup->stream, fd)) {
 		bt_bap_stream_start(setup->stream, NULL, NULL);
 		g_io_channel_set_close_on_unref(io, FALSE);
@@ -2289,38 +2290,72 @@ static gboolean pa_idle_timer(gpointer user_data)
 	return TRUE;
 }
 
+static void find_pending_req(void *data, void *user_data)
+{
+	struct bap_setup *setup = data;
+	bool *pending = user_data;
+
+	if (bt_bap_stream_get_state(setup->stream) ==
+		BT_BAP_STREAM_STATE_PENDING ||
+		bt_bap_stream_get_state(setup->stream) ==
+		BT_BAP_STREAM_STATE_RELEASING)
+		*pending = TRUE;
+}
+
+static void count_pending(void *data, void *user_data)
+{
+	struct bap_setup *setup = data;
+	struct bap_bcast_pa_req *req = user_data;
+
+	if (bt_bap_stream_get_state(setup->stream) ==
+				BT_BAP_STREAM_STATE_ENABLING) {
+		req->iso_bc_addr.bc_bis[req->iso_bc_addr.bc_num_bis] =
+				get_bis_from_stream(setup->stream);
+		req->iso_bc_addr.bc_num_bis++;
+		DBG("pushing setup for BIS %d",
+				get_bis_from_stream(setup->stream));
+		queue_push_tail(req->setups, setup);
+	}
+}
+
 static void setup_accept_io_broadcast(struct bap_data *data,
 					struct bap_setup *setup)
 {
-	struct bap_bcast_pa_req *req = new0(struct bap_bcast_pa_req, 1);
+	struct bap_bcast_pa_req *req;
+	bool pending = FALSE;
 	struct bap_adapter *adapter = data->adapter;
 
-	req->setups = queue_new();
-	req->iso_bc_addr.bc_bdaddr_type =
+	/* Search for requests to sync to the same BIG.
+	 * If any, merge the current request with it.
+	 */
+	queue_foreach(data->bcast_snks, find_pending_req, &pending);
+	if (!pending) {
+		req = new0(struct bap_bcast_pa_req, 1);
+		req->iso_bc_addr.bc_bdaddr_type =
 			btd_device_get_bdaddr_type(data->device);
-	memcpy(&req->iso_bc_addr.bc_bdaddr,
+		memcpy(&req->iso_bc_addr.bc_bdaddr,
 			device_get_address(data->device), sizeof(bdaddr_t));
-	req->iso_bc_addr.bc_bis[req->iso_bc_addr.bc_num_bis] =
-			get_bis_from_stream(setup->stream);
-	req->iso_bc_addr.bc_num_bis++;
-	queue_push_tail(req->setups, setup);
-
-	/* Timer could be stopped if all other requests were treated.
-	 * Check the state of the timer and turn it on so that this request
-	 * can also be treated.
-	 */
-	if (adapter->pa_timer_id == 0)
-		adapter->pa_timer_id = g_timeout_add_seconds(PA_IDLE_TIMEOUT,
+		req->setups = queue_new();
+		queue_foreach(data->bcast_snks, count_pending, req);
+
+		/* Timer could be stopped if all other requests were treated.
+		 * Check the state of the timer and turn it on so that this
+		 * request can also be treated.
+		 */
+		if (adapter->pa_timer_id == 0)
+			adapter->pa_timer_id = g_timeout_add_seconds(
+								PA_IDLE_TIMEOUT,
 								pa_idle_timer,
 								adapter);
 
-	/* Add this request to the PA queue.
-	 * We don't need to check the queue here, as we cannot have
-	 * BAP_PA_BIG_SYNC_REQ before a short PA (BAP_PA_SHORT_REQ)
-	 */
-	req->type = BAP_PA_BIG_SYNC_REQ;
-	req->in_progress = FALSE;
-	queue_push_tail(adapter->bcast_pa_requests, req);
+		/* Add this request to the PA queue.
+		 * We don't need to check the queue here, as we cannot have
+		 * BAP_PA_BIG_SYNC_REQ before a short PA (BAP_PA_SHORT_REQ)
+		 */
+		req->type = BAP_PA_BIG_SYNC_REQ;
+		req->in_progress = FALSE;
+		queue_push_tail(adapter->bcast_pa_requests, req);
+	}
 }
 
 static void setup_create_ucast_io(struct bap_data *data,
-- 
2.40.1

