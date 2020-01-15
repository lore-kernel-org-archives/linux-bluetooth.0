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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C101C33C9E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 01:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328F924679
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 01:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmyP/+NF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgAOB7a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jan 2020 20:59:30 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53847 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgAOB7a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jan 2020 20:59:30 -0500
Received: by mail-pj1-f67.google.com with SMTP id n96so6646757pjc.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2020 17:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YFd0JhZ0fswhsnoF6yQcdQAaq0by6LcXYedQoF+YTDc=;
        b=LmyP/+NFhDfNcevu+kCvzpVuS3D1BYcNSzb77ismHgTiUzRVKq0QBYY5QfjMFYuuc3
         +bl/4hlfAu+rlOoKUGyQq8NSz/qC0dNrs9tiZzTY168vrNCP0nDmGf1CE/xJp+aAZb7U
         AulE0MI/F6duycGmTu/iH4eutFaL/J6m47fwKf7QbeQwoz4dXQymp7hCE+HvSpKsDDDQ
         Ie5RexuFYrjV/zPq+WV8R7VzW+HJGn2RNkCrGxQ1yf6VYuYzhl2Ss3Ia25e6KKUFs7kj
         DOM4BuRClQ5LhbnNrwxHJdbvED+g1pPKJgfx9HUbpjn4lVUv0YADMIsuVWcNNC6a8udu
         iOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YFd0JhZ0fswhsnoF6yQcdQAaq0by6LcXYedQoF+YTDc=;
        b=MQ+ISwJ0GtRC3aNMKRf69DcwQuavIF9sexLwOxr1UvyfTKIdBSx5h9MwUeGR8RJ4g1
         rQ2Rd5xyRz4j5eaw/ewL9W7tlJjpDfFtwrkeZzF7YHu1fATbdCptYy04BbKK03xK1z70
         zQPaNY6d7smFMzwunfEboohZw7zNBqsO0Jfoq2zX6RFAh15tRk37uamnCQG3R7dzfG7k
         GYKVrzQWmagCzkleKMpG7prXt+kd8Nk43L1IgQzZqgT6JE0MSNggr4rLCWBFU5GkrgP+
         VSIZygOOniMlFRRNQYuFW7PCB1HIpZ5/EBVM7hQq02wsFWmxTZ87txs4R5NbpyVhq9Df
         mJpw==
X-Gm-Message-State: APjAAAUuhGz+4LseZ7JIbqxhJgN03vQnOERtbg/avfFzNbElMvGTBsfk
        M8gRcODr+uJnmcE8flMHVVJhgxrpbAU=
X-Google-Smtp-Source: APXvYqwBdC7NbCHUv1ZpR07Kv/VZpEK/GeSxFaFhBBlMINdDnLyZpbzDejDixYtRrdrsY6GXfHeyiw==
X-Received: by 2002:a17:902:6501:: with SMTP id b1mr23776863plk.121.1579053569303;
        Tue, 14 Jan 2020 17:59:29 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id q10sm20263573pfn.5.2020.01.14.17.59.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 17:59:28 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 8/8] Bluetooth: hci_h4: Add support for ISO packets
Date:   Tue, 14 Jan 2020 17:59:18 -0800
Message-Id: <20200115015918.1187-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115015918.1187-1-luiz.dentz@gmail.com>
References: <20200115015918.1187-1-luiz.dentz@gmail.com>
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

