Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6752C6B2
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Feb 2024 12:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344931; cv=fail; b=gn6o5g1W9d+TAjZTUkWHMu4oY2HvmsJJ7VavBYB6pOAfYP/6kSreu9neiFDE1CxWyd7mGfBy4XS+SccS++w0grjPtYmGTsKqOaFLibnucikPGOGKW5PoAn+bH4nfkv8/ETzCzvE8gsnkBMcbbq++p6gK8RYfHMA1BASFSDlw3zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344931; c=relaxed/simple;
	bh=yzH8YVj4GwJHelc+aQtQ5NuR6tVtBHneItK3rYZlb6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mAtkzxNfEYEybq+Ivljl1Q+SvLhmEk/M0XwxtEoIMBENw+RxxGLWsebBj6zmqmLsm+IQSpaa8geFHuhEZnFZDUrMYn2U7ngl84+D0MILBmgh8UdYnE3yOfou2xr6CBh6JgZlqvldLvOoR0FcFEiQkRDbXTTbHaP9ZTP7Ocgt1P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=n17Z5aAJ; arc=fail smtp.client-ip=40.107.20.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n17Z5aAJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEL72n0pZtORsklr0Klf7pC+Dk1oWcyGv+xQl7NllO5UkZVuDH3a6ZDMrYBU7wOFgYxIy5x/o5jw0cLRaNOvnFmMs9YMST9wAZxzUND9f2quIrdvNjYVuUHJB0lc7YV4Ptn05ZRttVPyyhnW1NTtwj7XjqkLvc459CNvAYtRY/2ZuM/V2QNTOWsUpHDBoPXsGV9/gTM3wle3DAAdvvSI7No2XRw5SWzT7taxUmkJm+VhqU+xXYjLKMSPgOtTnIWT8FknFaRjNKRj3Jir6Ull8coaVS3dCN3MSWceorLayvtzn3Bj6mMwzBUpjAuuM7EDrel+lewpM6dQMjU4hJXUlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EILv0Vd/57cZWFI1Yl7J+urCytM5VoRAGq+MZ6Uw+Bg=;
 b=az3tOBwSrj4sJ6CNCLZ1Js/LtueMsarh+yjav96Pir7V31icHwJ6OsuE6yR4GQ3hBWtaKJ4oghdzjO/SZwcefD3cnMf2fqYmAcrG1xtgDJDzZWUHxFsXqsfBLcwotwX10HqWVwzOA4nfSonjrkYkgfDZmPexhLsQTRnhDN4SWYjtHcl8n+Rlcb0ig4dtNlicIPQxve1muNe2fMjZquvdEz8t/YXMXDM/y01FhuJQiGbbO9jEnhQJ81qOgnUqqVYnbM+n+YAXev3YdnvbsIODK2TfNhOSWlug98wmrYR9o6FsGpg8x+Hgvd8ORH5zb8r7mcS3FzwOn512UHm3HCht5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EILv0Vd/57cZWFI1Yl7J+urCytM5VoRAGq+MZ6Uw+Bg=;
 b=n17Z5aAJHv+wFeoyddMcnclsawLBSShdoiDrC4626gvkDZ/c7Ug0ezT75nXwxNPQQktz3upe9EhPZPJdQjsL5DzDOb2TJsXdIsooQ7OxVNfZgz/ceB3rYx9YCGnW7OwXJNWBSUaTZDW36DgsrAdUZaL3p3zJfL8pW59RikqfoL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by AS8PR04MB9141.eurprd04.prod.outlook.com (2603:10a6:20b:448::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37; Mon, 19 Feb
 2024 12:15:20 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd%4]) with mapi id 15.20.7292.029; Mon, 19 Feb 2024
 12:15:20 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v3 4/4] bap: Do PA Sync for each BAP Broadcast source discovered
