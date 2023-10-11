Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B39CD6E77
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Oct 2023 14:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbjJKOYf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Oct 2023 10:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjJKOYf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Oct 2023 10:24:35 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2060.outbound.protection.outlook.com [40.107.105.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA3B90
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 07:24:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZA9v0LJxQwYqMiuhqmZ89d2jgfV51SI5g1S1gmOi0hFRi3HWANxqCkGu6BTA/7TA4xTkUsIObF1b6M4EqQAL/Tx9hy2Yog+g+tgFMA2hsW/PP4aOpdkg1B5c00qogYGpc9RANjA5WdIM6WT/nOm3xrEndTAkmwtNd/6NE1AQ5xmUeDxfaqZyfn1fxbJEMplzFlMDzUAKrPb6wr4TKmK8DYOd4HXOuFGcwbBYOxdpfsc0ZfXmgug+YCDEbDe/HqIM7tSl7DM9NoHTc7BzSKhvvvOiJsRNJlABXpG7lzXGAsgOn3/F29BCY21VQFsEeUvwh6sZLPQinuSmqtwjkHllw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkKy66T2i7/nZ53XuCiHnJuRpIPptpzLPLBx/iELlUE=;
 b=LwEDB2d+Qusog+XdaoQC00OzyKFhUdhLtfmLdsw1YsNgQDtNjSRs58/JxIvqXxppfHeSw9RXsoX0MQwyUwiu/sXWkVmdHQoGLDYMKJlFQDRF6wCqEta1ij7dJ9TtNCsSKymwlMLoKccC8qbrV48s9U1Lt52VxrJQp+G43g5iQHHYm4qyXvOSX8RYQ2nw58IxCX/Oz4fwz+tUd96H+2l0VQHLjspj5guoaIILfcE40LwY0BjWh5/GcfX5nSpkZSC6dG53cF9ZBmlgo7Hskd8coQwafC46xbIA+iSTh2ITa7/MnbpUFjm80KF3gKwnWnT9ph/WNpBGKSMnMLw6cFCDnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkKy66T2i7/nZ53XuCiHnJuRpIPptpzLPLBx/iELlUE=;
 b=DBOtdZjF+75oJZ2XARccuX+1CeVcncEUs1G8FtCv2NIGqsOp5FvEt7bpH1HEizJ1rgROhq+ijjRNLGUWG4MrL24W7hQhPXdcKkf2zsSBXTKduYtc753hfKx5zRzZpJgSvEBlaLw2FOovx/6AgqjGqpXhC4WD6Up7odDdiTQCw5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VE1PR04MB7471.eurprd04.prod.outlook.com (2603:10a6:800:1a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 14:24:30 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 14:24:30 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 2/2] Bluetoth: ISO: Fix broadcast event handling
Date:   Wed, 11 Oct 2023 17:24:08 +0300
Message-Id: <20231011142408.5529-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011142408.5529-1-iulia.tanasescu@nxp.com>
References: <20231011142408.5529-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0033.eurprd02.prod.outlook.com
 (2603:10a6:803:14::46) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VE1PR04MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: 91ca2b7a-fad1-4afd-50ca-08dbca65c810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zNQI02M7pjye6gxKGH+AYyr+nMEadoJsMsYzPec/dsSTFhTQ+CVCSq0v+Z/QMy1bSpjIWJVc5PSFJDsrr2IWzXSiPXoha81rghFtMoGEVR0XZngm662uvLwVssujBw3TMYtFHd/eq4lKmX5iNX064GJqXQcDloITwSAGdBcT5HwZMe6qRuAFVo6sEEDch8QIvjnlTTWvTjtAjjrlvoONNE87Omi+VM37JhHftjDF/9xlMfJszPOekSPHBlqBWUzAVNIVpwDGRaK/5Tbwm+BwMPfz1RuE4YNkfXjHZPZ72jebPlrWTeY0+98FBrjKkZiZklJCtBI1Dc5+OkGL0tfsYEDYuNWhAhfQxdlwb2FMKHwR+XgYlXC419rD/AA4dqqko3Gq1xIOs/3Db0RRwJf9oh0fpEs0Pc2OQCYHzMDZdC9Qk4K0HF7D44UfGoRFctUzDNW3CzUcq8FQ59EvuKGXlBDcKzsgTEBCEeju8aCoZdR3lOnSp8CnLI+Io0H1TyzJYw26a61bNejqdch0Nd2Sc3mPQzG8W3E58MMyINq2GmZQLQOJy8BjkQPxufz/8TcI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(4326008)(41300700001)(5660300002)(6916009)(316002)(8676002)(36756003)(8936002)(44832011)(2906002)(2616005)(26005)(1076003)(86362001)(83380400001)(6506007)(6512007)(6666004)(38100700002)(6486002)(478600001)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ln45yuOEO6lgIGGRyq4pK2PJ9TWkc7c01krtyyW1nOVVjqarCEhM0KRJTMax?=
 =?us-ascii?Q?hkTVlgKZ0kRwG4tGmtJnU9kYtnpgEcihpI61P1u1FtPvMzy1Zluao/cuprKw?=
 =?us-ascii?Q?/trAH7im6S5aU4OM9UO3MQEyGOyxNbdkRx2EmYd9aGpA+ESbdOvY/h77U33V?=
 =?us-ascii?Q?U7j1nKMbe6YvIIMcp5aN8d/3iDBtLGXhQslLoPw8HwIJhLXz5JeHD4W6Glap?=
 =?us-ascii?Q?G6QKQO/KQDdAxdXjeLLjdOOuPS2/pe6uFpkOMZ9HwxuZ4fjrHRZyzXrDyems?=
 =?us-ascii?Q?N++BPLv+mgXSpiB3BdlJqPC42WXkqp82m0nJHARoEaqMVFgoZWDCsZNEwoAc?=
 =?us-ascii?Q?zQV1XHW60KhBybJR70aVx0NfN1dG864U22lbHtMXaQjzU6mEwe1BI9jqblZn?=
 =?us-ascii?Q?NJTEgY0PUPwPQx3fEZGAEaEjrK1jRxH5oaQ8wVNimSW1n84WwYpsQYYQuy8T?=
 =?us-ascii?Q?E/QF19JRvLmw7Fxk2w13WrodJ2LpJ8sI74IprURc9gtWcKgA9QZX1gZ5c+WU?=
 =?us-ascii?Q?i9EX8y6P7TbCHKQ2v+/dwZM01zP7iojmNfL+HjzkGi2N0LaCxrMMsy+7LD+1?=
 =?us-ascii?Q?Mu1YO+TrTFQTKEhMnNpy21Ox2c35G/WxyR3DVfHE/OPKSydl4UippuMqqJai?=
 =?us-ascii?Q?ty4iqA0lov0BkFK71uXVo+HfRdjpzjU5UeUFOv5zWjclgixmKZUTb64CTstN?=
 =?us-ascii?Q?8ZwDkOUc56F6VsUukg+Fdr7CRgQI85DvQOAxZNTeTM/P+TC1kMafbc+CFeho?=
 =?us-ascii?Q?p8vjreOV4ldWCGCxrc/g9AoC9plvzRnicGRIjmYckKrxYpfZQwwOO8WxZsfk?=
 =?us-ascii?Q?ueXL69Dtfhf9UhiFLVp7MzJz3cBTWJvdln0kb2njLMqxTzh6Xp/prdR/N69Z?=
 =?us-ascii?Q?+tcA+RAEZ4XUMYPATxh9kX+63ID3Ly7kyb5KmFLNnwqU+fZpT+UHLT0K42CR?=
 =?us-ascii?Q?HGXe1T2NVHmds6SaGRAHep4YGTy6Sp0HVrrCLTjwmzqvGM7+jt5Gn3nOSaCt?=
 =?us-ascii?Q?YeUGA4VagjE++TS0rO1QyTysUBW/qhNrr6Z1s5gvLuVRCs9hoK1iQrkqfc7h?=
 =?us-ascii?Q?cMU7dLNNiWL8wIVARMSVYhGS9CRhBh2t/eIBsimHHm1YmyoomxJ2rJaQmQnI?=
 =?us-ascii?Q?Nql+MgiLaP+1JFVOFKL4qv0TGFF4PQSP6rS7hl+bmWlM1M7QROEPDukYbfj1?=
 =?us-ascii?Q?o/517Np/1ZkDBYo5KSZwzlA/CAi7YESZ8LmvKlHNEoo8+9Mt2VO9dU6wFC++?=
 =?us-ascii?Q?cAfjeJ607ldcyFExr6u0p4qJNufFjudUGap7QYE2Bl3EdsR5FSFl9+P08iY8?=
 =?us-ascii?Q?lElBNIQKzQ2c/V7ClWUPMoot93K9hNNf52nr+HL5DOMOaIPEnJi6AKEs9ENX?=
 =?us-ascii?Q?jKVs9RwpI7mspfBE9906p7jQGv79REdxoKW72uRDhXA5VIuzI9HncGFGMReN?=
 =?us-ascii?Q?ioEfm76pXqhbpLV9SCcSgEg/4jJyk6rj6zcgynSSVDpK5htmQcX/8JXBQQkR?=
 =?us-ascii?Q?dyTgEHMKGncchhvukneqg406bjWwG6qNTMfb/zeQRxzh9YUxxFzTm9IojoNs?=
 =?us-ascii?Q?zmLMzpm1a6I7VaDkDen/hj930cnhp7pO2VHaYbQxwPgAHEUq9X6thV3BcwZt?=
 =?us-ascii?Q?aQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ca2b7a-fad1-4afd-50ca-08dbca65c810
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 14:24:30.1281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: facyiSoh8kNJ4XjeIwIql1qwMEN65pGObPWglyidZ7g4tmHaP7TphS8/0QetjnGubvtOor4y8lKrzXB66+zS4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7471
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes the way broadcast events are handled by the ISO layer:
A new slave BIS hcon is notified after the Command Complete for
LE Setup ISO Data Path is received, not after BIG Sync Established.

The iso_match_pa_sync_flag function has been replaced with more
specific matching functions, depending on the event being handled.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 include/net/bluetooth/hci_core.h |   3 +-
 net/bluetooth/hci_core.c         |  50 ++++++++++-----
 net/bluetooth/iso.c              | 101 +++++++++++++++++++++++++------
 3 files changed, 119 insertions(+), 35 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 99865c23e461..a85c47abd88d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2127,7 +2127,8 @@ void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
 void hci_send_iso(struct hci_conn *conn, struct sk_buff *skb);
 
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
-void *hci_recv_event_data(struct hci_dev *hdev, __u8 event);
+void *hci_le_meta_evt_data(struct hci_dev *hdev, __u8 subevent);
+void *hci_cmd_complete_data(struct hci_dev *hdev, __u16 opcode);
 
 u32 hci_conn_get_phy(struct hci_conn *conn);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 195aea2198a9..5ccc6ef1b66b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3120,10 +3120,11 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
 	return hdev->sent_cmd->data + HCI_COMMAND_HDR_SIZE;
 }
 
