Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CAF1F75AF
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Dec 2024 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459224; cv=none; b=Br+KWDeFnPwjTQnt6Ge8Wq6gYsIBRn6PurwLmJn37XybPFAhpBaDAIMZTWAvaHKDFD1QjnMEZY8zvBJOsbmeVM68OyOQIivm6xiMyUQQo/MC7UUeSJIqYnzGmwjdFYuNi915+KIJobi8nt88DxLfdI8X52KOnkjHOqZ3gXukooE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459224; c=relaxed/simple;
	bh=QkmAVq6lb9WVzm/qCney9L03JynJ0PPTFp+Naz69pyo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDGXBt2MXAlHXOb48rt4ROhLRqSS2q529BBYorXcrHQJ6gYGFH1DFV6PTZdFSVUJC+Mkk3cajqrL2BJzOtfR5pdjIF500SajeSXlgiBtDZU5ps3KAMAaZFlbFjw+q+DaNAy2A6Xk1hu4qv7TCPFPor/2/3CvlTSVvYQn+iiSRnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXocylLZ; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXocylLZ"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4b10dd44c8bso1180631137.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Dec 2024 10:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734459220; x=1735064020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OcqjYN9dtItZka6MagbbfSI5Ja6c0sqMDS2z1F896Fk=;
        b=MXocylLZwG/zX81xTbRI8R4vdS67krIAIxwSbG/tiwy9DmKqAnjXBT9AnoBwiGWm3Q
         u+34z1tP37iLkj7Bkzd4rG3Ev8lFU5zre1jK6LLPp/rhdR/CYLPp1g/+FiVAutvYwK3S
         llU+Eu0Y6fcrXWVQ2SrZ+BCwAgQWyz1QCZyKol8r/jI3MojwNexiHgbUmLiXRGRaUvKQ
         H1dM0k2z99b3ojHTmSK35oVRAOgnWLeVzcCyvdMh7meQ3Buwk7Lcoce29HbL9C7XkInu
         TvZ24C0TZtSO44CKXGeC4kstxdcvyi+C4AN+3coETjvYKItSTl72yrtKkaGvfX52Smx3
         0yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734459220; x=1735064020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcqjYN9dtItZka6MagbbfSI5Ja6c0sqMDS2z1F896Fk=;
        b=d3MkVKs2Dms1v4+9bkmT2yW2JXecoGRAHHckrb5eqgv7appDeLbbqjNB9u0uheu2bg
         irWX1oOXj4cCY1rSwKswvJ3iQQ2F5AYcX/qL76D0VmwcnfGC+VOjGRdx49zwV5n8lVzj
         nThWeNudvQC2TqdCuP4Nqdypg3AUc2wINbFe5qVlY++QF1P83Rs4M3rU+26888QisGRl
         vfTAIhGffAp24LM7m2//OsN2QNUDqKq5BLT+wRHNngsMtU16dBfXoCb6BQ2P77wMmJ5t
         VjI/J2cL+Ju6rt1CQ4iFfymqlY4bCp5N4LV3j0Cpj9GGsfdDyNJaybrTxG4N1Yyfu2ig
         6Z7w==
X-Gm-Message-State: AOJu0Yzv0A1v8ae5LlA0j3SjU6LLYHpYp4NAGWp3m+gErKYeOk2HBbDC
	OxuUygSFzlnYeppqgXsnEcwUNGIVgMmaeJ8GDJQcwmzazQMkYBsGWECVgA==
X-Gm-Gg: ASbGnctwS1oPLzAd60cW5VJ8DtTBBCM+30MxrLNvRQP2lR3w5w8kJ9mjQMox8f9EUbh
	oYUMOzrASUu+KpDmFsOamPX8U3+I0iqT5OjNB7XegBPrtwTQN8JUd1/MaQD94XPsZVcnB4etzJG
	PuK7Djxn5ivCBgyOE+CRqWppthPMlo91fIM5ds1DM1noO7sNt4MGCVysvSlyk9hpq0Ogal/usyl
	KzM+8xIdefXRlN0fALucUSmHD25Zph5lwiLH+SqEtgpcN5P8n/7iQSsIXfeYc039zkk4Hnr4VuA
	92QswLNWQ6wU/PGQFcqfK16mb8mu
