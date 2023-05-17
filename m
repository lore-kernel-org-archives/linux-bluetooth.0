Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60B7C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 May 2023 07:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjEQH1h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 May 2023 03:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjEQH1f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 May 2023 03:27:35 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E09EE7F
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 00:27:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIWtTu/FxLhHY7yzsiv5BhU4PZM8z3Mox4L47jgsdDC/7+iwYDU026D8w4qSx+6fP2rcSiJvmCRp0Vlw15CCsWVn2m3IBtE1DjS5MpfYsvYkiAsg2vNmiC9lWjzJmfdxDsdUtY4BfG6kV22ARAtCwh7AD2pA16wEjuZlSLIGcaLQmwO88x5IPxICfsdHkQ8zVOnd3V14S1ofPZm8CmkoKKUCVZ9Z3o2tgTioMm8RqF4GSFo38QX+bMIcT3UjoUmFqv5Hlv1y4BKwOIzpnc4ZvG44t19BCaBFJwl5foevVfRjHA2W3uPHAfCGjXNxIbGMb4Jy7dj8tKK6G2vc10iY3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+U9A7oz1XnK1vrAMF/R0/rKRxyJ4axPWdjEScRii3VI=;
 b=YuJPPjjsp7V415dtHPpEbkOo1qgrVWKG8h3+hBjuJvkVWhVUpmJaQXwMOOjULSw18Q+y3l3+pm4LE5aldbSrcol+VKfPL7cRpflLzzkaB2LNNtd2HOKTs3jVvsCWKFnMj+BArASoo1H7NUd960lKYrMEPq+zmGSjC9lZCUH2Dv4urr5mbkaCWpDmWVBS7IttRXD3O8Sj19GgZX+ztE8pO1Pd3O+Y3XRF/wumEhftokhkUW+c68XSrrMIApEVdAoNxG/74l/bAsbdjV8ta5+1YC3feOJ+BENcsng+R9Qzmj3RfOdqaAeXlk2LLrcGWumybPxNpH4ZL+2a7/SEYM8/2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+U9A7oz1XnK1vrAMF/R0/rKRxyJ4axPWdjEScRii3VI=;
 b=QEeV7i0R8loDtNQASHImHMIXH7RQO3FPYTPZchcqSbwY0neP8CVU789IMkCd04+BD3ZAIBti7K9f7+S982k73LlTlc7QLwjzlX+Wb8rtDt9dBiwisTAvG3rx3p6WuT0FgCQn4MhWQvSGuR2kcdsOcAScUGIApz+0wzHeJBKcHmE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM0PR04MB6993.eurprd04.prod.outlook.com (2603:10a6:208:17d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 07:27:29 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%4]) with mapi id 15.20.6387.032; Wed, 17 May 2023
 07:27:29 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: Add support for creating multiple BISes
