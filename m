Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F10BC43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 06:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02D8B2083B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 06:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="nXL/btYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgIQGsd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 02:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgIQGs2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 02:48:28 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6EEC06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 23:48:27 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id c5so972041qtd.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 23:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=0WYATeNozfS1LrKcApAsG4ah2AmW/WN4JP8kkkzL7Xg=;
        b=nXL/btYDdOTe3RqTF7F1o0A3mLF1iEazCm+hkVNT9yfSD0QtMNbCwlke6m6OFpmsnd
         NF7OmwZdrazpOFH9XNGZFaCZpaPNxNfWIqOkmqjPjqeJi66fGUmA+mMhWWK7YlMFoMs8
         ltp7lQTWzf/1CyZNQu3TZTAA/TBWB85jL5YsVAS2b+yJ5CeEeMs+CCelodaP4DwLlmr3
         Iq5JWPKJPKjwvzamGeplKOUx1rpltmKiJef8AxMjFrkqD67SLQP2JUd2eVklnQpfcGM9
         JZMB8k3x44z3MWek4HGGRCH8ORpbeiLyW3aLfdrlK+ApyEKYMPp00Ap7dldxIiHC/Xxz
         4PbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0WYATeNozfS1LrKcApAsG4ah2AmW/WN4JP8kkkzL7Xg=;
        b=CY1FtNYdlxLF8DZE2OzZb1SUwgtZefUyocD/kvaic1vLlKeI3+cCQePN7dyQNh33N7
         2lVCLhNWRxmNSxYrNxR1872XVgz99rEA78YG/g5uBHdZF9esCtnQdAmLkUOl78GUBKQT
         fYgpF/JkVQBhcdWFP2TJyeTihyAMD2V/ulYG68PWdRWmQde4/ZMVWQ1T0av6814lSyWE
         vu5S7lmNt8L5LtNE/k+wAv0X1ia1haAV82Xod/OChKdlwGFKO6cEvCVmyCO9Rj5kgZHW
         RovMFq16aaNdiS4JTbrl+OPsIePevo8+U4TS9WHn4QZN/bB0U8Ej9mtYgp2Ca4d0+N6f
         Estw==
X-Gm-Message-State: AOAM533P4QNIMPq/ISlqXyXeDc8FlbAMDJEgD140zGfCf0SRtjCTC4K9
        elZ1rc+hjlcrpRHijxC3KSmgvoKH1kKc6LyMPHlYyWEcMEdb7EmXI7w3tYcxHWrcShLurpFqmqH
        Es6N40ong2aRuuDl4mMCCS9DADTX0g/Aiyhtao1TChxBd31rCIYDBu5Kfs4GgmGpbO1TZ5Das5k
        BGhmNBRUMaivI=
X-Google-Smtp-Source: ABdhPJyJGDPFWBnCXooPeOMQScT7DpWbH6eXfCImE6bn0zllPRQ7Z39sDCFg9JE49/P2EY3qjlyFCcDGR0aexI8yXA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:ad4:4e4e:: with SMTP id
 eb14mr10745407qvb.41.1600325307008; Wed, 16 Sep 2020 23:48:27 -0700 (PDT)
Date:   Thu, 17 Sep 2020 14:48:16 +0800
In-Reply-To: <20200917144759.BlueZ.1.I1f083629d41c747a33a3937fbc199ea37dccde12@changeid>
Message-Id: <20200917144759.BlueZ.2.Iac5207375d22fb7b96ae4ef73b49ae4ab457219c@changeid>
Mime-Version: 1.0
References: <20200917144759.BlueZ.1.I1f083629d41c747a33a3937fbc199ea37dccde12@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [BlueZ PATCH 2/2] core: Add param to disable interleave scan
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, luiz.dentz@gmail.com, mcchou@chromium.org,
        mmandlik@chromium.org, Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds parameter to enable/disable the interleave scan feature.
---

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
index 3b341f44c9cf..c300a3b81086 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -159,6 +159,12 @@
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
2.28.0.618.gf4bc123cb7-goog

