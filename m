Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013038.outbound.protection.outlook.com [52.101.67.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FB326E17F
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740758226; cv=fail; b=pLVfGRRalZpeAB2DLSiG0k5mGstF8MLMWymPwkG+KoyuZyA3fJIK86EP8dGEMY8AC0IBshzelHtoMC+Aeo0n/P+895GReqFTbcaK5IQY+NtP9es8Bz+zkLp7AB5DAUPzbAjU5NCWBrofNuaNeR4/TxsVv7V3P0GsUXAclqhXmxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740758226; c=relaxed/simple;
	bh=j6oKxv0dnncWeDZfCxvTWQgMrOzqmE0yFwNM2VE5C5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TxuQYG88Dj3D0JiOw2WOhzG4Lvhmema+mD/jIy29KcCVlF347JqafPBUkpcwS/hzxdhDEYRWPj9IYPxAaE75LZv5OzvN+jDyZGBHfUjOrrEpFQnjuFWmfQSdvMvVuXNGnv2owfug2w9k99ho9mTX3Os3/B/HqUgLErrpWPvQFeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OMzDpbL4; arc=fail smtp.client-ip=52.101.67.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OMzDpbL4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZObAjxFWbnDX0MODGRj594px/ims4HAKQcF/EpKNYML2pmT2wmQRDQ+w17x91UnEdV6Ia8ccLE7YHOw94AClFgR5JrkzZQj8MRFTQfncYZpBv+oWfwna+PYRq8e8teAqheZsBbzl4hVaiuIYDm25cVN6kmVKLS5krYtsspXi3J5AvCW0uw+DGj6IawOVDUbFQX+o2QYMPqFL9Gdo3KvXiIS0KQnU/qufBffin2Optjgncz+njWe43ltkzCqQxsowrctqsqMSpa1V1ARCdGQOpes3mLSNkc7zLdg3BydXSQpc1kIzA1k55FIdnA7FpU/SysOT94iUX6vW1jIKTntAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7bm3uxDjfHczphW82U81ZMojbAO8vZvmbXj2jAxY90=;
 b=DYxvpDHZd2EHPXsamAGKceISI0z+V9p55z13LNBK9rSS9xDlzAPdBtE5loCbdZcSS37PS1GzjAgLXuM6jwu2ILp+pkJGJzXT5ZRe75XpGLqbcMQ9cqQZRmmoPuCEzgH2ATGjMnPZ7NNBEXhyHccxZEpPhGLF7OE5z6k2ZLpDwRKCL1okBWW+JiSwsF91fgw6ZrnI+W1MDTA6gcKa9Vx8My0P2vzGcsmRobqyUOqmn1tzrd03FH7hc+rapbQuRi2jGelQHC9qHLfY7cw97FruENK0QnYSixmz/EWBUpCt4xO6s0lV9rPWjDuqqkGgNOIZaKRMXfdcVYNswvMzOGtw4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7bm3uxDjfHczphW82U81ZMojbAO8vZvmbXj2jAxY90=;
 b=OMzDpbL4JYvBTmc1ed3KN1usS1f8Cehg4meG2/Fy3QD62H4xVhik3A1KnPdOti/iaWirIZY/HKYljDW5hsQNyaL0F5qniQNlGnD9/ISBMtRjaiCZYWbtry8LwEw+zVKY3Tr20IKMWr9J3Nl1upHm2YxgErI8IVfAZNP/8n6Ch7PAIuHKfF6EZDS/6mEr2cK60r73JGketbdv0GlmGj4AB3cYNyQYxUPsMYDJzuEYefo/ZLti/UATX7EGPY1qFiUVo+9FKqUTIeaohV4fnW6pIVAP/aILVTdq7wYfXLFZ4kXOLB/xkEbYD7TpZf21sXrUpfkvKlx8lnZOIuKHeQVb2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GV1PR04MB9118.eurprd04.prod.outlook.com (2603:10a6:150:25::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 15:57:02 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 15:57:02 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/3] shared/bap: Add APIs to register broadcast code callback
Date: Fri, 28 Feb 2025 17:56:32 +0200
Message-ID: <20250228155634.57979-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228155634.57979-1-iulia.tanasescu@nxp.com>
References: <20250228155634.57979-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0046.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::26) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GV1PR04MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d690e8f-b0ed-4414-0f9d-08dd58108a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tGBgQhxcFzVr00t3lpfkyFaWVImcMkSbCackgOAl0kK/Mx4jU0z4t0ubmm9a?=
 =?us-ascii?Q?1dXM5QTvRHX7By3OpgQCqiLz/vWvZO/hp3yNJIUbTTPHUSq8Cj//YbPgrrSz?=
 =?us-ascii?Q?US2DOg666ylW+r3Cm+DXksuAurG3hUi4q73w9JxSAQZJevBc8IEeutVzQsM+?=
 =?us-ascii?Q?/NRRCz217OCPAYh58QzEECKKMv/f6efJSn2jICh9EUYuj+pUj61ChqkpRKSY?=
 =?us-ascii?Q?mqXNIXffa8qjgsJPwULffnz3TVCnxevF+2GQMjg/CncI4mFcv3vAK7/Oq0vA?=
 =?us-ascii?Q?5ku+DRHNiRcL4ofbw15z2+HgsYOPc0+YyvOflhNIfCe8vjeTQ64iR9gqYYnE?=
 =?us-ascii?Q?9fH/UwIqkegnjFtJXsJ00EAME3ZW1Ocsqu1zB71vocaJPKWAjiTag056/OYo?=
 =?us-ascii?Q?fOIu3iV51gXw0TxV/fhII+N2xZPBjeGdwu365dEqgaLfWq1prwI67wmFYXwD?=
 =?us-ascii?Q?zUeK1O8FzVpJQZHLbXnINXYFCA7plH/OeA2mEMXob+/0+onSFY/4Mrz0OKaJ?=
 =?us-ascii?Q?AxW9PbspUOkPj5tBQzrDvQpDN9zRtn6yXb5lpJj/HnIpCHYiLKcpuMxtFhyc?=
 =?us-ascii?Q?EI0mcgjV/NXFwHUTcJ+UvVBUnb6vrn9Ddpju3hXnbU4ttrvcZj0bEn8dE7j1?=
 =?us-ascii?Q?Va5lwlegdOirReoYRMjY5LmnNHmxorH2YfDbJtN3fIMjjGjEZgpU2WefS/QO?=
 =?us-ascii?Q?5C4n9gYjsEp7HTVi7GzShOXYRz7DJeTmHAgXYLpX5dBeq2Jq/gNmqNgP96sD?=
 =?us-ascii?Q?SmZOT0h0SeOLL81mTGwzKEFSYVYkLX9/OQVGiYkP/7EmrPymRF5NkqwLs7HE?=
 =?us-ascii?Q?fjkQUdO/mW6Ide61ZGV4M8z9V/TvsEZjBeM/wUW0uQo/+LjGp79ojvDBJemA?=
 =?us-ascii?Q?sxnk1Ls0boBb52dNimtx3fbgxB5/3gl2xO/rYpE3Rj15dxhhd+c6v7vmp51m?=
 =?us-ascii?Q?ytR/52rmYZESeIMzm1aR3gJycKsyVBZUmEZcA/bDLUm6DpaLL4TFDf6mn1k5?=
 =?us-ascii?Q?tu5+GBmfnq9vvTztDtsIWn5iPOdKMihcSwKLzfYQkwqF61lA3TS/T6DK6/Q9?=
 =?us-ascii?Q?+msQlqFbzH8H90K/8WAl9F2DlRwg5lCaUFCRUy1q0ST00nVdp2XXli+7S+O2?=
 =?us-ascii?Q?M30SvXUNL+HRzrolka6REKBa51V+4LAhJ0zoFE5Qgx9RRGcmxsD1WIsp/UeT?=
 =?us-ascii?Q?Zt5d2wqHpd1qDaMeF88UVCpCy54fZk5pq5TwOimI3POgAuM3UudXMe9vLvYo?=
 =?us-ascii?Q?4NtaNc38Rr+mf9XAN6w/5OeaXzh/bO5gg/7SqQQRZIu/3Cw/gbkgI39+OiIO?=
 =?us-ascii?Q?vLgEden5/5gE6mUqrvZknsdUmRUXBdvWmEgTu5XuP0CFyFWKOf8OTLBnD30x?=
 =?us-ascii?Q?blIeVoRtsv0DGu+t9eh3xxl8yuR9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V+eNb3mI2W1XRlCj/KrGQU9urdV6UpwAqYcddnIaBEFpqav1Q/RCrscZVpBj?=
 =?us-ascii?Q?LYDkMEqeG3iA7st4pSCyi1nF4swmhdhdmws0EuI78amDNozQwMnMZcGGHwRw?=
 =?us-ascii?Q?n20OtaDiWfMxrIKReyQzue4FdZnfhLd5D1Lk+ihMJ8J+83dsUG4kOp7S0WL4?=
 =?us-ascii?Q?TOyjD57ArQPy/t5O38zFW23xKRzEpw3dvZJHFOWYDfdq1TKQ0cmbpN/nZvYM?=
 =?us-ascii?Q?TgXdWFxlD98HRKYLFXqcaWMI8RkkPVaZ0v4TSq0cIWGzAG+Kh8o2lGA/N5ZH?=
 =?us-ascii?Q?3MmybvuOurnINiUpRPnmed1sXmXXN/pBrGnk13F7bfVq44LQ7c0+oVGApCn6?=
 =?us-ascii?Q?DDPv+wBbzE2ClZsXqa09jmzi6E8+H9RBau9H/BPIwDsKypa9J8p3lrUV4yhb?=
 =?us-ascii?Q?NzvR3y9DgQoGqQEI95bwqg85w6wp/rSQGC9P9LSSyDiHijdrERA0/HzIZAGH?=
 =?us-ascii?Q?cXU85Joa5fSFQSZ37nWWyvpG1qQhDi1Pr60V5vQy8Db+At2hfydhlBGLE3FK?=
 =?us-ascii?Q?qRJ3LquHUSnUtkkGOTddtt8Kj8g+tUgDyKoxUd0kCCwd6BEeqKOZ+BFM2jzs?=
 =?us-ascii?Q?cMM/GQB48d+zfYDcrDgn6CfF4mRrNniHEIAD3Qy3AUcLcmBUcdhunA93eBSp?=
 =?us-ascii?Q?r9+5qlEK98VwyMExelL/BuY/JJenXKXM3qD2hX9RVym6RrJ6IyYBNSkudXR/?=
 =?us-ascii?Q?Zlf4SESyJw2bNdDODIJpqgH5Si04ESj2KdxIOmUjpWyPbg3P6XJKaNSfXzvh?=
 =?us-ascii?Q?nipK9SDcuiYVpcdTiDa9Bbb9cHkdFhBJdrkIoBj3+EppeSaI/EhBAQm7j0tm?=
 =?us-ascii?Q?XZvdKR7Z8OEQwGZWFtWDPV4lc817HU0yKljXJGlcIJVEjQnhMiKMhQi0ubpA?=
 =?us-ascii?Q?VauwywsXPCwPxQ9SSCkXXciTLGE7N2KJAh9gbBTi+UFsT+12JjW+HvOGNt33?=
 =?us-ascii?Q?9JEmI1cRbJOzGfLPEEpmxXy+cgA/mPba+u6UjZU0lCpc4xhjNFQYEwIBdvgL?=
 =?us-ascii?Q?VBA3t+drVHSBtGusVhA94VfQsLLV932/A3uGCs+FVN6LSmrRV0FGLLiDdi+9?=
 =?us-ascii?Q?rFSt0qavIBpHuVDSSo9h6yANeKh10UGmbYAyyfkjjOt8uHRjXYM+2MeC9Skt?=
 =?us-ascii?Q?/ZYdmCziyj2Zhz50vJvAOVtbHAB1mP5JnNr+VHYb5lm6+FCoRFmYCOOFGrtw?=
 =?us-ascii?Q?D8dLPE1bDDF5glUpV07B6MOj4DiAvumqKxA3gL2RltyriAlWS0Civg6yATXd?=
 =?us-ascii?Q?IR8KmP3ZqlaBBU01/Lwy8oDoPFyRvLDIEN5NNmfhgk64bT/WRvvtgp80i+1G?=
 =?us-ascii?Q?82hY46qSdSeHTQ8rPdis0n+sxioML6JFrJ3B6QVw1u0Jw0TbukRKqBsuNizX?=
 =?us-ascii?Q?JH9Qr9s9+AmT220k8qqY6uYQoOFfVDEi5Ao2akpZp4KbwgrNbM63lfZP238M?=
 =?us-ascii?Q?eNSbCCkhufa0zINABJ1Z84g3sWAUiYiV3lQFfSy6EcWgn5uHrJG4nfBW1vUw?=
 =?us-ascii?Q?qAeVu7CHd1F4T2fEdw4h7Ym6ZhD4j2O/Nhf68aQCtlI4xTKZAxwyOnKN3XfO?=
 =?us-ascii?Q?k70dr3DS/GZ5cdYThZeCiaKaUhzcU0xtiJsUe8vjxW/xdl/GQduyHfLG4/kc?=
 =?us-ascii?Q?cQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d690e8f-b0ed-4414-0f9d-08dd58108a26
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:57:02.0884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 113m+5dkIn12ZDMvlD0JdVjue1yA59eZ8VTV3qODKfJs2u8E/UGqrienp0UhFnY6FI9A4Ar36YsnA9xlyN6CVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9118

