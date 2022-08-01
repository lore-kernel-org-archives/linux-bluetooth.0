Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDCEC00144
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Aug 2022 22:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbiHAWVV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Aug 2022 18:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbiHAWVR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Aug 2022 18:21:17 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4D130565
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 15:21:16 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id q22so3586343plr.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Aug 2022 15:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SaUYLzBNL8ysLF5DpFSvdwrHS8jwzSZy/cq88W7EcZI=;
        b=Rb+HJDRUkGuQunbOwhQqLjnIe9b34p/uoUW1mwYhuRRf79p5DhmI4jOLhWAcyY11Tt
         +LjnfRBwXWWg2Es0kmB3PKcnGUCdh+Rwj2LAbK6nx/DcEdzOINQJjgMZ+MYApiGE1W6J
         6osyHooAVfp+AR4clWbEF+u4twaYHDHR6S5QVfPlVl9qFHjo74nHZWzHiM0SwHYJT0dm
         6uZ4BhzPcpg2TXi+ZkzdKFwe2ekmOWEncucK4oSFKfGIit+YymioshrjgDIAzRI3AsF3
         h4Z7LZPx4PFmOSLUDzvFhq9SHdCS+Fv3lFX7j0HH2nZALgZNmAGUXp72OzAsbIwEPIWx
         OArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SaUYLzBNL8ysLF5DpFSvdwrHS8jwzSZy/cq88W7EcZI=;
        b=mcDRc+gXuP6Jpoqsa0yWWVPrP6MB7fLcsM3PGd/udarAbQ0GmLc+3QYrwPQthYWZZA
         zYRzhQodj9yaQotVoTDX2XDz4GAwgJabdGuOy3hESefYqtBD+KMwV6oUJiW9F88PP+So
         GSxx0XUwCDTEGGoqPX8uyKAwzHfQiMeVm/HUYBhr96yHWr5/goGbz1f4urDT7Mj5zmUL
         b9krNrWtMOV8H6vXxxmXWrUfZA0Daw3zC7Auv6Vn59nDqjNq24jgnGp5YjwOWyQR4u8Z
         a5ehmu8Zvodq5TbuvMPvyhTvYkOk0vp1c/7knSFxalzyHQyCh4W9kOKX97p7/Lp8PrBG
         vgOA==
X-Gm-Message-State: ACgBeo1ZgX4iLmDSll360DZiIrKUrL9vZcxRfBhKFYPbipVWQGjgvjuk
        qTXRJxvCx7HLJaNen/YF5YigbpLuvsUhKA==
X-Google-Smtp-Source: AA6agR4BcDJy/F8p5oWqQsOdt9K2/UBk2hvnICXVCw5goijJIpJfTJcy4dkSx9pZ0M41QRlos4y4fw==
X-Received: by 2002:a17:902:8f92:b0:16c:e485:7cd2 with SMTP id z18-20020a1709028f9200b0016ce4857cd2mr18993901plo.50.1659392475454;
        Mon, 01 Aug 2022 15:21:15 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id bg1-20020a056a02010100b00419a6f3c8f5sm7879263pgb.19.2022.08.01.15.21.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 15:21:14 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] device: Fix not auto-connecting profile
Date:   Mon,  1 Aug 2022 15:21:13 -0700
Message-Id: <20220801222113.2269509-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the profile is registered and marked to auto-connect it shall
automatically be connected whenever a device is already connected.

Fixes: https://github.com/bluez/bluez/issues/370
---
 src/device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 9a4f2ce45..775003796 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4574,7 +4574,8 @@ void device_probe_profile(gpointer a, gpointer b)
 
 	device->services = g_slist_append(device->services, service);
 
-	if (!profile->auto_connect || !device->general_connect)
+	if (!profile->auto_connect || (!btd_device_is_connected(device) &&
+					!device->general_connect))
 		return;
 
 	device->pending = g_slist_append(device->pending, service);
-- 
2.37.1

