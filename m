Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323093542C5
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810603; cv=none; b=UVZtZ8s0SPzZGXO3/lc4MiqnAfPLtMWbLc9kQoWqbYIIFkYtXsdKImXIDYwWtWy55ER+7hecU/8oH7ORc0Xf7WPsXuGXM9u4odwKFFRM01BNLyHHNJZZnmFLiTfnGQVKnh0JKLqTtnIfLtet6GlsKLG4veZ8ozSc894QIcQ9ax0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810603; c=relaxed/simple;
	bh=4+WlYpWqZMC1EFSaVmltcR2KRHYaADccCW1Yr6u+WIk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQvrXz0uWEYWmGjUImnN6vAMjzXIzHF9CPm9DVkrPE1A2Tkj0mGvW5c45UUszJT6bUnHb6Glzj83C4m2YHZCecwtfBa1psgmw+Y2CyuH3pTkXFde7kqG6hPAr2qU2ZUEXbS4i5bss0yoyDBkG+EghmlCp8c2Vtp2FEth+PypWFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbgYmuWT; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbgYmuWT"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56637565faaso2097429e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810601; x=1770415401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AuD9R5Yu8WdB1Vcj5aKKlpgIDYVmgIgkC3ePDVluN5Q=;
        b=IbgYmuWT+IO19g+wnSyIputBzyroiP7Gbf8ipakexnvbV8P7Ki7qQwjClyz/0JpAOH
         xSBa2M06HtFwJiuriKHM1Zzok+5Q9H7L0xVpRITrMPeC28dyuV8eGfBNEY1Enx4Vp4rn
         x8Oie6Cd3zWhSfu2Vgr5Tr2XHZdE6wIIFogTqlUC9tMzlNei/VEBQHDxB4FG0JKqaYrE
         aHvpCtm61pBqaHuhXugZNQdfFq+cY6OS8AmB50GZS2sJClUhhvqxgm4Tl2DfR6dEvxDo
         YdXyFeVZCbboc9iRh+sVUZmlR14Sm2wkO7291L84dwu1fk0QsWSJumn+A5DEywpFCXAn
         QdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810601; x=1770415401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AuD9R5Yu8WdB1Vcj5aKKlpgIDYVmgIgkC3ePDVluN5Q=;
        b=iPMqNlP04uADj0CZtA0SjPcMVAfLjBCCkZ1qgLqHNwKb871IHMj1flCdyP7WowiAx2
         bcqfDRo/1rEwjr2N4IzgJLpqtyTWSjGhKae3/YRpKxTy20RD+8HhWsFJlPDg9PQF5fin
         juyMTV7BorpveMIrqS0XkXWVX+0KQvL4Py8Qqd4MeEtxM7bSQbDjKedrP5LxiPowqdEK
         xpql4jSfT63UnLF8K2Ao4Ex4Y3mAiqtT3+BrqOfp/txtgVXrJJyQLs+2dyMpWMZRaLHG
         Brkx2+PIlMuYWgMqBz3fycn4OzgWR/koOQJsZyEC9gkoDb3awO7ohloMejxK1+p/4T9y
         ctZw==
X-Gm-Message-State: AOJu0YzFnDKj3sOxEfptLdj0CS3Oprq/l2hlgPN2RwEZvTjSNBC30LPk
	+ZGTd/JRRpfYVhhFofD8RijTz4XlIay9q7qVUI2A2AvG1mtJHyNhwJC5PioNig==
X-Gm-Gg: AZuq6aL0L4SD5AUHl+qwEiwQ/2yaEm3cmCpKF9ytHZsTkr0mxbf7cqJ/uge9ySSWM/9
	aRWijjPLfH+tumesww081SxCE7Ht8zlU7xhe6yjZ4a9O+ZLlnZIwGB0GRuAYGEnXS0GtFA20kLJ
	VW4nHijpVzSjwamNc+nfNap0qpDUZiAGBPJEPEdrFJ7u7lCNKE7mMStZtj+/FeDXsnU7zrdbH0D
	OnU6QMrpcMgyFrfBS8N4YF4lIc6vX1cA44fcNQXU49454AqiXGggDHsgB866GNAQrEQOV0tqojP
	VF6EvRXtK/4f1ilJOd5blhHZ3PYU2nJ+d+hMAZmddfxgkqCn2d/QGDnQkMy8ML+cw81MYLyhzDi
	uSgPnT1tkM0bqMfhx0jnDS1DlPeWlXCnyBEYGu9wp24bL3ODSouwIu8A/Xlt7fkCdnUWzDAbIkb
	5QJ6rAk7NoGWEBZCIyoS4HD47TPTsbAGRsqKY96gYNeTwYdyCVJc8frkojyUE8Uim/4ildMIVLl
	4vNYQ==
X-Received: by 2002:a05:6122:130a:b0:566:3548:815c with SMTP id 71dfb90a1353d-5669ffc970dmr1544479e0c.1.1769810600975;
        Fri, 30 Jan 2026 14:03:20 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.03.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:03:20 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 34/37] doc/org.bluez.MediaTransport: Add Used by reference and Examples
Date: Fri, 30 Jan 2026 17:02:25 -0500
Message-ID: <20260130220229.1346261-35-luiz.dentz@gmail.com>
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

Add :Used by: field linking to bluetoothctl-transport and Examples
sections showing corresponding bluetoothctl transport commands.
---
 doc/org.bluez.MediaTransport.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransport.rst
index 3d1e8c5b5a40..81cf9e4da572 100644
--- a/doc/org.bluez.MediaTransport.rst
+++ b/doc/org.bluez.MediaTransport.rst
@@ -17,6 +17,7 @@ Interface
 :Service:	org.bluez
 :Interface:	org.bluez.MediaTransport1
 :Object path:	[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}/fd#
+:Used by:	**bluetoothctl-transport(1)**
 
 Methods
 -------
@@ -31,6 +32,10 @@ Possible Errors:
 :org.bluez.Error.NotAuthorized:
 :org.bluez.Error.Failed:
 
+Examples:
+
+:bluetoothctl: > transport.acquire <transport> [transport1...]
+
 fd, uint16, uint16 TryAcquire()
 ```````````````````````````````
 
@@ -50,6 +55,10 @@ void Release()
 
 Releases file descriptor.
 
+Examples:
+
+:bluetoothctl: > transport.release <transport> [transport1...]
+
 void Select()
 `````````````
 
@@ -68,6 +77,10 @@ Possible Errors:
 
 :org.bluez.Error.NotAuthorized:
 
+Examples:
+
+:bluetoothctl: > transport.select <transport> [transport1...]
+
 void Unselect()
 ```````````````
 
@@ -84,6 +97,10 @@ Possible Errors:
 
 :org.bluez.Error.NotAuthorized:
 
+Examples:
+
+:bluetoothctl: > transport.unselect <transport> [transport1...]
+
 Properties
 ----------
 
@@ -139,6 +156,10 @@ Possible Values:
 :0-127 (A2DP):
 :0-255 (BAP):
 
+Examples:
+
+:bluetoothctl: > transport.volume <transport> [value]
+
 object Endpoint [readonly, optional, experimental]
 ``````````````````````````````````````````````````
 
-- 
2.52.0

