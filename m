Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DD7C001E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 14:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbjHBOh0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 10:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjHBOhY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 10:37:24 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C2D11B
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 07:37:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cc4RLoIEgG/MXPq7rLywoZ7f6b5gY85Jp0aeUr2b2v/GgvLml00jCzGGFWL3puZ1eAx0Ytker2T3Gu1HY9fyy0w9M9frHhNQqAV2ytBEkOdhT7az13kNGZw6rhVzctRdryI7Ja9lmsjEcPBALXqRshVj5VaEFJNO79dBuVpjJA4MUax7AP2ltkFoN7dik/Oe2TvgJ1vqaHXvmKMzEB2f7BzaXlVheRWnnL3R2qlx1OdHYN+DbDCMotRpQ78GbuoLrHaChJu5/Dib8oi/HdmdwPf95cwiINzBoblmUdbj61Nnh4wpkMKp0uVj/5wG/r6YrmUJBx+kpMKn9Lu4Xtfl0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKFOCjaGaHgY3DqB7VUuLbkZZ62txq78O7oEyFrf5Ms=;
 b=L8WnLYffPJY/3bul0FQoSQZY+pPd9MvRr3T65TvtkN8ZTaSazdkuZNufU+KJlBWB/rSENKAFpFRvjiQmOgmzntEaEJ6wJmeJwisNBqRJ05ucqnVydflK1E90Y9QXp5wSO9ckjCqhyvD7uRHcialN7ZMJ+x7y+NgrC5d31BTFQxHp2AN7Fq2qLbclyye0jIsvmJYDUbC9AlKxVHejvdHBFxZ3AkyNP76HS3gl2mRdKR3tG4sf81/GK4fzt9eDrb/kUtea/fziKrK4R+UOGbSRB7Q7ai7InDLYmy0x5lgZ1Uj97LSY8EyvBn1l49WXI3iKLUwQlrY9ZDBWqrQrUbdDZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKFOCjaGaHgY3DqB7VUuLbkZZ62txq78O7oEyFrf5Ms=;
 b=KH+aOUZfLtF1l+srqbCtNlAPIg0QppLMYfSeyaaxbraXwUfQxegNXKftrKFNK8O/aByDcoECVy/r/oyp3pxIO36IDmUkHal6R9gqQjbiMBtUtIrLdc7zMDyPmWw+vUllfbklDnaDIlet16+KDAlxRnNgmwqe+4AJmzDlveQH7hk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB7582.eurprd04.prod.outlook.com (2603:10a6:102:f2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 14:37:18 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 14:37:18 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: ISO: Use defer setup to separate PA sync and BIG sync
Date:   Wed,  2 Aug 2023 17:36:38 +0300
Message-Id: <20230802143638.59945-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802143638.59945-1-iulia.tanasescu@nxp.com>
References: <20230802143638.59945-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0016.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::21) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e362d3b-5220-4e3e-9a61-08db9365f917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o3fPnGFSmtiC8Ky3GOUfwEjqLJp+o0W3N+exMTqz5F/E34oPJG4rNfC28Rq2tgxGieJS4IubF0w6lRh5MUb3NaiousrDHFbeBov/OvftfZZ1wsTfovLmxagM9eNITx+J4TS3LoSJ5vikFfl6tdS4M8Jja+OCtTZQqMtFGATgaR0Ny7c9QhQMuGEHVLVKHxMUNAgK3hDl+vpZrQcN9c4uhTSP4PUHjOq0ILQqjejB/NnWHI3bg6zbyuyb2pFJaCIDiTkRelcYNs1g68euqOcDtt8BXphfLqG4oC4kFlMmZsCHaZDG/j7PM4fWe/ZxlUsDMNoEga641SlzjA4vUxVHxryYzYbkT7+IgRtwx6Vyrq4PJSl6Zcc3RbliATeK1JHlGVnnHiEAHeIfPMs4asHN7lPezLMZo9YO2pWf6wBGukMhBrYi1TjW+xgx+jGJJyX7EniQPYqL3GSQPtiYCqDsgYch06Lfpylr3u4dnBk5YDW3gaLz7cClGv52rIHu2TX2eZt2jc0tyVDmk/IqS42dVG+xFblVzreXjDdFFM6VzHaYYdXxLeFYLiT2wPhR9S84i9Bpumw9uxM1rh01sYRJOmtdvIjWzjDwemSEaS6hJbTtMq5eYp89uwf24ITQX22k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199021)(4326008)(6916009)(86362001)(36756003)(38100700002)(38350700002)(52116002)(6506007)(2616005)(83380400001)(1076003)(186003)(26005)(6666004)(6486002)(6512007)(478600001)(66556008)(66476007)(66946007)(8676002)(8936002)(316002)(44832011)(41300700001)(5660300002)(30864003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gIGrw7+U3WN1PYA58o+X3Vwv9mCO3P9tTrX1juE7Ct6kUFYz31kD+ySt+Y2t?=
 =?us-ascii?Q?OtVO7HF6sjrJrSykYRboNcc4Yq78rQ6cl4DJvA/vIN4MzB3LDkFbKdXxM1u8?=
 =?us-ascii?Q?lulYUW9KSmjgycjwwvz2mnRKtEN9LVjuLciejKYVMdzgG1/ni86dvh2rgt8B?=
 =?us-ascii?Q?bjq5G26WG1YlJ5WqE7OX28EAgnDH1AqLTpzTW0kZ9QmLRiZdSLWwq6UxHcmX?=
 =?us-ascii?Q?+bb/pwVpXKk+K4EH0q7+Mp7B/gqeY2OKxUxDCu+DKbjw+uPAEZeqWqubKwr9?=
 =?us-ascii?Q?rtzdO/2PVa00CoYAHGhN6RAOhFIs/XwRIqVLjUcCElM91nUuI+bA4e2l84dc?=
 =?us-ascii?Q?uWlMdH4Kzcig4jmpcuRimQO4lPuDcnCaxi/m0bCRs4eS3KutX3Tl6j8nlblJ?=
 =?us-ascii?Q?wdWJKwgmstl8nEvMDqVBEpXXi7LKrPl4V63iQoD2UMfmZsHZIRqcpmB7zTyz?=
 =?us-ascii?Q?NWiUVRmnoq1xP0fatgq6AFAWnhuVqGGQtZOQimgusPXjnafceobZRg22QI23?=
 =?us-ascii?Q?d50kTmKONKeLKH8v633U0Kx8v9H9Hm5Y150fakdayFuscdW84oA8w1UkNa9M?=
 =?us-ascii?Q?PfHnbbwp8XnR4gZB9hXfgtunJRWiZHYLsadnbooWu1yBciYyamshJgNM3LYv?=
 =?us-ascii?Q?7CChpdovadRb/r12b0wQZy+T/cKOLTyOFIIMNCOIBESLdHEq5m9vOpSgP7bZ?=
 =?us-ascii?Q?BisyYme/OKrvI7/ZRGuz7oxjxN6HPdH622nGFmxw0GC/GeaA2hi5EZ0ir4P+?=
 =?us-ascii?Q?vW68AUTZR0Wu3Dp0zxpQamNq2roEmfotAg9vT+q+d+wtLJAS0ocThtoq70vu?=
 =?us-ascii?Q?2bQoj+2RGrMw9bGNntSSGbVx0V91dGpAWUalrKSE9mIdPGW0aKm4J7S0kEsN?=
 =?us-ascii?Q?iQF6f2kYf7MLgWDjMXZw6T6BJNKr0qEA/i+UToj8BBOoA2WrgIBwZu7PgeoQ?=
 =?us-ascii?Q?mRHOgVCu/p2J4fMJoepqkbruxGHl+QpfvsILocIYHR/fBAoGywKiAMSK6UjH?=
 =?us-ascii?Q?PZuHt7PUIAKvYeIukNTZ5S+4h/GeWoX5Z3QPrPF0O7a+NX60uZYZY0MknSyZ?=
 =?us-ascii?Q?nMI4vewTH8yQV6+DUHoxpmL5+VI+zWA0npBOheb7yHXMwA4itrzXNt+e+Jt+?=
 =?us-ascii?Q?sif94b0OO6oGAjdD0Z/01zCS4aEGsxjfsehrCj9TY3Wdm5dN4TsWY9FzLn49?=
 =?us-ascii?Q?JeffNFCUBo9A5cwHHs2vaZegw+qMsmV9w/p7VwCD143tlIBhvj6s/yxwB0mI?=
 =?us-ascii?Q?xkLoB3W4byHHK5sSBWQuC7Q3B252A/55mQGdz/IChZHroJxDmaCa4ry3FEOO?=
 =?us-ascii?Q?4uZrkc84HVhHJCXrkG9XQ6P/T2FkqTwhErp2nDCH+Rc6TUEy0W76+THtxj65?=
 =?us-ascii?Q?QIukLPgKGEMX/B4beDZBXp+eHd5U5qNp8MiT2FIqpNa+jaRzCxVeXHO9VOyJ?=
 =?us-ascii?Q?mdnCZlaBrn8q9/CZMgQMwDalyQuUNNw97yXTwxxfiMhd0yum6inNeB1Nnr6x?=
 =?us-ascii?Q?ZL1nxPpWOHo1MSIlzvuw2TIL6t0sJJ3GltrDfdYndV9A4Pzsa7Tbz5xtpddu?=
 =?us-ascii?Q?7RoOlyjl0IDdindnLW45s4pbTjSrkRJnydmAV3s4XhuXaBLN8eHwo0oUsWMh?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e362d3b-5220-4e3e-9a61-08db9365f917
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 14:37:18.4866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5tIGA3qvrsFR9q+/nuwvB4cNvdKtHkSMKGCsp5I7cXsXXk3nSUau0T3WaNCXrP60AD03jd4vQhOZge/KFvnEiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7582
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This commit implements defer setup support for the Broadcast Sink
scenario: By setting defer setup on a broadcast socket before calling
listen, the user is able to trigger the PA sync and BIG sync procedures
separately.

This is useful if the user first wants to synchronize to the periodic
advertising transmitted by a Broadcast Source, and trigger the BIG sync
procedure later on.

If defer setup is set, once a PA sync established event arrives, a new
hcon is created and notified to the ISO layer. A child socket associated
with the PA sync connection will be added to the accept queue of the
listening socket.

Once the accept call returns the fd for the PA sync child socket, the
user should call read on that fd. This will trigger the BIG create sync
procedure, and the PA sync socket will become a listening socket itself.

When the BIG sync established event is notified to the ISO layer, the
bis connections will be added to the accept queue of the PA sync parent.
The user should call accept on the PA sync socket to get the final bis
connections.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 include/net/bluetooth/hci_core.h |  30 +++++-
 net/bluetooth/hci_conn.c         |  13 ++-
 net/bluetooth/hci_event.c        |  41 +++++++-
 net/bluetooth/hci_sync.c         |  16 +++-
 net/bluetooth/iso.c              | 160 ++++++++++++++++++++++++-------
 5 files changed, 215 insertions(+), 45 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8200a6689b39..317a1939081d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -978,6 +978,8 @@ enum {
 	HCI_CONN_CREATE_CIS,
 	HCI_CONN_BIG_SYNC,
 	HCI_CONN_BIG_SYNC_FAILED,
+	HCI_CONN_PA_SYNC,
+	HCI_CONN_PA_SYNC_FAILED,
 };
 
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
@@ -1300,7 +1302,7 @@ static inline struct hci_conn *hci_conn_hash_lookup_big_any_dst(struct hci_dev *
 		if (c->type != ISO_LINK)
 			continue;
 
-		if (handle == c->iso_qos.bcast.big) {
+		if (handle != BT_ISO_QOS_BIG_UNSET && handle == c->iso_qos.bcast.big) {
 			rcu_read_unlock();
 			return c;
 		}
@@ -1311,6 +1313,29 @@ static inline struct hci_conn *hci_conn_hash_lookup_big_any_dst(struct hci_dev *
 	return NULL;
 }
 
+static inline struct hci_conn *
+hci_conn_hash_lookup_pa_sync(struct hci_dev *hdev, __u8 big)
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
+		if (c->iso_qos.bcast.big == big) {
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
@@ -1414,7 +1439,8 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 				 __u8 data_len, __u8 *data);
 int hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst, __u8 dst_type,
 		       __u8 sid, struct bt_iso_qos *qos);
-int hci_le_big_create_sync(struct hci_dev *hdev, struct bt_iso_qos *qos,
+int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
+			   struct bt_iso_qos *qos,
 			   __u16 sync_handle, __u8 num_bis, __u8 bis[]);
 int hci_conn_check_link_mode(struct hci_conn *conn);
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index cccc2b8b60a8..63f4e1e1eda2 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -735,6 +735,7 @@ struct iso_list_data {
 	int count;
 	struct iso_cig_params pdu;
 	bool big_term;
+	bool pa_sync_term;
 	bool big_sync_term;
 };
 
@@ -808,7 +809,10 @@ static int big_terminate_sync(struct hci_dev *hdev, void *data)
 	if (d->big_sync_term)
 		hci_le_big_terminate_sync(hdev, d->big);
 
-	return hci_le_pa_terminate_sync(hdev, d->sync_handle);
+	if (d->pa_sync_term)
+		return hci_le_pa_terminate_sync(hdev, d->sync_handle);
+
+	return 0;
 }
 
 static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, struct hci_conn *conn)
