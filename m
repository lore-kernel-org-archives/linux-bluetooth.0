Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30606C49EA6
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jun 2021 05:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0722C61931
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jun 2021 05:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhFZFZY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Jun 2021 01:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhFZFZX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Jun 2021 01:25:23 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC842C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jun 2021 22:23:00 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 21so9176123pfp.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jun 2021 22:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bHXu6QpYhAF1bUg3eeLJ+I+qTJOic4krZqFaMCKTV0g=;
        b=b8eKxOAmGy4gBlERq8xINuj3/rC/lHju2Dqro4t69QW06NYdyxrw45n/nFpWmctu4W
         3nlELuiDesQkdXzyakXZ7sJzFM/SwtyRQCCeOQBfkkMTvln+FL5q0hAYtYujSJUAue+G
         rL4yoG6XDqFS/EiZ40xvTVNMkJ5fZUkwfLMFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bHXu6QpYhAF1bUg3eeLJ+I+qTJOic4krZqFaMCKTV0g=;
        b=QaZhDGg3yJoz+nvQKFGLGyJZ4Z+abk0twW1UvL+HOHeexuDlZ2fPNe6J3aM38Eo/HA
         OTbM/OL3fd8PYTLvl+OSuGM0SfO+bwmbch6p1+KTE8wtYPEtneC5yJRCe62YWwE70yUE
         26jQ6sj15y6RS2LuM0CqRik0yLXucYkkdpuRVX6hllVvdnnWWQkYnew5DBV64lZmPcW6
         mSuuKKdR5jJ39qAiJrYuB7Ctk6ZDZsQnXg/tHoi0ghAAHrdCrjujAsFp+sQTEyGxCumx
         ufJmT5FU2KaVHLKfGG09kPcxTkE0p0yKSc7nRNuNefYtGE+dM6QNjyjKbAd0LE25/yH1
         KqXw==
X-Gm-Message-State: AOAM532C9EPTsDQRCMT6XvfLHJn/BW5e/XAdNpRZ0I6GDVM3Bpd4n1wE
        VBasaBZqQHrQpNm5jFwyElvwDmACPTU85w==
X-Google-Smtp-Source: ABdhPJzg1upuSg8Cdyy8xneATFD/1pR+nIPdOFk93/9wFgqQVbRjXV8s6FuQa65CFmN3Luo8xKU/lw==
X-Received: by 2002:a65:42c3:: with SMTP id l3mr12607058pgp.259.1624684980129;
        Fri, 25 Jun 2021 22:23:00 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:be2:cfe5:893:108f])
        by smtp.gmail.com with UTF8SMTPSA id k25sm7297188pfa.213.2021.06.25.22.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 22:22:59 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Howard Chung <howardchung@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v2 3/3] client: Print error code for connect methods
Date:   Fri, 25 Jun 2021 22:21:55 -0700
Message-Id: <20210625222111.BlueZ.v2.3.I226fdcdd12b13e4875c8cd03b42fc52283920cc4@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210626052152.2543526-1-mcchou@chromium.org>
References: <20210626052152.2543526-1-mcchou@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The following steps were performed.
- Issuing repeated commands to connect the same BLE device.
- Verifying the print in bluetoothctl console

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Howard Chung <howardchung@google.com>
---

Changes in v2:
- Add documentation for error codes

 client/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/client/main.c b/client/main.c
index da877b546..488a24bf6 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1949,7 +1949,8 @@ static void connect_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		bt_shell_printf("Failed to connect: %s\n", error.name);
+		bt_shell_printf("Failed to connect: %s %s\n", error.name,
+				error.message);
 		dbus_error_free(&error);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
-- 
2.32.0.93.g670b81a890-goog

