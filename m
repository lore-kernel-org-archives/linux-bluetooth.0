Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FEE33F6
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 May 2025 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746117354; cv=none; b=KYN+hnN66GmXXOk+YCwOF32BXeIRGTXcwMs5wLbgH+QuJr5maOkT1S0Ezk0AWakDEa57W+nUq68Rq4lT5An457/32Yv+/lx9zAUXvuq6aMbF7uv8qO093CKUuRqve53S7DGuEhWxqK816BM0hf0dcG8v6TnrR9v3HKTK/EYaJgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746117354; c=relaxed/simple;
	bh=yQODoPl7eZ7tg2Re2h1MvdGTmnkfxW3dTviKNMTSxY0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXJ6Hn/ZNK6cdHrfPhnlKIxlUBoYNZWKacyBRHoDbmgnREXz226nPofIX15cYeNfFLgnDoFffjUSp6VitK0qqy/TpGQXvpIs4CjbB46UPzeLQCXcmWPfVjlrPhVEsJc1eKp6A0HL91zDQA0h6XOiqLUAFeNRJYDwT16hsYp9bLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mind.be; spf=pass smtp.mailfrom=essensium.com; dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b=BQzRy8Rt; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mind.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=essensium.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b="BQzRy8Rt"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39d83782ef6so1535062f8f.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 May 2025 09:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1746117349; x=1746722149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a42mE8bbluUJistpF7so0K3jXEJQNWK53JfyTiHrb08=;
        b=BQzRy8Rtm8lMLEWc7TIyneZaZSXa2/ASN4rZCRT9t3T06TR3wvaD/NlVjUnClPlkt+
         y0YlEiRWEJHZo3ZzbNDv+W6NsKpsJlgeTZH79d1ObQ4681ythGIsEy0anBup/uRWav34
         6iU7brhAftkTq0cizDwr0agSQw5WzlhlRnFujn6PIa5Zc5ffE4qHtXeJFR8NsMJ8qD/r
         nqu8WV1uh4aCG6gm/0K8lB2fDcEeoEVT1vb/6DBqj9HWyMQJ7CA5dcObCROLk+qxYqvT
         ++DuSnKRzIiwSLM+fhFb6xv3RazuuC9znW7JK6yPGdLaDyLBh7EQiFPdsg/npxSXSb97
         gJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746117349; x=1746722149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a42mE8bbluUJistpF7so0K3jXEJQNWK53JfyTiHrb08=;
        b=tfknbnqhWqjcOPDBl6RUglbUWtuBYMoQ3sOSfQVcBCJt8iEkhoJGKFCDd4r+HToDxl
         PrAX/r4iQHIEsAMAF2TPE87jw7ccvlWVKsoa+KxSBk4c+xS6m6IhKzHc69mAYU34VQmr
         c187SApYEkE2gw3wwElD+32oZWVb3zqfP7IVmyKvMG1ac3ro3LIBDiQSID5EpqvYOAiq
         GoosYLE9hiz7WNWm2hQ0gd2Y/iPMsmr/wyCxxWXh/UeELFpifdvOxkIrgdghKnso2lPQ
         wBGuXeSamFfrlmZAxsLYFYVlfU161D4ycKIPuRkNDloSYyrVlzRxjJzVspwB4vtHAzhV
         bn0g==
X-Gm-Message-State: AOJu0YzMDDrEEoD/stQ4ZqeUK5L7paP4nxan7ejlAoX3NvMugOUs2d9f
	rbPaWA1h49pO+aataL99d7w/ZkBJVKJs5VDRPuRd1pXDwq1DYp91SVlPpcNgdmj1nHVxBUt6T5y
	oppk=
X-Gm-Gg: ASbGncu0uiKGvKS8QF3PfBpUVKSJxgi1NtRCYr7BZg8u8sQrUp8WvTouzCQup0M43P3
	WDHVct1kjCmwL46sy4hZ6uLJNMvxJuDXqr5ht/pZmYN0lTEdiOqT5rLi9SuJzBDPHzdzOmMOjGt
	sZgjBFbbLxcRLzGP6qPBy891fk0SUccdb5tFd+9ldoW48oh4q3YXWpWDR8goJIO8YbUhNwQqr+P
	y3Loc8jEb47gPc4Mp93fbEIbvZtrpfqhafLJxoCDM2ty5hjHNgDl97tuBmdD/mx3qmijw49eM6l
	GTLa0Okc/EETgzRTIz7X/ZBFABRx53ex8z+a87NYeIG29WfTVH8wRLA=
X-Google-Smtp-Source: AGHT+IFud/JgVFTDQlbR0OHNNL2XyeSdBR2UAKVN9FX/Al+o04JNhUy3IFd9FdoAS1dQdTULR5GDwQ==
X-Received: by 2002:a05:6000:4283:b0:3a0:6c43:6a69 with SMTP id ffacd0b85a97d-3a09405d566mr2178419f8f.29.1746117349222;
        Thu, 01 May 2025 09:35:49 -0700 (PDT)
