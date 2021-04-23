Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87338C433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 12:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C0CA6145F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 12:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242226AbhDWMaK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Apr 2021 08:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhDWMaK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Apr 2021 08:30:10 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D48C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Apr 2021 05:29:34 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id c4so9322511wrt.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Apr 2021 05:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bgWIlcq0jkjm2IQXT/BNQEqzpeYvTgFDnru4N6CtDaU=;
        b=bFiLZpLmTcYBPSkTd7BV0Hps7xKsbqY4qS0hi0se387HQSDSGUiyefFyjY+ZTimDSr
         h+qPt19kYyuE8GUlTOX7daotcQIk0L7LTpHe+GXQ84JMUVJf/iz1VeXgkRCD1LL8qoBN
         Kkxc00PbTPHbNtth1+NhHioLuMBZb18oBn4yN5wR9nkWDOr7+hCYy6JFVJbMiyubjDLY
         Qh6CZ/wwq46O2jyqIctNN9TwkfIXkCIbRLW/s9jKOaO1WlSMtjG2fIPaIGd3HdcMc6ZP
         N3fTz3BkFdzBZ7WrqRLoMGjp3fO3DslBlpnyN7rR7pBdzXnrbCmgceWTYi/KCcjuAsEd
         Pd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bgWIlcq0jkjm2IQXT/BNQEqzpeYvTgFDnru4N6CtDaU=;
        b=f3oV0jwTjEU6PGM2thiuvcv899hddWQMt0/rLBGV1HfIAYPGVRT6rvsF7M2x6pMYJ+
         g/++zoQQJprHt4ynWaZaS7suBVL5WJjt2D59HI6gvWdhlzB7thVVQrgbj/6T12v73mH9
         XXpVTbrjWUIWhs4F783V2VoYDirDd0eBfDYEAsJoFR9SrkTR9kEQD4gJkDfVo9sbLTU8
         LjtNn0FVNLszt0UlbpuMrhetaorQySBP+skWDjuYntkEHsq8LdTRMU7o0YdIaw9AOnwO
         LjH+X7R35Ho7gWW/Rf+HsxRlI5Ab3LV6jp+fKgW1IT3GMKmxLkFej/B9IuTMWaVbYNyg
         2hFw==
X-Gm-Message-State: AOAM532s4NZbEfphAnXO7aCIoNkqO4CebqfepH6toxVaeA6LR5Iaxk0c
        IQEwY4JLHOpp4gZzuxPZb7jjGsM3im7vJg==
X-Google-Smtp-Source: ABdhPJywMKW4QvSjmTu9ip4MYLwF4c/pTATZxgy/+N2PDedQ5Q7D9Y5di/52OwFmB7glcXgGyvKSlA==
X-Received: by 2002:a5d:6e06:: with SMTP id h6mr4399909wrz.201.1619180972878;
        Fri, 23 Apr 2021 05:29:32 -0700 (PDT)
Received: from localhost.localdomain (84.red-88-11-91.dynamicip.rima-tde.net. [88.11.91.84])
        by smtp.googlemail.com with ESMTPSA id s64sm8008926wmf.2.2021.04.23.05.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 05:29:32 -0700 (PDT)
From:   Ian Mackinnon <imackinnon@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Ian Mackinnon <imackinnon@gmail.com>
Subject: [PATCH] Load Broadcom firmware for Dell Bluetooth device 413c:8197.
Date:   Fri, 23 Apr 2021 14:27:32 +0200
Message-Id: <20210423122732.30657-1-imackinnon@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Remove the btusb_table entry for 413c:8197 so the device is handled
by the later Dell vendor entry, which specifies patchram loading.
---
 drivers/bluetooth/btusb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5cbfbd948f6..2d24231f898 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -119,9 +119,6 @@ static const struct usb_device_id btusb_table[] = {
 	/* Canyon CN-BTU1 with HID interfaces */
 	{ USB_DEVICE(0x0c10, 0x0000) },
 
-	/* Broadcom BCM20702A0 */
-	{ USB_DEVICE(0x413c, 0x8197) },
-
 	/* Broadcom BCM20702B0 (Dynex/Insignia) */
 	{ USB_DEVICE(0x19ff, 0x0239), .driver_info = BTUSB_BCM_PATCHRAM },
 
-- 
2.25.1

