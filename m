Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853B63C0C
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Mar 2025 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743173053; cv=none; b=LozCiXvCk9T9pF3MQYeaZDjd7X1zXVinfQ5lWG+ayqsH2WpL8+229srRN/lpOWewo03VOB7HVYBAADtj+oxxjjzZfbIzVtsFeae7fwxkNM8RftulB2sshMchNcolmvuGtNfjHIDXobOVghiPgNQ3TUDUgNHB4jmqdm2wwZMFoJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743173053; c=relaxed/simple;
	bh=EZHD9JRNB+f2KklEYjBK5T93LVAuQ16hCHxcTl3ptnA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gAa9zCceHLwgXQdHB1PuFvuHndgyaN80M4n2cGa9pZ196v4MI3023PuorymFxj+LV+6Qhh3Mog2SIo7Ayx9kzzoTdKbeMze5DJR/hOegpj/MSA1ofiVF59/4p7CZ+rpq7AMdxD4x63dewEF6dnE8NpH0MPmLpFsbTZewvHyersU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCtdDBBs; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCtdDBBs"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-51eb1a714bfso2158767e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Mar 2025 07:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743173050; x=1743777850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nzhdd8fC1lWOqYbiUHcfJUyP6/Emy6UpFAyh6LNKxZU=;
        b=DCtdDBBssuejNUyJmUHavaTMsdjheKNJrso1oUTqDOfuU0HQUbmGPmd4MroHItPMGO
         0rmyMIW0vn9f2Irhh/H2ZoW35Wbo2DP7IGt4tI2kZv/8nxd9ing7kReIOrLbITVgae6f
         fo04eMW8t+hetq3WwrAxA5LMevgW1KFvrowQaN89mJD7IHTyCocmVPVfmeCj1WcKOjvZ
         3t3iVXSblvUuNXo4qLp9bJOOr9jCUterLZw1a/T897Wd+ECPUoJ+9KMbY8MTqWYGjUxx
         6uJAkdDZvW9NwXMZqAPTmqx4BJEoFp3P2wEnyuILZwl70HNRgyXrwnbE3htmgMe/FlVq
         GOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743173050; x=1743777850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nzhdd8fC1lWOqYbiUHcfJUyP6/Emy6UpFAyh6LNKxZU=;
        b=uLl7H3OjkalTGqhr79H3enPViibyDHfJeEswau0Tznf191pguXDi5lri5pDHb79loy
         JB0JsD6Z8fatILmWH3200EI6bivop34h8mlUpEYSdS5uH1k8wHBBpmaU/rZoC1GSgNpW
         q5VbI19ve3d2LzdHeeZNzdLtizVeVcS/Bckzz1I2JMVUHPRV8ON5wYIcYeGyskHckJOr
         nNZ+Ucll6ycDIFuFTFHzKZhIrd7aDXaJgPzGCT1luUNXEWFm0h4boMoj2STjmStSmv2W
         pI7GoDNJwtK7BEsavFc+G3rutlVacZk9Y0SApd1UbHGfME1tPEXLBSIiAFlep2vU8Uzm
         8fAg==
X-Gm-Message-State: AOJu0YyoMwTtw5I9R/7ZyDCuXtJrBCsfl+5rAPVl7+nFDQvvqSGdBxCZ
	6XkNozTgK+MTHHopE7p1FFjpVYwy0ruboVkMCuKFA1N/C3eY5AOR+Riso4ca6Ig=
X-Gm-Gg: ASbGnctUH8OtXUTlKGN09IKs8QBaHhnMEP4mS5kJ2muWRxG5LlNALTq3nNAdEXzFRMR
	J4lHdIMrfIPIDPefS7m3y4kOvTFxfuZs0ZP+cXNfQpA167gkJNYmsmEuzzi3Wz25S0B+Tsgblu+
	aKwgVCVApsQxb0vzxKwqBSFi5G5EFa/41nQs+pQOhFjKjzKJBPzUQwP+B55B+ryoAUJ1GM9AJ3u
	4MJYx13w+4sbz9fFkJ3QokF4lh5MKsY3lQFw1yJiG7utV4qwXoF+u8ybGyE4BQrCdCActIUiz5b
	7I/1eFe+afyH/Rr4Vg5vShPXxNpJLZR7Mt9Fn9sAh543TSu7nbXTSUUJbRjUfS4wDJHdJMWz9oa
	bgAsOFw1kNnOYoA==
