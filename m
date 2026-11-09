Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794244725;
	b=vwvMOudxcqg6/q8PEv5xWbSdPGZI3tFD4zFJrWwRJAdBeBFKFoOdiCm5OrPmCUJEO+Fy
	 FmhUL1tbUxFgJLfuKDY44Hu44ri1OuTHn6nBjRoVCjY3MWNWZlQ38ZHoFoV9pTxXeI/eW
	 vbGKJpuDw5gcluedCfBh7x4Zkr86Z5d2B62hDkBGA8p7ANiuvmfrMy/hpVT6bWePNXT0u
	 K0nvBXrWJiGflgUTMSsUo3Uq9Sm1x8+uFDktaEgCgxKO/xnamFAjvF70d6mpGqb3Byw4o
	 Ys8NNzEH6mONp5vLY1zG/kkKPr2b4gmlUvE6TT291XHyHCvdMmXSYosxXheLnJ9+wlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vi3phFEGSJDcDOT2cvVwJQBUpAnn4pBBXbu4Fu8OAxY=;
	b=Dzw5fj9J27N4y3e1dD+EW6yZbqBfzSp3+l+gvOthYPlcpNGphZgesUqWOo9PIOmUCkqg
	 jYhxVSSM/PRQAHIv57WJFRtndp8XfX5zqYZeUTtAQq2OH0G4IXdhOotv+/dsk3FGCMrf+
	 kEu3nl60X3AybMctTlj3pxSgy6xOWyo/D/PWcTuMd5NgpPoullGE8OxRcHw5dgeGVcPnW
	 Wbe1jBB/Jq1hrYVonxdAalikTeGiUPPQ7BX7zbuamuSx/jpYT44H1t/tg/pzkgfW7qD7p
	 aKrtTL6Alkz6kqt0Hkpfvx9mtmifhyPDCZevUobi47QN2GWQEsLlidcewwAsKyXCS5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=apsK3svj;
	arc=none smtp.remote-ip=209.85.222.51
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54BD606EEB8
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 17:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E54BD606EEB8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=apsK3svj
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-99ac154431bso154737241.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 09:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794244724; x=1794849524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vi3phFEGSJDcDOT2cvVwJQBUpAnn4pBBXbu4Fu8OAxY=;
        b=apsK3svjVZ8EgKDXYOayFVUvjIlJFCyE9ndmJuYB9VhY4XGHpfUGCcr9m6NzuJEM9t
         5BTL4VEgvrRs7hrjgu2ROHa1atXxJ+20d+14fcVXfA8nYHewxv3FDS0RdLMqJURj1gsu
         RSq8WyE14bRsjwDsX432wmODyjTm+RoRsn3VP78P9K3DNM7fk1ZyrLeo9N35h6QsanU4
         CVcEZWPH3Sw8pvRJ4tjoAbaNDvHYXi7dNzlHsS30RW0U9rh/1+XBX49GukZMxTadAsmC
         GtnaVeAOOQ0aWj469As958Por9rNz3CUoQBgNCYYTd2w5eCtRwIdIquAXHL7me48Z4Xk
         Dk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794244724; x=1794849524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vi3phFEGSJDcDOT2cvVwJQBUpAnn4pBBXbu4Fu8OAxY=;
        b=jvjw8YsNKe7S0gwcDNrFAkHRQ0F8WoQhugKwwb+oAlKFFfnDRbHIWaSj23X5ktLeSO
         0TZ6eQxUTgQITghUzLpD88bVeMWuOAx3NL1ilHbCaNYbQ5jDaQ0271EnB/jBf6MFhfRX
         4limTMJC4U7VU/lwl46yHyQMr9+fiSBCndg1BMN6XGjFEKAmTUr1da3wBe2QmQndwNQ7
         ez9dFdVcmjBxdTGsM64sXZuuBBhF5EC+Ez4OAdUB8Bkgxcuh/UrkBvCnlA9MmRkvnexf
         iSeEmeMW0sgyy09aX78jVthrErpLqToXTKls+JvYsv/doVxvPMoqHlH6/0GrcMVXthD2
         hdSA==
X-Gm-Message-State: APuU4Z+FIXuSvkeeQ8+84lepv1ZhViK19wSZkNWsIVjFLBTw2NEdNqkT
	XDMkEvpPjBwWKDbMX3y9JCFqzfziXXxM86MHEpKDypury+VdbWJMDDNKxBvveQ==
X-Gm-Gg: AYBFou1kCqPn4VdtLndugwxm4JbGRoxO1djQvNQdJH7EciOqNmQJRHqTapjY+pUtamy
	xC0efweWZcAsIDaQjihDtG96w11ZtsWKbm6BaoKof5Rj+jO6UHQJ8TfkKiOn59axQkyj566Gcqe
	FFdnMHbcQO1njiTr/kCcKDY4tQOFQccDBd1ZOlrp4lGNKtsWPhMzUMpFbrze6aTonJUK+r6Td2S
	IPgODJqtSXIEEPrHyDx7ppVOe2kbOv7F+EygvGJ9d7hqpVWpow9HGotV5iRlaxPb9uA2Y1Mzu8v
	QD/l/cfOnE0up8h3nIZqo/fyUqIet3hv9/q9riDjr8LQvFlNj7Bpisvy3KUGygcTTPOvEhz+mFU
	5ljr3ExeQXpm+zMue4INGe3jdc1UBqk0OAgQ6BJIkbHXs+3v+L9v9VGcJX4oxaKXqeQGE5qZYSJ
	z42b5IJ6QSB+TzcZShssVnjD0yYy0iP4KRpipGat5GxqKMyawARfUJKWF+Ub5e/GY+WLHwOKYm7
	FOVyOojzcxy2b/Bk9kzL7AdSAVUpUl5B1p6coDqwElv6zvV2f5k5LF0mXlwYELZGdrUp+jzYhPq
	rc6/WwSeeSFCEOt2DMqg9zxod34gQjel/G8o4ScDFzQMc5yyof9+I1K5IlrA2jjByGPuD9+uMt6
	ElQiC3G+pDTTSFVB8CfUakFAaWaXxBmb7vD206T23QGIg1c3QdyTBl2NQyOxQwckz8jPBGBT9L3
	mmZmY=
