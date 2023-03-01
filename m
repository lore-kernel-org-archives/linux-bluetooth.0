Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72464C64ED6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Mar 2023 13:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjCANnZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Mar 2023 08:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCANnX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Mar 2023 08:43:23 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628121707
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Mar 2023 05:43:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y75fCVRuos94xV0dbOuTWNKGWly0ddrNaSDJF/Ovpz+p/j5ToFRoD0AJlERhPKtMEa2U9jCFRbco7U8PHc/ptFhRczGjLdFEmBZkrxr0wFlAW+rfRRd0IsgHO4syWfySKZiqkHx9SRa+sf0FY8fwg7jjaowcXjCsvItQIs+ih8tTw50307y1qWyucjvF2ArPnIDWbf+lRWNXOoyMjRtCmTcIIBGmcYgFe9RpE0LqzlnQVPJUW/Nbw7sY09+RYujrQ1Qoawm9j5J0c8anxf+9fr4LMU+ddOrApFv3qxYknYAloYIi6/8BjLgcWliZcB2hQ24IVTpk+HxqdYbwx/Nyyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTS5WsXHhX6hbq0JiOuFGlPh9XNIWNtBygsEEf4eT+Q=;
 b=RNIvBWr6pi8Gc7IPPYxsl3ZVlkxjtP9hMUQNHzMftz8zMc8u1q5fvsq2kl2BViVw8ePPn197bVNt8kl0TAf7k2t2aBeoEsie2cRuyyyYXZAEADB+ar4FvUIFpMOS0EHMJ26bI9ZyEg/d9U6keidyNS2ZnxXs4VALDfJYrJkx6Q888mOtv+CMZetVYS7p+WEsBiMt3fIU66VFB6BT5b03Rw8T5Kl48cV3bOyVcrMovvNc1uI/gbmA7uIqXE8r9X1+YFxPk8e0Gv/YZ/D19QuabFKUTtKTZpA9N0L+PKxlAs8mW3x/QwZCVUx91rrab+2fgVGibYaPyLfrpsXzKJPh5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTS5WsXHhX6hbq0JiOuFGlPh9XNIWNtBygsEEf4eT+Q=;
 b=JFTN/W3HpgQnC/1rHXdHSjqcLg4o746gw//7ogpj7Bi92Ff6MZu7b3g8nSpHzpYH31gZR9TDDBUkDHEJ64HwqROFhaOEYmMSm4KlMpIqFvl9yVAk0umeXmL+MVGvjZiRfElPhDi9ubKbU9bAn3fZExP3EDJ7nunp02is9HfyVQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAXPR04MB8702.eurprd04.prod.outlook.com (2603:10a6:102:21d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 13:43:17 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98%9]) with mapi id 15.20.6156.017; Wed, 1 Mar 2023
 13:43:17 +0000
From:   iulia-tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia-tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/2] shared: Add initial BASS code
Date:   Wed,  1 Mar 2023 15:42:07 +0200
Message-Id: <20230301134207.10924-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230301134207.10924-1-iulia.tanasescu@nxp.com>
References: <20230301134207.10924-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::27) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAXPR04MB8702:EE_
X-MS-Office365-Filtering-Correlation-Id: 610a6796-43d3-4de6-f3c3-08db1a5ae9a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YAKyPXUff7yzy4FVY4Ad8oQAbBZQ1lLtt9/mSKGwiCeqMKyhg2QhtpvxNETgmL4NT61UamuUg9rsObewzvajsc5fU1BMPcBsyAIyYMXqfbuuMC4v3JjRxTb5aOD1boFiw0QT6IFj/G2DNnvMTysAQaQjzrD3eQ4mXfPQn0hCiij0w7v4ZfLqWs/Wjru07hZ49RuY94VJHQJ/LsW9fZGJhRZEPlRzqXpFI+/+DE/CspeA2AYbSSf9axsQpw7idhP65HPiThwKyGigMXU274A3+KUu0TtgeOrv9Vu8LVbgd4lCaoyhzBwi6ypEKpDc+kOCUqbGPp5jF1zXNlhjAZQvlaLZ5++wewmGmGEg0EynyCy4rORIkBA8ril0zb1LxAZWXMVzIRRLb3CKVtuAwW0dz9jrOjw39ywYSVqNed2az4I+WVZRX2ur3SXvMt3/9LHJTYZt8Q4QZIMx7qukrld7fqtSkuKDv2dYfASxoCLqTqsHH5EF8Pr6bT8OH4vt+91gd+tdpb/GAielPgWgNyeRK5zZ7y0T/v93gdCqIwKAQzro5i8iKZgS5DWFE7IyJTle1xD9TuSM5pYN1Gscbk9B14GRfDnfcuPQIuHUaSwVGC/RzTw2jRZpAqMxxieYuB1ZM8zW4atG9hOBdKYN9Icu9O90dBjkKJV6U9SlCxCiF41vhxxMtG7ekkZyoShaer3g2aOaHMKBY4nyEm2H1d4FpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199018)(86362001)(36756003)(66476007)(66946007)(8676002)(66556008)(41300700001)(5660300002)(8936002)(2906002)(30864003)(38350700002)(6916009)(38100700002)(4326008)(52116002)(6486002)(478600001)(316002)(6666004)(83380400001)(2616005)(26005)(186003)(6506007)(55236004)(1076003)(6512007)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LFZF/WdSwljg4l7ePpdJN3r9UrOdMwr4BjSGgWn4b3+gBtUEag9vzWOgjLva?=
 =?us-ascii?Q?DJvfGt8L1x5/wMwZfhJgcmLE1peotHAti6SP0xVwXKGa6GpwTXz9uZEwRPKl?=
 =?us-ascii?Q?wlGEQUA4rCFEF/raXc0JcOM671+A2itnfihkkuY7QxbacX+Ff6Li8UDd57YR?=
 =?us-ascii?Q?+Nrzmi6H06VHH7BWTqJ2dSYWDK6XbzC9ABqHvgllcA9dwAHDMVH+CC7GiUYb?=
 =?us-ascii?Q?14h+TOeZsCbrSfaznYLspKPdA9G89j20HxkG0UINJW/MwYNvFvfg3WX3FUQu?=
 =?us-ascii?Q?wStLmvanYsx8GIKmKSp3TZ5C8BMLKzKCYxSv4r8mR3VHh6A0r3adNU+/e8yL?=
 =?us-ascii?Q?ZWfo2bcj2a59ykQZNHsAn3o2+96aWYOqRI5R0zd1Srwim2tiwYs649oT6GnH?=
 =?us-ascii?Q?i646BIIncLp3d25e1PE3b67iw+2zv+CFXmHtbwVH4PJBkRiZjQEa4bMc5K/S?=
 =?us-ascii?Q?3AVkm9SEEJml5riOhbsdXlzoDmxCbeRqrqPZ/rEIVJVyCkZ9UpSvm+qvLjDr?=
 =?us-ascii?Q?aZucCB21m6MOlK3WwMObkQWxrc43lx+xvBsrjUNoONr18uFDCe3mxF/L3XWr?=
 =?us-ascii?Q?On3GDDqgV9NWzZJ37fJGINR/Qq2rn4MwkCAn9bI2Hx/WfMKz4W0X6pvICOGd?=
 =?us-ascii?Q?DIq/ep1XO3U/LyWvbMaK7p8yaRn872WoHIdkYwxj5ZMmXUEF0aBeiFcX6IMb?=
 =?us-ascii?Q?q4us+zQhkpdMlLUWV2QfkhNQeFMa4SeMkL4U4W1uacsNHQ4p2EXnWjYj64rA?=
 =?us-ascii?Q?G6+lyl8JE5jvAwMmyG6ZzN/EkKRGWr4La9q3wdqoMH9zC29j6th4djUfSldC?=
 =?us-ascii?Q?PhRAZcge6EhNIxCzWMc5ug3BS8qp0QHQ4GXzAMI68gQM0SPxjPz6Le2pGXwW?=
 =?us-ascii?Q?/b3GntcYBriOSkf00Xoparkc8MizpRJ5EVZtRTk8I53Sc/DuiYDKxIqq8Mwv?=
 =?us-ascii?Q?iMqvAz18DvGMMB7CVjTJFTRKjofZ3dmA+7LLuuEGYIx/uLCN5jjwNfHfIb1J?=
 =?us-ascii?Q?Gy8SDrunVi/oTJP8OHS4VaYe/viSMkYCl/qF3j3G4g8TKyQoCqkewpB47qck?=
 =?us-ascii?Q?tllQSEOWGh89NDycXwzG1ZYYWbr6pjxJvwWp+fqNz5gA9bTbijo49j1sKUnC?=
 =?us-ascii?Q?gH0PZHKG5oj+pag2o2ofzxZE8dGqnn1Mx+d13wc5ZZ8sijyyqEVeDBNkoZkV?=
 =?us-ascii?Q?O5az2SHdS65aCkuwfa3X1ddBHvQaRTliDkTtFqgYYECxkCY9rQOQugdGZU3U?=
 =?us-ascii?Q?h+IJqjMWf1RfpLfLO+tAh+ahQhW3QGrY2uLlplNplPCtn+1BcfNNBSIO113S?=
 =?us-ascii?Q?0POd9M28hqW2/1/sZmn+4C2WAdZx/F1Z5qLsawWQ12QlCWIs0eAq4Wvuo2H3?=
 =?us-ascii?Q?oVdfh7+ngoc9D87kJS44ufiejQOVMm/rgNgXQ+hQ4HbCMqK5mRUKkKwUzt3V?=
 =?us-ascii?Q?Qfua1PlUcTP4aZrh1ChGg6I8E3rFbT5iip6l3HH/Q6K77cjDALELHffeLwJV?=
 =?us-ascii?Q?nCvN3IH9ROIDiolRKMZJJ4fG6mPcJoToMmOrs6PjoKbHyUR3Vg4nwncsR3dK?=
 =?us-ascii?Q?5gjHDUxtu5Qh0hRJgns2mss6TeukxDQ6zqsoF4wUUwnBXlNo5MnjDgj5+93l?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 610a6796-43d3-4de6-f3c3-08db1a5ae9a3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 13:43:17.4302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqf5Klc78YOzg5MD1+m0nnTLAKHjEKE4S0cDAc4brN0ex9khacwfRLW0t/WR06eWTRDjSy0qPb0xwzIAzrA35Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8702
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Added initial BASS code - added support for the Broadcast
Receive State characteristic and for the Set Broadcast_Code
operation from the Broadcast Audio Scan Control Point
characteristic.
The BASS implementation exposes HCI event callbacks that
enable the BASS server to autonomously synchronize
to BIGs.

