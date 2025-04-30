Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BC625E817
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746023827; cv=none; b=ZPgS7zClM3HISjhiaiCz1vx0z/Ji0RF3UNs/wxPk1o70iQBrrvOlr3BTBcbx8hytLl5VPf29OWUu/oE6N187VXLbsFgd1XKhp3X8VMIau1jyFBk4G/DVlVCwLzwARrvoDhIKwam3zxjdW2USVwTBB/p8MuQKxAZzWEALELYssXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746023827; c=relaxed/simple;
	bh=RdXIoZD6JEzYOVtVXsIPuOA2y1DMDjGNBH4zKnRE8XU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldGAoNcYjZ3dHeTlqJOLe5oun7yz2uTQZWlRN/m/vtl5yosPJ3SDLlE6/c7yNDqPcurKCLF3ccmFgu+4+3U2papx2CNREB8uBwaVgosumlAMuKFj+GDc+iidEk4bSzUGh16fRkY1vM0XvCKWHA1qsgkPk6dg6YUL7khC5ZkmCvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mind.be; spf=pass smtp.mailfrom=essensium.com; dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b=SY+dv76J; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mind.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=essensium.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b="SY+dv76J"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-441ab63a415so27786325e9.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 07:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1746023823; x=1746628623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QySfX2OFME5Sb6aFaEFML/JkdMlDAnIAKR3rL6EDpBk=;
        b=SY+dv76JJZ4KW/R1iZEYB/r60cU5D32CCm235Y7AFK6KQAP0ZsoerZLjmwEWkIXCK4
         KmsqBLScth/ef+DShA+Tlm9tiYS/1VlAnuSQDvLDEcaG0kl86KFYnNj23pCEl6E099c4
         oEorhs9pV8NOJKk9wZmlAQCwQ+dWHjYLJG/hAOJ41/s2mIC7PeogSGBHnWlydMIhjZ1+
         UemfIp/NawolkAD0yRI6RtVr2Y6G3fZMNfC7onef0ipYlqpSkoewRj0ETfATS+pe+we4
         iCJm3jKIOdMqFe7WS3nz1WCa7vEt3V5fs2lmlrev4bf7tmttAJ9dcoAIZU34sx7tjw9V
         Uo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746023823; x=1746628623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QySfX2OFME5Sb6aFaEFML/JkdMlDAnIAKR3rL6EDpBk=;
        b=R5lZpBb1CBkcYBGjUr27gk2n6D1rJ5NVVTdTabXlyzN66Ln5mzF7u8KdLUnZre36/m
         RJy05JwfvWnywfR9FJ07NzcbdTkfb0yFPYW1AlqoHa2iibaeu5kwn2SPDDXEKkpJVP9N
         RkG23/THHlk6xKEvcMKK1oJZOtJC9jA+Yk6R6zVUOuw0uRuQJHJJ7xLfEvAzAEG50yQc
         Yh65wXxnoLpkZ8BlQqCTrxe7WDBRioe0vIDjyt+0Yjqm9u+efv2UPQMvKcF7klrvri5W
         3YmP+5wGK71Nl+uC+6CcblbDwPeIQrxqBmQhy5ESSEh8XoFXPDqTuclNgus67/L743JN
         ha4A==
X-Gm-Message-State: AOJu0YymaRswg+Tj5n9TD7N31jNONkobefobFaGzpui74MHEEi/NFvwu
	duVhjvDMygbBB+fcacn5VFgE0Lw9dr77DfdBF+JAkS1j07lphVsTu+4ZJ1FuADlxk899apwi2KG
	TAZQ=
X-Gm-Gg: ASbGncsZB51FzW8r0bwRfulcZCm7GeN8KFz9uhEVe2pPA+PygcUH7DrukOVOb3CfF4X
	7z3ksMIwHx2b/i8twl4v8QASVVkYVKVp7q54KmixOmhaw7LG/LQoRmjdTrWToOWpbi1J2WR8X1k
	RBfQ+0iEEc+M3mWPtaPRDDKZ0aFUAQ/WViknPsHNJhEuTAWPftrj4dg4vRYN/Rs7E9tQEkwOY+G
	ahwFF2xLuHIFbcdNyVaAH0B3ji5GW6Vh2gTKNybnStru8NIDQUAkSIerCeTNGMz8g1kfWQDud0r
	Bg7LcgrzKSCf6Kp9GjYlq2Sh87GCqUgOa90dyZPs/lz0lfAJKUNl6H1MBKn/fn4mUg==