X-Received: by 2002:a05:6122:219f:b0:5c9:a60b:e5d6 with SMTP id 71dfb90a1353d-5ece725e675mr1924066e0c.16.1794244723447;
        Mon, 09 Nov 2026 09:18:43 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c5b2233sm21944e0c.10.2026.11.09.09.18.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 09:18:43 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v11 2/6] Bluetooth: ISO: Add extended QoS with the HDT rates
Date: Mon,  9 Nov 2026 12:18:34 -0500
Message-ID: <20261109171838.1592267-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109171838.1592267-1-luiz.dentz@gmail.com>
References: <20261109171838.1592267-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add struct bt_iso_qos_ext, an extensible version of struct bt_iso_qos,
so new QoS fields can be added without defining a new socket option or
struct each time. It starts with two fields:

 - version tells which fields are valid, so later versions can add
   fields while applications built for an earlier version keep working.
 - type tells which member of the union is in use, unicast or
   broadcast. The QoS is usually set before bind() or connect(), when
   the socket can't tell which one it was given, so without type the
   two could only grow together. With it, each can be extended on its
   own by adding fields at its end, which is also why the union is the
   last member.

BT_ISO_QOS_ANY leaves the type to connect() or listen(), which set it.
That works for version 1 since its unicast fields are a prefix of the
broadcast ones, and is what struct bt_iso_qos uses. A type that doesn't
match how the socket is used makes connect() or listen() fail with
-EINVAL, or setsockopt() on a socket that already has a connection,
such as with deferred setup or a PA sync.

Version 1 adds the rates of each direction, BT_ISO_HDT_RATE_*, so
userspace can select the HDT rates of a CIS or BIS along with
BT_ISO_PHY_HDT; 0 selects every rate the controller supports.

BT_ISO_QOS accepts either struct: the length of struct bt_iso_qos
selects it, as before, and any other length must carry struct
bt_iso_qos_ext of a known version and type. The struct is copied field
by field, so its padding is zeroed. Reading BT_ISO_QOS with a buffer
shorter than struct bt_iso_qos_ext returns struct bt_iso_qos, so
existing userspace is not affected; otherwise the version and type in
use are reported, including for connections set up by the controller.

The ISO sockets keep the extended form internally, so the rates are
passed to LE Set CIG Parameters v2 and LE Create BIG v2, and reported
back from LE CIS Established v3 and LE Create BIG Complete v2.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h |  83 ++++++++++
 include/net/bluetooth/hci_core.h  |  15 +-
 include/net/bluetooth/hci_sync.h  |   2 +-
 net/bluetooth/hci_conn.c          |  34 ++--
 net/bluetooth/hci_event.c         |  20 ++-
 net/bluetooth/hci_sync.c          |  32 ++--
 net/bluetooth/iso.c               | 262 ++++++++++++++++++++++++++++--
 7 files changed, 393 insertions(+), 55 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index fbedd1ebd051..d59407349b3e 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -235,6 +235,89 @@ struct bt_iso_qos {
 	};
 };
 
+/* Extended ISO QoS, set and read with BT_ISO_QOS.
+ *
+ * The option length tells it apart from struct bt_iso_qos, which is kept for
+ * existing applications. New fields are added by extending this struct rather
+ * than by adding new socket options or structs:
+ *
+ * - version tells which fields are valid, so later versions can add fields
+ *   while older applications keep working with the fields they know.
+ * - type tells which member of the union is in use. The QoS is usually set
+ *   before bind() or connect(), so the socket can't tell unicast from
+ *   broadcast at that point. With type, struct bt_iso_ucast_qos_ext and
+ *   struct bt_iso_bcast_qos_ext can each grow on their own, by adding fields
+ *   at their end, without the kernel having to guess which one it was given.
+ *   For that the union shall remain the last member.
+ *
+ * BT_ISO_QOS_ANY leaves the type to be set by connect() or listen(), which is
+ * possible with version 1 since its unicast fields are a prefix of the
+ * broadcast ones. A type that doesn't match how the socket is used makes
+ * connect() or listen() fail with -EINVAL, or setsockopt() on a socket that
+ * already has a connection, such as with deferred setup. getsockopt() reports
+ * the type in use once it is known.
+ *
+ * Version 1 adds the HDT rates of each direction, see BT_ISO_HDT_RATE_*, used
+ * when the PHY is BT_ISO_PHY_HDT; 0 means every rate the controller supports.
+ */
+#define BT_ISO_QOS_VERSION_1	0x0001
+
+#define BT_ISO_QOS_ANY		0x0000
+#define BT_ISO_QOS_UCAST	0x0001
+#define BT_ISO_QOS_BCAST	0x0002
+
+#define BT_ISO_HDT_RATE_2M	BIT(0)
+#define BT_ISO_HDT_RATE_3M	BIT(1)
+#define BT_ISO_HDT_RATE_4M	BIT(2)
+#define BT_ISO_HDT_RATE_6M	BIT(3)
+#define BT_ISO_HDT_RATE_7_5M	BIT(4)
+
+struct bt_iso_io_qos_ext {
+	__u32 interval;
+	__u16 latency;
+	__u16 sdu;
+	__u8  phys;
+	__u8  rtn;
+	__u16 rates;
+};
+
+struct bt_iso_ucast_qos_ext {
+	__u8  cig;
+	__u8  cis;
+	__u8  sca;
+	__u8  packing;
+	__u8  framing;
+	struct bt_iso_io_qos_ext in;
+	struct bt_iso_io_qos_ext out;
+};
+
+struct bt_iso_bcast_qos_ext {
+	__u8  big;
+	__u8  bis;
+	__u8  sync_factor;
+	__u8  packing;
+	__u8  framing;
+	struct bt_iso_io_qos_ext in;
+	struct bt_iso_io_qos_ext out;
+	__u8  encryption;
+	__u8  bcode[16];
+	__u8  options;
+	__u16 skip;
+	__u16 sync_timeout;
+	__u8  sync_cte_type;
+	__u8  mse;
+	__u16 timeout;
+};
+
+struct bt_iso_qos_ext {
+	__u16 version;
+	__u16 type;
+	union {	/* Shall be the last member */
+		struct bt_iso_ucast_qos_ext ucast;
+		struct bt_iso_bcast_qos_ext bcast;
+	};
+};
+
 #define BT_ISO_PHY_1M		BIT(0)
 #define BT_ISO_PHY_2M		BIT(1)
 #define BT_ISO_PHY_CODED	BIT(2)
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 689e2a1266b4..1158ec218e1a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -797,7 +797,7 @@ struct hci_conn {
 	__s8		rssi;
 	__s8		tx_power;
 	__s8		max_tx_power;
-	struct bt_iso_qos iso_qos;
+	struct bt_iso_qos_ext iso_qos;
 	__u8		num_bis;
 	__u8		bis[HCI_MAX_ISO_BIS];
 
@@ -1678,23 +1678,24 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 				 __u16 setting, struct bt_codec *codec,
 				 u16 timeout);
 struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
