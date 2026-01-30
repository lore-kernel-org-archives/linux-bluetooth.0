Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0FB3033C3
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801996; cv=none; b=ENLRG7VMAXJhX28IJhCyOA4O7RboCSQyU8ia/k8m2NOjCxr7KzSx6jPx/3fRS/R4RAlz1C8KVRnDMtrhutajzxHMfv6Im1hwzMa17kkrJYFxvXcG8uHzi3w/3rLezGSgSXXUIgohyVFHnp+6g7/KdSLUv2kv+QGZ4M4MTcXOGvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801996; c=relaxed/simple;
	bh=jhxsrwRob42HSM6zCAoB1Ikw/SAsN+ap75yQhqZJSiU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slJagpuiWPI1z7Qq5S1eoGtpI45HFm8L6BcM+9RwCaEG+1eZIDz9is6xr9X95Cq2G0FmA5x6QEGtDHbZZk3a2vKTPyOYWa6ANNgsTzGan3omhoBkmiIuu0vVnn1Y/jRJTak8gwtj0Ka6d7hj0zPduI5kjHIcp3fm6xnwE1x5Tpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaoQNJx3; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaoQNJx3"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56641b5a471so2098264e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769801994; x=1770406794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xkyJxM+EW3lFEa6Dp0iQPYaEUgeNkdv57uwdA3HEk48=;
        b=DaoQNJx3oRv4+DyCNSqhDXJ+DwOWuiEIGWVheZLx0iozRmEpj120Oc1Uc9FQCePmrB
         d7CjEgl4pRZTRyl/ozma/QpAHrLE2/lfeAh/rr47+D75Kza5GRApRXDLUqI24X6tRsr2
         ZIaKYG/dA4kDlC0+Oi4FJJoYWw+HE4+DGx0FCn9zLBEo/3GksBhc6+i9ZIM21J2BRFyN
         AzUfW9U68ZF8Yc/h5dzWhYrRrW0FznnYIyo0yLY/3OtFcRsDiG7R0KDG5wK2Cv77sFH4
         yLQ+4rWo/1vdYEQfJVuwNHw4zg+aT6IT7B7UGWjMNb8CJ7aYr5RREa8CbOVhtTifwxij
         V4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769801994; x=1770406794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xkyJxM+EW3lFEa6Dp0iQPYaEUgeNkdv57uwdA3HEk48=;
        b=LK7o7FFwbPQTGSdrt9PamAdVUFTjEjPbDi6SptYFhdpjUJELlVwGEj/rgYx58HM2xb
         bV0YmjTxdKViUtv9MKVqxxJTQnLy8GX2lUgTsU1E+gCC4zLPxlxeoMMcUT68cxDQJBve
         J8M878rdURQvMD8Gpjd+DirG2JKaXBieSHQsNFbXPQXcVTaDPy69mP7POwKnxNwG5Gwa
         lvN1NymvhJreWybvECV1qPtjJ7uVRMcezmbVM0vdwmFMaiXMcBiRSiZDis87v1JziZnO
         xRTCv+NG0Q8IHmYindkBluJgBpwz6a/+9Oo3veOHAaEDuwZBJ3psPAkGEPII2W1f1ToW
         B1Qw==
X-Gm-Message-State: AOJu0YwW8SqmM3vo09lTRje9BftkfhcLZWs7GWEdGj4sNWho4ShzTofb
	ofCCK/23+pD8ltDMeltIzzHczgsrZhm/UEccSReH8tAJ1nVKZtokTRc410PJzA==
