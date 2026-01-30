Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3374737647D
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810582; cv=none; b=UNYx8WnUwx91LsQmVvHue/bCTp1/o1UuMA6QhmKKODNsqpwPRa/Yxjpup06gghMCJgbzpR/SExF3P/Z413DwRi3TP6asNiFGi6TRVRiV0D6MHNVh9t0NY+LEkUruPsP082jZKRUnpmJK0ZjxeQabWDioVbBeUuEHb+zXS8a6vGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810582; c=relaxed/simple;
	bh=fm3XI/zK91AiubOFK67saRKnaHa9ddz7gER9VpUY6VU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVP6n9F+JSDLiwa8ERKCNazKDI+LosvDNwrm1GNMPLnXqrxhyw6Sy/n4ZGHAYbrCXXMt19VzExXKGn5OB/ZDtevpCnbHQcr3vliieT+uk38gd1AfBv2IVrlcEFB8qwwiPGvveKZD/bP6j2VpPlcChzPAscCtPIAAT+SlkMCY5F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czH1pATr; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czH1pATr"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-947fe9e92c3so1527275241.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810580; x=1770415380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5KHmWyrwL7sDZjyTOQGnpHAj+tNjs+urBK+FzZbsr7c=;
        b=czH1pATrhjy64N4+Iq6Cey5TJneHqpCDyRu/gwt/AwwyZPaM9uns6KXTJAJiLRcVWl
         tPHyg5Aj3PKBy860LAkap0i5wqGQYuDCNadaXlSr4ink8VMNQFht6UjMOLTHh088lB7E
         WDQwfueWYiqZF+pfTRE/pLYgAWkmUKOzfxFsd/OoCUTMA0ML+zwhxdN7iuh1AD4oNE0S
         Fw8PTcEEPyKarvxaC4cEyknwPZYGjZeJmCUKB7/faFZCG/4nCjLgjmWK0BrViqVDmo8w
         9S9K35swQgyyiWQ4TzMIKxMYbrqxnllDD+mqRmkxYPlyZB2KlIDVRuzJyVLazmLHMAOI
         8sRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810580; x=1770415380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5KHmWyrwL7sDZjyTOQGnpHAj+tNjs+urBK+FzZbsr7c=;
        b=XM7doJkqUUawBb66g/Vb5iXvPfN99YRQZmL/BXpCm2mbvSC3QxtycnrCi8hGt33wL7
         MhBPmS6Nh95f3WTUH6cVgnZ62lfrw1hyEXNxnQQg5yKw01CR+upn5yUa9rfgpz3ax4EO
         9UCUlASXLwvm/fkWm5y4D8yEVSI54FmBU+QJVm9+NKH6CcxbXaquVoglhhUZw1SFcBCS
         al48Uzbg47z8eh9R5cfE+oG/QjIJzT0GqivrA5PM3upyzW1fjiF1iJA8EcvAwW3X97ej
         EtPVeJtSQDCIk+aBOv2PVeOEr198oUG7FG2x63o7r7tRCIEdI2SE+y+GAZlxmcTBfdOW
         Zuug==
X-Gm-Message-State: AOJu0YwxD1m7rO91S2jahmJbCGbbwiJcbcrbXnlszLLbwptfztQyFA4Y
	GJWrJJp5p6E73E5wsOmx6MvcFlbzrxAP20P67Po6Php3QVD16iL8o0CqJFVjEw==
X-Gm-Gg: AZuq6aJyM0Sj5s4Rs8qGp84IFfGHEe05jwcEsNbLoj5Ma5BTC8+Ly+HW4mxwjEVf6H9
	neb3tJ3WvK8YniMVMBxpFKNcwD6yX8JRHBD4VfQa3YSbf2C8KYO4kxBjUZzvUbMcIGJ/3B2m/oU
	N918QfMBSSCqos8Jx0v0ES+kSIHiX+6OfDR+uWGrDrFHUkz86Le+Y2+Ww53pgDjWVyQQSH6N01b
	/t2wrZUfdCRtgveuiM8YHeQkBIPIRalnuqUKfiSIVxjfh50N1svT+LE66ADeHU3Yq9KnqitoLy/
	kJxelmAFGDTtlO+c1RqWOcQSWhZxJlEP0qLBq0kma4g4rPOBlsKUWw1Y4B/mOkkhqkTsI4jUbGY
	3SAeHZGC3XKlG6+lgbFwFX/JMSSFVmwKiLQGVMaj2z5JNcZl17qAZSkUHKAbpszyhRa70e2p1cP
	0XzTSaBgrqGwRiyJSe2ygAxJPidotwtSfZa7rNm11lz0jtuYkIy5K0ezN1WsZmt1SMclU8iBNay
	uVaWw==
