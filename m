Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086A7C7618A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Mar 2023 14:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjCTOgy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 10:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjCTOgw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 10:36:52 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2057.outbound.protection.outlook.com [40.107.8.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3866324107
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 07:36:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3qh8Um3l3iNIWfMtCPMluUZ5qxG5hzGvGslNomskPu677u3Hue0+oGNozSfLi5ihjBEG3Wriu6x9oxwLat4jNuVZYXssVGN6pvfZh25OM+MK46zePq7Pt5v9G5GMTgelRIxKnpohEQy+aqbNYtfi3qJ8zJQokfY6kXjDqgzYbo4ek11YrLrwWLRau5CuqiNakxi/VZHfIC9+z/XWii61UlAyIg++3KbYLfUhfYZXk7EDZNF/Db40lDGZ5F5h0kogqBYEhtoODTTm1u1d/EltEC5aXGpWApkfshKXX4BIr8d7cUDjxw2iBC5aJpFzs1yGI2KR6Mpyui0ixOf3oMEGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfK6i4MX6O3EyBg5DLsN2C3UOHddrJsSSFi0qwZfGQw=;
 b=VAMdzKo7F+iCC56clQ5iEJ0clAuDyFyVXKUMc4uVNO4YjLeXL4qR3oyNwrTZEtaQ4AmzZ+/GgWP64IENydwnzxVU9eK1ZUjiCvCMMM3t308HuMY6u8VE5HpKWVCbqyuXLDEdknK/6lLzOfkSdpei5e1RqX2K23vnTM9JyDmrCqNkRvHXl2fPROFEzyFExc+PHw6/foo/c5ZQS6deTtZq4sx2FpwyohZQ+jQW5Z+yDbooTFhpui4nbEXS5MdSjTNeELSZFUZfyOCvdQ4RaRovxwupqUfOOxjabJxDWrp5DMBf4ZIyvwgVpdKxS4x5M6Ta++vpkfBS+D2egesLDvLLfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfK6i4MX6O3EyBg5DLsN2C3UOHddrJsSSFi0qwZfGQw=;
 b=jOjMfv8CvaXliFPfyNTtoKuISFeXyzRMcR1fbRCxOKUPbnkn9axFnAhw+MSzcwdS6zO21UEak4NQFen9S6NpdJBSmSOs5HxKtxVX7wYItwipqOSru8LWqphLl15k8k4kwvCOqnErYjlG8j8rCU/bYev8aIqqtQIy/DA9N0O4TGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB8PR04MB6954.eurprd04.prod.outlook.com (2603:10a6:10:11c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 14:36:43 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98%8]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 14:36:43 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: Split bt_iso_qos into dedicated structures
Date:   Mon, 20 Mar 2023 16:36:08 +0200
Message-Id: <20230320143608.25399-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320143608.25399-1-iulia.tanasescu@nxp.com>
References: <20230320143608.25399-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0065.eurprd04.prod.outlook.com
 (2603:10a6:208:1::42) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB8PR04MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: 504e2e8c-93b0-4a9e-f672-08db295086a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zHY582pkoD3SFf1eSu42QAN3W8HHVGeEKbPOWbZDUWvIKN7usPc1x+JLvna6U1/eLrNHOvBYw3h/Smho/J73nstYmacRrAv+wsOltNebmVPhTVe7vHuqlTLVbqg4TFX8/yhcMiUCSO+HjrDsaZYJsObZn/wYo9wf8XTOCsTf+9XaPTWE1lDe22O9ewltFz0ZI9Ac2gNeVC3SRNjc33fH4ust6Gbeiy7TAwCMzDQF/jBiMjcv9vGN2TS7iZwiaE+7JbOcIp4MWG0EHRB4vDBZcJ6wNfDG6j0NRXcXc8BB5ZgCs6odpnkCTgEPvR8EbvDzUp1RERxVNdbUWFTWDp/cvcpCpoq8ocmC95NySfJCSAE1+NJmnXXE22gLzMOmzzLxZ+zJx/65g5HUHmOwcR+H9c9EbEwlck2paoC47rZXvRZ+Xkyd1+p2iPf2rljydnywpjnLrRYAZdgqVp3XzBs8W4vdTG1pwAt3RhNo39mAkd2GaFFsRJLZ2+B/Fq5lBbhM51IWpw4a+6VZQMwH/jbWrdXq85xIhoJJ9YpCQ4STLO3NQft12dfylJ9oH2fsqwLJ4uYc1N+FD67SxxaaD/199MWhm9e6StiMcblTcYAIr2mDARGiHNmYBAL7S4JPxiNOchOvG5BmiQQ8F69gKBrBz4P8R2hB4ZdPdXByp1mH5PStCFO3fyLEDWpeu4s4acD3ZnThpngWSRLEpA4wjQ/BXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199018)(2616005)(41300700001)(52116002)(186003)(6486002)(4326008)(6666004)(83380400001)(478600001)(316002)(66476007)(66556008)(6916009)(66946007)(8676002)(55236004)(6506007)(1076003)(6512007)(26005)(44832011)(8936002)(30864003)(5660300002)(38350700002)(38100700002)(2906002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dxiwkv+urvPu+sXvq0Kx1zhnyPGEHeijJxscioHOt39o6pMUG1jt01w139YO?=
 =?us-ascii?Q?G8h4FAgCfy9G+wgL2qj/4MvqBsKptbEoHNS3/84K0E9JwPyhjMTP+ipFZCos?=
 =?us-ascii?Q?EivbQlOKQPWs861XiKFTxr6nYsHe1yuIdelQInULwFbrzv8bXPxlA6awiepu?=
 =?us-ascii?Q?NbZEuAvLTK4tSotWwmvXhNrwMYP2eFV6wHsTDUQ7VO1qKcpTGwWXKrjPblzE?=
 =?us-ascii?Q?wVHdm1q2+9SMQLPOiIOGIDWGxQ488Onsf9x2kstsnHEpJyipLcnia1UFHhz1?=
 =?us-ascii?Q?UUFxL1bVRpcAIMApoO/Pq/rhm5XXOKQOdDs/JXecccymhBTxa0bQ4LZxfF1S?=
 =?us-ascii?Q?Ymx1Zz1Num4Axfp6v3O2CBQ4ZA4Afz/s7YtUyH/0E8ntQ2nI8w4+T4Mz0Fw8?=
 =?us-ascii?Q?M1X74ZLt6vYvrGWTI9cNpeYR29nu2dtrEweaEIS7HuVf0LC1DFHbyCP8u341?=
 =?us-ascii?Q?CaIsNt3WEt8VBj2SUZlutBWy8R+5wHhwf/sbFAUOsm+Izrxmdo859WwC9sUa?=
 =?us-ascii?Q?EhMXD1VuAD2GCGqgq2EvROI8pFB1Emc8N6dHEsW298+SMKSoV/2iKS6im8nD?=
 =?us-ascii?Q?qTwGJ+ulwjnxGdncGG+siyo97doTbpJ7EqyiAbiMCFa3mGRI3tFB4Yfm8ksT?=
 =?us-ascii?Q?ks+8u0hXASPnzBxZuJ4urayE6BoCQ5NiUbQRzm5YboawNJmcZNoMba2hhfyu?=
 =?us-ascii?Q?k5Oqp1ODyrJIXQSbK11WdYBm2GnbJt+/GxSBoVnb+Y6eosC89C06Y37Kgu7v?=
 =?us-ascii?Q?DBEpwwdGwaUkv345f1qnXzpTsiQB4iHpETweL9Ppg5sDg/s7l6MnIgPUWyId?=
 =?us-ascii?Q?G+GIeeaeGMmO/o0nkssPiBzBqAFvljomqkDPzRd4irxhMS+Y0WiEEbwCGQ9N?=
 =?us-ascii?Q?ZH1FPY5yYLzsFoVYn18p96k7HJqtAkI0gz/tftVtpDCLp4VI5GKfZ+lW0scZ?=
 =?us-ascii?Q?JqjpFb2Niv+leAuYDUVzWPC1wZcIzNJgWAh19loj453XqQT4ZkFyC5MdQlHV?=
 =?us-ascii?Q?cGIubt+H8eqTKeJFA/0YVCaUHbHDc1ynVhMaJoGcDvUsnZS4HK1bjZbmOLdo?=
 =?us-ascii?Q?b9I3R5EceSsVxiZEPohkXlSYwmCWpeIILyq/OJnoFfYnQnFCwJUSBY0c2V52?=
 =?us-ascii?Q?77+lqmkKweYqW+NIGYTYo2H75ulZC3CS/3+frgogqYmFPKA7aWqgGPSU5sPo?=
 =?us-ascii?Q?yutZnJh/QOlqcEvvYz869BrpZqXqdqm2YKhWH3p7PpMaQT9N3fXU7iOjVEfZ?=
 =?us-ascii?Q?YjqeTdKPaJd9QyuVGffd2Z9FPxfA4GS1GftsEMUMp9ChhMs5PZP9zOi0Rgmx?=
 =?us-ascii?Q?eO0t0eCBSdKqIUogq6S+30LRGgeet6bXp6C/yGPJZzEvX7BMbyJDJA3LNqXc?=
 =?us-ascii?Q?0EJcq0679qgzdRP+qSVFSj24xN58G0tHW3Vu4EOMDgRc4uXncoF6ynxJ01lv?=
 =?us-ascii?Q?8AnOaRoZVBXef5Xr6mlmBt+IjhxaF1tlXKwoVZlWYTlvqc/n8B7ITEzOTq0C?=
 =?us-ascii?Q?Oryufh/FWZDIFaTEuOX94aOjRL7Rtej0Y9qP3LplgJJqV+Psa2MX3mr6DQdz?=
 =?us-ascii?Q?FVOmd6HtnDJDf4m9FxHNlYMM8uvgopC5RoE8euOPtS9PvsiwJvDtJT/zT+3U?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 504e2e8c-93b0-4a9e-f672-08db295086a8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 14:36:43.8274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jm34UUMzjuCl+/zSMx18gBq4eCHTFbfSG8cnuYeydWYN88mhC+jeFoBqE9X9Ep4rSocBaGX2x5cofU85bnPCfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6954
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Split bt_iso_qos into dedicated unicast and broadcast
structures and add missing broadcast parameters

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 include/net/bluetooth/bluetooth.h |  47 ++++--
 include/net/bluetooth/hci_core.h  |  21 +--
 net/bluetooth/hci_conn.c          | 104 ++++++++-----
 net/bluetooth/hci_event.c         |  38 +++--
 net/bluetooth/iso.c               | 247 ++++++++++++++++++++++++++----
 5 files changed, 346 insertions(+), 111 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index bcc5a4cd2c17..24d303783ea4 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -1,6 +1,7 @@
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (C) 2000-2001 Qualcomm Incorporated
+   Copyright 2023 NXP
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
@@ -155,11 +156,14 @@ struct bt_voice {
 
 #define BT_SCM_PKT_STATUS	0x03
 
-#define BT_ISO_QOS		17
+#define BT_ISO_UNICAST_QOS	17
 
 #define BT_ISO_QOS_CIG_UNSET	0xff
 #define BT_ISO_QOS_CIS_UNSET	0xff
 
+#define BT_ISO_BCAST_SINK_QOS	18
+#define BT_ISO_BCAST_SOURCE_QOS	19
+
 #define BT_ISO_QOS_BIG_UNSET	0xff
 #define BT_ISO_QOS_BIS_UNSET	0xff
 
@@ -171,25 +175,40 @@ struct bt_iso_io_qos {
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
+struct bt_iso_unicast_qos {
+	__u8  cig;
+	__u8  cis;
+	__u8  sca;
 	__u8  packing;
 	__u8  framing;
 	struct bt_iso_io_qos in;
 	struct bt_iso_io_qos out;
 };
 
+struct bt_iso_bcast_sink_qos {
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
+struct bt_iso_bcast_source_qos {
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
 #define BT_ISO_PHY_1M		0x01
 #define BT_ISO_PHY_2M		0x02
 #define BT_ISO_PHY_CODED	0x04
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 53d3328c2b8b..60b6acb1be2b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1,6 +1,7 @@
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (c) 2000-2001, 2010, Code Aurora Forum. All rights reserved.
+   Copyright 2023 NXP
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
@@ -730,7 +731,9 @@ struct hci_conn {
 	__s8		rssi;
 	__s8		tx_power;
 	__s8		max_tx_power;
-	struct bt_iso_qos iso_qos;
+	struct bt_iso_unicast_qos iso_unicast_qos;
+	struct bt_iso_bcast_sink_qos iso_sink_qos;
+	struct bt_iso_bcast_source_qos iso_source_qos;
 	unsigned long	flags;
 
 	enum conn_reasons conn_reason;
@@ -1090,7 +1093,7 @@ static inline struct hci_conn *hci_conn_hash_lookup_bis(struct hci_dev *hdev,
 		if (bacmp(&c->dst, ba) || c->type != ISO_LINK)
 			continue;
 
-		if (c->iso_qos.big == big && c->iso_qos.bis == bis) {
+		if (c->iso_source_qos.big == big && c->iso_source_qos.bis == bis) {
 			rcu_read_unlock();
 			return c;
 		}
@@ -1199,7 +1202,7 @@ static inline struct hci_conn *hci_conn_hash_lookup_cig(struct hci_dev *hdev,
 		if (c->type != ISO_LINK)
 			continue;
 
-		if (handle == c->iso_qos.cig) {
+		if (handle == c->iso_unicast_qos.cig) {
 			rcu_read_unlock();
 			return c;
 		}
@@ -1222,7 +1225,7 @@ static inline struct hci_conn *hci_conn_hash_lookup_big(struct hci_dev *hdev,
 		if (bacmp(&c->dst, BDADDR_ANY) || c->type != ISO_LINK)
 			continue;
 
-		if (handle == c->iso_qos.big) {
+		if (handle == c->iso_source_qos.big) {
 			rcu_read_unlock();
 			return c;
 		}
@@ -1324,15 +1327,15 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 				 __u16 setting, struct bt_codec *codec);
 struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
-			      __u8 dst_type, struct bt_iso_qos *qos);
+			      __u8 dst_type, struct bt_iso_unicast_qos *qos);
 struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
-				 __u8 dst_type, struct bt_iso_qos *qos);
+				 __u8 dst_type, struct bt_iso_unicast_qos *qos);
 struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
-				 __u8 dst_type, struct bt_iso_qos *qos,
+				 __u8 dst_type, struct bt_iso_bcast_source_qos *qos,
 				 __u8 data_len, __u8 *data);
 int hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst, __u8 dst_type,
-		       __u8 sid);
-int hci_le_big_create_sync(struct hci_dev *hdev, struct bt_iso_qos *qos,
+		       __u8 sid, struct bt_iso_bcast_sink_qos *qos);
+int hci_le_big_create_sync(struct hci_dev *hdev, struct bt_iso_bcast_sink_qos *qos,
 			   __u16 sync_handle, __u8 num_bis, __u8 bis[]);
 int hci_conn_check_link_mode(struct hci_conn *conn);
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 17b946f9ba31..77f0c89a9089 100644
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
+		check_big = conn->iso_source_qos.big;
+		check_bis = conn->iso_source_qos.bis;
+	} else {
+		check_big = conn->iso_sink_qos.big;
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
+		hci_le_terminate_big(hdev, conn->iso_source_qos.big,
+				     conn->iso_source_qos.bis);
 	} else {
-		hci_le_big_terminate(hdev, conn->iso_qos.big,
+		hci_le_big_terminate(hdev, conn->iso_sink_qos.big,
 				     conn->sync_handle);
 	}
 }
@@ -940,7 +950,7 @@ static void cis_cleanup(struct hci_conn *conn)
 	struct iso_list_data d;
 
 	memset(&d, 0, sizeof(d));
-	d.cig = conn->iso_qos.cig;
+	d.cig = conn->iso_unicast_qos.cig;
 
 	/* Check if ISO connection is a CIS and remove CIG if there are
 	 * no other connections using it.
@@ -949,7 +959,7 @@ static void cis_cleanup(struct hci_conn *conn)
 	if (d.count)
 		return;
 
-	hci_le_remove_cig(hdev, conn->iso_qos.cig);
+	hci_le_remove_cig(hdev, conn->iso_unicast_qos.cig);
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
+		       struct bt_iso_bcast_source_qos *qos)
 {
 	struct iso_list_data data;
 
@@ -1455,7 +1466,7 @@ static int qos_set_bis(struct hci_dev *hdev, struct bt_iso_qos *qos)
 
 /* This function requires the caller holds hdev->lock */
 static struct hci_conn *hci_add_bis(struct hci_dev *hdev, bdaddr_t *dst,
-				    struct bt_iso_qos *qos)
+				    struct bt_iso_bcast_source_qos *qos)
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
+static void cis_add(struct iso_list_data *d, struct bt_iso_unicast_qos *qos)
 {
 	struct hci_cis_params *cis = &d->pdu.cis[d->pdu.cp.num_cis];
 
@@ -1659,8 +1670,8 @@ static void cis_list(struct hci_conn *conn, void *data)
 	if (!bacmp(&conn->dst, BDADDR_ANY))
 		return;
 
-	if (d->cig != conn->iso_qos.cig || d->cis == BT_ISO_QOS_CIS_UNSET ||
-	    d->cis != conn->iso_qos.cis)
+	if (d->cig != conn->iso_unicast_qos.cig || d->cis == BT_ISO_QOS_CIS_UNSET ||
+	    d->cis != conn->iso_unicast_qos.cis)
 		return;
 
 	d->count++;
@@ -1669,10 +1680,11 @@ static void cis_list(struct hci_conn *conn, void *data)
 	    d->count >= ARRAY_SIZE(d->pdu.cis))
 		return;
 
-	cis_add(d, &conn->iso_qos);
+	cis_add(d, &conn->iso_unicast_qos);
 }
 
-static int hci_le_create_big(struct hci_conn *conn, struct bt_iso_qos *qos)
+static int hci_le_create_big(struct hci_conn *conn,
+			     struct bt_iso_bcast_source_qos *qos)
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
+				  struct bt_iso_unicast_qos *qos)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct iso_list_data data;
@@ -1779,7 +1792,7 @@ static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
 }
 
 struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
