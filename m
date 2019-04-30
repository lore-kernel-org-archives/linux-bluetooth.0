Return-Path: <SRS0=EsMn=TA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55788C43219
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Apr 2019 00:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2117120675
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Apr 2019 00:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k7Kw5N91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbfD3AKa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Apr 2019 20:10:30 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37072 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbfD3AKa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Apr 2019 20:10:30 -0400
Received: by mail-pl1-f196.google.com with SMTP id z8so5869733pln.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Apr 2019 17:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y8Pf9UXyzPjlpRjHiYMPtrNDJ8/3UQU5riBkZSYp9gs=;
        b=k7Kw5N91Pxko0ghZG+tFO44IQLSLmLpxnt3s2C4Ka8pDBJI7mim2Lk2dlUKF8ZLNot
         RfLDsDUUUc+VFe0qPlwHOA5zqLJvvxwtOGg/7Hb0GR8p7ebNzp7Us5YVQoeiIhu9Ltwr
         Ao2kyZGey9qZR1awyZuwdaSkWY17AaOxzyawc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y8Pf9UXyzPjlpRjHiYMPtrNDJ8/3UQU5riBkZSYp9gs=;
        b=DbmfnrO+ReDR51yhcU98xIaotlDXOqOBqhWN1sR3pIYWD46EOluyxf+RcB5laiTbVu
         OmZ1yrSIsYU2pxKdfbXCnY6fx5PBvIzQAI6jVZKPk1GTqe267dFP0qeXwL2z38+w0RMS
         lG4amIwPx4HUYNY49ng/h5kvAbVlXFAzIbtWgT9CYj8qKoHbBfgv6RrTYDArEEjeYQVh
         qW8cyHUAM7MOGH5d0JnH4p2GGT9y4dv8RIfZ2Su09tQmY329mctLLYtuQwRlxye6qBRj
         MU46jSc41/i2Ecpi+niO/rk29MSZmVOTEPXux2kKxigvizJr+024JkAQ/b2C3xd94ueV
         tUPA==
X-Gm-Message-State: APjAAAWfR+ui0FXdF+/FPFFvmvVw88TD2IaC7CVuajl3EH7t+cYskcDn
        CEDRNA5T6WmeEeddL/e+0vj/Eg==
X-Google-Smtp-Source: APXvYqxXWqn4PyYBhaEXrbFBPXd88+0a2CteVhsZB0uDiFIMSkAjoNlIJlfk7AESXUSA6LYf/viT6Q==
X-Received: by 2002:a17:902:7b8e:: with SMTP id w14mr48845254pll.202.1556583029384;
        Mon, 29 Apr 2019 17:10:29 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id n65sm59063555pga.92.2019.04.29.17.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 17:10:28 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Harish Bandi <c-hbandi@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v8] Bluetooth: btqca: inject command complete event during fw download
Date:   Mon, 29 Apr 2019 17:10:24 -0700
Message-Id: <20190430001024.209688-1-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Balakrishna Godavarthi <bgodavar@codeaurora.org>

From: Balakrishna Godavarthi <bgodavar@codeaurora.org>

Latest qualcomm chips are not sending an command complete event for
every firmware packet sent to chip. They only respond with a vendor
specific event for the last firmware packet. This optimization will
decrease the BT ON time. Due to this we are seeing a timeout error
message logs on the console during firmware download. Now we are
injecting a command complete event once we receive an vendor specific
event for the last RAM firmware packet.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v8:
- renamed QCA_HCI_CC_SUCCESS to QCA_HCI_CC_OPCODE
- use 0xFC00 as opcode of the injected event instead of 0
- added Matthias' tags from the v7 review
---
 drivers/bluetooth/btqca.c | 39 ++++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btqca.h |  3 +++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index cc12eecd9e4d..ef765ea881b8 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -144,6 +144,7 @@ static void qca_tlv_check_data(struct rome_config *config,
 		 * In case VSE is skipped, only the last segment is acked.
 		 */
 		config->dnld_mode = tlv_patch->download_mode;
+		config->dnld_type = config->dnld_mode;
 
 		BT_DBG("Total Length           : %d bytes",
 		       le32_to_cpu(tlv_patch->total_size));
@@ -264,6 +265,31 @@ static int qca_tlv_send_segment(struct hci_dev *hdev, int seg_size,
 	return err;
 }
 
+static int qca_inject_cmd_complete_event(struct hci_dev *hdev)
+{
+	struct hci_event_hdr *hdr;
+	struct hci_ev_cmd_complete *evt;
+	struct sk_buff *skb;
+
+	skb = bt_skb_alloc(sizeof(*hdr) + sizeof(*evt) + 1, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	hdr = skb_put(skb, sizeof(*hdr));
+	hdr->evt = HCI_EV_CMD_COMPLETE;
+	hdr->plen = sizeof(*evt) + 1;
+
+	evt = skb_put(skb, sizeof(*evt));
+	evt->ncmd = 1;
+	evt->opcode = HCI_OP_NOP;
+
+	skb_put_u8(skb, QCA_HCI_CC_SUCCESS);
+
+	hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
+
+	return hci_recv_frame(hdev, skb);
+}
+
 static int qca_download_firmware(struct hci_dev *hdev,
 				  struct rome_config *config)
 {
@@ -297,11 +323,22 @@ static int qca_download_firmware(struct hci_dev *hdev,
 		ret = qca_tlv_send_segment(hdev, segsize, segment,
 					    config->dnld_mode);
 		if (ret)
-			break;
+			goto out;
 
 		segment += segsize;
 	}
 
+	/* Latest qualcomm chipsets are not sending a command complete event
+	 * for every fw packet sent. They only respond with a vendor specific
+	 * event for the last packet. This optimization in the chip will
+	 * decrease the BT in initialization time. Here we will inject a command
+	 * complete event to avoid a command timeout error message.
+	 */
+	if ((config->dnld_type == ROME_SKIP_EVT_VSE_CC ||
+	    config->dnld_type == ROME_SKIP_EVT_VSE))
+		return qca_inject_cmd_complete_event(hdev);
+
+out:
 	release_firmware(fw);
 
 	return ret;
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 4c4fe2b5b7b7..595abcdaed2d 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -41,6 +41,8 @@
 #define QCA_WCN3990_POWERON_PULSE	0xFC
 #define QCA_WCN3990_POWEROFF_PULSE	0xC0
 
+#define QCA_HCI_CC_OPCODE		0xFC00
+
 enum qca_baudrate {
 	QCA_BAUDRATE_115200 	= 0,
 	QCA_BAUDRATE_57600,
@@ -82,6 +84,7 @@ struct rome_config {
 	char fwname[64];
 	uint8_t user_baud_rate;
 	enum rome_tlv_dnld_mode dnld_mode;
+	enum rome_tlv_dnld_mode dnld_type;
 };
 
 struct edl_event_hdr {
-- 
2.21.0.593.g511ec345e18-goog