@@ -824,6 +828,7 @@ static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, struct hci_conn *c
 
 	d->big = big;
 	d->sync_handle = conn->sync_handle;
+	d->pa_sync_term = test_and_clear_bit(HCI_CONN_PA_SYNC, &conn->flags);
 	d->big_sync_term = test_and_clear_bit(HCI_CONN_BIG_SYNC, &conn->flags);
 
 	ret = hci_cmd_sync_queue(hdev, big_terminate_sync, d,
@@ -2096,7 +2101,8 @@ int hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst, __u8 dst_type,
 	return hci_cmd_sync_queue(hdev, create_pa_sync, cp, create_pa_complete);
 }
 
-int hci_le_big_create_sync(struct hci_dev *hdev, struct bt_iso_qos *qos,
+int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
+			   struct bt_iso_qos *qos,
 			   __u16 sync_handle, __u8 num_bis, __u8 bis[])
 {
 	struct _packed {
@@ -2112,6 +2118,9 @@ int hci_le_big_create_sync(struct hci_dev *hdev, struct bt_iso_qos *qos,
 	if (err)
 		return err;
 
+	if (hcon)
+		hcon->iso_qos.bcast.big = qos->bcast.big;
+
 	memset(&pdu, 0, sizeof(pdu));
 	pdu.cp.handle = qos->bcast.big;
 	pdu.cp.sync_handle = cpu_to_le16(sync_handle);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f1fcece29e7d..dec1bca76d3a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6571,20 +6571,39 @@ static void hci_le_pa_sync_estabilished_evt(struct hci_dev *hdev, void *data,
 	struct hci_ev_le_pa_sync_established *ev = data;
 	int mask = hdev->link_mode;
 	__u8 flags = 0;
+	struct hci_conn *bis;
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
 
-	if (ev->status)
-		return;
-
 	hci_dev_lock(hdev);
 
 	hci_dev_clear_flag(hdev, HCI_PA_SYNC);
 
 	mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, ISO_LINK, &flags);
-	if (!(mask & HCI_LM_ACCEPT))
+	if (!(mask & HCI_LM_ACCEPT)) {
 		hci_le_pa_term_sync(hdev, ev->handle);
+		goto unlock;
+	}
+
+	if (!(flags & HCI_PROTO_DEFER))
+		goto unlock;
+
+	/* Add connection to indicate the PA sync event */
+	bis = hci_conn_add(hdev, ISO_LINK, BDADDR_ANY,
+			   HCI_ROLE_SLAVE);
 
+	if (!bis)
+		goto unlock;
+
+	if (ev->status)
+		set_bit(HCI_CONN_PA_SYNC_FAILED, &bis->flags);
+	else
+		set_bit(HCI_CONN_PA_SYNC, &bis->flags);
+
+	/* Notify connection to iso layer */
+	hci_connect_cfm(bis, ev->status);
+
+unlock:
 	hci_dev_unlock(hdev);
 }
 
@@ -7033,6 +7052,7 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 {
 	struct hci_evt_le_big_sync_estabilished *ev = data;
 	struct hci_conn *bis;
+	struct hci_conn *pa_sync;
 	int i;
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
@@ -7043,6 +7063,15 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
+	if (!ev->status) {
+		pa_sync = hci_conn_hash_lookup_pa_sync(hdev, ev->handle);
+		if (pa_sync)
+			/* Also mark the BIG sync established event on the
+			 * associated PA sync hcon
+			 */
+			set_bit(HCI_CONN_BIG_SYNC, &pa_sync->flags);
+	}
+
 	for (i = 0; i < ev->num_bis; i++) {
 		u16 handle = le16_to_cpu(ev->bis[i]);
 		__le32 interval;
@@ -7056,6 +7085,10 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 			bis->handle = handle;
 		}
 
+		if (ev->status != 0x42)
+			/* Mark PA sync as established */
+			set_bit(HCI_CONN_PA_SYNC, &bis->flags);
+
 		bis->iso_qos.bcast.big = ev->handle;
 		memset(&interval, 0, sizeof(interval));
 		memcpy(&interval, ev->latency, sizeof(ev->latency));
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 3348a1b0e3f7..ad1851a4f493 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5396,12 +5396,20 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 	case BT_CONNECT2:
 		return hci_reject_conn_sync(hdev, conn, reason);
 	case BT_OPEN:
-		/* Cleanup bises that failed to be established */
-		if (test_and_clear_bit(HCI_CONN_BIG_SYNC_FAILED, &conn->flags)) {
-			hci_dev_lock(hdev);
+		hci_dev_lock(hdev);
+
+		/* Cleanup bis or pa sync connections */
+		if (test_and_clear_bit(HCI_CONN_BIG_SYNC_FAILED, &conn->flags) ||
+		    test_and_clear_bit(HCI_CONN_PA_SYNC_FAILED, &conn->flags)) {
 			hci_conn_failed(conn, reason);
-			hci_dev_unlock(hdev);
+		} else if (test_bit(HCI_CONN_PA_SYNC, &conn->flags) ||
+			   test_bit(HCI_CONN_BIG_SYNC, &conn->flags)) {
+			conn->state = BT_CLOSED;
+			hci_disconn_cfm(conn, reason);
+			hci_conn_del(conn);
 		}
+
+		hci_dev_unlock(hdev);
 		break;
 	default:
 		conn->state = BT_CLOSED;
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index cbe3299b4a41..1b8d0bd2e837 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -51,6 +51,7 @@ static void iso_sock_kill(struct sock *sk);
 /* iso_pinfo flags values */
 enum {
 	BT_SK_BIG_SYNC,
+	BT_SK_PA_SYNC,
 };
 
 struct iso_pinfo {
@@ -75,6 +76,8 @@ static struct bt_iso_qos default_qos;
 
 static bool check_ucast_qos(struct bt_iso_qos *qos);
 static bool check_bcast_qos(struct bt_iso_qos *qos);
+static bool iso_match_sid(struct sock *sk, void *data);
+static void iso_sock_disconn(struct sock *sk);
 
 /* ---- ISO timers ---- */
 #define ISO_CONN_TIMEOUT	(HZ * 40)
@@ -598,6 +601,15 @@ static void iso_sock_cleanup_listen(struct sock *parent)
 		iso_sock_kill(sk);
 	}
 
+	/* If listening socket stands for a PA sync connection,
+	 * properly disconnect the hcon and socket.
+	 */
+	if (iso_pi(parent)->conn && iso_pi(parent)->conn->hcon &&
+	    test_bit(HCI_CONN_PA_SYNC, &iso_pi(parent)->conn->hcon->flags)) {
+		iso_sock_disconn(parent);
+		return;
+	}
+
 	parent->sk_state  = BT_CLOSED;
 	sock_set_flag(parent, SOCK_ZAPPED);
 }
@@ -619,6 +631,16 @@ static void iso_sock_kill(struct sock *sk)
 	sock_put(sk);
 }
 
+static void iso_sock_disconn(struct sock *sk)
+{
+	sk->sk_state = BT_DISCONN;
+	iso_sock_set_timer(sk, ISO_DISCONN_TIMEOUT);
+	iso_conn_lock(iso_pi(sk)->conn);
+	hci_conn_drop(iso_pi(sk)->conn->hcon);
+	iso_pi(sk)->conn->hcon = NULL;
+	iso_conn_unlock(iso_pi(sk)->conn);
+}
+
 static void __iso_sock_close(struct sock *sk)
 {
 	BT_DBG("sk %p state %d socket %p", sk, sk->sk_state, sk->sk_socket);
@@ -630,20 +652,19 @@ static void __iso_sock_close(struct sock *sk)
 
 	case BT_CONNECTED:
 	case BT_CONFIG:
-		if (iso_pi(sk)->conn->hcon) {
-			sk->sk_state = BT_DISCONN;
-			iso_sock_set_timer(sk, ISO_DISCONN_TIMEOUT);
-			iso_conn_lock(iso_pi(sk)->conn);
-			hci_conn_drop(iso_pi(sk)->conn->hcon);
-			iso_pi(sk)->conn->hcon = NULL;
-			iso_conn_unlock(iso_pi(sk)->conn);
-		} else {
+		if (iso_pi(sk)->conn->hcon)
+			iso_sock_disconn(sk);
+		else
 			iso_chan_del(sk, ECONNRESET);
-		}
 		break;
 
 	case BT_CONNECT2:
-		iso_chan_del(sk, ECONNRESET);
+		if (iso_pi(sk)->conn->hcon &&
+		    (test_bit(HCI_CONN_PA_SYNC, &iso_pi(sk)->conn->hcon->flags) ||
+		    test_bit(HCI_CONN_PA_SYNC_FAILED, &iso_pi(sk)->conn->hcon->flags)))
+			iso_sock_disconn(sk);
+		else
+			iso_chan_del(sk, ECONNRESET);
 		break;
 	case BT_CONNECT:
 		/* In case of DEFER_SETUP the hcon would be bound to CIG which
@@ -1151,6 +1172,29 @@ static void iso_conn_defer_accept(struct hci_conn *conn)
 	hci_send_cmd(hdev, HCI_OP_LE_ACCEPT_CIS, sizeof(cp), &cp);
 }
 
+static void iso_conn_big_sync(struct sock *sk)
+{
+	int err;
+	struct hci_dev *hdev;
+
+	hdev = hci_get_route(&iso_pi(sk)->dst, &iso_pi(sk)->src,
+			     iso_pi(sk)->src_type);
+
+	if (!hdev)
+		return;
+
+	if (!test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
+		err = hci_le_big_create_sync(hdev, iso_pi(sk)->conn->hcon,
+					     &iso_pi(sk)->qos,
+					     iso_pi(sk)->sync_handle,
+					     iso_pi(sk)->bc_num_bis,
+					     iso_pi(sk)->bc_bis);
+		if (err)
+			bt_dev_err(hdev, "hci_le_big_create_sync: %d",
+				   err);
+	}
+}
+
 static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 			    size_t len, int flags)
 {
@@ -1163,8 +1207,15 @@ static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 		lock_sock(sk);
 		switch (sk->sk_state) {
 		case BT_CONNECT2:
-			iso_conn_defer_accept(pi->conn->hcon);
-			sk->sk_state = BT_CONFIG;
+			if (pi->conn->hcon &&
+			    test_bit(HCI_CONN_PA_SYNC, &pi->conn->hcon->flags)) {
+				iso_conn_big_sync(sk);
+				sk->sk_state = BT_LISTEN;
+				set_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags);
+			} else {
+				iso_conn_defer_accept(pi->conn->hcon);
+				sk->sk_state = BT_CONFIG;
+			}
 			release_sock(sk);
 			return 0;
 		case BT_CONNECT:
@@ -1519,11 +1570,17 @@ static bool iso_match_big(struct sock *sk, void *data)
 	return ev->handle == iso_pi(sk)->qos.bcast.big;
 }
 
+static bool iso_match_pa_sync_flag(struct sock *sk, void *data)
+{
+	return test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags);
+}
+
 static void iso_conn_ready(struct iso_conn *conn)
 {
-	struct sock *parent;
+	struct sock *parent = NULL;
 	struct sock *sk = conn->sk;
-	struct hci_ev_le_big_sync_estabilished *ev;
+	struct hci_ev_le_big_sync_estabilished *ev = NULL;
+	struct hci_ev_le_pa_sync_established *ev2 = NULL;
 	struct hci_conn *hcon;
 
 	BT_DBG("conn %p", conn);
@@ -1535,15 +1592,32 @@ static void iso_conn_ready(struct iso_conn *conn)
 		if (!hcon)
 			return;
 
-		ev = hci_recv_event_data(hcon->hdev,
-					 HCI_EVT_LE_BIG_SYNC_ESTABILISHED);
-		if (ev)
+		if (test_bit(HCI_CONN_BIG_SYNC, &hcon->flags) ||
+		    test_bit(HCI_CONN_BIG_SYNC_FAILED, &hcon->flags)) {
+			ev = hci_recv_event_data(hcon->hdev,
+						 HCI_EVT_LE_BIG_SYNC_ESTABILISHED);
+
+			/* Get reference to PA sync parent socket, if it exists */
 			parent = iso_get_sock_listen(&hcon->src,
 						     &hcon->dst,
-						     iso_match_big, ev);
-		else
+						     iso_match_pa_sync_flag, NULL);
+			if (!parent && ev)
+				parent = iso_get_sock_listen(&hcon->src,
+							     &hcon->dst,
+							     iso_match_big, ev);
+		} else if (test_bit(HCI_CONN_PA_SYNC, &hcon->flags) ||
+				test_bit(HCI_CONN_PA_SYNC_FAILED, &hcon->flags)) {
+			ev2 = hci_recv_event_data(hcon->hdev,
+						  HCI_EV_LE_PA_SYNC_ESTABLISHED);
+			if (ev2)
+				parent = iso_get_sock_listen(&hcon->src,
+							     &hcon->dst,
+							     iso_match_sid, ev2);
+		}
+
+		if (!parent)
 			parent = iso_get_sock_listen(&hcon->src,
-						     BDADDR_ANY, NULL, NULL);
+							BDADDR_ANY, NULL, NULL);
 
 		if (!parent)
 			return;
