Received: from mail-vs1-f66.google.com (mail-vs1-f66.google.com [209.85.217.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B662FB093
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810575; cv=none; b=iPGTAzyOLdCe8HLF6BOP9KAmvxUWsJG9+rcjCFCKDgaDAqEQilH39Myq572GRaapO6u1nmoJr9N7EZRESMQfrpgOU70KotfhQHrNaNgk01tG08mNVdOmTnn1TdrpjF95XVAjsuUk6Z5xSFQm+Fc4guvPUFLYsDVaoDNsIk6ijXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810575; c=relaxed/simple;
	bh=3dyIQDoxQL940go/6Pg4cTdZVy4bFcGmz5cXI2fHaec=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ta6x2Qd2KfVlXXsYZihxmLQUoy5i+oSxz0x/A2+rwP6JsuFT+679zIxguMuTy3bORuT9SV9xICfdgh0iMuacOnUF6hYd77WJmQaY7BRkO1Q3HovzeKUlqxRc6FPy4N0+gpyAxvwJN26U77pJhl4WNvVDwOSwg6Qazmy97w90X8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9lGvQ8y; arc=none smtp.client-ip=209.85.217.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9lGvQ8y"
Received: by mail-vs1-f66.google.com with SMTP id ada2fe7eead31-5f54d6b4047so1655392137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810573; x=1770415373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04/7DrTA4Du2day76YYueoteBpggMV9ufyq1EteqNcU=;
        b=Q9lGvQ8y5D7SgPrHGgWV1tCBAEl18MEaX2qsHEzVP2dHWTZrr6wGLjh8hMYjkvQMKq
         xW48j0nDch4EKuyM4gWfqCUCkdTWhJM4xuwcHcKvk6OSgKOV2T4iKQR7Gf/LDziRNM1j
         ekTe4cqLRAHAbvyNTDjUhxdLW3f5zwxnPT5aIJgmRyMmCETUz5kfgfXQBub8slBr/nLR
         5Ha648kynzDrj6/Qygkx1d9gz/Ydc2StvVaP5btLhfqYUv38lTxrJafa6ogNjKwaAVk1
         BPR4xgP7ccqeN1U1av/lBmdxtQtSqY6u4dnxfmgNw/zPLo6jx33EAjmTOx50fhS0WXCf
         vCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810573; x=1770415373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=04/7DrTA4Du2day76YYueoteBpggMV9ufyq1EteqNcU=;
        b=twnTq++TKTAr1IYBn1odSNZY1GYxrvEtcyEIEESxYWZZooLJxc648RzBC0eE4tOF1Q
         qOdG6FvJLaKQleekxRgPvnXuQjyyANIx/M0NTYwCwl7+xaSSjQzaBvUvzyIX+Q3XxSIZ
         K2JFKrqsY1LMmpEIK9WNjBF9C0FGpYE7LNzrkQNxTxGB3HHkwM1qUxqzuQ4d6b9Y98YQ
         cfOlhImJ1eOa6HfWK0P5et3EaLWKX1OHClxvZEFmeJEC7mrDydFxXQmsLmQkO8oAOHE2
         V5yEnwAxQqtQqbqqpWyJx6sTfUadonYoP/n1vavxPm3W5LsoTa+uIz+Co+Sae0/Xm/OB
         hlnQ==
X-Gm-Message-State: AOJu0YwPoR/t2RDZ7gOrfjUUEy8d1grUP94bN0s4sGSJGfsdm7Cga3H8
	OPVEhGeUTQmZyUesbdfswOsp50bA0rMP3Fcz5mkvI8HPd/HMtnjWie+QS4DRDqT7
X-Gm-Gg: AZuq6aJ2tYTdpz2c2/kc7NIaKMSZCe6VrTtpbRkWurGbxWjXBfPLjv+Ni6zsvxmC/8L
	tcM9zUfRIMo37MeHaXWPnPg7xn4Yx+j91Q5NfD3DL+j7WWJUkdMYKl6iMcssiCKI9OXg071op7N
	fUm28mjJBMC7SNTWNaeecc2UEz9kKxmR6miiz11+u+7/4pvo60cuihr81WOdroF42uJ5Om7XW72
	skmdQAgdiWdB9dGPHlSG1n+RWBz9G5uf+oWyanpWXsd7TA7Uws2WUyxO7vf8pnFq3GcGTdA6Lmu
	XNzkOOtJMW7YsX6MLlIYhFjadp27FHH2xCtsNbo63+upxVRD/0wfIP/ujltZaG5qYL3DvuyijRO
	YKFOL6yIso4DtUsqWL+0XsCsZKjBqXW+vVC2XcSXEfxEzxLJpRkhesydFZg7UAAQswQvGGAaijp
	J9cKenBqQrX0EAWjr3EclJdYTXASaAVNJEhwrkyFT1XpFhjb3pLMkXIAKnlz6Vd0N8z9fV4aiSx
	GFyNOcBWV8qgIlz
X-Received: by 2002:a05:6102:38cb:b0:5f5:320c:4d36 with SMTP id ada2fe7eead31-5f8e263b5edmr1331309137.40.1769810573050;
        Fri, 30 Jan 2026 14:02:53 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.02.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:02:52 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 10/37] doc/bluetoothctl-le: Add :Uses: fields and document arguments
Date: Fri, 30 Jan 2026 17:02:01 -0500
Message-ID: <20260130220229.1346261-11-luiz.dentz@gmail.com>
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

