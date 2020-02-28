Return-Path: <SRS0=e/tT=4Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E04AC3F2D2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 20:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C4B246AE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 20:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TOB9UA49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgB1Uvw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Feb 2020 15:51:52 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35076 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgB1Uvw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Feb 2020 15:51:52 -0500
Received: by mail-vs1-f65.google.com with SMTP id u26so2846663vsg.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2020 12:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pFJTaE2xrNcAanqHyoHceUjLy2NQv7Ru7eflVQr0amA=;
        b=TOB9UA49RZk66S1xgAVImJjLgvIY7LOObSCwDyLgbLZkjptYvFJA+gE2dzPoR1qEfd
         TwrPnKNnQokZ2YlLCQbAu+uCUh8JIEMRCHWLg+qSVaIeovpZYwyyGzbgjirbr6nCs4y6
         +g4XnmcLhUWsZEqwtDMMdl31vizWkpFBHV46Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pFJTaE2xrNcAanqHyoHceUjLy2NQv7Ru7eflVQr0amA=;
        b=oO+Y9TKO5jjOjhtcE7ulyecJWZp37byzM/ARhsafx1n4aX1pZjcjGSDv5TS9pf/TXF
         UT+YqcND0x/BAJyKS507FQT3PG8JR4Ea+dUINSqXa9ZQK9inwe+MojkYp9LV4v1rLVxs
         vZ+TPA0QcdeL3nyy+7kpHESbYe4uznR14+Uwjf4NYlACV5/0meeCMfMQS1vErS+rdP1z
         WjtoEhgAY0qetrui4w7LRHYLRG6wYFq9qOY2zo3GNZOfyezjt48yAQo57MpDeO5K1BSY
         f0IveisMGuIRIOnk1oD09dVOHNfsvgrKB/DXOWMDB3DLcUKFBLi2dzB2I9gpwnT8Cwm7
         pNcg==
X-Gm-Message-State: ANhLgQ22ux+IahjBryl84WRHT5Ep03WDP6PjpvOY5jaQ5FNzbcunUnYy
        5UYCm9ucHYWBp2XfM6PYPI1VnoBKiuQ=
X-Google-Smtp-Source: ADFU+vsBsdygaxGLUJNu5Ltvf7rJWvhSnPS4wl9lZyeJhMhzzuIVivkkbfSArSkJLUGxjvUaLm4nrw==
X-Received: by 2002:a67:ecc1:: with SMTP id i1mr3635952vsp.145.1582923111198;
        Fri, 28 Feb 2020 12:51:51 -0800 (PST)
Received: from alain.c.googlers.com.com (39.119.74.34.bc.googleusercontent.com. [34.74.119.39])
        by smtp.gmail.com with ESMTPSA id 22sm3290201vkz.39.2020.02.28.12.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 12:51:50 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v1] bluetooth: guard against controllers sending zero'd events
Date:   Fri, 28 Feb 2020 20:51:46 +0000
Message-Id: <20200228205146.161229-1-alainm@chromium.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some controllers have been observed to send zero'd events under some
conditions.  This change guards against this condition as well as adding
a trace to facilitate diagnosability of this condition.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 net/bluetooth/hci_event.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 591e7477e925..f865eddb8d69 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5868,7 +5868,8 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	u8 status = 0, event = hdr->evt, req_evt = 0;
 	u16 opcode = HCI_OP_NOP;
 
-	if (hdev->sent_cmd && bt_cb(hdev->sent_cmd)->hci.req_event == event) {
+	if (hdev->sent_cmd && event &&
+	    bt_cb(hdev->sent_cmd)->hci.req_event == event) {
 		struct hci_command_hdr *cmd_hdr = (void *) hdev->sent_cmd->data;
 		opcode = __le16_to_cpu(cmd_hdr->opcode);
 		hci_req_cmd_complete(hdev, opcode, status, &req_complete,
@@ -5876,6 +5877,9 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		req_evt = event;
 	}
 
+	if (!event)
+		BT_ERR("Received unexpected HCI Event 00000000");
+
 	/* If it looks like we might end up having to call
 	 * req_complete_skb, store a pristine copy of the skb since the
 	 * various handlers may modify the original one through
-- 
2.25.0.265.gbab2e86ba0-goog

