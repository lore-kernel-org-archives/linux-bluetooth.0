Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EC2C41513
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Aug 2023 15:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343919AbjHPPBs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Aug 2023 11:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344001AbjHPPBd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Aug 2023 11:01:33 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495D02D64
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 08:01:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMcq2q7EOE5obvUnfQCo8/m4ff76JQoWaP0x71hvXUJdhnA5YHv9d4KukivIpYhlNYcY3yGd0iLjtF0iVxdznxxW10Qk0lN/HxJcH8PdnI4dyuN9mGoVOM0SL6X4AnnLrVjvG2Y9UWjxQ3sFBWuW3a+GXGzKfBxhjqPrMIV/uIwVo/tT+86bpx8lxFcysGkSvKC1AdCgay0MkVKR3qobe8w/bLF79H7rQkkNZfxNPEEKicALxGIUSYxBHwJx15KhQh8FYrsYWpHhUQnu7yz1K4QWL+8Ot1rfMVZ2RtlpD37brdreD5xBY/ahmmEQJq/u8U3CTtf2j6O5QqNgHkjWvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9730EAl4gPADLHwDSzWlnTyG0lhvJfqffMFpoaAcF2I=;
 b=iHzu98APg8RMJy4HNZFhDLnWIkr79+ckyTaHR0qVKtc9cfW6NDW8heAe5AMWsS+I7WpZam3nlS8eUF8xFWB4FOczTiAqwRXWo2v9FtWROAcOFVbMaSE0bUDU69X2GbAbDgMM3TomOubKpol+SrV52XZDfACFtnSwdoflZ/yg5uGtCvguTsYMtk9AbiNIKZ03l28e4+HuB+ndhtv7LdRcJ+cV9FQxesUwaXwIym+fgz70q3ocl30ucbm3e5tfpcICDKftW5dwUswY9q+4FRyAYauHfRGg6+GK2/VeWmUDJ8ImCcobwNdCfMKIc2GOLdCAUwkOjDZE25cl/DwTrq3omg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9730EAl4gPADLHwDSzWlnTyG0lhvJfqffMFpoaAcF2I=;
 b=UeJt0FGAUz77J0PuWhT0y/JjMs+l0lRddXXmRfCM31FHyjkTEsa6o/ODbpdnBM7+EWdQKvC/hDb+jtEBmnzoyaQSOBxpbEIvM0NM48Z6SNiRhElny6fcDvAUiFja209w/u589fMbcnAPJP0lMLe5TBYd00S3pE+5N2RyFJK2Gzw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB9189.eurprd04.prod.outlook.com (2603:10a6:20b:44c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 15:01:04 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 15:01:04 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v2 1/1] Bluetooth: ISO: Use defer setup to separate PA sync and BIG sync
