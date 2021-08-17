Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C92DC4320A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 01:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BD3A60E52
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 01:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbhHQBDP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Aug 2021 21:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbhHQBDO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Aug 2021 21:03:14 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89802C061764
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Aug 2021 18:02:42 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id qe12-20020a17090b4f8c00b00179321cbae7so3336024pjb.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Aug 2021 18:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aruppHw+1xDSKS3DJk7LiNCzngkV6hx7rNnhf7+1Z/I=;
        b=XdFEia1bMlkssNPtPnTPuXYNwTmxOa+8NLMm2yIG25STYNOu++B7J/8zfo79Qee7en
         Pq70w5JNHzF0+Hb0MvKMIKsYPMu2R7zXNNLT/nNXv9LnvnIUGQFcgqvcmBYZCcUKK7N5
         kL3yVLEDP2rapmb3/gktHcMioRO4UHq3nbNEz/wv+qTvzBLQImujBA1JaHxMHG8GawqU
         UaOLW2QJFZfBUC1h8F7vhdMLNp1FnoVivYLiDqDhgWOhC+Zks/H4/Zjfs6mGA9GLegWQ
         jgAH4Ty0JxAHFLxEwpfDwj+2QseKk9x4EgR+Iv24LnWFMavW6O6LFhAjVH5exaCHoMq+
         Ldwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aruppHw+1xDSKS3DJk7LiNCzngkV6hx7rNnhf7+1Z/I=;
        b=O/r6tBuQOpGLdEyMv4ndwFxTtCdNAu77xewsr+5YecEL053+dJtoy0yo/k9pzjnCtK
         tZw7QElWqHRrSfOTRYAtg5ump9HfYZAcvUfSTN+6y6OcDDCuu5p4zp7HO0A40dmtfnzO
         S6l+tAGTt9q8q4NKWURUC6KLNxG7uHKY2EaeFV5kIZSFeA02M12b9AzuETVP1HkGp/BD
         Urg9MS5XKfqXxCtF86h7CgmmkTXZymyOLkMt7BNTABCOY/vs6HmXVgeLNnwzxKBBLfPw
         5JvuTPNEf3aA7Wi8UiSzxTniVWFSDnYWYvTtuD6UCVTdCnSkQJwvCHEo1z5flrLcv+rN
         nk0A==
X-Gm-Message-State: AOAM533siV0mi7/PR2GrBcoDMK/JFv8qUMfba9IvYTf16XsrHtN1Jv1Q
        deNWb0Ib+nNTlCvAn8xT3uwNGVhi6lY=
X-Google-Smtp-Source: ABdhPJz03LtAO3aJ8+zlhq9Eaj1lKFEjITEV4rooSAhFY0GLxSfe3hREdC6dZTMaJZC4T0/18zkgEA==
X-Received: by 2002:a17:90a:7185:: with SMTP id i5mr717444pjk.236.1629162161965;
        Mon, 16 Aug 2021 18:02:41 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q26sm347137pff.174.2021.08.16.18.02.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 18:02:41 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 3/3] client: Add support for printing Experimental property
Date:   Mon, 16 Aug 2021 18:02:37 -0700
Message-Id: <20210817010237.1792589-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210817010237.1792589-1-luiz.dentz@gmail.com>
References: <20210817010237.1792589-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Thid adds support to show command to print Experimental property:

[bluetooth]# show
Controller ...
	Experimental: BlueZ Experimental LL p.. (15c0a148-c273-11ea-b3de-0242ac130004)
---
 client/main.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/client/main.c b/client/main.c
index 506602bbd..80f40cf57 100644
--- a/client/main.c
+++ b/client/main.c
@@ -319,7 +319,7 @@ static void print_property(GDBusProxy *proxy, const char *name)
 	print_property_with_label(proxy, name, NULL);
 }
 
-static void print_uuid(const char *uuid)
+static void print_uuid(const char *label, const char *uuid)
 {
 	const char *text;
 
@@ -340,9 +340,10 @@ static void print_uuid(const char *uuid)
 			n = sizeof(str) - 1;
 		}
 
-		bt_shell_printf("\tUUID: %s%*c(%s)\n", str, 26 - n, ' ', uuid);
+		bt_shell_printf("\t%s: %s%*c(%s)\n", label, str, 26 - n, ' ',
+									uuid);
 	} else
-		bt_shell_printf("\tUUID: %*c(%s)\n", 26, ' ', uuid);
+		bt_shell_printf("\t%s: %*c(%s)\n", label, 26, ' ', uuid);
 }
 
 static void print_uuids(GDBusProxy *proxy)
@@ -359,7 +360,27 @@ static void print_uuids(GDBusProxy *proxy)
 
 		dbus_message_iter_get_basic(&value, &uuid);
 
-		print_uuid(uuid);
+		print_uuid("UUID", uuid);
+
+		dbus_message_iter_next(&value);
+	}
+}
+
+static void print_experimental(GDBusProxy *proxy)
+{
+	DBusMessageIter iter, value;
+
+	if (g_dbus_proxy_get_property(proxy, "Experimental", &iter) == FALSE)
+		return;
+
+	dbus_message_iter_recurse(&iter, &value);
+
+	while (dbus_message_iter_get_arg_type(&value) == DBUS_TYPE_STRING) {
+		const char *uuid;
+
+		dbus_message_iter_get_basic(&value, &uuid);
+
+		print_uuid("Experimental", uuid);
 
 		dbus_message_iter_next(&value);
 	}
@@ -984,6 +1005,7 @@ static void cmd_show(int argc, char *argv[])
 	print_property(adapter->proxy, "Modalias");
 	print_property(adapter->proxy, "Discovering");
 	print_property(adapter->proxy, "Roles");
+	print_experimental(adapter->proxy);
 
 	if (adapter->ad_proxy) {
 		bt_shell_printf("Advertising Features:\n");
@@ -1424,7 +1446,7 @@ static void cmd_scan_filter_uuids(int argc, char *argv[])
 		char **uuid;
 
 		for (uuid = filter.uuids; uuid && *uuid; uuid++)
-			print_uuid(*uuid);
+			print_uuid("UUID", *uuid);
 
 		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 	}
-- 
2.31.1

