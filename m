Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB20C7EE2F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 28 May 2023 17:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjE1Rjg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 28 May 2023 13:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjE1Rje (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 28 May 2023 13:39:34 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA85E4
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 10:39:21 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id F0051240029
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 19:39:18 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QTm9y4Cz8z6txq;
        Sun, 28 May 2023 19:39:18 +0200 (CEST)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/4] btdev: fix inactive CIG configurable status
Date:   Sun, 28 May 2023 17:39:14 +0000
Message-Id: <1788d43df1a572539158d133f8d330e36340d7fe.1685283364.git.pav@iki.fi>
In-Reply-To: <502997002ac9d4a76593aa4ba8237b7fb803c701.1685283364.git.pav@iki.fi>
References: <502997002ac9d4a76593aa4ba8237b7fb803c701.1685283364.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

CIG shall not be configurable after the first Create CIS until Remove
CIG is issued (Core v5.3 Vol 6 Part B Sec. 4.5.14.3).  We currently have
it configurable in the inactive state (Create CIS done and all CIS
closed), which is incorrect.

Track CIG state and allow reconfigure only in nonexistent/configured
state, i.e., when no CIS have been created yet.
---
 emulator/btdev.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index f9260511a..98d7af99e 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -105,6 +105,7 @@ struct le_ext_adv {
 struct le_cig {
 	struct bt_hci_cmd_le_set_cig_params params;
 	struct bt_hci_cis_params cis[CIS_SIZE];
+	bool activated;
 } __attribute__ ((packed));
 
 struct btdev {
@@ -5864,29 +5865,24 @@ static int cmd_set_cig_params(struct btdev *dev, const void *data,
 		goto done;
 	}
 
+	/* BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
+	 * page 2553
+	 *
+	 * If the Host issues this command when the CIG is not in the
+	 * configurable state, the Controller shall return the error
+	 * code Command Disallowed (0x0C).
+	 */
+	if (dev->le_cig[cig_idx].activated) {
+		rsp.params.status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		goto done;
+	}
+
 	rsp.params.status = BT_HCI_ERR_SUCCESS;
 	rsp.params.cig_id = cmd->cig_id;
 
 	for (i = 0; i < cmd->num_cis; i++) {
-		struct btdev_conn *iso;
-
 		rsp.params.num_handles++;
 		rsp.handle[i] = cpu_to_le16(make_cis_handle(cig_idx, i));
-
-		/* BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
-		 * page 2553
-		 *
-		 * If the Host issues this command when the CIG is not in the
-		 * configurable state, the Controller shall return the error
-		 * code Command Disallowed (0x0C).
-		 */
-		iso = queue_find(dev->conns, match_handle,
-				UINT_TO_PTR(le16_to_cpu(rsp.handle[i])));
-		if (iso) {
-			rsp.params.status = BT_HCI_ERR_COMMAND_DISALLOWED;
-			i = 0;
-			goto done;
-		}
 	}
 
 	memcpy(&dev->le_cig[cig_idx], data, len);
@@ -6006,6 +6002,8 @@ static int cmd_create_cis_complete(struct btdev *dev, const void *data,
 		evt.cig_id = le_cig->params.cig_id;
 		evt.cis_id = le_cig->cis[cis_idx].cis_id;
 
+		le_cig->activated = true;
+
 		le_meta_event(iso->link->dev, BT_HCI_EVT_LE_CIS_REQ, &evt,
 					sizeof(evt));
 	}
-- 
2.40.1

