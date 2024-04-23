Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7031F947
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2024 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713912371; cv=none; b=BAfYl73TxDNoP5Pjb6fH6z1sa4ROkb3RRpmMwjeNRd8cxH2bgPygx6eGCgF52gmHxqMX0EMwjKUT2fqoczuvhtI5D33yg0IJ/AINd2yB3cWyWh9Zya4XOu/zKuUz/RgHbKWAV8CpMv5MpR5gxvVd5fkDAjny01xRTc029XiyTjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713912371; c=relaxed/simple;
	bh=hGv6lpur6yHGzPm2teF5ClJLw+Pt7IwH2iVPlsyny6U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMqwOL83/lyxEgfnRgiOJ0BXlNh/p/oWFtvDcC655Dyl2ck8eNrjdTadG7rpivRtf4funDLC6wAx+pjSmCtg7MPSUUvumBXQ7wqL1agyoO7yG0MFISdVRrDJ39RHkAVw6sWlg6xQlIHXUTM4OJIRz+cC64lD6IAhvQde6I2NO1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8fnh2jP; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8fnh2jP"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7eb89aa9176so1859571241.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2024 15:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713912368; x=1714517168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f1TV2ozXrfwimFjaiULTv7hkVmhN4GQs0KfbR61aHnw=;
        b=U8fnh2jP1f180y44do1t+nD16AssnJVSWIhOCp0ubjYm/3WUdCjVWZUyDvXl8JgBt9
         hBV1umDO0l/SlInU7fQp1sRmLeB+0CUBH+iiMZwKFYol4UMYtkbsMKs/eklfn5roxyiP
         Blr2NacT+mebNVWms2Kty5TV1yRL5b8pywEvR0dfX5OZPmsBFnzRI7xfodTSJX69JE2o
         5pJT5eP9wOeerqSaHhSbpwm08t2DAzPbV0fPLHHZawpyJHhQcE7qvKJWVCodM+QSwV6Y
         rYoVcL0Tzsl7UCebXi2wSztPjZk/z7gam9ZBFC8u/LrDpcm4hEYFfCDiHl0+hFGfravr
         gLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713912368; x=1714517168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1TV2ozXrfwimFjaiULTv7hkVmhN4GQs0KfbR61aHnw=;
        b=VAaF7Cn+b4C75Awgr+39xwOZe8w5HbfdX6wEv6Hp4udjap1nuJEtUSKvDHgPWRTCx0
         iXong9kVc7rYe7MrtA69b+f5GRH1A2GXpRqHLsnE9g1ASScl4NsmkkqNwc2Jgky3nNqO
         hJb7J99kvyMEcvVo/QA59d0trTzfUP+RitcGIyRQGO8DnKKzKeAayds+3mzurnJot602
         yn7SGMmGGLKWwUCz4EntVuaxO3nGrI9+Bx7cmoibG00UG/+ptA5o0frWP4UwQMV+w1gy
         GfWJQYjpR6h+ieFHisp31lVjQiHlCIbg5shajka+RidfNHoRP0wYTKyAidoIt/aSx5DS
         qK/Q==
X-Gm-Message-State: AOJu0YxFyd2maRn5jbif+L+TjEyi1KOsRSAptWMJLCXD2cULeMqLTkqf
	cF4EsJVHc3vrUX/BgQOrCPO8eQUvVgJtd9vXbtzbVkZW+5uHQVbur5UsTQ==
X-Google-Smtp-Source: AGHT+IH3lA28XZKT2Xg6XuWTVnTjuOfZrKRXR2QtF0VobnIYPlkzhb2LcdHIvHNMAT67FyFf2AFtwg==
X-Received: by 2002:a67:e441:0:b0:47b:c963:3f96 with SMTP id n1-20020a67e441000000b0047bc9633f96mr921909vsm.12.1713912368261;
        Tue, 23 Apr 2024 15:46:08 -0700 (PDT)
Received: from lvondent-mobl4.. ([107.146.107.67])
        by smtp.gmail.com with ESMTPSA id g20-20020a05610209d400b0047b8ee9674dsm2196056vsi.1.2024.04.23.15.46.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 15:46:07 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/3] main.conf: Add support for testing interfaces
Date: Tue, 23 Apr 2024 18:46:02 -0400
Message-ID: <20240423224603.2124790-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423224603.2124790-1-luiz.dentz@gmail.com>
References: <20240423224603.2124790-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for D-Bus testing interfaces and testing profile
drivers.
---
 src/bluetoothd.rst.in | 9 +++++++--
 src/btd.h             | 1 +
 src/main.c            | 8 ++++++++
 src/main.conf         | 4 ++++
 src/profile.c         | 6 ++++++
 src/profile.h         | 5 +++++
 6 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/src/bluetoothd.rst.in b/src/bluetoothd.rst.in