X-Received: by 2002:a05:6102:2910:b0:5f5:3c00:180f with SMTP id ada2fe7eead31-5f8e2470a47mr1420596137.4.1769810579851;
        Fri, 30 Jan 2026 14:02:59 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.02.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:02:59 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 16/37] doc/org.bluez.Adapter: Add Used by reference and Examples
Date: Fri, 30 Jan 2026 17:02:07 -0500
Message-ID: <20260130220229.1346261-17-luiz.dentz@gmail.com>
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

Add :Used by: field linking to bluetoothctl and Examples sections
showing corresponding bluetoothctl commands for D-Bus methods.
---
 doc/org.bluez.Adapter.rst | 41 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/doc/org.bluez.Adapter.rst b/doc/org.bluez.Adapter.rst
index 41d6517b512e..c84490d164b7 100644
--- a/doc/org.bluez.Adapter.rst
+++ b/doc/org.bluez.Adapter.rst
@@ -17,6 +17,7 @@ Interface
 :Service:	org.bluez
 :Interface:	org.bluez.Adapter1
 :Object path:	[variable prefix]/{hci0,hci1,...}
+:Used by:	**bluetoothctl(1)**, **bluetoothctl-scan(1)**
 
 Methods
 -------
@@ -41,6 +42,10 @@ Possible errors:
 :org.bluez.Error.Failed:
 :org.bluez.Error.InProgress:
 
+Examples:
+
+:bluetoothctl: > scan <on/off/bredr/le>
+
 void StopDiscovery()
 ````````````````````
 
@@ -67,6 +72,10 @@ Possible errors:
 :org.bluez.Error.InvalidArguments:
 :org.bluez.Error.Failed:
 
+Examples:
+
+:bluetoothctl: > remove <dev>
+
 void SetDiscoveryFilter(dict filter)
 ````````````````````````````````````
 
@@ -176,6 +185,17 @@ Possible errors:
 :org.bluez.Error.NotSupported:
 :org.bluez.Error.Failed:
 
+Examples:
+
+:bluetoothctl: [scan] > uuids [all/uuid1 uuid2 ...]
+:bluetoothctl: [scan] > rssi [rssi]
+:bluetoothctl: [scan] > pathloss [pathloss]
+:bluetoothctl: [scan] > transport [auto/bredr/le]
+:bluetoothctl: [scan] > duplicate-data [on/off]
+:bluetoothctl: [scan] > discoverable [on/off]
+:bluetoothctl: [scan] > pattern [value]
+:bluetoothctl: [scan] > clear [filter]
+
 array{string} GetDiscoveryFilters()
 ```````````````````````````````````
 
@@ -278,6 +298,11 @@ defaults to the system name and provides the pretty hostname.
 Only if the local name needs to be different from the pretty hostname, this
 property should be used as last resort.
 
+Examples:
+
+:bluetoothctl: > system-alias <name>
+:bluetoothctl: > reset-alias
+
 uint32 Class [readonly]
 ```````````````````````
 
@@ -308,6 +333,10 @@ state of the controller.
 The value of this property is not persistent. After restart or unplugging of the
 adapter it will reset back to false.
 
+Examples:
+
+:bluetoothctl: > power <on/off>
+
 string PowerState [readonly, experimental]
 ``````````````````````````````````````````
 
@@ -353,6 +382,10 @@ In case the adapter is switched off, setting this value will fail.
 When changing the Powered property the new state of this property will be
 updated via a PropertiesChanged signal.
 
+Examples:
+
+:bluetoothctl: > discoverable <on/off>
+
 boolean Pairable [readwrite] (Default: true)
 ````````````````````````````````````````````
 
@@ -361,6 +394,10 @@ should only be used by the settings application.
 
 Note that this property only affects incoming pairing requests.
 
+Examples:
+
+:bluetoothctl: > pairable <on/off>
+
 uint32 PairableTimeout [readwrite] (Default: 0)
 ```````````````````````````````````````````````
 
@@ -373,6 +410,10 @@ uint32 DiscoverableTimeout [readwrite] (Default: 180)
 The discoverable timeout in seconds. A value of zero means that the timeout is
 disabled and it will stay in discoverable/limited mode forever.
 
+Examples:
+
+:bluetoothctl: > discoverable-timeout [value]
+
 boolean Discovering [readonly]
 ``````````````````````````````
 
-- 
2.52.0