-			      __u8 dst_type, struct bt_iso_qos *qos)
+			      __u8 dst_type, struct bt_iso_unicast_qos *qos)
 {
 	struct hci_conn *cis;
 
@@ -1797,7 +1810,7 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
 
 	/* Check if CIS has been set and the settings matches */
 	if (cis->state == BT_BOUND &&
-	    !memcmp(&cis->iso_qos, qos, sizeof(*qos)))
+	    !memcmp(&cis->iso_unicast_qos, qos, sizeof(*qos)))
 		return cis;
 
 	/* Update LINK PHYs according to QoS preference */
@@ -1833,7 +1846,7 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
 		return ERR_PTR(-EINVAL);
 	}
 
-	cis->iso_qos = *qos;
+	cis->iso_unicast_qos = *qos;
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
+		in = &conn->iso_unicast_qos.in;
+		out = &conn->iso_unicast_qos.out;
+	} else {
+		out = &conn->iso_source_qos.out;
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
+	cig = conn->iso_unicast_qos.cig;
 
 	hci_dev_lock(hdev);
 
@@ -1894,7 +1916,7 @@ static int hci_create_cis_sync(struct hci_dev *hdev, void *data)
 		struct hci_cis *cis = &cmd.cis[cmd.cp.num_cis];
 
 		if (conn == data || conn->type != ISO_LINK ||
-		    conn->state == BT_CONNECTED || conn->iso_qos.cig != cig)
+		    conn->state == BT_CONNECTED || conn->iso_unicast_qos.cig != cig)
 			continue;
 
 		/* Check if all CIS(s) belonging to a CIG are ready */
