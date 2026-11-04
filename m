Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793830860;
	b=C3tKxU57bZIqnHev4pHCIN8IDvwaIa+tQSMcSjfsD8DJVIMIfgVr+Qh1nqVm79nnvaay
	 GvSgLzWNYRkdbc6bwjeY6toKBezLUEFMLCgnHhoB/53L9Bj0bhAP6yi/LkkUijemxMDEq
	 slJoKYT0p5QbUBzU59SnQNdB4STFd/1M4wotHKn7TMQUDG4w+Yz/bKvf8JxtyTDgti4/R
	 Bw3BUTWXAHUSUlhri3yP8OiXVLDcla0LWBAu+oZ9NT4S6qOaLlOLPHuXJUZRsnmvabzkk
	 gJBQ2/dONCsnTpPa1ujrv0U4ekGetI/lQsPrvy3aLYdZHnRMWpf1qFMxXX7ydcUwFPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793830860;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KEpmrqjeBlLIC5FDw6P8Lla+tRVPL0vgEUnkg0Ph/sE=;
	b=WVFKVuZaqygnbBwSFbD+WKePQI5AaBIKY1S3jj0vWw3p70PVM3qAsErPwu8TI/QErgUG
	 FWFwM2CXxJpEA+8yoy1Xh9J9AoqvQzhRjs6+zdYKmdV76m4r3A3+cek492qqTNgEbahMw
	 8C6PFw150fqedWYxVc1jIXmFaGCz0GtkEi6mu3KLsrkYSrRj5svAA59Sob2G0IJ/esWZU
	 IUp0hAzIUNKNYftyX9lHLSwDXA8uMkNBat2A7T9uuDyRTlVoqYNvBHrFBJhBu5h7LQNjA
	 34siV4CgkjF2sslWAVi3gJ+JtnII/L6ysRLGw4kApI040AvlGe3ye++LVE/6P0ys6VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HbR7uY3T;
	arc=none smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6086606D805
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 22:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6086606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HbR7uY3T
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-74ab99038afso790419137.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 14:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793830859; x=1794435659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KEpmrqjeBlLIC5FDw6P8Lla+tRVPL0vgEUnkg0Ph/sE=;
        b=HbR7uY3TwRe4CyUv2fWi0QT7pl4cf7MGzkwef9aCOb3hIc/F9bbpU6fD7DUonmZ8g0
         Yme9g3XNsfDGFLscUigop9r5242B1oE0TjxdXR6OD/ja/dO6UB3fSI9pIteBy6T//J7m
         Gr9o2xaSaJ+CopiTSCziyKGPIn7bACN/Tq9aT4koToEY0gDF4epxlh87bE4dqaFh9izU
         D69Wnx02yONm7vo0iwc8+Y6APJ2x8SVSloFCSqEhk6P2mHMTqQUISUy4f+vI6f54KCu0
         77QdZMLP4clCyoRMVFX4/k13LVUnkchCPpTiU3y7i7ne6BYnnNJo2EBA7kOB/k0j/IKb
         O8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793830859; x=1794435659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KEpmrqjeBlLIC5FDw6P8Lla+tRVPL0vgEUnkg0Ph/sE=;
        b=iIuhobeQYOCfA6ggp4pZCi4UT2AEFaqe5mJUWjnlRZZlR2Cu39nKSlc3vhkGtaJCIc
         5WZed0Fz9jmvx5HpWpfo0os7tOdn/vhqQvBKmzm1O/mkev45NVxQV58gfWXolFt720IS
         ZbqS+61CjduXDaDBQERKOtesFjw/JCD5z7kQOHeqIGY+m6yW29n1tf3U3dux4KbUd8RW
         KY/bTIO/P5Sfo9GDj3rsO0TAu41Eyp2O5hkFxXytn1LUj1RHhyXmQOlIsOwgBDBN34g/
         gAoenIlbmaaSrVcHovzdUq2xNSY5ctTxEBBhey+ZH6gDAeQ6yT17nUkXa75RrUWiVIBF
         HTGg==
