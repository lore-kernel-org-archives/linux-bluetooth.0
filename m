Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2041.outbound.protection.outlook.com [40.107.241.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42362DF87
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jan 2024 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dILtelmx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLWRrl1ElxgUu0EHqmI6JH26X9m35OQ7w32kWBrJPz2t9nB+lXsibl38XkztxFe/Ggh7mJiE6B5EXJfFNNJdRtb0P7COpXrhogMDPlH5i2R9ipQkmkS1wLZrRUAssNaEJrxBoyru/0juioU8Fm1mO/HMnXXcc9axUmgmhbFIJFPcTqAuiEbZtV5X3IFEsIR8LG5XJGiyj0CT0zeJlaJuqDffKq5rTNDB/6+qDBcav2z5mUdK1VeBtFEa9jZGew6FgFUQSG7MS9wkuqrmsqL7t7qC2OQMCdUPpjBd9ingsAnDwF5qGtAGazQdJHPpTVzkG8w2ax2ucgheYinDCzn7OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBUlXzWfUu17PRfkSPU3NUAMsiILw+Fp4mSbohh44uM=;
 b=U46R/o2MHIG35eRktN+zLM5OnhgDPpjtJUSFYwqVnaYa6bbGDPGrP8WIf9SZ8CRXeXJ3AzY15/MZvfCyjHzlYKldblIZGM2MvIzEX+FDMOSXvjTrz7P7xVYckctyUX77+NgdpAMBuwT4vMpRTn6/On2vwZVmFSKpMZt/A/jio0UKhZDaXz7UNCo2xFoEwgiYMMM+kL7dG0JqGF/ZIGRmnD0ZMOZt12jWkgraE2zsBPi4GhpwipuJyiLh1UWBsGecCHldRAcdaP67k9DaTa96Yjdqysbg5JxPoPr7/qx4JRfg0oi5OJbhzLMhfJ8ik8Wz48n0T62vcPj22nt/DUv/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBUlXzWfUu17PRfkSPU3NUAMsiILw+Fp4mSbohh44uM=;
 b=dILtelmxc1vEJ5Kloy+sXtDUJMquWe0rWRcbTwAU0pim8D6Zbdz8RIBDlzzVDbDw0IVVS+RsNKuEvXnFytlDoy/beD6QAdlDiJDRxmAsMSxv1ffqz4oqn1SAexLnMkAfLHbONX1rrps8VhSjKRHi/5kpj9qsODSpf5f4NmB08v8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AS8PR04MB8627.eurprd04.prod.outlook.com (2603:10a6:20b:42a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Fri, 5 Jan
 2024 14:33:43 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%6]) with mapi id 15.20.7135.023; Fri, 5 Jan 2024
 14:33:43 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH v2 2/2] bap.c: Add support for multiple BISes
Date: Fri,  5 Jan 2024 16:33:34 +0200
Message-Id: <20240105143334.7248-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240105143334.7248-1-silviu.barbulescu@nxp.com>
References: <20240105143334.7248-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0030.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::18) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AS8PR04MB8627:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ebe9d34-d0be-4dc0-aabc-08dc0dfb510f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qGkcP8RjU9BfL2IXTatjr0/mjnUOpsSenu7n5dNDdFD9UHREUEMQxt5ddS6o0dssUwHzR7kj9K3MpqHQYzP/kLu/Jrerm22EGkokR51gk1GpjYDYiPn5yJYfQq7c9XxnMg0wx2u+SwSbHNpXeFzQMDZR0Ds9E3fWbj/owFN7lJx8Kcj0toqot/9dRUpoYjTuGtNkXihwQRMMQ00mHmicdHFZSPAx5ih5+gdbWijZvR6Cd+BCAQlWL4ZP42bPswlS2Q9tHrUnL8NNGW1pWXdq3uitMzztUen3kJShJLjQ0ubcsrKBbt2YdLaVEb1SJUUqjqp4jKJet2xvBVVzycE26AhjhtA8fIhQbjY+LSfxWH+sp/+KZkiVvB33s84EREM0haVY3O9x4FOScWMAZY/pLMy+L6z1N5H0VT/Lov1mMcRHDVUdVZXCA2aD/Plr0+9lQ6GP3GpdhMy7zBkxR0EbMPopzL5c/s+12E5E8H+soeASVhr/1y0k1UtQN8B5M9mkaGVRtOQo90zaWhhD0+YWgkdrH2uSF71lfFC8VAfbKNj26ZKnqOUqpczUn7d39mT8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(4326008)(83380400001)(8936002)(8676002)(86362001)(30864003)(5660300002)(2906002)(478600001)(41300700001)(6486002)(38100700002)(6512007)(6666004)(36756003)(6506007)(66556008)(66476007)(316002)(66946007)(6916009)(2616005)(1076003)(26005)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UBnOVKaNXHVN6xHh1ulBaKsswBq7LeAAV4RIoOQ2ZgCMdwzC9dlscvUhIPqz?=
 =?us-ascii?Q?ZhTJyD5JvUlTni0T3qlZCF6WasBDEQfrGfqnG1fMwmYn/qEfDKra80y3gDUn?=
 =?us-ascii?Q?7W5a5UEpem/w4SNoFMQ7YuMXSFGaWFMnISqddk/L10ednERtRgq4l5tGJFhP?=
 =?us-ascii?Q?/fcwzV/JzA81ORKycelR4XxFJLiUJz39CzUn2Z+9IJqv7hoSrh0R3aMUcF/G?=
 =?us-ascii?Q?01QZPKpb6BkyCzFSH7LALfF0H/zejdPYul4HCJCeYf3SX7zCrDxQ8rdKgX2f?=
 =?us-ascii?Q?+7I0J7XBY40ZsLdEos+kokLynRdqP2EHPMX+QbI7cPh/gz76U1zj/9hvG+Mg?=
 =?us-ascii?Q?nAlWWm54vFb5hrHMHa1SFSatYnsyhXh2eWkfKrmdfC8V68uZK8X1aaOciKcm?=
 =?us-ascii?Q?DFmA9BPQjA7hAKXYfZyGZ8bRvhCFDQjnDNR1FP79OJcEODH6XoyhW8dzV1MZ?=
 =?us-ascii?Q?WEdmh1Tu/YqYd/OBicc2mzkf8O5CTnt1ILuLbioIIGIUsc9bBgMszOBfTkeS?=
 =?us-ascii?Q?m0L+uq8NU+amQnKniVzFvZr0dWb6oQS+JIrUQ3ht28Chr/yFnivpyaMbIKmJ?=
 =?us-ascii?Q?bFrvFMYKMUhGmewGJmHNJCNqWXxDYZRx/8prngIKRYs93B7kgWeqCCFaXgAr?=
 =?us-ascii?Q?jX9kmB/MvNXtKzyK7VR/VFTOvZ8brdA8BHr2fP7TJ1DSgknl+xxMnKBMkmfm?=
 =?us-ascii?Q?z6z8tUOx1NU6/tKcQLSi//WOFUdiomlrXgsOhyIaQN+6kKwNWyiWqBuSQi37?=
 =?us-ascii?Q?fStmazjUW7hR/Jh+lQ7D0JCPQvYBc0lNpEGV4wUZ7SNN2KtgCwhQVQbwkwqN?=
 =?us-ascii?Q?zJnlUWoHE+IwJfvr9f/IaRS5s2mv/PbB3taQYvi16onkuG6L2Wa7hNhml4qa?=
 =?us-ascii?Q?DR+icYK3F4X5H8hJgh5gxMtQ2LGMcI2dZOU7OwmvRrlfCaC8hxOvA0Sa87Ni?=
 =?us-ascii?Q?Q4ku392fp3dUsiABMo/YiV2itCG//00Ky+2VdkOQ/HT4Pr8AUMJjJKKCQ3Ad?=
 =?us-ascii?Q?+/A33QrUS+DGOdwHPlaMlUoaFIAtdxOwqbssKk6ynS3ApunGPRhJ4FtrvX00?=
 =?us-ascii?Q?Lyg93slXlJsCWmrKfUZ9bL+Y0o4jGRgGZkwUaVjnawhy0VVhDlBGeRjaaraO?=
 =?us-ascii?Q?VJBJroWOpzcnd5U74Im6e8iUlqo6ZICgGwRtSEN5YRhz60tTlhKmrUfzUGtM?=
 =?us-ascii?Q?gtbAmS8E727iyrdeG8gXxBWQZg7VyjZbxhGhZougj50pd8s6bxj78/fftsUs?=
 =?us-ascii?Q?5i9WkSL/LxjYznsbex6ld8qqfOWnt8TsOpUoCQJNAm/YCvr+QhpY84RrBJL7?=
 =?us-ascii?Q?IxYPE+hFmvXeag1rInZZVvNwT274tvAE4oZgtsVUs9rmc0tMmaLg77+H2p6C?=
 =?us-ascii?Q?s9OdOwZC9KBzAgkb2CrnLaZ9gROgCpZDDxRNcUGB42vQGu8HVkjvCGSV6TlN?=
 =?us-ascii?Q?rBpOsT9Pr9XvpSSQKrQHuMXhF+EzVR8+HBuFWJWH5+hDao1gJeFyFzQu+m+2?=
 =?us-ascii?Q?73OP3Wx9xqimGJxm4uTu7DnYYx65OToRqhsm/XK5rScA+y6RvCTCPcToPpGA?=
 =?us-ascii?Q?fu6wSq29t7NoQvtTfolP08mNQ9++ipbgysekUcdyBFW8iR/v6Sz56SQFR+0H?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ebe9d34-d0be-4dc0-aabc-08dc0dfb510f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 14:33:43.0458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXC38WazfLgKCve/skJQwyafNkHBbRSEp2pj5vE8MAVTU+pmvvTu3V4HDV/Vk3uf/yklYOfErZ+jqyok0nAhltPCHc1Ik1fa95Ms1RVhFPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8627

Update broadcast to support the new setup structure.
Change broadcast code from iovec struct to byte array.
Add adapter property for broadcast endpoint.
Make broadcast sink to select broadcast source BISes
based on pac broadcast sink properties.

---
 profiles/audio/bap.c       | 1273 ++++++++++++++++++++++++++++++------
 profiles/audio/transport.c |   25 +-
 src/shared/bap.c           |  441 ++++++++++++-
 src/shared/bap.h           |   36 +-
 4 files changed, 1543 insertions(+), 232 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index b88876485..8bc292946 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -45,6 +45,7 @@
 #include "src/shared/gatt-client.h"
 #include "src/shared/gatt-server.h"
 #include "src/shared/bap.h"
+#include "src/shared/lc3.h"
 
 #include "btio/btio.h"
 #include "src/plugin.h"
