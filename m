Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822EFEB64DA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jul 2023 22:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjGTWUw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Jul 2023 18:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGTWUq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Jul 2023 18:20:46 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF6A2D57
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jul 2023 15:20:19 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6682909acadso888222b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jul 2023 15:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689891596; x=1690496396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YN5/G/u7O9LH7esUEl5mcO0xhdLZqRJRZQsHaTmhTEI=;
        b=P0cJPxShTRtdDr4LKDFImjMKFdtAyZEIJei+MtQY9Dc0g6B0NyNEkjYAb9HsKWgVFc
         XK9XNBDPw5RZTUt53aoGzOtsFNxLHj2OgLpiRaAbaZs2vfoYS0+jTaQG3r/iDXl8WfGf
         YfKu87r9WpOMRFxE1qXSiuC3nrakn+gbgoBhsSbHofxRz/Uz7SPdCYuqyaxo8fxOw5+3
         Ccoa3hATbqGHp6VZOrnAwDbUYbUQ6BNPlV3M+XG1DrZPkCfJpHjQ4L4RnzXTLdGi1WLW
         EdYtobube+FwiqgFl/pEEpUA63QWlKrtov4OSNHa0zvPiEF9VyiCfUK/Dhrap2/dlqPx
         8nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689891596; x=1690496396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YN5/G/u7O9LH7esUEl5mcO0xhdLZqRJRZQsHaTmhTEI=;
        b=PnqGlnWV2NYz7/d+d85dfK8EuvpsQwKNpTfZ4cURwujtjmopK3Pp0p2sJKu2gsA0qM
         nl5WWAewpmdE1V901uCC3ggbk8oPGdsnsNA2IaR++oHdeVKIegKbfWW3CCBDmziHtqqk
         H0Di4SzWvXXdnHFl8IuceqttZA+8saEPyurlHPAKwBQfhd+4CG/7x3NkYEyeafftXxyZ
         Xv3cwkL+uadV76zHxi5GDdPauXo0jRusFmJlvOALyys4rg2OfdcGujh3pRRnHksRf0P+
         +C6CH+ym0ZYAV18/PPr8Pk+zncnVFI6BeIaRFVfzOWXavEo1a3svB1WTLPG9TwP/B64L
         GKEQ==
X-Gm-Message-State: ABy/qLZ/vTlo7sSgkwueVsupCVY/FqaUhRvYXrR/NeaYGBmUOgg/uu1n
        RnwueotZDxL2ur2J12jCbR8F0UHdex8=
X-Google-Smtp-Source: APBJJlHBHOzJCw0bt2mx6W5/BjyDTSxiNnNmKvkfgb4oZanAmZr6ZF2RNG3vLOAYvQaVMrSaPp93nw==
X-Received: by 2002:a05:6a20:9684:b0:133:5eca:a8aa with SMTP id hp4-20020a056a20968400b001335ecaa8aamr147919pzc.46.1689891596466;
        Thu, 20 Jul 2023 15:19:56 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902744400b001b8903d6773sm1912634plt.85.2023.07.20.15.19.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 15:19:55 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Move btusb_recv_event_intel to btintel
Date:   Thu, 20 Jul 2023 15:19:54 -0700
Message-ID: <20230720221954.517948-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

btusb_recv_event_intel is specific to Intel controllers therefore it
shall be placed inside btintel.c so btusb don't have a mix of vendor
specific code with the generic parts.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btintel.c | 74 ++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |  1 +
 drivers/bluetooth/btusb.c   | 75 +------------------------------------
 3 files changed, 76 insertions(+), 74 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index b32277cb045d..633e8d9bf58f 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2948,6 +2948,80 @@ int btintel_configure_setup(struct hci_dev *hdev, const char *driver_name)
 }
 EXPORT_SYMBOL_GPL(btintel_configure_setup);
 
