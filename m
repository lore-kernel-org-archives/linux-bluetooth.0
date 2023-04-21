Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AE0C77B73
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Apr 2023 02:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjDUCrv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Apr 2023 22:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjDUCrr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Apr 2023 22:47:47 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6E22723
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 19:47:46 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63b73203e0aso11414245b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 19:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682045265; x=1684637265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c8x+pY6NdGQ2u4XFdJpOuSbYBXt1uFuYMOJysu2JbKE=;
        b=Apxy0Bdi1j3pMHDDaQqui0FVawddZNP30p+wu+homjulSWAFJOgPV7oGL4zGeH9+cs
         JqrKALZvClp24MLRKFlhH7BukzfM9xsKriWYaez+eT4NswyP/Se/rqcfFwWiJGJNCqVb
         7a7ZTbHdf3tmyBhkx9mBKv90FqmT7PwWQNJlKoz3sTMSlRgetcfa3a8P2nBD0JYhjT5y
         gP5zB/LsLx25ROQY8nvQPmAWAUCRe0KIqGdDkiCW7BsbgbSyrKyePO17uWXinWv8bjY2
         pJZvCr5Wx8PXcQYJfvn9OeGpyjfAz8YKb9OzbbpW0DFTlT1fMfKrTP8z3q/aWBplU6EO
         NyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682045265; x=1684637265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8x+pY6NdGQ2u4XFdJpOuSbYBXt1uFuYMOJysu2JbKE=;
        b=ZZ3bnpoIFZBMLJ740PZ3evd1Bn1tH1IJH2wWBveVI33W6BTfyEGlQYIRf2NcOlhA56
         O03fOg13tl2GvvKYLSCVI/zokD5e8NqQ4d3coa/1LSljzqZ/o5cuVgHtCUBqM8+Ax98a
         iMuQviG+r9JuR7O08Q+rYtJbtg5o5rlLTfgctQIsbu68iaknX5Gr4F//dT5Qx5HR2UPo
         GII54iEfpTVUprub03NssBQ6ea+NIG41o+RM+DYtGy56VRA1YGl5F3y57Qcn3vsmP5Bb
         EYNkBrKqdQsymNt5a/C8mVw+2VVmcXawoRkY/SYUZWfcrg1QOh/iEr5D9OMsfhVvOqgR
         M+8g==
X-Gm-Message-State: AAQBX9dO5Jyhpc+U/OuzgFEZhqaqEGhoRK+PwuXmMNrghGDL3B9Tp6B4
        Iunlv5/B3nf56uZtTYJ8EjjG50myxoOwkpQL
X-Google-Smtp-Source: AKy350YmOWMRkdasVdU8G5Hcci0uVBpL9FNAobtnjRSC29kd0k36qXJtN6NLhSRljxJJY9P+fMamJg==
X-Received: by 2002:aa7:8896:0:b0:636:e0fb:8c45 with SMTP id z22-20020aa78896000000b00636e0fb8c45mr3835822pfe.16.1682045265523;
        Thu, 20 Apr 2023 19:47:45 -0700 (PDT)
Received: from aaron-shen.localdomain ([183.63.252.58])
        by smtp.gmail.com with ESMTPSA id c4-20020aa78804000000b0062e00158bf4sm1871995pfo.208.2023.04.20.19.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 19:47:44 -0700 (PDT)
From:   Guiting Shen <aarongt.shen@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Guiting Shen <aarongt.shen@gmail.com>
Subject: [PATCH Bluez] obexd: agent: Use if-elseif instead of multi-if to check error message
Date:   Fri, 21 Apr 2023 10:47:31 +0800
Message-Id: <20230421024731.42130-1-aarongt.shen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The obex agent will return only one error message at the same time.So
we should use if-elseif instead of multi-if to check error message which
maybe DEBUG_ERROR_NO_REPLY or OBEX_ERROR_REJECT in agent_reply().
---
 obexd/src/manager.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index 2bb985b96..73fd6b9af 100644
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
-- 
2.34.1

