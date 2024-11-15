Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2069.outbound.protection.outlook.com [40.107.103.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1891B4F0D
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731667139; cv=fail; b=DIiYuJdqq8jZ9ay1kwdJoJqzdc3oo5pAscqYZlvjnjmDsRgYuH9gdn0ZnZ6bE/iU108ZICvN1BY05laoyAbBLB3zSGsm2TYKVKr9AOZDNTnyt28us3FXJRvK6QF+WQ9MrclFeYtav0NFV0hSN3Zp/reBOLMCY6vbtCfuQ7jvVN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731667139; c=relaxed/simple;
	bh=DaEyLzGrhJKD5UOukuCqfbFY+vb5x4iXX3w7Ro/bBnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MqPS4KmveurK1XTqN93MaR4KLpHV3f/Wo803niJjJbUWFZvTG2v5V9KCc5rXoYnY3/W01RJ+EU+tbHIDSulLHk01LOLxde52rD3vGvK5I3X+La9h8uH/GG09HuctKOLjQ7xT72VmqK/4lWA0U1ywj0ZoEjJeRLtJ8SDOyO0Hd7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P625B4xK; arc=fail smtp.client-ip=40.107.103.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P625B4xK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BabBo9f4KUtSE6WG1qKfDavRSL7tspdcRdx65L5dVJ4N9PQJ/zbke3gnF1/ZXy8Smrc6acVczpy55mGXFzbHrC0FoftPdTgdwqWnIVMYF7YcpwJdtocvhug3qVqDgHJTwtE1wG6CCZnRlpgFIvgpG1exmXrQVFf3DiSOHJIAVTJQelTh/gnA0v3OhLlJ3aCWRpl6vekvWfOva+DnUkrjdGmiWJDxXCeOyDIAca67zTZwFYuCGYdy+bZmf+Xu5WpqJyC7lKQP3E8oNk5ClzUNSsa3szAr4+5G/Mr/A5TkM3p/SsJ32DMzqTQTZAbNQwJdigUObnagBvzoNm2cVfzgUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyUGRdJgN2J8d/rVi2mbRLQ+UUB/Xe8ctafwKJyA4M4=;
 b=gZe3osiTqHCgU80Um9U9CUVCGzpC/OeoMvcsJCP8z6PD0qgW/XGB5j/5q/r7K8FWNnAwtL5XSYXi/XZy1KGqzyeC6eu4ziVuJLQyuvG3XZpx0Ckmg4Lua94Jxtre4CqgzzxdfKcf3PpI5+Jy4FQ+Q0/opiDxkmVhN1HjXhepSVK0CASYCJXUw4ePGcW9lkPTA/2CLOOW06MLYK1oqHLL/rIYHuXd4zh0DT2iZNeCI6xvEBD7rlw/LLEz4wV+4+fCKO2YGOytSPd1pb6mrtfcXzOjjVNt4R/2zdbjMHHpj3bD/p5GxdAIq1zTYoswUXeCr4mQBjnSTcB73+Taez2A+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyUGRdJgN2J8d/rVi2mbRLQ+UUB/Xe8ctafwKJyA4M4=;
 b=P625B4xKxfWGJTpy8HGASpx0oGzh57ZC+RE4+VK4oLb6JorxudbgNqss3aFr4rGqX2zwhD768zHbFfPeFAbQVx8huwL+GguFvYf/hNJc0XidC4rLAducv4Av8XL7jRAAD1GNYrfl/V4DZeDDXvOvF0nUFKdYSnxzngbs2yM5fguMLBeFxzR6Kaq5tpbgBvePg5aizQpFNi84njoTC6djRyzInelxiwURLCfaL3bhLFx9yVXKIu9Qdt9+/J+QsT9L4nUjD4GyDjT8/peQ8mExeHShYhXmuF/6W7W4bhJQ7ylhhpx+NH2v3vAUbWQo6KnWYImuzyT4Nby7g1hjZXSSUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM9PR04MB7714.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Fri, 15 Nov
 2024 10:38:51 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 10:38:51 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 6/6] bap: Remove PA idle timer logic
