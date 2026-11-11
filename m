Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414481;
	b=1xCuyWmb10ogTxz/P3P/sg8pdI8WwX5uj1vIRAF2wDXFK7/ylHa7PtAgUHoVpe1HKxHH
	 kUDHE1Q3m2hvg98WuM+MbB2a1N0kGKOQPWQbETr1SnevnpepHBSpHvn2P9EgC7jEKtd0+
	 avauY1qU40pF3dVodyXZT8OBE+Iw8rqlP+O1RKrj488+DU0JjJVX8AHKSc33GdrTxy3kW
	 wFh+tzaeKS4gdYmbZeERoPrB84i7g4voouQZrJNqWiXCVHAceoLXCKAkHBTtWT3JP3Ac5
	 Z6YZKb6MDMeFCcFovZr2aYaZ+ybZ5EZUKtiddG+ULdaMLDk0rlUQz9wjA+AFhhqegrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q7MbMV1rz4ncyD+3tsgr32JQ+dFMLevhy58tHK7aWOk=;
	b=GYcTr3+nUNQUFXIrTBaLCgxcj5hW8tKbhDB7j64gCyvXk+DNuHzVqH+O5nO8h5KWi+nI
	 qPTzpS3efbzQ0qmsxVJalJAo8ZRe37RJicDJoKxIALfGfpSm+k5xFHJAGwFJ21xXDnd/r
	 KqASPWZpdoEVZmjBSvv5tIFr2c6XGVAajGwVNdX63v4UIEzw0DYE1nfjPb6KYejCqUAyY
	 3c37FY/aEOn4OesropZAAULO2sFUG+Wurh59uzWG/BrHSWTNV6Y8Ho53SaXhfcU09a3uw
	 Hv8xSKMC+b+nYfZpP8/HlHfjtxzvwUGxxP8uZflUdoGbuczjI1CWLb36OjU/CxAZvnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="zbGdi/Dd";
	arc=none smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335C7606A33D
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 335C7606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zbGdi/Dd
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5eafb65e169so1777210e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794414480; x=1795019280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=q7MbMV1rz4ncyD+3tsgr32JQ+dFMLevhy58tHK7aWOk=;
        b=zbGdi/DdvclzLguvlr5GXk9VO26nEeMmU3y44jlhFU0Eaiyk8w1PH2EMdA3UIv6r5G
         uedVBJCtknp/pJWVO+sgOFqe8pGEOMUyS4M0jmEcDM31TvGaRb4fGKZVi9lu4+VzN2gf
         dp5Fp/BKdQREkrf3+8pLVoh3YJPUyX+elAS80PhOahoW/0/rG0jieXjkWQW7yHygQPBM
         0r8KnQpf7KxWyhP7mJXColTLB/D9Zkkv3alaN6amDOaLDx/S+ES22UeEdHzn6Cq7IxL1
         k2w7k3O1h2777oHPrc2iWfZvZcnTvR+m37Vu7PGHgawlLaBYYna5o5ugrXq3wK3t/EbS
         4NiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794414480; x=1795019280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=q7MbMV1rz4ncyD+3tsgr32JQ+dFMLevhy58tHK7aWOk=;
        b=WzsYTWyyATz05ncsBSul7P9+qeAqrx1FpEIJrf5BOPykMUw13vs0AmwYN7lcTgl3mM
         TxhTi3iZQam3o7MU3vXEOUTw3GT93VZ0Ng/uKsCs3HJnHBw+XTJ76NPun3p5ErYUWZ8C
         u4cSkAaYBaDHvEzhej1VGJy4PS4wWxIf/EYODr6UFT+aPC1Lrh4kiurCQ5A0MkRdsfxF
         OgrcrtbHm6u9Cctf342qJhRr5l1XESGRTxsIpQmWJWN+RvOJMwm90ZOxPD6deL0IUb+O
         Co51FODI1xKgw6FaMCxk67MlK8YuvVMrdschZlnSLCAk1A+xAi8YEbIEt67kZswl7Zhy
         sqPg==
X-Gm-Message-State: APuU4Z/jjuBQl2U0o1pnZkdbwq+pJGt+93GZZY+TI5nwUYO9nCYhgT0N
	JWx1iXhhakSyhDKCsqs/wCwBwqFeRFNEbhm/bvg7SQ4OFv3O3JDW45ijVjXDvA==
