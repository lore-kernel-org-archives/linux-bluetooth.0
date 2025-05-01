Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC4A20C49E
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 May 2025 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746117355; cv=none; b=EHm288ZHSH97eRKN0Lt9pFEEeO5SEv25yud8cEAhgcJAfvSTmDYMJjICQbY+/R6zVQR80faqjWhSq55o+mFFukcXCgCKeQm2Dq0R4zdQPqQ2B6yCcpV39KQcqi/PkGZ8ViCVQsOpFzBHeieICmgoIpvqya6wGAEua9aRxdr2nTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746117355; c=relaxed/simple;
	bh=370JqGOmOA4Lrdg3l396hdt6buPEyLilw3NyvZ7HIhk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBv5N7ZTYcru1vWtexUlGUTc3ialMChhocJztjkMgPQXRIBY3sXn0hA4Oosa3Rygii+RdXmbhnQO5qmbKHJuWCNgn3E1+GY8+oUZrN3yVXYfB/y5RvuB7x2TuX7cYITc2+t7G6lj5agV0aU4nc/hv4qXpR35LyT3pWmUUMZ/E4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mind.be; spf=pass smtp.mailfrom=essensium.com; dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b=ChNBI4VK; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mind.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=essensium.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b="ChNBI4VK"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39c31e4c3e5so639087f8f.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 May 2025 09:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1746117350; x=1746722150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R11FYZzn35Sjh1mg60+9TryUnl4lBdM/rRkkUl2wwfA=;
        b=ChNBI4VKR3/LUCdlMipJUC7+LB6Abvo4K1hV0SCKdbf4wTGLx0yvYSaYVkPeM8ayza
         x4NyuGUrqB3hL3H2Uay/AST+dniQ7Ks1T2IvwTjbPAnRPUN33Z/3PQxMC3TWDvZ4zNP3
         7L3Pb3MhO6xd9HzybKdLf2Hd+Ee9lx9lQ8dDPCTIEI9zNzyJVd9c+KqfSAbUrIZ8ig7f
         2e3gI6Un5irLaa+gdU5mtr7yjGnysuTM/lTzgFiX1JuTO86XYIMWnIKcg7bKRHx+L/7u
         tuInoNpa7Rq15E+ZX7Ocz6xH0KsYPJPtqLKQEgACNhFj3YDwLQZ17UiQj0wnrQltW1r0
         L75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746117350; x=1746722150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R11FYZzn35Sjh1mg60+9TryUnl4lBdM/rRkkUl2wwfA=;
        b=w1pqD5GiLOLsuhEaCeDQjpueBGxJUkt+RPwGOoQ+z4PAs3Z9A5/ZpNOwi/q+G+DIme
         Ha2XjK+SV8nPJXlmbjfo0Om6ygFEYKFeTLlXXkmizTe+yoM0E94Hz3D7SBZpTWdr2bZL
         O0WNjJUbKf87oKphhGgL+CCNGShzeTnh96B+eiypSCtoFeeyGZfktnxCwAc7CYnyeX06
         xlUt2y9ZP1v7WYZgOwE9iuyrA8eR7PlVEBbc92THyWs6RH5nDe09nP0xVSsLEmxT/4Wh
         jiaVvVCOOL6oXkrxfXnmu3wCCRM5jcNTZcyUAn682jke+Wn7nbZKfzLkI1FvYPCQd0TA
         rvzQ==
X-Gm-Message-State: AOJu0YyS9r8xt8N8yQ/xUebpJdHrcep2GAAD1FXsQTc1jdBgW+4IWlmD
	3ijrj/ZJZMNf1tEh65bI8gnXKsEkrCv+LkI7mh/HvbPYKeXV5Lw8lgCvg23Bvv8FuXd002uJkW8
	EF3A=
X-Gm-Gg: ASbGnctBOXB+8GFD/byygmTSWfV7OFKeB0vFdNdQ/Zz9U5FVG/yxeG+tbmOMXBzBSQ7
	1cPvWb+2fANavX25boe2AOXEPKP5zy1QorLF4dL9yiL+pimFwQpVPLkmnpeeVZXRTXQaugL5DE1
	ZFrj0mxXN9hItboUIQWmE2bkOviUKphD2xTvMO5FvjaNlJ25UBZnGJwfb3PKvsvvFwsjbYLxb18
	DRDV/oIBWek3afPJr9PEVif//aM27zuWZYAUZleNUkwq0pvCG2fwqB5eHWEMhsm7F5b7qSFdT8f
	Igg+84qnm+dFIicIbpSQJFGW1hEkxYyHjLGj+kl6CyytRt9XgMPf7Kk=