Date: Fri, 15 Nov 2024 12:38:24 +0200
Message-ID: <20241115103825.19761-7-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241115103825.19761-1-iulia.tanasescu@nxp.com>
References: <20241115103825.19761-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0001.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::8) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM9PR04MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c25b06-56b7-4604-6e5f-08dd0561b0f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GhPiyx1AHkk5jauABe+vXUsk2HvdtO0s8BO35fKQ1/C05U98GVex8yw1yvTz?=
 =?us-ascii?Q?ktRsVyFXp8TNYIq65xbcP6NHPsiAeM7K/L8nmwb/016enn6BIvyi2+TT0F0i?=
 =?us-ascii?Q?khfyKD2ZaXBCXnHOh0OIQTSz1sgVcQX9JjWlQj19/pvxU7ga/NUH9AJoTcOn?=
 =?us-ascii?Q?7+cCcvBhjcf7ScPo6jcLvw6GRa0y/EbUJKSLyEavKiXOeN48qCFMGmoUm3df?=
 =?us-ascii?Q?UZlgLUbPP2nGyY/4hPWwyrQoWiI8tmxvKRKgx5hKjm1OC48qvyGSMZ8s29m0?=
 =?us-ascii?Q?h43pHktHqSUbQ1r0Wzo6uQWryY/w7rs8AW05ugSIGu3H5e7D2iJPqKpLCJ6o?=
 =?us-ascii?Q?ZB5xI1w/MQK2vsZbC8+tEv7n+FOIGwBrT4lkSQh+Lb4+hE3BJn8TDwwQrQ1O?=
 =?us-ascii?Q?LPiub01Q8cKVq3lEGz+pkZpvjDxwh0h+ynja5ONsiBN15JhM57JjWMXlEPFD?=
 =?us-ascii?Q?+eJfn9msl8SLUJL51o9/eTV+kKm6M6j3KT4P9KmPo2zuEGoTC8mlA3fTcefy?=
 =?us-ascii?Q?2TXEXb9L+/iPNG1sfJGmRM4QR/NVBt4PtIdvoa21kxbX8KR9ZiC1xlaktX22?=
 =?us-ascii?Q?/ARbDT3RDjs84p3Uu+COvNyqWlFp/l7IVv14FUFGAQONu2t5CD090eKZr26S?=
 =?us-ascii?Q?sVZbuDLQcjAPz6E+F/McPQLMvnpH/XVG7EgdZJC3uoPqS9cZa6egyQR5A+0t?=
 =?us-ascii?Q?2kbr2klLY5fNKI8lAp/QGTG2RB477hUBMy+jVEqEqaObTH2jOEdTgO4E2O8n?=
 =?us-ascii?Q?9sqjB0t4V5Ae6s/YpUyb1ubXkGa37DSKmDnRSeuHlx/d344VIuYlFDinbcxY?=
 =?us-ascii?Q?9fWL2Y3dUtmvk3nj+cTcKVca+egYwR3ByTRWH/RdK1goZVP32jib7H5g3cpY?=
 =?us-ascii?Q?BSJA96AN9GkZbZ/XiQM0LSc25wzmdHToCuHCqeypKL2Kd/Pndy/ZFc4xKxtz?=
 =?us-ascii?Q?hFUi8Ht/AfzOgctQ/kB7zJBNOxtEUD1WwibthMuwCS6uEvRSNi3Hndhqv9LH?=
 =?us-ascii?Q?Q8+6K6ijCYw8oWtFd9/9k0b4sGWQZ2uPZ6gV0pF7nd7Axz8vMqJhG94DSjJI?=
 =?us-ascii?Q?KSEuKn7sYmzAMwvBLe6nMfVrAa04I/DVYcO/VZ9yoZQaec4qIJzD54F0iqGw?=
 =?us-ascii?Q?c0+ML9cZFzJD7GhsELL1D6rKToelxyqOmNgF7yama+9jHoeyXWaEZs9WSCu3?=
 =?us-ascii?Q?WTgq39Lq5idlviySmGJCddB0US8/uJ/CydofhkzPqNbSb0aZu/8cgL2B7qoL?=
 =?us-ascii?Q?q7tMd4cecE44jURXgMK6/8UcYUt+/oPiTAHEdfhjHpkUeM62XYU4gkAjN6DN?=
 =?us-ascii?Q?QJB207Hco2Px354xPsC/Si4M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tbb6HNU809tkEF/g+nSFboW9DwgQoBbXTjoPBc6Ugb5xuB0IfWf0sGLAfz4x?=
 =?us-ascii?Q?7RgLPx3N4/THdXCEBIwoXaKwt8zlDqdYsR0iGq1V5O2qDaM1B9GJ+JwfiL4L?=
 =?us-ascii?Q?ZcRQwvjVnQRz4TWgop9oa9cI4ZAGnNOOVX6li87ObY44Tk3mElEneFCtjSEJ?=
 =?us-ascii?Q?NPAh8r7FnrK80c9G25J3yJEHDYYbqzRQQiAmBbL14+Kj3lcb4JgiC2qGlUE6?=
 =?us-ascii?Q?v4v+eEZ2GDs7Ir9HsIkFt23Mq8br0aWCcQxVyUNzT3No+EEd2y+6oL/G6WEe?=
 =?us-ascii?Q?/0QXj5tBHRnQYjkemKJzQpw9q3c3/w0vUEqxBWhs/l2mgpWXKv2XA/etyBrZ?=
 =?us-ascii?Q?iks+JfiWNas76mS866vLmHNva2873HfTdjztB8Dn+urMW8kSjv33kn+NIVLm?=
 =?us-ascii?Q?h9Z6uuQzK1A4C1e5UOX1VG9nflCnmxKmefxHOJIDjadanYLwJy2WX6PluytI?=
 =?us-ascii?Q?VH27tEtQ9lfVAm25Plm2gsms/VegjgDhLK2Ql5qEwTHuUM5HeLGFmtn3+kUw?=
 =?us-ascii?Q?Q9/O8PBy5LnCkyHzFel1Nr1WLfZfBl8/eYp2/Hn6uqmgbNQBQZxRgh9c+Ict?=
 =?us-ascii?Q?P0CyK/teXOHSx4ugafFgTEqHOpuLPzRS4N8lO3Bhxf2d0dBxcJar6Tal1i7R?=
 =?us-ascii?Q?zRUtjMmNvT1ZcPtv7zF/URk7f50KjEV1bm15cRzAkb6k+sixcKcX37Iqduhj?=
 =?us-ascii?Q?LJKV5qakxUFj7qcXqIGZRq3AkwhWdzFDykPDSQDFQtgCF8jEtMH7a++ns+uU?=
 =?us-ascii?Q?2LVu7Y/Hs7wgA77/qXLcB69HTFKDBTOjvUOWnXrJVyGP88z0OdVT/BNFhCSl?=
 =?us-ascii?Q?GbssNNAXXNDJPYuA34wURwZMeiSr19WPhRDcE60Y0dUUGO7SIHsaHsEy1eDx?=
 =?us-ascii?Q?btiEzl0uW/wlIrnH/FrBMTwV8BOIaQ93cxNrH7RKrAO7B1gQZeIOn1f+m17l?=
 =?us-ascii?Q?zMxd0gsQo5G2f1LZNjlPc226oPpHGVB29Vy1IAhzspDAYXWH3+1ftr6qsOCB?=
 =?us-ascii?Q?oFt/0B4c8CA6deP9gkuOakoiSLdvfH3BhnnDPgDsQZVi3zt3PSBiiLIxGPrH?=
 =?us-ascii?Q?UEgfvu+vT4+miaBQRn1Vwr4q2/4pTRFyTNvAlc2/6a1a452O34P6+r4GnqMk?=
 =?us-ascii?Q?wSXE55dZp2DakbXrFBd5RCpruL2dPAR1r3bhIAXjzaN1QYmWyA0yWLS17I3M?=
 =?us-ascii?Q?Tms8cyqkA4xNdWjHs7HROR9pRxcmbEBsbOSG8cYKsA/tK1ZZzJbYeRYH9wvu?=
 =?us-ascii?Q?jsS6piPV9hq0QnkzmaS0YU8w+ss+P0xYG+ZdQdXonEJ+f771FG0Nca/DmAzl?=
 =?us-ascii?Q?qInA+/vJxAJv+pCvS7mlwxVUli+DdqJpjG7I5X2S3J1QFge9RGFpRFI2cgra?=
 =?us-ascii?Q?jglk6cfsUsEIJVl8to4VK6x7FHe03FW3kpApgbu0CHwQugCMl5bYL6OBKclh?=
 =?us-ascii?Q?ODevIIrH37jwg3EAptEGWp47uI+MgJOJ6JjREXcs0kvxvXh3RFPqPKmwkahm?=
 =?us-ascii?Q?QvALxO2Y5XN/4h1POBpj95La39OJzbTLnJDCm/g/moAljoIwhHo/4FWJaG5r?=
 =?us-ascii?Q?MrtnJLbF4NtGDDlgq+v+I30k5/wc/ymVl3llFaNhEVPwt9FnRMxxYo2EpF8a?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c25b06-56b7-4604-6e5f-08dd0561b0f3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 10:38:49.8636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qz6SHmEJn3O7ATS2BI/+l9w9ZhmF7bYVD0h/1+pDCWDcN/N3RjrjGhO3kUgVYZYMNM/4Z2+bbuwUWzx8c0POnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7714

