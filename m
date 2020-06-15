Return-Path: <SRS0=u3xs=74=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113F3C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jun 2020 14:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E081C20644
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jun 2020 14:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mWk7WDv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730747AbgFOOw5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbgFOOw4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jun 2020 10:52:56 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09DBC061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 07:52:56 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id k13so9480403vsm.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 07:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uEDPBGsyyuMkD7h1SxGrU2ByRnSLYy+1iRRzLr5C7A4=;
        b=mWk7WDv8z3Qk49A8br2bEDUKFZBRV0HJlXZzen3W2pW3DcLl0nSnU1R0GIX6CIf/1I
         eczlhPtvty9+h6E9SuxfNXs327wy1TPBLxkJN6kgGeQimdVoecXn+7vseSdnoGusfsTC
         tD5w+YOBe75jvta8+esz7UhkLSwI4ZQUtECOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uEDPBGsyyuMkD7h1SxGrU2ByRnSLYy+1iRRzLr5C7A4=;
        b=F6EuYwMUBr3ZD62tCyD4j7OAOAmFava/MOzPItS4+lpBKFivxhBPU+aLPg+CSY98A5
         EP4GujXk+3MDN3gOHjlZqrVadw0xUgcoJjohyPo5SZsQvvCrm1wyp3NIVYvs5x0Ks1gd
         Yn5rqgHlpddO/6b+HJ0B+guLoWZtHXsX4YnidhNMj3w459yNrQAgJj8ZILupx1F31bWq
         MQKDCoj8UmPD+gkGY/BItUW9tk+oo0ErBJwlBZUZXA1ngq+2nf7gPS9hkiHmRkdY3z4j
         embI7TOQV4K30GtJPSvL+sOkeOyNYtRo5YSh3GcJcaKu6Ct5ARbk5Z0QgsZho5aFLgwW
         pgOQ==
X-Gm-Message-State: AOAM532eLCeo6egA7pYKgJ6TZxVGllT16XenxjNtiyp3CEYSrjmVJXyA
        MieOTIYGzGHnG4peBuTI5GXK4q7ILT8=
X-Google-Smtp-Source: ABdhPJx/F66oRp87FCq769X2IctcNFhC5vQpljfNOCjTlP7HzYAdOrUIbTrUE7HzkvZ0vNUMBi/EKA==
X-Received: by 2002:a67:fc08:: with SMTP id o8mr20158325vsq.188.1592232775761;
        Mon, 15 Jun 2020 07:52:55 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id f138sm2451471vke.54.2020.06.15.07.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 07:52:55 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH v1] adding a configurable le autoconnect timeout value
Date:   Mon, 15 Jun 2020 14:52:52 +0000
Message-Id: <20200615145252.259971-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds support for a configurable le autoconnect timer.

---

 doc/mgmt-api.txt | 1 +
 src/adapter.c    | 8 ++++++++
 src/hcid.h       | 1 +
 src/main.c       | 5 +++++
 src/main.conf    | 1 +
 5 files changed, 16 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 80c483f8b..ca0d38469 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3278,6 +3278,7 @@ Read Default System Configuration Command
 		0x0018	LE Max Connection Interval
 		0x0019	LE Connection Latency
 		0x001a	LE Connection Supervision Timeout
+		0x001b	LE Autoconnect Timeout
 
 	This command can be used at any time and will return a list of
 	supported default parameters as well as their current value.
diff --git a/src/adapter.c b/src/adapter.c
index 92002673b..9ce351893 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4423,6 +4423,14 @@ static void load_default_system_params(struct btd_adapter *adapter)
 		len += sizeof(params[i].u16);
 	}
 
+	if (main_opts.default_params.le_autoconnect_timeout) {
+		params[i].entry.type = 0x001b;
+		params[i].entry.length = sizeof(params[i].u16);
+		params[i].u16 = main_opts.default_params.le_autoconnect_timeout;
+		++i;
+		len += sizeof(params[i].u16);
+	}
+
 	err = mgmt_send(adapter->mgmt, MGMT_OP_SET_DEF_SYSTEM_CONFIG,
 			adapter->dev_id, len, params, NULL, NULL, NULL);
 	if (!err)
diff --git a/src/hcid.h b/src/hcid.h
index 1b2714b1d..c21ac9980 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -91,6 +91,7 @@ struct main_opts {
 		uint16_t	le_max_conn_interval;
 		uint16_t	le_conn_latency;
 		uint16_t	le_conn_lsto;
+		uint16_t	le_autoconnect_timeout;
 	} default_params;
 
 
diff --git a/src/main.c b/src/main.c
index e51f614b3..77886d58e 100644
--- a/src/main.c
+++ b/src/main.c
@@ -120,6 +120,7 @@ static const char *controller_options[] = {
 	"LEMaxConnectionInterval",
 	"LEConnectionLatency",
 	"LEConnectionSupervisionTimeout",
+	"LEAutoconnecttimeout",
 	NULL
 };
 
@@ -410,6 +411,10 @@ static void parse_controller_config(GKeyFile *config)
 		  &main_opts.default_params.le_scan_win_connect,
 		  0x0004,
 		  0x4000},
+		{ "LEAutoconnecttimeout",
+		  &main_opts.default_params.le_autoconnect_timeout,
+		  0x0001,
+		  0x4000},
 	};
 	uint16_t i;
 
diff --git a/src/main.conf b/src/main.conf
index 92d937f0c..6a6f7d4b4 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -141,6 +141,7 @@
 #LEMaxConnectionInterval=
 #LEConnectionLatency=
 #LEConnectionSupervisionTimeout=
+#LEAutoconnecttimeout=
 
 [GATT]
 # GATT attribute cache.
-- 
2.27.0.290.gba653c62da-goog

