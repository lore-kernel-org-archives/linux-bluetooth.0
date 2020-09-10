Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CA1C43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDFCF2076D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mMZIaj0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgIJEhV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 00:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgIJEhQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 00:37:16 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D00C061573
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2020 21:37:15 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id k15so3886701pfc.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2020 21:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wgoIVPRWXVNntcbMbldt7TpPEHI4+Eh2hW+gjZOt2Js=;
        b=mMZIaj0NZ9xEAHaaPZidEIAITW8us9QoZ94vAL+aQsJXbN8IMFMwnlNlzXXsyWr2zO
         Bj5C6trz+gbSyKL1s7kn+dmBYE/+04JoFwQCc35z1sCd23gaaEtLV3PwRiBjkRZ5BIHS
         OHqossIt7YsJMSQoau5JQf37NlaFMahOXIURA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wgoIVPRWXVNntcbMbldt7TpPEHI4+Eh2hW+gjZOt2Js=;
        b=kK/8XIEP+fDmtIqxtJ/ngN3527VI0V/XROrahzBxEHp4QetkYJl5nRL6OPp7zOu0B2
         osgp/2acOM1uGrfpEgRCn/nkDmHObsjjb7BYL40L6dkrrhV3HxdIH5hwDdEKwNhZwRya
         sSjgkjvrAdVc+YwUXuWJn5PIXFSEB3h+dAjgBZ/henJGRJkX+3uf0iPm8jC8jGrzGaVn
         75uST6AE7La26h7Iw/e/MZJcOVqTSBsLeLi6h3g6D1/WoWh06OZ1bjYshbFmT2f1KXiU
         BHtB3RtmJMMbC6HOwb7rFPmm07j/+H/dBmD5oOSUY5nP3vfHSlkv8RoyPZojLtHUWK++
         EmRw==
X-Gm-Message-State: AOAM530NdoKHzK7v9yCegGBoZRzhMeZObFjzDa7+NRKWYrSAj59Vfc4Q
        ApTa/Mwj8u+IwLeWfE/R9tA/5iQaICmlhA==
X-Google-Smtp-Source: ABdhPJy3jqcGuJmD+yt4DwMgs2oXrRep81aESmkWSzzWikwtlNguSlpyLRrwDmBfhq0qHvF30S0T7A==
X-Received: by 2002:a62:3007:0:b029:13c:1611:6526 with SMTP id w7-20020a6230070000b029013c16116526mr3659217pfw.6.1599712635178;
        Wed, 09 Sep 2020 21:37:15 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id y4sm4149820pfq.215.2020.09.09.21.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 21:37:14 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Manish Mandlik <mmandlik@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v2 4/7] PRE-UPSTREAM: adv_monitor: Implement UnregisterMonitor()
Date:   Wed,  9 Sep 2020 21:35:38 -0700
Message-Id: <20200909213423.BlueZ.v2.4.I335e42ab9a238261c2492c308ce77c959f631483@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909213423.BlueZ.v2.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
References: <20200909213423.BlueZ.v2.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This implements the UnregisterMonitor() method handler of ADV monitor
manager interface.

The following tests were performed.
- Issue a UnregisterMonitor() call with a nonexistent path and expect
org.bluez.Error.DoesNotExist as the return.
- Issue a UnregisterMonitor() call with a invalid path and expect
org.bluez.Error.InvalidArguments as the return.
- Issue RegisterMonitor() with a path, issue UnregisterMonitor() and
expect a successful method call return.

Reviewed-by: Yun-Hao Chung <howardchung@google.com>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

(no changes since v1)

 src/adv_monitor.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index b8b55d2fc..1a38e6994 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -213,13 +213,48 @@ static DBusMessage *register_monitor(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
+/* Handles UnregisterMonitor D-Bus call */
+static DBusMessage *unregister_monitor(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	DBusMessageIter args;
+	struct app_match_data match;
+	struct adv_monitor_app *app;
+	struct btd_adv_monitor_manager *manager = user_data;
+
+	if (!dbus_message_iter_init(msg, &args))
+		return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&args, &match.path);
+
+	if (!strlen(match.path) || !g_str_has_prefix(match.path, "/"))
+		return btd_error_invalid_args(msg);
+
+	match.owner = dbus_message_get_sender(msg);
+
+	app = queue_find(manager->apps, app_match, &match);
+	if (!app)
+		return btd_error_does_not_exist(msg);
+
+	queue_remove(manager->apps, app);
+	app_destroy(app);
+
+	btd_info(manager->adapter_id, "Path %s removed along with Adv Monitor "
+			"app %s", match.path, match.owner);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static const GDBusMethodTable adv_monitor_methods[] = {
 	{ GDBUS_EXPERIMENTAL_METHOD("RegisterMonitor",
 					GDBUS_ARGS({ "application", "o" }),
 					NULL, register_monitor) },
 	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("UnregisterMonitor",
 					GDBUS_ARGS({ "application", "o" }),
-					NULL, NULL) },
+					NULL, unregister_monitor) },
 	{ }
 };
 
-- 
2.26.2

