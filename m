Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D7D3E0094
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 22:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787178748; cv=none; b=al9gsydiaxYXAYBuU+jw7KCNU7h57VwkQQAhop3ahL83804zkQusi9f1w/vyzEG0w9Aposzca3kD+MXDCUe1J4etdQKaYrCuohExNd1iXvOE0z5SpyJDuPQzJ0ol3fgS2qAN0y9JaFnYZhxppZi+pFRfsH17VR//Aqqy8Ps6Fsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787178748; c=relaxed/simple;
	bh=fHa+Qh0tZuEBxQOujxQsVtCdcROzNffDDKhi8iy4DqQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vASlw61vcG/hwtJB+CXV0VS1fY7qgdR90MPpdKFgiFCyyYzIMWhJtfg5AvEUhVjTe4xziqAMJRfWnpHdGiCTtfnbqh3U87tZYpJBTaCHZRNhtTYi8yziIf6xKcZ/OHPlQghciFzleSQ3CCGZr+8XH2H4F1TEAb17HYh4KBd05i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at; spf=pass smtp.mailfrom=irregular.at; dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b=nKdtovp4; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irregular.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b="nKdtovp4"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f3b39f2a1so1311215f8f.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 15:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=irregular.at; s=google; t=1787178741; x=1787783541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iuMMHjbKJJyWMZllW2/YDxgqwLDnv65cDL/gLe0ScWk=;
        b=nKdtovp4/M6ZjrYPND3jYCHKYOQ+8rZxl23eHZmOulOJCI0IW3P2F69HJNOFxari0s
         VVITWb9CEhz4EWN1zMQrK6AJ/8QxIQ8totdpSE8m6r82GpfGBHW9iK10ybs3J8Oa2q03
         1tZLADICLd+6l0ZlZRNqDd7AyLuclN1ANat2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787178741; x=1787783541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iuMMHjbKJJyWMZllW2/YDxgqwLDnv65cDL/gLe0ScWk=;
        b=EiCBstEwARxECzJukqtqzxWIyJzzw4MqwRTcfrnuZddyedMp6e9ZnKtn4MGhsqdCxb
         dIbOSU30LcBNpwdLnGSQWMyXCXPMR3RT16iEJuUGzfzkrfz8UiSRmqPRr79NhCD0jp3d
         VY0uPxMZWq8EPYh7qYvSK0y6DPFEIVmfRM5lEqDtFwl0CD87qEb01kspzbPeJbcrJFCw
         UW9kDzFs+tjAz7bcxTEe1Ecj8xfq+z1qpdKgt4UEEtxPR7GTCJ7XmdMlnjZYXhdqnnCI
         So8S5p5jeQoii0k3dVbug4BoYDbdT57JmCXddbLMFs0nQlx70acqcsdf8hT1If8Q3NUM
         3gsw==
X-Gm-Message-State: AFuF++nkkDUPAx4A+ZT8c4Bsf5ZwqL/u++LORfcJ2PYmQP/iBHxzrXQH
	zpWrAaV5aqEF4bA4TDlST5+2rkL5IAdBvG13RDUybt3/94u6+HY+VIPzi+hldX7uaw93vpF3OhX
	4ayZBAgc=
X-Gm-Gg: AR+sD13swF16XKdUobI/kvD3/jr2soTy3ZG9kWmTBRfy9JbFf+Bv6sb1I0bjODkjy68
	sDrYNTvovbD2UAf94vKowpzGg8xGEs6rI9uXzMEK+WJwXV0rwqy3hVnPqLmJMyPotNemzdRRVnd
	ioeFERv6RV6rRwqZMDG9IylKIPbhIiywvG7CBzYBxeXIbnlkjTDDFBxNAl8kn2yCJ3lbCl08q0a
	OIhC4G0nPWj0KhRNtYIqT2UR3cwBOf3bAfepiWtSM2ubuDbeDBEktIQTDLOWX2MKyE11QJlkGjJ
	2Sko9w8SMFgxm78xwTaHZ+SHR+dColq+xF5aOYlPhhj45slF2mcnWDkYO+68pCNCWmH66alzWyV
	oJuOpRct0CV1nOO61osx7Q3RJWmUYZ2PBypvzO7XNjRbuWGHVfD3ZqWAxlMCxwTDqDJ2XnXHcpe
	dLHBXQtRCoZW8mL2NJVs3j3OTgiD75XdzqCaQKbvQtJgtok7+TYZ36rfoqDGVohrTQHfq1CFfyg
	SqujU6y7CEAhOeboJwOKplAuG+BhPdPl9NeNzia4sHvZOWjZgqCan8a0ICOG3bgqARcoW4197D5
	P+K0mx27INR7pP8TCS4qbJuLLK+R0LzOvTMtn8gkPnAZIhc+wgzDTfh1oKG2sT9xllSN3Z8PkW7
	Y9GlGaF43QZq6teuHK3XIgdJGX8Vp1imREpQo
