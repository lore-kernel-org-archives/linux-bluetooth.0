Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB47C64E7B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 21:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F0D52084C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 21:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MxsTf7mr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387546AbgK3V5o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Nov 2020 16:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387499AbgK3V5o (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Nov 2020 16:57:44 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD5CC0617A6
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 13:56:22 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id b6so11308914pfp.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 13:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Osr2t5lC/rtahR1ayaZEYydm7foHMd951I0Pg1nz0qM=;
        b=MxsTf7mrD7rP8KLHUxvDe2GyTFuH1fnOIhpdgh8lJ2xjM6EMqr7eHYwa398mkuXXas
         GLJDi8+nyjOOBTSSyM0Vvhshs355FkOU+hu5GGtKedwgtZCbQYmizPPY0/eB9eIgD+V9
         krJ1LHK3NIrc38Ct3n25ylKyQ4kdgLMHx/HIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Osr2t5lC/rtahR1ayaZEYydm7foHMd951I0Pg1nz0qM=;
        b=N3zHs8ekYwBSEByKe96/OIYF34sEOeLKoBX13Gq2NIiPlRqgZdEtyziBO0pEggCQoW
         aPGqe56SU9Z5eEuSgoAaGeXPaxFH9z9Nu+LtITJ9hlX5xQXNchHmdhr4KzIoA1MnYewW
         Am0irFk0wUKx2AJh8egmOf9E1PXK5bSbSnPK2H8JArlkJQglnis6HqQIHMOaLzS5KjMP
         n0tcRVZ29vt4r6sk+mANIeciisaGwYFnMmyVrEqFLB4DLRzfX2yv1/bq9Nlm8sg82CCR
         XFSVDOP7GwjUBhHz40d8NmBxU29eIOUh+8lPpzJ4HdBWgGICYKdYBxyo/f/A82DGm1QB
         saeA==
X-Gm-Message-State: AOAM531pOX7nnjxIBGs96k3N6nJUnQ2JzK5+zWNtbgm2WE/myMrIFB0U
        t2HqfqzxPjZ39WQ5eTQheq5zbhN6JMV3Vw==
X-Google-Smtp-Source: ABdhPJypw3rdUgTV4uKSG/iClzrFdfNdTMxlPvvCnL2EhtZfgGAQfhXIM+gXhwf4FCIOamZVQ1wQzg==
X-Received: by 2002:a63:211:: with SMTP id 17mr19942683pgc.56.1606773382138;
        Mon, 30 Nov 2020 13:56:22 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id 23sm17476588pfx.210.2020.11.30.13.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 13:56:21 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [PATCH BlueZ v5 6/7] adapter: Add a public function to find a device by path
Date:   Mon, 30 Nov 2020 13:56:01 -0800
Message-Id: <20201130215602.386545-6-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201130215602.386545-1-sonnysasaka@chromium.org>
References: <20201130215602.386545-1-sonnysasaka@chromium.org>
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
index 56d0c6eaa..03d9d29e9 100644
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
@@ -3192,15 +3216,6 @@ static gboolean property_get_roles(const GDBusPropertyTable *property,
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
index e5750a37b..60b5e3bcc 100644
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

