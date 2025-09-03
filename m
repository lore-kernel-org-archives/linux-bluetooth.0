Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5CD3629B8
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Sep 2025 18:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756924970; cv=none; b=knB9+7kOKhZpM1ch9Hi6AVei38EgjHY9q+uFHppXeXSGrngWlskljz6JygrpyV74G3e09kL7r1hIz3D5WVNPOEn4f2fEC2kY5I+prYKwIcYJQZAKbylFqn/9CE0xZRe3SlIK7IU3NKMMcjbr7Aske5adCgmJYIB7qomVTrwqP+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756924970; c=relaxed/simple;
	bh=gKOhczifCfMHqI9ajzhGvNZVqvXrKaEpKIeLf3bD2jE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=maWjAjOW9IZsue1fp4jqv85U7zZiCYIh980r7VNidnmRtLLx1N+z/XcUQuvoOcAeefh4R4LOQ7cj1ZqTzb0Nm8w33LBAxzvZCSoJpTKPNb3/wEsH1SpiLoySlcx1rFo3JdQ2BD+sIOGlUDSWHpssze0RlGzkoawMW5VSJ63zW+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMhA3rn/; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMhA3rn/"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-89a079e01f2so54449241.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Sep 2025 11:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756924967; x=1757529767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uQIJKGuPyclvvJuo6SP660eNEgualtxb2xq3Mqbgtm4=;
        b=iMhA3rn/7qLWWGvU78hAkbWuvpPQVeKGE9sly3NmvCQroDyPQoPC4I5Gm3/aTflrr4
         2gvLA5UBnus2azsKBW4Dcs1+lWr/w7SfcyqkwuMEl+UT4ABdewwfBhcrePQCLr1Y76YC
         /kEKQUc10gDpIGVBJGbEztdE680Bvzp9IRzCtK/g+fX/hKlEaLqoNRTF6PbuRhpv3VzO
         WdONoY1ID64DuXcpzSCi/x2J2LZwrpJKlHpEHFOoMjdmIqYWhI9jdSqw/srvO5rpV9DB
         J1I0LmOolcJz5aA3n5HSUcIkgH18+ZNkxPB43dfyXL9WAsu19ZHmVMr818hO/UCFpbSQ
         0Slg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756924967; x=1757529767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQIJKGuPyclvvJuo6SP660eNEgualtxb2xq3Mqbgtm4=;
        b=g1JmqqGvF6j/RE+Or191XJAiiqImIpYAdM07Op8j6b+T+z2GUajA4SqyePIOoP/h34
         UwEPokmgbLhKoidxqWcgmd2PrFRgRv5CiX/BwvbOQyF7aBZlfYrBAgmorpbX7Cdyyhhy
         ywOmmCn0rTQZl/Sq2dPAm/xbL7KMzhugwE9XTmhU8xAa9pOlM13K0oArY1kngTRta8ii
         IgCeEaBgWl3jrrNgVX6oHVKkK9meA20UQtqiSqwGKEAH/HOPj1wEsD2hg6DwcTtET4ib
         Qeecyt6jjcbTpi/tmJp62sx6rlEeEel6VZtGCVFCp1F1PAI4e+8sb8W+Q2cJrhYYVNGC
         sYaw==
X-Gm-Message-State: AOJu0YyVJ+tf1mzdKRokam71hS/sQs7C+afkaHKmoN2vTb2OIqovv8IS
	LGmUIerHYva90o8/irqLWha4NGZuXvm29fscO39IaCrqXTdqjUbViZFVh1v5xw==
X-Gm-Gg: ASbGncs+nn3t+WwI6XDh1sX7BKf60WN64ko7vLo721yKDa2FxU3DsyhnCEg6GFrxcHC
	QTbAtc5AF9NCgJ1vF6iRNUix21J7fCuszX1oIGg+Xp4o4Wv+xpBozZAAjpMsuapZyFj+rwwx7AA
	dUUiVzun4PydcHp/CV9gZPItA3MSDACpRbUk0TSYacpbrKaBkUyGkcPWEBPJtYojRa/3L3OyU++
	wZKy6nQbcSY0unVxCTOAL4HsdX7nVCXq4t/bmWlZEmojmQM1Klab6lFjMaJ/5ptqOfgkKnnoIZI
	FxQEbhn66OkyQ6Y3DtBEcIGYELIPv6MeUWskDRtMbjFlh/yTjX2Jn+Qsa3+UzYWO8f88NdhYOlw
	ztlyfxjqKpGDMGTw6DZkzqNcg03Hs8dW005tpKfMhxoL+79s/zGXA5UuhZnFmKPol9Kwn/8Nl7B
	SMvYlSsAk6TYomye6XfgcZchkw1SoYIw==
