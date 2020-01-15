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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B800C33CB2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F302187F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UG/1UViD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgAOGgq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 01:36:46 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37881 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbgAOGgq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 01:36:46 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so8027361pfn.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2020 22:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MUE2IHxfflZ8pLtwZKHIQX59YaKDGxYsemUMZS+ZXM4=;
        b=UG/1UViDnR2qzEZIx8W9A2rSvl7/c/YxMseQq1aDWQH/kjtY65R3ZwkVkZyfWFPF5/
         FtPEeMv6l3ggP0aweqwQe37k+ZL42+1zznb1lSff6clFUaETAOtdzQFY63teVbh6g9Qq
         peB8TnRajEjMs+g1xOdY7GTABZUGEZAoMQjKN+b7R5B3BawJIEV4PIJSm/7D/yJ91q3M
         P4rTyqPijWamOC3KQtTejoUMG50Zjhkcn31o+Abw8AIOr/c+3Mb9OQ72zjkWuuj9lAhX
         Et8zz2PqwbtYPKV0QESUDHdr1dlVKrUKzLH4s5fst+tx4E3WpLoutLeMULqo9GLn0Tsh
         yBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MUE2IHxfflZ8pLtwZKHIQX59YaKDGxYsemUMZS+ZXM4=;
        b=Dip+yYwryIRKvsfFzUusjWdLK6bB8051XCFNGhVg3SUqTi2NP9IEtdN6W2b3LLUUCp
         5OpuAuC+/LkW/Wi68+gg+w0KMqylQp5XDfoMY4TMCzSquv//cSp/iboHtOnXpzuCW6bP
         qGkLaoH9/gKu+NOv+1vZHDEsgo2B5NV5oUHFBKIUpE0v1GLcru25wisdFaIVNyDA+DbL
         VXo2yNXXpmVPfTpiNTHUJ5QX5qgzD50ExxwvAnvyTCbHclGoK2cau6/KyUyYPD/W4Xoj
         GRUvczS2bOI0niIN9N9dSdfi8B71VMV9Kii3JwwKMGQMwiThrZwaSEW4bTlg22qrwRsX
         WtgA==
X-Gm-Message-State: APjAAAXoO78/D/v/PmVfLFNe8hppKpwX5Emg6iZjx8z5HlfceVBQScIU
        2ZceQfWyb76z5H9lRyBaVespwMBNNfY=
X-Google-Smtp-Source: APXvYqwdXfDyu3FGZVVawjzhlL8xJqoDKXXPZs8hoVYPO7lGIzXWHoGyazKzSUZKB6SzzFbTpg+bcg==
X-Received: by 2002:a63:5b59:: with SMTP id l25mr32192038pgm.382.1579070205302;
        Tue, 14 Jan 2020 22:36:45 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id z19sm19725594pfn.49.2020.01.14.22.36.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 22:36:44 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 10/11] Bluetooth: hci_h5: Add support for ISO packets
Date:   Tue, 14 Jan 2020 22:36:32 -0800
Message-Id: <20200115063633.32441-11-luiz.dentz@gmail.com>
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

This enables H5 driver to properly handle ISO packets.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/hci_h5.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index dacf297baf59..0b14547482a7 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -385,6 +385,7 @@ static void h5_complete_rx_pkt(struct hci_uart *hu)
 	case HCI_EVENT_PKT:
 	case HCI_ACLDATA_PKT:
 	case HCI_SCODATA_PKT:
+	case HCI_ISODATA_PKT:
 		hci_skb_pkt_type(h5->rx_skb) = H5_HDR_PKT_TYPE(hdr);
 
 		/* Remove Three-wire header */
@@ -594,6 +595,7 @@ static int h5_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 		break;
 
 	case HCI_SCODATA_PKT:
+	case HCI_ISODATA_PKT:
 		skb_queue_tail(&h5->unrel, skb);
 		break;
 
@@ -636,6 +638,7 @@ static bool valid_packet_type(u8 type)
 	case HCI_ACLDATA_PKT:
 	case HCI_COMMAND_PKT:
 	case HCI_SCODATA_PKT:
+	case HCI_ISODATA_PKT:
 	case HCI_3WIRE_LINK_PKT:
 	case HCI_3WIRE_ACK_PKT:
 		return true;
-- 
2.21.0

