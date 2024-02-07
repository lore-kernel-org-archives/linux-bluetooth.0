Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2082.outbound.protection.outlook.com [40.107.105.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B54A5A0EC
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Feb 2024 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707308607; cv=fail; b=Yeef9GhdVy7GxYAS8HI6+54A5mG6bKVwBS+FDYmCgw5OZtWZAAOYkB3+l90rSmkckMRVNui2HorzQ6J3IJu88B9KAPy7H5zsW3m7cxwtZ4UJuOuJVGCuU1auKgKppjS7X7fvIQ4Af/zWmc1Kbx4F+ntF6j3nZ6q0bY3WAhUUEfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707308607; c=relaxed/simple;
	bh=Uy+DC9nM8GHlUw4eRb8hIc0ddPqYr/Fc7jqqqqSNcr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=InS9LYXPRkJQjNv1tqBzPrylOHJWg8i6R/QQVqMIvhbyb//eK5PtpX6pRz+T/zQDUymOkihAjt1ISJw7KoQmrr4/DAMdtddp4xiszDJp6hBkXXnefcKhI8KxrPiJTsAK73Jnkh0QrrP6BqXpojmnpLLQtQ8mteXfYb21PDVlmHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WE//ykNX; arc=fail smtp.client-ip=40.107.105.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WE//ykNX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBLR2IKkCVeujrWiWcCtiVeRK5gui3GzfHkftKHrApmb/+QyfkWU/EPfc8+d9y67CTNKr/s0ZWBvy/bDMG/Y3v3sI5pEQwarv43sH8n8SiQmWifr3WyfMx7mmxQj3jCASeJfJ/PuJxaRqnm9LoNgZbWkkXOe+OYrviiXWsxfqHJhnOu6HY4VxzR89PYPLlbUxuGuF/Va54pHlRyn1q2YhZBj4C3cR9A50HrtEh1ypluarOHjfaYDifcMb2SRRsaNDXHbs3vS33taaO5u9yy+1CrRnuPKZ+YzAIQo3xZC9yk6qWk5t3gMbaST4LXH6Eyy2K8YIb3fr22MnX+x6ENJkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwlNumKxkfLFSc2D9C1IxG48P7ocd2n3SvZo6bEF1uk=;
 b=bU3VKhTQmRfExXU/X0jHkRelpJgT3PT8pZfZuVJ5kNGw9LfM5p6AulyxVkWSWIhCXMtha7aENP7FScIqCnZCw4+L9kr/r1Js4F959+pTTJ2iepf1sRpoQth/+zbmW6kN/HUFNFlmnVp3EiKCKWmWQkqaXpoRmbVGYFkYmyhQMJdakVErrd7v5wnmflRbeYcpqF9pRIkRNWGHdVdo3lmV9SHKcIZhhF4+bpEn3Sp+tednjCH5IStTWtyfHVxVKd/YniCdzoOZxj4CJKdin9l3rJvodR/azCJsqmeLG+a5gGbVohbdRrcPaghUDFJB8zrokIEjsnwZ8GcBS5WKh9IKLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwlNumKxkfLFSc2D9C1IxG48P7ocd2n3SvZo6bEF1uk=;
 b=WE//ykNXytBhgkOolfKrXLgWEOUeFweVaudsq4G2txHX4+lvx9UkXE1K1W5J6jl+7jkb1q0m81fRa3c43XCWFpl4qmapBRa2xcU3Ml0hZVNX0u1wrqTKxdd+VRmdvAK6DCjOK4If1Sy9wBuZsEvG52V9a0HLsL2dJTPfjaLwATk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by GVXPR04MB9851.eurprd04.prod.outlook.com (2603:10a6:150:118::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 12:23:17 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd%4]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 12:23:17 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ 3/3] bap: Do PA Sync for each BAP Broadcast source discovered
Date: Wed,  7 Feb 2024 14:23:08 +0200
Message-Id: <20240207122308.26457-4-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240207122308.26457-1-andrei.istodorescu@nxp.com>
References: <20240207122308.26457-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0090.eurprd04.prod.outlook.com
 (2603:10a6:208:be::31) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|GVXPR04MB9851:EE_
X-MS-Office365-Filtering-Correlation-Id: b4db5ed4-7dec-4f76-5a29-08dc27d79022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e533MLbjiqD5fBcgjPbriSz3SIYUUWevO0nXTkmjf8bW00uBt0M1Od8ZxSo0zEII4FkVbHmesfnvhEyxUtY+3T1NV3t9PgJf8bw94qse2M+FaFHQ1iafCcBqwObdp4iXrj87ZOQ5tFurQcFCfVUszjiKTDUTWoEMCzmN4Fh5VzxU8OjG35gB12MZbROyXRRdcmhbvuDrWMGE5aOLGt6LMdacUDJPNePJKseOauZYMfYNo4PuPTbwTi+o7lvH2kZR7SaPgqm5EdrtHDS+5r2tXIYe02z34URCBKw/2I0P6L5KC8+6JnJ0RVQhh0Zq3XjbmMwXvjohzxBK6wOVCKdGEkIYUvUJ/6AMEl4GZBxleuv6kocLnyjwgKijwkRCix5j1XV7r5FBdTUmr6aIbUOyAc+d0PYkBAEXykrEF4KeXhPEgR/Br5L1ojQR/zoa6OsMdJjnVMBPhqeMQ064iMSMwXarYwD2nyPL818jrdZYduw1W0r6To2HY3TC7SWdIBQV+3ED1MgtpJNbYgmGL2uWmwgcYz/q8Kvamsbys4ZH9l2hNbsnMbRKH4z4PD3FJH54
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6666004)(6506007)(38100700002)(83380400001)(26005)(86362001)(41300700001)(1076003)(2616005)(8676002)(6512007)(4326008)(8936002)(36756003)(30864003)(478600001)(2906002)(5660300002)(6486002)(66556008)(6916009)(66946007)(66476007)(316002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o7GGEivphfmJGr31yUj9Roo76Ror5qYajYHzHwPX3zUZyrut5g2mdMD/z2vu?=
 =?us-ascii?Q?neagdaJDPVXIwUsrUagfhRlxRRkM86e8gAnRTeIwKqhycsluLv/0uRH18YTB?=
 =?us-ascii?Q?xM1pFrq/fsPkbHcEI7xbwCtifxdrMCWqH1ed/5SNHLmu76UREGj+CHCw2cwq?=
 =?us-ascii?Q?t7+8UdnXo7TVJezFqeZvQqWyVMNP+F+abHchhGgdRZBDr1HIy4DBrRsvB9/l?=
 =?us-ascii?Q?m7O6CGZ4zwyxrLGqS79tEDeS/AjtrDQlNyBkABD5jtYycW7kICduOwrG6h9R?=
 =?us-ascii?Q?Dj/RgVL48iAlf+JZe5j5jNeESYyYyIOp7nTWs6W+xxWtByI/D1RqoA40e0jt?=
 =?us-ascii?Q?3SLcO7IjpXp71UiwRjHkN5ZERfsXcSAvibwoRhZg/bXJwL7pA6AxGZXujrid?=
 =?us-ascii?Q?NzbDG5U/T2GDDW/3MShSryy8TsvJLLl9yVc+3P/QDrGNQsE8cgg5SPeCW/hj?=
 =?us-ascii?Q?vdCqle2ViA0zq3bZPxvwzkqT1Ban7b8NoYUDrwoSDR+yxCygqo2a0nnlmPfx?=
 =?us-ascii?Q?9w8GMBbaeL7z0P4nc+Rp4r+P50MQG8i3DrTmLYcaAMWTVKbVtfw3L3cu8Uyc?=
 =?us-ascii?Q?b2BUVsbroqM+rcS/BtqnGXtHU8w+nS6ZQ4XnvngpuM0iul48wyAYr+PexB8u?=
 =?us-ascii?Q?3LSbX5ersaOqzOlcFLWvRsH2JyBbwhS8IOf+qJns7D8tmrcNFr7+VDs7eli/?=
 =?us-ascii?Q?5uqBz1b/FNASzx+rx5Go6bPI08HId1A5Db7em4WrAGlb/lA9aujNHDRj5rlZ?=
 =?us-ascii?Q?jsrM+ssiiyFR4E4pSehojeT/vuZMuAyye+KM4Bqwy6Thmu0YH8ebFO7a+nrS?=
 =?us-ascii?Q?AkuEyOf4dhAmBy6mTuInDQUjQsWyeFwJR2oob+b1PcPDSf5SjnS9Db/QRtrq?=
 =?us-ascii?Q?ApwmXv1cUKBjP4aPexZ0a4K6JlpcLJHB3nqtwwcG3RBsZNBNmbqEwfWbI9s4?=
 =?us-ascii?Q?kdLIQyiJRWROXeudCnND6BF7QBdWzwQ+8V/a0XXlhF6z2XgoZDQuG7k/jcBf?=
 =?us-ascii?Q?d+cPfmm5e8vKwJRHUbr3Br8y692JynSCeI7VUf1L+135Awfly39eHD6H1jPF?=
 =?us-ascii?Q?9bgNu0uPl9qNW/OM0EL2GqYldoLeB88zU16GSAuJu8x9lRi/cD9nRc0JWN7B?=
 =?us-ascii?Q?jrvMRvBoBI1y3czgOKOGSr+DnjiIE0BMEdL0Yek2NZAVQYfUT7aNcmV6z07h?=
 =?us-ascii?Q?msqDsMlImfzL//l/7hPfiaLM30mOfJfzsa9EZfGAuvhrHzQiyVvV6Z/goHmf?=
 =?us-ascii?Q?/i4E3SGPYMFvgj9kv82X5FC5/+DYOjAxdb3VUOnPnNavO8ZEQiQe21gNhAmF?=
 =?us-ascii?Q?5WLGgJPpDh3H6NMzChgT4HMIHjjPvkl2LANxRrYrhuFG/7zF3Nv7vi7/3hpv?=
 =?us-ascii?Q?B1/pNprHW2SdAJ1j9xsmdqv30E4cWvj7czW9RMRros9pOrMRNC6GwsGmOKoi?=
 =?us-ascii?Q?RE8MvDxdGuLFlqkP3bxnMxidNq9ypk8T3qQXIxUswWSjmtkyFn7eG1+u+B3t?=
 =?us-ascii?Q?miidA8AsK3fHjn8YtIEUDEgoPwt5H7Mkjl0Ryh6idKCsqCpnKkEODJ0nWdlB?=
 =?us-ascii?Q?ruNUZ39dz4Vul0d7kJxebdONX54nNBQKu7C+bj0Y9MFXTAlAkHp0alc32dy9?=
 =?us-ascii?Q?0g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4db5ed4-7dec-4f76-5a29-08dc27d79022
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 12:23:17.0957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDLtIwTJXaOSjXwxeSNzBQKNb563MEsnArBUelWuWxTPX3XHW+swXHrIserQkY5YfKppYXIZEqy4fGVqOxV/6t0NcIm+n0iu01Ox6J8c7FA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9851

After discovering a BAP Broadcast Source do a short PA sync first to learn
the BASE. After discovering the BASE check how many BISes are matching
the sink capabilities and create endpoints for them. Allow user to
configure one endpoint using "SetConfiguration" causing BIG
synchronization to the corresponding BIS; also this results in creating a
stream and the corresponding transport.
---
 profiles/audio/bap.c | 324 +++++++++++++++----------------------------
 1 file changed, 110 insertions(+), 214 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 88c93127bea0..8646eae2ed20 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -105,6 +105,44 @@ struct bap_data {
 	void *user_data;
 };
 
+/* Structure holding the parameters for periodic train and BIG
+ * synchronization
+ */
+static struct bt_iso_qos bap_sink_sync_parameters = {
+	.bcast = {
+		.big			= BT_ISO_QOS_BIG_UNSET,
+		.bis			= BT_ISO_QOS_BIS_UNSET,
+		/* HCI_LE_Periodic_Advertising_Create_Sync */
+		.options		= 0x00,
+		.skip			= 0x0000,
+		.sync_timeout	= 0x4000,
+		.sync_cte_type	= 0x00,
+		/* HCI_LE_BIG_Create_Sync */
+		.encryption		= 0x00,
+		.bcode			= {0x00},
+		.mse			= 0x00,
+		.timeout		= 0x4000,
+		/* to remove from kernel check */
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
+
 static struct queue *sessions;
 
 static bool bap_data_set_user_data(struct bap_data *data, void *user_data)
@@ -422,113 +460,6 @@ static int parse_array(DBusMessageIter *iter, struct iovec *iov)
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
@@ -954,6 +885,17 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
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
 
@@ -977,95 +919,27 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
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
 	struct bap_setup *setup = user_data;
-	struct bap_ep *ep = setup->ep;
-	struct bap_data *data = ep->data;
-	struct bt_iso_qos qos;
-	struct bt_iso_base base;
-	char address[18];
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
 
-	g_io_channel_ref(io);
-	btd_service_connecting_complete(data->service, 0);
-	DBG("BCAST ISO: sync with %s (BIG 0x%02x BIS 0x%02x)",
-					address, qos.bcast.big, qos.bcast.bis);
-
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
+	/* listen channel is not needed anymore */
+	g_io_channel_unref(setup->io);
+	setup->io = NULL;
 
 	fd = g_io_channel_unix_get_fd(io);
 
@@ -1074,26 +948,43 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
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
+	struct bap_data *data = user_data;
+	struct bt_iso_base base;
+	struct bt_bap_base base_s;
+	struct bt_iso_qos qos;
 
-	if (!bt_io_bcast_accept(io, iso_bcast_confirm_cb,
-				user_data, NULL, &err, BT_IO_OPT_INVALID)) {
-		error("bt_io_bcast_accept: %s", err->message);
+	btd_service_connecting_complete(data->service, 0);
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
 
+	/* The PA Sync channel becomes the new listen_io.
+	 * It will be later used to listen for a BIS io.
+	 */
+	g_io_channel_unref(data->listen_io);
+	data->listen_io = io;
+	g_io_channel_ref(io);
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
@@ -1934,12 +1825,11 @@ static void setup_listen_io(struct bap_data *data, struct bt_bap_stream *stream,
 	data->listen_io = io;
 }
 
-static void setup_listen_io_broadcast(struct bap_data *data,
+static void setup_accept_io_broadcast(struct bap_data *data,
 					struct bap_setup *setup,
 					struct bt_bap_stream *stream,
 					struct bt_iso_qos *qos)
 {
-	GIOChannel *io;
 	GError *err = NULL;
 	struct sockaddr_iso_bc iso_bc_addr;
 
@@ -1951,29 +1841,18 @@ static void setup_listen_io_broadcast(struct bap_data *data,
 
 	DBG("stream %p", stream);
 
-	/* If IO already set skip creating it again */
-	if (bt_bap_stream_get_io(stream) || data->listen_io)
-		return;
-
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
+	if (!bt_io_bcast_accept(data->listen_io,
+			iso_bcast_confirm_cb,
+			setup, NULL, &err,
+			BT_IO_OPT_ISO_BC_NUM_BIS,
+			iso_bc_addr.bc_num_bis, BT_IO_OPT_ISO_BC_BIS,
+			iso_bc_addr.bc_bis, BT_IO_OPT_INVALID)) {
+		error("bt_io_bcast_accept: %s", err->message);
 		g_error_free(err);
 	}
-	setup->io = io;
-	data->listen_io = io;
 
+	setup->io = data->listen_io;
+	data->listen_io = NULL;
 }
 static void setup_create_ucast_io(struct bap_data *data,
 					struct bap_setup *setup,
@@ -2037,7 +1916,7 @@ done:
 	if (bt_bap_pac_get_type(setup->ep->lpac) == BT_BAP_BCAST_SOURCE)
 		setup_connect_io_broadcast(data, setup, stream, &iso_qos);
 	else
-		setup_listen_io_broadcast(data, setup, stream, &iso_qos);
+		setup_accept_io_broadcast(data, setup, stream, &iso_qos);
 }
 
 static void setup_create_io(struct bap_data *data, struct bap_setup *setup,
@@ -2422,6 +2301,7 @@ static int bap_bcast_probe(struct btd_service *service)
 	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
 	struct bap_data *data = btd_service_get_user_data(service);
 	char addr[18];
+	GError *err = NULL;
 
 	ba2str(device_get_address(device), addr);
 
@@ -2465,7 +2345,23 @@ static int bap_bcast_probe(struct btd_service *service)
 
 	bt_bap_set_user_data(data->bap, service);
 
-	bt_bap_new_bcast_source(data->bap, device_get_path(device));
+	DBG("Create PA sync with this source");
+	data->listen_io = bt_io_listen(NULL, iso_pa_sync_confirm_cb, data,
+			NULL, &err,
+			BT_IO_OPT_SOURCE_BDADDR,
+			btd_adapter_get_address(data->adapter),
+			BT_IO_OPT_DEST_BDADDR,
+			device_get_address(data->device),
+			BT_IO_OPT_DEST_TYPE,
+			btd_device_get_bdaddr_type(data->device),
+			BT_IO_OPT_MODE, BT_IO_MODE_ISO,
+			BT_IO_OPT_QOS, &bap_sink_sync_parameters,
+			BT_IO_OPT_INVALID);
+	if (!data->listen_io) {
+		error("%s", err->message);
+		g_error_free(err);
+	}
+
 	return 0;
 }
 
-- 
2.40.1

