Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AA5C4167B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Oct 2023 15:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbjJ3Pnj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Oct 2023 11:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbjJ3Pni (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Oct 2023 11:43:38 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E955DA
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Oct 2023 08:43:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeZulrnNVFODeQE8Z2KzL1pgg9Fcns+YbTIxlzxBiyoFQf/EI/nbdXeKyE1K0W04oTQGtP36owY3EHD80ua0WZc44ocP/pyAjHHCG8JlVHSWAEliL9eASPw4G1qSExym7DgKzazP0CghlrBwtKsBtTmQapo234oS0ktX0g5jHDINCWkWMhk/tnc8emGyuYw+JsuOCW7Xm8LrIWP8lZ0guwc3VO1uYgr41fWw5UBieoFmck2KVQME6uhHTFSFPZ0fXTMtb1zLjk5eT0bbb8unVPgoYwqsTWZELDWmKBNmwYjT5l4tgG9XO+cKdg6Qypr4HLCW71EDDpEwdcthAU0KSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hx/1bkmBgn0AQVcwp9xtbWkHRhHXp+dnBZkwfL3yE8M=;
 b=hBMazlV0WxzqQlIuyFgy8E5Txk9FQOpRKXZXTCSc615OOQeCttJulJ5M5JfIn6tg6XolKTDZ5HWE6/9yDvZ5LCPolvPO7BEjeNuFlDpvqXsPw9v/GudPOARgREB1q2//qNffq69C68fgxfNHjd3kgYG2w4bIt8Mvuzp3yScQMG4S0vj1dil8q+JJwg4UFZM37hUlymtjZi0zrLJWIubDohsETSv8MKmMep5r7leKHwF8GPhU9knwkytP4o6G5nmeWoaiM7sS39z01xvzx8BWfbm/ZNHtUi/mHNkwROijFfQbb4EBcqi85VZhdK0HbRsWtHrZdiginGSQiQP2A5JMfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hx/1bkmBgn0AQVcwp9xtbWkHRhHXp+dnBZkwfL3yE8M=;
 b=gbtvghqDeyDT+mIrV5kLD0uXJsZfDl32fCuTj69SBoZOw/WMUL8B5J+eRmi1SDzO2yfEcpJ5P0JDEeuwYuRHk6QM2+uQuHCp7KQ7tSvLlZIssLJSeSyFc7WRJdNE38N0vyLaAfOWyLmFy8duqIlRQFv7UAXgaJFOpN8VFiMmbfo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VE1PR04MB7342.eurprd04.prod.outlook.com (2603:10a6:800:1a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Mon, 30 Oct
 2023 15:43:33 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::9294:43e2:390:2b6d]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::9294:43e2:390:2b6d%4]) with mapi id 15.20.6954.014; Mon, 30 Oct 2023
 15:43:33 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: ISO: Reassociate a socket with an active BIS