index 7a0fa1b24469..0b998f621595 100644
--- a/src/bluetoothd.rst.in
+++ b/src/bluetoothd.rst.in
@@ -64,8 +64,13 @@ OPTIONS
 
 -C, --compat        Provide deprecated command line interfaces.
 
--E, --experimental  Enable experimental interfaces. Those interfaces are not
-                    guaranteed to be compatible or present in future releases.
+-E, --experimental  Enable D-Bus experimental interfaces.
+    These interfaces are not guaranteed to be compatible or present in future
+    releases.
+
+-T, --testing  Enable D-Bus testing interfaces.
+    These interfaces are only meant for test validation of the internals of
+    bluetoothd and shall not never be used by anything other than that.
 
 -K, --kernel=<uuid1>,<uuid2>,...
     Enable Kernel experimental features. Kernel experimental features are
diff --git a/src/btd.h b/src/btd.h
index 8c80059ac1d8..383bd7c19600 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -128,6 +128,7 @@ struct btd_opts {
 	bool		fast_conn;
 	bool		refresh_discovery;
 	bool		experimental;
+	bool		testing;
 	struct queue	*kernel;
 
 	uint16_t	did_source;
diff --git a/src/main.c b/src/main.c
index 78831ad02520..23af6781d931 100644
--- a/src/main.c
+++ b/src/main.c
@@ -87,6 +87,7 @@ static const char *supported_options[] = {
 	"TemporaryTimeout",
 	"RefreshDiscovery",
 	"Experimental",
+	"Testing",
 	"KernelExperimental",
 	"RemoteNameRequestRetryDelay",
 	NULL
@@ -1034,6 +1035,8 @@ static void parse_general(GKeyFile *config)
 	parse_secure_conns(config);
 	parse_config_bool(config, "General", "Experimental",
 						&btd_opts.experimental);
+	parse_config_bool(config, "General", "Testing",
+						&btd_opts.testing);
 	parse_kernel_exp(config);
 	parse_config_u32(config, "General", "RemoteNameRequestRetryDelay",
 					&btd_opts.name_request_retry_delay,
@@ -1344,6 +1347,8 @@ static GOptionEntry options[] = {
 				"Provide deprecated command line interfaces" },
 	{ "experimental", 'E', 0, G_OPTION_ARG_NONE, &btd_opts.experimental,
 				"Enable experimental D-Bus interfaces" },
+	{ "testing", 'T', 0, G_OPTION_ARG_NONE, &btd_opts.testing,
+				"Enable testing D-Bus interfaces" },
 	{ "kernel", 'K', G_OPTION_FLAG_OPTIONAL_ARG, G_OPTION_ARG_CALLBACK,
 				parse_kernel_experimental,
 				"Enable kernel experimental features" },
@@ -1410,6 +1415,9 @@ int main(int argc, char *argv[])
 	if (btd_opts.experimental)
 		gdbus_flags = G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
 
+	if (btd_opts.testing)
+		gdbus_flags |= G_DBUS_FLAG_ENABLE_TESTING;
+
 	g_dbus_set_flags(gdbus_flags);
 
 	if (adapter_init() < 0) {
diff --git a/src/main.conf b/src/main.conf
index 49864b5c35f5..bea94640e627 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -126,6 +126,10 @@
 # Possible values: true or false
 #Experimental = false
 
+# Enables D-Bus testing interfaces
+# Possible values: true or false
+#Testing = false
+
 # Enables kernel experimental features, alternatively a list of UUIDs
 # can be given.
 # Possible values: true,false,<UUID List>
diff --git a/src/profile.c b/src/profile.c
index ea188f36b6dd..c62224af9dd8 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -781,6 +781,12 @@ int btd_profile_register(struct btd_profile *profile)
 		return -ENOTSUP;
 	}
 
+	if (profile->testing && !(g_dbus_get_flags() &
+					G_DBUS_FLAG_ENABLE_TESTING)) {
+		DBG("D-Bus testing not enabled");
+		return -ENOTSUP;
+	}
+
 	profiles = g_slist_append(profiles, profile);
 	return 0;
 }
diff --git a/src/profile.h b/src/profile.h
index 6871f2f0d7d8..424ce55ad657 100644
--- a/src/profile.h
+++ b/src/profile.h
@@ -33,6 +33,11 @@ struct btd_profile {
 	 */
 	bool experimental;
 
+	/* Indicates the profile for testing only and shall only be registered
+	 * when testing has been enabled (see: main.conf:Testing).
+	 */
+	bool testing;
+
 	int (*device_probe) (struct btd_service *service);
 	void (*device_remove) (struct btd_service *service);
 
-- 
2.44.0