Date:   Wed, 16 Aug 2023 18:00:33 +0300
Message-Id: <20230816150033.7812-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816150033.7812-1-iulia.tanasescu@nxp.com>
References: <20230816150033.7812-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0044.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::13) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB9189:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d91567e-5ebe-4197-a51a-08db9e699cf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7P00ABtrlFDjL+gje0GFCA0R6yBXofZE01Jq/7Ppl7GGnjtIEYj5zey9BdQBjBMZphqaPRNXMNb8U+0mACrZWk8bHGXLaqAi3IZaKPnf81rmawp1jV4V+M1g5Cs0gtiZapd/LkpURJRZQXgXuNvrjJZSTTrkF4JaRqJqnwOs3Mt2DcizvG04rt5IYf0imMM9cwdkzW1T2dA3OD5wnWqwzIW8mTK1Zs2gHFEze1SumkEcBQ9uvX+N++nGM3W+LQWDJAtAWpYYGbimz+rr2QfD/lgwm+CakeLg9wYcL4DDfYp3uzFDzs2jRlT4AV/nXQJfeJsk1NYtSjLbBRM+LvIgHg0L5pfzWxE1QsqBn4fwt+H8gnBMUEfKReuSmdsxijkm517PwvQMf1TMUPjbQuFuDzqNq8bti22ZrjFXY6ALKB7XblIOPkETn9SAYda2QJhHjjJMa48UenzvJcGkgvWBIQPeKSILPjVXOAVzSMWhGA1myKx2ZkY+BnTNpPfvrfIZMpFJVfNt+rKnpOjWSdTouZCUUosmrvfFMkt792d5wuaDB9rHsSDfotdBAL/2EdxRk1T4oJNjD2GRYR1TRLc/Yjb7glBvt7Lkoco4Zx4aWzYgygOcYQdpohp5U18j8tgW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(6916009)(66946007)(66476007)(66556008)(41300700001)(5660300002)(44832011)(38350700002)(38100700002)(8676002)(4326008)(8936002)(30864003)(2906002)(83380400001)(26005)(478600001)(86362001)(6512007)(52116002)(55236004)(6506007)(36756003)(6666004)(1076003)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AG+9iUcdZLx9ALxSJJbN0BJduge4V6S9gmQXBJ2nbWogLp2v20rdQwXByIWf?=
 =?us-ascii?Q?wnlec8x7JLmIKDTALrqljwOPJnI//fppM5M0FG5uDtkLGRXmxnGnvt+mwoIB?=
 =?us-ascii?Q?70XuiHXSs4sg4TXPBrDdfjIYwy6w28+Nhi8JiVi1FTcGIYMeC4uCY9rePG7N?=
 =?us-ascii?Q?LCRCLSL/NIthJ/fH5ilnN+1uPovC+gn9ZCxFakQQlDR/v4bOSrSL5i8BkGSf?=
 =?us-ascii?Q?AiXpmAg4ZmCM40TeAd+XRpXtDuy7Pc/foKHDLEcHSINfi4cDpB/htRNC9tcG?=
 =?us-ascii?Q?k30YqzF0J9GSMa8wqt1GcZOP4goiwGSXMxBDGTEEATSNdZss7Ugo21M/QeeY?=
 =?us-ascii?Q?mxF7CBWacmBz+tqDgbx+n74yGoNTR1adEGuhMHepFxNpGJg2BU0uhonA3N11?=
 =?us-ascii?Q?3ZagD1lhqGeSO5Zp0JxwR/Xp5MY87S9GSHPNDujr28Wgvu6Yj9asWV8VmphN?=
 =?us-ascii?Q?fTqRoPTLiQmBbx7sELL81GMnUibeQZfryxgrVr2GhIw+ODAaINEgOJfO69mS?=
 =?us-ascii?Q?EWpvchMI+TWJznHGRs0uUeS0JyVrmsejQRHNaraorbsXL7P9wNcB7LH7NGhn?=
 =?us-ascii?Q?tDPtDFjBFbylJo8tQT+PWg2pgzc7nI9Pob3AmcgourbLGbQvNVG9/ooBa1id?=
 =?us-ascii?Q?omE4XvPmscZdCVROkYL8xcY9cRj3FljRAM9tbh3qoPvXaN4pYHdvFN0c4HJ5?=
 =?us-ascii?Q?UnEoVnrKykXzPdg1ykao0HXsoSHdJAgzvMHv1jZb4m4sHIhOu1IoDZV6VY9R?=
 =?us-ascii?Q?knUH6n3wf9TOEXHHqjNQDCUkupCXDdVCXZPvSCCS2g83h6jdhUD2gqVGzjQI?=
 =?us-ascii?Q?a30/XWrEUFVv8OE8yEASGpXJNBo4pLOIhhcg2fEBhCFsEIZgw+dWfqHfY0fs?=
 =?us-ascii?Q?PlkenFiCGdzEc5agnx4YJBxSpe3P7TAZNwlrUEqEzMQEqfMRzYDaSE0qT40B?=
 =?us-ascii?Q?8m3DMda4bVsJkcEdfPh3gdKodvjtodxhM3PWYCR2qVnywHUtA4A3Vh5lEaJp?=
 =?us-ascii?Q?tbYtnEGUlABh2AMFOP0NFajfJAbjiMsk4oyPnRyvKsMOmDvziNpF9krnTC0+?=
 =?us-ascii?Q?JqdxBAp/YHsfyE64kru20a1V72tB4BaTk/bNwjcb5+sbDIPiTDc8m3pQS4yF?=
 =?us-ascii?Q?Tlue+GPpCWHEuQV2w/ojYY2rc6bRvKKrJq6U8feRFoJNvrGjnfQh9Bgd35cQ?=
 =?us-ascii?Q?nPB90Gjzk9I38cysd+NZogfxTqEZxc7wqyW1+qatIthwK4EE2ZjElS1i+3ot?=
 =?us-ascii?Q?ZllD3X95XwAsvyLbAl5uJZkQyHgD9ZosRks/8wThruv1m7LUnDtsT0gEncCf?=
 =?us-ascii?Q?8LDckHrYVZngWJYiq2tqGXeJ0qydYOnQzF9GjNI65dZUC7Co2aZ4im0c81KD?=
 =?us-ascii?Q?a8uVtpes2tlLL5MTNZWNFV7GBZn3yCWbpCGkne7DUaoxz0HXdYs0u8Rh/jjm?=
 =?us-ascii?Q?AhTRaiEMwgezIvbmBoJTHg7HayovPcbAx45TeHHL70Kygl3lpwfRdxhpwnRI?=
 =?us-ascii?Q?8ultg7JJMW8BvJJ8jGmQb/viYYk4aQZy4FfRnaEgdEtk+qcXVsokfQiApCdL?=
 =?us-ascii?Q?lrJDlF9LrTRur5AYKT+V8P4cklj5p+2y+irLzoV23CCsFg7BM/946lUsdFoa?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d91567e-5ebe-4197-a51a-08db9e699cf2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 15:01:04.7911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLK3+azMBSsnBIhVkD7MW8WgYw98+fRDCc9a0/7UxifxPutb3EwUp69XGYKgP6tlIxs9vgv0Zk5WTVSxFkR9lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9189
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
index 234746721047..950b3cfb3121 100644
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
@@ -2100,7 +2105,8 @@ int hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst, __u8 dst_type,
 	return hci_cmd_sync_queue(hdev, create_pa_sync, cp, create_pa_complete);
 }
 
-int hci_le_big_create_sync(struct hci_dev *hdev, struct bt_iso_qos *qos,
+int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
+			   struct bt_iso_qos *qos,
 			   __u16 sync_handle, __u8 num_bis, __u8 bis[])
 {
 	struct _packed {
@@ -2116,6 +2122,9 @@ int hci_le_big_create_sync(struct hci_dev *hdev, struct bt_iso_qos *qos,
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
index 5eb30ba21370..2dc4cea4ceb5 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5383,6 +5383,21 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
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

