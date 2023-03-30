Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC015C77B6D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Mar 2023 06:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjC3GFf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Mar 2023 02:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjC3GFd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Mar 2023 02:05:33 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EB61BD6
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Mar 2023 23:05:32 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54574d6204aso177543587b3.15
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Mar 2023 23:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680156331;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3IPXOF71xhyJEtqQ3Z98VllJlolVRDwWUwDqo2jNXHo=;
        b=T2Xd/vq4QTC43NzxMiqSqBA8msNyNnHwNo6UYCR6DdjwKSdN7puBZQbpLOgxQylu5B
         6MryFowxU9/CeP3PrNz+SadXmpimku7vRJFPmIOAC8YNblPOJSp8D77HXjV0tpgVLiVI
         4N9IJgrdUVI0eYrleZN00+XjcsyauZiCpIOvxba7pJHKJ8UIiMTqNEqYHHJdJlrU36Jf
         1UHQ85XZwKvyo5W1l8U1Y/vTNdvQ4/1V3Kab1d5t33t/oC2QF85nUUxF5svdiLJGLxAU
         Nm64To0CMn9CYygJZW+ulUToZlW0X1dmq9+XUIH++wvAE4gbShgrsYTjPbJkv00R6QjC
         SBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680156331;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3IPXOF71xhyJEtqQ3Z98VllJlolVRDwWUwDqo2jNXHo=;
        b=srU9lTfCdOXeNdZxpfvaBjx73ApBASZ13yUEgOzTX64RDA6QCkmz9k/7U3QKoISp8o
         W7JdL/r1GPffq1XGx0iPBCchqd0rHkeiqs7TbPAsM8tqjkDYAaiiOZpGhQzW9BLmZPx8
         8V+Dyj7esCosrrh8SNcEJuCPKrvEcJtJr5wqJ3M4Gi+RWxiBWkI3X0q9Vyh30ueeXjxv
         OgpqH7usaEekTfgk1y2tyNY0k63eG+gn+lfm9zGTm/loXKkmhfOVKB/ywUkVPds/2aVd
         J40S3yO4PBwTHIJOzx5KyshY59gfO6oItgMEWcwGNx4J0Jbs3p9pSqLkY0pBSy4Zh0y+
         pmKA==
X-Gm-Message-State: AAQBX9fzmZCnd4/B4Uxs2behZ5rmN5jlesOZvg5zjXrZvuC5FPOKuoxK
        woTrk88DEPCGCNYQerM+FzS3ldXLrhWA9g==
X-Google-Smtp-Source: AKy350Ymcg4w/g2wSAcLxooGhAl1H3npi/oStK8CaFgkf+a/KCg3Ivngm5jyRNcMN8ZTdNEfsgXG2vqkJDuU+Q==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a25:e08a:0:b0:b72:fff0:2f7f with SMTP id
 x132-20020a25e08a000000b00b72fff02f7fmr3211068ybg.4.1680156331464; Wed, 29
 Mar 2023 23:05:31 -0700 (PDT)
Date:   Wed, 29 Mar 2023 23:05:22 -0700
In-Reply-To: <20230329230447.v12.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
Mime-Version: 1.0
References: <20230329230447.v12.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230329230447.v12.3.I8cd97c192e8268567b6f467ccd993ec71897318e@changeid>
Subject: [PATCH v12 3/4] Bluetooth: btusb: Add btusb devcoredump support
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch implements the btusb driver side .coredump() callback to
trigger a devcoredump via sysfs.

Signed-off-by: Manish Mandlik <mmandlik@google.com>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

(no changes since v6)

Changes in v6:
- Remove dev->coredump_disabled check since the sysfs flag related
  change has been abandoned

Changes in v4:
- New patch in the series

 drivers/bluetooth/btusb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4ca91c033d2f..9c9f7bf1375a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4385,6 +4385,17 @@ static int btusb_resume(struct usb_interface *intf)
 }
 #endif
 
+#ifdef CONFIG_DEV_COREDUMP
+static void btusb_coredump(struct device *dev)
+{
+	struct btusb_data *data = dev_get_drvdata(dev);
+	struct hci_dev *hdev = data->hdev;
+
+	if (hdev->dump.coredump)
+		hdev->dump.coredump(hdev);
+}
+#endif
+
 static struct usb_driver btusb_driver = {
 	.name		= "btusb",
 	.probe		= btusb_probe,
@@ -4396,6 +4407,14 @@ static struct usb_driver btusb_driver = {
 	.id_table	= btusb_table,
 	.supports_autosuspend = 1,
 	.disable_hub_initiated_lpm = 1,
+
+#ifdef CONFIG_DEV_COREDUMP
+	.drvwrap = {
+		.driver = {
+			.coredump = btusb_coredump,
+		},
+	},
+#endif
 };
 
 module_usb_driver(btusb_driver);
-- 
2.40.0.348.gf938b09366-goog

