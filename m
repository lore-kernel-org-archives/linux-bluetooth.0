Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD91C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 20:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99B8961A8F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 20:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhJAUYU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Oct 2021 16:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355034AbhJAUYS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Oct 2021 16:24:18 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901BAC06177E
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Oct 2021 13:22:33 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so10183962pjw.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Oct 2021 13:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A5rl0S62hahQyCu6Ur7O7T7yx7Pp1mb6dO23e6uKip0=;
        b=g7cc7Po6W/p3oY1t/3r4DneBzLuNCCtwvoylgLaW4Q8YuJ+sPHhZ7oO4UP6po1Ur2A
         mrBPaGHtsGK0fWSdCEqk1a5UVRCUgBIr5m3UCSJBb18imE24IwtZI8oRxQUYEaJ5tq53
         f9XEzB/P/a0is/PEVUt8ahqHVWxbTPkebjup6Vv1VHrz4s60PlKXz2h4754KbV84C+GE
         R9250/XF0j+C8sXQfDWBQ4+Vj5KNeyD9pGPtHgR/DWVS0kg8stAe9y7954pTkB3z3mO3
         5OsRGcq/BpJ2Kw24tNCrapycfNK+yWRmNY7j6J1ykbEFs5j0U0/ZILOTm4l6jgObqw+h
         I5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A5rl0S62hahQyCu6Ur7O7T7yx7Pp1mb6dO23e6uKip0=;
        b=au+blEynDKOE0o3gRS7d9QGLeSV1y7DtMMmMrwE3wBDYEr4pwyf412DSN49tzpW/2J
         piHXlcyBgwbB7RAxVxLYezacGKjQLCESyORI7YH0a8f7WAIgNAyUsHVUtF6iPMwVU3w+
         euwVfPodYBSYwqcgsU/Dz3G06KDZKr+7NsjgEGE8cp/Ws9tqUO9Y6gcKd8HrV/2VBQrf
         6+1J+amnDWSLDOZoH1nrpPV5aQQHbwnKyCi3SORJNTccYdkEclY9TZocl0bqh39s51gu
         oIpEVeNPc3pKXqRWEH49LWGCM/WBJkCQbMTFGeiTSBXxiRzbZF1Ge2tpvRBXCtJamfsG
         B3rg==
X-Gm-Message-State: AOAM531yPYPrN6Yco3eKtQk7O0sc8+L+bcgHjrAVyfHnwfZb49/zd458
        frYjiOKq7eO5KxpATnCzk2wCcGGDe3w=
X-Google-Smtp-Source: ABdhPJwOI/+ph90WiTHF71W84Sfwrzy/Dx2hiWHG4q7Cex5yesdxOWf+3tsnhKV1DyWEhXOQYt6Xgw==
X-Received: by 2002:a17:90a:4618:: with SMTP id w24mr15488320pjg.142.1633119752603;
        Fri, 01 Oct 2021 13:22:32 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id k14sm6659330pji.45.2021.10.01.13.22.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 13:22:32 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Rename driver .prevent_wake to .wakeup
Date:   Fri,  1 Oct 2021 13:22:31 -0700
Message-Id: <20211001202231.3599199-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

prevent_wake logic is backward since what it is really checking is
if the device may wakeup the system or not, not that it will prevent
the to be awaken.

Also looking on how other subsystems have the entry as power/wakeup
this also renames the force_prevent_wake to force_wakeup in vhci driver.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c        |  4 ++--
 drivers/bluetooth/hci_vhci.c     | 32 ++++++++++++++++----------------
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_core.c         | 13 +++++++------
 4 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a215a1c37571..3e1fa9176995 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3640,7 +3640,7 @@ static void btusb_check_needs_reset_resume(struct usb_interface *intf)
 		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
 }
 
