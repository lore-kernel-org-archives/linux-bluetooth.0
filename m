Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF54AEB64DA
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Jul 2023 18:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjGBSnL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 2 Jul 2023 14:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGBSnJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 2 Jul 2023 14:43:09 -0400
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71203C1
        for <linux-bluetooth@vger.kernel.org>; Sun,  2 Jul 2023 11:43:08 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4QvHxQ2N0GzyV2;
        Sun,  2 Jul 2023 21:43:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1688323386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AlTNCG/fnP1tZEPZpzcmGFC8ncxPhXa9qgQ2PyluIaQ=;
        b=qiHbVWQ3R5fGKcERTPeITzX1KbES21MGXG5D2nHKif9EeSVHxpSDC6Agxb2pmhEa1cfvb2
        aih9mH/3fdGLJVVsBpXVa4vn6amI3XW6Fkoq3kVW8J0a8S7ggamtp039DBuDWF+juX3uBN
        06bfczvug1gBeJSpjTzWn/LjhK1xZQs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1688323386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AlTNCG/fnP1tZEPZpzcmGFC8ncxPhXa9qgQ2PyluIaQ=;
        b=pe3Bg3r27+yosFFkcFSB3WuZAwIiik1DcPaJn7nbqbfMjmVAHGyaJPilpJSjAw8r+fo+7S
        d/uwabfxnC8CnLbQlvYisaLGupr8fLisZoPOm6qqNnk/voyrmpbjqQExdB6T1+AmArUi63
        s5/BOI/6iNq/hNE3j4wdqLX9sKUVcks=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1688323386; a=rsa-sha256; cv=none;
        b=BcAF5nJsn99SX1H4/cY91LAjrDZcVa+fW74e8xOgvyUqug2d0IR69MSDxy/9e8vndsehOP
        L2pt5OvYRouQKanzRwNZuK9a0qKnIRkHh4ui5dRunElwaSPXYw+GbCdwCbFiF1ztE6exNX
        l/pn2LjY377a+BIU4/zOJWMszXNZ4pc=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 1/2] shared/bap: detach io for source ASEs only after Stop Ready
Date:   Sun,  2 Jul 2023 21:43:04 +0300
Message-ID: <09443d89e7486d890b346d47ebc5c6a8f5eb30af.1688323254.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The Client may terminate a CIS when sink is in QOS and source in
Disabling states (BAP v1.0.1 Sec 5.6.5).  It may also terminate it when
Receiver Stop Ready has completed successfully (BAP v1.0.1 Sec 5.6.5.1).

It appears Samsung Galaxy Buds2 Pro (R510XXUOAWA5) ignores the Receiver
Stop Ready command if CIS is already disconnected, and then gets stuck
in disabling state. It works if CIS is disconnected after Receiver Stop
Ready.

For better compatibility as client for this device, and since it
shouldn't matter for us in which order we do it, disconnect CIS after
completion of Receiver Stop Ready, instead of immediately in Disabling.

We disconnect also if Receiver Stop Ready fails, given that
disconnecting in Disabled state should be OK.

Link: https://github.com/bluez/bluez/issues/516
---

Notes:
    v2: Disconnect when Receiver Stop has completed.
        Keep BAP server behavior unchanged.
    
    I don't have access to PTS, so if it's needed to verify what it does,
    someone else must do it.
    
    Assuming this device was PTS tested, I'd guess its test case does not
    disconnect CIS immediately in Disabling.

 src/shared/bap.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index cf5d810bb..13c76afe6 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1168,18 +1168,6 @@ static bool match_stream_io(const void *data, const void *user_data)
 	return stream->io == io;
 }
 
-static void stream_stop_disabling(void *data, void *user_data)
-{
-	struct bt_bap_stream *stream = data;
-
-	if (stream->io || stream->ep->state != BT_ASCS_ASE_STATE_DISABLING)
-		return;
-
-	DBG(stream->bap, "stream %p", stream);
-
-	bt_bap_stream_stop(stream, NULL, NULL);
-}
-
 static bool bap_stream_io_detach(struct bt_bap_stream *stream)
 {
 	struct bt_bap_stream *link;
@@ -1198,9 +1186,6 @@ static bool bap_stream_io_detach(struct bt_bap_stream *stream)
 		/* Detach link if in QoS state */
 		if (link->ep->state == BT_ASCS_ASE_STATE_QOS)
 			bap_stream_io_detach(link);
-	} else {
-		/* Links without IO on disabling state shall be stopped. */
-		queue_foreach(stream->links, stream_stop_disabling, NULL);
 	}
 
 	stream_io_unref(io);
@@ -1244,6 +1229,15 @@ static struct bt_bap *bt_bap_ref_safe(struct bt_bap *bap)
 	return bt_bap_ref(bap);
 }
 
+static void stream_stop_complete(struct bt_bap_stream *stream, uint8_t code,
+					uint8_t reason,	void *user_data)
+{
+	DBG(stream->bap, "stream %p stop 0x%02x 0x%02x", stream, code, reason);
+
+	if (stream->ep->state == BT_ASCS_ASE_STATE_DISABLING)
+		bap_stream_io_detach(stream);
+}
+
 static void bap_stream_state_changed(struct bt_bap_stream *stream)
 {
 	struct bt_bap *bap = stream->bap;
@@ -1271,7 +1265,9 @@ static void bap_stream_state_changed(struct bt_bap_stream *stream)
 		bap_stream_update_io_links(stream);
 		break;
 	case BT_ASCS_ASE_STATE_DISABLING:
-		bap_stream_io_detach(stream);
+		/* As client, we detach after Receiver Stop Ready */
+		if (!stream->client)
+			bap_stream_io_detach(stream);
 		break;
 	case BT_ASCS_ASE_STATE_QOS:
 		if (stream->io && !stream->io->connecting)
@@ -1305,8 +1301,9 @@ static void bap_stream_state_changed(struct bt_bap_stream *stream)
 			bt_bap_stream_start(stream, NULL, NULL);
 		break;
 	case BT_ASCS_ASE_STATE_DISABLING:
-		if (!bt_bap_stream_get_io(stream))
-			bt_bap_stream_stop(stream, NULL, NULL);
+		/* Send Stop Ready, and detach IO after remote replies */
+		if (stream->client)
+			bt_bap_stream_stop(stream, stream_stop_complete, NULL);
 		break;
 	}
 
-- 
2.41.0

