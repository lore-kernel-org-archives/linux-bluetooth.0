Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001BDC4338F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jul 2021 00:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2C6360725
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jul 2021 00:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbhGWXhH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jul 2021 19:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbhGWXhG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jul 2021 19:37:06 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9341CC061757
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jul 2021 17:17:39 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id k7-20020ad453c70000b02902f36ca6afdcso2873838qvv.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jul 2021 17:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HOlFjIupBaRC8Gj2HRr1sX5wQQLAab9xCES8dhta9ys=;
        b=ILx4pqCqbGkzhWIJTLtu9nC1m+It4WUw0yZM1Q3U2n7JCxtIkWzPzay+m+X2RL7tLL
         J43O8vOtq3f9YScoL53U0MNLyYvG9logrmR1gkRtiMzm3fF9a2MS76njxQjHiufgSfhS
         9PoM70rrHjJQ/AN9bC3OXw1E1roXQOWEayQBornKkrCpw8HPrBf7u5308KE9UYa/js9L
         tnTlhGUYOoLnW/bwjfi8xAzydX5n+psmkKUmG6y+0CtZbYGVqnZ+SQBCKS5La9aVd3WZ
         Cswd3cO9DNbgszs/u/NiWPlAU6RLmO+5SiJ6Fh3ecGmFhlQzx3G8rc+dyzQ49az0QeAm
         GgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HOlFjIupBaRC8Gj2HRr1sX5wQQLAab9xCES8dhta9ys=;
        b=gbbwHKwsWZCBhdxDZaobkoxA6PIYz65KmHvxCK58pKlVZ8ZPWJggJqELLNosUMwSMR
         UsCEK/Wyy89VCtIivN0geLkWFjl97ZSKNhiw53m/LvFMrXvklUeiGEWLdE6jI5R4iT59
         SFKFmXH5Y/ieEyQ3a+p0VCqcuSEiNUcch3MEyzuCdc4L44UVaA8/CWi8ooKRyrNvM/B+
         usPuKtuMCf6SpaCQ7zv8fwpg9jhZFIinA5yjw4mpzJ+siRFiHxDkjpiKdJlwxkQ7SypM
         EVFkTLOfu1d50GLMRVeGD84v9TR4HslJxkzm09wHQ7C4fWjCR8acscPWWl3/zLY+Sav/
         P5Nw==
X-Gm-Message-State: AOAM5324Eu0tnoR76Q6B2tEMjTwEF4VgolaMOQl1mcf97delRWo/7tJj
        z/XO6t6a6LUJcoCIA6ZlHbFvA4n5HRLnHvBy0hxh1KJq3r8xtqLxOBGYaa50yJWb52AWldqu34u
        vgZKDR6Y8wdJygUPD+ZEQs5yUBDqT/93xZyroy7VyO6UnhEAYdVa0pqvD1pkxcOX4jBoX4xOROU
        NUqZC0BvsGCHE=
X-Google-Smtp-Source: ABdhPJxXDydiKx4ZebBCkBSRRlKUeS0PpaZROv9k4Ocf+GWRrYX4ALpcUwlhCr6StwlF9ZqKEldZImucfpWS8KP+mA==
X-Received: from michaelfsun.mtv.corp.google.com ([2620:15c:202:201:153b:286b:8047:586b])
 (user=michaelfsun job=sendgmr) by 2002:a05:6214:cac:: with SMTP id
 s12mr7031703qvs.29.1627085858563; Fri, 23 Jul 2021 17:17:38 -0700 (PDT)
Date:   Fri, 23 Jul 2021 17:17:31 -0700
Message-Id: <20210723171729.1.I98b1da8cdd72c1f355366f623cb34ddfc0fe40ae@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH] Bluetooth: btusb: Add valid le states quirk
From:   Michael Sun <michaelfsun@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Michael Sun <michaelfsun@google.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add the valid le states quirk for WCN6855 and GarfieldPeak controller
so the 'central-peripheral' role is exposed in userspace.

Signed-off-by: Michael Sun <michaelfsun@google.com>
---

 drivers/bluetooth/btusb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7b69a97bd0e9..1876a960b3dc 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -297,7 +297,8 @@ static const struct usb_device_id blacklist_table[] = {
 
 	/* QCA WCN6855 chipset */
 	{ USB_DEVICE(0x0cf3, 0xe600), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH },
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 
 	/* Broadcom BCM2035 */
 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
@@ -371,7 +372,8 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x8087, 0x0032), .driver_info = BTUSB_INTEL_NEWGEN |
 						     BTUSB_WIDEBAND_SPEECH},
 	{ USB_DEVICE(0x8087, 0x0033), .driver_info = BTUSB_INTEL_NEWGEN |
-						     BTUSB_WIDEBAND_SPEECH},
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL },
 	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL },
-- 
2.32.0.432.gabb21c7263-goog