This removes BAP support for long-lived PA sync (added for Scan Delegator
support), since it is now handled inside the BASS plugin. This also
removes the PA idle timer logic, since PA/BIG sync requests are now
ordered inside the kernel.
---
 profiles/audio/bap.c | 368 ++++++++++---------------------------------
 1 file changed, 80 insertions(+), 288 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index beab85cff..e927a4404 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -65,15 +65,9 @@
 #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
 #define MEDIA_INTERFACE "org.bluez.Media1"
 
-/* Periodic advertisments are performed by an idle timer, which,
- * at every tick, checks a queue for pending PA requests.
- * When there is no pending requests, an item is popped from the
- * queue, marked as pending and then it gets processed.
- */
-#define PA_IDLE_TIMEOUT 2
-
 struct bap_setup {
 	struct bap_ep *ep;
+	struct bap_data *data;
 	struct bt_bap_stream *stream;
 	struct bt_bap_qos qos;
 	int (*qos_parser)(struct bap_setup *setup, const char *key, int var,
@@ -101,15 +95,9 @@ struct bap_ep {
 	struct queue *setups;
 };
 
-struct bap_adapter {
-	struct btd_adapter *adapter;
-	unsigned int pa_timer_id;
-	struct queue *bcast_pa_requests;
-};
-
 struct bap_data {
 	struct btd_device *device;
-	struct bap_adapter *adapter;
+	struct btd_adapter *adapter;
 	struct btd_service *service;
 	struct bt_bap *bap;
 	unsigned int ready_id;
@@ -121,30 +109,12 @@ struct bap_data {
 	struct queue *bcast_snks;
 	struct queue *streams;
 	GIOChannel *listen_io;
+	unsigned int io_id;
 	int selecting;
 	void *user_data;
 };
 
-enum {
-	BAP_PA_SHORT_REQ = 0,	/* Request for short PA sync */
-	BAP_PA_LONG_REQ,	/* Request for long PA sync */
-	BAP_PA_BIG_SYNC_REQ,	/* Request for PA Sync and BIG Sync */
-};
-
-struct bap_bcast_pa_req {
-	uint8_t type;
-	bool in_progress;
-	struct bap_data *bap_data;
-	union {
-		struct btd_service *service;
-		struct queue *setups;
-	} data;
-	unsigned int io_id;	/* io_id for BIG Info watch */
-	GIOChannel *io;
-};
-
 static struct queue *sessions;
-static struct queue *adapters;
 
 /* Structure holding the parameters for Periodic Advertisement create sync.
  * The full QOS is populated at the time the user selects and endpoint and
@@ -219,6 +189,9 @@ static void bap_data_free(struct bap_data *data)
 		g_io_channel_unref(data->listen_io);
 	}
 
+	if (data->io_id)
+		g_source_remove(data->io_id);
+
 	if (data->service) {
 		btd_service_set_user_data(data->service, NULL);
 		bt_bap_set_user_data(data->bap, NULL);
@@ -382,7 +355,7 @@ static gboolean get_device(const GDBusPropertyTable *property,
 	const char *path;
 
 	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE)
-		path = adapter_get_path(ep->data->adapter->adapter);
+		path = adapter_get_path(ep->data->adapter);
 	else
 		path = device_get_path(ep->data->device);
 
@@ -996,12 +969,19 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
+static bool stream_io_unset(const void *data, const void *user_data)
+{
+	struct bt_bap_stream *stream = (struct bt_bap_stream *)data;
+
+	return !bt_bap_stream_get_io(stream);
+}
+
 static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 {
-	struct bap_bcast_pa_req *req = user_data;
-	struct bap_setup *setup;
+	struct bap_setup *setup = user_data;
+	struct bt_bap_stream *stream = setup->stream;
 	int fd;
-	struct bap_data *bap_data = req->bap_data;
+	struct bap_data *bap_data = setup->data;
 
 	DBG("BIG Sync completed");
 
@@ -1009,28 +989,23 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 	 * to the order of the BISes that were enqueued before
 	 * calling bt_io_bcast_accept.
 	 */
-	setup = queue_pop_head(req->data.setups);
-
-	if (queue_isempty(req->data.setups)) {
-		/* All fds have been notified. Mark service as connected. */
-		btd_service_connecting_complete(bap_data->service, 0);
-
-		if (req->io) {
-			g_io_channel_unref(req->io);
-			g_io_channel_shutdown(req->io, TRUE, NULL);
-			req->io = NULL;
-		}
-
-		queue_remove(bap_data->adapter->bcast_pa_requests, req);
-		queue_destroy(req->data.setups, NULL);
-		free(req);
-	}
+	if (bt_bap_stream_get_io(stream))
+		stream = queue_find(bt_bap_stream_io_get_links(stream),
+				stream_io_unset, NULL);
 
 	fd = g_io_channel_unix_get_fd(io);
 
-	if (bt_bap_stream_set_io(setup->stream, fd)) {
+	if (bt_bap_stream_set_io(stream, fd))
 		g_io_channel_set_close_on_unref(io, FALSE);
-		return;
+
+	if (!queue_find(bt_bap_stream_io_get_links(stream),
+				stream_io_unset, NULL)) {
+		/* All fds have been notified. Mark service as connected. */
+		btd_service_connecting_complete(bap_data->service, 0);
+
+		g_io_channel_unref(bap_data->listen_io);
+		g_io_channel_shutdown(bap_data->listen_io, TRUE, NULL);
+		bap_data->listen_io = NULL;
 	}
 }
 
@@ -1099,6 +1074,7 @@ static void create_stream_for_bis(struct bap_data *bap_data,
 	struct bap_setup *setup;
 
 	setup = setup_new(NULL);
+	setup->data = bap_data;
 
 	/* Create BAP QoS structure */
 	bap_iso_qos_to_bap_qos(qos, &setup->qos);
@@ -1280,8 +1256,7 @@ static gboolean big_info_report_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
 	GError *err = NULL;
-	struct bap_bcast_pa_req *req = user_data;
-	struct bap_data *data = btd_service_get_user_data(req->data.service);
+	struct bap_data *data = user_data;
 	struct bt_iso_base base;
 	struct bt_iso_qos qos;
 
@@ -1295,7 +1270,7 @@ static gboolean big_info_report_cb(GIOChannel *io, GIOCondition cond,
 		error("%s", err->message);
 		g_error_free(err);
 		g_io_channel_shutdown(io, TRUE, NULL);
-		req->io_id = 0;
+		data->io_id = 0;
 		return FALSE;
 	}
 
@@ -1304,41 +1279,31 @@ static gboolean big_info_report_cb(GIOChannel *io, GIOCondition cond,
 	g_io_channel_unref(data->listen_io);
 	data->listen_io = NULL;
 
-	if (req->type == BAP_PA_LONG_REQ) {
-		/* If long-lived PA sync was requested, keep a reference
-		 * to the PA sync io to keep the sync active.
-		 */
-		data->listen_io = io;
-		g_io_channel_ref(io);
-	} else {
-		/* For short-lived PA, the sync is no longer needed at
-		 * this point, so the io can be closed.
-		 */
-		g_io_channel_shutdown(io, TRUE, NULL);
-	}
+	/* For short-lived PA, the sync is no longer needed at
+	 * this point, so the io can be closed.
+	 */
+	g_io_channel_shutdown(io, TRUE, NULL);
 
 	/* Analyze received BASE data and create remote media endpoints for each
 	 * BIS matching our capabilities
 	 */
 	parse_base(&base, &qos, bap_debug, bis_handler, data);
 
-	service_set_connecting(req->data.service);
+	service_set_connecting(data->service);
 
-	queue_remove(data->adapter->bcast_pa_requests, req);
-	req->io_id = 0;
-	free(req);
+	data->io_id = 0;
 
 	return FALSE;
 }
 
 static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
 {
-	struct bap_bcast_pa_req *req = user_data;
+	struct bap_data *data = user_data;
 	/* PA Sync was established, wait for BIG Info report so that the
 	 * encryption flag is also available.
 	 */
 	DBG("PA Sync done");
-	req->io_id = g_io_add_watch(io, G_IO_OUT, big_info_report_cb,
+	data->io_id = g_io_add_watch(io, G_IO_OUT, big_info_report_cb,
 								user_data);
 }
 
@@ -1393,7 +1358,7 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 					struct bt_bap_pac *lpac,
 					struct bt_bap_pac *rpac)
 {
-	struct btd_adapter *adapter = data->adapter->adapter;
+	struct btd_adapter *adapter = data->adapter;
 	struct btd_device *device = data->device;
 	struct bap_ep *ep;
 	struct queue *queue;
@@ -2240,95 +2205,13 @@ static void setup_listen_io(struct bap_data *data, struct bt_bap_stream *stream,
 	data->listen_io = io;
 }
 
-static void check_pa_req_in_progress(void *data, void *user_data)
-{
-	struct bap_bcast_pa_req *req = data;
-
-	if (req->in_progress == TRUE)
-		*((bool *)user_data) = TRUE;
-}
-
-static int pa_sync(struct bap_bcast_pa_req *req);
-static void pa_and_big_sync(struct bap_bcast_pa_req *req);
-
-static gboolean pa_idle_timer(gpointer user_data)
-{
-	struct bap_adapter *adapter = user_data;
-	struct bap_bcast_pa_req *req;
-	bool in_progress = FALSE;
-
-	/* Handle timer if no request is in progress */
-	queue_foreach(adapter->bcast_pa_requests, check_pa_req_in_progress,
-			&in_progress);
-	if (in_progress == FALSE) {
-		req = queue_peek_head(adapter->bcast_pa_requests);
-		if (req != NULL)
-			switch (req->type) {
-			case BAP_PA_SHORT_REQ:
-				DBG("do short lived PA Sync");
-				pa_sync(req);
-				break;
-			case BAP_PA_LONG_REQ:
-				DBG("do long lived PA Sync");
-				pa_sync(req);
-				break;
-			case BAP_PA_BIG_SYNC_REQ:
-				DBG("do PA Sync and BIG Sync");
-				pa_and_big_sync(req);
-				break;
-			}
-		else {
-			/* pa_req queue is empty, stop the timer by returning
-			 * FALSE and set the pa_timer_id to 0. This will later
-			 * be used to check if the timer is active.
-			 */
-			adapter->pa_timer_id = 0;
-			return FALSE;
-		}
-	}
-
-	return TRUE;
-}
+static int pa_sync(struct bap_data *data);
+static void pa_and_big_sync(struct bap_setup *setup);
 
 static void setup_accept_io_broadcast(struct bap_data *data,
 					struct bap_setup *setup)
 {
-	struct bap_bcast_pa_req *req = new0(struct bap_bcast_pa_req, 1);
-	struct bap_adapter *adapter = data->adapter;
-	struct queue *links = bt_bap_stream_io_get_links(setup->stream);
-	const struct queue_entry *entry;
-
-	/* Timer could be stopped if all other requests were treated.
-	 * Check the state of the timer and turn it on so that this request
-	 * can also be treated.
-	 */
-	if (adapter->pa_timer_id == 0)
-		adapter->pa_timer_id = g_timeout_add_seconds(PA_IDLE_TIMEOUT,
-								pa_idle_timer,
-								adapter);
-
-	/* Add this request to the PA queue.
-	 * We don't need to check the queue here, as we cannot have
-	 * BAP_PA_BIG_SYNC_REQ before a short PA (BAP_PA_SHORT_REQ)
-	 */
-	req->type = BAP_PA_BIG_SYNC_REQ;
-	req->in_progress = FALSE;
-	req->bap_data = data;
-
-	req->data.setups = queue_new();
-
-	/* Enqueue all linked setups to the request */
-	queue_push_tail(req->data.setups, setup);
-
-	for (entry = queue_get_entries(links); entry;
-							entry = entry->next) {
-		struct bt_bap_stream *stream = entry->data;
-
-		queue_push_tail(req->data.setups,
-				bap_find_setup_by_stream(data, stream));
-	}
-
-	queue_push_tail(adapter->bcast_pa_requests, req);
+	pa_and_big_sync(setup);
 }
 
 static void setup_create_ucast_io(struct bap_data *data,
@@ -3083,10 +2966,8 @@ static void bap_detached(struct bt_bap *bap, void *user_data)
 	bap_data_remove(data);
 }
 
-static int pa_sync(struct bap_bcast_pa_req *req)
+static int pa_sync(struct bap_data *data)
 {
-	struct btd_service *service = req->data.service;
-	struct bap_data *data = btd_service_get_user_data(service);
 	GError *err = NULL;
 
 	if (data->listen_io) {
@@ -3095,13 +2976,13 @@ static int pa_sync(struct bap_bcast_pa_req *req)
 	}
 
 	DBG("Create PA sync with this source");
-	req->in_progress = TRUE;
-	data->listen_io = bt_io_listen(NULL, iso_pa_sync_confirm_cb, req,
+
+	data->listen_io = bt_io_listen(NULL, iso_pa_sync_confirm_cb, data,
 		NULL, &err,
 		BT_IO_OPT_SOURCE_BDADDR,
-		btd_adapter_get_address(data->adapter->adapter),
+		btd_adapter_get_address(data->adapter),
 		BT_IO_OPT_SOURCE_TYPE,
-		btd_adapter_get_address_type(data->adapter->adapter),
+		btd_adapter_get_address_type(data->adapter),
 		BT_IO_OPT_DEST_BDADDR,
 		device_get_address(data->device),
 		BT_IO_OPT_DEST_TYPE,
@@ -3119,9 +3000,9 @@ static int pa_sync(struct bap_bcast_pa_req *req)
 
 static void append_setup(void *data, void *user_data)
 {
-	struct bap_setup *setup = data;
+	struct bt_bap_stream *stream = data;
 	struct sockaddr_iso_bc *addr = user_data;
-	char *path = bt_bap_stream_get_user_data(setup->stream);
+	char *path = bt_bap_stream_get_user_data(stream);
 	int bis = 1;
 	int s_err;
 	const char *strbis = NULL;
@@ -3146,39 +3027,36 @@ static void append_setup(void *data, void *user_data)
 
 static void setup_refresh_qos(void *data, void *user_data)
 {
-	struct bap_setup *setup = data;
+	struct bt_bap_stream *stream = data;
+	struct bap_data *bap_data = user_data;
+	struct bap_setup *setup = bap_find_setup_by_stream(bap_data, stream);
 
-	setup->qos = *bt_bap_stream_get_qos(setup->stream);
+	setup->qos = *bt_bap_stream_get_qos(stream);
 }
 
 static void iso_do_big_sync(GIOChannel *io, void *user_data)
 {
 	GError *err = NULL;
-	struct bap_bcast_pa_req *req = user_data;
-	struct queue *setups = req->data.setups;
-	struct bap_setup *setup = queue_peek_head(setups);
-	struct bap_data *data = req->bap_data;
+	struct bap_setup *setup = user_data;
+	struct bap_data *data = setup->data;
 	struct sockaddr_iso_bc iso_bc_addr = {0};
 	struct bt_iso_qos qos;
+	struct queue *links = bt_bap_stream_io_get_links(setup->stream);
 
 	DBG("PA Sync done");
 
-	if (req->io) {
-		g_io_channel_unref(req->io);
-		g_io_channel_shutdown(req->io, TRUE, NULL);
-		req->io = io;
-		g_io_channel_ref(req->io);
-	}
-
-	iso_bc_addr.bc_bdaddr_type = btd_device_get_bdaddr_type(data->device);
-	memcpy(&iso_bc_addr.bc_bdaddr, device_get_address(data->device),
-			sizeof(bdaddr_t));
+	g_io_channel_unref(data->listen_io);
+	g_io_channel_shutdown(data->listen_io, TRUE, NULL);
+	data->listen_io = io;
+	g_io_channel_ref(data->listen_io);
 
 	/* Append each linked BIS to the BIG sync request */
-	queue_foreach(setups, append_setup, &iso_bc_addr);
+	append_setup(setup->stream, &iso_bc_addr);
+	queue_foreach(links, append_setup, &iso_bc_addr);
 
 	/* Refresh qos stored in setups */
-	queue_foreach(setups, setup_refresh_qos, NULL);
+	setup->qos = *bt_bap_stream_get_qos(setup->stream);
+	queue_foreach(links, setup_refresh_qos, data);
 
 	/* Set the user requested QOS */
 	bap_qos_to_iso_qos(&setup->qos, &qos);
@@ -3192,7 +3070,7 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 
 	if (!bt_io_bcast_accept(io,
 			iso_bcast_confirm_cb,
-			req, NULL, &err,
+			setup, NULL, &err,
 			BT_IO_OPT_ISO_BC_NUM_BIS,
 			iso_bc_addr.bc_num_bis, BT_IO_OPT_ISO_BC_BIS,
 			iso_bc_addr.bc_bis, BT_IO_OPT_INVALID)) {
@@ -3201,28 +3079,16 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 	}
 }
 
-static void pa_and_big_sync(struct bap_bcast_pa_req *req)
+static void pa_and_big_sync(struct bap_setup *setup)
 {
 	GError *err = NULL;
-	struct bap_data *bap_data = req->bap_data;
-
-	req->in_progress = TRUE;
-
-	if (bap_data->listen_io) {
-		/* If there is an active listen io for the BAP session
-		 * with the Broadcast Source, it means that PA sync is
-		 * already established. Go straight to establishing BIG
-		 * sync.
-		 */
-		iso_do_big_sync(bap_data->listen_io, req);
-		return;
-	}
+	struct bap_data *bap_data = setup->data;
 
 	DBG("Create PA sync with this source");
-	req->io = bt_io_listen(NULL, iso_do_big_sync, req,
+	bap_data->listen_io = bt_io_listen(NULL, iso_do_big_sync, setup,
 			NULL, &err,
 			BT_IO_OPT_SOURCE_BDADDR,
-			btd_adapter_get_address(bap_data->adapter->adapter),
+			btd_adapter_get_address(bap_data->adapter),
 			BT_IO_OPT_DEST_BDADDR,
 			device_get_address(bap_data->device),
 			BT_IO_OPT_DEST_TYPE,
@@ -3230,26 +3096,17 @@ static void pa_and_big_sync(struct bap_bcast_pa_req *req)
 			BT_IO_OPT_MODE, BT_IO_MODE_ISO,
 			BT_IO_OPT_QOS, &bap_sink_pa_qos,
 			BT_IO_OPT_INVALID);
-	if (!req->io) {
+	if (!bap_data->listen_io) {
 		error("%s", err->message);
 		g_error_free(err);
 	}
 }
 
-static bool match_bap_adapter(const void *data, const void *match_data)
-{
-	struct bap_adapter *adapter = (struct bap_adapter *)data;
-
-	return adapter->adapter == match_data;
-}
-
 static int bap_bcast_probe(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
 	struct btd_adapter *adapter = device_get_adapter(device);
 	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
-	struct bap_bcast_pa_req *req;
-	uint8_t type = BAP_PA_LONG_REQ;
 	struct bap_data *data;
 	int ret = 0;
 
@@ -3258,27 +3115,10 @@ static int bap_bcast_probe(struct btd_service *service)
 		return -ENOTSUP;
 	}
 
-	data = queue_find(sessions, match_device, device);
-	if (data && data->service) {
-		error("Profile probed twice for the same device!");
-		return -EINVAL;
-	}
-
-	if (!data) {
-		data = bap_data_new(device);
-		data->device = device;
-		bap_data_add(data);
-
-		/* The Broadcaster was scanned autonomously,
-		 * so it should be probed short-lived.
-		 */
-		type = BAP_PA_SHORT_REQ;
-	}
-
+	data = bap_data_new(device);
 	data->service = service;
-	btd_service_set_user_data(service, data);
-
-	data->adapter = queue_find(adapters, match_bap_adapter, adapter);
+	data->adapter = adapter;
+	data->device = device;
 	data->bap = bt_bap_new(btd_gatt_database_get_db(database),
 			btd_gatt_database_get_db(database));
 	if (!data->bap) {
@@ -3286,9 +3126,6 @@ static int bap_bcast_probe(struct btd_service *service)
 		free(data);
 		return -EINVAL;
 	}
-
-	bt_bap_set_debug(data->bap, bap_debug, NULL, NULL);
-
 	data->bcast_snks = queue_new();
 
 	if (!bt_bap_attach(data->bap, NULL)) {
@@ -3296,6 +3133,8 @@ static int bap_bcast_probe(struct btd_service *service)
 		return -EINVAL;
 	}
 
+	bap_data_add(data);
+
 	data->ready_id = bt_bap_ready_register(data->bap, bap_ready, service,
 								NULL);
 	data->state_id = bt_bap_state_register(data->bap, bap_state_bcast_sink,
@@ -3309,36 +3148,15 @@ static int bap_bcast_probe(struct btd_service *service)
 		/* Return if probed device was handled inside BASS. */
 		return ret;
 
-	/* Start the PA timer if it hasn't been started yet */
-	if (data->adapter->pa_timer_id == 0)
-		data->adapter->pa_timer_id = g_timeout_add_seconds(
-							PA_IDLE_TIMEOUT,
-							pa_idle_timer,
-							data->adapter);
-
-	/* Enqueue this device advertisement so that we can create PA sync. */
-	DBG("enqueue service: %p", service);
-	req = new0(struct bap_bcast_pa_req, 1);
-	req->type = type;
-	req->in_progress = FALSE;
-	req->data.service = service;
-	queue_push_tail(data->adapter->bcast_pa_requests, req);
+	pa_sync(data);
 
 	return 0;
 }
 
-static bool match_service(const void *data, const void *match_data)
-{
-	struct bap_bcast_pa_req *req = (struct bap_bcast_pa_req *)data;
-
-	return req->data.service == match_data;
-}
-
 static void bap_bcast_remove(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
 	struct bap_data *data;
-	struct bap_bcast_pa_req *req;
 	char addr[18];
 
 	ba2str(device_get_address(device), addr);
@@ -3349,17 +3167,6 @@ static void bap_bcast_remove(struct btd_service *service)
 		error("BAP service not handled by profile");
 		return;
 	}
-	/* Remove the corresponding entry from the pa_req queue. Any pa_req that
-	 * are in progress will be stopped by bap_data_remove which calls
-	 * bap_data_free.
-	 */
-	req = queue_remove_if(data->adapter->bcast_pa_requests,
-						match_service, service);
-	if (req && req->io_id) {
-		g_source_remove(req->io_id);
-		req->io_id = 0;
-	}
-	free(req);
 
 	/* Notify the BASS plugin about the removed session. */
 	bass_bcast_remove(device);
@@ -3501,13 +3308,7 @@ static int bap_adapter_probe(struct btd_profile *p, struct btd_adapter *adapter)
 	bt_bap_set_user_data(data->bap, adapter);
 	bap_data_set_user_data(data, adapter);
 
-	data->adapter = new0(struct bap_adapter, 1);
-	data->adapter->adapter = adapter;
-
-	if (adapters == NULL)
-		adapters = queue_new();
-	data->adapter->bcast_pa_requests = queue_new();
-	queue_push_tail(adapters, data->adapter);
+	data->adapter = adapter;
 
 	return 0;
 }
@@ -3522,15 +3323,6 @@ static void bap_adapter_remove(struct btd_profile *p,
 	ba2str(btd_adapter_get_address(adapter), addr);
 	DBG("%s", addr);
 
-	queue_destroy(data->adapter->bcast_pa_requests, free);
-	queue_remove(adapters, data->adapter);
-	free(data->adapter);
-
-	if (queue_isempty(adapters)) {
-		queue_destroy(adapters, NULL);
-		adapters = NULL;
-	}
-
 	if (!data) {
 		error("BAP service not handled by profile");
 		return;
-- 
2.43.0

