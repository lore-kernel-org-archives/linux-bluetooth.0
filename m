Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3AFC77B73
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Apr 2023 02:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjDTC0E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Apr 2023 22:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjDTC0C (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Apr 2023 22:26:02 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3726146A5
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 19:26:01 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b620188aeso681608b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 19:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681957560; x=1684549560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=77JUUzQXzcotRsLH4dY07i49UucoxKVcxmsQVMWb4B8=;
        b=UHlNL9/UIQgL4lR2Sof7cKCi5uaObLICh7ups3tpTeJXgQmEjIAo7wGk0aPJ0R0ULc
         wm0P9wR3VpIqp5mo6gibnXe0x03DNbkbRZmA4tn/h7IvGoC30C8N77sH5l4YPgM+CcK+
         Hx2PJj6WwbbgK1WjVXhzw3yw49ok0/sCj6+eWwEYWa1dVHXLekJIbs3OyZiuZN8tWm06
         dxVf4CoUaaK+nt62bfcJSZ1B7UNwxX7nAcZd143BqEEYgsO2uPlMb9ps5oqlzm8bdyD6
         N+QTFZYNb4epg7v9haflmlrZcoUjAcVdDJdfrAqPrnRoN+N4sSe3WmE7YnZQaIJXEqko
         PyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681957560; x=1684549560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=77JUUzQXzcotRsLH4dY07i49UucoxKVcxmsQVMWb4B8=;
        b=hTR7IvlJgk7KomSu05MTwjOulJclDbL4ffpaAxI1KZ/Fd/7JQgSeKGH0k2cjoowkGR
         5oYYIUT6u+fqsiWhIy6Mog5yyI223Vm+W884zSw1BP0AanA5xUlcd0sZjIaQ1UEpLelm
         oVPBrTyxERZheU6tEGe1pb6I7jmqMcFl+2Lk5vgHjbkXljAi+DnsOaAvTFWJjBSKlzsO
         0cR9MnuH12JD0cdQ+U1xk6YcKfgAZMSZdYWq5t2EZzX510M8qpWcD9k+NAC1fX0wAmsG
         G8vSRwpEHUydaaMw2Sm8YXtfpkfyB+5RKmlYPxQjBziZytCN5bEnTOEnIBjOY5maz18R
         raaw==
X-Gm-Message-State: AAQBX9dBwxKxBM4Td531yvgZEhPsq6JryyULhSNFBPA5Ruj/MncKkiIu
        rvC4GR5Rp1r/XkqM/3mTTvHvYkT4k2F/vNAt
X-Google-Smtp-Source: AKy350aWxUOZkKRWDPEWIWN9Dp6u22Kr0jnbeH6ZaSDnd3qsV2FZflZEAR4VHQG/zGQHy4YS//TYjg==
X-Received: by 2002:a05:6a00:1a91:b0:63b:8324:df with SMTP id e17-20020a056a001a9100b0063b832400dfmr7290813pfv.0.1681957560262;
        Wed, 19 Apr 2023 19:26:00 -0700 (PDT)
Received: from aaron-shen.localdomain ([183.63.252.58])
        by smtp.gmail.com with ESMTPSA id g13-20020aa7874d000000b0063b8f17768dsm67112pfo.129.2023.04.19.19.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 19:25:59 -0700 (PDT)
From:   Guiting Shen <aarongt.shen@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     pmenzel@molgen.mpg.de, Guiting Shen <aarongt.shen@gmail.com>
Subject: [PATCH BlueZ v4] obexd: support to reply folder name to store file
Date:   Thu, 20 Apr 2023 10:25:54 +0800
Message-Id: <20230420022554.14159-1-aarongt.shen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The obex agent usually returns the full path by getting the default
folder and filename from the Filename property of the transfer object
which is not convenient.
The patch helps that the obex agent can return the folder name suffixed
with '/' or new full path or even null which will use the default name
if new_name is NULL and the default folder if the new_folder is NULL in
opp_chkput().
---
 doc/obex-agent-api.txt |  9 +++++----
 obexd/src/manager.c    | 10 ++++++----
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/doc/obex-agent-api.txt b/doc/obex-agent-api.txt
index 3923da6df..5a9c6d417 100644
--- a/doc/obex-agent-api.txt
+++ b/doc/obex-agent-api.txt
@@ -46,10 +46,11 @@ Methods		void Release()
 			This method gets called when the service daemon
 			needs to accept/reject a Bluetooth object push request.
 
-			Returns the full path (including the filename) where
-			the object shall be stored. The tranfer object will
-			contain a Filename property that contains the default
-			location and name that can be returned.
+			Returns the full path (including the filename) or
+			folder name suffixed with '/' where the object shall
+			be stored. The transfer object will contain a Filename
+			property that contains the default location and name
+			that can be returned.
 
 			Possible errors: org.bluez.obex.Error.Rejected
 			                 org.bluez.obex.Error.Canceled
diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index 849928603..73fd6b9af 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -632,8 +632,7 @@ static void agent_reply(DBusPendingCall *call, void *user_data)
 
 		if (dbus_error_has_name(&derr, DBUS_ERROR_NO_REPLY))
 			agent_cancel();
-
-		if (dbus_error_has_name(&derr, OBEX_ERROR_REJECT))
+		else if (dbus_error_has_name(&derr, OBEX_ERROR_REJECT))
 			agent->auth_reject = TRUE;
 
 		dbus_error_free(&derr);
@@ -651,7 +650,10 @@ static void agent_reply(DBusPendingCall *call, void *user_data)
 			agent->new_name = g_strdup(name);
 			agent->new_folder = NULL;
 		} else {
-			agent->new_name = g_strdup(slash + 1);
+			if (strlen(slash) == 1)
+				agent->new_name = NULL;
+			else
+				agent->new_name = g_strdup(slash + 1);
 			agent->new_folder = g_strndup(name, slash - name);
 		}
 	}
@@ -722,7 +724,7 @@ int manager_request_authorization(struct obex_transfer *transfer,
 
 	dbus_pending_call_unref(call);
 
-	if (!agent || !agent->new_name || agent->auth_reject)
+	if (!agent || agent->auth_reject)
 		return -EPERM;
 
 	*new_folder = agent->new_folder;
-- 
2.34.1

