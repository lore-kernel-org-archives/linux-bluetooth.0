Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0124FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Sep 2021 22:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE3E461101
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Sep 2021 22:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346568AbhIGWbT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Sep 2021 18:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346573AbhIGWbS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Sep 2021 18:31:18 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1699C061757
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Sep 2021 15:30:11 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id v1so42725plo.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Sep 2021 15:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=J8y9srhLy7xXZr208e3K7aYbMXh6OJHw41vPHmgwaoY=;
        b=IdWnBcoyaDwAAVrosH8E7oiDm1qxPjEgc+Tn3Mg0vQeXDRhnSARDt81uxxTfedKs89
         hXL7iH3qY0V+EZsoFdNMI6MyHla2fNvxWluljHfG7K/VfY3+TB+/V18tIkyGff3ngzi8
         OHZjXcpd+NxuFjvYIAnQeRQhnNJxkHrvv1pbs4yG3X+bSD+r+C/kDbsJT5rOWl5V/WHI
         QxjNXnM+M1qx48MhCHnOdTEGoWIy9ok3PHOceA/PrTuCAg5m2V4ClxFYTuEL88RskJAd
         FPxdMn3nKKERlfBNlQA8IT2obwgSq+Hg9hPvEd+GJBfbD+sm5H7rV9044f3yTxY1LuGX
         fG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J8y9srhLy7xXZr208e3K7aYbMXh6OJHw41vPHmgwaoY=;
        b=sKz3SVJnmAEvxPd5EjmyZgL9uXpT/5Qet0gYj/2ebEOB3z8/o+Ho2RMmc2GTn7egIp
         2QpLBEQXmIhPq4/og4oTvpW60JA0sqBnHhy6+maAPrZBHffYUiy7sodH455N/n2819cz
         DD35aMS4bkUKpYlA5oL7bTPEs3+W0eC+B8KC8ZRt3YHxUJ55XrPXoMBx93QKTkJeNuRf
         Vt+3K9Syl9p4s9LXJ6CVKqJ/rCxHem37rE67gYDvPSYAu0waiR1Fkl5aeWOSelxa7Ip9
         7Fo5mA/FcHnHDfBpppzOPu2P3qrz1y+U6gwJgBLIHwRxOpj1mjKYnxoBtyl7hv71qImu
         9h7w==
X-Gm-Message-State: AOAM531NUmfXUFVHmmrjGZm9RPfLAHd43ts2eVhSAExuhNR/FWeVreF3
        iKLaYesVnzmYj0rMhx1GCbd5gmU3s2w=
X-Google-Smtp-Source: ABdhPJz4LLcbZPiyem0UjIINgGvRNc926kTkaANrpzbyuNjIQcrCHqADGLtQkDKbTIysfsDS0ileSQ==
X-Received: by 2002:a17:90b:1801:: with SMTP id lw1mr701788pjb.162.1631053811091;
        Tue, 07 Sep 2021 15:30:11 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x19sm153811pgk.37.2021.09.07.15.30.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 15:30:10 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] client: Add support for printing ExperimentalFeatures property
Date:   Tue,  7 Sep 2021 15:30:06 -0700
Message-Id: <20210907223008.2322035-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210907223008.2322035-1-luiz.dentz@gmail.com>
References: <20210907223008.2322035-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Thid adds support to show command to print ExperimentalFeatures property:

[bluetooth]# show
Controller ...
	Experimental: BlueZ Experimental LL p.. (15c0a148-c273-11ea-b3de-0242ac130004)
---
 client/main.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/client/main.c b/client/main.c
index 506602bbd..9a36a8c65 100644
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
@@ -359,7 +360,28 @@ static void print_uuids(GDBusProxy *proxy)
 
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
+	if (g_dbus_proxy_get_property(proxy, "ExperimentalFeatures",
+						&iter) == FALSE)
+		return;
+
+	dbus_message_iter_recurse(&iter, &value);
+
+	while (dbus_message_iter_get_arg_type(&value) == DBUS_TYPE_STRING) {
+		const char *uuid;
+
+		dbus_message_iter_get_basic(&value, &uuid);
+
+		print_uuid("ExperimentalFeatures", uuid);
 
 		dbus_message_iter_next(&value);
 	}
@@ -984,6 +1006,7 @@ static void cmd_show(int argc, char *argv[])
 	print_property(adapter->proxy, "Modalias");
 	print_property(adapter->proxy, "Discovering");
 	print_property(adapter->proxy, "Roles");
+	print_experimental(adapter->proxy);
 
 	if (adapter->ad_proxy) {
 		bt_shell_printf("Advertising Features:\n");
@@ -1424,7 +1447,7 @@ static void cmd_scan_filter_uuids(int argc, char *argv[])
 		char **uuid;
 
 		for (uuid = filter.uuids; uuid && *uuid; uuid++)
-			print_uuid(*uuid);
+			print_uuid("UUID", *uuid);
 
 		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 	}
-- 
2.31.1

