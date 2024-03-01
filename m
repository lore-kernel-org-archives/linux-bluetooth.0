Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2082.outbound.protection.outlook.com [40.107.8.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D396F3A1DD
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Mar 2024 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709305253; cv=fail; b=usYirnpowYmcUhxEVZimAU0Y8TL98oxf/IOttjfMK5NzkybhT3Pz9JErdxutmdv1Vwffdnp42LsKZkch7D6JCSDHvkkamWo9WCkLPeKDMU6RnKHwnKoxCmtA0HF0ovzUZUzuhmFt62ClG5ekeVYhm3hT7IwuW835aeLIM9BaNkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709305253; c=relaxed/simple;
	bh=tTwd59IH/QgRE3fJLbOWtwufOhUT1g37ifKdW1V9cWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GbZV2S8wqyhlkcJ+6O/0IzuL3zS5Y0j3C8KvHar1pQnqtsrtuRxgLaa3Gbb8jMbXdQoTSoGDJDxH/KQeAlm5xoDi5wqZE6iyDODHMySbWS8LUDiuU7xuSYTn5EMAkA4fCkG1ThMl54VjZruSXnNJ5su6AjOgn6XnUGUvmrEBD0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=apmrSw4Z; arc=fail smtp.client-ip=40.107.8.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="apmrSw4Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxFU41embDzMRgEf2sWvOIE829uLcgFExGGQPsJUmdCkAcmcU6Q1y+7Dw97Fb6gF14Tws+TxEZa79DizwP018af9ix8j678yv1YwEgaqBKkvV/VdTkE8yIhxdFn4A3TctVbY6uoBT2MbOu8fZZ0V+DrBVHcRvEyAAjuPzKvi+Zj33Hv3MLx+dGD1hjg4DzD7DLGUNPdywRnzO8v71kzmmAbxcbbcXjRZkjNVRcBFfrks3ARXu9qFY2sPMcwNpA4MHb+zLyqEF3za03Bp3u9bJ8rugKzPtE0y4cmPZaUN/Sbx9TjoCnQrL4WpjFQQtZTyzbrFrkr6GonxOd/mhLP12Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDchfjS9y/2mGc9Oila/I2o06J2MooOfFg2deK5jViI=;
 b=Xm54K5fJQAOd51+SJXuMF7R2nyG70rRqTlYniW2FYHYVjXxhJ2AZYFXr+snMscyzyGWOGj58RjsBXLw9yW0HTjG2wYTc3yLdTfZ7HxzPxifc4YGdJH741S3JW0OwuXO1Ul+X4f65ZIQwIOoHCqKNvIlUTYgLaW0Mk5wZB0UUh4Dw4UFfjRyZy5S+hajRB7z5F5wbW4468aJFmSnCSpYjyufyJa/EKPqVNC8IWYZGfU9Cm1GPns1cNZFVNmtO+xYRK2JB5NkRiLUnRItgGt9gnPZtxJRest2eQU8tHByYUJjUuEw+sfzbYY9oeoPhiJ2hzIB8MVFTbQ+C6wJvGw3cKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDchfjS9y/2mGc9Oila/I2o06J2MooOfFg2deK5jViI=;
 b=apmrSw4Z7XbcQRu56nZRBZQu1r5j5vRvON6ZD/hNjloTGfZ54W8RmRYEY4KkjJ55dHWslF2yDra78hVvwvOK2chWlDKyz3il99gTPRn3s2pXazXSqnb0HU++vgdg1neO1qbTX5SemdhTtwEnBjZD4whXgSwCD7LHTJCcGbffUdA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by DBAPR04MB7480.eurprd04.prod.outlook.com (2603:10a6:10:1a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 15:00:47 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::83af:c10f:9f30:43f]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::83af:c10f:9f30:43f%6]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 15:00:47 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v5 6/6] bap: Do PA Sync for each BAP Broadcast source discovered
