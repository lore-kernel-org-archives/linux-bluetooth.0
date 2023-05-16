Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B0EC77B7F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 May 2023 20:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjEPU7k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 May 2023 16:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjEPU7i (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 May 2023 16:59:38 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BF97AB8
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 May 2023 13:59:37 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1aaea3909d1so1068755ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 May 2023 13:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684270776; x=1686862776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KjhUpj8uSuuQsuauzOhywl0XBpKd80yMyJQj1Ru8+Ns=;
        b=Hi6mPASpiz1Xj2DADtlfQVoNHrKfEgXFv0V9IWWPlkX74f+qP6YxedFlS+BCcK6HIC
         V/uV94dGbjoZyjNYL1eZJjgAYQMcDvPi6cfIzo8woC589WZ2nSnZiAUa57iIcm7tBepc
         3u+hj64omlP5ZSK5XQCk2rNlfuOHZlc61zia88KNCUBsAyvOIk/v2SdON6PBHQxlMjqw
         XEbQmQ0oN/YqDTJUU2wsI1Kulr1WyKRzWuc/z24Wup+Kymx3FRdRMPgckmuTfx9k/6L8
         nH3GXLRvMpbya0sMrOEsUKHwV2C6vYINk39OzChfAkdXx5Mzus9Cw4P73uuM3iRz+3tT
         3hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684270776; x=1686862776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjhUpj8uSuuQsuauzOhywl0XBpKd80yMyJQj1Ru8+Ns=;
        b=DGhkQuIbSziEH8q1sQvClYSVbMNBBG/eWqTBvIlhQk0+noS8HVAw6lSQDhNHZ+awz9
         IrVTTw+3nur+XG8MJEepDV5UrbanijgdEwX2jr7DLnL/QAU3FG+ZtsXVWOO8F5JjQ+RP
         WhWnuvg3RAiOyDB39vP8PXrRKHLkIcMj14Pung6OW8vyC1Pg+bvGTp4rIQS05AXscVsY
         /MwKX3an2upO5CKaOOeUe/ZyybttiVulaVES/Ro9T9EadLXeZGtPkWWVUrV73FvksKwG
         U9YGr5nQqN8lQqpj6kqdPLHlpHCLQesV57pnH85mKARkdNhCIU+nrUdtnZZ0f+ivByYI
         CzTA==
X-Gm-Message-State: AC+VfDwzdFOj89f4xm2C3IWR6rmzvcmZ479hQbZO8d7XT+a2nVMoy7x6
        6wYm/1MJNiSZhMqbmzzj28yvwi+q0Hg=
X-Google-Smtp-Source: ACHHUZ5W+DV1slfYzfL5i+PCkHSqeW4LfKeeu5E1qcQ2u3Z0CrtjbfOT0DzjyAK3iG0MdCsWEsTwng==
X-Received: by 2002:a17:903:6ce:b0:1a6:3799:ec2a with SMTP id kj14-20020a17090306ce00b001a63799ec2amr33506272plb.35.1684270776250;
        Tue, 16 May 2023 13:59:36 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id t16-20020a1709028c9000b001acad024c8asm14272237plo.40.2023.05.16.13.59.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 13:59:35 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 06/10] vcp: Mark driver as experimental
Date:   Tue, 16 May 2023 13:59:20 -0700
Message-Id: <20230516205924.1040506-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516205924.1040506-1-luiz.dentz@gmail.com>
References: <20230516205924.1040506-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses the btd_profile.experimental to mark the driver as
experimental.
---
 profiles/audio/vcp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/profiles/audio/vcp.c b/profiles/audio/vcp.c
index b42b0a4f79dd..175275f2e977 100644
--- a/profiles/audio/vcp.c
+++ b/profiles/audio/vcp.c
@@ -289,18 +289,20 @@ static struct btd_profile vcp_profile = {
 
 	.adapter_probe = vcp_server_probe,
 	.adapter_remove = vcp_server_remove,
+
+	.experimental	= true,
 };
 
 static unsigned int vcp_id = 0;
 
 static int vcp_init(void)
 {
-	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
-		warn("D-Bus experimental not enabled");
-		return -ENOTSUP;
-	}
+	int err;
+
+	err = btd_profile_register(&vcp_profile);
+	if (err)
+		return err;
 
-	btd_profile_register(&vcp_profile);
 	vcp_id = bt_vcp_register(vcp_attached, vcp_detached, NULL);
 
 	return 0;
@@ -308,10 +310,8 @@ static int vcp_init(void)
 
 static void vcp_exit(void)
 {
-	if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) {
-		btd_profile_unregister(&vcp_profile);
-		bt_vcp_unregister(vcp_id);
-	}
+	btd_profile_unregister(&vcp_profile);
+	bt_vcp_unregister(vcp_id);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(vcp, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
-- 
2.40.1

