Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334757E59F
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Feb 2024 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497213; cv=fail; b=qF5Yh5BixSsWTa5NGZJmHZmeilMMRu6Cmr9cL8xj8GSTxB98C6b/ohm8IsGApRDEG0FYq/ZDqNp6xrwYf3ZoXMQIFnkHVcXmVJ7FtkjGie2BN+oiwyFKjJWT5Pk7uqFSCpi6GrwOQuUVsSdrOXakIMwkTEzPOqWjn0hD4oTpTSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497213; c=relaxed/simple;
	bh=fKeBvX9xp3YbYUl1YnHhEcG43ovfHQ3yOuq/B/F2inQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fw6Ny6wnIfxLbZK+eFgKbcXvV872CeDd2eLjxEaj4T8JQuVBUNvQ4jEChC1gSmhol5z8dyT0z9Lj12ECRKuz0hPs5S7T8d4tUl81JpFSFoOsSYlmqSrCec9UcsuoYN/TVIze0xrUPC7we8qOgkkOay6WPC67tA+dFFydLQgRnZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=oo5swO/Q; arc=fail smtp.client-ip=40.107.104.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oo5swO/Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKe9H5mDSbLU13uFT1wKRjz25TilsTjvQFG/frDr6k+TGxAowEpfbyF14vOIEKSbs+YDwNK5U+Be8nVUASMeKa15UVBYyl+9b/TsSvJgTk7Rxtf5yeVllciOuFR04ZgSHR0XdVjBHobF9V5xTmr7+JAr17/81MlH9gurBKOmDnKAw+OwFXPULQeVARJGGlnaLKS5cHbe3ICkWTwvOB8uWV8dHY3olnDJSXQoaDjuvSMyyuW531GMavUwsYZ8rdyfbpUmlLJSW0pbgFRa2lmPHAJjU5JlFu12wlyibWxYTES4Te+NpjOpv47Oy7uNI/ev5eJA3lRM5fD6Ou/KQj8tRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPqFH8xxB03ODnk1cfVPQ9CScjGW50e6NQYYAvKsHDw=;
 b=Ik+XF46u5oQ35PjYcM76aRTSPYqjnrSl1J4tW5u4zPIfDq0Bsfd1+aAmXH1qtDRTNuVfB/RKiivLTCWxkTIPcbUXGvoP9FQhky58tsEu55VWki05f4f7EVnLHE7gs28+1z7ePZeksV78bfFJia5GhJ2GQecE2wQgzwKhpFllyVmpDnBhOnToBN+gwPx46iQ2/mNQI9qRzFGzxfx9lDk0fpQUDsXe9nRVEAFGyJv4MZhA4NVeMQAHo3LYPZH2yYfQQRcMHa1gOjIlAEbAmSDW5ZxBcSulgB0oi5gwZf1waOYGuv2xAAvK3AqxVbQ2utrsD1EcRAv2TDserPX+2wJHmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPqFH8xxB03ODnk1cfVPQ9CScjGW50e6NQYYAvKsHDw=;
 b=oo5swO/QhR3Yzs+uQ5g0GCG5EWjzM6mSzJYhNYUWtUv6maw3cgUyW+IvFuJcY/aIHVdSzOfBG10lUId6o8fBEwloe3cEaMVFAV9XGt8+otR215AVy+1jxt3frMD/fizX0nfuXbAX+rFo/+j36zd0aAHkLLh8r/+1EdOVxWYVJWE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by DB8PR04MB7097.eurprd04.prod.outlook.com (2603:10a6:10:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 16:46:41 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd%4]) with mapi id 15.20.7249.039; Fri, 9 Feb 2024
 16:46:41 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v2 5/6] bap: Do PA Sync for each BAP Broadcast source discovered