---
 src/shared/att-types.h |    1 +
 src/shared/bap.c       | 1064 ++++++++++++++++++++++++++++++++++++++++
 src/shared/bap.h       |   25 +
 src/shared/bass.h      |   42 ++
 4 files changed, 1132 insertions(+)
 create mode 100644 src/shared/bass.h

diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index a08b24155..35bf41118 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -104,6 +104,7 @@ struct bt_att_pdu_error_rsp {
  * 0xE0-0xFC are reserved for future use. The remaining 3 are defined as the
  * following:
  */
+#define BT_ERROR_WRITE_REQUEST_REJECTED         0xfc
 #define BT_ERROR_CCC_IMPROPERLY_CONFIGURED      0xfd
 #define BT_ERROR_ALREADY_IN_PROGRESS            0xfe
 #define BT_ERROR_OUT_OF_RANGE                   0xff
diff --git a/src/shared/bap.c b/src/shared/bap.c
index db7def799..9a378b8b5 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -17,6 +17,8 @@
 
 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
+#include "lib/hci.h"
+#include "lib/hci_lib.h"
 
 #include "src/shared/io.h"
 #include "src/shared/queue.h"
@@ -28,6 +30,8 @@
 #include "src/shared/gatt-client.h"
 #include "src/shared/bap.h"
 #include "src/shared/ascs.h"
+#include "src/shared/bass.h"
+#include "src/shared/ad.h"
 
 /* Maximum number of ASE(s) */
 #define NUM_SINKS 2
@@ -108,13 +112,54 @@ struct bt_ascs {
 	struct gatt_db_attribute *ase_cp_ccc;
 };
 
+/* BASS subgroup field of the Broadcast
+ * Receive State characteristic
+ */
+struct bt_bass_subgroup_data {
+	uint32_t bis_sync;
+	uint8_t meta_len;
+	uint8_t *meta;
+} __packed;
+
+/* BASS Broadcast Source structure */
+struct bt_bcst_source {
+	struct gatt_db_attribute *attr;
+	uint8_t id;
+	uint8_t addr_type;
+	uint8_t addr[6];
+	uint8_t sid;
+	uint8_t bid[BT_BAP_BROADCAST_ID_SIZE];
+	uint8_t sync_state;
+	uint8_t encryption;
+	uint8_t bad_code[BT_BAP_BROADCAST_CODE_SIZE];
+	uint8_t num_subgroups;
+	struct bt_bass_subgroup_data *subgroup_data;
+} __packed;
+
+/* Broadcast Receive State characteristic structure */
+struct bt_bcst_recv_state {
+	struct bt_bass *bass;
+	struct gatt_db_attribute *attr;
+	struct gatt_db_attribute *ccc;
+};
+
+/* BASS instance structure */
+struct bt_bass {
+	struct bt_bap_db *bdb;
+	struct gatt_db_attribute *service;
+	struct gatt_db_attribute *broadcast_audio_scan_cp;
+	struct bt_bcst_recv_state *bcst_recv_states[NUM_BCST_RECV_STATES];
+};
+
 struct bt_bap_db {
 	struct gatt_db *db;
 	struct bt_pacs *pacs;
 	struct bt_ascs *ascs;
+	struct bt_bass *bass;
 	struct queue *sinks;
 	struct queue *sources;
 	struct queue *endpoints;
+	struct queue *bass_bcst_sources;
 };
 
 struct bt_bap_req {
@@ -255,6 +300,15 @@ static struct queue *bap_db;
 static struct queue *bap_cbs;
 static struct queue *sessions;
 
+static int hci_fd = -1;
+
+static struct bt_hci_cmd_le_big_create_sync *big_sync_cmd;
+static int big_sync_cmd_len;
+
+static struct bt_hci_le_pa_report *pa_report;
+
+static uint8_t next_available_source_id;
+
 static bool bap_db_match(const void *data, const void *match_data)
 {
 	const struct bt_bap_db *bdb = data;
@@ -2170,6 +2224,643 @@ static struct bt_ascs *ascs_new(struct gatt_db *db)
 	return ascs;
 }
 
+static int bass_build_bcst_source_from_notif(struct bt_bcst_source *bcst_source,
+							const uint8_t *value)
+{
+	struct bt_bass_subgroup_data *subgroup_data;
+
+	if (!bcst_source || !value)
+		return -1;
+
+	bcst_source->id = *value;
+	value++;
+
+	bcst_source->addr_type = *value;
+	value++;
+
+	memcpy(bcst_source->addr, value, 6);
+	value += 6;
+
+	bcst_source->sid = *value;
+	value++;
+
+	memcpy(bcst_source->bid, value, BT_BAP_BROADCAST_ID_SIZE);
+	value += BT_BAP_BROADCAST_ID_SIZE;
+
+	bcst_source->sync_state = *value;
+	value++;
+
+	bcst_source->encryption = *value;
+	value++;
+
+	if (bcst_source->encryption == BT_BASS_BIG_ENC_STATE_BAD_CODE) {
+		memcpy(bcst_source->bad_code, value, BT_BAP_BROADCAST_CODE_SIZE);
+		value += BT_BAP_BROADCAST_CODE_SIZE;
+	} else {
+		memset(bcst_source->bad_code, 0, BT_BAP_BROADCAST_CODE_SIZE);
+	}
+
+	bcst_source->num_subgroups = *value;
+	value++;
+
+	free(bcst_source->subgroup_data);
+	bcst_source->subgroup_data = malloc(bcst_source->num_subgroups *
+					sizeof(struct bt_bass_subgroup_data));
+
+	if (!bcst_source->subgroup_data)
+		return -1;
+
+	for (int i = 0; i < bcst_source->num_subgroups; i++) {
+		subgroup_data = &bcst_source->subgroup_data[i];
+
+		memcpy(&subgroup_data->bis_sync, value, sizeof(uint32_t));
+		value += sizeof(uint32_t);
+
+		subgroup_data->meta_len = *value;
+		value++;
+
+		free(subgroup_data->meta);
+		subgroup_data->meta = malloc(subgroup_data->meta_len);
+		if (!subgroup_data->meta) {
+			for (int j = 0; j < i; j++)
+				free(bcst_source->subgroup_data[j].meta);
+
+			free(bcst_source->subgroup_data);
+			return -1;
+		}
+
+		memcpy(subgroup_data->meta, value, subgroup_data->meta_len);
+		value += subgroup_data->meta_len;
+	}
+
+	return 0;
+}
+
+static int bass_build_bcst_source_from_read_rsp(
+					struct bt_bcst_source *bcst_source,
+					const uint8_t *value)
+{
+	return bass_build_bcst_source_from_notif(bcst_source, value);
+}
+
+static uint8_t *bass_build_notif_from_bcst_source(struct bt_bcst_source *source,
+							size_t *notif_len)
+{
+	size_t len = 0;
+	uint8_t *notif = NULL;
+	uint8_t *ptr;
+
+	*notif_len = 0;
+
+	if (!source)
+		return NULL;
+
+	len = 15 + source->num_subgroups * 5;
+
+	if (source->encryption == BT_BASS_BIG_ENC_STATE_BAD_CODE)
+		len += BT_BAP_BROADCAST_CODE_SIZE;
+
+	for (size_t i = 0; i < source->num_subgroups; i++) {
+		/* add length for subgroup metadata */
+		len += source->subgroup_data[i].meta_len;
+	}
+
+	notif = malloc(len);
+	if (!notif)
+		return NULL;
+
+	memset(notif, 0, len);
+	ptr = notif;
+
+	/* add source_id field */
+	*ptr = source->id;
+	ptr++;
+
+	/* add addr_type field */
+	*ptr = source->addr_type;
+	ptr++;
+
+	/* add addr field */
+	memcpy(ptr, source->addr, 6);
+	ptr += 6;
+
+	/* add sid field */
+	*ptr = source->sid;
+	ptr++;
+
+	/* add bid field */
+	memcpy(ptr, source->bid, BT_BAP_BROADCAST_ID_SIZE);
+	ptr += 3;
+
+	/* add sync_state field */
+	*ptr = source->sync_state;
+	ptr++;
+
+	/* add encryption field */
+	*ptr = source->encryption;
+	ptr++;
+
+	if (source->encryption == BT_BASS_BIG_ENC_STATE_BAD_CODE) {
+		memcpy(ptr, source->bad_code, BT_BAP_BROADCAST_CODE_SIZE);
+		ptr += BT_BAP_BROADCAST_CODE_SIZE;
+	}
+
+	/* add num_subgroups field */
+	*ptr = source->num_subgroups;
+	ptr++;
+
+	for (size_t i = 0; i < source->num_subgroups; i++) {
+		/* add subgroup bis_sync */
+		memcpy(ptr, &source->subgroup_data[i].bis_sync,
+						sizeof(uint32_t));
+		ptr += sizeof(uint32_t);
+
+		/* add subgroup meta_len */
+		*ptr = source->subgroup_data[i].meta_len;
+		ptr++;
+
+		/* add subgroup metadata */
+		if (source->subgroup_data[i].meta_len > 0) {
+			memcpy(ptr, source->subgroup_data[i].meta,
+					source->subgroup_data[i].meta_len);
+			ptr += source->subgroup_data[i].meta_len;
+		}
+	}
+
+	*notif_len = len;
+	return notif;
+}
+
+static uint8_t *bass_build_read_rsp_from_bcst_source(struct bt_bcst_source *source,
+								size_t *rsp_len)
+{
+	return bass_build_notif_from_bcst_source(source, rsp_len);
+}
+
+static bool bass_src_id_match(const void *data, const void *match_data)
+{
+	const struct bt_bcst_source *src = data;
+	const uint8_t *id = match_data;
+
+	return (src->id == *id);
+}
+
+static void bass_fill_create_big_sync_cmd_from_pa_report(
+				struct bt_hci_cmd_le_big_create_sync *cmd)
+{
+	struct iovec iov;
+	struct bt_ad_structure *ad_structure;
+	uint16_t uuid;
+	struct bt_hci_le_pa_base_data *base_data;
+	uint8_t *bis_index = (uint8_t *)cmd->bis;
+
+	if (!pa_report)
+		return;
+
+	iov.iov_base = pa_report->data;
+	iov.iov_len = pa_report->data_len;
+
+	ad_structure = util_iov_pull_mem(&iov, sizeof(*ad_structure));
+	if (ad_structure->ad_type != BT_AD_SERVICE_DATA16)
+		return;
+
+	uuid = bt_get_le16(util_iov_pull_mem(&iov, sizeof(uint16_t)));
+	if (uuid != BASIC_AUDIO_ANNOUNCEMENT_SERVICE_UUID)
+		return;
+
+	base_data = util_iov_pull_mem(&iov, sizeof(*base_data));
+
+	for (int i = 0; i < base_data->num_subgroups; i++) {
+		struct bt_hci_le_pa_base_subgroup *subgroup;
+		struct bt_hci_lv_data *codec_cfg;
+		struct bt_hci_lv_data *metadata;
+
+		subgroup = util_iov_pull_mem(&iov, sizeof(*subgroup));
+
+		codec_cfg = util_iov_pull_mem(&iov, sizeof(*codec_cfg));
+		util_iov_pull_mem(&iov, codec_cfg->len);
+
+		metadata = util_iov_pull_mem(&iov, sizeof(*metadata));
+		util_iov_pull_mem(&iov, metadata->len);
+
+		for (int j = 0; j < subgroup->num_bis; j++) {
+			struct bt_hci_le_pa_base_bis *bis;
+			struct bt_hci_lv_data *codec_cfg;
+
+			bis = util_iov_pull_mem(&iov, sizeof(*bis));
+			*bis_index = bis->index;
+			bis_index++;
+
+			codec_cfg = util_iov_pull_mem(&iov,
+						sizeof(*codec_cfg));
+			util_iov_pull_mem(&iov, codec_cfg->len);
+		}
+	}
+}
+
+static void bass_fill_bcst_source_from_pa_report(
+				struct bt_bcst_source *bcst_source)
+{
+	struct iovec iov;
+	struct bt_ad_structure *ad_structure;
+	uint16_t uuid;
+	struct bt_hci_le_pa_base_data *base_data;
+
+	if (!pa_report)
+		return;
+
+	iov.iov_base = pa_report->data;
+	iov.iov_len = pa_report->data_len;
+
+	ad_structure = util_iov_pull_mem(&iov, sizeof(*ad_structure));
+	if (ad_structure->ad_type != BT_AD_SERVICE_DATA16)
+		return;
+
+	uuid = bt_get_le16(util_iov_pull_mem(&iov, sizeof(uint16_t)));
+	if (uuid != BASIC_AUDIO_ANNOUNCEMENT_SERVICE_UUID)
+		return;
+
+	base_data = util_iov_pull_mem(&iov, sizeof(*base_data));
+
+	if (bcst_source->sync_state == BT_BASS_NOT_SYNCHRONIZED_TO_PA) {
+		bcst_source->sync_state = BT_BASS_SYNCHRONIZED_TO_PA;
+		bcst_source->num_subgroups = base_data->num_subgroups;
+
+		bcst_source->subgroup_data = malloc(base_data->num_subgroups *
+						sizeof(struct bt_bcst_source));
+		if (!bcst_source->subgroup_data)
+			return;
+
+		memset(bcst_source->subgroup_data, 0, base_data->num_subgroups *
+						sizeof(struct bt_bcst_source));
+	}
+
+	if (bcst_source->num_subgroups != base_data->num_subgroups)
+		return;
+
+	for (int i = 0; i < base_data->num_subgroups; i++) {
+		struct bt_hci_le_pa_base_subgroup *subgroup;
+		struct bt_hci_lv_data *codec_cfg;
+		struct bt_hci_lv_data *metadata;
+
+		subgroup = util_iov_pull_mem(&iov, sizeof(*subgroup));
+		codec_cfg = util_iov_pull_mem(&iov, sizeof(*codec_cfg));
+		util_iov_pull_mem(&iov, codec_cfg->len);
+
+		metadata = util_iov_pull_mem(&iov, sizeof(*metadata));
+		util_iov_pull_mem(&iov, metadata->len);
+
+		bcst_source->subgroup_data[i].meta_len = metadata->len;
+		free(bcst_source->subgroup_data[i].meta);
+
+		bcst_source->subgroup_data[i].meta = malloc(metadata->len);
+		if (!bcst_source->subgroup_data[i].meta)
+			return;
+
+		memcpy(bcst_source->subgroup_data[i].meta,
+					metadata->data, metadata->len);
+
+		for (int j = 0; j < subgroup->num_bis; j++) {
+			struct bt_hci_le_pa_base_bis *bis;
+			struct bt_hci_lv_data *codec_cfg;
+
+			bis = util_iov_pull_mem(&iov, sizeof(*bis));
+			codec_cfg = util_iov_pull_mem(&iov, sizeof(*codec_cfg));
+			util_iov_pull_mem(&iov, codec_cfg->len);
+		}
+	}
+}
+
+static void bass_fill_bcst_source_bis_sync_bitmask(
+					struct bt_bcst_source *bcst_source)
+{
+	struct iovec iov;
+	struct bt_ad_structure *ad_structure;
+	uint16_t uuid;
+	struct bt_hci_le_pa_base_data *base_data;
+
+	if (!pa_report)
+		return;
+
+	iov.iov_base = pa_report->data;
+	iov.iov_len = pa_report->data_len;
+
+	ad_structure = util_iov_pull_mem(&iov, sizeof(*ad_structure));
+	if (ad_structure->ad_type != BT_AD_SERVICE_DATA16)
+		return;
+
+	uuid = bt_get_le16(util_iov_pull_mem(&iov, sizeof(uint16_t)));
+	if (uuid != BASIC_AUDIO_ANNOUNCEMENT_SERVICE_UUID)
+		return;
+
+	base_data = util_iov_pull_mem(&iov, sizeof(*base_data));
+
+	for (int i = 0; i < base_data->num_subgroups; i++) {
+		struct bt_hci_le_pa_base_subgroup *subgroup;
+		struct bt_hci_lv_data *codec_cfg;
+		struct bt_hci_lv_data *metadata;
+
+		subgroup = util_iov_pull_mem(&iov, sizeof(*subgroup));
+
+		codec_cfg = util_iov_pull_mem(&iov, sizeof(*codec_cfg));
+		util_iov_pull_mem(&iov, codec_cfg->len);
+
+		metadata = util_iov_pull_mem(&iov, sizeof(*metadata));
+		util_iov_pull_mem(&iov, metadata->len);
+
+		for (int j = 0; j < subgroup->num_bis; j++) {
+			struct bt_hci_le_pa_base_bis *bis;
+			struct bt_hci_lv_data *codec_cfg;
+
+			bis = util_iov_pull_mem(&iov, sizeof(*bis));
+			bcst_source->subgroup_data[i].bis_sync |=
+						(1 << (bis->index - 1));
+
+			codec_cfg = util_iov_pull_mem(&iov,
+						sizeof(*codec_cfg));
+			util_iov_pull_mem(&iov, codec_cfg->len);
+		}
+	}
+}
+
+static void bass_handle_set_broadcast_code_opcode(struct bt_bass *bass,
+						struct gatt_db_attribute *attrib,
+						uint8_t opcode,
+						unsigned int id,
+						struct iovec *iov,
+						struct bt_att *att)
+{
+	struct bt_bap *bap = bap_get_session(att, bass->bdb->db);
+	struct bt_bass_set_bcst_code_params *params;
+	struct bt_bcst_source *bcst_source;
+	uint8_t *notify_data;
+	size_t notify_data_len;
+	struct hci_request rq;
+
+	struct bt_hci_evt_le_big_sync_estabilished *big_sync_established_evt = NULL;
+	int big_sync_established_evt_len = 0;
+
+	if (!big_sync_cmd)
+		goto done;
+
+	big_sync_established_evt_len =
+			sizeof(struct bt_hci_evt_le_big_sync_estabilished) +
+			big_sync_cmd->num_bis * sizeof(uint16_t);
+
+	big_sync_established_evt = malloc(big_sync_established_evt_len);
+	if (big_sync_established_evt == NULL)
+		goto done;
+
+	/* validate Set Broadcast_Code command length */
+	if (iov->iov_len < sizeof(struct bt_bass_set_bcst_code_params)) {
+		if (opcode == BT_ATT_OP_WRITE_REQ)
+			gatt_db_attribute_write_result(attrib, id,
+					BT_ERROR_WRITE_REQUEST_REJECTED);
+
+		goto done;
+	}
+
+	/* get Set Broadcast_Code command parameters */
+	params = util_iov_pull_mem(iov, sizeof(*params));
+
+	bcst_source = queue_find(bap->ldb->bass_bcst_sources,
+						bass_src_id_match,
+						&params->source_id);
+
+	if (bcst_source == NULL) {
+		/* no source matches the written source_id */
+		if (opcode == BT_ATT_OP_WRITE_REQ)
+			gatt_db_attribute_write_result(attrib, id,
+					BT_BASS_ERROR_INVALID_SOURCE_ID);
+
+		goto done;
+	}
+
+	memcpy(big_sync_cmd->bcode, params->bcst_code,
+			BT_BAP_BROADCAST_CODE_SIZE);
+
+	rq.ogf		= OGF_LE_CTL;
+	rq.ocf		= OCF_LE_BIG_CREATE_SYNC;
+	rq.event	= BT_HCI_EVT_LE_BIG_SYNC_ESTABILISHED;
+	rq.cparam	= big_sync_cmd;
+	rq.clen		= big_sync_cmd_len;
+	rq.rparam	= big_sync_established_evt;
+	rq.rlen		= big_sync_established_evt_len;
+
+	if (hci_send_req(hci_fd, &rq, 0) < 0) {
+		DBG(bap, "Failed to send Big Sync Create command: %s",
+						strerror(errno));
+		goto done;
+	}
+
+	if (big_sync_established_evt->status == 0x00) {
+		bcst_source->encryption = BT_BASS_BIG_ENC_STATE_DEC;
+
+		bass_fill_bcst_source_bis_sync_bitmask(bcst_source);
+	} else {
+		bcst_source->encryption = BT_BASS_BIG_ENC_STATE_BAD_CODE;
+		memcpy(bcst_source->bad_code, params->bcst_code,
+					BT_BAP_BROADCAST_CODE_SIZE);
+	}
+
+	notify_data = bass_build_notif_from_bcst_source(bcst_source,
+							&notify_data_len);
+
+	gatt_db_attribute_notify(bcst_source->attr,
+					(void *)notify_data,
+					notify_data_len, att);
+
+	free(notify_data);
+
+done:
+
+	free(big_sync_cmd);
+	big_sync_cmd = NULL;
+	free(big_sync_established_evt);
+	free(pa_report);
+	pa_report = NULL;
+	big_sync_cmd_len = 0;
+}
+
+#define BASS_OP(_str, _op, _size, _func) \
+	{ \
+		.str = _str, \
+		.op = _op, \
+		.size = _size, \
+		.func = _func, \
+	}
+
+struct bass_op_handler {
+	const char	*str;
+	uint8_t		op;
+	size_t		size;
+	void		(*func)(struct bt_bass *bass,
+						struct gatt_db_attribute *attrib,
+						uint8_t opcode,
+						unsigned int id,
+						struct iovec *iov,
+						struct bt_att *att);
+} bass_handlers[] = {
+	BASS_OP("Set Broadcast_Code", BT_BASS_SET_BCST_CODE,
+		sizeof(struct bt_bass_set_bcst_code_params),
+		bass_handle_set_broadcast_code_opcode)
+};
+
+static void bass_broadcast_audio_scan_cp_write(struct gatt_db_attribute *attrib,
+				unsigned int id, uint16_t offset,
+				const uint8_t *value, size_t len,
+				uint8_t opcode, struct bt_att *att,
+				void *user_data)
+{
+	struct bt_bass *bass = user_data;
+	struct bt_bass_bcst_audio_scan_cp_hdr *hdr;
+	struct bass_op_handler *handler;
+	struct iovec iov = {
+		.iov_base = (void *)value,
+		.iov_len = len,
+	};
+
+	/* validate written command length */
+	if (len < (sizeof(*hdr))) {
+		if (opcode == BT_ATT_OP_WRITE_REQ) {
+			gatt_db_attribute_write_result(attrib, id,
+					BT_ERROR_WRITE_REQUEST_REJECTED);
+		}
+		return;
+	}
+
+	/* get command header */
+	hdr = util_iov_pull_mem(&iov, sizeof(*hdr));
+
+	if (hdr->op != BT_BASS_SET_BCST_CODE) {
+		if (opcode == BT_ATT_OP_WRITE_REQ) {
+			gatt_db_attribute_write_result(attrib, id,
+					BT_BASS_ERROR_OPCODE_NOT_SUPPORTED);
+		}
+
+		return;
+	}
+
+	/* call the appropriate opcode handler */
+	for (handler = bass_handlers; handler && handler->str; handler++) {
+		if (handler->op == hdr->op) {
+			handler->func(bass, attrib, opcode, id, &iov, att);
+			break;
+		}
+	}
+
+	gatt_db_attribute_write_result(attrib, id, 0x00);
+}
+
+static bool bass_source_match_attrib(const void *data, const void *match_data)
+{
+	const struct bt_bcst_source *src = data;
+	const struct gatt_db_attribute *attr = match_data;
+
+	return (src->attr == attr);
+}
+
+static bool bass_source_match_sid(const void *data, const void *match_data)
+{
+	const struct bt_bcst_source *src = data;
+	const uint8_t sid = *(const uint8_t *)match_data;
+
+	return (src->sid == sid);
+}
+
+static void bass_bcst_receive_state_read(struct gatt_db_attribute *attrib,
+							unsigned int id, uint16_t offset,
+							uint8_t opcode, struct bt_att *att,
+							void *user_data)
+{
+	struct bt_bass *bass = user_data;
+	struct bt_bap *bap = bap_get_session(att, bass->bdb->db);
+	uint8_t *rsp;
+	size_t rsp_len;
+	struct bt_bcst_source *bcst_source;
+
+	bcst_source = queue_find(bap->ldb->bass_bcst_sources,
+							bass_source_match_attrib,
+							attrib);
+
+	if (!bcst_source) {
+		gatt_db_attribute_read_result(attrib, id, 0, NULL,
+							0);
+		return;
+	}
+
+	/* build read response */
+	rsp = bass_build_read_rsp_from_bcst_source(bcst_source, &rsp_len);
+
+	if (!rsp) {
+		gatt_db_attribute_read_result(attrib, id, BT_ATT_ERROR_UNLIKELY,
+								NULL, 0);
+		return;
+	}
+
+	gatt_db_attribute_read_result(attrib, id, 0, (void *)rsp,
+						rsp_len);
+
+	free(rsp);
+}
+
+static void bcst_recv_new(struct bt_bass *bass, int i)
+{
+	struct bt_bcst_recv_state *bcst_recv_state;
+	bt_uuid_t uuid;
+
+	if (!bass)
+		return;
+
+	bcst_recv_state = new0(struct bt_bcst_recv_state, 1);
+	bcst_recv_state->bass = bass;
+
+	bt_uuid16_create(&uuid, BCST_RECV_STATE_UUID);
+	bcst_recv_state->attr = gatt_db_service_add_characteristic(bass->service, &uuid,
+					BT_ATT_PERM_READ,
+					BT_GATT_CHRC_PROP_READ |
+					BT_GATT_CHRC_PROP_NOTIFY,
+					bass_bcst_receive_state_read, NULL,
+					bass);
+
+	bcst_recv_state->ccc = gatt_db_service_add_ccc(bass->service,
+					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+
+	bass->bcst_recv_states[i] = bcst_recv_state;
+}
+
+static struct bt_bass *bass_new(struct gatt_db *db)
+{
+	struct bt_bass *bass;
+	bt_uuid_t uuid;
+	int i;
+
+	if (!db)
+		return NULL;
+
+	bass = new0(struct bt_bass, 1);
+
+	/* Populate DB with BASS attributes */
+	bt_uuid16_create(&uuid, BASS_UUID);
+	bass->service = gatt_db_add_service(db, &uuid, true,
+						3 + (NUM_BCST_RECV_STATES * 3));
+
+	for (i = 0; i < NUM_BCST_RECV_STATES; i++)
+		bcst_recv_new(bass, i);
+
+	bt_uuid16_create(&uuid, BCST_AUDIO_SCAN_CP_UUID);
+	bass->broadcast_audio_scan_cp = gatt_db_service_add_characteristic(bass->service,
+							&uuid,
+							BT_ATT_PERM_WRITE,
+							BT_GATT_CHRC_PROP_WRITE,
+							NULL, bass_broadcast_audio_scan_cp_write,
+							bass);
+
+	gatt_db_service_set_active(bass->service, true);
+
+	return bass;
+}
+
 static struct bt_bap_db *bap_db_new(struct gatt_db *db)
 {
 	struct bt_bap_db *bdb;
@@ -2182,6 +2873,7 @@ static struct bt_bap_db *bap_db_new(struct gatt_db *db)
 	bdb->sinks = queue_new();
 	bdb->sources = queue_new();
 	bdb->endpoints = queue_new();
+	bdb->bass_bcst_sources = queue_new();
 
 	if (!bap_db)
 		bap_db = queue_new();
@@ -2192,6 +2884,9 @@ static struct bt_bap_db *bap_db_new(struct gatt_db *db)
 	bdb->ascs = ascs_new(db);
 	bdb->ascs->bdb = bdb;
 
+	bdb->bass = bass_new(db);
+	bdb->bass->bdb = bdb;
+
 	queue_push_tail(bap_db, bdb);
 
 	return bdb;
@@ -2236,6 +2931,20 @@ static struct bt_ascs *bap_get_ascs(struct bt_bap *bap)
 	return bap->rdb->ascs;
 }
 
+static struct bt_bass *bap_get_bass(struct bt_bap *bap)
+{
+	if (!bap)
+		return NULL;
+
+	if (bap->rdb->bass)
+		return bap->rdb->bass;
+
+	bap->rdb->bass = new0(struct bt_bass, 1);
+	bap->rdb->bass->bdb = bap->rdb;
+
+	return bap->rdb->bass;
+}
+
 static bool match_codec(const void *data, const void *user_data)
 {
 	const struct bt_bap_pac *pac = data;
@@ -2321,6 +3030,17 @@ static void bap_pac_free(void *data)
 	free(pac);
 }
 
+static void bass_bcst_source_free(void *data)
+{
+	struct bt_bcst_source *bcst_source = data;
+
+	for (int i = 0; i < bcst_source->num_subgroups; i++)
+		free(bcst_source->subgroup_data[i].meta);
+
+	free(bcst_source->subgroup_data);
+	free(bcst_source);
+}
+
 static void bap_add_sink(struct bt_bap_pac *pac)
 {
 	struct iovec iov;
@@ -2512,10 +3232,12 @@ static void bap_db_free(void *data)
 	queue_destroy(bdb->sinks, bap_pac_free);
 	queue_destroy(bdb->sources, bap_pac_free);
 	queue_destroy(bdb->endpoints, free);
+	queue_destroy(bdb->bass_bcst_sources, bass_bcst_source_free);
 	gatt_db_unref(bdb->db);
 
 	free(bdb->pacs);
 	free(bdb->ascs);
+	free(bdb->bass);
 	free(bdb);
 }
 
@@ -2663,6 +3385,7 @@ struct bt_bap *bt_bap_new(struct gatt_db *ldb, struct gatt_db *rdb)
 	bdb->sinks = queue_new();
 	bdb->sources = queue_new();
 	bdb->endpoints = queue_new();
+	bdb->bass_bcst_sources = queue_new();
 
 	bap->rdb = bdb;
 
@@ -3670,6 +4393,119 @@ static void foreach_ascs_char(struct gatt_db_attribute *attr, void *user_data)
 	}
 }
 
+static void read_broadcast_receive_state(struct bt_bap *bap, bool success, uint8_t att_ecode,
+				const uint8_t *value, uint16_t length,
+				void *user_data)
+{
+	struct gatt_db_attribute *attr = user_data;
+	struct bt_bcst_source *bcst_source = NULL;
+
+	if (!success) {
+		DBG(bap, "Unable to read Broadcast Receive State: error 0x%02x", att_ecode);
+		return;
+	}
+
+	if (length == 0)
+		return;
+
+	bcst_source = queue_find(bap->rdb->bass_bcst_sources,
+				bass_source_match_attrib, attr);
+
+	if (!bcst_source) {
+		bcst_source = malloc(sizeof(struct bt_bcst_source));
+
+		if (bcst_source == NULL) {
+			DBG(bap, "Failed to allocate memory for broadcast source");
+			return;
+		}
+
+		memset(bcst_source, 0, sizeof(struct bt_bcst_source));
+		bcst_source->attr = attr;
+
+		queue_push_tail(bap->rdb->bass_bcst_sources, bcst_source);
+	}
+
+	if (bass_build_bcst_source_from_read_rsp(bcst_source, value)) {
+		free(bcst_source);
+		DBG(bap, "Failed to populate broadcast source data");
+		return;
+	}
+}
+
+static void bcst_recv_state_notify(struct bt_bap *bap, uint16_t value_handle,
+				const uint8_t *value, uint16_t length,
+				void *user_data)
+{
+	struct gatt_db_attribute *attr = user_data;
+	struct bt_bcst_source *bcst_source = NULL;
+
+	bcst_source = queue_find(bap->rdb->bass_bcst_sources,
+				bass_source_match_attrib, attr);
+
+	if (!bcst_source) {
+		bcst_source = malloc(sizeof(struct bt_bcst_source));
+
+		if (bcst_source == NULL) {
+			DBG(bap, "Failed to allocate memory for broadcast source");
+			return;
+		}
+
+		memset(bcst_source, 0, sizeof(struct bt_bcst_source));
+		bcst_source->attr = attr;
+
+		queue_push_tail(bap->rdb->bass_bcst_sources, bcst_source);
+	}
+
+	if (bass_build_bcst_source_from_notif(bcst_source, value)) {
+		free(bcst_source);
+		DBG(bap, "Failed to populate broadcast source data");
+		return;
+	}
+}
+
+static void foreach_bass_char(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct bt_bap *bap = user_data;
+	uint16_t value_handle;
+	bt_uuid_t uuid, uuid_bcst_audio_scan_cp, uuid_bcst_recv_state;
+	struct bt_bass *bass;
+
+	/* get attribute value handle and uuid */
+	if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle,
+						NULL, NULL, &uuid))
+		return;
+
+	bt_uuid16_create(&uuid_bcst_audio_scan_cp, BCST_AUDIO_SCAN_CP_UUID);
+	bt_uuid16_create(&uuid_bcst_recv_state, BCST_RECV_STATE_UUID);
+
+	if (!bt_uuid_cmp(&uuid, &uuid_bcst_audio_scan_cp)) {
+
+		/* found Broadcast Audio Scan Control Point characteristic */
+		bass = bap_get_bass(bap);
+
+		if (!bass || bass->broadcast_audio_scan_cp)
+			return;
+
+		/* store characteristic reference */
+		bass->broadcast_audio_scan_cp = attr;
+
+		DBG(bap, "Broadcast Audio Scan Control Point found: handle 0x%04x",
+							value_handle);
+	}
+
+	if (!bt_uuid_cmp(&uuid, &uuid_bcst_recv_state)) {
+
+		/* found Broadcast Receive State characteristic */
+		bap_read_value(bap, value_handle, read_broadcast_receive_state, attr);
+
+		(void)bap_register_notify(bap, value_handle,
+						bcst_recv_state_notify, attr);
+
+		DBG(bap, "Broadcast receive State found: handle 0x%04x",
+							value_handle);
+	}
+}
+
 static void foreach_ascs_service(struct gatt_db_attribute *attr,
 						void *user_data)
 {
@@ -3683,6 +4519,19 @@ static void foreach_ascs_service(struct gatt_db_attribute *attr,
 	gatt_db_service_foreach_char(attr, foreach_ascs_char, bap);
 }
 
+static void foreach_bass_service(struct gatt_db_attribute *attr,
+						void *user_data)
+{
+	struct bt_bap *bap = user_data;
+	struct bt_bass *bass = bap_get_bass(bap);
+
+	/* store BASS attribute reference */
+	bass->service = attr;
+
+	/* handle BASS attributes */
+	gatt_db_service_foreach_char(attr, foreach_bass_char, bap);
+}
+
 static void bap_endpoint_foreach(void *data, void *user_data)
 {
 	struct bt_bap_endpoint *ep = data;
@@ -3778,6 +4627,9 @@ clone:
 	bt_uuid16_create(&uuid, ASCS_UUID);
 	gatt_db_foreach_service(bap->rdb->db, &uuid, foreach_ascs_service, bap);
 
+	bt_uuid16_create(&uuid, BASS_UUID);
+	gatt_db_foreach_service(bap->rdb->db, &uuid, foreach_bass_service, bap);
+
 	return true;
 }
 
@@ -4834,3 +5686,215 @@ bool bt_bap_stream_io_is_connecting(struct bt_bap_stream *stream, int *fd)
 
 	return io->connecting;
 }
