Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA0DC761A6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Mar 2023 01:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjC1BTL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Mar 2023 21:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjC1BTK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Mar 2023 21:19:10 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C031BCE
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 18:19:03 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id y186-20020a62cec3000000b00627df3d6ec4so5078552pfg.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 18:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679966343;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3y5WqOT376pI2yRKqgV9p9VlTctVEmeHkeRgXExZUGQ=;
        b=Jlb3o+cIX/JTlohbvx55JnUIDP6UK/SWtEIs21vdoiknObjL8amU3TFklUywGR+Toj
         GzlQN2Vmgb2zmnHeGLuR+tqOJlr1XndkByBNSlgjxEiR2u1utYmSgo601lBSEJSOxlkW
         fEArAgOo3ZGiq4QKxudAN9QArd2bOf7QoLqqUlzSkGj/0Fg9LQgCs0K5EtqjnTrwa0+L
         XjrktI7/YDv2os252VZfQds0R1PmGxcRMXiWIuaSpvX+HIcQwfuF1l/CBdyxVgOmgS5W
         UyROk993eM7PJ6VdS9s03ltGWh2K2Vp5duVnfIIKg6v9taRHufVWrV5LvyJHBvMlqVi+
         YD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679966343;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3y5WqOT376pI2yRKqgV9p9VlTctVEmeHkeRgXExZUGQ=;
        b=Kf+3mNFiS4IhAb4madQGWubHfQDLgW5smocKQAaeHkXJ0zOprdtLkYG9hTc6AAgTfU
         54Ysby2LqGdAgX8lAzG7ohymVHlkNhptSZBEnW9yStBSeeTUFucyRMhwQMdVx2clpoVi
         3gx454o5fezJlgDxMoqfjUXOAjK6dxKqpXhfOTZSUFkPNhl/6m/ZFqgaPMmmLfNV3Fdh
         6kJf3qd7j46zf3Z42PM0MjWl4M6sOZgc+E8TEWC4b7InKI4MmCqhOrODeDzDsEGUMIET
         6P5adXiQdmqWezjJgnTQNCvuJMgaVR2nOR92t+IE7gzRn/u5Whzr0C22+IhqWiOBtbxw
         Hbyw==
X-Gm-Message-State: AAQBX9dsUVC147AnRgek8NlNXTbhjIEKJdUtTD4VucJFghCKTx1+5sfy
        hxMxeArlG3zUyK4Kg9DKW3CVCGS1uwIrVA==
X-Google-Smtp-Source: AKy350ZtqFeEKI8WdCjTVwggXGo/OdiCQ0DwaPIeHO6zdYYgTb7EuaxJxY/WurBGkZb2EtO98smvaGo3cd48Rg==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a17:903:22c6:b0:1a0:6000:7fd0 with SMTP
 id y6-20020a17090322c600b001a060007fd0mr5434223plg.5.1679966343113; Mon, 27
 Mar 2023 18:19:03 -0700 (PDT)
Date:   Mon, 27 Mar 2023 18:18:55 -0700
In-Reply-To: <20230327181825.v9.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
Mime-Version: 1.0
References: <20230327181825.v9.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230327181825.v9.2.Ief9a81a3643d2291f6db2b3695c3a6e0159467dc@changeid>
Subject: [PATCH v9 2/4] Bluetooth: Add vhci devcoredump support
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add devcoredump support for vhci that creates forcce_devcoredump debugfs
entry. This is used for mgmt-tester tests.

Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

Changes in v9:
- Rename hci_devcoredump_*() to hci_devcd_*()

Changes in v8:
- Update vhci_coredump_hdr() to use skb

Changes in v7:
- New patch in the series

 drivers/bluetooth/Kconfig    |  1 +
 drivers/bluetooth/hci_vhci.c | 64 ++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 5a1a7bec3c42..7bc7a765ad69 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -363,6 +363,7 @@ config BT_HCIBLUECARD
 
 config BT_HCIVHCI
 	tristate "HCI VHCI (Virtual HCI device) driver"
+	select WANT_DEV_COREDUMP
 	help
 	  Bluetooth Virtual HCI device driver.
 	  This driver is required if you want to use HCI Emulation software.
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index c443c3b0a4da..a265dcaf8275 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -278,6 +278,67 @@ static int vhci_setup(struct hci_dev *hdev)
 	return 0;
 }
 
+static void vhci_coredump(struct hci_dev *hdev)
+{
+	/* No need to do anything */
+}
+
+static void vhci_coredump_hdr(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	char buf[80];
+
+	snprintf(buf, sizeof(buf), "Controller Name: vhci_ctrl\n");
+	skb_put_data(skb, buf, strlen(buf));
+
+	snprintf(buf, sizeof(buf), "Firmware Version: vhci_fw\n");
+	skb_put_data(skb, buf, strlen(buf));
+
+	snprintf(buf, sizeof(buf), "Driver: vhci_drv\n");
+	skb_put_data(skb, buf, strlen(buf));
+
+	snprintf(buf, sizeof(buf), "Vendor: vhci\n");
+	skb_put_data(skb, buf, strlen(buf));
+}
+
+static ssize_t force_devcoredump_write(struct file *file,
+				       const char __user *user_buf,
+				       size_t count, loff_t *ppos)
+{
+	struct vhci_data *data = file->private_data;
+	struct hci_dev *hdev = data->hdev;
+	struct sk_buff *skb = NULL;
+	char buf[512];
+	int ret;
+
+	ret = simple_write_to_buffer(&buf, sizeof(buf), ppos, user_buf, count);
+	if (ret < count)
+		return ret;
+
+	skb = alloc_skb(count, GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+	skb_put_data(skb, &buf, count);
+
+	hci_devcd_register(hdev, vhci_coredump, vhci_coredump_hdr, NULL);
+
+	ret = hci_devcd_init(hdev, skb->len);
+	if (ret) {
+		BT_ERR("Failed to generate devcoredump");
+		kfree_skb(skb);
+		return ret;
+	}
+
+	hci_devcd_append(hdev, skb);
+	hci_devcd_complete(hdev);
+
+	return count;
+}
+
+static const struct file_operations force_devcoredump_fops = {
+	.open		= simple_open,
+	.write		= force_devcoredump_write,
+};
+
 static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 {
 	struct hci_dev *hdev;
@@ -355,6 +416,9 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 		debugfs_create_file("aosp_capable", 0644, hdev->debugfs, data,
 				    &aosp_capable_fops);
 
+	debugfs_create_file("force_devcoredump", 0644, hdev->debugfs, data,
+			    &force_devcoredump_fops);
+
 	hci_skb_pkt_type(skb) = HCI_VENDOR_PKT;
 
 	skb_put_u8(skb, 0xff);
-- 
2.40.0.348.gf938b09366-goog