Date:   Wed, 17 May 2023 10:27:06 +0300
Message-Id: <20230517072706.5988-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517072706.5988-1-iulia.tanasescu@nxp.com>
References: <20230517072706.5988-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0032.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::9) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM0PR04MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: 561027e6-bddb-487b-a7b1-08db56a82c13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 722BHlfQnd0tCKHvtVda8rHbXcD7R1ln7eUBB3oMrd1zGr7eYhkMN6uuANNynQEWWZhxby5zHkjXGXt5fr/pky+32e0ylFereOZ6xNA37jlQ7/P6dkz7mvuUyJ+EZeolL+0ID6S4zMr9QCNWXbJyOb3Fg1erRBeGfppwf/cyS+dmP2zcy34TJSdmTTTE4wwKdHsPtMC+3ITq4XgR6bnUYoFGDQP59XwGutaMbWealEZQWxCHuyjDTgE+UusPveOurxi1vFXM55q6HDUGmmOGh/D/DknEJhfO13di+mewcv9AzUcuXnLAQ6hqN/rvLLo9TFEZf/0Tid3o9MoW3Q1bWP9EC5XVuCP/ndDIFoYFw1T43xZKRYj4bqstOcRc16dTy13UZRQz6w6KJrWvgGOZNw8vax+Tb/ukGJR1xIO6QFOR2mW3qFcYcLESi2vxbjU/Efbg9k7C/2ax+bvVX9mOuY+k3hFQvmGvhnRHxaRmxdqzzXyTAQcxeVK1TA5sNlMzQ9X7+rqovon/4pZlatFlxe1qgmiZ+c4N4LEyUuW51/9Z+hl9T8VoOgLtRwgsnTY7SSp8NMXZWt4RFOttKJ7bmscPzjAFUehfCUjD2YcobtU3RA8I/iJeKWla2WlJ6gKO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199021)(5660300002)(41300700001)(36756003)(2906002)(2616005)(83380400001)(30864003)(86362001)(38350700002)(38100700002)(26005)(186003)(1076003)(6512007)(6506007)(44832011)(8676002)(8936002)(66556008)(66476007)(66946007)(52116002)(6486002)(6666004)(478600001)(6916009)(316002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/6+szMs1Tin1/nH2bbPpYwW+ZxUuMvocmZwIwKzKUyWdnBoi2Tpf5UM3aTA5?=
 =?us-ascii?Q?B4u7F7nWaVKepjffqe2ZrQ+zhnRIadvgxESL9xkZBCO1JY7ibmc7DrwmHE88?=
 =?us-ascii?Q?TBphK7KpI1FGpFd+nHVUp6GCUqI6Mo8oFwtzoOdoHDQ7x7xSFrayyXe7STTR?=
 =?us-ascii?Q?7YoGB0TaBf8S+1778k6K7GwctpXbs+gj33KcA0NtqhdPX+i1+WHhTnFEC68f?=
 =?us-ascii?Q?w+UFIbdSFVqTObTHGfRTg+iRCZ9R9AbrELs08uuyQ4Y1wB7WC8gv8P/JxnmU?=
 =?us-ascii?Q?cOypEeiD57V6/m+xLFzn+y2NRg3lvSEpkfcL4tvx0jidt0Q54lTV/NbqOkbD?=
 =?us-ascii?Q?JX+wN2qFmzSBGpTOpBA0OKdGlT4Az5hOKE9wK8dzsKpqLcGa4dBCI01UBwXj?=
 =?us-ascii?Q?I+Zq5u+SFlnunYHEFExl5LuhMFozo7BOPRpU70CI5OJFEK6vejlsLMxG2D0t?=
 =?us-ascii?Q?Lg0pyGcL/aEz0Vd3vLLkJRSnOwzxt/J6Q3yqH2jeZ0FM29eWLHRhfc7vxN/f?=
 =?us-ascii?Q?AqPpwlVs5bDPcliNPSXF4QVAKzG4wt8ro8nuIfbCoc6GTOw1j85UT7TPeNML?=
 =?us-ascii?Q?/OOfmxXJ/X0sbp1FERVaq9zjttuwOKvbPSQlGgYsJ7HS38qu4Q9ZRYxRfc3k?=
 =?us-ascii?Q?xxpIhZMXPDf1L1ijYk3TZWdjQ0CSCm3O6+uSfDtuyQih/Yt1KoF4IFhAw7Pa?=
 =?us-ascii?Q?xfAm2t89w5gOvLfJ7FdRIwwECgUgtbFvtgoU2yxj0cprdSig23vmfn97OuMU?=
 =?us-ascii?Q?29cCQdihmcaAs9+uD/sR0suGtqIs358BaA6JjTJKtfD/KcmGv6mQA+XPpVWR?=
 =?us-ascii?Q?N58fOR5BoqIb3Oy9+0mXSsaNiMbmZACnPmLEHegXQXoLpdAoQmgaTh4fRYEm?=
 =?us-ascii?Q?cDxMyr3lEfuonwc3unnVtyb7mipbhr0C3Wiw2+1PsjIcmODzVBfjcfBfYkMb?=
 =?us-ascii?Q?t3RrvWsGIYz4Hv3Ngj3GW7XjCzYJ9V/rCB0I8RBOv4y9ZCn3uq3Nh5rkyGf0?=
 =?us-ascii?Q?kxgi2uUYClXhmvP8V8/Kx0TR+uwG/gzdiSbKEQPG5Z+HZTQbdkb/O9xQKFjy?=
 =?us-ascii?Q?TWbuJ3Y3zNkLRQbguAf+4sVQNdCY97OkCpYDc7ZaCFk9lsq2P60fC0YKnaWb?=
 =?us-ascii?Q?zjKoQEIuJadhUYIvXVVeM7NSjib5hb4oFGe1D2N5uhMlrw2tQOBpj7UbyQyj?=
 =?us-ascii?Q?u5USz6AnmtHN7XjzLdnYF9QPi6MxYaKk3QY5aUVY6N07N963OAxzJoeyDL3b?=
 =?us-ascii?Q?jqjZW3hsqtrO+BVbZr2MhqpcoWL7A33lvW0hqA+i3ndlT1tWOJ5Jbals5JSM?=
 =?us-ascii?Q?HSeukIg769nkIlIsL7HwN9uZqBmpOXMp97MqgT0hsDnSVcqcC4JN6FjllUo6?=
 =?us-ascii?Q?Oc6QRoMut6OAS8XCudUsWu47UNyv773FoS65buP0QhxyAsLembFHPauuvodp?=
 =?us-ascii?Q?sCd4VGbD4Cp10qKERgK40oh+yxmO6QiAU3Jsn0g0AGE0wHY1/vR6lCaF6ND+?=
 =?us-ascii?Q?D8AmW3jB/gB0x5HJgvAYybqaJFpi4xE0taBik30l1B/wNBYbhkpABAhSEaxq?=
 =?us-ascii?Q?LNIWCZCDIGqdCzuNtp7Q6JDo5B3R0S+AdQAS82Z7+DziPKzZoOPndpGJcmDI?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561027e6-bddb-487b-a7b1-08db56a82c13
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 07:27:29.8848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lSryzetCnsj8iBgLZtzVNW4NDUbTsx+7aXbaj6FchiGGx8QT/JBrH7ZkDf+b5Iz62ct8uoEn52rx8krWl+qYkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6993
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It is required for some configurations to have multiple BISes as part
of the same BIG, which is now covered by iso-tester in the following test
case:

    ISO Broadcaster AC 13 - Success

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 include/net/bluetooth/bluetooth.h |   2 +
 include/net/bluetooth/hci.h       |   7 ++
 include/net/bluetooth/hci_core.h  |  32 ++++++-
 include/net/bluetooth/iso.h       |  14 +++
 net/bluetooth/hci_conn.c          | 150 ++++++++++++++++++++++++------
 net/bluetooth/hci_core.c          |  18 ++++
 net/bluetooth/hci_event.c         |  98 +++++++++++++++----
 net/bluetooth/iso.c               |   4 +
 8 files changed, 277 insertions(+), 48 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 1b4230cd42a3..28a3b105fdf3 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -198,6 +198,8 @@ struct bt_iso_bcast_qos {
 	__u8  sync_cte_type;
 	__u8  mse;
 	__u16 timeout;
+	__u8  dummy[2]; /* Dummy octets for padding compatibility with old BlueZ */
+	__u8  num_bis;
 };
 
 struct bt_iso_qos {
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 07df96c47ef4..7567cbecf937 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1,6 +1,7 @@
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (C) 2000-2001 Qualcomm Incorporated
+   Copyright 2023 NXP
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
@@ -2812,6 +2813,12 @@ struct hci_evt_le_create_big_complete {
 	__le16  bis_handle[];
 } __packed;
 
+#define HCI_EVT_LE_TERM_BIG_COMPLETE	0x1c
+struct hci_evt_le_term_big_complete {
+	__u8    handle;
+	__u8    reason;
+} __packed;
+
 #define HCI_EVT_LE_BIG_SYNC_ESTABILISHED 0x1d
 struct hci_evt_le_big_sync_estabilished {
 	__u8    status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8baf34639939..2b2f25bea6bd 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -583,6 +583,7 @@ struct hci_dev {
 	struct list_head	pend_le_reports;
 	struct list_head	blocked_keys;
 	struct list_head	local_codecs;
+	struct list_head	bigs;
 
 	struct hci_dev_stats	stat;
 
@@ -973,7 +974,6 @@ enum {
 	HCI_CONN_NEW_LINK_KEY,
 	HCI_CONN_SCANNING,
 	HCI_CONN_AUTH_FAILURE,
-	HCI_CONN_PER_ADV,
 };
 
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
@@ -1258,6 +1258,31 @@ static inline struct hci_conn *hci_conn_hash_lookup_big(struct hci_dev *hdev,
 	return NULL;
 }
 
+static inline struct hci_conn *
+hci_conn_hash_lookup_big_state(struct hci_dev *hdev,
+			       __u8 handle, __u16 state)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (bacmp(&c->dst, BDADDR_ANY) || c->type != ISO_LINK ||
+						c->state != state)
+			continue;
+
+		if (handle == c->iso_qos.bcast.big) {
+			rcu_read_unlock();
+			return c;
+		}
+	}
+
+	rcu_read_unlock();
+
+	return NULL;
+}
+
 static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev *hdev,
 							__u8 type, __u16 state)
 {
@@ -1369,6 +1394,8 @@ void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active);
 
 void hci_conn_failed(struct hci_conn *conn, u8 status);
 
+int hci_le_create_big(struct hci_conn *conn, struct bt_iso_qos *qos);
+
 /*
  * hci_conn_get() and hci_conn_put() are used to control the life-time of an
  * "hci_conn" object. They do not guarantee that the hci_conn object is running,
@@ -1576,6 +1603,9 @@ struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
 						  bdaddr_t *addr,
 						  u8 addr_type);
 
+struct iso_big *hci_bigs_list_lookup(struct list_head *list,
+				     __u8 handle);
+
 void hci_uuids_clear(struct hci_dev *hdev);
 
 void hci_link_keys_clear(struct hci_dev *hdev);
diff --git a/include/net/bluetooth/iso.h b/include/net/bluetooth/iso.h
index 3f4fe8b78e1b..2deddb80499d 100644
--- a/include/net/bluetooth/iso.h
+++ b/include/net/bluetooth/iso.h
@@ -3,6 +3,7 @@
  * BlueZ - Bluetooth protocol stack for Linux
  *
  * Copyright (C) 2022 Intel Corporation
+ * Copyright 2023 NXP
  */
 
 #ifndef __ISO_H
@@ -29,4 +30,17 @@ struct sockaddr_iso {
 	struct sockaddr_iso_bc iso_bc[];
 };
 
+struct iso_bis {
+	__u16	handle;
+	bool	assigned;
+};
+
+/* hdev BIG list entry */
+struct iso_big {
+	struct list_head	list;
+	__u8			handle;
+	__u8			num_bis;
+	struct iso_bis		bis[ISO_MAX_NUM_BIS];
+};
+
 #endif /* __ISO_H */
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index f75ef12f18f7..57e52de6f21d 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -35,6 +35,7 @@
 #include <net/bluetooth/mgmt.h>
 
 #include "hci_request.h"
+#include "hci_debugfs.h"
 #include "smp.h"
 #include "a2mp.h"
 #include "eir.h"
@@ -826,13 +827,6 @@ static int terminate_big_sync(struct hci_dev *hdev, void *data)
 
 	hci_remove_ext_adv_instance_sync(hdev, d->bis, NULL);
 
-	/* Check if ISO connection is a BIS and terminate BIG if there are
-	 * no other connections using it.
-	 */
-	hci_conn_hash_list_state(hdev, find_bis, ISO_LINK, BT_CONNECTED, d);
-	if (d->count)
-		return 0;
-
 	return hci_le_terminate_big_sync(hdev, d->big,
 					 HCI_ERROR_LOCAL_HOST_TERM);
 }
