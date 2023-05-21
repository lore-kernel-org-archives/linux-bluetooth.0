Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5BCC7EE23
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 May 2023 15:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjEUP1q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 21 May 2023 11:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjEUP1p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 21 May 2023 11:27:45 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C22E1
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 May 2023 08:27:44 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id EAE0E240027
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 May 2023 17:27:41 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QPPbK3RQJz9rxH;
        Sun, 21 May 2023 17:27:41 +0200 (CEST)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 4/5] btdev: report right reason for local Disconnect complete
Date:   Sun, 21 May 2023 15:27:37 +0000
Message-Id: <d1b47d578b8e78ea349356dae031e7744a5cf009.1684682575.git.pav@iki.fi>
In-Reply-To: <024df2d86c14fc811701ba27bfa576476bc9c0d6.1684682575.git.pav@iki.fi>
References: <024df2d86c14fc811701ba27bfa576476bc9c0d6.1684682575.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Disconnect initiated by local host should get Connection Terminated by
Local Host (0x16) as termination reason.
---
 emulator/btdev.c | 4 +++-
 monitor/bt.h     | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 0eec1d9f2..f9260511a 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -749,7 +749,9 @@ static int cmd_disconnect_complete(struct btdev *dev, const void *data,
 		return 0;
 	}
 
-	disconnect_complete(dev, conn->handle, BT_HCI_ERR_SUCCESS, cmd->reason);
+	/* Local host has different reason (Core v5.3 Vol 4 Part E Sec 7.1.6) */
+	disconnect_complete(dev, conn->handle, BT_HCI_ERR_SUCCESS,
+						BT_HCI_ERR_LOCAL_HOST_TERM);
 
 	if (conn->link)
 		disconnect_complete(conn->link->dev, conn->link->handle,
diff --git a/monitor/bt.h b/monitor/bt.h
index 2548f0dcd..b99ada0b2 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -3716,6 +3716,7 @@ struct bt_hci_evt_le_big_info_adv_report {
 #define BT_HCI_ERR_COMMAND_DISALLOWED		0x0c
 #define BT_HCI_ERR_UNSUPPORTED_FEATURE		0x11
 #define BT_HCI_ERR_INVALID_PARAMETERS		0x12
+#define BT_HCI_ERR_LOCAL_HOST_TERM		0x16
 #define BT_HCI_ERR_UNSPECIFIED_ERROR		0x1f
 #define BT_HCI_ERR_ADV_TIMEOUT			0x3c
 #define BT_HCI_ERR_CONN_FAILED_TO_ESTABLISH	0x3e
-- 
2.40.1

