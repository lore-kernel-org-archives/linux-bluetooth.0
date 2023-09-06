Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAB5EB8FD5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Sep 2023 14:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241380AbjIFOAZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Sep 2023 10:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241291AbjIFOAY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Sep 2023 10:00:24 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E385810D3
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Sep 2023 07:00:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqLiGsftpBadPGzvciXzOxEfZHsluVFDTmSKKYxaNQHHmNCJ/9IEBFnKkQCHLBOqkWqlaezBXrQuLOGmpR/hqWqrRbJJEbTu543nK34BCFcXYvN5OZJQ4V3qlvwHwUEE4i3P0Hg6Si3lVFlSOm0rB/ycTO6UNUmeMVWuh3Az7q7ck9A7EOsWzk9HgdWj/02qL0C0eUaiyx2BnVN1AiBUktjCS4SyMXeYlSQvQMDUcQm6/DqeReD6XKvSSf5AYlIqTCMHKvbGeBDWYljRQd8DxME15rL9RdVfjDFdLk4G2DBuNzEGPJUCfcuCrixZbNPeEeUeUXDN+/S3pw5oNwWYnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuGF6S0UHf4LtoEaCeYOPgwiLVn/TgdnMg/u1+ixv9U=;
 b=hnBJ5SGZfG+v91EmRIMVv4Gnm3ZQiGnrux2Qr81LnNppJWReodr7vJr2rzVO6SwvHRe6ylEAsKtJm6o2Z9Q6UlcYP21VCfWqWBpAYdpRWkhf/QzTL8qRXzzyvCjD/RwohowvhB2fe3RVHfLfSf31lJEyj7Lp0H49slWyO4YVfM7AQ0UIaSviHsabahkq35nZ5VuRcpPhfr3OBzob25By5p9uNorL/sMaw6I1ALp6mxr9FhGWKnfF7Oo9jxDr3cYvrtp0WbsCs6BeH30kJ9FrPUCCErLKo8rPvCSipG5J6cCDfl05uceqWGhhOURXG/esAutllkeJ1mOsTlHwmFauDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuGF6S0UHf4LtoEaCeYOPgwiLVn/TgdnMg/u1+ixv9U=;
 b=Y+yJNHmuav18JymGiyHY1k43zdE24z5VlXxd0qrQfLRSO7mm1fqEyFIybrwi/jLGODA64U9US3KYuAdSQUBcnj2MUsX9zpLTS0cTy7yYIvtf7ruXkYrWS9X3XAQZBANSkZFr0XmPiWHp3sDJnv0uKhJiM7Z1zHhR84ZXR8TBcN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8788.eurprd04.prod.outlook.com (2603:10a6:20b:42f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 14:00:17 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 14:00:17 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v2 1/1] Bluetooth: ISO: Fix BIS cleanup
