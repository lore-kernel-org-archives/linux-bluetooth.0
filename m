Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817411;
	b=djzZHYfWqwrb0G1LeKuYqJNq8GPVA3NCNpdl/Xmlj4/XIt0/9VoKi/VeY0PFyp4r+STf
	 jmKms+PNQu77RPHUUATZzjy4c5dW4/m1dKaeSlWh5XKfwSG+0Ewlcr1Wm6DBeU364GogF
	 SrfGxASExlOteehqnFE8iLAzHU3R+ykmLfKePfgCT/ZK0s3JVhMtbakz1OUQMHCvV5GRD
	 I3EnoMTXK4+WGRFUzet11/AFcQIlZH/DpWEt1KXcZGvx5u3s0XNLrsn9LxTSMu6gg2KMT
	 lybeIClJo3PCcnSDnOP0BEvcN0ooOdIHj74iM5cZs02KoZOd5Xlh50OsvyBgju4ERyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YfSPeJBaxA6BMbzHEx7Vpbo/zAyY7LPDy4nj507VA1U=;
	b=yBRbWysbwSifvUE6EqMi1a+DqG6JgQl+IMJCibAGSkK2bxc4BUf7zEnyilWtKfE16R62
	 hkTPFdMcFw14HbG2X+AZo8iF8PSo/tg34etCi53vCJalob/vpChR8MPvzrXXfev5fAADb
	 spznewl+shX4WMp1j84OqDoHAxrM0MJIPU9SnUWYazPI2GUY9SBa+yxAfcOd3WvkTTDqh
	 0lvznTrd8ig91Vwennj8BtujH9FMhGscLLPxS9FGS3QIJI0tePiHrzNChLEJBE/434jml
	 LnkHVB82qaGpZ8LASD0sTQc+gd0IyBR12yQT8cWhXNnuF6QmLlOjiHB9VJt3oR6g84w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r5gkTCFA;
	arc=none smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43362606A330
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 18:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43362606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r5gkTCFA
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-9999f21f617so211899241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 10:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793817410; x=1794422210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YfSPeJBaxA6BMbzHEx7Vpbo/zAyY7LPDy4nj507VA1U=;
        b=r5gkTCFAQ2nRdD/hCrNDHdi9nPNpZvsrerpkMxxtsSEHS+dmV5oe7Vf8NLuErtvF4m
         JtW8e+twr4sAAow6PhgqgV6qafMb8naWag0/aUfOtD91J20lx4H9V8znsyQ/tuoB0SpQ
         V47f/8lXtK1SXKfdIec4A2ZWnmBnCNqKoKBUSIApAuhzrVLZuF667IqccAgSVjZG6h3z
         l+M9hFX7WRz1i+Vmsr73gQOEzDDS+TW/dbnAcYN1+AEoE9KL4pui4gndYUY8YAbPQc4c
         RK4g4LBMXfJsk7pVsY4QOaTlVKfpEtGKeHq4aKBD30AQCsWeSSdQUP/U2btpmE0Vvcrb
         DYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817410; x=1794422210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YfSPeJBaxA6BMbzHEx7Vpbo/zAyY7LPDy4nj507VA1U=;
        b=YirAEsJCVoXq/KeQnoS+9iYuqQI8d2V9eUXcTyiyW9kGp2Mxk56inucSZxm/UcaC4V
         eJ7EDPvB8WdlVMP60j0A2obWBvPypqFjT/crqhTKW4enXZuliknUYVfa8QaudlChfAhD
         KGT2KQd5XUtCNRTZDFPpc+JTgpeb1Tvi0cKyAUm6mF/+EI4UNNoSwdWJ85lHvRd+W1au
         ssA5J9oZXCURrlZlCJ44TRwfLdblYjpRU3Gf3Va4cXu/3dP1dTD77v0TszT1VGM8mA+d
         gpUeYJyJaMjN95NCcKp/9Za+z3BNaTlbwXnu6o3BP8hY8TxU7x1YZ5O1xgl+Bif4VV53
         3bww==
