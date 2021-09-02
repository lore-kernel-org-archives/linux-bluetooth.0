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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207F1C432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 10:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A05A60698
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 10:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343546AbhIBKwP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 06:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245693AbhIBKvO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 06:51:14 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E24C0613D9
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Sep 2021 03:50:16 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id m9-20020a17090ade09b029017903cc8d6cso955403pjv.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Sep 2021 03:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wdenUEJENVIVipxrbo4b1ygCInnbwIE19qxWHQENdgM=;
        b=vYn92NKMgbf1T4fxdie/qsbOAj04I2WsAXCMI6IERixlOn5nuTTD5gRKYR4zC0VXRI
         NwlYYSI99ggdxBH/yar0+y0ykhzf6kn/bftvBDxsqCX4OuMoH1+yEEq0OFgw9Kczkt/r
         tpXtt/wxRuQbhVCTDA2t9BQ4pRZp07IwRXKV14JpFor8RJ2piGepa/3Bifa5Wupcn6fE
         VyNmlcaAkeB/w/+7/n4JhGLYDnXoNrI8MbJgkpEH1+ejWNAkMrAO4yhVYBDzrqTWP/a5
         pt//ryCdU34xyEJGnQINP6EQJc9BHG3WAITbH9ytUQKGp16qHDuTD95F/i8w6YGOxQDX
         eJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wdenUEJENVIVipxrbo4b1ygCInnbwIE19qxWHQENdgM=;
        b=XlqMPlrfTwgHNPS1XR0Vv0hxZ5C7RN2/4y6pNqmr3/oDIRYvYbdrAFtCYnZId907NU
         7HgdW9XLyKLuKw5tE5wfywv1IUR/onvGjp5y0z6j+p7RkuJGaSahoFAzSsik3QIs6dOD
         w+WrAzBMk3uM9XkZ/R1tQSsLZxaJc1EaCkM7R/5PLAObxMxOAjLqkpSisXojJf7WkonZ
         pT5zMz54BGrsmYNW4yVOjkyUCxjukkogK7jYjp9WcFOV4S8E0ZpLUWs+TWxZQCEm9tHT
         bodeGlGp3gn01/DaP4LZYDoddZbwUEF3x1XiB1tRrjDojN58m1Ny82heUBHeOv55nmGo
         cFaA==
X-Gm-Message-State: AOAM532BmgQcWJrneeRCKOSZ4IuE8df/OTuxZPYdzisFx/M//MDHSpYr
        0dOjGmGoss3/sN9XSOZtUYMnxZhzT2rBJb+4FtwErpYkSH1AQnavtild0qMGEmXOnnlssCC63t7
        FUsefxcPGrmlN7asyLub+HC3iT0HiuvYNtjC3McnXtvivPCWgUONXy/iVgJuqMAyDXCuB4JFVMj
        8P
X-Google-Smtp-Source: ABdhPJxeoicnuygFDDhO+pXnw91487caV2O+stIY58O04+hLwbjRD7v1G7WtI2gvb4XtoXhSM+DIVpO3ivid
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:5249:e81c:3ce6:f50c])
 (user=apusaka job=sendgmr) by 2002:a62:7c02:0:b0:3f8:f3c3:1b32 with SMTP id
 x2-20020a627c02000000b003f8f3c31b32mr2943380pfc.62.1630579815481; Thu, 02 Sep
 2021 03:50:15 -0700 (PDT)
Date:   Thu,  2 Sep 2021 18:49:32 +0800
In-Reply-To: <20210902104938.824737-1-apusaka@google.com>
Message-Id: <20210902184744.Bluez.v3.6.I0e4236b0928a4359e2f43d0a2ae62e2f20bb3ff4@changeid>
Mime-Version: 1.0
References: <20210902104938.824737-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [Bluez PATCH v3 06/12] plugins/sixaxis: Inclusive language changes
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

