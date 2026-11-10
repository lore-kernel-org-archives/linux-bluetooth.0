Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328501;
	b=xe6F+dKgwEfn/dXeo/GrbjX5hQsr5UBsy1D1sgTNuyPe1mOmDGK2+V8nhtB87TLebYT3
	 4WpialbHK0exmWk1S9IkIEYtPSpS6Cpis1uOEXslbGge0CZTbm3V9xxLH4tRTn6w2Bqtf
	 Z2n21YIaf7Qi1DghkRDyQUiGEt3DrROu1m/M0pAWWGWxaIDrac8wAlL4GyXRwp/8JTkA+
	 xRBVbTfOxnnIpinkigZ53bXYxcTwm99tV29sowzDUOiXgJ5ltAu30gAo3IrsA+yDdeU87
	 9HPKRb7Vns+PduF8nNEvEiOUqxgdOx05J1SWR4IZyGmPzWeifgt9Ifi9cLzfLy9ASWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328501;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q7MbMV1rz4ncyD+3tsgr32JQ+dFMLevhy58tHK7aWOk=;
	b=PhpfQLX1k0Er5262YsUEezf/cjd5Uop/loQbEZ/PXNMtkLVgqffA1wwKoYyfmP+JPAwv
	 bhJjAioPW2/MMoLft7kitsfQx8NBLmiqhgdICQ2WQo0gyOCpI0zd8O0x3LvEcTl1BPg7I
	 PIoyKcpVXjeyXHdUuqMFg7y9KNiRhQ15CFDkyH+peKeKKUpUaoQnCAyiYy/xTBLlMwTto
	 59V+gm7a7uc+hmp1OMju9tgwqTUo7DKSXuPIuI+/SwJlyj8ZxllZnV5Tjvlypz1CKexG0
	 lSKStoaO3xsU8EZ1kXbkkht20sovzhJt999BmcimTQsbbJoox++hNsLX6eKNTBrsslw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=huoCWfvN;
	arc=none smtp.remote-ip=209.85.222.50
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED05606A320
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 16:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ED05606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=huoCWfvN
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-998569550adso1259671241.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 08:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794328499; x=1794933299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=q7MbMV1rz4ncyD+3tsgr32JQ+dFMLevhy58tHK7aWOk=;
        b=huoCWfvNP8zZJFszL5fTIeOzaeloyIpgnxQOM+XnOzc00AVVpKNJQpZrryIhAYH4pJ
         OPkzEcun/xlU4rhS18zFxEkZWTMU7OByliuk97mCwI8gqyGfk6FaYYJR+DvB45apeNlH
         Pq2y0WnCz4tsBAAk+vraRrAH9F07phmIM5i2uXe8PRDGd56/ejUx8P+ILuf6F43YVOX4
         l1SgyIEEpgmejIvtkTg+CD+ZmHkExfwd/y9oVhWybG1KNBEXFO+LUdmwa3R5ZrKVUNd6
         VPk0jb+/2I2NmU+VdO2O5x2F4BVURxVZUOHB8MmQWuJcpeEElU0SbKh12F4qwIiAnR+v
         Zjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328499; x=1794933299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=q7MbMV1rz4ncyD+3tsgr32JQ+dFMLevhy58tHK7aWOk=;
        b=Fmnr1s2krqmvb/Bn1PJ0toaLu9Rv787wyzJsbAKcml7412X1gGPhAMtA6Jf0sWl+wo
         Cii2lCRsiSvpehrHyCAEDydkPZvB52uRafv8ydKRh1d5O3CdCji0Ua08dlivO1vnCXLF
         LqwpHsK2eqxTnReVV+lk1bPRZ+maCsh/SsQHIHgdJiCYZsoZz1Wezm0d8H7NcVYZ8978
         VlmIuPUeZ2kr0K/MtE5Kd2aodsHJKLmD4WTKcAVL/7YusGt1mr3/KPZgKK1xFYreX0DQ
         dYN2MDmUFn6oUSRqeWDEZEVC0MTwBXlq8bO/5hwVgQm5PrHWwlmlgN4fA9gXjFX3c8so
         7QFw==
X-Gm-Message-State: APuU4Z/13EG29U9jDRlpqAPVK2h6wFjaA7aMAfKpCfQtxFxAUwvLpo+R
	7mHUOROM3iAr1TCj1Ks4YCdtY2Dvcj8VUkFI/DbtYVF4fJkXmgb7NvdkqJSHqQ==
X-Gm-Gg: AYBFou0hw9iU/o44T/4me22PvtYToa8+2/1hEdEJc+eVKHRyt0p6njQVYsp8BbFhEtC
	YjslbdhOj1miv33UfpvLX7h0mRqHaRqlXVfnzAaXlGh3Mw8StNLG8YcZVbxFTLOOOF3vc+fryIi
	nM/ch9AIeUZzduVqi5au6YKuToGGCwJ05qIsOWxUHBflyfkRsTe6E5U7EzOAsp5Im8ITS3xoq7D
	oxrguFr9pjx40xGymYHmAVV5DQW4J/Bnus6Gm3jLxl583Occ1LTzIXOS68pk6/Bf150tx5e31og
	lWT3eDbS19eDA0MAjhMwWixSGG7T/iialIKy7heLFD9ksqZDFdU4Fi0G7XoyuERr0CVG5qNgnMW
	xsvgjI1dyoMkne1d+G/A0L55sVy7TjWECyYM5CdccxG0M3bLXVAT1FW2EH6E6xSEZon7eR/EIVg
	5j9UmAC5T/SmGgi5qd6A76cFYuoMx+PwS/FOru9qPoTiY91DNUwJXmsva/0kFipJTT0yIMOXj5N
	7lPtpBUGV90UjdfnTD5cK7ygKsavuh2eMxkeDvvsOqC0mVctAZCo9LTFuNH0vNXMjj6Iq1JQNTy
	QK3cNL+lgpT93XyDnYtRNfaDVNyIwH++hGYsQQlO5ml5wn4sL6+UiKOc07aqtEKCT82iUkEfjfB
	jIRw99a9Zf6x92YusYbxBXrURzq/RochbGWmKEWAfeKcynHA5bi0/ZrFkqpDZAkt4dsW+6CRlih
	EXL5I=
X-Received: by 2002:a05:6102:c54:b0:7cc:2fd1:7122 with SMTP id ada2fe7eead31-7d301bad12cmr1427812137.18.1794328499345;
        Tue, 10 Nov 2026 08:34:59 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d3023543casm1989315137.5.2026.11.10.08.34.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:34:58 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v8 02/11] lib: Add HDT definitions
Date: Tue, 10 Nov 2026 11:34:42 -0500
Message-ID: <20261110163452.2649366-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110163452.2649366-1-luiz.dentz@gmail.com>
References: <20261110163452.2649366-1-luiz.dentz@gmail.com>
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