X-Google-Smtp-Source: AGHT+IEmI/IkauPGyWOHUKsq+uNwEztq6i0bqBdWGdt4lIToitYzT+ps+Gtq66GqzxozgSHAualtSA==
X-Received: by 2002:a05:6102:4b04:b0:4b1:1def:3d10 with SMTP id ada2fe7eead31-4b25ddb2c56mr18346201137.19.1734459219082;
        Tue, 17 Dec 2024 10:13:39 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b270238f25sm1214721137.12.2024.12.17.10.13.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 10:13:37 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] device: Fix not being able to set WakeAllowed
Date: Tue, 17 Dec 2024 13:13:34 -0500
Message-ID: <20241217181334.3243011-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217181334.3243011-1-luiz.dentz@gmail.com>
References: <20241217181334.3243011-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Setting WakeAllowed was not working as intended since
device_set_wake_override was changing the current_flags which
btd_device_flags_changed checks to determine if flags has been changed
to only then call device_set_wake_allowed_complete.

Fixes: https://github.com/bluez/bluez/issues/1045
---
 src/device.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/src/device.c b/src/device.c
index 2d3ac71f6878..24ef3d77948f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1515,13 +1515,21 @@ void device_set_wake_support(struct btd_device *device, bool wake_support)
 
 	device->wake_support = wake_support;
 
-	/* If wake configuration has not been made yet, set the initial
-	 * configuration.
+	if (device->wake_support)
+		device->supported_flags |= DEVICE_FLAG_REMOTE_WAKEUP;
+	else
+		device->supported_flags &= ~DEVICE_FLAG_REMOTE_WAKEUP;
+
+	/* If there is not override set, set the default the same as
+	 * support value.
 	 */
-	if (device->wake_override == WAKE_FLAG_DEFAULT) {
+	if (device->wake_override == WAKE_FLAG_DEFAULT)
 		device_set_wake_override(device, wake_support);
-		device_set_wake_allowed(device, wake_support, -1U);
-	}
+
+	/* Set wake_allowed according to the override value. */
+	device_set_wake_allowed(device,
+				device->wake_override == WAKE_FLAG_ENABLED,
+				-1U);
 }
 
 static bool device_get_wake_allowed(struct btd_device *device)
@@ -1531,13 +1539,10 @@ static bool device_get_wake_allowed(struct btd_device *device)
 
 void device_set_wake_override(struct btd_device *device, bool wake_override)
 {
-	if (wake_override) {
+	if (wake_override)
 		device->wake_override = WAKE_FLAG_ENABLED;
-		device->current_flags |= DEVICE_FLAG_REMOTE_WAKEUP;
-	} else {
+	else
 		device->wake_override = WAKE_FLAG_DISABLED;
-		device->current_flags &= ~DEVICE_FLAG_REMOTE_WAKEUP;
-	}
 }
 
 static void device_set_wake_allowed_complete(struct btd_device *device)
@@ -1563,6 +1568,12 @@ static void set_wake_allowed_complete(uint8_t status, uint16_t length,
 	if (status != MGMT_STATUS_SUCCESS) {
 		error("Set device flags return status: %s",
 					mgmt_errstr(status));
+		if (dev->wake_id != -1U) {
+			g_dbus_pending_property_error(dev->wake_id,
+						      ERROR_INTERFACE ".Failed",
+						      mgmt_errstr(status));
+			dev->wake_id = -1U;
+		}
 		return;
 	}
 
@@ -1583,8 +1594,11 @@ void device_set_wake_allowed(struct btd_device *device, bool wake_allowed,
 	 * progress. Only update wake allowed if pending value doesn't match the
 	 * new value.
 	 */
-	if (wake_allowed == device->pending_wake_allowed)
+	if (device->wake_id != -1U && id != -1U) {
+		g_dbus_pending_property_error(id, ERROR_INTERFACE ".Busy",
+						"Property change in progress");
 		return;
+	}
 
 	device->wake_id = id;
 	device->pending_wake_allowed = wake_allowed;
@@ -4358,6 +4372,7 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
 
 	device->tx_power = 127;
 	device->volume = -1;
+	device->wake_id = -1U;
 
 	device->db = gatt_db_new();
 	if (!device->db) {
-- 
2.47.1

