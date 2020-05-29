Return-Path: <SRS0=kIsL=7L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E7CC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 15:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F74206E2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 15:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kUq8Hmzx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgE2Pao (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 May 2020 11:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2Pan (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 May 2020 11:30:43 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DB1C03E969
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 08:30:43 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id b13so1691612vsm.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 08:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vViVG7+5qiiR8NNkhmthB9J+XP/6BbKI6yRkBW0shRQ=;
        b=kUq8HmzxVSd0mZ7Y8yyldy54cXS+WTlvLHh9maKs0XoyLftSVQSTijaJoPpD44i76Y
         aKQXZ56KSYfdmvKHoDu5FoVr6KRiUSac8+D56jSaJcet+OCQwMqKsOl1iM8ssTxtnqnI
         /X7Vjf3TPyby/srsiNpE45jcdoiBpHSjSRDCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vViVG7+5qiiR8NNkhmthB9J+XP/6BbKI6yRkBW0shRQ=;
        b=i0phL0IgebjlAPZIJRaP+hfkSUvlN39D1OWjm28XqoBVldHen1XbslI4UOxLR1IE4g
         ZI9im9HWxtsfqtIHxSdYiouCxiHwszI7fi/LZspNgfky00GeYgleHfBAdxKlzRf7bSh2
         8JndxTClndVP7s2wIxpMURHEsxJjRwejhtW1qrKkO1R+CN6u/7YB52I+lxNDFtzOKaSR
         KGUsy1ueiUplS+tWtGpFxm0vO32DbKrG/Frs7cTfK0ic/WrX12lN/CcLCKQVFctM3yAx
         PAAWTeEMkSCavecZNX3sV9r3IT/CS98/8W8U38JK8T96fgK+oY7lJy+xj3ysW3F/v2w4
         6/jg==
X-Gm-Message-State: AOAM533+CQ+sXVKSt2xN2XM5itq6PrHg5UNVMpOnGV/ja5uzH6DZnjW1
        tCDYfj3anZtlq1reIN92232u3cywQP8=
X-Google-Smtp-Source: ABdhPJxI1kqc7wKuXanLLDK3Y3y8U+0TnqlWKpJAAPLY814cRNCExbEqqDbdT/snWjPY3mdiwaPJSA==
X-Received: by 2002:a67:898a:: with SMTP id l132mr6347942vsd.123.1590766242413;
        Fri, 29 May 2020 08:30:42 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id c65sm1216286vkh.32.2020.05.29.08.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 08:30:41 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH v2 3/3] main:read default system configuration from the conf file.
Date:   Fri, 29 May 2020 15:29:43 +0000
Message-Id: <20200529152940.208214-4-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
In-Reply-To: <20200529152940.208214-1-alainm@chromium.org>
References: <20200529152940.208214-1-alainm@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds support for reading the configurations from the
main.conf file.

---

Changes in v2:
- Fixing checkpatch warning that are applicable.

 src/main.c    | 162 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/main.conf |  65 ++++++++++++++++++++
 2 files changed, 227 insertions(+)

diff --git a/src/main.c b/src/main.c
index 98621fddf..ca27f313d 100644
--- a/src/main.c
+++ b/src/main.c
@@ -54,6 +54,7 @@
 #include "shared/att-types.h"
 #include "shared/mainloop.h"
 #include "lib/uuid.h"
+#include "shared/util.h"
 #include "hcid.h"
 #include "sdpd.h"
 #include "adapter.h"
@@ -97,6 +98,37 @@ static const char *supported_options[] = {
 	NULL
 };
 
+static const char * const controller_options[] = {
+	"BRPageScanType",
+	"BRPageScanInterval",
+	"BRPageScanWindow",
+	"BRInquiryScanType",
+	"BRInquiryScanInterval",
+	"BRInquiryScanWindow",
+	"BRLinkSupervisionTimeout",
+	"BRPageTimeout",
+	"BRMinSniffInterval",
+	"BRMaxSniffInterval",
+	"LEMinAdvertisementInterval",
+	"LEMaxAdvertisementInterval",
+	"LEMultiAdvertisementRotationInterval",
+	"LEScanIntervalAutoConnect",
+	"LEScanWindowAutoConnect",
+	"LEScanIntervalSuspend",
+	"LEScanWindowSuspend",
+	"LEScanIntervalDiscovery",
+	"LEScanWindowDiscovery",
+	"LEScanIntervalAdvMonitoring",
+	"LEScanWindowAdvMonitoring",
+	"LEScanIntervalConnect",
+	"LEScanWindowConnect",
+	"LEMinConnectionInterval",
+	"LEMaxConnectionInterval",
+	"LEConnectionLatency",
+	"LEConnectionSupervisionTimeout",
+	NULL
+};
+
 static const char *policy_options[] = {
 	"ReconnectUUIDs",
 	"ReconnectAttempts",
@@ -118,6 +150,7 @@ static const struct group_table {
 	const char **options;
 } valid_groups[] = {
 	{ "General",	supported_options },
+	{ "Controller", controller_options },
 	{ "Policy",	policy_options },
 	{ "GATT",	gatt_options },
 	{ }
@@ -283,6 +316,129 @@ static int get_mode(const char *str)
 	return BT_MODE_DUAL;
 }
 
+static void parse_controller_config(GKeyFile *config)
+{
+	static const struct {
+		const char * const val_name;
+		uint16_t * const val;
+		const uint16_t min;
+		const uint16_t max;
+	} params[] = {
+		{ "BRPageScanType",
+		  &main_opts.default_params.br_page_scan_type,
+		  0,
+		  1},
+		{ "BRPageScanInterval",
+		  &main_opts.default_params.br_page_scan_interval,
+		  0x0012,
+		  0x1000},
+		{ "BRPageScanWindow",
+		  &main_opts.default_params.br_page_scan_window,
+		  0x0011,
+		  0x1000},
+		{ "BRInquiryScanType",
+		  &main_opts.default_params.br_inquiry_scan_type,
+		  0,
+		  1},
+		{ "BRInquiryScanInterval",
+		  &main_opts.default_params.br_inquiry_scan_interval,
+		  0x0012,
+		  0x1000},
+		{ "BRInquiryScanWindow",
+		  &main_opts.default_params.br_inquiry_scan_window,
+		  0x0011,
+		  0x1000},
+		{ "BRLinkSupervisionTimeout",
+		  &main_opts.default_params.br_link_supervision_timeout,
+		  0x0001,
+		  0xFFFF},
+		{ "BRPageTimeout",
+		  &main_opts.default_params.br_page_timeout,
+		  0x0001,
+		  0xFFFF},
+		{ "BRMinSniffInterval",
+		  &main_opts.default_params.br_min_sniff_interval,
+		  0x0001,
+		  0xFFFE},
+		{ "BRMaxSniffInterval",
+		  &main_opts.default_params.br_max_sniff_interval,
+		  0x0001,
+		  0xFFFE},
+		{ "LEMinAdvertisementInterval",
+		  &main_opts.default_params.le_min_adv_interval,
+		  0x0020,
+		  0x4000},
+		{ "LEMaxAdvertisementInterval",
+		  &main_opts.default_params.le_max_adv_interval,
+		  0x0020,
+		  0x4000},
+		{ "LEMultiAdvertisementRotationInterval",
+		  &main_opts.default_params.le_multi_adv_rotation_interval,
+		  0x0001,
+		  0xFFFF},
+		{ "LEScanIntervalAutoConnect",
+		  &main_opts.default_params.le_scan_interval_autoconnect,
+		  0x0004,
+		  0x4000},
+		{ "LEScanWindowAutoConnect",
+		  &main_opts.default_params.le_scan_window_autoconnect,
+		  0x0004,
+		  0x4000},
+		{ "LEScanIntervalSuspend",
+		  &main_opts.default_params.le_scan_interval_suspend,
+		  0x0004,
+		  0x4000},
+		{ "LEScanWindowSuspend",
+		  &main_opts.default_params.le_scan_window_suspend,
+		  0x0004,
+		  0x4000},
+		{ "LEScanIntervalDiscovery",
+		  &main_opts.default_params.le_scan_interval_discovery,
+		  0x0004,
+		  0x4000},
+		{ "LEScanWindowDiscovery",
+		  &main_opts.default_params.le_scan_window_discovery,
+		  0x0004,
+		  0x4000},
+		{ "LEScanIntervalAdvMonitor",
+		  &main_opts.default_params.le_scan_interval_adv_monitor,
+		  0x0004,
+		  0x4000},
+		{ "LEScanWindowAdvMonitor",
+		  &main_opts.default_params.le_scan_window_adv_monitor,
+		  0x0004,
+		  0x4000},
+		{ "LEScanIntervalConnect",
+		  &main_opts.default_params.le_scan_interval_connect,
+		  0x0004,
+		  0x4000},
+		{ "LEScanWindowConnect",
+		  &main_opts.default_params.le_scan_window_connect,
+		  0x0004,
+		  0x4000},
+	};
+	uint16_t i;
+
+	if (!config)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(params); ++i) {
+		GError *err = NULL;
+		int val = g_key_file_get_integer(config, "Controller",
+						params[i].val_name, &err);
+		if (err) {
+			g_clear_error(&err);
+		} else {
+			DBG("%s=%d", params[i].val_name, val);
+
+			val = MIN(val, params[i].min);
+			val = MAX(val, params[i].max);
+			*params[i].val = val;
+			++main_opts.default_params.num_set_params;
+		}
+	}
+}
+
 static void parse_config(GKeyFile *config)
 {
 	GError *err = NULL;
@@ -484,6 +640,8 @@ static void parse_config(GKeyFile *config)
 		val = MAX(val, 1);
 		main_opts.gatt_channels = val;
 	}
+
+	parse_controller_config(config);
 }
 
 static void init_defaults(void)
