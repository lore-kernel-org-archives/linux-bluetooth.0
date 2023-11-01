Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24268C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Nov 2023 15:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbjKAPag (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Nov 2023 11:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbjKAPaf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Nov 2023 11:30:35 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2070.outbound.protection.outlook.com [40.107.8.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C842811B
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Nov 2023 08:30:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlpbYULDZp10p28PXQKWhVKDAj878OpMMVoic+/RTkOiWbgrdD/dXQWGJs3ikxlQaDr5f5LvvTAQGg2Fpn1tsb0zcK2XDDoVQlfKFI7l9PubQY5Ek1woOk4dU6TjAZZ3drF+9v4pg9MnaQC96MXkhrRwll288/Jkdvx8XBFnK9rv6DUdS24SZ7gm+MXffpz4JNal4eLwwNaZo5P90i2KsxN1xWrpcgVJhDEdNVg8q715J1Wv27jpGAZqiqJmC4GSSQIhRrPsKBEvEHRFsa0biI84yIh9i1tmu6tfnD/76OLM5hhtsLhFQPRnKCHX4d95SWtqUR/E4A8yMP1uxkjEQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEWoDHzeSMnJDmvMBNHJKGooMERXNDgSIhMH9mPBSHE=;
 b=nigASq+jD7L6DIG/h9GSUngAg/+SzBWEcpeSPvbv7FkKN0yU0uxF+G6F6jQo/V9iJ+j7+lpU/BNhWhqzKy5TyP7GqzO3xXiYIdgGNl4c6zDLaGZd5Gm6TSW/W6mmQKpNtM9oFYdnum23g5/azlgc9HE7mvDhwqs5/OEWhPyvNp438nyLQGYBSdNLSLp06twsqbRtyuUN3CEfzwzGkr6na4dVWtZHsyyZ7COR64bxkFhrja3WirWT5Pb1PVYTXwshzuz+Y/BHPf95bnqZl8N1nKcP1xuM8EqrYzGuTEaDsAIAiD8DRb8ogabhv7vfTvmxvKC8KiHyihBeH+ISfvPAOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEWoDHzeSMnJDmvMBNHJKGooMERXNDgSIhMH9mPBSHE=;
 b=ikp3hYHgyQwoIphlEPskQvKuD5uXGGq3EWa3XK8WfIZ+7v7fFMYxdpdxNMJb0rw2u2SVa/+UtJRyEeiCSYkE/9djPbCRoOiTupPec76mRpT6Ql0Vx/oIhlwetvmhXmrHnicF2q6vAPjyyrVyefNArH4cJQm2JydGZo38zv9Rb7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI1PR04MB7118.eurprd04.prod.outlook.com (2603:10a6:800:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 15:30:24 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::9294:43e2:390:2b6d]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::9294:43e2:390:2b6d%4]) with mapi id 15.20.6954.017; Wed, 1 Nov 2023
 15:30:24 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v2 1/1] Bluetooth: ISO: Reassociate a socket with an active BIS
