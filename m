Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0120CC27C7A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Aug 2023 06:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348296AbjHQGpA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Aug 2023 02:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348313AbjHQGoz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Aug 2023 02:44:55 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2054.outbound.protection.outlook.com [40.107.14.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9432102
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 23:44:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqzoRPoEDbzfKn3Pfj1wme8mD5aL9qHQBejhJsaXId/lW1+PGp0cvNGvh+5ymo9cncvK/h/95iy5EwPOab00rWoOoSxH0VYzoAQH/lEGnSxEdS4vsOOPVOpxrme6NslRjeoyq0CMmhhcN4u+3VQAuIZmwFnoILSfNojzHy4LINny8A3Jz5bafa2X7vRvC81FYvv7QwC92o/U4S0PGrnnTvgJGqpxgXR8YRR/g2jrK3PgysHISsSDhsfWxyABxQfeoe1xMg0m4awcJHk1srI/bbXkB1KVe/myC1xSGqoPgvmuZ7uxjuV7c0qBhqk203R/lPzmFnvbV5Dm+v8D7PUmTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3YIItr7NMJJm9oXWoCLUSuDrrnyh7jRmcqH82WSmhI=;
 b=Dzte3G6MAnoYFkoiHODXFATDl9zJChtAQY2f6TvKYvplYZuHPS84fT84CPiyGvbw+Be5P6YJyaeHLur92bAf15OK/1LQAPbvCa3zU4NdD2wZeq6vXNeOOpZ1bAHhptGxY3gVj9JOkNb7q2xkcG7B8lkYLWSeCgJaU3Q7V1nj4MdRoNugUoFV7qCBCX7PBiRgjqU5WP97iy9eTa2s4TvcBdkiBrQWuJpRs7td7C14l1ZiFdyQWHMXP/RL3w0KRN8oekFRQX/RERhQ+PokLqItqlv5gbSJRxVNFz87fU6OzXnWiLsWmOBeYc8S2PJ+VCFNKoaAZVprqwM/Pzg0D+HkTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3YIItr7NMJJm9oXWoCLUSuDrrnyh7jRmcqH82WSmhI=;
 b=rOr8lEffeykvsH32A9Ukimt5ST7jcxZ9boAGaVZrrDg3gGt33b07p6J7HOsMYglOMPTa/lhcQ9z8T+UpdMWrCpPswb7SND3RDphVtY3v5A/8FKD8tdYZRvDSkS1rm8yXZjWEagG07xGv8RVJbRZZDz+z3b19AtLmrbKxoxeZSZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8484.eurprd04.prod.outlook.com (2603:10a6:20b:34c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 06:44:50 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 06:44:50 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v3 1/1] Bluetooth: ISO: Use defer setup to separate PA sync and BIG sync
Date:   Thu, 17 Aug 2023 09:44:27 +0300
Message-Id: <20230817064427.3647-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817064427.3647-1-iulia.tanasescu@nxp.com>
References: <20230817064427.3647-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0083.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::24) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: 9197fcdb-590d-427c-7a7b-08db9eed74a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FnFuPe0/TaFbrq8YSiEViMwgbnlfSyg+Ny9vL1f+Nvb6IGbhRoU8zJpGXDUPXM0zLTFQOqAvMbvia/1qKLH8//wuxJLQY0J+Bln4qVXA6rWkFa1BIIhKS1r8y9/hBQRMnQyw9dLF0pGixdcTcnwTS6jb17UsPS0Gv7ZG60oCqlktGxkvsAGgP7mDp4yZ65GWVaty5HxLy7sLFa67mL7MBGpENgVpBPZpEh1HvBn3x1sPndX2515eneRWaMsvO8cCDDM4zXZ1JjHq8hP0u/Is+EHSd0Z298F9EHzsfXCz8ILtVO4rgWH4girIYA6Rmapu8LiGiAWP2PVcR302y2iZDemwfMbm9jSDUtCKzXz1sosci32WiUEPjpbSf7fbKocNMJ+gja3EyI9HXj+T31gUDVNBRurUw8R2sG/kjVuEjytO+2YTV/opUzUUi71AeEsLH2JHjkPotC+mODKSA1dLJ6QkcsqWgymt6Z7vi8xNK5R+u5Ncpp6kAbWqwR1f0ea9gdzQezMZbNpiZ6AvRaPcZtwcNCXRLiLVCx8bdRAMWS9m5dDauWlN3xZK2OJxw09V0KVjSZIgWpSO8nnltRaUKf2od2QYUowwjIg4wCGKu/36Bfcp7xmrarBhieodpc2r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199024)(1800799009)(186009)(316002)(6916009)(66556008)(66946007)(66476007)(5660300002)(41300700001)(44832011)(38100700002)(38350700002)(4326008)(8936002)(8676002)(26005)(30864003)(2906002)(55236004)(83380400001)(478600001)(86362001)(6512007)(52116002)(36756003)(6506007)(6666004)(1076003)(6486002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y//5UWVfiNlvIN2rsYEey54+l28UwROTtjhCqieFPtAOIyozKXQY7YByMCd7?=
 =?us-ascii?Q?j0MIiX81aPBxv6gHb6BU524101Yy9PcZbRxMrKqXuUVVis778mRGRlsFC8g+?=
 =?us-ascii?Q?GbRPTYf5uFDRs4CkOAq0G7eDd+pd+8HbuVuXg9dkzl1kzL8dtktkxKORcSpV?=
 =?us-ascii?Q?K/sP0ROabl94BXjsJu9fi4hwRJuqsQZATzMLYJ+7iZ4VjSOkASrR/E3c9gtH?=
 =?us-ascii?Q?jFo6RbAE1hwtzCm8EZlsmarvioRhlaxf2/Pa1zK6YkJy2AETeX0EA9aU7Wkw?=
 =?us-ascii?Q?4lVnEXbeXszScusmBVav32DRKIfHBpv/eEQ4cCSfWG9u9e5FRVtZQw0glSth?=
 =?us-ascii?Q?fG17hME3+NBQzUzRTJ0WAKqqqrmxp7cQL3N/nEZfYFyoN6hnVvFCJnZAhV6B?=
 =?us-ascii?Q?cBQWBDvKjIcHgCKgNy4MiA/uNrRt2twRq7lb1z2i/CBFcjpBXgo6QOsOaw5o?=
 =?us-ascii?Q?ihBFURdZcQgJzMpYuPiS7g3RuxYb9iiLen8neSqgVAgI5Sak7JxePbi4kt30?=
 =?us-ascii?Q?NsBSYrIIAT0QimE5qi1QgNAjfpXCBYO9ngOODgWEjclKEceZ1R/5+/vqQM9v?=
 =?us-ascii?Q?vhNDqAYXYvULublaHz5AkXAPE805VZVDbQpDRpEkXLnDrUHaw/3EfbAyl2ZL?=
 =?us-ascii?Q?+NTq49tuYAVIxzn9nwdkfZq3W7Ws0ulOUXUZpejunvLACIaVN2cCWv9clkoZ?=
 =?us-ascii?Q?Tl1/bspwnEshy+pS+fMkGOQ70xUIr8rkM+RjlI1oChyKZv071AFiaXc/G3iJ?=
 =?us-ascii?Q?+bXp0RZc+I8dvmhOEVvY3KKwV+PXC+Hk2AgFy+kLrIHDfPR5Qou7ryLczwaz?=
 =?us-ascii?Q?k0o0XdVGB0WwioI+L3l087AbOThlXIE4Q/gPueBpl6oQO3lQ9wHSASzfMPbe?=
 =?us-ascii?Q?oNWDLhql6CReeJJ8D5ddpNc9CFtCxNGDtpqNQHxCXjMInZnm3MPEwUxAmzS1?=
 =?us-ascii?Q?rMQjOzVy1/d6sAqHQA+KwZ8B85L8MQvCZgzzp9jyt4+HV3rN6AkHVryG5PXC?=
 =?us-ascii?Q?KgF0WGAjuTbOV0A67q1T9zgDYbn0JJd7kv11fYc71fKG+BdeSZyc3qC0DJ0U?=
 =?us-ascii?Q?fjF8ikihVuF1XFt+J32hQgJrZSCUSEw75djID7n6f2qbDcKjPQ8oEqBwznnw?=
 =?us-ascii?Q?YcRN4NOZluIIC5rNdyftWuOfoGhJ+20fIARdha/qEZ5SuUGRp1VL5Nfc+ekN?=
 =?us-ascii?Q?2PBr1Oo3HB8kmMy7u7qjbuLmtqQCXhPbKfoSArZeFYc8nuiArTzbM+/m1+aD?=
 =?us-ascii?Q?FWKnEKtyL2UQ4Cv0g2YMFOzhlifBf0JP4MTt0KD4wtQa4RP4oG1WjIV67eiB?=
 =?us-ascii?Q?2QOZsGD6EqjPvDN9rgEI6Bo81bp+3WJsgkp4xvMTS93aXax1/qYEtgX2rziX?=
 =?us-ascii?Q?jZAkd+x3ldGHPMjRbst/X7MkZMIpc5ancxwE8Jb724WyerU4jwiJB4cU27GI?=
 =?us-ascii?Q?Sat9luOHuDxXIBfolWEmPYOAtvZ9dz2bKT81vXzaCoyVsHSTk3a4W0Xr8HS6?=
 =?us-ascii?Q?6fzeNqoNE4S3EMVS6UVEwal7d085ck6YOonWmJ6MGOQ/mhALEj/2lG2sYnkz?=
 =?us-ascii?Q?/KvfPupOByI00a/4feZxtu8k5f8Mol6HMsaIVgTqmaEoeqo725X2lR4HtlgL?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9197fcdb-590d-427c-7a7b-08db9eed74a5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 06:44:50.6129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1JlcdV+ROZ2/UqLdmEiEjXRyhU7IfEJqcslyhwfRpvTCbjekPSXHvgqbdMOR/ExZXd8u1qlwssPFNSaaMkC5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8484
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
 net/bluetooth/hci_sync.c         |  15 +++
 net/bluetooth/iso.c              | 160 ++++++++++++++++++++++++-------
 5 files changed, 218 insertions(+), 41 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c53d74236e3a..6fb055e3c595 100644
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
@@ -1435,7 +1460,8 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
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
index 95339623883c..8b0c8e631324 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -734,6 +734,7 @@ struct iso_list_data {
 	};
 	int count;
 	bool big_term;
