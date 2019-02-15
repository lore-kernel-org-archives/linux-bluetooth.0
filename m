Return-Path: <SRS0=5uBP=QW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF9DC43381
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Feb 2019 14:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F7D2192D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Feb 2019 14:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="soTGvbyn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbfBOOXK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:23:10 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:41502 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729284AbfBOOXJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Feb 2019 09:23:09 -0500
Received: by mail-ed1-f53.google.com with SMTP id x7so8078765eds.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Feb 2019 06:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=uvs5bZmrE8I5KeqF+66abgiJeX34abRhjaqbk8/TvsY=;
        b=soTGvbynM/uiJDazZpkzfWEk3gjHREirsJwIBsFua1cJsOTEplnZSqn6vSmzfMMCCf
         KxW9OitMPkIKNOCMSe+zGF3pXV6ZFQNlvxsJrBOd6wrJ8uqI4srb0FeZCZQiEm+5I/+6
         EryoGarM9duNUqKLNCI7/cuU4PpjhaXQK5by1S6hD/GQDVgbTjx8nrH7nMawSfOzGx0Y
         lTuo4eYCLbHxQ0kjc3ravsQL1TkTuw+zagpmLGpOzGIOFZ+BaBjRbDoBbzcd3DEq7jQa
         WPpj8WMXiB8gAfUOryF/GSqW7tYDl0PaqVll262UhXBf6pJ7frVmQbgAbrAc2CWGKwze
         ONPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=uvs5bZmrE8I5KeqF+66abgiJeX34abRhjaqbk8/TvsY=;
        b=Q5nFBJzmdAstoSUnDhj/ITijm7kcGqUoQTPmO/qdiK3fBWH8vKeFYgBciIhku4tDus
         smd0edOUTqeNzAg5eACBnZrT2hp1aG/qQ0OypPPELyjCP2rmhze8jnqdV4yJu+jwergy
         WAknKeUJyZqz2cIiYZL+s5UalwT+1iJZxH4cwFbAvbHEQRkqjBg6RnX0dYNe1R1uYYRm
         XTA0QoDA/AlAGG1yt3ep1jZujl68Ooxgg/Dpj6kzO8l5uyzPsgbthEHWso6wKeAON3IT
         VwYFsLAEjIZrhtV56l1AhMjk+xkT9gnJh904dmxxo7XBEljsT71y0HkWSojT0Zypjn9W
         +76w==
X-Gm-Message-State: AHQUAuZaz02iYEArLOUtWutSQo7r9NodW+cnIPmOCb5U+fSImPuDtH/W
        +8Wf6mqQJlvFR54MIPmavsAv2GqU
X-Google-Smtp-Source: AHgI3IaercRKGsRQrZ8m9o3B23+d703hGoDdqBpLFu/KrpcOqZh2F19kEjDtK3548k7hy0TxwkvAlg==
X-Received: by 2002:a17:906:1c93:: with SMTP id g19mr6940599ejh.55.1550240587478;
        Fri, 15 Feb 2019 06:23:07 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id v11sm1501333edy.49.2019.02.15.06.23.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 06:23:06 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] advertising: Add implementation of SecondaryChannel
Date:   Fri, 15 Feb 2019 16:23:00 +0200
Message-Id: <20190215142301.30909-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190215142301.30909-1-luiz.dentz@gmail.com>
References: <20190215142301.30909-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This add the parsing for SecondaryChannel which indicates what secondary
PHY shall be used.
---
 src/advertising.c | 52 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index df7ebbf81..8cda6a372 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -874,6 +874,47 @@ static bool parse_discoverable_timeout(DBusMessageIter *iter,
 	return true;
 }
 
+static struct adv_secondary {
+	int flag;
+	const char *name;
+} secondary[] = {
+	{ MGMT_ADV_FLAG_SEC_1M, "1M" },
+	{ MGMT_ADV_FLAG_SEC_2M, "2M" },
+	{ MGMT_ADV_FLAG_SEC_CODED, "Codec" },
+	{ },
+};
+
+static bool parse_secondary(DBusMessageIter *iter,
+					struct btd_adv_client *client)
+{
+	const char *str;
+	struct adv_secondary *sec;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+		return false;
+
+	/* Reset secondary channels before parsing */
+	client->flags &= 0xfe00;
+
+	dbus_message_iter_get_basic(iter, &str);
+
+	for (sec = secondary; sec && sec->name; sec++) {
+		if (strcmp(str, sec->name))
+			continue;
+
+		if (!(client->manager->supported_flags & sec->flag))
+			return false;
+
+		DBG("Secondary Channel: %s", str);
+
+		client->flags |= sec->flag;
+
+		return true;
+	}
+
+	return false;
+}
+
 static struct adv_parser {
 	const char *name;
 	bool (*func)(DBusMessageIter *iter, struct btd_adv_client *client);
@@ -891,6 +932,7 @@ static struct adv_parser {
 	{ "Data", parse_data },
 	{ "Discoverable", parse_discoverable },
 	{ "DiscoverableTimeout", parse_discoverable_timeout },
+	{ "SecondaryChannel", parse_secondary },
 	{ },
 };
 
@@ -1234,16 +1276,6 @@ static gboolean get_supported_includes(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static struct adv_secondary {
-	int flag;
-	const char *name;
-} secondary[] = {
-	{ MGMT_ADV_FLAG_SEC_1M, "1M" },
-	{ MGMT_ADV_FLAG_SEC_2M, "2M" },
-	{ MGMT_ADV_FLAG_SEC_CODED, "Codec" },
-	{ },
-};
-
 static void append_secondary(struct btd_adv_manager *manager,
 						DBusMessageIter *iter)
 {
-- 
2.17.2

