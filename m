Return-Path: <SRS0=RRj3=DG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4D8C4346E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Sep 2020 10:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C779F207C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Sep 2020 10:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jE4ugx5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgI2K4Q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Sep 2020 06:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgI2K4Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Sep 2020 06:56:16 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA398C061755
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2020 03:56:14 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id a16so2647119qtj.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2020 03:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=GnzdACP512zgJlZNer+AWXbyoPMk47HIJPVn+VkAO1U=;
        b=jE4ugx5jScfBHZv2LYCYdO2ihvTPgOSodmCUr2Pct4X3tabrNoblDPSwTyHKCVc/w8
         UgareC4ZVPu/RN1gPUV2FoJKiFXQsBU+Iht3b7XViS/XSP2gmIMq1SRAssZjx30u0mNd
         GlCT/+EVArXmp2oZk/hlIDnaLGN4wk4FPOQnEci7TB6wi4/L6u3W4S8LxoOoiEKZUWy+
         RXungaDKodDX9+wptiDUtvbNV3/ut1dz0U2mWxgQLjGP68d+dcMzoSYPCsJ29uRVp0uZ
         meE7njYg6afr/6NORdFfWs6DpcAZzfK7yHkdf+bXx/uDvipksn7jWDiJHfTKE+EnIrge
         SWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GnzdACP512zgJlZNer+AWXbyoPMk47HIJPVn+VkAO1U=;
        b=pyg1XXVDcxgcNyBAJEPa0Jrla/Xa36zUaPj+ikddBcax1joEkWE5o//eY86DdtLXIs
         alPEqWPjYetDBzj1yGzq203XAIv7YpSlo/tHHRes+R9q3TNDbX0OBBkfbcKk1jk+H0Oa
         Rh6zyepEF/uHDswJ4Hju/JNg5GciPHOgkK3X9n9QEwac6O5XQDKf7tSMrJcYt5K7RoQj
         BsisNE/30GRV0Uo7rv6h9+azYf8SpDR6wIUv1DNcL879OHfHxmqx/lgt6RafYo1YGRCe
         hLra2MXFwnC0HNzKu4wfMS/TTfm87pdvml/84kTlMs+VmG7piy8Cg/dMMIEM7nukg6dk
         1Cmg==
X-Gm-Message-State: AOAM530cZYXwUq6OFjWxIGlqwVQ/wjDL+y3m4Rwg3Y47OadxTfucOxbv
        0fFt3s2VyEwYu5Ujmsy3y0jK7+XFKMZeplxzNI9AiHVoEx1xhY3qShRdBgXJCTcEaIlMrs1zb7O
        DD4KeIpD5E1091S4jmcXVJSbJ2B7MsgbbnaySDlR+YiHF2aKAt+HBHJzdzykiL8xfY3uEKySlpf
        GVmnFJLFDAs4o=
X-Google-Smtp-Source: ABdhPJx5BeGhe4R+VZuaFOsS/NYf7WyyPp/rCWtGTvaMAH4m5c4tk03DpalPt1aSSLp703wnUvTdX5jSefM5DZc77Q==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:ad4:41c4:: with SMTP id
 a4mr3670216qvq.60.1601376973698; Tue, 29 Sep 2020 03:56:13 -0700 (PDT)
Date:   Tue, 29 Sep 2020 18:56:03 +0800
In-Reply-To: <20200929185522.BlueZ.v5.1.I1f083629d41c747a33a3937fbc199ea37dccde12@changeid>
Message-Id: <20200929185522.BlueZ.v5.2.Iac5207375d22fb7b96ae4ef73b49ae4ab457219c@changeid>
Mime-Version: 1.0
References: <20200929185522.BlueZ.v5.1.I1f083629d41c747a33a3937fbc199ea37dccde12@changeid>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [BlueZ PATCH v5 2/3] core: Add param to disable interleave scan
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     mmandlik@chromium.org, luiz.dentz@gmail.com, alainm@chromium.org,
        mcchou@chromium.org, Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds parameter to enable/disable the interleave scan feature.
---

Changes in v5:
- Fix compile warning

Changes in v4:
- Set type of EnableAdvMonInterleaveScan to u8
- Add support of different sizes of parameters

Changes in v3:
- Set EnableAdvMonInterleaveScan default to Disable

 src/adapter.c | 10 ++++++++++
 src/hcid.h    |  1 +
 src/main.c    | 45 +++++++++++++++++++++++++++++++++++++++++++--
 src/main.conf |  6 ++++++
 4 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index f072541aad35..553db4aa8b1f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4169,6 +4169,7 @@ static void load_default_system_params(struct btd_adapter *adapter)
 		struct mgmt_tlv entry;
 		union {
 			uint16_t u16;
+			uint8_t  u8;
 		};
 	} __packed *params;
 	uint16_t i = 0;
@@ -4436,6 +4437,15 @@ static void load_default_system_params(struct btd_adapter *adapter)
 		len += sizeof(params[i].u16);
 	}
 
