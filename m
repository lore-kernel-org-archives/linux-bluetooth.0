Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25986C76196
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 03:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjCWDsP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Mar 2023 23:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCWDsO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Mar 2023 23:48:14 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B4E3586
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 20:48:12 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c18so21131730ple.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 20:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679543292;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxljwHdP8xNkwqo0WFmvF4AplStNr8O7CMgY8EWnZMQ=;
        b=VLLybmDzdhtbM8GF35t33434o/bv9vHI1cEohaDzNuA/2i0dhFP3S84/3pyKqeq+cj
         CTG2Hx8BLlpNegc1JqCi9Nz7Gz6sheH51nZGkh1RFki+VGuIS3SZENMhK6vnObfnHMO2
         31kmwjawtqVUElTNaqiyUYJvOoWggg48YhJJza7l+XnhmYvdE2RP3wHLdIwMr7AQWk0s
         WTQwtUYVR4PYBW3JJvEOxMtXTx6jCXJFTsL+Zn/3ds/GEJTzRyirBPNIgNtsWe1D4pWD
         uAfVv1TTd6XCZdiAgibwuQ0qF7zvrWV72hNSMLBgDWM6PRA1unrZ2XBzSClCjlDSKAvT
         aqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679543292;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxljwHdP8xNkwqo0WFmvF4AplStNr8O7CMgY8EWnZMQ=;
        b=ql1xPJylCNcw+49rsHJ0qGuoIdskvU0n4SbQ5ah7OpjUBVCLik9u/6LUDHATgzt7rX
         nnojEjhb1icxUHKbvCcByCE6SmyXJQgJ1XbNsSQAjgfnYjudccptTjjneDXcvKfIjNBf
         KpaHgBqMsmgtkvc/R2rhPv53nWkYXNKW8rLQ3dAL6UBhxLlayj1l7WxiwVjTAn96iNPW
         gCQNNd6CA51SVeo3XQprk+cAKaILVlBgUKJqtyLHJCo6NSGqtRU6DJ+0Yo5HgK51LNVU
         qbulr1F6VwkU3lKDCvNyiMjZ+8DqGtskbLjMcc5I1DFzoiqOMvzRRYoyywzQtLVBsfYS
         PrlQ==
X-Gm-Message-State: AO0yUKV/3DtNev2Vbjj/fWrusBI82kIJR/niBQydQYi5VNwE2MnhlZMb
        FOwM+kzC1U9UacrT1TeqgfLCcQWQTRFZ0Q==
X-Google-Smtp-Source: AK7set+HvxJQ8lLMe+Vjfb6Md/LOusRjJhYoqXsWfb2yJ07x4wUHjk5IMqr+MHeH4cf/BXhHGvTcJg==
X-Received: by 2002:a17:90b:38c4:b0:233:feb4:895f with SMTP id nn4-20020a17090b38c400b00233feb4895fmr6025755pjb.44.1679543291725;
        Wed, 22 Mar 2023 20:48:11 -0700 (PDT)
Received: from AndroidSev.unication.com.cn ([183.63.252.58])
        by smtp.gmail.com with ESMTPSA id 5-20020a630205000000b0050fa6546a45sm4191358pgc.6.2023.03.22.20.48.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2023 20:48:11 -0700 (PDT)
From:   Aaron_shen <aarongt.shen@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Aaron_shen <aarongt.shen@gmail.com>
Subject: [PATCH BlueZ] obexd: support to reply folder name to store file
Date:   Thu, 23 Mar 2023 11:48:05 +0800
Message-Id: <20230323034805.18946-1-aarongt.shen@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It is more convenient that agent reply the message with
folder name instead of the full new filename to be store.
Because the opp_chkput() will use the remote device filename
if the new filename is NULL.
---
 doc/obex-agent-api.txt |  9 +++++----
 obexd/src/manager.c    | 10 ++++++----
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/doc/obex-agent-api.txt b/doc/obex-agent-api.txt
index 3923da6df..9d399e3d2 100644
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
+			directory name suffixed with '/' where the object
+			shall be stored. The transfer object will contain a
+			Filename property that contains the default location
+			and name that can be returned.
 
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
2.11.0

