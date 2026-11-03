Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744390;
	b=NdWfhnJ7lynF/8/34clX4n/6qoI06WlccIGywotKAl8+qGVe4GOQ7zu4i5D8rmeOV957
	 G6BUpTXWoFeaYPlXgLr+tnGmgODLmapK3V9bX6cwC9jpXwiSlKr2F6+YqKBHv9tskjtOJ
	 ZY0w2B4v2g4nhXVD929AWWPHoL4YBle51MGrH1snGVPrNHs3JL5kt6FNY3XNSmAfp9eN5
	 3G6iYJUfuXKzC8VTAu2qADZzsjP0xPfq1eWkqiJoo7DOFy0GCaolIOgFL6VnO+qiSJIW6
	 j6wXksHA7acPLELepxvxSkb+gLo/YItgwQQSBpn1GjNowkcCW+H09z4cUh2yMp3wyeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0WuycRSFi1DngoXGBsTTVvwCTH1nRRwBj79zlBVtOjE=;
	b=bEYCmGy0FlxXknyf5QUms3k14XQWGxVs3gsZrkFsACJjmQqaEIEhh1CbfphLQ+qDt5JW
	 7+pQ6IvPNcNn5Yp5PGY5/ahbW60ex9P6Q1Tp21/h8ZvL/gAnYEqQnj8xh0EMRFQKdrKsJ
	 2FA9liZMml8zd6QtwNUNIS9jvVuJf14o43+Bu/IviXBhUzMs9hSVR3LRoF5AwNJUWI7DC
	 0bHkNkYC3uRoXorpqt3bX40cgFiNbddgkw1HSZWs65kgAfjldOtgIFsW+nGdrKszU9Fnn
	 Q2IqFtW11syhIIQzhk/tal2gmjwEzebZbybBLRxJr6sxBYbGv9SbWUFljPNgwcyM4wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gvzmn7Ms;
	arc=none smtp.remote-ip=209.85.217.44
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D56E606A31B
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 22:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D56E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gvzmn7Ms
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7cc603a168fso8427137.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 14:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744389; x=1794349189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0WuycRSFi1DngoXGBsTTVvwCTH1nRRwBj79zlBVtOjE=;
        b=Gvzmn7MsVVnRvPXu+VcxCTFUXoscYMWM7TXsFL2F0CEK1txY4vL5Og9rhDWrDydL8l
         IcvzVkgCUuW8dvAVK0N7ddErwNG9E73Z2x8nwKcRbx9mtWUCWqItunCSIffh/ya3XcfU
         7nCoRHLceLgeptyOJBwtIKoNANVixdXKpHR80oG/YVMhX9p/dh88ie+sor2vVdmHjrC9
         TqdzGLa63q3VaSdv0wRrwBSOKh/iPR8SJkKLEt5qehR9BKpROl/3BmCe/tvqbLT5MuUQ
         ifixijO5rDYoMPDary6B4HBQ13pHh5n967cf2ZlX5ruCBTG9x0WmzPwVBxlX5/ytF+jO
         rlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744389; x=1794349189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0WuycRSFi1DngoXGBsTTVvwCTH1nRRwBj79zlBVtOjE=;
        b=nsMWDpf9XohsnuM4U/viFY3SfC487F0jmBMC9BKlCQkbBhLGqAEB/uoocjw2sQxqdY
         lXCt8Xrf4riovDNkv3zMpGa9haBti8NTQ06F40j819WIV+gXyuJn9X1PvduHbKLUo4OJ
         mNZniOsbgeBka0O8WQ9sTtzSdwNrDo6/3bb02D5noWD/EyoyTuJ4RoBCUli7uoMYoZZj
         i6tykGt78j0ZF4MBf+ugQjJ8cpm39UutihwigqCKNHU5DKR2TLX3nmYQMLh5TLOY+MYR
         rrFKTG74TTTfJzitvTYTllIgS7lG+qnjcaNL8XKiLo/1OhQXnXXWaCxglNpLbnaCUoH9
         7cPA==
X-Gm-Message-State: APuU4Z/fls1iDFwxt8A95zQWDhaAJL/IqtTWDvHi7hHJ6NBDDEDlqBBd
	hFmdORTPmX0SGyHFUgRUISFyxOCaT8l/8cis3fKQ+BM1fwzKB2EZtUMtKG866Q==
X-Gm-Gg: AYBFou3T0uhm8zYVtWK6vMPZX7fuUo55VTI9o0fLfl72QB2cZ1yC2r+DZRnUoEnG74Z
	OdWDFCwtvClQoknhTdqGrWtRPNHwU1O3/AMb8fkA6wt43J5BSfDK9HVuBQXX0HFR6G9Fp6lpoUN
	QnwHLBUpmAJWwRp2nUpfuPEmAGHIXdD8YIztGqIQ+cwla/Yn21Ifdi6jARtcXxHp+khC0LqTcHO
	XQWGVi+RCknm5aYyBTMyBx9SdAIwdlF/s8XKXV1Ens/xukQpYRihuVV1oc0y9ZQ1K4tz5FD1dx+
	Xc/Xa7zrWT+Wdee6lBIA5VvPwNR2UJUXGGf+OoK4BTdRiLciT69o62Pn8zIcB/PpuaHR6nzYYxF
	S125XY0cNymHRgyVKLSW/2jNPa35zTxvNy/fmy3wxv1E7c3lsSQjGGod5E89B4TFS9optP0099e
	A/rtjd2CdCpxjqUiHpIYxavUtmofQnpGp9+7AmKvJMIUvZ+RuROT5Mx3GmHuVuOt5EYNLv4XEvU
	ZqLWWvT3msM+DCf3fhcN+nhEVqB0frYZ0qsUhPehDKG2hU/SWgWrjZAEI5mpFDwdpVaPc12zx64
	1mT+V8NsgJj5B+hCljBJ1PWAi7zk097WtPaaXRRoqMQ2DR9EK+8o0+0Tmu3Gkxr1/Rs/hVXgb5m
	SVFB697PWb2fdoZCs/6hrQhDLtuttjuMuPdUgSwuFiRo1Vc6ky9yp5pOjCY6F6tXGJBTrQhfZWC
	ieiCo=