X-Google-Smtp-Source: AGHT+IGhFVYHsEfyAEJgYnGYRZrZJJBoajSN3Uddr+iPWOh1VtPOBodvZNULxBhnu1e73nj7uaHcPQ==
X-Received: by 2002:a05:6102:2d09:b0:519:534a:6c24 with SMTP id ada2fe7eead31-52b1c77c94cmr6159249137.34.1756924967320;
        Wed, 03 Sep 2025 11:42:47 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8943b7c369asm5967636241.2.2025.09.03.11.42.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:42:46 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] main.conf: Add FilterDiscoverable option
Date: Wed,  3 Sep 2025 14:42:40 -0400
Message-ID: <20250903184240.476314-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds FilterDiscoverable option which can be use to control if
devices in non-discoverable mode shall be filtered or not, the default
is true to adhere to core spec:

 9.2. Discovery modes and procedures

 All devices shall be in either non-discoverable mode or one of the
 discoverable modes. A device in the discoverable mode shall be in
 either the general discoverable mode or the limited discoverable mode.
 A device in the non-discoverable mode is not discoverable. Devices
 operating in either the general discoverable mode or the limited
 discoverable mode can be found by the discovering device.
---
 src/adapter.c | 4 +++-
 src/btd.h     | 1 +
 src/main.c    | 3 +++
 src/main.conf | 5 +++++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 549a6c0b8324..dc5ba65d73fa 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7239,8 +7239,10 @@ static bool device_is_discoverable(struct btd_adapter *adapter,
 
 	if (bdaddr_type == BDADDR_BREDR || adapter->filtered_discovery)
 		discoverable = true;
-	else
+	else if (btd_opts.filter_discoverable)
 		discoverable = eir->flags & (EIR_LIM_DISC | EIR_GEN_DISC);
+	else
+		discoverable = true;
 
 	/*
 	 * Mark as not discoverable if no client has requested discovery and
diff --git a/src/btd.h b/src/btd.h
index 18a5eb88696a..5c952bf17956 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -142,6 +142,7 @@ struct btd_opts {
 	bool		refresh_discovery;
 	bool		experimental;
 	bool		testing;
+	bool		filter_discoverable;
 	struct queue	*kernel;
 
 	uint16_t	did_source;
diff --git a/src/main.c b/src/main.c
index a542d0fc50b0..6bb3bb8adb3e 100644
--- a/src/main.c
+++ b/src/main.c
@@ -91,6 +91,7 @@ static const char *supported_options[] = {
 	"Testing",
 	"KernelExperimental",
 	"RemoteNameRequestRetryDelay",
+	"FilterDiscoverable",
 	NULL
 };
 
@@ -1062,6 +1063,8 @@ static void parse_general(GKeyFile *config)
 	parse_config_u32(config, "General", "RemoteNameRequestRetryDelay",
 					&btd_opts.name_request_retry_delay,
 					0, UINT32_MAX);
+	parse_config_bool(config, "General", "FilterDiscoverable",
+						&btd_opts.filter_discoverable);
 }
 
 static void parse_gatt_cache(GKeyFile *config)
diff --git a/src/main.conf b/src/main.conf
index 86759d53c1f2..55618be5c923 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -148,6 +148,11 @@
 # The value is in seconds. Default is 300, i.e. 5 minutes.
 #RemoteNameRequestRetryDelay = 300
 
+# Filter out non-discoverable devices based on discoverable flags (General or
+# Limited).
+# Defaults to true
+#FilterDiscoverable = true
+
 [BR]
 # The following values are used to load default adapter parameters for BR/EDR.
 # BlueZ loads the values into the kernel before the adapter is powered if the
-- 
2.51.0

