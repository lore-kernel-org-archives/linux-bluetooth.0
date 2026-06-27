Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEA42F99B8
	for <linux-bluetooth@vger.kernel.org>; Sat, 27 Jun 2026 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782574553; cv=none; b=s55yyMFeYQaN8VI60acy5qXE50Sr36VxeiS4PDbSlNSUsymhLaqKGtT8lznhMEh9rTJ47As0MzucRRch3f727b6eYnkPFSyU4YAUVM5hHyGVAEfOr8og9go5G6BzNEVYSQ4sits5UvELhL5suXMHzvJlJWp/QRHyvK/O9NbQMUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782574553; c=relaxed/simple;
	bh=OMfHcOBxtpB0j9NTcAJ2DVfk+zscKvIV9aTQqt0BfCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WMk8RL0Kzkw37m5AwPQb6/MkvfOkp8WjrGtGqKHcfgXcY0956rtJg1gTAeg8Z+YvnV2AzpM0C67h62mAwVFK+8bIFwDpExOIzAo6EnYyXjZe5ZBpfFNMVfkIf70WTlvhplN1juQ0fqMzAML3zh4v5ogHnUIdpVdb8sMwj3bCNKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNiRGn30; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNiRGn30"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4629051c9d1so1013255f8f.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 27 Jun 2026 08:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782574550; x=1783179350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e+kkJ09VUw+7SzKi5twgS6gbZyQ8SvfRATjQ8fCfUko=;
        b=lNiRGn30c7IQHm/e9j1d9xBYIvDWBzrJv7e9n/IVow4DymOxG3uUPvAmZRj0f1Nghe
         uMww/vSen6jPfZ8ykfnq3v9UfoA2ENlvLmSDwn8hxW9eLR7CLj5A+/Yn8Z1W256dS0DW
         2W2a++9NGtIXIEkqyssdYFpw5FKLnA6oBiKZBVIzgAtQbhrnIuZIj/vKEohNwmVClKyD
         DVPOv0bnMAAXRdAFNbqZtgSDsvqcnmyDSY5+67v5io2HOJNhDWRgMQJVitA0X6q/d6YY
         rcfdmx3W7qt/AknWNGBVRLDxg5ityb8thuSNDY0NZPiv2IpEC5QZlnSrKa1ahk6L13xN
         phew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782574550; x=1783179350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+kkJ09VUw+7SzKi5twgS6gbZyQ8SvfRATjQ8fCfUko=;
        b=QWIwIV6Ur39QnvpL57iUpedmKtZ+4N1RouAWl6xDbIrzp26FW3HWpLThHz6RSrG0cA
         OoeXbwjt69FptjJ5IqJkcpUv2/0zM9EMkNczTNWUpRFHnCYDrt8uf8vvmlNO4hNmQqgV
         6OGwi0ZLJ0BmgR3X8c/777+O/HC7AQzalYJnjQObP8d+2hz3EQDmZV97dTaNXIAWKCXH
         6e3pndZbTBerzvskpi2Auaxxh5hdEV7vq3gcdWl6OuXPZSGpE3LTikAQlMndLlh+Wvc3
         dKuF+AM8SJ8vAHfjxtTh75YODmyHumNFSThpqhWR26xr8YWgZddvzmU5kqiGBKAxkRBH
         0alQ==
X-Gm-Message-State: AOJu0YwuuKcsD8xnyB4gjx92pnUg9b790LtfHDOJGD4cOBLlVLej4yBx
	6AOy6jfUcxz3Am+E9P5LgihqVcoA7ljFocG1fU98noYsAoBbxwn77v1m
X-Gm-Gg: AfdE7cn1NVfNSXfj48tf9a74yLggf9wl4dUjbaj8et9TJx5qEddGnuGNu4jAmAW6J8P
	Dx5VIWB1ETaVBSuXubQeeSAbvJQ/iJZ5WXvJd5ZgpXKRWzTXtCGSG1+ynU2GzCIIgJh7/b+S9uc
	L29+c8Psa7791y2lv+BqwyYrWXe4dFcLOzl4/K1NI+8TpLhdsAzxk9mEbUynxOfc+Zp9LNpaARN
	LzYlY24nvb+beTkQxvnfoMKf+SZCERrOfmcdLGi5ceq8ricd/jcJM5uvEIpiDZKnaP2wGTh/uhi
	HOtWgNBBAb9qg2PjicZzG86wVM2a+w87ZMNog0WdIeuxViTzANPD4Hk4D8PlESV2fYaU1KXHy9E
	bRyn8v4Z2FUWWn1B67X11hSUxrsz8ohg4Kjgz1EKVp02uDFi0PhNhlyjq9QPX4AklV18QJmaM9m
	hWGrvyu2o7KuLC
X-Received: by 2002:a05:600c:5297:b0:493:85ae:2575 with SMTP id 5b1f17b1804b1-49385ae2619mr28301695e9.27.1782574549790;
        Sat, 27 Jun 2026 08:35:49 -0700 (PDT)
Received: from tibor-herobox0 ([150.251.225.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268ffe204sm172595745e9.7.2026.06.27.08.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 08:35:49 -0700 (PDT)
From: Tibor Harcsa <silurust@gmail.com>
To: luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tibor Harcsa <silurust@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Add IMC Networks QCA9377 to quirks table
Date: Sat, 27 Jun 2026 17:35:05 +0200
Message-ID: <20260627153505.20173-1-silurust@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the USB ID (13d3:3503) for the IMC Networks Qualcomm Atheros
QCA9377 Bluetooth controller to the btusb quirks table. This
device requires Qualcomm Rome firmware and wideband speech support
to function properly; otherwise, BLE scanning fails with HCI
unexpected event opcode 0x2005 errors.

Signed-off-by: Tibor Harcsa <silurust@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 08c0a99a6..7963fd48a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -297,6 +297,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3501), .driver_info = BTUSB_QCA_ROME |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3503), .driver_info = BTUSB_QCA_ROME |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* QCA WCN6855 chipset */
 	{ USB_DEVICE(0x0489, 0xe0c7), .driver_info = BTUSB_QCA_WCN6855 |
-- 
2.54.0

