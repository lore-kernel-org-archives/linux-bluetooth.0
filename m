Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E91EC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Mar 2023 10:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjCOKGL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 06:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjCOKFm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 06:05:42 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AC24C05
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 03:05:01 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id v21so9327622ple.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 03:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678874700;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4yuN2Vf6XahCUJDWAPD54smLN5lAj0NCkXCw7WtJWg=;
        b=PpH47yL8gc+iGjYyemPIM6eXifZ0A1QDIUL4Z1DQZZ2mHhgcf+ya1YvaIeY31I6ljj
         CSCiVcwDLYLMVg+F5F/sLjfi95RvzoK4JAgeHfBoBTyLCeMu090Nz6WWZqrcWm8Ra/j7
         k74BGxVKsRqEwpA8bZqCpgHJvw40Ac2aFY79EsjtwIjgSCfruC+hFJWvhzTsTE9YGhZn
         WthaS9X2EHIeuv++ZlDhdE5KOvWQ7B1yVDfD1ZyUMvx3VKCyYuyNko9gR+1IX81RgTXe
         KjmyGNmwCXBkdRrT6/xOBxuhl2BTDO50plIH7AYpQFi0vTQpLUKw/KGK6vVbOggIAQvf
         IxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678874700;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4yuN2Vf6XahCUJDWAPD54smLN5lAj0NCkXCw7WtJWg=;
        b=jhdBwHNSvGtwO13Yy+BRBSLGvG3sfWOeT3T0nbwcGgry0mYOz2uOUqku0Z6syyzUc+
         prlcAv1WmZmRYe5duJg1/v9uF8vK+KSiyadNbGCbSLI+V4vuAR+JCDB3yskTWC/0jxuL
         hmrovfIDOlgAZztQtCObgtSDEopQURW+7Uz/Gy6tbpO8JBbKfqU7PbHp78JFsRsoXX8G
         ZwdGGXs6x/0TzYVxNLfGip0AqoWTLwrs+hR1AIYLOk63OkLEpshEsgXJqi5yNLWme+Pm
         uNTYh13aUNt5Sh86KuHXXJA9ZzOli+7/egzb3FAKuSG5EQoN8Vj9OVrvxK88os6V8NOI
         9Ndg==
X-Gm-Message-State: AO0yUKW3NY2c5OrxCY2nCXcVYaoVFiciY7206LKhdaAPCmHYBJcEq1yb
        42OE0XMuGVbcEyHtuqMOHjTjmLIrDmzc5v3A2QI=
X-Google-Smtp-Source: AK7set9qRTLKG1Cex9kS409ydb4w4CH8lq2x+O4X8wn52Y0ntvBdrdqE39AIto5vecBSvExcnHw0ig==
X-Received: by 2002:a05:6a20:65a9:b0:d3:f695:1cd9 with SMTP id p41-20020a056a2065a900b000d3f6951cd9mr12045126pzh.58.1678874700133;
        Wed, 15 Mar 2023 03:05:00 -0700 (PDT)
Received: from AndroidSev.unication.com.cn ([183.63.252.58])
        by smtp.gmail.com with ESMTPSA id v2-20020aa78502000000b0060c55143fdesm3144857pfn.68.2023.03.15.03.04.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Mar 2023 03:04:59 -0700 (PDT)
From:   Aaron_shen <aarongt.shen@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Aaron_shen <aarongt.shen@gmail.com>
Subject: [PATCH BlueZ] obexd: reject to accept file when replying reject message
Date:   Wed, 15 Mar 2023 18:04:35 +0800
Message-Id: <20230315100435.5424-1-aarongt.shen@gmail.com>
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

