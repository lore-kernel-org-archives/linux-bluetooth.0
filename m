Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8B4C83F24
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Aug 2023 18:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245668AbjH3Sx6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244354AbjH3NCk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Aug 2023 09:02:40 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2064.outbound.protection.outlook.com [40.107.241.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE42132
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Aug 2023 06:02:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0D6sncPi9NGEJbIjRyQks5HlLasY7IWVjaStWCT3vYyDnwMWKhS77u+mQ+exaAF0RVQAE1Je6EwtZMEkHTNi0C3GwJAYazqXBjj6crSk/hKGaOn5HEjkXZx8Z4AmZD1VZ255kJvXLwRoXYxMQYmORZPbFdinYKs3+D2jciAL4AqzRh+m/FZ8kS16pqLvNEqkoWMR9ze9YIEcaELSB+WnCtxZqDuj99QdgDhpe15zqzzrBvRiPqtrdg9Na29ngZReO9RV/ksSVK4zfFp/qfZ4+wwMExaciS1MeB52fY/D+tZFemEKMaIiWWLfOoy57yUbnyeIzC6CD+Mdbk97itA4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3cycxPYeHNy6P+lfTaqMD11slb4hqVGOK/BYLB77lg=;
 b=Swl/w0EHV79VrF8NMM5VvkWzP8/emCfYuu9WUdURvMr/0QHA0iYV0wZ/fco1G0KBbnWyWi5qjjrumXiA7fF/UONpifljh/7ldhgnVX1ZDulBKILsU1YwgRhcwvYChYJbnUkBbpPtxjDDpr8wo24D2RVmyLnQu/qXd2QSTZLy0aMZ5R7mG7feyudmgo701K5px9VTdeOg9AZrN+3x7LThn15q6oypYSz0cq1GHnIYKOEQmDpufLiMCgZzR1sEbmjL+Di6G4V1d4MFDp6O9TtVhezhSziWJVBywoEo4fSEAZGvbe++A7h3wrRLVjNOEr7qXalWaSxDROMOHCEkSMZU1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3cycxPYeHNy6P+lfTaqMD11slb4hqVGOK/BYLB77lg=;
 b=gtp8SLuLdcedWxQD5gpj+uY5tCbbrXUT13PhHpbjjdDbYxKsO/rhkykum0kp1VvaG4R5tbgLGN3hMF3lRMCCu0sdXjI56wgkoOQZrVz5+k7400VSZ49B+Jzc0rgm6q3xRuu5efeCLNZZ552FJOiaZdRdGP1Ty7zq6TzNXGjyTAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU0PR04MB9442.eurprd04.prod.outlook.com (2603:10a6:10:35a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 13:02:32 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 13:02:31 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: ISO: Pass BIG encryption info through QoS
Date:   Wed, 30 Aug 2023 16:01:47 +0300
Message-Id: <20230830130147.359016-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830130147.359016-1-iulia.tanasescu@nxp.com>
References: <20230830130147.359016-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR08CA0010.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::23) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU0PR04MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e7336eb-ea5b-4bcf-dbee-08dba9595ee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mk0/aWeWx9XiOTmRhE9KMA2W2LhIMsS2uUIPTrsYzJBnKV9qhAxKHcSaBLipoXsUsZCqQvMKPGroUVmIMXxhhikaAYrg6gOIJjTb6STIfZbSH9Z3cd/Kted+NdNp2hMD0oH61l7zEP02PINBVPVXlS+ir1T4b+NEH5KvmxmCMAL5W+p+/6aWUdaQCbioRVeiBGfx2BP+uf8bBdhQuwg58HRX9pVbiDAYAS9Fvo3SH9QY6EDAlJ7kCTHo/ft2W9261pUrbAz6fJOXF31+j9jKY9ZrE6oDPkbRwj+gQyYumKMkj6ZXmIgNyPgzuyX/RPU98RSgNAs8IMyBRkyaz0lM6fxfApm/VP0AB7FG/jLc7v5c1KsgyL1ae6F2PE9lud2IjccwQTh1E0WdEdeHPi4g952+ILKInKg3D3qXHeRlliUMgMSBdEJnoEByN6rYMjQNDcPdvd51akYcbnW1y18umV0lZoxorqGTeO6+EWFme6PaSru4oRFUVTBvkV2R+kUeQYiOGcUAp+KXOjQ90TFbtweAUJbskxXjKABUDzPLCfMzE9Mv7S4gy67+eCKKTZoLsB7/T/hTHonMfsR1KFLMjz3dqzPU8uobNNEr4mRwMODi9lggAkcVEc22yU9YqFtF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(186009)(451199024)(1800799009)(2906002)(66556008)(66476007)(66946007)(316002)(6916009)(36756003)(41300700001)(4326008)(8676002)(8936002)(5660300002)(44832011)(6666004)(6506007)(38350700002)(6486002)(52116002)(2616005)(6512007)(38100700002)(86362001)(1076003)(26005)(478600001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1OLnZ1DfzGwmpcX75bhfBzGJYI2MtlH80hgCowMiPW9IgLSdvOuCVFc3LICP?=
 =?us-ascii?Q?wsfXX8VbEsqmjB0hznGvxw/aawXgWpeZFm2qsdMMY/oAKortiVB3EFrZVmRd?=
 =?us-ascii?Q?VUwHqCWpx3UYIBSogUTqY+RFe3Symd8FhjHx4a7YQcdeiD9iNvVV9D3Jrwum?=
 =?us-ascii?Q?S0p7PU2N9Ixc80iPYXBIxPS6zfsilS4oEP+0m1d6LYSLHvRGwNha8arz/4Nu?=
 =?us-ascii?Q?Al8RXDAKgcAQ5CsSFr/d/FhovTc/mQ/oOaq/BBJQokZd3oOL4UvwjAjC6d2f?=
 =?us-ascii?Q?9XStOviHggdspsgf1BruTogoihiEOv0rW8qH4X/wGuNL4TwT7N3TtT2Suris?=
 =?us-ascii?Q?AQhFzGLmmkiLML1V/OYVQmlovdvLa5wMM8LVOvBWajceOInAAScaFUFoexCQ?=
 =?us-ascii?Q?sgxHPSEbbglTNzaEq/GvX3G9oegFuxI1MU/YLKnp+7vyOJyZ6e4PF9kLo6Up?=
 =?us-ascii?Q?egRSBjo+6OzW9T1ffT/rdmcCe48OqrJ5gChovqZXN9OOAH+mESQ4Fk68X2mk?=
 =?us-ascii?Q?wb8+hMo8HbM68ca+ZajxKfB/ag4J5k9zy7paoES0sYWyTvRIDfw0E8PdGFFB?=
 =?us-ascii?Q?0X5DLjhIZ5n0mZ4wpw0uA/3AQzP6H7Q7IdUVlzqNmAX76sf2eAU0pZpgCwnM?=
 =?us-ascii?Q?0ES+yI74kIijdZFyihb2gKcUjzIXk6H1AduGM8Pkn0wG9rAg1G8xkCyIR5no?=
 =?us-ascii?Q?qnxNbiQ1WtMiR1MoDu2agt/w9yQCRJDQC0o0FVo+4RygX2E4s8yjL4DQO8yU?=
 =?us-ascii?Q?vxcUeyTa8CXJceGihU45D+Hg/Ovr93mLrxDKoSeJT/RM/qbwcXjUsfuBMsiM?=
 =?us-ascii?Q?CS3AKkwdhE4+cNUEtUNK+O9Qi+QxxkGJ/WjbtP42+qsFXFMZS9gVdna/wCXS?=
 =?us-ascii?Q?txaigrsBUkApZviciMscrvks34BQ9/b2d+WqUXoRnfKvHQeOlNSWRZzjZNrV?=
 =?us-ascii?Q?RqRoJzsOKkXjw0UmwqKUwBmdKX/woxUG4+OUm/uQr22BUVPIpFRPCuLr/JYI?=
 =?us-ascii?Q?um1hwS+VfzEG1kI7faAtDsV07hmy/J0LrJNJItitC4qccMZSXkjMcSucs3tA?=
 =?us-ascii?Q?LQp4PR3Ip3kzjZ2jEqxHiOdiNaxb0SiPLdF82AZ7pATVM/ULBe0H96L86nUU?=
 =?us-ascii?Q?JxXvnLBogR8duAlM7Xk2lMekjZbG3VtnjBUhRAIl8vEKctS4Sc5xhRw6P7a/?=
 =?us-ascii?Q?9otkKCmNpoWV80HCyFUYXkGeRHPqUKDIUUiQ0sAtP/wkKxcfKEoqvJszJ/SA?=
 =?us-ascii?Q?uEV4i4VHgpc8HVSYz7gd5X7rf7ykWrNIloxMCKlQJsAFncl3pkgNK/4Z/gU+?=
 =?us-ascii?Q?uOGUuC017kDj+lEGRhxR+4crNePmv5KKc/2JW86iJxtFGgVY84TLncKhixCq?=
 =?us-ascii?Q?jqhtSXJHVExgj/PV56/HI760bh9mVJoo2UX4d50AnylpkIb7lxCPOs4+NFwe?=
 =?us-ascii?Q?wifhx0SgUjOkxMs+PsK2rboMnXGvwmHjylb472x2uV4zyLHt31ix4yBCbqgm?=
 =?us-ascii?Q?4uhnu3mWMR/Xo/OootvwSGDhRI0SRMhwLXwRi29UXCP7ZwoyVFQxn/Dd+5yY?=
 =?us-ascii?Q?afnSGHsbx/nlLQicPpOQkN10229w+VniNPioLHonnHiVzodVDAa1FaIKZnjy?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7336eb-ea5b-4bcf-dbee-08dba9595ee4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 13:02:31.3608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGb60nla80jO49MbykdPqQnbiDa2Dhzvc1igCFVJKkXnXUSqjvod+cALS0IaQwymE/cnDWo3uj0xuysjxl72Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9442
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

