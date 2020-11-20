Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E1BC63777
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 20:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2927F223B0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 20:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S01E+jmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbgKTU55 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Nov 2020 15:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730387AbgKTU55 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Nov 2020 15:57:57 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807ACC0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 12:57:57 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c66so9047494pfa.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 12:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Osr2t5lC/rtahR1ayaZEYydm7foHMd951I0Pg1nz0qM=;
        b=S01E+jmfS95tkeThCaHIzMh+Ap6cSUAnbaFq9QviXZ+JTwZGwOB4kIiOkGwK+JE3Pk
         vIIhj4NA17xyHJuw1q9vGtIAO65N5Yvx5axvzmgUTXBSixDvP69InmZB9R9PdLEHjEa1
         RsK83MduUqsHfsT0rw/jBRRtrhs/J3J7KjZCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Osr2t5lC/rtahR1ayaZEYydm7foHMd951I0Pg1nz0qM=;
        b=ieWa1hOu+bZnLuABx3SD2L+8hBWsryNQ4OJ010Bzyvt9EXeaD+uu3pONBnFx0Sk8qC
         Jx3q/TDoBpPd8llLlJj58hPyaEsf0qZfmp25/WFLUzZ8aqITkAFrVwNuD16JS0c2VE3e
         6Xn1ku7MG4wy2at5w6007NYVaOzLJt2xJBsBBssW5Wkvv38XZf7Po7PJM76oSy9oI5Wi
         isRLhlSzIBvOn2Dy8JQpLfKyvimOk/2hSBU6cEn1ZPEhOQFq77DnVrVBMGwA1jc9KIb9
         LHyJtHNwWBbLnVnk5jnpfC1cimJ/aJa7yTdgrzd9PoZmdgsz5N0FC/huGpG+kBwWN62E
         ffnQ==
X-Gm-Message-State: AOAM533dkwyz5sDZUb6j/6Xyxqq9eIrmDugQ7NeiNNUtOhxUZucit6Cn
        354PSAB/R+hf99jb8sRuqCXA+OF4eBYWBw==
X-Google-Smtp-Source: ABdhPJyeF9g9GI3B2JWBKgnnCW2ecnw+wtk6UrJplH/Z3lKPXPw2HWml4mxH/OYFzbDWudH6nuorPw==
X-Received: by 2002:a17:90a:5310:: with SMTP id x16mr12274140pjh.62.1605905876837;
        Fri, 20 Nov 2020 12:57:56 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id a67sm3232080pfa.77.2020.11.20.12.57.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:57:56 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [PATCH BlueZ v3 6/7] adapter: Add a public function to find a device by path
Date:   Fri, 20 Nov 2020 12:57:27 -0800
Message-Id: <20201120205728.339325-6-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201120205728.339325-1-sonnysasaka@chromium.org>
References: <20201120205728.339325-1-sonnysasaka@chromium.org>
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

