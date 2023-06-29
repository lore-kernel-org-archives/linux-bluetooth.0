Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50CCEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jun 2023 09:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjF2Ju2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jun 2023 05:50:28 -0400
Received: from mail-dbaeur03on2079.outbound.protection.outlook.com ([40.107.104.79]:60768
        "EHLO EUR03-DBA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231310AbjF2JuZ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jun 2023 05:50:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyZXsF8hb1jXwVTP8YDj+1BOblbh47v3RsCQBpK1Bzq+TMJuJcCB3NIj4UzVxanIIWYOqzbZr4W+SxZlTEPcQYZoeH52B0+ExqAoSFXO5pXXPPEEGhtyEk5JQepHFIWgi77w/s7SzK04Om56pnR8lWIrXEXiF7wEfwLPa6G2xiLkyB0oHvWQLo887MGw8X6dO0yfMD/nBYNDApwjNLb2h/oOj/M4K11FAR2wGQeBwnAjq6XwUMs1QZcnWfh9qse2wAOk6atbcLqxnbnwkDnXaEP8dXz50CI/NjfirGJzmLpeMhqZBK6TpvOe+CTkmSscg+rXbWCKLOKp4GYRlcE4XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58htU1aaJMtzbks53olmyeICCBPHmnFQOER0Y5hTNss=;
 b=flzmUuSdk953jBBesWHbKtPInHdgABbHjDAUiO6VMyv0YHXxlP1IcNIkb1/kAsn3aW8dAz4cdWpHC2vUQuRkrZU6veof9g3LF4KS755J+ucVcqp5IU/2EqJoZ7pz4CNxOYU/BAptR3APpsU36o5STEvEwdae5OEmJPHf24rMgP+QBUihi4AmIKNaYiDGw5bW5UlRbFR52BXuFq1L4b2vMuyZqo9tjpGULcgFtedfpTvLiA2VQ8Edsmg+P9OivJpgGW0dTw3IyOo8xbRQVffqSsf3aJS0Y/y9etiEdD0dSB98aICPZsJ5ai00SoL/PbSx4KkaiwQqRapBUF9TbItBqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58htU1aaJMtzbks53olmyeICCBPHmnFQOER0Y5hTNss=;
 b=g+og6xlWsC/S+awWQdem7j+Xu97EQxCo7exWXQ20r7R0LzkvNS0tgjjcqySkhDPZAtwQ+NyWmpyF/HQNpF05FfTJIswaZCbsTugUO0kcSmgkbqDu39Xfc0+F7mZ4wofJSQo00B9X/NqTSfTU/B2eXOsdPG2/KjcoSyX/U6s9cq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DU2PR04MB8520.eurprd04.prod.outlook.com (2603:10a6:10:2d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 09:50:22 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 09:50:22 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: ISO: Add support for periodic adv reports processing
Date:   Thu, 29 Jun 2023 12:32:24 +0300
Message-Id: <20230629093224.5135-2-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629093224.5135-1-claudia.rosu@nxp.com>
References: <20230629093224.5135-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0147.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::14) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DU2PR04MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: f838fc68-5f04-4d9b-6519-08db788641ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OP9KvQWdgTEXVQTLL6Q23+DZO/pZdbKD8lDW9mofEbu7gYz6iyTOt6X1V2TbK3oJYBDDSJL2AjQjeBTnuGuUH3LTrMZmOvWECeQM9GmdDeshsUZUp5muM9+zIzQwbbdvk/IZ1CWldcuDXSn3PrioQO9hzjxwgpRDdwJgZRwlU2V2yBNUEqB3lxjQ/o71Ro+mhNQQm0hTiG0NteaEEm8zV/iZHcYYfiY5oV9E7LaXyVrM8s8Guq4CnEfCvrKd0kq/t3tsjxb3lH/6I95VH4xb1IvmSo56jdEqVun/SzTfN9ayT2xK01NGNQqwNXCXdvo6i4MaTaWI651WQcmniVNOo/EP40e+Xs0jjEKD76QT9YjM8Qts0Awd0AX/cNTMnqsDcsdgknWiW0g2EJd5+e+qj0L/un84O7fUSsPI7dgiaT/sPthvA/+qHQz+DsPRHBVlJ2ZaAb6yfzcTkgepCx/7FPFpE1oekPcSEuyRVXrgOSzvqtfpiE/4YCHOuX56GS210cujdSuXwOENqbjYgYLQFh723+424EWLI/zrf1Li5PHydNlfU+UAo20yu9NNLsq3RmTEWByceNwYVZznjcvQOmvEsg4bJCNI4Z4kr7wCEolU0Mi82DXop0rwQ4m/66Ho
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199021)(2906002)(83380400001)(6916009)(316002)(55236004)(26005)(6506007)(1076003)(52116002)(478600001)(6486002)(186003)(6512007)(86362001)(2616005)(41300700001)(8936002)(66476007)(4326008)(66556008)(66946007)(36756003)(8676002)(38350700002)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/zWoBmeLV+4GGkECOJJ1NPkuF1G6Fm/MwjzhclDdABS3UDNty5bJDrFtHMhM?=
 =?us-ascii?Q?X0IGCWImyU307u5kcK+BqgP6HRg0hvhRwiXnkEcfDrSvnaDPClpLrJUkLSFL?=
 =?us-ascii?Q?9I2Zgi5pGDF6NVqWRmG2vM5IN4QMBdJUxd4nzR9oH4rwMqSScZm2z7m4hWZI?=
 =?us-ascii?Q?GpvJ3hp2j0bLZmo9SFPQ9QzhQQmuLHVFoGfpS1Iyr1y3MSQ0R2DGn7pusN/3?=
 =?us-ascii?Q?54o2VqEGnjL8L5Lbotb1D4i+X6v6SSemcnOoTI2dg8nl4eTwcXruWp+Gw9EE?=
 =?us-ascii?Q?NzxIay6yEBltmbUD0uP1quPQ1Q8qb+tEGdTAOw2fr5lY/DhNFm2kdwUaPh2/?=
 =?us-ascii?Q?yBZPCxvbqqp8SmDLXxInGpZ8oZchzvTQxsYR48MllMeOpS/+sW1oGsqSIWEL?=
 =?us-ascii?Q?FS7EUChSmRKlaTlL3AGHMZsDzRmh9lTqBx4/fAVThfwXWpK3oJQMCEcZbTDX?=
 =?us-ascii?Q?tCeJ3SLjcG4pevQPaEd5xpfTe6HQMur0hcPOujJ4id3F3OrBkXHEhe7c3boP?=
 =?us-ascii?Q?iewedMwDz4Wig+NGiA0oJkQsMHXkeYYqNvWYp7uXyDg29ubYN8gv/TbkXGHj?=
 =?us-ascii?Q?xAOhyw8H/1nIzXY4+qoBznEBjHpZxlfk1pRWyd+03Omzukav+kcLORNKh/es?=
 =?us-ascii?Q?ZfKp+0ZWGiYbYHC9VfBHhP5Oc0rrLO1FBAxYQ+lfoBUF7jazTy/UYMNwAIFw?=
 =?us-ascii?Q?qtBPT6quZNFmSCcY8sqc5iI8YLzphYaMLxaI9iBRUpS4Dx1G8yJFwlwWQCW/?=
 =?us-ascii?Q?X556gSOSPvJrx3XVFYBPMHt8JuGAh+5EU5OFcsx9w+dB+21kSuC4Wgxpn/Wl?=
 =?us-ascii?Q?7wcTWgkHfb0/IHRpVofN1WJG5v+tc0sMjqgr/nTowZKas3k35fkL78Z0Hrwr?=
 =?us-ascii?Q?K+DYW+HfUQr8YK3iXFZVmHfiOf29n85+Yw1seLjUaTMA7dzMq8NCP19HLKmJ?=
 =?us-ascii?Q?WxGg9FMr43zgMJyMjvS2X3Dkt0A2WLIdTFHAbz4N9dguYBRE3SGxlGihnCyP?=
 =?us-ascii?Q?A3ksdXNNqlki4RkhkB+WkRsChTUs+yb8nJE17TsW1VR5fqretEJcyDAtaTfS?=
 =?us-ascii?Q?/y/GuOHhwx8GLMqeflkMxuk3HoforU2Aso2o4kpUn7IJ4LXXursqz0gW6nBV?=
 =?us-ascii?Q?xsXGeh2850/GsGDtU3vHyKTNkwDT65jkN2G9LWKIwOs+ymVy+9wN2IbfzoJF?=
 =?us-ascii?Q?ReOcWTCOzkOp2KR7KqoakvVec+DEMC3ReLaiYE/iYk3X4KYgm4HYbghtX9vv?=
 =?us-ascii?Q?PoyxgBaZE6qztAUXyxAtUcICnt/ceIu9Tfu1H5jK+r0GTR5YDe5LTpRMOEq1?=
 =?us-ascii?Q?Qco/owVF0iQoaqXL0QTyf24UTZ+aplWZp3m0GIK9rSlVlveRChwv4hgfdhn+?=
 =?us-ascii?Q?A2kLCQZTBGnerO2p5wYLRBaCPsShkidCAmkijy5+B51FG9muBOgquh1tngbG?=
 =?us-ascii?Q?TI4Q8TQFyIKxMsf+AVUCcBvortxFiU3FveTykmNs5/4XRJA0ZRHlmcIVJLTL?=
 =?us-ascii?Q?X/qBLoujQKR8MhnJcVej+m48f7VTCiE6F8viu8iQrZTRjiP7ZwAWww+qCjAv?=
 =?us-ascii?Q?gTnmh5aZcHWyYj9x1xVbGtbxgseTdaBj7YOnYHKX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f838fc68-5f04-4d9b-6519-08db788641ab
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 09:50:22.7267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1tRIaahfTy0JtGLrohIgKxsWDuRYTkEgu4KzCwe61AfZmfjRmYGAAEOU4TLLQEsUxQLUrE0xTIMBtqbWApSVmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8520
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

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
index 77cbf13037b3..b036ee4fd397 100644
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
+		  hci_le_per_adv_report_evt,
+		  sizeof(struct hci_ev_le_per_adv_report),
+		  HCI_MAX_EVENT_SIZE),
 	/* [0x12 = HCI_EV_LE_EXT_ADV_SET_TERM] */
 	HCI_LE_EV(HCI_EV_LE_EXT_ADV_SET_TERM, hci_le_ext_adv_term_evt,
 		  sizeof(struct hci_evt_le_ext_adv_set_term)),
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 84d238d0639a..2c077bdf8aa4 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1392,7 +1392,8 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_ISO_BASE:
-		if (sk->sk_state == BT_CONNECTED) {
+		if ((sk->sk_state == BT_CONNECTED)
+				&& (!bacmp(&iso_pi(sk)->dst, BDADDR_ANY))) {
 			base_len = iso_pi(sk)->conn->hcon->le_per_adv_data_len;
 			base = iso_pi(sk)->conn->hcon->le_per_adv_data;
 		} else {
@@ -1565,6 +1566,9 @@ static void iso_conn_ready(struct iso_conn *conn)
 
 		bacpy(&iso_pi(sk)->dst, &hcon->dst);
 		iso_pi(sk)->dst_type = hcon->dst_type;
+		iso_pi(sk)->sync_handle = iso_pi(parent)->sync_handle;
+		memcpy(iso_pi(sk)->base, iso_pi(parent)->base, iso_pi(parent)->base_len);
+		iso_pi(sk)->base_len = iso_pi(parent)->base_len;
 
 		hci_conn_hold(hcon);
 		iso_chan_add(conn, sk, parent);
@@ -1595,12 +1599,20 @@ static bool iso_match_sync_handle(struct sock *sk, void *data)
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
 
@@ -1616,6 +1628,9 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	 * 2. HCI_EVT_LE_BIG_INFO_ADV_REPORT: When connect_ind is triggered by a
 	 * a BIG Info it attempts to check if there any listening socket with
 	 * the same sync_handle and if it does then attempt to create a sync.
+	 * 3. HCI_EV_LE_PER_ADV_REPORT: When a PA report is received, it is stored
+	 * in iso_pi(sk)->base so it can be passed up to user, in the case of a
+	 * broadcast sink.
 	 */
 	ev1 = hci_recv_event_data(hdev, HCI_EV_LE_PA_SYNC_ESTABLISHED);
 	if (ev1) {
@@ -1648,6 +1663,17 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 				sk = NULL;
 			}
 		}
+	}
+
+	ev3 = hci_recv_event_data(hdev, HCI_EV_LE_PER_ADV_REPORT);
+	if (ev3) {
+		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
+				iso_match_sync_handle_pa_report, ev3);
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

