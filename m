Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71290396599
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 22:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291904; cv=none; b=P0QTJkgkdZiSX5Pej4QlTEVGgEUR9OojT0bKN51ISF4jbbsVeTSRz9UEwyilqyylItMt0aYoPOmCeKMTTc9NiWvE1NsEeHwo24Ci/1bJPBvqIw+y1/QVaHpEi+hMGaAbqwhXSTzZ3eYeuEifKk6IS3anAgdfnDG0AMZ34lZM4nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291904; c=relaxed/simple;
	bh=lHxQM53ATJk+RvjtMNmOrmWVaTNLE1nT2m1ETChjebs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wa62DHH1fddSsDdOivLV0bX7IEKbne2Hf6VEdEQQT2PmE5dS0tZ2U2L6oBHeQDhyAXOsqBYXLsTaVCX5KdoYNgFgo/a7nuu1xJSQMoy5oQ54WYIGf74iKlZ9/o9zixqTxwjUfds4Tz3Hr4HYL+szB+7pjwpTfgMIitYxxFpse6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCY6WaBL; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCY6WaBL"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d7605ec91so3494348f8f.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 15:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291902; x=1776896702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1rz0R3NUJptYDT9JhJJKIHjbD1HQArOFkGD/cwsPMQM=;
        b=cCY6WaBL5ilRJ/wVLxD8psTZcv3bJuxtRYzgeL3jTa6okndkpfZ6nTbikF3ihU077J
         bvPDm+eOFT3AwzijjXOYWJ0mblXN8j3xOumA1/lBvqaLah+CkFk4Q7Uy92iJK8uoWcvW
         GZ9N280tgjozxbrlf0QQr7XqizRr+/mmcRSMoVeddd8i9fLrzURKdIsAZhYVNaZcBH/3
         zFT/OyjMFFaG7w2YTypMXZxckAoKndqDkEgwuekYMfIN7ROU8eOUpGz7PpOhFn9hWTFv
         DIGAoZQMWjABx4aUADBW4zDwdk6BFyjIq72Fgo4BsvOsezjU8ySpTkTnaOvvCRhwBGGV
         GmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291902; x=1776896702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rz0R3NUJptYDT9JhJJKIHjbD1HQArOFkGD/cwsPMQM=;
        b=gvLixb03DtI7xYFxO/Kk38w7Qu286uONB2eL+BigfNvzmY16QiVMmnFzxb/J7JxNCC
         QAqnlhEUdrNzuRbnvS9zgTrNX0bXGtV+Zs3hv4sMMdspm8uzWiTBmukaTBeAxGymKNKR
         k9aKn/WamGA+XOEzEYaVxVkmilAuWHNaNFjLKi0vM7BRxSA63iNljlalIx3In7IhHpo6
         JYfAYDJIJK1cpVSfgdH6QyvZ3xKExbWR0g9YoWYYeOQ7wbhfLOOtl1ROQXB7pDojHMeL
         7PGo4hRyr8oB1ORHWBbAyQUxTowLLV8CBMC8g9tAXO5TCZs7hIrd/fHsvLrSid1RHiUS
         50kA==
X-Forwarded-Encrypted: i=1; AFNElJ9jFPqzb1nP+1ElMRu2Kz751fmE8jeQayvGIh/uKYsMbE6BxeGgDDQChai9Bqe9qW9M64ZE2LTla62wcuXhRFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNCVqSu6KiAHYoWedWvbAagfAclGXLBnWsSdGB5Rn9pN63sIcb
	Ur8iOxZLlp9OIBkcTtMlmw0ATxDYj944m45vE3lo9V9JdzMyNtmW+EtJkjAf6QRU5w==
X-Gm-Gg: AeBDieurrM1SI5HoYgaRABt5NQttmIFW+EHKOo9mzw3Wvr9cY2qyPCY5zmLgfRMlZ9U
	3alUXkdLnTHgBZ6INA1S3wBxwsfoYwJ0xDWwf/k7vCqjhEsUW27rTC34Ta/REAEowRlSitZspvC
	fLoDMoAkIprt6imHYcAA0gGm2avCs5nWrdFQGq3u/CY0FPft0eND1jdi8ERlvkbcgm4LOxSQqWO
	XA56qCLdqfouX9XQkkM8Ru/X+QyhEcK+P7EZdNbMc0hikCG3WAPZbqL3SvzlUUiSEKk9gchxE4Z
	e5k/k0Rov6p7biq/yEvOYwUBUbsGcPisWlHIg274gtzBdjps95JTABnz6br1tTdapoeHmO7YqTK
	FMkP5PQLj5NMhPinQSaxtkMePda6R6XTmzinuGV2aUHUpP2o5preYgO+xIxta2bqHnexi05IqD9
	zZiJ4=
X-Received: by 2002:a05:6000:40de:b0:43c:ef4f:79dc with SMTP id ffacd0b85a97d-43d6427b8e2mr35272672f8f.8.1776291901728;
        Wed, 15 Apr 2026 15:25:01 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead33d65asm8340969f8f.4.2026.04.15.15.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:25:01 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btintel: fix OOB read from short TLV values in version parser
Date: Wed, 15 Apr 2026 22:25:00 +0000
Message-ID: <20260415222500.1547797-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

The TLV parser validates that tlv->len fits in the SKB but not that it
meets the minimum size required by each type-specific read. Short TLV
values cause out-of-bounds reads from SKB data.

Add length checks for types that read fixed-size values (le32, le16,
bdaddr_t).

Fixes: ca5425e15881 ("Bluetooth: btintel: Add combined setup and shutdown functions")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Note: v2 resubmission -- original sent via Gmail had HTML rendering
issues. This version uses git send-email for plain-text formatting.

drivers/bluetooth/btintel.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -582,18 +582,34 @@ int btintel_parse_version_tlv(struct hci_dev *hdev,
 		switch (tlv->type) {
 		case INTEL_TLV_CNVI_TOP:
+			if (tlv->len < 4)
+				return -EINVAL;
 			version->cnvi_top = get_unaligned_le32(tlv->val);
 			break;
 		case INTEL_TLV_CNVR_TOP:
+			if (tlv->len < 4)
+				return -EINVAL;
 			version->cnvr_top = get_unaligned_le32(tlv->val);
 			break;
 		case INTEL_TLV_CNVI_BT:
+			if (tlv->len < 4)
+				return -EINVAL;
 			version->cnvi_bt = get_unaligned_le32(tlv->val);
 			break;
 		case INTEL_TLV_CNVR_BT:
+			if (tlv->len < 4)
+				return -EINVAL;
 			version->cnvr_bt = get_unaligned_le32(tlv->val);
 			break;
+		case INTEL_TLV_OTP_BDADDR:
+			if (tlv->len < sizeof(bdaddr_t))
+				return -EINVAL;
+			memcpy(&version->otp_bd_addr, tlv->val, sizeof(bdaddr_t));
+			break;
+		case INTEL_TLV_BUILD_NUM:
+			if (tlv->len < 4)
+				return -EINVAL;
+			version->min_fw_build_nn = tlv->val[0];
+			version->build_num = get_unaligned_le32(tlv->val);
+			break;

