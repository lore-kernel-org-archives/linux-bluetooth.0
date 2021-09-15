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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E801DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 08:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C309D61209
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 08:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236890AbhIOIek (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Sep 2021 04:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236929AbhIOIei (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Sep 2021 04:34:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE5EC061767
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 01:33:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v16-20020a256110000000b005b23a793d77so2660398ybb.15
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 01:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UfrF3VYQdX5Hv4/QEbC4x1htPDI/mw8wQZDF/1St4Qw=;
        b=UgJ+tc2Bh0O/biZn2tjAnZT3HswYRB4jKQNVmNQEI4tnh4ms/Z/snNPWM6PbXGmQAi
         KjPGKNcqVP6OkKaE+G4/OVEdgy7Sv9e7DiCmXC4h+hncYng36zmVEMdcpmTzWJyt3bEa
         5ATNM9N9kiZNpU0SFiJpneSZdegT7Fnrmqaxi/wTgXrsDPSavyMgfenGmDJdHUY4see0
         W1aOO8QlMBOfzwpHmqcR0f76qpbaL9hKBKWuLP3MKGDIn8MJ6OP/RZUBDs20TWktmQ/3
         RS+eU/NjYvTCnEOz9ri5uADjRsiZTPE42yZKq26s2Sx876VOSB0fK1VrWb68qTYyE9NZ
         UegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UfrF3VYQdX5Hv4/QEbC4x1htPDI/mw8wQZDF/1St4Qw=;
        b=bS37YWBj+N5SCUNq2Hd0Hps4qYnMoVTf01djPn4i5JndS8hG1yRXni8FhaYmopZTIn
         FeuaXxTyIbrsC/FxTpm72cO7okdJvCn56qZ+cN9+bZWCbUR/y3wk6TIjOZvHLu2xsFVq
         BJtJRx1vmBmLd9IasP1FKM5UlN4hh4gFYL8DQq4ykyn2xgNSv6Emk70T1Cft03903NyB
         JwpzWnEta+LmhUkfSJXsuxe++OG/wCrLm5cIo7Q6As9XnWJQgcBGIwFWZBa0y/OvGfsR
         nwaDYUoWFcfSXG7H1yVyqfw7ZH1tnGZWFlLtAYTZcMtFtmaRMa28UbeGcgRZP6GgTG9y
         a/3A==
X-Gm-Message-State: AOAM533UZIr4h0/OLUhJqsVnn8ytEsc9KaIciC99mgq1sSt7jOPktkhc
        qQTDlp+ARqjaYyMTXdx/vg3h6HvQh2G5SwlSrJmyuiP+voPKc8Jn6UADOggWrVJE6I1m3WJgnXa
        9xeQqZwEqx3ThqJ4J0TmorZTAnRGnJV0gMbitcDqCO+5nmUIVGPLarFmCYJoUmMPORXZFbgwKZ2
        Q6
X-Google-Smtp-Source: ABdhPJyJU8wLgZFtSTh1DMNoviNGa+s78Kl2NUZKf1qsSXKYHNNN+SV9h/zosUcylw4oteF0H2XbnIfep5Bb
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:3c6b:8053:7e45:276b])
 (user=apusaka job=sendgmr) by 2002:a25:5606:: with SMTP id
 k6mr4711196ybb.476.1631694798721; Wed, 15 Sep 2021 01:33:18 -0700 (PDT)
Date:   Wed, 15 Sep 2021 16:32:03 +0800
In-Reply-To: <20210915083207.243957-1-apusaka@google.com>
Message-Id: <20210915162843.Bluez.v5.7.I0e4236b0928a4359e2f43d0a2ae62e2f20bb3ff4@changeid>
Mime-Version: 1.0
References: <20210915083207.243957-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [Bluez PATCH v5 07/13] plugins/sixaxis: Inclusive language changes
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
2.33.0.464.g1972c5931b-goog

