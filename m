Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989095;
	b=JVWdhpu5C588O6SC07zSkhWgdZ1VuhOcKxS2V10g55K/FcHPYXzgPOmPq4hQ69BmQW0I
	 xU4J5og3bXR7Cno7DjfjQ8vzBM1YEif1QCAsQG62F6lpR9ddEo21p+c0n2NUK5+OnrNfo
	 MjFhQmOaW708ngR1LhzSDhyzA1Kr7b1yv0D4bjKjxtJPrQ+1317jzpaq3gSu1Kq5sSCm+
	 /LCXZEjiF3LBv0NlT/4iOl1qt4MduMI2mKewe7Ehc1Fj2G7EnVHXGrNTCrowHBBlpIp28
	 Df/+VekXw9U2vo603jcHrW93j9tHhvu4AxJGXkBzgNA8/rA7/ip8mAaK0nEmMz+Xlng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989095;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OlVrLyzL+2ZnGkMnDz5/fhh/VZLUqVVMM3t+XxYM1Mo=;
	b=BWQNugS3ntsJB9CEd+R1luNm7Vd6njd5nQyWBiQn0rGegaI/BpPo3Dee4cGRBWZ7Rj8y
	 0aYVyaFUnG7yWrxLd2whaPKXD0pymswUXmVu8oBfJcTs3A/EBy7LuToDUnCf3peTCfDr7
	 NYnmGPhHX3ZUCi2Cl8C0eUq9bUoviy/GGbmfSjpL3/BSAT4TBVB8rk0LcSSpYXWZ+NheP
	 LBoaSNP1tIQgmE7VSI0XVbBy3jPgv+CN6UL0EB2CQH0XBoqFBGGlW9LBH9U8MPVxCHIcV
	 AhO2S/GA66tpYFBixjYj2pilQdVyfLwb3RS5hJ/ue2fZZSgsnwQfMqbpvO6fhXgLjHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FWzzUTkP;
	arc=none smtp.remote-ip=209.85.222.46
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD02606A326
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 18:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BD02606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FWzzUTkP
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-9908c849564so279263241.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 10:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793989094; x=1794593894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OlVrLyzL+2ZnGkMnDz5/fhh/VZLUqVVMM3t+XxYM1Mo=;
        b=FWzzUTkPJkhCy1E4yv5kCKNkSr7Xt6+OhcrLACZIy6yRCcjw7qmzoEpCSuEML8Gp8w
         GfME99lyMKxbToMpCpcXwkWIBznyWkR/nD99gEgwV0/CBF4yVlYEbgMX+O7ObK6qpC7y
         iTk1ycJozBnPP0a3hrAM4sgTTZM1N6qYa2u62ZdPTRe/Tzp5JRusc25n2E5Qy1lGWO2u
         w5Y/7ZazfbWgfXjnSxH4SambVgV7wtP8cipBpVKFc3x76LU9/Rd+Kfvi/m8Av3XaiI9X
         lYP5MZR1NBZTFVBmzorkrNRAXRP8h+ZV/7KMAHEC4hNTbijPr663nIIjGFd+cjzN472y
         vw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793989094; x=1794593894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OlVrLyzL+2ZnGkMnDz5/fhh/VZLUqVVMM3t+XxYM1Mo=;
        b=usoPErKY9KzCRht7n+GlQ0f3iLt5xizBazZ7PL0S8jBXoaTLyWFL0pnRhNOKu1LvTU
         Z3RDTOWXUVQHA/KRBBYwd58yEfF86ldk4YHK2GZWNVD28wzBtemfIgAI0+OBvV8SVJz3
         JGPhpoifYD9ZypgmNd09NyYAzxzYCqib0zjTWp6OMtnOi+0jDcMX3WVWdU3s2yGuMR7x
         p5Ez+RHIjjfP9HMkMw9CDTCjfoVgMEa4RFYmMT8IgkFAjKcIw8SnvUwnGbUajqPNVBdn
         UJHyZuMDXlv5LkaFwLBs+HKC4W4dP1J6GaQxcRJacgbUSx3KHZj4GGwMqB/oiYys8NTI
         nFKw==
X-Gm-Message-State: APuU4Z+NHi2hc12WIb9HAjP0fTVAmwdZfgzS0Cw7hMcJ3W2UHvgSdU2v
	Vw4bKrwZKGWo0B9GOfwhGnaAwrmykonWCw8W2/th5esI0ZTDhPtZJsN2w8FNmg==
X-Gm-Gg: AYBFou1NVMRrs+PIGxnL0hTzJhck6Bewjd+E/1DyGCmTEbgO30lc8jLuUOolJUwmZQv
	Q8R59XKl+BgDG0dEMOpR7mx9uLzUsIGue5TZXHDCYJUPTJVvexuyiZedPTFlplGO+ROlCqGTzIt
	TxBreLOqNZjt0GrbEt0mHNxiase/6XP0Zu4/Gm26j+IdtuN5rhY10RS/AAOBaK5Bl3Tn/PPTFuZ
	g/mHmuGVIvXJ/PFiDvR1I1pACHAocVIjlPB4FHRUxdYVfsgaG3gQ8/PgU9E9tAPO6Hr0uyRuiNz
	BIGB/QYW8YZOPhIMwkr0+S4NqvLcRcgzgkIOjHMb9+zdzL4YtEvzrYgRl6ZcYHRGA17yeqDKVbD
	i7UpbKBnurG3x6+57q288HmWEjYNDWZbPLkB0gWsqslek3ekk8FyWO7j2LXxb6Gw0jjiNrpPtvT
	mMLAnREsA+zsxUQq9vFbpbfY0Sddsrcz3LptrGkGJhHC7K/QCjiQxCypPcSWtBE72WQt8UqzFM5
	C7lqtoUVVPqmrjWCz8hUU7XT7EiuXHEVI+eUqVerm1kGk6EzoTvGKMqM0w/ihOfybGlgzXxG9uu
	WRuwOPsK6jBbUhjtP7fd9CcDDiX9/u5oaAeEpO4N7a651WULLINvY0G3AAN1h8gXQu+h/NEewFq
	7c0f38d4y03oCnm/DBVtcRjiTLabPK6lq1usiVlxXAVhhBRA18yiyXKPSXsbn+B7SnpQ0hM5x25
	43XJY=
X-Received: by 2002:a05:6102:580e:b0:7c3:9b8d:5124 with SMTP id ada2fe7eead31-7d2a1583829mr1682747137.18.1793989094244;
        Fri, 06 Nov 2026 10:18:14 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc6517dc0sm1922904e0c.17.2026.11.06.10.18.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:18:13 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 02/11] lib: Add HDT definitions
Date: Fri,  6 Nov 2026 13:17:59 -0500
Message-ID: <20261106181809.3134862-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106181809.3134862-1-luiz.dentz@gmail.com>
References: <20261106181809.3134862-1-luiz.dentz@gmail.com>
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