-			      __u8 dst_type, struct bt_iso_qos *qos,
+			      __u8 dst_type, struct bt_iso_qos_ext *qos,
 			      u16 timeout);
 struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
-			      struct bt_iso_qos *qos,
+			      struct bt_iso_qos_ext *qos,
 			      __u8 base_len, __u8 *base, u16 timeout);
 int hci_past_bis(struct hci_conn *conn, bdaddr_t *dst, __u8 dst_type);
 struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
-				 __u8 dst_type, struct bt_iso_qos *qos,
+				 __u8 dst_type, struct bt_iso_qos_ext *qos,
 				 u16 timeout);
 struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 				 __u8 dst_type, __u8 sid,
-				 struct bt_iso_qos *qos,
+				 struct bt_iso_qos_ext *qos,
 				 __u8 data_len, __u8 *data, u16 timeout);
 struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
-		       __u8 dst_type, __u8 sid, struct bt_iso_qos *qos);
+				    __u8 dst_type, __u8 sid,
+				    struct bt_iso_qos_ext *qos);
 int hci_conn_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
-			     struct bt_iso_qos *qos, __u16 sync_handle,
+			     struct bt_iso_qos_ext *qos, __u16 sync_handle,
 			     __u8 num_bis, __u8 bis[]);
 int hci_conn_check_link_mode(struct hci_conn *conn);
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index a24f6a84a447..aa12250eca52 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -195,5 +195,5 @@ int hci_le_read_remote_features(struct hci_conn *conn);
 int hci_acl_change_pkt_type(struct hci_conn *conn, u16 pkt_type);
 int hci_le_set_phy(struct hci_conn *conn, u8 tx_phys, u8 rx_phys, u16 phy_opts);
 int hci_le_set_cig_params_sync(struct hci_dev *hdev, u8 cig_id);
-int hci_le_create_big_sync(struct hci_conn *conn, struct bt_iso_qos *qos,
+int hci_le_create_big_sync(struct hci_conn *conn, struct bt_iso_qos_ext *qos,
 			   u8 num_bis);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 83aed078032d..64d4cb940aaa 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1120,6 +1120,12 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type,
 			conn->cleanup = cis_cleanup;
 
 		conn->mtu = hdev->iso_mtu;
+
+		/* Set for connections the controller sets up, such as an
+		 * incoming CIS, sockets replace it with their own QoS.
+		 */
+		conn->iso_qos.version = BT_ISO_QOS_VERSION_1;
+		conn->iso_qos.type = BT_ISO_QOS_UCAST;
 		break;
 	case PA_LINK:
 	case BIS_LINK:
@@ -1127,6 +1133,8 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type,
 		hci_copy_identity_address(hdev, &conn->src, &conn->src_type);
 		conn->cleanup = bis_cleanup;
 		conn->mtu = hdev->iso_mtu;
+		conn->iso_qos.version = BT_ISO_QOS_VERSION_1;
+		conn->iso_qos.type = BT_ISO_QOS_BCAST;
 		break;
 	case SCO_LINK:
 		if (lmp_esco_capable(hdev))
@@ -1637,7 +1645,7 @@ static int hci_explicit_conn_params_set(struct hci_dev *hdev,
 	return 0;
 }
 
-static int qos_set_big(struct hci_dev *hdev, struct bt_iso_qos *qos)
+static int qos_set_big(struct hci_dev *hdev, struct bt_iso_qos_ext *qos)
 {
 	struct hci_conn *conn;
 	u8  big;
@@ -1661,7 +1669,7 @@ static int qos_set_big(struct hci_dev *hdev, struct bt_iso_qos *qos)
 	return 0;
 }
 
-static int qos_set_bis(struct hci_dev *hdev, struct bt_iso_qos *qos)
+static int qos_set_bis(struct hci_dev *hdev, struct bt_iso_qos_ext *qos)
 {
 	struct hci_conn *conn;
 	u8  bis;
@@ -1703,7 +1711,7 @@ static int qos_set_bis(struct hci_dev *hdev, struct bt_iso_qos *qos)
 
 /* This function requires the caller holds hdev->lock */
 static struct hci_conn *hci_add_bis(struct hci_dev *hdev, bdaddr_t *dst,
-				    __u8 sid, struct bt_iso_qos *qos,
+				    __u8 sid, struct bt_iso_qos_ext *qos,
 				    __u8 base_len, __u8 *base, u16 timeout)
 {
 	struct hci_conn *conn;
@@ -1938,7 +1946,7 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	return sco;
 }
 
-static int hci_le_create_big(struct hci_conn *conn, struct bt_iso_qos *qos)
+static int hci_le_create_big(struct hci_conn *conn, struct bt_iso_qos_ext *qos)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct iso_list_data data;
@@ -1961,7 +1969,7 @@ static int set_cig_params_sync(struct hci_dev *hdev, void *data)
 	return hci_le_set_cig_params_sync(hdev, cig_id);
 }
 
-static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
+static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos_ext *qos)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct iso_list_data data;
@@ -2037,7 +2045,7 @@ static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
 }
 
 struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