@@ -75,6 +76,8 @@ struct bap_setup {
 	unsigned int id;
 	struct iovec *base;
 	DBusMessage *msg;
+	struct queue *same_big_setups;
+	struct bt_bap_qos combined_qos;
 };
 
 struct bap_ep {
@@ -102,6 +105,64 @@ struct bap_data {
 	void *user_data;
 };
 
+struct stream_base_data {
+	struct queue *ltv_caps;
+	struct queue *ltv_meta;
+	struct bap_setup *setup;
+};
+
+struct base_data {
+	uint32_t pres_delay;
+	struct queue *base_data_subgroup;
+};
+
+struct base_data_subgroup {
+	uint8_t subgroup_index;
+	struct bt_bap_codec codec;
+	struct queue *ltv_caps;
+	struct queue *ltv_meta;
+	struct queue *bises;
+};
+
+struct base_data_bis {
+	uint8_t bis_index;
+	struct queue *ltv_caps;
+};
+
+#define DEFAULT_IO_QOS \
+{ \
+	.interval	= 10000, \
+	.latency	= 10, \
+	.sdu		= 40, \
+	.phy		= 0x02, \
+	.rtn		= 2, \
+}
+
+static struct bt_iso_qos default_qos = {
+	.bcast = {
+		.big			= BT_ISO_QOS_BIG_UNSET,
+		.bis			= BT_ISO_QOS_BIS_UNSET,
+		.sync_factor	= 0x07,
+		.packing		= 0x00,
+		.framing		= 0x00,
+		.in			= DEFAULT_IO_QOS,
+		.out			= DEFAULT_IO_QOS,
+		.encryption		= 0x00,
+		.bcode			= {0x00},
+		.options		= 0x00,
+		.skip			= 0x0000,
+		.sync_timeout		= 0x4000,
+		.sync_cte_type		= 0x00,
+		.mse			= 0x00,
+		.timeout		= 0x4000,
+	}
+};
+struct ltv_compare_data {
+	bool match;
+	void *data;
+	uint32_t data32;
+};
+
 static struct queue *sessions;
 
 static bool bap_data_set_user_data(struct bap_data *data, void *user_data)
@@ -258,10 +319,20 @@ static gboolean get_device(const GDBusPropertyTable *property,
 	struct bap_ep *ep = data;
 	const char *path;
 
-	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE)
-		path = adapter_get_path(ep->data->adapter);
-	else
-		path = device_get_path(ep->data->device);
+	path = device_get_path(ep->data->device);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
+
+	return TRUE;
+}
+
+static gboolean get_adapter(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct bap_ep *ep = data;
+	const char *path;
+
+	path = adapter_get_path(ep->data->adapter);
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
 
@@ -370,6 +441,26 @@ static const GDBusPropertyTable ep_properties[] = {
 	{ }
 };
 
+static const GDBusPropertyTable ep_properties_bcast_source[] = {
+	{ "UUID", "s", get_uuid, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Codec", "y", get_codec, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Capabilities", "ay", get_capabilities, NULL, has_capabilities,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Adapter", "o", get_adapter, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Locations", "u", get_locations, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "SupportedContext", "q", get_supported_context, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Context", "q", get_context, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "QoS", "a{sv}", get_qos, NULL, qos_exists,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ }
+};
+
 static int parse_array(DBusMessageIter *iter, struct iovec *iov)
 {
 	DBusMessageIter array;
@@ -384,101 +475,755 @@ static int parse_array(DBusMessageIter *iter, struct iovec *iov)
 	return 0;
 }
 
-static bool parse_base(void *data, size_t len, util_debug_func_t func,
-		uint32_t *presDelay, uint8_t *numSubgroups, uint8_t *numBis,
-		struct bt_bap_codec *codec, struct iovec **caps,
-		struct iovec **meta)
+static void cleanup_subgroup(struct bt_bap_base_subgroup *subgroup)
 {
-	struct iovec iov = {
-		.iov_base = data,
-		.iov_len = len,
-	};
+	if (!subgroup)
+		return;
 
-	uint8_t capsLen, metaLen;
-	uint8_t *hexstream;
+	if (subgroup->meta)
+		util_iov_free(subgroup->meta, 1);
 
-	if (presDelay) {
-		if (!util_iov_pull_le24(&iov, presDelay))
-			return false;
-		util_debug(func, NULL, "PresentationDelay %d", *presDelay);
+	if (subgroup->caps)
+		util_iov_free(subgroup->caps, 1);
+
+	while (!queue_isempty(subgroup->bises)) {
+		struct bt_bap_bis *bis = queue_peek_head(subgroup->bises);
+
+		if (bis->caps)
+			util_iov_free(bis->caps, 1);
+		queue_remove(subgroup->bises, bis);
+		subgroup->num_bises--;
 	}
+	queue_destroy(subgroup->bises, NULL);
 
-	if (numSubgroups) {
-		if (!util_iov_pull_u8(&iov, numSubgroups))
-			return false;
-		util_debug(func, NULL, "NumSubgroups %d", *numSubgroups);
+	if (subgroup)
+		free(subgroup);
+}
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
+static struct stream_base_data *get_stream_base_info(
+			struct bap_setup *setup, util_debug_func_t func)
+{
+	struct stream_base_data *sbd = new0(struct stream_base_data, 1);
+	struct iovec *stream_caps_iov = util_iov_dup(
+			setup->caps, 1);
+	struct iovec *stream_meta_iov = util_iov_dup(
+			setup->metadata, 1);
+
+	/*
+	 * Copy the Codec Specific configurations from stream
+	 */
+	if (stream_caps_iov != NULL) {
+		if (!util_ltv_foreach(stream_caps_iov->iov_base,
+				stream_caps_iov->iov_len, NULL,
+				parse_ltv, &sbd->ltv_caps)) {
+			util_debug(func,
+			NULL, "Unable to parse Codec Specific configurations");
+			goto fail;
+		}
 	}
 
-	if (numBis) {
-		if (!util_iov_pull_u8(&iov, numBis))
-			return false;
-		util_debug(func, NULL, "NumBis %d", *numBis);
+	/*
+	 * Copy the Metadata from stream
+	 */
+	if (stream_meta_iov != NULL) {
+		if (!util_ltv_foreach(stream_meta_iov->iov_base,
+				stream_meta_iov->iov_len, NULL,
+				parse_ltv, &sbd->ltv_meta)) {
+			util_debug(func,
+			NULL, "Unable to parse Codec Specific configurations");
+			goto fail;
+		}
 	}
 
-	if (codec) {
-		codec = util_iov_pull_mem(&iov, sizeof(*codec));
-		if (!codec)
+	sbd->setup = setup;
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
+	struct bap_setup *setup = data;
+	struct queue *streams_base_data = user_data;
+	struct stream_base_data *sbd = get_stream_base_info(setup, bap_debug);
+
+	if (sbd)
+		queue_push_tail(streams_base_data, sbd);
+}
+
+static void set_device_presentation_delay(void *data, void *user_data)
+{
+	struct stream_base_data *sbd = data;
+	struct base_data *base = user_data;
+	struct bt_bap_qos *qos = &sbd->setup->qos;
+
+	if (base->pres_delay < qos->bcast.delay)
+		base->pres_delay = qos->bcast.delay;
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
 			return false;
-		util_debug(func, NULL, "%s: ID %d CID 0x%2.2x VID 0x%2.2x",
-				"Codec", codec->id, codec->cid, codec->vid);
 	}
 
-	if (!util_iov_pull_u8(&iov, &capsLen))
-		return false;
-	util_debug(func, NULL, "CC Len %d", capsLen);
+	return true;
+}
 
-	if (!capsLen)
-		return false;
-	if (caps) {
-		if (!(*caps))
-			*caps = new0(struct iovec, 1);
-		(*caps)->iov_len = capsLen;
-		(*caps)->iov_base = iov.iov_base;
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
 	}
 
-	for (int i = 0; capsLen > 1; i++) {
-		struct bt_ltv *ltv = util_iov_pull_mem(&iov, sizeof(*ltv));
-		uint8_t *caps;
+	if (queue_isempty(ltv_caps)) {
+		queue_destroy(ltv_caps, NULL);
+		return NULL;
+	} else
+		return ltv_caps;
+}
 
-		if (!ltv) {
-			util_debug(func, NULL, "Unable to parse %s",
-								"Capabilities");
-			return false;
-		}
+static void get_max_bises_index(void *data, void *user_data)
+{
+	struct base_data_bis *bdb = data;
+	uint8_t *bis_index = user_data;
 
-		util_debug(func, NULL, "%s #%u: len %u type %u",
-					"CC", i, ltv->len, ltv->type);
+	if (bdb->bis_index > *bis_index)
+		*bis_index = bdb->bis_index + 1;
+	else if (bdb->bis_index == *bis_index)
+		*bis_index = *bis_index + 1;
+}
 
-		caps = util_iov_pull_mem(&iov, ltv->len - 1);
-		if (!caps) {
-			util_debug(func, NULL, "Unable to parse %s",
-								"CC");
-			return false;
+static void get_bises_index(void *data, void *user_data)
+{
+	struct base_data_subgroup *bds = data;
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
+static void add_new_bis(struct base_data_subgroup *subgroup,
+			uint8_t bis_index, struct queue *ltv_bis_caps)
+{
+		struct base_data_bis *bdb = new0(struct base_data_bis, 1);
+
+		bdb->bis_index = bis_index;
+		bdb->ltv_caps = ltv_bis_caps;
+		queue_push_tail(subgroup->bises, bdb);
+}
+
+static void add_new_subgroup(struct queue *subgroups,
+			struct stream_base_data *base_data)
+{
+		struct bt_bap_pac *lpac = base_data->setup->ep->lpac;
+		struct base_data_subgroup *bds = new0(
+					struct base_data_subgroup, 1);
+		uint16_t cid;
+		uint16_t vid;
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
+		base_data->setup->qos.bcast.bis = get_bis_index(subgroups);
+		add_new_bis(bds, base_data->setup->qos.bcast.bis,
+						queue_new());
+		queue_push_tail(subgroups, bds);
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
+	struct stream_base_data *stream_base = data;
+	struct base_data *base = user_data;
+	struct queue *ltv_caps;
+
+	if (queue_isempty(base->base_data_subgroup)) {
+		add_new_subgroup(base->base_data_subgroup, stream_base);
+	} else {
+		/* Verify if a subgroup has the same metadata */
+		const struct queue_entry *entry;
+		struct base_data_subgroup *subgroup_base = NULL;
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
 		}
-		util_hexdump(' ', caps, ltv->len - 1, func, NULL);
 
-		capsLen -= (ltv->len + 1);
+		if (!same_meta) {
+			/* No subgroup with the same metadata found.
+			 * Create a new one.
+			 */
+			add_new_subgroup(base->base_data_subgroup,
+				stream_base);
+		} else {
+			/* Soubgroup found with the same metadata
+			 * get different capabilities
+			 */
+			ltv_caps = compare_caps_ltv_lists(
+					subgroup_base->ltv_caps,
+					stream_base->ltv_caps);
+
+			queue_foreach(ltv_caps, remove_ltv_form_list,
+				stream_base->ltv_caps);
+			stream_base->setup->qos.bcast.bis = get_bis_index(
+				base->base_data_subgroup);
+			add_new_bis(subgroup_base,
+					stream_base->setup->qos.bcast.bis,
+					ltv_caps);
+		}
 	}
+}
+
+static void get_tlv_size(void *data, void *user_data)
+{
+	struct bt_ltv *ltv = data;
+	uint8_t *length = user_data;
+
+	*length = *length + ltv->len + 1;
+}
+
+static uint8_t get_size_from_ltv_queue(struct queue *tlv_queue)
+{
+	uint8_t length = 0;
+
+	queue_foreach(tlv_queue, get_tlv_size, &length);
+	return length;
+}
+
+static void generate_ltv_base(void *data, void *user_data)
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
+	util_debug(bap_debug, NULL, "ltv type %d", ltv->type);
+}
+
+static void generate_bis_base(void *data, void *user_data)
+{
+	struct base_data_bis *bis = data;
+	struct iovec *base_iov = user_data;
+	uint8_t cc_length = get_size_from_ltv_queue(bis->ltv_caps);
+
+	if (!util_iov_push_u8(base_iov, bis->bis_index))
+		return;
+	util_debug(bap_debug, NULL, "Bis Index %d", bis->bis_index);
+
+	if (!util_iov_push_u8(base_iov, cc_length))
+		return;
+	util_debug(bap_debug, NULL, "Codec Specific Configuration length %d",
+				cc_length);
+
+	queue_foreach(bis->ltv_caps, generate_ltv_base, base_iov);
+}
+
+static void generate_subgroup_base(void *data, void *user_data)
+{
+	struct base_data_subgroup *bds = data;
+	struct iovec *base_iov = user_data;
+	uint8_t cc_length = get_size_from_ltv_queue(bds->ltv_caps);
+	uint8_t metadata_length = get_size_from_ltv_queue(bds->ltv_meta);
+
+	if (!util_iov_push_u8(base_iov, queue_length(bds->bises)))
+		return;
+
+	util_debug(bap_debug, NULL, "Number of BIS %d",
+				queue_length(bds->bises));
+
+	if (!util_iov_push_u8(base_iov, bds->codec.id))
+		return;
+
+	util_debug(bap_debug, NULL, "Codec ID %d", bds->codec.id);
+
+	if (!util_iov_push_le16(base_iov, bds->codec.cid))
+		return;
+
+	util_debug(bap_debug, NULL, "Company ID %d", bds->codec.cid);
+
+	if (!util_iov_push_le16(base_iov, bds->codec.vid))
+		return;
+
+	util_debug(bap_debug, NULL, "Vendor specific codec_ID %d",
+				bds->codec.vid);
+
+	if (!util_iov_push_u8(base_iov, cc_length))
+		return;
+
+	util_debug(bap_debug, NULL, "Codec Specific Configuration length %d",
+				cc_length);
+
+	queue_foreach(bds->ltv_caps, generate_ltv_base, base_iov);
+
+	if (!util_iov_push_u8(base_iov, metadata_length))
+		return;
+
+	util_debug(bap_debug, NULL, "Metadata length %d", metadata_length);
+
+	queue_foreach(bds->ltv_meta, generate_ltv_base, base_iov);
+
+	queue_foreach(bds->bises, generate_bis_base, base_iov);
+}
+
+static struct iovec *generate_base(struct base_data *base,
+					util_debug_func_t func)
+{
+	struct iovec *base_iov = g_new0(struct iovec, 0x1);
+
+	base_iov->iov_base = util_malloc(BASE_MAX_LENGTH);
+
+	if (!util_iov_push_le24(base_iov, base->pres_delay))
+		return NULL;
+	util_debug(func, NULL, "PresentationDelay %d", base->pres_delay);
+
+	if (!util_iov_push_u8(base_iov,
+			queue_length(base->base_data_subgroup)))
+		return NULL;
+
+	util_debug(func, NULL, "Number of Subgroups %d",
+			queue_length(base->base_data_subgroup));
+
+	queue_foreach(base->base_data_subgroup, generate_subgroup_base,
+				base_iov);
+
+	return base_iov;
+}
+
+static void update_endpoint_base(struct bap_setup *setup,
+			struct bap_data *data, struct iovec *base_iov)
+{
+	if (setup->base)
+		util_iov_free(setup->base, 1);
+
+	setup->base = util_iov_dup(base_iov, 1);
+}
+
+static void destroy_stream_base_data(void *data)
+{
+	struct stream_base_data *sbd = data;
+
+	if (!sbd)
+		return;
+
+	queue_destroy(sbd->ltv_caps, destroy_ltv);
+	queue_destroy(sbd->ltv_meta, destroy_ltv);
+	sbd->setup = NULL;
+	free(sbd);
+}
+
+static void destroy_base_data_bis(void *data)
+{
+	struct base_data_bis *bis = data;
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
+	struct base_data_subgroup *subgroup = data;
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
+static void update_base(struct bap_setup *setup,
+			struct bap_data *data, util_debug_func_t func)
+{
+	struct base_data *base;
+	struct iovec *base_iov;
+	const struct queue_entry *entry;
+	struct queue *streams_base_data = queue_new();
+	struct stream_base_data *sbd = get_stream_base_info(setup, func);
+
+	queue_foreach(setup->same_big_setups, get_stream_base_data,
+						streams_base_data);
+
+	queue_push_tail(streams_base_data, sbd);
+
+	base = new0(struct base_data, 1);
+	base->base_data_subgroup = queue_new();
+
+	queue_foreach(streams_base_data, set_device_presentation_delay, base);
+
+	queue_foreach(streams_base_data, set_base_subgroup, base);
+
+	base_iov = generate_base(base, bap_debug);
+
+	/* Update the endpoints BASE iovec */
+	update_endpoint_base(setup, data, base_iov);
+
+	for (entry = queue_get_entries(setup->same_big_setups);
+						entry; entry = entry->next) {
+		struct bap_setup *link = entry->data;
+
+		update_endpoint_base(link, data, base_iov);
+	}
+
+	util_iov_free(base_iov, 1);
+
+	queue_destroy(streams_base_data, destroy_stream_base_data);
+
+	queue_destroy(base->base_data_subgroup, destroy_base_data_subgroup);
+
+	free(base);
+}
 
-	if (!util_iov_pull_u8(&iov, &metaLen))
+static void get_combined_qos(void *data, void *user_data)
+{
+	struct bap_setup *setup = data;
+	struct bt_bap_qos **local_qos = user_data;
+	struct bt_bap_qos *qos = &setup->qos;
+
+	if (*local_qos == NULL)
+		return;
+
+	if (((*local_qos)->bcast.io_qos.interval !=
+				qos->bcast.io_qos.interval) ||
+	 ((*local_qos)->bcast.io_qos.rtn != qos->bcast.io_qos.rtn) ||
+	 ((*local_qos)->bcast.io_qos.latency !=
+				qos->bcast.io_qos.latency) ||
+	 ((*local_qos)->bcast.io_qos.phy != qos->bcast.io_qos.phy) ||
+	 ((*local_qos)->bcast.framing != qos->bcast.framing)) {
+		util_debug(bap_debug,
+		NULL,
+		"Error: QOS is different between BISes in the BIG");
+		free(*local_qos);
+		*local_qos = NULL;
+		return;
+	}
+
+	if ((*local_qos)->bcast.io_qos.sdu != qos->bcast.io_qos.sdu)
+		if ((*local_qos)->bcast.io_qos.sdu < qos->bcast.io_qos.sdu)
+			(*local_qos)->bcast.io_qos.sdu = qos->bcast.io_qos.sdu;
+
+	if ((*local_qos)->bcast.delay != qos->bcast.delay)
+		if ((*local_qos)->bcast.delay < qos->bcast.delay)
+			(*local_qos)->bcast.delay = qos->bcast.delay;
+}
+
+static void update_qos(struct bap_setup *setup,
+			struct bap_data *data)
+{
+	const struct queue_entry *entry;
+	struct bt_bap_qos *local_qos = new0(struct bt_bap_qos, 1);
+	struct bt_bap_qos *qos = &setup->qos;
+
+	memcpy(local_qos, qos, sizeof(struct bt_bap_qos));
+
+	queue_foreach(setup->same_big_setups,
+				get_combined_qos, &local_qos);
+
+	/* Update each endpoint QOS structure to have the
+	 * same values, as obtained in local_qos
+	 */
+	if (local_qos != NULL) {
+		memcpy(&setup->combined_qos, local_qos,
+				sizeof(struct bt_bap_qos));
+
+		for (entry = queue_get_entries(setup->same_big_setups);
+				entry; entry = entry->next) {
+			struct bap_setup *link = entry->data;
+
+			memcpy(&link->combined_qos, local_qos,
+					sizeof(struct bt_bap_qos));
+		}
+	}
+
+	if (local_qos != NULL)
+		free(local_qos);
+}
+
+static bool parse_base(struct bt_bap *bap, void *data, size_t len,
+		util_debug_func_t func, struct bt_bap_base *base)
+{
+	uint8_t num_subgroups;
+	uint8_t num_bis;
+
+	struct iovec iov = {
+		.iov_base = data,
+		.iov_len = len,
+	};
+	util_debug(func, NULL, "BASE len %ld", len);
+	if (!base)
 		return false;
-	util_debug(func, NULL, "Metadata Len %d", metaLen);
 
-	if (!metaLen)
+	if (!util_iov_pull_le24(&iov, &base->pres_delay))
 		return false;
-	if (meta) {
-		if (!(*meta))
-			*meta = new0(struct iovec, 1);
-		(*meta)->iov_len = metaLen;
-		(*meta)->iov_base = iov.iov_base;
-	}
+	util_debug(func, NULL, "PresentationDelay %d", base->pres_delay);
 
-	hexstream = util_iov_pull_mem(&iov, metaLen);
-	if (!hexstream)
+	if (!util_iov_pull_u8(&iov, &base->num_subgroups))
 		return false;
-	util_hexdump(' ', hexstream, metaLen, func, NULL);
+	util_debug(func, NULL, "NumSubgroups %d", base->num_subgroups);
+	num_subgroups = base->num_subgroups;
+
+	for (int sg = 0; sg < num_subgroups; sg++) {
+		struct bt_bap_base_subgroup *sub_group = new0(
+						struct bt_bap_base_subgroup, 1);
+		uint8_t caps_len, metaLen;
+		uint8_t *hexstream;
+
+		sub_group->subgroup_index = sg;
+
+		util_debug(func, NULL, "Subgroup #%d", sg);
+		sub_group->bap = bap;
+		sub_group->bises = queue_new();
+
+		if (!util_iov_pull_u8(&iov, &num_bis)) {
+			cleanup_subgroup(sub_group);
+			goto fail;
+		}
+		util_debug(func, NULL, "NumBis %d", num_bis);
+		sub_group->num_bises = num_bis;
+
+		memcpy(&sub_group->codec, util_iov_pull_mem(&iov,
+		sizeof(struct bt_bap_codec)), sizeof(struct bt_bap_codec));
+		util_debug(func, NULL, "%s: ID %d CID 0x%2.2x VID 0x%2.2x",
+			"Codec", sub_group->codec.id, sub_group->codec.cid,
+				sub_group->codec.vid);
+		if (!util_iov_pull_u8(&iov, &caps_len)) {
+			cleanup_subgroup(sub_group);
+			goto fail;
+		}
+
+		util_debug(func, NULL, "CC Len %d", caps_len);
+
+		/*
+		 * Copy the Codec Specific configurations from base
+		 */
+		sub_group->caps = new0(struct iovec, 1);
+		util_iov_memcpy(sub_group->caps, iov.iov_base, caps_len);
+		DBG("subgroup caps len %ld", sub_group->caps->iov_len);
+
+		for (int i = 0; caps_len > 1; i++) {
+			struct bt_ltv *ltv = util_iov_pull_mem(&iov,
+								sizeof(*ltv));
+			uint8_t *caps;
+
+			if (!ltv) {
+				util_debug(func, NULL, "Unable to parse %s",
+							"Capabilities");
+				cleanup_subgroup(sub_group);
+				goto fail;
+			}
+
+			util_debug(func, NULL, "%s #%u: len %u type %u",
+						"CC", i, ltv->len, ltv->type);
+
+			caps = util_iov_pull_mem(&iov, ltv->len - 1);
+			if (!caps) {
+				util_debug(func, NULL, "Unable to parse %s",
+									"CC");
+				cleanup_subgroup(sub_group);
+				goto fail;
+			}
+			util_hexdump(' ', caps, ltv->len - 1, func, NULL);
+
+			caps_len -= (ltv->len + 1);
+		}
+
+		if (!util_iov_pull_u8(&iov, &metaLen)) {
+			cleanup_subgroup(sub_group);
+			goto fail;
+		}
+		util_debug(func, NULL, "Metadata Len %d", metaLen);
+
+		sub_group->meta = new0(struct iovec, 1);
+		sub_group->meta->iov_len = metaLen;
+		sub_group->meta->iov_base = iov.iov_base;
+
+		hexstream = util_iov_pull_mem(&iov, metaLen);
+		if (!hexstream) {
+			cleanup_subgroup(sub_group);
+			goto fail;
+		}
+		util_hexdump(' ', hexstream, metaLen, func, NULL);
+
+		for (int bis_sg = 0; bis_sg < sub_group->num_bises; bis_sg++) {
+			struct bt_bap_bis *bis;
+			uint8_t caps_len;
+			uint8_t crt_bis;
+
+			if (!util_iov_pull_u8(&iov, &crt_bis)) {
+				cleanup_subgroup(sub_group);
+				goto fail;
+			}
+			util_debug(func, NULL, "BIS #%d", crt_bis);
 
+			bis = new0(struct bt_bap_bis, 1);
+			bis->bisIndex = crt_bis;
+
+			if (!util_iov_pull_u8(&iov, &caps_len)) {
+				cleanup_subgroup(sub_group);
+				goto fail;
+			}
+			util_debug(func, NULL, "CC Len %d", caps_len);
+
+			bis->caps = new0(struct iovec, 1);
+			bis->caps->iov_len = caps_len;
+			util_iov_memcpy(bis->caps, iov.iov_base, caps_len);
+			DBG("bis caps len %ld", bis->caps->iov_len);
+
+			for (int i = 0; caps_len > 1; i++) {
+				struct bt_ltv *ltv = util_iov_pull_mem(&iov,
+								sizeof(*ltv));
+				uint8_t *caps;
+
+				if (!ltv) {
+					util_debug(func, NULL, "Unable to parse %s",
+								"Capabilities");
+					cleanup_subgroup(sub_group);
+					goto fail;
+				}
+
+				util_debug(func, NULL, "%s #%u: len %u type %u",
+						"CC", i, ltv->len, ltv->type);
+
+				caps = util_iov_pull_mem(&iov, ltv->len - 1);
+				if (!caps) {
+					util_debug(func, NULL,
+						"Unable to parse %s", "CC");
+					cleanup_subgroup(sub_group);
+					goto fail;
+				}
+				util_hexdump(' ', caps, ltv->len - 1, func,
+									NULL);
+
+				caps_len -= (ltv->len + 1);
+			}
+
+			queue_push_tail(sub_group->bises, bis);
+		}
+
+		queue_push_tail(base->subgroups, sub_group);
+	}
 	return true;
+
+fail:
+		while (!queue_isempty(base->subgroups)) {
+			struct bt_bap_base_subgroup *subGroup =
+					queue_peek_head(base->subgroups);
+			cleanup_subgroup(subGroup);
+			base->num_subgroups--;
+		}
+		util_debug(func, NULL, "Unable to parse %s", "Base");
+
+		return false;
 }
 
 static int parse_io_qos(const char *key, int var, DBusMessageIter *iter,
@@ -561,6 +1306,16 @@ static int parse_bcast_qos(const char *key, int var, DBusMessageIter *iter,
 			return -EINVAL;
 
 		dbus_message_iter_get_basic(iter, &qos->bcast.encryption);
+	} else if (!strcasecmp(key, "BIG")) {
+		if (var != DBUS_TYPE_BYTE)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->bcast.big);
+	}  else if (!strcasecmp(key, "BIS")) {
+		if (var != DBUS_TYPE_BYTE)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->bcast.bis);
 	} else if (!strcasecmp(key, "Options")) {
 		if (var != DBUS_TYPE_BYTE)
 			return -EINVAL;
@@ -596,6 +1351,11 @@ static int parse_bcast_qos(const char *key, int var, DBusMessageIter *iter,
 			return -EINVAL;
 
 		dbus_message_iter_get_basic(iter, &qos->bcast.timeout);
+	} else if (!strcasecmp(key, "PresentationDelay")) {
+		if (var != DBUS_TYPE_UINT32)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->bcast.delay);
 	} else if (!strcasecmp(key, "BCode")) {
 		struct iovec iov;
 
@@ -604,8 +1364,8 @@ static int parse_bcast_qos(const char *key, int var, DBusMessageIter *iter,
 
 		parse_array(iter, &iov);
 
-		util_iov_free(qos->bcast.bcode, 1);
-		qos->bcast.bcode = util_iov_dup(&iov, 1);
+		memcpy(qos->bcast.bcode, iov.iov_base,
+				sizeof(qos->bcast.bcode));
 	} else {
 		int err;
 
@@ -618,14 +1378,15 @@ static int parse_bcast_qos(const char *key, int var, DBusMessageIter *iter,
 }
 
 static int parse_qos(DBusMessageIter *iter, struct bt_bap_qos *qos,
-			struct iovec **base)
+			struct bt_bap_pac *lpac)
 {
 	DBusMessageIter array;
 	const char *key;
 	int (*parser)(const char *key, int var, DBusMessageIter *iter,
 			struct bt_bap_qos *qos);
 
-	if (*base)
+	if ((bt_bap_pac_get_type(lpac) == BT_BAP_BCAST_SOURCE) ||
+		(bt_bap_pac_get_type(lpac) == BT_BAP_BCAST_SINK))
 		parser = parse_bcast_qos;
 	else
 		parser = parse_ucast_qos;
@@ -657,8 +1418,9 @@ static int parse_qos(DBusMessageIter *iter, struct bt_bap_qos *qos,
 }
 
 static int parse_configuration(DBusMessageIter *props, struct iovec **caps,
-				struct iovec **metadata, struct iovec **base,
-				struct bt_bap_qos *qos)
+				struct iovec **metadata,
+				struct bt_bap_qos *qos,
+				struct bt_bap_pac *lpac)
 {
 	const char *key;
 	struct iovec iov;
@@ -699,24 +1461,13 @@ static int parse_configuration(DBusMessageIter *props, struct iovec **caps,
 			if (var != DBUS_TYPE_ARRAY)
 				goto fail;
 
-			if (parse_qos(&value, qos, base))
+			if (parse_qos(&value, qos, lpac))
 				goto fail;
 		}
 
 		dbus_message_iter_next(props);
 	}
 
-	if (*base) {
-		uint32_t presDelay;
-		uint8_t numSubgroups, numBis;
-		struct bt_bap_codec codec;
-
-		util_iov_memcpy(*base, (*caps)->iov_base, (*caps)->iov_len);
-		parse_base((*caps)->iov_base, (*caps)->iov_len, bap_debug,
-			&presDelay, &numSubgroups, &numBis, &codec,
-			caps, NULL);
-	}
-
 	return 0;
 
 fail:
@@ -838,18 +1589,81 @@ static void setup_free(void *data)
 	if (setup->ep)
 		queue_remove(setup->ep->setups, setup);
 
+	queue_destroy(setup->same_big_setups, NULL);
+
 	setup_io_close(setup, NULL);
 
 	util_iov_free(setup->caps, 1);
 	util_iov_free(setup->metadata, 1);
 	util_iov_free(setup->base, 1);
 
-	if (bt_bap_stream_get_type(setup->stream) == BT_BAP_STREAM_TYPE_BCAST)
-		util_iov_free(setup->qos.bcast.bcode, 1);
-
 	free(setup);
 }
 
+static void link_setups(void *data, void *user_data)
+{
+	struct bap_ep *ep = data;
+	struct bap_setup *setup = user_data;
+	const struct queue_entry *entry;
+
+	for (entry = queue_get_entries(ep->setups); entry;
+					entry = entry->next) {
+		struct bap_setup *iter_setup = entry->data;
+
+		if (iter_setup == setup)
+			continue;
+
+		if (setup->qos.bcast.big == iter_setup->qos.bcast.big) {
+			if (setup->same_big_setups == NULL)
+				setup->same_big_setups = queue_new();
+
+			if (iter_setup->same_big_setups == NULL)
+				iter_setup->same_big_setups = queue_new();
+
+			queue_push_tail(setup->same_big_setups, iter_setup);
+			queue_push_tail(iter_setup->same_big_setups, setup);
+		}
+	}
+}
+
+static void bap_pac_foreach_channel(size_t i, uint8_t l, uint8_t t, uint8_t *v,
+					void *user_data)
+{
+	struct ltv_compare_data *data = user_data;
+	uint32_t location32;
+
+	if (!v)
+		return;
+
+	memcpy(&location32, v, l);
+
+	/* If all the bits in the received bitmask are found
+	 * in the local bitmask we have a match
+	 */
+	if ((le32_to_cpu(location32) & data->data32) ==
+			le32_to_cpu(location32))
+		data->match = true;
+	else
+		data->match = false;
+}
+
+static bool verify_bis_location_suported(struct bap_setup *setup,
+						struct bap_ep *ep)
+{
+	uint8_t type = LC3_CONFIG_CHAN_ALLOC;
+	struct ltv_compare_data data;
+	struct iovec *caps =  util_iov_dup(setup->caps, 1);
+
+	data.data32 = bt_bap_pac_get_locations(ep->lpac);
+
+	util_ltv_foreach(caps->iov_base, caps->iov_len, &type,
+				bap_pac_foreach_channel, &data);
+
+	util_iov_free(caps, 1);
+
+	return data.match;
+}
+
 static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -882,13 +1696,52 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		setup->qos.ucast.cis_id = BT_ISO_QOS_CIS_UNSET;
 	}
 
+	/* Populate setup with the received data */
 	if (parse_configuration(&props, &setup->caps, &setup->metadata,
-				&setup->base, &setup->qos) < 0) {
+				&setup->qos, ep->lpac) < 0) {
 		DBG("Unable to parse configuration");
 		setup_free(setup);
 		return btd_error_invalid_args(msg);
 	}
 
+	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE) {
+		/*
+		 * Kernel uses bis id as advertising handler.
+		 * To open all BISes from a big on the same
+		 * advertisng handler set the bis
+		 * to BT_ISO_QOS_BIS_UNSET.
+		 */
+		setup->qos.bcast.bis = BT_ISO_QOS_BIS_UNSET;
+
+		if (!verify_bis_location_suported(setup, ep)) {
+			DBG("BIS Location is unsupported");
+			return btd_error_invalid_args(msg);
+		}
+		bt_bap_add_vendor_pac_from_pac(ep->lpac);
+
+		/* Link all setups based on the BIG id */
+		queue_foreach(ep->data->bcast, link_setups, setup);
+
+		update_base(setup, data, bap_debug);
+		update_qos(setup, data);
+	} else if ((bt_bap_pac_get_type(ep->rpac) == BT_BAP_BCAST_SOURCE) &&
+			(bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK)) {
+		struct iovec *metadata;
+		struct iovec *caps;
+
+		util_iov_free(setup->caps, 1);
+		util_iov_free(setup->metadata, 1);
+
+		setup->caps = new0(struct iovec, 1);
+		setup->metadata = new0(struct iovec, 1);
+		setup->io = ep->data->listen_io;
+
+		bt_bap_pac_get_vendor_codec(ep->rpac, NULL, NULL, NULL, &caps,
+						&metadata);
+		bt_bap_ltv_merge(setup->caps, caps, false);
+		bt_bap_ltv_merge(setup->metadata, metadata, false);
+	}
+
 	setup->stream = bt_bap_stream_new(ep->data->bap, ep->lpac, ep->rpac,
 						&setup->qos, setup->caps);
 
@@ -900,12 +1753,12 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_invalid_args(msg);
 	}
 
-	bt_bap_stream_set_user_data(setup->stream, ep->path);
-
 	if (setup->metadata && setup->metadata->iov_len)
 		bt_bap_stream_metadata(setup->stream, setup->metadata, NULL,
 								NULL);
 
+	bt_bap_stream_set_user_data(setup->stream, ep->path);
+
 	switch (bt_bap_stream_get_type(setup->stream)) {
 	case BT_BAP_STREAM_TYPE_UCAST:
 		setup->msg = dbus_message_ref(msg);
@@ -944,30 +1797,21 @@ static void update_bcast_qos(struct bt_iso_qos *qos,
 	bap_qos->bcast.io_qos.sdu = qos->bcast.in.sdu;
 	bap_qos->bcast.io_qos.rtn = qos->bcast.in.rtn;
 
-	bap_qos->bcast.bcode = new0(struct iovec, 1);
-	util_iov_memcpy(bap_qos->bcast.bcode, qos->bcast.bcode,
-		sizeof(qos->bcast.bcode));
+	memcpy(bap_qos->bcast.bcode, qos->bcast.bcode,
+				sizeof(bap_qos->bcast.bcode));
 }
 
 static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 {
 	struct bap_setup *setup = user_data;
 	struct bap_ep *ep = setup->ep;
-	struct bap_data *data = ep->data;
 	struct bt_iso_qos qos;
-	struct bt_iso_base base;
 	char address[18];
 	int fd;
-	struct iovec *base_io;
-	uint32_t presDelay;
-	uint8_t numSubgroups;
-	uint8_t numBis;
-	struct bt_bap_codec codec;
 
 	bt_io_get(io, &err,
 			BT_IO_OPT_DEST, address,
 			BT_IO_OPT_QOS, &qos,
-			BT_IO_OPT_BASE, &base,
 			BT_IO_OPT_INVALID);
 	if (err) {
 		error("%s", err->message);
@@ -976,25 +1820,15 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 	}
 
 	g_io_channel_ref(io);
-	btd_service_connecting_complete(data->service, 0);
+	btd_service_connecting_complete(ep->data->service, 0);
 	DBG("BCAST ISO: sync with %s (BIG 0x%02x BIS 0x%02x)",
 					address, qos.bcast.big, qos.bcast.bis);
 
 	update_bcast_qos(&qos, &setup->qos);
 
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
 	setup->id = bt_bap_stream_config(setup->stream, &setup->qos,
 					setup->caps, NULL, NULL);
-	data->listen_io = io;
+	setup->io = io;
 
 	bt_bap_stream_set_user_data(setup->stream, ep->path);
 
@@ -1006,25 +1840,39 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 		return;
 	}
 
-
 	return;
 
 drop:
 	g_io_channel_shutdown(io, TRUE, NULL);
-
 }
 
 static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
 {
 	GError *err = NULL;
+	struct bt_iso_base base;
+	char address[18];
+	struct bt_bap_base base_s;
+	struct bap_data *data = user_data;
+	struct bt_iso_qos qos;
 
-	if (!bt_io_bcast_accept(io, iso_bcast_confirm_cb,
-				user_data, NULL, &err, BT_IO_OPT_INVALID)) {
-		error("bt_io_bcast_accept: %s", err->message);
+	bt_io_get(io, &err,
+			BT_IO_OPT_DEST, address,
+			BT_IO_OPT_QOS, &qos,
+			BT_IO_OPT_BASE, &base,
+			BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", err->message);
 		g_error_free(err);
-		g_io_channel_shutdown(io, TRUE, NULL);
+		return;
 	}
+	g_io_channel_ref(io);
+	data->listen_io = io;
+	btd_service_connecting_complete(data->service, 0);
+
+	base_s.subgroups = queue_new();
+	parse_base(data->bap, base.base, base.base_len, bap_debug, &base_s);
 
+	bt_bap_update_bcast_source(NULL, &base_s);
 }
 
 static bool match_data_bap_data(const void *data, const void *match_data)
@@ -1081,6 +1929,7 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 	int i, err = 0;
 	const char *suffix;
 	struct match_ep match = { lpac, rpac };
+	const GDBusPropertyTable *properties;
 
 	switch (bt_bap_pac_get_type(lpac)) {
 	case BT_BAP_BCAST_SOURCE:
@@ -1109,11 +1958,15 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 	case BT_BAP_BCAST_SOURCE:
 		err = asprintf(&ep->path, "%s/pac_%s%d",
 				adapter_get_path(adapter), suffix, i);
+		properties = ep_properties_bcast_source;
 		break;
 	case BT_BAP_BCAST_SINK:
 		err = asprintf(&ep->path, "%s/pac_%s%d",
 				device_get_path(device), suffix, i);
+		properties = ep_properties;
 		break;
+	default:
+		return NULL;
 	}
 
 	if (err < 0) {
@@ -1125,7 +1978,7 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 
 	if (g_dbus_register_interface(btd_get_dbus_connection(),
 			ep->path, MEDIA_ENDPOINT_INTERFACE,
-			ep_methods, NULL, ep_properties,
+			ep_methods, NULL, properties,
 			ep, ep_free) == FALSE) {
 		error("Could not register remote ep %s", ep->path);
 		ep_free(ep);
@@ -1646,9 +2499,12 @@ static gboolean setup_io_disconnected(GIOChannel *io, GIOCondition cond,
 
 	setup_io_close(setup, NULL);
 
-	/* Check if connecting recreate IO */
-	if (!is_cig_busy(setup->ep->data, setup->qos.ucast.cig_id))
-		recreate_cig(setup);
+	if (bt_bap_stream_get_type(setup->stream) ==
+					BT_BAP_STREAM_TYPE_UCAST) {
+		/* Check if connecting recreate IO */
+		if (!is_cig_busy(setup->ep->data, setup->qos.ucast.cig_id))
+			recreate_cig(setup);
+	}
 
 	return FALSE;
 }
@@ -1741,7 +2597,7 @@ static void setup_connect_io(struct bap_data *data, struct bap_setup *setup,
 static void setup_connect_io_broadcast(struct bap_data *data,
 					struct bap_setup *setup,
 					struct bt_bap_stream *stream,
-					struct bt_iso_qos *qos)
+					struct bt_iso_qos *qos, int defer)
 {
 	struct btd_adapter *adapter = data->user_data;
 	GIOChannel *io = NULL;
@@ -1778,7 +2634,7 @@ static void setup_connect_io_broadcast(struct bap_data *data,
 			BT_IO_OPT_MODE, BT_IO_MODE_ISO,
 			BT_IO_OPT_QOS, qos,
 			BT_IO_OPT_BASE, &base,
-			BT_IO_OPT_DEFER_TIMEOUT, false,
+			BT_IO_OPT_DEFER_TIMEOUT, defer,
 			BT_IO_OPT_INVALID);
 
 	if (!io) {
@@ -1832,41 +2688,28 @@ static void setup_listen_io_broadcast(struct bap_data *data,
 					struct bt_bap_stream *stream,
 					struct bt_iso_qos *qos)
 {
-	GIOChannel *io;
 	GError *err = NULL;
 	struct sockaddr_iso_bc iso_bc_addr;
 
 	iso_bc_addr.bc_bdaddr_type = btd_device_get_bdaddr_type(data->device);
 	memcpy(&iso_bc_addr.bc_bdaddr, device_get_address(data->device),
 			sizeof(bdaddr_t));
-	iso_bc_addr.bc_bis[0] = 1;
 	iso_bc_addr.bc_num_bis = 1;
+	iso_bc_addr.bc_bis[0] = strtol(bt_bap_pac_get_name(setup->ep->rpac),
+					NULL, 10);
 
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
+	if (!bt_io_bcast_accept(setup->io,
+				iso_bcast_confirm_cb,
+				setup, NULL, &err,
+				BT_IO_OPT_ISO_BC_NUM_BIS,
+				iso_bc_addr.bc_num_bis, BT_IO_OPT_ISO_BC_BIS,
+				iso_bc_addr.bc_bis, BT_IO_OPT_INVALID)) {
+		error("bt_io_bcast_accept: %s", err->message);
 		g_error_free(err);
+		g_io_channel_shutdown(setup->ep->data->listen_io, TRUE, NULL);
 	}
-	setup->io = io;
-	data->listen_io = io;
-
 }
 static void setup_create_ucast_io(struct bap_data *data,
 					struct bap_setup *setup,
@@ -1902,32 +2745,37 @@ static void setup_create_bcast_io(struct bap_data *data,
 					struct bt_bap_stream *stream, int defer)
 {
 	struct bt_iso_qos iso_qos;
+	struct bt_bap_qos *qos;
 
-	memset(&iso_qos, 0, sizeof(iso_qos));
 
-	if (!defer)
-		goto done;
+	memset(&iso_qos, 0, sizeof(iso_qos));
 
-	iso_qos.bcast.big = setup->qos.bcast.big;
-	iso_qos.bcast.bis = setup->qos.bcast.bis;
-	iso_qos.bcast.sync_factor = setup->qos.bcast.sync_factor;
-	iso_qos.bcast.packing = setup->qos.bcast.packing;
-	iso_qos.bcast.framing = setup->qos.bcast.framing;
-	iso_qos.bcast.encryption = setup->qos.bcast.encryption;
-	if (setup->qos.bcast.bcode)
-		memcpy(iso_qos.bcast.bcode, setup->qos.bcast.bcode->iov_base,
-									16);
-	iso_qos.bcast.options = setup->qos.bcast.options;
-	iso_qos.bcast.skip = setup->qos.bcast.skip;
-	iso_qos.bcast.sync_timeout = setup->qos.bcast.sync_timeout;
-	iso_qos.bcast.sync_cte_type = setup->qos.bcast.sync_cte_type;
-	iso_qos.bcast.mse = setup->qos.bcast.mse;
-	iso_qos.bcast.timeout = setup->qos.bcast.timeout;
-	memcpy(&iso_qos.bcast.out, &setup->qos.bcast.io_qos,
+	if (bt_bap_pac_get_type(setup->ep->lpac) ==
+					BT_BAP_BCAST_SOURCE)
+		qos = &setup->combined_qos;
+	else
+		qos = &setup->qos;
+
+	iso_qos.bcast.big = qos->bcast.big;
+	iso_qos.bcast.bis = qos->bcast.bis;
+	iso_qos.bcast.sync_factor = qos->bcast.sync_factor;
+	iso_qos.bcast.packing = qos->bcast.packing;
+	iso_qos.bcast.framing = qos->bcast.framing;
+	iso_qos.bcast.encryption = qos->bcast.encryption;
+	memcpy(iso_qos.bcast.bcode, qos->bcast.bcode,
+				sizeof(iso_qos.bcast.bcode));
+	iso_qos.bcast.options = qos->bcast.options;
+	iso_qos.bcast.skip = qos->bcast.skip;
+	iso_qos.bcast.sync_timeout = qos->bcast.sync_timeout;
+	iso_qos.bcast.sync_cte_type = qos->bcast.sync_cte_type;
+	iso_qos.bcast.mse = qos->bcast.mse;
+	iso_qos.bcast.timeout = qos->bcast.timeout;
+	memcpy(&iso_qos.bcast.out, &qos->bcast.io_qos,
 				sizeof(struct bt_iso_io_qos));
-done:
+
 	if (bt_bap_pac_get_type(setup->ep->lpac) == BT_BAP_BCAST_SOURCE)
-		setup_connect_io_broadcast(data, setup, stream, &iso_qos);
+		setup_connect_io_broadcast(data, setup, stream,
+						&iso_qos, defer);
 	else
 		setup_listen_io_broadcast(data, setup, stream, &iso_qos);
 }
@@ -1953,6 +2801,30 @@ static void setup_create_io(struct bap_data *data, struct bap_setup *setup,
 		break;
 	}
 }
+/*
+ * Function  test_linked_streams_state will check if all linked streams
+ * have the test state.
+ * If all streams are in test_state returns true; Else returns false
+ */
+static bool test_linked_streams_state(struct bap_setup *setup,
+						uint8_t test_state)
+{
+	const struct queue_entry *entry;
+	struct bap_setup *linked_setups;
+
+	if (!setup->same_big_setups)
+		return true;
+
+	for (entry = queue_get_entries(setup->same_big_setups); entry;
+						entry = entry->next) {
+		linked_setups = entry->data;
+		if (bt_bap_stream_get_state(linked_setups->stream) !=
+							test_state)
+			return false;
+	}
+
+	return true;
+}
 
 static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 				uint8_t new_state, void *user_data)
@@ -1983,17 +2855,29 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 		break;
 	case BT_BAP_STREAM_STATE_CONFIG:
 		if (setup && !setup->id) {
-			setup_create_io(data, setup, stream, true);
-			if (!setup->io) {
-				error("Unable to create io");
-				if (old_state != BT_BAP_STREAM_STATE_RELEASING)
-					bt_bap_stream_release(stream, NULL,
-								NULL);
-				return;
-			}
-
 			if (bt_bap_stream_get_type(stream) ==
+					BT_BAP_STREAM_TYPE_BCAST) {
+				bool defer = !test_linked_streams_state(setup,
+						BT_BAP_STREAM_STATE_CONFIG);
+				setup_create_io(data, setup, stream, defer);
+				if (!setup->io) {
+					error("Unable to create io");
+					if (old_state !=
+						BT_BAP_STREAM_STATE_RELEASING)
+						bt_bap_stream_release(stream,
+								NULL,
+								NULL);
+					return;
+				}
+			} else if (bt_bap_stream_get_type(stream) ==
 					BT_BAP_STREAM_TYPE_UCAST) {
+				setup_create_io(data, setup, stream, true);
+				if (!setup->io) {
+					error("Unable to create io");
+					bt_bap_stream_release(stream,
+								NULL, NULL);
+					return;
+				}
 				/* Wait QoS response to respond */
 				setup->id = bt_bap_stream_qos(stream,
 								&setup->qos,
@@ -2311,6 +3195,12 @@ static int bap_bcast_probe(struct btd_service *service)
 	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
 	struct bap_data *data = btd_service_get_user_data(service);
 	char addr[18];
+	GIOChannel *io;
+	GError *err = NULL;
+	struct sockaddr_iso_bc iso_bc_addr;
+
+	iso_bc_addr.bc_bis[0] = 1;
+	iso_bc_addr.bc_num_bis = 1;
 
 	ba2str(device_get_address(device), addr);
 
@@ -2349,7 +3239,24 @@ static int bap_bcast_probe(struct btd_service *service)
 
 	bt_bap_set_user_data(data->bap, service);
 
-	bt_bap_new_bcast_source(data->bap, device_get_path(device));
+	DBG("Create PA sync with source");
+	io = bt_io_listen(NULL, iso_pa_sync_confirm_cb, data, NULL, &err,
+			BT_IO_OPT_SOURCE_BDADDR,
+			btd_adapter_get_address(data->adapter),
+			BT_IO_OPT_DEST_BDADDR,
+			device_get_address(data->device),
+			BT_IO_OPT_DEST_TYPE,
+			btd_device_get_bdaddr_type(data->device),
+			BT_IO_OPT_MODE, BT_IO_MODE_ISO,
+			BT_IO_OPT_QOS, &default_qos,
+			BT_IO_OPT_ISO_BC_NUM_BIS, iso_bc_addr.bc_num_bis,
+			BT_IO_OPT_ISO_BC_BIS, iso_bc_addr.bc_bis,
+			BT_IO_OPT_INVALID);
+	if (!io) {
+		error("%s", err->message);
+		g_error_free(err);
+	}
+
 	return 0;
 }
 
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index a4696154a..657474a67 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -172,7 +172,9 @@ find_transport_by_bap_stream(const struct bt_bap_stream *stream)
 		struct bap_transport *bap;
 
 		if (strcasecmp(uuid, PAC_SINK_UUID) &&
-				strcasecmp(uuid, PAC_SOURCE_UUID))
+				strcasecmp(uuid, PAC_SOURCE_UUID) &&
+				strcasecmp(uuid, BCAA_SERVICE_UUID) &&
+				strcasecmp(uuid, BAA_SERVICE_UUID))
 			continue;
 
 		bap = transport->data;
@@ -776,7 +778,11 @@ static gboolean get_device(const GDBusPropertyTable *property,
 	if (transport->device)
 		path = device_get_path(transport->device);
 	else
-		path = adapter_get_path(transport->adapter);
+		/*
+		 *Use remote endpoint path as fake device path
+		 *for broadcast source transport
+		 */
+		path = transport->remote_endpoint;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
 
@@ -1132,6 +1138,7 @@ static gboolean get_bcast_qos(const GDBusPropertyTable *property,
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
 	DBusMessageIter dict;
+	uint8_t *temp = bap->qos.bcast.bcode;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
 					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
@@ -1150,10 +1157,9 @@ static gboolean get_bcast_qos(const GDBusPropertyTable *property,
 					&bap->qos.bcast.packing);
 	dict_append_entry(&dict, "Framing", DBUS_TYPE_BYTE,
 					&bap->qos.bcast.framing);
-	if (bap->qos.bcast.bcode)
-		dict_append_array(&dict, "BCode", DBUS_TYPE_BYTE,
-					&bap->qos.bcast.bcode->iov_base,
-					bap->qos.bcast.bcode->iov_len);
+	dict_append_array(&dict, "BCode", DBUS_TYPE_BYTE,
+					&temp,
+					sizeof(bap->qos.bcast.bcode));
 	dict_append_entry(&dict, "Options", DBUS_TYPE_BYTE,
 					&bap->qos.bcast.options);
 	dict_append_entry(&dict, "Skip", DBUS_TYPE_UINT16,
@@ -1614,9 +1620,10 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 		/* If a request is pending wait it to complete */
 		if (owner && owner->pending)
 			return;
-		bap_update_links(transport);
-		if (!media_endpoint_is_broadcast(transport->endpoint))
+		if (!media_endpoint_is_broadcast(transport->endpoint)) {
+			bap_update_links(transport);
 			bap_update_qos(transport);
+		}
 		else if (bt_bap_stream_io_dir(stream) != BT_BAP_BCAST_SOURCE)
 			bap_update_bcast_qos(transport);
 		transport_update_playing(transport, FALSE);
@@ -1633,7 +1640,7 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 			bap_update_bcast_qos(transport);
 		break;
 	case BT_BAP_STREAM_STATE_RELEASING:
-		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SINK)
+		if (!bt_bap_stream_io_dir(stream))
 			return;
 		break;
 	}
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 078d308dc..6934c6d2d 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -30,6 +30,7 @@
 #include "src/shared/bap.h"
 #include "src/shared/ascs.h"
 #include "src/shared/bap-debug.h"
+#include "src/shared/lc3.h"
 
 /* Maximum number of ASE(s) */
 #define NUM_SINKS 2
@@ -260,6 +261,8 @@ static struct queue *bap_db;
 static struct queue *bap_cbs;
 static struct queue *sessions;
 
+static bool bt_bap_new_bcast_sink(struct bt_bap *bap);
+
 static bool bap_db_match(const void *data, const void *match_data)
 {
 	const struct bt_bap_db *bdb = data;
@@ -1343,6 +1346,12 @@ static void stream_set_state_broadcast(struct bt_bap_stream *stream,
 
 	bt_bap_ref(bap);
 
+	switch (stream->ep->state) {
+	case BT_ASCS_ASE_STATE_QOS:
+		bap_stream_update_io_links(stream);
+		break;
+	}
+
 	for (entry = queue_get_entries(bap->state_cbs); entry;
 							entry = entry->next) {
 		struct bt_bap_state *state = entry->data;
@@ -2377,21 +2386,6 @@ static struct bt_bap_pac *bap_pac_find(struct bt_bap_db *bdb, uint8_t type,
 	return NULL;
 }
 
-static void *ltv_merge(struct iovec *data, struct iovec *cont)
-{
-	uint8_t delimiter = 0;
-
-	if (!data)
-		return NULL;
-
-	if (!cont || !cont->iov_len || !cont->iov_base)
-		return data->iov_base;
-
-	iov_append(data, sizeof(delimiter), &delimiter);
-
-	return iov_append(data, cont->iov_len, cont->iov_base);
-}
-
 static void bap_pac_foreach_channel(size_t i, uint8_t l, uint8_t t, uint8_t *v,
 					void *user_data)
 {
@@ -2427,7 +2421,7 @@ static void bap_pac_merge(struct bt_bap_pac *pac, struct iovec *data,
 {
 	/* Merge data into existing record */
 	if (pac->data)
-		ltv_merge(pac->data, data);
+		bt_bap_ltv_merge(pac->data, data, true);
 	else
 		pac->data = util_iov_dup(data, 1);
 
@@ -2436,7 +2430,7 @@ static void bap_pac_merge(struct bt_bap_pac *pac, struct iovec *data,
 
 	/* Merge metadata into existing record */
 	if (pac->metadata)
-		ltv_merge(pac->metadata, metadata);
+		bt_bap_ltv_merge(pac->metadata, metadata, true);
 	else
 		pac->metadata = util_iov_dup(metadata, 1);
 }
@@ -2650,6 +2644,8 @@ static void bap_add_broadcast_source(struct bt_bap_pac *pac)
 static void bap_add_broadcast_sink(struct bt_bap_pac *pac)
 {
 	queue_push_tail(pac->bdb->broadcast_sinks, pac);
+
+	pacs_add_sink_location(pac->bdb->pacs, pac->qos.location);
 }
 
 static void notify_pac_added(void *data, void *user_data)
@@ -2668,6 +2664,20 @@ static void notify_session_pac_added(void *data, void *user_data)
 	queue_foreach(bap->pac_cbs, notify_pac_added, user_data);
 }
 
+struct bt_bap_pac *bt_bap_add_vendor_pac_from_pac(struct bt_bap_pac *pac)
+{
+	struct bt_bap_pac *new_pac;
+
+	new_pac = bt_bap_add_vendor_pac(pac->bdb->db, pac->name, pac->type,
+							pac->codec.id,
+							pac->codec.cid,
+							pac->codec.cid,
+							&pac->qos, pac->data,
+							pac->metadata);
+	bt_bap_pac_set_ops(new_pac, pac->ops, pac->user_data);
+	return new_pac;
+}
+
 struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 					const char *name, uint8_t type,
 					uint8_t id, uint16_t cid, uint16_t vid,
@@ -2725,7 +2735,7 @@ struct bt_bap_pac *bt_bap_add_pac(struct gatt_db *db, const char *name,
 					struct iovec *metadata)
 {
 	return bt_bap_add_vendor_pac(db, name, type, id, 0x0000, 0x0000, qos,
-							data, metadata);
+						    data, metadata);
 }
 
 uint8_t bt_bap_pac_get_type(struct bt_bap_pac *pac)
@@ -2748,13 +2758,24 @@ uint32_t bt_bap_pac_get_locations(struct bt_bap_pac *pac)
 	switch (pac->type) {
 	case BT_BAP_SOURCE:
 		return pacs->source_loc_value;
+	case BT_BAP_BCAST_SOURCE:
+		return pac->qos.location;
 	case BT_BAP_SINK:
+	case BT_BAP_BCAST_SINK:
 		return pacs->sink_loc_value;
 	default:
 		return 0;
 	}
 }
 
+struct iovec *bt_bap_pac_get_data(struct bt_bap_pac *pac)
+{
+	if (!pac)
+		return 0x00;
+
+	return pac->data;
+}
+
 uint16_t bt_bap_pac_get_supported_context(struct bt_bap_pac *pac)
 {
 	struct bt_pacs *pacs;
@@ -2837,12 +2858,26 @@ static void notify_session_pac_removed(void *data, void *user_data)
 bool bt_bap_pac_set_ops(struct bt_bap_pac *pac, struct bt_bap_pac_ops *ops,
 					void *user_data)
 {
+	const struct queue_entry *entry = NULL;
+	struct bt_bap_pac *pac_entry;
+
 	if (!pac)
 		return false;
 
 	pac->ops = ops;
 	pac->user_data = user_data;
 
+	if (pac->type == BT_BAP_BCAST_SOURCE) {
+		for (entry = queue_get_entries(pac->bdb->broadcast_sources);
+					entry != NULL; entry = entry->next) {
+			pac_entry = entry->data;
+			if (pac_entry != pac) {
+				pac_entry->ops = ops;
+				pac_entry->user_data = user_data;
+			}
+		}
+	}
+
 	return true;
 }
 
@@ -4489,6 +4524,11 @@ bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct bt_bap_pac *pac)
 	return false;
 }
 
+char *bt_bap_pac_get_name(struct bt_bap_pac *pac)
+{
+	return pac->name;
+}
+
 static bool find_ep_unused(const void *data, const void *user_data)
 {
 	const struct bt_bap_endpoint *ep = data;
@@ -4618,7 +4658,6 @@ unsigned int bt_bap_stream_config(struct bt_bap_stream *stream,
 		if (stream->lpac->type == BT_BAP_BCAST_SINK) {
 			if (data)
 				stream_config(stream, data, NULL);
-			stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
 		}
 		return 1;
 	}
@@ -4763,7 +4802,7 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 			return NULL;
 
 		bt_bap_foreach_pac(bap, type, match_pac, &match);
-		if (!match.lpac)
+		if ((!match.lpac) || (!lpac))
 			return NULL;
 		if (!match.rpac && (lpac->type != BT_BAP_BCAST_SOURCE))
 			return NULL;
@@ -4780,7 +4819,15 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 	if (!ep) {
 		/* Check for unused ASE */
 		ep = queue_find(bap->remote_eps, find_ep_unused, &match);
-		if (!ep) {
+		if (!ep && lpac->type == BT_BAP_BCAST_SOURCE) {
+			bt_bap_new_bcast_sink(bap);
+			ep = queue_find(bap->remote_eps, find_ep_unused,
+								&match);
+			if (!ep) {
+				DBG(bap, "Unable to find unused ASE");
+				return NULL;
+			}
+		} else if (!ep) {
 			DBG(bap, "Unable to find unused ASE");
 			return NULL;
 		}
@@ -4943,11 +4990,10 @@ unsigned int bt_bap_stream_enable(struct bt_bap_stream *stream,
 	case BT_BAP_STREAM_TYPE_BCAST:
 		if (!bt_bap_stream_io_dir(stream))
 			stream_set_state_broadcast(stream,
-				BT_BAP_STREAM_STATE_CONFIG);
+						BT_BAP_STREAM_STATE_CONFIG);
 		else if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
 			stream_set_state_broadcast(stream,
 				 BT_BAP_STREAM_STATE_STREAMING);
-
 		return 1;
 	}
 
@@ -5094,13 +5140,21 @@ unsigned int bt_bap_stream_metadata(struct bt_bap_stream *stream,
 	if (!stream)
 		return 0;
 
-	if (!stream->client) {
-		stream_metadata(stream, metadata, NULL);
+	switch (bt_bap_stream_get_type(stream)) {
+	case BT_BAP_STREAM_TYPE_UCAST:
+		if (!stream->client) {
+			stream_metadata(stream, metadata, NULL);
+			return 0;
+		}
+		return bap_stream_metadata(stream, BT_ASCS_METADATA,
+				metadata, func,	user_data);
+	case BT_BAP_STREAM_TYPE_BCAST:
+		util_iov_free(stream->meta, 1);
+		stream->meta = util_iov_dup(metadata, 1);
+		return 1;
+	default:
 		return 0;
 	}
-
-	return bap_stream_metadata(stream, BT_ASCS_METADATA, metadata, func,
-								user_data);
 }
 
 unsigned int bt_bap_stream_release(struct bt_bap_stream *stream,
@@ -5207,6 +5261,14 @@ struct iovec *bt_bap_stream_get_metadata(struct bt_bap_stream *stream)
 	return stream->meta;
 }
 
+struct bt_bap_pac *bt_bap_stream_get_local_pac(struct bt_bap_stream *stream)
+{
+	if (!stream)
+		return NULL;
+
+	return stream->lpac;
+}
+
 struct io *bt_bap_stream_get_io(struct bt_bap_stream *stream)
 {
 	struct bt_bap_stream_io *io;
@@ -5265,6 +5327,23 @@ static bool match_name(const void *data, const void *match_data)
 	return (!strcmp(pac->name, name));
 }
 
+void *bt_bap_ltv_merge(struct iovec *data, struct iovec *cont,
+						bool add_delimiter)
+{
+	uint8_t delimiter = 0;
+
+	if (!data)
+		return NULL;
+
+	if (!cont || !cont->iov_len || !cont->iov_base)
+		return data->iov_base;
+
+	if (add_delimiter)
+		iov_append(data, sizeof(delimiter), &delimiter);
+
+	return iov_append(data, cont->iov_len, cont->iov_base);
+}
+
 int bt_bap_stream_cancel(struct bt_bap_stream *stream, unsigned int id)
 {
 	struct bt_bap_req *req;
@@ -5301,9 +5380,9 @@ int bt_bap_stream_io_link(struct bt_bap_stream *stream,
 		return -EALREADY;
 
 	if (stream->client != link->client ||
-			stream->qos.ucast.cig_id != link->qos.ucast.cig_id ||
-			stream->qos.ucast.cis_id != link->qos.ucast.cis_id ||
-			stream->ep->dir == link->ep->dir)
+		stream->qos.ucast.cig_id != link->qos.ucast.cig_id ||
+		stream->qos.ucast.cis_id != link->qos.ucast.cis_id ||
+		stream->ep->dir == link->ep->dir)
 		return -EINVAL;
 
 	stream->link = link;
@@ -5484,11 +5563,301 @@ bool bt_bap_new_bcast_source(struct bt_bap *bap, const char *name)
 	return true;
 }
 
+static bool bt_bap_new_bcast_sink(struct bt_bap *bap)
+{
+	struct bt_bap_endpoint *ep;
+
+	/* Push remote endpoint with direction source */
+	ep = bap_endpoint_new_broadcast(bap->ldb, BT_BAP_BCAST_SOURCE);
+
+	if (ep)
+		queue_push_tail(bap->remote_eps, ep);
+
+	ep->bap = bap;
+	return true;
+}
+
+struct ltv_compare_data {
+	bool match;
+	void *data;
+	uint32_t data32;
+};
+
+static void bap_sink_match_allocation(size_t i, uint8_t l, uint8_t t,
+		uint8_t *v, void *user_data)
+{
+	struct ltv_compare_data *data = user_data;
+	uint32_t location32;
+
+	if (!v)
+		return;
+
+	memcpy(&location32, v, l);
+
+	/* If all the bits in the received bitmask are found in
+	 * the local bitmask then we have a match
+	 */
+	if ((le32_to_cpu(location32) & data->data32) ==
+			le32_to_cpu(location32))
+		data->match = true;
+	else
+		data->match = false;
+}
+
+static void bap_sink_match_caps_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
+					void *user_data)
+{
+	struct ltv_compare_data *local_data = user_data;
+	struct iovec local_caps = *((struct iovec *)local_data->data);
+	struct bt_ltv *ltv = NULL;
+	bool found = false;
+
+	/* Search for {l,t,v} in local_caps */
+	do {
+		ltv = util_iov_pull_mem(&local_caps, sizeof(*ltv));
+
+		if (ltv != NULL) {
+			/* If the LTV is found, continue */
+			if (ltv->type == t) {
+				switch (ltv->type) {
+				case LC3_FREQ:
+				{
+					uint16_t val16 =
+						*((uint16_t *)ltv->value);
+					val16 = le16_to_cpu(val16);
+					if (val16 & (1 << (v[0] - 1)))
+						found = true;
+				}
+				break;
+				case LC3_DURATION:
+					if ((ltv->value[0]) & (1 << v[0]))
+						found = true;
+					break;
+				/* LC3_CHAN_COUNT */
+				case LC3_FRAME_LEN:
+				{
+					uint16_t min =
+						*((uint16_t *)ltv->value);
+					uint16_t max =
+					*((uint16_t *)(&ltv->value[2]));
+					uint16_t frame_len = *((uint16_t *)v);
+
+					min = le16_to_cpu(min);
+					max = le16_to_cpu(max);
+					frame_len = le16_to_cpu(frame_len);
+					if ((frame_len >= min) &&
+							(frame_len <= max))
+						found = true;
+				}
+				/* LC3_FRAME_COUNT */
+				break;
+				}
+
+				if (found)
+					/* Matching LTV found -> mark it
+					 * in the output bitmask
+					 */
+					local_data->data32 |= 1<<t;
+			}
+
+			/* Advance over data field */
+			(void)util_iov_pull_mem(&local_caps, ltv->len - 1);
+		}
+	} while ((local_caps.iov_len > 0) && (ltv != NULL) &&
+			(found == false));
+}
+
+static void check_capabilities(void *data, void *user_data)
+{
+	struct ltv_compare_data *ltv_data = user_data;
+
+	#define Codec_Specific_Configuration_Check_Mask (\
+			(1<<LC3_FREQ)|\
+			(1<<LC3_DURATION)|\
+			/*(1<<LC3_CONFIG_CHAN_ALLOC)|\*/\
+			(1<<LC3_FRAME_LEN))
+
+	/* Keep searching for a matching PAC if one wasn't found
+	 * in previous PAC elements
+	 */
+	if (ltv_data->match == false) {
+		const struct bt_bap_pac *pac = data;
+		struct iovec *in_caps = (struct iovec *)ltv_data->data;
+		struct ltv_compare_data local_ltv_data = {
+				.data = pac->data,
+				.data32 = 0, /* LTVs bitmask result */
+				.match = false
+		};
+
+		util_ltv_foreach(in_caps->iov_base, in_caps->iov_len, NULL,
+				bap_sink_match_caps_ltv, &local_ltv_data);
+
+		/* We have a match if all selected LTVs have a match */
+		if (local_ltv_data.data32 &
+				Codec_Specific_Configuration_Check_Mask)
+			ltv_data->match = true;
+	}
+}
+
+static bool bap_compare_ltv_capabilities(struct iovec *in_caps,
+		uint32_t location,
+		struct queue *local_data)
+{
+	struct ltv_compare_data ltv_data = {0};
+	uint8_t type = 0;
+
+	/* Check Audio_Channel_Allocation LTV from PACS data */
+	if (location) {
+		ltv_data.data32 = location;
+		type = LC3_CONFIG_CHAN_ALLOC;
+
+		util_ltv_foreach(in_caps->iov_base, in_caps->iov_len, &type,
+				bap_sink_match_allocation, &ltv_data);
+	}
+
+	/* Check remaining LTVs from PACs list */
+	if (ltv_data.match) {
+		ltv_data.data = in_caps;
+		ltv_data.match = false;
+		queue_foreach(local_data, check_capabilities, &ltv_data);
+	}
+
+	return ltv_data.match;
+}
+
+static void bap_sink_get_allocation(size_t i, uint8_t l, uint8_t t,
+		uint8_t *v, void *user_data)
+{
+	uint32_t location32;
+
+	if (!v)
+		return;
+
+	memcpy(&location32, v, l);
+	*((uint32_t *)user_data) = le32_to_cpu(location32);
+}
+
+static void print_caps(const char *str, void *user_data)
+{
+	printf("%s\n\r", str);
+}
+
+static void merge_codec_specific_config(struct iovec *caps_l2,
+		struct iovec *caps_l3, struct iovec *result)
+{
+	struct iovec iov_l2 = {0};
+	struct iovec iov_l3 = {0};
+	struct bt_ltv *ltv2 = NULL;
+
+	/* Loop Level 2 LTVs */
+	iov_l2 = *caps_l2;
+	do {
+		iov_l3 = *caps_l3;
+		ltv2 = util_iov_pull_mem(&iov_l2, sizeof(*ltv2));
+
+		if (ltv2 != NULL) {
+			struct bt_ltv *ltv3 = NULL;
+			bool found = false; /* found at Level3? */
+
+			/* Loop Level 3 LTVs */
+			do {
+				ltv3 = util_iov_pull_mem(&iov_l3,
+							sizeof(*ltv3));
+
+				if (ltv3 != NULL) {
+					/* If the LTV is found,
+					 * continue
+					 */
+					if (ltv3->type == ltv2->type)
+						found = true;
+
+					/* Advance over data field */
+					(void)util_iov_pull_mem(&iov_l3,
+							ltv3->len - 1);
+				}
+			} while ((iov_l3.iov_len > 0) && (ltv3 != NULL) &&
+					(found == false));
+
+			/* In case LTV (L3) was not found at L2 add it */
+			if (!found)
+				iov_append(result, ltv2->len + 1, ltv2);
+			/* In case LTV (L3) was found at L2,
+			 * get the one at Level 3
+			 */
+			else
+				iov_append(result, ltv3->len + 1, ltv3);
+
+			/* Advance over data field */
+			(void)util_iov_pull_mem(&iov_l2, ltv2->len - 1);
+		}
+	} while ((iov_l2.iov_len > 0) && (ltv2 != NULL));
+}
+
+static void bis_to_pac(void *data, void *user_data)
+{
+	struct bt_bap_bis *bis = data;
+	struct bt_bap_base_subgroup *subgroup = user_data;
+	struct bt_bap_pac *pac_source_bis;
+	struct bt_bap_endpoint *ep;
+	int err = 0;
+	struct bt_bap_pac_qos bis_qos = {0};
+	uint8_t type = 0;
+	struct iovec *iov_bis = new0(struct iovec, 1);
+
+	/* Create a Codec Specific Configuration with LTVs at level 2
+	 * overwritten by LTVs at level 3
+	 */
+	merge_codec_specific_config(subgroup->caps, bis->caps, iov_bis);
+
+	/* Search in local database to see if this BIS
+	 * matches our capabilities
+	 */
+	if (bap_compare_ltv_capabilities(iov_bis,
+			subgroup->bap->ldb->pacs->sink_loc_value,
+			subgroup->bap->ldb->broadcast_sinks) != true)
+		return;
+
+	DBG(subgroup->bap, "Selected BIS %i", bis->bisIndex);
+	bt_bap_debug_caps(iov_bis->iov_base, iov_bis->iov_len,
+			print_caps, NULL);
+
+	/* Create a QoS structure based on the received BIS information */
+	type = LC3_CONFIG_CHAN_ALLOC;
+	util_ltv_foreach(iov_bis->iov_base, iov_bis->iov_len, &type,
+			bap_sink_get_allocation, &bis_qos.location);
+
+	/* Create a remote PAC */
+	pac_source_bis = bap_pac_new(subgroup->bap->rdb, NULL,
+				BT_BAP_BCAST_SOURCE, &subgroup->codec, &bis_qos,
+				iov_bis, subgroup->meta);
+
+	err = asprintf(&pac_source_bis->name, "%d", bis->bisIndex);
+
+	if (err < 0)
+		DBG(subgroup->bap, "error in asprintf");
+
+	/* Add remote source endpoint */
+	if (!subgroup->bap->rdb->broadcast_sources)
+		subgroup->bap->rdb->broadcast_sources = queue_new();
+	queue_push_tail(subgroup->bap->rdb->broadcast_sources, pac_source_bis);
+
+	queue_foreach(subgroup->bap->pac_cbs, notify_pac_added, pac_source_bis);
+	/* Push remote endpoint with direction sink */
+	ep = bap_endpoint_new_broadcast(subgroup->bap->rdb, BT_BAP_BCAST_SINK);
+
+	if (ep)
+		queue_push_tail(subgroup->bap->remote_eps, ep);
+
+	util_iov_free(iov_bis, 1);
+}
+static void parse_bis(void *data, void *user_data)
+{
+	struct bt_bap_base_subgroup *subgroup = data;
+
+	queue_foreach(subgroup->bises, bis_to_pac, subgroup);
+}
 void bt_bap_update_bcast_source(struct bt_bap_pac *pac,
-					struct bt_bap_codec *codec,
-					struct iovec *data,
-					struct iovec *metadata)
+				struct bt_bap_base *base)
 {
-	bap_pac_merge(pac, data, metadata);
-	pac->codec = *codec;
+	queue_foreach(base->subgroups, parse_bis, NULL);
 }
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 51edc08ab..814b3af9e 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -79,7 +79,7 @@ struct bt_bap_bcast_qos {
 	uint8_t  packing;
 	uint8_t  framing;
 	uint8_t  encryption;
-	struct iovec *bcode;
+	uint8_t  bcode[16];
 	uint8_t  options;
 	uint16_t skip;
 	uint16_t sync_timeout;
@@ -87,6 +87,7 @@ struct bt_bap_bcast_qos {
 	uint8_t  mse;
 	uint16_t timeout;
 	uint8_t  pa_sync;
+	uint32_t delay;			/* Presentation Delay */
 	struct bt_bap_io_qos io_qos;
 };
 
@@ -97,6 +98,27 @@ struct bt_bap_qos {
 	};
 };
 
+struct bt_bap_base {
+	uint32_t pres_delay;
+	uint8_t num_subgroups;
+	struct queue *subgroups;
+};
+
+struct bt_bap_base_subgroup {
+	uint8_t subgroup_index;
+	struct bt_bap *bap;
+	uint8_t num_bises;
+	struct bt_bap_codec codec;
+	struct iovec *caps;
+	struct iovec *meta;
+	struct queue *bises;
+};
+
+struct bt_bap_bis {
+	uint8_t bisIndex;
+	struct iovec *caps;
+};
+
 typedef void (*bt_bap_ready_func_t)(struct bt_bap *bap, void *user_data);
 typedef void (*bt_bap_destroy_func_t)(void *user_data);
 typedef void (*bt_bap_debug_func_t)(const char *str, void *user_data);
@@ -168,6 +190,8 @@ uint8_t bt_bap_pac_get_type(struct bt_bap_pac *pac);
 
 uint32_t bt_bap_pac_get_locations(struct bt_bap_pac *pac);
 
+struct iovec *bt_bap_pac_get_data(struct bt_bap_pac *pac);
+
 uint16_t bt_bap_pac_get_supported_context(struct bt_bap_pac *pac);
 
 uint16_t bt_bap_pac_get_context(struct bt_bap_pac *pac);
@@ -176,6 +200,8 @@ struct bt_bap_pac_qos *bt_bap_pac_get_qos(struct bt_bap_pac *pac);
 
 uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream);
 
+struct bt_bap_pac *bt_bap_add_vendor_pac_from_pac(struct bt_bap_pac *pac);
+
 struct bt_bap_stream *bt_bap_pac_get_stream(struct bt_bap_pac *pac);
 
 /* Session related function */
@@ -231,6 +257,7 @@ int bt_bap_pac_get_codec(struct bt_bap_pac *pac, uint8_t *id,
 
 void bt_bap_pac_set_user_data(struct bt_bap_pac *pac, void *user_data);
 void *bt_bap_pac_get_user_data(struct bt_bap_pac *pac);
+char *bt_bap_pac_get_name(struct bt_bap_pac *pac);
 
 /* Stream related functions */
 int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
@@ -294,6 +321,7 @@ uint32_t bt_bap_stream_get_location(struct bt_bap_stream *stream);
 struct iovec *bt_bap_stream_get_config(struct bt_bap_stream *stream);
 struct bt_bap_qos *bt_bap_stream_get_qos(struct bt_bap_stream *stream);
 struct iovec *bt_bap_stream_get_metadata(struct bt_bap_stream *stream);
+struct bt_bap_pac *bt_bap_stream_get_local_pac(struct bt_bap_stream *stream);
 
 struct io *bt_bap_stream_get_io(struct bt_bap_stream *stream);
 bool bt_bap_match_bcast_sink_stream(const void *data, const void *user_data);
@@ -315,9 +343,9 @@ bool bt_bap_stream_io_is_connecting(struct bt_bap_stream *stream, int *fd);
 
 bool bt_bap_new_bcast_source(struct bt_bap *bap, const char *name);
 void bt_bap_update_bcast_source(struct bt_bap_pac *pac,
-					struct bt_bap_codec *codec,
-					struct iovec *data,
-					struct iovec *metadata);
+				struct bt_bap_base *base);
+void *bt_bap_ltv_merge(struct iovec *data, struct iovec *cont,
+						bool add_delimiter);
 
 bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct bt_bap_pac *pac);
 
-- 
2.39.2

