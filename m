Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA072EA467
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673393; cv=none; b=foWXFImQadXfSWfmHhlS+Q2wRvcODaHGbou+mrufYYeYxIgWxjGtj35FNrHy5A1qfHASqGw8x5FxeHMKrJrM93ZxGUFJc5eEIWdfmDzV3rXhTKl9ZkxAmY8b8SJ8GJM0gTeb9OuADnFhf16XF0dizx6b1XwZLxFLJ57Q+8aGSDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673393; c=relaxed/simple;
	bh=TuWkHpyzyZ6Bu+T+2g4gbUag/jNCmBa35lf9QWsjyKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QBvnivoUYZ+UOah1mk/jHvWDsGHFMzB1OcFJ6BhcGlr7BnzLX4mL6jGwQdN4JOOL9oEg2Y17V1W8vf+jrJbP9Ig1q4Zy8WeG+0Vy7yNK4tpD8PTD6KaVMYRtdr7ZZNYhWQjcTRITFhfsAq8y17kzC8iiRmEArEgdePT6DG+WoTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=km21yKmu; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="km21yKmu"
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DECD2414A7
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 10:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1757673378;
	bh=3IOksmbooBoQMbqX50TTRZDhxdBTTHIG3yT2qmnv/kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=km21yKmuagLlOr7rCqhQOWVaSxWUsB16xTqW3VofWStWUBYXrH6jnA39HiHlGF1Ii
	 Ci2sImUfrN6uGkQKb94+INkgvp9WmVCwEuDuaOpvMfxvTRkEP5jYxb9lKp8h2DOpyE
	 YxFp7YYEmP42Pt8GhI+cP9Rn7RgmT4Au1S1b8QDMfXwiP9RqHW4hrPlmGj75E+PUOX
	 ljxsEq7wdLG0dJVKNg36Zsx/79n69YlAdIhd9p1+500qsiSbS0IPkvrxfMxxL0Npl5
	 b/LJC6OvHps44ZHjiJRLJ+TDV5nAok2Qi+kgSHOMqt/61lVAzVLST6t6ytVvGiYcDQ
	 pBezMwmeKrAnA==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b00e4aff77fso3122466b.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 03:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757673377; x=1758278177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3IOksmbooBoQMbqX50TTRZDhxdBTTHIG3yT2qmnv/kk=;
        b=YXg6dGKRFT9VfvKsNOb8THM6navBSgSriVTbKsenHR+CyJjQDLvtvbbPb/0VJikK/W
         fQcgJrpTCrHySQc9Yy/BNeqyxJc/IhDAxo7XrE9GCoNcyXsiPA3EtfWb4egFvDfdtItV
         w2UuT0l3/2O7x7h6XqhgmD3ueUDKHUiQ5TLB/Kycbs4BTnUoPtHykmJOpzOxhhNvvfmY
         2rxGqrQRjsJL3bYo1D4gp2eNlwIxyja0YpYAjYuZc4sLE9dHpT1eQ7RQEDQXovAaWXN1
         NGoDfrRG6yJkJ+VOGwlGnW3RkE+im1s5f2epxDVytXkeU8gy93LV7vqEncLWh08qf9T8
         BvRg==
X-Gm-Message-State: AOJu0YwenK8mC/sGduRWqnxPBAhwP3gdtaQSskNYV569reda515uthae
	tKrU76o2goEszK75UkaB2RiyEY/5qn1sH/deqal1TehbhHhgoj76bAjEwzadD6xQuZ/f6fmxFXK
	k4A9U1KDpd+6S56Oy5ClmFWNK1MLD2Gl4IkNSdiMoo5wOgVkpGL4zfQR7K5h4GHqPMPzh8f6Ts4
	N0Rw5AZgkcC7tOYseRZA==
X-Gm-Gg: ASbGncttrZPDYyzrkqnviPh9Bjx2E1zPJQg/UUFC1YiOrhizDAM81BVCnxH8sQd/lOJ
	mN5qaV9ViTvsVsyHTpZt08q5nA/PbXlXWTLOZjG/JdPoW3QpiEAOn/VQONXePTN+6Clgo+30IzB
	jEH4ll0N87bzx7IlsKXJI4ILGONQsE2oG7oSVf0t6jDvQS7+2Mf1u8cCxws84fs69QwquHD32bn
	vN03ym/WpfNrWU6KyadR2nBRjgFOPe2wMk6pdIQ7Pn6BHWlGwg6Z4n7e0c9PO07cQQ0UbiWKg6T
	OY8RJJMi7s5iDgnBo7ixulnxgHqUuKhZWD4GOmSFCVYQO6+/kf1irDRNcYFrbITO1H5wgVq9nia
	W1CKoQobPvFaNSW9tw20GEeUfQfrOQUdKmI7hu82LChl4
