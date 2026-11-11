Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794427632;
	b=H/iPxy9uEnWFD3qBqdktjiUS2//a7GpqG++cO7Iw2iFWYfeOu8WYgkQeGMlZ3lbbWnQr
	 +23qzrg6ysnpYm35iKPu4CHB/lIoEgeMtgYHxgt1Xi08H3wSE4+gN9P7Pm7qEZ0qXvoLg
	 Q/2xZY1O9XPI/EqHIMsYevcvMtVrNQ4dg0rHZLXfBt3Pe0P/STZsKlNylMaGmNuN+UcMt
	 1lF+oQDjnwxvf6/RNgeRIWd6JlQ8fLxq5hqAfW6s7/+lHrgtYOwdHaBc4v8fUFn2xOCuC
	 b0iwjhVnndc1o/zzAz2dHMT91I37vbUxmIHI19vh+BoexyPpe9XIhf/iBaZLspzHo8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794427632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q7MbMV1rz4ncyD+3tsgr32JQ+dFMLevhy58tHK7aWOk=;
	b=GxMdDmEl6ERC42XoZlfIjuNiGJpYbPQSZ+D7O3zBp79TLIhC7LTQ6dR5q2AR8zFB+pLa
	 ecVwPdOdCVSSGPEcRtpXkNyCzoz4Sfk3vHPnvOVeq/BT5EIduzyg2t2fv8bqGuVR41Xwa
	 tsTTKlQ0mNBU/zXB0IrCx0YLnqkwm+FHTzmxwMDjUaxFzDor0YY0h/AEXIKem5Vr62/iW
	 qikVgfijOE6pBkgtJtDnL9+UE72WhTmtZyi0qVyhzzL6zEkPUj+fHC/xGjt6Q8yhwKUz/
	 VI8ypV5VmIQxj8wpfbjNJ7dHFIxSAXHM14VYDC5ItB6rbdjZ7GOHW6AqgwRqOslG9gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AZxL6Yf7;
	arc=none smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18331606A32D
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18331606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AZxL6Yf7
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7cc3eb09dd2so1154133137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794427630; x=1795032430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=q7MbMV1rz4ncyD+3tsgr32JQ+dFMLevhy58tHK7aWOk=;
        b=AZxL6Yf7P7qWZd6pFBGn57rA0jqjm9dja+F+ZCJkeUXUoc9XN4ZyNQQHeyZN5obV4l
         beynUFDESDf8HJkN5v17VkLPdkEODFroF3+Yydq2hLjsUsDyFZzlot22CvevxOhskTAT
         ZqqMjcDXi1DJrftYRoFtSkLcr3FoLfuDaEvK/UPOqNKCQwYu8//JuRMdNMZ6+qgHcCYV
         1Ell2Q3cvU8Pgw2DJQDElze2d+7xFYQIJY7q08dj/7R4j11rjNACJiWfhAOI2k9ucrHX
         fCTZ6B0gy7XTP5PQyzZ3jHgdB2IgTbLj4exM9hPqHscQQ8duFbKPoIum+OX07dUt5tJu
         1BDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794427630; x=1795032430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=q7MbMV1rz4ncyD+3tsgr32JQ+dFMLevhy58tHK7aWOk=;
        b=TZ3AvfiP/ot+6KTmRJqJ+9ZrnWrNV4TE+eynJIJorboCv98Y78uqj4i39wgiNDGqdm
         slv01i0wP1ZzjbZLu1+dkcR2vYPMEN/Z8hEnY504cwLQvx7LVV/ODlG+7mfWw5WkP+EZ
         SEOA9fYnvTEJ2DyuG/UbIgCyAThX+V6kuFNT1avOTjvLHogPP7hEHH4+naqM5vNgKWkZ
         rpwidVoa8FQy5VrCmUyECNkSsWM2mmpNc/WDdbIykj7NfT//LppntzvBe2XbHRTtCOk5
         KPo+5kVuoG5LMJ4IZrAdbH3PdYbiZiyYNyHTexxF/lvKusXE/nXZGJwOwMk3fcwwoGcu
         cB/Q==
X-Gm-Message-State: APuU4Z9zaVCOPadL8KIX0G0F14xTKK1n5ljLSMT349FSr1SvA+vP0crn
	f9rf55xlBcWhjg+7yKmX8HnmfGr7gt8eduXqCJolv4aWtpvNzq5qnZSaVlZAJA==
X-Gm-Gg: AYBFou23Dvvhxbqogkv0ArHczpOr7vOR2rlBLkiKGjpzcsLQqB2BoLIgfMhVn/oZ1JD
	qisY9yBBW/0q9oCNIZPbPofi/V++T3ppAIi3kxUHaO3IfyskKCP4IQUJqMhtPVIXsLy0vXEEQey
	oihEJnjTwf5UXHSTVBss/wvaLdWav9OHc607fWUJx4lzfPYv2GQFzoyC7NljwL84xO5i7wXLI5C
	yF/ECNRiRCqt4LJ3wIKnQXaXzSGzh6/CLyuGk8DpWkYakukEnZ83wwxZMLzuMxKqWgktmKCrB5p
	T5EB51r6TUQVu6LmGt2tyqbH6rJNZ+3R76LkmQTQdfAbbPlHZ37o/eRc9EFJzYqwIYqN+35kaIo
	CtLP4vNtyJ//mLoZ+Wkyztgg5qahaHc8nlaLOOx3cAREy983eXs2bJLRCdSapXoLPJOvSwnGy85
	zSxig38JVNwUl4thr9biOvid+VIafUNEsC3kczkdS9fJbWokA9e+MoCnqlzEoGe/EEOeMOk3NQA
	ZJNqGB+W1DOG7A1wFQd8Z0d1vJW6GhN1Ya5DQEOn8jDbecZ4XiDG/mc2zDOiS55UBk9IbaBo6sZ
	4ah0ercMXYStzNgdwngegD/Q8tTqIyVbZFq6CYjA1rLz2QFieelZ2DycN7Xig85wkh+LyFhxYJx
	Z6iRbBCxUDtXqCM6Yof84PuIKEO4L1fxd4hsinCQGsrtpdMjOcusl7clRv336/4UEexa7m3GxJd
	x9BUZpGppHxyjksQpFP4LrRHRc
X-Received: by 2002:a05:6102:54aa:b0:7d2:7c63:5a0a with SMTP id ada2fe7eead31-7d4fb2d462dmr1167563137.23.1794427630052;
        Wed, 11 Nov 2026 12:07:10 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d30209ff97sm4954449137.0.2026.11.11.12.07.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:07:09 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v10 02/11] lib: Add HDT definitions
Date: Wed, 11 Nov 2026 15:06:55 -0500
Message-ID: <20261111200705.3802779-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111200705.3802779-1-luiz.dentz@gmail.com>
References: <20261111200705.3802779-1-luiz.dentz@gmail.com>
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

