Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD39EC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Aug 2021 13:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9578C608FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Aug 2021 13:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240272AbhHSOAJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Aug 2021 10:00:09 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:44078
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238560AbhHSOAI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Aug 2021 10:00:08 -0400
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id C4B4E411C5
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Aug 2021 13:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629381570;
        bh=a9ny+xZUCPsZrVKI8nflfzc/2KeNQowb9QjnWfTlKg4=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=Jzh1Cv16e4jQZTSrLtVvvBC4sDzrz42xppmUEDufKfXIh6SVSlt734ZO/nzuF5SYL
         bDgt2+3w7Fszp6vZfqUpBIw+4+xYIdxN+H0n60DrXKWUZUjt8M0CPcUAW9kKcsckVQ
         o4EJma+TloqJ2wsuX+Jli0iTgdjUqTw1CHMeZouufd7mElnvk+La8ZOyl1vkucI3w2
         QYLs3zFJcgAeSD9O93EewYB/Zq4yF3lIKkez6keaa4dkYX5tdS7LaGq4OUUJT4kzts
         rB2ahljKlWtiUnSvN2cLeerih6lxasVu60Ow5W+gxDO/h8UmxPHJQ7piNe+yygEn+F
         1KMCBqF034jTQ==
Received: by mail-pg1-f199.google.com with SMTP id q22-20020a63e956000000b002524787adb1so3484177pgj.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Aug 2021 06:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a9ny+xZUCPsZrVKI8nflfzc/2KeNQowb9QjnWfTlKg4=;
        b=F4adycCWPeU26HDY5lVOxTHbvwg2eZ7m2ivWtGy4ISbf89vemhH2S1bOA5lU5BIp96
         NYfFHHKlOwRVfl0bcBdFuzt8nQ/5wbbqZZi0EaPsbJxpNfFsj4pfgxghH1MAXKziVKQ+
         RPvGYPL3vl+70YTqsRVkJ0L0/5ypgtN2RgkfYO6M/9Ud9DCEy4qBXtWS0/l7TyZSGAXA
         rnNL1Gn0bqSlqUZ7DsCsVUmQxxJqtGLnDFYqT9m2QGtym/cr/qfuQDQ8KscPQ1OEJ8Xi
         UAlbKr20TzHH2hD365P75T1fuPfW264AHRlINFhDO2/f4T24IkCtRTsjzyG/0ew47gnu
         cDsQ==
X-Gm-Message-State: AOAM531LB1SduRbZTPHfgo6VmiU43WUn32ykcs3AYGl9dM+bjzUJ0oM1
        FurX4u25a4atkr1VEXRps00nCFg+Ud4Gnk8eTrEo0gZgecLWoIR3L6sfGE8Sj1BOSn9EKwXUq4E
        5F8L1lI/xr4AIQhHkosFgGRzPDTqmhzTJqc3YXrQNEQyBeQ==
X-Received: by 2002:a17:90b:240e:: with SMTP id nr14mr2711015pjb.170.1629381569261;
        Thu, 19 Aug 2021 06:59:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1I0V0a2X/mGlmKX1WllergnUm3sI0/t/EbLVGJ+aZPfoLFatszSaySp4oJ7weoz8f4yMU4w==
X-Received: by 2002:a17:90b:240e:: with SMTP id nr14mr2710980pjb.170.1629381568916;
        Thu, 19 Aug 2021 06:59:28 -0700 (PDT)
Received: from canonical.com (61-220-137-34.HINET-IP.hinet.net. [61.220.137.34])
        by smtp.gmail.com with ESMTPSA id g26sm4277522pgb.45.2021.08.19.06.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 06:59:28 -0700 (PDT)
From:   Koba Ko <koba.ko@canonical.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: add a reject table to disable msft
Date:   Thu, 19 Aug 2021 21:59:27 +0800
Message-Id: <20210819135927.49715-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

With Intel AC9560, follow this scenario and can't turn on bt since.
1. turn off BT
2. then suspend&resume multiple times
3. turn on BT

Get this error message after turn on bt.
[ 877.194032] Bluetooth: hci0: urb 0000000061b9a002 failed to resubmit (113)
[ 886.941327] Bluetooth: hci0: Failed to read MSFT supported features (-110)

Remove msft from compilation would be helpful.
Turn off msft would be also helpful.

As per Intel's comment, For AC9560, in JSL the hw_variant is 0x13.
In GLK, the hw_variant is 0x11. can't use hw_variant to filter for
AC9560.
Only AC9560 encounter this issue, so add a reject table to
disable msft for AC9560.

Signed-off-by: Koba Ko <koba.ko@canonical.com>
---
 drivers/bluetooth/btusb.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a9855a2dd561..3c131fd40869 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -479,6 +479,11 @@ static const struct usb_device_id blacklist_table[] = {
 	{ }	/* Terminating entry */
 };
 
+static const struct usb_device_id msft_rej_table[] = {
+	{ USB_DEVICE(0x8087, 0x0aaa) },
+	{ }	/* Terminating entry */
+};
+
 /* The Bluetooth USB module build into some devices needs to be reset on resume,
  * this is a problem with the platform (likely shutting off all power) not with
  * the module itself. So we use a DMI list to match known broken platforms.
@@ -2851,6 +2856,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	char ddcname[64];
 	int err;
 	struct intel_debug_features features;
+	struct usb_device_id *match;
 
 	BT_DBG("%s", hdev->name);
 
@@ -2928,7 +2934,9 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	case 0x12:	/* ThP */
 	case 0x13:	/* HrP */
 	case 0x14:	/* CcP */
-		hci_set_msft_opcode(hdev, 0xFC1E);
+		match = usb_match_id(data->intf, msft_rej_table);
+		if (!match)
+			hci_set_msft_opcode(hdev, 0xFC1E);
 		break;
 	}
 
-- 
2.25.1

