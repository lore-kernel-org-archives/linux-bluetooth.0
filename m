Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13907C7EE2A
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 May 2023 15:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjEUPsn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 21 May 2023 11:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjEUPsk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 21 May 2023 11:48:40 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FFFE4
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 May 2023 08:48:39 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 3735E240103
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 May 2023 17:48:38 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QPQ3T5RhYz6tw1;
        Sun, 21 May 2023 17:48:37 +0200 (CEST)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 2/2] Bluetooth: ISO: fix CIG auto-allocation to select configurable CIG
Date:   Sun, 21 May 2023 15:48:29 +0000
Message-Id: <f0a8ca0bbd1d3360f247eef75018b1b419d622c6.1684683803.git.pav@iki.fi>
In-Reply-To: <cfe0dd7b21b58dcb06af414e92386e5dd372adb0.1684683803.git.pav@iki.fi>
References: <cfe0dd7b21b58dcb06af414e92386e5dd372adb0.1684683803.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Make CIG auto-allocation to select the first CIG_ID that is still
configurable. Also use correct CIG_ID range (see Core v5.3 Vol 4 Part E
Sec 7.8.97 p.2553).

Previously, it would always select CIG_ID 0 regardless of anything,
because cis_list with data.cis == 0xff (BT_ISO_QOS_CIS_UNSET) would not
count any CIS. Since we are not adding CIS here, use find_cis instead.
---

Notes:
    It could also make sense to always auto-allocate to an unused CIG_ID
    instead.  However, that changes current behavior, and would force
    userspace to do the allocation themselves as they may want to use as few
    CIG as possible. I think e.g Intel AX210 doesn't support multiple CIG.
    
    With the patchset adding new BlueZ iso-tester CIG tests:
    
    ISO Connect2 CIG auto/auto Seq - Success             Passed       0.148 seconds

 net/bluetooth/hci_conn.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2363477af89d..99150d054a8d 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1771,24 +1771,23 @@ static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
 
 	memset(&data, 0, sizeof(data));
 
-	/* Allocate a CIG if not set */
+	/* Allocate first still reconfigurable CIG if not set */
 	if (qos->ucast.cig == BT_ISO_QOS_CIG_UNSET) {
-		for (data.cig = 0x00; data.cig < 0xff; data.cig++) {
+		for (data.cig = 0x00; data.cig < 0xf0; data.cig++) {
 			data.count = 0;
-			data.cis = 0xff;
 
-			hci_conn_hash_list_state(hdev, cis_list, ISO_LINK,
-						 BT_BOUND, &data);
+			hci_conn_hash_list_state(hdev, find_cis, ISO_LINK,
+						 BT_CONNECT, &data);
 			if (data.count)
 				continue;
 
-			hci_conn_hash_list_state(hdev, cis_list, ISO_LINK,
+			hci_conn_hash_list_state(hdev, find_cis, ISO_LINK,
 						 BT_CONNECTED, &data);
 			if (!data.count)
 				break;
 		}
 
-		if (data.cig == 0xff)
+		if (data.cig == 0xf0)
 			return false;
 
 		/* Update CIG */
-- 
2.40.1

