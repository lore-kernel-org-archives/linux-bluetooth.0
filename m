Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAC2C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 14:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5C1460F01
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 14:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbhHDOhG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 10:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbhHDOhG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 10:37:06 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E500C0613D5
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Aug 2021 07:36:53 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id n16so3106855oij.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Aug 2021 07:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OL7+UiD0tX9hYUNDk0fnZgJ5frMEZzA7M7wcisrFFFg=;
        b=UvbY2RPROwdN4L5LZOtyFVogIuBkmq9OUYBvBqWwE0ZHb7PzWEdtUmqyDXwmX5JdDL
         weXSI3L4kegIwSXmdmiappDiLCX4xrOQ1oJmUFM37ggCSyYsMlxlyriPFMOEbRU/7GR9
         AYmJlJUNhZXWhO8izFEDt91QoM72nrfAYcCvzx6hr0sfQkdEGZoryx4WwbZ/mC20NOO6
         cLDmaWF60fj9xi+lgoTvIVNHizNVJ0rPZoV0zgnVvF12c6Lu6F+IE30ws8YWWspZExQM
         weOuqse/XcTu/Creb4czkT7N2i2o1LQDL1KwE+CyvsNOWv4tGL2kdC3d/zqYvWOC+0gw
         c9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=OL7+UiD0tX9hYUNDk0fnZgJ5frMEZzA7M7wcisrFFFg=;
        b=rKdyS6BR3es5V4YVOKSRIMLFvMg8YE6RO7j4wG/ZBrM+tfSxorm/MpaxH7/Ik1mrqz
         Epp+QEJbnBk+3dI0xojKw7ejr/acWuGV5qCYXYZlSluHJxr1b1uu2Ojn6NgiGAciC56g
         CTqMX/a0/JSAjEpnuxRvx8mG5cRQ+UP4EDH//2STZ7OoHQAYvrdUXK2pVzkTCawqxhWp
         KpDABZz8SawI9xHkWMfsH7TXvpeAsMcCJKeIzkmIUYllyuaY/nN78YFzqN8q3KcpLRcO
         NFjQ296pJOjw7/6yRUWqFGqMJ0sgGH/6uoGykNJ4jcpjjeY918bwWOekYHcLVeNbNj26
         Ui/w==
X-Gm-Message-State: AOAM531Z98R55+QLcLMpVIoJR6vGLBHVI9Lv0idCQ0TGLefhZaTNpfoh
        4RpEPsop+nSO7qId/4YzlmOTyuvCL00=
X-Google-Smtp-Source: ABdhPJxICmbpiZyLyv6/Uj2VKr3ChrJlVIys2r2Zxz1Ya/tgL+PFQqc5GBDYzaNPl68TQ0kfCVJOFA==
X-Received: by 2002:a05:6808:6c5:: with SMTP id m5mr18698357oih.9.1628087812480;
        Wed, 04 Aug 2021 07:36:52 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id bg9sm478750oib.26.2021.08.04.07.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 07:36:52 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, Hilda Wu <hildawu@realtek.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH] bluetooth: Add Bluetooth part of Realtek 8852AE
Date:   Wed,  4 Aug 2021 09:36:41 -0500
Message-Id: <20210804143641.23913-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This Realtek device has both wifi and BT components. The latter reports
a USB ID of 04ca:4006, which is not in the table.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/bluetooth/btusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a9855a2dd561..2a3f953172f3 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -452,6 +452,10 @@ static const struct usb_device_id blacklist_table[] = {
 	/* Additional Realtek 8822CE Bluetooth devices */
 	{ USB_DEVICE(0x04ca, 0x4005), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	/* Bluetooth component of Realtek 8852AE device */
+	{ USB_DEVICE(0x04ca, 0x4006), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+
 	{ USB_DEVICE(0x04c5, 0x161f), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0b05, 0x18ef), .driver_info = BTUSB_REALTEK |
-- 
2.32.0

