Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349518;
	b=pZ7mL7lN3efR/IT8MdYMHypruVSzT/SyCOpEof7qce+RSUGXYlOI2NQ2KkItb78CGQqt
	 Ml+GepQQQk5YNJ2UQPV5gwHg/THgYkBhAI31/7mvuunq1hBmn/Lh8ig8qfic3bwSM5NsV
	 RTy7SdC799Z35mSZnxNQsjh+S97xIvrECY3xQW4vXWMhU8uqMHE/IizDotD/6xDo6q9JZ
	 O/8YFZG3OOlxUS4ZIgl9K8f6TTTIPxzYRsVJ2A5nce8wN2AttiaLPTTzOOZJ5uHDmusQm
	 AlPQJEHwKOCjCCRk5EU9sQAKNcDG5FFbVveIjgM+7hEKgIDXy1MKUhnquiSw7t5Qk0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349518;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q7MbMV1rz4ncyD+3tsgr32JQ+dFMLevhy58tHK7aWOk=;
	b=P0SookIA6bhcjhCP1ocErWt74J51+krOnj7UzXhAEbO5D62Gm8n7wFk7RuV2OdFzoNl5
	 lZV7eEDcFVxrLR0ORjWzeldw/msvNTcDdoDAPdvNutTj7zftyqMYkWdpcRmlY4+pVac3t
	 TyrkFHrleq24TAQAy/Aqx/czpz/gqsU6LVy+fBMjEDeUP4/Ppk6N+VblABKK36ghLzBbJ
	 n3IdziT56O3S34l60vY3NuAyhirGlpRAdO1IN5nUb8SOHa1nEgXQAax+/e9GjGhF9zOzw
	 5r26Smh3th3tlLO4PlGSy33NudbnuWo1q2MxqvcDnzg9BH2kLwVKgNmMwHpu8DlPDmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pGPXNCiN;
	arc=none smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F10606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98F10606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pGPXNCiN
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7d2d1b4a83aso806229137.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 14:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349516; x=1794954316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=q7MbMV1rz4ncyD+3tsgr32JQ+dFMLevhy58tHK7aWOk=;
        b=pGPXNCiN6522pFovIWz+48sjdpPvTiIrRvfGJN2KuidcMPRgucoNSu8BAK+KW7Cug9
         Dzbwj5v2TsfbCpD0+/4iH6B0Rj/l+Rfsf4qURo/O8nEurWGnRVGh0HHQIWQ11dnjzczX
         zFi4txYOxfx+MNOvwA/9hO+1z/7bbzWEr7yEmbMoqNa94AurTaKbuhSV1rYoxBlEcEQz
         fz2/SzwlvNQSDBuETU2OeKc88H0cAXoObuDJfSBNoHbTTosBrSdrsBzDvu+rtBOLmwD/
         89C+5lPQAmQQCdGTA/fJdqQWjmkPFM38GNvD37IOvN43nkQJyeR/7v0y8O/YwSkRzkw0
         d9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349516; x=1794954316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=q7MbMV1rz4ncyD+3tsgr32JQ+dFMLevhy58tHK7aWOk=;
        b=CKe4/oKwbv0aLBejM4HCRx9yvtwcskf8SJHoeNwjXxOVXHqXXIwYe5R1DJKvb1poo2
         npxIw9Umr2VhPmPSea170z3ogTJX1mxtyrGffk7165Xp6NbRFdm3OcvQ83WznRLp47lJ
         jjgSayu+6ovR2S8UBNplm7LwkjPrt7i/e6WBVR7q3WVnn85Q60KXr7UvLEqizXgNyVS+
         IG3o3JV72yyKHyr1S9pWPuyGmVY5RDXj8C8nqPLbhG34uP1s5lcG10HQI5Uq7EqSVfMV
         5v3Bwz5YS+QrHwQ0ZVzvcZsSjvs2QHBsq1u9RlaJnn0RTb/jL/OLvULLffGRkNbkB0V4
         boPQ==
X-Gm-Message-State: APuU4Z+lVBqpXQ502TBEdJ+T/mrW5DgU1JAyKfiUQpJLJL0oqU22P4yZ
	trDTTCvrRLrjt65I0YzZkBeH4gIBb2wAncvTsT4XfygQZ7ci17sTCfN1r4XtQg==
X-Gm-Gg: AYBFou1yIqS25Pf8dI2siT4XpcRniFZxhi9sL7RAW4ksCGoIKLviD7M3RsHuVaPpAxq
	JLyxTEzjrJAtKiEox6b3E0BNKCLobao0puh9gU2k/v+jJE8M6iSKB3+t91pMz+snAaL1ByNmSMj
	AQnSXzy0ou2GKzxkak20YFwBhkNYNOKKDpB+JYGRl9Ucf7O+70J3GForNsm5B3aqXEP+ITxldjL
	05MhoMZjSNUNhpSGjJ3X8t+149QDklD066KpxUtXDzTGrb399Fk2CjpDVkKo30WfEfnfRNraIEc
	Mc+WHagJADoIZp/aawHK+Yx4qCKCraCKXNduPG5m2Kry/B3vianW0pcvedtM32IHzY6InAt2s7/
	SRT7G6xQXhTo5/NbdUz0lZhACGsXfokNtYtWyVc49SCVJee7q/fa3vMhTNcAtfxfTumoQF1Ur+M
	FKadJdZQeNZeBB00RmLeDlEuGoDLOyyae3eiPvlaen02SPKeaxAC9fhKpvqA2lTUwiophfgmIHS
	rH7D6nuoTtbC9OyogIbk6YUyU257Y79R5Or+QXA46XaU8BODKjkHcQ/Lr+BVQhszvEX50T3DP6s
	se127Y3ZvZrnaMg4eP2HlZB73A7mdxJnxSJGtXox2CmQTNoZ+14vd0jPMdlxT0N8lUQ2y1Zhxqf
	/ZRgeARVViM0bjpHO50vytTDNw+ZN23OTfHaSLJzrruvycXmfJEa5SINvjiaLZINsGNOPPJWh/x
	Fw4NY=
X-Received: by 2002:a05:6102:5241:b0:7ba:d953:edd8 with SMTP id ada2fe7eead31-7d50143fd4fmr136716137.27.1794349516322;
        Tue, 10 Nov 2026 14:25:16 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d30223977dsm2609190137.1.2026.11.10.14.25.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:25:15 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v8 02/11] lib: Add HDT definitions
Date: Tue, 10 Nov 2026 17:25:01 -0500
Message-ID: <20261110222511.3011494-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110222511.3011494-1-luiz.dentz@gmail.com>
References: <20261110222511.3011494-1-luiz.dentz@gmail.com>
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

