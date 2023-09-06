Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90065EB8FD2
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Sep 2023 14:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241402AbjIFOBe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Sep 2023 10:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241384AbjIFOBd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Sep 2023 10:01:33 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7567310C9
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Sep 2023 07:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSUXHJ4Vk41Hqc0kabPsGXOYDvS64f7pHR8vFwIK5+hywfemfAwlCTpSZTt0WLzaVBvvBd3cgCU7e3ikIdWI/bh4lY0IjScny0oE4gJEhvfT+cb3a3jAAmi9MSB0Y5InGvwDwTGjXwYpFs29GuPQVck4oJLq+K/AlQa7v/ysn0Xb6w5JdXwNbiSNihKBTv+NpQLnHzCNXQod69Cj6Z/SrsVmHYJMIVJ3Ec4D3LNoyddBxPIMIcoaroyA/d4B5pBv89BMh+9avNO0LSzfyIjjxGMMNxc/EsVp1fOM1CVcdBVXawiHhpN2RVS42ahqiP5gNvSOJF3uRfvY4oCThJRk+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3cycxPYeHNy6P+lfTaqMD11slb4hqVGOK/BYLB77lg=;
 b=NmO2sgvLG8KEhpQTcx3a5I5UownxvdXuRLb/lHeuC12hfHewEMZhePEzkS+tupcV0sDX1fCkjaedtnbj+O/mxsDuRWjpHN9txUTF6nFUEKnV7OVKMEgGk0lD1d1J7+bc/b7V7hjjv4KZK7FBRz1oLZz+dFBddC5AJIec0Dc/ciXGsJXmHt7SOjNhw/czngyso7nRUR3v5eTiBXdhSINAD3U66qhcv0ZFiQMRK36DtHJFDB2u8ZkXj+bL5mK1DRDsmQ6u07I3waRf3hm/w216Qn8ygLoCBcw9V43G40pLWPpturIZZw0a56E4K6BbWP1HMWkcC1jiqHjaVT1tyrfW6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3cycxPYeHNy6P+lfTaqMD11slb4hqVGOK/BYLB77lg=;
 b=dqiwc4aTgcxud8Z/ZOhDbxSdGMfWmmkOz2S1o2CLj7/vCRSGU2n9duz/viLEk/mzLjM1c09SZ29Iqpx4ZIh3WrgsNk7WivdLi6D4JxA0bQT8nIKIOQEs7d4l+JrM+QMGjpWkISMqJYa8GBIgDGfhZ23BNC42OM6Pa5w8SBdmglY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8788.eurprd04.prod.outlook.com (2603:10a6:20b:42f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 14:01:25 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 14:01:25 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: ISO: Pass BIG encryption info through QoS
Date:   Wed,  6 Sep 2023 17:01:03 +0300
Message-Id: <20230906140103.9183-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906140103.9183-1-iulia.tanasescu@nxp.com>
References: <20230906140103.9183-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0128.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::25) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b21fe96-bda6-4b70-fd26-08dbaee1c276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ZsqgYpcXYAzITlilWxw3Wva2FzMebrAiBuoKRV4/CDTxWrg1yoW7tWX8TEk7WV7nxnxV16JLDLuhTdq2AWxR+XgvWfjIN2UFmQ6R1rBmcMwtC7HHEOjYlW5uh6kpT1zgrx/TNvr8rYGZaVVU9cvEmwjPLHvOpKcuaYmsOsUKPclYbXzKolHxjSY0LwxrTWL698zOSXsMEvuT18qTjCB10chrHxYEXC5cBlqBd20QbP8Qlarp43g+Zni5AOYD1Rr1FlJn7VSJPNRHxwCFz4YFS4gl0GmbUfNRe8nxj7Y38f/ayLZ7TudPTl9KItdUBnKTx9PpmW9FgsZxBF0A4o3Wsvqn+FdKYbISsUxL1pgpP3RYxKaUi1+XYhsVMZYciprf0vXzcKeBOIuJ8Eor7tuNVlfmo37U3H6B0qleh+xHS+tCAesYYlTy61MhMuy3CrZsotcUhqWnrXPwY+RkKFWEyL5GTTB+4QgMvN8RmP2LtM3QPoZZCV6vAz4T1TzwJHre7zqEg5zZtRbdim2tOs1Q+gdBDq6z9EBWLv8E1NvsIjKQzVObACL0wFR5D8aGi6DK6sJn699cdGt+AFE78u4895p+np81I3GyiNcyyXMEyN0Snl0TqlT3P7XMggkdp/u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199024)(1800799009)(186009)(38350700002)(36756003)(38100700002)(86362001)(6666004)(26005)(478600001)(1076003)(5660300002)(52116002)(44832011)(6486002)(6506007)(55236004)(66556008)(66946007)(66476007)(316002)(6916009)(41300700001)(2616005)(8676002)(8936002)(6512007)(4326008)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7uPZzIphEXqXk0B+8OyuxppP7G/aNnGSpQqI4ULJ38MZSWRcb1U8lBnbaddq?=
 =?us-ascii?Q?BweEjBfsgqw/GqkTNaHJe3L6OF3Sr60/vOkEJk+Y31zX1moobSluQWWIvGiE?=
 =?us-ascii?Q?GTR/Pc7iBWqmRyS7NIpsT2M8WxdpwLKLpi49WAB6DMcP2Qr7PzThEiQ9LS+F?=
 =?us-ascii?Q?uiZZOdKfbp80sJM8AA0q6ILkGH2hv66lp77gKIxjYIeX+aXd9rN7SKhMYXAu?=
 =?us-ascii?Q?rAI5+ipYyN2PuyaWCo/yA0IALxHppua5n+0lnzNqN2PIMpNiuvBo8d3LuXIm?=
 =?us-ascii?Q?tVwjHR+JMwwJy498SkVXMPANR+3p3Rlc+l22G62bkrsyC/RTiRC3CQEUUJCt?=
 =?us-ascii?Q?qOVUzfVa13S/fXfsIgx/NmH6SF59xkzIFt5z745AxnjxrM9ibLgCfLn0nOuz?=
 =?us-ascii?Q?gzt6zKpHrVCdUl/2GyXny4it+KAUX436k7obWB5xSB9b4IiFKf1KYRDnOR7I?=
 =?us-ascii?Q?Ue7VevuBVj2rIqn/MYbuLI0PeVRwOKhWPySP56JyBOKlIG9YlHAM23yWBRxX?=
 =?us-ascii?Q?zDvgZteVwg2CLS+1RGiRGXHuQ6Pve1kIWjBA8pZNWU/w4eLkYB6mDx5o7glj?=
 =?us-ascii?Q?Geclp1ZdaMlWQRaa5xFXL2ZntsdK5MDDMctOqejgts5/JACuDjVs1AAHfKRx?=
 =?us-ascii?Q?dyqNpjwiRjJXSpYqOM4Y6LknYPH15MU4kg4vf22usBHxg7bXE51jyIm210TX?=
 =?us-ascii?Q?DMLrxUHgWjtj5lvDxE0XvKvikKYhk+iocja7s9IBuPS53QYyWeD3jy0Sq/6P?=
 =?us-ascii?Q?C4GPvLilmB7ySJ7k7gYKlf4LPoFkfFJ35D+jggS5/xYEqQv9K2fIJXvAbCfg?=
 =?us-ascii?Q?2lDDZLCVuqRZxqfSdX7vthly05wm6ZBkTgXYyrmmiNvB3M5pfZD6I2DrFVeM?=
 =?us-ascii?Q?Wp3aZTwRRU0s0OrtABBuDjaR9lHejngBt9p+U1FJouKPrTmhCg+pIyb/u1FF?=
 =?us-ascii?Q?OLGd7C/Af5CTY9iYqJV/4vvJO1a9A6AQqYDyY/Gw3TDhBTUJ5eiSMV2g/ily?=
 =?us-ascii?Q?ceEOhT76i5H3QRmmR4jaguFWVZ64sPUDci8+fcm4nsBs3z/fen3wXpXm6H39?=
 =?us-ascii?Q?1BQfaO7J+j8p0B3IxLWiKRXHD5j9LqVY/Q/7K9k6aSz3tqS+Um8oITArwVIq?=
 =?us-ascii?Q?mAwHzLSiKuxSl+/IrsoKZXt9vBPQM33aJOwAtcIJUN+x6uDjEF9PvQsA3ZFp?=
 =?us-ascii?Q?Rdxkjb8HQqSvU/KLflgz9tDGyZzhRXo+42ToLzy8mdTKnshPVUhJvsNps4BF?=
 =?us-ascii?Q?Acncsc4tNWJZuGcDpNMeFID2MpNEksn2NOya0RlpWBRlGvsFDpqgj1ctSkXg?=
 =?us-ascii?Q?/UNybgKspbCLhcKPX/mQIO45D/LfRRSO2h4fYyr6AiD7+PNVFYvOlgi7QjtL?=
 =?us-ascii?Q?E1HwK2Uw5SMIxl+eU8RvyZOl4QqNKap7qDJCB6hUeC2RUP0kiLRxFWkzZYQv?=
 =?us-ascii?Q?qsOizFXn3IzxdgHscHvwhVhaBdRZqqAmaTEUnqkn2WgoA4iDqIFbmel8B8QX?=
 =?us-ascii?Q?cMDQBggu23Kbzyp5PhGJ9yGGLZeEDEidBKaXG2jRSw+/8TF0T/yAh937xoqD?=
 =?us-ascii?Q?Sbw3AFVMkNW1mJCPrv0Twp4s3YJPsZFteC7mM4KCLH2AY2ohRq5Z5f0qqQ+V?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b21fe96-bda6-4b70-fd26-08dbaee1c276
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 14:01:25.7589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3GgQHkfoDkp+FGCAM7Mxo+xgXawLh2or8A393cxS7MvMhzjwGRjMykzIX7wq3zQxfiytj+ezQx0QctBZgk3mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8788
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This enables a broadcast sink to be informed if the PA
it has synced with is associated with an encrypted BIG,
by retrieving the socket QoS and checking the encryption
field.

