Return-Path: <SRS0=CFtH=CY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174D6C433E2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Sep 2020 17:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D18E921D1B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Sep 2020 17:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hf+jhrcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgIORn0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Sep 2020 13:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbgIORl7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Sep 2020 13:41:59 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9403C06178A
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2020 10:41:58 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 7so2339128pgm.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2020 10:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vd5r3TeLsaCA/FonKoaEEnRN1IsGwZeTfuAzbxCS9yE=;
        b=Hf+jhrcNZa13owORLbemg2thCh3yoSHlopNqRTy3NhCi64Q5cxIY9uh3MlBm9VYqqD
         oZ8QezExrZQcda/PDQ+rS3YMxsNmumyGImBpM4BNdQI5l1rzlYxn8TcVpE+smxeowz/L
         1TJ1A1fAMx7HVRa1C/Qi/gQ01fWcmRtLgGfvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vd5r3TeLsaCA/FonKoaEEnRN1IsGwZeTfuAzbxCS9yE=;
        b=LwCmN/K8a2LI3dvKZGDTC7v2hyzJED2ldvkJzC3BcA9veKR64+zRsumYAv02vhwQqb
         RzkMznAfxXdQWAozlYiJKlh/orpo/R41y2XEfaZLxDH0ZpjUxKxKTaXwBoxrX6GCJWzI
         v9yBccv1hw6UVgsgcDvsLHDoxKjwkFDIoPvfNeyA8LdLWbmwa+3CiXt1mBohKkpZ/tB3
         o6bh7tATGKUkXKmYV1DBSLmCZsCsI2XenwwMLnpDVOwwjKwDwhS1tRxOFRGaCJu3XN6k
         p92bux6lOYBz4BbtCpYolqB/7q+8VxoLdqJ9uBdRhwByM38OyuYY78Pjw6sYC5kkdmOe
         QERA==
X-Gm-Message-State: AOAM530bPXS4TgE5lx9TM2i9TFF40Rg2cwI6wSr63HczmlvrPsKwGo5R
        1ZVfhgdudfixT9e7yoQfbRXSQQ==
X-Google-Smtp-Source: ABdhPJxTU0++yIPdbLfM/+8c2lhdjnTFDnCqLC+YOaES7uoI4DwX5gX8W8wKeqrqxOt4dBGdMbw0Zw==
X-Received: by 2002:a63:d648:: with SMTP id d8mr15441341pgj.4.1600191718408;
        Tue, 15 Sep 2020 10:41:58 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id y29sm15490232pfq.207.2020.09.15.10.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 10:41:57 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [Bluez PATCH v5 2/4] adapter: Handle controller resume and notify drivers
Date:   Tue, 15 Sep 2020 10:41:44 -0700
Message-Id: <20200915104127.Bluez.v5.2.Ic6aa9c03323b5ef0265e5b5b36986af05d9ecd26@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200915174146.1693687-1-abhishekpandit@chromium.org>
References: <20200915174146.1693687-1-abhishekpandit@chromium.org>
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

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 src/adapter.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h |  2 ++
 2 files changed, 45 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 88b5202d9..b431097f2 100644
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

