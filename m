Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE210219EF
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kk0yAWmw"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5321735
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 07:38:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWnVJYSKlozMOAGh3wG5LLV1819GXQBjd3UiIg2BPzRDM8hULWcxSZMHwYo+Pt5C/V1r92lHdj5bwYrvi1IVPr8zBw+wYOvYRpExxY54h+HDsGRhRvSuyA1+L39Ns4O45FmZlQHnteJWh5hEKmhEhstLZKyV5Qe97AO5Kxm83mspF8J1P9cFKoW1QiiJZqrsdhe+YAmI4R9x6DgG6hoo+GtmCnxueCKUVbpuOVg9r0hpcoK6je60NRelS8dx085FJ68xH4hWngFxxB6C6ZLmlXWOKsDju9SkoHTBa1ngEvkm68wNarWFzi1Pe9yW0ISD7a0DZpztGBrQsJyfC9jwTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEWoDHzeSMnJDmvMBNHJKGooMERXNDgSIhMH9mPBSHE=;
 b=dD7l420TJ6FX5KGqf1PNAjQxB55cImVI6oAa7rHTb/ZzOeg0J1/ZTZ/d3zhMYCzGBwbVEPex3m1nPvPGqsTtMGeA55yut7eK9/9VaUsuWuaYbFs47qYIzQQgSPVaBvrsfU3ysjjGiYoDWxnJP0pYyjyevwCBiny3AzvQIIB5vTx85myBs+0TwxAWl5iBHuQYOLWVg6YiOy4GcuncPyKC9HhkjnGRyBCrKhRTd5hV0St+GENILi24syLHjoRR65GY01k9lYqeI/pNXt2lAeEs8hgNM0DKm+Q5c3lMn05YCvyCXIDZRnkOsW7UTGRf3vtQY5awTVdrIs2t4kmp2KfY3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEWoDHzeSMnJDmvMBNHJKGooMERXNDgSIhMH9mPBSHE=;
 b=kk0yAWmwogBWr20NVBVnyRkTlzXeMGXNWnxFHPMpkFjup5tOnVNQNo+yUl8Es+kPBvFzxSoofYXduzNkucmXE6N6DXrV7ye0OhTkukt5AQdLFlSg0Xqgfif9wBK0URFYICUVkq4N8/2M9uncU8x66v9OnqBlrzl7o48JTMU0Azo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8498.eurprd04.prod.outlook.com (2603:10a6:20b:341::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Mon, 13 Nov
 2023 15:38:07 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::25a:e1cd:f957:6e7d]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::25a:e1cd:f957:6e7d%3]) with mapi id 15.20.7002.015; Mon, 13 Nov 2023
 15:38:07 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v2 1/1] Bluetooth: ISO: Reassociate a socket with an active BIS
