Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF96DC7EE29
	for <linux-bluetooth@archiver.kernel.org>; Sun, 28 May 2023 17:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjE1RoU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 28 May 2023 13:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjE1RoT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 28 May 2023 13:44:19 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39201A3
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 10:44:18 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id D7354240101
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 19:44:16 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QTmHh3SbFz6tvv;
        Sun, 28 May 2023 19:44:16 +0200 (CEST)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 1/6] Bluetooth: ISO: fix maximum number of CIS in Set CIG Parameters
Date:   Sun, 28 May 2023 17:44:09 +0000
Message-Id: <46eefccceb45556120a0d1fa95cf27c576e9649a.1685294131.git.pav@iki.fi>
In-Reply-To: <cover.1685294131.git.pav@iki.fi>
References: <cover.1685294131.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The maximum CIS_Count is 0x1f (Core v5.3 Vol 4 Part E Sec 7.8.97).

Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_conn.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 1f906f8508bc..7b1a83ec50ae 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -788,7 +788,7 @@ struct iso_list_data {
 	int count;
 	struct {
 		struct hci_cp_le_set_cig_params cp;
-		struct hci_cis_params cis[0x11];
+		struct hci_cis_params cis[0x1f];
 	} pdu;
 };
 
@@ -1815,7 +1815,8 @@ static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
 	}
 
 	/* Reprogram all CIS(s) with the same CIG */
-	for (data.cig = qos->ucast.cig, data.cis = 0x00; data.cis < 0x11;
+	for (data.cig = qos->ucast.cig, data.cis = 0x00;
+	     data.cis < ARRAY_SIZE(data.pdu.cis);
 	     data.cis++) {
 		data.count = 0;
 
-- 
2.40.1

