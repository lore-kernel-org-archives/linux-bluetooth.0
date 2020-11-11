Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D070DC388F7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 00:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CDE621D7F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 00:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="On0qZtrD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732295AbgKKAhy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Nov 2020 19:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732289AbgKKAhu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Nov 2020 19:37:50 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B79C0613D1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 16:37:48 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id y7so414484pfq.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 16:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2hhs0cimnIAGDXquUQAWrxX/tnrV59lDfBqhqkbcuJM=;
        b=On0qZtrDPG3zbs8YyjbbppUr4hlby5vQCmvDqZ08cREsuNa2aqu8ncH4eAjv6G2eTL
         zTWpLbf309hhJh6NS5h4F9BexwjQoghiJERJdoZ10hyOWD3GXNSr91+S5EQ2RsleiX5u
         zkhMBDG6IHyy8GDfDKBfPoY3J1CiMn1Ii7dU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2hhs0cimnIAGDXquUQAWrxX/tnrV59lDfBqhqkbcuJM=;
        b=IvJ4psoAr2hf6eNZLK0vEDsjitPaLEGRIykbazGnodh8WHJfO1SG1/NXbCnmwEfZ4P
         akMQYMti4LdfFGkk795GYmNLpNkY2ON14ZqG6i5uVGv83Yxvfj2UW8gIiVi0ZLLoG5zo
         bt/E5NCLlzhcSBEb6h+YA4gayD+DMjlIuRFEckF770bZ/zhE3nLylxcnZmriuDk98pyY
         THEU8fZM6yzpws22V95pcTj+zk3nnpQ71BxRS79u8dscRm8YsRwP2mSMRp2WltOAVwrq
         etz39vgEu0ek+d+gelAZplqiLCBNOp0v8Hj6Y4lG0gPNEnvOwsRnTLK9eW6t1FrkiHRG
         clGw==
X-Gm-Message-State: AOAM531/YXIkHxOBIq+24QjDmsQOuFPCv4Uz+KlFUjVRy2LHke63iDLd
        ShgmhUR14vTht2bQh+Rtxq4dR2cLtFrS3Q==
X-Google-Smtp-Source: ABdhPJyBpY+6Hf19dyijpoipMvqrezDO9HKgxCA0wfmII7+bmsGb4hQlmwG3wsp5fE0UxMOMla1j3g==
X-Received: by 2002:a65:4287:: with SMTP id j7mr18916654pgp.183.1605055067929;
        Tue, 10 Nov 2020 16:37:47 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id b16sm180655pju.16.2020.11.10.16.37.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2020 16:37:47 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [PATCH BlueZ 6/7] adapter: Add a public function to find a device by path
Date:   Tue, 10 Nov 2020 16:37:19 -0800
Message-Id: <20201111003720.1727-7-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111003720.1727-1-sonnysasaka@chromium.org>
References: <20201111003720.1727-1-sonnysasaka@chromium.org>
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

