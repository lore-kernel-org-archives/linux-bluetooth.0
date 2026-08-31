Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC8C3D45EF
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170380; cv=none; b=ZxmRpp4/MkHWHYwnLtbWJ2o6XMbEZOtoF8hts7OfpVnyxXvrkRkdisSahxWl/jBih/lMAl10MP7pza4YKdJUTooBNB0ilaqvugDV3co63nYGB7A5Qni2B5CwBW7EzUNd1DzqirrE7E0LRN4doysdKbRfUWYRbOX8fB4Pw7HIdl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170380; c=relaxed/simple;
	bh=8oIoq3/BxEm7Bcl0GQ8KUIZQgDk0bEzaSgG154+Dchg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GD4YkgSXgTOwiDM/cJOKg4BUi9kHRH3Fh3nAPNFOLrR9ncQchx9vGWXA05iY3SdPiHKm0auqlLAGSxM8ba//2Pt/J41h8t4UUt/t85MGj/9rDNKaKVoAGmepvmrRqdR3JhudDWCC+jPI57xfF3itz/CuhKwXrJVomSlX+jQuJ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWrVi+6i; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWrVi+6i"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d7200b2e15so34516685ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 02:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788170379; x=1788775179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=31EY+ggiKNRoWg2rQDHXLSRikiCKuhKgERxrI2qpU+M=;
        b=OWrVi+6iXR47cNS6+VM3OlpgOUkXSHfpL0LxGCxDx827Ets3+Nx+Gj/694y/mTrA/Y
         oz5t4WCnWdDAUriwRym7yvC8K3pzwO2uQmPZlJFXa2CAfG69q7RspsPstfz9d1M95pTJ
         OJKQNSmTNhQWJ2ZQ124OeX+iFJbKtapca8C/BZiWcPh7PjWtQt3HWWQB4qcqxL3xxExs
         STcMWzC4N8ob5Ucb17XkxgdZajW06/m3pFnltTLooyys/xLpBBUFXtgPY/o1B3Af72r/
         SDHB8+32rrUAZS8kzpgrHjRu/gZdbOgL9/Nz1t85N7STxLMXtiFrR0i5sy7c+jNuyUP2
         2dFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788170379; x=1788775179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=31EY+ggiKNRoWg2rQDHXLSRikiCKuhKgERxrI2qpU+M=;
        b=cU+qi+SMgmG4ycEAEIdQSq2QTIhk0Bl0+y7fFkghdHyw/l0yncMf5qGGi5B8Sl4ATv
         j7qGKrSvWz55L+TOxjOe3yUOmDqZpiEPWdKRQwl2uv3Wm5ao5rz4oiEyqTfYv42QEmJf
         ISl7D9smj6SqkztZwDif6lAlILF7IMOPr+z3AsARxWXG1qrYOGgfvzcbx97/qfplBoeL
         kAGB2P5PP0YKOK9cjXrRffGyXW9ASImsXrLehe6DrI6WIF9WaVByw8BsOw1UaWqvWFUy
         TEMWJ3R0bUOdX68lxwtPOQmxzT99inuna28LdcnUyHOGwTyg8a8urZk2o+7Iq5BKQG7i
         1UrA==
X-Gm-Message-State: AFuF++lX6ZhyOHjvxpGNAORsbJHGpASYnb29XHsBZeiHoPYZFU7sRHeL
	I6Z7IvlYH1vtIom26HiQgCjNeF6w+ERLwq5obkHhoUEh5IOlrDC/VkZI5nOmKqcGAb0=
X-Gm-Gg: AYBFou2exBl+yWg40vFL2/SIxmF7Vd/jw7if7KLD5aY98fHQdLo7/FYI2gRTYsVCUdU
	eIms/vej4u4hgoDYr/emmE/1KqRThbqrr7SlWt2MVYXp2/FRMGRoidOGiW4Zq9I+HAZEV6MveJv
	VSD9JOj1opblR/EjDmi+MmaBJiE288ErjVcFUwW+WiNQaqc+TMD1NhIWK2y/gdcC2n0Zo7CuGwd
	Jwv3TyKM2tokfciy5q/I/Q3yCRgldEFc+MzJdiVXHel/lYCyCRwtnGIEHggRHcHsdVCUXNNTuLZ
	0OCFU8Qsw866thH9HkJtadVxUvNm8M0wgPKo5lwb4cj7RMHreeJYYwtCVRJR5LfZ9RSKy6fY4yu
	lHYCruiVP7UhRoYFy4cSJ8IrKDvUEqaV7XlvIwpy0yDlrOCqb/mVldhNGxRCoqbhPW37Bx4WpnA
	yUdE7ZCPg73Fs94tzgIzpxjIgssaqa8saT9Jbbbkv4TMYc5Wg1i9Xf5GYXAoHma0K7311n0pTDl
	Rb/qkIAqZLv8PFU4DCdCKdOkECkx/RbXzaUK/vKf6cjG2lw1THJnTfMSYpxizCoqeuwA8yArMjn
	8+eZngSRt0guFE9XweaOMUM3g3fg7EZJnvwPwnfY/kWGzFfSMZj/Hmsa7XCF6EIreHVZtaXIMFa
	UwP7ajEO8tI+J8A1RjRS7cU50rYM90ElQ73Hzli45ZPzDSQo=