Date: Mon, 13 Nov 2023 17:38:00 +0200
Message-Id: <20231113153800.3771-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231113153800.3771-1-iulia.tanasescu@nxp.com>
References: <20231113153800.3771-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0029.eurprd03.prod.outlook.com
 (2603:10a6:803:118::18) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d7f5ef9-27bd-497a-6f56-08dbe45e8884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wbC2Ma/m4zZTbmr4YscCD36UUEjIMzJp+06BtnVUaTHpheyxNg5u5ElC8KB6QDoBzHb0kNm1+OpiuCyAjbM3oAlQMjDvuzferFxOT9pjCr/mQLhMBI3WcTrdLrS4lvJDJvJCbeIJ0I+9KdXx1fF2ZkE5NKvLZX/vrHOS9How50DMyq/lzH9KI0cTPW2AKdN1R5vgIadPh35LGwzrEFji4Lv/9m44AgJrB+YR6Zd3OsZsjCTVS0r3O1mSpgoAp2RX2MSJEZwlFxywrBItR4KtHJtOzAesE4y8beh0w6oVqa89xOY8YZGjoFAzJdg1JRceUEEwU30EaoYKk8tV1pkVmiwNYayeB7a2CdggMLqmUylmEYR5VCMfoMTDLGJHuCcwWUxHhCGzVPpjey5Nc/YIcmp3rMQ8o+JAXgxnn7xhAP2PNs11Qr2oQBpMW1Cc/k0m5CLTPID1ksq2CMAUI7P0GUMi4AmpANwgQ7tjkynOwOmpsYKs/4tegSVor3PM4Vxc35dhejrJp/WKXi+skMImMo4VCWa7pY/WNzwcKzTcVqki42H/gSPYzRqgcOmL2lMV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(376002)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6506007)(44832011)(41300700001)(6486002)(478600001)(8676002)(4326008)(8936002)(6666004)(2616005)(5660300002)(6512007)(26005)(1076003)(6916009)(316002)(66476007)(66946007)(66556008)(2906002)(83380400001)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Yu2dz+0yFIu3D3IZSD+pWnuCyXJiKEy5aC32SYK/DdRMnMt+G1sgj/bx856?=
 =?us-ascii?Q?pJKrOO2kEqqYvwV4oO82XP5WU4fEGEFa/w/KCqzFORMhiPLPx4wkVxAUSHCJ?=
 =?us-ascii?Q?9F+gWZHmmqw8jEa4P0OQXFwIyQoS93ofymI7xib2DZrMTpgwfkleHb2cCONm?=
 =?us-ascii?Q?twksCfYqSLm3cFJHNP3e6u6z4NDwoMemNqLSuWjUiioR9uJxdvHGMsrV9755?=
 =?us-ascii?Q?av8dIblvTMhij1iQ3NEccdHMhVz0mZbpk77GFCzXgXgpkvdOxocRj/ZGHgCE?=
 =?us-ascii?Q?8BYmTNBOfP8fJ3ZDK+/DJxFMEVSi+uNMiBar+B5KwWyhO/4L0UQT7eV9VqS1?=
 =?us-ascii?Q?oJrav1RsIjFSXSuBJiDaMv/2vTFnHpQGq4zo0lYRod9PuCOL1z3H/lRDiPoy?=
 =?us-ascii?Q?ftW5afoqn5+W87XaaXIUfI9jkt1CKDmJqJGMADrCyuN2yQ9BHkoCMpES/05x?=
 =?us-ascii?Q?Bhc72fhtXVDTvTGcngWuFh58sOlpdYftWa8bKX3oGnMHCo/qB8OU6VM8tCN8?=
 =?us-ascii?Q?oFceELROWMHKUlDkqLDXcyBYhqsIOnYwMUu8UobkGkHfr/74s4HDDFar2IiT?=
 =?us-ascii?Q?RrYyiHQb8nYxhwp72mBacCnjHzfLp/UC8qdOZa0IZO9ZXGwBDDPLYXQ9NGRb?=
 =?us-ascii?Q?uNZrhaINJV+bMWjwQLsA5qvNge2IzWrU8+DPYkgdVRRRFsy7yOs3hGGEmpRs?=
 =?us-ascii?Q?p6quqj+vrUoWgy9AkDKE0OKnrHu7nyhtiA8etlp7zeXKzj5OFXBWUV79agsm?=
 =?us-ascii?Q?Rf3bNJlvrsfkf+XeFtNWgTVtkF4e/59vsp2+XhDR3HyqhXC2S5MBUxaB9InW?=
 =?us-ascii?Q?H78GPueefRU9C8HGiYJTMSCtvo1ipjc0BdQp5AWzVRrnTqASHtZc+ZTwH9jL?=
 =?us-ascii?Q?E2fnpqqjJxHuh3hI2Gk2ha0WLotWhSNaoGgS8xVrYIZSHMg619/ko5vNMrrk?=
 =?us-ascii?Q?izuNRzWh/ABHrbHOKA5qaQyMLsWVQog2kEayHPWINd92CH+6wMi0Jro4g7MF?=
 =?us-ascii?Q?2xDnn+x+zhaDkgsBRYmdXWUXVvjERnNZLcGjitE28orPTTypQFaFC5rWYOA/?=
 =?us-ascii?Q?j4qxNB6QJqHe11FdvA1ih0yB6VT4FUAVcRywQxL8qlNTMAVHxdlzCvpy9Xf6?=
 =?us-ascii?Q?96Zp8YO9OIKWTqTf+8VwKeYKihLDk9CPIN0IYlXaqX1fHEiHyOWnhh34KbQr?=
 =?us-ascii?Q?tj8LVqMZmbOdaGFFy64GhWs68CMXfx/IdM3N94hVhtjkXa3EarTwAJd04fzD?=
 =?us-ascii?Q?dxW/L/VfliTxphz9yEniQKGD1441/7M5dWdMYvNzAy+tx7lTvCBSwg+PjPQ+?=
 =?us-ascii?Q?fwDBaMpPXhTtyPydqoIGx6rcX4vNGVzaKyQbeh9d3gqrQbho4q50p0PZ7SaG?=
 =?us-ascii?Q?BlDZW5dRVk7g+LNMxkD06heStHRnslXyj+JGqVwdRAGYAVzNYpPx23Le4in6?=
 =?us-ascii?Q?qeYCaSM1AggvZUpGIVByq1NzibkTb8HuMbHMgkK/p4XnUdJEiE1PuB3NJxkU?=
 =?us-ascii?Q?OZ9AwB7oom0F4LdI5bzJc3if0BZwkERfK3KaCzOhcgLxlKU7OZPQVnDV5Uta?=
 =?us-ascii?Q?u0BXnse6nNYwLpp8pS5rnKYrc3IJwziDL6mpYrRGNMs0ZfKE3u0kgkTreQiE?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7f5ef9-27bd-497a-6f56-08dbe45e8884
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 15:38:07.2418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i36HZohQWfFD8MYSzzb4TAHRkqsgx5MP2PRflrCVP9+8XT/KC6CZA55xOYVwici3x665dKvYmQY2xKgA6jHiag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8498

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

