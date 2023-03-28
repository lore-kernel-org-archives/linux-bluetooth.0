Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C2DC77B6D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Mar 2023 16:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbjC1Qam (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Mar 2023 12:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbjC1Qa3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Mar 2023 12:30:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ADCB446
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 09:30:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 8-20020a250508000000b00b7c653a0a4aso4605742ybf.23
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 09:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680021028;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3IPXOF71xhyJEtqQ3Z98VllJlolVRDwWUwDqo2jNXHo=;
        b=iHSKdWsbQy/GeVzBB8qj+guo53lEw4PtllPBGrE0VU/M2dkD23/QOZGGuR0wKM1woY
         xoRId10Gu9qAKC5ovRdE30LmAdcD4GA4VgwOvURL5CKioWDBdCPVcAgPqKSm/GnRBLC6
         Wr1asA9XzPKSlnb3CkPAvOeE1DSAsxamg7910KDePodfi8AFZRY98KL1TEJ0DhKqnY9i
         Ff4neDE62XKXPZQYmz8aDY8qlxjyhhLp9tWIv3nrlugxV+bmhh+Xng2r74fru7LZ/LPQ
         jsNBwK15z+3dffzyJ4LfvNokbOI11Gq4phqSvLhgy0v7wXktgPHVTH0LyaUBlCRQ1y46
         hZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680021028;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3IPXOF71xhyJEtqQ3Z98VllJlolVRDwWUwDqo2jNXHo=;
        b=8Id0m1Xjk9tj5AYtqlc0Ov9zcSbQG6kDTdcfYnQU6PBC7fbEbhWogI4JuuUn9pDi1P
         aiPwQ/3EmX04RqYjRxoW2+jCI0v8EhY8l35fr4ZHvD8fu9jbbBgkfm/LdxuGThpeusYz
         MJ+Qr3KDjXsC+VOg45so9D0GH3SjAPkN4Fp22WeiilBro2bplEEfOWzDjmyyC/BEc+xG
         Kpwn56t/cn6Efz51SM0PGGFVDySEls/qGNNWFbujDDGlephyb33IyuW+WhuztMJSRXPE
         fabNKOiAR++2Y/C8K4MObraJ6m8kLQRaxV6La8rMp5EQfr3W0kVcGf43gjGH33TCiHnQ
         55Og==
X-Gm-Message-State: AAQBX9eXZ0tzWJk5VgcRYZsWFx1os9LnfzW4ydy4a5MbuDhaHC1jLtGH
        fFt9kPpXQdpnEn1MdyDG5gMHFEUV1tiXkA==
X-Google-Smtp-Source: AKy350Y+wvZPoh9LYygwBjPZLYtS2gxTdz4mEbJFt4wl+JyIyElkUuBFLZepi30FgdKKeHfY3LJ+7SitnobFzw==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a05:6902:154e:b0:b77:d2db:5f8f with SMTP
 id r14-20020a056902154e00b00b77d2db5f8fmr10015853ybu.12.1680021027873; Tue,
 28 Mar 2023 09:30:27 -0700 (PDT)
Date:   Tue, 28 Mar 2023 09:30:18 -0700
In-Reply-To: <20230328093000.v10.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
Mime-Version: 1.0
References: <20230328093000.v10.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328093000.v10.3.I8cd97c192e8268567b6f467ccd993ec71897318e@changeid>
Subject: [PATCH v10 3/4] Bluetooth: btusb: Add btusb devcoredump support
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