-static bool btusb_prevent_wake(struct hci_dev *hdev)
+static bool btusb_wakeup(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 
@@ -3801,7 +3801,7 @@ static int btusb_probe(struct usb_interface *intf,
 	hdev->flush  = btusb_flush;
 	hdev->send   = btusb_send_frame;
 	hdev->notify = btusb_notify;
-	hdev->prevent_wake = btusb_prevent_wake;
+	hdev->wakeup = btusb_wakeup;
 
 #ifdef CONFIG_PM
 	err = btusb_config_oob_wake(hdev);
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index acf2544dbb05..b45db0db347c 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -40,7 +40,7 @@ struct vhci_data {
 	struct delayed_work open_timeout;
 
 	bool suspended;
-	bool prevent_wake;
+	bool wakeup;
 };
 
 static int vhci_open_dev(struct hci_dev *hdev)
@@ -95,11 +95,11 @@ static int vhci_get_codec_config_data(struct hci_dev *hdev, __u8 type,
 	return 0;
 }
 
-static bool vhci_prevent_wake(struct hci_dev *hdev)
+static bool vhci_wakeup(struct hci_dev *hdev)
 {
 	struct vhci_data *data = hci_get_drvdata(hdev);
 
-	return data->prevent_wake;
+	return data->wakeup;
 }
 
 static ssize_t force_suspend_read(struct file *file, char __user *user_buf,
@@ -149,21 +149,21 @@ static const struct file_operations force_suspend_fops = {
 	.llseek		= default_llseek,
 };
 
-static ssize_t force_prevent_wake_read(struct file *file, char __user *user_buf,
-				       size_t count, loff_t *ppos)
+static ssize_t force_wakeup_read(struct file *file, char __user *user_buf,
+				 size_t count, loff_t *ppos)
 {
 	struct vhci_data *data = file->private_data;
 	char buf[3];
 
-	buf[0] = data->prevent_wake ? 'Y' : 'N';
+	buf[0] = data->wakeup ? 'Y' : 'N';
 	buf[1] = '\n';
 	buf[2] = '\0';
 	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
 }
 
-static ssize_t force_prevent_wake_write(struct file *file,
-					const char __user *user_buf,
-					size_t count, loff_t *ppos)
+static ssize_t force_wakeup_write(struct file *file,
+				  const char __user *user_buf, size_t count,
+				  loff_t *ppos)
 {
 	struct vhci_data *data = file->private_data;
 	bool enable;
@@ -173,16 +173,16 @@ static ssize_t force_prevent_wake_write(struct file *file,
 	if (err)
 		return err;
 
-	if (data->prevent_wake == enable)
+	if (data->wakeup == enable)
 		return -EALREADY;
 
 	return count;
 }
 
-static const struct file_operations force_prevent_wake_fops = {
+static const struct file_operations force_wakeup_fops = {
 	.open		= simple_open,
-	.read		= force_prevent_wake_read,
-	.write		= force_prevent_wake_write,
+	.read		= force_wakeup_read,
+	.write		= force_wakeup_write,
 	.llseek		= default_llseek,
 };
 
@@ -227,7 +227,7 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 	hdev->send  = vhci_send_frame;
 	hdev->get_data_path_id = vhci_get_data_path_id;
 	hdev->get_codec_config_data = vhci_get_codec_config_data;
-	hdev->prevent_wake = vhci_prevent_wake;
+	hdev->wakeup = vhci_wakeup;
 
 	/* bit 6 is for external configuration */
 	if (opcode & 0x40)
@@ -248,8 +248,8 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 	debugfs_create_file("force_suspend", 0644, hdev->debugfs, data,
 			    &force_suspend_fops);
 
-	debugfs_create_file("force_prevent_wake", 0644, hdev->debugfs, data,
-			    &force_prevent_wake_fops);
+	debugfs_create_file("force_wakeup", 0644, hdev->debugfs, data,
+			    &force_wakeup_fops);
 
 	hci_skb_pkt_type(skb) = HCI_VENDOR_PKT;
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3b06990fcf16..dd8840e70e25 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -617,7 +617,7 @@ struct hci_dev {
 	int (*set_diag)(struct hci_dev *hdev, bool enable);
 	int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 	void (*cmd_timeout)(struct hci_dev *hdev);
-	bool (*prevent_wake)(struct hci_dev *hdev);
+	bool (*wakeup)(struct hci_dev *hdev);
 	int (*set_quality_report)(struct hci_dev *hdev, bool enable);
 	int (*get_data_path_id)(struct hci_dev *hdev, __u8 *data_path);
 	int (*get_codec_config_data)(struct hci_dev *hdev, __u8 type,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ea063ce4d7af..8d33aa64846b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3998,18 +3998,19 @@ int hci_suspend_dev(struct hci_dev *hdev)
 	 *  - Second, program event filter/accept list and enable scan
 	 */
 	ret = hci_change_suspend_state(hdev, BT_SUSPEND_DISCONNECT);
-	if (!ret)
-		state = BT_SUSPEND_DISCONNECT;
+	if (ret)
+		goto clear;
 
-	/* Only configure accept list if disconnect succeeded and wake
-	 * isn't being prevented.
-	 */
-	if (!ret && !(hdev->prevent_wake && hdev->prevent_wake(hdev))) {
+	state = BT_SUSPEND_DISCONNECT;
+
+	/* Only configure accept list if device may wakeup. */
+	if (hdev->wakeup && hdev->wakeup(hdev)) {
 		ret = hci_change_suspend_state(hdev, BT_SUSPEND_CONFIGURE_WAKE);
 		if (!ret)
 			state = BT_SUSPEND_CONFIGURE_WAKE;
 	}
 
+clear:
 	hci_clear_wake_reason(hdev);
 	mgmt_suspending(hdev, state);
 
-- 
2.31.1

