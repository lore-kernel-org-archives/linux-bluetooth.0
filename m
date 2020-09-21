Return-Path: <SRS0=5m6h=C6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4379DC43465
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Sep 2020 04:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F415820888
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Sep 2020 04:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qhDWnzfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgIUE2d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Sep 2020 00:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgIUE2d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Sep 2020 00:28:33 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2C1C061755
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2020 21:28:33 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id a16so12025651qtj.7
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2020 21:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=fC9C6NlE7ABAb/uqOE5M5b3A+T5ojcafIgUq12Ln5lA=;
        b=qhDWnzfOcDtYQw+no0IcMQyNUUEor4MAOuTA/mq2GZggIG38AXuHtVXDB+ZnCou2Hd
         I+Ahu+HI66UYI0SB16kXe67Ig9fErqxxCUWdZ2WXszokxrwEHhQbh/2uidptAgYCMY1y
         XaGxZwz0LU19Co3ScHClqkUSR5b/lhf8v7bcDbUkMrCh2VzPwIWUsId+W3wQDh+okEIp
         V6um9u4ooNsloi/eBYRqpekX+CieQr3ENgJAUwqq30b0fw2JSEM71APtL8L/i4Mzp+Z2
         x5qlMnW0xOcosnnajUMp+Z4Bnk7MK4NXM41HGp44JAgcxYW6iA2b8l3k3a54dBIRtJgy
         aqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=fC9C6NlE7ABAb/uqOE5M5b3A+T5ojcafIgUq12Ln5lA=;
        b=kTTS0z7IyMdJ8oNg70nGK0UIfUIrGSEtmjfCg+YmMI1i89a5F5AWkKkVCQRgqiGzM2
         03zMdGloi5MbqfYGkKRPf77dajYsfyAraq/CclNARJpAKvA29qKc3pMMGlyu/7qHToUk
         OZZHkhueOHWgLPTcdL3Y9TcVHXEFoTgS1+f8ejUGVrNY5zv3cWXxIWortQuy+uH8lxwg
         TtSFJKFRYuHSfV/JkribIeAxiUUEzz6jYQH7Fu1NQdttx9F62mHxUcxopiggcFva3ntF
         7ELal9JnmbABpgeRGrBQcZUei/dNBgvmIE9UkcCTUX7C/rFehHcCFjZheKq68ILoOp0O
         yzCw==
X-Gm-Message-State: AOAM530mlDNZXcJ9t7Cm7EUGpu1/t1mIZqQmA9SqXQlry5jMWNjcIEaN
        447Y0AYuoOyvoJHryXaJZJ/W8+De6W2th3S6El5G4/CWaSm4tOOg1DODXpmXlxpkV8bdu4FHWWy
        i4Y5YmVs+CLp818glYerchStXntpTUNmf65ZjIQNgOHJQEY/Iposa+jEpv7+ah/Z5XciE9V+8WR
        GqEf+6YS4qimo=
X-Google-Smtp-Source: ABdhPJxgk/8S0bxhQGnBj5Ve94q24v904tgYlwf2XHZllId+zTIL4JajhnToSWxaaXfU45waSOgsN/QUtVk2Sae6YQ==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:ad4:43e5:: with SMTP id
 f5mr44353106qvu.12.1600662511449; Sun, 20 Sep 2020 21:28:31 -0700 (PDT)
Date:   Mon, 21 Sep 2020 12:28:23 +0800
Message-Id: <20200921042824.1265006-1-howardchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [BlueZ PATCH v3 1/2] core: Add params to set interleaving durations
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     mcchou@chromium.org, mmandlik@chromium.org, luiz.dentz@gmail.com,
        alainm@chromium.org, Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds parameters to control the durations of allowlist scan
and no-filter scan when the kernel is doing interleaving scan.
---

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
2.28.0.681.g6f77f65b4e-goog

