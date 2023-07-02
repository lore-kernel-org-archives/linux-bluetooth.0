Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185B8EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Jul 2023 19:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjGBTe1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 2 Jul 2023 15:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjGBTe0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 2 Jul 2023 15:34:26 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B956CE60
        for <linux-bluetooth@vger.kernel.org>; Sun,  2 Jul 2023 12:34:23 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4QvK4X6fdbz49Q2n;
        Sun,  2 Jul 2023 22:34:20 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1688326461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1N1lZrXUJXWHRvziwccYAWbBah6BneplGet8LPsr/qs=;
        b=sBM1X75R/j5xR+BBXtbMd1Ow0tZtFSK5QjzbGlGogDvKNCCo0iEMcL/wizyf3BXBSkPvlg
        rf/HbpnA+0iE/CMqdiwewyBxuvA87xWsCQptvATwhhACri97j4dM1hI0ogjEmHRvw35nq/
        KjJvuBCGpC+oX+oIuecqEkNrfjiyAcoHxWoevjnB3KBCZ+3mGahvRIs9QErdHeJjJ5cJ9u
        jDJLRVTos1ZytutmE9/8isubOcwILuCKnYs5BV3Ph5l9n+4/HZyGLjaU8Y0hHrUd2a0Zyq
        ry0+lHUEy6wmfFpedH/WnUn/ODA37esPt2L7pSvflRip+/+v4v2+Oz5MniK9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1688326461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1N1lZrXUJXWHRvziwccYAWbBah6BneplGet8LPsr/qs=;
        b=Qi1jv++HlqcvKRIKcg9YEDGwA0DyyVSVhY+CDPGLlJMfK0vxkXmNd0gDvctRBp1BwPl8bl
        Nn4kWkO0n1fs04VHG48vloM9va3cxIJek/LRYqsPdAYQCCe4+c5g8PkdaxMdqJaKiKd0eN
        NiyrrSkckl01jxVX8k++yr5yoyPigZezAmvX+1ktFMolt2Is2z5lqo+LVWyd4oMGRIPGfB
        O6vdnMS6RB2BcEp9gyBpChYrNVX3CDOKgcCsoPPAwSrfhcqtsfo6yDTVRrEZ6op3rnMpKo
        lbJpNGdz5Pa3Nl/woPazZfjhI+cHO7osEDu/b5RamtZxYIwrnW99rw4zVxTNuQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1688326461; a=rsa-sha256;
        cv=none;
        b=NWOb0lmaBTQXgPBoS5cNLjD1tBfd8Fu1DBVU1vibXklGJNxqoop7Piv6XoxV2BBKbLGpo7
        GznZH2nfNjVlY/ottHeMQkifhNwkZZaCLBQNYz58aVZkYj5RvqoxURC9sGgyFkrI2ovt3l
        UhZ3B/2PWU4ccOGGDmVNo5dC+xFjdNDClnD1oprzbXPs/NyMfDfjeNp3N8uyKfeJWpvafb
        nu6vOtCI+IkhQxbzmhy1BfkSkdEHjkvEJ2iVUSSjeJKujHsEJ1hHZRtpEMIgJn9JO8FM9C
        iiwse7fs539MP8rwGC3DW2sbOYPQl/au08himxTfdXR5Xhg1WHDDBHtmviZOXg==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/2] transport: handle BAP Enabling state correctly when resuming
Date:   Sun,  2 Jul 2023 22:34:18 +0300
Message-ID: <8af1dd5097cc4411ff2681ed39c49c232f817ebe.1688326228.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If BAP stream is in Enabling state when transport acquire is attempted,
we should wait for bap_state_changed to emit the completion event.

transport->resume() is only called with new owner with no
owner->pending, and shall return nonzero completion id on success.
Currently if BAP stream is Enabling, it returns zero which fails the
acquire operation.

To fix this, return valid completion id in this case instead.  Also keep
track of the g_idle_add resume id, so that we don't try to give it to
bt_bap_stream_cancel.

Fixes sound server getting spurious Not Authorized errors when trying to
acquire a pending transport.  This can happen on BAP server: linked
transports become pending when the first of the two enters Streaming. If
sound server tries to acquire the other linked transport whose stream is
still Enabling, the acquire fails (media_owner_free +
btd_error_not_authorized).

