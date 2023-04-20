Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C566C77B72
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Apr 2023 09:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbjDTJ4K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Apr 2023 05:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbjDTJ4F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Apr 2023 05:56:05 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A29E268D
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 02:56:03 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b67a26069so1138859b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 02:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681984562; x=1684576562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HA3/JDK+TyUa1JckzxDPT3iCbsXcv5oJpBxe4wtkDxc=;
        b=e5tXCcIBD4Z6XJjKh8C/fdiSYTD8Scu8ZbcxDa4AekIE/scz3otFQ3Zn4ap7bbXn/+
         Lw9t55X6moqLJv3SmceixmNsdYRZAb1/ytLkgK3RPANzUaXM4Inij4q5VT7gWWNMKnu7
         DjOMF5q2dGBFPmC89zws+fhCMbkxiVdMVuODBVlMDTjXawfpNuByHjBZoGcV87fYdqAx
         jW5oBbKvOdx0/N/5pUYvNF2JZSlpeh1eKkEwhsc0cLD4I5Vk3CelRI95CcYIOSO8XlIE
         qZ4ulV3sOShn0wk0lSHFFuxsXIxwia/D5ERctPtx/3FOLMdB/Daj2Be1Qd1X1eAMx/Qe
         Yo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681984562; x=1684576562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HA3/JDK+TyUa1JckzxDPT3iCbsXcv5oJpBxe4wtkDxc=;
        b=cCgIik2ny/5ek9fojtdWI6fkwwowaYyPFczV1t148A6CZpPBJE5qZ0kKw88Z/uun1x
         vk0EpIS+yMhmUV2v46MMtHg6danAJEECZEjK9zWKTpck/5CwZ53dSIrcWArGDw+I1a90
         N2Zs+Cev/Lvsn8L591kLUllfisUreFlmjpmeMsOZYkwGHWZfw2nYWGHwx8+EjtvV0YdI
         JIOIC8uPzGV6cpcJS23Vvzl4sr6L6uzg11C22aOYiw5f7GTZ1KktYx5zQFCox+n7H66r
         VvJEJTWHavaiZZVdAOD/9opTAGngTjO4a+DImT88BglROjQmDwM6Kfr0rmpJtjXG0GsT
         pvlA==
X-Gm-Message-State: AAQBX9dlswl/Vxusv/vmhfFLLgLm3/rziCN4pwEK52nZLmLZcdShYbvo
        cEyHOUSD0k7BuATHkFqvcV9VXd69nhb0qI3A
X-Google-Smtp-Source: AKy350YgbP7G8WMa532Wd7TpIaZSsWEOH8vpOoJUzDayySH9n3yWGowfP1vSCPJXNF6Ogoov+diR4A==
X-Received: by 2002:a05:6a20:748b:b0:ef:f5fc:cb44 with SMTP id p11-20020a056a20748b00b000eff5fccb44mr1477554pzd.35.1681984562404;
        Thu, 20 Apr 2023 02:56:02 -0700 (PDT)
Received: from aaron-shen.localdomain ([183.63.252.58])
        by smtp.gmail.com with ESMTPSA id t10-20020a63460a000000b004fab4455748sm818126pga.75.2023.04.20.02.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 02:56:02 -0700 (PDT)
From:   Guiting Shen <aarongt.shen@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     pmenzel@molgen.mpg.de, Guiting Shen <aarongt.shen@gmail.com>
Subject: [PATCH BlueZ v5] obexd: AuthorizePush: Support to return folder name for file storage
Date:   Thu, 20 Apr 2023 17:55:57 +0800
Message-Id: <20230420095557.22252-1-aarongt.shen@gmail.com>
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
 doc/obex-agent-api.txt | 9 +++++----
 obexd/src/manager.c    | 7 +++++--
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/doc/obex-agent-api.txt b/doc/obex-agent-api.txt
index 3923da6df..7c720927d 100644
--- a/doc/obex-agent-api.txt
+++ b/doc/obex-agent-api.txt
@@ -46,10 +46,11 @@ Methods		void Release()
 			This method gets called when the service daemon
 			needs to accept/reject a Bluetooth object push request.
 
-			Returns the full path (including the filename) where
-			the object shall be stored. The tranfer object will
-			contain a Filename property that contains the default
-			location and name that can be returned.
+			Returns the full path (including the filename) or the
+			folder name suffixed with '/' where the object shall
+			be stored. The transfer object will contain a Filename
+			property that contains the default location and name
+			that can be returned.
 
 			Possible errors: org.bluez.obex.Error.Rejected
 			                 org.bluez.obex.Error.Canceled
diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index 849928603..2bb985b96 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -651,7 +651,10 @@ static void agent_reply(DBusPendingCall *call, void *user_data)
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
@@ -722,7 +725,7 @@ int manager_request_authorization(struct obex_transfer *transfer,
 
 	dbus_pending_call_unref(call);
 
-	if (!agent || !agent->new_name || agent->auth_reject)
+	if (!agent || agent->auth_reject)
 		return -EPERM;
 
 	*new_folder = agent->new_folder;
-- 
2.34.1

