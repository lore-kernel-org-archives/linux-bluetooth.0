Return-Path: <SRS0=xgU7=QE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DEAC282CD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jan 2019 23:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAA52171F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jan 2019 23:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KCCKGmF8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfA1XIQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:08:16 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:45092 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfA1XIP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Jan 2019 18:08:15 -0500
Received: by mail-vk1-f202.google.com with SMTP id g87so4927157vkc.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jan 2019 15:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lwKhytqdSAhh74l4TzMqfP4Or8eaBXB950S9OHzkc0s=;
        b=KCCKGmF8aO7ZSI8NwYcn68SMn1tmPlJkMkdkOmWBhHRNYZPohEgcBIyA1Ib/i0UtGA
         kJFFzZ2yPtngF/uDbUqhe3yo/lbWag9LCDv2kt0m57hBlFM5pgLcOnQJkmnoRm4PgC+N
         oO5Z0a/B077bI9jMIymGA9jQw6D59l0cAKMJ0He9a51yKs8EUZg7RMdLLw+enCKEwMx8
         AQWKF3teFej6UyNRa39cJSrC3SERXSjvmVabXg18u0KErJ0A/zuIkUkn7cTOdbIRKOBY
         kSI+LtRm/tuakDLpy4yMPZK3gcnV/m74QhoR3rH4BM5AMPCgy10+l5ZC12wIn4KCdqCg
         0I0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lwKhytqdSAhh74l4TzMqfP4Or8eaBXB950S9OHzkc0s=;
        b=TaR00KiVZ9JEffNXXNv1HZ5wPHUDUJ/CqvUxMswD6m052Q3EIP8wyVqF76ctpFUXO6
         Qaw6xSBAOwFdZWbAz6Fa6ixRCYN2S4yjAuwRLM9ZuGDwHaYugAR18tYV5fIKpRDywVBg
         ijq0VHJjyYTzEe6gpVHliV+zif4ELFmQ6A2697IyszXr+sw0bOFzUaM9eu+sZrpCh3Fm
         ppgsJG1+l4jrucTWTKdPrzaCpSX38HLN1sgf8OvHEXA0Yz8CAvT8gKM+pMHI9PezgJWd
         ppw4+7YVhMcyO464fD/ayb8uyUb4bbQ3yPOSbsDNg7hJrsYvyqQzoArwKp9uwbMa+ArD
         VCAQ==
X-Gm-Message-State: AHQUAuarPJiQR2ZVjed4U5sD1sS6MDTWNu+OypKvoMGW9Wn3E389jqgB
        1fli5oBEOAoo7cHzlFw3J5hSlq2U9B3N
X-Google-Smtp-Source: AHgI3IYrVnxXbITkrAWnuXvYSKadMyXvPdeg32TMythagkg21o1nAScxOJdOPiSz+SKi5tYZk+YXbamHcF1w
X-Received: by 2002:a67:410b:: with SMTP id o11mr1308840vsa.8.1548716894717;
 Mon, 28 Jan 2019 15:08:14 -0800 (PST)
Date:   Mon, 28 Jan 2019 15:08:09 -0800
Message-Id: <20190128230809.173975-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
Subject: [PATCH] Bluetooth: btusb: btusb_intel_cmd_timeout: use sleeping functions
From:   Rajat Jain <rajatja@google.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rajatxjain@gmail.com, dtor@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The btusb_intel_cmd_timeout() is called from workqueue contexts,
so use the helper functions that can sleep.

Signed-off-by: Rajat Jain <rajatja@google.com>

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5de0c2e59b97..9a890b2a7ee1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -523,9 +523,9 @@ static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
 	}
 
 	bt_dev_err(hdev, "Initiating HW reset via gpio");
-	gpiod_set_value(reset_gpio, 1);
-	mdelay(100);
-	gpiod_set_value(reset_gpio, 0);
+	gpiod_set_value_cansleep(reset_gpio, 1);
+	msleep(100);
+	gpiod_set_value_cansleep(reset_gpio, 0);
 }
 
 static inline void btusb_free_frags(struct btusb_data *data)
-- 
2.20.1.495.gaa96b0ce6b-goog

