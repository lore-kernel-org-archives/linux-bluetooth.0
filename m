Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E80BEE49A6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 12:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbjHUMBF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 08:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjHUMBE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 08:01:04 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E65E90
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 05:01:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ko/aKF6baFpx/0zC7WRl1fOEr0KErmhstlbGsKoOf59MQrnyMThhd6OF5nnAmg8Tzt+gqB3M+Pl9NOd9LyiC3g0V8sKleGqNLXI5UzZZ1OUrxHYsTtAE5IlAQ7QfyEy4m1QSy/pYv79z00mpinyWv2zC5Uc3NvxieNOF/jwlrqO8+IdOnk0xC476tvNx7O10113PpbX8qB0bfCDwNA6Gmuhu+Pq1Sq3a4cuOJD9i7MzMYRGbyiRf02gW+labaMcqOnD3XPRnYMBvkFnh+Ug4TBRaRvSjBid08P3RhcHc0Ue0zZ1ArWs5mFtmTkb+T67xjll2PY07oCU+RjYKNadk1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Am3VOGNcf+iyHlW49B6gvGFG3cNYpq8YYJg/wk8U5YQ=;
 b=nAHRHmUvQ7L8gXLpq7sLAdBP+WL75Wg8sVUqdHsZO4pWSZ1Wu1bjtK/PISNNLoo9lx7KeINPGYOpxt/nD4urzWi1uKuCRpF2j5OynsX2fHZ8ZUhoUXTK6uSSyhGOStFWdXeJvo5+SHD08mDHeWltdgNtfzGLQXftdaEyvsNUt6xN7fL+dGW132hSbI69NwERPIKc+mippIYRyfsgNUgObPopAt6Qt6OowCjI3S67srpw3+fb32cmEnEcyIJCrRAt+YEoRE8/4vol6n6oh1/78Pl4DAnJL2QAWbdOUjKuwt1rdBsPUGmk3AcwNTCSPcfbgD1n3okOnNRotk97HUl6iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Am3VOGNcf+iyHlW49B6gvGFG3cNYpq8YYJg/wk8U5YQ=;
 b=hOhkog6KcWCPee5SS2rVJRT5KcuufwC43DtNr1BBb7lAx3pwJu/LP/jpj3LnRe2Ulf5R/Oe+I7ySEI0DPgAUXEWmkCLtWA2IcwCmLE+RsgFVYSsgrZqRlwzgtSjjDDOX0Q2xl6Gj6ALUjGkSIhm9TEX9nw+tdbrhlHv0SazEELo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB7832.eurprd04.prod.outlook.com (2603:10a6:20b:2af::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 12:01:01 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6678.031; Mon, 21 Aug 2023
 12:01:01 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 2/2] Bluetooth: ISO: Pass sync_handle through iso qos
