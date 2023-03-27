Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BEFC76195
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Mar 2023 13:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjC0Npu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Mar 2023 09:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjC0Npr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Mar 2023 09:45:47 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BCD527A
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 06:45:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzfSFioTU8Jpovpjp0z5CudZBGRIY4oBXErsdat++Ov4W6p3zB6Yt/fblit+CF3EWHqEKlQWyylfh5+v9g+iHnWa8BAfkgVd8kYOTeipanyKlsENSfPxs4DkDXRMbw5WN2xyWmOO4L3rcGt4/AbWTFlOtIqfavxFmJtAQ0xaO0bgXQ/YSQGZkBtiD/XR5Upupq96LCWN6y127jn/t/cnY53IQ78HoxFdH0DjrrP7mYR6bU0IK4MrBL98LEii5ElKdeytstlt1mg8Y8meYdwKmx/DLwm9xuBMmBCZ92AZ3oB1HKzNzjyoWIBEhm3lTfnbJrDb+DXBCb5HshEzxNf/+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZ9HOZAEWAMW6k9O79/7TabrBmRDMOmNifd5rvmNVck=;
 b=Tpu5j5Cuol/ZPc0CwrtMxE6gmI1e4wpf0vrjpt1E+3ZcJjR2CsbB3rclSWVQ+q3llhfB4aKWhriqTAP1ipSKjvoES4weP/8ZA5GcROUoSoZtXfZK5fcaFnWUVfIpnRwV8WSQdzzqRRUD9i/Zir6/7KBgux9A3oFvvpeXprYv6m2LMPcX3in5ZSqRVstA7WqzHevir0nrbrvlyYbHBUryRGLfyy76E/UPbxrNY6ptmWwjq1z4Ucw3oPWtK3F/AI+ldW+J/98NamrD+3UQo4qNRAYfNhA9ioNZIIwNLqc9PpugIYyUeifJX4HXC5jcmwoPQhNNwgRoEYmXdzSFJKrqrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZ9HOZAEWAMW6k9O79/7TabrBmRDMOmNifd5rvmNVck=;
 b=EOMEEqglci2j3C9FXFWqDBV43ysEKuJr/n6Q8kSiUu4qYxdcs/O+XmulYiplE10emqw3BOiIdE/s0NkuSZjlxqGnG3CHzd/FZkFvjEbp0f5695AC7p4nER9XZsgC3gvv/6zW90t7HLiUqzSJHLBa38/QCuRzVuNmYrw6UNYBL3s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBBPR04MB7932.eurprd04.prod.outlook.com (2603:10a6:10:1ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 13:45:41 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%9]) with mapi id 15.20.6222.030; Mon, 27 Mar 2023
 13:45:41 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: Split bt_iso_qos into dedicated structures
