Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20445C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 00:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCABC61A50
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 00:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350805AbhJAAtC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Sep 2021 20:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349760AbhJAAtB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Sep 2021 20:49:01 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD1AC06176A
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Sep 2021 17:47:18 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ce20-20020a17090aff1400b0019f13f6a749so7767421pjb.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Sep 2021 17:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aFw5frKIYs8B8kLnrlQEKvQxVCwYaIx5WBKAd+1tJ2I=;
        b=dQNcc5/rZRtacgC4qcun5wqHyJdIhVgmyK9+VXJPd/lwvm9GjC+oVZ+GGSPeKhdPXF
         B3BEgavNqrcpYs5xXv+89og8OvIY33+DqoDoCLzZkUWp9MP4EBdrV+hcz9v/Sk7AIfxD
         FMz3FjOt0PX/F2q/ogXc/qJVxBToin4zhzIMNTDg88isgXLvCEPVdqYWwI8O9briSoqj
         AEbY+wlnA0FixluL8koPmmy6bn8gH7+uBpOtyPgK1GVH2HntqWFUJDXwV04vgbVKTvwR
         /3dUpKzxM+EIyO0BCE4aCO4/l3K9rK4+INX9dZTlJ/SOdBCKWLAg7mH7cAcGFKDN+Ihd
         pGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aFw5frKIYs8B8kLnrlQEKvQxVCwYaIx5WBKAd+1tJ2I=;
        b=YbA4dd/FjkVXxrUmD9mEzy234+KrJflPCsSKJZAgbF7O+wXjbW4CQdOUJcqrN6x88B
         QJQCaa3gUscm72KrEr1OQgzyXHhQ+5XN2nN5F15yahhy8jma80EQFf8rKnRZKtExU3br
         bdktAuy+8e7QMRILtpAOvUg0+mX1tW7BrGcKdnEj4mvHnWZ7hTd3/li3yWLXr2NGzS+4
         MIcd7uceubPZSRlHPLnwTx9BH3G02vOzQltOIJaTeMg/qH4YduZXgiqJy9NSWdmr4cTc
         GEYnhQQkoBdMDP3aPyanZU6EoavdOV0h+qsiXzgG3mzmz/skyOgAw4KXVn44vyz+9wZm
         FF3Q==
X-Gm-Message-State: AOAM532DebESrNRi1YEym4C6KjcbfhFbBcesmlx0mVYScp7BwpxhLPsi
        irv9LHmhK3X/epvMI0KTi78YME19fsI=
X-Google-Smtp-Source: ABdhPJzJV5/di6Imp3QPhQwK7DgTmfQTm0VUtmOMvJrGZVXVCU/hMrKKgm8wIr3/ZFxnPI4BMmGM4Q==
X-Received: by 2002:a17:902:7e05:b0:13b:7282:957f with SMTP id b5-20020a1709027e0500b0013b7282957fmr6781282plm.50.1633049237318;
        Thu, 30 Sep 2021 17:47:17 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id v7sm3689299pjk.37.2021.09.30.17.47.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 17:47:16 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Rename driver .prevent_wake to .wakeup
Date:   Thu, 30 Sep 2021 17:47:16 -0700
Message-Id: <20211001004716.3447880-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

prevent_wake logic is backward since what it is really checking is
if the device may wakeup the system or not, not that it can prevent
the system to be awaken.

Also looking on how other subsystems have the entry as power/wakeup
this also renames the force_prevent_wake to just wakeup in vhci driver.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c        |  4 ++--
 drivers/bluetooth/hci_vhci.c     | 25 ++++++++++++-------------
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_core.c         | 13 +++++++------
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 34363d3c85e5..bd09b91bb1ea 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3636,7 +3636,7 @@ static void btusb_check_needs_reset_resume(struct usb_interface *intf)
 		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
 }
 
-static bool btusb_prevent_wake(struct hci_dev *hdev)
+static bool btusb_wakeup(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 
@@ -3797,7 +3797,7 @@ static int btusb_probe(struct usb_interface *intf,
 	hdev->flush  = btusb_flush;
 	hdev->send   = btusb_send_frame;
 	hdev->notify = btusb_notify;
-	hdev->prevent_wake = btusb_prevent_wake;
+	hdev->wakeup = btusb_wakeup;
 
 #ifdef CONFIG_PM
 	err = btusb_config_oob_wake(hdev);
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index acf2544dbb05..5c27c27e54a0 100644
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
@@ -149,19 +149,19 @@ static const struct file_operations force_suspend_fops = {
 	.llseek		= default_llseek,
 };
 
-static ssize_t force_prevent_wake_read(struct file *file, char __user *user_buf,
+static ssize_t wakeup_read(struct file *file, char __user *user_buf,
 				       size_t count, loff_t *ppos)
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
+static ssize_t wakeup_write(struct file *file,
 					const char __user *user_buf,
 					size_t count, loff_t *ppos)
 {
@@ -173,16 +173,16 @@ static ssize_t force_prevent_wake_write(struct file *file,
 	if (err)
 		return err;
 
-	if (data->prevent_wake == enable)
+	if (data->wakeup == enable)
 		return -EALREADY;
 
 	return count;
 }
 
-static const struct file_operations force_prevent_wake_fops = {
+static const struct file_operations wakeup_fops = {
 	.open		= simple_open,
-	.read		= force_prevent_wake_read,
-	.write		= force_prevent_wake_write,
+	.read		= wakeup_read,
+	.write		= wakeup_write,
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
@@ -248,8 +248,7 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 	debugfs_create_file("force_suspend", 0644, hdev->debugfs, data,
 			    &force_suspend_fops);
 
-	debugfs_create_file("force_prevent_wake", 0644, hdev->debugfs, data,
-			    &force_prevent_wake_fops);
+	debugfs_create_file("wakeup", 0644, hdev->debugfs, data, &wakeup_fops);
 
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

