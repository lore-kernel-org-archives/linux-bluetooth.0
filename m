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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D93C33C99
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 07:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BD3206DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 07:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vUaCCEH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbgAGHlI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 02:41:08 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54483 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgAGHlI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 02:41:08 -0500
Received: by mail-pj1-f67.google.com with SMTP id kx11so8654276pjb.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jan 2020 23:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YFd0JhZ0fswhsnoF6yQcdQAaq0by6LcXYedQoF+YTDc=;
        b=vUaCCEH/Xw9x4xcBzVtZSdyivoRCZ7NcwKuuQnCxniiD+oeNLGlNKF/k0kePTHt5lm
         ZFQ8sh2yOtJohYM1TNuKpsJRB6+lw0cqCOZPJ3ir4RIm80spq59kwtobMCMqilhcrWu7
         Gpd61iC4Oi9LFMprdtncTDVCY83/OkHSblMuZ+EDJTsj1XAQ5zB4XNPZDIkT6x9z9xvI
         /mdutbP2oDjzrHtQKNJFBTPjHP9EfjWPUbthujK0P/spw+6/gbCFU+TlnZ6Dwy0MK+M2
         ZEaeNOdxAWMcplolv12LgYP7Grro0BXHmzP54YIqHeQcjYwlejzeumNT+VfTxPaakYJf
         OSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YFd0JhZ0fswhsnoF6yQcdQAaq0by6LcXYedQoF+YTDc=;
        b=mQL2MqL5vcSR+0o8Xn6zWdN05ADgsFZE3Sa1Bw7Yo6LbTydIeJwWQ86ylkz6+Snsmo
         ttis65JM0d6GCkJFrdDDHuWVCZMLV+SG2eXeik3ppF8nZzi9azCJAQAH9GiNYGDqkJRf
         YyLPjL910mNWooAcQDs5xaTDmam0QiRWZmouDcAvk90gz+Ix1H8QfWEz/NV1zkdPR+tC
         JedtXZARZZ+Rm4IXk24PSWZdOMN2X3UnaIfEn3/oQMAwJNZ6Wf17JEqgFZAMvFw+wbHN
         Tyo32kdyl+arjZywB1yFNxa5Gc3ZKcZAPzqzFB1n3x6HJPhTVLGTiLWPmEs92qHTwSvy
         nqqA==
X-Gm-Message-State: APjAAAXWaNlldkSRu15hPIMen2lgu37fsjsL/JCT1+CBik64cqF2wJG/
        AQ52UToV51LcLCEZhtAuWdOVdOzECjE=
X-Google-Smtp-Source: APXvYqzavHbCum1SiQ5ZAUhqAu+gVHN+DEoHUmJFX1bqDDzhkgGilY3TSzZiwh8/0gypeKOGB8l4Iw==
X-Received: by 2002:a17:90a:e2d4:: with SMTP id fr20mr48944535pjb.85.1578382866634;
        Mon, 06 Jan 2020 23:41:06 -0800 (PST)
Received: from vudentzs-t460s.hsd1.or.comcast.net ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id k21sm67725388pfa.63.2020.01.06.23.41.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 23:41:05 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/10] Bluetooth: hci_h4: Add support for ISO packets
Date:   Mon,  6 Jan 2020 23:40:54 -0800
Message-Id: <20200107074056.25453-9-luiz.dentz@gmail.com>
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

This enabled H4 driver to properly handle ISO packets.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/hci_h4.c   | 1 +
 drivers/bluetooth/hci_uart.h | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index 19ba52005009..6dc1fbeb564b 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -103,6 +103,7 @@ static const struct h4_recv_pkt h4_recv_pkts[] = {
 	{ H4_RECV_ACL,   .recv = hci_recv_frame },
 	{ H4_RECV_SCO,   .recv = hci_recv_frame },
 	{ H4_RECV_EVENT, .recv = hci_recv_frame },
+	{ H4_RECV_ISO,   .recv = hci_recv_frame },
 };
 
 /* Recv data */
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 6ab631101019..4e039d7a16f8 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -143,6 +143,13 @@ struct h4_recv_pkt {
 	.lsize = 1, \
 	.maxlen = HCI_MAX_EVENT_SIZE
 
+#define H4_RECV_ISO \
+	.type = HCI_ISODATA_PKT, \
+	.hlen = HCI_ISO_HDR_SIZE, \
+	.loff = 2, \
+	.lsize = 2, \
+	.maxlen = HCI_MAX_FRAME_SIZE \
+
 struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
 			    const unsigned char *buffer, int count,
 			    const struct h4_recv_pkt *pkts, int pkts_count);
-- 
2.21.0