+	if (main_opts.default_params.enable_advmon_interleave_scan != 0xFF) {
+		params[i].entry.type = 0x001f;
+		params[i].entry.length = sizeof(params[i].u8);
+		params[i].u8 =
+			main_opts.default_params.enable_advmon_interleave_scan;
+		++i;
+		len += sizeof(params[i].u8);
+	}
+
 	err = mgmt_send(adapter->mgmt, MGMT_OP_SET_DEF_SYSTEM_CONFIG,
 			adapter->dev_id, len, params, NULL, NULL, NULL);
 	if (!err)
diff --git a/src/hcid.h b/src/hcid.h
index 713eab8e03ae..34d22b3470f9 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -83,6 +83,7 @@ struct main_opts {
 
 		uint16_t	advmon_allowlist_scan_duration;
 		uint16_t	advmon_no_filter_scan_duration;
+		uint8_t		enable_advmon_interleave_scan;
 	} default_params;
 
 
diff --git a/src/main.c b/src/main.c
index 38f193a093df..274af6bdcc0f 100644
--- a/src/main.c
+++ b/src/main.c
@@ -112,6 +112,7 @@ static const char *controller_options[] = {
 	"LEAutoconnecttimeout",
 	"AdvMonAllowlistScanDuration",
 	"AdvMonNoFilterScanDuration",
+	"EnableAdvMonInterleaveScan",
 	NULL
 };
 