+
+void bap_big_info_adv_report_received_cb(struct gatt_db *db, uint8_t source_id,
+		struct bt_hci_evt_le_big_info_adv_report *big_info_adv_report)
+{
+	struct bt_bap_db *bdb = bap_get_db(db);
+	struct bt_bcst_source *bcst_source = NULL;
+	size_t notify_data_len = 0;
+	uint8_t *notify_data;
+	struct hci_request rq;
+	struct bt_hci_evt_le_big_sync_estabilished *big_sync_established_evt = NULL;
+	int big_sync_established_evt_len = 0;
+
+	if (!pa_report)
+		return;
+
+	bcst_source = queue_find(bdb->bass_bcst_sources,
+					bass_src_id_match,
+					&source_id);
+
+	if (bcst_source == NULL) {
+		free(pa_report);
+		pa_report = NULL;
+		return;
+	}
+
+	big_sync_cmd_len = sizeof(struct bt_hci_cmd_le_big_create_sync)
+				+ big_info_adv_report->num_bis *
+				sizeof(struct bt_hci_bis_sync);
+
+	free(big_sync_cmd);
+	big_sync_cmd = malloc(big_sync_cmd_len);
+
+	if (!big_sync_cmd) {
+		free(pa_report);
+		pa_report = NULL;
+		return;
+	}
+
+	memset(big_sync_cmd, 0, big_sync_cmd_len);
+
+	big_sync_cmd->sync_handle = big_info_adv_report->sync_handle;
+	big_sync_cmd->encryption = big_info_adv_report->encryption;
+	big_sync_cmd->timeout = 0x4000;
+	big_sync_cmd->num_bis = big_info_adv_report->num_bis;
+
+	bass_fill_create_big_sync_cmd_from_pa_report(big_sync_cmd);
+
+	if (big_info_adv_report->encryption == 0x01) {
+		bcst_source->encryption = BT_BASS_BIG_ENC_STATE_BCODE_REQ;
+	} else {
+		bcst_source->encryption = BT_BASS_BIG_ENC_STATE_NO_ENC;
+
+		big_sync_established_evt_len =
+				sizeof(struct bt_hci_evt_le_big_sync_estabilished) +
+				big_sync_cmd->num_bis * sizeof(uint16_t);
+
+		big_sync_established_evt = malloc(big_sync_established_evt_len);
+		if (big_sync_established_evt == NULL) {
+			free(pa_report);
+			pa_report = NULL;
+
+			free(big_sync_cmd);
+			big_sync_cmd = NULL;
+			big_sync_cmd_len = 0;
+
+			goto done;
+		}
+
+		/* create BIG sync */
+		rq.ogf		= OGF_LE_CTL;
+		rq.ocf		= 0x006B;
+		rq.event	= BT_HCI_EVT_LE_BIG_SYNC_ESTABILISHED;
+		rq.cparam	= big_sync_cmd;
+		rq.clen		= big_sync_cmd_len;
+		rq.rparam	= big_sync_established_evt;
+		rq.rlen		= big_sync_established_evt_len;
+
+		if (hci_send_req(hci_fd, &rq, 0) < 0) {
+			free(pa_report);
+			pa_report = NULL;
+
+			free(big_sync_cmd);
+			big_sync_cmd = NULL;
+			big_sync_cmd_len = 0;
+
+			free(big_sync_established_evt);
+
+			goto done;
+		}
+
+		if (!big_sync_established_evt->status)
+			bass_fill_bcst_source_bis_sync_bitmask(bcst_source);
+	}
+
+done:
+
+	notify_data = bass_build_notif_from_bcst_source(bcst_source,
+							&notify_data_len);
+
+	gatt_db_attribute_notify(bcst_source->attr, (void *)notify_data,
+				notify_data_len, NULL);
+
+	free(notify_data);
+}
+
+void bap_pa_report_received_cb(struct gatt_db *db, uint8_t source_id,
+				struct bt_hci_le_pa_report *report)
+{
+	struct bt_bcst_source *bcst_source = NULL;
+	struct bt_bap_db *bdb = bap_get_db(db);
+	uint8_t report_len = sizeof(struct bt_hci_le_pa_report) +
+						report->data_len;
+
+	printf("Report len = %d\n\n", report->data_len);
+
+	free(pa_report);
+	pa_report = malloc(report_len);
+	if (!pa_report)
+		return;
+
+	memcpy(pa_report, report, report_len);
+
+	bcst_source = queue_find(bdb->bass_bcst_sources,
+					bass_src_id_match,
+					&source_id);
+
+	if (!bcst_source)
+		return;
+
+	bass_fill_bcst_source_from_pa_report(bcst_source);
+}
+
+int bap_ext_adv_report_received_cb(struct gatt_db *db,
+				struct bt_hci_le_ext_adv_report *ext_adv_report)
+{
+	struct bt_bcst_source *bcst_source = NULL;
+	struct gatt_db_attribute *attr = NULL;
+	struct bt_bap_db *bdb = bap_get_db(db);
+	struct bt_ad_structure *ad_structure;
+	uint16_t uuid;
+	uint8_t *bid;
+
+	struct iovec iov = {
+		.iov_base = ext_adv_report->data,
+		.iov_len = ext_adv_report->data_len,
+	};
+
+	bcst_source = queue_find(bdb->bass_bcst_sources,
+					bass_source_match_sid,
+					&ext_adv_report->sid);
+
+	if (bcst_source != NULL)
+		return -1;
+
+	bcst_source = malloc(sizeof(struct bt_bcst_source));
+
+	if (bcst_source == NULL)
+		return -1;
+
+	memset(bcst_source, 0, sizeof(struct bt_bcst_source));
+
+	bcst_source->id = next_available_source_id++;
+	bcst_source->addr_type = ext_adv_report->addr_type;
+	memcpy(bcst_source->addr, ext_adv_report->addr, 6);
+	bcst_source->sid = ext_adv_report->sid;
+
+	ad_structure = util_iov_pull_mem(&iov, sizeof(*ad_structure));
+
+	while (ad_structure) {
+		if (ad_structure->ad_type == BT_AD_SERVICE_DATA16) {
+			uuid = bt_get_le16(util_iov_pull_mem(&iov, sizeof(uint16_t)));
+			if (uuid == BCST_AUDIO_ANNOUNCEMENT_SERVICE_UUID) {
+				bid = util_iov_pull_mem(&iov,
+							BT_BAP_BROADCAST_ID_SIZE);
+				memcpy(bcst_source->bid, bid,
+							BT_BAP_BROADCAST_ID_SIZE);
+				break;
+			}
+		}
+
+		ad_structure = util_iov_pull_mem(&iov, sizeof(*ad_structure));
+	}
+
+	for (int i = 0; i < NUM_BCST_RECV_STATES; i++) {
+		attr = bdb->bass->bcst_recv_states[i]->attr;
+
+		if (queue_find(bdb->bass_bcst_sources,
+			bass_source_match_attrib, attr) == NULL) {
+			bcst_source->attr = attr;
+			break;
+		}
+	}
+
+	queue_push_tail(bdb->bass_bcst_sources, bcst_source);
+
+	return bcst_source->id;
+}
+
+int bt_bap_register_device(int dev_id)
+{
+	/* Open HCI */
+	hci_fd = hci_open_dev(dev_id);
+	if (hci_fd == -1)
+		return -1;
+
+	return 0;
+}
+
+void bt_bap_register_db(struct gatt_db *db)
+{
+	bap_db_new(db);
+}
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 47a15636c..f72ecbd76 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -9,6 +9,7 @@
 
 #include <stdbool.h>
 #include <inttypes.h>
