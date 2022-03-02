Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80FAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Mar 2022 22:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiCBWxQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Mar 2022 17:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiCBWxP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Mar 2022 17:53:15 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DDF12E776
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Mar 2022 14:52:22 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 139so2911690pge.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Mar 2022 14:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hpQ3Ltxx8MaUo84vQcIBRbnGLEpPgzt99h9oNch8G9g=;
        b=Vyn7uqnLa7E8femaO9z7FSZWyavLSq7YWjwYt/j1f/P0wuP/OaKqRDIiz7T9+TLrrf
         NRbQsVfPkv6MBEv34jG+/0axo23cxQgE98vP3vSN1hsRHJN0lFMNZepPVhKkX40g7Hf4
         9AuZR8yAxt+pqOLFPU86rZvt+0sn/e0FX8h9q7fxONusMLJv3aRnXUTHr3QKlKV/tgbo
         /ykHPxLEXX+aX7Q86zeEjxDkXpjbWEgvShU5TAjaxlMguNng86XrfumP9QgNgNk+eyu6
         /2nv9+VKvmFnEtHC4tX08vV14DbTIT/Yk9SELSP2hEk3VFvuWeBEF8IwBjIYgkIip+qT
         9IpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hpQ3Ltxx8MaUo84vQcIBRbnGLEpPgzt99h9oNch8G9g=;
        b=6v1uLUjb6aIjBDcTsbT2WElA+eiP041sFLYvanaZ9vq2X8Xqd0TrJLG/emEUBv4E1p
         DqNVttrkHm9np9DcH/J8n1VJ5sxhN9SiQrGdz8pI8etqqxDXbl2XKOsu1vXqjxnPXfFu
         S7whkShD533KZZmx6EKZcMMFlptW6fBAwWif7XnYYx9J9AxEiAKBeFRApAKHn2FXoEv2
         b7dQJaWr/fIj7VTMfSH+GOGMM+AIeMoLYNISd1V7jJwjc1LbB2FyVsbgZ53b6i4bIBdP
         9oNxB67GLmn99rZxT8uvzoAnArZvQpKXQoMo7rOn8kUQscgq2Fv0W++ZcKHnV+oamQaV
         vplA==
X-Gm-Message-State: AOAM532r3KMjXwxQ7Y/ravzChbzQdBl51EJn3Hlyv4/Wopz8aG1DzSbQ
        5hb73xnE9VnU+m5fmUxWCkBSCl9bPCk=
X-Google-Smtp-Source: ABdhPJzLAfXmZ5FXVmfNsXeAJ1vtwcIKJYVovfGYvI94ETZ6E4HucUl0VmRhhQBIviXmJZu71LX7PQ==
X-Received: by 2002:a63:d1d:0:b0:359:b894:23d1 with SMTP id c29-20020a630d1d000000b00359b89423d1mr27441516pgl.132.1646261450814;
        Wed, 02 Mar 2022 14:50:50 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id o7-20020a63f147000000b00373facf1083sm167764pgk.57.2022.03.02.14.50.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 14:50:50 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: HCI: Add HCI_QUIRK_ENHANCED_SETUP_SYNC_CONN quirk
Date:   Wed,  2 Mar 2022 14:50:49 -0800
Message-Id: <20220302225049.432025-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds HCI_QUIRK_ENHANCED_SETUP_SYNC_CONN quirk which can be used to
mark HCI_Enhanced_Setup_Synchronous_Connection as supported by
controller since using just the support command bits are not enough
since some controller report it as supported but the command don't work
properly with some configurations (e.g. BT_VOICE_TRANSPARENT/mSBC).

Fixes: b2af264ad3af ("Bluetooth: Add support for HCI_Enhanced_Setup_Synchronous_Connection command")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=215576
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c        | 58 +++++++++++++++++---------------
 include/net/bluetooth/hci.h      |  9 +++++
 include/net/bluetooth/hci_core.h |  8 +++--
 3 files changed, 46 insertions(+), 29 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 558151f2f150..c862d0f963b5 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -36,33 +36,34 @@ static bool reset = true;
 
 static struct usb_driver btusb_driver;
 
