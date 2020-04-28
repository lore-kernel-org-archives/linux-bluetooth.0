Return-Path: <SRS0=u/yl=6M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028ACC83004
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Apr 2020 05:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDA41206A5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Apr 2020 05:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hYOGfFlU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgD1FM0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Apr 2020 01:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725792AbgD1FMZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Apr 2020 01:12:25 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1537C03C1A9
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2020 22:12:23 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x77so10128811pfc.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2020 22:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lovTVnVl+1su5Gp69rqpY+nvujlizDdI7TM7pL8Unzg=;
        b=hYOGfFlUAAO1n7sLfa0DzFuwr3iZY/afrruNUuESXWF+DRaDtUqTJ52DI2hJdQW2J6
         0gdLdgIpc4cYSup/LpeKh3LPtMMBRX0/BhgFOIQxgXxoXXqZ5bGoTb+p8gz56tRmC80C
         8oa6mkQRWB8IkjmlfSwtB7eXTwSZ2lViNbRmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lovTVnVl+1su5Gp69rqpY+nvujlizDdI7TM7pL8Unzg=;
        b=DW4Y9CnBc+YiCsf05Ux+Tty6A8aPb7PNv9JyNCmIImCLI1jH/ywYsXHeNllWiz07a5
         LhZm9m5nM7hd5AvgJzx57P3sdjbVYXV2ZYDYAlbZhpemqG5As9+E/+zHoeMeexPleezo
         njRIe9GNyqhuGDEIOjAv6J/AEepb9lApeHoqtwrabyjF+9b4mVByUu4nt/G/IbUesAQW
         gaGHpAISSaGc8U/N4p6A1YYzwmPFK+tTZ88vqo/1LCN2d3/GYydrjK2tJvxbPFpnPnGE
         EXjPaneXcp3MPHKUSLuH8g0VYBNFhT4QLwMUsw87XxZOCvzTHGfTclQg2YR47HhAagwd
         VD3w==
X-Gm-Message-State: AGi0PuZ6BzsM6yDh0zmf61oz9FAbysOCkVqyE8XIX89RsrU4OFYOOW5Z
        anUC93bjdVCf/OjOSqv3nSm3bmmpyjk=
X-Google-Smtp-Source: APiQypLGL8w66q2h3Xy5VYzsqHjZSf9ZJBuCggOaWKUGNF8gfdR+m+jxidnPk5XO5LHrYdA3S+lgRw==
X-Received: by 2002:aa7:988e:: with SMTP id r14mr11590722pfl.146.1588050742913;
        Mon, 27 Apr 2020 22:12:22 -0700 (PDT)
Received: from localhost.localdomain (c-73-231-41-185.hsd1.ca.comcast.net. [73.231.41.185])
        by smtp.googlemail.com with ESMTPSA id p16sm901286pjz.2.2020.04.27.22.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 22:12:22 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
X-Google-Original-From: Sonny Sasaka <sonnysasaka@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH] Bluetooth: Handle Inquiry Cancel error after Inquiry Complete
Date:   Mon, 27 Apr 2020 22:11:51 -0700
Message-Id: <20200428051151.14879-1-sonnysasaka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Sonny Sasaka <sonnysasaka@chromium.org>

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
 net/bluetooth/hci_event.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 966fc543c01d..0f3f7255779f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -42,10 +42,9 @@
 
 /* Handle HCI Event packets */
 
-static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb,
+				  u8 status)
 {
-	__u8 status = *((__u8 *) skb->data);
-
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
 	if (status)
@@ -3233,7 +3232,19 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 
 	switch (*opcode) {
 	case HCI_OP_INQUIRY_CANCEL:
-		hci_cc_inquiry_cancel(hdev, skb);
+		/* It is possible that we receive Inquiry Complete event right
+		 * before we receive Inquiry Cancel Command Complete event, in
+		 * which case the latter event should have status of Command
+		 * Disallowed (0x0c). This should not be treated as error, since
+		 * we actually achieve what Inquiry Cancel wants to achieve,
+		 * which is to end the last Inquiry session.
+		 */
+		if (*status == 0x0c && !test_bit(HCI_INQUIRY, &hdev->flags)) {
+			BT_DBG("Ignoring error of HCI Inquiry Cancel command");
+			*status = 0;
+		}
+
+		hci_cc_inquiry_cancel(hdev, skb, *status);
 		break;
 
 	case HCI_OP_PERIODIC_INQ:
-- 
2.17.1

