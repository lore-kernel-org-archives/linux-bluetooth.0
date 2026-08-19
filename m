Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD533371D10
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 20:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787172032; cv=none; b=NMl2D4albM0XTeD8GKIX2oC+43/u0T4tbMApDLzBqFSV6oih8dDEe1tqc3rCj36O+AcV/NclSpdWUZ6LVeIel5LzwUpLSZJiNaogYKR1ZcYiYnQlseFQaEtnOvUeyn4iJBDNPpVodjY2tvJOgCnDpq8/upI4W4jONxGLoyEunLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787172032; c=relaxed/simple;
	bh=UZexpsVgJWH+MSGm7ckXdN94jfxuvsoDQHlJCjHWRjU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EO2EmpsL5a/8tVwlBiV+Z/hAE9PpFVmGNj7ZSiZpW+HDk+chtewcS8zkp6BdwCycwf44y57bwMXSDx78MjhxT/6VlCAoMcka9Gm4QXybDl5ywfZdbuwyXyje3ohvUcw6/ILIDOur8S1MIQSLfNMOl7WuL99VmbbLS9mz6N0Lvow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdoqEtk6; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdoqEtk6"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5c2ae02f69eso1142834e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 13:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787172029; x=1787776829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/Sk3Cim+mY+syRWvGmQcz+ZIKAoU0Mbr6TXZR+FTlUM=;
        b=hdoqEtk633UcdvBF/cL2eBrnATxe+uQkBM/GuN0c1HuQDoMv1x8U4qyizQrxCnukVA
         2PrXOG2XGfa9+Kfwc2TmyE1Se2BY81Gmt+0i3eXGhVrZCw1B78evwxqwavUjP4bth3Pq
         8P8qHjpPCM5NSy4ldjbnJgdu9zuZK7xbpxm7oGatYGniYTgPsCRlqlDjnT9s+dilQEg3
         O4J/YbT0YC7UFYTp+biqSVNT5mKgSYwmtOJM40sy8k3oGrfZwQPASUAjIADHuiC6Ou+K
         XLXU9szbGVT83iU3DGE7cQkQfT3fKBFQcM6Zl2T4euq6uaTmAq2WnboTwhH+hIjx0+rB
         eelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787172029; x=1787776829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/Sk3Cim+mY+syRWvGmQcz+ZIKAoU0Mbr6TXZR+FTlUM=;
        b=RKfifXje5NukRqTRWYTbMTQCYs3VmdhwATrFDuKt+mex9BkWQKeFm2ypd1wgD2HLtH
         hI+jbc96Crj7ZjIiGPqJRQ+f6vpI9Q1dGes9ZQUDgn4c7GbrirK8RbP7NeG6IHDwwVii
         fjgTJMuzDIB86caHlxCtY6y9Hx4ONNV36rPpnCzZ37OX2pq0OhhFHGwzqVjwlHZbWWHD
         GZYJ5hSFA41t38yPZEEz5yPRwgM5DrTbnUn+AXjl8vPbcFQklluPQfzYFu2U6c2po4af
         XfcDtT2X9unI1QlPyyxrmzSDkirw1t1DejVIMq5UsSUlKEFETzmSyDVsVo4KVG7UKDV3
         Ymow==
X-Gm-Message-State: AOJu0Ywmdob1nxlC4Z2JBnOOdR+9ZtyXkCpkG4j7m/6TXcpvJBshk7i4
	w2OjbncLp/h9vJE7XoUD4nvATB095El2vJ/hyj7qwE/XdKCQRcUCseauA+g3i7CpZxalTg==
X-Gm-Gg: AR+sD10ivWOBj8Mxsodlt1h8A1ZNOZJ12MKLj+CyRHWijx9p9uiw3ULL44xS10MIDwg
	LNZt/OSL3aIVY4/g48FxSeJA0KTfo5gw6Wd13RP1WFcZMf1nLgsDgLZpUuKpah7DNm0me0sU7pY
	p6A9G6m/+CzMzth7fhZZwaHje7H1nXxXmt7Iccb+je42bYDUN0AQ5dhJJzcLw+AbxzZer26Yv0B
	nc3KnuCMTgUW+tcsXjLVd5sb94SWCtt64K9tBO3woiprOZgxi/qGo1cbsDnV5SZ9/Qhypee6hps
	ETgLDfMrWGrEo22MvFLsioFwgNJlqdsWAvr/aW6DQG8vVOuG4ZQTTjbdUEHsYpuTFrbWpu3GZz4
	947f0gRg7aZOvKOeqnFdmd+ZK65OZmX10WDyXZRuK8/FwxGJT1XN9lUyJUSbepj4MAo4mzhfBXM
	aDFlVHBmAi26CraXYJbMZ4hynS0SfNCwk9zrFqaGG2cyRJv2YpF9Y3zjKRNwhDWCzZaXq9++eeq
	JD1UrUTAiQ5g20rhkTG5T8Yr4x0S5rrgcLJtMbjs1Xe5KOPwxLXVdYT
X-Received: by 2002:a05:6122:e253:b0:5bf:5edc:9aa0 with SMTP id 71dfb90a1353d-5c5e3dcc01cmr3294735e0c.7.1787172029069;
        Wed, 19 Aug 2026 13:40:29 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e2486864sm3496404e0c.0.2026.08.19.13.40.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 13:40:28 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 6/8] device: Fix the name truncation splitting UTF-8 sequences
Date: Wed, 19 Aug 2026 16:40:06 -0400
Message-ID: <20260819204008.2292225-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260819204008.2292225-1-luiz.dentz@gmail.com>
References: <20260819204008.2292225-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

btd_device_device_set_name() copies the name with

	strncpy(device->name, name, MAX_NAME_LENGTH);

which cuts at 248 bytes without any regard for where the UTF-8
characters start and end, so a longer name can be left with a partial
sequence. The result is no longer valid UTF-8 and D-Bus rejects it when
the Name property is emitted.

A name made of 249 U+FFFD characters is 747 bytes long and cutting it at
248 leaves a trailing "ef bf", two thirds of a character.

Truncate on a character boundary instead. The same name now ends up 246
bytes long and stays valid.

This also means a name that is not valid UTF-8 to begin with, as can be
had from the neard and sixaxis plugins, is now cut at the first
ill-formed sequence rather than passed on as is.

Assisted-by: Claude:claude-opus-5
---
 src/device.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 65d84be56ca5..df607f718be1 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5103,12 +5103,22 @@ char *btd_device_get_storage_path(struct btd_device *device, const char *name)
 
 void btd_device_device_set_name(struct btd_device *device, const char *name)
 {
+	size_t len;
+
 	if (strncmp(name, device->name, MAX_NAME_LENGTH) == 0)
 		return;
 
 	DBG("%s %s", device->path, name);
 
-	strncpy(device->name, name, MAX_NAME_LENGTH);
+	/*
+	 * Truncate on a character boundary, so that a name longer than
+	 * MAX_NAME_LENGTH does not end up with a partial sequence, which
+	 * would no longer be valid UTF-8 and would be rejected by D-Bus.
+	 */
+	len = strnlenutf8(name, MIN(strlen(name), (size_t) MAX_NAME_LENGTH));
+
+	memcpy(device->name, name, len);
+	device->name[len] = '\0';
 
 	store_device_info(device);
 
-- 
2.54.0

