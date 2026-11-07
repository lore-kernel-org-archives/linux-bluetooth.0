Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794016615;
	b=mswace6jNVbv2pSHbzSeVhDZWPNBjh+Eu7bv26gFoESICig/SeTILEWWmMZDgG6PDUDG
	 6AjgsFK/HHfiN5HvVClfcne6IuFdYfT0JD6LCkixRBSLlU9f6WAhjYbUr47gaywczeiz6
	 NKLwyA0EYOeZR4o9APvsnIFnaUnZzCZOj90q9BOOmy2pYoIlhqFRMmrpXm1qA+gCuezhi
	 gIJo07GnAOYSNkWQsRRhYCg/MzqVPlg7+SZb5+N5M11kYBS0xwNP3EHI3+2nSwIqjAN7o
	 rvrh5shjtFDK7YMyTWYV2kG3VP4EY5C/m54cb7dAmXyIbl4KwN36sN84FJWfEncsm4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794016615;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yGNrjx+BIcgORwQSfngbNTxuTNAY0UWGRdzjOCqqugc=;
	b=yPURNNbyYJ0GjChOSAzB+UoDGlGPQuYPYOMJi9Xh6Yin9pvAe//Q1C7peJX4EybU6b4H
	 UIaNtS8z3da70L1DV4MXzhrg5QI5xSb/CFFzHB57xAwjQYCBZXjhyzsR4fmHYfHCRRY1n
	 DqyXGorFHBlTiSoklC9bghuL65mgmzfQl5gmoy6fb0tMh2GEDfoiaVd1E53R3sB0dV0fM
	 Uf9Hq5jO/ISlKnQfJNDlVzN/fVdYWz8wtU/KVaL7qWvLMHWHJ9wQhz94u7/kRM3N+VWkx
	 YXji6hik8XJyCo8ripjHplZSZ32GAjR3zY4AUvtTqwb2gXCa1ir9d9ASiTKsejFlvmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=cwIx9w6B;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAC2606A32F
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Nov 2026 01:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBAC2606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=cwIx9w6B
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so1927137eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 17:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794016614; x=1794621414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yGNrjx+BIcgORwQSfngbNTxuTNAY0UWGRdzjOCqqugc=;
        b=cwIx9w6ByAuj8AM0h/ehCLftF0yuv05ax4XlJJPQBT8bTDz4Q0VkVk/T7+KCDEafXh
         GRl67BeKJdEsrcbMMlVuX827aP/GXTU+SvV1KTjjRm7ZXKVrLVHA7pNh80u9i4n3+JqK
         f+jdmwP182G4gEu3IjBPndhxWvzdXPHo07vtEB2OW2TY3z7NhwX79R9UNzC10GGvNsDD
         nXc0iSEeSKuK21n6aA/IWrZZy/vmWqmilb2IVxvng62mGj208qKO9cIdFmwPOeuiz4aR
         0rdKjHhfCVgOpRhm8OZaInHv7mFv8t4ngduVU22o7ICERi3i0gtieohq6vUtqh2FXIEi
         LVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794016614; x=1794621414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yGNrjx+BIcgORwQSfngbNTxuTNAY0UWGRdzjOCqqugc=;
        b=U7bqM/4EdYRO+QcaxW74qlupteZwXcDbudd2tCjwbhUMmN/zmz2BxHyivUMX7NGri/
         MH3WaCgiVdmnaNeZoFuHzHJosAQzR0vOvnqC19QQKAOpRshzPHHpCyc/aP2KYbkiSSpy
         gjnOujQaiK4p6bH5aSZjWf74FzFQP/GF2K281Lxmlb8sEvNwyVafBde6s62IGx9UWGCF
         1wTQDErGoLiJAqf8seJwaXW84kxJEBhpc1/GOzhTvB0W4DasRXircYetsD/mYRJ9yJlt
         TwRL5swsiRn3+fDlZuNlVr7Iml3Uwp9aebqMqQ6A4A8YqSsIHwEwTELaVX3oazxlKMBf
         JAiQ==
X-Gm-Message-State: APuU4Z81YQj81J8dIqXAMecaKUBfgd+pDoX85bs+NOaA48T8QYtlXP7V
	EUW9S7LLxQrhvhOczpQIGa89tbYqEf7/R+cZ9ZUUj5rZfJzY/BM39Zm81XRhOduHGmpG3FuCKwz
	6hGBs5cM=
