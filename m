Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ABCC7EE23
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Jun 2023 06:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjFAGfQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Jun 2023 02:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjFAGfP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Jun 2023 02:35:15 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52656E2
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 May 2023 23:35:14 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4QWxFq2syWzytZ;
        Thu,  1 Jun 2023 09:35:11 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1685601311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uwHelr9epidNx4TlyEwPNGxb8mG0HmBux+ZYLk+0kkE=;
        b=WxSZPXMpaQNTgyQAsjFkmB52S8/UH51wRWr9XNdZ3IsZ/zIz5pOGJJRFtt6tTTTdRIwV3X
        iDfsVlvit9Mz/xSUvZ3xQLBKqxldwliQnMlSnrpqVI67sqBHvpL5xn8XeztkO8o5z1Gzv2
        1YB7PHGfTbF67paXrxRvSz8xuQvlrgg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1685601311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uwHelr9epidNx4TlyEwPNGxb8mG0HmBux+ZYLk+0kkE=;
        b=k1h/oGL04Waw4PrZcanK+F7hN30VHtbOzirdb7HlnecdFHh9mn/RDa0clZKx80NG6DtOiJ
        aZHrsp2R+qBAdyhiNGBx1JpyD3v2+JVQPoVR/zfA/tF43MYS0NooIG/J5A5xh8I26GA9ar
        87LM6rSEIxyw3Xo+I6PsqdK6qnSbfaU=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1685601311; a=rsa-sha256; cv=none;
        b=WoYtCZ+vJyUGICfkuKXD/OA7iNRmYPs43e45H9a9wNFsHvQOk8eaN7auFOXAF1NDk8zNCW
        RV057TOGsxu4FNgqnA8ICfAzKsUtYsm5zHs31pdKaUpzORpOy08CaCW+rD1RigtPH8DPhB
        pS0qQy3hzu3Fou0ecRTspQjKSFK6LDI=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v2 1/4] Bluetooth: ISO: use hci_sync for setting CIG parameters
Date:   Thu,  1 Jun 2023 09:34:43 +0300
Message-Id: <97114b5f17f44d913c564f4ac8b41726c3a8eeae.1685565568.git.pav@iki.fi>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685565568.git.pav@iki.fi>
References: <cover.1685565568.git.pav@iki.fi>
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

Notes:
    v2: rebased, no changes

 net/bluetooth/hci_conn.c | 47 +++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 795b2daa5bac..f45476deca82 100644
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
-		struct hci_cis_params cis[0x11];
-	} pdu;
+	struct iso_cig_params pdu;
 	bool big_term;
 };
 
@@ -1783,10 +1785,33 @@ static int hci_le_create_big(struct hci_conn *conn, struct bt_iso_qos *qos)
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
 
@@ -1856,12 +1881,18 @@ static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
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

