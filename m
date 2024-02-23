Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2076.outbound.protection.outlook.com [40.107.6.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A537D82887
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702505; cv=fail; b=VCcEurOVSs7R5AS+s6u8AGPQegw6Hf0o6op+kbL3Hqhhp1PAANotb68bqnv8GMD6uxC9kTq+9icoUyyOjhSr1EEjND8aNfu9nG+mN+P/zLe1oyL87SM4lKa/MH24Jclmxgq/n+iA/SchMjjHUkgCvtMGu5cyzcL5mPX0LOO54ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702505; c=relaxed/simple;
	bh=BKYOcBVOLbMaSgjA+maKov8cmLbZl2fBhj05BqchspQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RkDlmY1ZmaW6Kf19qUYc+fK3iBwAYMxeF8v4LgKvYbA+dcLouqfuvC5VzXu5IUNkxDMqXA6cAnBrRRFrPjjII3oq7Az4MVcpfosgCCtxMlqEKwYy544zrgN9PQiSGR3jN1GsC2ZT9Zp6F3CF5silWNzbYjoJ7me2+0JXx/RNI8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dn0QWGQp; arc=fail smtp.client-ip=40.107.6.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dn0QWGQp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEKFgncnpMoibaZWbNf5YnBbMpCBQrMio2TNpFXjSsUKgGSVsE7wjEeVv4drwIe5L6m/c1E2xIMYTQF3AXzwYl0y5ZWzwzIzbUjECzP4z98qSe4XHLgKcPWrue9ZghLndjq074pkkwcuc3xRloobJhEEXMEzK5dpG7YQVti0etavn/OmaTZSc8kvQ7YauzpDSxHqjhPcg9toDmlRskCEbhPogB8O2e05EWE+s3Pto3hoz+1q4zux2pb9+d+EhXVt6fRNr0XAFzLXYPf47x8W2aaYAMPwQQyQbq1Wa/Q4azt0RIQtAQf0oGhMkaeO8YBJg7RaPeAQCrBqLQqEwB9tyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGdgL7+2E4u6VtjoJ1ma3ObbpGobxoLBin65kic9IxE=;
 b=IQCfws15K3AHARp6Jbv1WczkGs5jqY6kwW4BIkMcugI/oQMUFOzdz47NhLbfmS1nibcyZyCR6PV0514AJF5x+6UkWb36ABPIs8pfSX2euFoeUwecZ21+bbvvFCC9ZMi2jQ5l7LC1r8c52ALWAGqr/sCK2M/PXMv0RI37FFQ70o9EkY1GWuCednxoTObhuC94gbsnT3OqGr5zxGYNf5oT35tkUXF/HingUVaGaoZcu3bg0/Cue/5Ph61DiWq8AfU7+TebZQ9U5P1VIndTYxi8YTDU/A9OvKnGrt7pXXeNBQUHbcjH/AkWFykuruY8iu95lpA1nWgQE7duV04MhQjXpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGdgL7+2E4u6VtjoJ1ma3ObbpGobxoLBin65kic9IxE=;
 b=Dn0QWGQp2AIfVEW1r0pfIzOTM0MLiU+VP97ydIvVal9vKcY3hJPp4oOMKcTrlln1SIY5iq3x4YyrzMIh5PTYt+cOqXORK5kmSrMpIW3bUHYNos9Q+dEJaHgfxEgXFxbnymTWR87J+JpLfRs2TuueJbQE81eF65TZ4IzLA8903jY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by AM9PR04MB8953.eurprd04.prod.outlook.com (2603:10a6:20b:408::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 23 Feb
 2024 15:34:57 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd%4]) with mapi id 15.20.7292.029; Fri, 23 Feb 2024
 15:34:57 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v4 2/2] bap: Do PA Sync for each BAP Broadcast source discovered