@@ -1560,11 +1634,17 @@ static void iso_conn_ready(struct iso_conn *conn)
 		iso_sock_init(sk, parent);
 
 		bacpy(&iso_pi(sk)->src, &hcon->src);
-		iso_pi(sk)->src_type = hcon->src_type;
+
+		/* Convert from HCI to three-value type */
+		if (hcon->src_type == ADDR_LE_DEV_PUBLIC)
+			iso_pi(sk)->src_type = BDADDR_LE_PUBLIC;
+		else
+			iso_pi(sk)->src_type = BDADDR_LE_RANDOM;
 
 		/* If hcon has no destination address (BDADDR_ANY) it means it
-		 * was created by HCI_EV_LE_BIG_SYNC_ESTABILISHED so we need to
-		 * initialize using the parent socket destination address.
+		 * was created by HCI_EV_LE_BIG_SYNC_ESTABILISHED or
+		 * HCI_EV_LE_PA_SYNC_ESTABLISHED so we need to initialize using
+		 * the parent socket destination address.
 		 */
 		if (!bacmp(&hcon->dst, BDADDR_ANY)) {
 			bacpy(&hcon->dst, &iso_pi(parent)->dst);
@@ -1572,13 +1652,21 @@ static void iso_conn_ready(struct iso_conn *conn)
 			hcon->sync_handle = iso_pi(parent)->sync_handle;
 		}
 
