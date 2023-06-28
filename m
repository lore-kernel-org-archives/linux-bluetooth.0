Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43118EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jun 2023 15:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjF1PF3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jun 2023 11:05:29 -0400
Received: from mail-dbaeur03on2076.outbound.protection.outlook.com ([40.107.104.76]:3936
        "EHLO EUR03-DBA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230073AbjF1PF2 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jun 2023 11:05:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKxgogm2v9jXijB9rDk9cfb7v5czmfjOfHFVb30m+wYgixupdMOAjxMf4AUw/iRDKyGkpdVyewEt5XH+gUUXgO4RlEolMEGYkH32vM/+Okabfmkx4tW1ep+6FiQPtHCZap1K2xkZnN7lUVgNvjyT0nr4tRPnQQPbR2JZR3nVTmdcECJ3mvXhg6tM1yBsKwKe9CkHMumLKfOkfLd/PZwtWkw5/9y6nuce3wqQhNYni6rAZ8x+EnYxS+PWM587bMgMLjITlKM2Kf7qcYF848NpLKu54V5znjTKswHUMFW9490ruWYa20aaI+dAhhqvaFDM4cWCYV6ZMYWE621liXA+lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKMbsFHMrKHA0TT22IyCFftafGsfDDx5ODtj3VyX8FA=;
 b=FHAKzuRHoWYT9SPSPFprSTBqafbKH35KyjSWALyChOZUHnh4/t6wq6nQk+hzLoCm5DPdGXAbLLc5K82dET3JjdotBrZif/kgY9c514n6hYE5ArrgKHl8Pbgaq15L6z9JYUQu0frORL/Y9BB1tZrSsz0ICMIfZp58Gg1cGm2WGKcmK/i6sYERUUuNK98LP1J5ja+VEwIpkmcbzkFrBRrPdFs7FuWuYwOSBwP9QWlTAPCCPvmOvgA20M/kPZUMylOcb6CIx88jQSCgwR6CM7JrQOkaqHJYHucY/+jQ3mA62fpqKePryxq+wk+fRd7NPyb9WUJP1huWS1UAzXF6qczrEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKMbsFHMrKHA0TT22IyCFftafGsfDDx5ODtj3VyX8FA=;
 b=GIPT1cC5WZY4ltVXophdRo1XJ8Fj08RbPG1Ylm2UbtFLkaUYLRD8uiYd5N+ucUCfOY7MLwgrlYkw4J4MLnLwbimODKcN3h8LBGHnVanFsk1MROZltGtESXVhhvDU04YlzKNTVTWCPtkbPiLWqTh9JxJilN+IYF2s23hYpBz1m2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB8PR04MB6953.eurprd04.prod.outlook.com (2603:10a6:10:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 15:05:26 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%7]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 15:05:26 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v2 1/1] Bluetooth: ISO: Notify user space about failed bis connections