X-Google-Smtp-Source: AGHT+IE8WEekq1SQBWQpFYhM+rMIlzsBhaogsKoQelE29F/c7YC8ygGmiEpgbFIfDw1qDCeWplCeBQ==
X-Received: by 2002:a5d:64e6:0:b0:3a0:8070:8af8 with SMTP id ffacd0b85a97d-3a0930356b2mr2755980f8f.18.1746117350057;
        Thu, 01 May 2025 09:35:50 -0700 (PDT)
Received: from localhost.localdomain ([79.132.233.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a095a8f8ddsm1235312f8f.91.2025.05.01.09.35.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 09:35:49 -0700 (PDT)
From: Thomas Perale <thomas.perale@mind.be>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/2] input: fix HoG compilation w/o HID
Date: Thu,  1 May 2025 18:35:36 +0200
Message-ID: <20250501163536.1283827-3-thomas.perale@mind.be>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250501163536.1283827-1-thomas.perale@mind.be>
References: <20250501163536.1283827-1-thomas.perale@mind.be>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit [1] introduced a dependency with the HID plugin in the HoG code
As a result, building with --disable-hid --enable-hog caused linker
errors due to undefined references to HID-related functions:

```
> ./configure --disable-hid --enable-hog
> make
/usr/bin/ld: profiles/input/bluetoothd-hog.o: in function `hog_accept':
/home/../bluez/profiles/input/hog.c:184:(.text.hog_accept+0xbb): undefined reference to `input_get_auto_sec'
/usr/bin/ld: profiles/input/bluetoothd-hog.o: in function `hog_disconnect':
/home/../bluez/profiles/input/hog.c:205:(.text.hog_disconnect+0x12): undefined reference to `input_get_userspace_hid'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:6344: src/bluetoothd] Error 1
make: *** [Makefile:4695: all] Error 2
```

This patch duplicate the read of the 'UserspaceHID=persist' config entry
in the HoG plugin file to remove the dependency on the HID plugin files.

[1] 1782bfd79 input: Add support for UserspaceHID=persist

Fixes: https://github.com/bluez/bluez/issues/1228
---
 profiles/input/device.c |  5 -----
 profiles/input/device.h |  1 -
 profiles/input/hog.c    | 14 ++++++++++++--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index a7bc4d44f..3642cc326 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -112,11 +112,6 @@ void input_set_userspace_hid(char *state)
 		error("Unknown value '%s'", state);
 }
 
-uint8_t input_get_userspace_hid(void)
-{
-	return uhid_state;
-}
-
 void input_set_classic_bonded_only(bool state)
 {
 	classic_bonded_only = state;
diff --git a/profiles/input/device.h b/profiles/input/device.h
index 036a88980..905669502 100644
--- a/profiles/input/device.h
+++ b/profiles/input/device.h
@@ -22,7 +22,6 @@ struct input_conn;
 
 void input_set_idle_timeout(int timeout);
 void input_set_userspace_hid(char *state);
-uint8_t input_get_userspace_hid(void);
 void input_set_classic_bonded_only(bool state);
 bool input_get_classic_bonded_only(void);
 
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index f82648fec..a3c876cf9 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -40,7 +40,6 @@
 #include "src/shared/gatt-client.h"
 #include "src/plugin.h"
 
-#include "device.h"
 #include "suspend.h"
 #include "attrib/att.h"
 #include "attrib/gattrib.h"
@@ -55,6 +54,7 @@ struct hog_device {
 
 static gboolean suspend_supported = FALSE;
 static bool auto_sec = true;
+static bool uhid_state_persist = false;
 static struct queue *devices = NULL;
 
 static void hog_device_accept(struct hog_device *dev, struct gatt_db *db)
@@ -203,7 +203,7 @@ static int hog_disconnect(struct btd_service *service)
 {
 	struct hog_device *dev = btd_service_get_user_data(service);
 
-	if (input_get_userspace_hid() == UHID_PERSIST)
+	if (uhid_state_persist)
 		bt_hog_detach(dev->hog, false);
 	else
 		bt_hog_detach(dev->hog, true);
@@ -229,6 +229,7 @@ static void hog_read_config(void)
 	GKeyFile *config;
 	GError *err = NULL;
 	bool config_auto_sec;
+	char *uhid_enabled;
 
 	config = g_key_file_new();
 	if (!config) {
@@ -253,6 +254,15 @@ static void hog_read_config(void)
 	} else
 		g_clear_error(&err);
 
+	uhid_enabled = g_key_file_get_string(config, "General",
+					"UserspaceHID", &err);
+	if (!err) {
+		DBG("input.conf: UserspaceHID=%s", uhid_enabled);
+		uhid_state_persist = strcasecmp(uhid_enabled, "persist") == 0;
+		free(uhid_enabled);
+	} else
+		g_clear_error(&err);
+
 	g_key_file_free(config);
 }
 
-- 
2.49.0

