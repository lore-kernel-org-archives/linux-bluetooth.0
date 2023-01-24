Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95422C54E94
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Jan 2023 23:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbjAXX7g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Jan 2023 18:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjAXX7c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Jan 2023 18:59:32 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3E047403
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 15:59:29 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id g68so12361853pgc.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 15:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pEyfkcYx7LLXIX8X8vph7xamuJaRQUiOEiriStKBkK4=;
        b=bGqGJcfLGQkFGw08+UWZ2Ga/Wtnq/CR2QgezhmmrrdbIrKf/eJrlSbJ9y8eCFiJ2Sh
         zb+M0b2ZwmelGoasDv9b7PwKfre9f3XJ/qVgaRwMNCDv1J0atG+MXiqeIwZhNgRy3Ynr
         DOfwPhatW9iRTVN1HaQk13uI9csjQl0R3K2iZbxhr5F16lnzQDk94chxflDPv3OzLSJQ
         nZBVEvjkx3zSRRevYh59cogM/P3IKTuz+x8OlGlC6eSBg7tYCBR/BNx97mv75xGW3+Bd
         8dO32przXIR+ZtiMGWmTfCCHg0mz8oPeq+lmvBEaGZFCAIOVJ0XwPOWTktUO0ZAetaLJ
         ixvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEyfkcYx7LLXIX8X8vph7xamuJaRQUiOEiriStKBkK4=;
        b=njM7h/nDhtmqqEQEGHedxTZNZdODRqEoKSMic8VlAm2+axJAsgY1A+j3n7ZeFE3xhc
         Fv5+F1/adGoYs8wU1JfBFAL1FjoLDPXOpq+4YFbhZEkIiqwBVv7ZUlPPUej8ETnk1zZH
         vIFHWyVcNsO5CkbZbXUCUsWzzq1Ek2FXc/j6zD3uvNXDrPGIQ03hyPMeZMuOcmtCEo8q
         5BXvAF8qlhmQ1iBbE0w5xoHu9jp0IQw+nzH8tBleWEWOYBnw6eMG5WVN/HtjvoeOyyCK
         xMzgwCeC+z5fD/FzziR6b5/Dai1btVOp2gnUl93guj1m/Dy+632lX63q4Zu+/Z9t390O
         QVbg==
X-Gm-Message-State: AFqh2krK1yFeP5FZ7HefN+gCZIZQddL68y6pGt4Xln9362aYAMBfIC77
        Pr4uMlf8MwFmOgraknFq9o5pDr0OV8s=
X-Google-Smtp-Source: AMrXdXtLUgM4/wTdrAFsXIFehN+eBr9hnTyK3mV2wjlp+XOiuZvz0IFnqa3QT322tIEZhpKnwL6nyg==
X-Received: by 2002:aa7:8c51:0:b0:58d:8d88:447b with SMTP id e17-20020aa78c51000000b0058d8d88447bmr26458230pfd.2.1674604768189;
        Tue, 24 Jan 2023 15:59:28 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id r3-20020aa79883000000b00585cb0efebbsm2242648pfl.175.2023.01.24.15.59.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 15:59:27 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/3] bap: Fix not removing endpoint if local PAC is unregistered
Date:   Tue, 24 Jan 2023 15:59:23 -0800
Message-Id: <20230124235923.3623705-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230124235923.3623705-1-luiz.dentz@gmail.com>
References: <20230124235923.3623705-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If local PAC is unregistered it would also notify via pac_removed
callback which shall unregister the endpoint D-Bus object.

Fixes: https://github.com/bluez/bluez/issues/457#issuecomment-1402178691
---
 profiles/audio/bap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 8f24117681d2..5a50a2cc6105 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1049,12 +1049,12 @@ static void pac_added(struct bt_bap_pac *pac, void *user_data)
 	bt_bap_foreach_pac(data->bap, BT_BAP_SINK, pac_found, service);
 }
 
-static bool ep_match_rpac(const void *data, const void *match_data)
+static bool ep_match_pac(const void *data, const void *match_data)
 {
 	const struct bap_ep *ep = data;
 	const struct bt_bap_pac *pac = match_data;
 
-	return ep->rpac == pac;
+	return ep->rpac == pac || ep->lpac == pac;
 }
 
 static void pac_removed(struct bt_bap_pac *pac, void *user_data)
@@ -1082,7 +1082,7 @@ static void pac_removed(struct bt_bap_pac *pac, void *user_data)
 		return;
 	}
 
-	ep = queue_remove_if(queue, ep_match_rpac, pac);
+	ep = queue_remove_if(queue, ep_match_pac, pac);
 	if (!ep)
 		return;
 
-- 
2.37.3