Date: Fri,  9 Feb 2024 18:46:29 +0200
Message-Id: <20240209164630.92208-6-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240209164630.92208-1-andrei.istodorescu@nxp.com>
References: <20240209164630.92208-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0015.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::20) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|DB8PR04MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: c1143b4f-d8be-4aca-c4c1-08dc298eb100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rSK73Dz21VVHC3XQ6uU6aVmqnETpiWOiJ9acivb4hJh0rAnhTs/kxseMtsyJHtTJr7pTT3W7Yc9Ilx02iCy3dhb0dxsQ9OFezvWQxpV47ywKysRkzKXYi2ZZavD8WX384q0QFwB1g6OdvxLqF2r1vUvqmApmgkZoTU4QcSZ0iJrqljaVjuUCOaC9q2FZpkZ4WacMq1KcWNrPV8pC02Cvd/kGUHa+UtaL33WseztdQ8CfUSTyeOowCb8ctn2tQBfZ4IufqBaWEzeWPC8YHShbDGeKXNasleklMK96AHwz/+h8ZTGS3Kue4VJVNGH5TvZrf8nBWRaBReXK1zfcpf1WfqxFdDDrpn1CZAUPkeIeIZqOiA0T1WTHr/dW/U51zl6iH0ZhTdTmlQ4yn4RTOLGiJiZesE5Bj/tqjMxlrzYW8n5F08dh3n362ptTJJL5CyZ+KQ+v/sVPhFlJWP+uyNe24L/4jUTjBkIofgvUUmOEvddU0AR+QrNxpqZGYv9yYPAWKOe4RAp0+LsawpDersPZxS0EOttx6/Xh2my4pvCjnppW8c9ngkvTVzPwJSZElQI6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(4326008)(5660300002)(30864003)(6916009)(66556008)(66946007)(8676002)(66476007)(8936002)(44832011)(2906002)(83380400001)(26005)(36756003)(86362001)(38100700002)(1076003)(6666004)(316002)(478600001)(41300700001)(6486002)(6506007)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1j8cbrYDiyKMnP7rHODOrEGxtObUrrqIzdf1F4Hy0FHAwvQTii4wkhclmWIe?=
 =?us-ascii?Q?XWVPqDRJx5f39s06Bg+z/Hv/tcXTv1B39qeDKktxpt/ipuW9ULc6wIquITXG?=
 =?us-ascii?Q?mTjxOC3ZnzpvcsPBELh0tC37gNXQU5dmNuv4odeQYISDySyQ+weQXHfbO3Ou?=
 =?us-ascii?Q?PsSlHVZroi3katkfxTnLlz/WG7RC7ZKXiV1kDV28MTqHcW00DHVszBpU+b3W?=
 =?us-ascii?Q?KcHOvBOl8pYGCrU2aOo1dfa0uWaGC1+pBBgPdwsW5oW41fRld7Olsk9jI5hw?=
 =?us-ascii?Q?o9cXnE7EMXW2239ycJY0oBNc5M+lhMENTwQXnKWtpBFlcTnjzO7cGPXyXb9U?=
 =?us-ascii?Q?Vz69OJBxgFSK0JHrdug8DvfJsDlo6+cxlmPehme0CWei+hReuc7h/HfrsC4A?=
 =?us-ascii?Q?8l6bmg3hAjTlyZrC7+Ok7P99I2HSfmiANoTr4IltUs0BT3SAvbG0iABi6yWK?=
 =?us-ascii?Q?vX8bUghq6pjP9HZgtHCr2KLbAGomNVtSTn3BfeVr5aDcSeaWQtdD++/dkoR4?=
 =?us-ascii?Q?+HxSZOZtVj7L2yolvj37V2njU93YXwdlSf4Xhpqra95RDIx3qDrU1prE9NBD?=
 =?us-ascii?Q?YKV4IXVgXsbtHglJs96Q83KccrBu9KUsooefg+7yLJYEopsGasvF82Nqp615?=
 =?us-ascii?Q?NVivg5xVAuCXpBMMGBX08b2maNwsZS7/1GUN1cvGGuIcTtcUcAqBg3bSzF7m?=
 =?us-ascii?Q?nHayvPM5Jt5DDtc9Vc5YKJwvEkG1TwdGH3Mb21/gVibzQRL5tRCV/1WAGg3h?=
 =?us-ascii?Q?FnMtvBswrb4wyCefRac8XOjKF4BRywGSo2L1aeT4a/Vf/dErA/b2T3jcegm3?=
 =?us-ascii?Q?2LRiSRTGT3nYTvEM54R2menHGGcRU/iEzyzmfbthgWYd7ZZ5mxj23p9Mdm7L?=
 =?us-ascii?Q?X2zIQpsP4jfDfa5igas3oGfZ3HoBmlj8IGNNt/hJmfSFy9XI7r6q/w4MEYDy?=
 =?us-ascii?Q?4dIn1z1b/KndsCCphUcHwUvr3aVg6V5JHxEU1xvxn7L4h9gFFPKz7CE2W4Zs?=
 =?us-ascii?Q?lDFZ9TM5OywYYr+vAmObYoXJpo0gPVlxCyQOgn+lrLBgjIj6H8C1YjxXXnfD?=
 =?us-ascii?Q?dZp8kvWwfNLVww8hQwNCKLimb10ui3QMUGfG8DH+TFLnQKEna4k//VhjcIvc?=
 =?us-ascii?Q?Y35vpDIhMvn0zuR+r0D4D3oBQaW0G0ROy6xU2b3zBwgoeUXYcxodVzT9IgiU?=
 =?us-ascii?Q?VyKre+2RJfLcNOFQGoK/P+1yQ2n9tD2/qZhpp/ZBeIKbvIn/F3b7PmTJC/CC?=
 =?us-ascii?Q?Dt8iOOgBZTY8iLkTJhQRah4G/Q+OQvRyqJ/lRplNl1fxHu1ngaPkXDngrW2g?=
 =?us-ascii?Q?5FB/qRK0rHjtjkhdI6BCptiR02+9QSDMue/nrvr1oWRQzxiR6IXP0msHcm5e?=
 =?us-ascii?Q?PaQ0uK0rFAv9oyFy8157JD5VfAgh8rlKaG1bQV+YiHUAnplXMrCM8t1QnzFk?=
 =?us-ascii?Q?K7iQk4SdgbtaaKzKxEKTYkOLCVkGdZN+jA/g72cZC/JBC854COFgFvcwSViW?=
 =?us-ascii?Q?4PxRZZ+YxppnH9ekHOjNEDs+p8EKyWGbzZKsCbpoAIpd00uvBNxxVeFC+CIU?=
 =?us-ascii?Q?ABM/sF0qFJFzN0/MpKHBBjXNGEg7es1xJIazNGKG9Va4q6I5y1Bx0dnv3iZt?=
 =?us-ascii?Q?QQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1143b4f-d8be-4aca-c4c1-08dc298eb100
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 16:46:41.3171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8J4XTKq7QsIi0qSLcmVb0ONmlvpD0J5AXz99FaHSChb0Jh5JFPUomAdrwoXMeRt7+yPPQdoA2WiLNqL8RlkZ7I6c+XscjEGZMKWvmWf4/2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7097