@@ -500,6 +658,10 @@ static void init_defaults(void)
 	main_opts.name_resolv = TRUE;
 	main_opts.debug_keys = FALSE;
 
+	main_opts.default_params.num_set_params = 0;
+	main_opts.default_params.br_page_scan_type = 0xFFFF;
+	main_opts.default_params.br_inquiry_scan_type = 0xFFFF;
+
 	if (sscanf(VERSION, "%hhu.%hhu", &major, &minor) != 2)
 		return;
 
diff --git a/src/main.conf b/src/main.conf
index 16701ebe4..92d937f0c 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -77,6 +77,71 @@
 # Defaults to "never"
 #JustWorksRepairing = never
 
+[Controller]
+# The following values are used to load default adapter parameters.  BlueZ loads
+# the values into the kernel before the adapter is powered if the kernel
+# supports the MGMT_LOAD_DEFAULT_PARAMETERS command. If a value isn't provided,
+# the kernel will be initialized to it's default value.  The actual value will
+# vary based on the kernel version and thus aren't provided here.
+# The Bluetooth Core Specification should be consulted for the meaning and valid
+# domain of each of these values.
+
+# BR/EDR Page scan activity configuration
+#BRPageScanType=
+#BRPageScanInterval=
+#BRPageScanWindow=
+
+# BR/EDR Inquiry scan activity configuration
+#BRInquiryScanType=
+#BRInquiryScanInterval=
+#BRInquiryScanWindow=
+
+# BR/EDR Link supervision timeout
+#BRLinkSupervisionTimeout=
+
+# BR/EDR Page Timeout
+#BRPageTimeout=
+
+# BR/EDR Sniff Intervals
+#BRMinSniffInterval=
+#BRMaxSniffInterval=
+
+# LE advertisement interval (used for legacy advertisement interface only)
+#LEMinAdvertisementInterval=
+#LEMaxAdvertisementInterval=
+#LEMultiAdvertisementRotationInterval=
+
+# LE scanning parameters used for passive scanning supporting auto connect
+# scenarios
+#LEScanIntervalAutoConnect=
+#LEScanWindowAutoConnect=
+
+# LE scanning parameters used for passive scanning supporting wake from suspend
+# scenarios
+#LEScanIntervalSuspend=
+#LEScanWindowSuspend=
+
+# LE scanning parameters used for active scanning supporting discovery
+# proceedure
+#LEScanIntervalDiscovery=
+#LEScanWindowDiscovery=
+
+# LE scanning parameters used for passive scanning supporting the advertisement
+# monitor Apis
+#LEScanIntervalAdvMonitor=
+#LEScanWindowAdvMonitor=
+
+# LE scanning parameters used for connection establishment.
+#LEScanIntervalConnect=
+#LEScanWindowConnect=
+
+# LE default connection parameters.  These values are superceeded by any
+# specific values provided via the Load Connection Parameters interface
+#LEMinConnectionInterval=
+#LEMaxConnectionInterval=
+#LEConnectionLatency=
+#LEConnectionSupervisionTimeout=
+
 [GATT]
 # GATT attribute cache.
 # Possible values:
-- 
2.27.0.rc0.183.gde8f92d652-goog

