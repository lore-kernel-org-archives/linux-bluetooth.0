Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E34C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 20:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DACA619EC
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 20:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhJAUX0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Oct 2021 16:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhJAUX0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Oct 2021 16:23:26 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7758C061775
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Oct 2021 13:21:41 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id q23so8933813pfs.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Oct 2021 13:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A5rl0S62hahQyCu6Ur7O7T7yx7Pp1mb6dO23e6uKip0=;
        b=Up0m97M+XBAY78movWh4ahO3Rvi0yfknX6seej47Ak6jVXeBfxUZZfWBlSY7Bj0HOg
         YcmvOv8uQt8alwGvApWxuWoyCgFZU4IOo3y4dDUGkGPHf7nlQzQqXbEVlVO8/PJTZjpH
         t5rOXkj+MA7fFdTECN4Pbsn9bqpnjyTA25eIQj2EXO0SmucGNahmWcWrYYYdSbly3ehh
         S50PMhYTn+3KsLQfA7t6uuXJRKALJkzrA+6gKr8JtjQ0jA8Psa7K+2K/wNyWKhJ0upM2
         PTg3F/DyFvs3s2V8dNDp1XrMRRjKctCQq/BHiWcGWHKvncWcYfNhbuediFuL2AZXMHg7
         tnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A5rl0S62hahQyCu6Ur7O7T7yx7Pp1mb6dO23e6uKip0=;
        b=C9G/BHmQWYZPh2LFNrEEEN4c/HYLzdO09PMdru4aHAxS2f4eYnUNdSoBh0pvNZdR/7
         VC7ZKNBvtHuRkIJ67yjIA0cnFsDdd99kfjc3cQYRZzsysJHnNHPrH2kaI/NFEjSOrJeZ
         utk3sxFyB8TGlSV5FSZ59W/0c37WaBp8i6v0TJ5fI2XXxGJejqmlXgQOE8J2wiapejZ9
         5Q0Pz1bkjSitdWv+LE+03LrkVdof17zuDY+KI1fbVlwslVeMudXAO1Ex1LVZfC/qrmMv
         EfpXfkGizpMyHFfM02Dy52caa503M5saPuqI60FtgW6GKXLOYWQlKFzSuVPm8lnWdbJj
         pX5g==
X-Gm-Message-State: AOAM533OhIAoQqpJ9Wi+aCFhZL6ELYBhfxN33MOe55Nrt4dlYVY0VLOc
        2CU+GuSxf7XzUI5UJ4M3NMinT73kzjI=
X-Google-Smtp-Source: ABdhPJycJdeKubGQEwM/GC1amaiOCtBiHNvCESRg0WVaC63xIwAUVtVeL6bSvzAweBbh+ptJ43zaNw==
X-Received: by 2002:a63:9a01:: with SMTP id o1mr11186271pge.441.1633119700796;
        Fri, 01 Oct 2021 13:21:40 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id r2sm7162908pgn.8.2021.10.01.13.21.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 13:21:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Rename driver .prevent_wake to .wakeup
Date:   Fri,  1 Oct 2021 13:21:39 -0700
Message-Id: <20211001202139.3598667-1-luiz.dentz@gmail.com>
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

