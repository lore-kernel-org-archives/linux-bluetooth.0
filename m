Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A979CD6E78
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Oct 2023 14:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbjJKOYb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Oct 2023 10:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjJKOYa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Oct 2023 10:24:30 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2083.outbound.protection.outlook.com [40.107.105.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940A192
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 07:24:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3GUI6i9y+Qr3Wxh3SGITK4rq0VN8jt4sL3WoEltwSGNbTo//iOsMGjy2v4mA1IzdRONR1FAi35PESNYax6NbHlIU7h9GxTkoU6EIWq9DnCuAorvdtVjFJS3/Pf5yYGBpq+IqYF8UGFEhbcnQqheubMwCusf3XE2KQEhYvC++urmt8XNzlx2f5QRIpjDCmYiWnhx+sz8MkbLbXUHJlHqbutKqNMEsr9zXhff9FK2TCYqzQkMywP1jCyfubkAqpHPZ8ZEC1+7iWGmYxYCiGbfMA3/slvIqKZCPKKV6CNUgzJvtQ/GZFZLCpo90NtgzWv3RiKgDrCeQ0xCo+AM35rKvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJsmn+gZVod0csUGG5lm0hBKtZqrUbuT+t/pdHpuZhs=;
 b=WXW0ziqfu+5dwDLvGQ9GMieX9nxcHfsVbakj+qskCPy/RulJcjpfHv4vNSPROJeJplh181uVFGUAYR+9ItmXkThs4R7ZTsgGVYb9Fn4JjFZ4BrM4vgEnSvxoP1ulrMhXbLzod/Ff0bHKUKV7DVYOe5Aepfh9s2uWPcKFqBwjidFZOEjg3WO8ymhl9mL2bk9t3PI+5IteJ5x7dbAD265LOfPwCyqYL4T+zs7TEjhVDXM91jOlASwU4nFI5LIdfWzWE5a9kw8PJp6iDcb1cAXwb1KFKQr+pTAo1wg/razAEdyrTqM6LrjA6Y4rIbejGTqA5pMr2jkZTaua9z3qEDJTqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJsmn+gZVod0csUGG5lm0hBKtZqrUbuT+t/pdHpuZhs=;
 b=eKGElLPnTT9QTZjG8JRBDKrWAKm9tFQS4QzFJ+TJ+AqURpBvcqCtI8dDwUYNLUzt6rPFxqY9tVklTfShkGQlGmwwrjumEVvgex9306Wr55VSVCCW7m9X7jUplW9xN4I5jrVf7mou/njnGUiMY+bF93LX8zTMQNtbud8ciFqNdIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VE1PR04MB7471.eurprd04.prod.outlook.com (2603:10a6:800:1a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 14:24:26 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 14:24:26 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 1/2] Bluetooth: ISO: Fix bcast listener cleanup
Date:   Wed, 11 Oct 2023 17:24:07 +0300
Message-Id: <20231011142408.5529-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011142408.5529-1-iulia.tanasescu@nxp.com>
References: <20231011142408.5529-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0010.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::22) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VE1PR04MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: af99d9e7-4f06-4df0-75f0-08dbca65c5b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUyo4mD9LmBPxUD2s2GZ9HXFKU1MhqkPfzNvgrAmTWkHcE6DxtpkrzO6EmVdykND1FqaBvCrIDX/yhzRiC2ZJPFgf00+fyCVAaOrajdRUZ7QzJ0BkxX4Io1c/CVaMkOyaPT6I+yqbK7ZCIy/SAF3NiGgWZ4wB3vowSDMpPE0OvNJNMfn4eOt/c7FSEjWFNajLhv6m6CtRi9UhKbUNolcdNkJiVEIzJIMzSwsIBvoMfXKAlOBW+YEb+sSqGzHSwmIvbXMKKYLsmn88ac+I08eS6nwPCv9lOAYxZIoVQ1zKuLOmkRpl3x+h521FEncFpAGlX1Zo3iXZ4BpYFqQRSAmH5zqZsw+g+2S2NGWX1yPwLxw8IcQo0doi6sXAYaxC8IYDR/dVZ2Hr/vOoCKWM+pHow4PDjw3WV/rI82oJPCrWBHzR8LeYMYX75fnbt8TDZoPQC2Igw2PMSZl7UK+dfeS72apURncRB6U1jE9d9ejCfsNvdbcZHm1mnGdenbhBuzqgHuxbQ4riMdCnVumlQaR4ORyhQfQGjXpGMvh6ycvef/wkDjHPpZyOwpWTFUxzuOCUMsXoLaOAW84LywSxYwN7TIU4ZAezWkvDECH3UBMO9WIX7j2sCYfWeMnhi5BDcrb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(4326008)(41300700001)(5660300002)(6916009)(316002)(8676002)(36756003)(8936002)(44832011)(2906002)(2013699003)(2616005)(26005)(1076003)(86362001)(83380400001)(6506007)(6512007)(6666004)(38100700002)(6486002)(478600001)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hnJJHkEcqyxLOgZ1p1bKxBKG6Rop2z1JidxDdUQF7dBNaD/6h1qZILNu3OSF?=
 =?us-ascii?Q?EvLzrmnJO6NlP2pUQc/gdUQBHkQzuTxh1DLd2pQqus4rc4smEHwwatOmkTIH?=
 =?us-ascii?Q?ROwznEUIe5X1Avgsi6BlojESLktNA4Xf9Y0ZqjHIK2RA9jey9kXkeTI07CrR?=
 =?us-ascii?Q?yoTeiArx/SKDm/ZNvNF+ArC9cWUpxod8H6mM2Wt7Hbe1U5pdZ+PEq8WzRrd8?=
 =?us-ascii?Q?BtDjkF3hPZ8P43fo8r/tL3wqBsfHAtVgfdU+N9m8MqVsx82Gt74NjdjZEekr?=
 =?us-ascii?Q?49OPbzZwonb+bxHVybuEpS6cY7OaoEV4uptFav3GNcsRNVtGQPBkY6poGhCj?=
 =?us-ascii?Q?j6qvHwHLIavwHa8trcJj3MyBjsNWDqq892/9dX2L1kFjdduaCmnLU6yHiS6+?=
 =?us-ascii?Q?lkfigh4lykb2brfY06K0LzC/v+V3Ntp0oPgf/JSchJxCe3xf387RJIfG2Wnc?=
 =?us-ascii?Q?Z5v8meXb7AEhymOGp3RCpHpMR0gkky8kDwU6KXHnJvuKmFreNEvXDq8ShSVH?=
 =?us-ascii?Q?Kh4vJ2vIxhkNMGq4OU7SUB0PNZXVPMU+kQnh/ABKtWY1QqDVYApLBuqSyhFZ?=
 =?us-ascii?Q?MUWM6w0hvfpGKmdGke2vtWowvE3OGVfuVc+1X2DTm1FJ1DFj+OUzwmqczh4v?=
 =?us-ascii?Q?iFEQw462ryE1BE166lpqnbhiamI97SvoV8XZPF1ww1FiRq1rRYLN82YN4HIt?=
 =?us-ascii?Q?5o1Jm/OBYdFxvfCepMHzeYKnbeSP3qyIN2YI4Q4JEsHvPbaKCnbxV0UmIz9G?=
 =?us-ascii?Q?z9u72m1zIq1kkExTec3w2PVa56WkR2AWVmivy89mCC+bGe/I+X2gQXj5711p?=
 =?us-ascii?Q?9x8c8DyJ0jMDX70lf3nQgfxb5CDbYj2evDyQM5Tb1YsVsi8x+uQLrBX+peWk?=
 =?us-ascii?Q?kFRr9qrb9/hIDe7Q2ruB1Fau26ZAzcjxc86dygCYmBo3L5D8EIxpTB1iXlHZ?=
 =?us-ascii?Q?RSTle1TU04x/esnP37nHzwIz0yktyxEP5CYJyvwWBF2/DrJ7DA+5kphU9KaO?=
 =?us-ascii?Q?Czi7Y/luuqQz86vA2CVG01AuLl/AAY6XSmshrKKV9S3Is4epKT5cVfK7W1eS?=
 =?us-ascii?Q?msVCJSkQ1sCVO9Yb03yM8yTk1OKw6aXxwUQXTql3THKVhOZiP3DlZprKzWlL?=
 =?us-ascii?Q?enLhiEx9wEjkIAU4+6FBn3wXJ2Bp8ti01/yf8808ykgR+NV5Xo2HfQ+HxBAJ?=
 =?us-ascii?Q?LatAcZJ383eEXsjI3nA/q1Ghdd4IGqrtjdoY/FdAchQmg4IC/0Jxeq8Rd2V9?=
 =?us-ascii?Q?Khj3pvM7d2+PplDNWUudV4FVUXboHnElo+tddFjoi0xwwLoOyDkQj2p1ZCGV?=
 =?us-ascii?Q?GC7RUlNI+2AGTh3rKwc6pzwv2DWNgwIiV74wf3j597Jkebtmc1CONYFKOm7j?=
 =?us-ascii?Q?fvwHKKNSg/R3ai6JltS5N5pNCRsV8bdLuhIz7svylAz93UG60qUvYpy02U4D?=
 =?us-ascii?Q?h+13nMq5axwGM5ZFToW6SKwcSd7LO/tu+/PSlVhgMmtggf8ouNopfH0lQUel?=
 =?us-ascii?Q?TqPsyZut2QxiuE+sujI3nCUQL2cQtlBf69/1OPFfrLZivxmi8dK+b00Bd66U?=
 =?us-ascii?Q?UDorYLqhemfsHGKUC1Mw/tUhrrYPlGeN6fmODMVgCG6Z9prhBWJvS0J6yuiA?=
 =?us-ascii?Q?kQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af99d9e7-4f06-4df0-75f0-08dbca65c5b0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 14:24:26.1730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPP9s5ye7xp/yKOafTW0BhrG2hfywl4uYkcw1HgM1iq9a+ZH50X9RZKacwkhcIr8lG2ybV2oi0r+ybDtwXitgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7471
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes the cleanup callback for slave bis and pa sync hcons.

