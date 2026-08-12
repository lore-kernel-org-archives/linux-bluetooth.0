Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CACA470E8F
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554887; cv=none; b=BT2yu+oDn8JHHFQri62o///S6WgqjZ7uSvX/xXGtnMQw4PVffBScR+FgewtJEAmDGc5Q0NoTjzO+DkNmnqdBUBfFVRKl06GaXUHxdYLR0CcGoOIdzOWyaRCVdm2lUiuY6Qo2GKQPTGsZrw6OR7A3Iqb0lneILNW1xWPzb9Qm1tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554887; c=relaxed/simple;
	bh=goB+Ed+1d5rnMX/Gf7kXo8+dy16a0MRkPbyjXDFSXgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DjjAlXP8ilvKdo/cKhyn6vQUtOJENX2s7FsdCqF5GGWcW2tukRxEWbNfZt5iBmYIeJb8UZTR7XL836liCiavGWIO5qjyikk7y4/NQvcyHr5wqyOYGUywA3ORwSK91mVchl9EaxxqIb5t1eE1Qm9AZE9C5iiQ8Q5bsMdjIqEC2NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OT0/UoKX; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OT0/UoKX"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-382ef647e20so1400899a91.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 10:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786554885; x=1787159685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aRSdyzFIOnj8kEZYFu/H6/Eba3XNB95fFLCi1SUko1I=;
        b=OT0/UoKXHWtcYQHTiqm68MMtKkDyfcU2JtiajCHJqDDdMMki4zv3OBaGoSTWc6cEK7
         q+BE8RWQv6ojaEmUAKGL07EkR94mjfRr8ByUGjvcOWfzkwwN3byj92Nbv+0n8A1cc9eG
         E2Zy3rLYqr5SefY7vkDOOXgVn6lJv2tJ4dz4x6UBafYRbBwJY26+KTcw0e+x+X2pvR2d
         A+iyNm7bjloPzX0KQHJV7uywarbfqlt5eMaWgivdNsU2pxZAWI6NWWD+4QZCTBYgPQP3
         GSmB425jeop4dCxZVW/1+RUo0DD92uJXgXzxvkkens6X4uIRhQtjObY8VgOJIm4DRowR
         Ykiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786554885; x=1787159685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aRSdyzFIOnj8kEZYFu/H6/Eba3XNB95fFLCi1SUko1I=;
        b=Pp4reCWS9MiYk/Ez3u44a2774KxEab8H0BrmD2bRWVvBeK8Pp9GjNqrnd0I+iORCH5
         kYBfY+HIUa0stE6LBpLzMTbwnNdiNoaQOJdUEXxFCYr2qFsB4qtNjm0SC4w/QUtidfsJ
         7EVsTF0zt25s8kDsY0MHDz8B1ot1iKEkm8rVoJxDBx4p9SnK/GcB5xptvRGpyG1MyicD
         A+N1ljnA6a6i2rHu6SmY9zeERT4cz2WWtpZwJbAOisNSjcsSg4DU5idbyZd6K7RAlP6B
         biIiZx6gKNBC4Ts9MTdCotdvt1xj+WLqPFgCQW0vzZCN6/Y9W2bgIIjne0BUsCYm7FL1
         e7Lw==
X-Forwarded-Encrypted: i=1; AHgh+RrpFBwQYcEAA6RsWv+BH+32tnUSvOdR1mhekANV4/n8yQ9ODZpcQoehrUYxkuwmYZZC3dYjGNz1tS3ZbZVjpCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQxnEv83zZ7ioMnMVnnCVUG8PFnnJo1jtkaThttf2XHsXGfSJ/
	7SwEw0xdjQrMsZLeeB4RZO2+EBVEY9tDZxEysPGgEmnx+9jN+refTRQb
