Return-Path: <SRS0=JXiH=C3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20CEC43465
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 04:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B43C723888
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 04:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="js3OZGbs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgIREON (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Sep 2020 00:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgIREON (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Sep 2020 00:14:13 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E7AC06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 21:14:12 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id w126so3606216qka.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 21:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=iblcy/QeLiCTNkqzDgNQtqvRJl2CHZ4/1gqki2SzBNs=;
        b=js3OZGbs5eVAi816fw8tBqqigsra0fwoOacOiAFm9Xs6Fllv8YDVKugjhDBoBiw5Ar
         HcZCRWH4Sz1i353rqD4hWyi13bi7zRNHdpVJLT9E86uG+AvOTvaT5bRF6AX7/lK4l7VO
         p95NUZ3GpeCxiHgUK+BtKbMlUB3Lv7AQyYGcB5/aZwPJJcFkgHAm8twxT9cCzDAHnaLP
         JHE7F1HrjkKrIVgtdkoKcAOmN6mAhuNVMFvekDEgx3VbWcMNinzNr2PpRI55/NSET1/9
         DDljWv1dPJjh0rGnmmnxcisXNEivgd3yXmbu+iFvtDJzwvJ8fSo5qgGWK0wCurW0SXtX
         KPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iblcy/QeLiCTNkqzDgNQtqvRJl2CHZ4/1gqki2SzBNs=;
        b=AVYrHwwaHsQqnpBMbLceSo76u7fVVC3iVxLdc2a23V1LkdxCie23kfwa4i4eNP/RXw
         98/XnBKLWDo/TbAxBLBcNwwqwQrX93o/XX7Y7JtQ5vxCcirRbZTDdcoCBddy82ecmLkw
         0i67ZCtOvhJHqPEhO4EWjC9oJYA3ve/x2hUE1Hrq/51h8/synaYbE+YCL6UP7O2B2rbg
         anTnosk8q/8k3SIUkQgNxP6juq3zCKMFU7EBpauMfu/P3JrmVQcJE+45b+R/iHJK3T+B
         UsRLaPmKx2zQFhj6tg6CJvhqOaLsBHdxgmIHByEP/w+gqJ2+Gx0o433iWOHYH3A3rvHN
         4CsA==
X-Gm-Message-State: AOAM531LKh1YOmpXSE5LhhaJFrHFAGbWrfzDjCSX0w48TbXh6ol4p6mF
        NsuLwXAlOAk2fgaaL/frp9eAOB1U8mWSv0a8OvP3WqZER5+X3eb6hefPtiXwpaLCqxl/68SZ+bJ
        //ire1HndoFNz6Spw5Pi1f5brcOnvTMRc8XPvn4vgfh92Tu8rKBpxyJkXkDfXDfaiTxBEROOaFC
        YjJ+2InYTG1kI=
X-Google-Smtp-Source: ABdhPJz7sxFlf66S7G61f40BD1pbeVYC1AY/XfsIviEsmS0WbBJfKkTR2De4Rv1ruJBYcQWqT0HGPdkxQWrJdZcASA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a0c:cd0d:: with SMTP id
 b13mr15712173qvm.53.1600402452001; Thu, 17 Sep 2020 21:14:12 -0700 (PDT)
Date:   Fri, 18 Sep 2020 12:14:02 +0800
In-Reply-To: <20200918121348.BlueZ.v2.1.I1f083629d41c747a33a3937fbc199ea37dccde12@changeid>
Message-Id: <20200918121348.BlueZ.v2.2.Iac5207375d22fb7b96ae4ef73b49ae4ab457219c@changeid>
Mime-Version: 1.0
References: <20200918121348.BlueZ.v2.1.I1f083629d41c747a33a3937fbc199ea37dccde12@changeid>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [BlueZ PATCH v2 2/2] core: Add param to disable interleave scan
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     mmandlik@chromium.org, mcchou@chromium.org, alainm@chromium.org,
        luiz.dentz@gmail.com, Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds parameter to enable/disable the interleave scan feature.
---

(no changes since v1)

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
2.28.0.681.g6f77f65b4e-goog

