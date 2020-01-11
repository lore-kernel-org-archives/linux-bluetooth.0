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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF986C33CA3
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Jan 2020 02:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9771820842
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Jan 2020 02:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRApdomP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgAKCW1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jan 2020 21:22:27 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42712 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbgAKCW0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jan 2020 21:22:26 -0500
Received: by mail-pl1-f193.google.com with SMTP id p9so1543682plk.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2020 18:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/7toxpl5PLp9wQq7+QMjAWMB9Nzp1ZtUr5PVHGbr8I4=;
        b=ZRApdomPdLh30W4kAVnEEnWhOErHEYp/PsapUGb1Cj88FMXtO66O7Z9nnaqJJpsHiE
         g6VUKpuQG6YuNYj0HxWT4Ag/Y+715CwwAIWniolZNcUUgRiQ9EPCng0SbIsZJoZjL0UX
         rC76yuXmwI0r+IOv/1n8waTBPC62Se/lJ8FPnUE/9LE6SW11KwE6ZSD+Ba5/a3ncYcEF
         X+KmP61z6AnG+bQz3mQjWpgk+JkNmSrlESp7s3UQxmG44KqWNC64SkipKgIJIUxeWcSf
         giFm6P1rYv8IKSBKyKGvuwjk52zD0x2tHTcGU8BzqR56YI9w99FxoEBg6+/dCjsK54sj
         N8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/7toxpl5PLp9wQq7+QMjAWMB9Nzp1ZtUr5PVHGbr8I4=;
        b=hbMCwQaGmsRowFza3aMSFdEyBq5FUlgvs4lk5FI3KPmMCcE1dxt4wgWvQB3HWIOTea
         VXE1DMWUrrijdfzh1isLD9se8UUX1jY/cYO1oqLZwMABVIp5VJtg7gt0urhkWRw136Mx
         jQuXZtotY9i5NaU4Iaxrx9JLZf1ZgSSeMWIIaJrgcPr8RYgoATT1/bfebENIA4avFm4x
         voobBmCPTiEnQfVEglgsa1xnPL12/yK0IhRHX4zlShMnQQ4ZUDx5QIlDu/vjFA8N5H4z
         SiL3mWb0xdQVbmko0UAPlcMM+KEsshsVfwEDAr55WVWCKYLxpSdKow4LfaYP1nDujWse
         iPkg==
X-Gm-Message-State: APjAAAXb7PDUcrlQffkafVjPWAu+xHg+yEazzt7OFaLij1XQaFGXrGoO
        PnKdnb4kyCLSkRgbz5gU4rGeJgbnj+s=
X-Google-Smtp-Source: APXvYqy+MTaKJ/TrxwTB38I6Ou3mLpg9QE90/lMpaVyrNPcJanMc3S4VwG07sw8Yxzm6GrLJtNs2QQ==
X-Received: by 2002:a17:90a:1a14:: with SMTP id 20mr8850577pjk.33.1578709345275;
        Fri, 10 Jan 2020 18:22:25 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id g22sm4158906pgk.85.2020.01.10.18.22.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 18:22:24 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 06/10] Bluetooth: monitor: Add support for ISO packets
Date:   Fri, 10 Jan 2020 18:22:12 -0800
Message-Id: <20200111022216.30842-7-luiz.dentz@gmail.com>
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

This enables passing ISO packets to the monitor socket.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_mon.h | 2 ++
 net/bluetooth/hci_sock.c        | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/net/bluetooth/hci_mon.h b/include/net/bluetooth/hci_mon.h
index 240786b04a46..2d5fcda1bcd0 100644
--- a/include/net/bluetooth/hci_mon.h
+++ b/include/net/bluetooth/hci_mon.h
@@ -49,6 +49,8 @@ struct hci_mon_hdr {
 #define HCI_MON_CTRL_CLOSE	15
 #define HCI_MON_CTRL_COMMAND	16
 #define HCI_MON_CTRL_EVENT	17
+#define HCI_MON_ISO_TX_PKT	18
+#define HCI_MON_ISO_RX_PKT	19
 
 struct hci_mon_new_index {
 	__u8		type;
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 5d0ed28c0d3a..3ae508674ef7 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -324,6 +324,12 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
 		else
 			opcode = cpu_to_le16(HCI_MON_SCO_TX_PKT);
 		break;
+	case HCI_ISODATA_PKT:
+		if (bt_cb(skb)->incoming)
+			opcode = cpu_to_le16(HCI_MON_ISO_RX_PKT);
+		else
+			opcode = cpu_to_le16(HCI_MON_ISO_TX_PKT);
+		break;
 	case HCI_DIAG_PKT:
 		opcode = cpu_to_le16(HCI_MON_VENDOR_DIAG);
 		break;
-- 
2.21.0