@@ -914,11 +908,25 @@ static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, u16 sync_handle)
 static void bis_cleanup(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
+	struct iso_list_data data;
+	struct iso_big *big;
 
 	bt_dev_dbg(hdev, "conn %p", conn);
 
 	if (conn->role == HCI_ROLE_MASTER) {
-		if (!test_and_clear_bit(HCI_CONN_PER_ADV, &conn->flags))
+		big = hci_bigs_list_lookup(&hdev->bigs, conn->iso_qos.bcast.big);
+
+		for (int i = 0; i < big->num_bis; i++)
+			if (!big->bis[i].assigned)
+				return;
+
+		data.count = 0;
+		data.big = conn->iso_qos.bcast.big;
+		data.bis = conn->iso_qos.bcast.bis;
+
+		hci_conn_hash_list_state(hdev, bis_list, ISO_LINK, BT_CONNECTED,
+					 &data);
+		if (data.count)
 			return;
 
 		hci_le_terminate_big(hdev, conn->iso_qos.bcast.big,
@@ -1486,13 +1494,40 @@ static int qos_set_bis(struct hci_dev *hdev, struct bt_iso_qos *qos)
 	return 0;
 }
 
+static int hci_match_bis_params(struct hci_dev *hdev, struct bt_iso_qos *qos,
+				__u8 base_len, __u8 *base, __u16 bis_state)
+{
+	struct hci_conn *conn;
+	__u8 eir[HCI_MAX_PER_AD_LENGTH];
+
+	if (base_len && base)
+		base_len = eir_append_service_data(eir, 0,  0x1851, base, base_len);
+
+	conn = hci_conn_hash_lookup_big_state(hdev, qos->bcast.big, bis_state);
+
+	if (memcmp(qos, &conn->iso_qos, sizeof(*qos)) ||
+	    base_len != conn->le_per_adv_data_len ||
+	    memcmp(conn->le_per_adv_data, eir, base_len))
+		return -EADDRINUSE;
+
+	return 0;
+}
+
 /* This function requires the caller holds hdev->lock */
 static struct hci_conn *hci_add_bis(struct hci_dev *hdev, bdaddr_t *dst,
-				    struct bt_iso_qos *qos)
+				    struct bt_iso_qos *qos, __u8 base_len,
+				    __u8 *base, bool *big_create,
+				    bool *connected)
 {
 	struct hci_conn *conn;
 	struct iso_list_data data;
 	int err;
+	int i;
+	struct iso_big *big;
+	__u16 handle;
+
+	*big_create = false;
+	*connected = false;
 
 	/* Let's make sure that le is enabled.*/
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
@@ -1509,26 +1544,71 @@ static struct hci_conn *hci_add_bis(struct hci_dev *hdev, bdaddr_t *dst,
 	if (err)
 		return ERR_PTR(err);
 
-	data.big = qos->bcast.big;
-	data.bis = qos->bcast.bis;
-	data.count = 0;
+	/* Check if BIG is already created */
+	big = hci_bigs_list_lookup(&hdev->bigs, qos->bcast.big);
+	if (!big) {
+		/* Check if there are other BISes bound to the same BIG */
+		data.big = qos->bcast.big;
+		data.bis = qos->bcast.bis;
+		data.count = 0;
 
-	/* Check if there is already a matching BIG/BIS */
-	hci_conn_hash_list_state(hdev, bis_list, ISO_LINK, BT_BOUND, &data);
-	if (data.count)
-		return ERR_PTR(-EADDRINUSE);
+		hci_conn_hash_list_state(hdev, bis_list, ISO_LINK, BT_BOUND, &data);
+		if (data.count) {
+			/* Check QoS and base parameters against the
+			 * other BOUND connections
+			 */
+			err = hci_match_bis_params(hdev, qos, base_len, base, BT_BOUND);
+			goto done;
+		}
 
-	conn = hci_conn_hash_lookup_bis(hdev, dst, qos->bcast.big, qos->bcast.bis);
-	if (conn)
-		return ERR_PTR(-EADDRINUSE);
+		*big_create = true;
+		goto done;
+	}
+
+	conn = hci_conn_hash_lookup_big_state(hdev, qos->bcast.big, BT_CONNECTED);
+	if (!conn) {
+		/* BIG is in the process of terminating.
+		 * Check BIS parameters against other BOUND connections if any,
+		 * and mark BIS as bound for the BIG. BIG will be recreated
+		 * after receiving the HCI_EVT_LE_TERM_BIG_COMPLETE event
+		 */
+		err = hci_match_bis_params(hdev, qos, base_len, base, BT_BOUND);
+		goto done;
+	}
+
+	/* BIG is already created. Check that QoS and
+	 * base parameters match the BIG
+	 */
+	err = hci_match_bis_params(hdev, qos, base_len, base, BT_CONNECTED);
+	if (!err) {
+		/* Try to assign a bis handle */
+		for (i = 0; i < big->num_bis; i++) {
+			if (big->bis[i].assigned)
+				continue;
+
+			handle = big->bis[i].handle;
+			big->bis[i].assigned = true;
+			*connected = true;
+			break;
+		}
+
+		if (i == big->num_bis)
+			err = -EADDRINUSE;
+	}
+
+done:
+	if (err)
+		return ERR_PTR(err);
 
 	conn = hci_conn_add(hdev, ISO_LINK, dst, HCI_ROLE_MASTER);
 	if (!conn)
 		return ERR_PTR(-ENOMEM);
 
-	set_bit(HCI_CONN_PER_ADV, &conn->flags);
 	conn->state = BT_CONNECT;
 
+	if (*connected)
+		conn->handle = handle;
+
 	hci_conn_hold(conn);
 	return conn;
 }
@@ -1736,7 +1816,7 @@ static void cis_list(struct hci_conn *conn, void *data)
 	cis_add(d, &conn->iso_qos);
 }
 
-static int hci_le_create_big(struct hci_conn *conn, struct bt_iso_qos *qos)
+int hci_le_create_big(struct hci_conn *conn, struct bt_iso_qos *qos)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_le_create_big cp;
@@ -1745,7 +1825,7 @@ static int hci_le_create_big(struct hci_conn *conn, struct bt_iso_qos *qos)
 
 	cp.handle = qos->bcast.big;
 	cp.adv_handle = qos->bcast.bis;
-	cp.num_bis  = 0x01;
+	cp.num_bis  = qos->bcast.num_bis;
 	hci_cpu_to_le24(qos->bcast.out.interval, cp.bis.sdu_interval);
 	cp.bis.sdu = cpu_to_le16(qos->bcast.out.sdu);
 	cp.bis.latency =  cpu_to_le16(qos->bcast.out.latency);
@@ -2156,9 +2236,12 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 {
 	struct hci_conn *conn;
 	int err;
+	bool big_create = false;
+	bool connected = false;
 
 	/* We need hci_conn object using the BDADDR_ANY as dst */
-	conn = hci_add_bis(hdev, dst, qos);
+	conn = hci_add_bis(hdev, dst, qos, base_len, base,
+			   &big_create, &connected);
 	if (IS_ERR(conn))
 		return conn;
 
@@ -2171,18 +2254,27 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 		conn->le_per_adv_data_len = base_len;
 	}
 
-	/* Queue start periodic advertising and create BIG */
-	err = hci_cmd_sync_queue(hdev, create_big_sync, conn,
-				 create_big_complete);
-	if (err < 0) {
-		hci_conn_drop(conn);
-		return ERR_PTR(err);
+	if (big_create) {
+		/* Queue start periodic advertising and create BIG */
+		err = hci_cmd_sync_queue(hdev, create_big_sync, conn,
+					 create_big_complete);
+		if (err < 0) {
+			hci_conn_drop(conn);
+			return ERR_PTR(err);
+		}
 	}
 
 	hci_iso_qos_setup(hdev, conn, &qos->bcast.out,
 			  conn->le_tx_phy ? conn->le_tx_phy :
 			  hdev->le_tx_def_phys);
 
+	if (connected) {
+		conn->state = BT_CONNECTED;
+		hci_debugfs_create_conn(conn);
+		hci_conn_add_sysfs(conn);
+		hci_iso_setup_path(conn);
+	}
+
 	return conn;
 }
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a856b1051d35..0dd9161f7157 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2,6 +2,7 @@
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (C) 2000-2001 Qualcomm Incorporated
    Copyright (C) 2011 ProFUSION Embedded Systems
+   Copyright 2023 NXP
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
@@ -38,6 +39,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
+#include <net/bluetooth/iso.h>
 #include <net/bluetooth/mgmt.h>
 
 #include "hci_request.h"
@@ -2264,6 +2266,20 @@ struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
 	return NULL;
 }
 
