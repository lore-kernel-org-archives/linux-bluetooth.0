Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FD4374190
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023872; cv=none; b=mhPm5UhH4DzP3NnEeuwEAZ3Gk/F1Y1+IWYUIQyOw2n0Y35gknTzEQVQQ4NZdiEvifl/LrC4QeoV6hq3pDw9CcYm1zTAUjlv8LsQNcR1Jpmfy5gXChY5uYIFPLfDDyMZX/ZiOrULxNWyhw6o1Nq7GtSYaEEBT/o3Jmsfi7r9uFHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023872; c=relaxed/simple;
	bh=xJ+snH1B5vVVd9arDy88kq2UBIDPs3PRnOCTCL9q68w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mu6ks0NRGKBMM+rB1UWaSM7tGX1hSdahnnI01gD/7Xlwzqe10jvq3wtZNg+V/Jc0fhZ4KmHolE53SLdvH8EtwzgvioPo5ZP8B/vrgOWMpIu3Ur9FRvK7Sh6QfihwuuX1ObRO9FEIG/RII1U3zvNkC1zJElCpVLj1hl/9O48XuWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hA4qvWtX; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hA4qvWtX"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-59c2a81ca92so3326417e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 09:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781023870; x=1781628670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a6Nq9JyXRsgg/9mUI4Xcc6SR2whA3Otg+agVt60lnGw=;
        b=hA4qvWtXBpikQ7MySBJGmI6KeEH1e7QPrC6/eCTSFAYwegCfCavrM1z8D1ZH27GMrI
         WdlinF/ADsUlSPkfKNL0sxl4W9qhITW3Vt2yu2Wdf/kruvb1bg5zQ65wyPmeaZit8YrC
         NwtsxRq0M0xR9XPpY9xgwh+yvIrZg/8TM3JxpgIFN92gHN01Dx6P6CsyO8w0EsEvrmZe
         jVVVVjMlsta/JkQSEVRQ3/xmxDHXZxUhHE4xPjf6NlwOedDz2qT4s7q5pDjL5UI5Yt1R
         Y1DbDqhGGYSE0OL6HfzRkBKYI4CrhHLcpUNiPMkOTLUAdWNUs9axtM67HDbwbc530Zbp
         ahFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781023870; x=1781628670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a6Nq9JyXRsgg/9mUI4Xcc6SR2whA3Otg+agVt60lnGw=;
        b=NvoD5NvAl3ieuYfAwhDof47q+IqaoWNQ5UvB3ZUzayTJuZRRgLR7yFtA1QBvsrZwMu
         soUemeQbHGQQlmaci76LE9d+aMKpaq0UK6BbeFfNZhnD8NWBj+O9j6Dq/vP9wNVln+gS
         LliAQSBjuyQBiFacymVpVOzDBw2i3gkVVR1Qw7Qy84yDXWBjL0Im0GGpCXu/sZHcL13p
         qdUWEOdddYcJ/em7gN/fg2+3UpbsRtRJoc3TRsM7FzBIvj5+kyKHvIfxvb344GwiDOAz
         xU1HTHlgQSxvUoYsmaQ+wnVUGbxkLW7EPC1CJLohy+sF3Ha7byETXB9cObj3pafOUYhD
         bzLw==
X-Gm-Message-State: AOJu0YwvdRAqXx7rpe93Cp8/yOaqZuvyxumQWT5MUqswkrhjdUhaqMd/
	cDTxn5eD4fqAvlRdzxh7xav+/iQBqy3kq2wcBl7esGWeCd4egVsOs2UcmXq5Rg==
X-Gm-Gg: Acq92OGdGdsZLTUjypyObcGuiGp0+4c0ggPBTjqTbnteFykQq52EDZDsNgSENOVLXMR
	CxVAp0dQmJSvtpMqNuT7bG77gCGPA6WgwHbYGfPOyJscTL26qN6sSdr3+2gDwxIJmLHDmU3s6NU
	wqa0c/lk5QAk2iXHMv1PVS38y12ldoum2nnO2AVhVyhO3XLvNwcUE27/C5XXDD5QX0GTrA4rUEq
	ibxSv2dM0X6+Cip+oDmWbdgenBxph79aDVmQPpVsfLqMZ3Efb9aSk9MwNcgmdlxD4udHGUDWHUZ
	o/YgfegX+AVx544EC5cGmtYaqMt74S8tqHq7keEmy9Cogn/QZ6AR5vxQwRUdYswiZV+sXJC4JZ0
	B5LMAetuQ8y4i+l8s4+++rGQ1aD6BI9sJWAjhGEVas20Y/nsMqAuYANxQmyEiu2ZkpogxwNo8wE
	rdUqRwshCixeQAcw6rTLRUOxnyidV5Ms5VcYY3DM0QK3VOy2GrQW6lpCEJz7Z59+qAzTw6dYMCO
	AAsKpLmDUfeRkAj6HWm2NncJLpL
