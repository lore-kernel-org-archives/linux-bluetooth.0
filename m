Return-Path: <SRS0=2FZ9=CU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685E1C433E2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Sep 2020 22:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F80C22207
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Sep 2020 22:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ybrt8GDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbgIKWay (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Sep 2020 18:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgIKWas (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Sep 2020 18:30:48 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CD5C061757
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 15:30:47 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id m5so7537842pgj.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 15:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WaLvyDrpSOjFqABkikbrubyIQ9gGcpKW8XM7vdEOdKA=;
        b=Ybrt8GDp4U0Ref+E7puBcHWfPDeqZwmnDzBVdD7Dl8dM4XCcdjemh+UcuyJ+GCBIeN
         VvfI56mOhtYfsip2ICar2nX41HBqhyjAy9YYZq+KHS0C20b3RjnHBK4UgqDYPE3UujpY
         zOthAQCPCBOpf8Okk9WkZ3HNUFV7O4GpwwJJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WaLvyDrpSOjFqABkikbrubyIQ9gGcpKW8XM7vdEOdKA=;
        b=P3yRDpl/rs8FCF2QGvlolt6ePE/WaS4rCGQgBRD+u3VlsDAm8qpRn7+fso3q+fi66n
         wEx31A3sVadKOOW8QkYizpuExMIV54ey8ArKnZ+i1OY/N8jKIlJX65GxZfnsbNL7/qd9
         XQ0fctpzdJ8AL8YkojXxR04EOBkZznebJIzjgxDeRkjNv9MlykVFkYI/l7LEDVV2BAXE
         PE8M3POc2C0SQX3UnBP8bhYB3hKn2hpDaQaCId1UxuBs2OZfc8faKL6cAcquHM1lWqGA
         JSWZePQnaDlxid6gw3svVcdy6KSJ4Iw49dJ+cvld3TxU+Rg89D+4ipgXZUEpqfit95IU
         iW1w==
X-Gm-Message-State: AOAM5323O8noDa3r8+9ds9KpQccgRjTLh4LgHYPZ6v363YE5+JPo5ZfQ
        r4zPThhs/GY33Fetv50N5uzHxA==
X-Google-Smtp-Source: ABdhPJxzXgcnx5kETwJRmZa8l8Bd1kKZiC5t6POvTuSOOmCYl77EML9xgKIdBOEEM4sOOkg+JeI9uw==
X-Received: by 2002:a63:464c:: with SMTP id v12mr3182389pgk.130.1599863446753;
        Fri, 11 Sep 2020 15:30:46 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id m14sm3123742pfo.202.2020.09.11.15.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 15:30:46 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [Bluez PATCH v4 2/4] adapter: Handle controller resume and notify drivers
Date:   Fri, 11 Sep 2020 15:30:35 -0700
Message-Id: <20200911153010.Bluez.v4.2.Ic6aa9c03323b5ef0265e5b5b36986af05d9ecd26@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200911223037.4127188-1-abhishekpandit@chromium.org>
References: <20200911223037.4127188-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Register for controller resume notification and notify the adapter
drivers when it occurs. Also adds the resume event kernel feature to
make sure the kernel supports this event.
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 src/adapter.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h |  2 ++
 2 files changed, 45 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index e700a78d5..d77d83d11 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -8771,6 +8771,33 @@ static void connected_callback(uint16_t index, uint16_t length,
 	eir_data_free(&eir_data);
 }
 
+static void controller_resume_notify(struct btd_adapter *adapter)
+{
+	GSList *l;
+
+	for (l = adapter->drivers; l; l = g_slist_next(l)) {
+		struct btd_adapter_driver *driver = l->data;
+		if (driver->resume)
+			driver->resume(adapter);
+	}
+}
+
+static void controller_resume_callback(uint16_t index, uint16_t length,
+				       const void *param, void *user_data)
+{
+	const struct mgmt_ev_controller_resume *ev = param;
+	struct btd_adapter *adapter = user_data;
+
+	if (length < sizeof(*ev)) {
+		btd_error(adapter->dev_id, "Too small device resume event");
+		return;
+	}
+
+	info("Controller resume with wake event 0x%x", ev->wake_reason);
+
+	controller_resume_notify(adapter);
+}
+
 static void device_blocked_callback(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -9394,6 +9421,11 @@ static void read_info_complete(uint8_t status, uint16_t length,
 						user_passkey_notify_callback,
 						adapter, NULL);
 
+	mgmt_register(adapter->mgmt, MGMT_EV_CONTROLLER_RESUME,
+						adapter->dev_id,
+						controller_resume_callback,
+						adapter, NULL);
+
 	set_dev_class(adapter);
 
 	set_name(adapter, btd_adapter_get_name(adapter));
@@ -9604,6 +9636,17 @@ static void read_commands_complete(uint8_t status, uint16_t length,
 			break;
 		}
 	}
+
+	for (i = 0; i < num_events; i++) {
+		uint16_t ev = get_le16(rp->opcodes + num_commands + i);
+
+		switch(ev) {
+		case MGMT_EV_CONTROLLER_RESUME:
+			DBG("kernel supports suspend/resume events");
+			kernel_features |= KERNEL_HAS_RESUME_EVT;
+			break;
+		}
+	}
 }
 
 static void read_version_complete(uint8_t status, uint16_t length,
diff --git a/src/adapter.h b/src/adapter.h
index b0ed4915f..fae2e9d3d 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -113,6 +113,7 @@ struct btd_adapter_driver {
 	const char *name;
 	int (*probe) (struct btd_adapter *adapter);
 	void (*remove) (struct btd_adapter *adapter);
+	void (*resume) (struct btd_adapter *adapter);
 };
 
 typedef void (*service_auth_cb) (DBusError *derr, void *user_data);
@@ -239,6 +240,7 @@ enum kernel_features {
 	KERNEL_BLOCKED_KEYS_SUPPORTED	= 1 << 1,
 	KERNEL_SET_SYSTEM_CONFIG	= 1 << 2,
 	KERNEL_EXP_FEATURES		= 1 << 3,
+	KERNEL_HAS_RESUME_EVT		= 1 << 4,
 };
 
 bool has_kernel_features(uint32_t feature);
-- 
2.28.0.618.gf4bc123cb7-goog