+/* This function requires the caller holds hdev->lock */
+struct iso_big *hci_bigs_list_lookup(struct list_head *list,
+				     __u8 handle)
+{
+	struct iso_big *big;
+
+	list_for_each_entry(big, list, list) {
+		if (big->handle == handle)
+			return big;
+	}
+
+	return NULL;
+}
+
 /* This function requires the caller holds hdev->lock */
 struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
 					    bdaddr_t *addr, u8 addr_type)
@@ -2525,6 +2541,8 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	INIT_LIST_HEAD(&hdev->monitored_devices);
 
 	INIT_LIST_HEAD(&hdev->local_codecs);
+	INIT_LIST_HEAD(&hdev->bigs);
+
 	INIT_WORK(&hdev->rx_work, hci_rx_work);
 	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
 	INIT_WORK(&hdev->tx_work, hci_tx_work);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d00ef6e3fc45..ddf55fa4703a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -30,6 +30,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/mgmt.h>
+#include <net/bluetooth/iso.h>
 
 #include "hci_request.h"
 #include "hci_debugfs.h"
@@ -3903,6 +3904,11 @@ static void hci_cs_le_create_big(struct hci_dev *hdev, u8 status)
 	bt_dev_dbg(hdev, "status 0x%2.2x", status);
 }
 