This adds support for registering Broadcast Code request callback with
shared/bap, to be called when a BAP Scan Delegator needs to receive the
Code from peer Broadcast Assistants.
---
 src/shared/bap.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/bap.h | 17 +++++++++
 2 files changed, 115 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index aa4b1aa86..8b5010f32 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -88,6 +88,13 @@ struct bt_bap_bis_cb {
 	void *data;
 };
 
+struct bt_bap_bcode_cb {
+	unsigned int id;
+	bt_bap_bcode_func_t func;
+	bt_bap_destroy_func_t destroy;
+	void *data;
+};
+
 struct bt_bap_cb {
 	unsigned int id;
 	bt_bap_func_t attached;
@@ -189,6 +196,7 @@ struct bt_bap {
 	struct queue *ready_cbs;
 	struct queue *state_cbs;
 	struct queue *bis_cbs;
+	struct queue *bcode_cbs;
 
 	bt_bap_debug_func_t debug_func;
 	bt_bap_destroy_func_t debug_destroy;
@@ -4226,6 +4234,16 @@ static void bap_bis_cb_free(void *data)
 	free(bis_cb);
 }
 
+static void bap_bcode_cb_free(void *data)
+{
+	struct bt_bap_bcode_cb *cb = data;
+
+	if (cb->destroy)
+		cb->destroy(cb->data);
+
+	free(cb);
+}
+
 static void bap_ep_free(void *data)
 {
 	struct bt_bap_endpoint *ep = data;
@@ -4265,6 +4283,7 @@ static void bap_free(void *data)
 	queue_destroy(bap->ready_cbs, bap_ready_free);
 	queue_destroy(bap->state_cbs, bap_state_free);
 	queue_destroy(bap->bis_cbs, bap_bis_cb_free);
+	queue_destroy(bap->bcode_cbs, bap_bcode_cb_free);
 	queue_destroy(bap->local_eps, free);
 	queue_destroy(bap->remote_eps, bap_ep_free);
 
@@ -4348,6 +4367,7 @@ struct bt_bap *bt_bap_new(struct gatt_db *ldb, struct gatt_db *rdb)
 	bap->streams = queue_new();
 	bap->state_cbs = queue_new();
 	bap->bis_cbs = queue_new();
+	bap->bcode_cbs = queue_new();
 	bap->local_eps = queue_new();
 
 	if (!rdb)
@@ -7350,3 +7370,81 @@ done:
 
 	return ret;
 }
+
+void bt_bap_req_bcode(struct bt_bap_stream *stream,
+				bt_bap_bcode_reply_t reply,
+				void *reply_data)
+{
+	const struct queue_entry *entry;
+
+	if (!bap_stream_valid(stream))
+		return;
+
+	bt_bap_stream_ref(stream);
+
+	if (!bt_bap_ref_safe(stream->bap))
+		goto done;
+
+	entry = queue_get_entries(stream->bap->bcode_cbs);
+
+	while (entry) {
+		struct bt_bap_bcode_cb *cb = entry->data;
+
+		entry = entry->next;
+
+		if (cb->func)
+			cb->func(stream, reply, reply_data, cb->data);
+	}
+
+	bt_bap_unref(stream->bap);
+
+done:
+	bt_bap_stream_unref(stream);
+}
+
+unsigned int bt_bap_bcode_cb_register(struct bt_bap *bap,
+				bt_bap_bcode_func_t func,
+				void *user_data,
+				bt_bap_destroy_func_t destroy)
+{
+	struct bt_bap_bcode_cb *cb;
+	static unsigned int id;
+
+	if (!bap)
+		return 0;
+
+	cb = new0(struct bt_bap_bcode_cb, 1);
+	cb->id = ++id ? id : ++id;
+	cb->func = func;
+	cb->destroy = destroy;
+	cb->data = user_data;
+
+	queue_push_tail(bap->bcode_cbs, cb);
+
+	return cb->id;
+}
+
+static bool match_bcode_cb_id(const void *data, const void *match_data)
+{
+	const struct bt_bap_bcode_cb *cb = data;
+	unsigned int id = PTR_TO_UINT(match_data);
+
+	return (cb->id == id);
+}
+
+bool bt_bap_bcode_cb_unregister(struct bt_bap *bap, unsigned int id)
+{
+	struct bt_bap_bcode_cb *cb;
+
+	if (!bap)
+		return false;
+
+	cb = queue_remove_if(bap->bcode_cbs, match_bcode_cb_id,
+						UINT_TO_PTR(id));
+	if (!cb)
+		return false;
+
+	bap_bcode_cb_free(cb);
+
+	return false;
+}
diff --git a/src/shared/bap.h b/src/shared/bap.h
index adb531b4c..359147b69 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -44,6 +44,12 @@ typedef void (*bt_bap_bis_func_t)(uint8_t bis, uint8_t sgrp,
 		struct iovec *caps, struct iovec *meta,
 		struct bt_bap_qos *qos, void *user_data);
 
+typedef void (*bt_bap_bcode_reply_t)(void *user_data, int err);
+
+typedef void (*bt_bap_bcode_func_t)(struct bt_bap_stream *stream,
+				bt_bap_bcode_reply_t reply, void *reply_data,
+				void *user_data);
+
 /* Local PAC related functions */
 struct bt_bap_pac_qos {
 	uint8_t  framing;
@@ -279,3 +285,14 @@ bool bt_bap_bis_cb_unregister(struct bt_bap *bap, unsigned int id);
 void bt_bap_bis_probe(struct bt_bap *bap, uint8_t bis, uint8_t sgrp,
 	struct iovec *caps, struct iovec *meta, struct bt_bap_qos *qos);
 void bt_bap_bis_remove(struct bt_bap *bap);
+
+void bt_bap_req_bcode(struct bt_bap_stream *stream,
+				bt_bap_bcode_reply_t reply,
+				void *reply_data);
+
+unsigned int bt_bap_bcode_cb_register(struct bt_bap *bap,
+				bt_bap_bcode_func_t func,
+				void *user_data,
+				bt_bap_destroy_func_t destroy);
+
+bool bt_bap_bcode_cb_unregister(struct bt_bap *bap, unsigned int id);
-- 
2.43.0

