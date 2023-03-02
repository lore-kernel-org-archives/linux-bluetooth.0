Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22013C6FA8E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Mar 2023 23:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCBXP5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Mar 2023 18:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjCBXP4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Mar 2023 18:15:56 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426EB580FA
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Mar 2023 15:15:55 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id y35-20020a056a00182300b005e8e2c6afe2so336484pfa.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Mar 2023 15:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZIXCTLgoXIOnNOIeD8QH+8i1pHPgpgdgWc+E/qLbmc=;
        b=X4WtmS/JKsbbQP4HnbFUXwuKUKnZrd1pJwRJovvs8he5VPYfl51dKrtoev3eFk/3Vh
         sOBhreI7OWswTZMQM+H7v+wHvShRKaEChs4Fx2zZ+xy+Kk9UEpd+4NuaAuJjGqqgExq2
         yVqY6FY5OVwICbWaDNCH7L6BQFm/MOSd60gco+RM5xlATgFkC172ZJIZfUn1Q435Vfd6
         WVgWhSmDVaFz+BGjm6uBznK/s4UyV0Kvd7V45iauL1xqQ20aBgSu/AGfL4S9jcq/g35F
         R2UbXvtcqsxCB6PR925NXAiv7fekjPIq5H2kZdP2HGK90aOkdgxsOymbd6CTCam9VBvM
         tqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZIXCTLgoXIOnNOIeD8QH+8i1pHPgpgdgWc+E/qLbmc=;
        b=qcMZUUfkR/EKBzFMyJ2BAoHFIkvGEc73in/b7IJEVEQU5EiwdQQzn2SC2o+LDsvX7S
         HWuv2/6p/L2UvOe7BhgJ60EO6H7yAYobN6+dffQa9ncxhSTDdU+GBWrbPbRfmVRbFrjj
         7aE3WVeNjdbQvogjXPoE1UgV7stXMreTZchXIoRMP+BBVjcHMQtQR5Nuh7OEnNPNTipm
         6knGaJDlKV2w9+DNv0xOVZVlvIZpUDnCWECXWN02X5hv4E2QXKhLOdzgeqyZk4B9p5sK
         p4UjZgHLzRHKnWywG473f5F2LwkvAtxuKa13TyiugDF7qoMFSiUnyHrJlvC8A5aCUUK4
         3VLA==
X-Gm-Message-State: AO0yUKU9ZJ81s1NbhONfruJCXOTF8oxNF9dlrNXqAI5iPvgU7RRi8con
        /lcMHkPpexeton+nIcs56iaG0ukS9Zee7Q==
X-Google-Smtp-Source: AK7set/FgNGD2kdx45DRPPsGP9xZbqFnU3lIWQmGawpDz3HSgQ5ThH32WmV8JgPmwyOvvf7O9Vel3jnLB+Z1Uw==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a17:903:2483:b0:19b:f946:e57d with SMTP
 id p3-20020a170903248300b0019bf946e57dmr4264426plw.11.1677798954729; Thu, 02
 Mar 2023 15:15:54 -0800 (PST)
Date:   Thu,  2 Mar 2023 15:15:45 -0800
In-Reply-To: <20230302151413.v7.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
Mime-Version: 1.0
References: <20230302151413.v7.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230302151413.v7.2.Ief9a81a3643d2291f6db2b3695c3a6e0159467dc@changeid>
Subject: [PATCH v7 2/4] Bluetooth: Add vhci devcoredump support
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

Changes in v7:
- New patch in the series

 drivers/bluetooth/Kconfig    |  1 +
 drivers/bluetooth/hci_vhci.c | 72 ++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

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
index c443c3b0a4da..8a74e66f8b8e 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -278,6 +278,75 @@ static int vhci_setup(struct hci_dev *hdev)
 	return 0;
 }
 
+static void vhci_coredump(struct hci_dev *hdev)
+{
+	/* No need to do anything */
+}
+
+static int vhci_coredump_hdr(struct hci_dev *hdev, char *buf, size_t size)
+{
+	char *ptr = buf;
+	size_t rem = size;
+	size_t read = 0;
+
+	read = snprintf(ptr, rem, "Controller Name: vhci_ctrl\n");
+	rem -= read;
+	ptr += read;
+
+	read = snprintf(ptr, rem, "Firmware Version: vhci_fw\n");
+	rem -= read;
+	ptr += read;
+
+	read = snprintf(ptr, rem, "Driver: vhci_drv\n");
+	rem -= read;
+	ptr += read;
+
+	read = snprintf(ptr, rem, "Vendor: vhci\n");
+	rem -= read;
+	ptr += read;
+
+	return size - rem;
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
+	hci_devcoredump_register(hdev, vhci_coredump, vhci_coredump_hdr, NULL);
+
+	ret = hci_devcoredump_init(hdev, skb->len);
+	if (ret) {
+		BT_ERR("Failed to generate devcoredump");
+		kfree_skb(skb);
+		return ret;
+	}
+
+	hci_devcoredump_append(hdev, skb);
+	hci_devcoredump_complete(hdev);
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
@@ -355,6 +424,9 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 		debugfs_create_file("aosp_capable", 0644, hdev->debugfs, data,
 				    &aosp_capable_fops);
 
+	debugfs_create_file("force_devcoredump", 0644, hdev->debugfs, data,
+			    &force_devcoredump_fops);
+
 	hci_skb_pkt_type(skb) = HCI_VENDOR_PKT;
 
 	skb_put_u8(skb, 0xff);
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