Date:   Wed,  6 Sep 2023 16:59:54 +0300
Message-Id: <20230906135954.9165-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906135954.9165-1-iulia.tanasescu@nxp.com>
References: <20230906135954.9165-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0024.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::12) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: c6355bbc-b65d-4600-da65-08dbaee199dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 01pBWpLlr9U7mUHkZV0pp2MG/IRvs9tJa0uYEcvHIO+FaAB/j3oR9fdODEhmTCCGrd05d89X7ZZQnd2o0YxO1webCazPaFC4Z8M45yLsoKvMz7Wb4q9p+P2yr4rlMYdZ9CBkRtIfnBz/hhSVbKoyCpbN+C828pU3WyxLvs0YWl1WitZCI6EWcWm5xZyai0MBnkMlkKDtsDugWshgIJY4QxNA9HLjtEzskjxy3ZBfmTqQdcb7kbs1Yq9NAiVwiKkqPcQl5p//0L2nuDEneOSgRgijpz9n7AfcOTVcV4p7C64Ux1cnfrRbvCP1rxKTgxsg511HFFOid/zYE3cSFwftxBoVEZ/aFAFRB/zgLs7yWGt2szkv+7qS70U6Xn07d8bD6eLVix5PVauYRbgDoUmZeFIFyftEutbCtpU42o2qEsETViwAP7RRQ5qust3LbijBzQsUbyDSNARAK5PK2D2fEpyEK5NQAuKId6/5LNX5uIIfxwpDaHK3hfWARbK/TTJ62kT4H5QkQi3DK+Q/mPSoIlHRpb0D8bT2xQ5tMUFI2+Q7h+bZE0pU3TdghFpsEvWJsZYfsCab1ospf7dH2A9ULzpOJbqNto9X5IUL9Xkt0EcvbL63wHYNOHiLndT3mqgT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199024)(1800799009)(186009)(38350700002)(36756003)(38100700002)(86362001)(6666004)(26005)(478600001)(1076003)(5660300002)(52116002)(44832011)(6486002)(6506007)(55236004)(66556008)(66946007)(66476007)(316002)(6916009)(41300700001)(2616005)(8676002)(8936002)(6512007)(4326008)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OxMacSoXKsfRGHcJNHSli8ffGcKXzFaoSsu38IGi9S0wBnF0KeDfqaOWSb1k?=
 =?us-ascii?Q?nK8WYVpI74FFeAzISdY2nbTKZ/CJTXQV86LMbyCYB5iRbFGpMJiRCMSeS1w9?=
 =?us-ascii?Q?kbbOLxrYiiU3Fdf81OGbhHZrk8uG0dI5Mq3STfCY0p9H7cX1PXpd9u64PL5B?=
 =?us-ascii?Q?LOUSwGuORleViy7yHENE/B8pKk1VUkrSUQJ9Bg6KkQi0VK+7QmLA397lURwg?=
 =?us-ascii?Q?KS13ax1oSDEm0B+JTzds8hurTaT1DVBySax4niLkcieHUR+ufSVhZBx6VFaM?=
 =?us-ascii?Q?gglIBeAdSbh3fZSzsIOyhxrIzsL0EtZ9w8TDdwMgZ7klszIYFuxg6FK/ZFRJ?=
 =?us-ascii?Q?By45oU1VF7RK3u3jhrecet/NdF5Y5oklW7U+W5Iq0CzXLaVZuinrkh7gmPle?=
 =?us-ascii?Q?CP7FhSDm/RXnsxOL3e0Qb2B1Fe5+p8O4NVIZsiU3LMbj6+Dz+yNMMzYw/+Vs?=
 =?us-ascii?Q?xVYn7lA8qVrCjOSjlh9yDsdl2rhnJYZQz0sIYSO8ShidcJl1eK2TEXDmFDei?=
 =?us-ascii?Q?4PVQTTXXlu3f4Dw1U32BI+VfcKiLUFcn3kOaA2pZL355lPXfhPE9P57MjGKm?=
 =?us-ascii?Q?PIs9v5C9VoCjhLd+U2Olu+XO9kaM6fcgf5R+YwTx11woCWB9SWcKIHoY4ctt?=
 =?us-ascii?Q?YxSha4JIdQFGWaiJFMlROVlZLNypG03gjzzjVC9WnhLlaf3W08kfoyfYfgYE?=
 =?us-ascii?Q?OVoKiUzTD5hbXQBkdOoqkeiCjYHlZ73dkuWtEFaUKeRd+I3jZSFJDKANCJYz?=
 =?us-ascii?Q?g+bJ+QnzpzsHoVZlARcq0i42zbxZL7aR+iZom+tFuZQ7/1KKuOXRRxXL7HaI?=
 =?us-ascii?Q?HExG93v7NN0KNH5HX/m/CrSqCY2zEt4gs9WvJlVAr3aRHVPZ6Ml4oxN+kUn2?=
 =?us-ascii?Q?+14woOB86/dBRoe8IwEqnfD+p6miRCialSsCrMp2q2r/JpJtJ3GJQWwLVWd4?=
 =?us-ascii?Q?to5jCL3JOncl4hlQ8WTx9o/APN9fTPn7nwrMap0UhGj+c6J9h/daD2w2DHCk?=
 =?us-ascii?Q?J9kinDPF+6YhgRNhJemsYsK5VcTUYuB3VlCrGslGFkgP9FvGedvx4oXYX2vo?=
 =?us-ascii?Q?6QBZzxSzDSXkHJiPOiyru0HhvSeVaJEG7qXp7jftjBo86GI9a2nnk+pfo+Di?=
 =?us-ascii?Q?agTJLRovzRRE+3dFUiJBzV4OmJJJ/z4+JGjdEV7pf5BkERaqmWIPXUouKT6g?=
 =?us-ascii?Q?XRHIxhwwVHx0xHBlzw/wdxEUYAX0wJs8UlBv2samnBExYY6P0etT3QqPen8i?=
 =?us-ascii?Q?hoGFjLyENr7LGy781jHkCuukCPlPJN8CwDJFoDmch7f9qUOs+EXUb4XdRPrf?=
 =?us-ascii?Q?F6SxXiBRXoVpVijmFck9uWqpTpApglJ6oeqNXIWmu33+KjYf2RZq1vRHatAT?=
 =?us-ascii?Q?S1OwDZ6k5MvEGdQJbl3S/Z+X/hBpTgmT0tqm4OLKr3D2/02yYAi0x15pHFPi?=
 =?us-ascii?Q?irAQhhoG1rXZn22YCuwkiRXUXMw3/BHXVc5qa/FgTvfcn1sm2SJr3mv8L0uA?=
 =?us-ascii?Q?ktI1EzCS7C0FjD8wvcCEe2NClUPXcdjXikTIHp3BL3F94anqcubhv1ut9hwG?=
 =?us-ascii?Q?4XBsMJv9gle9AgMI7oahyOV49w4E2H5vaEQbZYGBPw0Rwj/e9I/TouAE/PpN?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6355bbc-b65d-4600-da65-08dbaee199dd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 14:00:17.6516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgoIzSjpADWvdcgzxiZjOdI/Ux99vKQz/OXU95EY0AfRB82zTkoiiTIkF/nyHmdGdc2yCYQg9wCbvP4TImiP4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8788
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes the master BIS cleanup procedure - as opposed to CIS cleanup,
no HCI disconnect command should be issued. A master BIS should only be
terminated by disabling periodic and extended advertising, and terminating
the BIG.

