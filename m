Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CA1C77B6E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Mar 2023 16:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjC1Qal (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Mar 2023 12:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbjC1Qa1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Mar 2023 12:30:27 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A477B446
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 09:30:26 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id e15-20020a65678f000000b0050f9e396342so3392227pgr.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 09:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680021026;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sVqYiqqONgJinnmUNat86CZDMiZZiJLuOgYyNlqZ0G4=;
        b=LP2JH1/h7tcgzYCUI8SVxWvVevFsuhPAFOGD0UMm28p0GOSF7qsbuFk1YryWGoucKc
         pUB+rVpAyeht5JL2DWUne2HbBYviLccsU/L6WaDcgCHO636JkjRqS3Bda18reMmA7dZg
         vDtzF2/sYwXsd7PGNEXvdtbB+mM/Wz9REbcE9P+hTVWDJeGf6R8NipvWfvvHh4SztX+F
         pHw1H31eOrtPTklrmSXrZi+nmpox13UqHEM8Ij2/kSETpatfpjpO5Lu1CzhTc0iER8NL
         dBNq0p2IgVkJv7VnRehU6lsg72vnQ5UgP995GES08EZJQ7HQqkHZqyPqfvSGJNstMYze
         fcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680021026;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVqYiqqONgJinnmUNat86CZDMiZZiJLuOgYyNlqZ0G4=;
        b=0xXDEQalvhL2YMgjfrHvFIYEcmKdwa1a9moaG11uK5Gy9HkpT2fugcpJH2Z0AIVHPA
         Z75FTDNgoTlS2RiP+kfOkh+6nS8+2JhNSExH26uolyt4IR+hW/fALDTQaeF8oc02X3vL
         VynHxdWedfuRO4UhdABBV4+Nu+w1ozcB/9Ag9pKotw8Gj/abAe1pj+Gj2bmCM6wuVxx9
         c5/O3W/sv2YZW+1XBXhG2NaNqAA0p49WOEvpbcMslMN76ZeTmpUjCYhQBInfduHp5Kvx
         zrozk7JH59kQZBhQv7zD0dTBjshejZpyTZ23vVt0f7t3YtnjjPzy+Z0qxbutU4O9egCH
         Xkgw==
X-Gm-Message-State: AAQBX9db2F7LHXF/kK+qI5DmcwoIEEvV8bRXXGRj/qZYZJ9enQYzz6ym
        MTQ54p4WtTF++tRrm1V0mkrsWGMQ7UQp3A==
X-Google-Smtp-Source: AKy350YyPBs8oUKKHE8mENWLtrXAGS/JHKzzoV1fN4pLTzMieRozm3qE4mqv/+Pg5EnlqcUzYRQR/m8XWFM9Lw==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a05:6a00:2e9a:b0:624:1261:918f with SMTP
 id fd26-20020a056a002e9a00b006241261918fmr7951619pfb.1.1680021026093; Tue, 28
 Mar 2023 09:30:26 -0700 (PDT)
Date:   Tue, 28 Mar 2023 09:30:17 -0700
In-Reply-To: <20230328093000.v10.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
Mime-Version: 1.0
References: <20230328093000.v10.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328093000.v10.2.Ief9a81a3643d2291f6db2b3695c3a6e0159467dc@changeid>
Subject: [PATCH v10 2/4] Bluetooth: Add vhci devcoredump support
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

(no changes since v9)

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

