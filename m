Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7A8C77B78
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Apr 2023 03:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjDSDIc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Apr 2023 23:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjDSDIa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Apr 2023 23:08:30 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31195582
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Apr 2023 20:08:24 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id p8so28310634plk.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Apr 2023 20:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681873704; x=1684465704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nqn40+KYtsbyL0nm/7BvwIk5576Ewf8b6sF0OxcTL/o=;
        b=sBKVMlPOmoywyQmK46Tuua9vLPS1vEQ16J5hZ/wUabwGA7CVZMqLveTgvRmXAallyO
         ApLh2V8tGRIECWpDcXmS+Htf3Dpc7Qn8v4P8JqEAxX0v+DRJR7mYr9G5wfbDW35tY+yj
         6HuHYwJeHPKxY22+46SJmyPX7qTETiXJelN0swT3fmnkdm1ZZblRcFwDXbXmx0gGyelc
         rX03IDnxa060+eJcBL0EJKeSoXolYHlza6jxPNXSx1+5f4qWVM/gqCAg8TiyaokMdDo1
         ski4dizr2Jv8OZd3jdXk6vGXR4ryyfntwV90cVoozvMUyHqEwdjfutTRc5SsO6M/0sbB
         wARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681873704; x=1684465704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nqn40+KYtsbyL0nm/7BvwIk5576Ewf8b6sF0OxcTL/o=;
        b=NlUpsVbLiSQmSlClVR23vNmKKRhDyvVvJKEW0pNupVXXJ62eWWFK9YSudhMKQAvrzA
         bIAT7yk04xtEivY2MfQu32h7RUcFvbZiMs6do3G708gVr91XMMVQnA2UFSRA578WMDYF
         wR4CvQyx1jI+ttPkZIzEyySmIiCukbMUKZUo8iAjB7mV++Tp141a4TqsvGSRJPbvlkEF
         vrhGjJiyJ3Mco8ER3Bc0wXWdni2VX7o1cu+0or0x0ooy3oiSeh9AVncVKH1D9y8fT3Y0
         DNqNYfGZDfxJc/SMxk3Ov0aZSbPTKrxFSW2W50aLKfRW8elkH9ajvLp2bIJvDxYMOFq/
         hxzA==
X-Gm-Message-State: AAQBX9dd6/hW44CpPepI7WX41KjwZYRIV2g0KksElj4jETe1IQPLVSIc
        2kNARoezssiDYNFiB9ozNdVVzugotMzV6Q==
X-Google-Smtp-Source: AKy350YPhMJWLopJj6N/3polWS7SjSS5Sxz2jzmSIHWrrIzFmpa+TV6YO+tTO7Y449/j7c44xV6vcA==
X-Received: by 2002:a05:6a21:99a0:b0:da:c7e:6ec0 with SMTP id ve32-20020a056a2199a000b000da0c7e6ec0mr1979139pzb.25.1681873703957;
        Tue, 18 Apr 2023 20:08:23 -0700 (PDT)
Received: from aaron-shen.localdomain ([183.63.252.58])
        by smtp.gmail.com with ESMTPSA id v11-20020a63f20b000000b00502f20aa4desm6780019pgh.70.2023.04.18.20.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 20:08:23 -0700 (PDT)
From:   Aaron_shen <aarongt.shen@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Aaron_shen <aarongt.shen@gmail.com>
Subject: [PATCH BlueZ v2] obexd: support to reply folder name to store file
Date:   Wed, 19 Apr 2023 11:07:42 +0800
Message-Id: <20230419030742.6123-1-aarongt.shen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

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

