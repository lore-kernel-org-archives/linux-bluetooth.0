Return-Path: <SRS0=Q1DV=EF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FE6C56201
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Oct 2020 09:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F4420825
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Oct 2020 09:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IaCjmUwb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgJ3JVE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Oct 2020 05:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgJ3JVE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Oct 2020 05:21:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE0CC0613D4
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2020 02:11:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u13so5531690ybk.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2020 02:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=KnDpF4ZW5zBRAqzn7DevZ/tCs2YZnFFcAdaI748CGpI=;
        b=IaCjmUwbZNkqO+t9ySvwALKn5xlGcVpSwa0hnY8rEPzvM00OxoKLbu4xMTplcnoT26
         fbM7SElX2p3oAB4IT9qTGr2WX0G0spjkqmrPhcYvAbWXCqN1429ArihV+qEIW3jzOizt
         42LkzlPkIb9aW5tjznBpklnIXSdUIAZU26YxIzE83Ko+sbHS9DTc615EEV1Xh4ghQQfh
         lRCQwJ8gyPtF7VFPmzWl1r8q2LqLq4a2otcIoxGzGpstZhO13J/AaTyPK0YISjhUSz5f
         yVvU5KmOfH1zQteX7CgqT8bwUNV9gP664XjjtvxTcrN4RhUtAAQhM20Or4308VsbPEPQ
         ptiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KnDpF4ZW5zBRAqzn7DevZ/tCs2YZnFFcAdaI748CGpI=;
        b=LqYKXtE+RpJtSf2K3Tkf91xV2qbq5VWvbSz9YaDCkY5lFnyKZhtqTCZmRaVLCJfl+c
         TdLtLpHyN5w5YVViyKdBUl9wtCJMo0TKUnBBdPTj58ObU5FQJdzzsrCYo4aXDr6qi5uX
         tdjUQQEOZj3A9jUs6RQ7c1vdf3PU7JW3bl8tlttZQ+qz/ZE6/LDQ8YB3zep5kw482yRz
         eJtYmC2cOlIYb8FMUJ1dSldtjHfCdAAbb/KWkJwKHKFNgPbHgtAJ8EXsngDJ09Uuducf
         IAyhdF0FwD7jDKe8aW3Hj4hrF64CnytfIpYybsyshTSNiOaz4XqG4xzLQ6MRpxegf2td
         CXXg==
X-Gm-Message-State: AOAM532kjmgzHIUV+Q/RD2ulr3xTdRbv97rmuNb4Q1G1Jj1ZBSaV6LRf
        /ie+egDKktyv7DKC99Q4YH3ZJiHAZbA8rMGyOlbLbmZdnn3bvCVxznAa6fz/ZeZ7jj2dYUun23z
        Z77KZi81jYg8xoe574/tgBcTb4YWjOXKvaK7Xu3SyvoYwsMA89rHexVaBIoXDYm+OgemnkQCIm2
        p4ICpmlS59CoA=
X-Google-Smtp-Source: ABdhPJxeJHgeXhMAvb5hd83iG6BCC1+iegzQU/WgqjTg+d3kQdGAOL3HWmHJHu6UsKErzTKXMr3ZYEGR8xf64K3mJw==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a25:3303:: with SMTP id
 z3mr2196340ybz.9.1604049075179; Fri, 30 Oct 2020 02:11:15 -0700 (PDT)
Date:   Fri, 30 Oct 2020 17:11:01 +0800
In-Reply-To: <20201030170932.BlueZ.v2.1.I1f083629d41c747a33a3937fbc199ea37dccde12@changeid>
Message-Id: <20201030170932.BlueZ.v2.2.Iac5207375d22fb7b96ae4ef73b49ae4ab457219c@changeid>
Mime-Version: 1.0
References: <20201030170932.BlueZ.v2.1.I1f083629d41c747a33a3937fbc199ea37dccde12@changeid>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [BlueZ PATCH v2 2/3] core: Add param to disable interleave scan
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

Changes in v2:
- set enable_advmon_interleave_scan to uint8_t

 src/adapter.c | 6 ++++++
 src/btd.h     | 1 +
 src/main.c    | 7 +++++++
 src/main.conf | 6 ++++++
 4 files changed, 20 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index bdfe41d7e88c..c7b2e0233639 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4354,6 +4354,12 @@ static void load_default_system_params(struct btd_adapter *adapter)
 			goto done;
 	}
 
+	if (btd_opts.defaults.le.enable_advmon_interleave_scan != 0xFF) {
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x001f,
+				&btd_opts.defaults.le.enable_advmon_interleave_scan))
+			goto done;
+	}
+
 	err = mgmt_send_tlv(adapter->mgmt, MGMT_OP_SET_DEF_SYSTEM_CONFIG,
 			adapter->dev_id, tlv_list, NULL, NULL, NULL);
 
diff --git a/src/btd.h b/src/btd.h
index b0df77fe3ab3..c98414e35529 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -74,6 +74,7 @@ struct btd_le_defaults {
 
 	uint16_t	advmon_allowlist_scan_duration;
 	uint16_t	advmon_no_filter_scan_duration;
+	uint8_t		enable_advmon_interleave_scan;
 };
 
 struct btd_defaults {
diff --git a/src/main.c b/src/main.c
index 47887a4059a1..9bbfba2f09c0 100644
--- a/src/main.c
+++ b/src/main.c
@@ -116,6 +116,7 @@ static const char *le_options[] = {
 	"Autoconnecttimeout",
 	"AdvMonAllowlistScanDuration",
 	"AdvMonNoFilterScanDuration",
+	"EnableAdvMonInterleaveScan",
 	NULL
 };
 
@@ -509,6 +510,11 @@ static void parse_le_config(GKeyFile *config)
 		  sizeof(btd_opts.defaults.le.advmon_no_filter_scan_duration),
 		  1,
 		  10000},
+		{ "EnableAdvMonInterleaveScan",
+		  &btd_opts.defaults.le.enable_advmon_interleave_scan,
+		  sizeof(btd_opts.defaults.le.enable_advmon_interleave_scan),
+		  0,
+		  1},
 	};
 
 	if (btd_opts.mode == BT_MODE_BREDR)
@@ -761,6 +767,7 @@ static void init_defaults(void)
 	btd_opts.defaults.num_entries = 0;
 	btd_opts.defaults.br.page_scan_type = 0xFFFF;
 	btd_opts.defaults.br.scan_type = 0xFFFF;
+	btd_opts.defaults.le.enable_advmon_interleave_scan = 0xFF;
 
 	if (sscanf(VERSION, "%hhu.%hhu", &major, &minor) != 2)
 		return;
diff --git a/src/main.conf b/src/main.conf
index a3f2020b04dc..54f6a36bd991 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -167,6 +167,12 @@
 # Default: 500
 #AdvMonNoFilterScanDuration=
 
+# Enable/Disable Advertisement Monitor interleave scan for power saving.
+# 0: disable
+# 1: enable
+# Defaults to 1
+#EnableAdvMonInterleaveScan=
+
 [GATT]
 # GATT attribute cache.
 # Possible values:
-- 
2.29.1.341.ge80a0c044ae-goog

