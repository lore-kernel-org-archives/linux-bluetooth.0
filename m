Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5106EC6FD19
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 08:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjCPIsM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Mar 2023 04:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjCPIsG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Mar 2023 04:48:06 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEF5A8EA7
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 01:48:05 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so866518pjz.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 01:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678956485;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8rziynO1GpD5t3pA9wSEemIZK8gBi8rDHYsQVdzSS0=;
        b=MEBnEzSmhkmkfVoKJ2ceE0KuCOkksArsoCBPWrVt/U6CoIHYigU1xvw86leKCoEbWM
         ksbdFZNZ/tB2ckohPzjDKJL1t303odA7pPCvhC2OZYTnspUxTez55tEf3iR0pZHE5y9N
         qFbwuPcOOPHTNTWEyVxKpwOchDqtwuGb3ycBGdUQSaRRHF48i/Xbt4P3XEMCUqRjxnkv
         E64sUQMxoO977gZYptb4hF9DDZkKuQ4s8i2KcdY/LktARyv6l7AMcZV59RZ3mVpEuGcK
         vR7/2uSpxMuVK1lPUQyZIjh1/mU0g0DuIuWvXujA2GC+L8Leb9bYSDMZRnbR5xOWOKqu
         68sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678956485;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8rziynO1GpD5t3pA9wSEemIZK8gBi8rDHYsQVdzSS0=;
        b=IgqZ2SNkjXuvNNzGHX6mSMEyK0SlE51lV8q5X+zb9o3XMkcvax2LpYAPrzFs6V4qEQ
         66fnwQMnGfmhlxt9GZ0hcewhFOMTGLkVRN/eYll5MGgLllvRuoUQX6YQVn07DXXsB7Gd
         vjFSfy6hWSUAWLT8lvjPSwydCjlkaRD0hIVDrLng6VZtznk+vAMVwuO4qp1O3kfRsmYV
         cvpUBY3WFC/pjqm+sL+kPZpWdiKXu8t2cI6iwSxLyLfNY2XSh2Zdpoa5MCigEnvttNEZ
         jStYJhjKIfh2DinQcCi4J5ly1JwTULFnUIOV0jAvKRQSqUevxYuoaPi4PFKb6oLmfu/g
         xUmg==
X-Gm-Message-State: AO0yUKXTXPGC24QJDX7U1Lb/sGCa2YMFDh0S3rgAltRLUMmA1c9/+q8C
        d7Z6vxGb/WGDbDvJnPcxkgkiw6N0QVEgbsyV
X-Google-Smtp-Source: AK7set8XHYPwWiLknMwmalif1P2MdYzzTa9yDXYQy3mmpP/hhy4tTznSp1TvGZZNPdtg7UP038Gi5g==
X-Received: by 2002:a17:902:f98b:b0:19a:9880:175f with SMTP id ky11-20020a170902f98b00b0019a9880175fmr2245105plb.51.1678956484791;
        Thu, 16 Mar 2023 01:48:04 -0700 (PDT)
Received: from AndroidSev.unication.com.cn ([183.63.252.58])
        by smtp.gmail.com with ESMTPSA id h132-20020a636c8a000000b0050be4ff460esm2171930pgc.4.2023.03.16.01.48.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Mar 2023 01:48:04 -0700 (PDT)
From:   Aaron_shen <aarongt.shen@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Aaron_shen <aarongt.shen@gmail.com>
Subject: [PATCH BlueZ] obexd: support to reply folder or error to store/reject file
Date:   Thu, 16 Mar 2023 16:47:52 +0800
Message-Id: <20230316084752.12071-1-aarongt.shen@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It is not good to force agent to reply full path (including
filename) to store files because the opp_chkput() will
use the default folder and filename if folder and filename
is NULL.
The patch helps that the obex agent can reply the message
with full filename path or folder or NULL to accept file and
"org.bluez.obex.Error.Rejected" message to reject file.
---
 doc/obex-agent-api.txt | 10 ++++++----
 obexd/src/manager.c    | 12 ++++++++++--
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/doc/obex-agent-api.txt b/doc/obex-agent-api.txt
index 3923da6df..14e40588e 100644
--- a/doc/obex-agent-api.txt
+++ b/doc/obex-agent-api.txt
@@ -46,10 +46,12 @@ Methods		void Release()
 			This method gets called when the service daemon
 			needs to accept/reject a Bluetooth object push request.
 
-			Returns the full path (including the filename) where
-			the object shall be stored. The tranfer object will
-			contain a Filename property that contains the default
-			location and name that can be returned.
+			Returns the full filename or directory name where
+			the object shall be stored. Or error message
+			"org.bluez.obex.Error.Rejected" to reject the request.
+			The transfer object will contain a Filename property
+			that contains the default location and name that can
+			be returned.
 
 			Possible errors: org.bluez.obex.Error.Rejected
 			                 org.bluez.obex.Error.Canceled
diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index 01741fe62..cd6e81942 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -38,6 +38,7 @@
 #define TRANSFER_INTERFACE OBEXD_SERVICE ".Transfer1"
 #define SESSION_INTERFACE OBEXD_SERVICE ".Session1"
 #define AGENT_INTERFACE OBEXD_SERVICE ".Agent1"
+#define OBEX_ERROR_REJECT "org.bluez.obex.Error.Rejected"
 
 #define TIMEOUT 60*1000 /* Timeout for user response (miliseconds) */
 
@@ -45,6 +46,7 @@ struct agent {
 	char *bus_name;
 	char *path;
 	gboolean auth_pending;
+	gboolean auth_reject;
 	char *new_name;
 	char *new_folder;
 	unsigned int watch_id;
@@ -630,6 +632,8 @@ static void agent_reply(DBusPendingCall *call, void *user_data)
 
 		if (dbus_error_has_name(&derr, DBUS_ERROR_NO_REPLY))
 			agent_cancel();
+		else if (dbus_error_has_name(&derr, OBEX_ERROR_REJECT))
+			agent->auth_reject = TRUE;
 
 		dbus_error_free(&derr);
 		dbus_message_unref(reply);
@@ -646,7 +650,10 @@ static void agent_reply(DBusPendingCall *call, void *user_data)
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
@@ -694,6 +701,7 @@ int manager_request_authorization(struct obex_transfer *transfer,
 	dbus_message_unref(msg);
 
 	agent->auth_pending = TRUE;
+	agent->auth_reject  = FALSE;
 	got_reply = FALSE;
 
 	/* Catches errors before authorization response comes */
@@ -716,7 +724,7 @@ int manager_request_authorization(struct obex_transfer *transfer,
 
 	dbus_pending_call_unref(call);
 
-	if (!agent || !agent->new_name)
+	if (!agent || agent->auth_reject)
 		return -EPERM;
 
 	*new_folder = agent->new_folder;
-- 
2.11.0

