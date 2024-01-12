Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2047.outbound.protection.outlook.com [40.107.249.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFEA6DD13
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jan 2024 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qidtbdk2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7/v4TiuPuSUTzz/7jz9TP9iNlsy8cqOAymcNcm8lDqiE4tsCg0KFxlrd0hdmkhRraCMAn4HeNuHL5XbIcUVH6Vkj6fwJrA64kwv/EasL5SKD9IgpKk2zGXjQ4CBBz5yvgXkWi9//MV6KBdo6yKozUSjtnL0bcCaWTs9cpEHGt1eYWZYxNsRYqwUOWpTjEfqdxvMxvLDub2KKLt964dCbom7c8Sad03cQNfgSFrJLSXmaSwmNemgxDYHfGg6qpPBbKRpZlFZi5jKLfXe8Dypl2e6N7Xv/0sgSPTn3YbX4K+l+geLyYoVAKNGuKn8X1bWiyLHARmkdI1dKy8cz24NuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQM6b/te1ZGnEL1tSJ1XVu6x7gsP/F2nk0YJUFpwU+8=;
 b=HsfnY/XbQtQjqQt1MHSSW/txF/YFJ0DQtdMRCs9M2q6bDKJFBKNsM9X/j5o2D/oIP9huVMgeSbCsKoD/pTy/nzvGAOLM+ncmaO3mjY/9t3QKw7zfgPUXfh8vXimzrEOk16daKm7Kc0ryj8h+XUIGcZaQO9zqb5KqcGaa3EDlgviCz+rIX8h+d7nlIXWM7u+T7s6mE+mC/Aek1NABzbPXJ7wTqQhYzihhhBo1OtU88oZepiLN5BFCEcfhxa2Nd43OHu/bB0gTYvhEQPId/9D6CoAVz79nK2SEkA2K+aL2RlOW5POlsoNpSlx/hBIRPagK+Ke7vhF3uMb/ny4T67lOfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQM6b/te1ZGnEL1tSJ1XVu6x7gsP/F2nk0YJUFpwU+8=;
 b=qidtbdk2k0wElhvrXtYAO0/ykABgxxLnWnw3IM4uHJCSRxRVk86Jg1SpZFwp6/ogCueFFEf0r4W/SXrbhJejss/1H5zVesEGNGnsYqItGmU7ShMsElBCInvSIxLowbMFbeXjG0o/31UrNZjSFqbOw09jZZ5r3ytd0iqrgzjp+8c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by DUZPR04MB9781.eurprd04.prod.outlook.com (2603:10a6:10:4e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 14:40:50 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 14:40:50 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 1/1] shared/bap: Code for dynamically generated BASE
Date: Fri, 12 Jan 2024 16:40:44 +0200
Message-Id: <20240112144044.58051-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112144044.58051-1-silviu.barbulescu@nxp.com>
References: <20240112144044.58051-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0025.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::12) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|DUZPR04MB9781:EE_
X-MS-Office365-Filtering-Correlation-Id: f63db457-f135-43fd-22c6-08dc137c78dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NJb0QYyKW7mZ8vLkEQN3NS39UZnoyiaFSYfulSOT7au0babClWFuRn4h0eVyUBUdofTrMi90s/y4O6evXQm1F/awsDr5gGahHcJeQqvOktLzslXnZFtgzIAIL2d2DI/Q+xUmVirn9usnZVUImB5+U34cVkSG2EhfrsqmZHZpdwf5HCY2DRwJ91XHuKu1IMYhH7XbLW43NOIHyYk+IyWwV+F5WJb3q1NOcu8EZgHL8prYbHERPyu8Wry8I136noQpLRZqcAk4sdkbHBaElGX+PGk2V+AaAoLHDzI4RMZgV2FOHy4drN/GhU5u9vzN48BxQEE3v9QzDCkI7cSu1MWOKp49GNwOyZENXJQjEq3MvX8OjYBKt310jkaQbma+EyUX0CFspaYiUmkA4OpJxpkgdsdP9/tJx9c+ozdThbM60NiB1wfW0QwM++HPrqO47fb8hYV/8qc5rbtprfW3I/f9KVZI15ubrlPH3C8NtDuWDUvBu/gHVQcB1U4HvgR/FnrVDC3T5exP+er+yOcZEBI43iGOGc2nFKH+UgwZJcezYV8n6kafWoHtnhks/gVQ+FsN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(396003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2616005)(26005)(1076003)(6512007)(5660300002)(478600001)(6666004)(2906002)(6916009)(66476007)(66946007)(8676002)(8936002)(316002)(66556008)(6506007)(83380400001)(30864003)(6486002)(38100700002)(4326008)(36756003)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Q1eNfWXCPerHQmTq8/3uAqxuKUiLnzsvoy/BXWJD4xCtKERp80CbcHs6f2K?=
 =?us-ascii?Q?JFftX+Yr+f1krPUzTKyAaYB5G1/zWjWKiv+WkBo90eoOPmIAWCNaxdPBKUjG?=
 =?us-ascii?Q?rXaOfXCv+DHHNkVrEGHz/+a4i1F1Wby49KtWjF3wjWnmA+J3+VNhBAqHZbGc?=
 =?us-ascii?Q?iYz4/zrlfPTXd8UjA9Z4VeHeswLGcTmh+vYj2x9ZnmvzWqWy2lENOPu33hIF?=
 =?us-ascii?Q?NMrQt+JJezwvGGvrwLMcyLOIM3AEjE6132LL9IBX1ILLWPhaWL6VCqZvmfKI?=
 =?us-ascii?Q?d5GRfPXwrXL3iti9kEWwWrz+H4VStooPUvpn6ZWMTAmBYO0ycxsqrAkVW1H4?=
 =?us-ascii?Q?jyuaVYwOzxJfjBx5JuuIejulBd4JUAQcQpC3bvst+da/59Xk0semX12/AjuL?=
 =?us-ascii?Q?MWXAJzAikgsY0nJcRxhpvDKQogOHJcrffmbK41kr/SYcxH9i5ZoQCL2oDZzi?=
 =?us-ascii?Q?3AGjSc6x0SUu8HRowKcqxVg2R/NJDMNbwa1cEUCnOzkoWY18XpezwsTieX99?=
 =?us-ascii?Q?Tf/qWEuTsbISVyLfxEz92UVyOlZiZaffFvi1MDrFL9D+P4W58i3eeasyJuwN?=
 =?us-ascii?Q?DX8T43d/O2EmMUr8VDg7as2HE1fuQc7OhStjlvuhbeTrnyIsfgnXcs6RcUqU?=
 =?us-ascii?Q?KRBOVhYrjG9+KOqBi6Uba5Tdr0n8ckHDL41uFylD040qsHeCELhPqC0EYJtH?=
 =?us-ascii?Q?n0mzqQCpAKX5ThftuuCILL8NCw5wQA7X9vAuxX4jpTCuaU0yMj34+HDRG61e?=
 =?us-ascii?Q?+Z/50a5O3LS2rluLn1gWUA2WPmzYsJFhTa6nx2fRbUgm08ecrGhVPHpEW8zV?=
 =?us-ascii?Q?4wHbCqO92fyx8as6MuCdTMlIJo27Cbp4mQqaYFvjVfE1Npavo9z8oTdiuoFF?=
 =?us-ascii?Q?R+48+7zz6D2cCulyxXPrUKOi9a0Aa8BVkT7Ct2GSxvvnTYCDKgfm6c6/gmFE?=
 =?us-ascii?Q?GfA5YYUChfgu7Y0bPV7CGlfOKv3I6HFIGnh3q1hVoZ7pIurkepEyDkG9AfGc?=
 =?us-ascii?Q?NqgqF1a7lPmJjAdHpAOqXvXy96xSq/icAa7J9tXOcDD68yX+xxAuMypNUYKY?=
 =?us-ascii?Q?kAVWRpkktXtCDMAsiOgH+BiS70JiQQOqbcd2j4zggfsmYDh8ihHiGHfbhjw1?=
 =?us-ascii?Q?b9Io1ZhdPo8E+tL+gqwRS0WilABMWBoJZFk8VONBoSFvE3gmLXD3vb3hZ8YL?=
 =?us-ascii?Q?/pQa1WbGO/s76xbYuCcNjSZM8qj968fIrpVBAmz1R2f08QWAmnEZb66UdEJy?=
 =?us-ascii?Q?WPJIMy1ydiTi+LcaEDxnE6t18q1h/CkYalyhsgnjtBkUA88IOTuOEK5GxtMB?=
 =?us-ascii?Q?XTLWAkInu5+sjl7o1bA262V+L+xld6erfvW8fAsV2Onb2r8aa3RZs7J/e9gk?=
 =?us-ascii?Q?68FqBMT+gNK7pA+Ptr+WIenYbktVCl8aNN9VYV7wb3670rDXbDOhNo/8RXXy?=
 =?us-ascii?Q?gX48Kq+WgB9D23Kq5VnIO7gqdIeqI8r/N89u/fG4SShYf/WUtNbWCXEYt9Uf?=
 =?us-ascii?Q?ckXmUqA+iGoNGBSnIXqoWyYPHS53Xeu/Lg/LN5GGoCqiZTRuCqQkcr+gSF1Q?=
 =?us-ascii?Q?bWFu/R4tgs8b2OkAgzikyBIZ1us7Bnwod/oCus6KjbI/bCFyJH9cQBhEUytU?=
 =?us-ascii?Q?eA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63db457-f135-43fd-22c6-08dc137c78dc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 14:40:50.6078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BraZoZ4RYmSlmTj2QXllh5WZtijwNW7QXKF6uDmGYsjgnqR8iqx6KTPIgwbUfGsHhxaM6ZKBsRBpUiX0ztA/c6MBksT9Y0TOf9OzbIraQME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9781

Add code to support dynamically generated BASE from presets

---
 src/shared/bap.c | 492 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/bap.h |   2 +
 2 files changed, 494 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 078d308dc..3c99e543c 100644
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

