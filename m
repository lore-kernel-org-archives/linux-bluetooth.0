Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60347C83F11
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Aug 2023 19:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjHZTzo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Aug 2023 15:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHZTzM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Aug 2023 15:55:12 -0400
X-Greylist: delayed 1790 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 26 Aug 2023 12:55:08 PDT
Received: from javispedro.com (javispedro.com [IPv6:2001:41d0:401:3000::34c4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3633FE1
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Aug 2023 12:55:08 -0700 (PDT)
Received: from [2a01:cb15:804c:e300:8337:b625:5964:c1be] (helo=pcj.home)
        by javispedro.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <dev.git@javispedro.com>)
        id 1qZyuG-001mJq-RW; Sat, 26 Aug 2023 21:25:12 +0200
From:   Javier de San Pedro <dev.git@javispedro.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com,
        Javier de San Pedro <dev.git@javispedro.com>
Subject: [PATCH BlueZ] shared/gatt-client: always send ATT confirmations
Date:   Sat, 26 Aug 2023 21:24:21 +0200
Message-ID: <20230826192421.7032-1-dev.git@javispedro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I noticed after upgrading 5.66->5.68 that Bluez was no longer sending
confirmations (ATT opcode 0x1E) in response to indication opcodes (0x1D).

Commit fde32ff9c9c0 ("shared/gatt-client: Allow registering with NULL
callback") added an early return to the notify_cb function when the
current client's notify_list is empty. However, in this case, we will
also not send the confirmation back. This breaks protocol.

The devices I have generally respond to this by stopping
any new indications until ~15sec timeout or disconnection.

As far as I can see, when using D-Bus API all notify handlers are always
added on client clones, never on the 'root' client itself (the one
with !client->parent), so for the root client the notify_list is always
empty, making this issue very easy to trigger using D-Bus GATT API.

Ensure that we always send the confirmation, even if notify_list is empty.

Fixes: fde32ff9c9c0 ("shared/gatt-client: Allow registering with NULL callback")
---
 src/shared/gatt-client.c | 57 ++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index efc013a20..56ecc6a8f 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -2230,45 +2230,46 @@ static void notify_cb(struct bt_att_chan *chan, uint8_t opcode,
 					void *user_data)
 {
 	struct bt_gatt_client *client = user_data;
-	struct value_data data;
-
-	if (queue_isempty(client->notify_list))
-		return;
 
 	bt_gatt_client_ref(client);
 
-	memset(&data, 0, sizeof(data));
+	if (!queue_isempty(client->notify_list)) {
+		struct value_data data;
 
-	if (opcode == BT_ATT_OP_HANDLE_NFY_MULT) {
-		while (length >= 4) {
-			data.handle = get_le16(pdu);
-			length -= 2;
-			pdu += 2;
+		memset(&data, 0, sizeof(data));
 
-			data.len = get_le16(pdu);
-			length -= 2;
-			pdu += 2;
+		if (opcode == BT_ATT_OP_HANDLE_NFY_MULT) {
+			while (length >= 4) {
+				data.handle = get_le16(pdu);
+				length -= 2;
+				pdu += 2;
 
-			if (data.len > length)
-				data.len = length;
+				data.len = get_le16(pdu);
+				length -= 2;
+				pdu += 2;
 
-			data.data = pdu;
+				if (data.len > length)
+					data.len = length;
 
-			queue_foreach(client->notify_list, notify_handler,
-								&data);
+				data.data = pdu;
 
-			length -= data.len;
-			pdu += data.len;
-		}
-	} else {
-		data.handle = get_le16(pdu);
-		length -= 2;
-		pdu += 2;
+				queue_foreach(client->notify_list,
+					      notify_handler, &data);
 
-		data.len = length;
-		data.data = pdu;
+				length -= data.len;
+				pdu += data.len;
+			}
+		} else {
+			data.handle = get_le16(pdu);
+			length -= 2;
+			pdu += 2;
+
+			data.len = length;
+			data.data = pdu;
 
-		queue_foreach(client->notify_list, notify_handler, &data);
+			queue_foreach(client->notify_list,
+				      notify_handler, &data);
+		}
 	}
 
 	if (opcode == BT_ATT_OP_HANDLE_IND && !client->parent)
-- 
2.41.0

