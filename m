Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E092F746A
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 20:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338455; cv=none; b=H/YO9HrUddB+9RQiawyNCL+w732sBmKwcVKtkUHZU/WX3I7VaKyakLGaT7jpBEPqC1FqsW+6nPXWhQ9fpoJA7Y1nLm57P/dp0IwWQL2ja6ItGzbiObYU2cp5u+Li0eAHyOPKl+l4YhqhImDk1beOmNqGqtEd7b7IGzSd399rmkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338455; c=relaxed/simple;
	bh=2r14nYA6Yf+baevQOfKeRbGNx6Jgfbn4VF4fmncT8OA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKMj4mQiJU+thFceUyfI8fFsu+1f8PsdPKuZ4YHAiFdWY5wXsb4p84v+yVXb7CJbx2BKBt3hBBaDV5XHtJIboDXMDOKoQsAsRkKzGnQa4bkRBQNtucm7XPwFnyMC7KNWrEls2lQhEgX+dPFlg2UyLuXk8ySEMSuEogvhno2yKBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWJHHm3/; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWJHHm3/"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-932dfe14b2eso1854491241.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 13:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761338452; x=1761943252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XgK2tdrOHtLhoVlrZ1Zm+ZGCWUzx0CKFEIxKsIVFMXY=;
        b=PWJHHm3/CyELRTC4ZNkz0eNULJI/+1ZrwyEXAfow8kBx3qBRXLTsba/vg/AlzgpXF6
         7b7AAazNue2oFlrvGjbQCKtxd6UQl8wNrojz5pc9vVA40HAYczRCchmycGSjDLQ2FHuj
         2nDZ8BL6jMwA9vVSHJ6UaMK8qw7SbKL6XE6yn0y8CZ/qrhSO8VJBT4KhxGif7KLFqu1A
         kzI+a3AXH5YBnWF0Y4IaMNhN0HIglck6JYJ1p3rPq41nqPplT5eP4Uyrj3jISbfYI6ur
         AQBFvCBpsv9kBVaqHF+THi+JK5BJ0/9urjo9mc0qT9K3aYllVd/JBS7wG0QMh2JGdSQA
         OXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761338452; x=1761943252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgK2tdrOHtLhoVlrZ1Zm+ZGCWUzx0CKFEIxKsIVFMXY=;
        b=IchMNH32kHtB45c3Hi2HXUq4XfZY6MZlcwVWELTBJPz84yE9DySrvRaUCyXLjrn3fe
         9TuabKf+qEqcoYllHdhDXyiuE6wcSxSbYx+nyB4tVNnOdAppLFv+CVPmAuYRVW4YVf8H
         NdYzCBuYSAqDXTo6Og0qujqGxtmaZg0MKc1e0hRLcweC+HpuK6JXy6/0Q2+JJPyroJhx
         3wgbXD3huiXOZpJg7mynrl+HPh330wejutl0/umMFzrYU3DEbpxsGmp/UhxGfhwZjkGf
         FHjqwVq+nkYk75MAO90wRLtgETyB2w9DVumhJB2d9kg0yElKgb8hS7grZOeGMOXJ9/M1
         ofsg==
X-Gm-Message-State: AOJu0Yz7Suzzoo0pp6MII8XrDvYZ0lKiYgff7c+b1295CFY1S68L3k91
	IIjjG3fMMs2korGN63Dhto+AugkOnaSDjwEjiUoVuPg+0VJKo80LN2fI0NMkWw==
X-Gm-Gg: ASbGnctGBLrXJDFw7txXkWTnxgOa74l6qVk/wO1YiUrtoHz4tqx3P6bCSTKmimSRaaV
	m11QBHGJ0j8F+XNCmjqigwu42Q6krbYVcVQM/QeQee2JNuo6paUt2KsfxbDD9RhvMgJ2RFNaV7c
	h1qzl/MZ10EjNS1y3PwGsZszAWfX3XAmJIOpZCshQF4mB/9sdIA6vtgdYAm1t4lUFJUXx3bvVHA
	tgVVV2XVq3IUVrxGBsKBR8jyAIrI09ZNVZIMyWuSahy3EKMbBmPNaYjj8fhP9hohYPPWM86c/5R
	mMj0ZX96OV4fTR5ZkFQIiW6DMcy4kggwvcXI4Y3o7ACiaqOHmA1gXNtHioI6h5QeEDJCfqwi3Ov
	o6rXM0pK5WLTFRBHjKMHUWABBHIE5gFIkdPyYFgGp7XMj/1H2AQ5i3JoPextWVFTftEJko41Ecw
	sKkgh0KDZRONlesQ==
X-Google-Smtp-Source: AGHT+IEHpUI4EBVVhWhmnh0/Ch8lmhvM11VR6xoqZUE5d2bJR0OuzbLyo9F8yYt+h8hOFII6EH1B4w==
X-Received: by 2002:a05:6122:1e14:b0:539:44bc:7904 with SMTP id 71dfb90a1353d-5564ee57420mr9007317e0c.5.1761338451740;
        Fri, 24 Oct 2025 13:40:51 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557ddb2f98asm73501e0c.10.2025.10.24.13.40.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:40:50 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 02/12] bass: Add support for setting DEVICE_FLAG_PAST
Date: Fri, 24 Oct 2025 16:40:29 -0400
Message-ID: <20251024204039.693918-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024204039.693918-1-luiz.dentz@gmail.com>
References: <20251024204039.693918-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to check if setting DEVICE_FLAG_PAST is possible based on
the MGMT settings.
---
 profiles/audio/bass.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 51ed45a215ec..b231d1f7787b 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -30,6 +30,7 @@
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/uuid.h"
 #include "bluetooth/iso.h"
+#include "bluetooth/mgmt.h"
 
 #include "src/dbus-common.h"
 #include "src/shared/util.h"
@@ -1262,8 +1263,17 @@ static void bass_data_add(struct bass_data *data)
 
 	queue_push_tail(sessions, data);
 
-	if (data->service)
+	if (data->service) {
+		struct btd_adapter *adapter = device_get_adapter(data->device);
+		bool initiator = btd_service_is_initiator(data->service);
+
 		btd_service_set_user_data(data->service, data);
+		if ((!initiator && btd_adapter_has_settings(adapter,
+				MGMT_SETTING_PAST_RECEIVER)) || (initiator &&
+				btd_adapter_has_settings(adapter,
+				MGMT_SETTING_PAST_SENDER)))
+			device_set_past_support(data->device, true);
+	}
 }
 
 static bool match_data(const void *data, const void *match_data)
-- 
2.51.0

