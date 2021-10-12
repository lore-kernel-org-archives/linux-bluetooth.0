Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639E4C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 21:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 414BF610A4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 21:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbhJLVeE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Oct 2021 17:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbhJLVeD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Oct 2021 17:34:03 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54954C061570
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Oct 2021 14:32:01 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ls18so619952pjb.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Oct 2021 14:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=A7nfk3+aYqodrO2YQj5bIWIMJEKanVdWT272yFtiF6c=;
        b=cT8jAUwN2tmF9y38D50haoesNMblIcI+DA4L3YgJ7rJMSyIP/InUHhv9MiB5ftj02g
         VmkDI2Srr2dc9JdnEq/V1LQ/WjSY5G8faUIRaazfUhlmW+KeR6ACJfxM3lSC38uMxL+C
         +Jrywb13XP2Kv4fIXVbu1j/lOQm/19f3pTHJJZrvBTyn+mu9WrZNw/e53DSy3hqI75RP
         fOgxx3bE1jw+yH8NrrKvVIRIFb7qYB/AaY8oXSn7LcfKvINNmHJGw/5w5iL0p8owqA5l
         Bh/fXmoE1TgWo1bVDBTQVEwAFEKAzcG/aF5omLrR6a68WwlBupL+i/0GlNCF3oH3uqSZ
         EH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A7nfk3+aYqodrO2YQj5bIWIMJEKanVdWT272yFtiF6c=;
        b=xJ25VWTfGHWWKTllgzTFRRwoLEPh4fqOGpqQei9LHRfrwe7CZpkekpGWuC3wZCQCaK
         L3yhOzdHuUxoAjq9Ro9rsRVvMVVRQgDS5j6r45LVy2j9TyyY6P+QSlNcCu1hXQIS/zZt
         Ce4pllgrTA94bVX0mf20mMPIi8nl+Fy+ONzeTFP1TLN1AESWNr0G0qtQ07Sft3VFc5zz
         CaVhbrIbMtxEi4FQDbFubPL/Ec0Vvt0jKUsrx+zzxzvg4QkfzLh2a8+DdG3VXXWVoqZD
         VGa5kAu8+zHJDFcugJADb6f9zHd5x6I63hGKTDulAaaaNirWFu+NmK/WC71NfyD5TUu7
         7kxA==
X-Gm-Message-State: AOAM530BJIXgUmRk2IDtmkdxFaFiRjMtqDwzpr3pL+M76KQQD528CZsj
        T0Vvu9QOd2jN4ToxQwPcK98S5pBreKc=
X-Google-Smtp-Source: ABdhPJxe57cwBVrkkqET+sUgyj7mTy9Mpb6XGtJkjN1M2htD0MUWg1mqc/JI8em4b5u7cN4iTvyvnw==
X-Received: by 2002:a17:90a:307:: with SMTP id 7mr8876553pje.176.1634074320588;
        Tue, 12 Oct 2021 14:32:00 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id on17sm3940900pjb.47.2021.10.12.14.31.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 14:32:00 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: vhci: Add support for setting msft_opcode
Date:   Tue, 12 Oct 2021 14:31:57 -0700
Message-Id: <20211012213158.2635219-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211012213158.2635219-1-luiz.dentz@gmail.com>
References: <20211012213158.2635219-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a debugfs entry to set msft_opcode enabling vhci to emulate
controllers with MSFT extention support.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/hci_vhci.c | 52 ++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 56c6b22be10b..68a970db8db1 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -42,6 +42,9 @@ struct vhci_data {
 
 	bool suspended;
 	bool wakeup;
+#if IS_ENABLED(CONFIG_BT_MSFTEXT)
+	__u16 msft_opcode;
+#endif
 };
 
 static int vhci_open_dev(struct hci_dev *hdev)
@@ -194,6 +197,44 @@ static const struct file_operations force_wakeup_fops = {
 	.llseek		= default_llseek,
 };
 
+#if IS_ENABLED(CONFIG_BT_MSFTEXT)
+
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
+static int vhci_setup(struct hci_dev *hdev)
+{
+	struct vhci_data *vhci = hci_get_drvdata(hdev);
+
+	if (vhci->msft_opcode)
+		hci_set_msft_opcode(hdev, vhci->msft_opcode);
+
+	return 0;
+}
+
+#endif /* CONFIG_BT_MSFTEXT */
+
 static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 {
 	struct hci_dev *hdev;
@@ -237,6 +278,12 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 	hdev->get_codec_config_data = vhci_get_codec_config_data;
 	hdev->wakeup = vhci_wakeup;
 
+	/* Enable custom setup if CONFIG_BT_MSFTEXT is selected */
+#if IS_ENABLED(CONFIG_BT_MSFTEXT)
+	hdev->setup = vhci_setup;
+	set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
+#endif
+
 	/* bit 6 is for external configuration */
 	if (opcode & 0x40)
 		set_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks);
@@ -259,6 +306,11 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 	debugfs_create_file("force_wakeup", 0644, hdev->debugfs, data,
 			    &force_wakeup_fops);
 
+#if IS_ENABLED(CONFIG_BT_MSFTEXT)
+	debugfs_create_file("msft_opcode", 0644, hdev->debugfs, data,
+			    &msft_opcode_fops);
+#endif
+
 	hci_skb_pkt_type(skb) = HCI_VENDOR_PKT;
 
 	skb_put_u8(skb, 0xff);
-- 
2.31.1

