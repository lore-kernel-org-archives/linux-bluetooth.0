Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B25C001B0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Jul 2023 07:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjGCHDF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Jul 2023 03:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjGCHDD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Jul 2023 03:03:03 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0DADD
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jul 2023 00:03:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATx3GKjWd0SuO769T8jCfgsOac7KiTQUbSxIp9YNPSzQ1I0IrExSzFDN8pfaBl2NK4MjBLpBn34EDjNtalikMMz5r02dU85fo8OEnwdhVWEwLNXYS4NJGUoFrzGYTS/ordS1LrgL6nzJkWmCebnklfsEGFc3XWadoFKieYAfFIQtFTpgn9M4TfmHrDfDBUOje8y+/FSOHprHMHktRu39+vxTib2pWR1iGY+g6oCGZZ/uGy+0E9xhSUK2fFCxrvbK8mFaVj08cc/wBE1jnGS4nzw/RoI/b2Msq9PSM4C5zBUEoOZ+RYLvRahMZxWYLRL+OSkkO09OuensbnYcaDNeCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1ArvyKJ6CK47Qd8D51YQIyP6kGxMEizF4+gHA/Jzr4=;
 b=IHRTdcnmPAPpqzGP5Wbv1rs7rL9JhPPDDpxfRzY660dWXE4TulPKPznUgQ0gwww4dOSl+FMHbzFC9OvYgbiTWEHCEfS56rjj1dfJ55p7kLqmd8rOGkl1DlG8+RFVhXyAsnVCrIsCzihiOH7wsvAfv/XbX3HR3O+HTJjbsnsMt5u6JiVWsFuPOMqCyIREMGrzQC7XdDqyqJZvQdma78Wji+1FrRuConC58ViPtLg8OkzSgzscyF8xOsNxxF6DSoGpn8bXESphIDwq9LBkAoGOy026XOQhgZ3UDY7s0RYo3hf46rF8aCEx0+AO9X0PPYPKbnMvqnaRoMEEqEd+IP9/JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1ArvyKJ6CK47Qd8D51YQIyP6kGxMEizF4+gHA/Jzr4=;
 b=dH0qGINWyXSSIWupHoFG/7HGd/Ue9SKdXsj4xFpgB35iUDdQfuaEXrZWlVAaPGpZAn5ko0/9+bHlf/xBrPRdaEjG2dwSwMmtZuVw7xPFaoWmrydGtGpOwth4WhM+U2cJnGApdYRG/Knp22CNIVY/vI7XeAZOM0N8SBbnq0/DzsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB7766.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 07:02:59 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 07:02:59 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v4 1/1] Bluetooth: ISO: Notify user space about failed bis connections
