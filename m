Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C1FC7EE29
	for <linux-bluetooth@archiver.kernel.org>; Sun, 28 May 2023 17:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjE1RoW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 28 May 2023 13:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjE1RoU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 28 May 2023 13:44:20 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FABAB
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 10:44:18 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 8AAB524002A
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 19:44:17 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QTmHj1FCDz6tw8;
        Sun, 28 May 2023 19:44:17 +0200 (CEST)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 3/6] Bluetooth: ISO: don't try to do Set CIG Parameters if CIG known busy
Date:   Sun, 28 May 2023 17:44:11 +0000
Message-Id: <b9da7e6788c218f4c3876a5e68b90af18ba800df.1685294131.git.pav@iki.fi>
In-Reply-To: <cover.1685294131.git.pav@iki.fi>
References: <cover.1685294131.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Don't try to do set CIG parameters if we know the CIG is busy, because
we drop all connections on command failure in hci_cc_le_set_cig_params.
Trying to connect new CIS while CIG is not configurable shall not cause
other active CIS connections to fail.

Check the CIG is not busy before trying to emit the Set CIG Parameters
command.

Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_conn.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 182dba4a19b5..47a8ec796d97 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1815,6 +1815,19 @@ static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
 
 		/* Update CIG */
 		qos->ucast.cig = data.cig;
+	} else {
+		/* If CIG is busy, fail early because cmd error closes conns */
+		data.cig = qos->ucast.cig;
+		data.count = 0;
+
+		hci_conn_hash_list_state(hdev, find_cis, ISO_LINK,
+					 BT_CONNECT, &data);
+		if (data.count)
+			return false;
+		hci_conn_hash_list_state(hdev, find_cis, ISO_LINK,
+					 BT_CONNECTED, &data);
+		if (data.count)
+			return false;
 	}
 
 	data.pdu.cp.cig_id = qos->ucast.cig;
-- 
2.40.1