X-Gm-Message-State: APuU4Z/JJ00QVtdHdeqUDfrBhPtWrVQ47jydLPatB6T+/X2xOW2KON0e
	2YzB1FDtRAVRm55+XU2vwkFJItCNQUkOBhPEqN9XR2b/FzwCk3Pe/ML+wZRFvA==
X-Gm-Gg: AYBFou1wdHbfT8KUlQjcdJaK4hmXTQd4poKBTGOehkxTh+ziOeU77RlyrekMjZQRAsL
	xSDWk2ndUUCSFa7n9wtsuoC2IYejAIRQIDoFU+DLN/3LaiwSkfTzNddmRQjUUY1bkpK+XIDWQqd
	nO0l27TSjguYIv5LFlIEmLTyAVGhqKqvvxV3gEUYsUSQ9MwVSodCAgnDdcKp8AoX5XSKZpuEIgt
	P+Q846I0vee3DhA0vqZccdwqw3YXYXlVm6yKLiUrd+vMpgGb1K/5rp2TFlPlwTtyy8Jx6MCFgVi
	CWdHUMccsHbRlolIRh1Oi1SOo3uKs4vOsnOacHjL1o9p1e/Ux8AbdPHVxMapLsQ1OoyaIbTRJVJ
	raWs0EhY0Lc+xE7b5LXbJDDnb55sJ+lKTum0q+P272ghQ4ZZDVYWIVkPgqCY0vjfG/vyByXLTtk
	p0YScEz3zvaLvUXMktT4Q61OCsj7qKQTRB9e4ORcxQ3OJKlNCtoR7xx1/604VvaM67V7IX39a8I
	F5P7xzu1sqAhZ3c4A2O2z21oESMz+codd7hzhj0KlAQfH9WH/NfapHTx87c5K8FERN7EnwQKyts
	AgprbAfTwOBQlgest8V0ywQUoTACcCKks0LdSK4U7/IhBkL3NFF+s7qZ2ypRl2gnGNNFlxms9D2
	HBzULdgBlq1n7ouYwiW513eIMSw6rlLoGAUvfCejsf+dnGzIjDIP3W6gF+JTdK73fynHE18GO7W
	WHJrw=
X-Received: by 2002:a05:6102:3e84:b0:7c3:9daf:f949 with SMTP id ada2fe7eead31-7d072658ceamr6321978137.30.1793817410158;
        Wed, 04 Nov 2026 10:36:50 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-999f3006224sm696605241.9.2026.11.04.10.36.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:36:49 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/9] lib: Add HDT definitions
Date: Wed,  4 Nov 2026 13:36:36 -0500
Message-ID: <20261104183647.839090-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104183647.839090-1-luiz.dentz@gmail.com>
References: <20261104183647.839090-1-luiz.dentz@gmail.com>
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
  direction, with the existing bits converted to BIT() for consistency
- bt_security.mic_len to request and read the MIC length of a link
- struct bt_iso_qos_v2, which adds the rates field to the ISO QoS
  passed with BT_ISO_QOS
---
 lib/bluetooth/bluetooth.h | 65 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/lib/bluetooth/bluetooth.h b/lib/bluetooth/bluetooth.h
index f9f22c3f7523..e9ed2f2f2a19 100644
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
 
@@ -219,6 +230,60 @@ struct bt_iso_qos {
 	};
 };
 
+/* Extended ISO QoS, set and read with BT_ISO_QOS: the option length tells it
+ * apart from struct bt_iso_qos, and version tells which fields follow.
+ *
+ * Version 1 adds the rates of each direction, set when the PHY is
+ * BT_ISO_PHY_HDT.
+ */
+#define BT_ISO_QOS_VERSION_1	0x01
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
+	uint8_t  version;
+	uint8_t  rfu[3];
+	union {
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

