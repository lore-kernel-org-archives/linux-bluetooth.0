Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3485125D1F4
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746023827; cv=none; b=q9wSkaSTdVekTkVnaGnQEzs3OSPgZvk6oMCbCYJlp1l/z+vxBaz7BCmH5ZU7/IL+70xp5Yk/cBcwshuiuIKvNvIknW2f7gKncph+smsSKXZj5QxFNTK+RoY1irZB5Ch47ssq9pbrwf+PVH6JNer/Ce291QlvCqQ+ebOXPbCYb3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746023827; c=relaxed/simple;
	bh=GwIcoOmmrZQO0osvneDwEiNT+s/SeE/nHZATdS3Lq/k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BL0ed8o6hqr2BhdCBSeBPLn/268HDJtQmfyX+PtoGjEZuK+wJ0gb5oL3keOawUhkbhAf40orURtEUacj+KmGNVw6OjQRsqJN+kibWCFRpQP182+ngWsMlmqbMOJtRmgc8Ehn2OFrM8sRXsxaqNnxFgSaNqHvh0OoOkc4Ag+QBFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mind.be; spf=pass smtp.mailfrom=essensium.com; dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b=bmQ3UMUR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mind.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=essensium.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b="bmQ3UMUR"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so48236685e9.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 07:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1746023822; x=1746628622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcxPVJ1HUbFctzwHwSui1WVMdbIrCQQBEpS224QAHFU=;
        b=bmQ3UMURK7XVT7FRvyEv5NfXNRDp/bbci3gKDqubKn6sRFyEqyYIQ/DWw5cXt0PDiA
         T3OeiJLU5EC6Kg66Ywzk8NeSHUnbk8wFKPYE0SYQCDLhRmqHFOl+e8EA7EzP0bokX6Ri
         LTKMCRP54e2QXj6n3GPgjEKgx6MkEWFtpsIaaXvjHJ9G2gQnuLdvqMNgPqNurkflRXV3
         yqeNepfBkCnhVrsz9xPyJa3bt2CKGt2i1Rwdf/avSp6hTAB09qtxSqu5oZ8mDJiwdS+O
         IMGAKWUkU7Lj6cSVMYys04kMDJljEfkS78aZd9nqcl0m20brG1sNiPVcmQgr5tiyUQhq
         gGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746023822; x=1746628622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcxPVJ1HUbFctzwHwSui1WVMdbIrCQQBEpS224QAHFU=;
        b=okASylFUd8PlKF6ABbzqRe7MX2X/Wld5sAR7RxCohUY2Vg787+AvaruqeyDFDzo0bR
         OuKaEXVJNkOuXI/dIYJicZk6pv6mTrxU3qUMExjAlb9mAiIdzNNp7dQAd3BGEDxXJlmF
         SCIdvdEf/hkPZJoi87oU2QHvW6xuzs1TSs0jeZGtrAzD3inwriEgbEv5RYoWtHnkoWEh
         fJkJkuD1RbltyLLusaihPV4LaC/2Enz/0bxhuC9tEhDDt8yfjasZnsOrdav2xkmcjzUF
         1gN7Qxw5GqQZ41+BUi+A8CBD9UWLPR2hc+xzdgOzEMl0tLrQftFqRHINT/hWPkCUgsCg
         LSeQ==
X-Gm-Message-State: AOJu0Yy8JJyeArzDKuvZIqnwCL4pFd7xqX2Q4myQy9As0DscbJZxxsaQ
	qLL4MOIhKPnknj6shM0KF3OKucRsv8vOACNl8fJppUu1dJdGOd50hybeqOuSkziQirphc/vxQkz
	+68Y=