Date: Fri,  1 Mar 2024 17:00:29 +0200
Message-Id: <20240301150029.14386-7-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240301150029.14386-1-andrei.istodorescu@nxp.com>
References: <20240301150029.14386-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0012.eurprd05.prod.outlook.com (2603:10a6:205::25)
 To AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|DBAPR04MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: d3d6eece-d74b-4817-5134-08dc3a00605f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zwRMiMaEzx5HLMaVcBycoAe5nbGx5q1c/12RfAilDdri5kICziQPEmkCxy1xCH3m6N2JTc7oW2J97VrM+IbIFed7OcTivcVWPQ4AZ/VeEJQMiYerKXBSK1OxtzU0fCWX6MZX6iLpyvr9j11stv6JaczrumbWHlrqV/NqZj31HIz0a/73q/NVDPZOB67G0GA/DzbxYRhc82uGKkI5Q5M0Fh4b7Ebc6LxIaFaNUMnWbjVZDb8BWkD0MnHgUIBCig/+lIV2pNhbv6vDf/7GYrpgwExomP3ObMVIrW2mpYxKwYpvE4bgP86diMNZExa9E9liDlgbMIkrH02qoTYI+7F9wyZou89b1f2d+Jjcom7/HG9oDew3zsjJITW51FSaK7CC0GBOg60ag8HBzYu6iWp32yAPWHchgZM75IeS1BVOiWQ3U/FXOWn7E+PwKjXKi4dlYcbF4vCiZOHJ3pN4Br7EyWZACQX/d/6WRQiMPG82I4u3haFITeyEwJz6h8KFf0nNXQ9/JDCr1RbA4DoUM1upGS3n9XnWP5Vv9aAfohR3cGCxGzVMjlWkuIylngy4UQi5TfdaW6NhePrwRQZTXPHJDKClFvsfZ/wRYbuP4qGp41dqjV85pwNvsKkK8hzgObW2XS6fDvMVa3kHEYgpNE60CQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U9sm25ohRnsGDzyirkZhkfh+BnSjX55EP8kWMUQvwNhfT4qAkkvVb6c//joR?=
 =?us-ascii?Q?YStRnfL1ZxCdYhnWwkyxt2ICq6v1A+fDptWyd1j8i7Sgt9Axirg3u/ZhT1Te?=
 =?us-ascii?Q?nQv7e6r4fE7LksMBXn1RwDP36mmVI3Wywb81C/piNQWbtsicvUCI+EXrtqjc?=
 =?us-ascii?Q?pAO6TIchVQV/C42VAnXh231cKOPMadPxLZwbJ+cMMdRRUbbc2TIHsTCp4sgb?=
 =?us-ascii?Q?s7X3gdXYEcJzcynp+0Hn9vV4nL6Rtywk/WJzLE1yYikvNiqVKv3fi7lrnu/O?=
 =?us-ascii?Q?NHZtbFX30jWMkaFLdcnxpZYXXcFw5P3Pmk22sGZvjqXD3HknmqJ7Aq9NZuZu?=
 =?us-ascii?Q?fW6u7n693KwB1kf5DYnwIcmXb01P9r242fleAC/H/PVeJrBVrIWT5uOBq+Pk?=
 =?us-ascii?Q?QEuADM+AqjcwZXeOUFYPeYnMuuWDfxacYk3kayjAzwmkelBjMbwo+4zJ8NqB?=
 =?us-ascii?Q?LMfUsBD/DKrAN9o8vbwOCTNyBu7sy8va++OGExoSyGugplxN8gZbffT/D3fO?=
 =?us-ascii?Q?nYBKIIKHdZosoc9UB6cDCBanskjsoO1fP7M86aQtst/+5xhCoIohbgFt7q6d?=
 =?us-ascii?Q?teoQ3Hz8tsR2Zxrr8kfvbr+fUB4wyCbwOI12BR/hot8IlEsmZpav0/UIet4N?=
 =?us-ascii?Q?0eSOBB8PVNtbkJ82xv0V0I294nSBW2VtmWQTSSZTcGQbCc0AQfCKNyUG6vSn?=
 =?us-ascii?Q?2ns+JQmgZoSoxD/y2Q31p8JAd1k7sEwf8h0Wa+OPwB2n0hKMF0Icyu6wYdtr?=
 =?us-ascii?Q?cempYkAySntdc5RHNDb3ut9/6/zTezD4mrHYektfV6lc/BL3L2IGFkKHP1lE?=
 =?us-ascii?Q?OQifmfA/ikP/XhvRoS8ay11rEHgCogPWWXHC4d9SrFfTkKnRJzmL+Ow1SpT9?=
 =?us-ascii?Q?XBgemhIyN+dmOE4l8n4D8dSjSURzTu5ei7CcaPPuZCFdbqqfBO7Rgn5cmZ2o?=
 =?us-ascii?Q?MJCTsmEIaqLpQip0NJhemQOBjIabUvHq41choFk5Y1otKwlpN8GQ/Ujp4JZF?=
 =?us-ascii?Q?JxTUCqpSP2osZJQf+jUo8WEL/RunoQrI/9YIzGwTfTVhIpG15B/NnYL0PZt/?=
 =?us-ascii?Q?K7Napxce9VOqZPBIgx6G3D9Fs/PVbYAPdlZOhtuGhqAitS3HyjsYDvBJY7j8?=
 =?us-ascii?Q?Tso9UYr21r0lnqgjUKHKSK6XWCoazJJkZ08/8MX1qDHQ2CdsmGAUyw9//VPb?=
 =?us-ascii?Q?XoRBqb2YUncKi33y1M7enpsxpClbocrqvTP92/15BxFeV/BBa6UG+2bNtu99?=
 =?us-ascii?Q?H4hAhpMb3r8BXp3VK2tz/haiQi+qWo5Y/LmWEAQQXDjqCLg/TQMq3velh19m?=
 =?us-ascii?Q?CIdsHjKcuUi+y6uwZDHzqZHeJZg0afBQ86Z459c0+HUlK8Dggqk4PeLwR/iZ?=
 =?us-ascii?Q?UeBegStmb+BSbQIvSX+EV7ddjm1gXQuCmGjIAcj/rhix4BGEVfe/bvVQLYgd?=
 =?us-ascii?Q?9tulcgOrktWeloxNP1WEyR6uvCIUesy+F85QqLXxOE+Guotl+S2Rmuo02BBU?=
 =?us-ascii?Q?YJ3eZcRvKA8Np9nYjFG+/w8BoQbq7kW8pKAMey1sjHWrnG6Wgh1rKcqtPmBo?=
 =?us-ascii?Q?PrMk5URUIe+cbQMszwycAKxY4xX49Fm9qKixvyadwLVHmDfHpVjI+md2DUdM?=
 =?us-ascii?Q?Rw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d6eece-d74b-4817-5134-08dc3a00605f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 15:00:47.2979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XOcAe1DuQvofqO3UhX04kmatsmJfThzG5EJY3x7o4p3MEzennJKrUm8aKY+ljjXPpfM96+C04n2AGYC5zf7ohEPh1QcA2ZKJC5EYPddfveo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7480

