Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2089.outbound.protection.outlook.com [40.107.8.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247A94CB30
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jan 2024 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XQyo4ugg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdzShKSbYITKLRTHlXJOWIDeoj3Ku41RGve3VaCna+dDnsv9I7aAUGIH8YnkHdukXAj4esggQaqa9lipq2ryc6JrAogI1uvas/WMWrz+fYmoCaCrWl19KO5+To9wkL4QQpk0TTzSXLKixMD7mWpo62xx0fNKwdnECddIM4njktl0ifz6LglJwnHngcAJLEiP9Cg0TXObXepMPrBIEPRiz7fxl2q+hCNL6ORLISxSE1RXs8ITWmvOKTVTfrIDamVwTm8faLfc7QWWzCBVjaget6oFuW7EtNRmNCJcmKRb3M56AvyvpSx8kRaX5+XpnYLXefpQXAhMpMiQbPIgyYq61g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RM4GCg/zq4eQFZigqon4rHKgHigxmkSXu/D6wRjEMWE=;
 b=CZkA+4lvIxW3NQXqiUzdq031+QTcfpmP6bc4JBYzjGyzmYsn729AgiKXtV52GtI3sTSuGqjZExPmDQrHoJsr8SS9QZ98c8BWzYimvztgAS2SPwbtU8pw33Yqw7kJgl1gVBtUYyrMtCKFaYU09q2R36RxdxOv0uN+fprrjrWwloJLWBjWURAmGTSJDBGiC8rTkW5ieL0XI6WrJF4WEVswQmI7v+6syRXB0SR2w2hhFsChQtlq5ddEI/kC1LWN64mlXQiBltlS3uit48kbHSDyYqrXxVyTQUOrjBKictoEnGF3SjgRdVCEOQgvg7Y+ZM3Um+dzJfbmB+IW+7vKd8QHxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RM4GCg/zq4eQFZigqon4rHKgHigxmkSXu/D6wRjEMWE=;
 b=XQyo4uggzFAjR/r/GaB/gr91sAj2GQ/Y1X+aGtJxDT1ksr6c4TJSFpdlja4HSJxK++FgxfSNv388JgrDgPIwQHT6o4WVw8Ti1wHfI7SS9QPa1coD8M6gVXQg2Zov8Ci3WGdumpoGgMnplAnvqAbkWLKIRW4tAftomQBjBZdkBWo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AM9PR04MB7539.eurprd04.prod.outlook.com (2603:10a6:20b:2da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 16:58:36 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 16:58:36 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH v5 2/3] bap.c: Add support for multiple BISes
Date: Wed, 10 Jan 2024 18:58:23 +0200
Message-Id: <20240110165824.114022-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240110165824.114022-1-silviu.barbulescu@nxp.com>
References: <20240110165824.114022-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0091.eurprd03.prod.outlook.com
 (2603:10a6:208:69::32) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AM9PR04MB7539:EE_
X-MS-Office365-Filtering-Correlation-Id: 123d8eb5-cc1f-4c14-b220-08dc11fd6295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dPLeqKgvvaxEtAW4FAJ84eMkZsmOisS+e7jr/vj4oMcY+dsag1Ug3yC9YaeHHrc2vLc3yLhoJPvQjG2vVYTL6nt/n1e7NS4I8HdwwfVW7y0A++PPg4gRSLfDWWz5/0hfRVISzt6/3iQcHNM4yAMnxbmUZhTrJEFTLQvKC8kzxbWVcro7Ihn2aOtaPuPP8uf9BqXn5Hflc/yTn5JrTYVPonMpVRLxXfHd9okVpft8xHhEiTF0hytjwxsCaHREzrLdQauKTGtHN8dwn7ThONb8j6g1+HQh7iPzk10dgCABy9X7WfqmRUGZBSKKVmnvQz+FkAgRw6Ezl7pqeVKjawOGo8flDMf26fkUzBPCuzxcn3vkBl01Gf+HCOBTcDWQ0dqgm020RTXEAavhJQ3c23/NmIKZ1rpfkAn4wv3SLlrym+APAAgsNYRj4Bg2yKDdfwEJ0QtcWnRZnbgf7Chx59LDxy0Yvhut19S8LesWG/xJPFOKoIUQZHNm7Mqc/ePFfUBQjPI1GQeSwIpu3clwSm8Fq9aPsXZ9F5Rsg/scW29Dl3piYcinxSuHRw0pK4SNVLAC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(41300700001)(36756003)(86362001)(38100700002)(66946007)(2616005)(1076003)(26005)(6512007)(6486002)(2906002)(6916009)(66556008)(66476007)(478600001)(316002)(8936002)(6506007)(6666004)(5660300002)(4326008)(30864003)(8676002)(559001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PVtlaQRzTfWVEbd0Kgin7ViwW11ki46T9QiGeKanah78ZcWn9N1/sj9DHAhy?=
 =?us-ascii?Q?3PHYJdUnuiiYarLyJshGyyWrp1ZoMg5vkNT842wQd1WVg240YTsdUlKNy69y?=
 =?us-ascii?Q?jpVGIWDHRj6KPp+lQybnDOrWR7fcpZqhK9ItXrou1BWjyu5K2JyTYMl2F8kw?=
 =?us-ascii?Q?7feGmmkQk/yfKzzjWVvv/mCUFgKqdNTnr4rJu5xN12fMIBiM1inMyd7/3LJv?=
 =?us-ascii?Q?AVUr9kZaUbX4elMArgtRg5EGGk+34PkpqJWdysgQhupoKIXQh9/OXWesjUpq?=
 =?us-ascii?Q?evHwhn0Ce8UVo6LNha27+CYuhlgs9hKl6Z7uAYpIi6hEQkh8W56OhIoNZ8Ju?=
 =?us-ascii?Q?iuKZOqvkjk9+sx4/owC+L1ksvTPSAuXrMN1wdb0ZYh33pKdg7TJeCGUm4tQh?=
 =?us-ascii?Q?2wexMTcMrq893ObhFeIInTssjCprbxO9cwB8btlUYB+t/xql4ym2k2s4Hx7w?=
 =?us-ascii?Q?WMs+x7FO4DU5t/deHRNjPAxq5T8+f1GsiSq9xbuIg5budEph0UO5Bb2pE81V?=
 =?us-ascii?Q?2SN2V26oP5oSXjshZh0X1iUNIEyKDOt4QLoinbPG3GXvIGaLNDGYpbWVwOKy?=
 =?us-ascii?Q?PzLCZm+Fka4i5t4JKStp+7oWhdPTbfRSl+PbdcAtW4ByWg2InXi4MTIcT2If?=
 =?us-ascii?Q?j2gmA/rNMg0hkyHmNvB8monmnu43j+Tl78IYXYuOg5lqHgYUbRiuzc1esbKQ?=
 =?us-ascii?Q?1ZVMcY51Yh358ncGSjoslkqtNK0//7cMQqp4Uoo+9IS+ZPWv9Fofd7tT3EcD?=
 =?us-ascii?Q?ut/Hd/IIzEHSuu36uhlcDRLhYDCm/4M+HOpGPRq7ShU4ozvN5grcYHmWjXii?=
 =?us-ascii?Q?xed99b6CNmxCQtENnmAyLE5AT9f4rqk1URG43Av4qTlUFTqy/IGt5BEKmBBO?=
 =?us-ascii?Q?iI7cHau1NAs2vMPkpeNOBInFMPMW+zjAWHjCSxrYX+bByzCdMw/B26E1A7oP?=
 =?us-ascii?Q?oJTLU6NECVSgaZ7mb8oh0AwH8ErI15mcyokGd4x9sJv7ZUW0NEFAjPDSulxA?=
 =?us-ascii?Q?TUM5LCNuX0lCHnN4t3/RWIR8YYQdleBxUG8+3t44nMX0fFJlKKbeLu8zHiC5?=
 =?us-ascii?Q?4+JnPQS8bE9sJo2G6k1168bf99j5qZWVgSl/Iorp29NtHv1Mx7ANUH2v5hBO?=
 =?us-ascii?Q?fkdFOl48CiyMecfjb3J7ET6oLHc4RDex3tgmckq5CbhhY41me2Hj4m7A9fk4?=
 =?us-ascii?Q?p3fOnHzGormG8fZuYuvC8NwBSSRE+DFas2/JY7fBrvjExGdjQoWtHA3ZJfC4?=
 =?us-ascii?Q?u7I+dt7PhvthIaPp1SGJ18CA9mJ66DNHOGRJW8t5HNpis+vV/iB5mSajvm8L?=
 =?us-ascii?Q?PaH2dRlqUQUVYFeZMmuHkLzX1T2z/7svYlgEh0IsDVRo6ny+V6Rpg9LNEv9e?=
 =?us-ascii?Q?cwMyFS61bPY4X/r6I8a2WnGnKG1MpLUJDrZRqEGAr9yNFsJlBwatDBE0pTYt?=
 =?us-ascii?Q?DpteHofViL4dOQPp7JiN+oIgajTme6M/5Wpohtnm7xXFn1tuidZgvQPpM5Nm?=
 =?us-ascii?Q?EaYaWpsPimp5WpJ0iQY7wDINGxYlvZfH1II4jv9RkMj2L0HGiGSAdahgfPns?=
 =?us-ascii?Q?QnrVIcfI5WZ0xa120dn+9joXxQH/r3OuUwlTgSUqo+somDHtD3eu+2rta0J9?=
 =?us-ascii?Q?+g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123d8eb5-cc1f-4c14-b220-08dc11fd6295
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 16:58:36.0642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BvbG0tFDh/ZhAJKD7RVfVd2xX/qFUEtanTl6YojY5bbNrw/3Xav4putH1vc0R/5kVtAGcirNLJX6wIj7apkDB2BmH6B1TVzjQ6JYlotjdwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7539

Update broadcast to support the new setup structure.
Change broadcast code from iovec struct to byte array.
Add adapter property for broadcast endpoint.
Make broadcast sink to select broadcast source BISes
based on pac broadcast sink properties.

---
 profiles/audio/bap.c       | 850 ++++++++++++++++++++++++--------
 profiles/audio/transport.c |  25 +-
 src/shared/bap.c           | 958 +++++++++++++++++++++++++++++++++++--
 src/shared/bap.h           |  42 +-
 4 files changed, 1638 insertions(+), 237 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index b88876485..8ee15f448 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -45,6 +45,7 @@
 #include "src/shared/gatt-client.h"
 #include "src/shared/gatt-server.h"
 #include "src/shared/bap.h"
+#include "src/shared/lc3.h"
 
 #include "btio/btio.h"
 #include "src/plugin.h"
@@ -102,6 +103,69 @@ struct bap_data {
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
+struct update_base_data {
+	struct bt_bap_stream *stream;
+	struct iovec *base;
+};
+
 static struct queue *sessions;
 
 static bool bap_data_set_user_data(struct bap_data *data, void *user_data)
@@ -258,10 +322,20 @@ static gboolean get_device(const GDBusPropertyTable *property,
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
 
@@ -370,6 +444,26 @@ static const GDBusPropertyTable ep_properties[] = {
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
@@ -384,101 +478,323 @@ static int parse_array(DBusMessageIter *iter, struct iovec *iov)
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
+static void update_endpoint_base(struct bap_setup *setup,
+		struct iovec *base_iov)
+{
+	if (setup->base)
+		util_iov_free(setup->base, 1);
+
+	setup->base = util_iov_dup(base_iov, 1);
+}
+
+static void search_setup(void *data, void *user_data)
+{
+	struct bap_setup *setup = data;
+	struct update_base_data *update_data = user_data;
+
+	if (setup->stream == update_data->stream)
+		update_endpoint_base(setup, update_data->base);
+}
+
+static void search_stream(void *data, void *user_data)
+{
+	struct bap_ep *ep = data;
+	struct update_base_data *update_data = user_data;
+
+	queue_foreach(ep->setups, search_setup, update_data);
+}
+
+static void update_base(struct bap_setup *setup,
+			struct bap_data *data)
+{
+	struct iovec *base_iov;
+	const struct queue_entry *entry;
+	struct update_base_data update_data;
+
+	base_iov = bt_bap_update_base(setup->stream);
+
+	update_data.base = base_iov;
+
+	/* Update the endpoints BASE iovec */
+	update_endpoint_base(setup, base_iov);
+
+	for (entry = queue_get_entries(
+				bt_bap_stream_get_link_bcast(setup->stream));
+				entry; entry = entry->next) {
+		update_data.stream = entry->data;
+
+		queue_foreach(data->bcast, search_stream, &update_data);
 	}
 
-	if (numBis) {
-		if (!util_iov_pull_u8(&iov, numBis))
-			return false;
-		util_debug(func, NULL, "NumBis %d", *numBis);
+	util_iov_free(base_iov, 1);
+}
+
+static void get_combined_qos(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	struct bt_bap_qos **local_qos = user_data;
+	struct bt_bap_qos *qos = bt_bap_stream_get_qos(stream);
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
 	}
 
-	if (codec) {
-		codec = util_iov_pull_mem(&iov, sizeof(*codec));
-		if (!codec)
-			return false;
-		util_debug(func, NULL, "%s: ID %d CID 0x%2.2x VID 0x%2.2x",
-				"Codec", codec->id, codec->cid, codec->vid);
+	if ((*local_qos)->bcast.io_qos.sdu != qos->bcast.io_qos.sdu)
+		if ((*local_qos)->bcast.io_qos.sdu < qos->bcast.io_qos.sdu)
+			(*local_qos)->bcast.io_qos.sdu = qos->bcast.io_qos.sdu;
+
+	if ((*local_qos)->bcast.delay != qos->bcast.delay)
+		if ((*local_qos)->bcast.delay < qos->bcast.delay)
+			(*local_qos)->bcast.delay = qos->bcast.delay;
+}
+
+static void set_stream_combined_qos(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	struct bt_bap_qos *local_qos = user_data;
+
+	bt_bap_stream_set_combined_qos(stream, local_qos);
+}
+
+static void update_qos(struct bap_setup *setup,
+			struct bap_data *data)
+{
+	struct bt_bap_qos *local_qos = new0(struct bt_bap_qos, 1);
+	struct bt_bap_qos *qos = &setup->qos;
+
+	memcpy(local_qos, qos, sizeof(struct bt_bap_qos));
+
+	queue_foreach(bt_bap_stream_get_link_bcast(setup->stream),
+				get_combined_qos, &local_qos);
+
+	/* Update each endpoint QOS structure to have the
+	 * same values, as obtained in local_qos
+	 */
+	if (local_qos != NULL) {
+		bt_bap_stream_set_combined_qos(setup->stream, local_qos);
+
+		queue_foreach(bt_bap_stream_get_link_bcast(setup->stream),
+				set_stream_combined_qos, local_qos);
 	}
 
-	if (!util_iov_pull_u8(&iov, &capsLen))
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
-	util_debug(func, NULL, "CC Len %d", capsLen);
 
-	if (!capsLen)
+	if (!util_iov_pull_le24(&iov, &base->pres_delay))
 		return false;
-	if (caps) {
-		if (!(*caps))
-			*caps = new0(struct iovec, 1);
-		(*caps)->iov_len = capsLen;
-		(*caps)->iov_base = iov.iov_base;
-	}
+	util_debug(func, NULL, "PresentationDelay %d", base->pres_delay);
 
-	for (int i = 0; capsLen > 1; i++) {
-		struct bt_ltv *ltv = util_iov_pull_mem(&iov, sizeof(*ltv));
-		uint8_t *caps;
+	if (!util_iov_pull_u8(&iov, &base->num_subgroups))
+		return false;
+	util_debug(func, NULL, "NumSubgroups %d", base->num_subgroups);
+	num_subgroups = base->num_subgroups;
 
-		if (!ltv) {
-			util_debug(func, NULL, "Unable to parse %s",
-								"Capabilities");
-			return false;
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
 		}
+		util_debug(func, NULL, "NumBis %d", num_bis);
+		sub_group->num_bises = num_bis;
 
-		util_debug(func, NULL, "%s #%u: len %u type %u",
-					"CC", i, ltv->len, ltv->type);
+		memcpy(&sub_group->codec, util_iov_pull_mem(&iov,
+		sizeof(struct bt_bap_codec)), sizeof(struct bt_bap_codec));
+		util_debug(func, NULL, "%s: ID %d CID 0x%2.2x VID 0x%2.2x",
+			"Codec", sub_group->codec.id, sub_group->codec.cid,
+				sub_group->codec.vid);
+		if (!util_iov_pull_u8(&iov, &caps_len)) {
+			cleanup_subgroup(sub_group);
+			goto fail;
+		}
 
-		caps = util_iov_pull_mem(&iov, ltv->len - 1);
-		if (!caps) {
-			util_debug(func, NULL, "Unable to parse %s",
-								"CC");
-			return false;
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
 		}
-		util_hexdump(' ', caps, ltv->len - 1, func, NULL);
 
-		capsLen -= (ltv->len + 1);
-	}
+		if (!util_iov_pull_u8(&iov, &metaLen)) {
+			cleanup_subgroup(sub_group);
+			goto fail;
+		}
+		util_debug(func, NULL, "Metadata Len %d", metaLen);
 
-	if (!util_iov_pull_u8(&iov, &metaLen))
-		return false;
-	util_debug(func, NULL, "Metadata Len %d", metaLen);
+		sub_group->meta = new0(struct iovec, 1);
+		sub_group->meta->iov_len = metaLen;
+		sub_group->meta->iov_base = iov.iov_base;
 
-	if (!metaLen)
-		return false;
-	if (meta) {
-		if (!(*meta))
-			*meta = new0(struct iovec, 1);
-		(*meta)->iov_len = metaLen;
-		(*meta)->iov_base = iov.iov_base;
-	}
+		hexstream = util_iov_pull_mem(&iov, metaLen);
+		if (!hexstream) {
+			cleanup_subgroup(sub_group);
+			goto fail;
+		}
+		util_hexdump(' ', hexstream, metaLen, func, NULL);
 
-	hexstream = util_iov_pull_mem(&iov, metaLen);
-	if (!hexstream)
-		return false;
-	util_hexdump(' ', hexstream, metaLen, func, NULL);
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
+
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
@@ -561,6 +877,16 @@ static int parse_bcast_qos(const char *key, int var, DBusMessageIter *iter,
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
@@ -596,6 +922,11 @@ static int parse_bcast_qos(const char *key, int var, DBusMessageIter *iter,
 			return -EINVAL;
 
 		dbus_message_iter_get_basic(iter, &qos->bcast.timeout);
+	} else if (!strcasecmp(key, "PresentationDelay")) {
+		if (var != DBUS_TYPE_UINT32)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->bcast.delay);
 	} else if (!strcasecmp(key, "BCode")) {
 		struct iovec iov;
 
@@ -604,8 +935,8 @@ static int parse_bcast_qos(const char *key, int var, DBusMessageIter *iter,
 
 		parse_array(iter, &iov);
 
-		util_iov_free(qos->bcast.bcode, 1);
-		qos->bcast.bcode = util_iov_dup(&iov, 1);
+		memcpy(qos->bcast.bcode, iov.iov_base,
+				sizeof(qos->bcast.bcode));
 	} else {
 		int err;
 
@@ -618,14 +949,15 @@ static int parse_bcast_qos(const char *key, int var, DBusMessageIter *iter,
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
@@ -657,8 +989,9 @@ static int parse_qos(DBusMessageIter *iter, struct bt_bap_qos *qos,
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
@@ -699,24 +1032,13 @@ static int parse_configuration(DBusMessageIter *props, struct iovec **caps,
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
@@ -844,12 +1166,72 @@ static void setup_free(void *data)
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
+			queue_push_tail(
+				bt_bap_stream_get_link_bcast(setup->stream),
+				iter_setup->stream);
+			queue_push_tail(
+				bt_bap_stream_get_link_bcast(
+					iter_setup->stream),
+				setup->stream);
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
@@ -882,13 +1264,46 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
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
 
@@ -900,12 +1315,12 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
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
@@ -914,8 +1329,14 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		/* No message sent over the air for broadcast */
 		if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK)
 			setup->msg = dbus_message_ref(msg);
-		else
+		else {
+			/* Link all setups based on the BIG id */
+			queue_foreach(ep->data->bcast, link_setups, setup);
+
+			update_base(setup, ep->data);
+			update_qos(setup, ep->data);
 			setup->id = 0;
+		}
 
 		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 	}
@@ -944,30 +1365,21 @@ static void update_bcast_qos(struct bt_iso_qos *qos,
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
@@ -976,25 +1388,15 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
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
 
@@ -1006,25 +1408,39 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
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
 
+	base_s.subgroups = queue_new();
+	parse_base(data->bap, base.base, base.base_len, bap_debug, &base_s);
+
+	bt_bap_update_bcast_source(NULL, &base_s);
 }
 
 static bool match_data_bap_data(const void *data, const void *match_data)
@@ -1081,6 +1497,7 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 	int i, err = 0;
 	const char *suffix;
 	struct match_ep match = { lpac, rpac };
+	const GDBusPropertyTable *properties;
 
 	switch (bt_bap_pac_get_type(lpac)) {
 	case BT_BAP_BCAST_SOURCE:
@@ -1109,11 +1526,15 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
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
@@ -1125,7 +1546,7 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 
 	if (g_dbus_register_interface(btd_get_dbus_connection(),
 			ep->path, MEDIA_ENDPOINT_INTERFACE,
-			ep_methods, NULL, ep_properties,
+			ep_methods, NULL, properties,
 			ep, ep_free) == FALSE) {
 		error("Could not register remote ep %s", ep->path);
 		ep_free(ep);
@@ -1646,9 +2067,12 @@ static gboolean setup_io_disconnected(GIOChannel *io, GIOCondition cond,
 
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
@@ -1741,7 +2165,7 @@ static void setup_connect_io(struct bap_data *data, struct bap_setup *setup,
 static void setup_connect_io_broadcast(struct bap_data *data,
 					struct bap_setup *setup,
 					struct bt_bap_stream *stream,
-					struct bt_iso_qos *qos)
+					struct bt_iso_qos *qos, int defer)
 {
 	struct btd_adapter *adapter = data->user_data;
 	GIOChannel *io = NULL;
@@ -1778,7 +2202,7 @@ static void setup_connect_io_broadcast(struct bap_data *data,
 			BT_IO_OPT_MODE, BT_IO_MODE_ISO,
 			BT_IO_OPT_QOS, qos,
 			BT_IO_OPT_BASE, &base,
-			BT_IO_OPT_DEFER_TIMEOUT, false,
+			BT_IO_OPT_DEFER_TIMEOUT, defer,
 			BT_IO_OPT_INVALID);
 
 	if (!io) {
@@ -1832,41 +2256,28 @@ static void setup_listen_io_broadcast(struct bap_data *data,
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
@@ -1902,32 +2313,37 @@ static void setup_create_bcast_io(struct bap_data *data,
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
+		qos = bt_bap_stream_get_combined_qos(setup->stream);
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
@@ -1953,6 +2369,31 @@ static void setup_create_io(struct bap_data *data, struct bap_setup *setup,
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
+	struct bt_bap_stream *linked_stream;
+
+	if (!bt_bap_stream_get_link_bcast(setup->stream))
+		return true;
+
+	for (entry = queue_get_entries(
+				bt_bap_stream_get_link_bcast(setup->stream));
+				entry; entry = entry->next) {
+		linked_stream = entry->data;
+		if (bt_bap_stream_get_state(linked_stream) !=
+							test_state)
+			return false;
+	}
+
+	return true;
+}
 
 static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 				uint8_t new_state, void *user_data)
@@ -1983,17 +2424,29 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
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
@@ -2311,6 +2764,12 @@ static int bap_bcast_probe(struct btd_service *service)
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
 
@@ -2349,7 +2808,24 @@ static int bap_bcast_probe(struct btd_service *service)
 
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
index 078d308dc..85cc3cc69 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -30,6 +30,7 @@
 #include "src/shared/bap.h"
 #include "src/shared/ascs.h"
 #include "src/shared/bap-debug.h"
+#include "src/shared/lc3.h"
 
 /* Maximum number of ASE(s) */
 #define NUM_SINKS 2
@@ -226,6 +227,8 @@ struct bt_bap_stream {
 	struct bt_bap_stream_io *io;
 	bool client;
 	void *user_data;
+	struct queue *link_bcast_streams; /* Link BISes from same BIG */
+	struct bt_bap_qos combined_qos;
 };
 
 /* TODO: Figure out the capabilities types */
@@ -255,11 +258,37 @@ struct bt_pacs_context {
 	uint16_t  src;
 } __packed;
 
+struct base_data {
+	uint32_t pres_delay;
+	struct queue *base_data_subgroup;
+};
+
+struct stream_base_data {
+	struct queue *ltv_caps;
+	struct queue *ltv_meta;
+	struct bt_bap_stream *stream;
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
 /* Contains local bt_bap_db */
 static struct queue *bap_db;
 static struct queue *bap_cbs;
 static struct queue *sessions;
 
+static bool bt_bap_new_bcast_sink(struct bt_bap *bap);
+
 static bool bap_db_match(const void *data, const void *match_data)
 {
 	const struct bt_bap_db *bdb = data;
@@ -331,6 +360,457 @@ bool bt_bap_pac_unregister(struct bt_bap *bap, unsigned int id)
 	return true;
 }
 
+static struct stream_base_data *get_stream_base_info(
+			struct bt_bap_stream *stream);
+static void bap_debug(struct bt_bap *bap, const char *format, ...);
+static void get_stream_base_data(void *data, void *user_data);
+static void set_device_presentation_delay(void *data, void *user_data);
+static void set_base_subgroup(void *data, void *user_data);
+static struct iovec *generate_base(struct base_data *base);
+static void destroy_stream_base_data(void *data);
+static void destroy_base_data_subgroup(void *data);
+
+struct iovec *bt_bap_update_base(struct bt_bap_stream *stream)
+{
+	struct base_data *base;
+	struct iovec *base_iov;
+	struct queue *streams_base_data = queue_new();
+	struct stream_base_data *sbd = get_stream_base_info(stream);
+
+	queue_foreach(stream->link_bcast_streams, get_stream_base_data,
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
+static void destroy_stream_base_data(void *data)
+{
+	struct stream_base_data *sbd = data;
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
+	// util_debug(bap_debug, NULL, "ltv type %d", ltv->type);
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
+static void generate_bis_base(void *data, void *user_data)
+{
+	struct base_data_bis *bis = data;
+	struct iovec *base_iov = user_data;
+	uint8_t cc_length = get_size_from_ltv_queue(bis->ltv_caps);
+
+	if (!util_iov_push_u8(base_iov, bis->bis_index))
+		return;
+
+	if (!util_iov_push_u8(base_iov, cc_length))
+		return;
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
+	queue_foreach(bds->ltv_caps, generate_ltv_base, base_iov);
+
+	if (!util_iov_push_u8(base_iov, metadata_length))
+		return;
+
+	queue_foreach(bds->ltv_meta, generate_ltv_base, base_iov);
+
+	queue_foreach(bds->bises, generate_bis_base, base_iov);
+}
+
+static struct iovec *generate_base(struct base_data *base)
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
+	struct base_data_bis *bdb = data;
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
+		struct bt_bap_pac *lpac = base_data->stream->lpac;
+		struct base_data_subgroup *bds = new0(
+					struct base_data_subgroup, 1);
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
+		}
+
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
+	struct stream_base_data *sbd = data;
+	struct base_data *base = user_data;
+	struct bt_bap_qos *qos = &sbd->stream->qos;
+
+	if (base->pres_delay < qos->bcast.delay)
+		base->pres_delay = qos->bcast.delay;
+}
+
+static void get_stream_base_data(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	struct queue *streams_base_data = user_data;
+	struct stream_base_data *sbd = get_stream_base_info(stream);
+
+	if (sbd)
+		queue_push_tail(streams_base_data, sbd);
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
+			struct bt_bap_stream *stream)
+{
+	struct stream_base_data *sbd = new0(struct stream_base_data, 1);
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
 static void pac_foreach(void *data, void *user_data)
 {
 	struct bt_bap_pac *pac = data;
@@ -826,6 +1306,7 @@ static struct bt_bap_stream *bap_stream_new(struct bt_bap *bap,
 	stream->rpac = rpac;
 	stream->cc = util_iov_dup(data, 1);
 	stream->client = client;
+	stream->link_bcast_streams = queue_new();
 
 	queue_push_tail(bap->streams, stream);
 
@@ -1010,6 +1491,14 @@ static void stream_io_unref(struct bt_bap_stream_io *io)
 	stream_io_free(io);
 }
 
+static void bap_stream_unlink(void *data, void *user_data)
+{
+	struct bt_bap_stream *link = data;
+	struct bt_bap_stream *stream = user_data;
+
+	queue_remove(link->link_bcast_streams, stream);
+}
+
 static void bap_stream_free(void *data)
 {
 	struct bt_bap_stream *stream = data;
@@ -1020,6 +1509,9 @@ static void bap_stream_free(void *data)
 	if (stream->link)
 		stream->link->link = NULL;
 
+	queue_foreach(stream->link_bcast_streams, bap_stream_unlink, stream);
+	queue_destroy(stream->link_bcast_streams, NULL);
+
 	stream_io_unref(stream->io);
 	util_iov_free(stream->cc, 1);
 	util_iov_free(stream->meta, 1);
@@ -1343,6 +1835,12 @@ static void stream_set_state_broadcast(struct bt_bap_stream *stream,
 
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
@@ -2377,21 +2875,6 @@ static struct bt_bap_pac *bap_pac_find(struct bt_bap_db *bdb, uint8_t type,
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
@@ -2427,7 +2910,7 @@ static void bap_pac_merge(struct bt_bap_pac *pac, struct iovec *data,
 {
 	/* Merge data into existing record */
 	if (pac->data)
-		ltv_merge(pac->data, data);
+		bt_bap_ltv_merge(pac->data, data, true);
 	else
 		pac->data = util_iov_dup(data, 1);
 
@@ -2436,7 +2919,7 @@ static void bap_pac_merge(struct bt_bap_pac *pac, struct iovec *data,
 
 	/* Merge metadata into existing record */
 	if (pac->metadata)
-		ltv_merge(pac->metadata, metadata);
+		bt_bap_ltv_merge(pac->metadata, metadata, true);
 	else
 		pac->metadata = util_iov_dup(metadata, 1);
 }
@@ -2650,6 +3133,8 @@ static void bap_add_broadcast_source(struct bt_bap_pac *pac)
 static void bap_add_broadcast_sink(struct bt_bap_pac *pac)
 {
 	queue_push_tail(pac->bdb->broadcast_sinks, pac);
+
+	pacs_add_sink_location(pac->bdb->pacs, pac->qos.location);
 }
 
 static void notify_pac_added(void *data, void *user_data)
@@ -2668,6 +3153,20 @@ static void notify_session_pac_added(void *data, void *user_data)
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
@@ -2725,7 +3224,7 @@ struct bt_bap_pac *bt_bap_add_pac(struct gatt_db *db, const char *name,
 					struct iovec *metadata)
 {
 	return bt_bap_add_vendor_pac(db, name, type, id, 0x0000, 0x0000, qos,
-							data, metadata);
+						    data, metadata);
 }
 
 uint8_t bt_bap_pac_get_type(struct bt_bap_pac *pac)
@@ -2748,13 +3247,24 @@ uint32_t bt_bap_pac_get_locations(struct bt_bap_pac *pac)
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
@@ -2837,12 +3347,26 @@ static void notify_session_pac_removed(void *data, void *user_data)
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
 
@@ -4489,6 +5013,11 @@ bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct bt_bap_pac *pac)
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
@@ -4618,7 +5147,6 @@ unsigned int bt_bap_stream_config(struct bt_bap_stream *stream,
 		if (stream->lpac->type == BT_BAP_BCAST_SINK) {
 			if (data)
 				stream_config(stream, data, NULL);
-			stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
 		}
 		return 1;
 	}
@@ -4763,7 +5291,7 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 			return NULL;
 
 		bt_bap_foreach_pac(bap, type, match_pac, &match);
-		if (!match.lpac)
+		if ((!match.lpac) || (!lpac))
 			return NULL;
 		if (!match.rpac && (lpac->type != BT_BAP_BCAST_SOURCE))
 			return NULL;
@@ -4780,7 +5308,15 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
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
@@ -4943,11 +5479,10 @@ unsigned int bt_bap_stream_enable(struct bt_bap_stream *stream,
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
 
@@ -5094,13 +5629,21 @@ unsigned int bt_bap_stream_metadata(struct bt_bap_stream *stream,
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
@@ -5191,6 +5734,26 @@ struct iovec *bt_bap_stream_get_config(struct bt_bap_stream *stream)
 	return stream->cc;
 }
 
+bool bt_bap_stream_set_combined_qos(struct bt_bap_stream *stream,
+		struct bt_bap_qos *qos)
+{
+	if (!stream)
+		return false;
+
+	memcpy(&stream->combined_qos, qos,
+				sizeof(struct bt_bap_qos));
+
+	return true;
+}
+
+struct bt_bap_qos *bt_bap_stream_get_combined_qos(struct bt_bap_stream *stream)
+{
+	if (!stream)
+		return NULL;
+
+	return &stream->combined_qos;
+}
+
 struct bt_bap_qos *bt_bap_stream_get_qos(struct bt_bap_stream *stream)
 {
 	if (!stream)
@@ -5207,6 +5770,14 @@ struct iovec *bt_bap_stream_get_metadata(struct bt_bap_stream *stream)
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
@@ -5265,6 +5836,23 @@ static bool match_name(const void *data, const void *match_data)
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
@@ -5301,9 +5889,9 @@ int bt_bap_stream_io_link(struct bt_bap_stream *stream,
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
@@ -5328,6 +5916,14 @@ struct bt_bap_stream *bt_bap_stream_io_get_link(struct bt_bap_stream *stream)
 	return stream->link;
 }
 
+struct queue *bt_bap_stream_get_link_bcast(struct bt_bap_stream *stream)
+{
+	if (!stream)
+		return NULL;
+
+	return stream->link_bcast_streams;
+}
+
 static void bap_stream_get_in_qos(void *data, void *user_data)
 {
 	struct bt_bap_stream *stream = data;
@@ -5484,11 +6080,301 @@ bool bt_bap_new_bcast_source(struct bt_bap *bap, const char *name)
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
index 51edc08ab..1d65613f1 100644
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
@@ -292,8 +319,13 @@ unsigned int bt_bap_stream_release(struct bt_bap_stream *stream,
 uint8_t bt_bap_stream_get_dir(struct bt_bap_stream *stream);
 uint32_t bt_bap_stream_get_location(struct bt_bap_stream *stream);
 struct iovec *bt_bap_stream_get_config(struct bt_bap_stream *stream);
+struct bt_bap_qos *bt_bap_stream_get_combined_qos(struct bt_bap_stream *stream);
+bool bt_bap_stream_set_combined_qos(struct bt_bap_stream *stream,
+					struct bt_bap_qos *qos);
 struct bt_bap_qos *bt_bap_stream_get_qos(struct bt_bap_stream *stream);
 struct iovec *bt_bap_stream_get_metadata(struct bt_bap_stream *stream);
+struct bt_bap_pac *bt_bap_stream_get_local_pac(struct bt_bap_stream *stream);
+struct queue *bt_bap_stream_get_link_bcast(struct bt_bap_stream *stream);
 
 struct io *bt_bap_stream_get_io(struct bt_bap_stream *stream);
 bool bt_bap_match_bcast_sink_stream(const void *data, const void *user_data);
@@ -315,9 +347,9 @@ bool bt_bap_stream_io_is_connecting(struct bt_bap_stream *stream, int *fd);
 
 bool bt_bap_new_bcast_source(struct bt_bap *bap, const char *name);
 void bt_bap_update_bcast_source(struct bt_bap_pac *pac,
-					struct bt_bap_codec *codec,
-					struct iovec *data,
-					struct iovec *metadata);
+				struct bt_bap_base *base);
+void *bt_bap_ltv_merge(struct iovec *data, struct iovec *cont,
+						bool add_delimiter);
 
 bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct bt_bap_pac *pac);
-
+struct iovec *bt_bap_update_base(struct bt_bap_stream *stream);
-- 
2.39.2

