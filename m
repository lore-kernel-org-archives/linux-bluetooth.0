Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA701C47E4B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jul 2021 01:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4D9861005
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jul 2021 01:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhGOBPB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Jul 2021 21:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbhGOBO5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Jul 2021 21:14:57 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A43BC06175F
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 18:12:05 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id me13-20020a17090b17cdb0290173bac8b9c9so5011104pjb.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 18:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IhrSu4wh8n4znVOwGnNvlUkfc0zLP1DS+0LDkx5VFDw=;
        b=J8BLPkR0X6erW673XeQK0gOwGhUrvf8P3FwTeiDErmcNrJaqMBdwKkx3hSDanDnp9Y
         Jy0bNJvH68NuBXFTWyuh9lrfyCZOceNd64tZZYcIIc76JCURNlItZ3nUJrLOxAPvFqw3
         mFuZMD/LtA86P4U2cnEnW5HVzSUswdJ9xZVhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IhrSu4wh8n4znVOwGnNvlUkfc0zLP1DS+0LDkx5VFDw=;
        b=kyAbQAEGz//qzFd8jskmC/UJBZmKokcq7WTYP77sPGXwkiuDO1MqR7ud+417vufhpz
         2bfq89HNeki0T3PhdQCzRWCQn74gGso0S0IKqUFDy5two3pNzRicVO3VOPligNF1Zcmq
         rfp82kPzivWXsDihNvF1Fw0GKbfBBKPT7Hwjvg/hOlwUoXy/ZTdsFRMrWyd8u79aZ7wX
         DbWMPXSO0t+Tp9ECWSMwDQRgy8o1zBM/oXiTb52Hw34BjKYh6Syqu7z6B5Q8vZuLY4MK
         PvUppxGSLhXDLUkQrmSsDHjHEk7LqRfJhQhxL+0CQRkUNGcqAa5DT9x7R2H8wruP3tk4
         2QLA==
X-Gm-Message-State: AOAM533QoA5KtoBtEO9xdTo8WFjH1rGJFrG6E6MZiz9hTujMJtalD/oN
        b06ZcjPXbkXB/6KV1DvyHDZX55UIMuQfmA==
X-Google-Smtp-Source: ABdhPJz2H1aII74cHYUrvjBWuWX/nxaXz7tpbgEVqrO3DK1GsB2AK8QTKMCmRD89LwXJWTJU/pAULw==
X-Received: by 2002:a17:90a:6482:: with SMTP id h2mr6255457pjj.24.1626311524579;
        Wed, 14 Jul 2021 18:12:04 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:20b7:5dcc:d530:a8df])
        by smtp.gmail.com with UTF8SMTPSA id t11sm4653972pgm.36.2021.07.14.18.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 18:12:04 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v3 4/4] client: Print error code for connect methods
Date:   Wed, 14 Jul 2021 18:09:56 -0700
Message-Id: <20210714180917.BlueZ.v3.4.I226fdcdd12b13e4875c8cd03b42fc52283920cc4@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210715010951.963176-1-mcchou@chromium.org>
References: <20210715010951.963176-1-mcchou@chromium.org>
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
2.32.0.93.g670b81a890-goog

