Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A702CC6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 03:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCWDWw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Mar 2023 23:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCWDWt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Mar 2023 23:22:49 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F94EC70
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 20:22:48 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w4so13033894plg.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 20:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679541767;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jM6KSwm2K8MuGU+51W5Gxb2R0oj9TXBUe4nd6RdIHEg=;
        b=nxnNbI3zjYhl80hgEF6lF0w0XsDHw9JYEqgIwf3UBJ90jAMdmG0UGjedYkRTUDfYuY
         DL5au1Bk9237+xtYs+7gUbgEVX3/01dypZnK29DRC9/YwjFDl9oML863ylY/Od2u8Wkc
         aFFVK068HPSFd+FfUUScun2LZsOsiqyFcEfjHOXR1SzvaGBA/RO4hA+FfGbpBSaQ/a4u
         /W8qqkLpu1vVLuriye5HjiPyXQW56Gmy42RwuBWMJjLzGbsVvGGJTWHlaDo1Il6ocuVy
         SxpvX3F2lrNzo9rtQ/XF3quqyQg/Bjiwum6GoAihry305Ta5iI5eSfEGpY4drpBHTx5f
         ehnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679541767;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jM6KSwm2K8MuGU+51W5Gxb2R0oj9TXBUe4nd6RdIHEg=;
        b=wowJn+DiQzCgEhnuMGo2+Xp/LUxihHfrPWvwOXssn8hA3nC6YBaIdwMTQu+a2WtNiL
         kffLRnQaT+vtcwBS/QulaDziDjRqZ7QrjU8Fl1rB6PrrzrFoMJTWxe5nYkwsPfXJ6hNi
         TEgcGNIontFI73v+nhTfysqQ3Ac8ZITw+XFiainyFBny1ucxB/YluwksI5nO5Owkywl7
         mdmyeI/8G9E6ztC/uGXuwfreEwZVd399vjooPF23DH8R5L++37CyBB7iflMUaqfZa0ZO
         DAkybrdgzpfguN0LWxEJIMpZSiyM90uyhkS+7vH47uglnQpFuaPxPyklC1SblFCKLuus
         UY/Q==
X-Gm-Message-State: AO0yUKWkwoAdlDfFnxX2AxyHh3EQBhrQGyJgIPI3OuKLDx2xdXYsBuKq
        CbJWNmkVsvyu8QmvX/ncq9dCa+jE9s6i3g==
X-Google-Smtp-Source: AK7set+5gAQEKbBudhOic0jcmH7y9AGTCw2EXtspf2ORRhiC8T+aR+eb8KglXMJs7ujHBeUpjIXHpg==
X-Received: by 2002:a17:902:f1c2:b0:19e:6bc5:8769 with SMTP id e2-20020a170902f1c200b0019e6bc58769mr3643936plc.69.1679541767370;
        Wed, 22 Mar 2023 20:22:47 -0700 (PDT)
Received: from AndroidSev.unication.com.cn ([183.63.252.58])
        by smtp.gmail.com with ESMTPSA id x13-20020a1709027c0d00b001a06677948dsm11231145pll.293.2023.03.22.20.22.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2023 20:22:46 -0700 (PDT)
From:   Aaron_shen <aarongt.shen@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Aaron_shen <aarongt.shen@gmail.com>
Subject: [PATCH BlueZ] obexd: support to reply folder name to store file
Date:   Thu, 23 Mar 2023 11:22:36 +0800
Message-Id: <20230323032236.17706-1-aarongt.shen@gmail.com>
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
index 3923da6df..4e6d493d3 100644
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
+			directory name suffixed with '\' where the object
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

