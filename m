Return-Path: <SRS0=JVds=Q5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F120C43381
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Feb 2019 00:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7912083E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Feb 2019 00:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CZMR79TE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfBVAeL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Feb 2019 19:34:11 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37658 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfBVAeL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Feb 2019 19:34:11 -0500
Received: by mail-pl1-f196.google.com with SMTP id q3so242387pll.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Feb 2019 16:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zY2jb25QAq1g/TE6DFipzC1VS/FPvRjbhYIqEGjdavA=;
        b=CZMR79TEp6okgbitRKUrx/zE6k1bvOTpS/MJdf4JgULsf7t8svMY7HCb5syEO4GOEw
         B/zo7Iztup8iB5CN2rh/IeFUIjF94xXCHiJVPZ7+6sLxqxhqVkbWUE/bEz6fM2aU+ZSv
         UuOkwX3OYX5UmrWRhNAdIBt1Zuq2nko3J0gts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zY2jb25QAq1g/TE6DFipzC1VS/FPvRjbhYIqEGjdavA=;
        b=JreeSNO4yuufo6c49cFt/j1WDVCtphekhdMJz4+ZeVw36W2WwJ8UHKPsKiXoLnCODU
         2+1mW22wlCEPEBfiEtPAnNQnhjzVESHd+fmc3WK2+QpJmbYFAjJ6hiiY+VyBhlB3+o29
         NDgWHvVCP1lGbROmgnfuvTfGqnDS41xx4zL7qFW2lpsIDny2AdU1uAOH75zCFKx6/Vbj
         p+vTIBZd3/7nUDVQdwTwHIkPOfl6xigk0YOv/aXTrENdSKo4yDt9woZute/kbCvfZoVi
         nd1oUjVs4VAFwl4VA2+hQoZrTO7OXSKcNrVVIa37f0RY75bQwteQ+3hcKbHmmr+itx2P
         CX2A==
X-Gm-Message-State: AHQUAuZuxsYPP9rvcJOXaIBmOpzsPxiD4ucWGvXy0Xup8jDC3lSCLB4U
        3FvfwvaG6iOPJMcBaqW90CXh3g==
X-Google-Smtp-Source: AHgI3Ib0CD3XpdWcv9QpJUjgdjW+aFVX0c54CH4gaJNQ02kxILdUJXAW0fFC8DTGWsMsGfuPCO2ylg==
X-Received: by 2002:a17:902:33c1:: with SMTP id b59mr1345131plc.220.1550795650564;
        Thu, 21 Feb 2019 16:34:10 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id c3sm269830pfg.53.2019.02.21.16.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 16:34:09 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 1/3] Bluetooth: btusb: add QCA6174A compatible properties
Date:   Thu, 21 Feb 2019 16:34:01 -0800
Message-Id: <20190222003403.128243-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

We may need to specify a GPIO wake pin for this device, so add a
compatible property for it.

There are at least to USB PID/VID variations of this chip: one with a
Lite-On ID and one with an Atheros ID.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 470ee68555d9..380e6f38c607 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2862,6 +2862,8 @@ static irqreturn_t btusb_oob_wake_handler(int irq, void *priv)
 
 static const struct of_device_id btusb_match_table[] = {
 	{ .compatible = "usb1286,204e" },
+	{ .compatible = "usb0cf3,e300" }, /* QCA6174A */
+	{ .compatible = "usb04ca,301a" }, /* QCA6174A (Lite-On) */
 	{ }
 };
 MODULE_DEVICE_TABLE(of, btusb_match_table);
-- 
2.21.0.rc0.258.g878e2cd30e-goog

