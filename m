Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17288C77B73
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Apr 2023 10:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjDSKUE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Apr 2023 06:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjDSKUD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Apr 2023 06:20:03 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D5A4215
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 03:20:01 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b5c4c769aso3353036b3a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 03:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681899601; x=1684491601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=74secaAjH7SS4hzDQ7RTo5WT0K89JYep5E7hAM70b0w=;
        b=J2QWmLg6KPjo0b8kPLn8CPunmSqpw0ycf2W6xb7z6xoKKx6Ey4gA2aOuRCfsja3iMV
         gITInvr/rxjw36GvUpwjZkh0xOjUPLsEibb7K+x9Hmsr9WVDOcBwPpBhsPkndBGJu72z
         g+g64mtcxG/LELjcRi5RGsMX/SuYLRNpkZdH5xRELWmnS0vLKURWWZyaMu1QO/iv8gdp
         cnex2CFeyERoqk0yhYR0vsFmGJJRpzVHKf1xLq/Pw4kbr12zbTgSQlZicTwUXn+RvbFU
         Vkx1Pd1kRpASbATSQPS95lpDY1TNHqIbpfUfECVEWzA4obPoB/rl0cY6ZjTr0CTMcPAJ
         mowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681899601; x=1684491601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=74secaAjH7SS4hzDQ7RTo5WT0K89JYep5E7hAM70b0w=;
        b=ToL19YeLl3h/bnOf+UyQ2XEov1VA7EByVNT7tQEYKECfYb2voiuxImgIAhihTuly7K
         m96fZCkEwbIhDV8MiyjG8sZOAGZAPuWXLagmC/tNzoHBOYqBobrDVB5kkFmi/evxEj9p
         AUO8VGmJ8xDim7ByRay6DUHU7APVAHZngGaPbYBvCXK6Jynxmgiaf+nH36lEDXYi14sK
         nsMUul/E3RK8hF3q0xuMGvq4lKVmUa7Q5TerZ+9k3Vg1ELYmBNWs7m9f+Eu6Ucn+NBG6
         G5wqSRxbxDxDTfreFdUkIv8QVAlx7WXDSALm8ECfavaP9peY4secxsfBZTNWQ10FO6vv
         Tdjw==
X-Gm-Message-State: AAQBX9cFIRwOraOmP3qBCKTzAKOK10OAIYKeLDfnn9kvxRAqN+7cNdJQ
        NQmpRhF5M19FVXZhajyGVGVL4+BQaI/143vL
X-Google-Smtp-Source: AKy350Z7MMdgsrxwInLWC27pcIscKS/NiF8npxN2qrQ5rGxXQ4r93BY9pvjsZB4fRABv4JENWhCEXQ==
X-Received: by 2002:a05:6a00:a23:b0:627:f1f1:a97d with SMTP id p35-20020a056a000a2300b00627f1f1a97dmr3475744pfh.24.1681899600921;
        Wed, 19 Apr 2023 03:20:00 -0700 (PDT)
Received: from aaron-shen.localdomain ([183.63.252.58])
        by smtp.gmail.com with ESMTPSA id f2-20020a635542000000b0051303d3e3c5sm10070745pgm.42.2023.04.19.03.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 03:20:00 -0700 (PDT)
From:   Guiting Shen <aarongt.shen@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     pmenzel@molgen.mpg.de, Aaron_shen <aarongt.shen@gmail.com>
Subject: [PATCH BlueZ v3] obexd: support to reply folder name to store file
Date:   Wed, 19 Apr 2023 18:19:54 +0800
Message-Id: <20230419101954.56002-1-aarongt.shen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Aaron_shen <aarongt.shen@gmail.com>

The obex agent usually reply the filename by getting the default filename
from the filename property of the transfer object which is not convenient.
The patch helps that the obex agent can reply folder name or new filename
or null which will use the default filename if new_name is NULL and the
default folder if the new_folder is NULL in opp_chkput().
---
 doc/obex-agent-api.txt |  9 +++++----
 obexd/src/manager.c    | 10 ++++++----
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/doc/obex-agent-api.txt b/doc/obex-agent-api.txt
index 3923da6df..322531009 100644
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
+			folder name suffiexed with '/' where the object shall
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

