Return-Path: <SRS0=Tr5+=S2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655D4C10F11
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 20:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BF520835
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 20:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbfDXUTW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Apr 2019 16:19:22 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:58692 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728924AbfDXUTW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Apr 2019 16:19:22 -0400
Received: from localhost.localdomain (p4FF9FD9B.dip0.t-ipconnect.de [79.249.253.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5E42ECF355
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2019 22:27:32 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Align minimum encryption key size for LE and BR/EDR connections
Date:   Wed, 24 Apr 2019 22:19:17 +0200
Message-Id: <20190424201917.115510-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The minimum encryption key size for LE connections is 56 bits and to
align LE with BR/EDR, enforce 56 bits of minimum encryption key size for
BR/EDR connections as well.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 3 +++
 net/bluetooth/hci_conn.c         | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 094e61e07030..05b1b96f4d9e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -190,6 +190,9 @@ struct adv_info {
 
 #define HCI_MAX_SHORT_NAME_LENGTH	10
 
+/* Min encryption key size to match with SMP */
+#define HCI_MIN_ENC_KEY_SIZE		7
+
 /* Default LE RPA expiry time, 15 minutes */
 #define HCI_DEFAULT_RPA_TIMEOUT		(15 * 60)
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index bd4978ce8c45..3cf0764d5793 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1276,6 +1276,14 @@ int hci_conn_check_link_mode(struct hci_conn *conn)
 	    !test_bit(HCI_CONN_ENCRYPT, &conn->flags))
 		return 0;
 
+	/* The minimum encryption key size needs to be enforced by the
+	 * host stack before establishing any L2CAP connections. The
+	 * specification in theory allows a minimum of 1, but to align
+	 * BR/EDR and LE transports, a minimum of 7 is chosen.
+	 */
+	if (conn->enc_key_size < HCI_MIN_ENC_KEY_SIZE)
+		return 0;
+
 	return 1;
 }
 
-- 
2.20.1

