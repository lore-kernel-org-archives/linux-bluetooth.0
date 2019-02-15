Return-Path: <SRS0=5uBP=QW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33746C10F02
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Feb 2019 14:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CD72192D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Feb 2019 14:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3vwUEo8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbfBOOXI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:23:08 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:42952 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729284AbfBOOXI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Feb 2019 09:23:08 -0500
Received: by mail-ed1-f51.google.com with SMTP id r15so8068387eds.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Feb 2019 06:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=C3SvbeZYykL3Rt5F4FBeBxQm3mwwm/iphG7fxKsWGBk=;
        b=Z3vwUEo8KFFuGlmdbNK0oUDx5+6Bixy9T2FKA0i8OildUDnvUfYVk0JozZmIZcbWUs
         mIiFBvS2Kb1ZBZor41uZOoyz5ct/ht1iByO5GsTeCUZ0cTIpuJlPWBItyjOZjZIK/1vv
         k2aBhP1DuL4qBOESFNTU5a7ZamgacQsd59eXBRr1gGNHpNjtQ6Wd5x+LFEgZBzy7Irxv
         XkMh1AHO1Pvn80bssMwPnjEd+2Azc4fyj0Na3LHZu+qdArPgwU43/5c3uZGwqBEL5q4o
         CEdzvFa0zaIvrQwL1p4YMKSbO4YGDzpk36XcnmfAAXC5YmEkwqt4kiCM2uymCO6Ugqlo
         zMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=C3SvbeZYykL3Rt5F4FBeBxQm3mwwm/iphG7fxKsWGBk=;
        b=nOQnO1PrHs+BZWr2E10SnTYR9qq+Ezl33ZDiWI8ur6aX+X67V+74clkYznKpwEpOM/
         9sOOScsfAMCVltMfkFyq68BkG+b98YXcIhaYZASVAmXmiZiSh27pVOqfuAqagS2fKuLS
         P5fJXa+g9/z05xmqzwUKDtBJ2bE5Du3i1bDWYj5zCylERXeYjHrXXphurUz067tb45RE
         MDlACxnM90jfX0tSYryAdyuPh7KvGvqBfu05sMWfjGbKjC+XM8MdtPeaJh2IGmMxtFsq
         kl2vcf5mSYz7RBozI/TFx2pJilLDMPol3UgfFnQ7qJoaofCL4hb2//o8C9BmkS9kZDV4
         5mVg==
X-Gm-Message-State: AHQUAubSZhayFOpcUy5YPDZDfWzqQk+jKWexWCVShrlKF+Od0qVUZbrY
        I/+KgtFDUMm+EjKb8ZVxEttBZlkg
X-Google-Smtp-Source: AHgI3IZA/jXdFpT7JEUds5wGMSDm4Ar6ZstH0Ahr2qOhLYjwlA9W0hfIueh8RQRfD2lvdfZjW4s7Qw==
X-Received: by 2002:aa7:c0c3:: with SMTP id j3mr7505487edp.36.1550240585645;
        Fri, 15 Feb 2019 06:23:05 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id v11sm1501333edy.49.2019.02.15.06.23.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 06:23:04 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] advertising: Add implementation of SupportedSecondaryChannels
Date:   Fri, 15 Feb 2019 16:22:59 +0200
Message-Id: <20190215142301.30909-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190215142301.30909-1-luiz.dentz@gmail.com>
References: <20190215142301.30909-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements SupportedSecondaryChannels property which expose what
the supported secondary channels.
---
 src/advertising.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/src/advertising.c b/src/advertising.c
index a843dbba3..df7ebbf81 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1234,10 +1234,50 @@ static gboolean get_supported_includes(const GDBusPropertyTable *property,
 	return TRUE;
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
+static void append_secondary(struct btd_adv_manager *manager,
+						DBusMessageIter *iter)
+{
+	struct adv_secondary *sec;
+
+	for (sec = secondary; sec && sec->name; sec++) {
+		if (manager->supported_flags & sec->flag)
+			dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
+								&sec->name);
+	}
+}
+
+static gboolean get_supported_secondary(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_adv_manager *manager = data;
+	DBusMessageIter entry;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_STRING_AS_STRING, &entry);
+
+	append_secondary(manager, &entry);
+
+	dbus_message_iter_close_container(iter, &entry);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable properties[] = {
 	{ "ActiveInstances", "y", get_active_instances, NULL, NULL },
 	{ "SupportedInstances", "y", get_instances, NULL, NULL },
 	{ "SupportedIncludes", "as", get_supported_includes, NULL, NULL },
+	{ "SupportedSecondaryChannels", "as", get_supported_secondary, NULL,
+									NULL },
 	{ }
 };
 
-- 
2.17.2

