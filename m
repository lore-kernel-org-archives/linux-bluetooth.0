Return-Path: <SRS0=zRH5=6U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33755C28CBC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 19:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B6DC2075E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 19:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Aw2HFcIH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgEFTzo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 May 2020 15:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgEFTzo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 May 2020 15:55:44 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D81C061A0F
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2020 12:55:44 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 18so1598710pfx.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2020 12:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1mIMJgVSnAO/W/jn4dWXlCE37Art7UsCVU3EaRnqhxo=;
        b=Aw2HFcIHfekl9CQ54N9ZMus/UDga8fS8CMbjm3nCVs1WWNMGLZnGA4MagsDyudclq4
         MVm2W1KT1Tot5gpAI4SffCZnLBYm3zjxi9dONdd/IuBbBpnfyoZV56Iv4a97QoU6VwaX
         de6DjfG755LlzUN0TNTH4mniejGFiLIb6LLUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1mIMJgVSnAO/W/jn4dWXlCE37Art7UsCVU3EaRnqhxo=;
        b=Ptr8NX29viBgVvWRpT/N9kj2bVpMcR14eAkyGBp+bYNdMWGn3oJBWv6odnWLtq9H6f
         oj6K8yaILBXWfbhrTkRM55wmRiFSTAy42WyweaM2/pqaksNseEsLJbzPSebmwiHykRmH
         6X4fcH1hYsMlgQf5LcZ2kbLyZ72Oibzqaj+hkD+zywnxMxmZtVHyfAK0TTVQYgYVbsbB
         qMSdb3YDO9C54Y3P3N9k5Y7eAKNFT+dH77pD513QcfgLfpKiCetLba1Wwygt3UFj3+94
         IkZBwHNzW90IzX9ypSn0qQfS8qzLdSyKb7blXi+XhmQlaDXu4adSrhmXtx07bLIlsSlO
         p1gg==
X-Gm-Message-State: AGi0PuakkO2So/EJ9hFU6BYdAqupNCgt4yyDQf5jlMyjBHThF+6bCUiW
        WL193y6dnlZlQWYzIGGfmg4gEBDkyQk=
X-Google-Smtp-Source: APiQypJ1wAtU2hbpcFIBCMjJLeW8QYE5PM5XRMWUDukzzzwpYaMtUmnC2HDQ9eI6wfMYDfoaZRqxaQ==
X-Received: by 2002:a63:1161:: with SMTP id 33mr8802415pgr.313.1588794943373;
        Wed, 06 May 2020 12:55:43 -0700 (PDT)
Received: from localhost.localdomain (c-73-231-41-185.hsd1.ca.comcast.net. [73.231.41.185])
        by smtp.googlemail.com with ESMTPSA id x4sm619986pff.67.2020.05.06.12.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 12:55:42 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH] Bluetooth: Handle Inquiry Cancel error after Inquiry Complete
Date:   Wed,  6 May 2020 12:55:03 -0700
Message-Id: <20200506195503.5837-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <89566A98-F0CE-4E70-A344-915E81FB0C14@holtmann.org>
References: <89566A98-F0CE-4E70-A344-915E81FB0C14@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

After sending Inquiry Cancel command to the controller, it is possible
that Inquiry Complete event comes before Inquiry Cancel command complete
event. In this case the Inquiry Cancel command will have status of
Command Disallowed since there is no Inquiry session to be cancelled.
This case should not be treated as error, otherwise we can reach an
inconsistent state.

Example of a btmon trace when this happened:

< HCI Command: Inquiry Cancel (0x01|0x0002) plen 0
> HCI Event: Inquiry Complete (0x01) plen 1
        Status: Success (0x00)
> HCI Event: Command Complete (0x0e) plen 4
      Inquiry Cancel (0x01|0x0002) ncmd 1
        Status: Command Disallowed (0x0c)
---
 net/bluetooth/hci_event.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3e7badb3ac2d..e8047175de10 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -41,12 +41,28 @@
 
 /* Handle HCI Event packets */
 
-static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb,
+				  u8 *new_status)
 {
 	__u8 status = *((__u8 *) skb->data);
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
+	/* It is possible that we receive Inquiry Complete event right
+	 * before we receive Inquiry Cancel Command Complete event, in
+	 * which case the latter event should have status of Command
+	 * Disallowed (0x0c). This should not be treated as error, since
+	 * we actually achieve what Inquiry Cancel wants to achieve,
+	 * which is to end the last Inquiry session.
+	 */
+	if (status == 0x0c && !test_bit(HCI_INQUIRY, &hdev->flags)) {
+		bt_dev_err(hdev, "Ignoring error of "
+				 "HCI Inquiry Cancel command");
+		status = 0x00;
+	}
+
+	*new_status = status;
+
 	if (status)
 		return;
 
@@ -3036,7 +3052,7 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 
 	switch (*opcode) {
 	case HCI_OP_INQUIRY_CANCEL:
-		hci_cc_inquiry_cancel(hdev, skb);
+		hci_cc_inquiry_cancel(hdev, skb, status);
 		break;
 
 	case HCI_OP_PERIODIC_INQ:
-- 
2.17.1

