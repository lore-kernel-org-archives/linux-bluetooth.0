Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED4BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 22:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60DA1610CC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 22:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhJMWTH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Oct 2021 18:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhJMWTG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Oct 2021 18:19:06 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4510FC061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 15:17:03 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id np13so3309166pjb.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 15:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GEWO+tSkLfZRrI/O5OcmkK+2eMHpg/T0ri94OenQkFk=;
        b=M0DrMBovbz46KIRE3RXPydwpULx35aijxi1R6gdsNuYzasmxhVXyxrOcydaeBCTKg5
         GOX4KknHIwb2OKPeTjxoAEI/ysjntMGvC0seneOtVe0yhTZnuqfxY6ZDdwkONTTFog53
         GjUY5W1XdHp4FJB4DcOizwmJiSQlPMVItGu7WjPmY3EDZzdxnqzwDirEuvfGXO28gH8J
         PupborGVIirq8+rQn6jvZA7RKVsy73QoUqdrnBhoTQ51Vmctp0ZcGWsxwoAVEnisY1x0
         I8Qg/UrxZ5IVrEYdER7YbB7sUF4OL/U8GspV+9zTKpQbmGeqzZwBzKBxYLYSfAFM6H66
         QZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GEWO+tSkLfZRrI/O5OcmkK+2eMHpg/T0ri94OenQkFk=;
        b=QhCIQMV2STPVZI2Nrp+3Yq+OM2S5dtk2UqV79UeUkoWm/VkoOfLOlTYhkusSGdpvNA
         H0byy9x3roks11uOqa4RR/M6wUnXpAwuzg5wnxWhhGRTWYtCRKnMDKTN2FjmQJtlTOcZ
         kPLn3/VNeDxv30dXjHf+bGo2RIT6dYTZC0yQD/2SUcqOpzX8a9Jwgn1pzmZQNibdN34J
         KnZs3W6H5GR1DLusfouXV6ikk2RJx/dnV9cr1ur9QjfbLRtb8AdGe5FAKYofV00StoCR
         h8/NRJvmDl0qn1WzE7uSFuC2S0o11GZs39F6lzFO8omHxTvvUqf3dOuVFnMYyKaVOnSk
         RtFw==
X-Gm-Message-State: AOAM531zg+GUnXGeQwrYv921OThF+0GjTck6fhZYzSJVjc1C00DkSj47
        2cN1rU2nH7Jk89RFwhRJ66WTdkyy7yk=
X-Google-Smtp-Source: ABdhPJwIMH8oKuswp8qsZYtL55In4+vXOWL5lkubqNCwOZrVfSKWuYJaNH79heF429KGHPFZKyH13g==
X-Received: by 2002:a17:90a:4306:: with SMTP id q6mr16292483pjg.202.1634163422445;
        Wed, 13 Oct 2021 15:17:02 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id u74sm438355pfc.87.2021.10.13.15.17.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 15:17:02 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: vhci: Add support for setting msft_opcode and aosp_capable
Date:   Wed, 13 Oct 2021 15:17:01 -0700
Message-Id: <20211013221701.2826793-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a debugfs entries to set msft_opcode and aosp_capable enabling
vhci to emulate controllers with MSFT/AOSP extension support.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2: Fix typos: s/extention/extension/g
v3: Remove checks for HCI_SETUP, merge changes to introduce MSFT/AOSP support
at the same time.

 drivers/bluetooth/hci_vhci.c | 92 ++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 56c6b22be10b..dc05729104a1 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -42,6 +42,8 @@ struct vhci_data {
 
 	bool suspended;
 	bool wakeup;
+	__u16 msft_opcode;
+	bool aosp_capable;
 };
 
 static int vhci_open_dev(struct hci_dev *hdev)
@@ -194,6 +196,82 @@ static const struct file_operations force_wakeup_fops = {
 	.llseek		= default_llseek,
 };
 
+static int msft_opcode_set(void *data, u64 val)
+{
+	struct vhci_data *vhci = data;
+
+	if (val > 0xffff || (val & 0xffff >> 10) != 0x3f)
+		return -EINVAL;
+
+	vhci->msft_opcode = val;
+
+	return 0;
+}
+
+static int msft_opcode_get(void *data, u64 *val)
+{
+	struct vhci_data *vhci = data;
+
+	*val = vhci->msft_opcode;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(msft_opcode_fops, msft_opcode_get, msft_opcode_set,
+			 "%llu\n");
+
+static ssize_t aosp_capable_read(struct file *file, char __user *user_buf,
+				 size_t count, loff_t *ppos)
+{
+	struct vhci_data *vhci = file->private_data;
+	char buf[3];
+
+	buf[0] = vhci->aosp_capable ? 'Y' : 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t aosp_capable_write(struct file *file,
+				  const char __user *user_buf, size_t count,
+				  loff_t *ppos)
+{
+	struct vhci_data *vhci = file->private_data;
+	bool enable;
+	int err;
+
+	err = kstrtobool_from_user(user_buf, count, &enable);
+	if (err)
+		return err;
+
+	if (vhci->aosp_capable == enable)
+		return -EALREADY;
+
+	vhci->aosp_capable = enable;
+
+	return count;
+}
+
+static const struct file_operations aosp_capable_fops = {
+	.open		= simple_open,
+	.read		= aosp_capable_read,
+	.write		= aosp_capable_write,
+	.llseek		= default_llseek,
+};
+
+static int vhci_setup(struct hci_dev *hdev)
+{
+	struct vhci_data *vhci = hci_get_drvdata(hdev);
+
+	if (vhci->msft_opcode)
+		hci_set_msft_opcode(hdev, vhci->msft_opcode);
+
+	if (vhci->aosp_capable)
+		hci_set_aosp_capable(hdev);
+
+	return 0;
+}
+
 static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 {
 	struct hci_dev *hdev;
@@ -237,6 +315,12 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 	hdev->get_codec_config_data = vhci_get_codec_config_data;
 	hdev->wakeup = vhci_wakeup;
 
+	/* Enable custom setup if CONFIG_BT_MSFTEXT or CONFIG_BT_AOSPEXT is
+	 * selected.
+	 */
+	hdev->setup = vhci_setup;
+	set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
+
 	/* bit 6 is for external configuration */
 	if (opcode & 0x40)
 		set_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks);
@@ -259,6 +343,14 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 	debugfs_create_file("force_wakeup", 0644, hdev->debugfs, data,
 			    &force_wakeup_fops);
 
+	if (IS_ENABLED(CONFIG_BT_MSFTEXT))
+		debugfs_create_file("msft_opcode", 0644, hdev->debugfs, data,
+				    &msft_opcode_fops);
+
+	if (IS_ENABLED(CONFIG_BT_AOSPEXT))
+		debugfs_create_file("aosp_capable", 0644, hdev->debugfs, data,
+				    &aosp_capable_fops);
+
 	hci_skb_pkt_type(skb) = HCI_VENDOR_PKT;
 
 	skb_put_u8(skb, 0xff);
-- 
2.31.1

