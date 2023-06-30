Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010BDEB64D7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jun 2023 10:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjF3KAh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jun 2023 06:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjF3KAf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jun 2023 06:00:35 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136A91FE7
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 03:00:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXYPQc9Of3YxdD0kg7kT5W2OhVSQhMCCdkMiXt4Y6P5WUWlh7ST6ISs+dDiXgtFl5fbkmg1JrqMTCbPU1g5gnWxQkMGafIR1S9cAxsAoW6wfkejGdphsYinPSZXNZnVZJJPL1DUJZwz9FjF71aYk+rmcndhVo2rHgs0f+L4S3Dfi456cA6NmMqf7qkpO3yzMjXheR4TNnMHiymGyBUB6DKUQYr26lvKIEwiqbk8WU0KLc6lA4uIVUTQDQIV9Nzwwpf6f8c8NeovFIxftcapaP1qxKmKLdl8hrvPO8DPIUJ3J/bTEbgHP0jxW0zAabtR5XLJ1fwaH9gDWi88NCLKNpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pqz+UAZD0wGqMTeAIeqC9e3CPWP5pe3fNfPIMvGasKM=;
 b=NtH6Aoo54nqj4gT7sog9CVdrfzx8KRsVxciEuPbrZbwkMXqRqakowoz9e44TQcLLuB/UOt+SkLkWr94KzlKF9Yn9P9/QtF7JNmupfb71f7i4B441o/kB9oMWE/LbV9uA68Fbi+gyDGlsbAnNvI442et7RD6naaiMZrLjS3AiLdRkwv2twXUAS8PBLaMPqoGw1s4IO4rPRFoXLRZPmanhGGy5bf7zrVH/ItnT8Vo7qpTZN/LnQQJiap3aUMGqbkl5XvGnvE9NMFETpIREF7c9cHjwXIgAn5lQR4xOn0ynqccKkDCRdtXMrUpKBptk3jWjzVzdwdIPDEJ+EHpE9Gdu1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pqz+UAZD0wGqMTeAIeqC9e3CPWP5pe3fNfPIMvGasKM=;
 b=mWXG794BXBq5FPkQGq77wBpdHJYil+Km0vFrYZjI2tGWC8NKMzGSpnM7eyWiSGrVBbSEr5xQNXogfPAyumebHy+HOno25mEObzdlk7MapKlSZ7NWzhzVdCT75Tg0DlECDWafIIi2d0Rsa+zLjJfYxokFeMSVCj1z7mValuFS5Ko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by VI1PR04MB7005.eurprd04.prod.outlook.com (2603:10a6:803:136::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 30 Jun
 2023 10:00:30 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 10:00:30 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH v2 1/1] Bluetooth: ISO: Add support for periodic adv reports processing