X-Gm-Gg: AYBFou1xg3DPlx/T3e1YYX9v355ViqjN6oovXskhECpI185DQzrjzk5VakEqr5Cm0ED
	EG6GgiEfP1YYN6xTIalYNb+mgL7FLlVd54OeVYq1diqCs/GRF0m9g6Ik3rIFk9YDnTY9t54DQFn
	OpLfeoYgjLZmxyvopFpJohDErPm5hWq3QkAZFrxHtpRk4w+wlpOcHZE1l2V7P7LMgzUm1StGPTa
	cvAXU6pHDA7OFCs2LnbWNss148fI5mGoac6NeYrFHekgk5WGunUPmgAiLyzRg/wmhomtOdchP7y
	RCR1YKfPyl+QNTllYoQMMK/QRsKH1369m2Y7QRnKl+SdIgqTuPSi6MQJIA6k7fbAeei5ZMyHpQo
	tXs5ZJ9sR+6bdDXGaNPHGpCVQtRXReD1cBMWZaTxUhHak01HHQzjFrHvm4DAxwEs2ADinY6me8F
	jCL/+xqzrw69k1agghBhdftwxZIHUUNl4JDR44eQZM6a6GifsDPrlBCkyKww7BouBtYqHs5cna7
	3vLNpEbc3OfLReJZA7kewBLW89GIEvIQAtBy7ZRCuXEMpwwSqETj10Xvc1z09hjW9dzMTjGgEdb
	Nj87tH3gIBna1CyKGI5XThv7GSwT3rO4ym0oVbfczQrwkVq1VckZ7Zb1cfHaAS9m2omA69Xl697
	Mnq5nItdVfaPnhvqkGbjtrmpjoeR4g/TE5RiG7Kotc2qy+4d2VDg1IZuArmFTxxvSgecwYXo=
X-Received: by 2002:a05:693c:69c8:b0:369:d6ed:f2b5 with SMTP id 5a478bee46e88-36f77beb91emr5129102eec.39.1794016613559;
        Fri, 06 Nov 2026 17:56:53 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa651e6b1sm22977994eec.3.2026.11.06.17.56.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 17:56:53 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ 1/2] device: Add functions to pause and resume auto-connect
Date: Fri,  6 Nov 2026 17:56:48 -0800
Message-ID: <20261107015649.84892-2-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261107015649.84892-1-kevin@simpleble.org>
References: <20261107015649.84892-1-kevin@simpleble.org>
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

Device1.Disconnect takes a device that is not trusted out of the
auto-connect list, and Device1.Connect and Device1.Pair put it back.
This moves both into functions, so that the LE bearer can do the same.

Assisted-by: Claude:claude-opus-5.5
---
 src/device.c | 42 +++++++++++++++++++++++++-----------------
 src/device.h |  2 ++
 2 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/src/device.c b/src/device.c
index 6d1e78b0e..36a980d1e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2369,19 +2369,34 @@ static void device_set_auto_connect(struct btd_device *device, gboolean enable)
 	adapter_connect_list_add(device->adapter, device);
 }
 
+/*
+ * If device is not trusted disable connections through passive scanning
+ * until Connect is called
+ */
+void device_pause_auto_connect(struct btd_device *device)
+{
+	if (!device->auto_connect || device->trusted)
+		return;
+
+	device->disable_auto_connect = TRUE;
+	device_set_auto_connect(device, FALSE);
+}
+
+void device_resume_auto_connect(struct btd_device *device)
+{
+	if (!device->disable_auto_connect)
+		return;
+
+	device->disable_auto_connect = FALSE;
+	device_set_auto_connect(device, TRUE);
+}
+
 static DBusMessage *dev_disconnect(DBusConnection *conn, DBusMessage *msg,
 							void *user_data)
 {
 	struct btd_device *device = user_data;
 
-	/*
-	 * If device is not trusted disable connections through passive
-	 * scanning until Device1.Connect is called
-	 */
-	if (device->auto_connect && !device->trusted) {
-		device->disable_auto_connect = TRUE;
-		device_set_auto_connect(device, FALSE);
-	}
+	device_pause_auto_connect(device);
 
 	device_request_disconnect(device, msg);
 
@@ -2926,11 +2941,7 @@ static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
 			return dbus_message_new_method_return(msg);
 
 		btd_device_set_temporary(dev, false);
-
-		if (dev->disable_auto_connect) {
-			dev->disable_auto_connect = FALSE;
-			device_set_auto_connect(dev, TRUE);
-		}
+		device_resume_auto_connect(dev);
 
 		err = device_connect_le(dev);
 		if (err < 0)
@@ -3480,10 +3491,7 @@ static DBusMessage *pair_device(DBusConnection *conn, DBusMessage *msg,
 	 * this in the ATT connect callback)
 	 */
 	if (bdaddr_type != BDADDR_BREDR) {
-		if (device->disable_auto_connect) {
-			device->disable_auto_connect = FALSE;
-			device_set_auto_connect(device, TRUE);
-		}
+		device_resume_auto_connect(device);
 
 		if (!state->connected && btd_le_connect_before_pairing())
 			err = device_connect_le(device);
diff --git a/src/device.h b/src/device.h
index 6756cb3ab..047a894c3 100644
--- a/src/device.h
+++ b/src/device.h
@@ -206,6 +206,8 @@ void btd_device_set_pnpid(struct btd_device *device, uint16_t source,
 			uint16_t vendor, uint16_t product, uint16_t version);
 
 int device_connect_le(struct btd_device *dev);
+void device_pause_auto_connect(struct btd_device *device);
+void device_resume_auto_connect(struct btd_device *device);
 
 DBusMessage *device_connect_profiles(struct btd_device *dev,
 		uint8_t bdaddr_type, DBusMessage *msg, const char *uuid);
-- 
2.54.0 (Apple Git-157)