Date:   Mon,  3 Jul 2023 10:02:38 +0300
Message-Id: <20230703070238.4193-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703070238.4193-1-iulia.tanasescu@nxp.com>
References: <20230703070238.4193-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::11) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: f75e1192-4a64-4928-07e6-08db7b9388cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tFjI7jzopqgg7oOCm9rQxY2oYw6jwPybOdrSDWNd0K7nu+lHvzrVOveKlViOlcsbTflYzz2GlfLLrlj1o7JLa+vIM5uApeXvw0p8wCxOK+pWL/WrWiR2pb02WYTRGfkjLtU2WJMo1vo3Ek3Bo6bd5MfZoo9ARb35fjnTa9XHTBRlt8FEhnwsrl0i3xQJeQO+CEs/s89l46P2U9GBPesIpC94aph74ZtjNaPmFb/Wbrii2kkxEb1T8mKi/UfXDZzcRpqh7bn2serdZsA6RCuvGe5WPg2K1iX6WQq3CKGD+X1WQVcVen8qXX6ime1w57wlqAzddHxBlm1vvf3y3tpag2fG4EQFnKa7azcMEtL5xnbRUveslm4MGyZ6NNqewqGjGKSve7J0raRefK6U7tXEujzR2WUkb2SfxPnI1jpsniNHiyF11kVVZj+volQmmDgj5OHgZ/2dUAWLWgFvpokqJLEsRgNrNt42bSk3vJ39Ph4DzrIWNdzXMH2P8wA4pvI087JRrJtqNlJF0OtRP4QWlKmn3vesAaIe8PEDOxaBkt+pIs+R1IAP1w1Ap4lnGxM3HOI6VLnWn2vC1Eh6g1YNWJtLxKXuSjMKUEu7wuqUGpewCQpllwqU9AgQFM0E9Th/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199021)(2906002)(41300700001)(5660300002)(44832011)(8936002)(8676002)(36756003)(86362001)(6512007)(52116002)(6486002)(478600001)(6666004)(83380400001)(186003)(26005)(55236004)(2616005)(66556008)(1076003)(6916009)(66476007)(4326008)(66946007)(6506007)(316002)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KMWp47GpaDeCkKVTimj2ytcf+U23egI9/KdBbKDKLPpd34uQJZSE8IZDdKzf?=
 =?us-ascii?Q?S/RaZnDjqRsvOQdt5btr0vbMlgJ4wP8uqcjaZUYgCnMi+6xILVnhcCYCg2qT?=
 =?us-ascii?Q?tfsoumaTVOJpYObR1BpI3dhfJRICfqwe0EB2Hvcvcf7HBlKWXfZhWt0J5HgV?=
 =?us-ascii?Q?HE1OSnvFzDL1I+aV4PDA1gD9/uQX6KoKhpAVUtVrIEnyDH/ILI+kbY3vUMCX?=
 =?us-ascii?Q?ukgtxPEmZGYClSHYYAE+TLNDbB6yOUsiJJuPzQnEeNPcWWLoHj372cZnDtAm?=
 =?us-ascii?Q?vJdrDyCSC0Xd1aq9p6nYH4hBp5OP/Lhb0DFACrG6eF1lR5Fs1Vsx27FtPsgS?=
 =?us-ascii?Q?Y4HdqdMseNCFmWnmvTaKtnU02vhEeOdd2cpjX4+nwyKjC3obBsAQ8K34+gI5?=
 =?us-ascii?Q?0y41OwQSagGhnpZtZII/+CkYFvovSlXd+2ap9vfKjDK27frpxZsgh/bZNuJt?=
 =?us-ascii?Q?CazCqwT+CeYpk/BzISuqCaVmKWA4u1w3RKuA28MsjtsYAtn+ClNrj65e743Q?=
 =?us-ascii?Q?27VpG00dzsmxGy/EKhDn8JP8kziAXpNo4plUI4s0fzxaxf/YR9O6OhTyZXiJ?=
 =?us-ascii?Q?/phaDs/m2inbcvCAXwVDaJq4R1OOIu8kZnS/4nT+UmDiYhcvOyYfCi4UjvAQ?=
 =?us-ascii?Q?VGANRh7T+l7w9zMQ17C3raP3P0NkZdFU2CdmsVqbKL/ZmBwu69Pt2r2ZG3e2?=
 =?us-ascii?Q?REaOBVZuvuMx5XggkGeZ+OJ5S3s1smwp7Vcl7Ol+yC9RxZS2vDuZSKGDPeoF?=
 =?us-ascii?Q?otkx3zYHS/acUWR8apQzWkSbfshafvaEUnhf2oPTZc03HlUZWNqN/51IT8hy?=
 =?us-ascii?Q?EwmUx4S1+ko/iO6irJvdzNrg8lQs0KwSuArfaqWSWM39DoT4RaCFE6ju1NaE?=
 =?us-ascii?Q?6Ner8AZIYWtSOy5zn+zMdzcACSCnSzcvz0KRilEFtpjpL84qh50lFcUAoIzx?=
 =?us-ascii?Q?0+7xgQnMoxcH6lRAZHWL4bYcK8XyLlXNtusyyPpcy5RMc608navIDqzAHAlB?=
 =?us-ascii?Q?TMkA8GxaduNe3ficDMGlCj5kw0k233o0znHoqDpfleKeEKaMEslB9wseaeHM?=
 =?us-ascii?Q?naIzt4srr6Pgn/abqKuR8nth/TtnAQ+grsPYD7JyMWk1U5VbvQdF/860H5Xx?=
 =?us-ascii?Q?TLbMLbjnl3ruNqjtJbmxDgCBuCHelKuls3CdFAg5vGc0NlAH3dlXDzTbVUMK?=
 =?us-ascii?Q?KER+dCKwvXgi1dl2PjIGaMIaiC0lCpr9CI5g+dPpLTbFyjC7jKHINXGpaQgF?=
 =?us-ascii?Q?TaP/AHMlsjVkW4ysO5gLEDykOxEx8MJdPS5YvQsUR7gqLNhSeMO51smpm5PZ?=
 =?us-ascii?Q?9UGJYVRhHFUnVgtufwYRtpsH9PZ+FrRzkwYLNOZczSRe/zZEGkY8dTfGqyV3?=
 =?us-ascii?Q?uAjz5i5Lf6Ff/KOqaQ7xw/t+XQFDLBeCrnhnpFmwvWB27uI4WMeTk4y8m4wk?=
 =?us-ascii?Q?ROHGH9Mc9iZ3aerfp9kIbTWFcA4KqMT5ODq0RtygnfuyXz+xCATftQfdW8Ep?=
 =?us-ascii?Q?FeGC9mhwySjoSkq77arEr+cPr1A/ncbMRE1u6TR8iH0jyRSKLHoSY/FgoaQV?=
 =?us-ascii?Q?FROaUN7BF4b0b2km+D5vLtNlWXFbcYQ4RQcytMta7SYUiJZVoOqemF/ZSlvf?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f75e1192-4a64-4928-07e6-08db7b9388cf
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 07:02:58.9994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AnEbdOX4ZXjA/vNo0KiX2R2UnZe/V4Y5bdSFUDXMWBe+JhtfNxGJM0xjWjWwfmoFxeh2Cnw71cip9JB3A6p4mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7766
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some use cases require the user to be informed if BIG synchronization
fails. This commit makes it so that even if the BIG sync established
event arrives with error status, a new hconn is added for each BIS,
and the iso layer is notified about the failed connections.

