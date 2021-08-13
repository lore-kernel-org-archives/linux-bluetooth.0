Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA115C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3DBF610A4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240502AbhHMMWv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240260AbhHMMWv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:22:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841B8C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j9-20020a2581490000b02905897d81c63fso9010842ybm.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=r0Uyu4ViFJMpN6A1CUdTc1aal48f8uwOpcSq+9Wg9Q0=;
        b=iwibtDgIaqjIt8NnrkjhLVatPDogMqz7+MCpEhNV/ZY5hO2NGMwIV4gz2NU/N1XxZs
         ob5ahRQQKCTeYIp9KeTCxbOtZOSVnyNEQEFNgBo02vY187jRmrZ91rdQgUy7NvL7PaeO
         vIb0oS+TGi6uShbwCQc4JsmpxDI8K0vr4w317x0a5z7pSNMJukSth6aGTfFkFEWoOKL/
         StcgOjzsYKDDMsKMky/qV3lamvFMIuy3V5W8Zu0fMZbmGfse8po3A5/WEwc6cuqYIKzY
         MElBefZwSrR0rQQAIPg79fIQ7KX75y56D6l6hov1k4RYlPOi+zaWac3c3RiLmyu7tZVp
         2W7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r0Uyu4ViFJMpN6A1CUdTc1aal48f8uwOpcSq+9Wg9Q0=;
        b=h8ZbedV8Vu2Qk+EXfqLiK/2geQHDgWVlodYPDbaMaO0+m3Op2kvESSW/W9NDcFsOcE
         tLCLKj2iE+sm7RdEwOHPCLS0M4oPpGrwgGIrE1YnhZqxpiidgc3KJUvm+c+Qiiqe7709
         8vSCY2QfkVfMGQiNspOCEtYY8xFUqtoLBWUeJLwkZ/qbNqEg5ZnTo2OOXeVS8eROMx8g
         iISkHIfHgTy4FPkDLkpqFAnGDH3ITGsFYfhDfj+9+tCevOVLM0r+L4NrjQaTzz0hkZct
         VlthCtKanNHl5ExjvRQLMP3YeNFEhMUK6y5hpSYhn6JM+W1iSCc2S9X6A2FvElCrf5mD
         m4yA==
X-Gm-Message-State: AOAM532CUS6kjC1zpJXgof+bwwZfl68J+u8B51PuDvBCMaC0ZVKn+xXK
        FqZsIH4ZwyKe8Gw/08s3WEE2AspZnFKhfQpaBVNL5zBXFkIQsD0+RnFldyjJ8uIrMos2t/gwS8c
        XE6il35JLlp8sRh16+SI+Z2bjeDU6LGRzjIoEzjUBBoxE9IVtIj6zyFRWCWxsAk3vpuGXwElT7E
        I0
X-Google-Smtp-Source: ABdhPJzPXnPf0/XqPNLOMiunnZ+ts6AeMCTrh0RwS1K/F9Ok+DQNCHc5TFCcft82Wa+Ta4jJiIvAbL0r9/Kc
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a25:c583:: with SMTP id
 v125mr2600793ybe.4.1628857343758; Fri, 13 Aug 2021 05:22:23 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:31 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.46.I0e4236b0928a4359e2f43d0a2ae62e2f20bb3ff4@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 46/62] plugins/sixaxis: Inclusive language changes
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

"central" is preferred, as reflected in the BT core spec 5.3.
---

 plugins/sixaxis.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 517cecc476..ddecbcccb3 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -139,7 +139,7 @@ static int get_device_bdaddr(int fd, bdaddr_t *bdaddr, CablePairingType type)
 	return -1;
 }
 
