Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92BA2EB5CD
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810591; cv=none; b=ALZA2yEYWI7g9dW92sr8H6jw7kgUO1Qh9/E40BLV3tLNwyLGHomByqsMxtP/3PKrarSK1/maVDbR5ylHqJFa3CI0eYpmEqCHJGlz+beomhTD76E6SsigFObMaH5Ae3X1HNpJkxka0onr407yk7xfBionDCXb2Sw5dK9WwJT3jzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810591; c=relaxed/simple;
	bh=plJ6swdqUmTwovgKg2m+PLsz9rluDzyVWcgX5IjnYnc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfTZtYNMsyUuFQbcU9xSROpAA3iru7ClVcc1LbbaRFPu1JHeCKLFxulMBuHHX023ebzJXkZalKg7Zj01OVthFBtgTb4o84QK4jcPNJiK/x8J0g4Hg20EfWTsYnoAX29LBNs98hNvYCccMTABSc/CFdyW34nhmH7bH1ENCqhF4Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiAU16Hy; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiAU16Hy"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5efa6d5dbf5so813366137.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810588; x=1770415388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qShBu038XhTZgMg/ANDarUIst8pTl/IGYhPYZ0YWOV4=;
        b=HiAU16HymtjOjKuULCuZqgVH4CkfgiTCcak/b+gqDMU6K+GKMsbevA28syRgvwqR2y
         PcvkYDh27cAUDqJ0J49lnNikjuVUHS7AXI0tMzwR/pIGHngnY/yKlEVOMswwub9O9cQw
         +s86lv+VXuAm1n65/h7x+FVdm78q2PZ/6+YAjUnEEw329ZHsxYHAW2ZCH4swAwZi2Lmk
         G6sW71xmLjiFCOpzL753lrPQJ5Cn/FjkKQBtV4dqfvzKvVbwecmvkSkoP4LT4of6EDsu
         YDqnYwwBc7mWBCNHbfvOr6prgL/VQyFNlUmDNMOLXG0a5VKjPcZlB/fxSQHmbn6n2ejX
         0izw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810588; x=1770415388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qShBu038XhTZgMg/ANDarUIst8pTl/IGYhPYZ0YWOV4=;
        b=L855Oflm5BjUJ9Y+9AFRBIFXMbh8+BIqZfo2geDJQe9lYm920/KmfAZaoOnY2l1cwo
         aLz33TGF4+BjfuaRhYMG2CPdnkmAfKbcVhuKnnBsumsqtTDGws7Epe6aC27VlqxTJdsY
         St3XJ9PLHxXXeiU2+zIRmz7hRTziG4mkEpoKATuWLnEqvvFVwdW0nSEvHEgx5dbj14h5
         RzOeOKA6tPo2wYgxyMSvKGi3JcensrXlv1dSXlFzHV962ub16SBubHCofuOHuTIz9MdK
         jFU1EMLjXKUkIFFiIGIy4CmDKeUwessvCTSYFGmYskUOHLy9zULp2zRzF69j2tv9uL96
         k27Q==
X-Gm-Message-State: AOJu0YyiiznUNxCFN2h1RfDTL0TkI97IFBCo/fGOB4u5Kvzw3oFKJoLG
	mEF0lNU860KuRO5GC3x/iKAJ8gqDfmUMY2oDF7CKJ1uoXu1dtmvq9gogPivMIA==
X-Gm-Gg: AZuq6aJIvRk8c8Ug82er1sYvtGoTwRq3ROW3hdaY9/1SKVlmksiXWlAOFALeAEFMpAl
	8FdVwg0RNN4zaF4vS3U4i+2SFtIM+JvkFYY+JZBqAoAliSCf7Sfl9GqlxKGzn+rc0Sr/pVU0GIq
	TObiBk2B8/1DWs5PMpeqL1fLgrINMPeV+7a22zOTwa537eTBOrCSq6bVs1Hhi2LjZ3cz7VkggGj
	VusjgcyD0XWBqlC6XywT7Hx5ZBO6UwSJu21LJ/byHXpSzgrRmJ0yHZGRz0scrsf+fsoxhW0Sjzu
	VtBRPVo2Ii/MA0rdAEFr64tLoJ5b5aV4EHC1TkBxRy8JSoRR7BP3zfS1L7DnJpv4Buy9HCgbB4t
	dotk9LoOPIHLLoD10STkmYj2MvXyiAHa65v06l8ceNeA+IxNKMHaA43wOVPHIL2A9U9cT78LH/R
	7Xve1MCZopPg3sa2kbBY0OwFleDxauBd+daNZcUFm17ue98NpDgey59k6FWvl47iCCZJqJyDAiy
	TSVCA==
