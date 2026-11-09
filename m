Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240960;
	b=5fRjddC9e6iJkC3nh8IPUNBThyf1oO3RsEYe69sBDW+hQYUTQ+WdF201oohvbGbJfwiN
	 TWAciLlRm378kjBrYcGXgWs9og2coRhOid2ExBxDZQYgaXwyj2+26q81vuUqPCD0/mZFY
	 7Bmr2BijicuNF6Cqd/ypGdn1v+sInucrl1w7EVPDLr7iA8Rh96QL15uHacNZDk5b278YI
	 TCmTd4i59vxbYTeZOhK++g0fqXLjH8vSgN0tq+7PwU+JGrMqHV9xTy+35fU53eXjvwbrd
	 B2upGIpjESwdZprE+qu8RBhPzIue6LAovFay+fO/JaGw9o3r10132zyNirOSNjh7sZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240960;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q7MbMV1rz4ncyD+3tsgr32JQ+dFMLevhy58tHK7aWOk=;
	b=wxO0janrJbkJ97bKgJ3fEuRpPHKgyoLncaR26DZ+gasIq9bpImt5qI8oPahsY91j1FLI
	 aHZzzUg6FX/ufAuvbOzSbcxUpCkwDOZOseepS8+QFxXKSRE7RQx26Ne1f5X/zLcN593lh
	 /0kyVrlxl1LGC5Mp9vDCPHKc8R+6KP/fk8vDAC3b8cb3aYzFS4sprUC9AjmOfPdr3nT+j
	 3uGGwx8MTrmpvEar27LyG09FoUtBzu4Gs0YmclEbKGYRvQzhw2JfcWLBWqVKdB/ZzVqsz
	 9znnSgpVluG0MLFP3KRkNsi6bIXTohWNFvgRZ7XHkzraqRb4uaksBrPLIwy+z/+3fYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=04UobFj7;
	arc=none smtp.remote-ip=209.85.217.49
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530B2606A325
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 16:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 530B2606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=04UobFj7
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7cc603a168fso420807137.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 08:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794240959; x=1794845759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=q7MbMV1rz4ncyD+3tsgr32JQ+dFMLevhy58tHK7aWOk=;
        b=04UobFj7KhrZ6G5dy5kPJkboQuH0Hvq0e8bwzOmRRLBO7422fxGB452sKO+oL97Tev
         5d6KT8x+jU3ldiP7xbJwbmgaJJMbfEmZxK+h3JBhhapdHCDUN2BY+h+nP8xkVWqvvU/5
         NN77vQUd5wjVsd6fAclNWazQzp5rrpn0u0Zz1L7TF/EVYhWBE3XcEIGYQosjfezbrrDW
         c+aRRw9N1DrQkfduTwfSdDblnbAfcxC2AIdv81SSqTnBo7U47uy9bSwzoYuiCioLznHD
         1h4GZ9Q1v4gQiTH6pry2r/+ZkjY2MSBKk5Bqfw5JmQBeBhfYkZgxmIemac0MuSAf7o/i
         aCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794240959; x=1794845759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=q7MbMV1rz4ncyD+3tsgr32JQ+dFMLevhy58tHK7aWOk=;
        b=VNsr0wRDU1sPGvZnnEehVhrq5V5KGksL/bOmKcJJUxnFADULj+HfU9S2/k0WisuXxO
         jtp5/IfMVw08LZOYJD7L9lcZyK9xSRSa+OAlFL1qLZ1ESBwEX3MAovta0Z2W6XK+yiZs
         Xxg7zqxK2vharX80vZ7YG1PA19qolwvS1LEBMDXA5hPHZO3wlFneyy0z91m5AOnFMhzI
         UmXMboblDS8AmBO2NEPKkfd2C7tUqIs3PgCxzB6scgq8CqvJnSYtISjU+L36qy6gfffk
         JdzHHrnEhLvfd2X7RkNxXmFhmBQ9MI/WLc/SZbU6paZzfUkL7enS5zbqF+4YMwkUJfha
         9xWg==
X-Gm-Message-State: APuU4Z+wdQ1WEK0zKRWvx4mrzw+CZjwFUZg6kBFr1Oz9eFyz/1Q46lqc
	2HR1N+0z7vH4QHY2oW2dP55tPwxZh/1S6Wl2G1nmghIx2I/0XLfcVkJy840TKg==
X-Gm-Gg: AYBFou1gGgxntZ1zpkRPEL1mSQK3wN1k3WMD29p/91/LQVX/bN9+UyriC5Fk8G/hNtY
	pc3z+UK1tzQsUwcdo7n39NM6dyYm1KLFpQt75QfcsjFYaXa+45R2szFXD7pZBRWXl64/e69/yn8
	UsudpgyKY8qGSJjc1s8nev4KJQ2gBx3ob4nmQau2WoCsb3m3c8siOjqJ22DpQfuxxiVvf4iTkbC
	Bm01X5lGP+LPMtxYavmGlEPbIYT2UM0jE189CD1fbObHOSoOSw8lbGwDFzvhC79JQB551SWVxx1
	1pIL41GcnpM58ljPOt5FB6NdCUa32UMSGReI4iLkCIwfLZ4oDvtEIEs11h6e0vz8SiT6GSrtW1h
	6M8XxXDMXEG4q1VViVJ8e0uzcBk2vvqEgagw1/FtcV091QC+tqVokzWqw82hE91GEuiaoOE68ly
	xE7r7GsPj5FHd0MGxluSqsVx5coUuzZXQcqqnacKmvWCh3/NcoOYzq22haWtqC8hLy+gqG+4HbB
	edph4a6srrhzEojH197BkDI638IkUMqfFs1lgI814udGpUapRrCFQI0yKgaNaoHPEVxtpL1A0Wr
	0CmnjTVGHpJhWLbHrTPXeeitjOVC4QQzqgnzz99AUYqyenSJogRMIPYZfy5w8RYR9UE1CLh6gnt
	4BDYkv7prqIjRFafUC9ZoQWoWhrlktzwKBpL+XeVnv/mgQWbdAS5yBqR4lNeXG75cPa+2GtLc7P
	Zd/Ti5ngfN/PWmezPk03khUtlJ
X-Received: by 2002:a05:6102:914:b0:7c2:635a:4f4b with SMTP id ada2fe7eead31-7d2db10275dmr1175670137.29.1794240958743;
        Mon, 09 Nov 2026 08:15:58 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ece66b77a7sm4562733e0c.17.2026.11.09.08.15.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:15:58 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v7 02/11] lib: Add HDT definitions
Date: Mon,  9 Nov 2026 11:15:42 -0500
Message-ID: <20261109161553.1506041-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109161553.1506041-1-luiz.dentz@gmail.com>
References: <20261109161553.1506041-1-luiz.dentz@gmail.com>
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