Unsuccesful bis connections will be marked using the
HCI_CONN_BIG_SYNC_FAILED flag. From the iso layer, the POLLERR event
is triggered on the newly allocated bis sockets, before adding them
to the accept list of the parent socket.

From user space, a new fd for each failed bis connection will be
obtained by calling accept. The user should check for the POLLERR
event on the new socket, to determine if the connection was successful
or not.

The HCI_CONN_BIG_SYNC flag has been added to mark whether the BIG sync
has been successfully established. This flag is checked at bis cleanup,
so the HCI LE BIG Terminate Sync command is only issued if needed.

The BT_SK_BIG_SYNC flag indicates if BIG create sync has been called
for a listening socket, to avoid issuing the command everytime a BIGInfo
advertising report is received.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 include/net/bluetooth/hci_core.h | 25 ++++++++++++++++++++
 net/bluetooth/hci_conn.c         | 37 +++++++++++------------------
 net/bluetooth/hci_event.c        | 21 +++++++++++++----
 net/bluetooth/hci_sync.c         |  8 +++++++
 net/bluetooth/iso.c              | 40 +++++++++++++++++++++++---------
 5 files changed, 93 insertions(+), 38 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c0ca3f869c92..18d335df9446 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -978,6 +978,8 @@ enum {
 	HCI_CONN_PER_ADV,
 	HCI_CONN_BIG_CREATED,
 	HCI_CONN_CREATE_CIS,
+	HCI_CONN_BIG_SYNC,
+	HCI_CONN_BIG_SYNC_FAILED,
 };
 
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
@@ -1288,6 +1290,29 @@ static inline struct hci_conn *hci_conn_hash_lookup_big(struct hci_dev *hdev,
 	return NULL;
 }
 
