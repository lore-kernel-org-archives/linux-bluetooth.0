Return-Path: <SRS0=ITyu=7V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA664C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jun 2020 22:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1C832074B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jun 2020 22:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Clg5EOZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgFHWB6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Jun 2020 18:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgFHWB5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Jun 2020 18:01:57 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D8DC08C5C3
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2020 15:01:56 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y17so7188624plb.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2020 15:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7Wu918VVQjfTfn4c+k4NFCZO3B0rpXcFmwElpmzGXWE=;
        b=Clg5EOZw/sUKlqPAoGq70bx4KRDPWU7OCjhaOBNqV0grBL7bA1h6d81L7nMHiai97i
         G/ICnkS5yGGAh8wFeoFAMdt4qUya9e1R0ZPQZFu8JEjgRN3pxmdx+oNy20/OI0NYR5t/
         afX96KoMzA28zBEuPVnLQKdYLzv8olITAPtUavUp+gBYhfFq4EVgC4KIPYAxOL4SQqSC
         vAJDwHdyZRam82FLwFijvKMia8CvSyBU0jCsK0LPvppgRQmB6KGqLjZKiiTa9p+0d0Vz
         LfYb58y5LQAo/0quRcmsqSHV6fnaxHz5mTQrX27B8bBLk2FiFA82ytsBblsK/RU7eIwp
         HEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Wu918VVQjfTfn4c+k4NFCZO3B0rpXcFmwElpmzGXWE=;
        b=OC/8cLLSNzmUNSU8FimEwtAbpNLwg080boYajnfSdQcuNiI0yNn205g62V9SiOMFiK
         M9voc6kqZpt4HEgGTjClZh/yyZ37RpBTvIuciie/4jjTQwD0QlQliiy6A9ZO7uwwiRqX
         SFV51WbYyFfnasn9EF9xduRR+U8uNmN5vcns+LzVCp8cyYPcSRPrOOU8iy5Yxp+lBHOh
         azgfxx9+2eDiuiZOc5ziSeehdFi3QharT4T270Dr4kTEa54DsmIsAl2/SJXCdXgizLd7
         xRAFmTveGxe9gTfEPLhnBJFnHe13o1F/t/DA8/3vJIb9jnPT7wv/aOZXLyfi0Be7L8RX
         O2Uw==
X-Gm-Message-State: AOAM531IRq5fsvB7PxyG0l7D2KZVciO9YCJuO4segUWeY5GOl6bUTNfB
        ZO2I7O8fp6IgmR/3OmqYJ821Z0y1
X-Google-Smtp-Source: ABdhPJyIcXq/6udjn7oHvKlkZ06lKgh0EbAN8nWC+c/KRmXJbv5nP4ZtlIPNBjmQCJERHFBuQGQDzg==
X-Received: by 2002:a17:902:9a4a:: with SMTP id x10mr673338plv.343.1591653715829;
        Mon, 08 Jun 2020 15:01:55 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b140sm7870172pfb.119.2020.06.08.15.01.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 15:01:54 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] adapter: Consolitate code for discovery reply
Date:   Mon,  8 Jun 2020 15:01:52 -0700
Message-Id: <20200608220153.880790-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200608220153.880790-1-luiz.dentz@gmail.com>
References: <20200608220153.880790-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This consolidate code that were used to reply discovery commands in a
single function so it easier to reuse and maintain.
---
 src/adapter.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index bf51b120b..c23c84175 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1584,13 +1584,30 @@ static void discovery_remove(struct watch_client *client, bool exit)
 
 static void trigger_start_discovery(struct btd_adapter *adapter, guint delay);
 
+static void discovery_reply(struct watch_client *client, uint8_t status)
+{
+	DBusMessage *reply;
+
+	if (!client->msg)
+		return;
+
+	if (!status) {
+		g_dbus_send_reply(dbus_conn, client->msg, DBUS_TYPE_INVALID);
+	} else  {
+		reply = btd_error_busy(client->msg);
+		g_dbus_send_message(dbus_conn, reply);
+	}
+
+	dbus_message_unref(client->msg);
+	client->msg = NULL;
+}
+
 static void start_discovery_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	struct btd_adapter *adapter = user_data;
 	struct watch_client *client;
 	const struct mgmt_cp_start_discovery *rp = param;
-	DBusMessage *reply;
 
 	DBG("status 0x%02x", status);
 
@@ -1630,12 +1647,7 @@ static void start_discovery_complete(uint8_t status, uint16_t length,
 		else
 			adapter->filtered_discovery = false;
 
-		if (client->msg) {
-			g_dbus_send_reply(dbus_conn, client->msg,
-						DBUS_TYPE_INVALID);
-			dbus_message_unref(client->msg);
-			client->msg = NULL;
-		}
+		discovery_reply(client, status);
 
 		if (adapter->discovering)
 			return;
@@ -1649,8 +1661,7 @@ static void start_discovery_complete(uint8_t status, uint16_t length,
 fail:
 	/* Reply with an error if the first discovery has failed */
 	if (client->msg) {
-		reply = btd_error_busy(client->msg);
-		g_dbus_send_message(dbus_conn, reply);
+		discovery_reply(client, status);
 		discovery_remove(client, false);
 		return;
 	}
@@ -1917,23 +1928,13 @@ static void stop_discovery_complete(uint8_t status, uint16_t length,
 {
 	struct watch_client *client = user_data;
 	struct btd_adapter *adapter = client->adapter;
-	DBusMessage *reply;
 
 	DBG("status 0x%02x", status);
 
-	if (status != MGMT_STATUS_SUCCESS) {
-		if (client->msg) {
-			reply = btd_error_busy(client->msg);
-			g_dbus_send_message(dbus_conn, reply);
-		}
-		goto done;
-	}
+	discovery_reply(client, status);
 
-	if (client->msg) {
-		g_dbus_send_reply(dbus_conn, client->msg, DBUS_TYPE_INVALID);
-		dbus_message_unref(client->msg);
-		client->msg = NULL;
-	}
+	if (status != MGMT_STATUS_SUCCESS)
+		goto done;
 
 	adapter->discovery_type = 0x00;
 	adapter->discovery_enable = 0x00;
-- 
2.25.3

