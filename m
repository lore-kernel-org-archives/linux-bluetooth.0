Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C913B76054
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 21:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706563241; cv=none; b=jDU/OUuBoZl30dzXKhLZ5uwXO64i6L7mRp15WpJVHuvsarlN9ygKQG8Ea6llpAyfWG7mT2n9rrrrhUygsHNfRpZ7aeNCi4XxLj/So78HBhkAF2nObzl0X/RHFVmK+b0gXPP5nxbakNVFMhR1SsxMwDpJFDpovALlE5ATO6EuQuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706563241; c=relaxed/simple;
	bh=Xa5lW18xjK/IIfN8+Gbc5A+ljhW8BlUOpiM6lbQiF4c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jU5ue3KcI0epbRW3DcLLvgGb8e4IA3BXuW9I+ONJWfIdY0wSp6N497hZOcOKczz6wIPdmGHoG8ayPArG2BKOaDlBCb8MWEuNMz8NI/+8NE0f+ClizMZScMEOptBC/oLmJVf3LsHsphgXhdH5HPX5KrYQST/WBgR1ehpWRbniXfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MR23MPZx; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MR23MPZx"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-602d0126e80so30289147b3.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 13:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706563238; x=1707168038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=K22dbLc6vKlD2NaJBhAcxy2aWYesXB1vp1oXcuRRSkc=;
        b=MR23MPZxh4izuNr5fO06elcw+uFOuaQp2gWfx5UWd0qcrVA+WVp8eKYgHvntGe2BxK
         xlcB8pwpnT9UspRd3AqKPsM5ZBVZojE19NfiCmy0bYd+OTAKElRI9Vf78UPCe28FTHY7
         daO+KVUpsg//AxZkrbc6IyzVFxGENcfVxcf6hEohb5iiE12xtVh2mVeqX4RxQvdpKwLl
         Zcw3H5EhmXSdOFJwUB3xnSU69mupArbJQsccSgGHKU+qyf1k5/XzvmTGyGKqYfB5Wphv
         XguiaV8P9DmUE3K+4eFGDyhigUiHrWrXnUcmozsKbtrbNCmf5v1l+Q+SH5/+4zp3dsKM
         t8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706563238; x=1707168038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K22dbLc6vKlD2NaJBhAcxy2aWYesXB1vp1oXcuRRSkc=;
        b=P5MESrOKnTGUtxgKKODcZYsyQnFcn+ttVuBmLlFhHBgWy0ZyrvUDwpuaZrm28T8kxn
         NSDgFJY9wXCqsZ6FzCbJ70YtDLluljvtjKUqcxeZEVv2ba5ALecCz+1ztETE90LcA26K
         M4pIZbqf7Oa4Vtuub5w12Wmp+j5T5K60R1Y4lFyzouSz5Q6s3gMafFKqxBmwcytnZwPB
         AHlHKJ9j41qNGzAwasa9mvJSAjad7jjPejrmY1l7p7Db3QiDyUJFOhOpHxyC6HEjowun
         K1XsCstrro9UJQK+WJQTUKKmWZy1xQqjdkrhinoBCKnaMZhoZxwmO1JKhh7g1ZRtFvfZ
         Im3Q==
X-Gm-Message-State: AOJu0Yw2fgi0IWJcFsh1isuZEWWPzojN7A0I9suUyrqHQB1GEkqk6lKv
	gfM0LUt2xs8farKRwXJKGKlqNIHWlP4w8sMEiu7YyaLYl12sEjw9TZHkpVKu
X-Google-Smtp-Source: AGHT+IFh3EjJRAQRI4QlPr+M28Wk+OxZyomJjy3qje6UPfWFvfJy4fTBB2AyKeMWM4UJhx4q7H0fmQ==
X-Received: by 2002:a81:b101:0:b0:5fb:557:58be with SMTP id p1-20020a81b101000000b005fb055758bemr4434415ywh.34.1706563238086;
        Mon, 29 Jan 2024 13:20:38 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id l198-20020a0de2cf000000b005fff75780f3sm2704904ywe.66.2024.01.29.13.20.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 13:20:37 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/4] util: Add UTIL_IOV_INIT
