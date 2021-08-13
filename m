Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D27C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52DC1610A4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240354AbhHMMXq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240525AbhHMMXp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:23:45 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0711DC0617AE
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:23:19 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id t9-20020a0562140c69b029033e8884d712so6888464qvj.18
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gWspoimB87hDAxMKBWziz3njh7BNvp0FojuHputuPbg=;
        b=B/xbL0TXraKw2e9GR2rwqrsZDhMRvNQLmaLl1MvRdb50A5MygnmX/i+fvSCtNnujFt
         RsWoONCto05sqE50ExeorE0dgEeT7EQV9oF65PHqFdw3mt1qNWAUXKXgezhvCyFkclgl
         SAlJ14sI01X+X30mMxFzk5VDGmAhRGb9hUJ5RleJmJuRVxVYxGRRDra/PLxVXEd2iubi
         s/lUKMfAUXjLKPks+OHXOPKqkamxvZrNn4YzpkBB0smeq9kVCxJEyi6WfECaPDnh4scc
         xmduOhx8zvb3TivC+kdtyTeiRaaR/XuYEs3Y8b4te/K9CvUTX7DtaNIYLktWI3w8bt/p
         2bFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gWspoimB87hDAxMKBWziz3njh7BNvp0FojuHputuPbg=;
        b=Ze2AOe/PmpZGBQKPqN85Y+dc6lSqHi6ZBERiIAGpL/ygSQaZ1G4o+Kr7G3IwZrbQxf
         ov/weXr4IlKi92a3AynVdkoWWAJ1p3teY14zl+Kq3+QifYuElxixcglwYbcxqGZyc8g7
         zNHxKOt3r0NVheEduHhaPBUDDzncT3Iy3Kw3CvGpC6nkvLMWAOGSzNy1f84VSzgCWchc
         3aLTOHApiy3/XHvoUEbfm+KHwBGbtOW8W29MnQxGfsdjpymharRcX2WaWw1TH67bRfFA
         j96hyyFEhERm4TnAtBhN7/w5dUIaOFkZywzBU6L8QQBPOzoE4xiecu/Hf6BomA2PWfGW
         IApw==
X-Gm-Message-State: AOAM533ybA65xrwBperpzADv8nDnL0/VrThM3Ce4b9A3evvzYToLcQDr
        gCMwF8/xUipHXAXA63A5B3MbfypxYtHJuMLwpQwH68Rq8pjTuDZFYbb0e3IQaEzeFQzkeIYgtJN
        A59OGyxpOCFejuW0i/srTHF1GmJmeSaBdqlScalPeEyvqIjmDJRbjCpGxiPwMlKL/X+bZd5IxMz
        kA
X-Google-Smtp-Source: ABdhPJwoH6Kpjen/+dhQCfbpLmvYp9oDxkeTfAKLLuIxYSdc04bPrnkPpalERrgjJylIpz9Ds1gDSUF25S1I
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a05:6214:324:: with SMTP id
 j4mr374961qvu.22.1628857398123; Fri, 13 Aug 2021 05:23:18 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:46 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.61.Ide58356fd72b10483a2b67591e71ce9f6a5b9973@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 61/62] android: Inclusive language for filtering devices
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

"accept list" is preferred, as reflected in the BT core spec v5.3.
Also prefer to use "blocked".
---

 android/bluetooth.c             | 18 +++++++++---------
 android/client/if-hf-client.c   |  2 +-
 android/hal-ipc-api.txt         |  2 +-
 android/hardware/bt_hf_client.h |  2 +-
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index b5f584eea2..611b717379 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -89,7 +89,7 @@ struct device {
 	bool le_paired;
 	bool le_bonded;
 
-	bool in_white_list;
+	bool in_accept_list;
 
 	bool connected;
 
@@ -1649,8 +1649,8 @@ bool bt_auto_connect_add(const bdaddr_t *addr)
 		return false;
 	}
 
