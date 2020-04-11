Return-Path: <SRS0=Wpeu=53=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62978C2BB86
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Apr 2020 23:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CF92084D
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Apr 2020 23:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586647486;
	bh=xqdDMXafI/lJR1TnjvBCsxh6zD3S8/yOI985BQtRjFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j+z+RIFvOvmEltuP2Mi62pJ3kHPPO4M9rhlm8b3kVrccgj2Nr89I3tWAKeLo6Lcxt
	 5tuP+wrMyC/bctDw3KGHBAQUndf7zSI4UE3ygMV1FS4eWcWjFn+qcKuV1ntDIulU3F
	 MM6C7OrQCjddW2b647bAsgwZIaZWBtcF3uUpdMUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbgDKXYi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:24:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727365AbgDKXMa (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Apr 2020 19:12:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89860216FD;
        Sat, 11 Apr 2020 23:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646750;
        bh=xqdDMXafI/lJR1TnjvBCsxh6zD3S8/yOI985BQtRjFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qa1PGx5gF67vJY5KXXp+HPOADof9kMgqkTfhdqPfs/bOu615mV9SCsKSolud51sVY
         fYmyg7OIUt0QG5sEhBnhYENtpUhYbrjSfxR8ZaXWBNVMAoeIXU+MNIaXj0yvMohXQC
         BFUmUhd1K3tiIm/akgwgLg6b/CIjIyeW3xW+kD40=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 22/66] Bluetooth: guard against controllers sending zero'd events
Date:   Sat, 11 Apr 2020 19:11:19 -0400
Message-Id: <20200411231203.25933-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411231203.25933-1-sashal@kernel.org>
References: <20200411231203.25933-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Alain Michaud <alainm@chromium.org>

[ Upstream commit 08bb4da90150e2a225f35e0f642cdc463958d696 ]

Some controllers have been observed to send zero'd events under some
conditions.  This change guards against this condition as well as adding
a trace to facilitate diagnosability of this condition.

Signed-off-by: Alain Michaud <alainm@chromium.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_event.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3e7badb3ac2d5..93d077328c6ab 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5718,6 +5718,11 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	u8 status = 0, event = hdr->evt, req_evt = 0;
 	u16 opcode = HCI_OP_NOP;
 
+	if (!event) {
+		bt_dev_warn(hdev, "Received unexpected HCI Event 00000000");
+		goto done;
+	}
+
 	if (hdev->sent_cmd && bt_cb(hdev->sent_cmd)->hci.req_event == event) {
 		struct hci_command_hdr *cmd_hdr = (void *) hdev->sent_cmd->data;
 		opcode = __le16_to_cpu(cmd_hdr->opcode);
@@ -5929,6 +5934,7 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		req_complete_skb(hdev, status, opcode, orig_skb);
 	}
 
+done:
 	kfree_skb(orig_skb);
 	kfree_skb(skb);
 	hdev->stat.evt_rx++;
-- 
2.20.1

