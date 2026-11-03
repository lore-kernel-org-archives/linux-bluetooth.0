Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793737819;
	b=gDM4dVeLyz+UVZUnfKnRXCTrRdsnghb5l3LUrnG6hJ4IJG5DEMmRpv8lEM/K1aUluIK5
	 A344J+yFXusdM/Hky0u5ZxYe7CrUJ8l+4FM+bolyw4P7MxGRlOv9XjO2W6MNTPZ2QHJtT
	 v5x6NXlb5RkpDovlQLGsarJqITYOEuocdCmkNqYFjnbmXyXM/VSiyvzZR8kX0Ew1evW1+
	 hscfveSFn8r9t5RG0cnCxE/HDZc8+toMJvvXZZp5kR42cRO9IKbsl/rdyLsQlyMjom9vJ
	 YnocSOf5ZfHCOHrRouocABiobZCT4Xi1EuRysR5Jbws9My6eKQKDm3Ovat79GYuzckg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793737819;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=itM7zsiVdI5UXLe8RTBovMbkspc+Nb6u5NIlO7xWjf8=;
	b=gDQ/ez5TEASKtNGsilwo8viTVLKFh7OYg/SUirkW1lk7lP7cDGS8+CKOXnnUmlZwjRum
	 lHD+797TPU07Bttv9cjnaxqwYtdbCEDqbIhv+S0EPIsYo2G1CW+o1Ne3hdGYr7MUkVONN
	 rajtvD2CVByXlKqrNCRLvvA0QzqAsBJZjk12tRmy5t5uPyhpgdsE2p9WzDWxtAgKgS7Ov
	 WYRU9sS3yE/igJpqF8vlaQxZRQDNRAs2rhH1hrBFIgkjnU/ooA1sJw1qUoqj0yzm0XqRX
	 D0wUISEbX9kwzBBvuubYvIqdx/uE/kQ7xIWFnke09CUidly4lQTIJOtAH4ee+/hJeqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WdEQPvbB;
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F068606A330
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 20:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F068606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WdEQPvbB
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5eac319a6c2so3577925e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 12:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793737818; x=1794342618; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=itM7zsiVdI5UXLe8RTBovMbkspc+Nb6u5NIlO7xWjf8=;
        b=WdEQPvbB33DovRyA7QvIeSKjmir8oIDxbySmL8LJT2B9MjD3ISp1KGx7fz+JkC3iVQ
         NF5bIgJR+pFc7jou4RGqvi4gK+NjOZLUUcFBbGo881IFPQhV24b86o6noBT8db6gKy4D
         2nHkKM6lLMjE/IHa/yOUxBLjALA3L6jlAI4yupr2TwRuODRvQTa+4cgEPzLGzYiomb0w
         GsmIgiS2LzlXYLIy3OgWCSwDVNGSCZg3c0P5DMnGnKQwkryj3Vvs6SdWtBwzf1tmr0lu
         ujD6hTSmHE4ONmpnlSbz4DZCvIwQMyVdXRCjni/ZICx3W9waFig+vX4dHmKTWChy5dK7
         MlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793737818; x=1794342618;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=itM7zsiVdI5UXLe8RTBovMbkspc+Nb6u5NIlO7xWjf8=;
        b=ictnQqP+9Wyb7hswIEehdL+03i0ooV+qHG+9GUOP9Vs/0Y3W/DRzln/J96yizJS1xv
         Sb3+1IdIw8ZEtLV8d9YqxIFVWsnS1r1y+O5iR8TzCvmavlRV9yQz+/2KK0Y2UHBDLCec
         dd7euQ5G6C9K1zL6KLr7IhG1pFOIqlCnOVXFjjni1aeYayfKjYy6zmhnWATplsVCYbAj
         pu9WOFZBezvxrjBXc/9Druqow0Pl2eCnNHOFUH91PZl4g6Xg1qQ1T/csRedwN7dEJxm8
         XR9sqPv/MSlyFdHsqX7nRt4OlUlRZIwyFqtr33jjzQlIy1INQhVNjTNOrfK/Q0R0zT24
         0btw==
X-Gm-Message-State: APuU4Z/mIia3cn9S22WobJm97lA4emuZqE/ET1XSlrgUO/rbqT76xAYC
	cFnFZ/LQr042k/YDYnOwljoSLIf+ZI+1FeiQ58TIIIeStC++++P+GCJAkYya2g==