+static inline struct hci_conn *hci_conn_hash_lookup_big_any_dst(struct hci_dev *hdev,
+							__u8 handle)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->type != ISO_LINK)
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
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 83858e6b674c..70d4a5b546ff 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -735,6 +735,7 @@ struct iso_list_data {
 	int count;
 	struct iso_cig_params pdu;
 	bool big_term;
+	bool big_sync_term;
 };
 
 static void bis_list(struct hci_conn *conn, void *data)
@@ -752,17 +753,6 @@ static void bis_list(struct hci_conn *conn, void *data)
 	d->count++;
 }
 
-static void find_bis(struct hci_conn *conn, void *data)
-{
-	struct iso_list_data *d = data;
-
-	/* Ignore unicast */
-	if (bacmp(&conn->dst, BDADDR_ANY))
-		return;
-
-	d->count++;
-}
-
 static int terminate_big_sync(struct hci_dev *hdev, void *data)
 {
 	struct iso_list_data *d = data;
@@ -815,31 +805,26 @@ static int big_terminate_sync(struct hci_dev *hdev, void *data)
 	bt_dev_dbg(hdev, "big 0x%2.2x sync_handle 0x%4.4x", d->big,
 		   d->sync_handle);
 
-	/* Check if ISO connection is a BIS and terminate BIG if there are
-	 * no other connections using it.
-	 */
-	hci_conn_hash_list_state(hdev, find_bis, ISO_LINK, BT_CONNECTED, d);
-	if (d->count)
-		return 0;
-
-	hci_le_big_terminate_sync(hdev, d->big);
+	if (d->big_sync_term)
+		hci_le_big_terminate_sync(hdev, d->big);
 
 	return hci_le_pa_terminate_sync(hdev, d->sync_handle);
 }
 
-static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, u16 sync_handle)
+static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, struct hci_conn *conn)
 {
 	struct iso_list_data *d;
 	int ret;
 
-	bt_dev_dbg(hdev, "big 0x%2.2x sync_handle 0x%4.4x", big, sync_handle);
+	bt_dev_dbg(hdev, "big 0x%2.2x sync_handle 0x%4.4x", big, conn->sync_handle);
 
 	d = kzalloc(sizeof(*d), GFP_KERNEL);
 	if (!d)
 		return -ENOMEM;
 
 	d->big = big;
-	d->sync_handle = sync_handle;
+	d->sync_handle = conn->sync_handle;
+	d->big_sync_term = test_and_clear_bit(HCI_CONN_BIG_SYNC, &conn->flags);
 
 	ret = hci_cmd_sync_queue(hdev, big_terminate_sync, d,
 				 terminate_big_destroy);
@@ -875,8 +860,14 @@ static void bis_cleanup(struct hci_conn *conn)
 
 		hci_le_terminate_big(hdev, conn);
 	} else {
+		bis = hci_conn_hash_lookup_big_any_dst(hdev,
+						       conn->iso_qos.bcast.big);
+
+		if (bis)
+			return;
+
 		hci_le_big_terminate(hdev, conn->iso_qos.bcast.big,
-				     conn->sync_handle);
+				     conn);
 	}
 }
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0b4415e79989..195cbb0b00d9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7039,9 +7039,6 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 				flex_array_size(ev, bis, ev->num_bis)))
 		return;
 
-	if (ev->status)
-		return;
-
 	hci_dev_lock(hdev);
 
 	for (i = 0; i < ev->num_bis; i++) {
@@ -7065,9 +7062,25 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 		bis->iso_qos.bcast.in.latency = le16_to_cpu(ev->interval) * 125 / 100;
 		bis->iso_qos.bcast.in.sdu = le16_to_cpu(ev->max_pdu);
 
-		hci_iso_setup_path(bis);
+		if (!ev->status) {
+			set_bit(HCI_CONN_BIG_SYNC, &bis->flags);
+			hci_iso_setup_path(bis);
+		}
 	}
 
