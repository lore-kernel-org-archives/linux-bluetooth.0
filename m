Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420F9C61DD8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 01:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F33EB221F1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 01:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZRHeaN0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733048AbgKKBSA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Nov 2020 20:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732586AbgKKBR6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Nov 2020 20:17:58 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2054EC0613D1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 17:17:58 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id g11so89235pll.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 17:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2hhs0cimnIAGDXquUQAWrxX/tnrV59lDfBqhqkbcuJM=;
        b=ZRHeaN0J0ZhyTHVueA0FXCBSpj/l2dTjM6YarY42ve3C0Fo1BbzWA7bjCk/V0326rJ
         ykqbX5sJoMY7cL0gTHAKQt+c0VaeSLluqtt/W19FpkGunE3L4kQ5uYja4dahGzUBNxry
         j0VTxOlamTchrtswV5ohancalGmg5jya/GRiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2hhs0cimnIAGDXquUQAWrxX/tnrV59lDfBqhqkbcuJM=;
        b=ngOO7c/2+QxhhtcqYmvPOPsMwN+F4dTxSYZRcifYX7C3H1JUezoQb0tuap0F6dAYgc
         vQUPZqVPyQNjfAyeTK353qdy9l3FFl2Tq/WSFJGXi77BTa4NQvqTOaqRe10bfHVIoiAv
         1qWbhYA0mMThbSeC/tJJvjGn4pKFIicQkjl/w8iR3iIQimfb9Jl/lwHanY3MhnhBAKdu
         IhjL6+UIs4fBB3l0T32uwi9zW3PeZoWYqlouAWKrWLsBilRo0h5bWkfL8JKSLHwF8dzW
         ABjSY5GQBgYb/2dS/H9/tB4gyiLjk849Jrj+kGNH4NsT8wMwUdsvlQC2gcbxjQEK8zbb
         IYvw==
X-Gm-Message-State: AOAM5308m/XRSnUImMc8Qnz3TKSxmlTArud2M+FjmGbkUts7qx9TqzxL
        g3Grc3Giipjq0/D9h3Fe7NU/fLFwTB5zkg==
X-Google-Smtp-Source: ABdhPJwiqAKeWrnaprYS+WB+1JTjiyzAoC+5mnAAOH1Nm6e7Syxyd/7LomdbDG948TSMJOqDoR95xg==
X-Received: by 2002:a17:902:7681:b029:d6:42d5:6af3 with SMTP id m1-20020a1709027681b02900d642d56af3mr19353876pll.12.1605057477475;
        Tue, 10 Nov 2020 17:17:57 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id y19sm331695pfn.147.2020.11.10.17.17.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2020 17:17:56 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [PATCH BlueZ v2 6/7] adapter: Add a public function to find a device by path
Date:   Tue, 10 Nov 2020 17:17:44 -0800
Message-Id: <20201111011745.2016-6-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111011745.2016-1-sonnysasaka@chromium.org>
References: <20201111011745.2016-1-sonnysasaka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The public function is motivated by the Battery Provider API code which
needs to probe whether a device exists.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

---
 src/adapter.c | 33 ++++++++++++++++++++++++---------
 src/adapter.h |  2 ++
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index c0053000a..d27faaaa3 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -872,6 +872,30 @@ struct btd_device *btd_adapter_find_device(struct btd_adapter *adapter,
 	return device;
 }
 
+static int device_path_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct btd_device *device = a;
+	const char *path = b;
+	const char *dev_path = device_get_path(device);
+
+	return strcasecmp(dev_path, path);
+}
+
+struct btd_device *btd_adapter_find_device_by_path(struct btd_adapter *adapter,
+						   const char *path)
+{
+	GSList *list;
+
+	if (!adapter)
+		return NULL;
+
+	list = g_slist_find_custom(adapter->devices, path, device_path_cmp);
+	if (!list)
+		return NULL;
+
+	return list->data;
+}
+
 static void uuid_to_uuid128(uuid_t *uuid128, const uuid_t *uuid)
 {
 	if (uuid->type == SDP_UUID16)
@@ -3184,15 +3208,6 @@ static gboolean property_get_roles(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static int device_path_cmp(gconstpointer a, gconstpointer b)
-{
-	const struct btd_device *device = a;
-	const char *path = b;
-	const char *dev_path = device_get_path(device);
-
-	return strcasecmp(dev_path, path);
-}
-
 static DBusMessage *remove_device(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
diff --git a/src/adapter.h b/src/adapter.h
index dcc574857..a77c7a61c 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -83,6 +83,8 @@ sdp_list_t *btd_adapter_get_services(struct btd_adapter *adapter);
 struct btd_device *btd_adapter_find_device(struct btd_adapter *adapter,
 							const bdaddr_t *dst,
 							uint8_t dst_type);
+struct btd_device *btd_adapter_find_device_by_path(struct btd_adapter *adapter,
+						   const char *path);
 
 const char *adapter_get_path(struct btd_adapter *adapter);
 const bdaddr_t *btd_adapter_get_address(struct btd_adapter *adapter);
-- 
2.26.2