X-Gm-Gg: AYBFou3nJF7Z1Yj8JJo+I59LALA0wRZ0T633nK7ORIWFHozaWOMGfQ4poJw3A+cHpqK
	xrCgw7/yuJgcb5S9YUb+SSlWha8H1sh7qoIug487EG8cT+NPzuxq3/c3jTDCBadaniQrVqHP/5k
	iL82H8V2S2DD4knnw5sZEoPoWoLvjjBWJp6sIHa/LR1JsZSfdFIXwFAXETFTC4NFlUy/iumDiIx
	QmYnuSJQ+19RIMJfntCo9aqIjvN+QvydRN/Xb+lCVQtbZgnd3plD/k1GT8pwvZlfycHjWnV0jux
	NB/Lq+Rci8260VlsugXb5b5iWb3zgBHjWm6ii6Juxj26kjtGhY61VDMaT9CyXklSr728+KUhd+R
	mMiFzWrEC2mozY5eM11lINHhrjpK9mC0IiVOLW+Mha+z9+VFyODwkbbp/5o9INj7QWbH4z/wtNT
	FSz94Dnl2BAqsYMZoZ2r+uDAMkrKadQ2KCICltuG9UhnW3JI8SO8Zmg8r+ESOpyxh2ySD8WJ+e7
	OK8S0Nt3eCpYO/45JTet2gGJdbD9/oJNB8zSuwGd8vFfSpJAYOqOCtVN3P06t+NSYWaNGDjmS+R
	P7sNPhqECdjJPCffRyzc2XL2YCQZRuM+QutldM7swhQ0+7Mdgj/LLIS4eFwVBwlIuN03wK0PXoY
	JssG0FjyAu4Tp2rX3jglVTix56+VNmof9stps3tBPWBM1qcfGd5iGLUD9pCZfxM7o4fH/nr9D3q
	JMGSk=
X-Received: by 2002:a67:e111:0:b0:78e:1e0f:ea42 with SMTP id ada2fe7eead31-7d07223fbb2mr5371016137.2.1793737818092;
        Tue, 03 Nov 2026 12:30:18 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d91d2a3asm139916241.8.2026.11.03.12.30.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:30:17 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/7] unit/test-bap: Add Notify Multiple test
Date: Tue,  3 Nov 2026 15:30:06 -0500
Message-ID: <20261103203011.3904290-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103203011.3904290-1-luiz.dentz@gmail.com>
References: <20261103203011.3904290-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a server test with Notify Multiple enabled which checks that
the ASE Control Point notification and the ASE state notification are
sent in the same Notify Multiple PDU.
---
 unit/test-bap.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 8f081d92b936..1b1a51b03e51 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -73,6 +73,7 @@ struct test_config {
 	const struct iovec *setup_data;
 	size_t setup_data_len;
 	uint8_t cancel;
+	bool mnotify;
 };
 
 struct test_data {
@@ -668,7 +669,8 @@ static void gatt_notify_cb(struct gatt_db_attribute *attrib,
 	}
 
 	if (!bt_gatt_server_send_notification(data->server,
-			handle, value, len, false))
+			handle, value, len,
+			data->cfg ? data->cfg->mnotify : false))
 		tester_debug("%s: Failed to send notification", __func__);
 }
 
@@ -2067,6 +2069,30 @@ static void test_ucl_scc_cc_lc3(void)
 
 
 /* 4.9 Unicast Server Configuration */
+static struct test_config cfg_snk_8_1_mnotify = {
+	.cc = LC3_CONFIG_8_1,
+	.qos = QOS_UCAST,
+	.snk = true,
+	.mnotify = true,
+};
+
+/* The CP notification and the ASE state notification are expected to be
+ * sent in the same Notify Multiple PDU.
+ */
+#define SCC_SNK_8_1_MNOTIFY \
+	DISC_SRC_ASE_LC3, \
+	IOV_DATA(SCC_PDU(1), SCC_PDU_ASE(SNK_ID(0), LC3_CODEC_ID_DATA, \
+			0x0a, 0x02, 0x01, 0x01, 0x02, 0x02, 0x00, 0x03, 0x04, \
+			0x1a, 0x00)), \
+	IOV_DATA(0x23, CP_HND, 0x05, 0x00, 0x01, 0x01, SNK_ID(0), 0x00, \
+			0x00, \
+			SNK_HND(0), 0x23, 0x00, SNK_ID(0), 0x01, \
+			0x00, 0x02, 0x01, 0x0a, 0x00, \
+			0x20, 0x4e, 0x00, 0x40, 0x9c, 0x00, 0x20, 0x4e, 0x00, \
+			0x40, 0x9c, 0x00, LC3_CODEC_ID_DATA, \
+			0x0a, 0x02, 0x01, 0x01, 0x02, 0x02, 0x00, 0x03, 0x04, \
+			0x1a, 0x00)
+
 static void test_usr_scc_cc_lc3(void)
 {
 	/* 4.9.1 Unicast Server as Audio Sink Performs Config Codec – LC3
@@ -2100,6 +2126,10 @@ static void test_usr_scc_cc_lc3(void)
 	define_test("BAP/USR/SCC/BV-001-C [USR SNK Config Codec, LC3 8_1]",
 			test_setup_server, test_server, &cfg_snk_8_1,
 			SCC_SNK_8_1);
+	define_test("BAP/USR/SCC/BLUEZ-1 [USR SNK Config Codec, LC3 8_1, "
+			"Notify Multiple]",
+			test_setup_server, test_server, &cfg_snk_8_1_mnotify,
+			SCC_SNK_8_1_MNOTIFY);
 	define_test("BAP/USR/SCC/BV-002-C [USR SNK Config Codec, LC3 8_2]",
 			test_setup_server, test_server, &cfg_snk_8_2,
 			SCC_SNK_8_2);
-- 
2.56.0