Log:
===============================================================
profiles/audio/transport.c:bap_state_changed() stream 0x25c2880: qos(2) -> enabling(3)
...
profiles/audio/transport.c:bap_state_changed() stream 0x25cc590: qos(2) -> enabling(3)
...
src/shared/bap.c:bap_stream_state_changed() stream 0x25cc590 dir 0x01: enabling -> streaming
profiles/audio/bap.c:bap_state() stream 0x25cc590: enabling(3) -> streaming(4)
profiles/audio/transport.c:bap_state_changed() stream 0x25cc590: enabling(3) -> streaming(4)
/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/fd1: fd(36) ready
profiles/audio/transport.c:transport_update_playing() /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/fd1 State=TRANSPORT_STATE_IDLE Playing=1
profiles/audio/transport.c:transport_set_state() State changed /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/fd1: TRANSPORT_STATE_IDLE -> TRANSPORT_STATE_PENDING
profiles/audio/transport.c:transport_set_state() State changed /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/fd0: TRANSPORT_STATE_IDLE -> TRANSPORT_STATE_PENDING
profiles/audio/transport.c:media_owner_create() Owner created: sender=:1.1242
profiles/audio/transport.c:media_owner_free() Owner :1.1242
===============================================================
---
 profiles/audio/transport.c | 67 +++++++++++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 12 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 77216e10b..aa3a718b0 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -86,6 +86,7 @@ struct bap_transport {
 	unsigned int		state_id;
 	bool			linked;
 	struct bt_bap_qos	qos;
+	guint			resume_id;
 };
 
 struct media_transport {
@@ -1191,17 +1192,27 @@ static void bap_enable_complete(struct bt_bap_stream *stream,
 		media_transport_remove_owner(owner->transport);
 }
 
-static gboolean resume_complete(void *data)
+static void bap_resume_complete(struct media_transport *transport)
 {
-	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
 	struct media_owner *owner = transport->owner;
 
+	DBG("stream %p owner %p resume complete", bap->stream, owner);
+
+	if (bap->resume_id) {
+		g_source_remove(bap->resume_id);
+		bap->resume_id = 0;
+	}
+
 	if (!owner)
-		return FALSE;
+		return;
+
+	if (owner->pending)
+		owner->pending->id = 0;
 
 	if (transport->fd < 0) {
 		media_transport_remove_owner(transport);
-		return FALSE;
+		return;
 	}
 
 	if (owner->pending) {
@@ -1215,15 +1226,13 @@ static gboolean resume_complete(void *data)
 						DBUS_TYPE_INVALID);
 		if (!ret) {
 			media_transport_remove_owner(transport);
-			return FALSE;
+			return;
 		}
 	}
 
 	media_owner_remove(owner);
 
 	transport_set_state(transport, TRANSPORT_STATE_ACTIVE);
-
-	return FALSE;
 }
 
 static void bap_update_links(const struct media_transport *transport);
@@ -1306,6 +1315,32 @@ static void bap_update_qos(const struct media_transport *transport)
 			"Delay");
 }
 
+static gboolean bap_resume_complete_cb(void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	bap->resume_id = 0;
+	bap_resume_complete(transport);
+	return FALSE;
+}
+
+static gboolean bap_resume_wait_cb(void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+	struct media_owner *owner = transport->owner;
+
+	/* bap_state_changed will call completion callback when ready */
+	DBG("stream %p owner %p resume wait", bap->stream, owner);
+
+	bap->resume_id = 0;
+	if (owner && owner->pending)
+		owner->pending->id = 0;
+
+	return FALSE;
+}
+
 static guint resume_bap(struct media_transport *transport,
 				struct media_owner *owner)
 {
@@ -1315,17 +1350,19 @@ static guint resume_bap(struct media_transport *transport,
 
 	if (!bap->stream)
 		return 0;
+	if (bap->resume_id)
+		return 0;
 
 	bap_update_links(transport);
 
 	switch (bt_bap_stream_get_state(bap->stream)) {
 	case BT_BAP_STREAM_STATE_ENABLING:
 		bap_enable_complete(bap->stream, 0x00, 0x00, owner);
-		if (owner->pending)
-			return owner->pending->id;
-		return 0;
+		bap->resume_id = g_idle_add(bap_resume_wait_cb, transport);
+		return bap->resume_id;
 	case BT_BAP_STREAM_STATE_STREAMING:
-		return g_idle_add(resume_complete, transport);
+		bap->resume_id = g_idle_add(bap_resume_complete_cb, transport);
+		return bap->resume_id;
 	}
 
 	meta = bt_bap_stream_get_metadata(bap->stream);
@@ -1389,6 +1426,12 @@ static void cancel_bap(struct media_transport *transport, guint id)
 {
 	struct bap_transport *bap = transport->data;
 
+	if (id == bap->resume_id && bap->resume_id) {
+		g_source_remove(bap->resume_id);
+		bap->resume_id = 0;
+		return;
+	}
+
 	if (!bap->stream)
 		return;
 
@@ -1491,7 +1534,7 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 	transport_update_playing(transport, TRUE);
 
 done:
-	resume_complete(transport);
+	bap_resume_complete(transport);
 }
 
 static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
-- 
2.41.0

