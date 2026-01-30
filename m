Received: from mail-vk1-f195.google.com (mail-vk1-f195.google.com [209.85.221.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062472FD1C1
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801984; cv=none; b=rcJFuqkrRJsu1iMQOJvAEpki6e15e5KTs/GhX4X7uizWEhPMWeATwqKV2DdntScxcvwRy5bMKUuo/dgNSUlZpeurFv7KHGqiLfCwKCmz1ysDg1i6Vw29jsXhfkYN3dD4/XLJLma7gei7xy8K8LiRNfJEimEH0rgAIPaei0wM3cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801984; c=relaxed/simple;
	bh=3dyIQDoxQL940go/6Pg4cTdZVy4bFcGmz5cXI2fHaec=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LttBHZ9ZUyxPrJQl7qxV0NN2xZrEh6tBThcxRMEBgY2hVZZ8HCIWrXLy15s0DiUeFAvc0zzThiFws6zFyV+WotQOzsKRT1B4vsVDxGjrgqSAhN56S8fLdqp1nWnaWnH3AexPLEvvUIweH9OcUOE78GqPvyxr8oHG2EHYMPlsTp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIu35MQd; arc=none smtp.client-ip=209.85.221.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIu35MQd"
Received: by mail-vk1-f195.google.com with SMTP id 71dfb90a1353d-5637886c92aso843583e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769801981; x=1770406781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04/7DrTA4Du2day76YYueoteBpggMV9ufyq1EteqNcU=;
        b=CIu35MQdTIiCEMSWjs9flMrk1BOrRlmXQlY3G7WHx6uyReqPKDqprWMVAKTOCIyMjc
         nEHxki5sbH3NaPANbOkS0JXTACZzk+pFJGL3HzUkr/9NGwUUXQ+wqDJnan8/fa9ey6zs
         GLenLzyoga8QGBfg7z2svYOwUrz7Bo6lYs8H+gxb565N0P8qDQ/qTIrs7eDPOE/bCVTh
         BI2jcYn41aIFZWF/iL3oummgh1Ig71ySVW6i6DEH6syhMznMeopEHr3iMXBCTYxVW/Np
         MuQ5eObxzZ0x5qCSj6wZ6AWtiLb8l4uV3IXsv3XTHfwP9SyT+KBUQcYtXQuLaJriZ2Xh
         RL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769801981; x=1770406781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=04/7DrTA4Du2day76YYueoteBpggMV9ufyq1EteqNcU=;
        b=svyIFvBkvGfRhU9NpNIQSnWtB1TYPBwC4jA70EuMZZg7UdiqsEcdPUdCqWKQGPLCRS
         cyEVLdJpLzvVf2p0BcvwGbWF3Kz11HL9UgIwzoaoUcy+tOZ6FAuBQ91WtunqjKJi630I
         dQ6KsXkIHWkbmkS5L36Bg4nsT1vK4G1/R4KPEEtLyRJ4QcVtbNAzjI77Px7y2w42ZT0B
         X2xYxYZVG5OvwTBKHdfIL0R3D9TQIA8rOZUgqZgqstpI2N3Y056sk+ilbe5a9v3Gqzsy
         LMwvhAPwOr3cYWpSyG9LoUXa2jHj9h+kTT6gLsusZ/jUYHlalq1mFBaigRb2c/AHIU6/
         mY0Q==
X-Gm-Message-State: AOJu0YwDodGJz1pUVCddEfPFX87h9hfaUbuWBNNa0YNAzqFyB7NAgE3H
	EDdd4HXP5vOq+h1O6HIdsmnhcFx05SXL88bW1ccdaXoQ2m7FpuK5zwYyjql1XMbb
X-Gm-Gg: AZuq6aL4q9lyxmTIMJ9LJXcygiqjPPp7lInv7sR370p5uBMbiaVJHErG2mHV5zDZtFE
	Ijrd0Pssbv8+UudnCddmeauOdx+XjcLevdF8OeypujMN3UrMM82I1UbvdyQZrb91om8li0Q+4H+
	j2UqQYWtuOQDU7TUHtU/4CiRQMqxB/tYG98Bwz6g4hqNRKQlStzg4WM9NMehy4abOiRA/Ifht+2
	rSa7Z5dlpnV6g90bwVKln5ZTDxTVcoUk3DmGkLEgdp2+ZchsR7/x72+7K4JndMAWVMj4vdH04ii
	x4X1OjFAXDk3Px/7LT3MaM1hl/dsqw+OE/e3qCrVXCn8Y6y8mFViVMSTTr3Sf8mF3214AITWlxJ
	iZ21Xw5IGSTDzbS75BIiHRWab7sPTRuFNdx2u3E/vJqsLrYzqRGiPxmUjAmBSrGt7IhDVcJ9Z/s
	OlO5j6KOjvpn69PrWUGmAZZi+HLZHCqF4OlYJFvcOe7hWMYoHDWZSWT1JIaBIcRoS3nSp9cBXqO
	KkceQ==
X-Received: by 2002:a05:6122:f89:b0:55b:1aa5:bf88 with SMTP id 71dfb90a1353d-566a0034a6dmr1036162e0c.7.1769801980844;
        Fri, 30 Jan 2026 11:39:40 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.39.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:39:40 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 10/35] doc/bluetoothctl-le: Add :Uses: fields and document arguments
Date: Fri, 30 Jan 2026 14:38:52 -0500
Message-ID: <20260130193921.1273263-11-luiz.dentz@gmail.com>
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
 doc/bluetoothctl-le.rst | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/doc/bluetoothctl-le.rst b/doc/bluetoothctl-le.rst
index 808d5786ee80..a6e1074ffa87 100644
--- a/doc/bluetoothctl-le.rst
+++ b/doc/bluetoothctl-le.rst
@@ -18,6 +18,9 @@ SYNOPSIS
 
 **bluetoothctl** [--options] [le.commands]
 
+This submenu manages LE (Low Energy) bearer connections using the
+**org.bluez.Device(5)** interface.
+
 LE Commands
 ===========
 
@@ -27,6 +30,8 @@ list
 List available le devices.
 
 :Usage: **> list**
+:Example Display all LE (Low Energy) devices that have been discovered:
+	| **> list**
 
 show
 ----
@@ -34,6 +39,12 @@ show
 Show le bearer information on a device.
 
 :Usage: **> show [dev]**
+:Uses: **org.bluez.Device(5)** properties
+:[dev]: Bluetooth device address (optional, shows all LE bearers if omitted)
+:Example Show all LE bearer information:
+	| **> show**
+:Example Show LE bearer info for device with specified address:
+	| **> show 00:11:22:33:44:55**
 
 connect
 -------
@@ -46,8 +57,11 @@ An active scan report is required before the connection can be
 established. If no advertising report is received before the timeout,
 a le-connection-abort-by-local error will be issued.
 
-:Usage: > connect <dev>
-:Example: > connect 1C:48:F9:9D:81:5C
+:Usage: **> connect <dev>**
+:Uses: **org.bluez.Device(5)** method **Connect**
+:<dev>: Bluetooth device address to connect to
+:Example Connect to another LE device:
+	| **> connect 00:11:22:33:44:55**
 
 disconnect
 ----------
@@ -57,8 +71,12 @@ Disconnect device over le.
 By default this command disconnects all profiles/services associated with the le
 connection, and then terminates the le link.
 
-:Usage: > disconnect <dev>
-:Example: > disconnect 1C:48:F9:9D:81:5C
+:Usage: **> disconnect <dev>**
+:Uses: **org.bluez.Device(5)** method **Disconnect**
+:<dev>: Bluetooth device address to disconnect from
+:Example Disconnect from another LE device:
+	| **> disconnect 00:11:22:33:44:55**
+
 
 RESOURCES
 =========
-- 
2.52.0

