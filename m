Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFB0C76195
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Mar 2023 07:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjC1H0Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Mar 2023 03:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjC1H0W (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Mar 2023 03:26:22 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2051.outbound.protection.outlook.com [40.107.6.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9552D64
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 00:26:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuwnndlufxgfYrwR7N5vzx/IhvckgIgfNm4MUdwittWlARx8FpxWbQBVln6iqgrwIkfgJNvOKQ18LPJEGjMOQjpinRJA26oxDqTnyX+uGkxioExG6SGLpK86pKFz8WzGnIxWWKZlJv0Hn13Z+VMCP8IORc0fnIWTA+4tYkDOt3RuRRMstszNuN7+IuZT60w9XJ6a/3HCroNUyYPaAWA2YB7KDvV0/08FQkm/3J26ZQb8PECEaQL/uoVMLB7dAayUWlIYGU7Y3Ab2+ob6rwc2/a2JgMAjxoiuN8Pe1pkjOBgBAOXongjZqhdHe70FMPpxhnB1jiHVzBZV2AtuaDog1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZ9HOZAEWAMW6k9O79/7TabrBmRDMOmNifd5rvmNVck=;
 b=nHd21aXZt5Q1ELfH7SfhBfW08hENKjZC+UdJLzVAcueJSqmbemzJ2BNpUuxPtDw/kM09POSonfWB/PmrvY6VD9/6oiY8brgWUajX7rqEilh3kO/qBkdPshm5inhhDrmiEoe7fapdwbp6v5cDCF5nMkwQagEtCJzCONRSXRI8Ztcvooz/5Ju9o4n5+kF/+f0rFxm07TtKFV+//TgikBd2clZQSUHYD3YRchjcvT9NtGKH2oaP8ta7KDXLTV3s2qoSc+01mvVdyFkwqPf9So/3zP9+BkbBn0BhA3AopzLPfBLg9UoLpf1gADk8Vpbfj+GK9ZOaK+9gAHfHvtw5JtoVjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZ9HOZAEWAMW6k9O79/7TabrBmRDMOmNifd5rvmNVck=;
 b=IFHgb1iWdXFK4C74zmUaLYj6kcombXZyGh/ksHO1e3Euv98oL6GhEgC0Gu4NKByRBSIwNeW5JDD2ApALRrj1rLdR4n3f0MYtxNr5kDpXH0adAVSpJrxWhRxfA5uN4RP1ipqH6snkJDsdsZI3/TUDaOIKcpNftHl76XN21OnTK4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VE1PR04MB7328.eurprd04.prod.outlook.com (2603:10a6:800:1a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 07:26:14 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%8]) with mapi id 15.20.6222.033; Tue, 28 Mar 2023
 07:26:14 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v2 1/1] Bluetooth: Split bt_iso_qos into dedicated structures
