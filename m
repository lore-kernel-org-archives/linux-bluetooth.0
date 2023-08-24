Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8B3C3DA6F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Aug 2023 10:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240161AbjHXKRV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Aug 2023 06:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239591AbjHXKRJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Aug 2023 06:17:09 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2053.outbound.protection.outlook.com [40.107.7.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB5A198B
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Aug 2023 03:17:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yy5gUwTAc45A6vr3YRt3QvuywnXuwzFl0gMwKEtppVdZp4cNrge/0O8mS9UsxLJ8eQN4lIR7MoaHg71uOeMN2lhBaullb5opRzgoJzHdVMtkO9mGmUB/yohUXP0DitCP1RPQl4Pw1UdEPr6GSicp7UmRu7JAjWU9V/xNfsjzz7RL10ZbPGZ5Lft3YbuLo0e7dtcPWBW6m/g+l7fIPBp5mWZrOVYVak+O7Cp08JEQyZeoq9D/l+JUFCW3Wpka9x0Sl8003+HFjksfwIY6rZMvruxilPxi0bAmcXK+nFWM5NIHQUYduhB8qlB/wMZplirSAQh17TNfcX24GNwTYpCgLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39QJo3oWtPXxBM3eG4V3giNSIRMr2jUJVoSjYd21LEk=;
 b=OxSwPr0nN08ZP45w6cQPR4rXd2xRXSJYR0FD6jRqHmFFN0plMwFt6tuaS5+1toLmIjCkW+xoUfqqV7ZntTFpWPwnNxfaG4f87j8b6dgs3HS9zoqQnlEvM0GYHUEdRlvInvsshJZWRTxHmBe+CF/WEFkFYBtUVqwmjQucccjmgjgjGRRgBwTKxOkqAyPLNDT9riBc14iI6sMDTtnAKlv4bteR5TWQpvf/OJvx09sSEJu7iYNDkWf1WSEUVtklo9xdflt6ARu2CBeSoCMabDbxIOi3P21b2fdySZoeyta3p8VjTZkrPHxwT8/Ra2rXN+Yh1NaFmRSAlayiYWfEvH3Now==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39QJo3oWtPXxBM3eG4V3giNSIRMr2jUJVoSjYd21LEk=;
 b=XHYIPBp7O0A82jEygnQZYYtrxq1rD7SqXVLFJE/FqUJQi833n8QWPXO3fCjGnkjYyEr2dpdsflUP/hh4Y5iT1x616ePVALKn/IGO3VKmzcWx1qWkdc1WuIJNA8M6VnbpNG9BdKjPCm2PPTfWhj6JRltasw1aVTZY28BhgEXwLK0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB8PR04MB7034.eurprd04.prod.outlook.com (2603:10a6:10:128::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 10:17:04 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 10:17:04 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 2/2] Bluetooth: ISO: Pass sync_handle through iso qos
Date:   Thu, 24 Aug 2023 13:16:35 +0300
Message-Id: <20230824101635.25662-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824101635.25662-1-iulia.tanasescu@nxp.com>
References: <20230824101635.25662-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0005.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::18) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB8PR04MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: c0ff0148-927d-475f-d5b9-08dba48b439b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Pio5+4GNVg+9rQSRUgCVQPrAPXObtvCrohK0G2lZ2mZ114zHVLNQdJEBk5G5tE4vevmxt5pcUy27/ir4SNfVVJa6TGZQsgOggzgoB/WhU11AayqgP9gbkBg8EGJ78+3lBHcahctPOlrDfnM5TgLbcac97DdZQnkqQlmys974CUNptZ7UZNAcY+VPcMhXJoQ7slpfwCwcoYdOos3Kl4AbcXN4HN3yTVWoyb5JczgpvSp6N7ZD3L9VhY+Kys5GNPTjXeWM+rusAz9JXh3WIrWTLADFvIbtgwO2KsG4oeNt3o/uGtu4LFl6xR9Qva+zjO6sMoL6yamWZFQ6ucJEKkEu3Q+nctdgSGFwKaXJ6zTZipGYVQzbx59AxZp9P4H21eXx+5PF8kpf1rbU+I4/tUHGMbAYVNEk9a4lJltuPkOZ0VGJFeev5mj2yuzyoSsWrhVPM9hSRf2cQPmolLT4InGxhDbKFmJpgwB6TQDMrnfXTDSovvVbkgA2ghWxZr/OuHXeMSzFUaW70pOgJaPaKdqqtO4J+aTD9dWmZcaWZ/6dlWw6y7SYsNax+iO1tNtUtv21HNWDRqpRVUMz+qugDrN91tbgLmH+cvoleIFGX0cqdLiQL0hZjNfmD/827JT1yLJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199024)(186009)(1800799009)(66946007)(66476007)(66556008)(6916009)(316002)(478600001)(38350700002)(26005)(44832011)(6666004)(38100700002)(41300700001)(52116002)(55236004)(86362001)(6486002)(6512007)(2906002)(6506007)(4326008)(8676002)(8936002)(1076003)(2616005)(5660300002)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UWkdv1EJUIxP4hBrs7ozjBWhd9XVaWvHXtIC0MYkp+OWSG06L/rtiLrYQvy6?=
 =?us-ascii?Q?cLe6JE3q2DIKZtM3ko/KEie0edJ7YFt+GzWSL8TeMptTprCrWHuSEkkdQGQP?=
 =?us-ascii?Q?dnMSp1Ayo9JxZnpLYp+8i4Rcte+R4KHzlm7u8bGK9YodB5A7gvJVP8BiTxaI?=
 =?us-ascii?Q?Zciq/r5HuFSkHzZlIeW8BvD/OLmNXzWXP05YuUJORF2/HIDkAfbyraIdv96b?=
 =?us-ascii?Q?BzLoQtQJQV24btz0yBRrugH2BurpL2dsdjcvUPwKAPcGL02tBTXlPXfRgxZr?=
 =?us-ascii?Q?/22FrpuijaHN1IZuq1nCcBA1/bE8+gvYKnzcY/sJ1ylX5lKwTjfpujwzY0eD?=
 =?us-ascii?Q?J3DkcYDHbno4kdI6FDz+vA5UIHntznV5Jcfy35uvQE80l+WyIxwgrxiF2EuZ?=
 =?us-ascii?Q?M1FSGUFCEsM4cTY+MdUT1SYftaCrXSsxBUQsUpaJMuATT7qOjWcxqtvBPr6V?=
 =?us-ascii?Q?Y4LYjTA1ZllJ3dV5xP4Ma7fnhrL84RQhcM9HD2mCk7Z2ctHnSbpGamsGmdEK?=
 =?us-ascii?Q?fKc/4ReO0eLledgiDeJeKr3Jg2iNeg2hn2oKzMz1+wnHaXksSkDSQ5XiYw4r?=
 =?us-ascii?Q?kNan7GEuJ75L0LkKA8eVXuAJUJfX9ma7iQcv6UHR7EJlJ5GFBJL74iPHdhk7?=
 =?us-ascii?Q?Gls49UVn3m/r9rI/4oOpbGxgXsCyhr6oT7EYndJW8vPiYImPo4Vv66/RwAHc?=
 =?us-ascii?Q?D6vgaYeGjTTmICKl6nW8UPvGGZJB46lBYvkHzipn5oBQkxqtoiW/UYNngRh/?=
 =?us-ascii?Q?DzIn1kDmhT9cNwZfox3jY9Ml3oEAplpCUec+FuNt8ymoJN/y2nvHkJyM9bUf?=
 =?us-ascii?Q?1qkCxJaYevNveRWm00rO4i/4q99G6czR/gKFJR5a69Q2O6aE7bpteP8XqvzO?=
 =?us-ascii?Q?Z89QW3Xt2+JaF+4jLWk/mNkclLTPVKqOMrdEYhyvTLg6LvREihKdAKs7N9ho?=
 =?us-ascii?Q?UIha/7HLz9mrXp6KnBtYzO6+HUr+bkCMmU0Zv4fwLugunn6dwAjZ6NwmEdZ5?=
 =?us-ascii?Q?ZJbkiCi4fw/q+633OWdFBD3VNrm1skcRbAmUMMjyaeNCizOhRTMXiNx7FMn6?=
 =?us-ascii?Q?n5RILe1eftyg6HqkfFcQXUIi+uFAl3d6tntA1clQrv56MrQM9rkR4qU1xX5E?=
 =?us-ascii?Q?xt1+Mj/ZPsM4rfJBoFtd6Uripo9b/+TaCOImqF1h535uM3sOCZUaNvWsUEuv?=
 =?us-ascii?Q?tcc5f0mkyqSta4HiauWswudGtSYfA/7SzYit33fq1DFTC6DniWgzsJeoCJY9?=
 =?us-ascii?Q?+oIMzMevzrcIxJQWWlLMKsZXmGwtepzoOklr9IEpLgShpZhap/LOImby6IU3?=
 =?us-ascii?Q?itgCHC3fmZGudlZEr1kTYttLP5mBXNGT25ZeuozBCipt8qVRv5jyUvdcWT8/?=
 =?us-ascii?Q?EiIRyHG12oEwv5p81fK52RhifzMYIUrRPEfeXp96fa6YDPG8/prBu4h+pFIN?=
 =?us-ascii?Q?wMJ1N+t5o3JpHJTIoIYbtHo5nrndBebf10IzKOIaHD6ZuW/cTXDsJqdBxxKI?=
 =?us-ascii?Q?NWVZonvlUUZxTdIbv6uxQRq1WHW8XQkEsTnRC/MNJFSCfvtlRkW41TIeFNLN?=
 =?us-ascii?Q?kFT0wxiaq834M8FHPMZcRkVGeimwg2o8IyV+40NKzLhi6VwBBNRzt8/ogqTq?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ff0148-927d-475f-d5b9-08dba48b439b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 10:17:04.6318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4DeBS3AM8eOfmh+e2BPAc1o2TjWnUnbeCw0pnWUmaFn3X6M/KDsIT4a6a2zoxtAZUcA13WJegGKmS/iHUj2uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7034
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
 net/bluetooth/iso.c               | 18 +++++++-----------
 4 files changed, 11 insertions(+), 15 deletions(-)

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
index ad6d24f17b73..22992ae5668f 100644
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
index 9d5057cef30a..1ea0f7efd212 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2121,8 +2121,7 @@ int hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst, __u8 dst_type,
 }
 
 int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