+#include "monitor/bt.h"
 
 #ifndef __packed
 #define __packed __attribute__((packed))
@@ -33,6 +34,9 @@
 #define BT_BAP_CONFIG_PHY_2M		0x02
 #define BT_BAP_CONFIG_PHY_CODEC		0x03
 
+#define BT_BAP_BROADCAST_CODE_SIZE	16
+#define BT_BAP_BROADCAST_ID_SIZE	3
+
 struct bt_bap;
 struct bt_bap_pac;
 struct bt_bap_stream;
@@ -62,6 +66,17 @@ struct bt_bap_qos {
 	uint8_t  target_latency;	/* Target Latency */
 };
 
+struct bt_ad_structure {
+	uint8_t  ad_len;
+	uint8_t  ad_type;
+	uint8_t  value[0];
+} __packed;
+
+struct bt_broadcast_audio_announcement {
+	uint16_t uuid;
+	uint8_t  bid[BT_BAP_BROADCAST_ID_SIZE];
+} __packed;
+
 typedef void (*bt_bap_ready_func_t)(struct bt_bap *bap, void *user_data);
 typedef void (*bt_bap_destroy_func_t)(void *user_data);
 typedef void (*bt_bap_debug_func_t)(const char *str, void *user_data);
@@ -267,3 +282,13 @@ uint8_t bt_bap_stream_io_dir(struct bt_bap_stream *stream);
 
 int bt_bap_stream_io_connecting(struct bt_bap_stream *stream, int fd);
 bool bt_bap_stream_io_is_connecting(struct bt_bap_stream *stream, int *fd);