-static int sixaxis_get_master_bdaddr(int fd, bdaddr_t *bdaddr)
+static int sixaxis_get_central_bdaddr(int fd, bdaddr_t *bdaddr)
 {
 	uint8_t buf[8];
 	int ret;
@@ -150,7 +150,7 @@ static int sixaxis_get_master_bdaddr(int fd, bdaddr_t *bdaddr)
 
 	ret = ioctl(fd, HIDIOCGFEATURE(sizeof(buf)), buf);
 	if (ret < 0) {
-		error("sixaxis: failed to read master address (%s)",
+		error("sixaxis: failed to read central address (%s)",
 							strerror(errno));
 		return ret;
 	}
@@ -160,7 +160,7 @@ static int sixaxis_get_master_bdaddr(int fd, bdaddr_t *bdaddr)
 	return 0;
 }
 
-static int ds4_get_master_bdaddr(int fd, bdaddr_t *bdaddr)
+static int ds4_get_central_bdaddr(int fd, bdaddr_t *bdaddr)
 {
 	uint8_t buf[16];
 	int ret;
@@ -171,7 +171,7 @@ static int ds4_get_master_bdaddr(int fd, bdaddr_t *bdaddr)
 
 	ret = ioctl(fd, HIDIOCGFEATURE(sizeof(buf)), buf);
 	if (ret < 0) {
-		error("sixaxis: failed to read DS4 master address (%s)",
+		error("sixaxis: failed to read DS4 central address (%s)",
 		      strerror(errno));
 		return ret;
 	}
@@ -182,16 +182,16 @@ static int ds4_get_master_bdaddr(int fd, bdaddr_t *bdaddr)
 	return 0;
 }
 
-static int get_master_bdaddr(int fd, bdaddr_t *bdaddr, CablePairingType type)
+static int get_central_bdaddr(int fd, bdaddr_t *bdaddr, CablePairingType type)
 {
 	if (type == CABLE_PAIRING_SIXAXIS)
-		return sixaxis_get_master_bdaddr(fd, bdaddr);
+		return sixaxis_get_central_bdaddr(fd, bdaddr);
 	else if (type == CABLE_PAIRING_DS4)
-		return ds4_get_master_bdaddr(fd, bdaddr);
+		return ds4_get_central_bdaddr(fd, bdaddr);
 	return -1;
 }
 
-static int sixaxis_set_master_bdaddr(int fd, const bdaddr_t *bdaddr)
+static int sixaxis_set_central_bdaddr(int fd, const bdaddr_t *bdaddr)
 {
 	uint8_t buf[8];
 	int ret;
@@ -203,13 +203,13 @@ static int sixaxis_set_master_bdaddr(int fd, const bdaddr_t *bdaddr)
 
 	ret = ioctl(fd, HIDIOCSFEATURE(sizeof(buf)), buf);
 	if (ret < 0)
-		error("sixaxis: failed to write master address (%s)",
+		error("sixaxis: failed to write central address (%s)",
 							strerror(errno));
 
 	return ret;
 }
 
-static int ds4_set_master_bdaddr(int fd, const bdaddr_t *bdaddr)
+static int ds4_set_central_bdaddr(int fd, const bdaddr_t *bdaddr)
 {
 	uint8_t buf[23];
 	int ret;
@@ -223,19 +223,19 @@ static int ds4_set_master_bdaddr(int fd, const bdaddr_t *bdaddr)
 
 	ret = ioctl(fd, HIDIOCSFEATURE(sizeof(buf)), buf);
 	if (ret < 0)
-		error("sixaxis: failed to write DS4 master address (%s)",
+		error("sixaxis: failed to write DS4 central address (%s)",
 		      strerror(errno));
 
 	return ret;
 }
 
-static int set_master_bdaddr(int fd, const bdaddr_t *bdaddr,
+static int set_central_bdaddr(int fd, const bdaddr_t *bdaddr,
 					CablePairingType type)
 {
 	if (type == CABLE_PAIRING_SIXAXIS)
-		return sixaxis_set_master_bdaddr(fd, bdaddr);
+		return sixaxis_set_central_bdaddr(fd, bdaddr);
 	else if (type == CABLE_PAIRING_DS4)
-		return ds4_set_master_bdaddr(fd, bdaddr);
+		return ds4_set_central_bdaddr(fd, bdaddr);
 	return -1;
 }
 
@@ -267,8 +267,8 @@ static void agent_auth_cb(DBusError *derr, void *user_data)
 {
 	struct authentication_closure *closure = user_data;
 	struct authentication_destroy_closure *destroy;
-	char master_addr[18], adapter_addr[18], device_addr[18];
-	bdaddr_t master_bdaddr;
+	char central_addr[18], adapter_addr[18], device_addr[18];
+	bdaddr_t central_bdaddr;
 	const bdaddr_t *adapter_bdaddr;
 	bool remove_device = true;
 
@@ -283,12 +283,12 @@ static void agent_auth_cb(DBusError *derr, void *user_data)
 		goto out;
 	}
 
-	if (get_master_bdaddr(closure->fd, &master_bdaddr, closure->type) < 0)
+	if (get_central_bdaddr(closure->fd, &central_bdaddr, closure->type) < 0)
 		goto out;
 
 	adapter_bdaddr = btd_adapter_get_address(closure->adapter);
-	if (bacmp(adapter_bdaddr, &master_bdaddr)) {
-		if (set_master_bdaddr(closure->fd, adapter_bdaddr,
+	if (bacmp(adapter_bdaddr, &central_bdaddr)) {
+		if (set_central_bdaddr(closure->fd, adapter_bdaddr,
 							closure->type) < 0)
 			goto out;
 	}
@@ -302,10 +302,10 @@ static void agent_auth_cb(DBusError *derr, void *user_data)
 						 SIXAXIS_HID_SDP_RECORD);
 
 	ba2str(&closure->bdaddr, device_addr);
-	ba2str(&master_bdaddr, master_addr);
+	ba2str(&central_bdaddr, central_addr);
 	ba2str(adapter_bdaddr, adapter_addr);
-	DBG("remote %s old_master %s new_master %s",
-				device_addr, master_addr, adapter_addr);
+	DBG("remote %s old_central %s new_central %s",
+				device_addr, central_addr, adapter_addr);
 
 out:
 	g_hash_table_steal(pending_auths, closure->sysfs_path);
-- 
2.33.0.rc1.237.g0d66db33f3-goog