X-Received: by 2002:a05:6102:3e89:b0:5db:cba0:941 with SMTP id ada2fe7eead31-5f8e26860f1mr1496956137.38.1769810588363;
        Fri, 30 Jan 2026 14:03:08 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.03.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:03:07 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 23/37] doc/org.bluez.Device: Add Used by reference and Examples
Date: Fri, 30 Jan 2026 17:02:14 -0500
Message-ID: <20260130220229.1346261-24-luiz.dentz@gmail.com>
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
showing corresponding bluetoothctl commands for device methods.
---
 doc/org.bluez.Device.rst | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
index 593ff06643f3..3e6a30aafb8a 100644
--- a/doc/org.bluez.Device.rst
+++ b/doc/org.bluez.Device.rst
@@ -17,6 +17,7 @@ Interface
 :Service:	org.bluez
 :Interface:	org.bluez.Device1
 :Object path:	[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}
+:Used by:	**bluetoothctl(1)**
 
 Methods
 -------
@@ -51,6 +52,10 @@ Possible errors:
 :org.bluez.Error.AlreadyConnected:
 :org.bluez.Error.BREDR.ProfileUnavailable:
 
+Examples:
+
+:bluetoothctl: > connect <dev> [uuid]
+
 void Disconnect()
 `````````````````
 
@@ -69,6 +74,10 @@ Possible errors:
 
 :org.bluez.Error.NotConnected:
 
+Examples:
+
+:bluetoothctl: > disconnect [dev] [uuid]
+
 void ConnectProfile(string uuid)
 ````````````````````````````````
 
@@ -125,6 +134,10 @@ Possible errors:
 :org.bluez.Error.AuthenticationTimeout:
 :org.bluez.Error.ConnectionAttemptFailed:
 
+Examples:
+
+:bluetoothctl: > pair [dev]
+
 void CancelPairing()
 ````````````````````
 
@@ -135,6 +148,10 @@ Possible errors:
 :org.bluez.Error.DoesNotExist:
 :org.bluez.Error.Failed:
 
+Examples:
+
+:bluetoothctl: > cancel-pairing [dev]
+
 array{array{byte}} GetServiceRecords() [experimental]
 `````````````````````````````````````````````````````
 
@@ -294,6 +311,11 @@ Indicates if the remote is seen as trusted.
 
 This setting can be changed by the application.
 
+Examples:
+
+:bluetoothctl: > trust [dev]
+:bluetoothctl: > untrust [dev]
+
 boolean Blocked [readwrite]
 ```````````````````````````
 
@@ -303,11 +325,20 @@ rejected.
 Any device drivers will also be removed and no new ones will be probed as long
 as the device is blocked.
 
+Examples:
+
+:bluetoothctl: > block [dev]
+:bluetoothctl: > unblock [dev]
+
 boolean WakeAllowed [readwrite]
 ```````````````````````````````
 
 If set to true this device will be allowed to wake the host from system suspend.
 
+Examples:
+
+:bluetoothctl: > wake [dev] [on/off]
+
 string Alias [readwrite]
 ````````````````````````
 
@@ -320,6 +351,10 @@ string as alias will convert it back to the remote device name.
 When resetting the alias with an empty string, the property will default back to
 the remote name.
 
+Examples:
+
+:bluetoothctl: > set-alias <alias>
+
 object Adapter [readonly]
 `````````````````````````
 
@@ -439,3 +474,7 @@ Possible values:
 :"last-seen":
 
 	Connect to last seen bearer first.
+
+Examples:
+
+:bluetoothctl: > bearer <dev> [last-seen/bredr/le]
-- 
2.52.0