-	if (dev->in_white_list) {
-		DBG("Device already in white list");
+	if (dev->in_accept_list) {
+		DBG("Device already in accept list");
 		return true;
 	}
 
@@ -1661,7 +1661,7 @@ bool bt_auto_connect_add(const bdaddr_t *addr)
 
 	if (mgmt_send(mgmt_if, MGMT_OP_ADD_DEVICE, adapter.index, sizeof(cp),
 						&cp, NULL, NULL, NULL) > 0) {
-		dev->in_white_list = true;
+		dev->in_accept_list = true;
 		return true;
 	}
 
@@ -1687,8 +1687,8 @@ void bt_auto_connect_remove(const bdaddr_t *addr)
 		return;
 	}
 
-	if (!dev->in_white_list) {
-		DBG("Device already removed from white list");
+	if (!dev->in_accept_list) {
+		DBG("Device already removed from accept list");
 		return;
 	}
 
@@ -1698,7 +1698,7 @@ void bt_auto_connect_remove(const bdaddr_t *addr)
 
 	if (mgmt_send(mgmt_if, MGMT_OP_REMOVE_DEVICE, adapter.index,
 				sizeof(cp), &cp, NULL, NULL, NULL) > 0) {
-		dev->in_white_list = false;
+		dev->in_accept_list = false;
 		return;
 	}
 
@@ -2194,8 +2194,8 @@ static void mgmt_device_unpaired_event(uint16_t index, uint16_t length,
 	update_device_state(dev, ev->addr.type, HAL_STATUS_SUCCESS, false,
 								false, false);
 
-	/* Unpaired device is removed from the white list */
-	dev->in_white_list = false;
+	/* Unpaired device is removed from the accept list */
+	dev->in_accept_list = false;
 }
 
 static void store_ltk(const bdaddr_t *dst, uint8_t bdaddr_type, bool central,
diff --git a/android/client/if-hf-client.c b/android/client/if-hf-client.c
index e3793aaf0b..85444ab5da 100644
--- a/android/client/if-hf-client.c
+++ b/android/client/if-hf-client.c
@@ -98,7 +98,7 @@ SINTMAP(bthf_client_cmd_complete_t, -1, "(unknown)")
 	DELEMENT(BTHF_CLIENT_CMD_COMPLETE_ERROR_BUSY),
 	DELEMENT(BTHF_CLIENT_CMD_COMPLETE_ERROR_NO_ANSWER),
 	DELEMENT(BTHF_CLIENT_CMD_COMPLETE_ERROR_DELAYED),
-	DELEMENT(BTHF_CLIENT_CMD_COMPLETE_ERROR_BLACKLISTED),
+	DELEMENT(BTHF_CLIENT_CMD_COMPLETE_ERROR_BLOCKED),
 	DELEMENT(BTHF_CLIENT_CMD_COMPLETE_ERROR_CME),
 ENDMAP
 
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index e3b7798b3d..7886b6b827 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -2649,7 +2649,7 @@ Notifications:
 		                   0x03 = Error busy
 		                   0x04 = Error no answer
 		                   0x05 = Error delayed
-		                   0x06 = Error blacklisted
+		                   0x06 = Error blocked
 		                   0x07 = Error CME
 
 		Note: CME parameter is valid only for Error CME type
diff --git a/android/hardware/bt_hf_client.h b/android/hardware/bt_hf_client.h
index 4a0ec364b0..0ba5387330 100644
--- a/android/hardware/bt_hf_client.h
+++ b/android/hardware/bt_hf_client.h
@@ -98,7 +98,7 @@ typedef enum {
     BTHF_CLIENT_CMD_COMPLETE_ERROR_BUSY,
     BTHF_CLIENT_CMD_COMPLETE_ERROR_NO_ANSWER,
     BTHF_CLIENT_CMD_COMPLETE_ERROR_DELAYED,
-    BTHF_CLIENT_CMD_COMPLETE_ERROR_BLACKLISTED,
+    BTHF_CLIENT_CMD_COMPLETE_ERROR_BLOCKED,
     BTHF_CLIENT_CMD_COMPLETE_ERROR_CME
 } bthf_client_cmd_complete_t;
 
-- 
2.33.0.rc1.237.g0d66db33f3-goog

