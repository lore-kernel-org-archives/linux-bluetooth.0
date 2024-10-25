Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2066.outbound.protection.outlook.com [40.107.249.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03511F80DB
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 12:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858952; cv=fail; b=MaSvD6WK5WDVld9I4aSKuRuVK//M6qtoXZHw6hKmH3FKPWWXdZn58XO/QpoVzx+4lqldn3To/k8K+4CQpFFI9yfAb4vpBbOwId51ExtoWlGn/CxsfpewghxveNeydlUtKP2e2oD1ddn/8JjQgMFFe6a1L1iLxQIClOr16A3WrQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858952; c=relaxed/simple;
	bh=CimEUsgb+hSKdXv5lc4cttFowBU7JZ5evqCUoSIIuxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bIWvAkJrHevp/NkQTb1MsrjdLNYoKeK8BspTxt0g4W/exsyATyAK6pQtobcnsL+lKuXw9X9RuaDFxT6SdtpI13w483Fe0UYBSeV7CbdtCj1NWV97UhMO9trcm4HzAeaxupiLzbreUCfhVDeBfYdWGk7Wt+vFvcqNP4AjBVU3v9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RJ48gdNj; arc=fail smtp.client-ip=40.107.249.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RJ48gdNj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0r+QL6FPXVX9mBbdPYSCJ87iBP9zXCXJ0DTLtvMxOR9k01SwL9LdQczfsoQfxnJMjnd/ZdfFXKLEEXb0NqBItq9GeQmaQnTQphP8YyvMQ5+S/Ej/HwDOOKafYqGArOQBFuu4P8g9XoFeiZwCaUfD0KNXAK0I5+SLm7Bk1NDiXgcIDwha4+mUNvDKCdp0bARKx5joba+aZPdJuNGwPgeMF08FI1U5w/eZMP4teF0OFQuyKcXZz43H1NPNrctWDWo23r+xQYXve2JjDhZs3M6yHj4bHTdZtGPJdqM1p+gC5LO4kSniyiVhezx8fPVNW3hrVj4JgSIxC6j4dO7BA2baw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPRx1EL+Ory0wF/hWi8VLsusGaNBICYmIZFqW9JgFGA=;
 b=zIOaadzmwvrczzA65nIhK5X/AYblz1GJGOnsK+OtnNsfeKl3UlNLJpqjKcqV7VWNy452DyKcDtcMN+D/MJjWLvTsoVlVLFMLcjpxhbbdruSFuyFGieJAoRWqFEjcj0ioAEqM9cu7gOdIYXTSAJQTOJUBuww9I1R93hFmK6+KntawbJ4UQplwanOqtOZBSVD5lDhXbW+rnpqlhI0AvJH/xFAwWMqhkE8diXKpCrd5MoqLmRRpJ+wdGnwIzRozGMmvHDFqNYIT5bNDjd+p7KJYE3k/6z+D1Spfgot2u1ZLxuMC+2VStrI25f5GS9dXwhoFzLBN9VyZSu0bukuiZ8TkrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPRx1EL+Ory0wF/hWi8VLsusGaNBICYmIZFqW9JgFGA=;
 b=RJ48gdNjEfgb+c/UDLP4DLGQtW+Vyu6GiQQ6Ny9s8j3GxYHie5pg8Zj6tvdJBKX3cGg0N1kqsz4G0UjB7d7N+LkHrFscq9gKdanCFdAGg/yn+yMmafp/3bm6MM6y6Coyac5scr1DB98UW8DzH4dObLxZ122GXHgPMrETYhpObZxZ1N8XY98aSJko151izKQKdjO9FQsF8V843zjA+p6smwuqkQTX9IOFrVoTVR5zli2+ceIMRR6PSGzIeeY+qtxmoTR0mQquxFzg2uSRGxXeeNG7guzzXLCIujdpFhFQ9mDvvT0fblFtZcm9NvyfOaim2dpebHIJqUWfRSxxKDMxpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI2PR04MB11052.eurprd04.prod.outlook.com (2603:10a6:800:272::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 12:22:23 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 12:22:23 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 05/14] bap: Add support for syncing to multiple BISes
Date: Fri, 25 Oct 2024 15:21:37 +0300
Message-ID: <20241025122146.17925-6-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025122146.17925-1-iulia.tanasescu@nxp.com>
References: <20241025122146.17925-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0006.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::11) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI2PR04MB11052:EE_
X-MS-Office365-Filtering-Correlation-Id: ace94775-978f-4bd4-6bed-08dcf4efae33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pYsbFKMqwveXl16wrZcs9ThHqAjVSgobdQLrE3KrSOgFDpOxSgM2wWsg/iWY?=
 =?us-ascii?Q?uQGOqcotzaoxxbdwFBHzWrgM4nxpa6rGlT6HDZMs4P2vrMuNquGxCb7NXPW3?=
 =?us-ascii?Q?5O7jE++0baSQcQTsXnmKcXCgEuIwULuiHbIjHhz0ROLpjeMtR/oQeb3slrZc?=
 =?us-ascii?Q?App9jK4WC2ST6Ui6jxya7NsY1ea17j0eDx6Q15K87Ugn4xMqjohzGAsTVS4h?=
 =?us-ascii?Q?6NEHdN0j6mJHD3cqbtgnj9f4SLE15pGB8bGv0MKIqyp8UJ1fsID5hGONSob3?=
 =?us-ascii?Q?zDucf8+SKZvUk4LnfUErh6Lvnjgc61uG4VrIWVimoYkt81KkMFmtXZC44haz?=
 =?us-ascii?Q?mR4pqSAR9p7cR/aPAwfB/FXVcO/LIszb23kzxVz7LBU5wCdSGHEopPC6mALs?=
 =?us-ascii?Q?/SnKkYja80P5v8vjFbK4vgDRoWv/2Fpc+HVh9gSr8MaVFAHW1yR0CBuOx/5S?=
 =?us-ascii?Q?B1SyX86m5Tz99qtGHA1l0C5cf2ZMZIIWBDFOospC57OaQsKwNkf0cLAn3wkV?=
 =?us-ascii?Q?ACsRSmdnEZ+RMFBNlmdIgwj6iyucEUpuCLE4RU0gzGAY8958u95q5tbUFF+0?=
 =?us-ascii?Q?hURfRx+fVzte+THdEQgMWUCvptyhJIVfYQzBPCy5sWQKCTBnAGKb/lTp3JXm?=
 =?us-ascii?Q?8X/UK7Oe/3vhdnaBHbj+PIg/xf+eQbF1mfTaA9RRyZsOzZ8Ph6ClkQatngji?=
 =?us-ascii?Q?9vY86Dyc8VJ8WABY7mI4eTC4llTMoKCQV9HOnUrGVA94ali8gTobhWGyqqhI?=
 =?us-ascii?Q?bMzSmEIvxuDaNeTxYlWEPm73sFjNz8MX9+YAnNWsmfqKqbij174DtGxaAqj6?=
 =?us-ascii?Q?Zxz7CVawd6BTuyvbKoclse9Bhwy/hk78e3+Fr4FfWu62HwL7XiATemjDuJdU?=
 =?us-ascii?Q?lXFE2KlTxQGvtPKuVqhVAp0zbu1hcPH51Xw+etxPtNjM5jjc0okGfqDwkLoO?=
 =?us-ascii?Q?dUOhdj7vit0pekUwGimvbenD6N9jSdzlaaZVyUEeGcQikyDTZ0Z6M2HiUzIV?=
 =?us-ascii?Q?Xp7YvOFvX5Le7yhNsgJeK+CEG3DpJNh6+Nibt/SJ/ZZgfSAi4GNgPY+9Ua11?=
 =?us-ascii?Q?Asw3/YE5D4OQafXEoLLtHauFWTz3wRB4yQMjrkXNoScGVKQc5YFeP2xkmU4B?=
 =?us-ascii?Q?YgDLbJJWJvq/10IZ+eAfJL+/qmB/WpswS84Fj0nBbHjSXLCK7MB5FZF88s9S?=
 =?us-ascii?Q?UcGiG/XxobE+7CyR7eQ0M/s7suotHtnH61r73ElEI7wqymcCHN4WGHERy188?=
 =?us-ascii?Q?oauBAblcqZlwqKSf+iygD5lbSsVCZY2KFO514oU223iqkT74vSHuAoZ3BWIp?=
 =?us-ascii?Q?WNR8L1w2r5vy1v17/0yRPXnN+vf2JLbZpi5KNYlgsngw3ghCJ11NQp8Kk7sU?=
 =?us-ascii?Q?anAvofE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N/Z2pTsuzhNXudVA8jbLOnJ/QM/8qtywXZu6S9+oT7ATVJUlqdLpaDKys2Ip?=
 =?us-ascii?Q?LvVS9UUbFrJWZMPrlBtQlG56O0ZU43c+hGhSnMkkYZngpQGODrA+YqLAWiti?=
 =?us-ascii?Q?eHiZsQVrra3zEMIAGMKObuUhE9raVVNkfZCvrMQPAgBidJ3XSjUB3OGr6/9e?=
 =?us-ascii?Q?x8ecy3EzgtiHlCIO4TkT5EQsddWnnPQSk6jL19LsAcgCRbf7DKu7NUjDjs3Z?=
 =?us-ascii?Q?Fey1pacfmR0ZhpZ8c2/IIvSEDPLhjkeUTwvgbMkA0uk/46hZiGWEAp+aJVVx?=
 =?us-ascii?Q?sxKmNusc3yVh48TYG+wdnm3tdXi3JHwtVyXqGGsiTa7GQfiNpfURep1mu2fE?=
 =?us-ascii?Q?0s+KRHkn322cj+cZSzi0WmYKkMEGDNHBDcIM8Nv6nm9BIFsCrD7sN7NyWQcG?=
 =?us-ascii?Q?SfUWrpR6DZli4TrHroUMDABECZ9r3fJu2GFJhtPVDW2kii33tXqsx/ipdrYk?=
 =?us-ascii?Q?xKx878XigVcYTxhPGjTdIpvQcV+M0akfuDMCPLOYQbawCMyTcNC0/533cA6i?=
 =?us-ascii?Q?lK+M0Q1uaCULLodjNwrLpwz5u+RhovhKfKGBjIVQ3tfLWY/as4oT7bdD7rZ2?=
 =?us-ascii?Q?R+vola0/Dcuf8aCQ+cUVihL6+l44NOGNZLVFOfybvi8ToAFT4vcVbleLHyon?=
 =?us-ascii?Q?4UMBDON6L+2KFyRftDotcW1RhmphYnrw65mH4X0LxHaxV5kNsYpahBx1fDdu?=
 =?us-ascii?Q?1WW01Cs4fQY6HgZddQDcf2EwickxKopj2IAsWUzKZOgKIXReVy9Qe/dpDETo?=
 =?us-ascii?Q?uOX7XGAzI3MFWQPab0tXsv7JnbTGWYhqzJa8h0+dQE+8FollRtk2JOpph0lh?=
 =?us-ascii?Q?0yHcTuSKSW40pnORqtiXmdWIzrTzh35t1h/0yE2co832eRZphtabfDXSNK5N?=
 =?us-ascii?Q?MIczYGranWQatL4/7zfX1g0v6f6GD9Ovs16bylR63/XkNcM1eg7xBw5BDNMg?=
 =?us-ascii?Q?pGgd0ccC5ZXllrwQ5sYC+0s5wIY7YoO3FP3IaycjrTrZnTeYqK45elKKahGy?=
 =?us-ascii?Q?s0F4JtO3aE0G0AU/9QNCxtogVzsIWwsQZhB8I8q3VGPY6lT3Nqi+zRfNKWdQ?=
 =?us-ascii?Q?nGMHe+h8Z/eD0d9mGG6qvryIBIdzOS0IU8TuvZtfHVcPv4k8yhgyXRkwHd7D?=
 =?us-ascii?Q?daspkQra5SYem9JyHPWd3lbbcXr57T9VLP7tmFtYFUknX5txymimklKS5Jae?=
 =?us-ascii?Q?8GMVFXlVnREnZW+QkT6dviO0FpeGlf4ZrXEZvY9aJQMC4IMzKfMSECT81xqH?=
 =?us-ascii?Q?1tVSl3RWaqax9I9+/g98CdLw8GUuWcf2kX4ZcwzW4m+KNfSijiEvozQyNOuY?=
 =?us-ascii?Q?jp5/1APTt1WHwprz6ODGzzYmHgdxzeuVcBu6waiXKftfglXCfGV1DuHclWsE?=
 =?us-ascii?Q?c64ec5IEBxMwSLSh6cpJ3AyJMMcNlu0UmrKW0vmEo6Ak/VgK/y9JVMfIpgMt?=
 =?us-ascii?Q?iRTrqFhmtlVEangHpaJfzLlGZKCir0y97OliNoNRiFzPGD2b6xgdyBpz3Yg1?=
 =?us-ascii?Q?ZxvFzICi6qz7siGcZQ2ZpCEQuLalKgIKeWzWoNHuIfiFh+XL14OLk3Ytrt25?=
 =?us-ascii?Q?cbEpXvsyi6u8R3FFLW6UVtDsurt3hk47iiQwlW6+CEOXkgSumNaPjVqAurfB?=
 =?us-ascii?Q?gw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace94775-978f-4bd4-6bed-08dcf4efae33
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 12:22:23.8436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hPS37u9KP62fqHCzawxlltoksUjJHjVTHUerdW2+AGaoRcn+tSXWlyXVIcudZp1gKdMmYeNxOaNEJpX48Zsi9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11052