In case of a Broadcast Receiver, all BIS and PA connections can be
cleaned up by calling hci_conn_failed, since it contains all function
calls that are necessary for successful cleanup.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 include/net/bluetooth/hci_sync.h |  2 ++
 net/bluetooth/hci_conn.c         |  7 +++++++
 net/bluetooth/hci_sync.c         | 28 ++++++++++++----------------
 3 files changed, 21 insertions(+), 16 deletions(-)

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
index 9d5057cef30a..7c8a5cc72e89 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -759,6 +759,7 @@ static int terminate_big_sync(struct hci_dev *hdev, void *data)
 
 	bt_dev_dbg(hdev, "big 0x%2.2x bis 0x%2.2x", d->big, d->bis);
 
+	hci_disable_per_advertising_sync(hdev, d->bis);
 	hci_remove_ext_adv_instance_sync(hdev, d->bis, NULL);
 
 	/* Only terminate BIG if it has been created */
@@ -1247,6 +1248,12 @@ void hci_conn_failed(struct hci_conn *conn, u8 status)
 		break;
 	}
 
+	/* In case of BIG/PA sync failed, clear conn flags so that
+	 * the conns will be correctly cleaned up by ISO layer
+	 */
+	test_and_clear_bit(HCI_CONN_BIG_SYNC_FAILED, &conn->flags);
+	test_and_clear_bit(HCI_CONN_PA_SYNC_FAILED, &conn->flags);
+
 	conn->state = BT_CLOSED;
 	hci_connect_cfm(conn, status);
 	hci_conn_del(conn);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index fd7c5d902856..ec4dfc4c5749 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1312,7 +1312,7 @@ int hci_start_ext_adv_sync(struct hci_dev *hdev, u8 instance)
 	return hci_enable_ext_advertising_sync(hdev, instance);
 }
 
-static int hci_disable_per_advertising_sync(struct hci_dev *hdev, u8 instance)
+int hci_disable_per_advertising_sync(struct hci_dev *hdev, u8 instance)
 {
 	struct hci_cp_le_set_per_adv_enable cp;
 	struct adv_info *adv = NULL;
@@ -5231,6 +5231,17 @@ static int hci_disconnect_sync(struct hci_dev *hdev, struct hci_conn *conn,
 	if (conn->type == AMP_LINK)
 		return hci_disconnect_phy_link_sync(hdev, conn->handle, reason);
 
+	if (test_bit(HCI_CONN_BIG_CREATED, &conn->flags)) {
+		/* This is a BIS connection, hci_conn_del will
+		 * do the necessary cleanup.
+		 */
+		hci_dev_lock(hdev);
+		hci_conn_failed(conn, reason);
+		hci_dev_unlock(hdev);
+
+		return 0;
+	}
+
 	memset(&cp, 0, sizeof(cp));
 	cp.handle = cpu_to_le16(conn->handle);
 	cp.reason = reason;
@@ -5382,21 +5393,6 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 		err = hci_reject_conn_sync(hdev, conn, reason);
 		break;
 	case BT_OPEN:
-		hci_dev_lock(hdev);
-
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
-
-		hci_dev_unlock(hdev);
-		return 0;
 	case BT_BOUND:
 		hci_dev_lock(hdev);
 		hci_conn_failed(conn, reason);
-- 
2.34.1

