Return-Path: <SRS0=Q1DV=EF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F734C55179
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Oct 2020 09:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEDCA20825
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Oct 2020 09:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZLZYs3yB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgJ3JVG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Oct 2020 05:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgJ3JVF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Oct 2020 05:21:05 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE1AC0613D2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2020 02:11:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a12so5595225ybc.20
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2020 02:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Ro1tGHllJsXx0VhhU/CbeMUu9vrpptndMHkugcz+pvM=;
        b=ZLZYs3yBGgn6xU5y6g77/GbGk2fRMbwhKeFkM4QQxL0CQzbiGqshNFgFeq3iQhUX+V
         pdi/hxwbG5xL8oY+2uqrf/0lCEotMyYuBH7O26Yy+mN0dC10fFa7oSS775qQe5eVIxS7
         y3W7bngGchi93TRR0xnOjkglvlTdkF/m5r1XOUpd5/bz/YC1/0xWAuAqdE5YHGyzNLoT
         czy7GqXfqRgWUppLjzg9ugQSCSBXxpwttoTA9zMXhCa9aRn/Gq9+qmPGLKXSA7tUpdNO
         YsseaqVbfZDC9vkaO+2j0z/xysO6KEAR0mt8xMVQKyROABmlPsjkRSAIhS3yik0TfLI8
         ZsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Ro1tGHllJsXx0VhhU/CbeMUu9vrpptndMHkugcz+pvM=;
        b=cb1hSlnejgj6IDtShQKG92W/iHtkwl/vxZdyQEcBLeyMZb7M7lcQKJw9WrARb5lKLc
         OWN5ZzntkaO5Y1mw9xQkHKTktgHnncUmeBxSwHt3zlI3VFC0lNJhlC6hUxyU09OKGbv6
         oEiRfX+OV9/GgU/RVgtWIx4nJZEP7fTP9UCCjtZNqk9VudlyRkfWnGsVZULy1XJbCe7T
         fmTJwhl0nDPbMRThM3/IqpkHOwgL87g/b+pzaUZs1hw87e6iFEJzL591S/c2o2j8UEVL
         l2JM/LjXlLGmiY4FerwVch1gM6m6TFFlwY9nZf8Lu36RO4OvfkhPrXBkb8lnnkUyrvqx
         /WUg==
X-Gm-Message-State: AOAM5313mD0Ef7Tn7E+jhglNgZvfGPiIaihyqxq4vpUlpliahoEb66Wt
        WaxqjFH9pWx7d/+vsgQ54qwHsV6Wd3FYw53bU+U7NaghZYW2iYEDJ8pG362lmeMmTdiqCSj3SUi
        5lC9e2FnMrCjX9sSLBnAdhCCUbPrtCOc8bwlQOML1EPm6o5C/MYsNSEnn3Gz7ivXx/F4N88fyCT
        n3WaNS75CSFKE=
X-Google-Smtp-Source: ABdhPJyUsaNovpOuaYuxFmbKWlwunkWLCDoDdIOmLkuXrgHKQEMJS0frcZjEASi5xIhsApBhnsfKBg82MuKyRBQmsw==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a25:2311:: with SMTP id
 j17mr2129360ybj.362.1604049071280; Fri, 30 Oct 2020 02:11:11 -0700 (PDT)
Date:   Fri, 30 Oct 2020 17:11:00 +0800
Message-Id: <20201030170932.BlueZ.v2.1.I1f083629d41c747a33a3937fbc199ea37dccde12@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [BlueZ PATCH v2 1/3] core: Add parmas to set interleaving durations
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, mmandlik@chromium.org, mcchou@chromium.org,
        alainm@chromium.org, Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds parameters to control the durations of allowlist scan
and no-filter scan when the kernel is doing interleaving scan.
---

Changes in v2:
- re-implement on new mgmt_tlv API

 src/adapter.c | 12 ++++++++++++
 src/btd.h     |  3 +++
 src/main.c    | 12 ++++++++++++
 src/main.conf |  7 +++++++
 4 files changed, 34 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index cac90b01bdc0..bdfe41d7e88c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4342,6 +4342,18 @@ static void load_default_system_params(struct btd_adapter *adapter)
 			goto done;
 	}
 
+	if (btd_opts.defaults.le.advmon_allowlist_scan_duration) {
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x001d,
+				&btd_opts.defaults.le.advmon_allowlist_scan_duration))
+			goto done;
+	}
+
+	if (btd_opts.defaults.le.advmon_no_filter_scan_duration) {
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x001e,
+				&btd_opts.defaults.le.advmon_no_filter_scan_duration))
+			goto done;
+	}
+
 	err = mgmt_send_tlv(adapter->mgmt, MGMT_OP_SET_DEF_SYSTEM_CONFIG,
 			adapter->dev_id, tlv_list, NULL, NULL, NULL);
 
diff --git a/src/btd.h b/src/btd.h
index 4cd117538fda..b0df77fe3ab3 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -71,6 +71,9 @@ struct btd_le_defaults {
 	uint16_t	conn_latency;
 	uint16_t	conn_lsto;
 	uint16_t	autoconnect_timeout;
+
+	uint16_t	advmon_allowlist_scan_duration;
+	uint16_t	advmon_no_filter_scan_duration;
 };
 
 struct btd_defaults {
diff --git a/src/main.c b/src/main.c
index 0ae45015fbe8..47887a4059a1 100644
--- a/src/main.c
+++ b/src/main.c
@@ -114,6 +114,8 @@ static const char *le_options[] = {
 	"ConnectionLatency",
 	"ConnectionSupervisionTimeout",
 	"Autoconnecttimeout",
+	"AdvMonAllowlistScanDuration",
+	"AdvMonNoFilterScanDuration",
 	NULL
 };
 
@@ -497,6 +499,16 @@ static void parse_le_config(GKeyFile *config)
 		  sizeof(btd_opts.defaults.le.autoconnect_timeout),
 		  0x0001,
 		  0x4000},
+		{ "AdvMonAllowlistScanDuration",
+		  &btd_opts.defaults.le.advmon_allowlist_scan_duration,
+		  sizeof(btd_opts.defaults.le.advmon_allowlist_scan_duration),
+		  1,
+		  10000},
+		{ "AdvMonNoFilterScanDuration",
+		  &btd_opts.defaults.le.advmon_no_filter_scan_duration,
+		  sizeof(btd_opts.defaults.le.advmon_no_filter_scan_duration),
+		  1,
+		  10000},
 	};
 
 	if (btd_opts.mode == BT_MODE_BREDR)
diff --git a/src/main.conf b/src/main.conf
index 1b349821294b..a3f2020b04dc 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -160,6 +160,13 @@
 #ConnectionSupervisionTimeout=
 #Autoconnecttimeout=
 
+# Scan duration during interleaving scan. Only used when scanning for ADV
+# monitors. The units are msec.
+# Default: 300
+#AdvMonAllowlistScanDuration=
+# Default: 500
+#AdvMonNoFilterScanDuration=
+
 [GATT]
 # GATT attribute cache.
 # Possible values:
-- 
2.29.1.341.ge80a0c044ae-goog

