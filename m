Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D82C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 00:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240880AbiCWAIc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Mar 2022 20:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240875AbiCWAIa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Mar 2022 20:08:30 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63AF6F480
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 17:07:01 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so192207pjm.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 17:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZdXcpJ++BFmfknFeg44qJ8tEEL3KH7uJgQPggfHVUP8=;
        b=PueIhsT8DkDqPL4PUbAHKBe+ToxqDSQ0w22yAREsuYCcmD7oocTIXQCX/JwO7Hm/el
         mwmOp91oo48xjrd+xSrUzq8Css2I/pQnV1gzp5vlUs2RWGH9P9fmxlUUs6RtA3I57VI4
         tzvAGG7qvLgZIuumYNMm7+DVSYwqkpWdmh/rUIe7toAJsQyC7D7XOTks0ThvfEEuJQMf
         AMCfolSWRYt1JnjrEjREyblLRoCmtk3H8R268lOi8tWBgX7/Q9v+vlzqsUh72fPjUvXm
         qUfs+ezPKtZMuI2gMKmA8tbo4nro9svg6ghPTBuz3qkdsGLEKbkMw8uyCQqxnsldCyAg
         o0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZdXcpJ++BFmfknFeg44qJ8tEEL3KH7uJgQPggfHVUP8=;
        b=jOhSLE5UEczrWw2zz64zbe+lmW7wpYtmDICs62aVQ+xGvSd8DZAWpaPVEXPKBD8EiA
         TXX8KWnbC2oTPV+wEF36N3DUVWA56m43GmWzW8qhefki1pJD34nmImgDKqB8q2xChdDu
         Q5qLHQXklweUAsecMryiBj7RBQG2zIcfMqUhcyE7OE8uRYBcOGm19sXGqdgDIfMsL+4w
         fl6srKvtvDhHZUSLiG2Jw80/CT61KHiP6XjYzMAxr+MDhAWYINEU5+qPoI+aPJgBjQQS
         IajRswpNb9YxxaSNOMXaP9kxlrQTx+okl3zBrgFdHUVefCYRr0Z5L8tz7A4Gq8i1cQQS
         w8rQ==
X-Gm-Message-State: AOAM532qywLyAeP+wrxRX9iQwnZzZIWS/dIWv17ZwBp6xU8UNfNaXkJ5
        5YbzHkTDGcU827IDfRapSAVPUOqJPXE=
X-Google-Smtp-Source: ABdhPJx0uQWLnz1s/ynIcF1nc+a2OSvDy3LlgBgnSwid7jd3nZouPDUlIAbxExzI7TtCkfebFjKWcg==
X-Received: by 2002:a17:90b:4f4e:b0:1bf:88f6:e5b5 with SMTP id pj14-20020a17090b4f4e00b001bf88f6e5b5mr8137288pjb.47.1647994021192;
        Tue, 22 Mar 2022 17:07:01 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id bx22-20020a056a00429600b004fa936a64b0sm10098423pfb.196.2022.03.22.17.07.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 17:07:00 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 9/9] device: Don't use DBG in gatt_debug
Date:   Tue, 22 Mar 2022 17:06:54 -0700
Message-Id: <20220323000654.3157833-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323000654.3157833-1-luiz.dentz@gmail.com>
References: <20220323000654.3157833-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

gatt_debug callback is used to print debug strings from bt_att which
includes the file and function names so using DBG would add yet another
set of file and function prefixes which makes the logs confusing.
---
 src/device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 3992f9a0c..860155b6e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5545,7 +5545,8 @@ static void gatt_client_service_changed(uint16_t start_handle,
 
 static void gatt_debug(const char *str, void *user_data)
 {
-	DBG("%s", str);
+	if (DBG_IS_ENABLED())
+		btd_debug(0xffff, "%s", str);
 }
 
 static void gatt_client_init(struct btd_device *device)
-- 
2.35.1