-#define BTUSB_IGNORE		0x01
-#define BTUSB_DIGIANSWER	0x02
-#define BTUSB_CSR		0x04
-#define BTUSB_SNIFFER		0x08
-#define BTUSB_BCM92035		0x10
-#define BTUSB_BROKEN_ISOC	0x20
-#define BTUSB_WRONG_SCO_MTU	0x40
-#define BTUSB_ATH3012		0x80
-#define BTUSB_INTEL_COMBINED	0x100
-#define BTUSB_INTEL_BOOT	0x200
-#define BTUSB_BCM_PATCHRAM	0x400
-#define BTUSB_MARVELL		0x800
-#define BTUSB_SWAVE		0x1000
-#define BTUSB_AMP		0x4000
-#define BTUSB_QCA_ROME		0x8000
-#define BTUSB_BCM_APPLE		0x10000
-#define BTUSB_REALTEK		0x20000
-#define BTUSB_BCM2045		0x40000
-#define BTUSB_IFNUM_2		0x80000
-#define BTUSB_CW6622		0x100000
-#define BTUSB_MEDIATEK		0x200000
-#define BTUSB_WIDEBAND_SPEECH	0x400000
-#define BTUSB_VALID_LE_STATES   0x800000
-#define BTUSB_QCA_WCN6855	0x1000000
-#define BTUSB_INTEL_BROKEN_SHUTDOWN_LED	0x2000000
-#define BTUSB_INTEL_BROKEN_INITIAL_NCMD 0x4000000
-#define BTUSB_INTEL_NO_WBS_SUPPORT	0x8000000
+#define BTUSB_IGNORE			BIT(0)
+#define BTUSB_DIGIANSWER		BIT(1)
+#define BTUSB_CSR			BIT(2)
+#define BTUSB_SNIFFER			BIT(3)
+#define BTUSB_BCM92035			BIT(4)
+#define BTUSB_BROKEN_ISOC		BIT(5)
+#define BTUSB_WRONG_SCO_MTU		BIT(6)
+#define BTUSB_ATH3012			BIT(7)
+#define BTUSB_INTEL_COMBINED		BIT(8)
+#define BTUSB_INTEL_BOOT		BIT(9)
+#define BTUSB_BCM_PATCHRAM		BIT(10)
+#define BTUSB_MARVELL			BIT(11)
+#define BTUSB_SWAVE			BIT(12)
+#define BTUSB_AMP			BIT(13)
+#define BTUSB_QCA_ROME			BIT(14)
+#define BTUSB_BCM_APPLE			BIT(15)
+#define BTUSB_REALTEK			BIT(16)
+#define BTUSB_BCM2045			BIT(17)
+#define BTUSB_IFNUM_2			BIT(18)
+#define BTUSB_CW6622			BIT(19)
+#define BTUSB_MEDIATEK			BIT(20)
+#define BTUSB_WIDEBAND_SPEECH		BIT(21)
+#define BTUSB_VALID_LE_STATES		BIT(22)
+#define BTUSB_QCA_WCN6855		BIT(23)
+#define BTUSB_INTEL_BROKEN_SHUTDOWN_LED	BIT(24)
+#define BTUSB_INTEL_BROKEN_INITIAL_NCMD BIT(25)
+#define BTUSB_INTEL_NO_WBS_SUPPORT	BIT(26)
+#define BTUSB_ENHANCED_SETUP_SYNC_CONN  BIT(27)
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -3848,6 +3849,9 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
 	}
 
+	if (id->driver_info & BTUSB_ENHANCED_SETUP_SYNC_CONN)
+		set_bit(HCI_QUIRK_ENHANCED_SETUP_SYNC_CONN, &hdev->quirks);
+
 	if (id->driver_info & BTUSB_CSR) {
 		struct usb_device *udev = data->udev;
 		u16 bcdDevice = le16_to_cpu(udev->descriptor.bcdDevice);
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 35c073d44ec5..7fe10ad044c1 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -255,6 +255,15 @@ enum {
 	 * during the hdev->setup vendor callback.
 	 */
 	HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER,
+
+	/*
+	 * When this quirk is set, enables the use of
+	 * HCI_OP_ENHANCED_SETUP_SYNC_CONN command to setup SCO connections.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_ENHANCED_SETUP_SYNC_CONN,
 };
 
 /* HCI device flags */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d5377740e99c..119341c7168d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1492,8 +1492,12 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define privacy_mode_capable(dev) (use_ll_privacy(dev) && \
 				   (hdev->commands[39] & 0x04))
 
-/* Use enhanced synchronous connection if command is supported */
-#define enhanced_sco_capable(dev) ((dev)->commands[29] & 0x08)
+/* Use enhanced synchronous connection if command is supported and quirk has
+ * been set.
+ */
+#define enhanced_sco_capable(dev) (((dev)->commands[29] & 0x08) && \
+				   test_bit(HCI_QUIRK_ENHANCED_SETUP_SYNC_CONN, \
+					    &(dev)->quirks))
 
 /* Use ext scanning if set ext scan param and ext scan enable is supported */
 #define use_ext_scan(dev) (((dev)->commands[37] & 0x20) && \
-- 
2.35.1

