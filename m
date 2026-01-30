Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377BF2FB093
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810592; cv=none; b=YbjhUOZvmo0zPgqU+2TCAlXgALezGqkrkMUWAlIS3h7iByUO+yZ4dYf3/8/oMx6962+I9/WxtgITVTCcYsQdj0F2iFCuRef8Xf8Ot7t+GfrL5HJSLv3wshsuoQOzeplPvkV8KMaGRLqUm0j2s/ve9idzhejQH2fwhwgvFA8+z7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810592; c=relaxed/simple;
	bh=jhxsrwRob42HSM6zCAoB1Ikw/SAsN+ap75yQhqZJSiU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOsQW9D1anQMMPKpa8X3ev+Inf36q6OpS7SSe8pFbQHIhYsincl5x3ltmr02Fvw9EYV4VfsoDMWpRglVTXxEj2W1Dna8SzFp7c7VQXb09odGpnXvZwbtUHZLMoVcYLi+cAjfkrrJUkp9DfC55TtZOXmA25TL4xvjtfieg1PfHWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yr2rw6CA; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yr2rw6CA"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5f52b3d98cfso814160137.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810590; x=1770415390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xkyJxM+EW3lFEa6Dp0iQPYaEUgeNkdv57uwdA3HEk48=;
        b=Yr2rw6CAXoFyOptZ3d3sGeMzRoIur91cE8inxS3Ueh9JOwmf1WJNZVa3jbyCQqENCb
         3KfGauWfl07Oy/8dAFgm/MM/jvtdlds3/uZNpX2nw8REhu6qYzqkjqNc8nG/j9uIg4DL
         hsbt2o1Ajb8/GbOu/FilDlmXotq1dzytlEGOvh0RePRsMwSW/5DGztod3puRWc1Y3g0m
         +EIm0qYCwqwhP5nhkpqaTeZ2o9og6xRJ/+ybfpUHuk3tPMoGn4DmkqvKwiTUmuVWO6pw
         MwCA78T772/H7t+kdhgYdIwQ2/8rerNzuh2odXPNLh2QXVvn8ibCuNuYAp3o1OyRlghD
         RNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810590; x=1770415390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xkyJxM+EW3lFEa6Dp0iQPYaEUgeNkdv57uwdA3HEk48=;
        b=NYGJbOi27y5nkbm3WkM2OXW9EabYUdQwUIhNgXdRtOakG5DN81mfOpygl4Gm/yNYjl
         1YyujosdQynFgtOHAIES/crVy/pemjhXrfjZKfc3C4UyfdeBH7Z1EZElihrqn3hYgXXN
         O+yxtYYiTPLz+/prEpwBg2TDGvomKRxIXscyxqZsLs1gQuCAp1I/IhSRNzP/UMGOs6D0
         C9TAvjxDHEelXfalcYBVVA9k78Nam8iYnTfXrIfGgYv18wAvSgKBq63lf0A6kvRNdVU3
         qLv7nDY7/j9bcZuzzE8vWuo6DXAl4Cppy0DjYFCS7B9icMNo0AWG0VTCDSlcNcwD45b5
         QWdw==
X-Gm-Message-State: AOJu0YxaVzyQcf2VJ/Yu8hYRf2fFoIo/FmRkUHSXQhjM0fDhqgGEN4zi
	Vrpesd1b2QRCpiFzkw10Wl/wSDoeocmDwES0o4RbK7NHGL2+Oh5p8mBAh47dCg==
X-Gm-Gg: AZuq6aKSP70uGHJ5M1PeUM9JHXtf29hRPqRYYRZUcwb8GMIVXoKLvmHmsihPgZ7ARQu
	l3mTYoAxHMRj07FJPNF3qvlAtchHpqAe/tlPbk7lCr0i3IFph6FUJd16rHofZ+QYYHrWklvpdQy
	l0bvDTAYD4wMPb1OhfIk1ZRrxzCOuAwQ4rQ8VWNLrjJAs5nDcpMh+4Qh90CzJ+JTqtXM5OZwsAH
	jLgAyEgKviuZsuzBgcZYarVh/LXZ7VdXTgFl0DhZd2PYs+5wGBqVETEHDSXZlcmL5vQfZW9WQnR
	4INLerbLQUh0RrQ3WpSwDeraM/EPcoJ0MV0e9AKqxKrSjGtjiZcYSslyKuWl9MYQYeyh6Eh5tP7
	ZEPGVMRRu9wjXEB5d6ugwheKgqqwc/HfNjfgIVb3db+vVKEEkzWry+q695AJOHY9EKO2dpZBxwI
	rHWVXGkcDwQKGfJ+SmNmIEtIV0yyjltLHOO5+apQFMGfRo7o/7nWvGxsEqvX3VX+OUMu0lquF3k
	Je1Sw==
X-Received: by 2002:a05:6102:2909:b0:5dd:b5a2:b590 with SMTP id ada2fe7eead31-5f8e24e15e1mr1184153137.16.1769810589983;
        Fri, 30 Jan 2026 14:03:09 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.03.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:03:09 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 24/37] doc/org.bluez.GattCharacteristic: Add Used by reference and Examples
Date: Fri, 30 Jan 2026 17:02:15 -0500
Message-ID: <20260130220229.1346261-25-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130220229.1346261-1-luiz.dentz@gmail.com>
References: <20260130220229.1346261-1-luiz.dentz@gmail.com>
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