X-Received: by 2002:a17:907:3e1f:b0:b01:7e4e:9bf4 with SMTP id a640c23a62f3a-b07c3829474mr115292766b.8.1757673377146;
        Fri, 12 Sep 2025 03:36:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeIMjmnlDpRaN9VRmaC76LHsUAtQtJmcpS0kzy76Lilr2qR6F9gZPshlrkgHIS+llNAlY23Q==
X-Received: by 2002:a17:907:3e1f:b0:b01:7e4e:9bf4 with SMTP id a640c23a62f3a-b07c3829474mr115291766b.8.1757673376689;
        Fri, 12 Sep 2025 03:36:16 -0700 (PDT)
Received: from aglinserer-MS-7C91.pigl.home (188-23-192-136.adsl.highway.telekom.at. [188.23.192.136])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd57csm339605366b.52.2025.09.12.03.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:36:16 -0700 (PDT)
From: Andreas Glinserer <andreas.glinserer@canonical.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andreas Glinserer <andreas.glinserer@canonical.com>
Subject: [PATCH BlueZ] src/adapter: add timeout for missing discovery
Date: Fri, 12 Sep 2025 12:35:50 +0200
Message-ID: <20250912103550.49240-1-andreas.glinserer@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a timeout to detect when the controller stops sending discovery
events. Without this, the system silently discovering new devices
and the scan list gradually empties due to DEFAULT_TEMPORARY_TIMEOUT.

When the timeout triggers, issue MGMT_OP_STOP_DISCOVERY to restart the
event loop and resume discovery.

Link: https://github.com/bluez/bluez/issues/1554
---
 src/adapter.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index dc5ba65d7..1ec665c73 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -342,6 +342,7 @@ struct btd_adapter {
 
 	struct queue *exp_pending;
 	struct queue *exps;
+	unsigned int last_discovery_timeout_id;		/* Timeout for discovery stop if no cb is coming */
 };
 
 static char *adapter_power_state_str(uint32_t power_state)
@@ -1727,6 +1728,11 @@ static void discovery_cleanup(struct btd_adapter *adapter, int timeout)
 		adapter->discovery_idle_timeout = 0;
 	}
 
+	if (adapter->last_discovery_timeout_id > 0) {
+		timeout_remove(adapter->last_discovery_timeout_id);
+		adapter->last_discovery_timeout_id = 0;
+	}
+
 	g_slist_free_full(adapter->discovery_found,
 						invalidate_rssi_and_tx_power);
 	adapter->discovery_found = NULL;
@@ -1833,6 +1839,8 @@ static struct discovery_client *discovery_complete(struct btd_adapter *adapter,
 	return client;
 }
 
+static bool time_since_last_discovery_cb(gpointer user_data);
+
 static void start_discovery_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -1900,6 +1908,20 @@ static void start_discovery_complete(uint8_t status, uint16_t length,
 	trigger_start_discovery(adapter, IDLE_DISCOV_TIMEOUT * 2);
 }
 
+static bool time_since_last_discovery_cb(gpointer user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	struct mgmt_cp_start_discovery cp;
+	DBG("");
+	cp.type =  get_scan_type(adapter);
+	
+	mgmt_send(adapter->mgmt, MGMT_OP_STOP_DISCOVERY,
+		adapter->dev_id, sizeof(cp), &cp,
+		NULL, NULL, NULL);
+
+	return FALSE;
+}
+
 static bool start_discovery_timeout(gpointer user_data)
 {
 	struct btd_adapter *adapter = user_data;
@@ -1909,6 +1931,9 @@ static bool start_discovery_timeout(gpointer user_data)
 	DBG("");
 
 	adapter->discovery_idle_timeout = 0;
+	adapter->last_discovery_timeout_id = timeout_add_seconds(
+		IDLE_DISCOV_TIMEOUT * 3, time_since_last_discovery_cb,
+		adapter, NULL);
 
 	/* If we're doing filtered discovery, it must be quickly restarted */
 	adapter->no_scan_restart_delay = !!adapter->current_discovery_filter;
@@ -2009,6 +2034,11 @@ static void trigger_start_discovery(struct btd_adapter *adapter, guint delay)
 	if (!btd_adapter_get_powered(adapter))
 		return;
 
+	if (adapter->last_discovery_timeout_id > 0) {
+		timeout_remove(adapter->last_discovery_timeout_id);
+		adapter->last_discovery_timeout_id = 0;
+	}
+
 	adapter->discovery_idle_timeout = timeout_add_seconds(delay,
 					start_discovery_timeout, adapter, NULL);
 }
@@ -2053,6 +2083,11 @@ static void suspend_discovery(struct btd_adapter *adapter)
 		adapter->discovery_idle_timeout = 0;
 	}
 
+	if (adapter->last_discovery_timeout_id > 0) {
+		timeout_remove(adapter->last_discovery_timeout_id);
+		adapter->last_discovery_timeout_id = 0;
+	}
+
 	if (adapter->discovery_enable == 0x00)
 		return;
 
-- 
2.43.0

