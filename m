Return-Path: <SRS0=d6qz=3A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A19CC33CA4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Jan 2020 02:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A6A2072E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Jan 2020 02:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3ezFXBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgAKCWa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jan 2020 21:22:30 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33649 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbgAKCW3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jan 2020 21:22:29 -0500
Received: by mail-pl1-f193.google.com with SMTP id ay11so1557780plb.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2020 18:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kLolv4TG5ez8jdcGtGB/+5OOu7TJYRnRQOtGX9bYVpg=;
        b=S3ezFXBHtQq7NqfO9JD+ujiyRxsjGTwrBRKtM0H/TTy8e/98uYKb6EGAr9NFi4BTyy
         okJxzJqZNKHQgnpWivsscMzyyAYQtt71KU2I8UbCva/NSqC6NL2mIrzflzb7K2dkrQZt
         nfAF5hANuRje+D1YIsuFGJ6RQRID00azl5lNPTno7dU/I0TUnJC1vdjq72IlEZuMEAal
         FMeb4PiBZr981QxO/sOshJJgrayzxaZG9z7Q8cuWt9LrzvuQxPQ4uhcbdo0uyqiFDWxp
         yMqFnAsKyMY2NUOuDhKDHaCGuIPvU7LhGw8FDjeyj9GXR44/C6f4tOltvsOkQW6vQm28
         YP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kLolv4TG5ez8jdcGtGB/+5OOu7TJYRnRQOtGX9bYVpg=;
        b=aFCNVEDeh+5EdhFnTMtG84hIpxtEeA3phUsxtsTD3JHb2LpyW1OssOWkhf+F22y9pu
         t44zZisb4R3BHZy+dWK6C/NcPEMpf/x353iU7at9U6edJpkilx5ou6xd+Ps76cr+5zZW
         M8+/o+QMAmMSKRSll68tCUprlu2IHwxPcAD0B+uSYRAiYzOO0YdPcf42X/5+z1EkYxcb
         baou+5GGfYGkgYc2YI+o/EU/vesgumuFORrxjQtMcZHXGXk35hmSE/lV7zHgDlyBFUG9
         oSjHg55AoIkF0+KFCd4RQbp2dltBfbwF6iLzflX3ztoTs5WFKSlATQVnVcFBBt1pBKr6
         em8A==
X-Gm-Message-State: APjAAAXIWYyk/O1pd24rCfACEX4XiRVgp0wvn0BUhE5CXstyGvFRF/aG
        6NC0uqrmjt6F5y5vWhGaiId9xl8tWlE=
X-Google-Smtp-Source: APXvYqwiWKIjmBDa1dK0aDTsdVysWEFDfqTdpKtX6GQAAWPHO6Du7n60brWbbz/f8wil6h14O8VLXQ==
X-Received: by 2002:a17:90b:941:: with SMTP id dw1mr8825953pjb.21.1578709348547;
        Fri, 10 Jan 2020 18:22:28 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id g22sm4158906pgk.85.2020.01.10.18.22.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 18:22:27 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 09/10] Bluetooth: btusb: Add support for ISO packets
Date:   Fri, 10 Jan 2020 18:22:15 -0800
Message-Id: <20200111022216.30842-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200111022216.30842-1-luiz.dentz@gmail.com>
References: <20200111022216.30842-1-luiz.dentz@gmail.com>
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