Date:   Wed,  1 Nov 2023 17:30:15 +0200
Message-Id: <20231101153015.5541-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231101153015.5541-1-iulia.tanasescu@nxp.com>
References: <20231101153015.5541-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0050.eurprd04.prod.outlook.com
 (2603:10a6:802:2::21) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI1PR04MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: ed2d587c-29d6-4092-97ff-08dbdaef77c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ocU6PO/9pWURTV9gkYZuJFmNDoogSkEfoWrFltpOzsM0NAosRhmkVQwz7MEsyRcXB5KX395cO8h/9D8w+vhuZFaJxf/v8GeCLbL6sCAHDxYsZVdAmtMlnsAP6aH2WpsSacGakn34kO/oXxZcjaCE+dHu0FiU5BWwp2FuYuIdozxOo4qQceW84JT3+UOiRu8UovRy64vRKi0UuuefSBaVlvO1/+68iKLWFuxT6Q/uqwsGKsaZBgNUsG4BxA1z+3pArgmYXeuKbg/QJ/av9EBJQTzEIz4ZCOAD9VeSiebsYJBz3cWWCx1pl6asEwCr/Jr4kmdBUr/rmVCxC78kB1ex3RmSkMdkkDbdAb6nmUWe/Lk4oXLwZulHqGymJ78xoJBAVdhOA6NRhrakdllC6b1c07Ooxo8OaxBZIi1unbtWZI0uP+chBiOGXVDfZPj3Y0BOcPJrC5kbRM59/lUahiuy+3oFI8IwWcFZvqSbTATHUq4/sPA/omBme/VYh1Jub0dKNywzFm6B/cKGg8s0a1xzaxh3G24rVwmSQye2PJoBlKeFHuR1ZmingT/mgz84tBDN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(376002)(39860400002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(6666004)(6512007)(38100700002)(86362001)(6486002)(6506007)(478600001)(36756003)(2906002)(1076003)(2616005)(66476007)(66556008)(66946007)(26005)(316002)(6916009)(4326008)(5660300002)(8676002)(8936002)(83380400001)(44832011)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jVobpgxNqrbykTM5XdoQhbD8vCI5p+ZyrgZKsqY/4odyfozGAPCSMWrQq/rA?=
 =?us-ascii?Q?76/U4bxOAKlGBwdQI3RKFHlMDe1dYncJs7sDQUB0UFrVRqe840leDeP53ARK?=
 =?us-ascii?Q?id5DvhFfHvH34sQSCw8ZbpztZD6w2LXSP3Yl4aZe6egRBDw1zZFVD2i2NrL9?=
 =?us-ascii?Q?rHEBQr8Gd1DCBmInm+VWiUSuWpECctDnkmgUxswNUWgwwCQo7FHR0iNuUxfR?=
 =?us-ascii?Q?+Cc/uIr6puvpxu7ocPNkaq3ZHQTityjwP5sdhOPKxpdAhNmWCUMlff7TJNoW?=
 =?us-ascii?Q?cyvm88UiQEXMu+TWabW5tvhM7VgcaHmWMYr/kmsUfN0ZGScLxaMg9OG5+4Lz?=
 =?us-ascii?Q?U6Lll7TjC4uHwFxOggoAMUno8ntr8ZM8kvVj/QAyS/qR1K9qOyVGNLiQMLg8?=
 =?us-ascii?Q?sxvQcpCMt7NEIHLsQdZUdKxhjK4mg7kOjCx9WOuDD4UjhYc7pddJLtUC4dAh?=
 =?us-ascii?Q?SOxVTkCxKhGVoBp3luZoa6q7DvsViMxUFvyEtuE3UHRh1bWmixSchxP7Q3vy?=
 =?us-ascii?Q?8j0uV+eaErvRja6TGywEaOk6iUjNWTZ1IMa3wLyLwdpjco0U2Jd2bTIT93aQ?=
 =?us-ascii?Q?l94miX3B33SD03gjizVyHECj7NEr6KV98cE9WAgpLwLZB6z4APNgNi+l9M/x?=
 =?us-ascii?Q?RmD568ASu2UoltoI0ranZY90QfA6nKYYh+lrkBGxCg0rfPDYWmwD8qVPgCc9?=
 =?us-ascii?Q?lLrDHXN9AjaCxoXnWWG2pMlcfnqzNv7DBPoOTDvmjBdMgFlFm13pnhGej7B+?=
 =?us-ascii?Q?C0ILx17GABqWzYTgYGzT+D88xlajCSLS6GhGBjTN4AgHmHJwksxhso/X9qHd?=
 =?us-ascii?Q?XSvUdFNDDp1TA0zMvnW5frIteD0qOkYvu60mxh9kqknDEU6gi16HCmY3Bcqv?=
 =?us-ascii?Q?+a/j6QYe+SV91eIu0/TEZude1JywJa9ad2WvYzl9gFU0hWSKqUkx5/ySFvUr?=
 =?us-ascii?Q?+2sWG+xuT+Jy85UlZrWZBj/M2Ur2vrwZNLvMVJX3CFJNc2PLnxyHTXe+wcEq?=
 =?us-ascii?Q?ThtbF60um97nzl0nOshNViYzWHONwSgPBhEXsIzdoypvtpwobAFYbpORWtoQ?=
 =?us-ascii?Q?IpH0MVB9cnTBVccV0P+0GoDES6/WmrpAiyTPCYwcgo0ezJHfPmufXFqWrMeV?=
 =?us-ascii?Q?G2cXm+3nTvT+7FmzEISjhzDhNWroxZxje8b5bKRrE0VJIMU2zofc12/NtgER?=
 =?us-ascii?Q?xp8kzApDsVEnGM/5Iq7ajW53rTr0V2V103JsXiJ9eyyUzwafh/hNjfAd8taA?=
 =?us-ascii?Q?sLCet3AcVhQb8QijLrDJmoWjFCVv7f3V9Tm5PkxEQjICfkZhA/w6vAVrQsyL?=
 =?us-ascii?Q?aoDicxKDhnjPm6Dy3c8UW57fkFmSU7tr+JVc3kSwX2HSBrnOhgl/FS5/nbKp?=
 =?us-ascii?Q?vIHqtiYVTVWVlk0TxLgtxNIcXsN8YFipBKuhcwrNJPeqynfxEAZJKLzv5JOX?=
 =?us-ascii?Q?eIasv+5iU7XDQ5eq8ij3ZJD7hnPVksvxrEKknCj9f4ra5g9x8DUbVA789rFZ?=
 =?us-ascii?Q?JqFxTXadob/WzjCUNXzc1lL91mXX8e65a61yFjdtVCFOFg4P/oe78/aMcBEB?=
 =?us-ascii?Q?SJ7xpW6zOHB6c/kwrglIBFlGCWzXqPcP8gzyzQEfma4SjozLx3MXygKXiEpw?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2d587c-29d6-4092-97ff-08dbdaef77c9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 15:30:24.7011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UtYJ7U8ihNt31LKFGTurFvz4JR7Y2TqpU4//YlLy9j/90BoZG36eocXVupNfn8jVrAkpMQnZyl0N/MorK+FUDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7118
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
 include/net/bluetooth/hci_core.h | 24 ++++++++++
 net/bluetooth/hci_conn.c         | 32 ++++++++++++-
 net/bluetooth/iso.c              | 79 +++++++++++++++++++++++++++++++-
 3 files changed, 131 insertions(+), 4 deletions(-)

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
index 2cee330188ce..a09071059214 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1086,8 +1086,9 @@ static void hci_conn_cleanup_child(struct hci_conn *conn, u8 reason)
 			hci_conn_failed(conn, reason);
 		break;
 	case ISO_LINK:
-		if (conn->state != BT_CONNECTED &&
-		    !test_bit(HCI_CONN_CREATE_CIS, &conn->flags))
+		if ((conn->state != BT_CONNECTED &&
+		    !test_bit(HCI_CONN_CREATE_CIS, &conn->flags)) ||
+		    test_bit(HCI_CONN_BIG_CREATED, &conn->flags))
 			hci_conn_failed(conn, reason);
 		break;
 	}
