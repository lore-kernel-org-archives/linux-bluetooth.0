Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5751C77B61
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Mar 2023 16:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjC1Qmv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Mar 2023 12:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjC1Qms (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Mar 2023 12:42:48 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152043C1D
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 09:42:47 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536cb268ab8so126654757b3.17
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 09:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680021766;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3IPXOF71xhyJEtqQ3Z98VllJlolVRDwWUwDqo2jNXHo=;
        b=akG81if4jTiA5YzyK2S4GHzKQoAhTTq+47u+UaQ/VHIofm3zkprIOu6B7rYPy0tSyl
         UGUGltoHlgfE+76EaGusuobGe+lom/TQ52hOMw/twnoJxK9R3Yk/6h0k5KShhzn3To8f
         gYW0DhK35mOjv7aS7au1ZBOmUGhsI6ryXgzUQYQSSm2PKV33DE23sYJc2rioXGa0MsUY
         f/EJgHP565/cUHbq1M1UoGXALU239pGH/qxEiGJK7Z/1A+/+hbZwROBWpoYZqp3UBI9A
         T7Drp3G2KX0M/LyhaAJvdq2xc5i4v2uGrjOj3YHmEBie7OApXYb1qHy/IfIxxHduKF8+
         EmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680021766;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3IPXOF71xhyJEtqQ3Z98VllJlolVRDwWUwDqo2jNXHo=;
        b=nATuSCqOcgupJmPJPk6+sQFiEHxTMKokrJ1716azQgmfWfgTdb07Gza2fLhqGUkdPp
         yglj+qnIRTk1zuIVT56nxcHP0xsuRclguYZSTpDNvL6RCgZs5PL9FIqocX3Qb8MQ++cf
         gGbdQQpOPX2S4fk7JNfhNQsjMRgZ9Kne1pVjaxMHS7KneLZHVuW25SkXP4Zrj6Lw5JML
         /XkpmPrpDmiiwbr6C2j+emdckeIDyMHoVKYiY2+OGMojpADgpecQqBHUM1oAmjKx8jCC
         A87e1GpJr3oHjF6R6qHlhT0tHnREIVfBElcM3K7jVbTEktfTHbaJfJHW4YV4vHOpwA/N
         qvuw==
X-Gm-Message-State: AAQBX9edf9aC68WHh0etT7j6dD6oddAhcZgj452zWs6MJUxIhhPNfRT6
        AF5yYPQOgZvDN42UXhjNT2r+QgQTLmtpPw==
X-Google-Smtp-Source: AKy350bR6rJxmGAjFwURfQiBKLRMeY2B+66CwIhzIMLLr9+9B8WExIll1C/vuZ6mOLKs6yawoneAG/tQ3CHasw==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a81:ac46:0:b0:533:9185:fc2c with SMTP id
 z6-20020a81ac46000000b005339185fc2cmr7783218ywj.7.1680021766358; Tue, 28 Mar
 2023 09:42:46 -0700 (PDT)
Date:   Tue, 28 Mar 2023 09:42:39 -0700
In-Reply-To: <20230328094207.v11.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
Mime-Version: 1.0
References: <20230328094207.v11.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328094207.v11.3.I8cd97c192e8268567b6f467ccd993ec71897318e@changeid>
Subject: [PATCH v11 3/4] Bluetooth: btusb: Add btusb devcoredump support
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

