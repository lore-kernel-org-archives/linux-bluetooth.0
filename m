Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83357C77B7C
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 May 2023 15:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjEUPsm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 21 May 2023 11:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjEUPsk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 21 May 2023 11:48:40 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1F4E3
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 May 2023 08:48:39 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id D4BC4240103
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 May 2023 17:48:37 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QPQ3T2tnqz6tw1;
        Sun, 21 May 2023 17:48:37 +0200 (CEST)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 1/2] Bluetooth: ISO: consider right CIS when removing CIG at cleanup
Date:   Sun, 21 May 2023 15:48:28 +0000
Message-Id: <cfe0dd7b21b58dcb06af414e92386e5dd372adb0.1684683803.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When looking for CIS blocking CIG removal, consider only the CIS with
the right CIG ID. Don't try to remove CIG with unset CIG ID.
---
 net/bluetooth/hci_conn.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index f75ef12f18f7..2363477af89d 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -950,6 +950,8 @@ static void find_cis(struct hci_conn *conn, void *data)
 	/* Ignore broadcast */
 	if (!bacmp(&conn->dst, BDADDR_ANY))
 		return;
+	if (d->cig != conn->iso_qos.ucast.cig)
+		return;
 
 	d->count++;
 }
@@ -963,6 +965,9 @@ static void cis_cleanup(struct hci_conn *conn)
 	struct hci_dev *hdev = conn->hdev;
 	struct iso_list_data d;
 
+	if (conn->iso_qos.ucast.cig == BT_ISO_QOS_CIG_UNSET)
+		return;
+
 	memset(&d, 0, sizeof(d));
 	d.cig = conn->iso_qos.ucast.cig;
 
-- 
2.40.1