@@ -1991,19 +2013,19 @@ static void hci_iso_qos_setup(struct hci_dev *hdev, struct hci_conn *conn,
 }
 
 static void hci_bind_bis(struct hci_conn *conn,
-			 struct bt_iso_qos *qos)
+			 struct bt_iso_bcast_source_qos *qos)
 {
 	/* Update LINK PHYs according to QoS preference */
 	conn->le_tx_phy = qos->out.phy;
 	conn->le_tx_phy = qos->out.phy;
-	conn->iso_qos = *qos;
+	conn->iso_source_qos = *qos;
 	conn->state = BT_BOUND;
 }
 
 static int create_big_sync(struct hci_dev *hdev, void *data)
 {
 	struct hci_conn *conn = data;
-	struct bt_iso_qos *qos = &conn->iso_qos;
+	struct bt_iso_bcast_source_qos *qos = &conn->iso_source_qos;
 	u16 interval, sync_interval = 0;
 	u32 flags = 0;
 	int err;
@@ -2023,7 +2045,7 @@ static int create_big_sync(struct hci_dev *hdev, void *data)
 	if (err)
 		return err;
 
-	return hci_le_create_big(conn, &conn->iso_qos);
+	return hci_le_create_big(conn, &conn->iso_source_qos);
 }
 
 static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