Date:   Tue, 28 Mar 2023 10:25:45 +0300
Message-Id: <20230328072545.16876-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230328072545.16876-1-iulia.tanasescu@nxp.com>
References: <20230328072545.16876-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0121.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::18) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VE1PR04MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: 6399df5a-34f1-4a0c-a956-08db2f5db664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LrXwUa1ikkp4/50TiMBJEgUzD9U5rDl9l1jF5XfnnQZpqdUiEh9pThG2O/Oywux1cRZFRKm2D6kk/J+oE+xK4wB6ekn/oxODYEanBDmgVvNIUTIPfu9tK0O6XX0afamXoZ3mCJhim6NsIYNE/dqCl6vaBoboEQYKGQI1dARx79QAuWqzRM3AY37wdLXnWj9q00dkyP1GLdI1VRTlEz8rYB93lSL/OgiqGUyCuwEiZ7R/HwNWm5VFLIC7qAtUls/Sqwq8XfctCumBdja8OIIoUw3ag0gCS0ptq8BUeQmStG+leoUPzNZbQXSqyJLfvHEfshkvFHCWlfG2pcXBUs/+yfjVUC4ZDRLMwhvHkAZBOYyXrSU3kXiPWh5A/wSBk5uab6qhJCSbBpCXGRUjOrSGbP3XAQf/wKqHtUP+DAVA/41VH+CXYF+3ZK7H89uLMqHWC10i3qdzd9YnBlGDoyQJxXLoSs66K55SAPMsXkPc1s5x3OQULiuSv78/F64HkTlbm8a2yDSkNkUE0mzUYHpVkOeLxIhrNZKuOlUxsKLWZiNhx/bJW25aavBXPW2kWkJqjkYhMPLbPTQ7PDUvbADjJfN/01p+h60tLo8qBiUlxkltBn7AcF4QbCjHu32/aEVE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199021)(6666004)(83380400001)(86362001)(316002)(186003)(6506007)(55236004)(6512007)(26005)(1076003)(2616005)(52116002)(6486002)(41300700001)(8676002)(38350700002)(38100700002)(36756003)(8936002)(6916009)(478600001)(66556008)(66946007)(4326008)(5660300002)(30864003)(66476007)(2906002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F5a0yshOpQmZA9ory8UeFgmg4xejEUZXAr1zRaiZhe/eyX95oiUfLW0yS3kA?=
 =?us-ascii?Q?RzHv463hmEaDmWo2y+IrpoVkijfpf2AyyHhHkaPK/blPGSYqI1CI+WApPfjD?=
 =?us-ascii?Q?cpnleSwtlncqNPPhFrlONjc9kCy8bRwnaToD8O6U0aKhA2zODDIEcBepcOJC?=
 =?us-ascii?Q?w4bj5lbq+QIlX0eHlllM2Rvk13zho7I7l83AsUPbrpnYFdTlSPe7UHNFVvZH?=
 =?us-ascii?Q?AY9o/mhncCYhcgsxMv0CMmzwz6swbZbyXbDnery9heYW2/nj8Uqw74DPb/2O?=
 =?us-ascii?Q?1t92FX+lNA2hjBE6LCQiYwZuyi9S+fi5iknXvTTv0kOuo9uYWgqFqFUzMR9q?=
 =?us-ascii?Q?sr7sw7Ty01FqD4X7TmHUHBe4cUYwQiM3rag6Z78FgwHctS9wPVMTU2uJqA4V?=
 =?us-ascii?Q?OKeBl5xhxBff7Wlhh86JBG64KcWsmBvUE5RVHS+2B5NwpkpDJLxPamqIMSCM?=
 =?us-ascii?Q?Dua/8L8DQXtpxifkXaxaN6nuTXN+cdvil9YVOo0J/KchW3kJ/mKeKJC5wqS2?=
 =?us-ascii?Q?n7PxBp3d1AdJcY7oGzUkeIwgrS5XqS6VhyDtP/587yRRENELBdwMyx34txI8?=
 =?us-ascii?Q?cX6p0/S9EmbEZmLlhqWVaZ38K6ktVCHzb5w8YEi4Cip+aC3dFNphKMtSvq97?=
 =?us-ascii?Q?EcG8/B9IDnmzJ5bpG82/oRqoqZTQubJsrQ2X98Ye4X6aipiZiihoWLMCqreA?=
 =?us-ascii?Q?rjnzlrUuT2pwDyeO6S43iauzCVPa1SSXLsVbdFoTp7nJSyTW0qEewb4K6sQY?=
 =?us-ascii?Q?HwfzXipvFc611fuF0YerJCKUOk4t6QJvyscJDNXnLqRroEG5GdYnmB4C7iSB?=
 =?us-ascii?Q?fjdf1hnyvcrFf1TnuyXabs5kdV/Bevu0eikuomdn8AXHYyl7NAdAUM/SnNXp?=
 =?us-ascii?Q?DakQ8cjS/vu2m0bN1ToGnfFgxtp3aC6YjsDXSH4jrQUemAhSjifLNg6AWnA+?=
 =?us-ascii?Q?lKtzBWLkn0HXX2by2rTi+MgzFGnP1XwTGf3XjDiHh65MWSuLRlWZ6o0bTH2Z?=
 =?us-ascii?Q?3MCkm3bd/pyiUtcHPbNFAaH+IYQc/9QCXIV3iru+2JOWhyL8PkCcjobPEMG4?=
 =?us-ascii?Q?lvT33Lpl9luomy5U+aNsjo1ZwZbo2hg7R7jlqPJFULurzzr4bM/6ehGyQjeT?=
 =?us-ascii?Q?r55gD6j4kJQc8mEgcvxUe6lf45qisAFu6lzgTZIgr4oieJi80RiAPT1xnmu7?=
 =?us-ascii?Q?bj+HJODoe+zmhsAexN+zEpLhLgpb+rP49v/3JSw0aWzgheJIrI2oACGAGBwb?=
 =?us-ascii?Q?aEGZMpvNEmKitb4oLO08oMsosG6L8Kt+ibv1MY8GviYKL91Icn/jmN7eyZPF?=
 =?us-ascii?Q?zRA39/IAqNx6WhumV9LYcQRO7LTO/2iF3c9at2u6uHLYdo2qfl1T1qWxG1Zj?=
 =?us-ascii?Q?ElG3JVysX9q9QOD3Qh6fFEYAX7uqsfxxZURxUXvDzjoCDsiJizaI17xUxzsK?=
 =?us-ascii?Q?N9vnukraWDigXml1AdnpjwaG4RpAFFnj+dXxiAJcJkqI4YH47V/yYjOCtbLk?=
 =?us-ascii?Q?+39AADEQdNauyj166a9tKvFZUKsflV7vvpcOSYM1sDbF+hGl59iLijEebUDQ?=
 =?us-ascii?Q?9xtSM/vr36d2vt4F75eHi+Vq44dHUdW9x60mRSJtM2Q/yUSk1OwM9SF4VwXX?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6399df5a-34f1-4a0c-a956-08db2f5db664
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 07:26:14.4424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwRV8UR3IbBr8gpYvbS8K+6VA1dYWLh27yxaNj9DLyh4K+77MRgChXQJQVHMD7yU6sjWoJhKSTY0H3p/Yf99+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7328
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

