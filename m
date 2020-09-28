Return-Path: <SRS0=BM5K=DF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BA4C2D0A8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Sep 2020 07:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CEA3221EC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Sep 2020 07:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hvzD2DDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgI1HoW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Sep 2020 03:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgI1HoV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Sep 2020 03:44:21 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9451AC0613CE
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2020 00:44:21 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id i17so119605qvj.22
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2020 00:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=mJ5L5MriFE0YUPrbIn/gTQRHRCzqViv38cjaWaeup20=;
        b=hvzD2DDpNIZ+kcoW0RtwyoRAxnzDIXg12eF4DnySqx2Zc782VH4TJD/SFxyag5lCy6
         H/gzSUqHBA/Nm1h5FAUADwHrgn3O2uiOeNAwJ/esJ3HiUcU9DpGRbtVed5ybBommswqE
         dSZ3Xy1fYZMUH7fboNfg7RwbiTN8TTOBo+O0NsOtGFceOtbmWVfCbaXhLNjPgV01+3X6
         5QGESaB+Ry7JCGKQk4nQF6Cqd9gJjA5UfPivZXxrvz1uOtiFhh83TPOOQkwH7sIJDAYd
         D3sd4cNa1d/wfuMSh/ud67x70w2MUKYwFmfRfFhtKEOlRn7BQsXFXJJFAu0Y3cP5kYfu
         y3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=mJ5L5MriFE0YUPrbIn/gTQRHRCzqViv38cjaWaeup20=;
        b=TlKHymCVPL6zEZJMa6yXqD4GEIrvVDkdBuwEwlgjdRNBzwrVP7/e2E5cDmbRANFZw0
         8YUa4upqOM/Ixs5z5HPlE5ZR3hKS2C933J5y5hCV21KykMqAsSSrl5sl3jJ0NSUoPFTI
         p/+pxJ8sjv1pbINR90kQkIRieTdy5XxZ8FvF71JFLXQRWgJc12Y9aKS2vqYQG7nyKH5Q
         lKxL90EyUyA2Qjj7zAqR3DjyenOoDl6jOsfw2iWjOYRlGDbmpMu3iHVuCiUmccpuJ+pY
         hULuAcZi6bSsSUtS/w/dajPl9kJJrOBYwaiC/XuYr6k3Y6ZXILEh/5pC1G26JdgqScc6
         5acQ==
X-Gm-Message-State: AOAM532MqrfPzjFtPBgdiyiRG/D3X8nILWjfINQj+Uq2uttsEm7d8jJi
        kMLRswcsi8UuDgY4p1rpXonaOnnmSXd0x0xwwY5b5T58XiSWfAoPw1d7UUXZpp+Q8n5xwm7aC8X
        J3j+lINMs9ZHgLxlz3BNagiyxgwJMhN0zJbncpngxXKHNUSRN28WPxajmpBLSj+m9+qDOqN+J7T
        vxaWpan+Ku0Ak=
X-Google-Smtp-Source: ABdhPJyvAjjX6DdowSsi3VkAiYYvO91Q88PMRLmSLScta9KHxq7LIKymsvAv5bVgqHgjFdAcFmsWsZIIyM6PJTJDDg==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a0c:e892:: with SMTP id
 b18mr10702414qvo.5.1601279060685; Mon, 28 Sep 2020 00:44:20 -0700 (PDT)
Date:   Mon, 28 Sep 2020 15:44:01 +0800
Message-Id: <20200928154344.BlueZ.v4.1.I1f083629d41c747a33a3937fbc199ea37dccde12@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [BlueZ PATCH v4 1/3] core: Add params to set interleaving durations
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

Changes in v4:
- Change type of EnableAdvMonInterleaveScan default to u8
- Add a patch for doc/mgmt-api.txt

Changes in v3:
- Set EnableAdvMonInterleaveScan default to Disable

Changes in v2:
- Fix typo in the commit title

 src/adapter.c | 18 ++++++++++++++++++
 src/hcid.h    |  3 +++
 src/main.c    | 10 ++++++++++
 src/main.conf |  7 +++++++
 4 files changed, 38 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index c0053000ac19..f072541aad35 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4418,6 +4418,24 @@ static void load_default_system_params(struct btd_adapter *adapter)
 		len += sizeof(params[i].u16);
 	}
 
+	if (main_opts.default_params.advmon_allowlist_scan_duration) {
+		params[i].entry.type = 0x001d;
+		params[i].entry.length = sizeof(params[i].u16);
+		params[i].u16 =
+			main_opts.default_params.advmon_allowlist_scan_duration;
+		++i;
+		len += sizeof(params[i].u16);
+	}
+
+	if (main_opts.default_params.advmon_no_filter_scan_duration) {
+		params[i].entry.type = 0x001e;
+		params[i].entry.length = sizeof(params[i].u16);
+		params[i].u16 =
+			main_opts.default_params.advmon_no_filter_scan_duration;
+		++i;
+		len += sizeof(params[i].u16);
+	}
+
 	err = mgmt_send(adapter->mgmt, MGMT_OP_SET_DEF_SYSTEM_CONFIG,
 			adapter->dev_id, len, params, NULL, NULL, NULL);
 	if (!err)
diff --git a/src/hcid.h b/src/hcid.h
index 95d4b9665193..713eab8e03ae 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -80,6 +80,9 @@ struct main_opts {
 		uint16_t	le_conn_latency;
 		uint16_t	le_conn_lsto;
 		uint16_t	le_autoconnect_timeout;
+
+		uint16_t	advmon_allowlist_scan_duration;
+		uint16_t	advmon_no_filter_scan_duration;
 	} default_params;
 
 
diff --git a/src/main.c b/src/main.c
index 77be776686a8..38f193a093df 100644
--- a/src/main.c
+++ b/src/main.c
@@ -110,6 +110,8 @@ static const char *controller_options[] = {
 	"LEConnectionLatency",
 	"LEConnectionSupervisionTimeout",
 	"LEAutoconnecttimeout",
+	"AdvMonAllowlistScanDuration",
+	"AdvMonNoFilterScanDuration",
 	NULL
 };
 
@@ -421,6 +423,14 @@ static void parse_controller_config(GKeyFile *config)
 		  &main_opts.default_params.le_autoconnect_timeout,
 		  0x0001,
 		  0x4000},
+		{ "AdvMonAllowlistScanDuration",
+		  &main_opts.default_params.advmon_allowlist_scan_duration,
+		  1,
+		  10000},
+		{ "AdvMonNoFilterScanDuration",
+		  &main_opts.default_params.advmon_no_filter_scan_duration,
+		  1,
+		  10000},
 	};
 	uint16_t i;
 
diff --git a/src/main.conf b/src/main.conf
index 8d85702d4316..3b341f44c9cf 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -152,6 +152,13 @@
 #LEConnectionSupervisionTimeout=
 #LEAutoconnecttimeout=
 
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
2.28.0.681.g6f77f65b4e-goog

