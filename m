Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794087978;
	b=4RvZ9xzqVaOIxqClku7L5jTVfBVoYyHOuGoN4PPV1eCe805XkOYSUrupcEAbXCEf9Cqe
	 Jup0HjSvDHGWPrjTH/xtTvSggPTn1HkIye4BmDp+hAFq0O34/8wfE5UhLL4GFTdpMAxDQ
	 7ccBM2yahxF+M2GNq5l5UbSun2QiXNnh5Zn90KC7kSdDdZb3MVCiygjScl2TZW7rYQU71
	 1Gcb5eFCfEPFigUF5KGMj/snwy9P1EJ9d78S8VyaktQJvwOqarso3TFou1bfDizZr0TZT
	 lQ7z8+F08mlVxGNf2E+CyqhZT5ErRSmR+qr8QokqhboPpnnmgLwQOu672niH1aPZ9dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794087978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q7MbMV1rz4ncyD+3tsgr32JQ+dFMLevhy58tHK7aWOk=;
	b=l1H5oEp0fTXdMcmAWSEfOTbzZFFZ4QBhWwLp9sEUwIFnz3tigZYu6Uxxy5xCEyQ6qJAf
	 RAUfU/FXMF9i09lotffyx4yb8i5ODov/bOttcwGG5VCJFcsGFqjFHNLKhiDUluE92BT7F
	 0XodTXcSaKJPxL3H76/1gBcCdLwUp7niTBuhuttuYtCc5FgPq6vX6aY5hiWRIQ3jo6W8A
	 jFaHHk0r7/MpbPt+H2jiPtky+9zZYjADG/Cv9E1gQCZlgp0n6adVeZ06tjQSEpnyJMbbh
	 3qacsCxYx+GBmQpOYqssE/o28g8dGThjVs5CGtVLNmc2XHUNiHfmeOQddGP+NkWVicQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rF5zHs+5;
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479F6606A32C
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Nov 2026 21:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 479F6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rF5zHs+5
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5ecde8e8e5bso11172e0c.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 Nov 2026 13:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794087977; x=1794692777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=q7MbMV1rz4ncyD+3tsgr32JQ+dFMLevhy58tHK7aWOk=;
        b=rF5zHs+5RD6z+Gprk0pTQ+odrYwrbvb6Dx3xjR5aZTspOcjHQq5GxlX/NN3AUkGuIp
         jWdkkYQosKURstFzSRRzZyrWCx/YuNo3x69gIKPB/kSSLhityLBl3N+9f6n6V3g+oG/8
         RXYYtc+3g8SX8rlnKp50pFORRe6fbLUFzixedmNBb2p0dGukr9kXlRJFNwNVjeUYPzUC
         m9QIwWSJZ14zx7HeCbvr4sMTlxb0U4yrGdsbhbX56UF4DO365qgAVaqpTtLSTOfcI+EN
         eZdYa3/ORV+ppjqpSIqWqsKf10+TwKzxumLu81eMr0yvWB2ywkP3dQSdCM9aK2S6dkEL
         aEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794087977; x=1794692777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=q7MbMV1rz4ncyD+3tsgr32JQ+dFMLevhy58tHK7aWOk=;
        b=s4uZcVh5noTKoWU/e0kwlIWeBuViFkeUyqBbfqonTcNRoLUoH95gFIcwm6m3lWTRrU
         YX6DumkofkW+vGgizgyZ9GNTSAA2VuMiAH65kkVK4EMLMGjhmZP72tf4vnjyWOxJowsZ
         7xeFgx6lfglz6KSemvyDavgwlPBlJu+Kv3YikP79z7GRq1YgO3yMT4yuMiQH33LwgKD/
         OYVZ/zvYwMIvWLFikYlBvJNXwI+ecDPmi3od/QYKUzwwkzL4aZaJJVtlH9GnF5b573Fd
         4DcgAJdqJI++UiZc3pw70LmgRTfMNM2DtK/y1x9+ggTUZlH6AxjhOQJma6azMYBFRj0v
         096A==
X-Gm-Message-State: APuU4Z+nsPNTHFZDdnoN9XKRQMoDZk0IFvaomoDAGwhdiZRvHdNuaGwJ
	aS9+j20kHfPjplgD/UchLIAMQNgUEkI7ne88mAmUaaZWkB522OIMtQ3RmaYcLg==
X-Gm-Gg: AYBFou2a9tMSsTNlOwNc2mjuhNJ78j/C4XRS2zruqCmGG0F6GVHHJEeFVBoNY1Vf98D
	p0BW8E98QA+UncQdQRg5CPkXDCel38IR/YmmIFb40C71Ocf8z1hWeu1iDmSm6ghhuoQ6DvZipy7
	ns5YNsAQO7qbCQQ4+n+EfcVWWV+tCt7l5cgPLMm4mghvdNiqdH2ZZRqcz+xGCDsxXBxLFUwCfZN
	smdrMeLBEZoGgWb59eCLFblri78DGpUc+erVSivRPl7I+xGvDl5J5W1cdCiR+VTCUAlCdEdu+0p
	eaKF3St5/+sfw/MziTgy4DUyMquKACIicxEpiHivxos1e+EwBUhehZl8a8bR1iqi08wtrCclGoJ
	nJXwpFydl58JYhd0FR3RHVYdaReRs+KM0A0ScDLx8KqMSTCjzncr+Z9NRBsOtMsLcAslUd6rvVU
	7gWa1srUGnIPMJBFQQ/Be8cbfZ16fmO75UR9JWqaHIRZUIsS6qETDxTWX1aMCEmpiNeLgcx+820
	Zq+mDVkePfeHOZA5qr6rYHLcvnlu//RrmGnmJ00u92fULa98G70Qrl99oHx2GaZNDNNcTrU7PQH
	KDMsC25UxwESlw9Uz3jMTP6d9sukb4nnrUa5EonzqxpcR3YgAgu0GjryUQDB2qqOZagggAY8uum
	QW24a22ISU08fLXtUr4+KA5Xj2xzNy+NWGDUB6M4QNXFKWb9N3OGmai8+aSHXKbOjqWYgVHK2bc
	uBbHQg
X-Received: by 2002:a05:6122:e22f:b0:5ec:1996:43e5 with SMTP id 71dfb90a1353d-5ece725c6camr47648e0c.14.1794087977076;
        Sat, 07 Nov 2026 13:46:17 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ece6418de3sm382617e0c.13.2026.11.07.13.46.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 13:46:16 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 02/11] lib: Add HDT definitions
Date: Sat,  7 Nov 2026 16:46:01 -0500
Message-ID: <20261107214611.388705-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107214611.388705-1-luiz.dentz@gmail.com>
References: <20261107214611.388705-1-luiz.dentz@gmail.com>
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