-			      __u8 dst_type, struct bt_iso_qos *qos,
+			      __u8 dst_type, struct bt_iso_qos_ext *qos,
 			      u16 timeout)
 {
 	struct hci_conn *cis;
@@ -2180,7 +2188,7 @@ int hci_le_create_cis_pending(struct hci_dev *hdev)
 }
 
 static void hci_iso_qos_setup(struct hci_dev *hdev, struct hci_conn *conn,
-			      struct bt_iso_io_qos *qos, __u8 phys)
+			      struct bt_iso_io_qos_ext *qos, __u8 phys)
 {
 	/* Only set MTU if PHY is enabled */
 	if (!qos->sdu && qos->phys)
@@ -2205,7 +2213,7 @@ static void hci_iso_qos_setup(struct hci_dev *hdev, struct hci_conn *conn,
 static int create_big_sync(struct hci_dev *hdev, void *data)
 {
 	struct hci_conn *conn = data;
-	struct bt_iso_qos *qos = &conn->iso_qos;
+	struct bt_iso_qos_ext *qos = &conn->iso_qos;
 	u16 interval, sync_interval = 0;
 	u32 flags = 0;
 	int err;
@@ -2234,7 +2242,7 @@ static int create_big_sync(struct hci_dev *hdev, void *data)
 
 struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
 				    __u8 dst_type, __u8 sid,
-				    struct bt_iso_qos *qos)
+				    struct bt_iso_qos_ext *qos)
 {
 	struct hci_conn *conn;
 
@@ -2257,7 +2265,7 @@ struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
 }
 
 int hci_conn_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
-			     struct bt_iso_qos *qos, __u16 sync_handle,
+			     struct bt_iso_qos_ext *qos, __u16 sync_handle,
 			     __u8 num_bis, __u8 bis[])
 {
 	int err;
@@ -2308,7 +2316,7 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
 }
 
 struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
-			      struct bt_iso_qos *qos,
+			      struct bt_iso_qos_ext *qos,
 			      __u8 base_len, __u8 *base, u16 timeout)
 {
 	struct hci_conn *conn;
@@ -2396,7 +2404,7 @@ static void bis_mark_per_adv(struct hci_conn *conn, void *data)
 
 struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 				 __u8 dst_type, __u8 sid,
-				 struct bt_iso_qos *qos,
+				 struct bt_iso_qos_ext *qos,
 				 __u8 base_len, __u8 *base, u16 timeout)
 {
 	struct hci_conn *conn;
@@ -2447,7 +2455,7 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 }
 
 struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