X-Gm-Gg: AR+sD11q2V8soa3yOPl3reL9CGKDVkno4e1+HnYJaM093O7B0lh2Cim4b/RFIooWLRS
	lDS68UaeMDv+uZYBlFB16NLHq5xWwZd2X21XjWLme3tOlqhg41VwZd6+7m0XpP8iA0VB68CkK5y
	XLL2ZHfcGWEmRTvFMKYnWt4wxMSZ1SQSPOvw69hLlC8Id9x6Upb0dhFL99qUoVkhu8REhDG5bNW
	7rrdZECkiX+56rpfeI18trgue1oUspLe5OroneE4I56gBM9DdcyXtpea1BJWVIPWpEOCMEtfLHF
	Sv8xWxGl0awglhgPLKSTEjuIpNcmdq6COT0qmgX2GbyJ8Y6optGNHiyjbdcU9LpG1ffcBswM6lv
	GpK/Cwh3qemwlFTzvTWPqb0glUKwKgjDqC82bg/luiyoEkrycyCU2UJseLvOUy3B4wOTRBi1Lwe
	dvAG7Tp9WBSGjIlte+7CNlbykH5DyrJpU+mdR+zISMDQ2Z0E8Jn2Y8cbjTUmRbl2CdpkKdB5hwJ
	iLL21DQ3dY1B2WnNcgF0/1LqEc4cE9Obfu2SNQrFskjVNcYMCIEs0bv2EgZr/Y5vWJtcOMhFEoo
	38YRvumKkNB8KBRpXu9BMtGYJtiU9HT3tJFmXrzu6RPC/NceY2tLvAUEY3AcZ+IIPIIMKaBQJUk
	9aG+wfc59feUIvhnb+nujF/1BQJNj/DAXBI50jZMv3YLqb313TxPdng==
X-Received: by 2002:a17:90b:2ecb:b0:36a:5d1f:7b6 with SMTP id 98e67ed59e1d1-39301252d62mr8976148a91.2.1786554885349;
        Wed, 12 Aug 2026 10:14:45 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141245540fesm18150827c88.9.2026.08.12.10.14.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Aug 2026 10:14:44 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Tedd Ho-Jeong An <tedd.an@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btintel: validate version TLV value lengths
Date: Wed, 12 Aug 2026 22:59:34 +0545
Message-ID: <20260812171434.82729-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
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

The firmware ID is also treated as a NUL-terminated string even though
the TLV length is its only boundary. This lets snprintf() read beyond
the received response if the value has no NUL terminator.

Reject undersized values for all known TLV types, limit the firmware ID
conversion to the advertised value length, and propagate parser failures
to the caller.

Fixes: ca5425e15881 ("Bluetooth: btintel: Add combined setup and shutdown functions")
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Assisted-by: Codex:gpt-5 sparse
---
 drivers/bluetooth/btintel.c | 44 +++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index bf567b7c5f00..934775e449db 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -570,12 +570,44 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
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
@@ -595,6 +627,9 @@ int btintel_parse_version_tlv(struct hci_dev *hdev,
 		if (skb->len < tlv->len + sizeof(*tlv))
 			return -EINVAL;
 
+		if (tlv->len < btintel_version_tlv_min_len(tlv->type))
+			return -EINVAL;
+
 		switch (tlv->type) {
 		case INTEL_TLV_CNVI_TOP:
 			version->cnvi_top = get_unaligned_le32(tlv->val);
@@ -666,7 +701,7 @@ int btintel_parse_version_tlv(struct hci_dev *hdev,
 			break;
 		case INTEL_TLV_FW_ID:
 			snprintf(version->fw_id, sizeof(version->fw_id),
-				 "%s", tlv->val);
+				 "%.*s", tlv->len, tlv->val);
 			break;
 		default:
 			/* Ignore rest of information */
@@ -685,6 +720,7 @@ static int btintel_read_version_tlv(struct hci_dev *hdev,
 {
 	struct sk_buff *skb;
 	const u8 param[1] = { 0xFF };
+	int err;
 
 	if (!version)
 		return -EINVAL;
@@ -703,10 +739,10 @@ static int btintel_read_version_tlv(struct hci_dev *hdev,
 		return -EIO;
 	}
 
-	btintel_parse_version_tlv(hdev, version, skb);
+	err = btintel_parse_version_tlv(hdev, version, skb);
 
 	kfree_skb(skb);
-	return 0;
+	return err;
 }
 
 /* ------- REGMAP IBT SUPPORT ------- */
-- 
2.51.2

