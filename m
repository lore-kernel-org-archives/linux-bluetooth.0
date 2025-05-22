Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8A918EFD4
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747934998; cv=none; b=tWlCZC6OwsGQmdsag9LiOYbneRXzqViIVHAEvbf6uLPNLjQE9CHj8P0ek+BnXfDxXPkxqy3ZTkBDRyqE3H+khJwLjRjd3skNBGRlxCCwsBd0gc1IC3XVBhQPzbNmPrOEjJpmp9gIzf5L5TBDEvrj2QsSCzLX/jcQ+3cJKRglydY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747934998; c=relaxed/simple;
	bh=FEii0TmmwgHnUUUTsuH0CL1vMg0ZA4wGA2CELBu6mbM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HE+RBwF2WIOr8w0NhxNKkIa1xEDzpkExQlg6hpSJ6qh7RVQzlRDpTkMm01m40pbAvriOJo3YSAQDfu44bJyQw7HZy+z1d5THWgPb+tJ9Wj/WcMYpMeZ6PhazCwwiQIt35QcIq3i45zYH6GEss14Dib/K8/xs1r6ejUWd9qY1TSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nao1+t+y; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nao1+t+y"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5240b014f47so2723034e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 10:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747934994; x=1748539794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=T78sAGZml+VrZv1K0gsSbOmWw8dQPoEVSBR0LIlFhcE=;
        b=Nao1+t+yruI/ewt7DTaZ08SyyMv71CYDXEDs9lD5J81RlVnVd/Ob4ia33siNPIwPkM
         2PpXumOBh1x/y7bb2u88uinny5+Cd7qwpGP1th2wMT+K1XqpHvbaQCchxjMNpvnI8lVN
         DzrA4NyTPT8LT8essXBGsaZzxTpRgrj07f2Wag5cmbKNTrhdCBkn8iRqX8GoUsr9bj6m
         /yCw/vaUZ916yuU3KmyBL7QNmTxeUiuT+s68rL+crb4KRgqm4o4e8mQ532EIicxy26nb
         XtqS89Yp+2SVTJ7sGNYrUnIFpuPzbV+ilxf5JZm5tWWLzahhadJ55xPFyouiYmwZXuSi
         39+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747934994; x=1748539794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T78sAGZml+VrZv1K0gsSbOmWw8dQPoEVSBR0LIlFhcE=;
        b=Pah3uj9pjVnoD3/ODsVCq6SdK7IesPs1S3USc3X+fNDLfOCznw39LtJuv5UOqxdW75
         RmcVWyOZ6sOW0whwMlayEkT3oy2rqclNT5rtDazu/Hi4SjDPDS2cnBxMdV2kgVQa4J2c
         Lege+xLMYLr+L/fJUCDuk3d4GQhgjpYjfvFQIhhpsX4L12Au20v+VEzB6XYt4RSz6pbN
         j193S0JzlJHC21U1nyEkafw4uk7JQfX4FRjE/IB2WrQ7by6fK3BA0FiyYZX/qqODAYWW
         FZ+hW5XBxt3gToJJkgLoD1fDXGSGx4eQ4/sPzkeGJCM2gC5St1YhMsv5A46OVVpa0Kzj
         /8yQ==
X-Gm-Message-State: AOJu0YzHxEiRecB2JVOORv+j+vYy+jJSoZ1p5XKDHJb72nFn0Ne91D1y
	raXHMF/C7MzYeUGb2ZuQ4NIF0LN2hddGgUgtaE/y6WkUyNF3XAY+vBINPmQFL0Ge