@@ -2228,7 +2229,17 @@ struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst,
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
@@ -2256,6 +2267,20 @@ struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst,
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
 
@@ -2287,6 +2312,9 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 	if (IS_ERR(conn))
 		return conn;
 
+	if (conn->state == BT_CONNECTED)
+		return conn;
+
 	data.big = qos->bcast.big;
 	data.bis = qos->bcast.bis;
 
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index e01b6abe36fb..e49f00e8a6a6 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -574,19 +574,68 @@ static struct sock *iso_get_sock_listen(bdaddr_t *src, bdaddr_t *dst,
 			continue;
 
 		/* Exact match. */
-		if (!bacmp(&iso_pi(sk)->src, src))
+		if (!bacmp(&iso_pi(sk)->src, src)) {
+			sock_hold(sk);
 			break;
+		}
 
 		/* Closest match */
-		if (!bacmp(&iso_pi(sk)->src, BDADDR_ANY))
+		if (!bacmp(&iso_pi(sk)->src, BDADDR_ANY)) {
+			if (sk1)
+				sock_put(sk1);
+
 			sk1 = sk;
+			sock_hold(sk1);
+		}
 	}
 
+	if (sk && sk1)
+		sock_put(sk1);
+
 	read_unlock(&iso_sk_list.lock);
 
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
+		sock_hold(sk);
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
@@ -639,6 +688,28 @@ static void iso_sock_kill(struct sock *sk)
 
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
+			iso_sock_clear_timer(sk);
+			iso_chan_del(sk, bt_to_errno(hcon->abort_reason));
+			sock_put(bis_sk);
+			return;
+		}
+	}
+
 	sk->sk_state = BT_DISCONN;
 	iso_sock_set_timer(sk, ISO_DISCONN_TIMEOUT);
 	iso_conn_lock(iso_pi(sk)->conn);
@@ -1751,6 +1822,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 		parent->sk_data_ready(parent);
 
 		release_sock(parent);
+		sock_put(parent);
 	}
 }
 
@@ -1835,6 +1907,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 				if (err) {
 					bt_dev_err(hdev, "hci_le_big_create_sync: %d",
 						   err);
+					sock_put(sk);
 					sk = NULL;
 				}
 			}
@@ -1867,6 +1940,8 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags))
 		*flags |= HCI_PROTO_DEFER;
 
+	sock_put(sk);
+
 	return lm;
 }
 
-- 
2.39.2