X-Gm-Message-State: APuU4Z+h3ZfHQF2I3sVNbVCoOvvXBwkTqzuexM/gDrNWtS6jeXsFW7w1
	5+0tB4gU9SUNPOF9z+WbZsthFiLSoIv/qkVsg6aEtbCpMxN8lI0LlnG7m8SPwQ==
X-Gm-Gg: AYBFou1EvWP/2804S5urwhwq7zEIBGxDQeHGfVYCmXA5L9DZHQXq2rh5y5qhbRcUPp3
	FTn1/tNN0DNayGvwRHEE7ga7KUSNiiYqyTpzcmd/2k7iuYe9pQO4FgYmMnGb+nfk56a2HsZxgaY
	q+gLSj95E+FiKuJeDhFF8y6attWLtV0fSONjfs1TZ9lElQ7QNB0pNpEvGiXr8wBvMcGaNewwJEt
	pQZNLEsZguR9nlT7dVHH6gzDhOM1HYBTUrGygba4HzNRaNVF6i1gLDOku98jrlTdTpgqdzThAlL
	LYxxeGiMObIzrYMHcRtdKtEDi9Eq/gusmKibFKVFlu3vmTAGfWikis2/oXWNhbGxZsDyfWKuf+l
	sPBjwvcJQkQRtc3hlb6OZumO0gVui5IyIPSdyyDAjZ7kSN04Mx2ARgX04T036+ir6e/sC0rnCYa
	lDykqV/LXDrIj4hupsGZGpC3iYB3V+yG0fAm6o1NPk0TPLjVqIWb06T8zwJrJBPdtidD5v9obq/
	kWW41WjoXScpYK8btrN9O3ZWEoBDb7XKVEHwxhVBaoMHqOwwkqtSmAmk9eFqOsGbs5lLRAG3tAk
	httAUSqc9gQr8vZWBirCbTE/E4vs6gQsqdrDewfEpptvtvmUCIAem/2c9iXRL0zSj5V3Qu6x63r
	jfTVAkFxwUb6rXMhNqtB7UZ7I3somFfrJ0haQBwAqkZIqVPwdhQM3cK8nouoMe6mETvp7VUK9I1
	ZFXkU=
X-Received: by 2002:a05:6102:5126:b0:7cc:2674:b78c with SMTP id ada2fe7eead31-7d07262d5e2mr7457286137.7.1793830858640;
        Wed, 04 Nov 2026 14:20:58 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca89b6568sm2852206e0c.1.2026.11.04.14.20.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:20:58 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 01/10] lib: Add HDT definitions
Date: Wed,  4 Nov 2026 17:20:45 -0500
Message-ID: <20261104222055.1207928-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104222055.1207928-1-luiz.dentz@gmail.com>
References: <20261104222055.1207928-1-luiz.dentz@gmail.com>
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

Add the socket API needed for the LE HDT PHY:

- BT_PHY bits for the HDT2, HDT3, HDT4, HDT6 and HDT7.5 rates in each
  direction.
- bt_security.mic_len to request and read the MIC length of a link.
- struct bt_iso_qos_ext, an extensible ISO QoS passed with BT_ISO_QOS
  and told apart from struct bt_iso_qos by its length, along with the
  BT_ISO_PHY_* values and BT_ISO_HDT_RATE_* for its rates field.

struct bt_iso_qos_ext is meant to grow rather than adding new socket
options or structs, which is what its first two fields are for:

- version tells which fields are valid, so later versions can add
  fields while applications built for an earlier version keep working.
  Version 1 adds the HDT rates of each direction.
- type tells which member of the union is in use, unicast or
  broadcast. The QoS is usually set before bind() or connect(), when
  the kernel can't tell which one it was given, so with type each can
  grow on its own by adding fields at its end, which is also why the
  union is the last member. BT_ISO_QOS_ANY leaves it to connect() or
  listen().