X-Gm-Gg: AZuq6aKGReXccQas8y2mpT49tGMpBtyGAv1zMZJMl+ebrgEQZHMsYJ6gdT3Oa7fEsQT
	glI9Q1KPOxjQNppvCMWGg7l01iPLYLuquuyGXxuM3SPhjJ52jxYNE58nmAP5HMoFfyPDbTjfHQd
	IbgTNCxIYyvN6LQkaPo3aLlkvVaouYuDA/PEUEuk50qohvKhysJpY4qL+4fCXmE8O0cW8rfg5C0
	21+46DgZ9PxyJ6wmtFRsieRkYHyU3kPIULL6MCqPTcl+0pruh74zCwxLjF+Kt5dy6i1OCP5Kgwr
	2pGw1IWahbmQ2Oz9gnKG+F+jQVQcxWnprYC32knbwV+SWSuQApGO2PtE9jaBcC1HAIfy3HUQ5qA
	J6JaHlePm7H1BdlGIwB5LUnOVcEqQ6jjj+WE9yPI42NCmkPyY68u5Pm/svisJFs7rYRiadPic5w
	312HS/CUAD93ySITrPmCqxP1/QYAeyhomM7CafoY3v7zTEnGbjpAMnCkPYMSL0KM797Kc6AMNgT
	j7eUg==
X-Received: by 2002:a05:6122:3281:b0:566:226b:e30 with SMTP id 71dfb90a1353d-566a001356emr1492463e0c.7.1769801993803;
        Fri, 30 Jan 2026 11:39:53 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.39.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:39:53 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 24/35] doc/org.bluez.GattCharacteristic: Add Used by reference and Examples
Date: Fri, 30 Jan 2026 14:39:06 -0500
Message-ID: <20260130193921.1273263-25-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130193921.1273263-1-luiz.dentz@gmail.com>
References: <20260130193921.1273263-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add :Used by: field linking to bluetoothctl-gatt and Examples sections
showing corresponding bluetoothctl commands for GATT operations.
---
 doc/org.bluez.GattCharacteristic.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/doc/org.bluez.GattCharacteristic.rst b/doc/org.bluez.GattCharacteristic.rst
index 3cbf361cc904..805f39593903 100644
--- a/doc/org.bluez.GattCharacteristic.rst
+++ b/doc/org.bluez.GattCharacteristic.rst
@@ -31,6 +31,7 @@ Client
 :Service:	org.bluez
 :Interface:	org.bluez.GattCharacteristic1
 :Object path:	[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}/service#/char#
+:Used by:	**bluetoothctl-gatt(1)**
 
 Server
 ------
@@ -83,6 +84,10 @@ Possible Errors:
 :org.bluez.Error.InvalidOffset:
 :org.bluez.Error.NotSupported:
 
+Examples:
+
+:bluetoothctl: > gatt.read [offset]
+
 void WriteValue(array{byte} value, dict options)
 ````````````````````````````````````````````````
 
@@ -144,6 +149,10 @@ Possible Errors:
 :org.bluez.Error.NotSupported:
 :org.bluez.Error.ImproperlyConfigured:
 
+Examples:
+
+:bluetoothctl: > gatt.write <data=xx xx ...> [offset] [type]
+
 fd, uint16 AcquireWrite(dict options) [optional]
 ````````````````````````````````````````````````
 
@@ -187,6 +196,10 @@ Possible Errors:
 :org.bluez.Error.Failed:
 :org.bluez.Error.NotSupported:
 
+Examples:
+
+:bluetoothctl: > gatt.acquire-write
+
 fd, uint16 AcquireNotify(dict options) [optional]
 `````````````````````````````````````````````````
 
@@ -243,6 +256,10 @@ Possible Errors:
 :org.bluez.Error.NotSupported:
 :org.bluez.Error.NotPermitted:
 
+Examples:
+
+:bluetoothctl: > gatt.acquire-notify
+
 void StartNotify()
 ``````````````````
 
@@ -257,6 +274,10 @@ Possible Errors:
 :org.bluez.Error.NotConnected:
 :org.bluez.Error.NotSupported:
 
+Examples:
+
+:bluetoothctl: > gatt.notify <on/off>
+
 void StopNotify()
 `````````````````
 
-- 
2.52.0

