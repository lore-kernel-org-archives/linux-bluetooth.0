Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B5EC7EE24
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Jun 2023 21:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbjFBV36 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Jun 2023 17:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236470AbjFBV35 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Jun 2023 17:29:57 -0400
X-Greylist: delayed 140081 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Jun 2023 14:29:56 PDT
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12550E48
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Jun 2023 14:29:55 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4QXx3h4NDJzyWK;
        Sat,  3 Jun 2023 00:29:51 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1685741392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Y2aMQk9/QNXTcmFiAfcbnLBpS52wbiaF3IWkyoi19Ek=;
        b=azqByHb2nBUAxoFNa84DhWut6wqROM6LldC78mokA4+ypDtEocU7n6psyMU/ttz8qHG3lV
        ZNvT52Ax2eneP9Ap00C+2FR4NeGXJpVQDXbvsNFJvcDQFKVVxRwVKyZ7Dh55a4bF9y7U37
        PNVWo/09tvmrX0zqY7wmnnomsPdLW48=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1685741392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Y2aMQk9/QNXTcmFiAfcbnLBpS52wbiaF3IWkyoi19Ek=;
        b=o8IHqT3KIqi7bD97pZBkCyjv7fKwBDNrfODDtgg+CI0Fu82nbg6E+qv5qc18KXQpaU0F/D
        QWU7hx9nvoGErcnvq0Yz3ahhZuVOX7MiHumTWQhwMmUKpmo0MSmMnxkNZLkF5szB1Ti44+
        iBJ4sS8e4IcA7e+hb8iYi1dFzzUfP5s=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1685741392; a=rsa-sha256; cv=none;
        b=yNPkAidpPLauzVDqYfd+Dl6x8RuJyseKDEO1psobqEGAhi4e+CCyKKkzbZ05vQnOXjo4bq
        Y4ZrsVummZxVPSqe53GO31ZI7eFNhdR0MzmhhsC+ptqlbUtL8XUSZ8qsmyN3mW41/kjXfM
        z4tnXJcrSBI1XG9/nj5X2uLsDp17TKs=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, Pauli Virtanen <pav@iki.fi>
Subject: [PATCH] Bluetooth: hci_event: fix Set CIG Parameters error status handling
Date:   Sat,  3 Jun 2023 00:28:12 +0300
Message-Id: <d7b290a2d4a3acc77feb10873d28c5c62f26f5ae.1685740877.git.pav@iki.fi>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If the event has error status, return right error code and don't show
incorrect "response malformed" messages.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    Correction to
    "Bluetooth: ISO: use correct CIS order in Set CIG Parameters event"

 net/bluetooth/hci_event.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b3825b3f06d9..7c199f7361f7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3813,7 +3813,8 @@ static u8 hci_cc_le_set_cig_params(struct hci_dev *hdev, void *data,
 	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
 
 	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_CIG_PARAMS);
-	if (!cp || rp->num_handles != cp->num_cis || rp->cig_id != cp->cig_id) {
+	if (!rp->status && (!cp || rp->num_handles != cp->num_cis ||
+			    rp->cig_id != cp->cig_id)) {
 		bt_dev_err(hdev, "unexpected Set CIG Parameters response data");
 		status = HCI_ERROR_UNSPECIFIED;
 	}
-- 
2.40.1