+static void hci_cs_le_term_big(struct hci_dev *hdev, u8 status)
+{
+	bt_dev_dbg(hdev, "status 0x%2.2x", status);
+}
+
 static u8 hci_cc_set_per_adv_param(struct hci_dev *hdev, void *data,
 				   struct sk_buff *skb)
 {
@@ -4275,6 +4281,7 @@ static const struct hci_cs {
 	HCI_CS(HCI_OP_LE_EXT_CREATE_CONN, hci_cs_le_ext_create_conn),
 	HCI_CS(HCI_OP_LE_CREATE_CIS, hci_cs_le_create_cis),
 	HCI_CS(HCI_OP_LE_CREATE_BIG, hci_cs_le_create_big),
+	HCI_CS(HCI_OP_LE_TERM_BIG, hci_cs_le_term_big),
 };
 
 static void hci_cmd_status_evt(struct hci_dev *hdev, void *data,
@@ -6910,6 +6917,9 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 {
 	struct hci_evt_le_create_big_complete *ev = data;
 	struct hci_conn *conn;
+	struct iso_big *big;
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	__u8 bis_idx = 0;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
@@ -6919,30 +6929,78 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
-	conn = hci_conn_hash_lookup_big(hdev, ev->handle);
-	if (!conn)
-		goto unlock;
+	if (!ev->status) {
+		/* Add the created BIG to the list */
+		big = kzalloc(sizeof(*big), GFP_KERNEL);
+		if (!big)
+			return;
 
-	if (conn->type != ISO_LINK) {
-		bt_dev_err(hdev,
-			   "Invalid connection link type handle 0x%2.2x",
-			   ev->handle);
-		goto unlock;
+		big->handle = ev->handle;
+		big->num_bis = ev->num_bis;
+
+		for (int i = 0; i < ev->num_bis; i++) {
+			big->bis[i].handle = __le16_to_cpu(ev->bis_handle[i]);
+			big->bis[i].assigned = false;
+		}
+
+		list_add(&big->list, &hdev->bigs);
 	}
 
-	if (ev->num_bis)
-		conn->handle = __le16_to_cpu(ev->bis_handle[0]);
+	rcu_read_lock();
 
-	if (!ev->status) {
-		conn->state = BT_CONNECTED;
-		hci_debugfs_create_conn(conn);
-		hci_conn_add_sysfs(conn);
-		hci_iso_setup_path(conn);
-		goto unlock;
+	/* Connect all BISes that are bound to the BIG */
+	list_for_each_entry_rcu(conn, &h->list, list) {
+		if (bacmp(&conn->dst, BDADDR_ANY) || conn->type != ISO_LINK ||
+		    conn->state != BT_BOUND ||
+		    conn->iso_qos.bcast.big != ev->handle)
+			continue;
+
+		if (ev->status) {
+			hci_connect_cfm(conn, ev->status);
+			hci_conn_del(conn);
+		}
+
+		if (big->num_bis > bis_idx) {
+			conn->handle = __le16_to_cpu(big->bis[bis_idx].handle);
+			big->bis[bis_idx].assigned = true;
+			bis_idx++;
+
+			conn->state = BT_CONNECTED;
+			hci_debugfs_create_conn(conn);
+			hci_conn_add_sysfs(conn);
+			hci_iso_setup_path(conn);
+			continue;
+		}
 	}
 
-	hci_connect_cfm(conn, ev->status);
-	hci_conn_del(conn);
+	rcu_read_unlock();
+	hci_dev_unlock(hdev);
+}
+
+static void hci_le_term_big_complete_evt(struct hci_dev *hdev, void *data,
+					 struct sk_buff *skb)
+{
+	struct hci_evt_le_term_big_complete *ev = data;
+	struct iso_big *big;
+	struct hci_conn *conn;
+
+	BT_DBG("%s reason 0x%2.2x", hdev->name, ev->reason);
+
+	hci_dev_lock(hdev);
+
+	big = hci_bigs_list_lookup(&hdev->bigs, ev->handle);
+
+	if (big) {
+		list_del(&big->list);
+		kfree(big);
+	}
+
+	/* If there are any bound connections to the BIG, recreate it */
+	conn = hci_conn_hash_lookup_big_state(hdev, ev->handle, BT_BOUND);
+	if (!conn)
+		goto unlock;
+
+	hci_le_create_big(conn, &conn->iso_qos);
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -7089,6 +7147,10 @@ static const struct hci_le_ev {
 		     hci_le_create_big_complete_evt,
 		     sizeof(struct hci_evt_le_create_big_complete),
 		     HCI_MAX_EVENT_SIZE),
+	/* [0x1c = HCI_EVT_LE_TERM_BIG_COMPLETE] */
+	HCI_LE_EV(HCI_EVT_LE_TERM_BIG_COMPLETE,
+		  hci_le_term_big_complete_evt,
+		  sizeof(struct hci_evt_le_term_big_complete)),
 	/* [0x1d = HCI_EV_LE_BIG_SYNC_ESTABILISHED] */
 	HCI_LE_EV_VL(HCI_EVT_LE_BIG_SYNC_ESTABILISHED,
 		     hci_le_big_sync_established_evt,
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 34d55a85d8f6..416ed416fffa 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -717,6 +717,7 @@ static struct bt_iso_qos default_qos = {
 		.sync_cte_type		= 0x00,
 		.mse			= 0x00,
 		.timeout		= 0x4000,
+		.num_bis		= 0x01,
 	},
 };
 
@@ -1249,6 +1250,9 @@ static bool check_bcast_qos(struct bt_iso_qos *qos)
 	if (qos->bcast.timeout < 0x000a || qos->bcast.timeout > 0x4000)
 		return false;
 
+	if (qos->bcast.num_bis < 0x01 || qos->bcast.num_bis > ISO_MAX_NUM_BIS)
+		return false;
+
 	return true;
 }
 
-- 
2.34.1

