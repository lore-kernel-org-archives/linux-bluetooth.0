Received: from mail-vk1-f194.google.com (mail-vk1-f194.google.com [209.85.221.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24771354ACC
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810580; cv=none; b=M5Re/iRfoTwYGE73fmzFQElA/+5khxloipKL5+m/J5FGHdJRGjRGpd2okwVFqYBQpblZBFYIx7pV8JHBCwnnpZwGUZm3acFML8RjNtA16VAtKddYrfYI3gWSGM+pLbipQWvUEvq527F4L5psKGyJDH8eOwRSLYOHjbbJ3t/fcnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810580; c=relaxed/simple;
	bh=1qcg6Fo+zUlw0awma7itvdhqQrXkosVfl4b4dIPdJk4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWqL6utc0RPwujRE8Y/BdDuQHzsFDMzaSKF73Cmyro7wtLcp7sE2/pFc9axXNPbGbIKXMawncqoOZ3wkVHW1YYhstunIu4HtKrxrWkgGTeFTlLfa+Br3sM7TBROVRiXjnLCZqILJSiZtnr7bRJjmfT+1t76j6l/nX4+FSQv0whY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bD3n4f+6; arc=none smtp.client-ip=209.85.221.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bD3n4f+6"
Received: by mail-vk1-f194.google.com with SMTP id 71dfb90a1353d-56376c3e866so1859478e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810578; x=1770415378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1I5Tcnn29kS7X5Bx7cDIRKiPlsqGmWf3rIkh4jrajJo=;
        b=bD3n4f+6fM4yb9OA7cVHmAZ+zOJX9BBoi7sUXtS8oSB0Spq9sFTPBcIRYVGBZNhFWg
         7HeVjcPaPwEGp1NjveWgIE45sBliWVZhzloQ/LTuB4lgrsPXBWsvVewi+022KWsqDXdK
         qbi0COH9aCaI1Ud8yhclj419KRFZy/lXx69l4j+Jwtl+iBvKHKTO9tcf0kt6RAslIGty
         fWkjKt2c8u2IRV7JHuJaMBQFNr8mmnyeRcH8wRd3fcJhre1WKLEv/mAuZWFpKJ9BwS6h
         rPHs+tDdxK0WWxDWNMK9BFmAZtPtSpWFAvNNEVcO8p7ta9fwwFGKCwtUkVQB22flk1Kg
         p9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810578; x=1770415378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1I5Tcnn29kS7X5Bx7cDIRKiPlsqGmWf3rIkh4jrajJo=;
        b=toF5WkFlQpHcfeqokM0/IfAuglfY83MyClBN2mSqEA2j/Y/ofkZoz+UUzAfaMwFH7i
         toYsfA5etlGpDfGmPY99Usdi7B+bvX+3YTjC3MmLxCMtBZGJ1paJYIkFGSFN+AfkZx0g
         XDP0cGr9iX/+uibQFe6hLz362FBUcNog1R70xZHvLIV/hRZ6PTAENCsS5OhrOz1XHzd6
         8XaCJBhqqPAb+6+K0i449a7m/SeEEbN9tn5C+Cjyw3Tb2u43VlPG5Amdf6oXtnaGzdaK
         mAb5Jvb6AJDalELQQKmCuiH0w8aSWC47rXJF5zN6XE8zIbFhWFjR+lbVTF5VFXPUICt+
         yttA==
X-Gm-Message-State: AOJu0YzmnIM9BvKN1+OnK66Nc0tVlGb3IhKH2M4BSfTcZvsOtYgNGLLI
	PB6iHA+5MYFWpNWwMhiUdYiOMFYIHXioaU+D/C+djyw7fdPiSjuwdxJob/KMWnPj
X-Gm-Gg: AZuq6aIgeJniV/LWdiDfl4TQJu19bJa4875NsOD2lfn5DbaO0eEEz/CbShgZrXaAQYw
	oWt0MV7GR3uZdt0Y5KQvI/GLbxpe6yx4KDNs5Nh32NA6zWUGMlhw9Aedxpg9CcNQC5SRGbOPSYX
	bb2CpqyIkzJo0N31pAoDkGyZSSG7oB7Rycx9+AcoABOgh7CgXAFQQDCKnNDiEUJ8I4CzITmj26m
	idfvrwIZlJieYhXSCkKD3FEoj/6PCzLa1IZYgWZosC3kno8SPlimfuZ/HB/CEVWMfe9ybitMoOJ
	1bCtdp5xbLmC2i6USxkcdaKIlV4P3Z6zbDISxwYXJ4BqT0pv3UfReET6EEgpzJ0pQ6TaAJPKrtG
	vudlLQk00yw3WT0wAWfqzBmBhxsykg35W2Ed3wNe0v5WFCRYrbyHs0s4z1Wn9tc1RMIT7HE/4F5
	DKNYaS/PjvgzRK/sFzRiQ0g5yZCOcVnPmLOnbtuU7xnpvQIXxXGoDA8a13nM2IOEhkd/MoBwFed
	9jbAg==
X-Received: by 2002:a05:6122:906:b0:563:7390:b17d with SMTP id 71dfb90a1353d-5669fe8303bmr1274025e0c.0.1769810577722;
        Fri, 30 Jan 2026 14:02:57 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.02.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:02:57 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 14/37] doc/bluetoothctl-telephony: Add :Uses: fields and document arguments
Date: Fri, 30 Jan 2026 17:02:05 -0500
Message-ID: <20260130220229.1346261-15-luiz.dentz@gmail.com>
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
 doc/bluetoothctl-telephony.rst | 75 ++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 4 deletions(-)

diff --git a/doc/bluetoothctl-telephony.rst b/doc/bluetoothctl-telephony.rst
index a6870e781a7a..84ea36f778ed 100644
--- a/doc/bluetoothctl-telephony.rst
+++ b/doc/bluetoothctl-telephony.rst
@@ -18,6 +18,9 @@ SYNOPSIS
 
 **bluetoothctl** [--options] [telephony.commands]
 
+This submenu manages telephony features using the **org.bluez.Telephony(5)**
+and **org.bluez.Call(5)** interfaces.
+
 Telephony Commands
 ==================
 
@@ -27,34 +30,72 @@ list
 List available audio gateways.
 
 :Usage: **> list**
+:Example Display all available HFP audio gateways:
+	| **> list**
 
 show
 ----
 
 Show audio gateway information.
 
-:Usage: **> show [audiogw]**
+:Usage: **> show [telephony]**
+:Uses: **org.bluez.Telephony(5)** properties
+:[telephony]: Audio gateway device path (optional, shows current if omitted)
+:Example Show information for currently selected audio gateway:
+	| **> show**
+:Example Show information for specific audio gateway device:
+	| **> show /org/bluez/hci0/dev_00_11_22_33_44_55**
+:Example Show information for another audio gateway:
+	| **> show /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF**
 
 select
 ------
 
 Select default audio gateway.
 
-:Usage: **> select <audiogw>**
+:Usage: **> select <telephony>**
+:<telephony>: Audio gateway device path to set as default
+:Example Select specific audio gateway as default:
+	| **> select /org/bluez/hci0/dev_00_11_22_33_44_55**
+:Example Select different audio gateway as default:
+	| **> select /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF**
 
 dial
 ----
 
 Dial number.
 
-:Usage: **> dial <number> [audiogw]**
+:Usage: **> dial <number> [telephony]**
+:Uses: **org.bluez.Telephony(5)** method **Dial**
+:<number>: Phone number to dial
+:[telephony]: Audio gateway device path (optional, uses current if omitted)
+:Example Dial number using currently selected audio gateway:
+	| **> dial 555-1234**
+:Example Dial international number using current audio gateway:
+	| **> dial +1-555-123-4567**
+:Example Dial emergency number using current audio gateway:
+	| **> dial 911**
+:Example Dial number using specific audio gateway:
+	| **> dial 555-1234 /org/bluez/hci0/dev_00_11_22_33_44_55**
+:Example Dial UK number using specific audio gateway:
+	| **> dial +44-20-7946-0958 /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF**
+:Example Dial with caller ID blocking:
+	| **> dial *67-555-1234**
+:Example Dial with caller ID hiding (GSM format):
+	| **> dial #31#555-1234**
 
 hangup-all
 ----------
 
 Hangup all calls.
 
-:Usage: **> hangup-all**
+:Usage: **> hangup-all [telephony]**
+:Uses: **org.bluez.Telephony(5)** method **HangupAll**
+:[telephony]: Audio gateway device path (optional, uses current if omitted)
+:Example Terminate all active and waiting calls on current gateway:
+	| **> hangup-all**
+:Example Terminate all calls on specific audio gateway:
+	| **> hangup-all /org/bluez/hci0/dev_00_11_22_33_44_55**
 
 list-calls
 ----------
@@ -62,6 +103,8 @@ list-calls
 List available calls.
 
 :Usage: **> list-calls**
+:Example Display all active, waiting, and held calls:
+	| **> list-calls**
 
 show-call
 ---------
@@ -69,6 +112,14 @@ show-call
 Show call information.
 
 :Usage: **> show-call <call>**
+:Uses: **org.bluez.Call(5)** properties
+:<call>: Call object path to display information for
+:Example Show information for specific call:
+	| **> show-call /org/bluez/hci0/dev_00_11_22_33_44_55/call1**
+:Example Show information for another call:
+	| **> show-call /org/bluez/hci0/dev_00_11_22_33_44_55/call2**
+:Example Show call information from different device:
+	| **> show-call /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF/call1**
 
 answer
 ------
@@ -76,6 +127,14 @@ answer
 Answer call.
 
 :Usage: **> answer <call>**
+:Uses: **org.bluez.Call(5)** method **Answer**
+:<call>: Call object path to answer
+:Example Answer incoming call:
+	| **> answer /org/bluez/hci0/dev_00_11_22_33_44_55/call1**
+:Example Answer waiting call:
+	| **> answer /org/bluez/hci0/dev_00_11_22_33_44_55/call2**
+:Example Answer call from different device:
+	| **> answer /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF/call1**
 
 hangup
 ------
@@ -83,6 +142,14 @@ hangup
 Hangup call.
 
 :Usage: **> hangup <call>**
+:Uses: **org.bluez.Call(5)** method **Hangup**
+:<call>: Call object path to terminate
+:Example Terminate specific active call:
+	| **> hangup /org/bluez/hci0/dev_00_11_22_33_44_55/call1**
+:Example Terminate waiting or held call:
+	| **> hangup /org/bluez/hci0/dev_00_11_22_33_44_55/call2**
+:Example Terminate call from different device:
+	| **> hangup /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF/call1**
 
 RESOURCES
 =========
-- 
2.52.0