X-Received: by 2002:a17:902:d2cb:b0:2cc:f5aa:9513 with SMTP id d9443c01a7336-2d93f9f7c7fmr28821375ad.10.1788170378759;
        Mon, 31 Aug 2026 02:59:38 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d759640becsm32270775ad.36.2026.08.31.02.59.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 02:59:38 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	ali@iusegentoo.com,
	kiraank@gmail.com,
	kiran.k@intel.com,
	ravishankar.srivatsa@intel.com,
	amit.k.bag@intel.com,
	Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Subject: [PATCH v3 1/3] Bluetooth: btintel: validate version TLV value lengths
Date: Mon, 31 Aug 2026 15:44:21 +0545
Message-ID: <20260831095923.18830-2-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260831095923.18830-1-acharyalaxman8848@gmail.com>
References: <20260814171503.42684-1-acharyalaxman8848@gmail.com>
 <20260831095923.18830-1-acharyalaxman8848@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btintel_parse_version_tlv() verifies that a complete TLV is present in
the response, but it does not ensure that the value is long enough for
the specific TLV type. A short value can therefore cause an
out-of-bounds read through get_unaligned_le16(), get_unaligned_le32(),
or memcpy().

Reject values shorter than the minimum required by each known TLV type.
Also reject responses that do not contain the Command Complete Status
field.

Fixes: 57375beef71a ("Bluetooth: btintel: Add infrastructure to read controller information")
Reviewed-by: Ali Ahmet Memis <ali@iusegentoo.com>
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 drivers/bluetooth/btintel.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index cbeb27033..998c99b17 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -573,12 +573,44 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
 }
 EXPORT_SYMBOL_GPL(btintel_version_info_tlv);
 
+static u8 btintel_version_tlv_min_len(u8 type)
+{
+	switch (type) {
+	case INTEL_TLV_CNVI_TOP:
+	case INTEL_TLV_CNVR_TOP:
+	case INTEL_TLV_CNVI_BT:
+	case INTEL_TLV_CNVR_BT:
+	case INTEL_TLV_BUILD_NUM:
+	case INTEL_TLV_GIT_SHA1:
+		return sizeof(u32);
+	case INTEL_TLV_DEV_REV_ID:
+	case INTEL_TLV_TIME_STAMP:
+		return sizeof(u16);
+	case INTEL_TLV_IMAGE_TYPE:
+	case INTEL_TLV_BUILD_TYPE:
+	case INTEL_TLV_SECURE_BOOT:
+	case INTEL_TLV_OTP_LOCK:
+	case INTEL_TLV_API_LOCK:
+	case INTEL_TLV_DEBUG_LOCK:
+	case INTEL_TLV_LIMITED_CCE:
+	case INTEL_TLV_SBE_TYPE:
+		return sizeof(u8);
+	case INTEL_TLV_MIN_FW:
+		return 3;
+	case INTEL_TLV_OTP_BDADDR:
+		return sizeof(bdaddr_t);
+	default:
+		return 0;
+	}
+}
+
 int btintel_parse_version_tlv(struct hci_dev *hdev,
 			      struct intel_version_tlv *version,
 			      struct sk_buff *skb)
 {
 	/* Consume Command Complete Status field */
-	skb_pull(skb, 1);
+	if (!skb_pull(skb, 1))
+		return -EINVAL;
 
 	/* Event parameters contain multiple TLVs. Read each of them
 	 * and only keep the required data. Also, it use existing legacy
@@ -598,6 +630,9 @@ int btintel_parse_version_tlv(struct hci_dev *hdev,
 		if (skb->len < tlv->len + sizeof(*tlv))
 			return -EINVAL;
 
+		if (tlv->len < btintel_version_tlv_min_len(tlv->type))
+			return -EINVAL;
+
 		switch (tlv->type) {
 		case INTEL_TLV_CNVI_TOP:
 			version->cnvi_top = get_unaligned_le32(tlv->val);
-- 
2.51.2