Date:   Mon, 27 Mar 2023 16:45:22 +0300
Message-Id: <20230327134522.14308-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327134522.14308-1-iulia.tanasescu@nxp.com>
References: <20230327134522.14308-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0015.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::25) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBBPR04MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 9edf6cca-286a-4c31-fd53-08db2ec98e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bRtgRfDhZ6pD1UVw5vfT8gT8muQHS+2VoRd5/UhzSrACHNKHsLR3U879+k5sfIIxKPxn4LKhZbpSF2JD/bwTw+bZMKQpnyzHJ4Pd7zSIv0M05MfFyRZ6ZcG7GSbhj+fOEBL2cIFH4QTJejijci0X3WhDFdCHEuE63HnQeSxoCrDMlmswl7ck+PEO2myAkkPkAwkmRZA8wV44zAV/qsBLgEeJ28PopjVyCfZTlEioeimap7/xSPpV1qPE1+Xm/8U2h0zt8lu5eiqWZjopb46QpV74dvaYI4QX5vYChYFIhf/uVdAJ0aIxfUSRkV0MYgML8OayXVUsfk0Aw8rxX7u+VSpTTpEJhnfRnYT8e/ks9XCjDG25lD4zliQWqwbxekQeBiE7D57xxBfFWKqMJq+P49InT8NRjRzz5qE4VrPzG818mkrgPpw4tau2Tp9A1YZ8ABoq41gGrAXy+N7IFNcsCTeIL2rPxC9rcwWMPk7avqr9H08XvKddeBQs9Mmd1yEpf/VN5n/+uMNN8nNknwqgeAgFGudYhONoqiwEoOZ2oq45c/wG2MIHjwREXOh3z/wWvNHMGG2g0MWJmkydia0tHvVj5pOraOY8QlKqIMP9cxbjYY7cLY87xBG/n6MYFIXL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199021)(316002)(478600001)(8936002)(5660300002)(36756003)(86362001)(44832011)(38100700002)(30864003)(2906002)(38350700002)(4326008)(8676002)(6916009)(66556008)(66476007)(66946007)(41300700001)(6666004)(186003)(1076003)(26005)(55236004)(6506007)(6512007)(2616005)(83380400001)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fWxLkJCZxsq5xkpxl+S6JrYJH3D7P+xCaTGV4p34VnijUf8KbCYs3yfl/qu7?=
 =?us-ascii?Q?l2vxaBH/CZhIvv+ljGRU9WItI5X+rWN2mNKXpOQ6dhuQb/6hwI6bn9UXGuVP?=
 =?us-ascii?Q?Ha2Bb7vyWRtcLlBcTg37BMkGHgT8vTH9CZOxzlF4bfduiWr7UwhtGrKm6lrO?=
 =?us-ascii?Q?Do1qEOkgAGDycxFcKHlaGA1OMjA/USCTQTEOeNdLX+ECGoZ9K98RLyCc0v8W?=
 =?us-ascii?Q?iobnhmc2vE2o+aFL/v/bCLuJlEzF7k4lWohU+n69sdJhlEEuEdF5AMYiV2ol?=
 =?us-ascii?Q?aCy2xiY+i7guVt4lS48FoqzDuxsYCNZixEQUazuqt0y+OiETnMAaYeMXgAC5?=
 =?us-ascii?Q?/kCq5n/Q6YOTjuqh8VIkW5nfe1H+hZ2dwoXeoYnLSGCAsEsbSEM+pa5zGMeY?=
 =?us-ascii?Q?vMQeds8EW2NIKDQ+1JWfRz92TmjIzoZ890rRTlex1W+fzx5PnTlDs8RR53qH?=
 =?us-ascii?Q?r5IMfHs3JuDwmGziYGqovKVA6S9hD3ikGbJxxfZRpZCGj3Q6k1MozHyzO6+G?=
 =?us-ascii?Q?l4MbZKkC5gn8j4i3hsKd1amPKtfHDiSclPBEFRB/y5xCtU/tpx0DrAXth99m?=
 =?us-ascii?Q?auxxIKOMCkQ2n0BQdkJ8tULm2ZdwjnWPaPCP5BHkJ2wl/VJsOZbceqPG44rt?=
 =?us-ascii?Q?cnHAZFYHDE+UebBWA3kRgdD+hFthgZPQmMeQhVevE2+xlIy16Obsw9ZRJnWI?=
 =?us-ascii?Q?0EZ7Ii0m8vSGz4fPKP0a/NHZvUmis2WpXeFXEytQ8QM5ILeIasPxqbJ36Bdw?=
 =?us-ascii?Q?bDogvw3ETJeDaipR6NWAUq+qlWUdp0bsrnlkGiEQCV9Pa3NDN0Ru4C+R0oYm?=
 =?us-ascii?Q?c4uCRTqfifC2iJti6kK8o7L1IsFq28s3rXnSW9KAf+y+1qoqDi9ZgeMRv3ak?=
 =?us-ascii?Q?fRSDTrur3R7pOYENAfdS+w64xoQmmu7ROVjc3ht83JQk7CDu5VhbuhO2aJik?=
 =?us-ascii?Q?zf6DajO7wWG/CZom8ulCsvIOZH5j9aum3VeJiggeJi8zmmo93t9aRn1+ms3+?=
 =?us-ascii?Q?KT1Pa7NFc2LU7o7SQSD61g8texUnnJepqMrmQS6j+rvzoFnncCoolA1YvNMF?=
 =?us-ascii?Q?Gpgnh4z9dqln1hpKQEBgEiujhfTq03fKOpf98ADBfa3j3BcjW/ViJr3sMYg6?=
 =?us-ascii?Q?5ABtljTBe5V5XcIHYKsTY1ejm25sTICFOwHAkvWcP9GfSVq90JDAey5z4JwT?=
 =?us-ascii?Q?L6qz/VYSFTfY4jH10pDbhobxma2Y1vHgRlQtoPFk+N6J49QocVsKm9OJejwR?=
 =?us-ascii?Q?vuAeNWSAtGUvg9sz6mFES7yDBMf/pp/K326CazTGuSZ3B5vyOA3+a0bl6LLK?=
 =?us-ascii?Q?bEC+lKWQT5xXG9/LKqdLH1kzSsNvHFImAE+9PNFGMR5pkXiNPS1KaMUzPofi?=
 =?us-ascii?Q?tNNSxJf+VKk9n4x4zErufv7OBlgU/QhOvqi8dD2/8kqpCxl45KUEhVfeGkB8?=
 =?us-ascii?Q?OKoBSuZCyeu4boLPx9yD8/7YfTwDSTdexXrXESwZP4bp6+2mB3vmgLRv9FlM?=
 =?us-ascii?Q?9eXR/0AiCWzAep8dY/ZPSe1mYaicnqEeq5rdtQqdBLLN6UXZyxQCuhDeoXBs?=
 =?us-ascii?Q?Yx21d7H752No7QhIT/JaHyO+QSF90MOQ3HlmijdLI5ChOa8j/E5FDVAEvERb?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9edf6cca-286a-4c31-fd53-08db2ec98e2a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 13:45:41.3744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rKInkXBYIyXh/D6r6b4a9lTRatXxMSVowcIlSoacyBmV41Bu+O6975lwjGgFu8yBj25fUqgyV9jcphFFpWzXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7932
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Split bt_iso_qos into dedicated unicast and broadcast
structures and add additional broadcast parameters.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 include/net/bluetooth/bluetooth.h |  56 ++++++--
 include/net/bluetooth/hci_core.h  |  17 +--
 net/bluetooth/hci_conn.c          | 104 +++++++++------
 net/bluetooth/hci_event.c         |  38 +++---
 net/bluetooth/iso.c               | 205 ++++++++++++++++++++++++------
 5 files changed, 305 insertions(+), 115 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index bcc5a4cd2c17..bc2503d9c3cd 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -1,6 +1,7 @@
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (C) 2000-2001 Qualcomm Incorporated
+   Copyright 2023 NXP
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
@@ -171,25 +172,54 @@ struct bt_iso_io_qos {
 	__u8  rtn;
 };
 