-/* Get data from last received event */
-void *hci_recv_event_data(struct hci_dev *hdev, __u8 event)
+/* Get data from last received LE Meta event */
+void *hci_le_meta_evt_data(struct hci_dev *hdev, __u8 subevent)
 {
 	struct hci_event_hdr *hdr;
+	struct hci_ev_le_meta *ev;
 	int offset;
 
 	if (!hdev->recv_event)
@@ -3132,21 +3133,42 @@ void *hci_recv_event_data(struct hci_dev *hdev, __u8 event)
 	hdr = (void *)hdev->recv_event->data;
 	offset = sizeof(*hdr);
 
-	if (hdr->evt != event) {
-		/* In case of LE metaevent check the subevent match */
-		if (hdr->evt == HCI_EV_LE_META) {
-			struct hci_ev_le_meta *ev;
+	if (hdr->evt != HCI_EV_LE_META)
+		return NULL;
 
-			ev = (void *)hdev->recv_event->data + offset;
-			offset += sizeof(*ev);
-			if (ev->subevent == event)
-				goto found;
-		}
+	ev = (void *)hdev->recv_event->data + offset;
+	offset += sizeof(*ev);
+	if (ev->subevent != subevent)
+		return NULL;
+
+	bt_dev_dbg(hdev, "subevent 0x%2.2x", subevent);
+
+	return hdev->recv_event->data + offset;
+}
+
+/* Get data from last received Command Complete event */
+void *hci_cmd_complete_data(struct hci_dev *hdev, __u16 opcode)
+{
+	struct hci_event_hdr *hdr;
+	struct hci_ev_cmd_complete *ev;
+	int offset;
+
+	if (!hdev->recv_event)
+		return NULL;
+
+	hdr = (void *)hdev->recv_event->data;
+	offset = sizeof(*hdr);
+
+	if (hdr->evt != HCI_EV_CMD_COMPLETE)
+		return NULL;
+
+	ev = (void *)hdev->recv_event->data + offset;
+	offset += sizeof(*ev);
+
+	if (__le16_to_cpu(ev->opcode) != opcode)
 		return NULL;
-	}
 
-found:
-	bt_dev_dbg(hdev, "event 0x%2.2x", event);
+	bt_dev_dbg(hdev, "command complete event for 0x%4.4x", opcode);
 
 	return hdev->recv_event->data + offset;
 }
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 8ab7ea5ebedf..76c186f951d1 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1560,6 +1560,16 @@ struct iso_list_data {
 	int count;
 };
 