After PA sync has been successfully established and the
first BIGInfo advertising report is received, a new hcon
is added and notified to the ISO layer. The ISO layer
sets the encryption field of the socket and hcon QoS
according to the encryption parameter of the BIGInfo
advertising report event.

After that, the userspace is woken up, and the QoS of the
new PA sync socket can be read, to inspect the encryption
field and follow up accordingly.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 include/net/bluetooth/hci.h      |  3 ++
 include/net/bluetooth/hci_core.h | 25 ++++++++++++++-
 net/bluetooth/hci_conn.c         |  1 +
 net/bluetooth/hci_event.c        | 54 +++++++++++++++++++++++---------
 net/bluetooth/iso.c              | 19 ++++++++---
 5 files changed, 82 insertions(+), 20 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 87d92accc26e..bdee5d649cc6 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1,6 +1,7 @@
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (C) 2000-2001 Qualcomm Incorporated
+   Copyright 2023 NXP
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
@@ -673,6 +674,8 @@ enum {
 #define HCI_TX_POWER_INVALID	127
 #define HCI_RSSI_INVALID	127
 
+#define HCI_SYNC_HANDLE_INVALID	0xffff
+
 #define HCI_ROLE_MASTER		0x00
 #define HCI_ROLE_SLAVE		0x01
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e6359f7346f1..bbad301f5781 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1314,7 +1314,7 @@ static inline struct hci_conn *hci_conn_hash_lookup_big_any_dst(struct hci_dev *
 }
 
 static inline struct hci_conn *
-hci_conn_hash_lookup_pa_sync(struct hci_dev *hdev, __u8 big)
+hci_conn_hash_lookup_pa_sync_big_handle(struct hci_dev *hdev, __u8 big)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
@@ -1336,6 +1336,29 @@ hci_conn_hash_lookup_pa_sync(struct hci_dev *hdev, __u8 big)
 	return NULL;
 }
 