---
 lib/bluetooth/bluetooth.h | 100 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/lib/bluetooth/bluetooth.h b/lib/bluetooth/bluetooth.h
index f9f22c3f7523..dc05df21cd23 100644
--- a/lib/bluetooth/bluetooth.h
+++ b/lib/bluetooth/bluetooth.h
@@ -53,6 +53,7 @@ extern "C" {
 struct bt_security {
 	uint8_t level;
 	uint8_t key_size;
+	uint8_t mic_len;
 };
 #define BT_SECURITY_SDP		0
 #define BT_SECURITY_LOW		1
@@ -130,6 +131,16 @@ struct bt_voice {
 #define BT_PHY_LE_2M_RX		0x00001000
 #define BT_PHY_LE_CODED_TX	0x00002000
 #define BT_PHY_LE_CODED_RX	0x00004000
+#define BT_PHY_HDT_2M_TX	0x00008000
+#define BT_PHY_HDT_2M_RX	0x00010000
+#define BT_PHY_HDT_3M_TX	0x00020000
+#define BT_PHY_HDT_3M_RX	0x00040000
+#define BT_PHY_HDT_4M_TX	0x00080000
+#define BT_PHY_HDT_4M_RX	0x00100000
+#define BT_PHY_HDT_6M_TX	0x00200000
+#define BT_PHY_HDT_6M_RX	0x00400000
+#define BT_PHY_HDT_7_5M_TX	0x00800000
+#define BT_PHY_HDT_7_5M_RX	0x01000000
 
 #define BT_MODE			15
 
@@ -219,6 +230,95 @@ struct bt_iso_qos {
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
+ * connect() or listen() fail with -EINVAL. getsockopt() reports the type in
+ * use once it is known.
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
+#define BT_ISO_HDT_RATE_2M	0x0001
+#define BT_ISO_HDT_RATE_3M	0x0002
+#define BT_ISO_HDT_RATE_4M	0x0004
+#define BT_ISO_HDT_RATE_6M	0x0008
+#define BT_ISO_HDT_RATE_7_5M	0x0010
+
+#define BT_ISO_PHY_1M		0x01
+#define BT_ISO_PHY_2M		0x02
+#define BT_ISO_PHY_CODED	0x04
+#define BT_ISO_PHY_HDT		0x10
+#define BT_ISO_PHY_ANY		(BT_ISO_PHY_1M | BT_ISO_PHY_2M | \
+				 BT_ISO_PHY_CODED)
+
+struct bt_iso_io_qos_ext {
+	uint32_t interval;
+	uint16_t latency;
+	uint16_t sdu;
+	uint8_t  phys;
+	uint8_t  rtn;
+	uint16_t rates;
+};
+
+struct bt_iso_ucast_qos_ext {
+	uint8_t  cig;
+	uint8_t  cis;
+	uint8_t  sca;
+	uint8_t  packing;
+	uint8_t  framing;
+	struct bt_iso_io_qos_ext in;
+	struct bt_iso_io_qos_ext out;
+};
+
+struct bt_iso_bcast_qos_ext {
+	uint8_t  big;
+	uint8_t  bis;
+	uint8_t  sync_factor;
+	uint8_t  packing;
+	uint8_t  framing;
+	struct bt_iso_io_qos_ext in;
+	struct bt_iso_io_qos_ext out;
+	uint8_t  encryption;
+	uint8_t  bcode[16];
+	uint8_t  options;
+	uint16_t skip;
+	uint16_t sync_timeout;
+	uint8_t  sync_cte_type;
+	uint8_t  mse;
+	uint16_t timeout;
+};
+
+struct bt_iso_qos_ext {
+	uint16_t version;
+	uint16_t type;
+	union {	/* Shall be the last member */
+		struct bt_iso_ucast_qos_ext ucast;
+		struct bt_iso_bcast_qos_ext bcast;
+	};
+};
+
 #define BT_CODEC		19
 struct bt_codec {
 	uint8_t id;
-- 
2.56.0

