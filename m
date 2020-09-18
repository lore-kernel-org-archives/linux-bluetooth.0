Return-Path: <SRS0=JXiH=C3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255CAC43464
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 04:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D24B323772
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 04:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ax3aqfRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgIREOK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Sep 2020 00:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgIREOK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Sep 2020 00:14:10 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C8CC06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 21:14:09 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id g10so4025816qto.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 21:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=cgmCevP9sFtnM8IsBARtN3AUZ+zxR6msvXrKQGyD+04=;
        b=ax3aqfRw8xzWeFQbdteKYQF0M9eeFnHZGr1upnF3y3SNO6CO6Rd0fzo15syqu6zRzM
         0oFpYvwNPS+fOHCP4gqbtqVhFKynxepJZbY0urmOxEl7pJATx2EHGbOSeIW7IeS3tW5X
         tDCjwiqqS4MNt6EEXxNPjG7TLK2lhWq56PKXRW/ncpaFd67pKy8/kB3If/CTcDlPPmnF
         sdsfpyp9f+mqUH53OLTHmT+ukZXN1FRcgx0H3DsyAIxzllNEeOsDHAawgzArinDxMGrZ
         k8cPOYzBD+hIkX4DCNaPtFsbp3R78uNllzu/L0eG6WJBTqCwTI+k2AG+HSpc0jDDde1R
         j4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=cgmCevP9sFtnM8IsBARtN3AUZ+zxR6msvXrKQGyD+04=;
        b=BVoc1abjVb3qBofUbXNgIJ3v4o6ATJU2i1lJHjtx4jsLYlNVT7dazkpr0fh5K06pBq
         bEdvEhdDgpCEoNtHvJe0GNXNZWdCJ41rTJQN47l/OXgjdXRPHjhtDA+1lkTHZVQse9Bm
         j54LnqcpsgDSrA/LWf2SbRB19J2+zAOSiIvfxRXxFGoIlMmEI8mfmm6vArGXAqoeNS18
         E8nFlLW21nmGChW4p0RoOOBI8Vfni+miahJEmkzzB68fqGJr7J+uPaPdMLt8GzbfBFno
         1K8gZB3vZHETtE+cq1VXehnM2Dqj0jH55BHhmXjUlL8u6T/7jhh/kqIHzENlo9yXHhLU
         Bi5Q==
X-Gm-Message-State: AOAM5303QkP0GSg0tdAu6sN2ep2OCq+aBrJfzAnxRSr4abs+QME70tKb
        uq9KZK+rU1G3IAvKCjIE15/XdC9GLDhs1avmqg9P6xa2b4U2i87kvJ70JGu6Xum4v3E4u6hspqv
        3kGQAUKnVEOrJ1ygAUdaIf40ZGJNfrVUZlFP23qrbc3ukRuMG2UQh3ES+oUhGyDALXVOHokaNWh
        yBXNM/fSHSk+Y=
X-Google-Smtp-Source: ABdhPJxaad97caT2HU9lBCbj9PmSEznzYFFbbVOXxlSZYTlyP8hvg1EoprKnmT02dqY6oH6Ws9hjaQE0Tr5ELKygNQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:ad4:45b3:: with SMTP id
 y19mr15515155qvu.59.1600402448580; Thu, 17 Sep 2020 21:14:08 -0700 (PDT)
Date:   Fri, 18 Sep 2020 12:14:01 +0800
Message-Id: <20200918121348.BlueZ.v2.1.I1f083629d41c747a33a3937fbc199ea37dccde12@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [BlueZ PATCH v2 1/2] core: Add params to set interleaving durations
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     mmandlik@chromium.org, mcchou@chromium.org, alainm@chromium.org,
        luiz.dentz@gmail.com, Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds parameters to control the durations of allowlist scan
and no-filter scan when the kernel is doing interleaving scan.
---

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