X-Received: by 2002:a05:6122:906:b0:56d:451b:e4dd with SMTP id 71dfb90a1353d-5ac5792009bmr9657378e0c.12.1781023870009;
        Tue, 09 Jun 2026 09:51:10 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6d6dc3d3fsm18333721e0c.5.2026.06.09.09.51.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:51:09 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/4] plugins: Check btd_profile_register return value
Date: Tue,  9 Jun 2026 12:50:56 -0400
Message-ID: <20260609165057.90837-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609165057.90837-1-luiz.dentz@gmail.com>
References: <20260609165057.90837-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Ensure all plugin init functions check the return value of
btd_profile_register. If registration fails (e.g. bearer not enabled),
the plugin init propagates the error instead of continuing with an
unregistered profile.
---
 profiles/audio/a2dp.c      | 14 ++++++++++++--
 profiles/audio/avrcp.c     | 13 +++++++++++--
 profiles/audio/hfp-hf.c    |  4 +---
 profiles/audio/micp.c      |  7 ++++++-
 profiles/input/manager.c   |  4 +---
 profiles/network/manager.c |  5 ++++-
 src/gatt-database.c        |  4 +++-
 7 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index c7e0fc75c09e..a5e002784c02 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -3798,9 +3798,19 @@ static struct btd_adapter_driver media_driver = {
 
 static int a2dp_init(void)
 {
+	int err;
+
 	btd_register_adapter_driver(&media_driver);
-	btd_profile_register(&a2dp_source_profile);
-	btd_profile_register(&a2dp_sink_profile);
+
+	err = btd_profile_register(&a2dp_source_profile);
+	if (err)
+		return err;
+
+	err = btd_profile_register(&a2dp_sink_profile);
+	if (err) {
+		btd_profile_unregister(&a2dp_source_profile);
+		return err;
+	}
 
 	return 0;
 }
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index b6823753fe68..f63acd47091a 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -4987,8 +4987,17 @@ static struct btd_profile avrcp_controller_profile = {
 
 static int avrcp_init(void)
 {
-	btd_profile_register(&avrcp_controller_profile);
-	btd_profile_register(&avrcp_target_profile);
+	int err;
+
+	err = btd_profile_register(&avrcp_controller_profile);
+	if (err)
+		return err;
+
+	err = btd_profile_register(&avrcp_target_profile);
+	if (err) {
+		btd_profile_unregister(&avrcp_controller_profile);
+		return err;
+	}
 
 	populate_default_features();
 
diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index c91b16426898..8de2d7a62d68 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -507,9 +507,7 @@ static struct btd_profile hfp_hf_profile = {
 
 static int hfp_init(void)
 {
-	btd_profile_register(&hfp_hf_profile);
-
-	return 0;
+	return btd_profile_register(&hfp_hf_profile);
 }
 
 static void hfp_exit(void)
diff --git a/profiles/audio/micp.c b/profiles/audio/micp.c
index 475f32daf75c..3d39ef5e147f 100644
--- a/profiles/audio/micp.c
+++ b/profiles/audio/micp.c
@@ -318,12 +318,17 @@ static unsigned int micp_id;
 
 static int micp_init(void)
 {
+	int err;
+
 	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
 		DBG("D-Bus experimental not enabled");
 		return -ENOTSUP;
 	}
 
-	btd_profile_register(&micp_profile);
+	err = btd_profile_register(&micp_profile);
+	if (err)
+		return err;
+
 	micp_id = bt_micp_register(micp_attached, micp_detached, NULL);
 
 	return 0;
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 0fcd6728c2fc..1fd82d82f500 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -118,12 +118,10 @@ static int input_init(void)
 
 	}
 
-	btd_profile_register(&input_profile);
-
 	if (config)
 		g_key_file_free(config);
 
-	return 0;
+	return btd_profile_register(&input_profile);
 }
 
 static void input_exit(void)
diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index 693547d45fbc..a5f28a99ebfd 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -180,7 +180,10 @@ static int network_init(void)
 	if (server_init(conf_security) < 0)
 		return -1;
 
-	btd_profile_register(&panu_profile);
+	err = btd_profile_register(&panu_profile);
+	if (err)
+		return err;
+
 	btd_profile_register(&gn_profile);
 	btd_profile_register(&nap_profile);
 
diff --git a/src/gatt-database.c b/src/gatt-database.c
index 680a52952b16..30e25b6f41ca 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -3624,7 +3624,9 @@ static void add_profile(void *data, void *user_data)
 {
 	struct btd_adapter *adapter = user_data;
 
-	btd_profile_register(data);
+	if (btd_profile_register(data))
+		return;
+
 	adapter_add_profile(adapter, data);
 }
 
-- 
2.54.0