@@ -2054,7 +2076,7 @@ static int create_pa_sync(struct hci_dev *hdev, void *data)
 }
 
 int hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst, __u8 dst_type,
-		       __u8 sid)
+		       __u8 sid,  struct bt_iso_bcast_sink_qos *qos)
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
+int hci_le_big_create_sync(struct hci_dev *hdev, struct bt_iso_bcast_sink_qos *qos,
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
+				 __u8 dst_type, struct bt_iso_bcast_source_qos *qos,
 				 __u8 base_len, __u8 *base)
 {
 	struct hci_conn *conn;
@@ -2151,7 +2181,7 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 }
 
 struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
-				 __u8 dst_type, struct bt_iso_qos *qos)
+				 __u8 dst_type, struct bt_iso_unicast_qos *qos)
 {
 	struct hci_conn *le;
 	struct hci_conn *cis;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8d8547fa9032..8428a3f75ef7 100644
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
+		if (conn->type != ISO_LINK || conn->iso_unicast_qos.cig != rp->cig_id ||
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
+			(conn->iso_unicast_qos.out.sdu && !conn->iso_unicast_qos.in.sdu);
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
+		conn->iso_unicast_qos.in.interval = le32_to_cpu(interval);
 		memcpy(&interval, ev->p_latency, sizeof(ev->p_latency));
-		conn->iso_qos.out.interval = le32_to_cpu(interval);
-		conn->iso_qos.in.latency = le16_to_cpu(ev->interval);
-		conn->iso_qos.out.latency = le16_to_cpu(ev->interval);
-		conn->iso_qos.in.sdu = le16_to_cpu(ev->c_mtu);
-		conn->iso_qos.out.sdu = le16_to_cpu(ev->p_mtu);
-		conn->iso_qos.in.phy = ev->c_phy;
-		conn->iso_qos.out.phy = ev->p_phy;
+		conn->iso_unicast_qos.out.interval = le32_to_cpu(interval);
+		conn->iso_unicast_qos.in.latency = le16_to_cpu(ev->interval);
+		conn->iso_unicast_qos.out.latency = le16_to_cpu(ev->interval);
+		conn->iso_unicast_qos.in.sdu = le16_to_cpu(ev->c_mtu);
+		conn->iso_unicast_qos.out.sdu = le16_to_cpu(ev->p_mtu);
+		conn->iso_unicast_qos.in.phy = ev->c_phy;
+		conn->iso_unicast_qos.out.phy = ev->p_phy;
 	}
 
 	if (!ev->status) {
@@ -6904,8 +6908,8 @@ static void hci_le_cis_req_evt(struct hci_dev *hdev, void *data,
 		cis->handle = cis_handle;
 	}
 
-	cis->iso_qos.cig = ev->cig_id;
-	cis->iso_qos.cis = ev->cis_id;
+	cis->iso_unicast_qos.cig = ev->cig_id;
+	cis->iso_unicast_qos.cis = ev->cis_id;
 
 	if (!(flags & HCI_PROTO_DEFER)) {
 		hci_le_accept_cis(hdev, ev->cis_handle);
@@ -6992,13 +6996,13 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 			bis->handle = handle;
 		}
 
-		bis->iso_qos.big = ev->handle;
+		bis->iso_sink_qos.big = ev->handle;
 		memset(&interval, 0, sizeof(interval));
 		memcpy(&interval, ev->latency, sizeof(ev->latency));
-		bis->iso_qos.in.interval = le32_to_cpu(interval);
+		bis->iso_sink_qos.in.interval = le32_to_cpu(interval);
 		/* Convert ISO Interval (1.25 ms slots) to latency (ms) */
-		bis->iso_qos.in.latency = le16_to_cpu(ev->interval) * 125 / 100;
-		bis->iso_qos.in.sdu = le16_to_cpu(ev->max_pdu);
+		bis->iso_sink_qos.in.latency = le16_to_cpu(ev->interval) * 125 / 100;
+		bis->iso_sink_qos.in.sdu = le16_to_cpu(ev->max_pdu);
 
 		hci_connect_cfm(bis, ev->status);
 	}
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 8d136a730163..e660e1c5ea11 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -3,6 +3,7 @@
  * BlueZ - Bluetooth protocol stack for Linux
  *
  * Copyright (C) 2022 Intel Corporation
+ * Copyright 2023 NXP
  */
 
 #include <linux/module.h>
@@ -58,7 +59,9 @@ struct iso_pinfo {
 	__u8			bc_bis[ISO_MAX_NUM_BIS];
 	__u16			sync_handle;
 	__u32			flags;
-	struct bt_iso_qos	qos;
+	struct bt_iso_unicast_qos	unicast_qos;
+	struct bt_iso_bcast_sink_qos	sink_qos;
+	struct bt_iso_bcast_source_qos	source_qos;
 	__u8			base_len;
 	__u8			base[BASE_MAX_LENGTH];
 	struct iso_conn		*conn;
@@ -265,14 +268,14 @@ static int iso_connect_bis(struct sock *sk)
 	}
 
 	/* Fail if out PHYs are marked as disabled */
-	if (!iso_pi(sk)->qos.out.phy) {
+	if (!iso_pi(sk)->source_qos.out.phy) {
 		err = -EINVAL;
 		goto unlock;
 	}
 
 	hcon = hci_connect_bis(hdev, &iso_pi(sk)->dst,
 			       le_addr_type(iso_pi(sk)->dst_type),
-			       &iso_pi(sk)->qos, iso_pi(sk)->base_len,
+			       &iso_pi(sk)->source_qos, iso_pi(sk)->base_len,
 			       iso_pi(sk)->base);
 	if (IS_ERR(hcon)) {
 		err = PTR_ERR(hcon);
@@ -337,7 +340,7 @@ static int iso_connect_cis(struct sock *sk)
 	}
 
 	/* Fail if either PHYs are marked as disabled */
-	if (!iso_pi(sk)->qos.in.phy && !iso_pi(sk)->qos.out.phy) {
+	if (!iso_pi(sk)->unicast_qos.in.phy && !iso_pi(sk)->unicast_qos.out.phy) {
 		err = -EINVAL;
 		goto unlock;
 	}
@@ -346,7 +349,7 @@ static int iso_connect_cis(struct sock *sk)
 	if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
 		hcon = hci_bind_cis(hdev, &iso_pi(sk)->dst,
 				    le_addr_type(iso_pi(sk)->dst_type),
-				    &iso_pi(sk)->qos);
+				    &iso_pi(sk)->unicast_qos);
 		if (IS_ERR(hcon)) {
 			err = PTR_ERR(hcon);
 			goto unlock;
@@ -354,7 +357,7 @@ static int iso_connect_cis(struct sock *sk)
 	} else {
 		hcon = hci_connect_cis(hdev, &iso_pi(sk)->dst,
 				       le_addr_type(iso_pi(sk)->dst_type),
-				       &iso_pi(sk)->qos);
+				       &iso_pi(sk)->unicast_qos);
 		if (IS_ERR(hcon)) {
 			err = PTR_ERR(hcon);
 			goto unlock;
@@ -400,24 +403,40 @@ static int iso_connect_cis(struct sock *sk)
 	return err;
 }
 
-static struct bt_iso_qos *iso_sock_get_qos(struct sock *sk)
+static struct bt_iso_unicast_qos *iso_sock_get_unicast_qos(struct sock *sk)
 {
 	if (sk->sk_state == BT_CONNECTED || sk->sk_state == BT_CONNECT2)
-		return &iso_pi(sk)->conn->hcon->iso_qos;
+		return &iso_pi(sk)->conn->hcon->iso_unicast_qos;
 
-	return &iso_pi(sk)->qos;
+	return &iso_pi(sk)->unicast_qos;
 }
 
-static int iso_send_frame(struct sock *sk, struct sk_buff *skb)
+static struct bt_iso_bcast_sink_qos *iso_sock_get_bcast_sink_qos(struct sock *sk)
+{
+	if (sk->sk_state == BT_CONNECTED || sk->sk_state == BT_CONNECT2)
+		return &iso_pi(sk)->conn->hcon->iso_sink_qos;
+
+	return &iso_pi(sk)->sink_qos;
+}
+
+static struct bt_iso_bcast_source_qos *iso_sock_get_bcast_source_qos(struct sock *sk)
+{
+	if (sk->sk_state == BT_CONNECTED || sk->sk_state == BT_CONNECT2)
+		return &iso_pi(sk)->conn->hcon->iso_source_qos;
+
+	return &iso_pi(sk)->source_qos;
+}
+
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
@@ -679,7 +698,7 @@ static struct proto iso_proto = {
 	.rtn		= 2u, \
 }
 
-static struct bt_iso_qos default_qos = {
+static struct bt_iso_unicast_qos default_unicast_qos = {
 	.cig		= BT_ISO_QOS_CIG_UNSET,
 	.cis		= BT_ISO_QOS_CIS_UNSET,
 	.sca		= 0x00,
@@ -689,6 +708,30 @@ static struct bt_iso_qos default_qos = {
 	.out		= DEFAULT_IO_QOS,
 };
 
+static struct bt_iso_bcast_sink_qos default_sink_qos = {
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
+static struct bt_iso_bcast_source_qos default_source_qos = {
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
 static struct sock *iso_sock_alloc(struct net *net, struct socket *sock,
 				   int proto, gfp_t prio, int kern)
 {
@@ -712,7 +755,9 @@ static struct sock *iso_sock_alloc(struct net *net, struct socket *sock,
 	/* Set address type as public as default src address is BDADDR_ANY */
 	iso_pi(sk)->src_type = BDADDR_LE_PUBLIC;
 
-	iso_pi(sk)->qos = default_qos;
+	iso_pi(sk)->unicast_qos = default_unicast_qos;
+	iso_pi(sk)->sink_qos = default_sink_qos;
+	iso_pi(sk)->source_qos = default_source_qos;
 
 	bt_sock_link(&iso_sk_list, sk);
 	return sk;
@@ -895,7 +940,7 @@ static int iso_listen_bis(struct sock *sk)
 
 	err = hci_pa_create_sync(hdev, &iso_pi(sk)->dst,
 				 le_addr_type(iso_pi(sk)->dst_type),
-				 iso_pi(sk)->bc_sid);
+				 iso_pi(sk)->bc_sid, &iso_pi(sk)->sink_qos);
 
 	hci_dev_put(hdev);
 
@@ -1086,10 +1131,15 @@ static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	lock_sock(sk);
 
-	if (sk->sk_state == BT_CONNECTED)
-		err = iso_send_frame(sk, skb);
-	else
+	if (sk->sk_state == BT_CONNECTED) {
+		if (bacmp(&conn->hcon->dst, BDADDR_ANY))
+			err = iso_send_frame(sk, skb, &iso_sock_get_unicast_qos(sk)->out);
+		else
+			err = iso_send_frame(sk, skb,
+					     &iso_sock_get_bcast_source_qos(sk)->out);
+	} else {
 		err = -ENOTCONN;
+	}
 
 	release_sock(sk);
 
@@ -1154,7 +1204,7 @@ static bool check_io_qos(struct bt_iso_io_qos *qos)
 	return true;
 }
 
-static bool check_qos(struct bt_iso_qos *qos)
+static bool check_unicast_qos(struct bt_iso_unicast_qos *qos)
 {
 	if (qos->sca > 0x07)
 		return false;
@@ -1174,12 +1224,60 @@ static bool check_qos(struct bt_iso_qos *qos)
 	return true;
 }
 
+static bool check_bcast_sink_qos(struct bt_iso_bcast_sink_qos *qos)
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
+static bool check_bcast_source_qos(struct bt_iso_bcast_source_qos *qos)
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
 	struct sock *sk = sock->sk;
 	int len, err = 0;
-	struct bt_iso_qos qos;
 	u32 opt;
 
 	BT_DBG("sk %p", sk);
@@ -1204,32 +1302,96 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 			clear_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
 		break;
 
-	case BT_ISO_QOS:
+	case BT_ISO_UNICAST_QOS:
+		struct bt_iso_unicast_qos unicast_qos;
+
+		if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND &&
+		    sk->sk_state != BT_CONNECT2) {
+			err = -EINVAL;
+			break;
+		}
+
+		len = min_t(unsigned int, sizeof(unicast_qos), optlen);
+		if (len != sizeof(unicast_qos)) {
+			err = -EINVAL;
+			break;
+		}
+
+		memset(&unicast_qos, 0, sizeof(unicast_qos));
+
+		if (copy_from_sockptr(&unicast_qos, optval, len)) {
+			err = -EFAULT;
+			break;
+		}
+
+		if (!check_unicast_qos(&unicast_qos)) {
+			err = -EINVAL;
+			break;
+		}
+
+		iso_pi(sk)->unicast_qos = unicast_qos;
+
+		break;
+
+	case BT_ISO_BCAST_SINK_QOS:
+		struct bt_iso_bcast_sink_qos sink_qos;
+
 		if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND &&
 		    sk->sk_state != BT_CONNECT2) {
 			err = -EINVAL;
 			break;
 		}
 
-		len = min_t(unsigned int, sizeof(qos), optlen);
-		if (len != sizeof(qos)) {
+		len = min_t(unsigned int, sizeof(sink_qos), optlen);
+		if (len != sizeof(sink_qos)) {
 			err = -EINVAL;
 			break;
 		}
 
-		memset(&qos, 0, sizeof(qos));
+		memset(&sink_qos, 0, sizeof(sink_qos));
 
-		if (copy_from_sockptr(&qos, optval, len)) {
+		if (copy_from_sockptr(&sink_qos, optval, len)) {
 			err = -EFAULT;
 			break;
 		}
 
-		if (!check_qos(&qos)) {
+		if (!check_bcast_sink_qos(&sink_qos)) {
 			err = -EINVAL;
 			break;
 		}
 
-		iso_pi(sk)->qos = qos;
+		iso_pi(sk)->sink_qos = sink_qos;
+
+		break;
+
+	case BT_ISO_BCAST_SOURCE_QOS:
+		struct bt_iso_bcast_source_qos source_qos;
+
+		if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND &&
+		    sk->sk_state != BT_CONNECT2) {
+			err = -EINVAL;
+			break;
+		}
+
+		len = min_t(unsigned int, sizeof(source_qos), optlen);
+		if (len != sizeof(source_qos)) {
+			err = -EINVAL;
+			break;
+		}
+
+		memset(&source_qos, 0, sizeof(source_qos));
+
+		if (copy_from_sockptr(&source_qos, optval, len)) {
+			err = -EFAULT;
+			break;
+		}
+
+		if (!check_bcast_source_qos(&source_qos)) {
+			err = -EINVAL;
+			break;
+		}
+
+		iso_pi(sk)->source_qos = source_qos;
 
 		break;
 
@@ -1270,7 +1432,6 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 	int len, err = 0;
-	struct bt_iso_qos *qos;
 	u8 base_len;
 	u8 *base;
 
@@ -1294,11 +1455,29 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 
 		break;
 
-	case BT_ISO_QOS:
-		qos = iso_sock_get_qos(sk);
+	case BT_ISO_UNICAST_QOS:
+		struct bt_iso_unicast_qos *unicast_qos = iso_sock_get_unicast_qos(sk);
+
+		len = min_t(unsigned int, len, sizeof(*unicast_qos));
+		if (copy_to_user(optval, unicast_qos, len))
+			err = -EFAULT;
+
+		break;
+
+	case BT_ISO_BCAST_SINK_QOS:
+		struct bt_iso_bcast_sink_qos *sink_qos = iso_sock_get_bcast_sink_qos(sk);
+
+		len = min_t(unsigned int, len, sizeof(*sink_qos));
+		if (copy_to_user(optval, sink_qos, len))
+			err = -EFAULT;
+
+		break;
+
+	case BT_ISO_BCAST_SOURCE_QOS:
+		struct bt_iso_bcast_source_qos *source_qos = iso_sock_get_bcast_source_qos(sk);
 
-		len = min_t(unsigned int, len, sizeof(*qos));
-		if (copy_to_user(optval, qos, len))
+		len = min_t(unsigned int, len, sizeof(*source_qos));
+		if (copy_to_user(optval, source_qos, len))
 			err = -EFAULT;
 
 		break;
@@ -1419,7 +1598,7 @@ static bool iso_match_big(struct sock *sk, void *data)
 {
 	struct hci_evt_le_big_sync_estabilished *ev = data;
 
-	return ev->handle == iso_pi(sk)->qos.big;
+	return ev->handle == iso_pi(sk)->sink_qos.big;
 }
 
 static void iso_conn_ready(struct iso_conn *conn)
@@ -1550,7 +1729,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 				iso_pi(sk)->bc_num_bis = ev2->num_bis;
 
 			err = hci_le_big_create_sync(hdev,
-						     &iso_pi(sk)->qos,
+						     &iso_pi(sk)->sink_qos,
 						     iso_pi(sk)->sync_handle,
 						     iso_pi(sk)->bc_num_bis,
 						     iso_pi(sk)->bc_bis);
-- 
2.34.1