After discovering a BAP Broadcast Source do a short PA sync first to learn
the BASE. After discovering the BASE check how many BISes are matching
the sink capabilities and create endpoints for them. Allow user to
configure one endpoint using "SetConfiguration" causing BIG
synchronization to the corresponding BIS; also this results in creating a
stream and the corresponding transport.
---
 profiles/audio/bap.c | 656 +++++++++++++++++++++++++++----------------
 1 file changed, 410 insertions(+), 246 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 38577bcf376e..b7e1837801dc 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -62,6 +62,13 @@
 #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
 #define MEDIA_INTERFACE "org.bluez.Media1"
 
+/* Periodic advertisments are performed by an idle timer, which,
+ * at every tick, checks a queue for pending PA requests.
+ * When there is no pending requests, an item is popped from the
+ * queue, marked as pending and then it gets processed.
+ */
+#define PA_IDLE_TIMEOUT 2
+
 struct bap_setup {
 	struct bap_ep *ep;
 	struct bt_bap_stream *stream;
@@ -110,7 +117,62 @@ struct bap_data {
 	void *user_data;
 };
 
+enum {
+	BAP_PA_SHORT_REQ = 0,	/* Request for short PA sync */
+	BAP_PA_BIG_SYNC_REQ,	/* Request for PA Sync and BIG Sync */
+};
+
+struct bap_bcast_pa_req {
+	uint8_t type;
+	bool in_progress;
+	union {
+		struct btd_service *service;
+		struct bap_setup *setup;
+	} data;
+};
+
 static struct queue *sessions;
+static struct queue *bcast_pa_requests;
+static unsigned int pa_timer_id;
+
+/* Structure holding the parameters for Periodic Advertisement create sync.
+ * The full QOS is populated at the time the user selects and endpoint and
+ * configures it using SetConfiguration.
+ */
+static struct bt_iso_qos bap_sink_pa_qos = {
+	.bcast = {
+		.options		= 0x00,
+		.skip			= 0x0000,
+		.sync_timeout	= 0x4000,
+		.sync_cte_type	= 0x00,
+		/* TODO: The following parameters are not needed for PA Sync.
+		 * They will be removed when the kernel checks will be removed.
+		 */
+		.big			= BT_ISO_QOS_BIG_UNSET,
+		.bis			= BT_ISO_QOS_BIS_UNSET,
+		.encryption		= 0x00,
+		.bcode			= {0x00},
+		.mse			= 0x00,
+		.timeout		= 0x4000,
+		.sync_factor	= 0x07,
+		.packing		= 0x00,
+		.framing		= 0x00,
+		.in = {
+			.interval	= 10000,
+			.latency	= 10,
+			.sdu		= 40,
+			.phy		= 0x02,
+			.rtn		= 2,
+		},
+		.out = {
+			.interval	= 10000,
+			.latency	= 10,
+			.sdu		= 40,
+			.phy		= 0x02,
+			.rtn		= 2,
+		}
+	}
+};
 
 static bool bap_data_set_user_data(struct bap_data *data, void *user_data)
 {
@@ -427,113 +489,6 @@ static int parse_array(DBusMessageIter *iter, struct iovec *iov)
 	return 0;
 }
 
-static bool parse_base(void *data, size_t len, util_debug_func_t func,
-		uint32_t *presDelay, uint8_t *numSubgroups, uint8_t *numBis,
-		struct bt_bap_codec *codec, struct iovec **caps,
-		struct iovec **meta)
-{
-	struct iovec iov = {
-		.iov_base = data,
-		.iov_len = len,
-	};
-
-	uint8_t capsLen, metaLen;
-	struct iovec cc;
-	struct iovec metadata;
-
-	if (presDelay) {
-		if (!util_iov_pull_le24(&iov, presDelay))
-			return false;
-		util_debug(func, NULL, "PresentationDelay %d", *presDelay);
-	}
-
-	if (numSubgroups) {
-		if (!util_iov_pull_u8(&iov, numSubgroups))
-			return false;
-		util_debug(func, NULL, "NumSubgroups %d", *numSubgroups);
-	}
-
-	if (numBis) {
-		if (!util_iov_pull_u8(&iov, numBis))
-			return false;
-		util_debug(func, NULL, "NumBis %d", *numBis);
-	}
-
-	if (codec) {
-		codec = util_iov_pull_mem(&iov, sizeof(*codec));
-		if (!codec)
-			return false;
-		util_debug(func, NULL, "%s: ID %d CID 0x%2.2x VID 0x%2.2x",
-				"Codec", codec->id, codec->cid, codec->vid);
-	}
-
-	if (!util_iov_pull_u8(&iov, &capsLen))
-		return false;
-	util_debug(func, NULL, "CC Len %d", capsLen);
-
-	if (!capsLen)
-		return false;
-
-	cc.iov_len = capsLen;
-	cc.iov_base = util_iov_pull_mem(&iov, capsLen);
-	if (!cc.iov_base)
-		return false;
-
-	if (caps) {
-		if (*caps)
-			util_iov_free(*caps, 1);
-
-		*caps = util_iov_dup(&cc, 1);
-	}
-
-	for (int i = 0; capsLen > 1; i++) {
-		struct bt_ltv *ltv = util_iov_pull_mem(&cc, sizeof(*ltv));
-		uint8_t *caps;
-
-		if (!ltv) {
-			util_debug(func, NULL, "Unable to parse %s",
-								"Capabilities");
-			return false;
-		}
-
-		util_debug(func, NULL, "%s #%u: len %u type %u",
-					"CC", i, ltv->len, ltv->type);
-
-		caps = util_iov_pull_mem(&cc, ltv->len - 1);
-		if (!caps) {
-			util_debug(func, NULL, "Unable to parse %s",
-								"CC");
-			return false;
-		}
-		util_hexdump(' ', caps, ltv->len - 1, func, NULL);
-
-		capsLen -= (ltv->len + 1);
-	}
-
-	if (!util_iov_pull_u8(&iov, &metaLen))
-		return false;
-	util_debug(func, NULL, "Metadata Len %d", metaLen);
-
-	if (!metaLen)
-		return false;
-
-	metadata.iov_len = metaLen;
-	metadata.iov_base = util_iov_pull_mem(&iov, metaLen);
-	if (!metadata.iov_base)
-		return false;
-
-	if (meta) {
-		if (*meta)
-			util_iov_free(*meta, 1);
-
-		*meta = util_iov_dup(&metadata, 1);
-	}
-
-	util_hexdump(' ', metadata.iov_base, metaLen, func, NULL);
-
-	return true;
-}
-
 static int parse_io_qos(const char *key, int var, DBusMessageIter *iter,
 				struct bt_bap_io_qos *qos)
 {
@@ -965,9 +920,20 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_invalid_args(msg);
 	}
 
+	/* For BAP Broadcast Sink, the capabilities and metadata are coming
+	 * from the source's BIS, which are present in the remote PAC
+	 */
+	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK) {
+		util_iov_free(setup->caps, 1);
+		setup->caps = util_iov_dup(bt_bap_pac_get_data(ep->rpac), 1);
+		util_iov_free(setup->metadata, 1);
+		setup->metadata = util_iov_dup(
+				bt_bap_pac_get_metadata(ep->rpac), 1);
+	}
+
 	setup->stream = setup->stream_new(ep->data->bap, ep->lpac, ep->rpac,
 						&setup->qos, setup->caps);