Date: Fri, 23 Feb 2024 17:34:50 +0200
Message-Id: <20240223153450.86694-3-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240223153450.86694-1-andrei.istodorescu@nxp.com>
References: <20240223153450.86694-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0035.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::14) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|AM9PR04MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: 151b1960-7fc9-4e0c-2ed7-08dc3484fd78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4xy6PWH5FmfUnDVmyIlETGxpE3TV3r3U/pmJ8f1EudnR82PYLggghM2qQnvQWnjoXHwO7DvtlAIrRF5Mn6D1WVkiQTEXOcOAqwLWfa31DKWKbd6zf4xj/kUg+PLcbvWXgxYIHDn+rVn5oFE4yctjAHgqByc6sFmTyYbEDoTqzKjSgeBxyYG00Lq4Odf7d8U5ZDfPAkcMSI6+9H6x8Tj4/GAqD0W7x+iKZq25SUrZPmEJv11X7OjVkBtRHxwcNTm3VImq8kRIgCgmOAR2kBWyAQF2SZVFhTMan1vRu8Lf1RE35FseYaJ3F0pgGZ3j2WIXX/yH9/puNpY12LpbKB2Yz2ppyzso1CSmVwJVFUq2sLHciYoaECkCtr4VpLlbbZIWPfcQ5Rf5woucmWrFPtuaZjQIF/Dyjthtz+L1jpojU1zGyk6hWxIAyjiyf+5qPL3ICv8QQn2ORCeyZzM71Zap2D3lw+eVf/TJZRTD8kP30LNjI6Rh1DImgKVE+MQ6HbgK0U+yIu1tx+MMesQUv8HGHSV96LVlngHfCjbeDZUukl0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KylVeCyLKBZv94h/b+eZs5ZvUYCwPuDUyLyVzGKASpBG35K+L2HGbReboYBQ?=
 =?us-ascii?Q?MV5UPRQlU4f1x1Z63xpQdOiu71LPjS+ITINqH0Zxw9WQPvDk3EzcjMmLKQ2Z?=
 =?us-ascii?Q?sDLJCMFE0P30aeleqEF5u5xgYbAnJGxRMWIoq/zK/HDH68UDEVQJ8RQu2/Or?=
 =?us-ascii?Q?rbfnmlGLd9UostYMcL10b2N4nYNzVSbAbETCYIsAU1w0FyZllJ+dxuIS1VsI?=
 =?us-ascii?Q?PCEySj3Vapb9F/zlgKAj311wNUfpa2OWLnZ/FY60xk1b6hoxNgQQ+0Ud569u?=
 =?us-ascii?Q?Qt20WSXmYLt/dUXapko/95L52AMGnPft/cVc8lIMZq5jIanLrR4FuHGtk5jb?=
 =?us-ascii?Q?aK7gh4iPLmKW82v3wP+R/I8gSDmBs+hgaoHjnRVrS8pMeO27Q3a84tjA+czw?=
 =?us-ascii?Q?kRUEBjfWFbhwlBCrDt4/hpmUs+WtPGrtbIkG6P7B+zFNsJoAdE7ONTwNozwS?=
 =?us-ascii?Q?tRvaSpgf4+J8SITES6ykaEpdI9pWtUH0SaAVP0AVcrgKZpsEnjTKqNeGVt8X?=
 =?us-ascii?Q?Jr1pgDQ1uYnP/BITNr+GIp9gAAMQpr0HFUR+CmobiIg91GGv/JP5ZflyYI0G?=
 =?us-ascii?Q?/GcKK0on/uAgkVo4iTS+1B/jl8GKGoerh22dHIqDbd34+bg9s/6yS5HrEtmV?=
 =?us-ascii?Q?juikHTgrYPA4QhLU2hyEqzyqzJXKafFjwWVLyL5P38YNaLe1TWzyuIltClNS?=
 =?us-ascii?Q?Eoa7xdvgTfjpVoM3+rqeX71ycgy5TXboJFTS3IKgHqSHxp2cfnh13Ar+LeMO?=
 =?us-ascii?Q?Gn7PPfDSojeVOWtJ40EVD/xgh+0sfkqRW7J3gavBPsXQOwJEuCQ9uC8W8Sb7?=
 =?us-ascii?Q?zEfBCRUbGN5UphmVFEIxf73jHLtHVCk6dCTi0i/cmvh7Mlmk5IKKOyrr5FkA?=
 =?us-ascii?Q?+Zod1Xf+sAJs0GDo8+mAg/XXKW7nEH/NK5QmuwM+YB/N0lQqVW1/w9l/AJ7+?=
 =?us-ascii?Q?rpv64tTt+0SZ91SzRQUZ/88CUEtLdyDrwt1S1ZyiEYVXZmBW4jX9AM48ARKB?=
 =?us-ascii?Q?9VnxnxVOj46na7jg1LaBaD7ddjItlYtGt+Q+9Bgswy6VFxv6ZKC/HM/SIMKB?=
 =?us-ascii?Q?axppPw07BxVlYitT9UoRXY7613njnrxpAbRIeH/7rNnfbYpDiwbXJzwzJRlW?=
 =?us-ascii?Q?VR0hxCMUfez+l9y5GLw7ruCzVGgJlypyIg+DHvBFim3CwZCGemg29kqQg18k?=
 =?us-ascii?Q?cMkLWKFDxV2w2W+TwUTCGDxEVNNzvyqVNdXFXPg9JoNIFUGRw/pMFTK8Km4t?=
 =?us-ascii?Q?Gpj0FvDrQIgTM5Vq5EBJc94SBCvuB8g7Q7fkzTkc0/DHcZS1Wodf8Hx+H6hp?=
 =?us-ascii?Q?FVCATVbbmiM614135In2aINMLy65v68CZoBZlBdmFqM2/enHv2jqIqTb+JL1?=
 =?us-ascii?Q?z6Vmj8aqfvdW+LJ43I2EQnXf8KjGttr0ZzRv+A94+qL9CN7lN4ty4DnDVZYW?=
 =?us-ascii?Q?V0ZI4j1h8VYjN9SsXbsttly/PV8UvHXlIu7+h1bcnO83TaMAFdMed1lX1IOK?=
 =?us-ascii?Q?46RgEuAwX11cuW0wlzNeG2n9pLwg2Mcq6BLoDUHRF5mBm1FHXl78MR19uP2b?=
 =?us-ascii?Q?c5/5Dw9wzj3Zi6+505iuNsCVNfEJhTf+Ov5amaF4a/biW2muWOqvS3Lg+PDR?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 151b1960-7fc9-4e0c-2ed7-08dc3484fd78
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 15:34:57.4258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAvoDkz3zKm72Z+ZJHKbfMqY2Z+cKRqO78eFCetaBT5QMJ3RLLFGK8c1duMRouIacUF8YgflW/L+7g0BoFLUzyTY8s8MIt6cYFH9LaH0muQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8953

