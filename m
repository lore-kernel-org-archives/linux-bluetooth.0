Received: from mail-vk1-f196.google.com (mail-vk1-f196.google.com [209.85.221.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178172FDC27
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801979; cv=none; b=Q3Eo/9vOMrsAu1L74cgC3DwZ7VEti/YYhky9uUORbq3vcs046a8NamKZX3Gcm6iSF+K/4wovNR5pehyYetwSvw0OHnONiMhtN7URuv8raFNwhI/VGxon3y7ChhFv1rBO8Yem53G4YenBgL76t3QX1UcBbr0MSARH+sVRC8dJQy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801979; c=relaxed/simple;
	bh=9c7R2N5seOTyjsS0aWHZe8B7abWwqUBQ0sGVTLdFo/8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7TLVDHYgD4umXaJYy+xkRjLv9WzPxXnemcwWBYlqiQeJRfdvSfDJfZiPsIv8EOcHkv38Ihpzh2hBAykJtc9nhks5DCnlAwTulEIg+6JXW1VXI8UzczZNJ/cfPYFImP2wx0r/IzrqfJTScQMKcHiXs4ihBSKXgRtL9tt4e4dydc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMd+eymh; arc=none smtp.client-ip=209.85.221.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMd+eymh"
Received: by mail-vk1-f196.google.com with SMTP id 71dfb90a1353d-56638fca064so805370e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769801977; x=1770406777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SnVJ2CRjkqiLXMMFesIs3WyqsEpTqadys+AoA+Zu/zQ=;
        b=DMd+eymhc/QV2xLORtkwUmwUhkkPmKnWAUxWbfG8W+QaZzDM74RlQhVs5IgSJRvhp9
         Ck1u2qitoQhyDMXdJ7kRTK7UewB3uw0rk8mNThSwY4URCOwUWLIDCS5pHi4ECpmjgkrp
         WP4WdEuYzPDpEdnQBBa8oNZ+JJo1uRoXY0KKl1Dz0RbjfVvUt36Z27D/ZCg0ZVNgUCdc
         8BJBcFnwTbiWi0HxOMrXKH43O2pDS6Vh8cXXjONavH9rC526Nfq+Lnt0RDjWYQANw721
         tXDuxe/tbt8K7grKsTzkf7xnfPgvBPiUmtHKmQQ+8UBR76fLLIDzcLt0nDC7qPDNgi1/
         nntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769801977; x=1770406777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SnVJ2CRjkqiLXMMFesIs3WyqsEpTqadys+AoA+Zu/zQ=;
        b=mfR0A+mszShUjKLva8jTOjYLhp0ks/yh4IDqb0D+2hBIeb/PLRVGZfrXQKbdqLXccw
         I4YJ/WbTOHl4+9hlPUdtfeAuRzy6oRbT+KefwYqzXBuZ033WSnkPLfgZDXFAVSFZDkks
         +zovJSvuX31R/cFU2A3agvZCwhDDJG1PLmIYXrdC1iHQ/j0C1z0eLjWMESgbh884E+5S
         G1MgUJvhz6onYG9MxB+S66tGNUWMa32EtOEk7960I+RYINSUDxq+ykCaVzVoJZmuBH6I
         iYCYylrXIxZc/otLrPgLOR9ukWhGcL6HmEuFbDteYR6JRPLB5Yb9ojSw4OWDKZqftY2m
         v/Gw==
X-Gm-Message-State: AOJu0YzipFk8AuDgYPo3hBd0GAL38ykvxMz898gTTj0SnvwBODb0rHeQ
	KTW3oLYee8hwa6pYA/EV6KMDFh+EnfkuuuMzVdIPH8R3PbmLZx720UW6R8lRNY3b
X-Gm-Gg: AZuq6aLGzI9apeOLcZSmL24LqFbLbiMui4JjS3YTfa9nGusa6bY4vFxBeGIq5lIDsgl
	zS6PV0OUuHrNCq/61QBgJ4MJZM6J3ACCy1/v28KPQGgtl3NXeHUn/HFuxc97re5VWF6voPda5BA
	1UyJuDaj9SV6vjd/bMCNemHp3Z3iwvsPESSnDAHeP+QOV1NnBjZTxw7hFTIzVHnfkih5L2/OP0v
	oZ5fEVDrEF+P9FtqL+qQr9MZ25L6h6ZCvjnZ7b3RakduOnzoTvRVUY6zY98EDLH5ditdzJM85ft
	xrGw3kuhOwbDan9eftIkQzf2sT5jUuG5VxQbwQBfYQLNI3LjpTAe2N6mErq/q038zNu66dwYrXC
	L6RmzaZZSkRSiBSgeuJExMj95wOCVjzvLX7sjr8hBpB7fMXRsrXFwID4InPX7XMXI0tsLDrPFa7
	thjyugHlf9N/+AtK1xMzX6L2GjD4/msaZzazpnHlTjOBZ9vzdVvmkDUzWH6xtQ4uHak1XsZBEY5
	lOJKA==
X-Received: by 2002:a05:6122:2212:b0:55b:1938:9183 with SMTP id 71dfb90a1353d-566a005253cmr1351757e0c.4.1769801976761;
        Fri, 30 Jan 2026 11:39:36 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.39.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:39:36 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 06/35] doc/bluetoothctl-bredr: Add :Uses: fields and document arguments
Date: Fri, 30 Jan 2026 14:38:48 -0500
Message-ID: <20260130193921.1273263-7-luiz.dentz@gmail.com>
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

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.
---
 doc/bluetoothctl-bredr.rst | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/doc/bluetoothctl-bredr.rst b/doc/bluetoothctl-bredr.rst
index 3ec702a59ff3..2425707f3285 100644
--- a/doc/bluetoothctl-bredr.rst
+++ b/doc/bluetoothctl-bredr.rst
@@ -18,6 +18,9 @@ SYNOPSIS
 
 **bluetoothctl** [--options] [bredr.commands]
 
+This submenu manages BR/EDR (Classic Bluetooth) bearer connections using the
+**org.bluez.Device(5)** interface.
+
 BREDR Commands
 ==============
 
@@ -27,6 +30,8 @@ list
 List available bredr devices.
 
 :Usage: **> list**
+:Example Display all BR/EDR (Classic Bluetooth) devices that have been discovered:
+	| **> list**
 
 show
 ----
@@ -34,6 +39,12 @@ show
 Show bredr bearer information on a device.
 
 :Usage: **> show [dev]**
+:Uses: **org.bluez.Device(5)** properties
+:[dev]: Bluetooth device address or object path (optional, uses current device if omitted)
+:Example Show BR/EDR bearer information for currently selected device:
+	| **> show**
+:Example Show BR/EDR bearer info for device with specified address:
+	| **> show 00:11:22:33:44:55**
 
 connect
 -------
@@ -45,8 +56,11 @@ This command initiates a bredr connection to a remote device.
 By default, it establishes the bredr connection and then connects all profiles
 that marked as auto-connectable.
 
-:Usage: > connect <dev>
-:Example: > connect 1C:48:F9:9D:81:5C
+:Usage: **> connect <dev>**
+:Uses: **org.bluez.Device(5)** method **Connect**
+:<dev>: Bluetooth device address to connect to
+:Example Connect to BR/EDR device:
+	| **> connect 00:11:22:33:44:55**
 
 disconnect
 ----------
@@ -56,8 +70,11 @@ Disconnect device over bredr.
 By default this command disconnects all profiles associated with the bredr
 connection, and then terminates the bredr link.
 
-:Usage: > disconnect <dev>
-:Example: > disconnect 1C:48:F9:9D:81:5C
+:Usage: **> disconnect <dev>**
+:Uses: **org.bluez.Device(5)** method **Disconnect**
+:<dev>: Bluetooth device address to disconnect from
+:Example Disconnect from BR/EDR device:
+	| **> disconnect 00:11:22:33:44:55**
 
 RESOURCES
 =========
-- 
2.52.0

