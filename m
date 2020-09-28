Return-Path: <SRS0=BM5K=DF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61317C2D0A8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Sep 2020 07:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F04D5221EC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Sep 2020 07:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gF9IbvI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgI1HoZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Sep 2020 03:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgI1HoZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Sep 2020 03:44:25 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F75C0613CE
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2020 00:44:25 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 8so236829pfx.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2020 00:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=UQh2y3XDTl/CA66aIVWliYnUFIAGI1AHGNC3aVVpJ74=;
        b=gF9IbvI5mG5R19CpLBhx+lMZblEkLCZ3x0DrxtPAKMxY7f+MK516UJ1EWG9Vbq+B/L
         P1lSCBtmnBiTyMdphHYz5f1/2t1qQuCo0MDvZQrEGbQPhneP1zn3yIEQez5vMPgZ8MDF
         oW/53hlO83v2w/InyRRJmG0GD2/PN0vNmwlZgwkHfZSCuzC5WMuP4qxEjF6oTSp3PhSg
         W2UqL/4aeexwiaPzTCJgP7AFaMztaAsRZRsEOC+KcIeK4txxEajBBmTVbQ5k8VbH0eJw
         Swe7+5jxoU0J4CViF4aM25KkoUtxzf/AVHncvFgTex4yONziUcTW/HPL/tjHf3RWa1At
         tTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UQh2y3XDTl/CA66aIVWliYnUFIAGI1AHGNC3aVVpJ74=;
        b=AxvJG//LbgTf9Z213dx4YWfFr/o2OxOm+XCGlKGKZKIvxWuaw50/mOhnhHIq55yRdy
         xbFoj51zdxXB+TprhABgs+i3D2mwluaS/zYuvfOpNyAbyfavP+AFR9n638ExE6VmAhCa
         SBooh2b4nvy83QMKSJMyb5I6jDieNh7nthbVur8h8ZTlhMEd5XviAY6WHKz1ap/oQ+cW
         3HROsTbes77ZRZBmXaAU59JUzmBIn+BoPhs2rxze+l0JnqGnqMY6a/wC8XJG/ksHRF4r
         s2M830G5cTlfDUY8XsHo6sYnKAW5vGA1NTDCLnbelkCghcGCbLqLn+APUKM4uF+V9GaG
         sV8w==
X-Gm-Message-State: AOAM530BcE+lPbablBSU+aVihja+a+tBEcw8GydgvdnkgF2mwRsPVpm8
        5smZbPX+9Q2oqFAsdZBf81cgXpfKus2eR+OW5onCTSz58+szQvlIQ/DDt4HXU10K5kEnuQONirx
        Up8PLAHznvA4yHSBrHt2DcJ57WTQzX5ESWcl+IgeHykbCwEUuTkIuO1jihYGKU+TDvrP8qJbt6b
        7WGc6nWl4i+1s=
X-Google-Smtp-Source: ABdhPJxeSjaOHaizN/6X6yDQDZM4y/hrxVAWAyw2ItaQtduXPLRL1o1Fxp47xCxKvNO3ONiK6oWN9gaFO6XR/aMdcw==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a17:902:6903:b029:d2:2503:e5c1 with
 SMTP id j3-20020a1709026903b02900d22503e5c1mr447845plk.60.1601279064660; Mon,
 28 Sep 2020 00:44:24 -0700 (PDT)
Date:   Mon, 28 Sep 2020 15:44:02 +0800
In-Reply-To: <20200928154344.BlueZ.v4.1.I1f083629d41c747a33a3937fbc199ea37dccde12@changeid>
Message-Id: <20200928154344.BlueZ.v4.2.Iac5207375d22fb7b96ae4ef73b49ae4ab457219c@changeid>
Mime-Version: 1.0
References: <20200928154344.BlueZ.v4.1.I1f083629d41c747a33a3937fbc199ea37dccde12@changeid>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [BlueZ PATCH v4 2/3] core: Add param to disable interleave scan
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, mmandlik@chromium.org, mcchou@chromium.org,
        alainm@chromium.org, Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds parameter to enable/disable the interleave scan feature.
---

Changes in v4:
- Set type of EnableAdvMonInterleaveScan to u8

Changes in v3:
- Set EnableAdvMonInterleaveScan default to Disable

 src/adapter.c | 10 ++++++++++
 src/hcid.h    |  1 +
 src/main.c    |  6 ++++++
 src/main.conf |  6 ++++++
 4 files changed, 23 insertions(+)

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
index 38f193a093df..bcdde069d843 100644
--- a/src/main.c
+++ b/src/main.c
@@ -112,6 +112,7 @@ static const char *controller_options[] = {
 	"LEAutoconnecttimeout",
 	"AdvMonAllowlistScanDuration",
 	"AdvMonNoFilterScanDuration",
+	"EnableAdvMonInterleaveScan",
 	NULL
 };
 
@@ -431,6 +432,10 @@ static void parse_controller_config(GKeyFile *config)
 		  &main_opts.default_params.advmon_no_filter_scan_duration,
 		  1,
 		  10000},
+		{ "EnableAdvMonInterleaveScan",
+		  &main_opts.default_params.enable_advmon_interleave_scan,
+		  0,
+		  1},
 	};
 	uint16_t i;
 
@@ -698,6 +703,7 @@ static void init_defaults(void)
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
2.28.0.681.g6f77f65b4e-goog