X-Gm-Gg: AYBFou3HeB5ICLvpskSrG8UGBtVuxDbNocu3R+SQpFfiejtjzhzfl6I++1jo7rImc9N
	/LCM8Q6Bo4e6ryuc2EvueKSFNjX22tKTlLV3LkxBaY7dcTr26xrhb6lfWxtv4E3feMhdOs/F92g
	LutSz2GydW1+W0qLwc0Zss7jQAMahNjdvrj8aKYrr2kQ9pAtYxgw726cHW6xUowGOlKet7kTlJ3
	M3w5UA+zRtB/39fPDDHzLqjCK+9RSJZnQzNETklW2bhKA+b4Lldydwfs59Ap5mXXUpIxGdph4/Z
	nVgbM8WZT15/5QvHs8k3QPiBMdmn+SVA7TY4Y4fh36ZAgwn76DSceKa6x6ra/H95DPGqEdElePj
	QL5BKzR5fn3LWmf32dNBRImLvYgjpjiCzpgbUAq4vWipWsxICegZY3+CCcMBLiVVUhKU8JKiIGd
	bOG9zayqvUHlHXi+Amr1P+vRyT63+BBBRSZdR19a1VJZJTi70Lnzxb0VO6KpUTH8b2ZvdjIzkk5
	TNd9i0zawefHnQN8QrvkVBbJ/tlUYWrs9ZXb9AZ1eKdiD2dYzD3iN7asGGoChE4vYr8H7wOR42e
	yYCc7GG7DVZCu0lKNnScVekuXnj1IJNbItDZkYmzgiDp4AENNghMYkNCTpS3hfLXtfzXCFoDBAr
	3LJmQoLGPky9sNkI/NaEwbUo45z7ANqq44B6vkXe2nr3PdBY3RhY0BLlB2jC2ai/rarCrLdM4YI
	n+iJI=
X-Received: by 2002:a05:6122:3d05:b0:5ec:4653:2431 with SMTP id 71dfb90a1353d-5ee1c418b49mr1206674e0c.15.1794414480062;
        Wed, 11 Nov 2026 08:28:00 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c5ab918sm4007081e0c.7.2026.11.11.08.27.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:27:59 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v9 02/11] lib: Add HDT definitions
Date: Wed, 11 Nov 2026 11:27:45 -0500
Message-ID: <20261111162755.3506226-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111162755.3506226-1-luiz.dentz@gmail.com>
References: <20261111162755.3506226-1-luiz.dentz@gmail.com>
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
 lib/bluetooth/bluetooth.h | 119 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/lib/bluetooth/bluetooth.h b/lib/bluetooth/bluetooth.h
index f9f22c3f7523..58bb65d7b1d3 100644
--- a/lib/bluetooth/bluetooth.h
+++ b/lib/bluetooth/bluetooth.h
@@ -50,9 +50,17 @@ extern "C" {
 #endif
 
 #define BT_SECURITY	4
+/* mic_len is the MIC length required of the link on the LE HDT PHY when set,
+ * and the one in use when read. BLUETOOTH CORE SPECIFICATION Version 7.0 |
+ * Vol 4, Part E, Section 7.7.8, MIC_Length: 0x00 MIC length is 32 bits, 0x01
+ * MIC length is 64 bits, 0x02 MIC length is 128 bits, all other values
+ * Reserved for future use. The 32 bits are those of the GFSK PHYs, so on the
+ * LE HDT PHY 0x00 means no requirement.
+ */
 struct bt_security {
 	uint8_t level;
 	uint8_t key_size;
+	uint8_t mic_len;
 };
 #define BT_SECURITY_SDP		0
 #define BT_SECURITY_LOW		1
@@ -130,6 +138,16 @@ struct bt_voice {
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
 
@@ -219,6 +237,107 @@ struct bt_iso_qos {
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
+/* The HDT rates are those of the HDT_Rates parameters: BLUETOOTH CORE
+ * SPECIFICATION Version 7.0 | Vol 4, Part E, Section 7.8.97:
+ * HDT_Rates_C_To_P[i] bits 0 to 4 are the HDT2, HDT3, HDT4, HDT6 and HDT7.5
+ * rates of the LE HDT PHY "(possibly among others)", all other bits are
+ * Reserved for future use.
+ */
+#define BT_ISO_HDT_RATE_2M	0x0001
+#define BT_ISO_HDT_RATE_3M	0x0002
+#define BT_ISO_HDT_RATE_4M	0x0004
+#define BT_ISO_HDT_RATE_6M	0x0008
+#define BT_ISO_HDT_RATE_7_5M	0x0010
+
+/* The PHYs are the bits of PHY_C_To_P[i] and PHY_P_To_C[i], BLUETOOTH CORE
+ * SPECIFICATION Version 7.0 | Vol 4, Part E, Section 7.8.97: bit 0 is LE 1M,
+ * bit 1 is LE 2M, bit 2 is LE Coded, bit 4 is LE HDT and all other bits are
+ * Reserved for future use.
+ */
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