-
+	bt_bap_stream_set_user_data(setup->stream, ep->path);
 	setup->id = bt_bap_stream_config(setup->stream, &setup->qos,
 						setup->caps, config_cb, setup);
 	if (!setup->id) {
@@ -976,8 +942,6 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_invalid_args(msg);
 	}
 
-	bt_bap_stream_set_user_data(setup->stream, ep->path);
-
 	if (setup->metadata && setup->metadata->iov_len)
 		bt_bap_stream_metadata(setup->stream, setup->metadata, NULL,
 								NULL);
@@ -988,11 +952,7 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		break;
 	case BT_BAP_STREAM_TYPE_BCAST:
 		/* No message sent over the air for broadcast */
-		if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK)
-			setup->msg = dbus_message_ref(msg);
-		else {
-			setup->id = 0;
-		}
+		setup->id = 0;
 
 		if (ep->data->service)
 			service_set_connecting(ep->data->service);
@@ -1003,79 +963,18 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
-static void update_bcast_qos(struct bt_iso_qos *qos,
-			struct bt_bap_qos *bap_qos)
-{
-	bap_qos->bcast.big = qos->bcast.big;
-	bap_qos->bcast.bis = qos->bcast.bis;
-	bap_qos->bcast.sync_factor = qos->bcast.sync_factor;
-	bap_qos->bcast.packing = qos->bcast.packing;
-	bap_qos->bcast.framing = qos->bcast.framing;
-	bap_qos->bcast.encryption = qos->bcast.encryption;
-	bap_qos->bcast.options = qos->bcast.options;
-	bap_qos->bcast.skip = qos->bcast.skip;
-	bap_qos->bcast.sync_timeout = qos->bcast.sync_timeout;
-	bap_qos->bcast.sync_cte_type = qos->bcast.sync_cte_type;
-	bap_qos->bcast.mse = qos->bcast.mse;
-	bap_qos->bcast.timeout = qos->bcast.timeout;
-	bap_qos->bcast.io_qos.interval = qos->bcast.in.interval;
-	bap_qos->bcast.io_qos.latency = qos->bcast.in.latency;
-	bap_qos->bcast.io_qos.phy = qos->bcast.in.phy;
-	bap_qos->bcast.io_qos.sdu = qos->bcast.in.sdu;
-	bap_qos->bcast.io_qos.rtn = qos->bcast.in.rtn;
-	if (!bap_qos->bcast.bcode)
-		bap_qos->bcast.bcode = new0(struct iovec, 1);
-	util_iov_memcpy(bap_qos->bcast.bcode, qos->bcast.bcode,
-						sizeof(qos->bcast.bcode));
-}
-
 static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 {
-	struct bap_setup *setup = user_data;
-	struct bap_ep *ep = setup->ep;
-	struct bap_data *data = ep->data;
-	struct bt_iso_qos qos;
-	struct bt_iso_base base;
-	char address[18];
+	struct bap_bcast_pa_req *req = user_data;
+	struct bap_setup *setup = req->data.setup;
 	int fd;
-	struct iovec *base_io;
-	uint32_t presDelay;
-	uint8_t numSubgroups;
-	uint8_t numBis;
-	struct bt_bap_codec codec;
-
-	bt_io_get(io, &err,
-			BT_IO_OPT_DEST, address,
-			BT_IO_OPT_QOS, &qos,
-			BT_IO_OPT_BASE, &base,
-			BT_IO_OPT_INVALID);
-	if (err) {
-		error("%s", err->message);
-		g_error_free(err);
-		goto drop;
-	}
-
-	g_io_channel_ref(io);
-	btd_service_connecting_complete(data->service, 0);
-	DBG("BCAST ISO: sync with %s (BIG 0x%02x BIS 0x%02x)",
-					address, qos.bcast.big, qos.bcast.bis);
 
-	update_bcast_qos(&qos, &setup->qos);
+	DBG("BIG Sync completed");
 
-	base_io = new0(struct iovec, 1);
-	util_iov_memcpy(base_io, base.base, base.base_len);
+	queue_remove(bcast_pa_requests, req);
 
-	parse_base(base_io->iov_base, base_io->iov_len, bap_debug,
-			&presDelay, &numSubgroups, &numBis,
-			&codec, &setup->caps, &setup->metadata);
-
-	/* Update pac with BASE information */
-	bt_bap_update_bcast_source(ep->rpac, &codec, setup->caps,
-					setup->metadata);
-	setup->id = bt_bap_stream_config(setup->stream, &setup->qos,
-					setup->caps, NULL, NULL);
-
-	bt_bap_stream_set_user_data(setup->stream, ep->path);
+	/* This device is no longer needed */
+	btd_service_connecting_complete(setup->ep->data->service, 0);
 
 	fd = g_io_channel_unix_get_fd(io);
 
@@ -1084,26 +983,157 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 		g_io_channel_set_close_on_unref(io, FALSE);
 		return;
 	}