+	/* In case BIG sync failed, notify each failed connection to
+	 * the user after all hci connections have been added
+	 */
+	if (ev->status)
+		for (i = 0; i < ev->num_bis; i++) {
+			u16 handle = le16_to_cpu(ev->bis[i]);
+
+			bis = hci_conn_hash_lookup_handle(hdev, handle);
+
+			set_bit(HCI_CONN_BIG_SYNC_FAILED, &bis->flags);
+			hci_connect_cfm(bis, ev->status);
+		}
+
 	hci_dev_unlock(hdev);
 }
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c085b54d158b..3348a1b0e3f7 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5395,6 +5395,14 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 		return err;
 	case BT_CONNECT2:
 		return hci_reject_conn_sync(hdev, conn, reason);
+	case BT_OPEN:
+		/* Cleanup bises that failed to be established */
+		if (test_and_clear_bit(HCI_CONN_BIG_SYNC_FAILED, &conn->flags)) {
+			hci_dev_lock(hdev);
+			hci_conn_failed(conn, reason);
+			hci_dev_unlock(hdev);
+		}
+		break;
 	default:
 		conn->state = BT_CLOSED;
 		break;
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 9c41af55f2c7..efac284badbc 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -48,6 +48,11 @@ static void iso_sock_kill(struct sock *sk);
 #define EIR_SERVICE_DATA_LENGTH 4
 #define BASE_MAX_LENGTH (HCI_MAX_PER_AD_LENGTH - EIR_SERVICE_DATA_LENGTH)
 
+/* iso_pinfo flags values */
+enum {
+	BT_SK_BIG_SYNC,
+};
+
 struct iso_pinfo {
 	struct bt_sock		bt;
 	bdaddr_t		src;
@@ -58,7 +63,7 @@ struct iso_pinfo {
 	__u8			bc_num_bis;
 	__u8			bc_bis[ISO_MAX_NUM_BIS];
 	__u16			sync_handle;
-	__u32			flags;
+	unsigned long		flags;
 	struct bt_iso_qos	qos;
 	bool			qos_user_set;
 	__u8			base_len;
@@ -1555,6 +1560,12 @@ static void iso_conn_ready(struct iso_conn *conn)
 		hci_conn_hold(hcon);
 		iso_chan_add(conn, sk, parent);
 
+		if (ev && ((struct hci_evt_le_big_sync_estabilished *)ev)->status) {
+			/* Trigger error signal on child socket */
+			sk->sk_err = ECONNREFUSED;
+			sk->sk_error_report(sk);
+		}
+
 		if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags))
 			sk->sk_state = BT_CONNECT2;
 		else
@@ -1623,15 +1634,17 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 			if (ev2->num_bis < iso_pi(sk)->bc_num_bis)
 				iso_pi(sk)->bc_num_bis = ev2->num_bis;
 
-			err = hci_le_big_create_sync(hdev,
-						     &iso_pi(sk)->qos,
-						     iso_pi(sk)->sync_handle,
-						     iso_pi(sk)->bc_num_bis,
-						     iso_pi(sk)->bc_bis);
-			if (err) {
-				bt_dev_err(hdev, "hci_le_big_create_sync: %d",
-					   err);
-				sk = NULL;
+			if (!test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
+				err = hci_le_big_create_sync(hdev,
+							     &iso_pi(sk)->qos,
+							     iso_pi(sk)->sync_handle,
+							     iso_pi(sk)->bc_num_bis,
+							     iso_pi(sk)->bc_bis);
+				if (err) {
+					bt_dev_err(hdev, "hci_le_big_create_sync: %d",
+						   err);
+					sk = NULL;
+				}
 			}
 		}
 	} else {
@@ -1674,7 +1687,12 @@ static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
 
 	BT_DBG("hcon %p bdaddr %pMR status %d", hcon, &hcon->dst, status);
 
-	if (!status) {
+	/* Similar to the success case, if HCI_CONN_BIG_SYNC_FAILED is set,
+	 * queue the failed bis connection into the accept queue of the
+	 * listening socket and wake up userspace, to inform the user about
+	 * the BIG sync failed event.
+	 */
+	if (!status || test_bit(HCI_CONN_BIG_SYNC_FAILED, &hcon->flags)) {
 		struct iso_conn *conn;
 
 		conn = iso_conn_add(hcon);
-- 
2.34.1

