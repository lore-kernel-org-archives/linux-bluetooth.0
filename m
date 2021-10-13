Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93767C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 00:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CEF660FDA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 00:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbhJMAdH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Oct 2021 20:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbhJMAdE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Oct 2021 20:33:04 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6C3C061749
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Oct 2021 17:31:00 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id q19so934213pfl.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Oct 2021 17:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Z9Md0fmFSQDDHnVzT6gafBuVO8TfWl7TOxFXMarByKo=;
        b=pL6sDl0ztyBAr/cb0mF898WrrXI3imVSbRw6ETTAJMQNhnXmQF4fvGto7P/nbjE8BP
         MhlznTuNphdAfgAp+tRUm7mFX+/e6Mkhx3jrfUS9l+kJ4NOSN0DajL3tjJWJPDH3O4WY
         TM3aWWkCpgftVOBXJeApwh55+UaZAAtaEEdkx5s2FyJl38SqOzlc26CUHDILWu4VE0Xf
         LKrbZQeLXbr7GmtQA8vmMhYz7wnrZbwoMSSTlstEa3bVXYUJ9okCUtgQ0U0EMpkvcJuo
         bPcW+ol8PWDOz2aIM0QTsx26colARH3+tmjZJ1W4PtucmVpYJdDhQ7znM08FS9yN9e/Q
         QIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z9Md0fmFSQDDHnVzT6gafBuVO8TfWl7TOxFXMarByKo=;
        b=4RmOk/EQjyKPLZeAuhv1h/tYIxlTG+x4l9j61fr1glQXofZfI/3gOfQcT3CLBFAmPU
         kVkHG39feEMVcd1Shwer8lR1VHSGLT69iQUesuUB809vs0w3oKApvGlS0P3ZDV05qOab
         Th2GC2fjxMnZal916N9mhvK06z8vAYUFFiJzDivDfwTxbKiX7HcyY6OtUTrXqv1HAFm1
         Iw+F22LyRpm0+wWlBLLdBprr/keRmPLGR9L7qSW9Ev0lh4BasksJ3QuHv7ve8Ie67qqZ
         hJrvnNluqXxmkgAe6PHMY1DXkA2mdzyRWOPrQPiyoDQJSGwbv7BR5JdDr3f8G3HfUO30
         lPnQ==
X-Gm-Message-State: AOAM532GyGJeTbIuY76KOPlLHbtmopy9lBTlCQQVcZEQmlLoT6VO4BL3
        EbvnE6BYUQ7gq5QMlA2iplGAGSyTrgU=
X-Google-Smtp-Source: ABdhPJxAGpEI1vBluVxrwwNntIWST2qsJNv3zb9c1dXiSXImDJYxcS3MVLThzGAaYfBowrsExIhr7g==
X-Received: by 2002:a62:5101:0:b0:44c:5cc3:e088 with SMTP id f1-20020a625101000000b0044c5cc3e088mr34945181pfb.72.1634085059657;
        Tue, 12 Oct 2021 17:30:59 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s2sm11839996pfe.215.2021.10.12.17.30.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 17:30:59 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/4] Bluetooth: vhci: Add support for setting msft_opcode
Date:   Tue, 12 Oct 2021 17:30:54 -0700
Message-Id: <20211013003055.2664728-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211013003055.2664728-1-luiz.dentz@gmail.com>
References: <20211013003055.2664728-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a debugfs entry to set msft_opcode enabling vhci to emulate
controllers with MSFT extension support.

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