This adds support for a Broadcast Sink to synchronize to multiple BISes
from a Source.

BISes selected by the user need to be linked together and then enabled one
by one. The first enabled stream will enqueue all its links in a request
for PA and BIG sync. After BIG sync is established, the confirm callback
will be called for each BIS io created in the kernel. Each fd will be set
inside the corresponding link, even the links that have not yet been
enabled. The enabled links will be started as soon as the fds are ready.
---
 profiles/audio/bap.c | 171 +++++++++++++++++++++++++++----------------
 1 file changed, 109 insertions(+), 62 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 81e1fb03e..df685c6d3 100644
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
@@ -2684,9 +2718,19 @@ static void bap_state_bcast_sink(struct bt_bap_stream *stream,
 		 * the upper layer process requires the stream to start
 		 * receiving audio. This state is used to differentiate
 		 * between all configured streams and the ones that have
-		 * been enabled by the upper layer. Create stream io.
+		 * been enabled by the upper layer.
+		 *
+		 * Create stream io if not already created and if no
+		 * link has been enabled or started.
+		 *
+		 * The first enabled link will create and set fds for
+		 * all links.
 		 */
-		setup_create_io(data, setup, stream, defer);
+		if (!bt_bap_stream_get_io(stream) &&
+			!queue_find(bt_bap_stream_io_get_links(stream),
+							link_enabled, NULL))
+			setup_create_io(data, setup, stream, defer);
+
 		break;
 	}
 }
