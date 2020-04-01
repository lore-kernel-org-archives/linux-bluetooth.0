Return-Path: <SRS0=i/J9=5R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1466C2D0F3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 22:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81092071A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 22:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gMwCakW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733145AbgDAWOs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Apr 2020 18:14:48 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:56082 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733101AbgDAWOr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Apr 2020 18:14:47 -0400
Received: by mail-pj1-f68.google.com with SMTP id fh8so674764pjb.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2020 15:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GnX5Nt7Up+YEMCQT60W+dd05dt1V87CkKO1W0aco5v8=;
        b=gMwCakW7XNv2bd1beH+lvVbMfg8/w0EwOkV2a+sbP8qQilH8wuHBWM6LNUHFzH37XO
         Ql7c+u+lx0TKZteDhlpQPNESKbXuH+1pubpqOxaaXy6cB4sd0ME/grhTJ3+CFL9SVv3h
         zSYWrUc6S7tUWyM1UF6vvwnGTLa4xcmPs3+b0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GnX5Nt7Up+YEMCQT60W+dd05dt1V87CkKO1W0aco5v8=;
        b=YSK4XXhDFzM/q8hUMji53MAnNH0yVX/JxHmupEm2HJBAFk6ZhpP+bTZc29nxanlJTb
         EVgPATHq70OwD2D4tCS0UuxsQvC7Luv6fRTRDsiGXlwjyNFwSIwiwmeDJnlGevLgN+vq
         zRxk8/EP+I/ysuiPIH8buewFuTN5tN9sKF5ubmatpvtjCiuvHCbWdsVN7vUzf9mtw1wi
         +daWdgSjb9buYP182nb/hEltIdibqVts89bvlrBa/Iw9axh7YBA3F/webJrC59gPRsPh
         x6bEqMbEDVaZtpbHgXtGoCXytshA0PdXhE7L2GFNpldXbxNE0VGUd52at35J2rb/u0hc
         fnCg==
X-Gm-Message-State: AGi0PubulyhlVM3Tnthn7SX62f7amjRLIDXqAOyZQZbB6MllRL0Yw1Xs
        btc+V291+WjcHVyss4TdHT4fMduHKRQ=
X-Google-Smtp-Source: APiQypIitT6gJK1paGXfBRnfSqPcMh0jWPXxNBQdoLnTcGyW9wXUf0Q5ebV7al4L5m5YlNrpk+rjvA==
X-Received: by 2002:a17:90a:346f:: with SMTP id o102mr193540pjb.162.1585779286055;
        Wed, 01 Apr 2020 15:14:46 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:b7e2:9910:bd78:608d])
        by smtp.gmail.com with ESMTPSA id z6sm2394666pjt.42.2020.04.01.15.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 15:14:45 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Miao Chou <mcchou@chromium.org>
Subject: [PATCH 4/5] Implement RemoveServiceRecord method
Date:   Wed,  1 Apr 2020 15:14:33 -0700
Message-Id: <20200401221434.12185-4-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200401221434.12185-1-sonnysasaka@chromium.org>
References: <20200401221434.12185-1-sonnysasaka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Miao Chou <mcchou@chromium.org>

This implements the RemoveServiceRecord method of org.bluez.Adapter1 interface.
---
 src/adapter.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index c02aaf32b..1be3e7984 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3834,6 +3834,29 @@ failed_to_alloc:
 	return btd_error_failed(msg, "Failed to allocate SDP record");
 }
 
+static DBusMessage *remove_service_record(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	uint32_t rec_handle = 0xffffffff;
+	sdp_record_t *rec = NULL;
+
+	if (!(adapter->current_settings & MGMT_SETTING_POWERED))
+		return btd_error_not_ready(msg);
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT32, &rec_handle,
+							DBUS_TYPE_INVALID))
+		return btd_error_invalid_args(msg);
+
+	rec = sdp_record_find(rec_handle);
+	if (!rec)
+		return btd_error_does_not_exist(msg);
+
+	adapter_service_remove(adapter, rec_handle);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static const GDBusMethodTable adapter_methods[] = {
 	{ GDBUS_ASYNC_METHOD("StartDiscovery", NULL, NULL, start_discovery) },
 	{ GDBUS_METHOD("SetDiscoveryFilter",
@@ -3852,6 +3875,8 @@ static const GDBusMethodTable adapter_methods[] = {
 			GDBUS_ARGS({"record", "a{q(yuv)}"}),
 			GDBUS_ARGS({"handle", "u"}),
 			create_service_record)},
+	{ GDBUS_METHOD("RemoveServiceRecord", GDBUS_ARGS({"handle", "u"}), NULL,
+			remove_service_record)},
 	{ }
 };
 
-- 
2.24.1

