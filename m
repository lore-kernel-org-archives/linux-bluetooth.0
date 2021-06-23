Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559BFC4743C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 18:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D377601FC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 18:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhFWSqQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jun 2021 14:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWSqQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jun 2021 14:46:16 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01DBC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jun 2021 11:43:57 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id t32so3057686pfg.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jun 2021 11:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W3RQSRbecHZYpOTw42hDJgTmO77FuZ7pFqyXfwTSK6I=;
        b=IDenMgqMmGO3YkK6VcHoSlm6uy8RN02jOnvovCMsSdr2NFJ6W21YZsMSr1iC6/feD6
         nG/9W9CVEa76jQ/l9+EN9yg/a5C811U5Q8EgjkPEQ3s8n4xf/9xDXXcD2/U5yR2c2UwU
         /G8AEbZ2KfbnrksT7AQjMGiZtcdAPD05Lc89fBJFeQdyEcsTibL86OQLoCQwdme1Y5J5
         aqhBoUwEgFBybQPm+9W5eUxmutwYgjVYuWGcnNfB8Q+GjQuJPjruBBK0R/hdKHQesor9
         DFRFZUltE6CzVpntsejweoTnDkm/WwCiryJvAAEDJhGnD2YCIyWEcQW2uohx9zT94hC8
         oVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W3RQSRbecHZYpOTw42hDJgTmO77FuZ7pFqyXfwTSK6I=;
        b=e4LGZmCwDeft+wIpd4Ma8ET0QX7pTF6xwkc3CDB/xIxie+vWs2dkN77hoTxpnBxKJA
         6veo/u+KjICcSRqXHmiL3OWWa1d4awm7rT6yfKAwTlC9Dr4fMShpzWut4Whd/5AGG9ui
         CtYzsBPvaEaEVDg35amwd20rTW2/Nsuner+Zhmta9i8waSYl4Kpbl2ZOMhNN26k0ftuf
         L/L/NuRpB1XNl/hCSMPDo21TDm6G5OmTXxoYRaIY5tckwR4IqGXztQ1rwtyB7H0SEkOT
         srVbZjmHPQXWOWQpBzCFbtm4AEhBZIJJh3LUYOa5WDljpH1HLtwM6xe6sLWkoSg/mpGo
         yREw==
X-Gm-Message-State: AOAM530AMDhVSaVMmCtIkq8e6IsjHVPgkEEy9swp3O/ZH4VH3fbuHR23
        Cxi0vrpnMYl/WLQpohB5WWlurGLeTbtTdw==
X-Google-Smtp-Source: ABdhPJz8YIMwAZezPENKOpU8nxtlD2AdMsBqj6nztwbXigq0WEc45Lns+MxhzBN2CgUpeJY3Xedkcg==
X-Received: by 2002:a63:c1e:: with SMTP id b30mr849727pgl.118.1624473836893;
        Wed, 23 Jun 2021 11:43:56 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z16sm553735pff.9.2021.06.23.11.43.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 11:43:56 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] doc/agent-api: Add AuthenticationFailed method
Date:   Wed, 23 Jun 2021 11:43:55 -0700
Message-Id: <20210623184355.3685859-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces AuthenticationFailed method which is used to indicate
when there was an authentication failure with a remote device which is
recommended by the core spec:

BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 3, Part C page 1314:
 '5.2.2.3 Simple Pairing after authentication failure
 When the link key is stored, subsequent connections to the same device
 will use authentication but this may fail if the remote device has
 deleted the link key. Table 5.2 defines what shall be done depending
 on the type of the link key and whether bonding was performed or not.'

So following Table 5.2 recommendation the AuthenticationFailed method
would be called when authentication fails with a bonded device.
---
 doc/agent-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/agent-api.txt b/doc/agent-api.txt
index 0d9347cab..91d752b0a 100644
--- a/doc/agent-api.txt
+++ b/doc/agent-api.txt
@@ -183,3 +183,8 @@ Methods		void Release()
 
 			This method gets called to indicate that the agent
 			request failed before a reply was returned.
+
+		void AuthenticationFailed(object device, byte status)
+
+			This method indicates that there was an authentication
+			failure with a remote device.
-- 
2.31.1