After discovering a BAP Broadcast Source do a short PA sync first to learn
the BASE. After discovering the BASE check how many BISes are matching
the sink capabilities and create endpoints for them. Allow user to
configure one endpoint using "SetConfiguration" causing BIG
synchronization to the corresponding BIS; also this results in creating a
stream and the corresponding transport.
---
 profiles/audio/bap.c | 308 +++++++++++++------------------------------
 1 file changed, 95 insertions(+), 213 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 88c93127bea0..61fb124b62c2 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -422,113 +422,6 @@ static int parse_array(DBusMessageIter *iter, struct iovec *iov)
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
@@ -948,12 +841,36 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 
 	setup = setup_new(ep);
 
+	/* For BAP Broadcast Sink QOS comes from the kernel and it should be set
+	 * in the setup before taking user's new values.
+	 */
+	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK) {
+		GError *gerr = NULL;
+		struct bt_iso_qos qos;
+
+		bt_io_get(ep->data->listen_io, &gerr,
+				BT_IO_OPT_QOS, &qos,
+				BT_IO_OPT_INVALID);
+		bt_bap_bcast_qos_iso_to_bap(&setup->qos, &qos);
+	}
+
 	if (setup_parse_configuration(setup, &props) < 0) {
 		DBG("Unable to parse configuration");
 		setup_free(setup);
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
 
@@ -977,95 +894,27 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
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
 
@@ -1074,26 +923,43 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
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
@@ -1934,12 +1800,11 @@ static void setup_listen_io(struct bap_data *data, struct bt_bap_stream *stream,
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
 
@@ -1951,29 +1816,26 @@ static void setup_listen_io_broadcast(struct bap_data *data,
 
 	DBG("stream %p", stream);
 
-	/* If IO already set skip creating it again */
-	if (bt_bap_stream_get_io(stream) || data->listen_io)
-		return;
+	/* Send back to the kernel the updated QOS */
+	if (!bt_io_set(data->listen_io, &err,
+			BT_IO_OPT_QOS, qos,
+			BT_IO_OPT_INVALID)) {
+		error("bt_io_set: %s", err->message);
+		g_error_free(err);
+	}
 
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
@@ -2037,7 +1899,7 @@ done:
 	if (bt_bap_pac_get_type(setup->ep->lpac) == BT_BAP_BCAST_SOURCE)
 		setup_connect_io_broadcast(data, setup, stream, &iso_qos);
 	else
-		setup_listen_io_broadcast(data, setup, stream, &iso_qos);
+		setup_accept_io_broadcast(data, setup, stream, &iso_qos);
 }
 
 static void setup_create_io(struct bap_data *data, struct bap_setup *setup,
@@ -2422,6 +2284,7 @@ static int bap_bcast_probe(struct btd_service *service)
 	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
 	struct bap_data *data = btd_service_get_user_data(service);
 	char addr[18];
+	GError *err = NULL;
 
 	ba2str(device_get_address(device), addr);
 
@@ -2465,7 +2328,26 @@ static int bap_bcast_probe(struct btd_service *service)
 
 	bt_bap_set_user_data(data->bap, service);
 
-	bt_bap_new_bcast_source(data->bap, device_get_path(device));
+	/* TODO: Check that there is no other PA Sync in progress already.
+	 * If there is another PA Sync controller procedure in progress this
+	 * one will fail.
+	 */
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

