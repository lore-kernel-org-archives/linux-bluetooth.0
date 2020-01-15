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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BD6C33CB7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B91A2187F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrPJedb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgAOGgn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 01:36:43 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45456 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbgAOGgn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 01:36:43 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so8009932pfg.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2020 22:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/7toxpl5PLp9wQq7+QMjAWMB9Nzp1ZtUr5PVHGbr8I4=;
        b=RrPJedb4cUsvEOEvLNUYlqfqzB3Pd3t//gkbN6gFxMyUNnDGgb1CHVVBJn/iTDtihX
         Ms7yEBbF4fE08iGV2KBfPDg0hLZR5jIQ0tLpklx3t+BkIpRG260fdw95B4wihLbVHSKW
         sjMiXemyTwoagymw7QdsAv+xYOKMPGCIevNJtkeujs4ooSpLJKZULOgtOyQy/YR7v5jn
         zF+39q4aK2XUshIyMRFbh8Ji2wGYh+7VVUP8lcUM5+G2lDJKcR88g8ctP/NH9iXbnA/e
         G31feUCRZ3WZA8TAgajLvWL7pPHRvoK4Q/PPeXgeAdwns4D981QLzA2SsN8aswqkXwx2
         4psw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/7toxpl5PLp9wQq7+QMjAWMB9Nzp1ZtUr5PVHGbr8I4=;
        b=XpcvLtxyvvIOh9jHOm62xwsD2IcqN1x1/5NRguVPAeyX7RyT6e4m3zHWhKvUASv615
         76JSMThyDgUEYR4RVc7J5TcgDGvt8VjAyiIWKZJAQ/M9exNcu8qR9YmGE5rJNBTJqROK
         PYb9/RSTEc5Ah0drVVPycacul0F9a8QdXaFfR54L64Nk9QB7P9PzG/vAp1xxGswxcaQ/
         GVk9sF8NgIs6OlzeQGAMkO3/NEO/LJOGU+RMbKGzaU1glHcFPmfhqh3L9MWaYTtO70N6
         ID3gIlGPb7piKy21n+fP9XDrX3erYOL/pb7rPo0Up1XMDg8sEUgLuGDKxQ10RwCYY9jI
         tBsg==
X-Gm-Message-State: APjAAAUOlxInubFp3ZasYu+VDrt8/I/+lyVHSjAkKKENxIpnkOxQ9mfO
        a0aVBP6+I2NK7LVfvFZstYg/B7dEKUE=
X-Google-Smtp-Source: APXvYqw4Bfoi3wTXvI2royDIXsBQkD0vanLp6AtCctPAADkdUvl34cXVVWbSx03keLJDpIuKqVKTew==
X-Received: by 2002:a62:3892:: with SMTP id f140mr29070197pfa.190.1579070202315;
        Tue, 14 Jan 2020 22:36:42 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id z19sm19725594pfn.49.2020.01.14.22.36.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 22:36:41 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 07/11] Bluetooth: monitor: Add support for ISO packets
Date:   Tue, 14 Jan 2020 22:36:29 -0800
Message-Id: <20200115063633.32441-8-luiz.dentz@gmail.com>
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