X-Gm-Gg: ASbGncs6MwvmdDAZeo3i4RooagSyfK0QvEhHTIzM1s0atS/fhLr+xlG/kBVnlPbeaBh
	SZKSU1ihckbxY4YIJfba46X+VunTe8w0Wv3kSRryygaOA+NU5FE2QjCoX4fhnrQYd3ZYFkq5Sn1
	KeSpUFpiS2XIqElIIw6ma70SabCx24ptwJtOT4Dwy+9t4GGCoQ/6iXC7lJrnGFSYPFnRuwPhrNg
	AyaAX0doi4TH1D0ni6FCgJ4x7XmSufNdpzSA7XeiS+u+bGwGZRmCS4cdoXqy470e1GkahC92jTs
	8EMhCWlpZH6y7g0BgRTWz+PQwgNnTDH7cieLUjys0ImT6mSrQHdGKDA=
X-Google-Smtp-Source: AGHT+IHtOtVqo9jYP+53iCoxhaaFt/Id8FZeKt8NrAdG0Pp6wUB02rvBHI4ZSbUk+dqnmnophtrK0Q==
X-Received: by 2002:a05:600c:540e:b0:43d:7588:6687 with SMTP id 5b1f17b1804b1-441b1f35790mr32888235e9.12.1746023822167;
        Wed, 30 Apr 2025 07:37:02 -0700 (PDT)
Received: from localhost.localdomain ([79.132.233.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441ad870ae0sm34497285e9.2.2025.04.30.07.37.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 07:37:01 -0700 (PDT)
From: Thomas Perale <thomas.perale@mind.be>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] input: fix HID compilation w/o HoG
Date: Wed, 30 Apr 2025 16:36:09 +0200
Message-ID: <20250430143610.387300-2-thomas.perale@mind.be>
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

This patch moves the `input_set_auto_sec` function to
`profiles/input/device.c` file so it remains defined even when HoG is
disabled.

[1] f2778f587 input: Add LEAutoSecurity setting to input.conf
---
 profiles/input/device.c | 11 +++++++++++
 profiles/input/device.h |  1 +
 profiles/input/hog.c    |  8 +-------
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index a7bc4d44f..d27cfccee 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -92,6 +92,7 @@ struct input_device {
 static int idle_timeout = 0;
 static uhid_state_t uhid_state = UHID_ENABLED;
 static bool classic_bonded_only = true;
+static bool auto_sec = true;
 
 void input_set_idle_timeout(int timeout)
 {
@@ -127,6 +128,16 @@ bool input_get_classic_bonded_only(void)
 	return classic_bonded_only;
 }
 
+void input_set_auto_sec(bool state)
+{
+	auto_sec = state;
+}
+
+bool input_get_auto_sec(void)
+{
+	return auto_sec;
+}
+
 static void input_device_enter_reconnect_mode(struct input_device *idev);
 static int connection_disconnect(struct input_device *idev, uint32_t flags);
 
diff --git a/profiles/input/device.h b/profiles/input/device.h
index 7b87ce590..9d31fdc51 100644
--- a/profiles/input/device.h
+++ b/profiles/input/device.h
@@ -26,6 +26,7 @@ uint8_t input_get_userspace_hid(void);
 void input_set_classic_bonded_only(bool state);
 bool input_get_classic_bonded_only(void);
 void input_set_auto_sec(bool state);
+bool input_get_auto_sec(void);
 
 int input_device_register(struct btd_service *service);
 void input_device_unregister(struct btd_service *service);
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 017e320f0..97224f0d1 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -54,14 +54,8 @@ struct hog_device {
 };
 
 static gboolean suspend_supported = FALSE;
-static bool auto_sec = true;
 static struct queue *devices = NULL;
 
-void input_set_auto_sec(bool state)
-{
-	auto_sec = state;
-}
-
 static void hog_device_accept(struct hog_device *dev, struct gatt_db *db)
 {
 	char name[248];
@@ -187,7 +181,7 @@ static int hog_accept(struct btd_service *service)
 	if (!device_is_bonded(device, btd_device_get_bdaddr_type(device))) {
 		struct bt_gatt_client *client;
 
-		if (!auto_sec)
+		if (!input_get_auto_sec())
 			return -ECONNREFUSED;
 
 		client = btd_device_get_gatt_client(device);
-- 
2.49.0

