Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66AEC433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 06:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF99D2083B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 06:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="UOPSevjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgIQGsZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 02:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgIQGsX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 02:48:23 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA87C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 23:48:23 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id q2so796280pfc.17
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 23:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Ihi2082NxuAZnwPlDWpKybiyW3ApajnMKdIt5g5t49s=;
        b=UOPSevjbAMTngIb8psMDG/2VcsmQu9QDW4TSaKD3SwVtnxlb0hWdZnls40NMcHw2wQ
         HBnB9OSbi2YtisRZdy/eGMbEed2U7iVS+e3F4xjXVJ3RRMs0xBs9b+V9Q/X5ovccyL4L
         Na2l1G5Z2Ln0p5rrSaEbO5muz0x1hs0eaKh0wWjbPgKbI1a3poUb70iu4vLy9G8/AsCD
         qfWOWZUS3muNM+dWF4gCSv3YtlC+NXtD7W04O4pMaNAescv5mhRjEgGRbb68ZNc8JDbt
         LNJHtovPpnttbXwUhlUr61rMEhZX8dmQ0gk074DixjTFDo8SjadjAChCQx2a6wfziVsu
         Pxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Ihi2082NxuAZnwPlDWpKybiyW3ApajnMKdIt5g5t49s=;
        b=GPDsXtb7mj/NGmApL8sWavwBfT2n4JxAVeAdPFIwTsA6XXdDZRC6faDJamBMevfr3O
         XxtJNp0DVN+ICdiXmgygJiJ7n3wmmmcNx6MPwaEBc2qrNH85IRzxQvmbRHAXtM7i2l8e
         99/tw2BdSkQVZZ9UF3p7vjC9jJ+hWolCoKyjZbgqekL+1HGPyutTy/nRggFLUOLOPd+N
         bFREodNrBADNFddQeJ0LGq6KjYYGrp5e1//WEyL1IMcXQPneYmONGwP8cKLJ4540Jlyn
         HDLaUGhQ/dqmwf6hm6pwQlZeG8XtvVyyfWW4hzo39kwp1JICR1AlJQtwLSWQqOkSJ3pm
         U99w==
X-Gm-Message-State: AOAM5325Eh7kw1CZHmuwAZ+teCcQLQ8PSzI+dIdNPOiqc1ZyYzxTJbea
        0XBqYnKXT/CFACE+PGd3DbOh7KXFJPM5cagu6iZCDf2D4+8sibFHdoAhK+vkw6c7AKIvJxiQt2v
        +ThsbV1QufStWR77QNuposmJUrnktuKhfC9nSRMSHKjHB8OdtcVRvvcHbm1OB88R85RdjkZ4nIy
        zQnkHNLUyogKo=
X-Google-Smtp-Source: ABdhPJxHpoFRBdAfV8RevCzA9pjqOCASbwDYK5xArVgBdQUhQnHsSYmO6hDumpYRy643bmIbfB+kC2t+u36QsGsnqQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:aa7:934e:0:b029:13f:d056:593 with SMTP
 id 14-20020aa7934e0000b029013fd0560593mr20182654pfn.15.1600325303181; Wed, 16
 Sep 2020 23:48:23 -0700 (PDT)
Date:   Thu, 17 Sep 2020 14:48:15 +0800
Message-Id: <20200917144759.BlueZ.1.I1f083629d41c747a33a3937fbc199ea37dccde12@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [BlueZ PATCH 1/2] core: Add parmas to set interleaving durations
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, luiz.dentz@gmail.com, mcchou@chromium.org,
        mmandlik@chromium.org, Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds parameters to control the durations of allowlist scan
and no-filter scan when the kernel is doing interleaving scan.
---

 src/adapter.c | 18 ++++++++++++++++++
 src/hcid.h    |  3 +++
 src/main.c    | 10 ++++++++++
 src/main.conf |  7 +++++++
 4 files changed, 38 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index b2bd8b3f1d01..c0e95b48a1c4 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4431,6 +4431,24 @@ static void load_default_system_params(struct btd_adapter *adapter)
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
index 3624ba6ea163..c3e5fe803543 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -93,6 +93,9 @@ struct main_opts {
 		uint16_t	le_conn_latency;
 		uint16_t	le_conn_lsto;
 		uint16_t	le_autoconnect_timeout;
+
+		uint16_t	advmon_allowlist_scan_duration;
+		uint16_t	advmon_no_filter_scan_duration;
 	} default_params;
 
 
diff --git a/src/main.c b/src/main.c
index 038f867b5a6d..e222ed3bf855 100644
--- a/src/main.c
+++ b/src/main.c
@@ -123,6 +123,8 @@ static const char *controller_options[] = {
 	"LEConnectionLatency",
 	"LEConnectionSupervisionTimeout",
 	"LEAutoconnecttimeout",
+	"AdvMonAllowlistScanDuration",
+	"AdvMonNoFilterScanDuration",
 	NULL
 };
 
@@ -434,6 +436,14 @@ static void parse_controller_config(GKeyFile *config)
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
2.28.0.618.gf4bc123cb7-goog