+	bool pa_sync_term;
 	bool big_sync_term;
 };
 
@@ -807,7 +808,10 @@ static int big_terminate_sync(struct hci_dev *hdev, void *data)
 	if (d->big_sync_term)
 		hci_le_big_terminate_sync(hdev, d->big);
 
-	return hci_le_pa_terminate_sync(hdev, d->sync_handle);
+	if (d->pa_sync_term)
+		return hci_le_pa_terminate_sync(hdev, d->sync_handle);
+
+	return 0;
 }
 
 static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, struct hci_conn *conn)
@@ -823,6 +827,7 @@ static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, struct hci_conn *c
 
 	d->big = big;
 	d->sync_handle = conn->sync_handle;
+	d->pa_sync_term = test_and_clear_bit(HCI_CONN_PA_SYNC, &conn->flags);
 	d->big_sync_term = test_and_clear_bit(HCI_CONN_BIG_SYNC, &conn->flags);
 
 	ret = hci_cmd_sync_queue(hdev, big_terminate_sync, d,
@@ -2099,7 +2104,8 @@ int hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst, __u8 dst_type,
 	return hci_cmd_sync_queue(hdev, create_pa_sync, cp, create_pa_complete);
 }
 
-int hci_le_big_create_sync(struct hci_dev *hdev, struct bt_iso_qos *qos,
+int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
+			   struct bt_iso_qos *qos,
 			   __u16 sync_handle, __u8 num_bis, __u8 bis[])
 {
 	struct _packed {
@@ -2115,6 +2121,9 @@ int hci_le_big_create_sync(struct hci_dev *hdev, struct bt_iso_qos *qos,
 	if (err)
 		return err;
 
+	if (hcon)
+		hcon->iso_qos.bcast.big = qos->bcast.big;
+
 	memset(&pdu, 0, sizeof(pdu));
 	pdu.cp.handle = qos->bcast.big;
 	pdu.cp.sync_handle = cpu_to_le16(sync_handle);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 559b6080706c..b4b72070f5f6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6581,20 +6581,39 @@ static void hci_le_pa_sync_estabilished_evt(struct hci_dev *hdev, void *data,
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
 
@@ -7045,6 +7064,7 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 {
 	struct hci_evt_le_big_sync_estabilished *ev = data;
 	struct hci_conn *bis;
+	struct hci_conn *pa_sync;
 	int i;
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
@@ -7055,6 +7075,15 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 
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
@@ -7068,6 +7097,10 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
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
index d10a0f36b947..0cb780817198 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5384,6 +5384,21 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 		err = hci_reject_conn_sync(hdev, conn, reason);
 		break;
 	case BT_OPEN:
+		hci_dev_lock(hdev);
+
+		/* Cleanup bis or pa sync connections */
+		if (test_and_clear_bit(HCI_CONN_BIG_SYNC_FAILED, &conn->flags) ||
+		    test_and_clear_bit(HCI_CONN_PA_SYNC_FAILED, &conn->flags)) {
+			hci_conn_failed(conn, reason);
+		} else if (test_bit(HCI_CONN_PA_SYNC, &conn->flags) ||
+			   test_bit(HCI_CONN_BIG_SYNC, &conn->flags)) {
+			conn->state = BT_CLOSED;
+			hci_disconn_cfm(conn, reason);
+			hci_conn_del(conn);
+		}
+
+		hci_dev_unlock(hdev);
+		return 0;
 	case BT_BOUND:
 		hci_dev_lock(hdev);
 		hci_conn_failed(conn, reason);
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 6b66d6a88b9a..9879f2349d48 100644
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
@@ -631,20 +653,19 @@ static void __iso_sock_close(struct sock *sk)
 	case BT_CONNECT:
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
 	case BT_DISCONN:
 		iso_chan_del(sk, ECONNRESET);
@@ -1139,6 +1160,29 @@ static void iso_conn_defer_accept(struct hci_conn *conn)
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
@@ -1151,8 +1195,15 @@ static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
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
@@ -1513,11 +1564,17 @@ static bool iso_match_big(struct sock *sk, void *data)
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
@@ -1529,15 +1586,32 @@ static void iso_conn_ready(struct iso_conn *conn)
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
@@ -1554,11 +1628,17 @@ static void iso_conn_ready(struct iso_conn *conn)
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
@@ -1566,13 +1646,21 @@ static void iso_conn_ready(struct iso_conn *conn)
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
@@ -1630,7 +1718,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	if (ev1) {
 		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr, iso_match_sid,
 					 ev1);
-		if (sk)
+		if (sk && !ev1->status)
 			iso_pi(sk)->sync_handle = le16_to_cpu(ev1->handle);
 
 		goto done;
@@ -1638,16 +1726,21 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 
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
@@ -1699,12 +1792,13 @@ static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
 
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

