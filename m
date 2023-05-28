Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2054AC77B7E
	for <linux-bluetooth@archiver.kernel.org>; Sun, 28 May 2023 17:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjE1Rkf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 28 May 2023 13:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE1Rke (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 28 May 2023 13:40:34 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57449A0
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 10:40:33 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 0A7D8240101
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 19:40:32 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QTmCM3sNTz9rxF;
        Sun, 28 May 2023 19:40:31 +0200 (CEST)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/2] shared/bap: detach io for source ASEs at QoS when disabling
Date:   Sun, 28 May 2023 17:40:29 +0000
Message-Id: <bc567c4cb647d89e2e76568583716b4e44092519.1685284537.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The Client may terminate a CIS when sink is in QOS and source in
Disabling states (BAP v1.0.1 Sec 5.6.5).  It may also terminate it when
Receiver Stop Ready has completed successfully (BAP v1.0.1 Sec 5.6.5.1).
On successful Receiver Stop Ready the Server shall transition the ASE
back to QoS state (ASCS v1.0 Sec 5.6).

It appears Samsung Galaxy Buds2 Pro (R510XXUOAWA5) ignores the Receiver
Stop Ready command if CIS is already disconnected, and then gets stuck
in disabling state. It works if CIS is disconnected after Receiver Stop
Ready.

For better compatibility, disconnect CIS only after the source ASE is
back in the QoS state. This is what we also do with sinks.

Link: https://github.com/bluez/bluez/issues/516
---
 src/shared/bap.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index f194f466f..16a9cec5b 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1115,18 +1115,6 @@ static bool match_stream_io(const void *data, const void *user_data)
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
@@ -1145,9 +1133,6 @@ static bool bap_stream_io_detach(struct bt_bap_stream *stream)
 		/* Detach link if in QoS state */
 		if (link->ep->state == BT_ASCS_ASE_STATE_QOS)
 			bap_stream_io_detach(link);
-	} else {
-		/* Links without IO on disabling state shall be stopped. */
-		queue_foreach(stream->links, stream_stop_disabling, NULL);
 	}
 
 	stream_io_unref(io);
@@ -1218,7 +1203,6 @@ static void bap_stream_state_changed(struct bt_bap_stream *stream)
 		bap_stream_update_io_links(stream);
 		break;
 	case BT_ASCS_ASE_STATE_DISABLING:
-		bap_stream_io_detach(stream);
 		break;
 	case BT_ASCS_ASE_STATE_QOS:
 		if (stream->io && !stream->io->connecting)
@@ -1252,8 +1236,8 @@ static void bap_stream_state_changed(struct bt_bap_stream *stream)
 			bt_bap_stream_start(stream, NULL, NULL);
 		break;
 	case BT_ASCS_ASE_STATE_DISABLING:
-		if (!bt_bap_stream_get_io(stream))
-			bt_bap_stream_stop(stream, NULL, NULL);
+		/* IO is detached when back in QOS */
+		bt_bap_stream_stop(stream, NULL, NULL);
 		break;
 	}
 
-- 
2.40.1

