Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34087C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 18:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbiAYSxs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jan 2022 13:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbiAYSxI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jan 2022 13:53:08 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D774C06173D
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 10:53:07 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id i1so2551352pla.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 10:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BVRbbIrLpveGd+iHJYXgT+f4DhwBDfQUgT8q21QlbcA=;
        b=aIUTOdAGASlO+2pb16jScivHxKqUsP8enb3CCRovCkbI5jFluNUcjMftzYAjSK4UN+
         QdPcr3R7+YHTXKbp1iMnZ0E9ujwpC2iUQEfHKECfgDjB/4i8CmMXzntKFTfBeE+KGWve
         4winqj557XVeudoh9NgOc2Dsk+3KpG4IsUnfbZdXcX6qk0qu/6AtrMD6YgSqxhnn8SnF
         anums6dGRvpDw6P5Q+pjAfTp79h0Q8parTbdF7VDSJo8vatlzzJI1LBprHUsaQoxVqgN
         BfqQVanToKySxkSGEO5sFkcmnyfj0SlCJvad2iyyVrHZ98yG0CQ3q3sK62Gsbq3QlEi7
         bT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BVRbbIrLpveGd+iHJYXgT+f4DhwBDfQUgT8q21QlbcA=;
        b=WC8c6H/7/Uib4zIJfDCeNI7I7cxvf9aUUleE+z3b75N7U4DcAOwt4udoxXB/6HdUOF
         k1txPBSCtDPV0lkSZFg+L8zf5+ps8P35vFEj879cPeJQaDdiVKUl3ZMKod2p2gIYTKt7
         s8vZ2SsDz9/tyORv0+DhM+84a4EAE4fr4RrBfR7oaX57zcKmNDgMeIawzkYd+76fmYH3
         3eEwT8plXSx6Iit5GOxmRo+jNVKpKRD3EI7d2mvsf7h4LE9hovZVEDuFrgX53zXZgCrd
         lsA3f2MGIADIv093fweDtz+10NDXLsvN5EIpZ5v6J//J50hobaEwiPFDWKA+EAXv/Gxj
         uMgw==
X-Gm-Message-State: AOAM531SF7xmx5vcTnSlajMtIVfn1S3ep0A0aVy6y2DN91FwaOfxSaVc
        OZVTASBo/N5Z189q0Tn8TJPXjksJ1fRS0A==
X-Google-Smtp-Source: ABdhPJxqpu48gbXuY/pu/ta3Z2flFqndcdHY6BxRQQqG2Q8tBCSbrw4Pgpa40Shf9nKbBjxjFLlK0g==
X-Received: by 2002:a17:90a:141:: with SMTP id z1mr4910797pje.87.1643136786328;
        Tue, 25 Jan 2022 10:53:06 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id l14sm2708786pjf.1.2022.01.25.10.53.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 10:53:06 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_event: Fix HCI_EV_VENDOR max_len
Date:   Tue, 25 Jan 2022 10:53:05 -0800
Message-Id: <20220125185305.2419774-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

HCI_EV_VENDOR is in fact variable length since it acts as metaevent
where a vendor can implement their own event sets.

In addition to it this makes use of bt_dev_warn_ratelimited to supress
the amount of logging in case the event has more data than expected.

Fixes: 3e54c5890c87 ("Bluetooth: hci_event: Use of a function table to handle HCI event")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 664ccf1d8d93..63b925921c87 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6844,7 +6844,7 @@ static const struct hci_ev {
 	HCI_EV(HCI_EV_NUM_COMP_BLOCKS, hci_num_comp_blocks_evt,
 	       sizeof(struct hci_ev_num_comp_blocks)),
 	/* [0xff = HCI_EV_VENDOR] */
-	HCI_EV(HCI_EV_VENDOR, msft_vendor_evt, 0),
+	HCI_EV_VL(HCI_EV_VENDOR, msft_vendor_evt, 0, HCI_MAX_EVENT_SIZE),
 };
 
 static void hci_event_func(struct hci_dev *hdev, u8 event, struct sk_buff *skb,
@@ -6869,8 +6869,9 @@ static void hci_event_func(struct hci_dev *hdev, u8 event, struct sk_buff *skb,
 	 * decide if that is acceptable.
 	 */
 	if (skb->len > ev->max_len)
-		bt_dev_warn(hdev, "unexpected event 0x%2.2x length: %u > %u",
-			    event, skb->len, ev->max_len);
+		bt_dev_warn_ratelimited(hdev,
+					"unexpected event 0x%2.2x length: %u > %u",
+					event, skb->len, ev->max_len);
 
 	data = hci_ev_skb_pull(hdev, skb, event, ev->min_len);
 	if (!data)
-- 
2.34.1

