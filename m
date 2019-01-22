Return-Path: <SRS0=wtFT=P6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7F4C282C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 13:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20A420879
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 13:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pt0ceBGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbfAVNpk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:45:40 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:36147 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbfAVNpk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Jan 2019 08:45:40 -0500
Received: by mail-ed1-f51.google.com with SMTP id f23so19348862edb.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jan 2019 05:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Hcgc2TnKILwgJXFnljthixSWKSrB7d8XKXwMinppcTM=;
        b=pt0ceBGmZBHoTa4/qbr8fH8lcr7yrAkLTaTKgiFYi9PYwZTkE7S0bHDQkU9SH9uN5T
         O7dHg3dTZeBKLNkxF5WXvxWOMlmtAAjMtmHtb3w2lu/Gxz2NgneohkPSeUT7+tuw6CRC
         IO3gFAs93br72hu9KO2KMh8NBqX00qvkQYkZVMVDl7zU+zTMf8PPYNiOQxZUIFwx8f0J
         dUaRc+YHuwopmcJqhziscEY0g5ucApHgZwYeLRqDkLgaf0NSW8GkimrIlLQBciP3CEsw
         SYxOJBbEIG2/t/86O786dFLy6o101e3We2OgVfffXrFccmkCYfYwuHo86WIIs/DCJQBF
         MQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Hcgc2TnKILwgJXFnljthixSWKSrB7d8XKXwMinppcTM=;
        b=BfwLfBuMLxpuWxPKNy3l0XPJ8RlP3d+TXpCe9nHKWAfD13PkpkdMLTFl00OcFkrIFH
         Q05T6uVIr2r8Pl2i4mmabTLplL0t3dk8BW3O27TrRtNa+XYbsPW2SSu0havNQBWOP23H
         iXedlR79jrVlbm40jrABI4S1ID6MOUXErIChuMwClCfuMFnpgqy0Ypv6kCLr3gjMJYQC
         kL3kLQ8Txe+h5hGwS7PUtmRT80ziBzrc+D+ILTs0YcdZCw93xoaowl6bJ36dOWImmJBb
         wcCRlkaqixe8UGKxTeoqttKOWV1jKsQPuYGMk15Iz1LZ3hKGwLEmxHaWxvIcIJH1waFc
         plVQ==
X-Gm-Message-State: AJcUukfI8U+pA93o6xcaVaN8zyuCAQRSV3Dc0MrlT+zLjn4s2piY57VT
        3OR5Nl/C4994/WO21zWY87uComzS
X-Google-Smtp-Source: ALg8bN6+sJVyRmDs8GK3JrsbAO7IEVLEjA++dOqCFNDAU+CqzsXCGQFnEpL6E6qSaZiMILss/m21uQ==
X-Received: by 2002:a05:6402:758:: with SMTP id p24mr4876015edy.92.1548164737545;
        Tue, 22 Jan 2019 05:45:37 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id dc5-v6sm5319153ejb.53.2019.01.22.05.45.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 05:45:36 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 8/9] a2dp: Add implementation of MediaEndpoint.Device
Date:   Tue, 22 Jan 2019 15:45:23 +0200
Message-Id: <20190122134524.20509-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190122134524.20509-1-luiz.dentz@gmail.com>
References: <20190122134524.20509-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the implementation of MediaEndpoint.Device property so the
clints don't need to guess what device the endpoint belongs.
---
 profiles/audio/a2dp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 6975682c9..ff384cd23 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1718,6 +1718,19 @@ static gboolean get_capabilities(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean get_device(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct a2dp_remote_sep *sep = data;
+	const char *path;
+
+	path = device_get_path(sep->chan->device);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable sep_properties[] = {
 	{ "UUID", "s", get_uuid, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
@@ -1725,6 +1738,8 @@ static const GDBusPropertyTable sep_properties[] = {
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ "Capabilities", "ay", get_capabilities, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Device", "o", get_device, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ }
 };
 
-- 
2.17.2

