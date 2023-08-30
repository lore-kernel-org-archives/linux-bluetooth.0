Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BE2C83F17
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Aug 2023 18:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245696AbjH3SyP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245597AbjH3Pj3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Aug 2023 11:39:29 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2078.outbound.protection.outlook.com [40.107.105.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BD2122
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Aug 2023 08:39:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aw5U6rCreyrVq3qwbgWI+VAHlaH4CCvdEA4hO3IFFJHWe5/na0zhtCHCaeqdCaYg9AfaIYW8t48vRxHAGUlj13i9GsUtdpsWH1YYwHceyNw283HB4+v2b9Rqj4o1iQzaoOwNKDQ4iBVYqqxL+bDrDSU+flY/e7BnD4itlg9VF3/1txR+20XYTN1DAP82N/wg5Sf+iAk1nnwou2idTH4j5L2h4NidPuhsHRArH0vomYB2xeR+4mQQF0CZdPgnj7Y5IUVWSA8GiJha+YMNW20wqTossAotkqhcCHO96+Xd5D/2P41bvYRL0hUiYfZfxOZylNgEax+C1BDs+8Qkfa5qaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4s7OmhEbjOm2WHg1HGUnuihKbdUzOCgn2lyZL4t2K8=;
 b=H5LkI1XS9qdUqen8DqDpXTEYAsR3wr6+RUw3vkW4a9eScW/+DkEIpf4xcyjCoABeTSvqiCNJTx4hKuZp47BcjIMtQ/vilv6MGVCXdd4QVOi+2TMy8F/mYEXoulWbCvc37z/Oanj8vRbdy5VzefUEKL8wABAbY6hfIhidq2PFbRAt4Z2SpmLiQypNnrekG1jaFYjYAY3ydOqF3N+npnorsbt0kqrzKhIQC0GFmp8EqM05a8F3oSaFDrTbM4NRbVksEeRWFm/KQH5cEjWNWKmtmUNRgkSLRpsuWcCt2RlWC2j1FKFfn+4wEPc4shMuIk/vs9nUi9t1AwjDQoWqRsLqfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4s7OmhEbjOm2WHg1HGUnuihKbdUzOCgn2lyZL4t2K8=;
 b=CflKFkYXE/q7QYtiDdasSNk8e8zwB/B7U6GlxHUAQqqNqKFMiWYnT5E6OpJ8Ml1qvNR9ti2ocwlCGH3l30VZD45Qu134cZv5FzjUY+IB0IpJWJxtoJdqPXdw4Bf4LzG3IY6NPi0Z0DpeRZWqms4WGvr8g7AnrkeybGSnxhGelVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PR3PR04MB7481.eurprd04.prod.outlook.com (2603:10a6:102:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 15:39:24 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 15:39:24 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: ISO: Fix master BIS cleanup
Date:   Wed, 30 Aug 2023 18:38:40 +0300
Message-Id: <20230830153840.518868-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830153840.518868-1-iulia.tanasescu@nxp.com>
References: <20230830153840.518868-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0091.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::44) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PR3PR04MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 4778661e-78c4-48a0-2c26-08dba96f4979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VW69/X+Ns8v1tZOJPi/fpCIa8OkORdDgtwGPOfk2q8iRvHjhz0QNQTTxUxmtrnJQQ846+jmFqSYJcaNkQdMEtYB+c+yNeqnS91Z/ZSGUgm4sq/dEsdbS2t/yZBuIng1Dv6aZFQUTsV3J2XbyM3Qz2Fi44qaC2JyUGQOdwSL9S/0zt/0xOqB3OAwwNL5ssxHioM6NJdErScH7ZlzBqkS6+La2Dhjm4NvKjU3qlXKWyQvvJ2a6TYz9G+ccdz88LONjrmyAaLUmsfSFeg6t7MzqpRFvZOQT7zkI1JSBlwcx8c3N6ztcYnqhMEzQB4b+CtiMl4B21PgO7HuOo4K2k65IOU1mEhvVkxgNWG1y4V34oY/xggJM8n3OB7LLajEmec8PSf5/FTYIfG3X9owuRb2IQJOw5vUnxfacJ10W+qfHvyvxNOcNk3xu9idYMpEEKeV4I4ujiKxvrEqt3YMzm+7Cc/cH/fI7q2CssuoLS7pHveH1jor8keQvB2AsmqDdV6ksynNi73OaRhnMRiLP5R4BYpalOqeHQevaBg3iLfB7raEn3yq5zIiHNVpUZo6DZuGn/s9FFxlbPuTLok9Ap1N3xFHoHaqGFFE2lR/JVjUTITRJm0TJ+HAIcTHNVwCLfuYe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(136003)(376002)(186009)(1800799009)(451199024)(6486002)(6666004)(6506007)(6512007)(36756003)(86362001)(38100700002)(38350700002)(1076003)(2616005)(26005)(2906002)(52116002)(83380400001)(478600001)(8676002)(66946007)(66556008)(4326008)(8936002)(44832011)(41300700001)(5660300002)(66476007)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cl8FSHaiszdeeGxxgq3/RbAV9MUf8VTijl9XsN95axYnJcqSl4npg5yXSUDs?=
 =?us-ascii?Q?OIvETXAJ8PiM3y3MI690R5r8JdiplN+8NGM0bP+W7y4UXRhrZE5oYsgoub5Q?=
 =?us-ascii?Q?oU7W5KZSl8cxCIxUpv6gRLMMdgqNBT1jMiHfk+dAe4bHAokwu8hLNZUmwbAs?=
 =?us-ascii?Q?MKuaxwZWORwL85Yo+qUNTQgPrFs5k9pN1ALTMukZ6aXM5ceq1SOdfAX9xAMC?=
 =?us-ascii?Q?0Tomib0Fxx+ciE7Fcm+mlT3o8weFi+Hu1QdnPi+atZGGOC6a0ue1AEvNwmjQ?=
 =?us-ascii?Q?ahhBo+Mf11kovUnTbL1rhUx+1Npt41V07lJH+Veni61vYRmVQWrRgvF7VEv/?=
 =?us-ascii?Q?KGBMZjAB9ekto0Bjqattxsgukx28/20aIMy0kqmw08XJDpYMG6I+9jASz09G?=
 =?us-ascii?Q?p7U8DJBIbCneenW97mBfLeLWGPZVRPt+PV7Zd0bEVQyzDkVmXxMPiN4NfK2D?=
 =?us-ascii?Q?TZX/f5iHy1ql0ndHfisxDH2KMaCYkancbrVmIVyg0tK3NGSdZC4U99aNasTk?=
 =?us-ascii?Q?k4Oo4O6lML+JTP9uctHLGA91ThQgsmbcovkskuHdBufxB968XiqUCBtrOMOk?=
 =?us-ascii?Q?vlOF+yKZE8bWXbAIH8GP9dyWhQzByhluIADRGrJ0zD1jopkPu/2rbh73GZq2?=
 =?us-ascii?Q?Wpen8FvxQ3RkkjtN7nq94GCWJs8n4CsaEFZdts4U4XIHT4junHbb6nFMoDxJ?=
 =?us-ascii?Q?EHDDCbTSrrugny7iCaKSrZlQf91gO8zcriOXT4TgwcP1eIEiaV3uta66oj+g?=
 =?us-ascii?Q?abSPP7n8UR0cJNisisVs7XmbaPhwz0YsUKT99chjb8i4xjen6N1CrprPUZpj?=
 =?us-ascii?Q?n0lYl5xbgzzjfLt3fvg69D/ClnHtWigYfumU5jINURUQS4SDwAli9lay571w?=
 =?us-ascii?Q?zvQVaiWiiS72QV4CQz5DOAMVpc8dt8vFg6/caP1bGhzUNNxo/TpYTxRugLWb?=
 =?us-ascii?Q?gnc+ZYGwn+OjgcBWqFsNyPDFibpWoC8gySz9kN5MNfY3187O+5gZJTUg06w8?=
 =?us-ascii?Q?0XXyKDQPxoRki6ZpaiobJW2Vu34HIXSAnjzNu8/sHvqs7y3k+i42DeurXdgT?=
 =?us-ascii?Q?JmpnObQfDlA0P6eWk84E0v7gIWDEt5KAZduKpI4rcEijWmSuMCqP+kSn5/06?=
 =?us-ascii?Q?JAsMSj/JV3YpGu1VHsqZ0M7DH24JcCg+r3rnGyfofNovQNLw1ocw9NBiaGE5?=
 =?us-ascii?Q?o/xVJ3CxHzdCcgqXvIU9FTkfjaER4eGCsl2K/owAbh1ma4WOaogiOVQ7fVDU?=
 =?us-ascii?Q?0+fXDSuEMWHF032JgsDelSsYGqQWT+A8xbX0QoJzSz/T7zKphMtZvsSz2MKr?=
 =?us-ascii?Q?NbKk6ZglZ++FXJAtCuMCAAwecNSZZ3J2Ir8vqUkmt080bCWtgTwcRZMDGpUk?=
 =?us-ascii?Q?sEIV/9oks7jZ6YAbr+RUaD0AZVzB8SW78q6v94tqU8yn/2PJ0YUFxKlitLmj?=
 =?us-ascii?Q?dJdsi9zHgVRD1YqpMZZlltMa6y4OC8Ayxd0mQu875lvoSKYNJGFcg76KcLC9?=
 =?us-ascii?Q?ELi7+IaoV7rYMAe7NmbZm7VP5SCRP6wjgzYiNVX+0wlENlnlHVkfo40h6Wfg?=
 =?us-ascii?Q?LchhUo9mIKWO9EEqUKye5z7vLNlqztqmmTRBQArV5wKARHWEUa9meOhaqcoo?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4778661e-78c4-48a0-2c26-08dba96f4979
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 15:39:24.3501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKGkL5ROMwIZccjxQ+rZ2CuKItikz8pfwMgSxR4KbGIw+FsqVR7/IGUB78b5x2GnWTdXakQ4nhq1kqNFjMcVrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7481
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes the master BIS cleanup procedure - as opposed to CIS cleanup,
no HCI disconnect command should be issued. A master BIS should only be
terminated by disabling periodic and extended advertising, and terminatings
the BIG.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 include/net/bluetooth/hci_sync.h |  2 ++
 net/bluetooth/hci_conn.c         |  1 +
 net/bluetooth/hci_sync.c         | 29 ++++++++++++++---------------
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 57eeb07aeb25..6efbc2152146 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -80,6 +80,8 @@ int hci_start_per_adv_sync(struct hci_dev *hdev, u8 instance, u8 data_len,
 			   u8 *data, u32 flags, u16 min_interval,
 			   u16 max_interval, u16 sync_interval);
 
+int hci_disable_per_advertising_sync(struct hci_dev *hdev, u8 instance);
+
 int hci_remove_advertising_sync(struct hci_dev *hdev, struct sock *sk,
 				u8 instance, bool force);
 int hci_disable_advertising_sync(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 9d5057cef30a..9d4f63f14ce6 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -759,6 +759,7 @@ static int terminate_big_sync(struct hci_dev *hdev, void *data)
 
 	bt_dev_dbg(hdev, "big 0x%2.2x bis 0x%2.2x", d->big, d->bis);
 
+	hci_disable_per_advertising_sync(hdev, d->bis);
 	hci_remove_ext_adv_instance_sync(hdev, d->bis, NULL);
 
 	/* Only terminate BIG if it has been created */
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 9b93653c6197..f7da02393b3c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1317,7 +1317,7 @@ int hci_start_ext_adv_sync(struct hci_dev *hdev, u8 instance)
 	return hci_enable_ext_advertising_sync(hdev, instance);
 }
 
-static int hci_disable_per_advertising_sync(struct hci_dev *hdev, u8 instance)
+int hci_disable_per_advertising_sync(struct hci_dev *hdev, u8 instance)
 {
 	struct hci_cp_le_set_per_adv_enable cp;
 	struct adv_info *adv = NULL;
@@ -5378,6 +5378,12 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 	switch (conn->state) {
 	case BT_CONNECTED:
 	case BT_CONFIG:
+		if (test_bit(HCI_CONN_BIG_CREATED, &conn->flags)) {
+			/* This is a BIS connection, hci_conn_del will
+			 * do the necessary cleanup.
+			 */
+			goto conn_del;
+		}
 		err = hci_disconnect_sync(hdev, conn, reason);
 		break;
 	case BT_CONNECT:
@@ -5387,26 +5393,19 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 		err = hci_reject_conn_sync(hdev, conn, reason);
 		break;
 	case BT_OPEN:
-		hci_dev_lock(hdev);
+	case BT_BOUND:
+		if (test_bit(HCI_CONN_PA_SYNC, &conn->flags) ||
+		    test_bit(HCI_CONN_BIG_SYNC, &conn->flags))
+			goto conn_del;
 
-		/* Cleanup bis or pa sync connections */
-		if (test_and_clear_bit(HCI_CONN_BIG_SYNC_FAILED, &conn->flags) ||
-		    test_and_clear_bit(HCI_CONN_PA_SYNC_FAILED, &conn->flags)) {
-			hci_conn_failed(conn, reason);
-		} else if (test_bit(HCI_CONN_PA_SYNC, &conn->flags) ||
-			   test_bit(HCI_CONN_BIG_SYNC, &conn->flags)) {
-			conn->state = BT_CLOSED;
-			hci_disconn_cfm(conn, reason);
-			hci_conn_del(conn);
-		}
+		test_and_clear_bit(HCI_CONN_BIG_SYNC_FAILED, &conn->flags);
+		test_and_clear_bit(HCI_CONN_PA_SYNC_FAILED, &conn->flags);
 
-		hci_dev_unlock(hdev);
-		return 0;
-	case BT_BOUND:
 		hci_dev_lock(hdev);
 		hci_conn_failed(conn, reason);
 		hci_dev_unlock(hdev);
 		return 0;
+conn_del:
 	default:
 		hci_dev_lock(hdev);
 		conn->state = BT_CLOSED;
-- 
2.34.1