+}
 
+static void print_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
+		void *user_data)
+{
+	util_debug(user_data, NULL, "CC #%zu: l:%u t:%u", i, l, t);
+	util_hexdump(' ', v, l, user_data, NULL);
+}
 
-	return;
+static bool parse_base(struct bt_bap *bap, struct bt_iso_base *base,
+		util_debug_func_t func)
+{
+	struct iovec iov = {
+		.iov_base = base->base,
+		.iov_len = base->base_len,
+	};
+	uint32_t pres_delay;
+	uint8_t num_subgroups;
 
-drop:
-	g_io_channel_shutdown(io, TRUE, NULL);
+	util_debug(func, NULL, "BASE len: %ld", iov.iov_len);
 
+	if (!util_iov_pull_le24(&iov, &pres_delay))
+		return false;
+	util_debug(func, NULL, "PresentationDelay: %d", pres_delay);
+
+	if (!util_iov_pull_u8(&iov, &num_subgroups))
+		return false;
+	util_debug(func, NULL, "Number of Subgroups: %d", num_subgroups);
+
+	/* Loop subgroups */
+	for (int idx = 0; idx < num_subgroups; idx++) {
+		uint8_t num_bis;
+		struct bt_bap_codec codec;
+		struct iovec *l2_caps;
+		struct iovec *meta;
+
+		util_debug(func, NULL, "Subgroup #%d", idx);
+
+		if (!util_iov_pull_u8(&iov, &num_bis))
+			goto fail;
+		util_debug(func, NULL, "Number of BISes: %d", num_bis);
+
+		memcpy(&codec,
+				util_iov_pull_mem(&iov,
+						sizeof(struct bt_bap_codec)),
+				sizeof(struct bt_bap_codec));
+		util_debug(func, NULL, "Codec: ID %d CID 0x%2.2x VID 0x%2.2x",
+				codec.id, codec.cid, codec.vid);
+
+		/* Level 2 */
+		/* Read Codec Specific Configuration */
+		l2_caps = new0(struct iovec, 1);
+		if (!util_iov_pull_u8(&iov, (void *)&l2_caps->iov_len))
+			goto fail;
+
+		util_iov_memcpy(l2_caps, util_iov_pull_mem(&iov,
+				l2_caps->iov_len),
+				l2_caps->iov_len);
+
+		/* Print Codec Specific Configuration */
+		util_debug(func, NULL, "CC len: %ld", l2_caps->iov_len);
+		util_ltv_foreach(l2_caps->iov_base, l2_caps->iov_len, NULL,
+				print_ltv, func);
+
+		/* Read Metadata */
+		meta = new0(struct iovec, 1);
+		if (!util_iov_pull_u8(&iov, (void *)&meta->iov_len))
+			goto fail;
+
+		util_iov_memcpy(meta,
+				util_iov_pull_mem(&iov, meta->iov_len),
+				meta->iov_len);
+
+		/* Print Metadata */
+		util_debug(func, NULL, "Metadata len: %i",
+				(uint8_t)meta->iov_len);
+		util_hexdump(' ', meta->iov_base, meta->iov_len, func, NULL);
+
+		/* Level 3 */
+		for (; num_bis; num_bis--) {
+			uint8_t bis_index;
+			struct iovec *l3_caps;
+
+			if (!util_iov_pull_u8(&iov, &bis_index))
+				goto fail;
+
+			util_debug(func, NULL, "BIS #%d", bis_index);
+
+			/* Read Codec Specific Configuration */
+			l3_caps = new0(struct iovec, 1);
+			if (!util_iov_pull_u8(&iov, (void *)&l3_caps->iov_len))
+				goto fail;
+
+			util_iov_memcpy(l3_caps,
+					util_iov_pull_mem(&iov,
+							l3_caps->iov_len),
+					l3_caps->iov_len);
+
+			/* Print Codec Specific Configuration */
+			util_debug(func, NULL, "CC Len: %d",
+					(uint8_t)l3_caps->iov_len);
+			util_ltv_foreach(l3_caps->iov_base,
+					l3_caps->iov_len, NULL, print_ltv,
+					func);
+
+			/* Try to create a PAC using this BIS information */
+			bt_bap_add_bis(bap, bis_index, &codec, l2_caps, l3_caps,
+					meta);
+		}
+
+	}
+	return true;
+
+fail:
+	util_debug(func, NULL, "Unable to parse Base");
+
+	return false;
 }
 
 static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
 {
 	GError *err = NULL;
+	struct bap_bcast_pa_req *pa_req = user_data;
+	struct bap_data *data = btd_service_get_user_data(pa_req->data.service);
+	struct bt_iso_base base;
+	struct bt_iso_qos qos;
 
-	if (!bt_io_bcast_accept(io, iso_bcast_confirm_cb,
-				user_data, NULL, &err, BT_IO_OPT_INVALID)) {
-		error("bt_io_bcast_accept: %s", err->message);
+	DBG("PA Sync done");
+
+	bt_io_get(io, &err,
+			BT_IO_OPT_BASE, &base,
+			BT_IO_OPT_QOS, &qos,
+			BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", err->message);
 		g_error_free(err);
 		g_io_channel_shutdown(io, TRUE, NULL);
+		return;
 	}
 
+	/* Close the io and remove the queue request for another PA Sync */
+	g_io_channel_shutdown(data->listen_io, TRUE, NULL);
+	g_io_channel_unref(data->listen_io);
+	g_io_channel_shutdown(io, TRUE, NULL);
+	data->listen_io = NULL;
+	queue_remove(bcast_pa_requests, pa_req);
+
+	/* Analyze received BASE data and create remote media endpoints for each
+	 * BIS matching our capabilities
+	 */
+	parse_base(data->bap, &base, bap_debug);
 }
 
 static bool match_data_bap_data(const void *data, const void *match_data)
@@ -1942,47 +1972,58 @@ static void setup_listen_io(struct bap_data *data, struct bt_bap_stream *stream,
 	data->listen_io = io;
 }
 
-static void setup_listen_io_broadcast(struct bap_data *data,
-					struct bap_setup *setup,
-					struct bt_bap_stream *stream,
-					struct bt_iso_qos *qos)
+static void check_pa_req_in_progress(void *data, void *user_data)
 {
-	GIOChannel *io;
-	GError *err = NULL;
-	struct sockaddr_iso_bc iso_bc_addr;
+	struct bap_bcast_pa_req *req = data;
 
-	iso_bc_addr.bc_bdaddr_type = btd_device_get_bdaddr_type(data->device);
-	memcpy(&iso_bc_addr.bc_bdaddr, device_get_address(data->device),
-			sizeof(bdaddr_t));
-	iso_bc_addr.bc_bis[0] = 1;
-	iso_bc_addr.bc_num_bis = 1;
+	if (req->in_progress == TRUE)
+		*((bool *)user_data) = TRUE;
+}
 
-	DBG("stream %p", stream);
+static int short_lived_pa_sync(struct bap_bcast_pa_req *req);
+static void pa_and_big_sync(struct bap_bcast_pa_req *req);
 
-	/* If IO already set skip creating it again */
-	if (bt_bap_stream_get_io(stream) || data->listen_io)
-		return;
+static gboolean pa_idle_timer(gpointer user_data)
+{
+	struct bap_bcast_pa_req *req = user_data;
+	bool in_progress = FALSE;
 
-	io = bt_io_listen(NULL, iso_pa_sync_confirm_cb, setup, NULL, &err,
-			BT_IO_OPT_SOURCE_BDADDR,
-			btd_adapter_get_address(data->adapter),
-			BT_IO_OPT_DEST_BDADDR,
-			device_get_address(data->device),
-			BT_IO_OPT_DEST_TYPE,
-			btd_device_get_bdaddr_type(data->device),
-			BT_IO_OPT_MODE, BT_IO_MODE_ISO,
-			BT_IO_OPT_QOS, &qos->bcast,
-			BT_IO_OPT_ISO_BC_NUM_BIS, iso_bc_addr.bc_num_bis,
-			BT_IO_OPT_ISO_BC_BIS, iso_bc_addr.bc_bis,
-			BT_IO_OPT_INVALID);
-	if (!io) {
-		error("%s", err->message);
-		g_error_free(err);
+	/* Handle timer if no request is in progress */
+	queue_foreach(bcast_pa_requests, check_pa_req_in_progress,
+			&in_progress);
+	if (in_progress == FALSE) {
+		req = queue_peek_head(bcast_pa_requests);
+		if (req != NULL)
+			switch (req->type) {
+			case BAP_PA_SHORT_REQ:
+				DBG("do short lived PA Sync");
+				short_lived_pa_sync(req);
+				break;
+			case BAP_PA_BIG_SYNC_REQ:
+				DBG("do PA Sync and BIG Sync");
+				pa_and_big_sync(req);
+				break;
+			}
 	}
-	setup->io = io;
-	data->listen_io = io;
 
+	return TRUE;
 }
+
+static void setup_accept_io_broadcast(struct bap_data *data,
+					struct bap_setup *setup)
+{
+	struct bap_bcast_pa_req *pa_req = new0(struct bap_bcast_pa_req, 1);
+
+	/* Add this request to the PA queue.
+	 * We don't need to check the queue here and the timer, as we cannot
+	 * have BAP_PA_BIG_SYNC_REQ before a short PA (BAP_PA_SHORT_REQ)
+	 */
+	pa_req->type = BAP_PA_BIG_SYNC_REQ;
+	pa_req->in_progress = FALSE;
+	pa_req->data.setup = setup;
+	queue_push_tail(bcast_pa_requests, pa_req);
+}
+
 static void setup_create_ucast_io(struct bap_data *data,
 					struct bap_setup *setup,
 					struct bt_bap_stream *stream,
@@ -2043,7 +2084,7 @@ static void setup_create_bcast_io(struct bap_data *data,
 		setup_connect_io_broadcast(data, setup, stream, &iso_qos,
 			defer);
 	else
-		setup_listen_io_broadcast(data, setup, stream, &iso_qos);
+		setup_accept_io_broadcast(data, setup);
 }
 
 static void setup_create_io(struct bap_data *data, struct bap_setup *setup,
@@ -2281,19 +2322,12 @@ static void bap_state_bcast(struct bt_bap_stream *stream, uint8_t old_state,
 		if (!setup || setup->id)
 			break;
 		if (bt_bap_stream_io_dir(stream) ==
-				BT_BAP_BCAST_SOURCE) {
+				BT_BAP_BCAST_SOURCE)
 			/* If the stream is attached to a
 			 * broadcast sink endpoint.
 			 */
 			setup_create_io(data, setup, stream, defer);
-			if (!setup->io) {
-				error("Unable to create io");
-				if (old_state !=
-					BT_BAP_STREAM_STATE_RELEASING)
-					bt_bap_stream_release(stream,
-							NULL, NULL);
-			}
-		} else {
+		else {
 			/* If the stream attached to a broadcast
 			 * source endpoint generate the base.
 			 */
@@ -2657,32 +2691,23 @@ static void bap_detached(struct bt_bap *bap, void *user_data)
 	bap_data_remove(data);
 }
 
-static int bap_bcast_probe(struct btd_service *service)
+static int short_lived_pa_sync(struct bap_bcast_pa_req *req)
 {
+	struct btd_service *service = req->data.service;
 	struct btd_device *device = btd_service_get_device(service);
 	struct btd_adapter *adapter = device_get_adapter(device);
 	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
 	struct bap_data *data = btd_service_get_user_data(service);
-	char addr[18];
-
-	ba2str(device_get_address(device), addr);
-
-	if (!btd_adapter_has_exp_feature(adapter, EXP_FEAT_ISO_SOCKET)) {
-		error("BAP requires ISO Socket which is not enabled");
-		return -ENOTSUP;
-	}
+	GError *err = NULL;
 
-	/* Ignore, if we were probed for this device already */
 	if (data) {
-		error("Profile probed twice for the same device!");
-		return -EINVAL;
+		DBG("Already probed");
+		return -1;
 	}
-
 	data = bap_data_new(device);
 	data->service = service;
 	data->adapter = adapter;
 	data->device = device;
-
 	data->bap = bt_bap_new(btd_gatt_database_get_db(database),
 			btd_gatt_database_get_db(database));
 	if (!data->bap) {
@@ -2707,7 +2732,146 @@ static int bap_bcast_probe(struct btd_service *service)
 
 	bt_bap_set_user_data(data->bap, service);
 
-	bt_bap_new_bcast_source(data->bap, device_get_path(device));
+	DBG("Create PA sync with this source");
+	req->in_progress = TRUE;
+	data->listen_io = bt_io_listen(NULL, iso_pa_sync_confirm_cb, req,
+			NULL, &err,
+			BT_IO_OPT_SOURCE_BDADDR,
+			btd_adapter_get_address(data->adapter),
+			BT_IO_OPT_DEST_BDADDR,
+			device_get_address(data->device),
+			BT_IO_OPT_DEST_TYPE,
+			btd_device_get_bdaddr_type(data->device),
+			BT_IO_OPT_MODE, BT_IO_MODE_ISO,
+			BT_IO_OPT_QOS, &bap_sink_pa_qos,
+			BT_IO_OPT_INVALID);
+	if (!data->listen_io) {
+		error("%s", err->message);
+		g_error_free(err);
+	}
+
+	return 0;
+}
+
+static void iso_do_big_sync(GIOChannel *io, void *user_data)
+{
+	GError *err = NULL;
+	struct bap_bcast_pa_req *req = user_data;
+	struct bap_setup *setup = req->data.setup;
+	struct bap_data *data = setup->ep->data;
+	struct sockaddr_iso_bc iso_bc_addr;
+	struct bt_iso_qos qos;
+
+	DBG("PA Sync done, do BIG Sync");
+	g_io_channel_unref(setup->io);
+	setup->io = NULL;
+
+	setup->io = io;
+	g_io_channel_ref(setup->io);
+
+	/* TODO
+	 * We can only synchronize with a single BIS to a BIG.
+	 * In order to have multiple BISes targeting this BIG we need to have
+	 * all the BISes before doing this request. This request is triggered
+	 * by an endpoint "SetConfiguration" command. For multiple BISes
+	 * we need another way to specify which BISes user is requesting
+	 */
+	iso_bc_addr.bc_bdaddr_type = btd_device_get_bdaddr_type(data->device);
+	memcpy(&iso_bc_addr.bc_bdaddr, device_get_address(data->device),
+			sizeof(bdaddr_t));
+	iso_bc_addr.bc_bis[0] = 1;
+	iso_bc_addr.bc_num_bis = 1;
+
+	/* Set the user requested QOS */
+	qos.bcast.big = setup->qos.bcast.big;
+	qos.bcast.bis = setup->qos.bcast.bis;
+	qos.bcast.sync_factor = setup->qos.bcast.sync_factor;
+	qos.bcast.packing = setup->qos.bcast.packing;
+	qos.bcast.framing = setup->qos.bcast.framing;
+	qos.bcast.encryption = setup->qos.bcast.encryption;
+	if (setup->qos.bcast.bcode && setup->qos.bcast.bcode->iov_base)
+		memcpy(qos.bcast.bcode, setup->qos.bcast.bcode->iov_base,
+				setup->qos.bcast.bcode->iov_len);
+	qos.bcast.options = setup->qos.bcast.options;
+	qos.bcast.skip = setup->qos.bcast.skip;
+	qos.bcast.sync_timeout = setup->qos.bcast.sync_timeout;
+	qos.bcast.sync_cte_type = setup->qos.bcast.sync_cte_type;
+	qos.bcast.mse = setup->qos.bcast.mse;
+	qos.bcast.timeout = setup->qos.bcast.timeout;
+	memcpy(&qos.bcast.out, &setup->qos.bcast.io_qos,
+			sizeof(struct bt_iso_io_qos));
+
+	if (!bt_io_set(setup->io, &err,
+			BT_IO_OPT_QOS, &qos,
+			BT_IO_OPT_INVALID)) {
+		error("bt_io_set: %s", err->message);
+		g_error_free(err);
+	}
+
+	if (!bt_io_bcast_accept(setup->io,
+			iso_bcast_confirm_cb,
+			req, NULL, &err,
+			BT_IO_OPT_ISO_BC_NUM_BIS,
+			iso_bc_addr.bc_num_bis, BT_IO_OPT_ISO_BC_BIS,
+			iso_bc_addr.bc_bis, BT_IO_OPT_INVALID)) {
+		error("bt_io_bcast_accept: %s", err->message);
+		g_error_free(err);
+	}
+}
+
+static void pa_and_big_sync(struct bap_bcast_pa_req *req)
+{
+	GError *err = NULL;
+	struct bap_setup *setup = req->data.setup;
+	struct bap_data *data = setup->ep->data;
+
+	req->in_progress = TRUE;
+
+	DBG("Create PA sync with this source");
+	setup->io = bt_io_listen(NULL, iso_do_big_sync, req,
+			NULL, &err,
+			BT_IO_OPT_SOURCE_BDADDR,
+			btd_adapter_get_address(data->adapter),
+			BT_IO_OPT_DEST_BDADDR,
+			device_get_address(data->device),
+			BT_IO_OPT_DEST_TYPE,
+			btd_device_get_bdaddr_type(data->device),
+			BT_IO_OPT_MODE, BT_IO_MODE_ISO,
+			BT_IO_OPT_QOS, &bap_sink_pa_qos,
+			BT_IO_OPT_INVALID);
+	if (!setup->io) {
+		error("%s", err->message);
+		g_error_free(err);
+	}
+}
+
+static int bap_bcast_probe(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct btd_adapter *adapter = device_get_adapter(device);
+	struct bap_bcast_pa_req *pa_req =
+			new0(struct bap_bcast_pa_req, 1);
+
+	if (!btd_adapter_has_exp_feature(adapter, EXP_FEAT_ISO_SOCKET)) {
+		error("BAP requires ISO Socket which is not enabled");
+		return -ENOTSUP;
+	}
+
+	/* First time initialize the queue and start the idle timer */
+	if (bcast_pa_requests == NULL) {
+		bcast_pa_requests = queue_new();
+		pa_timer_id = g_timeout_add_seconds(PA_IDLE_TIMEOUT,
+					pa_idle_timer, NULL);
+	}
+
+	/* Enqueue this device advertisement so that we can do short-lived
+	 */
+	DBG("enqueue service: %p", service);
+	pa_req->type = BAP_PA_SHORT_REQ;
+	pa_req->in_progress = FALSE;
+	pa_req->data.service = service;
+	queue_push_tail(bcast_pa_requests, pa_req);
+
 	return 0;
 }
 
-- 
2.40.1