X-Received: by 2002:a05:6102:374c:b0:7b7:3acf:bd3a with SMTP id ada2fe7eead31-7d07277c1c5mr4724195137.4.1793744389251;
        Tue, 03 Nov 2026 14:19:49 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d8afc268sm356591241.4.2026.11.03.14.19.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:19:48 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/9] lib: Add HDT definitions
Date: Tue,  3 Nov 2026 17:19:35 -0500
Message-ID: <20261103221944.4072041-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103221944.4072041-1-luiz.dentz@gmail.com>
References: <20261103221944.4072041-1-luiz.dentz@gmail.com>
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
 lib/bluetooth/bluetooth.h | 85 ++++++++++++++++++++++++++++++++-------
 1 file changed, 70 insertions(+), 15 deletions(-)

diff --git a/lib/bluetooth/bluetooth.h b/lib/bluetooth/bluetooth.h
index f9f22c3f7523..4f93ad8ccc9b 100644
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
@@ -115,21 +116,31 @@ struct bt_voice {
 
 #define BT_PHY			14
 
-#define BT_PHY_BR_1M_1SLOT	0x00000001
-#define BT_PHY_BR_1M_3SLOT	0x00000002
-#define BT_PHY_BR_1M_5SLOT	0x00000004
-#define BT_PHY_EDR_2M_1SLOT	0x00000008
-#define BT_PHY_EDR_2M_3SLOT	0x00000010
-#define BT_PHY_EDR_2M_5SLOT	0x00000020
-#define BT_PHY_EDR_3M_1SLOT	0x00000040
-#define BT_PHY_EDR_3M_3SLOT	0x00000080
-#define BT_PHY_EDR_3M_5SLOT	0x00000100
-#define BT_PHY_LE_1M_TX		0x00000200
-#define BT_PHY_LE_1M_RX		0x00000400
-#define BT_PHY_LE_2M_TX		0x00000800
-#define BT_PHY_LE_2M_RX		0x00001000
-#define BT_PHY_LE_CODED_TX	0x00002000
-#define BT_PHY_LE_CODED_RX	0x00004000
+#define BT_PHY_BR_1M_1SLOT	BIT(0)
+#define BT_PHY_BR_1M_3SLOT	BIT(1)
+#define BT_PHY_BR_1M_5SLOT	BIT(2)
+#define BT_PHY_EDR_2M_1SLOT	BIT(3)
+#define BT_PHY_EDR_2M_3SLOT	BIT(4)
+#define BT_PHY_EDR_2M_5SLOT	BIT(5)
+#define BT_PHY_EDR_3M_1SLOT	BIT(6)
+#define BT_PHY_EDR_3M_3SLOT	BIT(7)
+#define BT_PHY_EDR_3M_5SLOT	BIT(8)
+#define BT_PHY_LE_1M_TX		BIT(9)
+#define BT_PHY_LE_1M_RX		BIT(10)
+#define BT_PHY_LE_2M_TX		BIT(11)
+#define BT_PHY_LE_2M_RX		BIT(12)
+#define BT_PHY_LE_CODED_TX	BIT(13)
+#define BT_PHY_LE_CODED_RX	BIT(14)
+#define BT_PHY_HDT_2M_TX	BIT(15)
+#define BT_PHY_HDT_2M_RX	BIT(16)
+#define BT_PHY_HDT_3M_TX	BIT(17)
+#define BT_PHY_HDT_3M_RX	BIT(18)
+#define BT_PHY_HDT_4M_TX	BIT(19)
+#define BT_PHY_HDT_4M_RX	BIT(20)
+#define BT_PHY_HDT_6M_TX	BIT(21)
+#define BT_PHY_HDT_6M_RX	BIT(22)
+#define BT_PHY_HDT_7_5M_TX	BIT(23)
+#define BT_PHY_HDT_7_5M_RX	BIT(24)
 
 #define BT_MODE			15
 
@@ -219,6 +230,50 @@ struct bt_iso_qos {
 	};
 };
 
+struct bt_iso_io_qos_v2 {
+	uint32_t interval;
+	uint16_t latency;
+	uint16_t sdu;
+	uint8_t  phys;
+	uint8_t  rtn;
+	uint16_t rates;
+};
+
+struct bt_iso_ucast_qos_v2 {
+	uint8_t  cig;
+	uint8_t  cis;
+	uint8_t  sca;
+	uint8_t  packing;
+	uint8_t  framing;
+	struct bt_iso_io_qos_v2 in;
+	struct bt_iso_io_qos_v2 out;
+};
+
+struct bt_iso_bcast_qos_v2 {
+	uint8_t  big;
+	uint8_t  bis;
+	uint8_t  sync_factor;
+	uint8_t  packing;
+	uint8_t  framing;
+	struct bt_iso_io_qos_v2 in;
+	struct bt_iso_io_qos_v2 out;
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
+struct bt_iso_qos_v2 {
+	union {
+		struct bt_iso_ucast_qos_v2 ucast;
+		struct bt_iso_bcast_qos_v2 bcast;
+	};
+};
+
 #define BT_CODEC		19
 struct bt_codec {
 	uint8_t id;
-- 
2.56.0

