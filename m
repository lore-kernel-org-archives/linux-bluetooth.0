Return-Path: <SRS0=xgU7=QE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65ADEC282C8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jan 2019 16:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0892084C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jan 2019 16:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693980;
	bh=wxeDGADoFZZd3VTSMTWBsiWLEuaKFPm74dbAzbdBlzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tSlx7fWkIILjaepBeAs+v8Ahkkc1LIQS2rIpjKxalt+YotYoJf8Aio0kdzLOZb2/B
	 wfwG9V42G/dr9QSMuGFKoZ5o7oAq2Weks1f50GZFf6LyoS4e7yyLWi60ZwcN/+O9Wr
	 IIht9vdU3L3g4UE5bmVCg5HUbRbYuaRPh9BEsoY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388431AbfA1QqM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:46:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:58778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388600AbfA1QWq (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Jan 2019 11:22:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B82A21738;
        Mon, 28 Jan 2019 16:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692565;
        bh=wxeDGADoFZZd3VTSMTWBsiWLEuaKFPm74dbAzbdBlzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W/xed3Pr24AeiSUG+vHF0/OsYUivU0jtOjt9c7mqD8Z6p8ji1iE9CV0YS/yuaICoG
         QnM5aLF6jm7dYni5L63311YFLXYVoGidEE6Tfbub3TRMMrGQQ6BdQALgG0wkVrW4/J
         LEt1iewtQtMzvS/SDGg4Az+V/5p3qWdZX3/kjvrY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johan Hedberg <johan.hedberg@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 067/107] Bluetooth: Fix unnecessary error message for HCI request completion
Date:   Mon, 28 Jan 2019 11:19:07 -0500
Message-Id: <20190128161947.57405-67-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Johan Hedberg <johan.hedberg@intel.com>

[ Upstream commit 1629db9c75342325868243d6bca5853017d91cf8 ]

In case a command which completes in Command Status was sent using the
hci_cmd_send-family of APIs there would be a misleading error in the
hci_get_cmd_complete function, since the code would be trying to fetch
the Command Complete parameters when there are none.

Avoid the misleading error and silently bail out from the function in
case the received event is a command status.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_event.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d2f9eb169ba8..6f78489fdb13 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5212,6 +5212,12 @@ static bool hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
 		return true;
 	}
 
+	/* Check if request ended in Command Status - no way to retreive
+	 * any extra parameters in this case.
+	 */
+	if (hdr->evt == HCI_EV_CMD_STATUS)
+		return false;
+
 	if (hdr->evt != HCI_EV_CMD_COMPLETE) {
 		BT_DBG("Last event is not cmd complete (0x%2.2x)", hdr->evt);
 		return false;
-- 
2.19.1

