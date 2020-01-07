Return-Path: <SRS0=JtZ7=24=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1A5C3F68F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 07:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E40C206DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 07:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWYziAVU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgAGHlI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 02:41:08 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33235 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbgAGHlI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 02:41:08 -0500
Received: by mail-pj1-f66.google.com with SMTP id u63so5068121pjb.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jan 2020 23:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kLolv4TG5ez8jdcGtGB/+5OOu7TJYRnRQOtGX9bYVpg=;
        b=nWYziAVUD4no6c8qFh5bTsaxVWSDuLiJRpZVIvP7w4VT6bajfFjLpZjF0ES+eQQD+t
         ocVGTnmjPoZXykOR3oWrKrRgVzDjJbjeCNIekq+mUXcmWJOLiEGP1Mhl6My6Vm7uS0/S
         C/tvr/vg/Fl/zCjZMhXoCmEMAcAAeoHxXyRRpwtmziRkG2yamLPQSZPR/RyriAkyl34S
         M1AEGyMPBCuIuTb8DE9RH8vgnf5I/xGrWwRf4O6yTfMfBOYklRaDKJLNZqtBfDcTsFX3
         SsI0UCof4QQ1EYdAzmVf9QHxQyUdsP7TWdksHUNg7ga2Inv0cak60bHL6kAPZ9QL/HT/
         xOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kLolv4TG5ez8jdcGtGB/+5OOu7TJYRnRQOtGX9bYVpg=;
        b=JVprNlrCz8qWElxitXGQxf+SgOFZTrrOxn8x2ggpYw6+82NOR5tkEnWP9PV+DTGI28
         7yExyl5HClXv1zeuPBSKhb8I7rEHTy0kCae0yqda0iU+THX/rts4A4wZ3xu/AVePwpSi
         NZ4R070sNDxD8boTwM2gisqdPmSyJtmIPTn2CbHjwnGWoJT2HbMVvGcrQn5efXAqlXOm
         xn+AbF3LJTp+C+vzegO9g0uP9ouoxtol01aa3LqGxgiwMEBSS0dhtfhzGsyNmUbdLXxG
         aVZnrUKIIGeiW8gLfUudxV06QOZELG/+4S0Si9mvb9rJf9zcw1iCsKc2s/bOs6OBUpew
         RlNg==
X-Gm-Message-State: APjAAAVJT/SR+1WDGHwD63eTWwEto+wtJiP2pjmlzjhLIJgNR8/SCOQw
        uQYXjaJMBmwa1JH5SEtR0auGYBF/jYg=
X-Google-Smtp-Source: APXvYqzMfQBvQSac/odTDPEkBeQw3RpgzZQ2XUZOtYzT87FJ3B3c+ngFRHVslRSCODiR7GmyhGQ58g==
X-Received: by 2002:a17:902:b617:: with SMTP id b23mr102734286pls.285.1578382867545;
        Mon, 06 Jan 2020 23:41:07 -0800 (PST)
Received: from vudentzs-t460s.hsd1.or.comcast.net ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id k21sm67725388pfa.63.2020.01.06.23.41.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 23:41:06 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/10] Bluetooth: btusb: Add support for ISO packets
Date:   Mon,  6 Jan 2020 23:40:55 -0800
Message-Id: <20200107074056.25453-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200107074056.25453-1-luiz.dentz@gmail.com>
References: <20200107074056.25453-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enabled btusb driver to properly transmit ISO packets.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f5924f3e8b8d..ded0ba83bcce 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1463,6 +1463,13 @@ static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 		hdev->stat.sco_tx++;
 		return submit_tx_urb(hdev, urb);
+
+	case HCI_ISODATA_PKT:
+		urb = alloc_bulk_urb(hdev, skb);
+		if (IS_ERR(urb))
+			return PTR_ERR(urb);
+
+		return submit_or_queue_tx_urb(hdev, urb);
 	}
 
 	return -EILSEQ;
@@ -2123,6 +2130,13 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 
 		hdev->stat.sco_tx++;
 		return submit_tx_urb(hdev, urb);
+
+	case HCI_ISODATA_PKT:
+		urb = alloc_bulk_urb(hdev, skb);
+		if (IS_ERR(urb))
+			return PTR_ERR(urb);
+
+		return submit_or_queue_tx_urb(hdev, urb);
 	}
 
 	return -EILSEQ;
-- 
2.21.0

