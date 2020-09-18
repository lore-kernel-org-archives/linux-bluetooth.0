Return-Path: <SRS0=JXiH=C3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C8CC43464
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 02:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 665E42388D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 02:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600396893;
	bh=wsW5bWA/0d2aGuBI+3kVFdiUF693X8BFYmlHJZMNYUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qiiY4jSSWbVgSQXgb1Jpc2I79s0uIB5UbsE0NKIydTTombf72ERCUXA/Co1fmTPWN
	 P9jxI4Bv7Zec0pLE1nvLHATGfCnynmeVr2jB9Fgzc1n0QYj370V4kXB5Pe10L5VK15
	 VaVZVHjb6skWPYOzNs8+pPMn+Ve0MhMis2jLjf0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbgIRCLT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 22:11:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728601AbgIRCLR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 22:11:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A86C208DB;
        Fri, 18 Sep 2020 02:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600395076;
        bh=wsW5bWA/0d2aGuBI+3kVFdiUF693X8BFYmlHJZMNYUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YAxiUro4qiFqMv0n7xqdO+0PAJhBQ+6jfHYC1jUf3VuiAu01DSdAyYsZiw8NG+Yrz
         iiLf7YXKhh+hHiEfdkBmpBTkC2B7BbqAc0v8SLBXbtGzyq6e0qCRyVBGdIzYDXMPw1
         uzLWO1mAIBIDe4vEBOi9L1mqx3uH2DMs+gbKjDtI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 160/206] Bluetooth: Handle Inquiry Cancel error after Inquiry Complete
Date:   Thu, 17 Sep 2020 22:07:16 -0400
Message-Id: <20200918020802.2065198-160-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918020802.2065198-1-sashal@kernel.org>
References: <20200918020802.2065198-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Sonny Sasaka <sonnysasaka@chromium.org>

[ Upstream commit adf1d6926444029396861413aba8a0f2a805742a ]

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

Signed-off-by: Sonny Sasaka <sonnysasaka@chromium.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_event.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ec6b3a87b3e7f..310622086f74b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -41,12 +41,27 @@
 
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
+		bt_dev_warn(hdev, "Ignoring error of Inquiry Cancel command");
+		status = 0x00;
+	}
+
+	*new_status = status;
+
 	if (status)
 		return;
 
@@ -3039,7 +3054,7 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 
 	switch (*opcode) {
 	case HCI_OP_INQUIRY_CANCEL:
-		hci_cc_inquiry_cancel(hdev, skb);
+		hci_cc_inquiry_cancel(hdev, skb, status);
 		break;
 
 	case HCI_OP_PERIODIC_INQ:
-- 
2.25.1