X-Google-Smtp-Source: AGHT+IHJ2DKpS+gOyYOzk+Wfa5cejyoUX063FDam1rFHp2vNEKNa92siPQL+HRW43jQABdkaLrAULg==
X-Received: by 2002:a05:6122:a1f:b0:520:62ce:98ed with SMTP id 71dfb90a1353d-52600a3145amr7492504e0c.6.1743173049578;
        Fri, 28 Mar 2025 07:44:09 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5260e8422e3sm426372e0c.23.2025.03.28.07.44.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 07:44:07 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] a2dp: Fix removing local cache on restart
Date: Fri, 28 Mar 2025 10:44:05 -0400
Message-ID: <20250328144406.3122778-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Endpoint cache shall only be removed when the device is being removed
not when just because the service is being removed since that is also
done when bluetoothd is being restarted.

Fixes: https://github.com/bluez/bluez/issues/1146
---
 profiles/audio/a2dp.c | 40 ----------------------------------------
 src/device.c          |  1 +
 2 files changed, 1 insertion(+), 40 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 81dbbfae39f6..0eac151db29d 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -880,44 +880,6 @@ static void store_remote_seps(struct a2dp_channel *chan)
 	g_key_file_free(key_file);
 }
 
-static void remove_endpoints_cache(struct btd_service *service)
-{
-	struct btd_device *device = btd_service_get_device(service);
-	char filename[PATH_MAX];
-	char dst_addr[18];
-	GKeyFile *key_file;
-	GError *gerr = NULL;
-	char *data;
-	gsize length = 0;
-
-	ba2str(device_get_address(device), dst_addr);
-
-	create_filename(filename, PATH_MAX, "/%s/cache/%s",
-		btd_adapter_get_storage_dir(device_get_adapter(device)),
-		dst_addr);
-
-	key_file = g_key_file_new();
-	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
-		g_error_free(gerr);
-		g_key_file_free(key_file);
-		return;
-	}
-	g_key_file_remove_group(key_file, "Endpoints", NULL);
-
-	data = g_key_file_to_data(key_file, &length, NULL);
-	if (length > 0) {
-		create_file(filename, 0600);
-		if (!g_file_set_contents(filename, data, length, &gerr)) {
-			error("Unable set contents for %s: (%s)", filename,
-								gerr->message);
-			g_error_free(gerr);
-		}
-	}
-
-	g_free(data);
-	g_key_file_free(key_file);
-}
-
 static void invalidate_remote_cache(struct a2dp_setup *setup,
 						struct avdtp_error *err)
 {
@@ -3390,7 +3352,6 @@ static int a2dp_source_probe(struct btd_service *service)
 static void a2dp_source_remove(struct btd_service *service)
 {
 	source_unregister(service);
-	remove_endpoints_cache(service);
 }
 
 static int a2dp_sink_probe(struct btd_service *service)
@@ -3405,7 +3366,6 @@ static int a2dp_sink_probe(struct btd_service *service)
 static void a2dp_sink_remove(struct btd_service *service)
 {
 	sink_unregister(service);
-	remove_endpoints_cache(service);
 }
 
 static int a2dp_source_connect(struct btd_service *service)
diff --git a/src/device.c b/src/device.c
index 057d116be6fc..b82a905f9995 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4984,6 +4984,7 @@ static void device_remove_stored(struct btd_device *device)
 	}
 	g_key_file_remove_group(key_file, "ServiceRecords", NULL);
 	g_key_file_remove_group(key_file, "Attributes", NULL);
+	g_key_file_remove_group(key_file, "Endpoints", NULL);
 
 	data = g_key_file_to_data(key_file, &length, NULL);
 	if (length > 0) {
-- 
2.48.1