-				 __u8 dst_type, struct bt_iso_qos *qos,
+				 __u8 dst_type, struct bt_iso_qos_ext *qos,
 				 u16 timeout)
 {
 	struct hci_conn *le;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cdf010a2c37f..f7297179e69c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7389,7 +7389,7 @@ static void hci_le_cis_established_evt(struct hci_dev *hdev, void *data,
 {
 	struct hci_evt_le_cis_established *ev = data;
 	struct hci_conn *conn;
-	struct bt_iso_qos *qos;
+	struct bt_iso_qos_ext *qos;
 	bool pending = false;
 	u16 handle = __le16_to_cpu(ev->handle);
 	u32 c_sdu_interval, p_sdu_interval;
@@ -7415,6 +7415,10 @@ static void hci_le_cis_established_evt(struct hci_dev *hdev, void *data,
 
 	qos = &conn->iso_qos;
 
+	/* This version of the event doesn't report the HDT rates */
+	qos->ucast.in.rates = 0x0000;
+	qos->ucast.out.rates = 0x0000;
+
 	pending = test_and_clear_bit(HCI_CONN_CREATE_CIS, conn->flags);
 
 	/* BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 6, Part G
@@ -7564,7 +7568,7 @@ static int hci_iso_term_big_sync(struct hci_dev *hdev, void *data)
 
 static void hci_le_create_big_complete(struct hci_dev *hdev, u8 status,
 				       u8 handle, u8 num_bis,
-				       const __le16 *bis_handle)
+				       const __le16 *bis_handle, u16 rates)
 {
 	struct hci_conn *conn;
 	__u8 i = 0;
@@ -7606,6 +7610,7 @@ static void hci_le_create_big_complete(struct hci_dev *hdev, u8 status,
 		}
 
 		conn->state = BT_CONNECTED;
+		conn->iso_qos.bcast.out.rates = rates;
 		set_bit(HCI_CONN_BIG_CREATED, conn->flags);
 		hci_debugfs_create_conn(conn);
 		hci_conn_add_sysfs(conn);
@@ -7639,7 +7644,7 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 		return;
 
 	hci_le_create_big_complete(hdev, ev->status, ev->handle, ev->num_bis,
-				   ev->bis_handle);
+				   ev->bis_handle, 0x0000);
 }
 
 static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
@@ -7895,7 +7900,7 @@ static void hci_le_cis_established_evt_v3(struct hci_dev *hdev, void *data,
 {
 	struct hci_evt_le_cis_established_v3 *ev = data;
 	struct hci_conn *conn;
-	struct bt_iso_qos *qos;
+	struct bt_iso_qos_ext *qos;
 	bool pending = false;
 	u16 handle = __le16_to_cpu(ev->handle);
 	u32 c_sdu_interval, p_sdu_interval;
@@ -7941,6 +7946,8 @@ static void hci_le_cis_established_evt_v3(struct hci_dev *hdev, void *data,
 		qos->ucast.out.sdu = ev->p_bn ? le16_to_cpu(ev->p_sdu) : 0;
 		qos->ucast.in.phys = le_phy_qos(ev->c_phy);
 		qos->ucast.out.phys = le_phy_qos(ev->p_phy);
+		qos->ucast.in.rates = le16_to_cpu(ev->c_rates);
+		qos->ucast.out.rates = le16_to_cpu(ev->p_rates);
 		break;
 	case HCI_ROLE_MASTER:
 		qos->ucast.in.interval = p_sdu_interval;
@@ -7956,6 +7963,8 @@ static void hci_le_cis_established_evt_v3(struct hci_dev *hdev, void *data,
 		qos->ucast.in.sdu = ev->p_bn ? le16_to_cpu(ev->p_sdu) : 0;
 		qos->ucast.out.phys = le_phy_qos(ev->c_phy);
 		qos->ucast.in.phys = le_phy_qos(ev->p_phy);
+		qos->ucast.out.rates = le16_to_cpu(ev->c_rates);
+		qos->ucast.in.rates = le16_to_cpu(ev->p_rates);
 		break;
 	}
 
@@ -7990,7 +7999,8 @@ static void hci_le_create_big_complete_v2_evt(struct hci_dev *hdev, void *data,
 		return;
 
 	hci_le_create_big_complete(hdev, ev->status, ev->handle, ev->num_bis,
-				   ev->bis_handle);
+				   ev->bis_handle,
+				   le16_to_cpu(ev->rates));
 }
 
 #define HCI_LE_EV_VL(_op, _func, _min_len, _max_len) \
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 9a5b198fa0c5..a01eea7c2032 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3187,7 +3187,7 @@ static int hci_le_set_ext_scan_param_sync(struct hci_dev *hdev, u8 type,
 			conn = hci_conn_hash_lookup_ba(hdev, PA_LINK,
 						       &bdaddr);
 			if (conn) {
-				struct bt_iso_qos *qos = &conn->iso_qos;
+				struct bt_iso_qos_ext *qos = &conn->iso_qos;
 
 				if (qos->bcast.in.phys & BT_ISO_PHY_1M ||
 				    qos->bcast.in.phys & BT_ISO_PHY_2M) {
@@ -7926,7 +7926,7 @@ static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 }
 
 static int hci_le_past_params_sync(struct hci_dev *hdev, struct hci_conn *conn,
-				   u16 acl_handle, struct bt_iso_qos *qos)
+				   u16 acl_handle, struct bt_iso_qos_ext *qos)
 {
 	struct hci_cp_le_past_params cp;
 	int err;
@@ -7960,7 +7960,7 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 {
 	struct hci_cp_le_pa_create_sync cp;
 	struct hci_conn *conn = data, *le;
-	struct bt_iso_qos *qos = &conn->iso_qos;
+	struct bt_iso_qos_ext *qos = &conn->iso_qos;
 	int err;
 
 	if (!hci_conn_valid(hdev, conn))
@@ -8101,7 +8101,7 @@ static int hci_le_big_create_sync(struct hci_dev *hdev, void *data)
 	DEFINE_FLEX(struct hci_cp_le_big_create_sync, cp, bis, num_bis,
 		    HCI_MAX_ISO_BIS);
 	struct hci_conn *conn = data;
-	struct bt_iso_qos *qos = &conn->iso_qos;
+	struct bt_iso_qos_ext *qos = &conn->iso_qos;
 	int err;
 
 	if (!hci_conn_valid(hdev, conn))
@@ -8429,7 +8429,7 @@ static int hci_le_set_cig_params_v2_sync(struct hci_dev *hdev, u8 cig_id)
 	DEFINE_FLEX(struct hci_cp_le_set_cig_params_v2, pdu, cis, num_cis,
 		    HCI_LE_CIG_PARAMS_V2_MAX_CIS);
 	struct hci_conn *conn;
-	struct bt_iso_qos *qos;
+	struct bt_iso_qos_ext *qos;
 	u8 aux_num_cis = 0;
 	u8 cis_id;
 
@@ -8476,11 +8476,16 @@ static int hci_le_set_cig_params_v2_sync(struct hci_dev *hdev, u8 cig_id)
 		cis->c_rtn  = qos->ucast.out.rtn;
 		cis->p_rtn  = qos->ucast.in.rtn;
 
+		/* Use the rates of each direction, or all the HDT rates the
+		 * controller supports if none were set.
+		 */
 		if (cis->c_phys & HCI_LE_SET_PHY_HDT)
-			cis->c_hdt_rates = cpu_to_le16(hci_hdt_tx_rates(hdev));
+			cis->c_hdt_rates = cpu_to_le16(qos->ucast.out.rates ? :
+						       hci_hdt_tx_rates(hdev));
 
 		if (cis->p_phys & HCI_LE_SET_PHY_HDT)
-			cis->p_hdt_rates = cpu_to_le16(hci_hdt_rx_rates(hdev));
+			cis->p_hdt_rates = cpu_to_le16(qos->ucast.in.rates ? :
+						       hci_hdt_rx_rates(hdev));
 	}
 	pdu->num_cis = aux_num_cis;
 
@@ -8499,7 +8504,7 @@ int hci_le_set_cig_params_sync(struct hci_dev *hdev, u8 cig_id)
 {
 	DEFINE_FLEX(struct hci_cp_le_set_cig_params, pdu, cis, num_cis, 0x1f);
 	struct hci_conn *conn;
-	struct bt_iso_qos *qos;
+	struct bt_iso_qos_ext *qos;
 	u8 aux_num_cis = 0;
 	u8 cis_id;
 
@@ -8562,7 +8567,7 @@ int hci_le_set_cig_params_sync(struct hci_dev *hdev, u8 cig_id)
 }
 
 static int hci_le_create_big_v2_sync(struct hci_conn *conn,
-				     struct bt_iso_qos *qos, u8 num_bis)
+				     struct bt_iso_qos_ext *qos, u8 num_bis)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_le_create_big_v2 cp;
@@ -8581,15 +8586,18 @@ static int hci_le_create_big_v2_sync(struct hci_conn *conn,
 	cp.bis.encryption = qos->bcast.encryption;
 	memcpy(cp.bis.bcode, qos->bcast.bcode, sizeof(cp.bis.bcode));
 
-	/* Check if HDT PHY is set then enable HDT supported rates */
+	/* Use the rates set, or all the HDT rates the controller supports if
+	 * none were set.
+	 */
 	if (cp.bis.phys & HCI_LE_SET_PHY_HDT)
-		cp.bis.hdt_rates = cpu_to_le16(hci_hdt_tx_rates(hdev));
+		cp.bis.hdt_rates = cpu_to_le16(qos->bcast.out.rates ? :
+					       hci_hdt_tx_rates(hdev));
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_CREATE_BIG_V2,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
 
-int hci_le_create_big_sync(struct hci_conn *conn, struct bt_iso_qos *qos,
+int hci_le_create_big_sync(struct hci_conn *conn, struct bt_iso_qos_ext *qos,
 			   u8 num_bis)
 {
 	struct hci_dev *hdev = conn->hdev;
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index cc6c8b7ba027..e945bd2b33e5 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -75,7 +75,7 @@ struct iso_pinfo {
 	__u8			bc_bis[ISO_MAX_NUM_BIS];
 	__u16			sync_handle;
 	unsigned long		flags;
-	struct bt_iso_qos	qos;
+	struct bt_iso_qos_ext	qos;
 	bool			qos_user_set;
 	__u8			base_len;
 	__u8			base[BASE_MAX_LENGTH];
@@ -83,10 +83,23 @@ struct iso_pinfo {
 	struct delayed_work	timeout_work;
 };
 
-static struct bt_iso_qos default_qos;
+static struct bt_iso_qos_ext default_qos;
+
+static bool check_ucast_qos(struct bt_iso_qos_ext *qos);
+static bool check_bcast_qos(struct bt_iso_qos_ext *qos);
+
+/* The type is set by the first connect() or listen() if left as
+ * BT_ISO_QOS_ANY, otherwise it has to match how the socket is used, see
+ * struct bt_iso_qos_ext.
+ */
+static bool iso_qos_check_type(struct bt_iso_qos_ext *qos, u16 type)
+{
+	if (qos->type == BT_ISO_QOS_ANY)
+		qos->type = type;
+
+	return qos->type == type;
+}
 
-static bool check_ucast_qos(struct bt_iso_qos *qos);
-static bool check_bcast_qos(struct bt_iso_qos *qos);
 static bool iso_match_sid(struct sock *sk, void *data);
 static bool iso_match_sid_past(struct sock *sk, void *data);
 static bool iso_match_sync_handle(struct sock *sk, void *data);
@@ -427,6 +440,12 @@ static int iso_connect_bis(struct sock *sk)
 		goto unlock;
 	}
 
+	/* Fail if the QoS was set for the other type */
+	if (!iso_qos_check_type(&iso_pi(sk)->qos, BT_ISO_QOS_BCAST)) {
+		err = -EINVAL;
+		goto unlock;
+	}
+
 	/* Fail if user set invalid QoS */
 	if (iso_pi(sk)->qos_user_set && !check_bcast_qos(&iso_pi(sk)->qos)) {
 		iso_pi(sk)->qos = default_qos;
@@ -531,6 +550,12 @@ static int iso_connect_cis(struct sock *sk)
 		goto unlock;
 	}
 
+	/* Fail if the QoS was set for the other type */
+	if (!iso_qos_check_type(&iso_pi(sk)->qos, BT_ISO_QOS_UCAST)) {
+		err = -EINVAL;
+		goto unlock;
+	}
+
 	/* Fail if user set invalid QoS */
 	if (iso_pi(sk)->qos_user_set && !check_ucast_qos(&iso_pi(sk)->qos)) {
 		iso_pi(sk)->qos = default_qos;
@@ -620,7 +645,7 @@ static int iso_connect_cis(struct sock *sk)
 	return err;
 }
 
-static struct bt_iso_qos *iso_sock_get_qos(struct sock *sk)
+static struct bt_iso_qos_ext *iso_sock_get_qos(struct sock *sk)
 {
 	if (sk->sk_state == BT_CONNECTED || sk->sk_state == BT_CONNECT2)
 		return &iso_pi(sk)->conn->hcon->iso_qos;
@@ -628,11 +653,134 @@ static struct bt_iso_qos *iso_sock_get_qos(struct sock *sk)
 	return &iso_pi(sk)->qos;
 }
 
+/* The unicast QoS is a prefix of the broadcast one, with the same fields at
+ * the same offsets, in both struct bt_iso_qos and struct bt_iso_qos_ext, so
+ * converting the broadcast view converts either.
+ */
+static void iso_io_qos_to_ext(const struct bt_iso_io_qos *io,
+			      struct bt_iso_io_qos_ext *ext)
+{
+	ext->interval = io->interval;
+	ext->latency = io->latency;
+	ext->sdu = io->sdu;
+	ext->phys = io->phys;
+	ext->rtn = io->rtn;
+	ext->rates = 0x0000;
+}
+
+static void iso_io_qos_from_ext(const struct bt_iso_io_qos_ext *ext,
+				struct bt_iso_io_qos *io)
+{
+	io->interval = ext->interval;
+	io->latency = ext->latency;
+	io->sdu = ext->sdu;
+	io->phys = ext->phys;
+	io->rtn = ext->rtn;
+}
+
+static void iso_io_qos_ext_copy(const struct bt_iso_io_qos_ext *src,
+				struct bt_iso_io_qos_ext *dst)
+{
+	dst->interval = src->interval;
+	dst->latency = src->latency;
+	dst->sdu = src->sdu;
+	dst->phys = src->phys;
+	dst->rtn = src->rtn;
+	dst->rates = src->rates;
+}
+
+/* Copy field by field so the padding, which the likes of hci_add_bis()
+ * compare with memcmp(), is zeroed rather than copied from or to userspace.
+ *
+ * In version 1 the unicast fields are a prefix of the broadcast ones, so
+ * copying the broadcast view copies either type. Fields added later to only
+ * one of them will need copying according to type.
+ */
+static void iso_qos_ext_copy(const struct bt_iso_qos_ext *src,
+			     struct bt_iso_qos_ext *dst)
+{
+	const struct bt_iso_bcast_qos_ext *s = &src->bcast;
+	struct bt_iso_bcast_qos_ext *d = &dst->bcast;
+
+	memset(dst, 0, sizeof(*dst));
+	dst->version = BT_ISO_QOS_VERSION_1;
+	dst->type = src->type;
+
+	d->big = s->big;
+	d->bis = s->bis;
+	d->sync_factor = s->sync_factor;
+	d->packing = s->packing;
+	d->framing = s->framing;
+	iso_io_qos_ext_copy(&s->in, &d->in);
+	iso_io_qos_ext_copy(&s->out, &d->out);
+	d->encryption = s->encryption;
+	memcpy(d->bcode, s->bcode, sizeof(d->bcode));
+	d->options = s->options;
+	d->skip = s->skip;
+	d->sync_timeout = s->sync_timeout;
+	d->sync_cte_type = s->sync_cte_type;
+	d->mse = s->mse;
+	d->timeout = s->timeout;
+}
+
+static void iso_qos_to_ext(const struct bt_iso_qos *qos,
+			   struct bt_iso_qos_ext *ext)
+{
+	const struct bt_iso_bcast_qos *b = &qos->bcast;
+	struct bt_iso_bcast_qos_ext *e = &ext->bcast;
+
+	memset(ext, 0, sizeof(*ext));
+	ext->version = BT_ISO_QOS_VERSION_1;
+	/* struct bt_iso_qos has no type, connect() or listen() sets it */
+	ext->type = BT_ISO_QOS_ANY;
+
+	e->big = b->big;
+	e->bis = b->bis;
+	e->sync_factor = b->sync_factor;
+	e->packing = b->packing;
+	e->framing = b->framing;
+	iso_io_qos_to_ext(&b->in, &e->in);
+	iso_io_qos_to_ext(&b->out, &e->out);
+	e->encryption = b->encryption;
+	memcpy(e->bcode, b->bcode, sizeof(e->bcode));
+	e->options = b->options;
+	e->skip = b->skip;
+	e->sync_timeout = b->sync_timeout;
+	e->sync_cte_type = b->sync_cte_type;
+	e->mse = b->mse;
+	e->timeout = b->timeout;
+}
+
+static void iso_qos_from_ext(const struct bt_iso_qos_ext *ext,
+			     struct bt_iso_qos *qos)
+{
+	const struct bt_iso_bcast_qos_ext *e = &ext->bcast;
+	struct bt_iso_bcast_qos *b = &qos->bcast;
+
+	memset(qos, 0, sizeof(*qos));
+
+	b->big = e->big;
+	b->bis = e->bis;
+	b->sync_factor = e->sync_factor;
+	b->packing = e->packing;
+	b->framing = e->framing;
+	iso_io_qos_from_ext(&e->in, &b->in);
+	iso_io_qos_from_ext(&e->out, &b->out);
+	b->encryption = e->encryption;
+	memcpy(b->bcode, e->bcode, sizeof(b->bcode));
+	b->options = e->options;
+	b->skip = e->skip;
+	b->sync_timeout = e->sync_timeout;
+	b->sync_cte_type = e->sync_cte_type;
+	b->mse = e->mse;
+	b->timeout = e->timeout;
+}
+
 static int iso_send_frame(struct sock *sk, struct sk_buff *skb,
 			  const struct sockcm_cookie *sockc)
 {
 	struct iso_conn *conn = iso_pi(sk)->conn;
-	struct bt_iso_qos *qos = iso_sock_get_qos(sk);
+	struct bt_iso_qos_ext *qos = iso_sock_get_qos(sk);
 	struct hci_iso_data_hdr *hdr;
 	int len = 0;
 
@@ -1009,7 +1157,8 @@ static struct proto iso_proto = {
 	.rtn		= 2u, \
 }
 
-static struct bt_iso_qos default_qos = {
+static struct bt_iso_qos_ext default_qos = {
+	.version = BT_ISO_QOS_VERSION_1,
 	.bcast = {
 		.big			= BT_ISO_QOS_BIG_UNSET,
 		.bis			= BT_ISO_QOS_BIS_UNSET,
@@ -1375,6 +1524,12 @@ static int iso_listen_bis(struct sock *sk)
 		goto unlock;
 	}
 
+	/* Fail if the QoS was set for the other type */
+	if (!iso_qos_check_type(&iso_pi(sk)->qos, BT_ISO_QOS_BCAST)) {
+		err = -EINVAL;
+		goto unlock;
+	}
+
 	/* Fail if user set invalid QoS */
 	if (iso_pi(sk)->qos_user_set && !check_bcast_qos(&iso_pi(sk)->qos)) {
 		iso_pi(sk)->qos = default_qos;
@@ -1417,6 +1572,10 @@ static int iso_listen_cis(struct sock *sk)
 
 	BT_DBG("%pMR", &iso_pi(sk)->src);
 
+	/* Fail if the QoS was set for the other type */
+	if (!iso_qos_check_type(&iso_pi(sk)->qos, BT_ISO_QOS_UCAST))
+		return -EINVAL;
+
 	write_lock(&iso_sk_list.lock);
 
 	if (__iso_get_sock_listen_by_addr(&iso_pi(sk)->src, &iso_pi(sk)->dst))
@@ -1863,7 +2022,7 @@ static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	return bt_sock_recvmsg(sock, msg, len, flags);
 }
 
-static bool check_io_qos(struct bt_iso_io_qos *qos)
+static bool check_io_qos(struct bt_iso_io_qos_ext *qos)
 {
 	/* If no PHY is enable SDU must be 0 */
 	if (!qos->phys && qos->sdu)
@@ -1878,10 +2037,19 @@ static bool check_io_qos(struct bt_iso_io_qos *qos)
 	if (qos->phys & ~(BT_ISO_PHY_ANY | BT_ISO_PHY_HDT))
 		return false;
 
+	/* Rates only apply to the LE HDT PHY */
+	if (qos->rates & ~(BT_ISO_HDT_RATE_2M | BT_ISO_HDT_RATE_3M |
+			   BT_ISO_HDT_RATE_4M | BT_ISO_HDT_RATE_6M |
+			   BT_ISO_HDT_RATE_7_5M))
+		return false;
+
+	if (qos->rates && !(qos->phys & BT_ISO_PHY_HDT))
+		return false;
+
 	return true;
 }
 
-static bool check_ucast_qos(struct bt_iso_qos *qos)
+static bool check_ucast_qos(struct bt_iso_qos_ext *qos)
 {
 	if (qos->ucast.cig > 0xef && qos->ucast.cig != BT_ISO_QOS_CIG_UNSET)
 		return false;
@@ -1907,7 +2075,7 @@ static bool check_ucast_qos(struct bt_iso_qos *qos)
 	return true;
 }
 
-static bool check_bcast_qos(struct bt_iso_qos *qos)
+static bool check_bcast_qos(struct bt_iso_qos_ext *qos)
 {
 	if (!qos->bcast.sync_factor)
 		qos->bcast.sync_factor = 0x01;
@@ -1959,7 +2127,9 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 	int err = 0;
-	struct bt_iso_qos qos = default_qos;
+	struct bt_iso_qos_ext qos = default_qos;
+	struct bt_iso_qos_ext qos_user;
+	struct bt_iso_qos qos_old;
 	u32 opt;
 
 	BT_DBG("sk %p", sk);
@@ -2005,9 +2175,49 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		err = copy_safe_from_sockptr(&qos, sizeof(qos), optval, optlen);
-		if (err)
+		/* The length of struct bt_iso_qos selects it, any other
+		 * length is struct bt_iso_qos_ext of a known version.
+		 */
+		if (optlen == sizeof(qos_old)) {
+			err = copy_safe_from_sockptr(&qos_old, sizeof(qos_old),
+						     optval, optlen);
+			if (err)
+				break;
+
+			iso_qos_to_ext(&qos_old, &qos);
+		} else {
+			if (optlen < sizeof(qos)) {
+				err = -EINVAL;
+				break;
+			}
+
+			err = copy_struct_from_sockptr(&qos_user,
+						       sizeof(qos_user),
+						       optval, optlen);
+			if (err)
+				break;
+
+			if (qos_user.version != BT_ISO_QOS_VERSION_1 ||
+			    qos_user.type > BT_ISO_QOS_BCAST) {
+				err = -EINVAL;
+				break;
+			}
+
+			iso_qos_ext_copy(&qos_user, &qos);
+		}
+
+		/* A socket that already has a connection, such as one with
+		 * deferred setup or a PA sync, knows its type, so check it
+		 * now as connect() or listen() won't.
+		 */
+		if (iso_pi(sk)->conn && iso_pi(sk)->conn->hcon &&
+		    !iso_qos_check_type(&qos,
+					iso_pi(sk)->conn->hcon->type ==
+					CIS_LINK ? BT_ISO_QOS_UCAST :
+					BT_ISO_QOS_BCAST)) {
+			err = -EINVAL;
 			break;
+		}
 
 		iso_pi(sk)->qos = qos;
 		iso_pi(sk)->qos_user_set = true;
@@ -2048,7 +2258,9 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 			       sockopt_t *opt)
 {
 	struct sock *sk = sock->sk;
-	struct bt_iso_qos *qos;
+	struct bt_iso_qos_ext *qos;
+	struct bt_iso_qos_ext qos_ext;
+	struct bt_iso_qos qos_old;
 	int len, val, err = 0;
 	u8 base_len;
 	u8 *base;
@@ -2083,9 +2295,25 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 	case BT_ISO_QOS:
 		qos = iso_sock_get_qos(sk);
 
-		len = min_t(unsigned int, len, sizeof(*qos));
-		if (copy_to_iter(qos, len, &opt->iter_out) != len)
-			err = -EFAULT;
+		/* A buffer too short for struct bt_iso_qos_ext gets
+		 * struct bt_iso_qos, as it did before the extension.
+		 */
+		if (len < sizeof(*qos)) {
+			iso_qos_from_ext(qos, &qos_old);
+
+			len = min_t(unsigned int, len, sizeof(qos_old));
+			if (copy_to_iter(&qos_old, len, &opt->iter_out) != len)
+				err = -EFAULT;
+		} else {
+			/* Report the version of this struct, with its padding
+			 * zeroed.
+			 */
+			iso_qos_ext_copy(qos, &qos_ext);
+
+			len = sizeof(qos_ext);
+			if (copy_to_iter(&qos_ext, len, &opt->iter_out) != len)
+				err = -EFAULT;
+		}
 
 		break;
 
-- 
2.56.0