+static inline struct hci_conn *
+hci_conn_hash_lookup_pa_sync_handle(struct hci_dev *hdev, __u16 sync_handle)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->type != ISO_LINK ||
+			!test_bit(HCI_CONN_PA_SYNC, &c->flags))
+			continue;
+
+		if (c->sync_handle == sync_handle) {
+			rcu_read_unlock();
+			return c;
+		}
+	}
+	rcu_read_unlock();
+
+	return NULL;
+}
+
 static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev *hdev,
 							__u8 type, __u16 state)
 {
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 9d5057cef30a..8280a7a79ef1 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -973,6 +973,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	conn->rssi = HCI_RSSI_INVALID;
 	conn->tx_power = HCI_TX_POWER_INVALID;
 	conn->max_tx_power = HCI_TX_POWER_INVALID;
+	conn->sync_handle = HCI_SYNC_HANDLE_INVALID;
 
 	set_bit(HCI_CONN_POWER_SAVE, &conn->flags);
 	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 35f251041eeb..d532f4c139f9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6581,7 +6581,7 @@ static void hci_le_pa_sync_estabilished_evt(struct hci_dev *hdev, void *data,
 	struct hci_ev_le_pa_sync_established *ev = data;
 	int mask = hdev->link_mode;
 	__u8 flags = 0;
-	struct hci_conn *bis;
+	struct hci_conn *pa_sync;
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
 
@@ -6598,20 +6598,19 @@ static void hci_le_pa_sync_estabilished_evt(struct hci_dev *hdev, void *data,
 	if (!(flags & HCI_PROTO_DEFER))
 		goto unlock;
 
-	/* Add connection to indicate the PA sync event */
-	bis = hci_conn_add(hdev, ISO_LINK, BDADDR_ANY,
-			   HCI_ROLE_SLAVE);
+	if (ev->status) {
+		/* Add connection to indicate the failed PA sync event */
+		pa_sync = hci_conn_add(hdev, ISO_LINK, BDADDR_ANY,
+				       HCI_ROLE_SLAVE);
 
-	if (!bis)
-		goto unlock;
+		if (!pa_sync)
+			goto unlock;
 
-	if (ev->status)
-		set_bit(HCI_CONN_PA_SYNC_FAILED, &bis->flags);
-	else
-		set_bit(HCI_CONN_PA_SYNC, &bis->flags);
+		set_bit(HCI_CONN_PA_SYNC_FAILED, &pa_sync->flags);
 
-	/* Notify connection to iso layer */
-	hci_connect_cfm(bis, ev->status);
+		/* Notify iso layer */
+		hci_connect_cfm(pa_sync, ev->status);
+	}
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -7094,7 +7093,7 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 	hci_dev_lock(hdev);
 
 	if (!ev->status) {
-		pa_sync = hci_conn_hash_lookup_pa_sync(hdev, ev->handle);
+		pa_sync = hci_conn_hash_lookup_pa_sync_big_handle(hdev, ev->handle);
 		if (pa_sync)
 			/* Also mark the BIG sync established event on the
 			 * associated PA sync hcon
@@ -7155,15 +7154,42 @@ static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *data,
 	struct hci_evt_le_big_info_adv_report *ev = data;
 	int mask = hdev->link_mode;
 	__u8 flags = 0;
+	struct hci_conn *pa_sync;
 
 	bt_dev_dbg(hdev, "sync_handle 0x%4.4x", le16_to_cpu(ev->sync_handle));
 
 	hci_dev_lock(hdev);
 
 	mask |= hci_proto_connect_ind(hdev, BDADDR_ANY, ISO_LINK, &flags);
-	if (!(mask & HCI_LM_ACCEPT))
+	if (!(mask & HCI_LM_ACCEPT)) {
 		hci_le_pa_term_sync(hdev, ev->sync_handle);
+		goto unlock;
+	}
 
+	if (!(flags & HCI_PROTO_DEFER))
+		goto unlock;
+
+	pa_sync = hci_conn_hash_lookup_pa_sync_handle
+			(hdev,
+			le16_to_cpu(ev->sync_handle));
+
+	if (pa_sync)
+		goto unlock;
+
+	/* Add connection to indicate the PA sync event */
+	pa_sync = hci_conn_add(hdev, ISO_LINK, BDADDR_ANY,
+			       HCI_ROLE_SLAVE);
+
+	if (!pa_sync)
+		goto unlock;
+
+	pa_sync->sync_handle = le16_to_cpu(ev->sync_handle);
+	set_bit(HCI_CONN_PA_SYNC, &pa_sync->flags);
+
+	/* Notify iso layer */
+	hci_connect_cfm(pa_sync, 0x00);
+
+unlock:
 	hci_dev_unlock(hdev);
 }
 
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 16da946f5881..5c740f1ef020 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -77,6 +77,7 @@ static struct bt_iso_qos default_qos;
 static bool check_ucast_qos(struct bt_iso_qos *qos);
 static bool check_bcast_qos(struct bt_iso_qos *qos);
 static bool iso_match_sid(struct sock *sk, void *data);
+static bool iso_match_sync_handle(struct sock *sk, void *data);
 static void iso_sock_disconn(struct sock *sk);
 
 /* ---- ISO timers ---- */
@@ -1199,7 +1200,6 @@ static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 			    test_bit(HCI_CONN_PA_SYNC, &pi->conn->hcon->flags)) {
 				iso_conn_big_sync(sk);
 				sk->sk_state = BT_LISTEN;
-				set_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags);
 			} else {
 				iso_conn_defer_accept(pi->conn->hcon);
 				sk->sk_state = BT_CONFIG;
@@ -1576,6 +1576,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 	struct sock *sk = conn->sk;
 	struct hci_ev_le_big_sync_estabilished *ev = NULL;
 	struct hci_ev_le_pa_sync_established *ev2 = NULL;
+	struct hci_evt_le_big_info_adv_report *ev3 = NULL;
 	struct hci_conn *hcon;
 
 	BT_DBG("conn %p", conn);
@@ -1600,14 +1601,20 @@ static void iso_conn_ready(struct iso_conn *conn)
 				parent = iso_get_sock_listen(&hcon->src,
 							     &hcon->dst,
 							     iso_match_big, ev);
-		} else if (test_bit(HCI_CONN_PA_SYNC, &hcon->flags) ||
-				test_bit(HCI_CONN_PA_SYNC_FAILED, &hcon->flags)) {
+		} else if (test_bit(HCI_CONN_PA_SYNC_FAILED, &hcon->flags)) {
 			ev2 = hci_recv_event_data(hcon->hdev,
 						  HCI_EV_LE_PA_SYNC_ESTABLISHED);
 			if (ev2)
 				parent = iso_get_sock_listen(&hcon->src,
 							     &hcon->dst,
 							     iso_match_sid, ev2);
+		} else if (test_bit(HCI_CONN_PA_SYNC, &hcon->flags)) {
+			ev3 = hci_recv_event_data(hcon->hdev,
+						  HCI_EVT_LE_BIG_INFO_ADV_REPORT);
+			if (ev3)
+				parent = iso_get_sock_listen(&hcon->src,
+							     &hcon->dst,
+							     iso_match_sync_handle, ev3);
 		}
 
 		if (!parent)
@@ -1647,11 +1654,13 @@ static void iso_conn_ready(struct iso_conn *conn)
 			hcon->sync_handle = iso_pi(parent)->sync_handle;
 		}
 
-		if (ev2 && !ev2->status) {
-			iso_pi(sk)->sync_handle = iso_pi(parent)->sync_handle;
+		if (ev3) {
 			iso_pi(sk)->qos = iso_pi(parent)->qos;
+			iso_pi(sk)->qos.bcast.encryption = ev3->encryption;
+			hcon->iso_qos = iso_pi(sk)->qos;
 			iso_pi(sk)->bc_num_bis = iso_pi(parent)->bc_num_bis;
 			memcpy(iso_pi(sk)->bc_bis, iso_pi(parent)->bc_bis, ISO_MAX_NUM_BIS);
+			set_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags);
 		}
 
 		bacpy(&iso_pi(sk)->dst, &hcon->dst);
-- 
2.34.1