-struct bt_iso_qos {
-	union {
-		__u8  cig;
-		__u8  big;
-	};
-	union {
-		__u8  cis;
-		__u8  bis;
-	};
-	union {
-		__u8  sca;
-		__u8  sync_interval;
-	};
+struct bt_iso_ucast_qos {
+	__u8  cig;
+	__u8  cis;
+	__u8  sca;
 	__u8  packing;
 	__u8  framing;
 	struct bt_iso_io_qos in;
 	struct bt_iso_io_qos out;
 };
 
+struct bt_iso_bcast_src_qos {
+	__u8  sync_interval;
+	__u8  big;
+	__u8  bis;
+	__u8  packing;
+	__u8  framing;
+	__u8  encryption;
+	__u8  bcode[16];
+	struct bt_iso_io_qos out;
+};
+
+struct bt_iso_bcast_snk_qos {
+	__u8  options;
+	__u16 skip;
+	__u16 sync_timeout;
+	__u8  sync_cte_type;
+	__u8  big;
+	__u8  encryption;
+	__u8  bcode[16];
+	__u8  mse;
+	__u16 timeout;
+	struct bt_iso_io_qos in;
+};
+
+struct bt_iso_bcast_qos {
+union {
+		struct bt_iso_bcast_src_qos bsrc;
+		struct bt_iso_bcast_snk_qos bsnk;
+	};
+};
+
+struct bt_iso_qos {
+	union {
+		struct bt_iso_ucast_qos ucast;
+		struct bt_iso_bcast_qos bcast;
+	};
+};
+
 #define BT_ISO_PHY_1M		0x01
 #define BT_ISO_PHY_2M		0x02
 #define BT_ISO_PHY_CODED	0x04
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 53d3328c2b8b..e6e6217a4509 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1,6 +1,7 @@
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (c) 2000-2001, 2010, Code Aurora Forum. All rights reserved.
+   Copyright 2023 NXP
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
@@ -1090,7 +1091,7 @@ static inline struct hci_conn *hci_conn_hash_lookup_bis(struct hci_dev *hdev,
 		if (bacmp(&c->dst, ba) || c->type != ISO_LINK)
 			continue;
 
-		if (c->iso_qos.big == big && c->iso_qos.bis == bis) {
+		if (c->iso_qos.bcast.bsrc.big == big && c->iso_qos.bcast.bsrc.bis == bis) {
 			rcu_read_unlock();
 			return c;
 		}
@@ -1199,7 +1200,7 @@ static inline struct hci_conn *hci_conn_hash_lookup_cig(struct hci_dev *hdev,
 		if (c->type != ISO_LINK)
 			continue;
 
-		if (handle == c->iso_qos.cig) {
+		if (handle == c->iso_qos.ucast.cig) {
 			rcu_read_unlock();
 			return c;
 		}
@@ -1222,7 +1223,7 @@ static inline struct hci_conn *hci_conn_hash_lookup_big(struct hci_dev *hdev,
 		if (bacmp(&c->dst, BDADDR_ANY) || c->type != ISO_LINK)
 			continue;
 
-		if (handle == c->iso_qos.big) {
+		if (handle == c->iso_qos.bcast.bsrc.big) {
 			rcu_read_unlock();
 			return c;
 		}
@@ -1324,15 +1325,15 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 				 __u16 setting, struct bt_codec *codec);
 struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
-			      __u8 dst_type, struct bt_iso_qos *qos);
+			      __u8 dst_type, struct bt_iso_ucast_qos *qos);
 struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
-				 __u8 dst_type, struct bt_iso_qos *qos);
+				 __u8 dst_type, struct bt_iso_ucast_qos *qos);
 struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
-				 __u8 dst_type, struct bt_iso_qos *qos,
+				 __u8 dst_type, struct bt_iso_bcast_src_qos *qos,
 				 __u8 data_len, __u8 *data);
 int hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst, __u8 dst_type,
-		       __u8 sid);
-int hci_le_big_create_sync(struct hci_dev *hdev, struct bt_iso_qos *qos,
+		       __u8 sid, struct bt_iso_bcast_snk_qos *qos);
+int hci_le_big_create_sync(struct hci_dev *hdev, struct bt_iso_bcast_snk_qos *qos,
 			   __u16 sync_handle, __u8 num_bis, __u8 bis[]);
 int hci_conn_check_link_mode(struct hci_conn *conn);
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 17b946f9ba31..8e12b00b45a2 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1,6 +1,7 @@
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (c) 2000-2001, 2010, Code Aurora Forum. All rights reserved.
+   Copyright 2023 NXP
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
@@ -771,13 +772,22 @@ struct iso_list_data {
 static void bis_list(struct hci_conn *conn, void *data)
 {
 	struct iso_list_data *d = data;
+	u8 check_big;
+	u8 check_bis = BT_ISO_QOS_BIS_UNSET;
 
 	/* Skip if not broadcast/ANY address */
 	if (bacmp(&conn->dst, BDADDR_ANY))
 		return;
 
-	if (d->big != conn->iso_qos.big || d->bis == BT_ISO_QOS_BIS_UNSET ||
-	    d->bis != conn->iso_qos.bis)
+	if (conn->role == HCI_ROLE_MASTER) {
+		check_big = conn->iso_qos.bcast.bsrc.big;
+		check_bis = conn->iso_qos.bcast.bsrc.bis;
+	} else {
+		check_big = conn->iso_qos.bcast.bsnk.big;
+	}
+
+	if (d->big != check_big || d->bis == BT_ISO_QOS_BIS_UNSET ||
+	    d->bis != check_bis)
 		return;
 
 	d->count++;
@@ -897,10 +907,10 @@ static void bis_cleanup(struct hci_conn *conn)
 		if (!test_and_clear_bit(HCI_CONN_PER_ADV, &conn->flags))
 			return;
 
-		hci_le_terminate_big(hdev, conn->iso_qos.big,
-				     conn->iso_qos.bis);
+		hci_le_terminate_big(hdev, conn->iso_qos.bcast.bsrc.big,
+				     conn->iso_qos.bcast.bsrc.bis);
 	} else {
-		hci_le_big_terminate(hdev, conn->iso_qos.big,
+		hci_le_big_terminate(hdev, conn->iso_qos.bcast.bsnk.big,
 				     conn->sync_handle);
 	}
 }
@@ -940,7 +950,7 @@ static void cis_cleanup(struct hci_conn *conn)
 	struct iso_list_data d;
 
 	memset(&d, 0, sizeof(d));
-	d.cig = conn->iso_qos.cig;
+	d.cig = conn->iso_qos.ucast.cig;
 
 	/* Check if ISO connection is a CIS and remove CIG if there are
 	 * no other connections using it.
@@ -949,7 +959,7 @@ static void cis_cleanup(struct hci_conn *conn)
 	if (d.count)
 		return;
 
-	hci_le_remove_cig(hdev, conn->iso_qos.cig);
+	hci_le_remove_cig(hdev, conn->iso_qos.ucast.cig);
 }
 
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
@@ -1398,12 +1408,12 @@ static int hci_explicit_conn_params_set(struct hci_dev *hdev,
 	return 0;
 }
 
-static int qos_set_big(struct hci_dev *hdev, struct bt_iso_qos *qos)
+static int qos_set_big(struct hci_dev *hdev, uint8_t *big)
 {
 	struct iso_list_data data;
 
 	/* Allocate a BIG if not set */
-	if (qos->big == BT_ISO_QOS_BIG_UNSET) {
+	if (*big == BT_ISO_QOS_BIG_UNSET) {
 		for (data.big = 0x00; data.big < 0xef; data.big++) {
 			data.count = 0;
 			data.bis = 0xff;
@@ -1418,13 +1428,14 @@ static int qos_set_big(struct hci_dev *hdev, struct bt_iso_qos *qos)
 			return -EADDRNOTAVAIL;
 
 		/* Update BIG */
-		qos->big = data.big;
+		*big = data.big;
 	}
 
 	return 0;
 }
 
-static int qos_set_bis(struct hci_dev *hdev, struct bt_iso_qos *qos)
+static int qos_set_bis(struct hci_dev *hdev,
+		       struct bt_iso_bcast_src_qos *qos)
 {
 	struct iso_list_data data;
 
@@ -1455,7 +1466,7 @@ static int qos_set_bis(struct hci_dev *hdev, struct bt_iso_qos *qos)
 
 /* This function requires the caller holds hdev->lock */
 static struct hci_conn *hci_add_bis(struct hci_dev *hdev, bdaddr_t *dst,
-				    struct bt_iso_qos *qos)
+				    struct bt_iso_bcast_src_qos *qos)
 {
 	struct hci_conn *conn;
 	struct iso_list_data data;
@@ -1468,7 +1479,7 @@ static struct hci_conn *hci_add_bis(struct hci_dev *hdev, bdaddr_t *dst,
 		return ERR_PTR(-EOPNOTSUPP);
 	}
 
-	err = qos_set_big(hdev, qos);
+	err = qos_set_big(hdev, &qos->big);
 	if (err)
 		return ERR_PTR(err);
 
@@ -1636,7 +1647,7 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	return sco;
 }
 
-static void cis_add(struct iso_list_data *d, struct bt_iso_qos *qos)
+static void cis_add(struct iso_list_data *d, struct bt_iso_ucast_qos *qos)
 {
 	struct hci_cis_params *cis = &d->pdu.cis[d->pdu.cp.num_cis];
 
@@ -1659,8 +1670,8 @@ static void cis_list(struct hci_conn *conn, void *data)
 	if (!bacmp(&conn->dst, BDADDR_ANY))
 		return;
 
-	if (d->cig != conn->iso_qos.cig || d->cis == BT_ISO_QOS_CIS_UNSET ||
-	    d->cis != conn->iso_qos.cis)
+	if (d->cig != conn->iso_qos.ucast.cig || d->cis == BT_ISO_QOS_CIS_UNSET ||
+	    d->cis != conn->iso_qos.ucast.cis)
 		return;
 
 	d->count++;
@@ -1669,10 +1680,11 @@ static void cis_list(struct hci_conn *conn, void *data)
 	    d->count >= ARRAY_SIZE(d->pdu.cis))
 		return;
 
-	cis_add(d, &conn->iso_qos);
+	cis_add(d, &conn->iso_qos.ucast);
 }
 
-static int hci_le_create_big(struct hci_conn *conn, struct bt_iso_qos *qos)
+static int hci_le_create_big(struct hci_conn *conn,
+			     struct bt_iso_bcast_src_qos *qos)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_le_create_big cp;
@@ -1689,13 +1701,14 @@ static int hci_le_create_big(struct hci_conn *conn, struct bt_iso_qos *qos)
 	cp.bis.phy  = qos->out.phy;
 	cp.bis.packing = qos->packing;
 	cp.bis.framing = qos->framing;
-	cp.bis.encryption = 0x00;
-	memset(&cp.bis.bcode, 0, sizeof(cp.bis.bcode));
+	cp.bis.encryption = qos->encryption;
+	memcpy(&cp.bis.bcode, qos->bcode, sizeof(cp.bis.bcode));
 
 	return hci_send_cmd(hdev, HCI_OP_LE_CREATE_BIG, sizeof(cp), &cp);
 }
 