-			   struct bt_iso_qos *qos,
-			   __u16 sync_handle, __u8 num_bis, __u8 bis[])
+			   struct bt_iso_qos *qos, __u8 num_bis, __u8 bis[])
 {
 	struct _packed {
 		struct hci_cp_le_big_create_sync cp;
@@ -2142,7 +2141,7 @@ int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
 
 	memset(&pdu, 0, sizeof(pdu));
 	pdu.cp.handle = qos->bcast.big;
-	pdu.cp.sync_handle = cpu_to_le16(sync_handle);
+	pdu.cp.sync_handle = cpu_to_le16(qos->bcast.sync_handle);
 	pdu.cp.encryption = qos->bcast.encryption;
 	memcpy(pdu.cp.bcode, qos->bcast.bcode, sizeof(pdu.cp.bcode));
 	pdu.cp.mse = qos->bcast.mse;
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index cb4ebd75d1c8..550dc01801de 100644
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
@@ -1644,11 +1642,10 @@ static void iso_conn_ready(struct iso_conn *conn)
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
@@ -1656,7 +1653,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 
 		bacpy(&iso_pi(sk)->dst, &hcon->dst);
 		iso_pi(sk)->dst_type = hcon->dst_type;
-		iso_pi(sk)->sync_handle = iso_pi(parent)->sync_handle;
+		iso_pi(sk)->qos.bcast.sync_handle = iso_pi(parent)->qos.bcast.sync_handle;
 		memcpy(iso_pi(sk)->base, iso_pi(parent)->base, iso_pi(parent)->base_len);
 		iso_pi(sk)->base_len = iso_pi(parent)->base_len;
 
@@ -1693,14 +1690,14 @@ static bool iso_match_sync_handle(struct sock *sk, void *data)
 {
 	struct hci_evt_le_big_info_adv_report *ev = data;
 
-	return le16_to_cpu(ev->sync_handle) == iso_pi(sk)->sync_handle;
+	return le16_to_cpu(ev->sync_handle) == iso_pi(sk)->qos.bcast.sync_handle;
 }
 
 static bool iso_match_sync_handle_pa_report(struct sock *sk, void *data)
 {
 	struct hci_ev_le_per_adv_report *ev = data;
 
-	return le16_to_cpu(ev->sync_handle) == iso_pi(sk)->sync_handle;
+	return le16_to_cpu(ev->sync_handle) == iso_pi(sk)->qos.bcast.sync_handle;
 }
 
 /* ----- ISO interface with lower layer (HCI) ----- */
@@ -1720,7 +1717,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	 *
 	 * 1. HCI_EV_LE_PA_SYNC_ESTABLISHED: The socket may specify a specific
 	 * SID to listen to and once sync is estabilished its handle needs to
-	 * be stored in iso_pi(sk)->sync_handle so it can be matched once
+	 * be stored in iso_pi(sk)->qos.bcast.sync_handle so it can be matched once
 	 * receiving the BIG Info.
 	 * 2. HCI_EVT_LE_BIG_INFO_ADV_REPORT: When connect_ind is triggered by a
 	 * a BIG Info it attempts to check if there any listening socket with
@@ -1734,7 +1731,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr, iso_match_sid,
 					 ev1);
 		if (sk && !ev1->status)
-			iso_pi(sk)->sync_handle = le16_to_cpu(ev1->handle);
+			iso_pi(sk)->qos.bcast.sync_handle = le16_to_cpu(ev1->handle);
 
 		goto done;
 	}
@@ -1757,7 +1754,6 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 			    !test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
 				err = hci_le_big_create_sync(hdev, NULL,
 							     &iso_pi(sk)->qos,
-							     iso_pi(sk)->sync_handle,
 							     iso_pi(sk)->bc_num_bis,
 							     iso_pi(sk)->bc_bis);
 				if (err) {
-- 
2.34.1