Received: from localhost.localdomain ([79.132.233.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a095a8f8ddsm1235312f8f.91.2025.05.01.09.35.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 09:35:48 -0700 (PDT)
From: Thomas Perale <thomas.perale@mind.be>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/2] input: fix HID compilation w/o HoG
Date: Thu,  1 May 2025 18:35:35 +0200
Message-ID: <20250501163536.1283827-2-thomas.perale@mind.be>
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
As a result, building with --enable-hid --disable-hog caused linker
errors due to undefined references to HoG-related functions:

```
> ./configure --enable-hid --disable-hog
...
> make
...
  CCLD     src/bluetoothd
/usr/bin/ld: profiles/input/bluetoothd-manager.o: in function `input_init':
/home/../bluez/profiles/input/manager.c:122:(.text.input_init+0x1c8): undefined reference to `input_set_auto_sec'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:6376: src/bluetoothd] Error 1
```

This patch moves the reading of the HOG specific configuration of the
'input.conf' file: LEAutoSecurity, to the HoG plugin file.

[1] f2778f587 input: Add LEAutoSecurity setting to input.conf
---
 profiles/input/device.h  |  1 -
 profiles/input/hog.c     | 40 +++++++++++++++++++++++++++++++++++-----
 profiles/input/manager.c | 11 +----------
 3 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/profiles/input/device.h b/profiles/input/device.h
index 7b87ce590..036a88980 100644
--- a/profiles/input/device.h
+++ b/profiles/input/device.h
@@ -25,7 +25,6 @@ void input_set_userspace_hid(char *state);
 uint8_t input_get_userspace_hid(void);
 void input_set_classic_bonded_only(bool state);
 bool input_get_classic_bonded_only(void);
-void input_set_auto_sec(bool state);
 
 int input_device_register(struct btd_service *service);
 void input_device_unregister(struct btd_service *service);
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 017e320f0..f82648fec 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -57,11 +57,6 @@ static gboolean suspend_supported = FALSE;
 static bool auto_sec = true;
 static struct queue *devices = NULL;
 
-void input_set_auto_sec(bool state)
-{
-	auto_sec = state;
-}
-
 static void hog_device_accept(struct hog_device *dev, struct gatt_db *db)
 {
 	char name[248];
@@ -228,10 +223,45 @@ static struct btd_profile hog_profile = {
 	.auto_connect	= true,
 };
 
+static void hog_read_config(void)
+{
+	const char filename[] = CONFIGDIR "/input.conf";
+	GKeyFile *config;
+	GError *err = NULL;
+	bool config_auto_sec;
+
+	config = g_key_file_new();
+	if (!config) {
+		error("Failed to allocate memory for config");
+		return;
+	}
+
+	if (!g_key_file_load_from_file(config, filename, 0, &err)) {
+		if (!g_error_matches(err, G_FILE_ERROR, G_FILE_ERROR_NOENT))
+			error("Parsing %s failed: %s", filename, err->message);
+		g_error_free(err);
+		g_key_file_free(config);
+		return;
+	}
+
+	config_auto_sec = g_key_file_get_boolean(config, "General",
+					"LEAutoSecurity", &err);
+	if (!err) {
+		DBG("input.conf: LEAutoSecurity=%s",
+				config_auto_sec ? "true" : "false");
+		auto_sec = config_auto_sec;
+	} else
+		g_clear_error(&err);
+
+	g_key_file_free(config);
+}
+
 static int hog_init(void)
 {
 	int err;
 
+	hog_read_config();
+
 	err = suspend_init(suspend_callback, resume_callback);
 	if (err < 0)
 		error("Loading suspend plugin failed: %s (%d)", strerror(-err),
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 95ca0a7ee..1c0b6122a 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -85,7 +85,7 @@ static int input_init(void)
 	config = load_config_file(CONFIGDIR "/input.conf");
 	if (config) {
 		int idle_timeout;
-		gboolean classic_bonded_only, auto_sec;
+		gboolean classic_bonded_only;
 		char *uhid_enabled;
 
 		idle_timeout = g_key_file_get_integer(config, "General",
@@ -115,15 +115,6 @@ static int input_init(void)
 		} else
 			g_clear_error(&err);
 
-		auto_sec = g_key_file_get_boolean(config, "General",
-						"LEAutoSecurity", &err);
-		if (!err) {
-			DBG("input.conf: LEAutoSecurity=%s",
-					auto_sec ? "true" : "false");
-			input_set_auto_sec(auto_sec);
-		} else
-			g_clear_error(&err);
-
 	}
 
 	btd_profile_register(&input_profile);
-- 
2.49.0

