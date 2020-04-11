Return-Path: <SRS0=Wpeu=53=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE19C2BB86
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Apr 2020 23:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C79520709
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Apr 2020 23:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586648357;
	bh=imOB+3GevijxpPnyCuaCHtbNXjSe1r5y/AGVlnfqbXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gzwRWklO2XlniNu1rmj2FrSdb6d/jlgIShbkEN3pcnakDKnaWVvLU4HaIO8WmCvTc
	 nlflg42YFhlc9giIAFO3X2r5QAIrG7rEIGbj1Rmf1cyT6udqieoAsyyrg4MECyQF3v
	 LD9xS42BNpKQUQqNDV26ImZ8KC+rtkzFItrvxIhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgDKXHo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:07:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727511AbgDKXHn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Apr 2020 19:07:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B04C520787;
        Sat, 11 Apr 2020 23:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646463;
        bh=imOB+3GevijxpPnyCuaCHtbNXjSe1r5y/AGVlnfqbXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mI8RPG7SwJFOjdGrg5fkR+/e2/BtNuntsyVyMsZhufYum5LZGwhu36JgZ92ELK4q2
         lIX7bOZ//aG5s3byjOJEBkghRRquWeYo7TSxurKyqt6v7nxLfF4sUGufMNXteLAVs+
         eYxMhHzXoMDxInCMPfAHY7CyDDRvPtLka1a8gE+A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 031/121] Bluetooth: Fix calculation of SCO handle for packet processing
Date:   Sat, 11 Apr 2020 19:05:36 -0400
Message-Id: <20200411230706.23855-31-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230706.23855-1-sashal@kernel.org>
References: <20200411230706.23855-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Marcel Holtmann <marcel@holtmann.org>

[ Upstream commit debdedf2eb5a2d9777cabff40900772be13cd9f9 ]

When processing SCO packets, the handle is wrongly assumed as 16-bit
value. The actual size is 12-bits and the other 4-bits are used for
packet flags.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9e19d5a3aac87..d136519d56542 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4322,13 +4322,16 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_sco_hdr *hdr = (void *) skb->data;
 	struct hci_conn *conn;
-	__u16 handle;
+	__u16 handle, flags;
 
 	skb_pull(skb, HCI_SCO_HDR_SIZE);
 
 	handle = __le16_to_cpu(hdr->handle);
+	flags  = hci_flags(handle);
+	handle = hci_handle(handle);
 
-	BT_DBG("%s len %d handle 0x%4.4x", hdev->name, skb->len, handle);
+	BT_DBG("%s len %d handle 0x%4.4x flags 0x%4.4x", hdev->name, skb->len,
+	       handle, flags);
 
 	hdev->stat.sco_rx++;
 
-- 
2.20.1