+
+int bap_ext_adv_report_received_cb(struct gatt_db *db,
+				struct bt_hci_le_ext_adv_report *ext_adv_report);
+void bap_pa_report_received_cb(struct gatt_db *db, uint8_t source_id,
+					struct bt_hci_le_pa_report *report);
+void bap_big_info_adv_report_received_cb(struct gatt_db *db, uint8_t source_id,
+		struct bt_hci_evt_le_big_info_adv_report *big_info_adv_report);
+
+int bt_bap_register_device(int dev_id);
+void bt_bap_register_db(struct gatt_db *db);
diff --git a/src/shared/bass.h b/src/shared/bass.h
new file mode 100644
index 000000000..ad85e8f62
--- /dev/null
+++ b/src/shared/bass.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2022  Intel Corporation. All rights reserved.
+ *
+ */
+
+#define NUM_BCST_RECV_STATES				2
+
+/* Application error codes */
+#define BT_BASS_ERROR_OPCODE_NOT_SUPPORTED		0x80
+
+#define BT_BASS_ERROR_INVALID_SOURCE_ID			0x81
+
+/* PA_Sync_State values */
+#define BT_BASS_NOT_SYNCHRONIZED_TO_PA			0x00
+#define BT_BASS_SYNC_INFO_RE				0x01
+#define BT_BASS_SYNCHRONIZED_TO_PA			0x02
+#define BT_BASS_FAILED_TO_SYNCHRONIZE_TO_PA		0x03
+#define BT_BASS_NO_PAST					0x04
+
+/* BIG_Encryption values */
+#define BT_BASS_BIG_ENC_STATE_NO_ENC			0x00
+#define BT_BASS_BIG_ENC_STATE_BCODE_REQ			0x01
+#define BT_BASS_BIG_ENC_STATE_DEC			0x02
+#define BT_BASS_BIG_ENC_STATE_BAD_CODE			0x03
+
+/* Broadcast Audio Scan Control Point
+ * header structure
+ */
+struct bt_bass_bcst_audio_scan_cp_hdr {
+	uint8_t op;
+} __packed;
+
+#define BT_BASS_SET_BCST_CODE				0x04
+
+struct bt_bass_set_bcst_code_params {
+	uint8_t source_id;
+	uint8_t bcst_code[BT_BAP_BROADCAST_CODE_SIZE];
+} __packed;
-- 
2.34.1