X-Google-Smtp-Source: AGHT+IHhgQKpE1fV7y7B6KbNeGFY/m8JhCDtvO8nG2+sKJcwP3ScvfLPDAG2ubyg//lHvDbG9yL9sw==
X-Received: by 2002:a05:600c:4f8b:b0:43d:49eb:9675 with SMTP id 5b1f17b1804b1-441b1f5af68mr21891165e9.22.1746023822886;
        Wed, 30 Apr 2025 07:37:02 -0700 (PDT)
Received: from localhost.localdomain ([79.132.233.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441ad870ae0sm34497285e9.2.2025.04.30.07.37.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 07:37:02 -0700 (PDT)
From: Thomas Perale <thomas.perale@mind.be>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] input: fix HoG compilation w/o HID
Date: Wed, 30 Apr 2025 16:36:10 +0200
Message-ID: <20250430143610.387300-3-thomas.perale@mind.be>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430143610.387300-1-thomas.perale@mind.be>
References: <20250430143610.387300-1-thomas.perale@mind.be>
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

This patch introduces the HAVE_HID symbol to conditionally call the
HID-related code in the HoG plugin only when HID is enabled.

Additionally, hog_disconnect() reverts to its pre-[1] behavior when
the HID plugin is unavailable.

[1] 1782bfd79 input: Add support for UserspaceHID=persist

Fixes: https://github.com/bluez/bluez/issues/1228
---
 configure.ac         |  3 +++
 profiles/input/hog.c | 11 ++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 1e089aaa7..aa56b7b81 100644
--- a/configure.ac
+++ b/configure.ac
@@ -194,6 +194,9 @@ AM_CONDITIONAL(NETWORK, test "${enable_network}" != "no")
 AC_ARG_ENABLE(hid, AS_HELP_STRING([--disable-hid],
 		[disable HID profile]), [enable_hid=${enableval}])
 AM_CONDITIONAL(HID, test "${enable_hid}" != "no")
+if test "${enable_hid}" != "no"; then
+	AC_DEFINE(HAVE_HID, 1, [Define to 1 if you have HID support.])
+fi
 
 AC_ARG_ENABLE(hog, AS_HELP_STRING([--disable-hog],
 		[disable HoG profile]), [enable_hog=${enableval}])
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 97224f0d1..7ad94c474 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -40,13 +40,16 @@
 #include "src/shared/gatt-client.h"
 #include "src/plugin.h"
 
-#include "device.h"
 #include "suspend.h"
 #include "attrib/att.h"
 #include "attrib/gattrib.h"
 #include "attrib/gatt.h"
 #include "hog-lib.h"
 
+#ifdef HAVE_HID
+#include "device.h"
+#endif /* HAVE_HID */
+
 struct hog_device {
 	struct btd_device	*device;
 	struct bt_hog		*hog;
@@ -181,8 +184,10 @@ static int hog_accept(struct btd_service *service)
 	if (!device_is_bonded(device, btd_device_get_bdaddr_type(device))) {
 		struct bt_gatt_client *client;
 
+#ifdef HAVE_HID
 		if (!input_get_auto_sec())
 			return -ECONNREFUSED;
+#endif /* HAVE_HID */
 
 		client = btd_device_get_gatt_client(device);
 		if (!bt_gatt_client_set_security(client,
@@ -202,10 +207,14 @@ static int hog_disconnect(struct btd_service *service)
 {
 	struct hog_device *dev = btd_service_get_user_data(service);
 
+#ifdef HAVE_HID
 	if (input_get_userspace_hid() == UHID_PERSIST)
 		bt_hog_detach(dev->hog, false);
 	else
 		bt_hog_detach(dev->hog, true);
+#else
+	bt_hog_detach(dev->hog, false);
+#endif /* HAVE_HID */
 
 	btd_service_disconnecting_complete(service, 0);
 
-- 
2.49.0