Date:   Wed, 28 Jun 2023 18:02:32 +0300
Message-Id: <20230628150232.239778-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628150232.239778-1-iulia.tanasescu@nxp.com>
References: <20230628150232.239778-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0060.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::13) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB8PR04MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: 89be8926-e559-4f43-4131-08db77e91a91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QNscydbOwXc7o6QeKhAwU/6wUJjX3IudZJLXewBKUFFHzLuw4CzE5qPhTvB2sigcVX1aOtLaDonXC4o6p107rInJPD7L9ATgBrQZiKniOgCmkLYEsqghC8zrbnh567l9y8dPPv0leUPqbWR3QnnKwH/agQvPvsoERE7XkUBqwUbSL5KP+Wmti3zQ3X9smWQ1TbgU2Tepcpiw8SCIDyooIQHImV2H/JxtAdgxfiuy3cWZa7m4acAyLBiK2sE7A1kg/GlkcYAzohOi2x0QBGK0bsiWsfYRXzjEEJmLhRB8SC/+5ZBDQja6nY891l9dUr4u4K1rEmDWIx0LR9FCqs3EXY7cPZw3MXgtawlVk59VuYlnt0A40o3YMWJ/5oJNx5224xizaz7ZwIwv99ITjMJKiyioICza2/PDzzsddxdtm6UnA8/gifM/tQJPU3iiexTyXU4sZLdB9V2oFJz942mGyedr5uOE+sgluq/Ib1yzEWtN86yPnb6DRTbIPjglEvlNBxrzEDJ8hBDX0zK6Uii5gRra91IANisNyIJ9gQiy/bezYT3UiCoZYUFA5Z1QIbXvKgCLc52uEQaiw+K3tZB6RGELwPab8ROVoG5wzeyzi1ss7SdNa02UC73MHDaJ9Q26
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199021)(186003)(2906002)(26005)(66476007)(5660300002)(41300700001)(8676002)(6666004)(6916009)(36756003)(52116002)(316002)(2616005)(478600001)(6486002)(86362001)(4326008)(38100700002)(38350700002)(1076003)(8936002)(83380400001)(44832011)(66946007)(66556008)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UwkjiUvBYFjGuIVPRNV/I3GG5uzSls06UjRELDYppSg8CqIvaQhHxZuF7W/d?=
 =?us-ascii?Q?L9jYjiXHR6JQVhRUCCyvZ7CUUZSdDKa+rZET61XIXBELsqW2R87WBzRLoZUl?=
 =?us-ascii?Q?4A9uV2HVQTMBkYQpqQuQafOn8uiVYvW0xxyKHYrsTCunAthnvFf5JDYTmBF2?=
 =?us-ascii?Q?mglNAM4/YydMfpyvkKJerPx4czcC2j0uqSRxiuuqPXixLJwBXS+Vb02WBfYt?=
 =?us-ascii?Q?5d1M1aaZUZLlnM+6nNzAV6qHgLiE9fNdjo2okG6lFxGQhsoYeqXgjsw93l0k?=
 =?us-ascii?Q?KGjZLpZpdKUzwMOn3iWuZRZMx/4bcTigUT+x5I/P+jYPcngdWlBJOV7aS+wn?=
 =?us-ascii?Q?ejBK5ZFgVZXvTiCEFxfUxVT/nry9nI/evf/SAR2vYwWnnp2Jt4aIQj7f8c22?=
 =?us-ascii?Q?k9Z6v8DRcwF9yTf1HdLRnCZf4H/RkHBZueP5aaRqTFh+gzD6gpLNDDRxa/jx?=
 =?us-ascii?Q?tL7Mmf2JWLfTYYVTxJwhoSMDh73aGlzJBK4fpXRuqF3VvRyYTWzah/5g15ff?=
 =?us-ascii?Q?DFeHs+M3OFQTborrj7P+Is3OlrBWVIQYmGE8LwTeemlBVh8Sfp7y3jHjdjEs?=
 =?us-ascii?Q?sEYw9W1Oxra4627LWN5SoJJ98omIozkg18RXSsQU/QRUstXljjRw0B0P8yfe?=
 =?us-ascii?Q?fo9lhZIpogrmo/lsTqdrwimX3ZDKxMrBO1IznoGbmh+pDJGHrRym3ua+wNoy?=
 =?us-ascii?Q?LlsupNt7EOpGh4YxZ2OzrruCgZzRrCo9rld/d1wIZmFruOkbEkPQeVO64bkG?=
 =?us-ascii?Q?efMCsHhgg/38739l6mp6lHGbyX0Y136X3Hl7+zsBUv9mSUBy3VpeKZ2CnBb0?=
 =?us-ascii?Q?PZ8VjJ1+1CY+Dma/GH3VdFBTEAGwqzx09+kbC7+k1vgIOUoZHB0nc9kZQDJl?=
 =?us-ascii?Q?R7UrZNNW+rbEoJ0nWXdNqbBh+smd8kofV4uLGlGxr5cNx9Ut+DbM+8tF/p8F?=
 =?us-ascii?Q?QW3U7tC6mV/MdLQsVkNGu6N29T4S36YraA1WwFujtLZupnMm0rVWVz/YLDD6?=
 =?us-ascii?Q?hZNF60Sl/DB168ZHnnBVnHUcrHEqSGUj9uvPn+w7SsNPuOiY7IXUGNRX06k3?=
 =?us-ascii?Q?A9CwLgjrjUW9PPkzupVhppalfnjq1+rzhV8UJlGB49Puj9tGOjDQXHrLC54j?=
 =?us-ascii?Q?nuAGcJMSTU2tJFVxkzifqRfI0CXqP3OYnRjBMRY4DzWufwdUKCJ8E26lKfvp?=
 =?us-ascii?Q?5rKXuCEBjNGAab2uh8OOsoxCxrqjWlCOUq+PrxvLwQs2Ajyk3RgT5cfongWU?=
 =?us-ascii?Q?TZarQEzDYYfnWaS/nDsF/yJ1hnZv32wELxXA+2azMCBxYW/vlGwUfCHI+Uh+?=
 =?us-ascii?Q?3i9AEVhZGda+yrN/djuMJatLe2ZiqKwywN4UH8s0dJyNpboSUue7R/9pZqwC?=
 =?us-ascii?Q?lAzqLh5/phwprcDO9U7QE1L1ww3ScONXKOOQe7j+Hi63Pyh2i+rHn3pVt9W2?=
 =?us-ascii?Q?XU5m/lK7GpWp+vC7v9kz5Rxw2e+C7yOrQ3Pxii1Af5n/avjkTgDUO0HQNb9q?=
 =?us-ascii?Q?IIhtXw6iabZ0B0kFhlydzT/SjnuEGvMc23ZWLlXLinN+PlTKIKDAupTBqqwJ?=
 =?us-ascii?Q?7SgYstWHd1yLOZvV8CRhBJXILe406PUkXcqF5vDAzXQOGOwK4wSCAG9ZH1Jz?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89be8926-e559-4f43-4131-08db77e91a91
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 15:05:26.0956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYBB0EZtq0eZ5ytfdRl6sReYRzbu3SixB/etOS0RRBNcZhb5YpCPC8TLhq17acIFT3fOaG+K309MRjM5qX1b5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6953
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
 include/net/bluetooth/hci_core.h | 25 ++++++++++++++++
 net/bluetooth/hci_conn.c         | 50 +++++++++++++++++---------------
 net/bluetooth/hci_event.c        | 21 +++++++++++---
 net/bluetooth/iso.c              | 37 ++++++++++++++++-------
 4 files changed, 95 insertions(+), 38 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 05a9b3ab3f56..f068a578ff59 100644
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
index 47e7aa4d63a9..491ca8e876f0 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -686,6 +686,19 @@ static void hci_conn_timeout(struct work_struct *work)
 		return;
 	}
 