X-Received: by 2002:a5d:59a7:0:b0:481:511c:8d45 with SMTP id ffacd0b85a97d-482b1ff5789mr15760623f8f.20.1787178741397;
        Wed, 19 Aug 2026 15:32:21 -0700 (PDT)
Received: from mkurz-macbook-pro.fritz.box (2a02-8388-82c0-2a80-5231-6791-f21f-fc93.cable.dynamic.v6.surfer.at. [2a02:8388:82c0:2a80:5231:6791:f21f:fc93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14cf0a3sm8125296f8f.32.2026.08.19.15.32.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 15:32:20 -0700 (PDT)
From: Matthias Kurz <m.kurz@irregular.at>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] doc: Document component battery objects
Date: Thu, 20 Aug 2026 00:31:42 +0200
Message-ID: <20260819223144.82045-3-m.kurz@irregular.at>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260819223144.82045-1-m.kurz@irregular.at>
References: <20260819223144.82045-1-m.kurz@irregular.at>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the experimental component Battery1 properties, their opaque
object paths, and how BatteryProvider1 implementations publish several
batteries for one device.

Assisted-by: Codex:gpt-5.6-sol
---
 doc/org.bluez.Battery.rst         | 35 +++++++++++++++++++++++++++++--
 doc/org.bluez.BatteryProvider.rst | 16 ++++++++++++++
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/doc/org.bluez.Battery.rst b/doc/org.bluez.Battery.rst
index 5f9c6e7c6..e68c5d260 100644
--- a/doc/org.bluez.Battery.rst
+++ b/doc/org.bluez.Battery.rst
@@ -17,15 +17,27 @@ Interface
 :Service:	org.bluez
 :Interface:	org.bluez.Battery1
 :Object path:	[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}
+		[/battery_{identifier}]
+
+Component battery objects are experimental. Their object paths are
+implementation details and shall be treated as opaque. Clients shall use the
+``Device`` and ``Identifier`` properties to associate a component with its
+parent device and its stable identity.
+
+For diagnostic purposes, ASCII letters and digits in the identifier are kept
+in the object path. Every other byte is encoded as an underscore followed by
+two lowercase hexadecimal digits.
 
 Properties
 ----------
 
-byte Percentage [readonly]
-``````````````````````````
+byte Percentage [readonly, optional]
+````````````````````````````````````
 
 The percentage of battery left as an unsigned 8-bit integer.
 
+The property is absent while the battery level is unknown.
+
 string Source [readonly, optional]
 ``````````````````````````````````
 
@@ -36,3 +48,22 @@ This property is informational only and may be useful for debugging purposes.
 Providers from **org.bluez.BatteryProvider(5)** may make use of this property to
 indicate where the battery report comes from (e.g. "HFP 1.7", "HID", or the
 profile UUID).
+
+object Device [readonly, optional, experimental]
+````````````````````````````````````````````````````````````
+
+The object path of the device containing this battery.
+
+This property is present on component battery objects below the device object.
+
+string Identifier [readonly, optional, experimental]
+````````````````````````````````````````````````````````````
+
+A stable identifier for this battery within the device, such as ``left``,
+``right``, or ``case``.
+
+boolean Charging [readonly, optional, experimental]
+````````````````````````````````````````````````````````````
+
+Indicates whether this battery is currently charging. The property is absent
+while the charging state is unknown.
diff --git a/doc/org.bluez.BatteryProvider.rst b/doc/org.bluez.BatteryProvider.rst
index 2373cebf9..b79cbe6f5 100644
--- a/doc/org.bluez.BatteryProvider.rst
+++ b/doc/org.bluez.BatteryProvider.rst
@@ -30,3 +30,19 @@ object Device [readonly]
 ````````````````````````
 
 The object path of the device that has this battery.
+
+string Identifier [readonly, optional, experimental]
+````````````````````````````````````````````````````````````
+
+A non-empty identifier that is unique among the batteries for this device.
+Multiple batteries may refer to the same device when each provides a unique
+identifier. They are reflected as component **org.bluez.Battery1** objects.
+
+A provider object without this property represents the legacy aggregate
+battery and is reflected directly on the device object.
+
+boolean Charging [readonly, optional, experimental]
+````````````````````````````````````````````````````````````
+
+Indicates whether this battery is currently charging. The property is absent
+while the charging state is unknown.
-- 
2.55.0