+		if (ev2 && !ev2->status) {
+			iso_pi(sk)->sync_handle = iso_pi(parent)->sync_handle;
+			iso_pi(sk)->qos = iso_pi(parent)->qos;
+			iso_pi(sk)->bc_num_bis = iso_pi(parent)->bc_num_bis;
+			memcpy(iso_pi(sk)->bc_bis, iso_pi(parent)->bc_bis, ISO_MAX_NUM_BIS);
+		}
+
 		bacpy(&iso_pi(sk)->dst, &hcon->dst);
 		iso_pi(sk)->dst_type = hcon->dst_type;
 
 		hci_conn_hold(hcon);
 		iso_chan_add(conn, sk, parent);
 
-		if (ev && ((struct hci_evt_le_big_sync_estabilished *)ev)->status) {
+		if ((ev && ((struct hci_evt_le_big_sync_estabilished *)ev)->status) ||
+		    (ev2 && ev2->status)) {
 			/* Trigger error signal on child socket */
 			sk->sk_err = ECONNREFUSED;
 			sk->sk_error_report(sk);
@@ -1636,7 +1724,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	if (ev1) {
 		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr, iso_match_sid,
 					 ev1);
-		if (sk)
+		if (sk && !ev1->status)
 			iso_pi(sk)->sync_handle = le16_to_cpu(ev1->handle);
 
 		goto done;
@@ -1644,16 +1732,21 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 
 	ev2 = hci_recv_event_data(hdev, HCI_EVT_LE_BIG_INFO_ADV_REPORT);
 	if (ev2) {
+		/* Try to get PA sync listening socket, if it exists */
 		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
-					 iso_match_sync_handle, ev2);
+						iso_match_pa_sync_flag, NULL);
+		if (!sk)
+			sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
+						 iso_match_sync_handle, ev2);
 		if (sk) {
 			int err;
 
 			if (ev2->num_bis < iso_pi(sk)->bc_num_bis)
 				iso_pi(sk)->bc_num_bis = ev2->num_bis;
 
-			if (!test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
-				err = hci_le_big_create_sync(hdev,
+			if (!test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags) &&
+			    !test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
+				err = hci_le_big_create_sync(hdev, NULL,
 							     &iso_pi(sk)->qos,
 							     iso_pi(sk)->sync_handle,
 							     iso_pi(sk)->bc_num_bis,
@@ -1705,12 +1798,13 @@ static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
 
 	BT_DBG("hcon %p bdaddr %pMR status %d", hcon, &hcon->dst, status);
 
-	/* Similar to the success case, if HCI_CONN_BIG_SYNC_FAILED is set,
-	 * queue the failed bis connection into the accept queue of the
-	 * listening socket and wake up userspace, to inform the user about
-	 * the BIG sync failed event.
+	/* Similar to the success case, if HCI_CONN_BIG_SYNC_FAILED or
+	 * HCI_CONN_PA_SYNC_FAILED is set, queue the failed connection
+	 * into the accept queue of the listening socket and wake up
+	 * userspace, to inform the user about the event.
 	 */
-	if (!status || test_bit(HCI_CONN_BIG_SYNC_FAILED, &hcon->flags)) {
+	if (!status || test_bit(HCI_CONN_BIG_SYNC_FAILED, &hcon->flags) ||
+	    test_bit(HCI_CONN_PA_SYNC_FAILED, &hcon->flags)) {
 		struct iso_conn *conn;
 
 		conn = iso_conn_add(hcon);
-- 
2.34.1

