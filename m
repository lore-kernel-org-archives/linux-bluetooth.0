Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26616C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 22:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D3C761881
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 22:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347011AbhI3WmD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Sep 2021 18:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344223AbhI3WmC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Sep 2021 18:42:02 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38404C06176A
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Sep 2021 15:40:19 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so7879997pjw.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Sep 2021 15:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rjn9c0A5xnGmuwQVHBsbF23LWzIh1tZ303XgwzxsFVo=;
        b=k6dI6bo1ZhPKLy3t7nJcqP/fPMjhac+aeEcFAw1zIcuXvPrjqfv3pJKXDMXvuzzN5b
         o8GvaaEalL2RHMrjlYZ+DLTjmwFNUhRxscy5GHv+tQVYhYzUnLfriy9BfN1QZruS1kfA
         1YFarVxEIAPmxujSmoe6WLbPlT8GnJ0i/vZrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rjn9c0A5xnGmuwQVHBsbF23LWzIh1tZ303XgwzxsFVo=;
        b=6ecXmO0Nu2VmekMaFHxyvB90/Pe7ojjb9VKhYZrzX8fI8hWGdg6q014M0bCUdEdkNa
         aS3QVRAW1xyD6FrnqsxNcrWe7T6EvArZKgvyTIPyDPOEpHi4ThwvtwLA79eq1bUNdbsU
         7oFaT22slE/Gu2y4JwCX7fKF0DF63f18q6zRZjELhdo+RxAdIbit260MPQ341HZ998G3
         WTp6dHov2qPE3L1mQdHe5tS3ar3XbFxnqWjcp5a5pNJ7L2G0QE6uAZ6areMS2/RtYt+S
         9ICBi/1WVGcMyYZxIr9FdJ/3fVYshFS3ar6Awebkql6mwwQReNprp6MQnFAiI5JbHYhR
         uBtg==
X-Gm-Message-State: AOAM533JoS8AVbuJfXat1I5ThlmbSfPueMlbqS/Y+sLf2cCRrzHCIB93
        5LbkqTj4tzfpkweSRIvmlc2nQIjyeKb7Ag==
X-Google-Smtp-Source: ABdhPJxwyO/aDLcO8Ucea5buNmsf2ADivgQQ3SHwdbGFFRYsUSE9X8CUFskUk6bZev065O6Xp1ltrQ==
X-Received: by 2002:a17:90a:de83:: with SMTP id n3mr12361821pjv.29.1633041618438;
        Thu, 30 Sep 2021 15:40:18 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:eb71:bb5c:56a6:693f])
        by smtp.gmail.com with UTF8SMTPSA id 26sm4541206pgx.72.2021.09.30.15.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 15:40:17 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v7 4/4] client: Print error code for connect methods
Date:   Thu, 30 Sep 2021 15:37:30 -0700
Message-Id: <20210930153703.BlueZ.v7.4.I226fdcdd12b13e4875c8cd03b42fc52283920cc4@changeid>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20210930223726.2886139-1-mcchou@chromium.org>
References: <20210930223726.2886139-1-mcchou@chromium.org>
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

Changes in v7:
- Fix nits

Changes in v6:
- Rephrase error string

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
index c1a62edb7..61650c289 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1966,7 +1966,8 @@ static void connect_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		bt_shell_printf("Failed to connect: %s\n", error.name);
+		bt_shell_printf("Failed to connect: %s %s\n", error.name,
+				error.message);
 		dbus_error_free(&error);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
-- 
2.33.0.800.g4c38ced690-goog

