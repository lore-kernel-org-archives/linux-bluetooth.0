Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2052.outbound.protection.outlook.com [40.107.20.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05002C1BE
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jan 2024 22:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ORAPjl6/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4EEAek0IZje6Wgqmgg7xoknScJrsvr3oUpmLUMWX4bFsvwvo+lt/Is/zou7AkunvMWMh1NohCt08BFGIryzIpS95yYnchzT+M9HYqgFdtTpwfISsxcUjWBH5AGrkLM+cyx1ZIXkF1/KnqgFM/afWy/d9JVcLbUJm+HDwQP9blLj8SnNcsB2Dzi4JcHxV3aHIHWT45bcfmIZ4+T0T/5GSCb1DOqttMfJX3M+C4RtzinHKtJB4Oqz9yyy1LWU9sow6hnEYJClpZZHZCsBKbnrVbmqpbvu2nIGFTqs//I3sBVNY+JADk8j/OlvYuycOnaMcy0Fd2tyQE9s4Bi/+DbBqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iv5SlHbYsM71MW9sNvAiCu9iI4qLz3qxz3fn14MSKN8=;
 b=Al/uYN8pKbZWVJPfQ4m5ucnae4n1PwYOovIieJ+0yC/mUgOxpBU0mkaHMXPgLVrZFMBNzbgoLHwYBKMK2hinPJ4XGiNCT77Uu6xQz+iSej+Sw5ida8bw8fD/v6couVLKBVtQxO8OzKrDjeejuSEChKzHgc+6oa9zEi6QqsxaDqhAXQspcvm3z9uz2JM4j9nMheopN2c/LKzgbaghKFBenmPPhSlqjN+bpGSLzyTUg0yURSOOfaj6b9MQDrd/7hJz0kZarhMRYiz6MTFzxK+Yh7RtA8I1E9B8IWSSbOTlWY5BJL8zBo1Loc6xAwrX4mc6akvbO1SnC1Ec3yxc53kekw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iv5SlHbYsM71MW9sNvAiCu9iI4qLz3qxz3fn14MSKN8=;
 b=ORAPjl6/2uxbxnyflWeWZjYnLIcIVsUiPoBzf8Vu3GJUOwQStdKw+Fuxi8PRMYbiDZ3vozcbefJQW9WoYJKR6SRApc6wpZGfjdsrtX+eGt2btniK/AzcYQt0Qq7eweL1kgid26ybxgpeVBnwjxO5vfeBL9XVQy/G9c2G24mhBIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AS8PR04MB8961.eurprd04.prod.outlook.com (2603:10a6:20b:42c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Sun, 14 Jan
 2024 22:41:15 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7181.019; Sun, 14 Jan 2024
 22:41:15 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH v3 2/2] shared/bap: Code for dynamically generated BASE
Date: Mon, 15 Jan 2024 00:41:04 +0200
Message-Id: <20240114224104.37716-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240114224104.37716-1-silviu.barbulescu@nxp.com>
References: <20240114224104.37716-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0070.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::47) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AS8PR04MB8961:EE_
X-MS-Office365-Filtering-Correlation-Id: da4e3a42-5182-4056-12c7-08dc1551ea69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OcA1tWCE8EgkLFKcO8hBX93Q3Xd0g9c9hDxCbpgyWM/9cyA8SSf4ncvai2Lw8or9nJRXC6edrwMpMy4lUpyFE7jwdyfUxhdABDLyqLUbuHnB4pifx7NrLIzGdTHwUyCv6YBYd2/zCd2DwKSDFWE2v6feGKPAKoLGqRB/+didbkdkWD3PgifRLON4hHXx8oRq9tDNKjvQ33c+F+1Eb7fWRjc1QAt/uRTeJ5QeHQKLcAd9mI/Kke2WJPVJuHMDjZJE68qZioB1m8GVPOOZuoJD5NVS6ubd7s0VevaGfiT70YXMIUqMqfTKf3GkjTlJUj8SloIlYRaA5YIWsTWGHNAR6xWI6/QB7ZfedAQ2CXAqDfjfk2L9QAEYliWz2jIrSt20tyxRoYVHtkgLLfaiNeJ6v8+vwaORoxqNa/a+HINQh4RqOqiGMnOltep9kP1hGaRqhkij21B178BuN7u10cOzJ53ilYDUI+CzofshkYngTsY2qT1vIQVrfix1Q5+ZiPuC7wld9RiX/owVdPj517S8OImBgSoT/PX9vCoj4K8VmKxdWUh2bydmNcA+t0Ma8FhG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(5660300002)(8676002)(4326008)(8936002)(30864003)(2906002)(6916009)(316002)(66476007)(66946007)(66556008)(6666004)(6512007)(6506007)(6486002)(478600001)(83380400001)(2616005)(26005)(1076003)(36756003)(41300700001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2UXA1Pym5ZJ98hjzpfMP1AJ6ADJ9ikB0m6g1o6JEBf0J0IzNM2d8O+XKgGXl?=
 =?us-ascii?Q?T7Mry4stmejYWFOwSdZNB2nswS54JemvWw/dnH9JYXXE1MlNuRoPTOWkl8Pb?=
 =?us-ascii?Q?r7Gi2TRtQaUparaQp8OqTeCv2LuIeayIT+8sG15rJCE8kq/GA8jNTGA0Ny6C?=
 =?us-ascii?Q?5n4QxfqTsaLEX+t1hnzont88tMxn21MQEBUZBmYFEP/TUiJF+SRrM0yEm6Iq?=
 =?us-ascii?Q?56Ema1dDMZpgSFA/bXjZbAqzNIfOwELtZGnRFGpfU+UOX8l2PmLStFOzAQMi?=
 =?us-ascii?Q?o3nYvV/27jBQf3BlCxx+hjEzEHu05ET9KgqcjYUScuxr3JEEhtzBtIrhcwcS?=
 =?us-ascii?Q?vkbWyzZW9+5HAcCLuxMswhzbd8Eu9NvPfOJkbPx7QSBJWpeCytLcn3GU8LtX?=
 =?us-ascii?Q?iybGldPp1DDM8YSrS6VVQQE2hHc7nU4BUMD8I5HmawvP3Hs3CmNB3tV4v7xI?=
 =?us-ascii?Q?VSlHwSNVEewLSo2olnO5hHx+R7VM63ZZGM8gIwitg3WogMF8Vb8QtdA57jvA?=
 =?us-ascii?Q?Zd8dS10ajuaihceUhDCnjtHuNfAUm9qaYmBb/kMajv3FNgOUZwt4/93sAfQD?=
 =?us-ascii?Q?vP2EA+5J3iF8umOXFgG4XG6YaL4HBRNggfJ5NAUMM+LcK3cwlwLHjWhRVFbC?=
 =?us-ascii?Q?O0YK1CPop3rBPHwijFO+A0gGinA8upb8Uzgy8+plxWyK+k/qbVQfZrOYgJlB?=
 =?us-ascii?Q?GojnzBGvQy23gGNdb0fjapbBHxGrt9iuXUAAnEOEfoLtHZ4ml7XtqC01XyvE?=
 =?us-ascii?Q?ixiUZhpOakG0h98cE6fMjvkJLPN5ytCZRlLcbGFtcDI3ibihQnj+PFtAak6s?=
 =?us-ascii?Q?dKS0wpeTfeMT7IsmN6b6k2YYOZYpPTVm08DLLd8nVMrFhXVwcOh9jkPCYoYs?=
 =?us-ascii?Q?QJNEhkeLUN1UHAC5r8Pby8cZSOmQfnh/rrKuxt16go/oByYkXV98TnA2FgIO?=
 =?us-ascii?Q?2sKBvqUmSlyX8bT3cYYoX4rdFJ8HBNX3zRzHTdmQhvm5G8sJXOi6Mqs9Ez1u?=
 =?us-ascii?Q?c5/PBIJUh/k+78qJCGRb1wo6wIAVhFNG27P5G+uHSxLh677TCXlP8QF6Giaj?=
 =?us-ascii?Q?sftOlBausOwymsj7VMzCfjAoVgTnM2qM8kcdGtpcxEZ3T+CRbmG+qlYs0lzv?=
 =?us-ascii?Q?vFLU64iNmvD1SAxtT4YgDfjE+RZ6HcuLV5qq+07tN42hurDCDxMw1XY9FcXF?=
 =?us-ascii?Q?cNAp+6Is8sdLg3n81+KajkBYvCJCQd+sQCy2dBuJJ7fLYPwiWVsI49AfL66h?=
 =?us-ascii?Q?8uwoO1OeYHkXmcUINUUiJr7CikBttoz70oI6LDGJXtEMkNjmYd60z53oNNdv?=
 =?us-ascii?Q?WErN0GpJgG41NJQtsUcOUwPA1blqrLkFGZjMCWKV5Z8ZzbshjhzCPuAdB+QW?=
 =?us-ascii?Q?rvwEqC87zFDbjPVaW4zeIEc95m7HuNTM8nIuoSTIA0TEIq92ZReWpqwH/HKY?=
 =?us-ascii?Q?iEBV30PBs8VjTkS10Hu2dKbrEp1YFvd+HVqgX+cGM2L/7TfiWNL9NpilYP3J?=
 =?us-ascii?Q?Mh/0vup571+zYy59Hb6pHFdwRJi+Kx/e11Pat/rMBHr+4Y45graeDmMPQXBd?=
 =?us-ascii?Q?aMTWDQ6hOQmtfuhOiCngJwdWdcr/dNZyLfKg3inJw00k8ZZsdIQp1U6wVTho?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da4e3a42-5182-4056-12c7-08dc1551ea69
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2024 22:41:15.0611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Mmcj21vtHYWinFNouj0psCyDTKSgMr3bk6t61MCzPVIhlfehmZHyYYONA1tjbPBnUmsrqUix9Aq18sh97Io/3UPV1dQvjb+3bXBi/9jzx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8961

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

