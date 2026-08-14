Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0031D490BEC
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786727720; cv=none; b=Au+MPLyQHxO0CjxFPhZ4fSMPrMHhoyyvOJ9Zt8dkLTItYSCslXY8Y4C27wmXRKYoDt+PxyxGIBcT1E09q8fHWwNvJLEMBLObRsOqJdnku2SuluDVGbsPbceOCMtOz7acAG06kEIgqd3J00sk/gsvAVuLB6u7Z3uUzwcxHtdVdzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786727720; c=relaxed/simple;
	bh=G9uDtmvhYhhIIkE9ALjkW5y13QsLywp3Uv2pg364UPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQpKyVTpxjn7XSn8VR7flKAfR/NtXAS/wqx7W/Fadp6wVVjyqy0FreWvozhf7Xl5FJdEJQkCVNdrcwb8zmcbJqfpgdRJ8GVDYc7Iv9VB3Gvjt0YeeCUPxNeO6/EL2bPSjsmHtjVq3FBEdKox5Sg++ELKJ3Jv44g+rUbPSRXStsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBDPa5tr; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBDPa5tr"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc97653887so22610745ad.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 10:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786727716; x=1787332516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=17paKKoyuCv2MENeR7ZOcTO4UqYD9DdC4Ci2/jcGOGs=;
        b=jBDPa5tr316mrsdX8h8PqpTjzL2LCGCC4kMlY53SKJQLaUP2MLkXZz87LGKmvBVRJJ
         Y3cGGhQ6JmmOePgduoBaV9lx8v+HaP+1DK82mlCS9NKdFjEKMBXfGJ58TXmRg53Imm7i
         Ci85fkOjrj9eIytnN0QbJs+2/be+HYVScwPtfgFuGw7aB2bAnC59FHcgOUcssieh9W2i
         wvie+zBSgkKEr43H6DMqxQJvYgVjtP2+6CUxpaCH9dQpo4aEY2QAzGssQ9SwTbUpCVON
         jCHn1DCqRLwKOngO3mE9FPA3NAGBmKUANK8+KFBObiNOK1GrgttFtAXndEWvb4TZhRWE
         5pNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786727716; x=1787332516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=17paKKoyuCv2MENeR7ZOcTO4UqYD9DdC4Ci2/jcGOGs=;
        b=l++GQWpqOIjyYicEstG8AGGAXe7GIYxXgYhzkG6VbE7sWnBrqm9o3WCyAwL6ifa2W5
         GAifnOG8k8Biq1DLME5RDksrRnpOV+oRqxbaxB/lni5Cfjm/VNzJJ5sVIKh6MMpESCcR
         5vxJ35GSxMriBgnV8uHXalD7ZsA6pHsd7V4ZF8q3k7pMfGzzDe+g3AH1spU4dBtJfxHL
         e3V9ZTPbv6KexQDIXCBZB1ULE+q79iEx8UTzywnj8diHr2c3Z6MDvO87N8Dudu3o+AIT
         1E/pfxIoYBLudLcmaeFArgfGhiWW3Dx9siJYoyJiCARP+gzOXagIqI4EDG5anFGteZGI
         hsqQ==
X-Gm-Message-State: AOJu0Yy5oR57bIEG3fRX8Jth93jC9Pi+OvaX0f8JsSF9X4pr5M84WCZp
	XCxJtYzgDDz67yRXDtiV7KS+5l5U0GJQhxYR8X0Qxi7zAzZGR9yTui06y/x6w48q
X-Gm-Gg: AR+sD10JSYPf1i58e7Od09Eafcpmwpun7KnHCOZJ1EnDnriTnqMyV8+ewSncyGIfrWX
	TnBRxYhKufLKpGavCtpB2vKXYe24mw49uyqR0ac2dcOwWGp7mlkUfwtyFTvuxDvVYiv4lzsoaVy
	yFfIPYW1+Omqh4ZFudv8vv/Jz2iGuTn8T0sxoKRvyOf/BS6mR7SjfvsqKvnEU5pIU0HrdwaHFOm
	jBDwDnGC3JWpS5BqMuUFd+YoeF8kpr3rfu4hsYY6ic8grQxcZj6qCTwbytIArVXMcC+3ySc+pn6
	AMpA93XtIgGqmjYgeT+ezsSUd9ah8sCFfB4bRPfUK1ogrzfduvojkIXPbpLM/+U6iTBY056Mm6z
	J1BC2supeZoK6Q0Qfa0ow+GzlG8hB+hLuqVbSdOU+abBgdf6xGzw5LU7LvQadVNXg3gVnn3Mzs1
	m8wsVCN83Y+09jbYtVTI87RrELYaIEV7PTCQHN9VM2hpgVmdJ053UJXoMT07VAlrg+nm3hxm3Mk
	ynm3bSbNp+BTCoXMQpURFIsA0CVNvsyIg0ZvsKMEGumBqI0ridQ9iMXUv7ryM/VhckbZutSAYVj
	TzvsJhtq6nlHokd4tRinqBTwMQKVrL1NuqXNHIFm5i4z3rqzKJgFKfNouw8anY3urTLEDSwTVSP
	krHmulXK4vFjBfmrFYqrAd++DmPgvhE6VMS8JsuakIKru21Iu
X-Received: by 2002:a05:6a20:2587:b0:3c3:33df:4d9a with SMTP id adf61e73a8af0-3cc71c1b66fmr8481982637.1.1786727715802;
        Fri, 14 Aug 2026 10:15:15 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea2f787fsm6182234eec.20.2026.08.14.10.15.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Aug 2026 10:15:15 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	ali@iusegentoo.com,
	raghuram.hegde@intel.com,
	kiraank@gmail.com,
	kiran.k@intel.com,
	ravishankar.srivatsa@intel.com,
	amit.k.bag@intel.com
Subject: [PATCH v2 1/3] Bluetooth: btintel: validate version TLV value lengths
Date: Fri, 14 Aug 2026 23:00:01 +0545
Message-ID: <20260814171503.42684-2-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260814171503.42684-1-acharyalaxman8848@gmail.com>
References: <20260814171503.42684-1-acharyalaxman8848@gmail.com>
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
Assisted-by: Codex:gpt-5 sparse
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 drivers/bluetooth/btintel.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index bf567b7c5f00..26435e41f1ce 100644
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
-- 
2.51.2