After discovering a BAP Broadcast Source do a short PA sync first to learn
the BASE. After discovering the BASE check how many BISes are matching
the sink capabilities and create endpoints for them. Allow user to
configure one endpoint using "SetConfiguration" causing BIG
synchronization to the corresponding BIS; also this results in creating a
stream and the corresponding transport.
---
 profiles/audio/bap.c | 651 +++++++++++++++++++++++++++----------------
 1 file changed, 412 insertions(+), 239 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index b4acdd9ef40c..6daa3640c21a 100644
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
+	queue_remove(bcast_pa_requests, req);
 
-	update_bcast_qos(&qos, &setup->qos);
-
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
 
@@ -1074,26 +972,157 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
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
+
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
@@ -1932,47 +1961,58 @@ static void setup_listen_io(struct bap_data *data, struct bt_bap_stream *stream,
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
@@ -2035,7 +2075,7 @@ done:
 	if (bt_bap_pac_get_type(setup->ep->lpac) == BT_BAP_BCAST_SOURCE)
 		setup_connect_io_broadcast(data, setup, stream, &iso_qos);
 	else
-		setup_listen_io_broadcast(data, setup, stream, &iso_qos);
+		setup_accept_io_broadcast(data, setup);
 }
 
 static void setup_create_io(struct bap_data *data, struct bap_setup *setup,
@@ -2148,7 +2188,10 @@ static void bap_state_bcast(struct bt_bap_stream *stream, uint8_t old_state,
 	case BT_BAP_STREAM_STATE_CONFIG:
 		if (setup && !setup->id) {
 			setup_create_io(data, setup, stream, true);
-			if (!setup->io) {
+			/* BAP Broadcast SInk creates the io asynchronously */
+			if ((!setup->io) &&
+				(bt_bap_pac_get_type(setup->ep->lpac)
+				!= BT_BAP_BCAST_SINK)) {
 				error("Unable to create io");
 				if (old_state != BT_BAP_STREAM_STATE_RELEASING)
 					bt_bap_stream_release(stream, NULL,
@@ -2470,32 +2513,23 @@ static void bap_detached(struct bt_bap *bap, void *user_data)
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
@@ -2520,7 +2554,146 @@ static int bap_bcast_probe(struct btd_service *service)
 
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

