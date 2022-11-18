Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46F1C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 05:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239229AbiKRF1A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 00:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiKRF07 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 00:26:59 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353E758BF4
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:26:57 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id cl5so7550184wrb.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7kT4pxCYfbhjQlzwje4ctWugNbObBPx2k9IpATaGCu0=;
        b=xqEEGqv1YPI5+ZAiHSwkf1YHHOKWifljWxebwbD8TZMGzV1fTkfA3xCfOf5mktYi3V
         oK4ll9C/JSi8m13mbD/va81zyC6Ox5tqsfl8cj8bSTNRbALIXIkOSBhwI2ERqIlBTzSg
         /hxSXKngEgf0kO0sJOdKH0qfV7PM2DLUQA5RA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7kT4pxCYfbhjQlzwje4ctWugNbObBPx2k9IpATaGCu0=;
        b=YgdtfxV2FW9e/TqJd5SoQwJkijkas0NWLiM6Gy5NvLjcNK25JBW2T3P8BrVkMsy+bU
         0IlWoBoxlx2cgMVudiEjrBAneBDvInwNi9Q7r0RRdAjZyPzkZB9B1KeOJAOQElE4vbMq
         bBUtP2p4dVtRJ2lH3y5XgHN5BP3+jgaaXUVsqVD01WmN4V7cLhmuatiplHFPFq43+oH/
         cbog5Q7K5dC1imP8N0U6ynw7MowYdPYZx9uhFtbuBhq+HULBClrr7HrV9d00ruXri0Hk
         hwzxP4lmMkRrkeeh5OvQXQJCoOhfj4rZUZpE51ojxISmGIRfAc3Qabo51qDJzUUd+/Aw
         7p5w==
X-Gm-Message-State: ANoB5plLQk8ZLzFlhQfIsqkQv8wB4scg9to8AvZv7VLQWfqQ6pekP0VS
        cEYHi7JN9iqXG82JbYlfSWJmhonhfJobgQ==
X-Google-Smtp-Source: AA0mqf6r7GzZrCsQfAx7eGxc++7UZ1D7fUR1/S9ERe2xJ71tlwfZtcWjp+PcbPwYIbv/Fj2XbNBqcw==
X-Received: by 2002:a05:6000:18f:b0:241:a046:91ff with SMTP id p15-20020a056000018f00b00241a04691ffmr3226491wrx.23.1668749215580;
        Thu, 17 Nov 2022 21:26:55 -0800 (PST)
Received: from Legionbuntu.. ([2a01:c846:10c0:200:7cd0:53cb:9851:e8de])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d43cb000000b00241bd177f89sm1708365wrr.14.2022.11.17.21.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 21:26:54 -0800 (PST)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ] main.conf: Add SecureConnections option
Date:   Fri, 18 Nov 2022 06:26:10 +0100
Message-Id: <20221118052610.36133-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This introduces SecureConnections option to main.conf that can be used to
configure this on adapter initialization.

This is useful for:
- disable for adapters that have a problems with SecureConnections enabled
- if you want to disable CTKD (cross transport key derivation)
- add option to enable only SecureConnections
---
 src/adapter.c |  2 +-
 src/btd.h     |  7 +++++++
 src/main.c    | 15 +++++++++++++++
 src/main.conf | 11 +++++++++++
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 8fb2acdc8..747f8f8ca 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -10146,7 +10146,7 @@ static void read_info_complete(uint8_t status, uint16_t length,
 	}
 
 	if (missing_settings & MGMT_SETTING_SECURE_CONN)
-		set_mode(adapter, MGMT_OP_SET_SECURE_CONN, 0x01);
+		set_mode(adapter, MGMT_OP_SET_SECURE_CONN, btd_opts.secure_conn);
 
 	if (adapter->supported_settings & MGMT_SETTING_PRIVACY)
 		set_privacy(adapter, btd_opts.privacy);
diff --git a/src/btd.h b/src/btd.h
index 63be6d8d4..42cffcde4 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -36,6 +36,12 @@ enum mps_mode_t {
 	MPS_MULTIPLE,
 };
 
+enum sc_mode_t {
+	SC_OFF,
+	SC_ON,
+	SC_ONLY,
+};
+
 struct btd_br_defaults {
 	uint16_t	page_scan_type;
 	uint16_t	page_scan_interval;
@@ -105,6 +111,7 @@ struct btd_opts {
 	uint8_t		privacy;
 	bool		device_privacy;
 	uint32_t	name_request_retry_delay;
+	uint8_t		secure_conn;
 
 	struct btd_defaults defaults;
 
diff --git a/src/main.c b/src/main.c
index 1d357161f..99d9c508f 100644
--- a/src/main.c
+++ b/src/main.c
@@ -80,6 +80,7 @@ static const char *supported_options[] = {
 	"MaxControllers"
 	"MultiProfile",
 	"FastConnectable",
+	"SecureConnections",
 	"Privacy",
 	"JustWorksRepairing",
 	"TemporaryTimeout",
@@ -881,6 +882,19 @@ static void parse_config(GKeyFile *config)
 		btd_opts.name_request_retry_delay = val;
 	}
 
+	str = g_key_file_get_string(config, "General",
+						"SecureConnections", &err);
+	if (err)
+		g_clear_error(&err);
+	else {
+		if (!strcmp(str, "off"))
+			btd_opts.secure_conn = SC_OFF;
+		else if (!strcmp(str, "on"))
+			btd_opts.secure_conn = SC_ON;
+		else if (!strcmp(str, "only"))
+			btd_opts.secure_conn = SC_ONLY;
+	}
+
 	str = g_key_file_get_string(config, "GATT", "Cache", &err);
 	if (err) {
 		DBG("%s", err->message);
@@ -993,6 +1007,7 @@ static void init_defaults(void)
 	btd_opts.debug_keys = FALSE;
 	btd_opts.refresh_discovery = TRUE;
 	btd_opts.name_request_retry_delay = DEFAULT_NAME_REQUEST_RETRY_DELAY;
+	btd_opts.secure_conn = SC_ON;
 
 	btd_opts.defaults.num_entries = 0;
 	btd_opts.defaults.br.page_scan_type = 0xFFFF;
diff --git a/src/main.conf b/src/main.conf
index 2796f155e..f187c9aaa 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -111,6 +111,17 @@
 # profile is connected. Defaults to true.
 #RefreshDiscovery = true
 
+# Default Secure Connections setting.
+# Enables the Secure Connections setting for adapters that support it. It
+# provides better crypto algorithms for BT links and also enables CTKD (cross
+# transport key derivation) during pairing on any link.
+# Possible values: "off", "on", "only"
+# - "off": Secure Connections are disabled
+# - "on": Secure Connections are enabled when peer device supports them
+# - "only": we allow only Secure Connections
+# Defaults to "on"
+#SecureConnections = on
+
 # Enables D-Bus experimental interfaces
 # Possible values: true or false
 #Experimental = false
-- 
2.34.1

