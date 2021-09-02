Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.5 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4739C4320A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 04:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4EE760EE6
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 04:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhIBEI7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 00:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbhIBEI7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 00:08:59 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F966C061575
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Sep 2021 21:08:01 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id c7-20020aa788070000b029035630a4b35dso460500pfo.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Sep 2021 21:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wdenUEJENVIVipxrbo4b1ygCInnbwIE19qxWHQENdgM=;
        b=AKKpKsauIvERIq65NY8/swtj8kiD1w0ReXxp3yA45Lx37sWbmL6tBKM6A6pnVslycg
         TBbPYM/YiBPBelV8/tc8E7wf816rl0zBM2+NrlkwIEbClbExaNWTlMu+f1rAVZYallXs
         0AvatB4ijMUBrLQvkUmzRIN9Bi9d9pwxVDbPJ8rUWXd0OvUlBB/1XuuHMEKWhwdRO16f
         Cam+3s/s6YSizVglDIPlTB2w4vqsr6R6gjVHdqKcWonbRQsQyUylB0+Xj/5muY1qahBk
         iIYdGumE4WkgOk0xeugaXWtLLSqY1MjLNt/2so3C76/P5jL4pD7naBXeSpeDqZVvYtvv
         MxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wdenUEJENVIVipxrbo4b1ygCInnbwIE19qxWHQENdgM=;
        b=dmTFtMLfbqOhnPIY3S8qh78G3Rj9It2CR/Ne+4LuNzGkPSTsex8Zf0oZQWH1Mdp86k
         sVosgKLbI6gHBaPREMI+gPIQhArKmnyAaoLD5k+SnhQMGb5wbrBaAEK4f9lmcMeZ5gls
         4Uk37tYfPGuqSaSwvRtzUM8maYLuhqMwIBEipm/1nCSy59x5kydpOGtSXZqw+HWbXz1P
         vMZQIT+1ns8hPERPcZlTLEP+CIUlzH/YXCMqGJWvVInY9nJlF8Fp/lHV91vuGMFFOchF
         RTxZ6fHfS1WunReWYy/af9QNBZvIprwO/h1VOreRT/A0NlHv+XGIxZoHMl5A575N7xKN
         PBlg==
X-Gm-Message-State: AOAM530GZpiNWPd57bLqiE/c5BULQ6DvNXaL+5LOU+uXwDIL6zYFTAFk
        XYADrnLaiYiSJjuAwlbFArx+O+IwUM2INjbe5qJ7Nn/dzxzIs8ubirbU9iX/98PY2VuUfcrat9S
        +IdbXMZCHXdIZVRE/HB9UMDR8rGY1o5yuCKUuAcT59dYe2KhObCSpxxLm5DFJtx0W+tvsZroR/l
        Rs
X-Google-Smtp-Source: ABdhPJwwZhjpqjvP6BxrsVB2t/l3FgItwvQxrgrsqp2kLROMQiBrfXMhYOz5Nlmqj2MZM9pZGOrkYeuUTmAD
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:5249:e81c:3ce6:f50c])
 (user=apusaka job=sendgmr) by 2002:a62:1996:0:b0:3f0:947:396d with SMTP id
 144-20020a621996000000b003f00947396dmr1371028pfz.75.1630555680929; Wed, 01
 Sep 2021 21:08:00 -0700 (PDT)
Date:   Thu,  2 Sep 2021 12:07:04 +0800
In-Reply-To: <20210902040711.665952-1-apusaka@google.com>
Message-Id: <20210902120509.Bluez.v2.6.I0e4236b0928a4359e2f43d0a2ae62e2f20bb3ff4@changeid>
Mime-Version: 1.0
References: <20210902040711.665952-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [Bluez PATCH v2 06/13] plugins/sixaxis: Inclusive language changes
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

BT core spec 5.3 promotes the usage of inclusive languages.
This CL uses "central" as it is deemed to be more appropriate.
---

(no changes since v1)

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
2.33.0.259.gc128427fd7-goog

