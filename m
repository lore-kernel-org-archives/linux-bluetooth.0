Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531613;
	b=ZqDx6A9jSw6N0LR/rttcfHw1lDLpkniRm7wzNgBD3GV0USPZC8C2lxAqRuoz/W1+u/+6
	 Qhrr9t6YIXrThu0441po/7hgB4cNJUCiTgZbtNKq3vYrsxarjGCqcwRsQxKKElcnnar0e
	 /rFFqo5KYoBLV54V13vvH/y4iLRQVEXFFw7qQqRZf2dz4VMOqLUqjZtgQ+4yKa5GByeal
	 7NtQHNA6m3Yw6fIpzM795s9fPbd8A1yxUHi5D2CGv6M4AW2qCfGvNPZ7GGWS1Zzmzs4Rl
	 CmHqidaixCbwRxpnCRpD+LS5SdQDy8VOwFT34C9TTUZYF4L1D/GXyTUNKTzAhnKaPuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mdld0D1yE/J63qgOC2C+zzh5Ht1TFl4rC872bUAhPJw=;
	b=rjV0gGBeg3Yy8LvF7WqQ0iuD723UMdX2VvuPkm17SO0xnpiir6SXUitNuIoIUKaDNF0s
	 bhRvl9DoJSsMJAMdbiqjF4CP/cMprOPTIbkpcWvh6yxuvyQQrYkjq38T4dOmdTHSYyDP7
	 3/hkWE7KcDnYJbHsuMSEUciB5RUYaIYauGIDopwQZ/ncybK8iMZPdUClNY0lu8o4M9Eq8
	 fJGMq0CQH21iHC7zEcnS6bpwrG9MamMeQDtw7/qJAwnovrQvk85nxQEtvle329VpQupVX
	 kbkd6ZsMWynxrRBVxlOAxJBCPzCAYEbMgo7FSX/z8PBmCfWwO9KnLjG4Z8f9HAsWa3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=HQrNqMwF;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF4F606A338
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 14:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CF4F606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=HQrNqMwF
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-498f5fa5103so2755078f8f.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 06:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795531612; x=1796136412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mdld0D1yE/J63qgOC2C+zzh5Ht1TFl4rC872bUAhPJw=;
        b=HQrNqMwFLBQ4mxWRiQoHSq7dNt0mFeix56mzpG71GPhIFpPnLY3mblP28fijihBKbl
         +30ZJN2Qb372t8eV0uOvpldO2lU4xjctqUuQrMNnv/b0bPnLVtSu/2ji5+CtuU7E+32o
         HOQ2MARnrLC75M3VKDXMMT961Ku71HdjnWCm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795531612; x=1796136412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mdld0D1yE/J63qgOC2C+zzh5Ht1TFl4rC872bUAhPJw=;
        b=ofVsdNN5OqqSBUNJ4Csn521jSvnS74NvsDX9NfeZX9uOk0TsVc1qdScf5wUm1ERtQM
         SF/iI2FeVYYuTAZsVF1kpb65VhLCVsZl2mvZJjNT/XYh+B2HY9p6S5kPo4bU3RO/uJ/o
         tPnv2U28vRjIkzSILdw+LQ9scr7/23/KsdYdJHNZB7hq4BkLcrKSBib+uYIPS7TOx+Fm
         QS7wO3a+yy0GMvg6BJsjkl/27pxbAsF7L0UsCdKCzzeN8qXHJJuz3hRKTkFUQftOdkRN
         eG1URDiSjuMFJnbzB8hjCAllQLYHxMkpRYDSht2Xn3cawgRJoqryIgbKxOl2mP2Ph/Wa
         hgVw==
X-Gm-Message-State: APuU4Z8aFcM018zqsaldDZdjcgRJflGBD032fuV2sMF+sXM4P1yyjsT3
	xuVYebni/5wcpjxORLjcD3pdXXifkI0g0zbxFIhhs+tRtaDicIHMeh7v5V0dim3bIE0sqrCJD0s
	QJN2M
