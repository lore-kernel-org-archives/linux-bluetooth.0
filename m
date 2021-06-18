Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62E4C2B9F4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jun 2021 00:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 859D2613B4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jun 2021 00:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhFRATy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Jun 2021 20:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbhFRATx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Jun 2021 20:19:53 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCC3C06175F
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jun 2021 17:17:44 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id x16so6287950pfa.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jun 2021 17:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7zDDBUcMb4xmnGPjaJ5I+6BNcJkydoiN3r/QOjWXtXo=;
        b=kPJTBkOTxN/i29stlgwWZDE/yZme0WPMa/9ZwlS5Mnw/uWQYhiUMKdTvVkaaAj25xX
         zV9aFuMMd9MwJVDtxSvucy2Ct6lIZTolQjPKXh5yAe5NKAZt8BJ/q3fyeWwN1+F5Z8KT
         ZfLbILtVcjNDlYU7RdWG+h2ipfX94gEMEacpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7zDDBUcMb4xmnGPjaJ5I+6BNcJkydoiN3r/QOjWXtXo=;
        b=i6FSw9mNddjyS/Pu67/n3ISfLXhAPxPzXsZYEyhIr2/RHSmxM4S4g+xcM9Akq/3c0b
         brkmRCESq2hrBpexYed2c+h2hX5JEJOrlna+8sZeqd5+1E2IslI+ZF1Qt/mxgGHG3jZm
         RnX2wPlpd22GyTxTDP26zXNPx9GaFpKsb6yex/ybgg1ZT2zyxclodgeueihikkWW3pbl
         9xIIZUfqB3cMpZFkpyDwfPaGvMAhB4v0w5fVLjbHQAte85WqwS3nuQkTlSOukrO9M+ju
         TpYgTPkTm2jHMW/ntwXyafoiQS3kqfDYBTzMXyoHgNt9vZb7zwb8qTj/tIGDNNl2xPwX
         sqYg==
X-Gm-Message-State: AOAM5313cg6E+5zolQSOwLSnOo1tVdY+9t7OHMRodSgdrhmcFNzmlARA
        9dsHoV6hxjpBrZsDX0ygyW62hXbdxWyUMA==
X-Google-Smtp-Source: ABdhPJwg0MRr04BWKKtk+4ibKiHFDKSgROyyg8bmrC4WS3gCRN1qusFCNL8/3IZkUqqC3lMQ+autVw==
X-Received: by 2002:a63:a54b:: with SMTP id r11mr223953pgu.43.1623975463396;
        Thu, 17 Jun 2021 17:17:43 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:d75:da94:7930:935d])
        by smtp.gmail.com with UTF8SMTPSA id y13sm6419808pgp.16.2021.06.17.17.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 17:17:43 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v1 3/3] client: Print error code for connect methods
Date:   Thu, 17 Jun 2021 17:16:02 -0700
Message-Id: <20210617170013.BlueZ.v1.3.I226fdcdd12b13e4875c8cd03b42fc52283920cc4@changeid>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210618001559.1284204-1-mcchou@chromium.org>
References: <20210618001559.1284204-1-mcchou@chromium.org>
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
2.32.0.288.g62a8d224e6-goog

