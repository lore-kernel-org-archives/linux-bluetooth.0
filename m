Return-Path: <SRS0=5m6h=C6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086DFC43463
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Sep 2020 04:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFAFF2086A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Sep 2020 04:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lqb4N6fL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgIUE2g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Sep 2020 00:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgIUE2g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Sep 2020 00:28:36 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02760C061755
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2020 21:28:35 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id w126so10170719qka.5
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2020 21:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=V8nNi7zfmcWJJjBYsa7DjWc16mvd/UtWiaZva2BXHgE=;
        b=lqb4N6fL0sItNVV8DWKGgfLE/zT1KXXeTlk29E0gOvYCRNKPNbdki11MZktr0uLVxw
         f2QlTJR7POPDqerDyLMyGYVqIycXp5z3nc3LgypAvlzbuY109MmzqhE6bE5KErFXYGbY
         DbnPtbmRxk4gnSaGzennP6V7TjpZXV4YObCU6eNCqArC2zw4pp3OBYNo7ZGkp+Ka+RKs
         gH20VG2KWDgEKUMnvoYvoUE9ZHt3gdn3W4dseMMPfKPZ1aABpbDLEt4fNEeEAn+RnR07
         MVClrUf7+nqq+CDWPMjAPYlGl04AQMD/a0hmmjTNPeC7nTncYcYptw6KPJTIukYeg8BO
         fuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=V8nNi7zfmcWJJjBYsa7DjWc16mvd/UtWiaZva2BXHgE=;
        b=UUG6akoDWUa7d3bjda/8aT1fV6Zyb+utZMryGJ1bQczY74WyJPT+3bzooBLHEdOVbe
         zBdTi4lwrNAAqEN5gX8vvxPzfNpV6eTQR9mXzj/P6/zwqx1Dxi8Ah3RQm05+hNMuZJRj
         WeqUguXaIuf05tOHV/LCeuKo0Qroq2+sntdjbmVve/u00gjuUZbyAmwbsofwybRkZvlU
         0iVlb65K1lcjRybp/I95Wm5yy46Ki7T7+jpFJc4LS52kfs37SckQa3BJAwn//u5aAbG7
         gVs9XxHKvZXsz3VcI5S5LP7YYOiQlL4lcvVPo8rX0bG00KgVKr8tC51P/WgQb6q2H9s3
         3LPg==
X-Gm-Message-State: AOAM532Sua4fV/SWKd8fR5jwxA6m87xm8dHzsewn3+/mh0ahpPf+86Du
        JSHsPK6dVm2Dnd6VGgrMNz31brwc90FYUvuQ1ku0s19Hk713Vh+0v9EhS9gb0f74FWHcrfkLjBr
        F60JA5JrOhB6usWIBZJyZgXmqR/e2/kNoo9ZhVEuK+m/hTgwz4v1OQhXzDKWA9Cq3uBcVRUOLxk
        +X9ybhg6h0s8E=
X-Google-Smtp-Source: ABdhPJwsAJTnQm1wxIx73RJv0k0QkSIb5hZiOq8/hchJfxuEMhsncumiYFjWHkhedMdb+kWEruilz6kMptPjAdDUwQ==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:ad4:57cc:: with SMTP id
 y12mr28804449qvx.48.1600662515000; Sun, 20 Sep 2020 21:28:35 -0700 (PDT)
Date:   Mon, 21 Sep 2020 12:28:24 +0800
In-Reply-To: <20200921042824.1265006-1-howardchung@google.com>
Message-Id: <20200921122757.BlueZ.v3.2.Iac5207375d22fb7b96ae4ef73b49ae4ab457219c@changeid>
Mime-Version: 1.0
References: <20200921042824.1265006-1-howardchung@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [BlueZ PATCH v3 2/2] core: Add param to disable interleave scan
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     mcchou@chromium.org, mmandlik@chromium.org, luiz.dentz@gmail.com,
        alainm@chromium.org, Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds parameter to enable/disable the interleave scan feature.
---

Changes in v3:
- Set EnableAdvMonInterleaveScan default to Disable

 src/adapter.c | 9 +++++++++
 src/hcid.h    | 1 +
 src/main.c    | 6 ++++++
 src/main.conf | 6 ++++++
 4 files changed, 22 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index c0e95b48a1c4..a2c782e308bb 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4449,6 +4449,15 @@ static void load_default_system_params(struct btd_adapter *adapter)
 		len += sizeof(params[i].u16);
 	}
 
+	if (main_opts.default_params.enable_advmon_interleave_scan != 0xFFFF) {
+		params[i].entry.type = 0x001f;
+		params[i].entry.length = sizeof(params[i].u16);
+		params[i].u16 =
+			main_opts.default_params.enable_advmon_interleave_scan;
+		++i;
+		len += sizeof(params[i].u16);
+	}
+
 	err = mgmt_send(adapter->mgmt, MGMT_OP_SET_DEF_SYSTEM_CONFIG,
 			adapter->dev_id, len, params, NULL, NULL, NULL);
 	if (!err)
diff --git a/src/hcid.h b/src/hcid.h
index c3e5fe803543..c6717be62c48 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -96,6 +96,7 @@ struct main_opts {
 
 		uint16_t	advmon_allowlist_scan_duration;
 		uint16_t	advmon_no_filter_scan_duration;
+		uint16_t	enable_advmon_interleave_scan;
 	} default_params;
 
 
diff --git a/src/main.c b/src/main.c
index e222ed3bf855..3433130bc419 100644
--- a/src/main.c
+++ b/src/main.c
@@ -125,6 +125,7 @@ static const char *controller_options[] = {
 	"LEAutoconnecttimeout",
 	"AdvMonAllowlistScanDuration",
 	"AdvMonNoFilterScanDuration",
+	"EnableAdvMonInterleaveScan",
 	NULL
 };
 
@@ -444,6 +445,10 @@ static void parse_controller_config(GKeyFile *config)
 		  &main_opts.default_params.advmon_no_filter_scan_duration,
 		  1,
 		  10000},
+		{ "EnableAdvMonInterleaveScan",
+		  &main_opts.default_params.enable_advmon_interleave_scan,
+		  0,
+		  1},
 	};
 	uint16_t i;
 
@@ -711,6 +716,7 @@ static void init_defaults(void)
 	main_opts.default_params.num_entries = 0;
 	main_opts.default_params.br_page_scan_type = 0xFFFF;
 	main_opts.default_params.br_scan_type = 0xFFFF;
+	main_opts.default_params.enable_advmon_interleave_scan = 0xFFFF;
 
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