X-Gm-Gg: AZFdTZfAiYoWLiFFXHCYhSWlOMoeXGJC5juvePUcVWNra9ZFOlA44EjGOOvO/jH1Xd2
	XXM9JzNDcc3QO9IlfjvbQY/K1ad/igGE2nCw1WdfSOlnDsAbB56uOTPSnFYgeA99x7Se6LhtnI2
	2o1JkcsMcZPmPiYRsN7nwrwTuZaTjXj4MxN6Xf4gEHZ/hf6t8ox3xgqU6HBL/uK735mt6Mc8UM8
	q+AaGqWB3QUzT/7r21PsVmDHRChOtFFjhSWgKfw2/J7j2eTkp3XYg+vgA9LjeU8gcAHEJlKuCdt
	7O/QYo6u+CYsan5IsR4IIdWsgPyMeT9zhgrYKvgBo8OEdrZI1KYA5Iks/x/FAp7ZKZufnLlgyX4
	QuyKP5PP6emPdRHMqexzLRUHg89FvfOfzkzYQcDe81RBqH9or70w1bp2qbqXjfk9T8gE4v+RZRM
	lePwH3e+dFJ59nuQ7SuTDI0nWaOi0K1wvKL8VMYZSMjLJ8wtmMWw4hWyScCRO3J9crSwPAUgetC
	xYLuvlPGTJJEfk2ZvDPyWqlfXQ3a70WJciAey22OBbcMgySP577sav+cR5/K6CZpg86kQTKZ6Cr
	aY9ZJnn+tHYKol4v/DjlnsaANMLvxwclyWIMxy2p0nXbmIFlzw==
X-Received: by 2002:a5d:5888:0:b0:4a7:8406:1e91 with SMTP id ffacd0b85a97d-4abb532eaf0mr25645015f8f.30.1795531611725;
        Tue, 24 Nov 2026 06:46:51 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf61e8sm29891561f8f.11.2026.11.24.06.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:46:51 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 4/8] device: Don't resolve services on GATT over BR/EDR
Date: Tue, 24 Nov 2026 15:46:38 +0100
Message-ID: <20261124144642.298366-5-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124144642.298366-1-simon.mikuda@streamunlimited.com>
References: <20261124144642.298366-1-simon.mikuda@streamunlimited.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When GATT discovery over BR/EDR completes, gatt_client_ready_cb() calls
device_svc_resolved() for device->bdaddr_type. For a BR/EDR device this
marks the bearer resolved and runs the device_wait_for_svc_complete()
callbacks while SDP may still be running, so they find none of the
device's profiles. For a device with an LE address type it resolves the
LE bearer instead. iOS opens ATT over BR/EDR right after pairing.

Over BR/EDR, leave resolving the services to SDP.

Fixes: 4b5bb941c380 ("core/device: Use shared/gatt-client for GATT")
Assisted-by: Claude:claude-opus-5-5
---
 src/device.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index be3267368..7a85403f0 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6423,12 +6423,15 @@ static void gatt_client_ready_cb(bool success, uint8_t att_ecode,
 								void *user_data)
 {
 	struct btd_device *device = user_data;
+	bool bredr = bt_att_get_link_type(device->att) == BT_ATT_BREDR;
 
 	DBG("status: %s, error: %u", success ? "success" : "failed", att_ecode);
 
+	/* Over BR/EDR, SDP resolves the services of the bearer */
 	if (!success) {
-		device_svc_resolved(device, BROWSE_GATT, device->bdaddr_type,
-									-EIO);
+		if (!bredr)
+			device_svc_resolved(device, BROWSE_GATT,
+						device->bdaddr_type, -EIO);
 		return;
 	}
 
@@ -6436,7 +6439,9 @@ static void gatt_client_ready_cb(bool success, uint8_t att_ecode,
 
 	btd_gatt_client_ready(device->client_dbus);
 
-	device_svc_resolved(device, BROWSE_GATT, device->bdaddr_type, 0);
+	if (!bredr)
+		device_svc_resolved(device, BROWSE_GATT, device->bdaddr_type,
+									0);
 
 	store_gatt_db(device);
 }
-- 
2.43.0

