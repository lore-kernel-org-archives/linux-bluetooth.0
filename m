Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898756;
	b=HFMd1KsqlMbi2MKbD2jhNb0Mfqd7UMCYtWNrMfdiKPn2CLbkexx2o5TI3PeMbZmYORf5
	 XD/DpXFitZIcglP1pmd2EAzBK5pZ2gZYAa/X0rHCL+vELNHQAWjuwMSP6C9q84Pk1OS2a
	 yIBIfxvHCwhl9IR7MIo1oSpajfFDYDl7I/5DUIdVWNDvITDNkJ4DZ3MEA2ymIMSnp7GBm
	 apqOKn4/R5OvoWQX87NO21a9lJrFDnDD3gCPqUnJEbxi6IQH6q81WMHNp3I/2DKmWgOy0
	 rKMYblKp9Q5sFKX1Ag365WZHNRSz+P5atJsAjOMRoCl8xoRLOwNIQppveK+uq3hGvhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OlVrLyzL+2ZnGkMnDz5/fhh/VZLUqVVMM3t+XxYM1Mo=;
	b=RIrExQztjb0avMVKYAqvLnCSVoGeYbhkm26od6uEgkW01pl9ZiBet5pen0k9tsBufWoK
	 s06k4+9Hnw3iuhhd1kT2iyk4z0NLmstPCU+GDbtgMAyHAZ+9+cKELX2CMl6EXox/Yg5ji
	 bxCUuaDhWxKaW4QUObBdK3yQLgl9wVmL2L6PhUprI3eoraIIOhOMvMyQPIvM79b8rTeox
	 pDtJQ7LoCH5Cz8UMTVs64G3KtBQ5xER48/BwqUQBWLqaDdgSy7+s232Xj2eWBy+VE5Ewy
	 r1rIub1KCmrRNxAcPUcQxsHZvqZqR2v/tTvH13pY61RX6tJJjj4ooAp/hj8U+sqiXBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PPEjVRq4;
	arc=none smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480ED606A336
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 17:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 480ED606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PPEjVRq4
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7ccae9f1a9eso1107932137.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 09:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793898755; x=1794503555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OlVrLyzL+2ZnGkMnDz5/fhh/VZLUqVVMM3t+XxYM1Mo=;
        b=PPEjVRq4VFxpK66uxZ/eOQtLVKhH8Y+HQt0koablbrIZL1T5wSdRZ4f5e1j1YeWYST
         IsxZicyhjLRobWIh9bNvXIao3LApP3ar2vhmORedBwbkPot/yOoGy9E9WMtV5bJ7x9zo
         UEgryYn7b2pfRH7bHWayovgWLlb+fJylBYxWD1JSCPqacJqseSNCE63nqazYIo9WlTEX
         pGPWt39+IN+oLFjViH2hzppGn7oQahYQ7InaEQhRVq5aOsrL/yTSbHWzxX3tP0/nDX8l
         /DZBBSxPEqNIuXR2wOef9JO3HPVyW2QCVZm2hY3k0b0GcckEC2ABYlmKkbWKvSiYgIUd
         OQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793898755; x=1794503555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OlVrLyzL+2ZnGkMnDz5/fhh/VZLUqVVMM3t+XxYM1Mo=;
        b=Q6LESCgBIPawmTiI5ZDa5M4Fr+ZDecR3+AHizMaRUojdBazl/OBDHsIWRXk3ymHMUS
         BUGGbv6wm1C6x4G6N9sxTVsIsw7lHicUBy6YDJFQCnJsQR2jE7k6PcU8dHYpKkyenyiC
         kbvMJIrOWkVVUKZsYB6ugTkSl7WE3Q2jnluML4B2GYzhXnOUE3t9o7yIBh0YjNLr2NPd
         qGt/6K3C0OhlYmWWSSTsv4UoTlPoLgabc1Mh/mVon7gNYUA3voXIwkmA18RTNtRZWo/q
         /NoEmnUp7YQndrpavo/My0Kpn6xP26H7Rg4hhKHiti3tJV3aSAOgB9fPWGMovwAW0nlP
         f6CQ==
X-Gm-Message-State: APuU4Z80kHRWrDFqIyizWhRaFrJ+z1COAXuYFmHIiieEhw3fX7FvjHHU
	t+xc8kr8kBAc/TGupFprWENIzJqo9XIfkBTSMUsg7lQeHMlxQ0RggwaP7JEieQ==
X-Gm-Gg: AYBFou0sk9m4ioVCGQBKdXcw/6vgGd60r7bLYC+e3v+DvzMTnY387H+jf/XHp+hpiGc
	dZ/kNuBwNi39QavH0NzcmE/FHKEus5oWWnz5gFJmX0IiJdruBm2dflE33GDw8XgHut/iZqOXNhB
	uIU6JATT0v0H4rEZR/UdFpMcxlvMHJUDT0/QZ5eviZyaIs+xRE4q0Vx+rw9x/WwDyQVnCQ9Zl72
	Qi5ZzCOsT5NoGj3V2HVC/6WpQ9Pvx+v0HVWyRn7ZbjFhk1lXe/jr9bj2CcXlgh0qxkCxhtvW5vB
	+3FqSu9zWGQ++qRD4wJrL7P5GGoPLisN+6vjRUhyK6Vkkf3PIPrbtvvQFCuLDABZDNwyuSIhk78
	a2yE/Q4+eSPuKTQK7CKUI3J+FRZlAYkRf+cUKgBEeSZj/rNoehIL94viB8OY6ffe8rjsKqBVS3d
	4bkVr4WIs+XUz9fFoCy3FaILJDTcoFA72Ydu36w8BiDYkWxGnOGx4zpn3MX4WsRIOkWugaP48iY
	q2EfqPh67PS8+LwEOzBqKoyC/9Gbudjv1VUjalBjWrqBXYjnSfErPdpUHrYS8dO3Rd8l98WmWF3
	43ZepxTRk4KAZ4ZyLhjopSycoivvr7y5LGGp5TBnF2PzA2sDZd4JMA1IZBHifD7eNjIarnvDJLy
	cvSmxd5VQCTSNY9ffRq2O8ra3edu1L91Gfp1PP8lckEyyhgK5lUI5aNPtuuEHHgE7md03DtAQN9
	W10V1yvmF4KxXk7/TzsH5QuEqK
X-Received: by 2002:a05:6102:14a3:b0:7cc:94e0:ad23 with SMTP id ada2fe7eead31-7d2a165ea7dmr179183137.31.1793898755089;
        Thu, 05 Nov 2026 09:12:35 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d277d13753sm4050798137.10.2026.11.05.09.12.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:12:34 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 02/11] lib: Add HDT definitions
Date: Thu,  5 Nov 2026 12:12:14 -0500
Message-ID: <20261105171229.2053802-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105171229.2053802-1-luiz.dentz@gmail.com>
References: <20261105171229.2053802-1-luiz.dentz@gmail.com>
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
 lib/bluetooth/bluetooth.h | 101 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/lib/bluetooth/bluetooth.h b/lib/bluetooth/bluetooth.h
index f9f22c3f7523..e321dd40926f 100644
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
 
@@ -219,6 +230,96 @@ struct bt_iso_qos {
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

