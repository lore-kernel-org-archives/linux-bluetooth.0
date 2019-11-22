Return-Path: <SRS0=qr/Y=ZO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B41DC432C3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Nov 2019 10:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FF120707
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Nov 2019 10:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODHxiLqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfKVKEz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:04:55 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40394 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfKVKEy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Nov 2019 05:04:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id y5so6871451wmi.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2019 02:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vZt1WPz+SaUcwPa3RcXKfLnJLiyL1oyrxTwENW47IsY=;
        b=ODHxiLqq//FIvwSCt7ejwT1Ou8V3lfF03vAEQPfWy0mw1W+kfIu2YbvAYumZQ+GBFI
         /y2HNvXNSf01+xd65txpWTWdboPxkX0ZG7svTxwWCViQz0t9G61BeNLV9NgD8W376HKc
         LNGVCAt+isqZ6nrMBWdgNG5X4qYlhBCG75IOvkN1GcFxXPMKzyyVsf9lPDiOvF6erPAi
         zaqSgf/R/xYLYLBOodmuYdHavZID8rW1ZorzQjZXKUelSyj/4UFi6zHvOnQC2ua/eNlK
         zijCgXTXfbrc4rUyBRxiChs7Uar5oIfREZj1GsGlx7YvfSMnYH7UXl7pKR+5S19BhFI9
         fwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vZt1WPz+SaUcwPa3RcXKfLnJLiyL1oyrxTwENW47IsY=;
        b=TMcsQopjHCXKU23XEjlVvQJGs2/t8Q3I5J4py1DkKkInXb0LBlBlXItzCLhA039SvF
         hOGGm249A6oaHGbX3l4XOcki7FSEzJzZOmHNxAS9ruPDLeemjWP3Gemnyj84kKUDIDT1
         vPxy/O2ywgRkv6+x+4mFQPfwjJSiua8Q91nxlJEG4UDUYXOvj5B9RHoJi1haLYYIi5+e
         QLKfH/TaGgMbe41GR/rJcFxA6SUQF3/AqdbZH9PSAuhWPYmV2caLHQWd4C/taPV/CZ5b
         nViihbHV/DUTAZ6qWwx6k5YNHxbh1rwzxoDzB/JIg/QS0789lMjS9ApbnhYMiTo/J7Q2
         mAbQ==
X-Gm-Message-State: APjAAAVB59jrXHB+l0mneMc6SVnOllkAVa96dip2VPyyM6lqXST1VZ6f
        vIOrgKoESYX5IOd9IFW+KZw=
X-Google-Smtp-Source: APXvYqypHeSVOwwoVd8jh4HDUwfh5JIOVmPwpT8ZsFTP93s0KH6ovL6eNhre0Wfe9hZvk3dLIKZilg==
X-Received: by 2002:a1c:b1c3:: with SMTP id a186mr15800320wmf.10.1574417092462;
        Fri, 22 Nov 2019 02:04:52 -0800 (PST)
Received: from mamamia.internal (a89-183-130-53.net-htp.de. [89.183.130.53])
        by smtp.gmail.com with ESMTPSA id q5sm2846826wmc.27.2019.11.22.02.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 02:04:51 -0800 (PST)
From:   Andre Heider <a.heider@gmail.com>
To:     Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH v3] bluetooth: bcm: Use the BDADDR_PROPERTY quirk for Orange Pi 3
Date:   Fri, 22 Nov 2019 11:04:49 +0100
Message-Id: <20191122100449.1994340-1-a.heider@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some devices ship with the controller default address, like the
Orange Pi 3 (BCM4345C5).

Allow the bootloader to set a valid address through the device tree.

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 drivers/bluetooth/btbcm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 2d2e6d862068..e20e7da45377 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -8,6 +8,7 @@
 
 #include <linux/module.h>
 #include <linux/firmware.h>
+#include <linux/of.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -440,6 +441,12 @@ int btbcm_finalize(struct hci_dev *hdev)
 
 	set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 
+	/* Some devices ship with the controller default address.
+	 * Allow the bootloader to set a valid address through the device tree.
+	 */
+	if (of_machine_is_compatible("xunlong,orangepi-3"))
+		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(btbcm_finalize);
-- 
2.24.0