Date: Mon, 19 Feb 2024 14:15:09 +0200
Message-Id: <20240219121509.5702-5-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240219121509.5702-1-andrei.istodorescu@nxp.com>
References: <20240219121509.5702-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0015.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::20) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|AS8PR04MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea6a92a-99cc-4c4e-4b3a-08dc314470bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jaaRRz3e3QFpZigGMIRBMM5UbBs4MsNepYrEXqoCPKgeUZTSFlaxb0wsYAroBGVdIIkLyTV4xTUJS5+5sR+/JnwWqFAueongQ23QKeV5TWLCNDH7b44ax4eQ0TmNMz/bTZBwaIdyGvZk7TeQdnqwuEONiegapceIMA46jHz7qBWTwG6H/KsY0RMwgPsp30zkLn5wRsKLDpsdxSqFPNFUzArcV5nGvJ7b6CovPbMqvDsRsavc8mTpB/JXWNvuye8rISxban/QUgGbZNYfHZhs7epAyJkJwtB1zpUtAWf1KN5MJq89O33iM7doL5g3Iu2nwNDR3L7lhpEPPWZ7Rb1Sd/gfX6z5T1FrfKGPwZBRcW+iPG4haEyiKGmcJGo7cv7k63eO662B4gS/SvUr/Ej5Gj2Xj98jMW1zBSJmapLZiN2SG47nNbI0NRbvUX346c2nh2YjojyGRnFyT8BQ1MijOQfdujoQu0qXzuFsrJl4h7FhOsXRqHmF8mIz65Bdut/A3R2dK23zEmj60xtRWYM5HJWBSYjv62isL67yuRjKDp4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IjfLfxqPaxL/gA9qREs8uYmtyjZy8q7kZ2sT9E8CYJSgHGptM66hXz3kPKUN?=
 =?us-ascii?Q?iDHK/rL/8fOQcIjVM9HkvSQmHGbHL3Df2K4uTuX4rmPUYBKlTSOzvntpJ7/X?=
 =?us-ascii?Q?DprUQxHVIBpharip6FU6XPQZtr0Qvf1Bk2QXpOZ9w6mi7icpRnV23QCNTW9f?=
 =?us-ascii?Q?IQNHpb5PufVlQVprAPq5cB9DInoNa4zg6TZI2pzuVCbvdtizVdAdT9wfkFB4?=
 =?us-ascii?Q?NwJcdxxL+1DuE2Dgjxnr+Fjzlm5GbTH5R71+78SfkEnhMzMUgZVjny+qV/QI?=
 =?us-ascii?Q?dZCksBqo3LofOyrLKGq1XwZDwVU0PUxGMzquDfGCvaaBwkLHXPlkptOkdTnC?=
 =?us-ascii?Q?AVxamtnPDvspmoOkQWfZbLyqVZKnk8Z/bPrwA0YAbpOau7gqgg9ffIXxhj2t?=
 =?us-ascii?Q?h200gAtvGAq/+XcstkwKQUw/kNdWVsKWRJND2myWpc8usqKmDWXkXnKZbEk1?=
 =?us-ascii?Q?wsK+fcoLNXFSB9KtbRrNe61pjhVxLj7KLQPwdyZ5nF7xsYJknobTKSmFHx17?=
 =?us-ascii?Q?kCIZlkprws9HSEuF3FgT5g7sZBisj1PpN/eqwst+N4gjnLUAh5aC9XYQX3TI?=
 =?us-ascii?Q?8IVYqUhr2jjcLABqZKDZMGSfI/D06CVuNwyhW83P2pmLCOlVvjURKTINm4QO?=
 =?us-ascii?Q?0whG4ObHpJP/FB8z0AkU/xJz2EzLvlVuKAGd3OLqxFixcl79+Ak/u+iyv9is?=
 =?us-ascii?Q?a6iB5Uzt/V6+/OQt98gIy+nMbUjRuPeyrf7oYEIpJSKhXUtaYu6lxXBkXCkc?=
 =?us-ascii?Q?DO1p8UlwoGsSKqc+p2W5o6TW/6dM9JD7fVTKQP4CDdeZbwfjoVv7l2cTiRXY?=
 =?us-ascii?Q?fPaYKvnIKtOiL+a2yh4J/+m/Q8DSniIEJcs+GCwBGcksln/L1m2V7upT0QSp?=
 =?us-ascii?Q?jjTsK7/D3RfmzUUH4YaZ1Zm/MW8gUvwsU862TM9OvnpDeMwENc7EuI3Dffhu?=
 =?us-ascii?Q?ZrlvbUcvuUzZpUL6I7X3mQwyJHZqKpVsEANOWeaVQhe+BGfxJSGfjyhn4SQE?=
 =?us-ascii?Q?eahELhbyOZyxSPJ4YqFlg1QL3Pcq3h4Zr6RO86oV6ZRkJXlCtOYNGIzndN8B?=
 =?us-ascii?Q?KSAZCAByeOPmcc1b6Jy+sgwNpkRCHCZaSzHuR7qAX7EPdvQ9nSSadYxUePyx?=
 =?us-ascii?Q?qdurBFSLO2YJ/bhGhxnb3NFUAVMSgPVYk8HQ66AIufSzHk+bo/sti+Fq9q2f?=
 =?us-ascii?Q?qm4dqete/daTolDrruFmXJQ8J+41LkWE5QKq5kksQIbZ8q5vLB/ZETMsEq3u?=
 =?us-ascii?Q?+6SnuweZMGvTZ3vnR+pozCM8vSUIyZFsis43qKS8Do+JKdfgNfz5mSxGyCkl?=
 =?us-ascii?Q?SaMzPjj83rNbL572U3HtTWq/r0iMAWmVn6L6rzSdZA9XbevS63ZeS1M/BHKr?=
 =?us-ascii?Q?1AxlqpeRMdXT3ZDgP3nw2QGzwP8dRbtRvkztg/M2CgB7UZlnc+X7Le1ND1MS?=
 =?us-ascii?Q?VNQqpntulyhw7lFmQIB5wStQTtRgVC79FzMWVVDBT+TMoNXitRl4cX4SIb5C?=
 =?us-ascii?Q?vTvUTYjmfPjIQs+mTePCwGEBeFiU1a71cDHF1AjD290O20JIsWg3/nNZEiCl?=
 =?us-ascii?Q?Q+CEOEbyCfoxiequg2Ds2bPPKBACgk0XG2OUkNyuMS+XZG4W1c47edkxnv73?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea6a92a-99cc-4c4e-4b3a-08dc314470bf
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 12:15:20.0527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPAeFtF1uSUCr4uFOkQm5PbUflA2eFCZdH0ndo+X2UoGB3chGaN9U5iLuYQ1HmDI2pjN12NUzNKHdr2xw7DB19v3PIIv+Qm7URzo6mYHulk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9141

