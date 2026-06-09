Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3484448AE04
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031208; cv=none; b=OQX+SlwykpZM+CqsyVzY+1j5REs7x0WTZWMCnvvcJqfqeKO8IG7CE6+GU91dvx2lXy+sg3Av3QlMmFoD75I/zzPF1AQT4SWuvKQ6oK8j/KwdAFVunoYY+XQ4EY8DlH22El39m9C+R7kls8sga00sPpZRq3MtMy+pAsBfhp5tSLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031208; c=relaxed/simple;
	bh=xJ+snH1B5vVVd9arDy88kq2UBIDPs3PRnOCTCL9q68w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMbZt9tUUM343i9PjLwrYn91loVUHBx3cEIw56fQ74kwGeVtLsugss/UZyTIKIvlHkrdQqj+N2Ya/gdmQHRSxBpRCVHBgATGMxaGhBTeg/7Kxd8UpCVK37muK822a7P6Hb/3g0JizbdSlsQ3eWh2P+0ROs2Ptpf2SSCav+t8Wrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gs7DxJ5C; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gs7DxJ5C"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-59d7db12342so1818106e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 11:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781031206; x=1781636006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a6Nq9JyXRsgg/9mUI4Xcc6SR2whA3Otg+agVt60lnGw=;
        b=gs7DxJ5CaKGTjjhxTDhsyuHpdhtzAaeT6UL9ByKvDYLr/euGxPzem2bnmED15e2AgX
         JAH+EdWFOq3MNTNd0TvT7Cj6cR+WBGmoS8bkVHwjk1o8qC7yg+GvabYtOkHCd/2oTsCZ
         gUvwpsqhpsidSJlP3ngU2qK1gKg9xQMAWtP4INY6oEtArYoKINl2rbrH6l2MLNDe3S35
         96+glg1DhJN2qYhfMF/yRLJiqJvZ2sPydTgXgYNmSGI2SA7Q5ftk/XcirfiaOkOqMhII
         QHIPQY3HI4cM1MmxDlpszWmpdIcFuW7lVtMaDM4/waHsXF+mgm/l9iS4VyRAYv3+lZS4
         7BHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781031206; x=1781636006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a6Nq9JyXRsgg/9mUI4Xcc6SR2whA3Otg+agVt60lnGw=;
        b=OkalmoG58uiUxgHZyPiETshqCDyiIHGukl9mJf/defDgrjDz9A0DO77u1sAgTrBTmm
         aZXTd1o2+KS3bJPRV9VUNeebFTgoSNVOpZFX16Rwm4uXyph7CX2ADCih9GsMgR6Blsm1
         DaJi5Tj099hBTtG6PsaWThl1ANBK8w8al1D/htueJ2dQyEkERBTl02gk6T6dEzB/b6yB
         IA8kC8jdAikzfvpC0daxuNBcY8/zEhDqlvVzsSogqUZe/q1BGD2Vlg7PhstdudS1XkQu
         sl26327OsLe1QxihH+oUJ+qZvP78tQkpu9jHGGRXXzn44ZKTLPuwDMlri43fbf52voj3
         l4pw==
X-Gm-Message-State: AOJu0YwUPDppvfRXRTkM+cho9P+AbKBjVHxD+k2ctQNOjyGH0n46Fqf6
	Vzoi82DlN0nzGoO7uwRgnYXuHac9KwyMvw+jDmo4lv+J9y9SkAy5O2DXWJ2zlw==
X-Gm-Gg: Acq92OEWkv9LClAmUWpg+CTTWsAw9Jok1NEXCleufHRumJbm00r2YDhtQPmrnQf7IYQ
	1dv2J9DxhCajMpz97/odxhh78IexbgIjCqz3Aa2mxDkXRljyYO54fQZnubrGUT2Z2x37t1u5hvB
	A0w/aqY1mW+mBHd4ODBdByt7EGBGWaseo4ISWqyBGrppH4b4FeA/YcBSkFP7IKvn+dqBRnpiqGd
	powbn74VRcCmIF8BUh/OpXp5e4j+xMzw8+bD1XjtgeJ7391Py9A4Tyl9zBzIk/F03ATrGdotDvN
	SFJO1SKjSUnAzWm34/nMc2pnve6xNbEQMpV//IIWpBOVt5KFnz/sF+0wZFDieNhwG7qKjfIGVBd
	Ur3osQglYKvYHQlecl92ysA2njOKXdRXqMLM67q9dyczh99KOeJArV+kFzvs7P4LyqAm0wrNNfT
	ehrlAG7gpelDPvicx8nZ+jT9FLtEaxSRUJIErAnX77/KP/AegiY4YNToVl8ducQB1+gy7Y6F+Dl
	TXYnSiaRNAdZW6pCHc7/q7ruFwCAZDB2utvo2A=
X-Received: by 2002:a05:6122:1907:b0:59e:372f:6db9 with SMTP id 71dfb90a1353d-5ac53aa6e2fmr10269292e0c.12.1781031206182;
        Tue, 09 Jun 2026 11:53:26 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6d06a491esm17772795e0c.0.2026.06.09.11.53.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 11:53:25 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/4] plugins: Check btd_profile_register return value
Date: Tue,  9 Jun 2026 14:53:12 -0400
Message-ID: <20260609185313.155105-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609185313.155105-1-luiz.dentz@gmail.com>
References: <20260609185313.155105-1-luiz.dentz@gmail.com>
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

