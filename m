Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70CA12C461
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 15:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715353788; cv=none; b=JbcMWP7J6imV5Rm+alOnLNfMsqJV1mz9Z8M/RKIL+kjuZsTEeS9mqH+JHEnvpSClWUufZeUrWiDB+1sPZVgMepApUHzw0EazZ3F99BZ7hHizpKapwFJ8zPJqo3BQFxnpMW/nOzxbb4BvNxL5GqeOZCKonGScCtcb/Pzp0TGhz3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715353788; c=relaxed/simple;
	bh=r1e3m+SC67CxdbKKtB6zGOqy77llkSSYc1HvO0DmPto=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VL6dhFVXfZadVCRzS0M0gK1We1qYBEHDtLG8dYqIUbBV9/L261Pyb0NqJWNgFWTwouB37d9jiEbcsjB5S1HbiJiOCPfd+smCWXNOWVv7BYjMOaAq7n3/brGjWmZDTeOyYiDvlf9vzN8JKjW9RnaBrhtGVuwanymY2S6LS0k8mLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgV6mV7k; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgV6mV7k"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-47ef8c9991dso693185137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 08:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715353785; x=1715958585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cxLUKbT3DbD9tsa3QsZdPm56fC8E9csEVljefspOnh4=;
        b=NgV6mV7kbVa1F+YqpgA5ygikH+Dpy+thllgLFLgrQDUjKmV+HXvX+zDNcns8syjcYq
         PCbKXe9bxqPsEvjaFm3gdPkmLUTBEChi+eaPd7kFS1C0V510jfycyapTSJHXSCaDQrYy
         V1jbWNvHsVXPddCG7ojad2OJZua/8xqHxuq+W5w30deGvA85WKK4u8R2ib0zUCw3XSl9
         uNSbJwbc7Nm6SxJLKKrZjqYGQxmq+i07Tb0JMj3t2fvDX1m7nd4K7fMlaCDRLsLzJPCt
         xjBdLHQcYfQdSO2EpP8jC6TnsiXgL4nM1j61du+QwfDLpYmFxuEVzSz7tsXQW/n+OgfQ
         Ptdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715353785; x=1715958585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxLUKbT3DbD9tsa3QsZdPm56fC8E9csEVljefspOnh4=;
        b=BRXBYNgMibywxopKGSCPPkaw7ZzNd2BXIH49RbwtPzGUc3QbMbWaqIpdoZKW18tzcO
         fQKzRCcTQbDihgPR1I3e8zEJ4DeYqEYXtq7WtOZNIIOiCMVoYXguiyRGqzv0bf8qbs2M
         rbKJfiwjgjMxS/xVxmKwYOGFLziHN5iaOEk4WAbnDJoVyH7vgv5s3vWB6MkxvoQcWYS6
         FPG+7/nQIACPEJTDbvH0O6ZKqv8aX4igbTOdPUIKA7Q6UK5IUe+21fuj52YDd1sXyvsv
         wgrVEvlkMsj8k7cPaZTJbe/Jx/q8KtcJZ1HzJvZvP+KlhOelToJVsqFKXIpAR2ITbvBS
         Thtg==
X-Gm-Message-State: AOJu0YxDX5DJUGBv9gAHBBwU/kn5TS0M6YG4ald1DJhcdsKPTvSaKNp6
	FzYIPa00x4r87gxc3+kKCTGQbAyqa1SGzBdfDkNs9l0kdgSthbDoFS+kpg==
X-Google-Smtp-Source: AGHT+IFAGh3XqAAitM8u4Be9+vccYVwww+04UhHx5mf+HSAdc7TsRELGsTu32RM+DbnlpY/CCAFwsA==
X-Received: by 2002:a05:6102:1628:b0:47f:251c:61df with SMTP id ada2fe7eead31-48077e5d7abmr3496928137.27.1715353783736;
        Fri, 10 May 2024 08:09:43 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4806cb008d2sm510050137.2.2024.05.10.08.09.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 08:09:42 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/4] src/device: Added function to set connection parameters
Date: Fri, 10 May 2024 11:09:37 -0400
Message-ID: <20240510150938.1492169-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510150938.1492169-1-luiz.dentz@gmail.com>
References: <20240510150938.1492169-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Felipe F. Tonello" <eu@felipetonello.com>

This function allows plugins to set the connection parameters of the
respective btd_device object.

It is useful for GAP Peripheral Preferred Connection Parameters
characteristic for example.
---
 src/device.c | 14 ++++++++++++++
 src/device.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/src/device.c b/src/device.c
index 1d4b8ab36720..79d8bb7ebc9b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -7322,3 +7322,17 @@ void btd_device_foreach_ad(struct btd_device *dev, bt_ad_func_t func,
 {
 	bt_ad_foreach_data(dev->ad, func, data);
 }
+
+void btd_device_set_conn_param(struct btd_device *device, uint16_t min_interval,
+					uint16_t max_interval, uint16_t latency,
+					uint16_t timeout)
+{
+	btd_adapter_store_conn_param(device->adapter, &device->bdaddr,
+					device->bdaddr_type, min_interval,
+					max_interval, latency,
+					timeout);
+	btd_adapter_load_conn_param(device->adapter, &device->bdaddr,
+					device->bdaddr_type, min_interval,
+					max_interval, latency,
+					timeout);
+}
diff --git a/src/device.h b/src/device.h
index 5722ca9cafe0..1a9f7e72a00f 100644
--- a/src/device.h
+++ b/src/device.h
@@ -204,3 +204,6 @@ typedef void (*bt_device_ad_func_t)(void *data, void *user_data);
 
 void btd_device_foreach_ad(struct btd_device *dev, bt_device_ad_func_t func,
 							void *data);
+void btd_device_set_conn_param(struct btd_device *device, uint16_t min_interval,
+					uint16_t max_interval, uint16_t latency,
+					uint16_t timeout);
-- 
2.44.0

