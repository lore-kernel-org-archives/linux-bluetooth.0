Return-Path: <SRS0=Btsr=QG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484DDC282D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jan 2019 13:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B44C20833
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jan 2019 13:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdeMtUNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbfA3Nyf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:54:35 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:45922 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfA3Nyf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Jan 2019 08:54:35 -0500
Received: by mail-ed1-f50.google.com with SMTP id d39so19011062edb.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jan 2019 05:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=JQJ+Fb5JLVwAoHkDIuuGU1KVyO5CvKEsn/HGBtDkwO0=;
        b=MdeMtUNd7wnl4bqGdjFDE/FDh//xO48x4Pq7piN255ZwRpJKFJ85WQVP+xov8qlAjF
         vZ2OWt4P/b64IpYwV5sgN0UrvjY66LfnSA3JhMfRMvPSlKqfw7cWaVVk7M5DmlqYJlvq
         EGMp+OFxHoVusWD6F/G6YOdZjYIZYL7B2H41W/cheXaBI/4aOtn+mZXLoeTkmehMCBR0
         I/0JVlk/hd1EyMqr31sg2T7sx6IDq2EOA9gtlARvwTh6aB2xt5iqfHMdX6OtZI97C1pL
         s8OcKMRiReuIOdoBc+IgFQjIOJDEcj8HQ7ykUPt8bh4FlB8DknmBSxZY7CcrqaBDtQWd
         +S6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=JQJ+Fb5JLVwAoHkDIuuGU1KVyO5CvKEsn/HGBtDkwO0=;
        b=VaSjsI/3iufduWSDdIS1NNMzWgUbPhLR0m0vYz/VlW6/CHCz6GH77f21pk2ltMKEqt
         yBcDd97u4bLM/8JL4EZvym086UZw+CPihw4MnRlHKU99F8+9pkZ0ScH3i7UGHCTXHqDx
         4hXXGWS+J3KyYqN0MQw+psOdpBhPV+S2DOhTfRC8Wa+VilNvjGIGdAibo85Gt5dElqfl
         9523luRF4+smVC/5MxEDO82Y+gTzUfIF6EBSRufZeADB87R307JUVoaa+V+CLFIZhBTy
         TCGYyDxyw5lrK4m55TklppQl5NgTL30u8RFtqdH/BFA8712eBn8zZddST9B0zd3PGFif
         yYMA==
X-Gm-Message-State: AJcUukf7cMYxg9IYHKWAksP//g0n0v8suEIwhjRZiA77mdxdIPvmcVOU
        2dadmeVGjBtkEbxcfHyvxUgk/PNn
X-Google-Smtp-Source: ALg8bN4w/mfovHzkPqIC4Uk0VGZtQH9PjsP2fktWWAtp3av+0UOxREDElmhe32hCLFx/DEd3Ww7Nhw==
X-Received: by 2002:a17:906:2e59:: with SMTP id r25-v6mr22295815eji.186.1548856472663;
        Wed, 30 Jan 2019 05:54:32 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id s19sm325045eja.52.2019.01.30.05.54.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 05:54:31 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/8] gatt: Write back the handle to Handle property
Date:   Wed, 30 Jan 2019 15:54:20 +0200
Message-Id: <20190130135424.2091-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190130135424.2091-1-luiz.dentz@gmail.com>
References: <20190130135424.2091-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the application has set an attribute with Handle set to 0 inform the
allocated handle by writting the Handle property.
---
 src/gatt-database.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 025f777eb..b159786ea 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -2617,6 +2617,18 @@ fail:
 	gatt_db_attribute_write_result(attrib, id, BT_ATT_ERROR_UNLIKELY);
 }
 
+static void write_handle(struct GDBusProxy *proxy, uint16_t handle)
+{
+	DBusMessageIter iter;
+
+	/* Check if the attribute has the Handle property */
+	if (!g_dbus_proxy_get_property(proxy, "Handle", &iter))
+		return;
+
+	g_dbus_proxy_set_property_basic(proxy, "Handle", DBUS_TYPE_UINT16,
+					&handle, NULL, NULL, NULL);
+}
+
 static bool database_add_desc(struct external_service *service,
 						struct external_desc *desc)
 {
@@ -2645,6 +2657,11 @@ static bool database_add_desc(struct external_service *service,
 
 	desc->handled = true;
 
+	if (!handle) {
+		handle = gatt_db_attribute_get_handle(desc->attrib);
+		write_handle(desc->proxy, handle);
+	}
+
 	return true;
 }
 
@@ -2810,6 +2827,11 @@ static bool database_add_chrc(struct external_service *service,
 	if (!database_add_cep(service, chrc))
 		return false;
 
+	if (!handle) {
+		handle = gatt_db_attribute_get_handle(chrc->attrib);
+		write_handle(chrc->proxy, handle);
+	}
+
 	/* Handle the descriptors that belong to this characteristic. */
 	for (entry = queue_get_entries(service->descs); entry;
 							entry = entry->next) {
@@ -2868,6 +2890,11 @@ static bool database_add_service(struct external_service *service)
 	if (!service->attrib)
 		return false;
 
+	if (!handle) {
+		handle = gatt_db_attribute_get_handle(service->attrib);
+		write_handle(service->proxy, handle);
+	}
+
 	database_add_includes(service);
 
 	entry = queue_get_entries(service->chrcs);
-- 
2.17.2