Date:   Mon, 21 Aug 2023 15:00:14 +0300
Message-Id: <20230821120014.28654-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821120014.28654-1-iulia.tanasescu@nxp.com>
References: <20230821120014.28654-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0124.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::29) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: 19987fdd-7dff-4f78-7f3a-08dba23e4997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H6zlhpVhPm0VLH21S6AVffhVoyOo3/omNvMg6+vEDQj6ni0ug1WeCCP7XTE+Xxvd0lh3+eQLbgk7NfYQa8n9VDTHKFPfhMmUChdpTPXuskNCngpFpbXRRuclMrT4OCeGZlwNO2D7eb2PvZczH/L2nR2GY010ART0RLIc5dTsAkeRvxGSOSQSKVngEPAEJ7n+/KASE42SCeYsVxxY+b59X7dryqbX25wk+iFN5gS5Gn2ltCv7ovXESrRvvNsDGnZcfZ+/hdkz7OEE5yEWVFyvwN7M9z28uumA00JwgC0kmbAj8rRC75myAbWWoTCUc2gBN33rY4s/6pmDXGqRNA9nES0x7apEI6Zar6zKsjaP3VA9XnlAqH+5D1tGcA+UAYb8KucRTOeLlWkD5NFjlvF2CKoLYLxa0SPhFsenOj91Poy8eQGiA/wXcqner6MK+/gcCSMVpsL2mSkY9TfYdufUlJ1r59Q6yHV5r1EG7HTj8abepA4XRFp9LnDCiG2eQO+sXFKBjA+uZPQpyX7RsUIBgw50T8TVXJ+hfSKmRBXlgVHjYshUBl86Bi+03CDIPU1RuLaoj0mOJ0k1DfnkKoRmuv8vvzSLb9kEM3V7gtxCCcsSUbL3UFUveuGzZeCacK94
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199024)(186009)(1800799009)(2906002)(52116002)(38350700002)(55236004)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(44832011)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(6916009)(66556008)(66476007)(478600001)(6666004)(36756003)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zp9dR2PDMK0ydugMUEDCz8EMo3SGBcmreZjJCgmg3hXH5WgfdnHp8mWFqKyX?=
 =?us-ascii?Q?J3AtgpLH9y8eFUoZngz5PFt/2E0ZgBq/KbvzkFuQCrLNpYrxZKLwy3+YXaQM?=
 =?us-ascii?Q?uGC6b6KqwULchcX8ah7DtfZF+mlmiElY0fLL88a9ZYbX3Mxrqlg5dw8g45DY?=
 =?us-ascii?Q?KDoghssTdSEm/Xsc0rTeCbvU9Al9JEwLXd6fVPnv0UKTwOhAFyFUaDVTWuVz?=
 =?us-ascii?Q?/zbHe0QcEgEpdPKKMrNtEEKpyajj0PA2c4EtCVXoy6OzULkVy4Yangcrapg+?=
 =?us-ascii?Q?GewscxiDatCNTpRjWKflaEJjiXOw95dcgJ8Af4TxIevtUWH00V1WO3S/P5E3?=
 =?us-ascii?Q?uc69WrEez+hSu4uuizPSPiUwa4tPzW0ca0eI2eJvD5SG1RlsRp4g+oCnKMFL?=
 =?us-ascii?Q?wm9pcgcM8AsKL/Y1HCFyLoC0f8Owo6jac76CwAJWaFG4U4g0WpHKxWDcADac?=
 =?us-ascii?Q?ztOxDs5HZ+/JURyALWgBsSeAWl2yKm0XH07hpq5sai3SL//swVGCaxET8EAC?=
 =?us-ascii?Q?DMQMnsa/6JN6qZ0OqDhQtfwIiqOJY3LtOKsqSRvanbphhH++PPErKrD3o+6i?=
 =?us-ascii?Q?EdisnTeMMESCKjqTZxjG96o3qZ/Lzvo7KWeHOmwnYXWN6zLBGj/shdAXBmLg?=
 =?us-ascii?Q?UkerxYJibJkixjnn87c3blcSZsIz8fWYvs5mSbZ9gJ8hV2SAtPLLITO7wOdM?=
 =?us-ascii?Q?BwYvLjUh5zNLiacmgkPYTX8o8qgBZKDgYl+KAMDIIlHPuim/FT2PrLaVcweE?=
 =?us-ascii?Q?eSoG45Psn2dc/TJ/3RR+uhD/BRK40irzyPY+qsnndXe3pu8FJchAUPzzVsR3?=
 =?us-ascii?Q?TzSx6NnEDFUdIHiyWB9H7/9omzrivNdSv2P8SRtcJJD+pSpZCvd6tDCQfho9?=
 =?us-ascii?Q?HByffCGthM4ihgaRH7id1Sfb4A4W2RF/qQP0xrnKcr9yZR5lKQ+v+V2CparP?=
 =?us-ascii?Q?2Qu2IxvowPIkmU0oD5XRv9IjXvUH7k4u3YLI+PIvKX00+ToM3qj60LvH906E?=
 =?us-ascii?Q?w8ACTbW2jTzM6mQt5yfaKkveMzWAln8w2XAl2WWsd6hvqe9s0f5fXMKd8NE5?=
 =?us-ascii?Q?el9gs/+1lufYSmBngbUFReuFO/BzFLdfPpLtGkY5dWn4ot3rCbKhUa4AsyfZ?=
 =?us-ascii?Q?nC24nGDUrGKFWtrPxWMV2lqdj/Lxz3eDjdIN8uIc8109JteJUC7CMr4/OUof?=
 =?us-ascii?Q?0OnQHSdoCv2ZqWFHbbOiHo+OPIPCnXWlcnvSU0xcc7M0qcXEboxdsIGYavr9?=
 =?us-ascii?Q?WUpI8xhmGBCHr7f/VZybCGfEuc2hggxkvvatJNPo+kJtFdCeDQ+PZbofLAQQ?=
 =?us-ascii?Q?SeZHCBGSg8hbDeZPmQycnFtOMd/Yfr+ls5LXX7XdVcJdVhlBiGkw4jysbiAS?=
 =?us-ascii?Q?456Agg3pBGAb2Ep2OOk6VkvFNqaKs+jDBoBUy2MFQy7KNDS6WLf0WnhUgFhG?=
 =?us-ascii?Q?8+BsGBU2TcM0v2EO0JM0C6V9SZmZ7qwMaEvh/ntfAXPbwjpQj40x93MKfuPN?=
 =?us-ascii?Q?S+lH+oYwk5XZZNAaC+JIxzOV5BmbsdMLcADsNXgAmm/NF/dHTsiTb+eFQJG6?=
 =?us-ascii?Q?epFyyl7d2JDy2yhVOWhn9rlVLhzCDE4y9VvTIPiZXRJQpxXhNP6qh0md+75n?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19987fdd-7dff-4f78-7f3a-08dba23e4997
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 12:01:01.0470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BY99TwARgulJPWVSuaxOCqDq+X0ib0LC+8YDnQ7G+5HHZhwTdOPoiSmIbZwI1FnE7pX9APze8MZ2Y5zJWhm8Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7832
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This moves the sync_handle parameter from the iso_pinfo struct to
the bt_iso_bcast_qos struct, so that it can be retrieved by the user
using getsockopt after PA is established.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 include/net/bluetooth/bluetooth.h |  1 +
 include/net/bluetooth/hci_core.h  |  2 +-
 net/bluetooth/hci_conn.c          |  5 ++---
 net/bluetooth/iso.c               | 14 +++++---------
 4 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index aa90adc3b2a4..ee284b9bcdd9 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -198,6 +198,7 @@ struct bt_iso_bcast_qos {
 	__u8  sync_cte_type;
 	__u8  mse;
 	__u16 timeout;
+	__u16 sync_handle;
 };
 
 struct bt_iso_qos {
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ba2e1082b86f..10322e09f875 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1462,7 +1462,7 @@ int hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst, __u8 dst_type,
 		       __u8 sid, struct bt_iso_qos *qos);
 int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
 			   struct bt_iso_qos *qos,
