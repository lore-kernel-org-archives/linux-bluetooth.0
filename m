Return-Path: <SRS0=cA0y=4I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B76C7619D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Feb 2020 00:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC01207FD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Feb 2020 00:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpVCiCH4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbgBTA2j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Feb 2020 19:28:39 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35026 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgBTA2i (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Feb 2020 19:28:38 -0500
Received: by mail-pj1-f68.google.com with SMTP id q39so109257pjc.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2020 16:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Sgn26Luz9XVSjFD2jqkmBUZAZcGhcXdUtpU3GjpAf84=;
        b=SpVCiCH4qxnkOHiKeuO2+uerhzIlHICbwjJ4v4yVB5TzupsmElr5hHSOFc9qYizVx/
         L235RMj8a1ennulSDnlByKqA6twy/mtHjDkRtonIglFBy6NHgciS6h09ZyyJS/dBNg64
         5yBeWuVhP4mqo/T6Ldrgy0qx3utYA0Ba/2PlvR5oDSv0sRmyXUvKgsGKMzhOUzRJUuDg
         Ulxjk0sJkEiPKN+3GDj6U/rbr4vF8vAdr3vQQVc9zicP3zQUdU/Ws0+yh7NpSP8cjS4t
         mTWR6XjVqWDqEYZrzMypMe5f/eW8rX4fEtE1FrPdkpDY0Ry+3PQCDM1Kjg3ytEw3YIWM
         0qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sgn26Luz9XVSjFD2jqkmBUZAZcGhcXdUtpU3GjpAf84=;
        b=CfYVxaj/MsCqFbMWKdIRs0FzRb73PRkfVLEjNof285v/Pq2JJ66FELV+0RCy5a9FXN
         E+ZyX2ziaMxNmMdtg2WVPSotAVLx0q4jJeo83YCfiQ2TpjzO+yS/kddqAoSI5OT3/iSt
         59ayHSCLog0f3vOf9rl/F1ighah/RVEHqFYlB2CkXzJR6fq9Q2mLBYnbRLrmUt+CcnK+
         2NaW6YlJ/tD3JYkGL8q8w1TaFLdInd0TzTFVO8GFSnxznqE/2jfPqlpW//5JVezqurAJ
         GDSToHZLbbPp3E7evFhktG2471+vKzxzYhqe1yHi4aBlzSi6p5xyJmJIthVS36RcvotQ
         USlg==
X-Gm-Message-State: APjAAAWUF8B+6uRFzahETzYFXiczSzHKMcW28Ut4Jf13OQ89YqsiwbLr
        5Sw2HFw4pnKB3fVxu9E5Y3e6VN6AcXI=
X-Google-Smtp-Source: APXvYqzUPotkXLfnKf+pzSvaGdKcPXjZOfD6uAVwJk9uvTMJqBGuvd6kHTOX335lZwibWMG9jWbGYQ==
X-Received: by 2002:a17:90a:af81:: with SMTP id w1mr438243pjq.14.1582158517924;
        Wed, 19 Feb 2020 16:28:37 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id c68sm769213pfc.156.2020.02.19.16.28.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 16:28:37 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] client: Add scan.pattern command
Date:   Wed, 19 Feb 2020 16:28:35 -0800
Message-Id: <20200220002835.8929-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200220002835.8929-1-luiz.dentz@gmail.com>
References: <20200220002835.8929-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses the new Pattern filter:

[bluetooth]# scan.pattern Living
[bluetooth]# scan on
SetDiscoveryFilter success
Discovery started
[CHG] Controller XX:XX:XX:XX:XX:XX Discovering: yes
[NEW] Device XX:XX:XX:XX:XX:XX Living Room TV
---
 client/main.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/client/main.c b/client/main.c
index 8bd0bac9e..422da5593 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1157,6 +1157,7 @@ static void cmd_default_agent(int argc, char *argv[])
 
 static struct set_discovery_filter_args {
 	char *transport;
+	char *pattern;
 	dbus_uint16_t rssi;
 	dbus_int16_t pathloss;
 	char **uuids;
@@ -1241,6 +1242,10 @@ static void set_discovery_filter_setup(DBusMessageIter *iter, void *user_data)
 						DBUS_TYPE_BOOLEAN,
 						&args->discoverable);
 
+	if (args->pattern != NULL)
+		g_dbus_dict_append_entry(&dict, "Pattern", DBUS_TYPE_STRING,
+						&args->pattern);
+
 	dbus_message_iter_close_container(iter, &dict);
 }
 
@@ -1440,6 +1445,22 @@ static void cmd_scan_filter_discoverable(int argc, char *argv[])
 		set_discovery_filter(false);
 }
 
+static void cmd_scan_filter_pattern(int argc, char *argv[])
+{
+	if (argc < 2 || !strlen(argv[1])) {
+		bt_shell_printf("Pattern: %s\n", filter.pattern);
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
+	free(filter.pattern);
+	filter.pattern = strdup(argv[1]);
+
+	filter.set = false;
+
+	if (filter.active)
+		set_discovery_filter(false);
+}
+
 static void filter_clear_uuids(void)
 {
 	g_strfreev(filter.uuids);
@@ -1473,6 +1494,12 @@ static void filter_clear_discoverable(void)
 	filter.discoverable = false;
 }
 
+static void filter_clear_pattern(void)
+{
+	free(filter.pattern);
+	filter.pattern = NULL;
+}
+
 struct clear_entry {
 	const char *name;
 	void (*clear) (void);
@@ -1485,6 +1512,7 @@ static const struct clear_entry filter_clear[] = {
 	{ "transport", filter_clear_transport },
 	{ "duplicate-data", filter_clear_duplicate },
 	{ "discoverable", filter_clear_discoverable },
+	{ "pattern", filter_clear_pattern },
 	{}
 };
 
@@ -2639,8 +2667,11 @@ static const struct bt_shell_menu scan_menu = {
 	{ "discoverable", "[on/off]", cmd_scan_filter_discoverable,
 				"Set/Get discoverable filter",
 				NULL },
+	{ "pattern", "[value]", cmd_scan_filter_pattern,
+				"Set/Get pattern filter",
+				NULL },
 	{ "clear",
-		"[uuids/rssi/pathloss/transport/duplicate-data/discoverable]",
+	"[uuids/rssi/pathloss/transport/duplicate-data/discoverable/pattern]",
 				cmd_scan_filter_clear,
 				"Clears discovery filter.",
 				filter_clear_generator },
-- 
2.21.1

