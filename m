Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2083.outbound.protection.outlook.com [40.107.105.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BF07762B
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jan 2024 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="o4j162/d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cjk1CSzCGL2qy2lxO0+R4+jl4gh18y45LThearjopIsluECXDvVw1x74J8X18E+uCIv06jHGKPLUPYni+rYaKqAb5Iry3hyxkN2gvPu5ODGgGqtTdD9q+pTN0omvkUdnNkL+cIAdiU1ArvWIJRepSh+KpAlrKi3tOPoP2GdDUsXC6F9ZkS2RHiJjnwWiFqHN0gZi7Zv/hSg1tos/NfBe+ai/AgzsQMLSCMJ86HdzjykgzoWScXfpp/5Cwv/ctyQGekeW73ftk0skMLlNZhpD9rj2tWF0mrceCVOlFbeJIQRTmVNPtGeuCyAgwwayUvT+eJqdbukuZZgZKC+AYAyT8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iv5SlHbYsM71MW9sNvAiCu9iI4qLz3qxz3fn14MSKN8=;
 b=N6TdLak9BoWmEqfqQ8SvHT+mqbDVfKZqF8NGIXkFCZti/eJu7cMnTC8vZ19O88DOWSlq7Q5QwNGmaX4yBboMvRH0mnBeyopvXizp1rWGPrii03WzohzQLMgIPiENhG7u6NHGJYO6oQnCZCQRL9r4SfeGPYNrd2WOvAJfNWpann6H26kvIrU2UkjmKXitOc6zTLoCbWdOCHM/ZssB6fTpytKQxe9jHndjVM9ScK2eckUW+pBYJOv+BjpCMWjc66suMJhPDOsQ4mnJQucEKdv+RiWnUYG9v5nBsecjU8YijRoIJinb+bzGTKYoBJs1rct+EQxq2tXdDnAfTaI43l5NRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iv5SlHbYsM71MW9sNvAiCu9iI4qLz3qxz3fn14MSKN8=;
 b=o4j162/doywM5PzbkM02ccEloe014K40fJ/7F3OEyyXNnpuSUwZbWAfWeSvz4PrHi3ftJcJCSmqpOpWwCrPR+uOwIPojZld1SiiwlvGp4gOqGQtgi+e46KAJFRoWj0JdnUyLDr80h65oxmqjaJaSDbp4OzEoGZElN9K6hYXftQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by PA4PR04MB9568.eurprd04.prod.outlook.com (2603:10a6:102:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 16:56:10 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 16:56:10 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v2 2/2] shared/bap: Code for dynamically generated BASE
Date: Fri, 12 Jan 2024 18:56:01 +0200
Message-Id: <20240112165601.134073-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112165601.134073-1-silviu.barbulescu@nxp.com>
References: <20240112165601.134073-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0004.eurprd03.prod.outlook.com
 (2603:10a6:208:14::17) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|PA4PR04MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: fae6b4da-a3d9-49aa-123c-08dc138f60ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2psMeLNvc9hUo/ZanbLFetb5yFpiJyYHtS6k0Ty0KxlNgabVq+cPPpwhDNANFBVsr4byuWZi4v6DpXOFtLMngUCDdhOtmrGFQzSxXNnniw0NbfRlyczHwyXmn3jTMv95kd88grodk2AXdw6qeMFEbtIiaz/etPKdUZd6iYcE8ivnpWBkrUIKJ6ClU3a1D9LiNlX1YPSoVo02ObiVDud9lv3MYVB6GMAAsg7yuY82ODXwCURZvwHtB3qqEia6kK6bSFGVgyKWb126pzUBwQWs+x5oJiyxJyKI7qixBmKoN0danRq/Br8Qw0OsdUBA3lAbAyuMPdPE28s3dob5Dh9xWwboTR5l7BY5+3U44Z2h3L8B2SjA7j6uW0y2yXKtrItd4AQRjMpEUWj5IIW6ShhlQwGcJCBfLUmqkZxExb3zcbwTnfpSEWxcwTGRaAKd2IRcHwz9vBRDSpkPtaV5Ilobzp2IBgw4XV4YC8CfM8nZoEMbWSX7zuhI0YHEE6s5ozXhgaHcTw/UTBSgQahX05Pp1agmQjXg4IlmPqiqlz2/seslhyH/f8DPObOq1Hjr8Wzm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(6916009)(316002)(66476007)(66556008)(66946007)(2616005)(1076003)(26005)(30864003)(6486002)(478600001)(6666004)(6506007)(6512007)(41300700001)(5660300002)(2906002)(38100700002)(8936002)(8676002)(4326008)(86362001)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?skrgyXBUwpBi/omnHcmvvC0TtHuTqKARnNkHd4KV6paMVcLgE/wQAIVkAJmJ?=
 =?us-ascii?Q?OVgh1fZKHdYx3qdR0v8I/GpY2zJkMmBPJe+WeVhYXiecgyEcnoODT06fCwWs?=
 =?us-ascii?Q?0gprEZGqKTGloFbclESGTSlmiReLQDs/xD+WN1XRMp7ZlShRkYpfpjXSeEAp?=
 =?us-ascii?Q?yFSbluAWjOG4aK+auDcWbazX13fDcInwHNznmIEFzma9MiOubZaaIfV5ZBgR?=
 =?us-ascii?Q?QuSGzLoEy/5rB3YWKB1Z+1eZY7XI03B46xGbhPWgcPvXFBYMJVUtnYyaUy3k?=
 =?us-ascii?Q?gEUp8V91aI6pCvzEWGwEuQop3cWIwXofkG4HEK7h9GbPlmNX+wtt9j6TWaKW?=
 =?us-ascii?Q?MH9phjl6flzUoP7b6Ejjj/L8goF7r1gq4KaVhq2yf6A6k4zoiR9F9JoaUqwb?=
 =?us-ascii?Q?8gYbopvF0l99zxBw7L5IK9KtW45vzUZzPz76aUW54a3ykWhsxt8HkbhhOmCD?=
 =?us-ascii?Q?bbe1ySiHhpPDcKiyuEqBPCohDqwRfEO0NwVFI/QFQbsF9zXDZA3sXbZ5RGee?=
 =?us-ascii?Q?sJVHAN49xvOn4XvztWsJXjERwvQPCI0D41OwfwAXpbTswnJz0CdSkAhixnH9?=
 =?us-ascii?Q?iS/CKrHKR6yCNXIZ/4y1UraxiG6jFzgrtYyX5iDmdTcWm9/I1c54NHENxTHv?=
 =?us-ascii?Q?H2dgG4tbSJ8bjW8YwgZDV7JYEIdDdsXBjQoVZxaoduIyCxnBhMuv2UAyYpMo?=
 =?us-ascii?Q?hpAljhs3oSPyKsH/LU2W6iMiiqnpL0xV7bkueyiZ/FziOoV0Cde45KEcSLrM?=
 =?us-ascii?Q?3EkM7rDquYJBsEtpz/9TvvF3LnmvuBea/irw4I4ukwll68zj6bbcKGn2ynr9?=
 =?us-ascii?Q?vw12j25uMwy3Tco5Ixg2sihqdEStPGdPR3JKM/Kgto8leIJ9IdVLz6fojEnW?=
 =?us-ascii?Q?G62V4qXCTz/OYfJvQL2IInFf3P0W1OpOb3vjdYI2Cjp5vim+P6HtGtZNzCP3?=
 =?us-ascii?Q?sl/7v/z2iNwlBtCAlLVCA+KkP9aG6w/b1+XqcLz/mZOyMwjsc2SoQGsHm0vz?=
 =?us-ascii?Q?T/AUT/2KdTRN02bcbl/hInq69Rr2VH3A0MwDLohvli7aApLcNIJp7OyjquXH?=
 =?us-ascii?Q?/YE0qoGDlhgYOO7d3wVej3J/bwFjXjP3kEE7YnsHAxMJ24zEgABNdi2AJ1ss?=
 =?us-ascii?Q?XQIVQ1FhV25snAomkZAaGW0TyL5ZZ6hKhUR9r9HF+Vgtr3Cwwa53txoBM3DU?=
 =?us-ascii?Q?2v4Uv5LDAcw6TezF/7iAujqLaEu+6k/gACzauyeHVZiNMBeWU+eQtyDgyLA0?=
 =?us-ascii?Q?umMjXAAa+vb1ab7sBSQaIl/PXOlkHMd3/uhSRde3SPOQBTJJkn7TzP0bxWmW?=
 =?us-ascii?Q?M5bpLkoKUX7D+lfbeKm3ZgiAOJ6YeMJ9UIJ9wLzW+UjPTKrgFYDxOnzncQsy?=
 =?us-ascii?Q?l6WrbrghA/+Xlaz5Vhe6Jrq5iAIHlmEwHncUO/aZ4slrsT+l1QhUSTHxtly4?=
 =?us-ascii?Q?dbbLPsBrV0ZCnwALOzpXZGF0GcoLuXsBrsj3GxA9mGzXklaA5gCU0wJGChhH?=
 =?us-ascii?Q?7N9TNNEYi71xBTI9+b1fcN1VIcRhRB/K2ua7WediWUp2xj2C7MAPdMChdXhf?=
 =?us-ascii?Q?YZJ2jm10oB6vdUAeJdqqYBx6kcZg5jUkFYiwHoa86GzIevL1hcnLxoa84KgO?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae6b4da-a3d9-49aa-123c-08dc138f60ad
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 16:56:10.5008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zl1W43Air4pLCa0NSwtrWVEDK98e4YpNWjY+WriucEvlPWFb9+qAJ+yoJCuiRt8OtuC/LMXmEXVx9fJ9GMKU4BG66Q0jH5dFE57RciYaYf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9568

Add code to support dynamically generated BASE from presets

---
 src/shared/bap.c | 492 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/bap.h |   2 +
 2 files changed, 494 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 49eb8d057..fca6ab9cf 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -226,6 +226,7 @@ struct bt_bap_stream {
 	struct bt_bap_stream_io *io;
 	bool client;
 	void *user_data;
+	struct queue *bcast_links; /* Linked streams from the same BIG */
 };
 
 /* TODO: Figure out the capabilities types */
@@ -255,6 +256,30 @@ struct bt_pacs_context {
 	uint16_t  src;
 } __packed;
 
+struct bt_base_data {
+	uint32_t pres_delay;
+	struct queue *base_data_subgroup;
+};
+
+struct bt_stream_base_data {
+	struct queue *ltv_caps;
+	struct queue *ltv_meta;
+	struct bt_bap_stream *stream;
+};
+
+struct bt_base_data_subgroup {
+	uint8_t subgroup_index;
+	struct bt_bap_codec codec;
+	struct queue *ltv_caps;
+	struct queue *ltv_meta;
+	struct queue *bises;
+};
+
+struct bt_base_data_bis {
+	uint8_t bis_index;
+	struct queue *ltv_caps;
+};
+
 /* Contains local bt_bap_db */
 static struct queue *bap_db;
 static struct queue *bap_cbs;
@@ -826,6 +851,7 @@ static struct bt_bap_stream *bap_stream_new(struct bt_bap *bap,
 	stream->rpac = rpac;
 	stream->cc = util_iov_dup(data, 1);
 	stream->client = client;
+	stream->bcast_links = queue_new();
 
 	queue_push_tail(bap->streams, stream);
 
@@ -1010,6 +1036,14 @@ static void stream_io_unref(struct bt_bap_stream_io *io)
 	stream_io_free(io);
 }
 
+static void bap_stream_unlink(void *data, void *user_data)
+{
+	struct bt_bap_stream *link = data;
+	struct bt_bap_stream *stream = user_data;
+
+	queue_remove(link->bcast_links, stream);
+}
+
 static void bap_stream_free(void *data)
 {
 	struct bt_bap_stream *stream = data;
@@ -1020,6 +1054,9 @@ static void bap_stream_free(void *data)
 	if (stream->link)
 		stream->link->link = NULL;
 
+	queue_foreach(stream->bcast_links, bap_stream_unlink, stream);
+	queue_destroy(stream->bcast_links, NULL);
+
 	stream_io_unref(stream->io);
 	util_iov_free(stream->cc, 1);
 	util_iov_free(stream->meta, 1);
@@ -5492,3 +5529,458 @@ void bt_bap_update_bcast_source(struct bt_bap_pac *pac,
 	bap_pac_merge(pac, data, metadata);
 	pac->codec = *codec;
 }
+
+static void destroy_ltv(void *data)
+{
+	struct bt_ltv *ltv = data;
+
+	if (!ltv)
+		return;
+
+	free(ltv);
+}
+
+static void destroy_base_data_bis(void *data)
+{
+	struct bt_base_data_bis *bis = data;
+
+	if (!bis)
+		return;
+
+	queue_destroy(bis->ltv_caps, destroy_ltv);
+	free(bis);
+}
+
+static void destroy_base_data_subgroup(void *data)
+{
+	struct bt_base_data_subgroup *subgroup = data;
+
+	if (!subgroup)
+		return;
+
+	queue_destroy(subgroup->ltv_caps, destroy_ltv);
+	queue_destroy(subgroup->ltv_meta, destroy_ltv);
+	queue_destroy(subgroup->bises, destroy_base_data_bis);
+
+	free(subgroup);
+}
+
+static void destroy_stream_base_data(void *data)
+{
+	struct bt_stream_base_data *sbd = data;
+
+	if (!sbd)
+		return;
+
+	queue_destroy(sbd->ltv_caps, destroy_ltv);
+	queue_destroy(sbd->ltv_meta, destroy_ltv);
+	sbd->stream = NULL;
+	free(sbd);
+}
+
+static void append_ltv_to_base(void *data, void *user_data)
+{
+	struct bt_ltv *ltv = data;
+	struct iovec *base_iov = user_data;
+
+	if (!util_iov_push_u8(base_iov, ltv->len))
+		return;
+
+	if (!util_iov_push_u8(base_iov, ltv->type))
+		return;
+
+	if (!util_iov_push_mem(base_iov, ltv->len - 1, ltv->value))
+		return;
+}
+
+static void get_ltv_size(void *data, void *user_data)
+{
+	struct bt_ltv *ltv = data;
+	uint8_t *length = user_data;
+
+	*length = *length + ltv->len + 1;
+}
+
+static uint8_t get_size_from_ltv_queue(struct queue *ltv_queue)
+{
+	uint8_t length = 0;
+
+	queue_foreach(ltv_queue, get_ltv_size, &length);
+	return length;
+}
+
+static void generate_bis_base(void *data, void *user_data)
+{
+	struct bt_base_data_bis *bis = data;
+	struct iovec *base_iov = user_data;
+	uint8_t cc_length = get_size_from_ltv_queue(bis->ltv_caps);
+
+	if (!util_iov_push_u8(base_iov, bis->bis_index))
+		return;
+
+	if (!util_iov_push_u8(base_iov, cc_length))
+		return;
+
+	queue_foreach(bis->ltv_caps, append_ltv_to_base, base_iov);
+}
+
+static void generate_subgroup_base(void *data, void *user_data)
+{
+	struct bt_base_data_subgroup *bds = data;
+	struct iovec *base_iov = user_data;
+	uint8_t cc_length = get_size_from_ltv_queue(bds->ltv_caps);
+	uint8_t metadata_length = get_size_from_ltv_queue(bds->ltv_meta);
+
+	if (!util_iov_push_u8(base_iov, queue_length(bds->bises)))
+		return;
+
+	if (!util_iov_push_u8(base_iov, bds->codec.id))
+		return;
+
+	if (!util_iov_push_le16(base_iov, bds->codec.cid))
+		return;
+
+	if (!util_iov_push_le16(base_iov, bds->codec.vid))
+		return;
+
+	if (!util_iov_push_u8(base_iov, cc_length))
+		return;
+
+	queue_foreach(bds->ltv_caps, append_ltv_to_base, base_iov);
+
+	if (!util_iov_push_u8(base_iov, metadata_length))
+		return;
+
+	queue_foreach(bds->ltv_meta, append_ltv_to_base, base_iov);
+
+	queue_foreach(bds->bises, generate_bis_base, base_iov);
+}
+
+static struct iovec *generate_base(struct bt_base_data *base)
+{
+	struct iovec *base_iov = new0(struct iovec, 0x1);
+
+	base_iov->iov_base = util_malloc(BASE_MAX_LENGTH);
+
+	if (!util_iov_push_le24(base_iov, base->pres_delay))
+		return NULL;
+
+	if (!util_iov_push_u8(base_iov,
+			queue_length(base->base_data_subgroup)))
+		return NULL;
+
+	queue_foreach(base->base_data_subgroup, generate_subgroup_base,
+				base_iov);
+
+	return base_iov;
+}
+
+static void get_max_bises_index(void *data, void *user_data)
+{
+	struct bt_base_data_bis *bdb = data;
+	uint8_t *bis_index = user_data;
+
+	if (bdb->bis_index > *bis_index)
+		*bis_index = bdb->bis_index + 1;
+	else if (bdb->bis_index == *bis_index)
+		*bis_index = *bis_index + 1;
+}
+
+static void get_bises_index(void *data, void *user_data)
+{
+	struct bt_base_data_subgroup *bds = data;
+	uint8_t *bis_index = user_data;
+
+	queue_foreach(bds->bises, get_max_bises_index, bis_index);
+}
+
+static uint8_t get_bis_index(struct queue *subgroups)
+{
+	uint8_t bis_index = 1;
+
+	queue_foreach(subgroups, get_bises_index, &bis_index);
+	return bis_index;
+}
+
+static void add_new_bis(struct bt_base_data_subgroup *subgroup,
+			uint8_t bis_index, struct queue *ltv_bis_caps)
+{
+		struct bt_base_data_bis *bdb = new0(struct bt_base_data_bis, 1);
+
+		bdb->bis_index = bis_index;
+		bdb->ltv_caps = ltv_bis_caps;
+		queue_push_tail(subgroup->bises, bdb);
+}
+
+static void add_new_subgroup(struct queue *subgroups,
+			struct bt_stream_base_data *base_data)
+{
+		struct bt_bap_pac *lpac = base_data->stream->lpac;
+		struct bt_base_data_subgroup *bds = new0(
+					struct bt_base_data_subgroup, 1);
+		uint16_t cid = 0;
+		uint16_t vid = 0;
+
+		bt_bap_pac_get_vendor_codec(lpac, &bds->codec.id, &cid,
+				&vid, NULL, NULL);
+		bds->codec.cid = cid;
+		bds->codec.vid = vid;
+		bds->ltv_caps = base_data->ltv_caps;
+		bds->ltv_meta = base_data->ltv_meta;
+		base_data->ltv_caps = NULL;
+		base_data->ltv_meta = NULL;
+		bds->bises = queue_new();
+		base_data->stream->qos.bcast.bis = get_bis_index(subgroups);
+		add_new_bis(bds, base_data->stream->qos.bcast.bis,
+						queue_new());
+		queue_push_tail(subgroups, bds);
+}
+
+static bool ltv_match(const void *data, const void *match_data)
+{
+	const struct bt_ltv *ltv1 = data;
+	const struct bt_ltv *ltv2 = match_data;
+
+	if (ltv1->len == ltv2->len)
+		if (ltv1->type == ltv2->type)
+			if (memcmp(ltv1->value, ltv2->value, ltv1->len - 1)
+						== 0)
+				return true;
+	return false;
+}
+
+
+static bool compare_ltv_lists(struct queue *ltv_list1, struct queue *ltv_list2)
+{
+	const struct queue_entry *entry;
+	/* Compare metadata length */
+	if (queue_length(ltv_list1) != queue_length(ltv_list2))
+		return false;
+
+	/* Compare metadata ltvs */
+	for (entry = queue_get_entries(ltv_list1); entry; entry = entry->next) {
+		struct bt_ltv *ltv = entry->data;
+
+		if (!queue_find(ltv_list2, ltv_match, ltv))
+			return false;
+	}
+
+	return true;
+}
+
+static struct queue *compare_caps_ltv_lists(
+		struct queue *subgroup_caps, struct queue *bis_caps)
+{
+	struct queue *ltv_caps = queue_new();
+	const struct queue_entry *entry;
+
+	/* Compare metadata ltvs */
+	for (entry = queue_get_entries(bis_caps); entry;
+					entry = entry->next) {
+		struct bt_ltv *ltv = entry->data;
+
+		if (!queue_find(subgroup_caps, ltv_match, ltv))
+			queue_push_tail(ltv_caps, ltv);
+	}
+
+	if (queue_isempty(ltv_caps)) {
+		queue_destroy(ltv_caps, NULL);
+		return NULL;
+	} else
+		return ltv_caps;
+}
+
+static void remove_ltv_form_list(void *data, void *user_data)
+{
+	struct bt_ltv *ltv = data;
+	struct queue *ltv_caps = user_data;
+
+	queue_remove(ltv_caps, ltv);
+}
+
+static void set_base_subgroup(void *data, void *user_data)
+{
+	struct bt_stream_base_data *stream_base = data;
+	struct bt_base_data *base = user_data;
+	struct queue *ltv_caps;
+
+	if (queue_isempty(base->base_data_subgroup)) {
+		add_new_subgroup(base->base_data_subgroup, stream_base);
+	} else {
+		/* Verify if a subgroup has the same metadata */
+		const struct queue_entry *entry;
+		struct bt_base_data_subgroup *subgroup_base = NULL;
+		bool same_meta = false;
+
+		for (entry = queue_get_entries(base->base_data_subgroup);
+						entry; entry = entry->next) {
+			subgroup_base = entry->data;
+			if (compare_ltv_lists(subgroup_base->ltv_meta,
+					stream_base->ltv_meta)) {
+				same_meta = true;
+				break;
+			}
+		}
+
+		if (!same_meta) {
+			/* No subgroup with the same metadata found.
+			 * Create a new one.
+			 */
+			add_new_subgroup(base->base_data_subgroup,
+				stream_base);
+		} else {
+			/* Subgroup found with the same metadata
+			 * get different capabilities
+			 */
+			ltv_caps = compare_caps_ltv_lists(
+					subgroup_base->ltv_caps,
+					stream_base->ltv_caps);
+
+			queue_foreach(ltv_caps, remove_ltv_form_list,
+				stream_base->ltv_caps);
+			stream_base->stream->qos.bcast.bis = get_bis_index(
+				base->base_data_subgroup);
+			add_new_bis(subgroup_base,
+					stream_base->stream->qos.bcast.bis,
+					ltv_caps);
+		}
+	}
+}
+
+static void set_device_presentation_delay(void *data, void *user_data)
+{
+	struct bt_stream_base_data *sbd = data;
+	struct bt_base_data *base = user_data;
+	struct bt_bap_qos *qos = &sbd->stream->qos;
+
+	if (base->pres_delay < qos->bcast.delay)
+		base->pres_delay = qos->bcast.delay;
+}
+
+static void parse_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
+					void *user_data)
+{
+	struct queue **ltv_queue = user_data;
+	struct bt_ltv *q_ltv_elem = malloc(sizeof(struct bt_ltv) + l);
+
+	q_ltv_elem->len = l + 1;
+	q_ltv_elem->type = t;
+
+	memcpy(q_ltv_elem->value, v, l);
+
+	if (!*ltv_queue)
+		*ltv_queue = queue_new();
+	queue_push_tail(*ltv_queue, q_ltv_elem);
+}
+
+/*
+ * Extract Codec Specific configurations and Metadata information
+ * that will be use in the BASE creation
+ */
+static struct bt_stream_base_data *get_stream_base_info(
+			struct bt_bap_stream *stream)
+{
+	struct bt_stream_base_data *sbd = new0(struct bt_stream_base_data, 1);
+	struct iovec *stream_caps_iov = util_iov_dup(
+			stream->cc, 1);
+	struct iovec *stream_meta_iov = util_iov_dup(
+			stream->meta, 1);
+
+	/*
+	 * Copy the Codec Specific configurations from stream
+	 */
+	if (stream_caps_iov != NULL) {
+		if (!util_ltv_foreach(stream_caps_iov->iov_base,
+				stream_caps_iov->iov_len, NULL,
+				parse_ltv, &sbd->ltv_caps)) {
+			DBG(stream->bap,
+			"Unable to parse Codec Specific configurations");
+			goto fail;
+		}
+	}
+
+	/*
+	 * Copy the Metadata from stream
+	 */
+	if (stream_meta_iov != NULL) {
+		if (!util_ltv_foreach(stream_meta_iov->iov_base,
+				stream_meta_iov->iov_len, NULL,
+				parse_ltv, &sbd->ltv_meta)) {
+			DBG(stream->bap,
+			"Unable to parse metadata");
+			goto fail;
+		}
+	}
+
+	sbd->stream = stream;
+
+	util_iov_free(stream_caps_iov, 1);
+	util_iov_free(stream_meta_iov, 1);
+
+	return sbd;
+
+fail:
+	util_iov_free(stream_caps_iov, 1);
+	util_iov_free(stream_meta_iov, 1);
+
+	if (sbd->ltv_caps)
+		queue_destroy(sbd->ltv_caps, destroy_ltv);
+
+	if (sbd->ltv_meta)
+		queue_destroy(sbd->ltv_meta, destroy_ltv);
+
+	free(sbd);
+
+	return NULL;
+}
+
+static void get_stream_base_data(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	struct queue *streams_base_data = user_data;
+	struct bt_stream_base_data *sbd = get_stream_base_info(stream);
+
+	if (sbd)
+		queue_push_tail(streams_base_data, sbd);
+}
+
+/*
+ * Function to update the BASE using configuration data
+ * from each BIS in an BIG
+ */
+struct iovec *bt_bap_update_base(struct bt_bap_stream *stream)
+{
+	struct bt_base_data *base;
+	struct iovec *base_iov;
+	struct queue *streams_base_data = queue_new();
+	struct bt_stream_base_data *sbd = get_stream_base_info(stream);
+
+	/*
+	 * Extract Codec Specific configurations and Metadata information
+	 * that will be use in the BASE creation from all linked BISes
+	 */
+	queue_foreach(stream->bcast_links, get_stream_base_data,
+						streams_base_data);
+
+	queue_push_tail(streams_base_data, sbd);
+
+	base = new0(struct bt_base_data, 1);
+	base->base_data_subgroup = queue_new();
+
+	queue_foreach(streams_base_data, set_device_presentation_delay, base);
+
+	/*
+	 * Create subgroups and BISes in a BASE
+	 */
+	queue_foreach(streams_base_data, set_base_subgroup, base);
+
+	base_iov = generate_base(base);
+
+	queue_destroy(streams_base_data, destroy_stream_base_data);
+
+	queue_destroy(base->base_data_subgroup, destroy_base_data_subgroup);
+
+	free(base);
+
+	return base_iov;
+}
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 51edc08ab..725151fa5 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -88,6 +88,7 @@ struct bt_bap_bcast_qos {
 	uint16_t timeout;
 	uint8_t  pa_sync;
 	struct bt_bap_io_qos io_qos;
+	uint32_t delay;			/* Presentation Delay */
 };
 
 struct bt_bap_qos {
@@ -321,3 +322,4 @@ void bt_bap_update_bcast_source(struct bt_bap_pac *pac,
 
 bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct bt_bap_pac *pac);
 
+struct iovec *bt_bap_update_base(struct bt_bap_stream *stream);
-- 
2.39.2

