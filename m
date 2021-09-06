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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DF3C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Sep 2021 08:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC14860F92
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Sep 2021 08:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240630AbhIFIG0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Sep 2021 04:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240622AbhIFIGZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Sep 2021 04:06:25 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76746C061575
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Sep 2021 01:05:21 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f64-20020a2538430000b0290593bfc4b046so7517043yba.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Sep 2021 01:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nCiATbOwTZU7cpvcAmN6qMTCtvrdP/lnLGl+wNXlnz0=;
        b=dWgPXrm7EeMWNmC2JaBlBkIcCoh8yIuogHd+P82ljnmBwFTrn3xR0Jfg6KAaDU5HDV
         Ka+5jMkr6XygKlmHUBiGo3SgWXjnjh+6QPoTE+zgjH2jljA7Ks52ggKXo4HoJ0/jMC4B
         /kXDvSGdUbrsy8VYJysCRKa3dTDnwZU1By6LhYifHXo1buqerIxnMR08feVQer1EfDWO
         JSwNMdJgBEV7Shoxs0gsskcfXNZ65r/3ojLZrpA+tzwFjbdvDXoKgoTJrOpN7w9I+1Aa
         IqFhMzlSPhrEQopPb5il0wMAFs1pvmLc0QgAhWEdFn+mTDo+rZsTGcJuOi+wRqNti9tc
         NVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nCiATbOwTZU7cpvcAmN6qMTCtvrdP/lnLGl+wNXlnz0=;
        b=Qd6XouMvv6zjgRR0oR+YS1ktEKpcRH/FQRFMOS6Zu+rV/QfIArWgHX4g5Kao2PR4mi
         t+n39npRFgte1djH5HH+yZEISYxI0Q8/dKgo8e6hGi1Mir35LebN6MPuNUTzGNW7rnhb
         6sPldRIX0o1+ZTAZxuiJx8QEM8wySyPhEuJCywDqG/GHT9QcxoIkFOR3ektn2YL8DfGa
         o2Cut2AJLX3hvJwUqOJXFQy52vZ1oUJkOTWL8hyvHWzoBt39uWR/2Qnv/SzMRJ91DeJP
         GDmTP12OZKeqDs5IJNRJRp7TtG21lznY1B4bcNruH7UtTTwA7IcDSavICqj8std9vrSp
         BcSA==
X-Gm-Message-State: AOAM533yspjX2IYWiaGUxeuuclfyrUoiAwf9RnY3+iseVX6vl4P8F1XK
        lhBWkZP4H3MjtNx5wAbCfqz17XJnJvxAsa2URW5oHL4Ld8+8jcmcW4ZWz3xxkbBP222ZoMlFF5G
        br/f06CtGRx6YbDRxTzAdHnJk0l7LVggoah/yacC/lB8JTiDKXyaV0DhFLO5EgXSfvMEVTYvA0U
        Tn
X-Google-Smtp-Source: ABdhPJxU7X+4KbQ08dBlJXUeu8qYO9y21jPoRPkxgQCVlPUkKpYj4FiG8sM/zadbA2AUukZvV8NIwr8MLnc+
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:3b13:95ba:12e5:7134])
 (user=apusaka job=sendgmr) by 2002:a05:6902:513:: with SMTP id
 x19mr14908700ybs.90.1630915520668; Mon, 06 Sep 2021 01:05:20 -0700 (PDT)
Date:   Mon,  6 Sep 2021 16:04:44 +0800
In-Reply-To: <20210906080450.1771211-1-apusaka@google.com>
Message-Id: <20210906160340.Bluez.v4.6.I0e4236b0928a4359e2f43d0a2ae62e2f20bb3ff4@changeid>
Mime-Version: 1.0
References: <20210906080450.1771211-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [Bluez PATCH v4 06/12] plugins/sixaxis: Inclusive language changes
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
2.33.0.153.gba50c8fa24-goog