-static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
+static bool hci_le_set_cig_params(struct hci_conn *conn,
+				  struct bt_iso_ucast_qos *qos)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct iso_list_data data;
@@ -1779,7 +1792,7 @@ static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
 }
 
 struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
-			      __u8 dst_type, struct bt_iso_qos *qos)
+			      __u8 dst_type, struct bt_iso_ucast_qos *qos)
 {
 	struct hci_conn *cis;
 
@@ -1797,7 +1810,7 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
 
 	/* Check if CIS has been set and the settings matches */
 	if (cis->state == BT_BOUND &&
-	    !memcmp(&cis->iso_qos, qos, sizeof(*qos)))
+	    !memcmp(&cis->iso_qos.ucast, qos, sizeof(*qos)))
 		return cis;
 
 	/* Update LINK PHYs according to QoS preference */
@@ -1833,7 +1846,7 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
 		return ERR_PTR(-EINVAL);
 	}
 
-	cis->iso_qos = *qos;
+	cis->iso_qos.ucast = *qos;
 	cis->state = BT_BOUND;
 
 	return cis;
@@ -1843,10 +1856,19 @@ bool hci_iso_setup_path(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_le_setup_iso_path cmd;
+	struct bt_iso_io_qos *in = NULL;
+	struct bt_iso_io_qos *out = NULL;
 
 	memset(&cmd, 0, sizeof(cmd));
 
-	if (conn->iso_qos.out.sdu) {
+	if (bacmp(&conn->dst, BDADDR_ANY)) {
+		in = &conn->iso_qos.ucast.in;
+		out = &conn->iso_qos.ucast.out;
+	} else {
+		out = &conn->iso_qos.bcast.bsrc.out;
+	}
+
+	if (out->sdu) {
 		cmd.handle = cpu_to_le16(conn->handle);
 		cmd.direction = 0x00; /* Input (Host to Controller) */
 		cmd.path = 0x00; /* HCI path if enabled */
@@ -1857,7 +1879,7 @@ bool hci_iso_setup_path(struct hci_conn *conn)
 			return false;
 	}
 
-	if (conn->iso_qos.in.sdu) {
+	if (in && in->sdu) {
 		cmd.handle = cpu_to_le16(conn->handle);
 		cmd.direction = 0x01; /* Output (Controller to Host) */
 		cmd.path = 0x00; /* HCI path if enabled */
@@ -1884,7 +1906,7 @@ static int hci_create_cis_sync(struct hci_dev *hdev, void *data)
 	cmd.cis[0].acl_handle = cpu_to_le16(conn->link->handle);
 	cmd.cis[0].cis_handle = cpu_to_le16(conn->handle);
 	cmd.cp.num_cis++;
-	cig = conn->iso_qos.cig;
+	cig = conn->iso_qos.ucast.cig;
 
 	hci_dev_lock(hdev);
 
@@ -1894,7 +1916,7 @@ static int hci_create_cis_sync(struct hci_dev *hdev, void *data)
 		struct hci_cis *cis = &cmd.cis[cmd.cp.num_cis];
 
 		if (conn == data || conn->type != ISO_LINK ||
-		    conn->state == BT_CONNECTED || conn->iso_qos.cig != cig)
+		    conn->state == BT_CONNECTED || conn->iso_qos.ucast.cig != cig)
 			continue;
 
 		/* Check if all CIS(s) belonging to a CIG are ready */
@@ -1991,19 +2013,19 @@ static void hci_iso_qos_setup(struct hci_dev *hdev, struct hci_conn *conn,
 }
 
 static void hci_bind_bis(struct hci_conn *conn,
-			 struct bt_iso_qos *qos)
+			 struct bt_iso_bcast_src_qos *qos)
 {
 	/* Update LINK PHYs according to QoS preference */
 	conn->le_tx_phy = qos->out.phy;
 	conn->le_tx_phy = qos->out.phy;
-	conn->iso_qos = *qos;
+	conn->iso_qos.bcast.bsrc = *qos;
 	conn->state = BT_BOUND;
 }
 
 static int create_big_sync(struct hci_dev *hdev, void *data)
 {
 	struct hci_conn *conn = data;
-	struct bt_iso_qos *qos = &conn->iso_qos;
+	struct bt_iso_bcast_src_qos *qos = &conn->iso_qos.bcast.bsrc;
 	u16 interval, sync_interval = 0;
 	u32 flags = 0;
 	int err;
@@ -2023,7 +2045,7 @@ static int create_big_sync(struct hci_dev *hdev, void *data)
 	if (err)
 		return err;
 
-	return hci_le_create_big(conn, &conn->iso_qos);
+	return hci_le_create_big(conn, &conn->iso_qos.bcast.bsrc);
 }
 
 static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
@@ -2054,7 +2076,7 @@ static int create_pa_sync(struct hci_dev *hdev, void *data)
 }
 
 int hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst, __u8 dst_type,
-		       __u8 sid)
+		       __u8 sid,  struct bt_iso_bcast_snk_qos *qos)
 {
 	struct hci_cp_le_pa_create_sync *cp;
 
@@ -2067,15 +2089,19 @@ int hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst, __u8 dst_type,
 		return -ENOMEM;
 	}
 
