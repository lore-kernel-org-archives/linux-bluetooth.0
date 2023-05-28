Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF2BC7EE2E
	for <linux-bluetooth@archiver.kernel.org>; Sun, 28 May 2023 17:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjE1RoV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 28 May 2023 13:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjE1RoU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 28 May 2023 13:44:20 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4BDA9
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 10:44:18 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 394BE240101
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 19:44:17 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QTmHh5vwpz6trs;
        Sun, 28 May 2023 19:44:16 +0200 (CEST)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 2/6] Bluetooth: ISO: use hci_sync for setting CIG parameters
Date:   Sun, 28 May 2023 17:44:10 +0000
Message-Id: <3b6c687cc86352b78e69f23aa065d512f93b07d4.1685294131.git.pav@iki.fi>
In-Reply-To: <cover.1685294131.git.pav@iki.fi>
References: <cover.1685294131.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When reconfiguring CIG after disconnection of the last CIS, LE Remove
CIG shall be sent before LE Set CIG Parameters.  Otherwise, it fails
because CIG is in the inactive state and not configurable (Core v5.3
Vol 6 Part B Sec. 4.5.14.3). This ordering is currently wrong under
suitable timing conditions, because LE Remove CIG is sent via the
hci_sync queue and may be delayed, but Set CIG Parameters is via
hci_send_cmd.

Make the ordering well-defined by sending also Set CIG Parameters via
hci_sync.

Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_conn.c | 47 +++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7b1a83ec50ae..182dba4a19b5 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -775,6 +775,11 @@ static void le_conn_timeout(struct work_struct *work)
 	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
 }
 
+struct iso_cig_params {
+	struct hci_cp_le_set_cig_params cp;
+	struct hci_cis_params cis[0x1f];
+};
+
 struct iso_list_data {
 	union {
 		u8  cig;
@@ -786,10 +791,7 @@ struct iso_list_data {
 		u16 sync_handle;
 	};
 	int count;
-	struct {
-		struct hci_cp_le_set_cig_params cp;
-		struct hci_cis_params cis[0x1f];
-	} pdu;
+	struct iso_cig_params pdu;
 };
 
 static void bis_list(struct hci_conn *conn, void *data)
@@ -1762,10 +1764,33 @@ static int hci_le_create_big(struct hci_conn *conn, struct bt_iso_qos *qos)
 	return hci_send_cmd(hdev, HCI_OP_LE_CREATE_BIG, sizeof(cp), &cp);
 }
 
+static void set_cig_params_complete(struct hci_dev *hdev, void *data, int err)
+{
+	struct iso_cig_params *pdu = data;
+
+	bt_dev_dbg(hdev, "");
+
+	if (err)
+		bt_dev_err(hdev, "Unable to set CIG parameters: %d", err);
+
+	kfree(pdu);
+}
+
+static int set_cig_params_sync(struct hci_dev *hdev, void *data)
+{
+	struct iso_cig_params *pdu = data;
+	u32 plen;
+
+	plen = sizeof(pdu->cp) + pdu->cp.num_cis * sizeof(pdu->cis[0]);
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_CIG_PARAMS, plen, pdu,
+				     HCI_CMD_TIMEOUT);
+}
+
 static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct iso_list_data data;
+	struct iso_cig_params *pdu;
 
 	memset(&data, 0, sizeof(data));
 
@@ -1836,12 +1861,18 @@ static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
 	if (qos->ucast.cis == BT_ISO_QOS_CIS_UNSET || !data.pdu.cp.num_cis)
 		return false;
 
-	if (hci_send_cmd(hdev, HCI_OP_LE_SET_CIG_PARAMS,
-			 sizeof(data.pdu.cp) +
-			 (data.pdu.cp.num_cis * sizeof(*data.pdu.cis)),
-			 &data.pdu) < 0)
+	pdu = kzalloc(sizeof(*pdu), GFP_KERNEL);
+	if (!pdu)
 		return false;
 
+	memcpy(pdu, &data.pdu, sizeof(*pdu));
+
+	if (hci_cmd_sync_queue(hdev, set_cig_params_sync, pdu,
+			       set_cig_params_complete) < 0) {
+		kfree(pdu);
+		return false;
+	}
+
 	return true;
 }
 
-- 
2.40.1

