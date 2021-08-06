Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34264C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 23:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 150356113B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 23:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242813AbhHFXuH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Aug 2021 19:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbhHFXuH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Aug 2021 19:50:07 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE8FC0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Aug 2021 16:49:49 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c16so9184473plh.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Aug 2021 16:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PCXTgNGM1kZekZvv1Tlao0nSFb8xcy7vfhwjIjHyYKA=;
        b=L/ku4Q0plePQyFY6Xp+5fvx7bk4mXQZWay7VmyP2glzqODyev6u5VkaMRUmcOhJACF
         WhQwV9583TUMoVdA/eK3OhQ0myU5YKaRrYL1g0wT1H5bmg+yLblBBrxzKZYrVg9UxE0Z
         5Ey9VwfbFjYSPInHrZpe22nmBgXEi0UaXPZDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PCXTgNGM1kZekZvv1Tlao0nSFb8xcy7vfhwjIjHyYKA=;
        b=fYXEuiVf3eb5pE6AGB+AHRLR0ljVmmapl/HAXFqo6H7Vzyy8xKUZaaS+7/5Azz7UWp
         HJz4Tr+RkrE9E9jBVmAiSWvPwlQTUkjOKTtnIUzV9zMzfzdeoDuPxcwM4UxyPnIlRiVq
         BLbVZysRP2Ecsj39WlwIVNn8+CdrPLeBc9mrdUKFa1RTCHy8LHWoC3Or+QlcRoXc5wAx
         Lob9atu5JkN3nhaARz/cH6bJ4YMDkdcnOp8CuIsH7D1SKQk/pWs96+dMzh1ogv77KCiQ
         hEwCVhg2cxdCe+WqbuWslMCAUuCGNxZzrPXsAwWDaX3T33yjWgfB8MVCV+drVYkK5SCu
         xIrQ==
X-Gm-Message-State: AOAM533JZXAoveqbXnoCIsX9BiWTJzbKuWiwPcVTP99g1xR7wOt+e30g
        I0nc8WzC/TyNpKzXbnxaNS3lVikjg70zzA==
X-Google-Smtp-Source: ABdhPJzekVo9zs1qnkM8GSAnLkKh/f/1+OyQk2wDkozDst/V2UjHuKC5ym5hjMZU74/AV5/ERHIBgA==
X-Received: by 2002:a17:902:b40b:b029:12b:997f:5677 with SMTP id x11-20020a170902b40bb029012b997f5677mr10636512plr.11.1628293789110;
        Fri, 06 Aug 2021 16:49:49 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:48a2:9887:4da1:32a4])
        by smtp.gmail.com with UTF8SMTPSA id c15sm9542255pjr.22.2021.08.06.16.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 16:49:48 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v5 4/4] client: Print error code for connect methods
Date:   Fri,  6 Aug 2021 16:47:26 -0700
Message-Id: <20210806164624.BlueZ.v5.4.I226fdcdd12b13e4875c8cd03b42fc52283920cc4@changeid>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
In-Reply-To: <20210806234720.286157-1-mcchou@chromium.org>
References: <20210806234720.286157-1-mcchou@chromium.org>
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

Changes in v5:
- Replace error code with error string

Changes in v4:
- Address make errors.

Changes in v3:
- Correct error-codes.txt.

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
2.32.0.605.g8dce9f2422-goog