After discovering a BAP Broadcast Source do a short PA sync first to learn
the BASE. After discovering the BASE check how many BISes are matching
the sink capabilities and create endpoints for them. Allow user to
configure one endpoint using "SetConfiguration" causing BIG
synchronization to the corresponding BIS; also this results in creating a
stream and the corresponding transport.
---
 profiles/audio/bap.c | 546 +++++++++++++++++++++++--------------------
 src/shared/bap.c     |  11 +-
 2 files changed, 299 insertions(+), 258 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 88c93127bea0..3a32b7f4e106 100644
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
@@ -105,7 +112,62 @@ struct bap_data {
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
@@ -422,113 +484,6 @@ static int parse_array(DBusMessageIter *iter, struct iovec *iov)
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
@@ -954,9 +909,20 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
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
 	setup->stream = bt_bap_stream_new(ep->data->bap, ep->lpac, ep->rpac,
 						&setup->qos, setup->caps);
-
+	bt_bap_stream_set_user_data(setup->stream, ep->path);
 	setup->id = bt_bap_stream_config(setup->stream, &setup->qos,
 						setup->caps, config_cb, setup);
 	if (!setup->id) {
@@ -965,8 +931,6 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_invalid_args(msg);
 	}
 
-	bt_bap_stream_set_user_data(setup->stream, ep->path);
-
 	if (setup->metadata && setup->metadata->iov_len)
 		bt_bap_stream_metadata(setup->stream, setup->metadata, NULL,
 								NULL);
@@ -977,95 +941,29 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		break;
 	case BT_BAP_STREAM_TYPE_BCAST:
 		/* No message sent over the air for broadcast */
-		if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK)
-			setup->msg = dbus_message_ref(msg);
-		else {
+		if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE)
 			setup->base = bt_bap_stream_get_base(setup->stream);
-			setup->id = 0;
 		}
+		setup->id = 0;
 
 		if (ep->data->service)
 			service_set_connecting(ep->data->service);
 
 		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
-	}
 
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
+	queue_remove(bcast_pa_requests, req);
 
-	base_io = new0(struct iovec, 1);
-	util_iov_memcpy(base_io, base.base, base.base_len);
-
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
 
@@ -1074,26 +972,44 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 		g_io_channel_set_close_on_unref(io, FALSE);
 		return;
 	}
-
-
-	return;
-
-drop:
-	g_io_channel_shutdown(io, TRUE, NULL);
-
 }
 
 static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
 {
 	GError *err = NULL;
+	struct bap_bcast_pa_req *pa_req = user_data;
+	struct bap_data *data = btd_service_get_user_data(pa_req->data.service);
+	struct bt_iso_base base;
+	struct bt_bap_base base_s;
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
+	 * matching BIS
+	 */
+	base_s.subgroups = queue_new();
+	bt_bap_parse_base(data->bap, base.base, base.base_len, bap_debug,
+			&base_s);
+	queue_foreach(base_s.subgroups, bt_bap_parse_bis, NULL);
 }
 
 static bool match_data_bap_data(const void *data, const void *match_data)