@@ -307,130 +308,169 @@ static void parse_controller_config(GKeyFile *config)
 {
 	static const struct {
 		const char * const val_name;
-		uint16_t * const val;
+		void * const val;
+		const size_t size;
 		const uint16_t min;
 		const uint16_t max;
 	} params[] = {
 		{ "BRPageScanType",
 		  &main_opts.default_params.br_page_scan_type,
+		  sizeof(main_opts.default_params.br_page_scan_type),
 		  0,
 		  1},
 		{ "BRPageScanInterval",
 		  &main_opts.default_params.br_page_scan_interval,
+		  sizeof(main_opts.default_params.br_page_scan_interval),
 		  0x0012,
 		  0x1000},
 		{ "BRPageScanWindow",
 		  &main_opts.default_params.br_page_scan_win,
+		  sizeof(main_opts.default_params.br_page_scan_win),
 		  0x0011,
 		  0x1000},
 		{ "BRInquiryScanType",
 		  &main_opts.default_params.br_scan_type,
+		  sizeof(main_opts.default_params.br_scan_type),
 		  0,
 		  1},
 		{ "BRInquiryScanInterval",
 		  &main_opts.default_params.br_scan_interval,
+		  sizeof(main_opts.default_params.br_scan_interval),
 		  0x0012,
 		  0x1000},
 		{ "BRInquiryScanWindow",
 		  &main_opts.default_params.br_scan_win,
+		  sizeof(main_opts.default_params.br_scan_win),
 		  0x0011,
 		  0x1000},
 		{ "BRLinkSupervisionTimeout",
 		  &main_opts.default_params.br_link_supervision_timeout,
+		  sizeof(main_opts.default_params.br_link_supervision_timeout),
 		  0x0001,
 		  0xFFFF},
 		{ "BRPageTimeout",
 		  &main_opts.default_params.br_page_timeout,
+		  sizeof(main_opts.default_params.br_page_scan_win),
 		  0x0001,
 		  0xFFFF},
 		{ "BRMinSniffInterval",
 		  &main_opts.default_params.br_min_sniff_interval,
+		  sizeof(main_opts.default_params.br_min_sniff_interval),
 		  0x0001,
 		  0xFFFE},
 		{ "BRMaxSniffInterval",
 		  &main_opts.default_params.br_max_sniff_interval,
+		  sizeof(main_opts.default_params.br_max_sniff_interval),
 		  0x0001,
 		  0xFFFE},
 		{ "LEMinAdvertisementInterval",
 		  &main_opts.default_params.le_min_adv_interval,
+		  sizeof(main_opts.default_params.le_min_adv_interval),
 		  0x0020,
 		  0x4000},
 		{ "LEMaxAdvertisementInterval",
 		  &main_opts.default_params.le_max_adv_interval,
+		  sizeof(main_opts.default_params.le_max_adv_interval),
 		  0x0020,
 		  0x4000},
 		{ "LEMultiAdvertisementRotationInterval",
 		  &main_opts.default_params.le_multi_adv_rotation_interval,
+		  sizeof(main_opts.default_params.
+						le_multi_adv_rotation_interval),
 		  0x0001,
 		  0xFFFF},
 		{ "LEScanIntervalAutoConnect",
 		  &main_opts.default_params.le_scan_interval_autoconnect,
+		  sizeof(main_opts.default_params.le_scan_interval_autoconnect),
 		  0x0004,
 		  0x4000},
 		{ "LEScanWindowAutoConnect",
 		  &main_opts.default_params.le_scan_win_autoconnect,
+		  sizeof(main_opts.default_params.le_scan_win_autoconnect),
 		  0x0004,
 		  0x4000},
 		{ "LEScanIntervalSuspend",
 		  &main_opts.default_params.le_scan_interval_suspend,
+		  sizeof(main_opts.default_params.le_scan_interval_suspend),
 		  0x0004,
 		  0x4000},
 		{ "LEScanWindowSuspend",
 		  &main_opts.default_params.le_scan_win_suspend,
+		  sizeof(main_opts.default_params.le_scan_win_suspend),
 		  0x0004,
 		  0x4000},
 		{ "LEScanIntervalDiscovery",
 		  &main_opts.default_params.le_scan_interval_discovery,
+		  sizeof(main_opts.default_params.le_scan_interval_discovery),
 		  0x0004,
 		  0x4000},
 		{ "LEScanWindowDiscovery",
 		  &main_opts.default_params.le_scan_win_discovery,
+		  sizeof(main_opts.default_params.le_scan_win_discovery),
 		  0x0004,
 		  0x4000},
 		{ "LEScanIntervalAdvMonitor",
 		  &main_opts.default_params.le_scan_interval_adv_monitor,
+		  sizeof(main_opts.default_params.le_scan_interval_adv_monitor),
 		  0x0004,
 		  0x4000},
 		{ "LEScanWindowAdvMonitor",
 		  &main_opts.default_params.le_scan_win_adv_monitor,
+		  sizeof(main_opts.default_params.le_scan_win_adv_monitor),
 		  0x0004,
 		  0x4000},
 		{ "LEScanIntervalConnect",
 		  &main_opts.default_params.le_scan_interval_connect,
+		  sizeof(main_opts.default_params.le_scan_interval_connect),
 		  0x0004,
 		  0x4000},
 		{ "LEScanWindowConnect",
 		  &main_opts.default_params.le_scan_win_connect,
+		  sizeof(main_opts.default_params.le_scan_win_connect),
 		  0x0004,
 		  0x4000},
 		{ "LEMinConnectionInterval",
 		  &main_opts.default_params.le_min_conn_interval,
+		  sizeof(main_opts.default_params.le_min_conn_interval),
 		  0x0006,
 		  0x0C80},
 		{ "LEMaxConnectionInterval",
 		  &main_opts.default_params.le_max_conn_interval,
+		  sizeof(main_opts.default_params.le_max_conn_interval),
 		  0x0006,
 		  0x0C80},
 		{ "LEConnectionLatency",
 		  &main_opts.default_params.le_conn_latency,
+		  sizeof(main_opts.default_params.le_conn_latency),
 		  0x0000,
 		  0x01F3},
 		{ "LEConnectionSupervisionTimeout",
 		  &main_opts.default_params.le_conn_lsto,
+		  sizeof(main_opts.default_params.le_conn_lsto),
 		  0x000A,
 		  0x0C80},
 		{ "LEAutoconnecttimeout",
 		  &main_opts.default_params.le_autoconnect_timeout,
+		  sizeof(main_opts.default_params.le_autoconnect_timeout),
 		  0x0001,
 		  0x4000},
 		{ "AdvMonAllowlistScanDuration",
 		  &main_opts.default_params.advmon_allowlist_scan_duration,
+		  sizeof(main_opts.default_params.
+						advmon_allowlist_scan_duration),
 		  1,
 		  10000},
 		{ "AdvMonNoFilterScanDuration",
 		  &main_opts.default_params.advmon_no_filter_scan_duration,
+		  sizeof(main_opts.default_params.br_page_scan_win),
 		  1,
 		  10000},
+		{ "EnableAdvMonInterleaveScan",
+		  &main_opts.default_params.enable_advmon_interleave_scan,
+		  sizeof(main_opts.default_params.
+						enable_advmon_interleave_scan),
+		  0,
+		  1},
 	};
 	uint16_t i;
 
@@ -449,7 +489,7 @@ static void parse_controller_config(GKeyFile *config)
 
 			val = MAX(val, params[i].min);
 			val = MIN(val, params[i].max);
-			*params[i].val = val;
+			memcpy(params[i].val, &val, params[i].size);
 			++main_opts.default_params.num_entries;
 		}
 	}
@@ -698,6 +738,7 @@ static void init_defaults(void)
 	main_opts.default_params.num_entries = 0;
 	main_opts.default_params.br_page_scan_type = 0xFFFF;
 	main_opts.default_params.br_scan_type = 0xFFFF;
+	main_opts.default_params.enable_advmon_interleave_scan = 0xFF;
 
 	if (sscanf(VERSION, "%hhu.%hhu", &major, &minor) != 2)
 		return;
diff --git a/src/main.conf b/src/main.conf
index 3b341f44c9cf..82ffc5813204 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -159,6 +159,12 @@
 # Default: 500
 #AdvMonNoFilterScanDuration=
 
+# Enable/Disable Advertisement Monitor interleave scan for power saving.
+# 0: disable
+# 1: enable
+# Defaults to 0
+#EnableAdvMonInterleaveScan=
+
 [GATT]
 # GATT attribute cache.
 # Possible values:
-- 
2.28.0.709.gb0816b6eb0-goog