@@ -3050,63 +3094,69 @@ static int pa_sync(struct bap_bcast_pa_req *req)
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
@@ -3148,10 +3198,7 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 static void pa_and_big_sync(struct bap_bcast_pa_req *req)
 {
 	GError *err = NULL;
-	struct bap_setup *setup = req->data.setup;
-	struct bt_bap *bt_bap = bt_bap_stream_get_session(setup->stream);
-	struct btd_service *btd_service = bt_bap_get_user_data(bt_bap);
-	struct bap_data *bap_data = btd_service_get_user_data(btd_service);
+	struct bap_data *bap_data = req->bap_data;
 
 	req->in_progress = TRUE;
 
@@ -3166,7 +3213,7 @@ static void pa_and_big_sync(struct bap_bcast_pa_req *req)
 	}
 
 	DBG("Create PA sync with this source");
-	setup->io = bt_io_listen(NULL, iso_do_big_sync, req,
+	req->io = bt_io_listen(NULL, iso_do_big_sync, req,
 			NULL, &err,
 			BT_IO_OPT_SOURCE_BDADDR,
 			btd_adapter_get_address(bap_data->adapter->adapter),
@@ -3177,7 +3224,7 @@ static void pa_and_big_sync(struct bap_bcast_pa_req *req)
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

