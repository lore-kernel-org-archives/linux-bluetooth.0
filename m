Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACCFEB64DA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jun 2023 14:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjF3OuG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jun 2023 10:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjF3OuF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jun 2023 10:50:05 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2089.outbound.protection.outlook.com [40.107.104.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E742E58
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 07:50:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKsanMysYz1ciX2U0UqG/3AoIQrrJ7B7NAL5kPR8BkKj78VxiXmwbNqqSrdw5jJF5guJwd1H4WQvTAFwGUmFwKJqKy42SoV0oJaOkg4PUDwnhytN7pWiwQZSm1iQNvaxIOXYQkPtYJ6LbSrdygC4jC1j1s24s87ajQlfp0V2WjsDc1viNAF1X3w5i7eRy0eTBiUKB5wVmnP9OMm+PnDqRnLlfF1cN7/aTn+ZJXwWa3+Oy8wLLeOxeW3xI66IMUcUuI+9bPR8nTxX2rCOs4CSIwbf9ve9eLpI2H3tRGMdsE9A3eGAo1MN6XoeVswpnzqgiD1HW+jnGmDFw8mHe9Q5PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRNZLJQDdMbWL4Ye4LI/LdV6BrmP3AU8OuzTD6ewA6U=;
 b=Oe+QLxkNDNdTaKB2MW/Eh++pAF2KrPDLEkwkAT69XJuq+DrW+NKMa2wJ1GNprZGO9foFigBGKgQemeAvjpJavWubmEocaLjZH+nbNacOrB9VCQ7Qqa688sonqfow/ioDVpAT98seQxgO0QXOvy+5NOfeGOGhfsxjJTCtinXn5YQZnKZS83fkK3PKY33M7DKGIilBuyJAMjuU6uEBRxqy4hAQMZwvegZVc6R64lXAp/JTfJw53opqfvVEbFrt9pJOatdSojSyfprjkNqkTthkRfaN4+JjqKGIwPV6vX++Kwcj3mieyvRtGhHbc8YV/dlSwJTbhkmJ1FHfr4pJlk4Raw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRNZLJQDdMbWL4Ye4LI/LdV6BrmP3AU8OuzTD6ewA6U=;
 b=mJMujvZ5y240yMh9jx//tBvM2fLeZVis8CO+7OSRownfZhuaXbiYXU6XGKWkKvRpteGGNx0CjQQ8rl3b0uG/fp34Bfpt2Im13HuRuIsffTW5ubNxWqi3PQkcJrdFo2u6L7fi/W5g9EKsOp3PzgZcuezzwzUyEIbGKpQvFa4FMbs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI1PR04MB7118.eurprd04.prod.outlook.com (2603:10a6:800:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 14:50:01 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%7]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 14:50:01 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v3 1/1] Bluetooth: ISO: Notify user space about failed bis connections
Date:   Fri, 30 Jun 2023 17:49:30 +0300
Message-Id: <20230630144930.216553-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630144930.216553-1-iulia.tanasescu@nxp.com>
References: <20230630144930.216553-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0013.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::18) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI1PR04MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb5507b-2ed5-4b44-31a6-08db79794802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MYe45aDkU8PJIry/FcD4SM+HH/5ru2B3iyzYw3/RbMjxkl9bk2BqBBV1YlhtnzaiblTEbKATBxnt9aEtaln2qREYq9pBLCea8UBYVijl4EKbGM/vdP52XSyYWhhgB6ZOhjPWKqZ7a7DpZ6qCf7n7IVFL+ODzUD99YDbnonugu5sCnctKyAcwV+mmnr47p7n5rIxLZxNo6NX1NnhjS5p/XCFVCTvsjg2U7xskjXT0cdi8n3hFSLNnVV4RtsOz8zGXJ6FUwHh4OG9qqy5qoN1OKptGtSkiT/VWOESLXxhoOQEglfKcwyTD6L/P+XnqE0NCkz1ysFi7IC1vmoiFgy4YAcO0ZGrZ1f/X45JTPWrzgaMYc5L5EbQNvLNq4ANHJ9yFtuRrvvfAdIwgI/YHwBDiHs0G6zWWxDPmK7kVDm21ZJyrfDYs0In/emlBCh0wkAsrWGTMAiA7rkHWdo/q/WC7Mknsy8DSRilqEUvIaJ8ykUjqlcWuICbik/yVz2Kn6d2EjWI19GgaJyb8ZCauP1xo03jPBE8YFLoTh9ZPKsgUC0PVoxrS69KRBrcEO4NoTDezTmBD17RHlPECwYnxJq1pJGZ2ogWgYFnmdFVVcqA+htXCnYUxNlGQbNzeAHHWF980
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199021)(4326008)(316002)(66946007)(6666004)(478600001)(6916009)(66476007)(66556008)(86362001)(36756003)(83380400001)(186003)(26005)(2616005)(55236004)(6512007)(1076003)(2906002)(44832011)(5660300002)(41300700001)(8676002)(8936002)(6486002)(52116002)(38100700002)(38350700002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XhTtpiABRyttuc1n1OeJhpK9p7PQveoX4RbvYLw/iCcOARTlXhUl0H5t1oSd?=
 =?us-ascii?Q?87b9QArqLVBYoa9ZMJh/zA0VPurplVH/+yKkfmVvTkIF8vs9khvLjt1p90a3?=
 =?us-ascii?Q?q3W1prLk4Lox/KXqvP9TC5lwTtPFYtvfl/HfH7BR6foL2nGjOfv6i/AJG3pV?=
 =?us-ascii?Q?96zx9/vhYOLqQbsCXSAvirdfakJY1Nc0YClVu+cvWi7/3m6P5DhTM1V70VJq?=
 =?us-ascii?Q?8uWABoZQXq52MAOctrRC746tlnYh8/uFW0n3SeBlBlPnnhzSBCxTNXcZRCsT?=
 =?us-ascii?Q?QM0OWURAS6FQp/lSMUC20PMWoF+jvsklhDxRv1r3qWdAqTvJIzCJcejSBrtl?=
 =?us-ascii?Q?vbTXX6slWcdEAKqw/7sSTIZC03IcoukEEpfL6y2+JsBClkOJzG/xWCuCn23K?=
 =?us-ascii?Q?LtBDeyFL2NCZIbkNr0I61AGUTXYxfqIoKr76mKiMHThvmcGkA2RIJOKmlUtB?=
 =?us-ascii?Q?6pixu6S1yQT02Of4gyHB4b2RrqJ9z18tGhF6xj6qu3lw8Ii4wvdwq7yLTphm?=
 =?us-ascii?Q?Bw1RI2f8vuwxsyLP8nfCJKGzfO7eEe62RC0YAH8c4N3owwCUN+Prh49oewgV?=
 =?us-ascii?Q?0du/Ixyr4dvCB6R7Q2riuaoN03PHzi1jI1q2HlF13/9tanvErbwfbpBnWEYV?=
 =?us-ascii?Q?qdwBhTA3BXnd2bUOHWhBNh1yOflNWX/pD67PWAfzCWt2/foo26dxuRvVqJSl?=
 =?us-ascii?Q?5aVjuw2EY2WTxnJjr2dx8ZbPECLx+h4QCzdLq2/Tal6J5AOts0zPeKGRLVs0?=
 =?us-ascii?Q?ozpNTlyapizYQqjVXQgKfWbxs4+hBAusPNm1rkgcp3K4oLfpWA9fuj3WR0Bg?=
 =?us-ascii?Q?tMAKXRr+eQzsI3fzvy++jjWSLnGicFNP/d8VS5tT2uPizrt7nztWaZp/kPsh?=
 =?us-ascii?Q?JLQuNl92oY8ft2D1LvUQSiNibZ02SprWa+ts17YB1DnRhN0eiNYPlnL2dEZd?=
 =?us-ascii?Q?N/FgGixIIvnC6eHBgY2rp3JGoo7YVibY+Y1WZpYPuas1n4PHrukSLmUJoKz0?=
 =?us-ascii?Q?voPkuBToWTBKnZAiOj4DpjWoPHjiJrISf3u92wxKtFsjoFG/kHtqU+AXAjxk?=
 =?us-ascii?Q?w3T0dlymfGDH1hWaWxr9mLd64cdWW79zbjgqDOKFCip3KTwdkc5kFy+tAiqR?=
 =?us-ascii?Q?6466YbxVlnF1849/jT+M2RIna45hsMQlN94Fjk55rIK4KZlUgvyaJAPQK43D?=
 =?us-ascii?Q?DWe5+1putPkqBGVm6gtSwS2/jS22EoivOSH3br5w801cVzjb2BZ1pIeOLZLj?=
 =?us-ascii?Q?8LmOmgGK+2wmpVZ6h6eF2HZRSzCoejm9qksk6LLPDpR/BC6cXttwzVsdl62P?=
 =?us-ascii?Q?jqOru/h5tHnZiyvKEoZ3TW9CH5HqGxbUSg87aAmY2QiTezPPjaq6uyvx18di?=
 =?us-ascii?Q?f8Oc2WDAHlRKqH7vC4ApNFIQ/D+D1wm271g6OFkkpcUoi5O3l1ZSAfug1aiq?=
 =?us-ascii?Q?OKjD6NZcx2C8AdPSg6El8VUBfFnR77Pp0nFNysYq4xgf3wAC/EeUHDeknSfA?=
 =?us-ascii?Q?tjiYQOCaKlhokvNs3O5ZLWXTgQ/xz9EFwdG794Of8CzXoxzh/4cxIG7a+14m?=
 =?us-ascii?Q?9JKUjxw+M6uemSmu841JtJihXUupxmP0qXQEc6gMksn1YXdX7o9/eaPBzggI?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb5507b-2ed5-4b44-31a6-08db79794802
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 14:50:01.0164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7mTK4UFFNU3mpWyOAYOclv8ufo/8XvOlLDKZ1PutK6urJEG8GPxM75n7GjA6/Jfp0GrfdLY7gkuqTnisgdQv+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7118
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
 include/net/bluetooth/hci_core.h | 25 +++++++++++++++++++++
 net/bluetooth/hci_conn.c         | 37 ++++++++++++--------------------
 net/bluetooth/hci_event.c        | 21 ++++++++++++++----
 net/bluetooth/hci_sync.c         |  8 +++++++
 net/bluetooth/iso.c              | 35 ++++++++++++++++++++----------
 5 files changed, 88 insertions(+), 38 deletions(-)

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
index 9c41af55f2c7..6dddb9eb7a99 100644
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
@@ -1674,7 +1687,7 @@ static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
 
 	BT_DBG("hcon %p bdaddr %pMR status %d", hcon, &hcon->dst, status);
 
-	if (!status) {
+	if (!status || test_bit(HCI_CONN_BIG_SYNC_FAILED, &hcon->flags)) {
 		struct iso_conn *conn;
 
 		conn = iso_conn_add(hcon);
-- 
2.34.1

