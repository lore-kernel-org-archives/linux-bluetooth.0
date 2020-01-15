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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBF7C32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 21:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F55A207FF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 21:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uruovyy+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbgAOVCh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:02:37 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40111 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbgAOVCg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 16:02:36 -0500
Received: by mail-pg1-f195.google.com with SMTP id k25so8764591pgt.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2020 13:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MUE2IHxfflZ8pLtwZKHIQX59YaKDGxYsemUMZS+ZXM4=;
        b=Uruovyy+5eJDhoqzNZ1wLSQ8U0Fu2YRSlayPy2qgYA0pzkuGAtL+A5jPEiXtDk8XsH
         gpGdcmhxFjkXihi83OxzexRZzX64YAQrU293h3n/unFotckixwDkziqf28CEWqewKd1V
         WT2JBlFs6UcWAH2aNRkfM1yzwhZHKZmBHz9ZDxdeXAk562v+I61U1QXeRH3GI7Yao/sh
         aHP046/bOo0K8+hFKzCW3Gke+AtCeT7aZs1jJ6bEKEWo+sTxVqzXrDwesRFI9yWsoBh9
         G6Amwbh++q8w/Swr9WBr0RLxgwN0JJGdYu7Ia24H3ZTMCDQXhzOs4PYxsxVGc4YcoeDF
         UM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MUE2IHxfflZ8pLtwZKHIQX59YaKDGxYsemUMZS+ZXM4=;
        b=b10XGzW4PdX/Q/MPBY5/04zeEfNEjzM3u7vT4LWaYMGF7PwghoVEAQuiiP3dZJuo7X
         jvtna7ybJ7awMyvrNhrOnNHa5WexeViPhAw+yUfgnPrnLUtLsf59o8sZEflmfVeRgeuK
         Z4wAJCzoDTb7OBIpEDCcMrSpXej7MvhyI0ehWKRLkygVb32keZ/iK9o7XeyYfYiNYwd0
         wCkmplPn0esmR35TWwlzQZtqnzSt49cefAdpmp45i88SD1ErNHi8m89T+c5TaSakOvFy
         9iSeLzp4bTfIgWg+LaQBKUeeNJWoZFCLWPxfiJnVZuk7u89jcS7zeIFs6Vy3pgvRQg+1
         XDag==
X-Gm-Message-State: APjAAAWVldmaZXa6mNt6410ytCI6S9VmLXocI4qiFyYxRWNoVrwjBKV7
        6zsuXksK3XHbDhSDVGuszSmxo5ml4I8=
X-Google-Smtp-Source: APXvYqwSBmBFuwoHKmnY6AeoBD+gvKQeGnZr4CUb/eyWdajd1oLk1CAXMXnRW5M5Ihm6Ln68jfWu+Q==
X-Received: by 2002:a62:2e41:: with SMTP id u62mr33390951pfu.248.1579122155663;
        Wed, 15 Jan 2020 13:02:35 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.41])
        by smtp.gmail.com with ESMTPSA id s24sm23290976pfd.161.2020.01.15.13.02.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 13:02:34 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 10/11] Bluetooth: hci_h5: Add support for ISO packets
Date:   Wed, 15 Jan 2020 13:02:20 -0800
Message-Id: <20200115210221.13096-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115210221.13096-1-luiz.dentz@gmail.com>
References: <20200115210221.13096-1-luiz.dentz@gmail.com>
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

