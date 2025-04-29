Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A00B242D6E
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745944582; cv=none; b=EzymTtynJKcbHcBIRb5fCuZN3dONUD+qvmjqtzv3FW7+g7+KCvSZ3MvcYl+cVyiXLwP5fxwppxE8pmlI1onyKIB+FNRa99W6NfTTCICh14wMV6HAKHv5TaWflczMMqrpCH8aJr4gGJ6lsSt7n2DXLRw9Ek22ow/AtTKMlHpyq+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745944582; c=relaxed/simple;
	bh=4Zt6lm+ijCiwNoQ0+YHP7RYoMlAO4J5BE21gI1xJH6Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bekoRLrhT+pZWIx7deanjFNU/+bRzzdldtKX5pgG0Y+a3rEFgsTfK6xKdR6UOVcJMU0rATUtypOG1RKKyfUC9T3blWqf8Qhw74S2ALR+F7HUnxp8eWPFowRU3555euIHaxao4h26fTHyFJ8Q7PN4h1Db414Ri3p2kGMlcXi711k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clcjCYEX; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clcjCYEX"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c55500cf80so568143585a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 09:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745944578; x=1746549378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ko/RPF6WWmuEmzTg635e4sT+vu+cVKTOWplD+pMZ46E=;
        b=clcjCYEXQhfzXqKkLxGntAfhWOP5csrsEw1L+TfTuWoOyzmnmRNLkBPx+TWp6K3qV/
         DlI+0jJ3AdeBEenpxvIBJZyM19y/UQrjRlUlX298Ktc8sFmPiT7UNQitFoA7Xnc7HjbJ
         RmkAO+GVHUC/ULB4hrxwlDpqL9XtveBCtGVqYqyRJQRmxj0WswUQJpqn6FPxB7NX1mjk
         /WOvG8wY5ITPcx1gb9j+478+wdt5BJcsGC3ecxEiQpp7y+EkKxYBtuAEd2dVinfZD/Nx
         nsA5tKgapik6Y7cKxBG00oBsCy8zBpniRW6uZzbpNWqLRfxhy6G5xMB98Be6xyWRyVkg
         EovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745944578; x=1746549378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ko/RPF6WWmuEmzTg635e4sT+vu+cVKTOWplD+pMZ46E=;
        b=rRWSINqNvf2ItRzkSJD5AnKcb0FDDKMe3jZRn2odZ1NEpnTG4c+bDeD1Mu3dB3FS1O
         gy31Ion+VYXkqDtxSnfQDCF7WR57yuq2Lc/DQVrIm+/ognmCOKE9vr0XjiFEJnndn2Wp
         qCnoIBJ3bnmft/Lt2h6rkURCa0qqNMe2b3WXhFec9mEFSgvpMRgEtxxleo/FldDj3+UI
         gLqkAiBkPuY7ChnoI7jVtoYDJwpLOZqUf05/Iw5sG9FEYWqAoU9kVjjkM6BIbeGM4yUU
         Ptgfcp1cDlldlALizuwPxwLpo1eewDplOYMu/HvdV0Y+hRG4lIJbQolxAQcK6pETTvRg
         hHNA==
X-Gm-Message-State: AOJu0YxwV4w+Bk6Su/jT/khswMB8jvsfOiMZT34/80lmgnv51Rd5Q63e
	rjvqDC2GiPEtUryBsJ1Ah9hnFOdXdIPowP2ZPYLswgy3ZwD6oW4nRGdyuirz
X-Gm-Gg: ASbGncuyDKTedY6OqNTo0g072yNSZNhes1Ce13nKN6EerfHd7QK7N0ucMIalHLSb10s
	YSaEm2ZVf8ww0PH+DQO8vdq5tUEHipkE7IiMvMy6XjHfkyd54XopLeWGVWKv+xHF+v0vw6Blu4U
	Sj9CyhKp9aELGL8KHMzsJ+X5rh40OZ4enA4lejY3kivr8hkV5Mno6BhgIFqFfzGEFGtDWXvE7hH
	v4HFqaktNg7hWjaMc5Hf7jTe0/TMqnRoaEMv9CKJXo7vASKSvPZgHt/Z/S05YSeY65vBKJC11H0
	DBHbDdK03GyF4IzzVrJhquff+eE44aup0m0Fx3weizIV7pZcGF2gQ4PCznTVV00AjrqIQPyCxRB
	IA9cwf09Jcw==
X-Google-Smtp-Source: AGHT+IFgLHLsHmacfr0nxbG++CaOP5VlXC9sz8pG1rrdm0rsy4GjJdoDBKlLy5iepNUoUi9yZDLCMQ==
X-Received: by 2002:a05:620a:40c4:b0:7c5:65ab:5002 with SMTP id af79cd13be357-7cabddda0fbmr737042185a.49.1745944578419;
        Tue, 29 Apr 2025 09:36:18 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-877c6a87a26sm1392119241.30.2025.04.29.09.36.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 09:36:17 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] device: Fix not setting DEVICE_FLAG_REMOTE_WAKEUP when required
Date: Tue, 29 Apr 2025 12:36:15 -0400
Message-ID: <20250429163615.2188056-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Due to the introduction of DEVICE_FLAG_ADDRESS_RESOLUTION it is no
longer possible to check if the kernel has support for it ahead of time
since that would depend on device->supported_flags which is only updated
with MGMT_OP_ADD_DEVICE _after_ services are probed.

Fixes: https://github.com/bluez/bluez/issues/1207
---
 src/device.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/src/device.c b/src/device.c
index 2ee319c4f7c2..c364d72c3bdf 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1552,12 +1552,6 @@ static bool device_get_wake_support(struct btd_device *device)
 
 void device_set_wake_support(struct btd_device *device, bool wake_support)
 {
-	if (device->rpa && !btd_adapter_has_exp_feature(device->adapter,
-						EXP_FEAT_RPA_RESOLUTION)) {
-		warn("Unable to set wake_support without RPA resolution");
-		return;
-	}
-
 	device->wake_support = wake_support;
 
 	if (device->wake_support)
-- 
2.49.0

