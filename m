Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D94C433E6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 09:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E2C523102
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 09:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbhAFJ1w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Jan 2021 04:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbhAFJ1v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Jan 2021 04:27:51 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B241FC06134C
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Jan 2021 01:27:10 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id k13so1286590pfc.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Jan 2021 01:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=K3y2lVRADdCWZBP/7WA7c6UNCEhc9cKri6loks5JZFo=;
        b=rilvXkmZqPwL/vEmpCecwlqP6A9cTXRC91b0+XiZZzqvyAuOMOFM0SjxA7xAZDn5MQ
         CPjkSWx6z0bjZGv/pkeDWUsTrLnZmoTf01uCH1u+96eFFukPFnocTN39/XRQKFXFik3C
         MJst6s86gMqi5cPWUIS3sYq1fAHzqmtmXPU1mw+0yUPaXleIajSXLR+ubmTDKRqnv25g
         /LhnmGGXWWo0wXrNtHjVvWTeyg1aB20U5doGFcYpCAsp/GMaBGIKJ8frW/fn+4qot8NP
         tDNk3P8ftUyFYGCaygDQGpn+07tsJ2a5yZLujoNY7DsVWtx7+l7oOXDZV4104rzzbzyV
         NxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=K3y2lVRADdCWZBP/7WA7c6UNCEhc9cKri6loks5JZFo=;
        b=hf3ph9l9CstcFGdPBc29I89TvVG6Y0Ztg/tNIU5nmwN4XXWmb23yWQlbd/+zRra3Vz
         YM5A17xx9HBbm03GgOse3YM4+13xrLwixoxeP9NPIAg7S73i38xplWfdXIwPh8tTfFVw
         mUCObL1qgKY9snMBFVTYYqh+Cs2YYUWOq0qJmasmZ5kdl8k23c2UdhJ+/4ZXVC01xU2L
         asBBb2R7YdLoWoMissMcDzKqpO9VFEfthV01HwJlvb44gdIP0cSapr3q2c/TKkix2KFK
         oZSHiGd+qBBIf28INskDjIjZXiXyeH7QBRwv7fHNQqjRqJQz1pg5IH1gLlFCcSz/TmEp
         jAOw==
X-Gm-Message-State: AOAM531gI7RPuEEC5tBDwt1JKtNP9s+Oy8zyHURBQ6ZZjsvvkHMvX0tA
        DGWmupLPd4tMHetjzzCtnC5l98NNenf5H0pbkcCoEmwvGVVtFW8cUGNAN3PfaeJ707GnWEfrr0f
        tnoBmSq3VErMFq5SNsbinGW+VhkMZWI6Rb5LHf2+3TsqX3QxZ4M5xT4GUgflXzjnkKXRT8G5wyx
        0u
X-Google-Smtp-Source: ABdhPJxBBF8hQ3s0sig+bpxfqDCRICV4vZy9JmzZxDxonvdTYKSG+agVNwatSoU3KjiQQiQQ/AmLjFPIwTfr
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a17:90a:fd08:: with SMTP id
 cv8mr3345008pjb.29.1609925228558; Wed, 06 Jan 2021 01:27:08 -0800 (PST)
Date:   Wed,  6 Jan 2021 17:26:58 +0800
Message-Id: <20210106172647.Bluez.v1.1.If4056891c866780eba7b210887c6db468b8b55e9@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [Bluez PATCH v1] adapter: Remove temporary devices before power off
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

If adapter is powered off when a currently connected device is
being removed, there is a possibility that we haven't finish waiting
for the disconnection but the adapter is already powered down.

When this happens, the kernel would fail to clean the device's
information, for example the pairing information. This causes
disagreement between the user space and the kernel about whether the
device is already paired, because the device is successfully removed
from the user space's perspective.

This patch enforces the removal of such devices before allowing the
adapter to power off.
---

 src/adapter.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index ec6a6a64c5..92d1cb2232 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -517,6 +517,7 @@ static void adapter_stop(struct btd_adapter *adapter);
 static void trigger_passive_scanning(struct btd_adapter *adapter);
 static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
 							uint8_t mode);
+static void remove_temporary_devices(struct btd_adapter *adapter);
 
 static void settings_changed(struct btd_adapter *adapter, uint32_t settings)
 {
@@ -622,6 +623,8 @@ static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
 	switch (mode) {
 	case MGMT_OP_SET_POWERED:
 		setting = MGMT_SETTING_POWERED;
+		if (!mode)
+			remove_temporary_devices(adapter);
 		break;
 	case MGMT_OP_SET_CONNECTABLE:
 		setting = MGMT_SETTING_CONNECTABLE;
@@ -2888,8 +2891,10 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
 		param = &mode;
 		len = sizeof(mode);
 
-		if (!mode)
+		if (!mode) {
 			clear_discoverable(adapter);
+			remove_temporary_devices(adapter);
+		}
 
 		break;
 	case MGMT_SETTING_DISCOVERABLE:
@@ -5304,6 +5309,19 @@ static void remove_discovery_list(struct btd_adapter *adapter)
 	adapter->discovery_list = NULL;
 }
 
+static void remove_temporary_devices(struct btd_adapter *adapter)
+{
+	GSList *l, *next;
+
+	for (l = adapter->devices; l; l = next) {
+		struct btd_device *dev = l->data;
+
+		next = g_slist_next(l);
+		if (device_is_temporary(dev))
+			btd_adapter_remove_device(adapter, dev);
+	}
+}
+
 static void adapter_free(gpointer user_data)
 {
 	struct btd_adapter *adapter = user_data;
-- 
2.29.2.729.g45daf8777d-goog

