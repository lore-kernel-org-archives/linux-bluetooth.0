Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169DEC6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 21:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjCWVKd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 17:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjCWVK3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 17:10:29 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4411ADE0
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 14:10:28 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id s11-20020a170902a50b00b001a1f8fc0d2cso32304plq.15
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 14:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679605828;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3IPXOF71xhyJEtqQ3Z98VllJlolVRDwWUwDqo2jNXHo=;
        b=EhYvkoKvgCCbxOwjd6FuNdq1QrRIoJpWIF7cJLLZ9gASmnAaRc+cEHJaCpIAkfBfUg
         bL/I+y8T8nHmo6qbtvmbKbUsCqzj9JjBzg++8JYVM78eHpCxyl3oilRt/AnkhiAncn90
         IKEK+BWoX5XhAUB973cOyK7Jg9eku+sMNyWkrycSxQkg6o5ID2JM0YuLOybxk61aMjWy
         M+eFazc3nyJLiG9V//Kqckr/f+am+zrkTAsMgXJAA8+U8h2ZeyouKn18jsnA8LYw6T+9
         KSiO0GkQ+3CEqqnpdpnP8IqnkO650sTRlV/DS3G3/UVUwQwjag6wNhfkSwnWsIcw+CJb
         dM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679605828;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3IPXOF71xhyJEtqQ3Z98VllJlolVRDwWUwDqo2jNXHo=;
        b=bnrY4e9O6H3F5QqVpNT6ecdK2AMIG5JHXPq17wdfkLwWX+KYWDRYY/gLysjtIRUgcH
         vKBY6pyXaL7xTG1Ym9KQ+V5+ROJMjSDyNMESvvZcXMGUMVbN6JQ2N6DmW9ZhUhy7wa9d
         n+WS4vi3DfBKPyIG/Wnppn/foUD+T3MtsVusB8yYS6iEIQfcGCEWzYsXezcUYuFrPQIk
         X/Q3ZUZ2z0KzVSULnQAPqboI3M63+gpP3JXXZaieHqm6vk0hXIMrPo+9QbDxRsJi2331
         AtWgnza7Xn9IjgiXHUOM8JKBZQ3fS8jgeZCArwQOFQY/A40QGTpgIx/lx9OXbh9prxUP
         4KYQ==
X-Gm-Message-State: AO0yUKWqT5krsZBwLMaAW/ferC6ZqUqb49srMML92+gYvYWZTJ/rWO3+
        Z4z52rOaSoWsGlSi+a8fnPWoJ+1Eg1Wc7w==
X-Google-Smtp-Source: AK7set8+jv1JzR3p1mgIcB67lMvllj7a5DVGzCsJvMiKKf4L89EIKtT8Ml5k+po/ClBmv1Tb0DZy265BlbJ47w==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a65:5086:0:b0:503:7bbb:9a77 with SMTP id
 r6-20020a655086000000b005037bbb9a77mr2310504pgp.8.1679605828243; Thu, 23 Mar
 2023 14:10:28 -0700 (PDT)
Date:   Thu, 23 Mar 2023 14:10:17 -0700
In-Reply-To: <20230323140942.v8.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
Mime-Version: 1.0
References: <20230323140942.v8.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230323140942.v8.3.I8cd97c192e8268567b6f467ccd993ec71897318e@changeid>
Subject: [PATCH v8 3/4] Bluetooth: btusb: Add btusb devcoredump support
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
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

