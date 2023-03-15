Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBDDC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Mar 2023 09:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjCOJa5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 05:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjCOJaw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 05:30:52 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9487DD0F
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 02:30:48 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id d13so8098017pjh.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 02:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678872647;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4yuN2Vf6XahCUJDWAPD54smLN5lAj0NCkXCw7WtJWg=;
        b=XteK0tKCVs3fpmvvwstUUZPxuKV7Co0WcpofFlM0bfESZSiMRSAuKKSQbT5dj84hSu
         M5b4oWSR472duIQM0+bbv1zk6xCdTDjOiVnhq9GyJfmpFoPumo69A6w4zaIwee+5c8oj
         mYiuu08uSk2hSrY+FJHRrjb76I9Hmz9B5a8+8wheZnPO2ZLr/sVXe0LgohIsutfkbQ06
         U1fw0T01Z+2map8URvcaUrFqIQngzBQxBzw4KsG/75lB8quDv2eY/GnxBEXvKEHrPIFY
         9jHHhKGw8RlTcLM+RJ8qsCvX1oYyYyQXGrTXjmxiujbxb0cFPqOP85atQalUJfKphYnb
         yRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678872647;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4yuN2Vf6XahCUJDWAPD54smLN5lAj0NCkXCw7WtJWg=;
        b=bTwuZR0cloyzQS0GUvkQrtNDaUhaXPUAv6KGAjPHtJArA8inTLVO47oEtCPCcea2C9
         Bd88KvwPNzBV0LHerFVZF2hV7YBYSr/M4i8PTRb4aidEP35N5/LEi343Dwmdi4RgxTvx
         bVciOkFYwVx/nZEXOWe84Aej0ASP9m0ISyTgB4DvSu7qp6nft8IbojCD/tlXlIAORYRA
         61g9Mxw3woh0/UNUId5QbOaOTMHgEYypGgvBTd3FaDIjM47s4Z+FKb9Wy64hbARt0FnG
         HgnCenFtUcQM8yvsKE5sCrVag/1PrnmZr47oqwoMDexadj3tOEngXyEsL0J+MQ4F87X3
         a88A==
X-Gm-Message-State: AO0yUKVdANOSL5x0s1TtqFTU/fDytEFihoYaxtPTJVu5sUI/LBTvEFBf
        XwUiPNjqPzbAusWGtXFEXHqmvLzjrSd7gCmrz8E=
X-Google-Smtp-Source: AK7set8B2rJxVLMufZuhT2OkpdoGqPKRgPaquGj/Viw1m3sQNywA8wQoA3SKoLkIA2MreL+RuOVnDg==
X-Received: by 2002:a05:6a20:6715:b0:d4:9b95:bdf2 with SMTP id q21-20020a056a20671500b000d49b95bdf2mr8018253pzh.32.1678872647651;
        Wed, 15 Mar 2023 02:30:47 -0700 (PDT)
Received: from AndroidSev.unication.com.cn ([183.63.252.58])
        by smtp.gmail.com with ESMTPSA id f3-20020a63f103000000b004eecc3080f8sm2988590pgi.29.2023.03.15.02.30.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Mar 2023 02:30:47 -0700 (PDT)
From:   Aaron_shen <aarongt.shen@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Aaron_shen <aarongt.shen@gmail.com>
Subject: [PATCH] obexd: reject to accept file when replying reject message
Date:   Wed, 15 Mar 2023 17:29:54 +0800
Message-Id: <20230315092954.4182-1-aarongt.shen@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It will accept file when obex agent replied any message
event though the message is org.bluez.obex.Error.Rejected.
The patch helps to reject a Bluetooth object push request if
user replied "org.bluez.obex.Error.Rejected" message according
to the doc/obex-agent-api.txt.
---
 obexd/src/manager.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index 01741fe62..849928603 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -38,6 +38,7 @@
 #define TRANSFER_INTERFACE OBEXD_SERVICE ".Transfer1"
 #define SESSION_INTERFACE OBEXD_SERVICE ".Session1"
 #define AGENT_INTERFACE OBEXD_SERVICE ".Agent1"
+#define OBEX_ERROR_REJECT      "org.bluez.obex.Error.Rejected"
 
 #define TIMEOUT 60*1000 /* Timeout for user response (miliseconds) */
 
@@ -45,6 +46,7 @@ struct agent {
 	char *bus_name;
 	char *path;
 	gboolean auth_pending;
+	gboolean auth_reject;
 	char *new_name;
 	char *new_folder;
 	unsigned int watch_id;
@@ -631,6 +633,9 @@ static void agent_reply(DBusPendingCall *call, void *user_data)
 		if (dbus_error_has_name(&derr, DBUS_ERROR_NO_REPLY))
 			agent_cancel();
 
+		if (dbus_error_has_name(&derr, OBEX_ERROR_REJECT))
+			agent->auth_reject = TRUE;
+
 		dbus_error_free(&derr);
 		dbus_message_unref(reply);
 		return;
@@ -694,6 +699,7 @@ int manager_request_authorization(struct obex_transfer *transfer,
 	dbus_message_unref(msg);
 
 	agent->auth_pending = TRUE;
+	agent->auth_reject  = FALSE;
 	got_reply = FALSE;
 
 	/* Catches errors before authorization response comes */
@@ -716,7 +722,7 @@ int manager_request_authorization(struct obex_transfer *transfer,
 
 	dbus_pending_call_unref(call);
 
-	if (!agent || !agent->new_name)
+	if (!agent || !agent->new_name || agent->auth_reject)
 		return -EPERM;
 
 	*new_folder = agent->new_folder;
-- 
2.11.0