-			   __u16 sync_handle, __u8 num_bis, __u8 bis[]);
+			   __u8 num_bis, __u8 bis[]);
 int hci_conn_check_link_mode(struct hci_conn *conn);
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
 int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8b0c8e631324..2164c8b7b962 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2105,8 +2105,7 @@ int hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst, __u8 dst_type,
 }
 
 int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
-			   struct bt_iso_qos *qos,
-			   __u16 sync_handle, __u8 num_bis, __u8 bis[])
+			   struct bt_iso_qos *qos, __u8 num_bis, __u8 bis[])
 {
 	struct _packed {
 		struct hci_cp_le_big_create_sync cp;
@@ -2126,7 +2125,7 @@ int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
 
 	memset(&pdu, 0, sizeof(pdu));
 	pdu.cp.handle = qos->bcast.big;
-	pdu.cp.sync_handle = cpu_to_le16(sync_handle);
+	pdu.cp.sync_handle = cpu_to_le16(qos->bcast.sync_handle);
 	pdu.cp.encryption = qos->bcast.encryption;
 	memcpy(pdu.cp.bcode, qos->bcast.bcode, sizeof(pdu.cp.bcode));
 	pdu.cp.mse = qos->bcast.mse;
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 9879f2349d48..47f7176c166a 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -63,7 +63,6 @@ struct iso_pinfo {
 	__u8			bc_sid;
 	__u8			bc_num_bis;
 	__u8			bc_bis[ISO_MAX_NUM_BIS];
-	__u16			sync_handle;
 	unsigned long		flags;
 	struct bt_iso_qos	qos;
 	bool			qos_user_set;
@@ -792,7 +791,7 @@ static int iso_sock_bind_bc(struct socket *sock, struct sockaddr *addr,
 
 	bacpy(&iso_pi(sk)->dst, &sa->iso_bc->bc_bdaddr);
 	iso_pi(sk)->dst_type = sa->iso_bc->bc_bdaddr_type;
-	iso_pi(sk)->sync_handle = -1;
+	iso_pi(sk)->qos.bcast.sync_handle = -1;
 	iso_pi(sk)->bc_sid = sa->iso_bc->bc_sid;
 	iso_pi(sk)->bc_num_bis = sa->iso_bc->bc_num_bis;
 
@@ -1174,7 +1173,6 @@ static void iso_conn_big_sync(struct sock *sk)
 	if (!test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
 		err = hci_le_big_create_sync(hdev, iso_pi(sk)->conn->hcon,
 					     &iso_pi(sk)->qos,
-					     iso_pi(sk)->sync_handle,
 					     iso_pi(sk)->bc_num_bis,
 					     iso_pi(sk)->bc_bis);
 		if (err)
@@ -1643,11 +1641,10 @@ static void iso_conn_ready(struct iso_conn *conn)
 		if (!bacmp(&hcon->dst, BDADDR_ANY)) {
 			bacpy(&hcon->dst, &iso_pi(parent)->dst);
 			hcon->dst_type = iso_pi(parent)->dst_type;
-			hcon->sync_handle = iso_pi(parent)->sync_handle;
+			hcon->sync_handle = iso_pi(parent)->qos.bcast.sync_handle;
 		}
 
 		if (ev2 && !ev2->status) {
-			iso_pi(sk)->sync_handle = iso_pi(parent)->sync_handle;
 			iso_pi(sk)->qos = iso_pi(parent)->qos;
 			iso_pi(sk)->bc_num_bis = iso_pi(parent)->bc_num_bis;
 			memcpy(iso_pi(sk)->bc_bis, iso_pi(parent)->bc_bis, ISO_MAX_NUM_BIS);
@@ -1689,7 +1686,7 @@ static bool iso_match_sync_handle(struct sock *sk, void *data)
 {
 	struct hci_evt_le_big_info_adv_report *ev = data;
 
-	return le16_to_cpu(ev->sync_handle) == iso_pi(sk)->sync_handle;
+	return le16_to_cpu(ev->sync_handle) == iso_pi(sk)->qos.bcast.sync_handle;
 }
 
 /* ----- ISO interface with lower layer (HCI) ----- */
@@ -1708,7 +1705,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	 *
 	 * 1. HCI_EV_LE_PA_SYNC_ESTABLISHED: The socket may specify a specific
 	 * SID to listen to and once sync is estabilished its handle needs to
-	 * be stored in iso_pi(sk)->sync_handle so it can be matched once
+	 * be stored in iso_pi(sk)->qos.bcast.sync_handle so it can be matched once
 	 * receiving the BIG Info.
 	 * 2. HCI_EVT_LE_BIG_INFO_ADV_REPORT: When connect_ind is triggered by a
 	 * a BIG Info it attempts to check if there any listening socket with
@@ -1719,7 +1716,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr, iso_match_sid,
 					 ev1);
 		if (sk && !ev1->status)
-			iso_pi(sk)->sync_handle = le16_to_cpu(ev1->handle);
+			iso_pi(sk)->qos.bcast.sync_handle = le16_to_cpu(ev1->handle);
 
 		goto done;
 	}
@@ -1742,7 +1739,6 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 			    !test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
 				err = hci_le_big_create_sync(hdev, NULL,
 							     &iso_pi(sk)->qos,
-							     iso_pi(sk)->sync_handle,
 							     iso_pi(sk)->bc_num_bis,
 							     iso_pi(sk)->bc_bis);
 				if (err) {
-- 
2.34.1