+static int btintel_diagnostics(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct intel_tlv *tlv = (void *)&skb->data[5];
+
+	/* The first event is always an event type TLV */
+	if (tlv->type != INTEL_TLV_TYPE_ID)
+		goto recv_frame;
+
+	switch (tlv->val[0]) {
+	case INTEL_TLV_SYSTEM_EXCEPTION:
+	case INTEL_TLV_FATAL_EXCEPTION:
+	case INTEL_TLV_DEBUG_EXCEPTION:
+	case INTEL_TLV_TEST_EXCEPTION:
+		/* Generate devcoredump from exception */
+		if (!hci_devcd_init(hdev, skb->len)) {
+			hci_devcd_append(hdev, skb);
+			hci_devcd_complete(hdev);
+		} else {
+			bt_dev_err(hdev, "Failed to generate devcoredump");
+			kfree_skb(skb);
+		}
+		return 0;
+	default:
+		bt_dev_err(hdev, "Invalid exception type %02X", tlv->val[0]);
+	}
+
+recv_frame:
+	return hci_recv_frame(hdev, skb);
+}
+
+int btintel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_event_hdr *hdr = (void *)skb->data;
+	const char diagnostics_hdr[] = { 0x87, 0x80, 0x03 };
+
+	if (skb->len > HCI_EVENT_HDR_SIZE && hdr->evt == 0xff &&
+	    hdr->plen > 0) {
+		const void *ptr = skb->data + HCI_EVENT_HDR_SIZE + 1;
+		unsigned int len = skb->len - HCI_EVENT_HDR_SIZE - 1;
+
+		if (btintel_test_flag(hdev, INTEL_BOOTLOADER)) {
+			switch (skb->data[2]) {
+			case 0x02:
+				/* When switching to the operational firmware
+				 * the device sends a vendor specific event
+				 * indicating that the bootup completed.
+				 */
+				btintel_bootup(hdev, ptr, len);
+				break;
+			case 0x06:
+				/* When the firmware loading completes the
+				 * device sends out a vendor specific event
+				 * indicating the result of the firmware
+				 * loading.
+				 */
+				btintel_secure_send_result(hdev, ptr, len);
+				break;
+			}
+		}
+
+		/* Handle all diagnostics events separately. May still call
+		 * hci_recv_frame.
+		 */
+		if (len >= sizeof(diagnostics_hdr) &&
+		    memcmp(&skb->data[2], diagnostics_hdr,
+			   sizeof(diagnostics_hdr)) == 0) {
+			return btintel_diagnostics(hdev, skb);
+		}
+	}
+
+	return hci_recv_frame(hdev, skb);
+}
+EXPORT_SYMBOL_GPL(btintel_recv_event);
+
 void btintel_bootup(struct hci_dev *hdev, const void *ptr, unsigned int len)
 {
 	const struct intel_bootup *evt = ptr;
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 7fd29ef038bd..2ed646609dee 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -222,6 +222,7 @@ int btintel_read_boot_params(struct hci_dev *hdev,
 int btintel_download_firmware(struct hci_dev *dev, struct intel_version *ver,
 			      const struct firmware *fw, u32 *boot_param);
 int btintel_configure_setup(struct hci_dev *hdev, const char *driver_name);
+int btintel_recv_event(struct hci_dev *hdev, struct sk_buff *skb);
 void btintel_bootup(struct hci_dev *hdev, const void *ptr, unsigned int len);
 void btintel_secure_send_result(struct hci_dev *hdev,
 				const void *ptr, unsigned int len);
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 96395994eb1f..68ea9ee6b062 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2495,79 +2495,6 @@ static int btusb_recv_bulk_intel(struct btusb_data *data, void *buffer,
 	return btusb_recv_bulk(data, buffer, count);
 }
 
-static int btusb_intel_diagnostics(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	struct intel_tlv *tlv = (void *)&skb->data[5];
-
-	/* The first event is always an event type TLV */
-	if (tlv->type != INTEL_TLV_TYPE_ID)
-		goto recv_frame;
-
-	switch (tlv->val[0]) {
-	case INTEL_TLV_SYSTEM_EXCEPTION:
-	case INTEL_TLV_FATAL_EXCEPTION:
-	case INTEL_TLV_DEBUG_EXCEPTION:
-	case INTEL_TLV_TEST_EXCEPTION:
-		/* Generate devcoredump from exception */
-		if (!hci_devcd_init(hdev, skb->len)) {
-			hci_devcd_append(hdev, skb);
-			hci_devcd_complete(hdev);
-		} else {
-			bt_dev_err(hdev, "Failed to generate devcoredump");
-			kfree_skb(skb);
-		}
-		return 0;
-	default:
-		bt_dev_err(hdev, "Invalid exception type %02X", tlv->val[0]);
-	}
-
-recv_frame:
-	return hci_recv_frame(hdev, skb);
-}
-
-static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	struct hci_event_hdr *hdr = (void *)skb->data;
-	const char diagnostics_hdr[] = { 0x87, 0x80, 0x03 };
-
-	if (skb->len > HCI_EVENT_HDR_SIZE && hdr->evt == 0xff &&
-	    hdr->plen > 0) {
-		const void *ptr = skb->data + HCI_EVENT_HDR_SIZE + 1;
-		unsigned int len = skb->len - HCI_EVENT_HDR_SIZE - 1;
-
-		if (btintel_test_flag(hdev, INTEL_BOOTLOADER)) {
-			switch (skb->data[2]) {
-			case 0x02:
-				/* When switching to the operational firmware
-				 * the device sends a vendor specific event
-				 * indicating that the bootup completed.
-				 */
-				btintel_bootup(hdev, ptr, len);
-				break;
-			case 0x06:
-				/* When the firmware loading completes the
-				 * device sends out a vendor specific event
-				 * indicating the result of the firmware
-				 * loading.
-				 */
-				btintel_secure_send_result(hdev, ptr, len);
-				break;
-			}
-		}
-
-		/* Handle all diagnostics events separately. May still call
-		 * hci_recv_frame.
-		 */
-		if (len >= sizeof(diagnostics_hdr) &&
-		    memcmp(&skb->data[2], diagnostics_hdr,
-			   sizeof(diagnostics_hdr)) == 0) {
-			return btusb_intel_diagnostics(hdev, skb);
-		}
-	}
-
-	return hci_recv_frame(hdev, skb);
-}
-
 static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct urb *urb;
@@ -4353,7 +4280,7 @@ static int btusb_probe(struct usb_interface *intf,
 		priv_size += sizeof(struct btintel_data);
 
 		/* Override the rx handlers */
-		data->recv_event = btusb_recv_event_intel;
+		data->recv_event = btintel_recv_event;
 		data->recv_bulk = btusb_recv_bulk_intel;
 	} else if (id->driver_info & BTUSB_REALTEK) {
 		/* Allocate extra space for Realtek device */
-- 
2.41.0