+	cp->options = qos->options;
 	cp->sid = sid;
 	cp->addr_type = dst_type;
+	cp->skip = qos->skip;
+	cp->sync_timeout = qos->sync_timeout;
+	cp->sync_cte_type = qos->sync_cte_type;
 	bacpy(&cp->addr, dst);
 
 	/* Queue start pa_create_sync and scan */
 	return hci_cmd_sync_queue(hdev, create_pa_sync, cp, create_pa_complete);
 }
 
-int hci_le_big_create_sync(struct hci_dev *hdev, struct bt_iso_qos *qos,
+int hci_le_big_create_sync(struct hci_dev *hdev, struct bt_iso_bcast_snk_qos *qos,
 			   __u16 sync_handle, __u8 num_bis, __u8 bis[])
 {
 	struct _packed {
@@ -2087,13 +2113,17 @@ int hci_le_big_create_sync(struct hci_dev *hdev, struct bt_iso_qos *qos,
 	if (num_bis > sizeof(pdu.bis))
 		return -EINVAL;
 
-	err = qos_set_big(hdev, qos);
+	err = qos_set_big(hdev, &qos->big);
 	if (err)
 		return err;
 
 	memset(&pdu, 0, sizeof(pdu));
 	pdu.cp.handle = qos->big;
 	pdu.cp.sync_handle = cpu_to_le16(sync_handle);
+	pdu.cp.encryption = qos->encryption;
+	memcpy(pdu.cp.bcode, qos->bcode, sizeof(pdu.cp.bcode));
+	pdu.cp.mse = qos->mse;
+	pdu.cp.timeout = qos->timeout;
 	pdu.cp.num_bis = num_bis;
 	memcpy(pdu.bis, bis, num_bis);
 
@@ -2115,7 +2145,7 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
 }
 
 struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
-				 __u8 dst_type, struct bt_iso_qos *qos,
+				 __u8 dst_type, struct bt_iso_bcast_src_qos *qos,
 				 __u8 base_len, __u8 *base)
 {
 	struct hci_conn *conn;
@@ -2151,7 +2181,7 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 }
 
 struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
-				 __u8 dst_type, struct bt_iso_qos *qos)
+				 __u8 dst_type, struct bt_iso_ucast_qos *qos)
 {
 	struct hci_conn *le;
 	struct hci_conn *cis;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8d8547fa9032..0a7c2c759ac8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1,6 +1,7 @@
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (c) 2000-2001, 2010, Code Aurora Forum. All rights reserved.
+   Copyright 2023 NXP
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
@@ -3843,7 +3844,7 @@ static u8 hci_cc_le_set_cig_params(struct hci_dev *hdev, void *data,
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
-		if (conn->type != ISO_LINK || conn->iso_qos.cig != rp->cig_id ||
+		if (conn->type != ISO_LINK || conn->iso_qos.ucast.cig != rp->cig_id ||
 		    conn->state == BT_CONNECTED)
 			continue;
 
@@ -3877,6 +3878,7 @@ static u8 hci_cc_le_setup_iso_path(struct hci_dev *hdev, void *data,
 	struct hci_rp_le_setup_iso_path *rp = data;
 	struct hci_cp_le_setup_iso_path *cp;
 	struct hci_conn *conn;
+	bool cfm;
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
 
@@ -3900,12 +3902,14 @@ static u8 hci_cc_le_setup_iso_path(struct hci_dev *hdev, void *data,
 	/* Input (Host to Controller) */
 	case 0x00:
 		/* Only confirm connection if output only */
-		if (conn->iso_qos.out.sdu && !conn->iso_qos.in.sdu)
+		cfm = !bacmp(&conn->dst, BDADDR_ANY) ||
+			(conn->iso_qos.ucast.out.sdu && !conn->iso_qos.ucast.in.sdu);
+		if (cfm)
 			hci_connect_cfm(conn, rp->status);
 		break;
 	/* Output (Controller to Host) */
 	case 0x01:
-		/* Confirm connection since conn->iso_qos is always configured
+		/* Confirm connection since Output is always configured
 		 * last.
 		 */
 		hci_connect_cfm(conn, rp->status);
@@ -6822,15 +6826,15 @@ static void hci_le_cis_estabilished_evt(struct hci_dev *hdev, void *data,
 		memset(&interval, 0, sizeof(interval));
 
 		memcpy(&interval, ev->c_latency, sizeof(ev->c_latency));
-		conn->iso_qos.in.interval = le32_to_cpu(interval);
+		conn->iso_qos.ucast.in.interval = le32_to_cpu(interval);
 		memcpy(&interval, ev->p_latency, sizeof(ev->p_latency));
-		conn->iso_qos.out.interval = le32_to_cpu(interval);
-		conn->iso_qos.in.latency = le16_to_cpu(ev->interval);
-		conn->iso_qos.out.latency = le16_to_cpu(ev->interval);
-		conn->iso_qos.in.sdu = le16_to_cpu(ev->c_mtu);
-		conn->iso_qos.out.sdu = le16_to_cpu(ev->p_mtu);
-		conn->iso_qos.in.phy = ev->c_phy;
-		conn->iso_qos.out.phy = ev->p_phy;
+		conn->iso_qos.ucast.out.interval = le32_to_cpu(interval);
+		conn->iso_qos.ucast.in.latency = le16_to_cpu(ev->interval);
+		conn->iso_qos.ucast.out.latency = le16_to_cpu(ev->interval);
+		conn->iso_qos.ucast.in.sdu = le16_to_cpu(ev->c_mtu);
+		conn->iso_qos.ucast.out.sdu = le16_to_cpu(ev->p_mtu);
+		conn->iso_qos.ucast.in.phy = ev->c_phy;
+		conn->iso_qos.ucast.out.phy = ev->p_phy;
 	}
 
 	if (!ev->status) {
@@ -6904,8 +6908,8 @@ static void hci_le_cis_req_evt(struct hci_dev *hdev, void *data,
 		cis->handle = cis_handle;
 	}
 
-	cis->iso_qos.cig = ev->cig_id;
-	cis->iso_qos.cis = ev->cis_id;
+	cis->iso_qos.ucast.cig = ev->cig_id;
+	cis->iso_qos.ucast.cis = ev->cis_id;
 
 	if (!(flags & HCI_PROTO_DEFER)) {
 		hci_le_accept_cis(hdev, ev->cis_handle);
@@ -6992,13 +6996,13 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 			bis->handle = handle;
 		}
 
-		bis->iso_qos.big = ev->handle;
+		bis->iso_qos.bcast.bsnk.big = ev->handle;
 		memset(&interval, 0, sizeof(interval));
 		memcpy(&interval, ev->latency, sizeof(ev->latency));
-		bis->iso_qos.in.interval = le32_to_cpu(interval);
+		bis->iso_qos.bcast.bsnk.in.interval = le32_to_cpu(interval);
 		/* Convert ISO Interval (1.25 ms slots) to latency (ms) */
-		bis->iso_qos.in.latency = le16_to_cpu(ev->interval) * 125 / 100;
-		bis->iso_qos.in.sdu = le16_to_cpu(ev->max_pdu);
+		bis->iso_qos.bcast.bsnk.in.latency = le16_to_cpu(ev->interval) * 125 / 100;
+		bis->iso_qos.bcast.bsnk.in.sdu = le16_to_cpu(ev->max_pdu);
 
 		hci_connect_cfm(bis, ev->status);
 	}
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 8d136a730163..4bbac01c84c2 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -3,6 +3,7 @@
  * BlueZ - Bluetooth protocol stack for Linux
  *
  * Copyright (C) 2022 Intel Corporation
+ * Copyright 2023 NXP
  */
 
 #include <linux/module.h>
@@ -59,11 +60,55 @@ struct iso_pinfo {
 	__u16			sync_handle;
 	__u32			flags;
 	struct bt_iso_qos	qos;
+	bool			qos_user_set;
 	__u8			base_len;
 	__u8			base[BASE_MAX_LENGTH];
 	struct iso_conn		*conn;
 };
 
+#define DEFAULT_IO_QOS \
+{ \
+	.interval	= 10000u, \
+	.latency	= 10u, \
+	.sdu		= 40u, \
+	.phy		= BT_ISO_PHY_2M, \
+	.rtn		= 2u, \
+}
+
+static struct bt_iso_ucast_qos default_ucast_qos = {
+	.cig		= BT_ISO_QOS_CIG_UNSET,
+	.cis		= BT_ISO_QOS_CIS_UNSET,
+	.sca		= 0x00,
+	.packing	= 0x00,
+	.framing	= 0x00,
+	.in		= DEFAULT_IO_QOS,
+	.out		= DEFAULT_IO_QOS,
+};
+
+static struct bt_iso_bcast_snk_qos default_snk_qos = {
+	.options	= 0x00,
+	.skip		= 0x0000,
+	.sync_timeout	= 0x4000,
+	.sync_cte_type	= 0x0000,
+	.big		= BT_ISO_QOS_BIG_UNSET,
+	.encryption	= 0x00,
+	.bcode		= {0x00},
+	.mse		= 0x00,
+	.timeout	= 0x4000,
+	.in		= DEFAULT_IO_QOS,
+};
+
+static struct bt_iso_bcast_src_qos default_src_qos = {
+	.sync_interval	= 0x07,
+	.big		= BT_ISO_QOS_BIG_UNSET,
+	.bis		= BT_ISO_QOS_BIS_UNSET,
+	.packing	= 0x00,
+	.framing	= 0x00,
+	.encryption	= 0x00,
+	.bcode		= {0x00},
+	.out		= DEFAULT_IO_QOS,
+};
+
 /* ---- ISO timers ---- */
 #define ISO_CONN_TIMEOUT	(HZ * 40)
 #define ISO_DISCONN_TIMEOUT	(HZ * 2)
@@ -243,6 +288,8 @@ static inline u8 le_addr_type(u8 bdaddr_type)
 		return ADDR_LE_DEV_RANDOM;
 }
 
+static bool check_bcast_src_qos(struct bt_iso_bcast_src_qos *qos);
+
 static int iso_connect_bis(struct sock *sk)
 {
 	struct iso_conn *conn;
@@ -264,15 +311,27 @@ static int iso_connect_bis(struct sock *sk)
 		goto unlock;
 	}
 
+	/* Check QoS */
+	if (!check_bcast_src_qos(&iso_pi(sk)->qos.bcast.bsrc)) {
+		if (!iso_pi(sk)->qos_user_set) {
+			/* Set default broadcast source QoS */
+			iso_pi(sk)->qos.bcast.bsrc = default_src_qos;
+		} else {
+			/* Fail if the user provided invalid QoS */
+			err = -EINVAL;
+			goto unlock;
+		}
+	}
+
 	/* Fail if out PHYs are marked as disabled */
-	if (!iso_pi(sk)->qos.out.phy) {
+	if (!iso_pi(sk)->qos.bcast.bsrc.out.phy) {
 		err = -EINVAL;
 		goto unlock;
 	}
 
 	hcon = hci_connect_bis(hdev, &iso_pi(sk)->dst,
 			       le_addr_type(iso_pi(sk)->dst_type),
-			       &iso_pi(sk)->qos, iso_pi(sk)->base_len,
+			       &iso_pi(sk)->qos.bcast.bsrc, iso_pi(sk)->base_len,
 			       iso_pi(sk)->base);
 	if (IS_ERR(hcon)) {
 		err = PTR_ERR(hcon);
@@ -315,6 +374,8 @@ static int iso_connect_bis(struct sock *sk)
 	return err;
 }
 
+static bool check_ucast_qos(struct bt_iso_ucast_qos *qos);
+
 static int iso_connect_cis(struct sock *sk)
 {
 	struct iso_conn *conn;
@@ -336,8 +397,14 @@ static int iso_connect_cis(struct sock *sk)
 		goto unlock;
 	}
 
+	/* Check QoS */
+	if (!check_ucast_qos(&iso_pi(sk)->qos.ucast)) {
+		err = -EINVAL;
+		goto unlock;
+	}
+
 	/* Fail if either PHYs are marked as disabled */
-	if (!iso_pi(sk)->qos.in.phy && !iso_pi(sk)->qos.out.phy) {
+	if (!iso_pi(sk)->qos.ucast.in.phy && !iso_pi(sk)->qos.ucast.out.phy) {
 		err = -EINVAL;
 		goto unlock;
 	}
@@ -346,7 +413,7 @@ static int iso_connect_cis(struct sock *sk)
 	if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
 		hcon = hci_bind_cis(hdev, &iso_pi(sk)->dst,
 				    le_addr_type(iso_pi(sk)->dst_type),
-				    &iso_pi(sk)->qos);
+				    &iso_pi(sk)->qos.ucast);
 		if (IS_ERR(hcon)) {
 			err = PTR_ERR(hcon);
 			goto unlock;
@@ -354,7 +421,7 @@ static int iso_connect_cis(struct sock *sk)
 	} else {
 		hcon = hci_connect_cis(hdev, &iso_pi(sk)->dst,
 				       le_addr_type(iso_pi(sk)->dst_type),
-				       &iso_pi(sk)->qos);
+				       &iso_pi(sk)->qos.ucast);
 		if (IS_ERR(hcon)) {
 			err = PTR_ERR(hcon);
 			goto unlock;
@@ -408,16 +475,16 @@ static struct bt_iso_qos *iso_sock_get_qos(struct sock *sk)
 	return &iso_pi(sk)->qos;
 }
 
-static int iso_send_frame(struct sock *sk, struct sk_buff *skb)
+static int iso_send_frame(struct sock *sk, struct sk_buff *skb,
+			  struct bt_iso_io_qos *out)
 {
 	struct iso_conn *conn = iso_pi(sk)->conn;
-	struct bt_iso_qos *qos = iso_sock_get_qos(sk);
 	struct hci_iso_data_hdr *hdr;
 	int len = 0;
 
 	BT_DBG("sk %p len %d", sk, skb->len);
 
-	if (skb->len > qos->out.sdu)
+	if (skb->len > out->sdu)
 		return -EMSGSIZE;
 
 	len = skb->len;
@@ -661,6 +728,13 @@ static void iso_sock_init(struct sock *sk, struct sock *parent)
 		sk->sk_type = parent->sk_type;
 		bt_sk(sk)->flags = bt_sk(parent)->flags;
 		security_sk_clone(parent, sk);
+
+		if (bacmp(&iso_pi(parent)->dst, BDADDR_ANY))
+			iso_pi(sk)->qos.bcast.bsnk = default_snk_qos;
+		else
+			iso_pi(sk)->qos.ucast = default_ucast_qos;
+	} else {
+		iso_pi(sk)->qos.ucast = default_ucast_qos;
 	}
 }
 
@@ -670,25 +744,6 @@ static struct proto iso_proto = {
 	.obj_size	= sizeof(struct iso_pinfo)
 };
 
-#define DEFAULT_IO_QOS \
-{ \
-	.interval	= 10000u, \
-	.latency	= 10u, \
-	.sdu		= 40u, \
-	.phy		= BT_ISO_PHY_2M, \
-	.rtn		= 2u, \
-}
-
-static struct bt_iso_qos default_qos = {
-	.cig		= BT_ISO_QOS_CIG_UNSET,
-	.cis		= BT_ISO_QOS_CIS_UNSET,
-	.sca		= 0x00,
-	.packing	= 0x00,
-	.framing	= 0x00,
-	.in		= DEFAULT_IO_QOS,
-	.out		= DEFAULT_IO_QOS,
-};
-
 static struct sock *iso_sock_alloc(struct net *net, struct socket *sock,
 				   int proto, gfp_t prio, int kern)
 {
@@ -712,8 +767,6 @@ static struct sock *iso_sock_alloc(struct net *net, struct socket *sock,
 	/* Set address type as public as default src address is BDADDR_ANY */
 	iso_pi(sk)->src_type = BDADDR_LE_PUBLIC;
 
-	iso_pi(sk)->qos = default_qos;
-
 	bt_sock_link(&iso_sk_list, sk);
 	return sk;
 }
@@ -869,6 +922,8 @@ static int iso_sock_connect(struct socket *sock, struct sockaddr *addr,
 	return err;
 }
 
+static bool check_bcast_snk_qos(struct bt_iso_bcast_snk_qos *qos);
+
 static int iso_listen_bis(struct sock *sk)
 {
 	struct hci_dev *hdev;
@@ -893,9 +948,20 @@ static int iso_listen_bis(struct sock *sk)
 	if (!hdev)
 		return -EHOSTUNREACH;
 
+	/* Check QoS */
+	if (!check_bcast_snk_qos(&iso_pi(sk)->qos.bcast.bsnk)) {
+		if (!iso_pi(sk)->qos_user_set) {
+			/* Set default broadcast sink QoS */
+			iso_pi(sk)->qos.bcast.bsnk = default_snk_qos;
+		} else {
+			/* Fail if the user provided invalid QoS */
+			return -EINVAL;
+		}
+	}
+
 	err = hci_pa_create_sync(hdev, &iso_pi(sk)->dst,
 				 le_addr_type(iso_pi(sk)->dst_type),
-				 iso_pi(sk)->bc_sid);
+				 iso_pi(sk)->bc_sid, &iso_pi(sk)->qos.bcast.bsnk);
 
 	hci_dev_put(hdev);
 
@@ -1086,10 +1152,15 @@ static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	lock_sock(sk);
 
-	if (sk->sk_state == BT_CONNECTED)
-		err = iso_send_frame(sk, skb);
-	else
+	if (sk->sk_state == BT_CONNECTED) {
+		if (bacmp(&conn->hcon->dst, BDADDR_ANY))
+			err = iso_send_frame(sk, skb, &iso_pi(sk)->qos.ucast.out);
+		else
+			err = iso_send_frame(sk, skb,
+					     &iso_pi(sk)->qos.bcast.bsrc.out);
+	} else {
 		err = -ENOTCONN;
+	}
 
 	release_sock(sk);
 
@@ -1154,7 +1225,7 @@ static bool check_io_qos(struct bt_iso_io_qos *qos)
 	return true;
 }
 
-static bool check_qos(struct bt_iso_qos *qos)
+static bool check_ucast_qos(struct bt_iso_ucast_qos *qos)
 {
 	if (qos->sca > 0x07)
 		return false;
@@ -1174,6 +1245,55 @@ static bool check_qos(struct bt_iso_qos *qos)
 	return true;
 }
 
+static bool check_bcast_snk_qos(struct bt_iso_bcast_snk_qos *qos)
+{
+	if (qos->options > 0x07)
+		return false;
+
+	if (qos->skip > 0x01f3)
+		return false;
+
+	if (qos->sync_timeout < 0x000a || qos->sync_timeout > 0x4000)
+		return false;
+
+	if (qos->sync_cte_type > 0x1f)
+		return false;
+
+	if (qos->encryption > 0x01)
+		return false;
+
+	if (qos->mse > 0x1f)
+		return false;
+
+	if (qos->timeout < 0x000a || qos->timeout > 0x4000)
+		return false;
+
+	if (!check_io_qos(&qos->in))
+		return false;
+
+	return true;
+}
+
+static bool check_bcast_src_qos(struct bt_iso_bcast_src_qos *qos)
+{
+	if (qos->sync_interval > 0x07)
+		return false;
+
+	if (qos->packing > 0x01)
+		return false;
+
+	if (qos->framing > 0x01)
+		return false;
+
+	if (qos->encryption > 0x01)
+		return false;
+
+	if (!check_io_qos(&qos->out))
+		return false;
+
+	return true;
+}
+
 static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 			       sockptr_t optval, unsigned int optlen)
 {
@@ -1224,12 +1344,17 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (!check_qos(&qos)) {
-			err = -EINVAL;
-			break;
-		}
+		if (sk->sk_state == BT_BOUND && bacmp(&iso_pi(sk)->dst, BDADDR_ANY))
+			/* If socket is bound with broadcast address,
+			 * check broadcast sink QoS
+			 */
+			if (!check_bcast_snk_qos(&qos.bcast.bsnk)) {
+				err = -EINVAL;
+				break;
+			}
 
 		iso_pi(sk)->qos = qos;
+		iso_pi(sk)->qos_user_set = true;
 
 		break;
 
@@ -1419,7 +1544,7 @@ static bool iso_match_big(struct sock *sk, void *data)
 {
 	struct hci_evt_le_big_sync_estabilished *ev = data;
 
-	return ev->handle == iso_pi(sk)->qos.big;
+	return ev->handle == iso_pi(sk)->qos.bcast.bsnk.big;
 }
 
 static void iso_conn_ready(struct iso_conn *conn)
@@ -1550,7 +1675,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 				iso_pi(sk)->bc_num_bis = ev2->num_bis;
 
 			err = hci_le_big_create_sync(hdev,
-						     &iso_pi(sk)->qos,
+						     &iso_pi(sk)->qos.bcast.bsnk,
 						     iso_pi(sk)->sync_handle,
 						     iso_pi(sk)->bc_num_bis,
 						     iso_pi(sk)->bc_bis);
-- 
2.34.1