+	/* Cleanup bises that failed to be established */
+	if (test_and_clear_bit(HCI_CONN_BIG_SYNC_FAILED, &conn->flags)) {
+		conn->state = BT_CLOSED;
+		hci_disconn_cfm(conn, hci_proto_disconn_ind(conn));
+		hci_conn_hash_del(conn->hdev, conn);
+
+		if (conn->cleanup)
+			conn->cleanup(conn);
+
+		hci_conn_put(conn);
+		return;
+	}
+
 	hci_abort_conn(conn, hci_proto_disconn_ind(conn));
 }
 
@@ -793,6 +806,7 @@ struct iso_list_data {
 	int count;
 	struct iso_cig_params pdu;
 	bool big_term;
+	bool big_sync_term;
 };
 
 static void bis_list(struct hci_conn *conn, void *data)
@@ -810,17 +824,6 @@ static void bis_list(struct hci_conn *conn, void *data)
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
@@ -873,31 +876,26 @@ static int big_terminate_sync(struct hci_dev *hdev, void *data)
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
@@ -933,8 +931,14 @@ static void bis_cleanup(struct hci_conn *conn)
 
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
index 77cbf13037b3..30d0a6631e17 100644
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
 
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 84d238d0639a..e0386b12ea4e 100644
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
@@ -1569,6 +1574,12 @@ static void iso_conn_ready(struct iso_conn *conn)
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
@@ -1637,15 +1648,19 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
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
+			if (!test_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
+				set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags);
+
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
@@ -1688,7 +1703,7 @@ static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
 
 	BT_DBG("hcon %p bdaddr %pMR status %d", hcon, &hcon->dst, status);
 
-	if (!status) {
+	if (!status || test_bit(HCI_CONN_BIG_SYNC_FAILED, &hcon->flags)) {
 		struct iso_conn *conn;
 
 		conn = iso_conn_add(hcon);
-- 
2.34.1

