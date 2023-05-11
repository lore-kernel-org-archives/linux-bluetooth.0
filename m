Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D7FC7EE22
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 May 2023 20:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239384AbjEKU2j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 May 2023 16:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239392AbjEKU2f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 May 2023 16:28:35 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C59A246
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 May 2023 13:28:30 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6436dfa15b3so6106423b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 May 2023 13:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683836909; x=1686428909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=emvuPNhNRveuiLJ+SN5oWzjXH32hbgFtDeH+ADZ9nbM=;
        b=VQTm0fafHXhE5RGThm1phrZgFgqLu5OtWz3j3P/LGR+fPV8Ugf8/DE0zZTHQfB2eVy
         NkTFQYOtlFear8r97gqXxX1rxa03KFsqpOvAFTzpwbZRJfYL0MyIxByfZUe9azLfEV4a
         ZIg6MlTSnkrvcxWI+AzebqBphe0EKqBXGaKcsEgTh7nruaLQnN4cyjKTUyw+xHGWZ3n3
         uDlSahS9vs+FF5lzO/qlOeCU2IvFUiEuaWTFSx/Biyl4yDCrwCOjcBSQYyi36TNQqJSi
         42AchNYIi2M5AAdCXSDQmPvqWtNbXutcO+J4HZDx0RkjGFN37N+Tfud3+/jmFLNgY9E8
         ZS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683836909; x=1686428909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emvuPNhNRveuiLJ+SN5oWzjXH32hbgFtDeH+ADZ9nbM=;
        b=AXFGNENsNuvbF3TOk+lT7bRd+rSX2lFdG+ri9xZKySJ9jlBQY0mMSNksDOa3gBcNUr
         TdiII+BESpx3VHfhuGlVBjZV3MRmzDJ4u46ielKk9evrkkQ71PvAZvRHxJgglX3zG163
         69YQZXsECNTyEW7M82Rcsdpx9v5G+aAxfmpyWIru1OX/2wHnBhJ6Sp0Bdgosn2NdPbd0
         hFwQF2EJmDr9r722HU97DZgBWbJD5zjWiLGbolQ+EicTC7t46DmR0ux6tRgqH7QgQf+W
         q6tZz2GFXZERu4uxrxef4SsVUZVbrF6f8x2lM4ghddoJxYpcmTF+FSb5a2LSPAES/u1C
         Angw==
X-Gm-Message-State: AC+VfDzmJ9RBR48dsLi7y6WEfk+dGXh5YV4QjGD0i7AmfoKVchK0f2VU
        fnUkAZqSLDrc0AUcZHHWtB95OK6fuT8=
X-Google-Smtp-Source: ACHHUZ7VUa1jG0EaYFs+oKK6s5iNLUDVLbD/Th+OrM0FSp+R7qOqczjRJMQfBx4uONxTa1Sch6LZhg==
X-Received: by 2002:a05:6a20:9193:b0:ec:7c4f:ed7a with SMTP id v19-20020a056a20919300b000ec7c4fed7amr28748433pzd.34.1683836909246;
        Thu, 11 May 2023 13:28:29 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id s24-20020aa78298000000b0062a7462d398sm5864529pfm.170.2023.05.11.13.28.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 13:28:27 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client/player: Fix not checking for SupportedUUIDs
Date:   Thu, 11 May 2023 13:28:25 -0700
Message-Id: <20230511202825.3983806-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230511202825.3983806-1-luiz.dentz@gmail.com>
References: <20230511202825.3983806-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When registering an endpoint it should always check for SupportedUUIDs.
---
 client/player.c | 66 +++++++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 24 deletions(-)

diff --git a/client/player.c b/client/player.c
index 091d7005f42a..46eab32a40a0 100644
--- a/client/player.c
+++ b/client/player.c
@@ -2190,9 +2190,32 @@ static void register_endpoint_reply(DBusMessage *message, void *user_data)
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static bool media_supports_uuid(GDBusProxy *proxy, const char *uuid)
+{
+	DBusMessageIter iter, array;
+
+	if (!g_dbus_proxy_get_property(proxy, "SupportedUUIDs", &iter))
+		return false;
+
+	dbus_message_iter_recurse(&iter, &array);
+	while (dbus_message_iter_get_arg_type(&array) == DBUS_TYPE_STRING) {
+		const char *support_uuid;
+
+		dbus_message_iter_get_basic(&array, &support_uuid);
+
+		if (!strcasecmp(uuid, support_uuid))
+			return true;
+
+		dbus_message_iter_next(&array);
+	}
+
+	return false;
+}
+
 static void endpoint_register(struct endpoint *ep)
 {
 	GList *l;
+	int registered = 0;
 
 	if (!g_dbus_register_interface(dbus_conn, ep->path,
 					BLUEZ_MEDIA_ENDPOINT_INTERFACE,
@@ -2203,6 +2226,9 @@ static void endpoint_register(struct endpoint *ep)
 	}
 
 	for (l = medias; l; l = g_list_next(l)) {
+		if (!media_supports_uuid(l->data, ep->uuid))
+			continue;
+
 		if (!g_dbus_proxy_method_call(l->data, "RegisterEndpoint",
 						register_endpoint_setup,
 						register_endpoint_reply,
@@ -2211,8 +2237,13 @@ static void endpoint_register(struct endpoint *ep)
 						BLUEZ_MEDIA_ENDPOINT_INTERFACE);
 			goto fail;
 		}
+
+		registered++;
 	}
 
+	if (!registered)
+		goto fail;
+
 	return;
 
 fail:
@@ -3015,33 +3046,20 @@ static struct endpoint *endpoint_new(const struct capabilities *cap)
 static void register_endpoints(GDBusProxy *proxy)
 {
 	struct endpoint *ep;
-	DBusMessageIter iter, array;
+	size_t i;
 
-	if (!g_dbus_proxy_get_property(proxy, "SupportedUUIDs", &iter))
-		return;
+	for (i = 0; i < ARRAY_SIZE(caps); i++) {
+		const struct capabilities *cap = &caps[i];
 
-	dbus_message_iter_recurse(&iter, &array);
-	while (dbus_message_iter_get_arg_type(&array) == DBUS_TYPE_STRING) {
-		const char *uuid;
-		size_t i;
+		if (!media_supports_uuid(proxy, cap->uuid))
+			continue;
 
-		dbus_message_iter_get_basic(&array, &uuid);
-
-		for (i = 0; i < ARRAY_SIZE(caps); i++) {
-			const struct capabilities *cap = &caps[i];
-
-			if (strcasecmp(cap->uuid, uuid))
-				continue;
-
-			ep = endpoint_new(cap);
-			ep->max_transports = UINT8_MAX;
-			ep->auto_accept = true;
-			ep->cig = BT_ISO_QOS_CIG_UNSET;
-			ep->cis = BT_ISO_QOS_CIS_UNSET;
-			endpoint_register(ep);
-		}
-
-		dbus_message_iter_next(&array);
+		ep = endpoint_new(cap);
+		ep->max_transports = UINT8_MAX;
+		ep->auto_accept = true;
+		ep->cig = BT_ISO_QOS_CIG_UNSET;
+		ep->cis = BT_ISO_QOS_CIS_UNSET;
+		endpoint_register(ep);
 	}
 }
 
-- 
2.40.0