Date:   Mon, 30 Oct 2023 17:43:18 +0200
Message-Id: <20231030154318.4339-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231030154318.4339-1-iulia.tanasescu@nxp.com>
References: <20231030154318.4339-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0219.eurprd08.prod.outlook.com
 (2603:10a6:802:15::28) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VE1PR04MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: ab72d2fa-7714-42aa-b1ee-08dbd95ef8f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1905LdPhCrXVMBNe39J1IWFsdxCQJ8N2m05yOuNblafn3n4yWKh0XuatS7oKSG0Fms3Lc8w5olL0TNXtFmB/1Y3oba8Im/RdT9PbGy+YpNmp2asfdqqBCoROIgLvcMV23ODSS03+03EPYiMxLlGB5TcIS1V7+oNzoxyf9F+RAJ0fZmNCa9akc2EKHf5T4FSKhzzSiwh9HWzlQJNTzD7IN81ig1Iv9PuNJKrxgLyQvLejpMgE4Kt8KigANtr/BaMPCj1D3j9wRDtxPA7jzoLbnJEjFbzW/qaURxVabC46KHy/AA+FTO/Tu7PVe1oxWz3Ec9AOl5STWWeYicUtxxFnnwoepxawX6feOVFNiZHR+vbPlCWvNJuQAeJU6a91w+/9+oOtnZl7h6RGBlWI4lo5ySxhJCA5J0ugAxRxsE4tQUL47EqrTD9nD67h19DaD8QbHteMnLwnghHJOXjGhJ1slPFvqdvmkKHgdTmd66f5IiAmscVZVdhteAVHiSKrBUKbJpETm05IkBNzUD1FcUdXbREw9b8ETUhyckH3Wg/U2qaJS+sLuqGey88YXpmmePW5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(136003)(346002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(478600001)(2906002)(38100700002)(8936002)(41300700001)(36756003)(4326008)(8676002)(44832011)(5660300002)(6916009)(66476007)(66556008)(6486002)(316002)(2616005)(86362001)(6666004)(6512007)(66946007)(1076003)(26005)(83380400001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UYx1u6NQq0btAKTtWC6yENZDZtZNXN5PXOix392ctz9zimXFUskhYxxzWWh6?=
 =?us-ascii?Q?WQn/43enVyhVwd4mur+0h3IR8XeMImb/YDv0HzpbPsshcy0hrMTSs2/ksy01?=
 =?us-ascii?Q?2t4jQlR8w3b5x2f9dESd+Nh2NYp+1x3sbSDjKDvlh7FgEkSI5fCRekjHmYyw?=
 =?us-ascii?Q?JPrgQ5XPENGajzCaduFW4Yh3hQFvboybNdmk5mBlJWmr4vC4bDE/VkuV2ToW?=
 =?us-ascii?Q?R1BcsQ89MixMwv1dYEttz3g87KdPtSLcNiB7Js3ERKwb3jX0ALMelJeLZLqd?=
 =?us-ascii?Q?ZbwBH1FXxyuRYF5wXV5ObOjZAB4UVUW2/cWGsCNU3deT3meHhU/r3lRZIIpp?=
 =?us-ascii?Q?W8Cel802EmppGd3bQ1GwF8pqjpxn16dVFffRnxJhsXF7bTKJvQrgLHAvsUo7?=
 =?us-ascii?Q?1wN1eCkC10q8kFByhjJd73Sip4OYqmWR6f+IkLngm7STKsCxrcIbizFmwztb?=
 =?us-ascii?Q?H0U9tqbt+0vrnZ4M0cUILeRkA67uGlKPxsE+c5rAPKreVNCxC90fJUOZEkPq?=
 =?us-ascii?Q?3ghTExsUTqtAo9Y4H2FA6T2eYfvdxoMhtTh5kDKKdKQA0R4kyYp6guCDXPUE?=
 =?us-ascii?Q?JV1eFFJu2Zvz2Q05S+zxknz5EAF7F9xjL8gE+ET0P1wDlofa44GNMTZj7RfQ?=
 =?us-ascii?Q?JCH2vHKz1RiHOvy4r9WuY95nvDx8fAQo9HH3DTr6GGcyhigNOMG/xg2RCyyQ?=
 =?us-ascii?Q?1eAPOmJnqkVQajxCZVN3IkFnwZF+O0YIkqGr4Hh/fc48Wb/5G96IZmKkxbrB?=
 =?us-ascii?Q?xFhToZcO5YaW28sCDa1gWkChErLEucP1Obpno/l0ya/eqQwHXZ10ykDWJFdq?=
 =?us-ascii?Q?XbnN0MW3TZ/bqQPVUGUNRDGBzZbgP3DCCqB2Y9NndrGzC+B3hdISnPMmZy42?=
 =?us-ascii?Q?/s4p7ZWZTyX0M3aRcai9jYj0aweYhTqY6CpPo7pluRTh/lbnTH9MxmZLCJaM?=
 =?us-ascii?Q?XX3XHjN0pxzjWJAkzUCoWfc1GcCdtB7BO6hwfd6t7bBvkRIFUZ+9H+1LbDp7?=
 =?us-ascii?Q?vhHR9Rpf1d7+ZiwV2wg+AuTe3g7PUHFjLd48pbQkhB8zLHdbKaDG0tDzlcVa?=
 =?us-ascii?Q?23v87ZwgNA5y8TKGcjwcVtTA1oiBlmQPi3eNMqC51JRYbDKhD1wtuRa2wFg4?=
 =?us-ascii?Q?8DV+9KuQgGF90WKgvMKNl/XTipdsJu6tyl4l8ifrXQaiqVtJ9H41IW814WcF?=
 =?us-ascii?Q?Vzf/4l9GqEVkfJ6DbESZXKI+4v0R6TkXWTYX9S7KpfPFiQ+Uc9q43K+R7Xka?=
 =?us-ascii?Q?VEelcs00Qr1O0iThxKmbcUz+frll5ZcTihsLq4A3jOhvn3e/fAZQxEkRiqQT?=
 =?us-ascii?Q?bfRTKcBMxPg8qrKVa2W2S7vN4/vFG4/RSRPSCRqQFaIQRteRyb+rnHGKUxhx?=
 =?us-ascii?Q?64ueVtWgDm/i0mzQOhh4/iBaYIgYapwzZ4g7q/NtWgP1hslr4UG2A5sQk/rr?=
 =?us-ascii?Q?m8UVDQfV9bPLQKIgILv9FQVRSzv+LgoWciCmAHBrbcr2L+L6O7YcyeT0t+0l?=
 =?us-ascii?Q?zWI8wHIUyd+/s85Fp6zZml6+9/kdLZsdfMsQdJAPc8hTdn0oJj0gxr7He95b?=
 =?us-ascii?Q?yTDx4fbQ4K+emEaB5s4B4mzJOvMqaxw4KWVTR8WN9ziHOPRMLkY/1kxmrUtm?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab72d2fa-7714-42aa-b1ee-08dbd95ef8f8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 15:43:33.4992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 273a1GNF1rprNpbka4TRLetci09TydTHnoxKvauRByy9i7Hvz1kB8sb7++z3QBcnm6bXX8+f7RpsvQDBdNTggw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7342
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

For ISO Broadcast, all BISes from a BIG have the same lifespan - they
cannot be created or terminated independently from each other.

This links together all BIS hcons that are part of the same BIG, so all
hcons are kept alive as long as the BIG is active.

If multiple BIS sockets are opened for a BIG handle, and only part of
them are closed at some point, the associated hcons will be marked as
open. If new sockets will later be opened for the same BIG, they will
be reassociated with the open BIS hcons.

All BIS hcons will be cleaned up and the BIG will be terminated when
the last BIS socket is closed from userspace.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 include/net/bluetooth/hci_core.h | 24 +++++++++++++
 net/bluetooth/hci_conn.c         | 27 ++++++++++++++
 net/bluetooth/iso.c              | 60 ++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 20988623c5cc..201c0809540a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1292,6 +1292,30 @@ static inline struct hci_conn *hci_conn_hash_lookup_big(struct hci_dev *hdev,
 	return NULL;
 }
 
+static inline struct hci_conn *
+hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle,  __u16 state)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (bacmp(&c->dst, BDADDR_ANY) || c->type != ISO_LINK ||
+			c->state != state)
+			continue;
+
+		if (handle == c->iso_qos.bcast.big) {
+			rcu_read_unlock();
+			return c;
+		}
+	}
+
+	rcu_read_unlock();
+
+	return NULL;
+}
+
 static inline struct hci_conn *
 hci_conn_hash_lookup_pa_sync_big_handle(struct hci_dev *hdev, __u8 big)
 {
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2cee330188ce..b8ab5c0cd48e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2228,7 +2228,17 @@ struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst,
 			      __u8 base_len, __u8 *base)
 {
 	struct hci_conn *conn;
+	struct hci_conn *parent;
 	__u8 eir[HCI_MAX_PER_AD_LENGTH];
+	struct hci_link *link;
+
+	/* Look for any BIS that is open for rebinding */
+	conn = hci_conn_hash_lookup_big_state(hdev, qos->bcast.big, BT_OPEN);
+	if (conn) {
+		memcpy(qos, &conn->iso_qos, sizeof(*qos));
+		conn->state = BT_CONNECTED;
+		return conn;
+	}
 
 	if (base_len && base)
 		base_len = eir_append_service_data(eir, 0,  0x1851,
@@ -2256,6 +2266,20 @@ struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst,
 	conn->iso_qos = *qos;
 	conn->state = BT_BOUND;
 
+	/* Link BISes together */
+	parent = hci_conn_hash_lookup_big(hdev,
+					  conn->iso_qos.bcast.big);
+	if (parent && parent != conn) {
+		link = hci_conn_link(parent, conn);
+		if (!link) {
+			hci_conn_drop(conn);
+			return ERR_PTR(-ENOLINK);
+		}
+
+		/* Link takes the refcount */
+		hci_conn_drop(conn);
+	}
+
 	return conn;
 }
 
@@ -2287,6 +2311,9 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 	if (IS_ERR(conn))
 		return conn;
 
+	if (conn->state == BT_CONNECTED)
+		return conn;
+
 	data.big = qos->bcast.big;
 	data.bis = qos->bcast.bis;
 
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index e01b6abe36fb..13353d7dc4b1 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -587,6 +587,44 @@ static struct sock *iso_get_sock_listen(bdaddr_t *src, bdaddr_t *dst,
 	return sk ? sk : sk1;
 }
 
+static struct sock *iso_get_sock_big(struct sock *match_sk, bdaddr_t *src,
+				     bdaddr_t *dst, uint8_t big)
+{
+	struct sock *sk = NULL;
+
+	read_lock(&iso_sk_list.lock);
+
+	sk_for_each(sk, &iso_sk_list.head) {
+		if (match_sk == sk)
+			continue;
+
+		/* Look for sockets that have already been
+		 * connected to the BIG
+		 */
+		if (sk->sk_state != BT_CONNECTED &&
+		    sk->sk_state != BT_CONNECT)
+			continue;
+
+		/* Match Broadcast destination */
+		if (bacmp(&iso_pi(sk)->dst, dst))
+			continue;
+
+		/* Match BIG handle */
+		if (iso_pi(sk)->qos.bcast.big != big)
+			continue;
+
+		/* Match source address */
+		if (bacmp(&iso_pi(sk)->src, src))
+			continue;
+
+		break;
+	}
+
+	read_unlock(&iso_sk_list.lock);
+
+	return sk;
+}
+
 static void iso_sock_destruct(struct sock *sk)
 {
 	BT_DBG("sk %p", sk);
@@ -639,6 +677,28 @@ static void iso_sock_kill(struct sock *sk)
 
 static void iso_sock_disconn(struct sock *sk)
 {
+	struct sock *bis_sk;
+	struct hci_conn *hcon = iso_pi(sk)->conn->hcon;
+
+	if (test_bit(HCI_CONN_BIG_CREATED, &hcon->flags)) {
+		bis_sk = iso_get_sock_big(sk, &iso_pi(sk)->src,
+					  &iso_pi(sk)->dst,
+					  iso_pi(sk)->qos.bcast.big);
+
+		/* If there are any other connected sockets for the
+		 * same BIG, just delete the sk and leave the bis
+		 * hcon active, in case later rebinding is needed.
+		 */
+		if (bis_sk) {
+			hcon->state = BT_OPEN;
+			iso_pi(sk)->conn->hcon = NULL;
+			release_sock(sk);
+			iso_conn_del(hcon, bt_to_errno(hcon->abort_reason));
+			lock_sock(sk);
+			return;
+		}
+	}
+
 	sk->sk_state = BT_DISCONN;
 	iso_sock_set_timer(sk, ISO_DISCONN_TIMEOUT);
 	iso_conn_lock(iso_pi(sk)->conn);
-- 
2.39.2

