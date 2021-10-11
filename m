Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39C0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Oct 2021 21:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD20560F43
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Oct 2021 21:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbhJKVNu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Oct 2021 17:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbhJKVNu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Oct 2021 17:13:50 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA9AC061570
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Oct 2021 14:11:49 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 21so5936309plo.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Oct 2021 14:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ngp3++O79al+cad27OV1IHGZYfV5z88NY3J14fxoyMU=;
        b=PB6J5o8RXCljvFIS41ziad6LdnDpovGBwtgeXpvsgSxvvjYJGv3MPf3amnsUrvOBq5
         2uVkFUlyW+KbBsiUcyGn3uQU43HWcy7j+/nvH7D75u2lOBkv6tbOuxvhygkwOBnNWS19
         WmlC4QmNaV9yXRf6PcsJ8Wsbgwwh6BHYf4daVVI+pGPDJlQjkJUJdE41EP0FoxacCtel
         N/A0yMFy1qCuS+n2EvRiRcyeO10BMeUCWp2xYk3Y39IrxwpGz1XSwrvSRCDL/YSAEpiB
         15UaZz6eU+WhBi3czNSg2YrJz2ItxurQKftgsdw8KU1IVh6AJqR72xD1u9Malpj/JE0Y
         tX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ngp3++O79al+cad27OV1IHGZYfV5z88NY3J14fxoyMU=;
        b=Ut2IFfFhBM1ioAN6GTn1ijmMkga9lPWrTXnYbAflkD16mJi30r1lM3LsPCYcALWt99
         hhv0/0QGBMUbD9RJO/JdgL/ifoCuuUqVb3kKSyV93xfTRo8mVqHvuWcfOwiyb0WWqMoJ
         P3KBM0RYDfX9iV+TM+5JA8zpRNe97gfoadxkpt0lsv5zpZu6E/LH4oVbpEVZRg++94A2
         TwYWwm4nTLP8aOaCLC1xFrOz/HXs//FhlDEYywvY59cpxk2FAG5ZVxMYvI0IA7nWbrqr
         z6el0ASjOx8++6lPtcpiqs7ZLasV8jzxSo9vTrmzhxTjvMvkgAdMBmSptZo2CHO4Kz2d
         6HyQ==
X-Gm-Message-State: AOAM532iSNN4UuOa78XdbUlx09DDTKbfsnbBsJZDtMaVri1P35p9zWzj
        8hVEpMF2b0uqfhw77OQ3YKKQq98XI5U=
X-Google-Smtp-Source: ABdhPJwquvsGYKIa29hKZPrbSQVppTasznAjPR4CHVm3KDq5A2h1yip/1HJGBSiOW9tb8EA1oK3GuA==
X-Received: by 2002:a17:90a:4814:: with SMTP id a20mr1471834pjh.154.1633986708866;
        Mon, 11 Oct 2021 14:11:48 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e1sm9335145pgi.43.2021.10.11.14.11.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 14:11:48 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: vhci: Add support for setting msft_opcode
Date:   Mon, 11 Oct 2021 14:11:47 -0700
Message-Id: <20211011211147.2379624-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
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
 drivers/bluetooth/hci_vhci.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 56c6b22be10b..ac122299bacc 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -194,6 +194,34 @@ static const struct file_operations force_wakeup_fops = {
 	.llseek		= default_llseek,
 };
 
+
+static int msft_opcode_set(void *data, u64 val)
+{
+	struct vhci_data *vhci = data;
+	uint16_t ogf = (val & 0xffff >> 10);
+
+	if (val > 0xffff || ogf != 0x3f)
+		return -EINVAL;
+
+	hci_set_msft_opcode(vhci->hdev, val);
+
+	return 0;
+}
+
+static int msft_opcode_get(void *data, u64 *val)
+{
+	struct vhci_data *vhci = data;
+
+	hci_dev_lock(vhci->hdev);
+	*val = vhci->hdev->msft_opcode;
+	hci_dev_unlock(vhci->hdev);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(msft_opcode_fops, msft_opcode_get, msft_opcode_set,
+			 "%llu\n");
+
 static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 {
 	struct hci_dev *hdev;
@@ -259,6 +287,10 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 	debugfs_create_file("force_wakeup", 0644, hdev->debugfs, data,
 			    &force_wakeup_fops);
 
+	if (IS_ENABLED(CONFIG_BT_MSFTEXT))
+		debugfs_create_file("msft_opcode", 0644, hdev->debugfs, data,
+				    &msft_opcode_fops);
+
 	hci_skb_pkt_type(skb) = HCI_VENDOR_PKT;
 
 	skb_put_u8(skb, 0xff);
-- 
2.31.1