Date:   Fri, 30 Jun 2023 12:59:28 +0300
Message-Id: <20230630095928.436569-2-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630095928.436569-1-claudia.rosu@nxp.com>
References: <20230630095928.436569-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::28) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|VI1PR04MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e00070-c059-4a62-0067-08db7950d650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g2c4fH+VkSY44NgSDwEszdeMB8xpZeqdM64E8iwDTFP+tNxD/VRfYGvrcKqXEcwrNkl/sdtoLE4agh+wThPp2a0jY2pzzZvWabES1Q4aP54Q/6JMLLHVjK9ld1dfZjbEGvyDySWUkm1FHLZW28bu+WETsF7Kp+nq00ZeYAljrU6qM+weR/bORR8jk1DkPj3gFtymRXinNgEVPQsEtxoBQ5MTYLZQEMQXwCqW2ANCjndCIXd0rl8WYRF05VLGiTF07lfvl7Lx6XlBURfgl/6qIrS63qd+VeZHpZ1lAaTdht1CThdn5kUUpy/uGqYfOOs7r+8mjWVjzN/TmtURHlYLap3pXqpIYNXWjsrNPQB9iwRZAZgi1AeQAH5iw7S5XImGsr7WCWcpgAzwxeBGRvqtnUB91v8XLDjxQKqM56IiqdPHlnhZQkR8gqKYlUu7SQLfOVe+26BFb0/BqdYGA8nhu1p7t68bxCDUlZD8T8p8Ppr5crkf0I0V0ccREJOiKPv9X2nMH+hGVSt/OSz8/VkyFOH6gJeY8ZjAiqyoDT2NLIU/4RJc3CvqUEq9ZUUXGmNnKSakjYVa4wx+AwKpDzOgYlwbDpEDMtlS8pBgpJVor+aA+FDyYLo5J7AMyrWh3Tfq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199021)(55236004)(1076003)(36756003)(5660300002)(86362001)(66476007)(66556008)(41300700001)(6916009)(8676002)(316002)(4326008)(38350700002)(8936002)(38100700002)(66946007)(2906002)(478600001)(6506007)(186003)(6512007)(26005)(2616005)(6486002)(52116002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9uy9h7G/k+YEuSyBHs6123eJOlAroXMdBARnNibDPAKirh3ctjJascv89NT9?=
 =?us-ascii?Q?EUoZpKqbjCrQJDhWaGV+Pq1SjwGISRtTjR7ZKyxVVVzZ6QblfHrPKhQghS18?=
 =?us-ascii?Q?cTRBX38RMBCM97S3Hk+bsm+lmTfseBUE/TcqNF0ryguoh/89dr49hCDn5ld/?=
 =?us-ascii?Q?QtKVJncDK2VC45ayDlWjqA/fuCzLKnkanab57UAozHTplV0I80/QV8tqDb0q?=
 =?us-ascii?Q?zq2AwMxOJKZmGMpXLEVpeEUKyr8jVTPiBfL19Pwc5wOugIj2MrNd+nNOC9zU?=
 =?us-ascii?Q?yIgZ6HBptAchbb3Ee+Wa10qBsF8f2dqePrcZVCpH/K45rKcePSGR0S556HWz?=
 =?us-ascii?Q?iWhMjppsItlCmXxCOoqbDbBo14Or/S/0T860MtlC/A/Dd/dyW+9ebRaSz2xk?=
 =?us-ascii?Q?+gTdpwe4WYH8wpIZI35/kAnO/5mc333rn5B1dxSuEpIg21zLvzZOIxuzh2Ol?=
 =?us-ascii?Q?hv3fElDhC2sbSAjV3JLHKkAdZP5/aPIaZPw9P1sOIlWP06LK62JYpkk6jZFc?=
 =?us-ascii?Q?soFSovXXNzqSu6BL/09QESPzkZv2OG02RjdjInF4m4EwZ8Ce8EflwL44WwPP?=
 =?us-ascii?Q?WPG3OkfdMZ0eXAxyX1ul6KH2GC/4nZe7BpLxR4yjT3QJiW/y2foCcOyjbo5B?=
 =?us-ascii?Q?rNUUEAndoAHGTTJq9f13kGIkixy3+kNIvEekxo7z5Okj0FnRa/vJSex0Hldd?=
 =?us-ascii?Q?XakLYCs0yqCy3vfuNxAl7SaE/1btxRrPMOaRTSaPEiRYmxDw1fvQvuQdYmxY?=
 =?us-ascii?Q?2xNp7lIwYL3F5X3RaXVA6EOoLc0A2xI1x52/d1S5sEhsXzE7NIrLScWczPip?=
 =?us-ascii?Q?jJKAN8cZxsITjC6DMIvt0uepyuB1wJ9+h5hpwPNXY49GuWpm8JtMipxNDqgm?=
 =?us-ascii?Q?NZBW6YuGkkjrUDKmsFXKVG7plIIOHd8k9RGP1savnRbhx1clRQhf2PQtbtrP?=
 =?us-ascii?Q?7clAJc5M59Fawnq9YJ6nkltdXiqBmoTE6m19I/NcTDhdRZzoAjyis+GskQNF?=
 =?us-ascii?Q?ppDtR9IrKToNew6BEYId9QV0BJ8Mk4jkW+TOqj0Przyf8+Te+AHQ6V9US0DC?=
 =?us-ascii?Q?UiF9wvFTDxAX3PO0h0otZez0lKeHhLlruQGAI7v0OTlJRU0SgfIWlcJ1nqGA?=
 =?us-ascii?Q?YpDG1kuRjPa6Nbs58fQmzMojvgPBpzq79HBdEbJqMTzjsbVoP6Lm9llLgmZ8?=
 =?us-ascii?Q?W0J2N6yidW4yB0uJwR0b9/P4sMI19kdYpJoYcoF0Uf1mKEyuIy/7ox1xK7FX?=
 =?us-ascii?Q?90uKJjguravJoBhuEi5Hd/d2F1W8BTh2UhcPTG74r5M9N/JDq3HrnsRJyebc?=
 =?us-ascii?Q?7/5azmFyuoZYxLCg/75DZif7GYX+Ioe/QrBdl6lNH96IqDkvHhefxCFY0glX?=
 =?us-ascii?Q?XULPG4J+4XBElrOV+CAPL1YiZTiIOXO1mbnVCXv4n4fHzUd3vxwWWHD8H+Gh?=
 =?us-ascii?Q?8wgnQAy15ClH6jg/BRpbnyjYBB8Or2vAow2iWTtKsE41jdvJcDnIEotacqy8?=
 =?us-ascii?Q?d0Oz9Rlg4Avkqo7buLxesgQijRKGSy/C63aB9SmFU/MI6SWBdz9i/VdQP1GR?=
 =?us-ascii?Q?AAHNNz7ekDlItq6ZwyUCqD8T6MZFLi/WL7m7lIHx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e00070-c059-4a62-0067-08db7950d650
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 10:00:30.4149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWnTSoHxHa01Aj451msfq2Jt+vLGwrD/x1scHemWX6HrOh/GZWLg0wF8Q6lMmpFgd3jZhUcqlmFbRQmMA2jvaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7005
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In the case of a Periodic Synchronized Receiver,
the PA report received from a Broadcaster contains the BASE,
which has information about codec and other parameters of a BIG.
This isnformation is stored and the application can retrieve it
using getsockopt(BT_ISO_BASE).

Signed-off-by: Claudia Draghicescu <claudia.rosu@nxp.com>
---
 include/net/bluetooth/hci.h | 11 +++++++++++
 net/bluetooth/hci_event.c   | 23 +++++++++++++++++++++++
 net/bluetooth/iso.c         | 28 +++++++++++++++++++++++++++-
 3 files changed, 61 insertions(+), 1 deletion(-)

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
index 0b4415e79989..d36e14bfe36f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6586,6 +6586,24 @@ static void hci_le_pa_sync_estabilished_evt(struct hci_dev *hdev, void *data,
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
@@ -7153,6 +7171,11 @@ static const struct hci_le_ev {
 	HCI_LE_EV(HCI_EV_LE_PA_SYNC_ESTABLISHED,
 		  hci_le_pa_sync_estabilished_evt,
 		  sizeof(struct hci_ev_le_pa_sync_established)),
+	/* [0x0f = HCI_EV_LE_PER_ADV_REPORT] */
+	HCI_LE_EV_VL(HCI_EV_LE_PER_ADV_REPORT,
+				 hci_le_per_adv_report_evt,
+				 sizeof(struct hci_ev_le_per_adv_report),
+				 HCI_MAX_EVENT_SIZE),
 	/* [0x12 = HCI_EV_LE_EXT_ADV_SET_TERM] */
 	HCI_LE_EV(HCI_EV_LE_EXT_ADV_SET_TERM, hci_le_ext_adv_term_evt,
 		  sizeof(struct hci_evt_le_ext_adv_set_term)),
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 9c41af55f2c7..6467c20970c2 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1378,7 +1378,8 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_ISO_BASE:
-		if (sk->sk_state == BT_CONNECTED) {
+		if (sk->sk_state == BT_CONNECTED &&
+		    !bacmp(&iso_pi(sk)->dst, BDADDR_ANY)) {
 			base_len = iso_pi(sk)->conn->hcon->le_per_adv_data_len;
 			base = iso_pi(sk)->conn->hcon->le_per_adv_data;
 		} else {
@@ -1551,6 +1552,9 @@ static void iso_conn_ready(struct iso_conn *conn)
 
 		bacpy(&iso_pi(sk)->dst, &hcon->dst);
 		iso_pi(sk)->dst_type = hcon->dst_type;
+		iso_pi(sk)->sync_handle = iso_pi(parent)->sync_handle;
+		memcpy(iso_pi(sk)->base, iso_pi(parent)->base, iso_pi(parent)->base_len);
+		iso_pi(sk)->base_len = iso_pi(parent)->base_len;
 
 		hci_conn_hold(hcon);
 		iso_chan_add(conn, sk, parent);
@@ -1581,12 +1585,20 @@ static bool iso_match_sync_handle(struct sock *sk, void *data)
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
 
@@ -1602,6 +1614,9 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	 * 2. HCI_EVT_LE_BIG_INFO_ADV_REPORT: When connect_ind is triggered by a
 	 * a BIG Info it attempts to check if there any listening socket with
 	 * the same sync_handle and if it does then attempt to create a sync.
+	 * 3. HCI_EV_LE_PER_ADV_REPORT: When a PA report is received, it is stored
+	 * in iso_pi(sk)->base so it can be passed up to user, in the case of a
+	 * broadcast sink.
 	 */
 	ev1 = hci_recv_event_data(hdev, HCI_EV_LE_PA_SYNC_ESTABLISHED);
 	if (ev1) {
@@ -1634,6 +1649,17 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 				sk = NULL;
 			}
 		}
+	}
+
+	ev3 = hci_recv_event_data(hdev, HCI_EV_LE_PER_ADV_REPORT);
+	if (ev3) {
+		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
+					 iso_match_sync_handle_pa_report, ev3);
+
+		if (sk) {
+			memcpy(iso_pi(sk)->base, ev3->data, ev3->length);
+			iso_pi(sk)->base_len = ev3->length;
+		}
 	} else {
 		sk = iso_get_sock_listen(&hdev->bdaddr, BDADDR_ANY, NULL, NULL);
 	}
-- 
2.34.1

