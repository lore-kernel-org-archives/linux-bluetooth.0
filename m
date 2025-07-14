Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9A8221FB1
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752525332; cv=none; b=J1OzabaAMUarzS8vKQHLTQ+mKUJB/uxNsGAeAxkiAKcliPB9pvP0R/g7wVdv7ZXHK47HGLRC2mR7bPDZrtQeTpQ+j4lKX9LcV2TVV5P0PLHbjM/cTVtdLJ0n3/a3y/mK5gqV8bgOl4XfmuWzKW3d/Roj+dsaM6xzvOOwHK56jbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752525332; c=relaxed/simple;
	bh=UOX/S+4oHmPT8gRXsIb/g4vR3OhIb0mKAdkH6xtprdU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=s6/pejniOU70pEwxhB+9AytyBe4LplEbdAxYPG2018cLHo28KIvyRGupVaN1XASWdFPw6WrIuBoJs2AEEeN4Y7BjEpndoT8iNnafqFkVlhdeM2CtLLooiMDB9iuC3F2/dEPU26M4FiZ9A4dYElHUoZrBT5Yukdl4o7XoMr3KMBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrzTCDFu; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrzTCDFu"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5316a5e4c6cso2019381e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 13:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752525329; x=1753130129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Z7TNC2hDeAZbCa2PfL2ZvB9M3TFOnVbKwuQ501N2T4=;
        b=LrzTCDFudue5FwmrtEjba91wnTQhs843iizz3wCeEIBPHk7LLqSVzLpciOx3aTgDp9
         KPHGey4ZICQVWtxEqJcVy4SjN1rVktflr7D9D3VmpchFEBAa2DWMjtreat/AY++52ZP+
         32qDWT8JIn6PCK2ynCpP5d4Ejfz9PzKj33gk4XqFc+mctz8a6fZhCwM+j8h516SeEJWv
         AMpAjfEWGXvQdy7GSlc1UPi8uDEB/Sjkd3/ywIHeEdABx6YgBrKx1JRnartMTQbO4stn
         Dc/nOzSlljX7faPllhSyXsxNj9pWIBA+mEgPKrJHYlZGV/GabQ60q9KhqQcgtMH+rnym
         ZOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752525329; x=1753130129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Z7TNC2hDeAZbCa2PfL2ZvB9M3TFOnVbKwuQ501N2T4=;
        b=GC4jmrugDgsRYcZhStuT/tAOjkvYWP3Gkewe+UXjIho72VQJmvl/x/KONLTpCBesAq
         W27SuALAzeZ6LxzYLDnw0MQ1+HaGro+0h8S8RyGwlEIH6G1qP9yL/E7DoT0dHvEED1ap
         nyuSqBJHmDAayFr9Wg+K66XWG2sEWi+HOdF4+A6iNx/s2CO/MpKNXJwGOqTb4+NBTPtE
         ziw7XzG1uiv3pW4pJYga7DFh+uu1xguFQeoaxAnp6CFdZ/N/2j47Rg5sGGaGgAaMTUZY
         DyJRyk/SHblQ2EP06571wdNcp3YtgMADhAzRI7ruZsv2mQyzYsxJTdr2llzryFNPB8Jv
         MRgg==
X-Gm-Message-State: AOJu0Yyo+odDtA90OOsrQ7pxGx4vOUHD587Dr7m/gbTuHYXkmb3kW0Kv
	D10vKsgeDNaI7fEsykZhAg59nmI7hlTVLL6akej+BkDGSU6hPqE7QRgdlS0ov4Li
X-Gm-Gg: ASbGnctPl0AZLwVg5OpcJHfgT5zxGps4qKXZZ/7p0Aj9lg5vfnkYWBcHD92Ug8HU1G8
	VHr38nzOQzat/ECPm/thGaFH8tFm4SpHkINKarinrTH6qkL3lyxcCi4eJoVbXIprXYrszBg5ZCz
	HAZ2bKQNPJ6fMR51D+ExQO8FtR3z9Yz7Dm3uYoKCluA6Qk7NLzfH13cjWLCe15/nU1tHrhGYmZk
	bYdZlZS4diqMhz9n+naO/k1eurKCyMHxLWxGMZIITm9KfAsuEzLuFicgXfYx7YCvI09n+VcjuRS
	EIcnTMbZTwbFTg4b6QrhV6D/V73MaqHS0RJFBP5If13DV90PxHbgO/mDWVSY0J0KlrsHbDgbqDU
	Ll9BOIG9bow1Mr/i/XcW6uX7d9t2KyTXnZxsm6jwGJ3/AOx9ey9blgXj7AIOAL+8U
X-Google-Smtp-Source: AGHT+IGHyHGVa8QqvFtuLuz8ItCLwoyx5DYAOprVJI1sIUtNS9ag0fa7USFsnF3lxe63JFy36iwVfA==
X-Received: by 2002:a05:6102:41a3:b0:4eb:2eac:aaa0 with SMTP id ada2fe7eead31-4f641f97194mr9043139137.19.1752525328774;
        Mon, 14 Jul 2025 13:35:28 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-888ec44a6f6sm1887177241.24.2025.07.14.13.35.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 13:35:28 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/5] device: Add btd_device_bdaddr_type_connected
Date: Mon, 14 Jul 2025 16:35:15 -0400
Message-ID: <20250714203519.345226-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds btd_device_bdaddr_type_connected which can return the
connected state based on the address type.
---
 src/device.c | 8 ++++++++
 src/device.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/src/device.c b/src/device.c
index a50d9ad5cee5..eed2edcf0dfc 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3632,6 +3632,14 @@ bool btd_device_bearer_is_connected(struct btd_device *dev)
 	return dev->bredr_state.connected || dev->le_state.connected;
 }
 
+bool btd_device_bdaddr_type_connected(struct btd_device *dev, uint8_t type)
+{
+	if (type == BDADDR_BREDR)
+		return dev->bredr_state.connected;
+
+	return dev->le_state.connected;
+}
+
 static void clear_temporary_timer(struct btd_device *dev)
 {
 	if (dev->temporary_timer) {
diff --git a/src/device.h b/src/device.h
index 4eebcebe9d5c..9e7c30ad7186 100644
--- a/src/device.h
+++ b/src/device.h
@@ -110,6 +110,7 @@ void device_set_tx_power(struct btd_device *device, int8_t tx_power);
 void device_set_flags(struct btd_device *device, uint8_t flags);
 bool btd_device_is_connected(struct btd_device *dev);
 bool btd_device_bearer_is_connected(struct btd_device *dev);
+bool btd_device_bdaddr_type_connected(struct btd_device *dev, uint8_t type);
 uint8_t btd_device_get_bdaddr_type(struct btd_device *dev);
 bool device_is_retrying(struct btd_device *device);
 void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
-- 
2.50.0

