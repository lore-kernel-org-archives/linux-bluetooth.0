Return-Path: <SRS0=rxlX=4P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E61C11D3D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Feb 2020 18:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA8420726
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Feb 2020 18:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hnDL3MkY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbgB0SaO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:30:14 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41515 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729258AbgB0SaN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Feb 2020 13:30:13 -0500
Received: by mail-vs1-f68.google.com with SMTP id k188so266997vsc.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2020 10:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4K6fKAA2/aD8JgveCrJlSP+eb307VQ5m4PPzf152bng=;
        b=hnDL3MkY1s2vZCu+YAqLlDcNJ7X8ZsnWguGo1B0rzijZCfnfilUJtR1VY4OR0hVT0f
         rZZbVWUyJyb8OiFFV/Y4HNcW1JTjn3CNmjHkHWE4UvLeJnouFJ6GNcdXPm33pUbp9UaG
         aoH3pLW8R67qlrZSq1tlVxhdgPhrO6jfhFCzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4K6fKAA2/aD8JgveCrJlSP+eb307VQ5m4PPzf152bng=;
        b=U9or070WhnbnR51foLwnKjXgy9h0B6hnC5lRPfwD0w0sIxkSsgJprNVtz8RT/iz9w/
         RyMZbdGlEm9642Qk+TId/k4wgO1f/luWsffk0h8kfsqPJNBNpZB6hwxT/ZyAQsN8MRPU
         KMsTZ8c7btJAu1NIRWj0k4REYNx2mcL7UGRMkxcXOzqrsRou+t4Byk2LDHSBACyGBPnC
         ZCYYzuxf8u4RlUG5I1beeco1B46dm7HtCJOTVawI/zQdouPX59HI5hehZBosyrqiRbG2
         pgeEN4TArshBAjBRP13X1Z1ci/8dR3SzP8VxchNGbAuqLZU9WJmUY7TdsnNak+U5N8vJ
         SHMQ==
X-Gm-Message-State: ANhLgQ1Yw+TbK6k5q95+yY+t0zxjy+Gh4pbHtLn63qm4xl1GH3JL+9bw
        h8Jk2qVNiauho+4rsrenVw6xmTzT+FeidQ==
X-Google-Smtp-Source: ADFU+vsI/QXwl+f1oC0mNhidfeORJRJOqz5KhPBFCPwq/ZtkFQfaom1W78EEkJ6YHLl+7HRGADVqhA==
X-Received: by 2002:a67:8c7:: with SMTP id 190mr392027vsi.163.1582828211800;
        Thu, 27 Feb 2020 10:30:11 -0800 (PST)
Received: from alain.c.googlers.com.com (39.119.74.34.bc.googleusercontent.com. [34.74.119.39])
        by smtp.gmail.com with ESMTPSA id v21sm2274464vkd.54.2020.02.27.10.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 10:30:11 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v1 2/3] bluetooth: Support querying for WBS support through MGMT
Date:   Thu, 27 Feb 2020 18:29:39 +0000
Message-Id: <20200227182938.110670-3-alainm@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200227182938.110670-1-alainm@chromium.org>
References: <20200227182938.110670-1-alainm@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch provides a mechanism for MGMT interface client to query the
capability of the controller to support WBS.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 drivers/bluetooth/btusb.c    | 3 +++
 include/net/bluetooth/hci.h  | 9 +++++++++
 include/net/bluetooth/mgmt.h | 1 +
 net/bluetooth/mgmt.c         | 4 ++++
 4 files changed, 17 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1b175ba3085c..95613f103d17 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3866,6 +3866,9 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_BROKEN_ISOC)
 		data->isoc = NULL;
 
+	if (id->driver_info & BTUSB_WIDEBAND_SPEECH)
+		set_bit(HCI_QUIRK_WIDE_BAND_SPEECH_SUPPORTED, &hdev->quirks);
+
 	if (id->driver_info & BTUSB_DIGIANSWER) {
 		data->cmdreq_type = USB_TYPE_VENDOR;
 		set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 6293bdd7d862..b214c4358d1c 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -205,6 +205,15 @@ enum {
 	 *
 	 */
 	HCI_QUIRK_NON_PERSISTENT_SETUP,
+
+	/* When this quirt is set, wide band speech is supported by
+	 * the driver since no reliable mechanism exist to report
+	 * this from the hardware, a driver flag is use to convey
+	 * this support
+	 *
+	 * This quirk must be set before hci_register_dev is called.
+	 */
+	HCI_QUIRK_WIDE_BAND_SPEECH_SUPPORTED,
 };
 
 /* HCI device flags */
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index a90666af05bd..51339584c3a9 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -102,6 +102,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_CONFIGURATION	0x00004000
 #define MGMT_SETTING_STATIC_ADDRESS	0x00008000
 #define MGMT_SETTING_PHY_CONFIGURATION  0x00010000
+#define MGMT_SETTING_WIDE_BAND_SPEECH	0x00020000
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0dc610faab70..a08691d679a8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -762,6 +762,10 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 
 		if (lmp_sc_capable(hdev))
 			settings |= MGMT_SETTING_SECURE_CONN;
+
+		if (test_bit(HCI_QUIRK_WIDE_BAND_SPEECH_SUPPORTED,
+			     &hdev->quirks))
+			settings |= MGMT_SETTING_WIDE_BAND_SPEECH;
 	}
 
 	if (lmp_le_capable(hdev)) {
-- 
2.25.1.481.gfbce0eb801-goog