Date: Mon, 29 Jan 2024 16:20:33 -0500
Message-ID: <20240129212036.163298-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds UTIL_IOV_INIT macro which can be used to init elements of
struct iovec with a byte array.
---
 src/shared/lc3.h  | 24 ++++++++----------------
 src/shared/util.h |  8 ++++++++
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/src/shared/lc3.h b/src/shared/lc3.h
index e6b043699bc1..3a8c6f7b5841 100644
--- a/src/shared/lc3.h
+++ b/src/shared/lc3.h
@@ -7,14 +7,6 @@
  *
  */
 
-#define data(args...) ((const unsigned char[]) { args })
-
-#define LC3_IOV(args...) \
-	{ \
-		.iov_base = (void *)data(args), \
-		.iov_len = sizeof(data(args)), \
-	}
-
 #define LC3_ID			0x06
 
 #define LC3_BASE		0x01
@@ -53,11 +45,11 @@
 #define LC3_FRAME_COUNT		(LC3_BASE + 4)
 
 #define LC3_CAPABILITIES(_freq, _duration, _chan_count, _len_min, _len_max) \
-	LC3_IOV(0x02, LC3_FREQ, _freq, _freq >> 8, \
-		0x02, LC3_DURATION, _duration, \
-		0x02, LC3_CHAN_COUNT, _chan_count, \
-		0x05, LC3_FRAME_LEN, _len_min, _len_min >> 8, \
-		_len_max, _len_max >> 8)
+	UTIL_IOV_INIT(0x02, LC3_FREQ, _freq, _freq >> 8, \
+			0x02, LC3_DURATION, _duration, \
+			0x02, LC3_CHAN_COUNT, _chan_count, \
+			0x05, LC3_FRAME_LEN, _len_min, _len_min >> 8, \
+			_len_max, _len_max >> 8)
 
 #define LC3_CONFIG_BASE		0x01
 
@@ -80,9 +72,9 @@
 #define LC3_CONFIG_FRAME_LEN	(LC3_CONFIG_BASE + 3)
 
 #define LC3_CONFIG(_freq, _duration, _len) \
-	LC3_IOV(0x02, LC3_CONFIG_FREQ, _freq, \
-		0x02, LC3_CONFIG_DURATION, _duration, \
-		0x03, LC3_CONFIG_FRAME_LEN, _len, _len >> 8)
+	UTIL_IOV_INIT(0x02, LC3_CONFIG_FREQ, _freq, \
+			0x02, LC3_CONFIG_DURATION, _duration, \
+			0x03, LC3_CONFIG_FRAME_LEN, _len, _len >> 8)
 
 #define LC3_CONFIG_8(_duration, _len) \
 	LC3_CONFIG(LC3_CONFIG_FREQ_8KHZ, _duration, _len)
diff --git a/src/shared/util.h b/src/shared/util.h
index 596663b8519c..6322b13d612a 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -151,6 +151,14 @@ ssize_t util_getrandom(void *buf, size_t buflen, unsigned int flags);
 uint8_t util_get_uid(uint64_t *bitmap, uint8_t max);
 void util_clear_uid(uint64_t *bitmap, uint8_t id);
 
+#define util_data(args...) ((const unsigned char[]) { args })
+
+#define UTIL_IOV_INIT(args...) \
+{ \
+	.iov_base = (void *)util_data(args), \
+	.iov_len = sizeof(util_data(args)), \
+}
+
 struct iovec *util_iov_dup(const struct iovec *iov, size_t cnt);
 int util_iov_memcmp(const struct iovec *iov1, const struct iovec *iov2);
 void util_iov_memcpy(struct iovec *iov, void *src, size_t len);
-- 
2.43.0