Closing all bis hcons will trigger BIG Terminate Sync, while closing
all bises and the pa sync hcon will also trigger PA Terminate Sync.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 include/net/bluetooth/hci_core.h | 43 +++++++++++++++-----------------
 net/bluetooth/hci_conn.c         | 38 ++++++++++++++++++++++------
 net/bluetooth/hci_event.c        | 10 --------
 3 files changed, 50 insertions(+), 41 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f36c1fd5d64e..99865c23e461 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1290,29 +1290,6 @@ static inline struct hci_conn *hci_conn_hash_lookup_big(struct hci_dev *hdev,
 	return NULL;
 }
 
-static inline struct hci_conn *hci_conn_hash_lookup_big_any_dst(struct hci_dev *hdev,
-							__u8 handle)
-{
-	struct hci_conn_hash *h = &hdev->conn_hash;
-	struct hci_conn  *c;
-
-	rcu_read_lock();
-
-	list_for_each_entry_rcu(c, &h->list, list) {
-		if (c->type != ISO_LINK)
-			continue;
-
-		if (handle != BT_ISO_QOS_BIG_UNSET && handle == c->iso_qos.bcast.big) {
-			rcu_read_unlock();
-			return c;
-		}
-	}
-
-	rcu_read_unlock();
-
-	return NULL;
-}
-
 static inline struct hci_conn *
 hci_conn_hash_lookup_pa_sync_big_handle(struct hci_dev *hdev, __u8 big)
 {
@@ -1400,6 +1377,26 @@ static inline void hci_conn_hash_list_state(struct hci_dev *hdev,
 	rcu_read_unlock();
 }
 
+static inline void hci_conn_hash_list_flag(struct hci_dev *hdev,
+					    hci_conn_func_t func, __u8 type,
+					    __u8 flag, void *data)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	if (!func)
+		return;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->type == type && test_bit(flag, &c->flags))
+			func(c, data);
+	}
+
+	rcu_read_unlock();
+}
+
 static inline struct hci_conn *hci_lookup_le_connect(struct hci_dev *hdev)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 974631e652c1..7727fe30e5c3 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -815,6 +815,17 @@ static int big_terminate_sync(struct hci_dev *hdev, void *data)
 	return 0;
 }
 
