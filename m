Return-Path: <SRS0=RRj3=DG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEB8C4727F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Sep 2020 10:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6EF120C09
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Sep 2020 10:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cinaYxH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbgI2K4L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Sep 2020 06:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgI2K4L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Sep 2020 06:56:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBA8C061755
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2020 03:56:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 140so4422051ybf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2020 03:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=+EMiw7AaqKMTc7moeMEEbaeFth4p8VcNu3tluYaRH/E=;
        b=cinaYxH3W1pTZymurBfk1cJTsO+Me+skJdMlZSAKxagEhxPA0GY+KgMy2PNeKu5oKp
         MTRRk6jefJAoO0mFBIj8IPnunsiex5a5ovz5UasqIfbgYWk3mmtYxsjryDmJC6A4UgTQ
         gKU/p2Cym1tO+1Spa3Exmd3idGA1l8Dft+8OKTzGRm1gwfl+aIufS7GbcusXu09FilJk
         1/W6MY/tXAabCvyQ+nN4kOD0ReZXHA9i89si/87hXmekkzgGvKzDGTktv2Y8oLMIwUgJ
         AFaRNGLjI/yfb7H1OKEqQUQwzeMSdhwm15Q0xwvrpijSZLD7bgCaaoeKPcWIyMtKtgwM
         ppLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=+EMiw7AaqKMTc7moeMEEbaeFth4p8VcNu3tluYaRH/E=;
        b=FbZbBAa4cT/ibM9l+6VQYBkg5cdWDekuJlYuMTtec1Gcsc39yHaCMKUQ1wTpufG93s
         XW4yGddMKIcdgLOC5Ll88gbMODih/J8gFP6VCCIcr9RG6jr5+bt0lrKG3sK1Q1V7CW9r
         5UKFyaOquxToHFuCDeohs/d1HnBZ6jCYRjylKmG2D6xIk02bRGlNM25P3Z91WRFC5EVG
         f65wV9FA9DjtDP6gheTqNDte0C1Njj+Q+glG54zSoUKaYOG6pYR56UmaEcsrm2gZpQeO
         riwCU7FVTeh664zYw2GVMIgDpKew2/Kxft/vpTdWS3VtxJHsfDfCskDfa4A1AfnUw3q2
         9esw==
X-Gm-Message-State: AOAM530AY8nQGvpo3biY0cnxpFbqybR+ImV37mxaX0Y93qnbLhrAWJS8
        QnOE3MNfdysBDudG3/uBLT6O+Nbu884u8y3OMr9XLKxTSSQS865AT/HICUTv/ltJOZ6OKw/6cX4
        U1EhWBlquvFOQuCBTW5Qy4rlt/Lvo/48SGsN6l3gLRJCy+AwI4p7Kf/NF9y6bFNlHxtgzoMt7Ua
        V5kgqTUcxwU0Y=
X-Google-Smtp-Source: ABdhPJwAZeDbbODn3OYP8Zi4yWnpCJNW+esswDIKUUwI877Z11baj7kWUoH+YS+neXDw134VJeFl5hY8slgPL8Nuqw==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a25:3b14:: with SMTP id
 i20mr4651510yba.351.1601376970005; Tue, 29 Sep 2020 03:56:10 -0700 (PDT)
Date:   Tue, 29 Sep 2020 18:56:02 +0800
Message-Id: <20200929185522.BlueZ.v5.1.I1f083629d41c747a33a3937fbc199ea37dccde12@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [BlueZ PATCH v5 1/3] core: Add params to set interleaving durations
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     mmandlik@chromium.org, luiz.dentz@gmail.com, alainm@chromium.org,
        mcchou@chromium.org, Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds parameters to control the durations of allowlist scan
and no-filter scan when the kernel is doing interleaving scan.
---

Changes in v5:
- Fix compile warning

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
2.28.0.709.gb0816b6eb0-goog

