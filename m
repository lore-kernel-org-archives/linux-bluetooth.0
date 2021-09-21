Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB93C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Sep 2021 16:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2F0061166
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Sep 2021 16:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhIUQvx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Sep 2021 12:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbhIUQvw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Sep 2021 12:51:52 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FCAC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Sep 2021 09:50:23 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c4so13788792pls.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Sep 2021 09:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/FXhO2NSMQzvQTLywyJVzhht/202PftsHvkwRYE2cG4=;
        b=oNoYNr2glEdgHrV9JaOsd98via4j/f1Q91g1rh0HhSk7F2Fn8np6TWYd13AUAouajU
         f8ZFrnS85wl5kwczDEsdGYcXC2G3v6g53tepyNcjTsXUqkphclzCNgy6xH6NGofqYAg0
         HRI8CQ+xkawZVIFHqMO7slq/3eSOZyW0xeAlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/FXhO2NSMQzvQTLywyJVzhht/202PftsHvkwRYE2cG4=;
        b=pVVOI6io2IseS+Ueq5roCJFdxQSHsV0qS7bp7bsqxhZQS86tDpXZ0hfVTU2xb5PuyN
         kyaVUYJ8KkTkKPzJ5X9KgGz0vsOchNvJMN6VJxFprMVwwO19rl60KCoaKiRaFCHrB+PK
         3aG5nn4SaX4iMyykcBLixAMgVKgi4Vv7S6su/OCku/uxuAtTQlWqi6rTeJUwg640sAEg
         3gJw034Ve3FC5My0UZ1PI3tLMIvpl8AXRf0chp2qomX2GcDN3ntVe2c16H2kCj8U9ol6
         J4AyJsfOwmgXgOxxIGoNQKLNJ9o3YRuSj4RUUHSE9FpSAwGQG2MZ7dUN/+KU42VKiDUw
         nQhA==
X-Gm-Message-State: AOAM533N7s2hVZPya/MEOQAplGYB7xBPktwzHhwFAqRwgstMynbGyjsk
        VYl8RfKwyKBAxJVJYOjr3EPUsXBIssVjBQ==
X-Google-Smtp-Source: ABdhPJwecBCfUsrK9f/RchndqEkettK23JKfKnKKL/t8Yhy8JWtFGmnt8IY7+siNkC0u1xvYq+IVUw==
X-Received: by 2002:a17:90a:c58b:: with SMTP id l11mr6230617pjt.134.1632243023105;
        Tue, 21 Sep 2021 09:50:23 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:db3:f19e:7f67:74f])
        by smtp.gmail.com with UTF8SMTPSA id m9sm19200841pfh.94.2021.09.21.09.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 09:50:22 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Howard Chung <howardchung@google.com>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v6 4/4] client: Print error code for connect methods
Date:   Tue, 21 Sep 2021 09:47:11 -0700
Message-Id: <20210921094400.BlueZ.v6.4.I226fdcdd12b13e4875c8cd03b42fc52283920cc4@changeid>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
In-Reply-To: <20210921164708.1497029-1-mcchou@chromium.org>
References: <20210921164708.1497029-1-mcchou@chromium.org>
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
2.33.0.464.g1972c5931b-goog