@@ -1675,7 +1591,7 @@ static bool is_cig_busy(struct bap_data *data, uint8_t cig)
 	return queue_find(sessions, cig_busy_session, &info);
 }
 
-static void setup_create_io(struct bap_data *data, struct bap_setup *setup,
+static bool setup_create_io(struct bap_data *data, struct bap_setup *setup,
 				struct bt_bap_stream *stream, int defer);
 
 static gboolean setup_io_recreate(void *user_data)
@@ -1934,47 +1850,58 @@ static void setup_listen_io(struct bap_data *data, struct bt_bap_stream *stream,
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
+}
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
 }
+
 static void setup_create_ucast_io(struct bap_data *data,
 					struct bap_setup *setup,
 					struct bt_bap_stream *stream,
@@ -2037,10 +1964,10 @@ done:
 	if (bt_bap_pac_get_type(setup->ep->lpac) == BT_BAP_BCAST_SOURCE)
 		setup_connect_io_broadcast(data, setup, stream, &iso_qos);
 	else
-		setup_listen_io_broadcast(data, setup, stream, &iso_qos);
+		setup_accept_io_broadcast(data, setup);
 }
 
-static void setup_create_io(struct bap_data *data, struct bap_setup *setup,
+static bool setup_create_io(struct bap_data *data, struct bap_setup *setup,
 				struct bt_bap_stream *stream, int defer)
 {
 	DBG("setup %p stream %p defer %s", setup, stream,
@@ -2060,6 +1987,15 @@ static void setup_create_io(struct bap_data *data, struct bap_setup *setup,
 		setup_create_bcast_io(data, setup, stream, defer);
 		break;
 	}
+
+	/* The function succeeds if the IO was created, but for BAP Broadcast
+	 * Sink the call is asynchronous, as it is handled by the Idle timer
+	 */
+	if (setup->io ||
+		bt_bap_pac_get_type(setup->ep->lpac) == BT_BAP_BCAST_SINK)
+		return TRUE;
+
+	return FALSE;
 }
 
 static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
@@ -2091,8 +2027,7 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 		break;
 	case BT_BAP_STREAM_STATE_CONFIG:
 		if (setup && !setup->id) {
-			setup_create_io(data, setup, stream, true);
-			if (!setup->io) {
+			if (!setup_create_io(data, setup, stream, true)) {
 				error("Unable to create io");
 				if (old_state != BT_BAP_STREAM_STATE_RELEASING)
 					bt_bap_stream_release(stream, NULL,
@@ -2415,32 +2350,23 @@ static void bap_detached(struct bt_bap *bap, void *user_data)
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
@@ -2457,15 +2383,137 @@ static int bap_bcast_probe(struct btd_service *service)
 	bap_data_add(data);
 
 	data->ready_id = bt_bap_ready_register(data->bap, bap_ready, service,
-								NULL);
+			NULL);
 	data->state_id = bt_bap_state_register(data->bap, bap_state,
-						bap_connecting, data, NULL);
+			bap_connecting, data, NULL);
 	data->pac_id = bt_bap_pac_register(data->bap, pac_added_broadcast,
-				 pac_removed_broadcast, data, NULL);
+			pac_removed_broadcast, data, NULL);
 
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
+	bt_bap_bcast_qos_bap_to_iso(&qos, &setup->qos);
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
 
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 19e40e3c70f4..3dadb9063b35 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1677,11 +1677,8 @@ static unsigned int bap_bcast_config(struct bt_bap_stream *stream,
 				     bt_bap_stream_func_t func, void *user_data)
 {
 	stream->qos = *qos;
-	if (stream->lpac->type == BT_BAP_BCAST_SINK) {
-		if (data)
-			stream_config(stream, data, NULL);
-		stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
-	}
+	stream->lpac->ops->config(stream, stream->cc, &stream->qos,
+			ep_config_cb, stream->lpac->user_data);
 
 	return 1;
 }
@@ -5255,10 +5252,6 @@ bool bt_bap_stream_set_user_data(struct bt_bap_stream *stream, void *user_data)
 
 	stream->user_data = user_data;
 
-	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BCAST)
-		stream->lpac->ops->config(stream, stream->cc, &stream->qos,
-					ep_config_cb, stream->lpac->user_data);
-
 	return true;
 }
 
-- 
2.40.1