+static void find_bis(struct hci_conn *conn, void *data)
+{
+	struct iso_list_data *d = data;
+
+	/* Ignore if BIG doesn't match */
+	if (d->big != conn->iso_qos.bcast.big)
+		return;
+
+	d->count++;
+}
+
 static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, struct hci_conn *conn)
 {
 	struct iso_list_data *d;
@@ -826,10 +837,27 @@ static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, struct hci_conn *c
 	if (!d)
 		return -ENOMEM;
 
+	memset(d, 0, sizeof(*d));
 	d->big = big;
 	d->sync_handle = conn->sync_handle;
-	d->pa_sync_term = test_and_clear_bit(HCI_CONN_PA_SYNC, &conn->flags);
-	d->big_sync_term = test_and_clear_bit(HCI_CONN_BIG_SYNC, &conn->flags);
+
+	if (test_and_clear_bit(HCI_CONN_PA_SYNC, &conn->flags)) {
+		hci_conn_hash_list_flag(hdev, find_bis, ISO_LINK,
+					HCI_CONN_PA_SYNC, d);
+
+		if (!d->count)
+			d->pa_sync_term = true;
+
+		d->count = 0;
+	}
+
+	if (test_and_clear_bit(HCI_CONN_BIG_SYNC, &conn->flags)) {
+		hci_conn_hash_list_flag(hdev, find_bis, ISO_LINK,
+					HCI_CONN_BIG_SYNC, d);
+
+		if (!d->count)
+			d->big_sync_term = true;
+	}
 
 	ret = hci_cmd_sync_queue(hdev, big_terminate_sync, d,
 				 terminate_big_destroy);
@@ -865,12 +893,6 @@ static void bis_cleanup(struct hci_conn *conn)
 
 		hci_le_terminate_big(hdev, conn);
 	} else {
-		bis = hci_conn_hash_lookup_big_any_dst(hdev,
-						       conn->iso_qos.bcast.big);
-
-		if (bis)
-			return;
-
 		hci_le_big_terminate(hdev, conn->iso_qos.bcast.big,
 				     conn);
 	}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9b34c9f8ee02..32fb2f102a12 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7112,7 +7112,6 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 {
 	struct hci_evt_le_big_sync_estabilished *ev = data;
 	struct hci_conn *bis;
-	struct hci_conn *pa_sync;
 	int i;
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
@@ -7123,15 +7122,6 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
-	if (!ev->status) {
-		pa_sync = hci_conn_hash_lookup_pa_sync_big_handle(hdev, ev->handle);
-		if (pa_sync)
-			/* Also mark the BIG sync established event on the
-			 * associated PA sync hcon
-			 */
-			set_bit(HCI_CONN_BIG_SYNC, &pa_sync->flags);
-	}
-
 	for (i = 0; i < ev->num_bis; i++) {
 		u16 handle = le16_to_cpu(ev->bis[i]);
 		__le32 interval;
-- 
2.39.2

