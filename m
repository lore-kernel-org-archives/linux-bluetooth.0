Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D37C33CB1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349012187F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfqaOTr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgAOGgp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 01:36:45 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37784 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729163AbgAOGgp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 01:36:45 -0500
Received: by mail-pj1-f66.google.com with SMTP id m13so7230515pjb.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2020 22:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/0l7XUV8UWV7OGtRGpnQ/sdmhdQTT9hpq4idu/sT62U=;
        b=WfqaOTr6Rdawg8/BN4rUDjJ12R2Jz/87ywtTK3UqPMNDalk85HmpQUhjELOlEkoJXC
         UIqteietT+z+wFxgD11TEwp3y3xXitv2LA2I2BTdCH6wTlXkbiadwAlBpRLtZfSUExXE
         PLV1YhF4EkyEv+W+oBRvvRuBfJrc4FkixUIbbXUioOsXFB6WhwGAdoHJDt/YohZLHSrE
         jmRdMOrFA5jNiUBQ2NPdwkt11i3cyRsoUYcLjyC0g864neRooMlfvz0AeDCHv/f0yIMv
         J2LDHA4pUpNBUzMvt1w1yi2QCac4j4wr1ZHs1pHxr3ejV5ZkGj/wVtFUZ2vNGnCUi+/F
         hFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/0l7XUV8UWV7OGtRGpnQ/sdmhdQTT9hpq4idu/sT62U=;
        b=VAx2GPJDnZSziVTIKnCJodlrlEuWEe2a/9H27Iu7dO8sP+pRA/lFlnTc56om7NkULf
         O4Prc4h7c3uZl7FuTVxzwPYlAWsOQT6uASmB5SrDtypeklZnclfVvkfXrnWndok0Q8Jc
         F6r1jNr8XdD9QW2aFDhpk2pz73UnRKT9WgyavL9bhAe1PIvS3coDnOsYGMQf5+cjGCq9
         TlLAFRCbO+XoTNOTpsFP0HxVWuulQu7KSq967TIj2rv0EatwPU3OKOUDd/pVKEc1BDvt
         1gtL44UziSAwLxhkFsZnJONYJaMB6wWb3Kw1cKuHf1ZbyaQUCsL2TbDMG+L6go26cMkK
         Xknw==
X-Gm-Message-State: APjAAAU252/S+yu4IeROJ36w1exGv88FNMepDrcKxFANQSAzWqecBGx0
        mu2fTj2+p/uFUxMitGxGmxlmq6n6p7k=
X-Google-Smtp-Source: APXvYqwPTzUt42T5JtqUX/rt5PRAjM4GlPtLqA2WsUcO9Jv8Ahw/6fyvNwlWHLaaH0o1igRtB7vx2w==
X-Received: by 2002:a17:90a:2a06:: with SMTP id i6mr34120243pjd.97.1579070204243;
        Tue, 14 Jan 2020 22:36:44 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id z19sm19725594pfn.49.2020.01.14.22.36.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 22:36:43 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 09/11] Bluetooth: hci_h4: Add support for ISO packets
Date:   Tue, 14 Jan 2020 22:36:31 -0800
Message-Id: <20200115063633.32441-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115063633.32441-1-luiz.dentz@gmail.com>
References: <20200115063633.32441-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables H4 driver to properly handle ISO packets.

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

