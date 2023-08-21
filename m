Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0642EE4996
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 15:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbjHUP0M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 11:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjHUP0L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 11:26:11 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2085.outbound.protection.outlook.com [40.107.241.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C606F3
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 08:26:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXfoCmp+f/xsmq62kZakmKui7TNVu+SADgfeG5iuG+j1KzZaSdKEOY7OVa81QGeIfhpBRS++MSLQM4bt98vv37MiV/GsU3ZGu+hdemid/kqex6lMgvO1Z67F3YBICluslLiQLAv9VJYz4Nn4ZgrI2otWPcqQiLoAfjdSA/R83iUFHUOnsXsuRehFX0/yyqk/gPegv+ln8iWsHHPF28/cWn1vk4rJumT15TJobWKOkyweEwusBxrjjKhU2vKyt0rpOdworvHvOmmCcWITMRi8UuCwqytvOnHhjNYOGeyFLaltQp9Oqfc4xE52UpOnveEZStqjoVJm478tUmUhVND/ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0w8mgN/rdzPpPSTOkvqW52FeSo03ZWyZw25pS/Id1g=;
 b=SB9gQPwNeey04/9D25rRGWecswOitdh6gcSf+qReM13nL1oMLUe98UKZtFxBXG7KWCRkUsxmufvnW1/Gq1O9FZrS3MjtfHstTLqJqShEUwK0UcVqI/Boqo91NFhe62Vy/L53s3eHn8PTYoiRzHbNZXIZNRrhKlbhSGYIFlgRKmKGoApOs3Su4X8VBrJYIghDz/F4Ua+Q+nnBPSxfmILHPal3bniVtaRW57dRkgSIq2HoV2AMG9xxKpBa+L13F4aLywX1UpXly2pbGsz0PhCW8WO+1oE7J+0TeOzJjibXnnXj3Pyg09xuIO2pSDgfhnIUeZ+/p0is21HFlj7WzpgWbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0w8mgN/rdzPpPSTOkvqW52FeSo03ZWyZw25pS/Id1g=;
 b=qesajXG8X5tktsGEqLGf8uDWXjGeEFRjivQdocat62TnedweBEbqz0vF8p9GxYngrPMeTadqxup9YK5fMi/V5x99HDb9q3i90hiEKqDxmryrxBPtbJIvL1VnezVY1PGQcCmFezcAFGVldi+ZkPmptVdM2vw/mxuJ9SDvX/+hPoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AM9PR04MB7570.eurprd04.prod.outlook.com (2603:10a6:20b:281::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 15:26:06 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 15:26:06 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH v3 1/1] Bluetooth: ISO: Add support for periodic adv reports processing
Date:   Mon, 21 Aug 2023 18:25:29 +0300
Message-Id: <20230821152529.23000-2-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821152529.23000-1-claudia.rosu@nxp.com>
References: <20230821152529.23000-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0002.eurprd05.prod.outlook.com (2603:10a6:205::15)
 To GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AM9PR04MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: eb040441-7b85-4ae1-d3c3-08dba25aeff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tWK+cji3Sn8GqohpuW3SXHbc+o+M8lSAv8OYrT0kCGlsr7PribIdJyAlRmqnSd9wQVG5gbGyH/CE1MxGNPdafuWcqU7Vi1d1yDgHssb3TLcp5axmSiz5XVnKDuBgMUx270NpmF01n6jF204zkozMQ5+5GNeT9pmMPHW4cWLxPHkdFm3vUuFoV3uLPXGZ1URNyUrF425gJ2eUIXzFOL+/CDY4Hb3eaMC8hkFrrjSrv8hpZGK6Lcd6Rzbyyj5zZR0pI6hkiJ0Ef2B98cTetKmJRPf2ShmNsSwP8geOJ9CQTXZ8oaKnmX96JyknzZcF2zlrv4vFVCjjs3jQ6BDdpCfX4dxzFLR50cLil+4rvJIsf1IFAeV3g3ZAFxLlhpj39L1rRlpa3YGVIU9wd6DsrdSn1xM4vY1gqgq17y/Kh5hvnNiCkXtSRkL2LmBLRST9XAnYLRq2lXIYSX0BQBTGlR+q0YrAGAlR2zHwwCJAFv9mVz7euTrtrxUlTZoXvUPTwSMlGG9cSjKpoEGeNAeqSrKb4+9RZj0+/yXvN3kwBbAOysd+4ttzlfJa6UHvY5g78KZmut90LyL4j0eJseBczwoRkz+4ub5mCTkRi/j88qDj1go0a2//PdgOBMfGClqRjHAF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(52116002)(38350700002)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(6916009)(66556008)(66476007)(478600001)(6666004)(36756003)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GZcTOvhDFJZ/+3I5aAMs2pcILIhxkIbfYTE496+e2IjVpS7X8cLFJLRkDLWR?=
 =?us-ascii?Q?usC5OU7qwK8F4B3VC+ACj/Hm8Pn5li23h3Y5t2tsFiRofoObJlrQFTCy08K6?=
 =?us-ascii?Q?rzr34T71RiJK2Elhw9u/SHMqI25rfLoA7upabqOUY6+lDQDt82CwvgnTCODV?=
 =?us-ascii?Q?z7h5lA0VKVBvbvKp5k4TUSKtm9nB5pnD4VhqOpkCKV++yi6+jpA1Ogy+hpzM?=
 =?us-ascii?Q?p2XyXZhDmcgK8U+q9snLuBtLXx+HI4Q05U1ZwFJtArX/Wh8sGwXo2bN2P5Gv?=
 =?us-ascii?Q?KRG0rXHd/UH39lel0x3qvT+1UFPHaKfelOPQdX1+MuJTt7RctiTvYVS5MqNB?=
 =?us-ascii?Q?H/sv/qj63NbhWlP8rF3RiRfJIzYP9Y9Yz1KdUF+AA2zwpHm7jjqODnfRRlaa?=
 =?us-ascii?Q?d/RYytZOp2RVKL48senj/NpE2k9gVWvTmtOe6+B+nYyXPEdm4dLHdt8vpLim?=
 =?us-ascii?Q?RDBw26ov7XSB2mnzOk2+Ud5wFVgvS47xNCrS0/A71a/z3BZboKtNGY+f79yi?=
 =?us-ascii?Q?p0TN1E5yqn4YQrwZCHw7JR5DdCrZPGsRInjUTxjTD8w2ZrRQmvP37kiKBek8?=
 =?us-ascii?Q?5PkU5eZxLZSgSG8v+Wftxzocl426jSpsxzd28LAvNGNowsTRb6KnFRpJM+CL?=
 =?us-ascii?Q?b3Z4nK++LVvwA2RSzEpXRiKd585I+t95BSdtjh/ZyLMsGg98V1lFlt/4F8tx?=
 =?us-ascii?Q?KpT3Quqah455I20VjmxRfF2ObUprNhHgB0Z1bc+8uTpwFCGQA3nw5CFqBEZw?=
 =?us-ascii?Q?NbyJFFHvHFtnaX9jg4Bc4r8mDCK+V9arU90BsccxaKHWSwbj862nikVhq5cG?=
 =?us-ascii?Q?2iAsZp6YyN46bUXKg20K9q7c/PH3/1Xz2jNDr9x38ettqNHmj0uJBtMYqkUO?=
 =?us-ascii?Q?PSYbNwnsLri6WpNqw6hv7chzDX4WJEcnbtfG+52P+XIn2fe86oQ5HFg2hxap?=
 =?us-ascii?Q?r9bv1aNIOXK2wMxcrz7zFBOrE4rJ/7tDLt+fVJLmxmbql/QbulyHpx5hOSsT?=
 =?us-ascii?Q?iBoeXcz0BhyCVT69npT4p3j+7UeEbCtuFD7IcrnijO1M4sGmHCRbyRCcq1lv?=
 =?us-ascii?Q?9SfKo/MQ0aQ+0ljPjI1hWwy493CNlr8JPQcFBOyeUNedZP0qV+rKrwFcHQhz?=
 =?us-ascii?Q?Y0DP/x6hXcOnA2729lxFmp9S1Ah5C6mlEAeb7Ywky6c9h5RRjBdH3yRSH00n?=
 =?us-ascii?Q?gwzOVbkW5fVEZasRllHn4pGjIPe1G+Y/B/uOkYN8Q0q5ALVtsvPPc2sYZ0uE?=
 =?us-ascii?Q?0vAGZrNC21e2h27fB/odBnz37/0ArLjYlISWCS45tOb8/88GbNvXGY3kYtGd?=
 =?us-ascii?Q?HHyb06xQU2VSJvs9AD3BQY1Urx6wgHIxRJtLb5+YhZML++zYm9+0J3fPch0Q?=
 =?us-ascii?Q?4obSar7Z+QfYiFK73Dr0BKpcJWDGUWR45DxF0hSGmV1bBid67tmDXdKtik6Z?=
 =?us-ascii?Q?gnNteecIKkUfnqr1AzqT5lZtyN/DRrblSe7s7+sNzihfPmtjHKfxbGf3jrai?=
 =?us-ascii?Q?9FKUBchVkFV6ZfjZ3SNpwe+s5OANoz4DNiwLQT8UjE7AobqUZq5Aa1NDfpAt?=
 =?us-ascii?Q?jx2VpJQkJcbaPjV8GIe2lhGpNQ2rxOgErMCnriYA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb040441-7b85-4ae1-d3c3-08dba25aeff0
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 15:26:06.3010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RhLCQN6tJTScQqL1GJMaPXBwftGy6YOtK3x5zaYaKKcCc7AfCNLE+t2Db6GA8Pz68kAZFsvOyczOMbWHD/Kgpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7570
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In the case of a Periodic Synchronized Receiver,
the PA report received from a Broadcaster contains the BASE,
which has information about codec and other parameters of a BIG.
This information is stored and the application can retrieve it
using getsockopt(BT_ISO_BASE).

Signed-off-by: Claudia Draghicescu <claudia.rosu@nxp.com>
---
 include/net/bluetooth/hci.h | 11 +++++++++++
 net/bluetooth/hci_event.c   | 23 ++++++++++++++++++++++
 net/bluetooth/iso.c         | 39 +++++++++++++++++++++++++++++++++++--
 3 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5723405b833e..c58425d4c592 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2771,6 +2771,17 @@ struct hci_ev_le_enh_conn_complete {
 	__u8      clk_accurancy;
 } __packed;
 
+#define HCI_EV_LE_PER_ADV_REPORT    0x0f
+struct hci_ev_le_per_adv_report {
+	__le16	 sync_handle;
+	__u8	 tx_power;
+	__u8	 rssi;
+	__u8	 cte_type;
+	__u8	 data_status;
+	__u8     length;
+	__u8     data[];
+} __packed;
+
 #define HCI_EV_LE_EXT_ADV_SET_TERM	0x12
 struct hci_evt_le_ext_adv_set_term {
 	__u8	status;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b4b72070f5f6..441b9c7077e4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6617,6 +6617,24 @@ static void hci_le_pa_sync_estabilished_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
+static void hci_le_per_adv_report_evt(struct hci_dev *hdev, void *data,
+				      struct sk_buff *skb)
+{
+	struct hci_ev_le_per_adv_report *ev = data;
+	int mask = hdev->link_mode;
+	__u8 flags = 0;
+
+	bt_dev_dbg(hdev, "sync_handle 0x%4.4x", le16_to_cpu(ev->sync_handle));
+
+	hci_dev_lock(hdev);
+
+	mask |= hci_proto_connect_ind(hdev, BDADDR_ANY, ISO_LINK, &flags);
+	if (!(mask & HCI_LM_ACCEPT))
+		hci_le_pa_term_sync(hdev, ev->sync_handle);
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_le_remote_feat_complete_evt(struct hci_dev *hdev, void *data,
 					    struct sk_buff *skb)
 {
@@ -7213,6 +7231,11 @@ static const struct hci_le_ev {
 	HCI_LE_EV(HCI_EV_LE_PA_SYNC_ESTABLISHED,
 		  hci_le_pa_sync_estabilished_evt,
 		  sizeof(struct hci_ev_le_pa_sync_established)),
+		/* [0x0f = HCI_EV_LE_PER_ADV_REPORT] */
+	HCI_LE_EV_VL(HCI_EV_LE_PER_ADV_REPORT,
+		  hci_le_per_adv_report_evt,
+		  sizeof(struct hci_ev_le_per_adv_report),
+		  HCI_MAX_EVENT_SIZE),
 	/* [0x12 = HCI_EV_LE_EXT_ADV_SET_TERM] */
 	HCI_LE_EV(HCI_EV_LE_EXT_ADV_SET_TERM, hci_le_ext_adv_term_evt,
 		  sizeof(struct hci_evt_le_ext_adv_set_term)),
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 9879f2349d48..f311ef17d068 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -14,6 +14,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/iso.h>
+#include "eir.h"
 
 static const struct proto_ops iso_sock_ops;
 
@@ -47,6 +48,7 @@ static void iso_sock_kill(struct sock *sk);
 
 #define EIR_SERVICE_DATA_LENGTH 4
 #define BASE_MAX_LENGTH (HCI_MAX_PER_AD_LENGTH - EIR_SERVICE_DATA_LENGTH)
+#define EIR_BAA_SERVICE_UUID	0x1851
 
 /* iso_pinfo flags values */
 enum {
@@ -1446,7 +1448,8 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_ISO_BASE:
-		if (sk->sk_state == BT_CONNECTED) {
+		if ((sk->sk_state == BT_CONNECTED)
+				&& (!bacmp(&iso_pi(sk)->dst, BDADDR_ANY))) {
 			base_len = iso_pi(sk)->conn->hcon->le_per_adv_data_len;
 			base = iso_pi(sk)->conn->hcon->le_per_adv_data;
 		} else {
@@ -1647,7 +1650,6 @@ static void iso_conn_ready(struct iso_conn *conn)
 		}
 
 		if (ev2 && !ev2->status) {
-			iso_pi(sk)->sync_handle = iso_pi(parent)->sync_handle;
 			iso_pi(sk)->qos = iso_pi(parent)->qos;
 			iso_pi(sk)->bc_num_bis = iso_pi(parent)->bc_num_bis;
 			memcpy(iso_pi(sk)->bc_bis, iso_pi(parent)->bc_bis, ISO_MAX_NUM_BIS);
@@ -1655,6 +1657,9 @@ static void iso_conn_ready(struct iso_conn *conn)
 
 		bacpy(&iso_pi(sk)->dst, &hcon->dst);
 		iso_pi(sk)->dst_type = hcon->dst_type;
+		iso_pi(sk)->sync_handle = iso_pi(parent)->sync_handle;
+		memcpy(iso_pi(sk)->base, iso_pi(parent)->base, iso_pi(parent)->base_len);
+		iso_pi(sk)->base_len = iso_pi(parent)->base_len;
 
 		hci_conn_hold(hcon);
 		iso_chan_add(conn, sk, parent);
@@ -1692,12 +1697,20 @@ static bool iso_match_sync_handle(struct sock *sk, void *data)
 	return le16_to_cpu(ev->sync_handle) == iso_pi(sk)->sync_handle;
 }
 
+static bool iso_match_sync_handle_pa_report(struct sock *sk, void *data)
+{
+	struct hci_ev_le_per_adv_report *ev = data;
+
+	return le16_to_cpu(ev->sync_handle) == iso_pi(sk)->sync_handle;
+}
+
 /* ----- ISO interface with lower layer (HCI) ----- */
 
 int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 {
 	struct hci_ev_le_pa_sync_established *ev1;
 	struct hci_evt_le_big_info_adv_report *ev2;
+	struct hci_ev_le_per_adv_report *ev3;
 	struct sock *sk;
 	int lm = 0;
 
@@ -1713,6 +1726,9 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	 * 2. HCI_EVT_LE_BIG_INFO_ADV_REPORT: When connect_ind is triggered by a
 	 * a BIG Info it attempts to check if there any listening socket with
 	 * the same sync_handle and if it does then attempt to create a sync.
+	 * 3. HCI_EV_LE_PER_ADV_REPORT: When a PA report is received, it is stored
+	 * in iso_pi(sk)->base so it can be passed up to user, in the case of a
+	 * broadcast sink.
 	 */
 	ev1 = hci_recv_event_data(hdev, HCI_EV_LE_PA_SYNC_ESTABLISHED);
 	if (ev1) {
@@ -1752,6 +1768,25 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 				}
 			}
 		}
+	}
+
+	ev3 = hci_recv_event_data(hdev, HCI_EV_LE_PER_ADV_REPORT);
+	if (ev3) {
+		size_t base_len = ev3->length;
+		u8 *base;
+
+		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
+				iso_match_sync_handle_pa_report, ev3);
+
+		base = eir_get_service_data(ev3->data, ev3->length,
+			EIR_BAA_SERVICE_UUID, &base_len);
+		if (base) {
+			if (sk) {
+				memcpy(iso_pi(sk)->base, base, base_len);
+				iso_pi(sk)->base_len = base_len;
+			}
+		}
+
 	} else {
 		sk = iso_get_sock_listen(&hdev->bdaddr, BDADDR_ANY, NULL, NULL);
 	}
-- 
2.34.1