+static bool iso_match_big_flag(struct sock *sk, void *data)
+{
+	struct hci_evt_le_big_sync_estabilished *ev = data;
+
+	if (!test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags))
+		return false;
+
+	return ev->handle == iso_pi(sk)->qos.bcast.big;
+}
+
 static bool iso_match_big(struct sock *sk, void *data)
 {
 	struct hci_evt_le_big_sync_estabilished *ev = data;
@@ -1567,15 +1577,28 @@ static bool iso_match_big(struct sock *sk, void *data)
 	return ev->handle == iso_pi(sk)->qos.bcast.big;
 }
 
-static bool iso_match_pa_sync_flag(struct sock *sk, void *data)
+static bool iso_match_conn_big_flag(struct sock *sk, void *data)
+{
+	struct hci_conn *hcon = data;
+
+	if (!test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags))
+		return false;
+
+	return hcon->iso_qos.bcast.big == iso_pi(sk)->qos.bcast.big;
+}
+
+static bool iso_match_conn_big(struct sock *sk, void *data)
 {
-	return test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags);
+	struct hci_conn *hcon = data;
+
+	return hcon->iso_qos.bcast.big == iso_pi(sk)->qos.bcast.big;
 }
 
 static void iso_conn_ready(struct iso_conn *conn)
 {
 	struct sock *parent = NULL;
 	struct sock *sk = conn->sk;
+	struct hci_rp_le_setup_iso_path *rp = NULL;
 	struct hci_ev_le_big_sync_estabilished *ev = NULL;
 	struct hci_ev_le_pa_sync_established *ev2 = NULL;
 	struct hci_evt_le_big_info_adv_report *ev3 = NULL;
@@ -1590,29 +1613,56 @@ static void iso_conn_ready(struct iso_conn *conn)
 		if (!hcon)
 			return;
 
-		if (test_bit(HCI_CONN_BIG_SYNC, &hcon->flags) ||
-		    test_bit(HCI_CONN_BIG_SYNC_FAILED, &hcon->flags)) {
-			ev = hci_recv_event_data(hcon->hdev,
-						 HCI_EVT_LE_BIG_SYNC_ESTABILISHED);
+		if (test_bit(HCI_CONN_BIG_SYNC, &hcon->flags)) {
+			rp = hci_cmd_complete_data(hcon->hdev,
+						   HCI_OP_LE_SETUP_ISO_PATH);
 
-			/* Get reference to PA sync parent socket, if it exists */
-			parent = iso_get_sock_listen(&hcon->src,
-						     &hcon->dst,
-						     iso_match_pa_sync_flag, NULL);
-			if (!parent && ev)
+			if (rp) {
+				/* If defer setup was used to listen for this
+				 * event, get reference to the socket marked
+				 * with the BT_SK_PA_SYNC flag.
+				 */
 				parent = iso_get_sock_listen(&hcon->src,
 							     &hcon->dst,
-							     iso_match_big, ev);
+							     iso_match_conn_big_flag,
+							     hcon);
+
+				if (!parent)
+					parent = iso_get_sock_listen(&hcon->src,
+								     &hcon->dst,
+								     iso_match_conn_big,
+								     hcon);
+			}
+		} else if (test_bit(HCI_CONN_BIG_SYNC_FAILED, &hcon->flags)) {
+			ev = hci_le_meta_evt_data(hcon->hdev,
+						  HCI_EVT_LE_BIG_SYNC_ESTABILISHED);
+
+			if (ev) {
+				/* If defer setup was used to listen for this
+				 * event, get reference to the socket marked
+				 * with the BT_SK_PA_SYNC flag.
+				 */
+				parent = iso_get_sock_listen(&hcon->src,
+							     &hcon->dst,
+							     iso_match_big_flag,
+							     ev);
+
+				if (!parent)
+					parent = iso_get_sock_listen(&hcon->src,
+								     &hcon->dst,
+								     iso_match_big,
+								     ev);
+			}
 		} else if (test_bit(HCI_CONN_PA_SYNC_FAILED, &hcon->flags)) {
-			ev2 = hci_recv_event_data(hcon->hdev,
-						  HCI_EV_LE_PA_SYNC_ESTABLISHED);
+			ev2 = hci_le_meta_evt_data(hcon->hdev,
+						   HCI_EV_LE_PA_SYNC_ESTABLISHED);
 			if (ev2)
 				parent = iso_get_sock_listen(&hcon->src,
 							     &hcon->dst,
 							     iso_match_sid, ev2);
 		} else if (test_bit(HCI_CONN_PA_SYNC, &hcon->flags)) {
-			ev3 = hci_recv_event_data(hcon->hdev,
-						  HCI_EVT_LE_BIG_INFO_ADV_REPORT);
+			ev3 = hci_le_meta_evt_data(hcon->hdev,
+						   HCI_EVT_LE_BIG_INFO_ADV_REPORT);
 			if (ev3)
 				parent = iso_get_sock_listen(&hcon->src,
 							     &hcon->dst,
@@ -1700,6 +1750,16 @@ static bool iso_match_sid(struct sock *sk, void *data)
 	return ev->sid == iso_pi(sk)->bc_sid;
 }
 
+static bool iso_match_sync_handle_flag(struct sock *sk, void *data)
+{
+	struct hci_evt_le_big_info_adv_report *ev = data;
+
+	if (!test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags))
+		return false;
+
+	return le16_to_cpu(ev->sync_handle) == iso_pi(sk)->sync_handle;
+}
+
 static bool iso_match_sync_handle(struct sock *sk, void *data)
 {
 	struct hci_evt_le_big_info_adv_report *ev = data;
@@ -1740,7 +1800,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	 * in iso_pi(sk)->base so it can be passed up to user, in the case of a
 	 * broadcast sink.
 	 */
-	ev1 = hci_recv_event_data(hdev, HCI_EV_LE_PA_SYNC_ESTABLISHED);
+	ev1 = hci_le_meta_evt_data(hdev, HCI_EV_LE_PA_SYNC_ESTABLISHED);
 	if (ev1) {
 		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr, iso_match_sid,
 					 ev1);
@@ -1750,11 +1810,12 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 		goto done;
 	}
 
-	ev2 = hci_recv_event_data(hdev, HCI_EVT_LE_BIG_INFO_ADV_REPORT);
+	ev2 = hci_le_meta_evt_data(hdev, HCI_EVT_LE_BIG_INFO_ADV_REPORT);
 	if (ev2) {
 		/* Try to get PA sync listening socket, if it exists */
 		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
-						iso_match_pa_sync_flag, NULL);
+						iso_match_sync_handle_flag,
+						ev2);
 		if (!sk)
 			sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
 						 iso_match_sync_handle, ev2);
@@ -1780,7 +1841,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 		}
 	}
 
-	ev3 = hci_recv_event_data(hdev, HCI_EV_LE_PER_ADV_REPORT);
+	ev3 = hci_le_meta_evt_data(hdev, HCI_EV_LE_PER_ADV_REPORT);
 	if (ev3) {
 		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
 					 iso_match_sync_handle_pa_report, ev3);
-- 
2.39.2