X-Gm-Gg: ASbGncvxffxOeOuR+lZU1ujVpXUpiZkUJtqsfMFYaZNE7DPPIfrxEefnLRUG/YMnSaZ
	p0K0BfZcyqEPPxHvUy0OJW+JO5Z8hbwajPS0x6Isk/Ly0LJTYJhl3/scfMtHnhVbw7GcK+YgOLj
	2XV3OAC1TYc1E6zXLfZSHFu9KysJLJSLqZKW3V+3w+T9c47xjLdwSeJ60Wggpy0QQuo7+cthSIS
	i7YkRoBXqLg3JM8QR68arrbf2wV+4O08sywEkddHqeF8bErZhbs4GCVk7ISiuuvjwAntLNM5e4E
	8xw/qWRhzgOThBF9G0b0z/NCnB8SO4taXKpEHP1SGXSK+c9MJ2DjSneWOpnyVVNTuJzVzupiW4+
	oEl4aIrknVuv1Ti8CUDYu
X-Google-Smtp-Source: AGHT+IG1/Rg/eUQeQA5YC27JzHPp45KuA850KXtCUEUr9nbl77PhnVNtPplwFcZ3Q6zB1i0t3ZY4DA==
X-Received: by 2002:a05:6122:caa:b0:520:61ee:c815 with SMTP id 71dfb90a1353d-52dbce4a585mr22337034e0c.10.1747934994136;
        Thu, 22 May 2025 10:29:54 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52dba91076esm12220321e0c.3.2025.05.22.10.29.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 10:29:53 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/4] org.bluez.Adapter: Add AutoConnect to SetDiscoveryFilter
Date: Thu, 22 May 2025 13:29:49 -0400
Message-ID: <20250522172952.3312270-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds AutoConnect filter option to SetDiscoveryFilter which can be
used by application to automatically connect devices found matching a
pattern.
---
 doc/org.bluez.Adapter.rst | 42 ++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/doc/org.bluez.Adapter.rst b/doc/org.bluez.Adapter.rst
index 021e4f8e5a9f..c5b8ed8e9132 100644
--- a/doc/org.bluez.Adapter.rst
+++ b/doc/org.bluez.Adapter.rst
@@ -150,29 +150,35 @@ void SetDiscoveryFilter(dict filter)
 		that don't set any pattern as it work as a logical OR, also
 		setting empty string "" pattern will match any device found.
 
-		When discovery filter is set, Device objects will be created as
-		new devices with matching criteria are discovered regardless of
-		they are connectable or discoverable which enables listening to
-		non-connectable and non-discoverable devices.
+	:bool AutoConnect (Default false):
 
-		When multiple clients call SetDiscoveryFilter, their filters are
-		internally merged, and notifications about new devices are sent
-		to all clients. Therefore, each client must check that device
-		updates actually match its filter.
+		Connect to discovered devices automatically if a Pattern has
+		been set and it matches the device address or name and it is
+		connectable.
 
-		When SetDiscoveryFilter is called multiple times by the same
-		client, last filter passed will be active for given client.
+	When discovery filter is set, Device objects will be created as new
+	devices with matching criteria are discovered regardless of they are
+	connectable or discoverable which enables listening to non-connectable
+	and non-discoverable devices.
 
-		SetDiscoveryFilter can be called before StartDiscovery.
-		It is useful when client will create first discovery session,
-		to ensure that proper scan will be started right after call to
-		StartDiscovery.
+	When multiple clients call SetDiscoveryFilter, their filters are
+	internally merged, and notifications about new devices are sent to all
+	clients. Therefore, each client must check that device updates actually
+	match its filter.
 
-		Possible errors:
+	When SetDiscoveryFilter is called multiple times by the same client,
+	last filter passed will be active for given client.
 
-		:org.bluez.Error.NotReady:
-		:org.bluez.Error.NotSupported:
-		:org.bluez.Error.Failed:
+	SetDiscoveryFilter can be called before StartDiscovery.
+	It is useful when client will create first discovery session,
+	to ensure that proper scan will be started right after call to
+	StartDiscovery.
+
+	Possible errors:
+
+	:org.bluez.Error.NotReady:
+	:org.bluez.Error.NotSupported:
+	:org.bluez.Error.Failed:
 
 array{string} GetDiscoveryFilters()
 ```````````````````````````````````
-- 
2.49.0

