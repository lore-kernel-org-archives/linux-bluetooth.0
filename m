Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AF91AA7AB
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Nov 2024 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730579414; cv=pass; b=dTOClro6kkEwr9jiSnwJiSMt/8U8fB+WxmJnq4c2dqlYvpE4lPDKD03bs3nNU/rW8PlGTEw+xXzS3KS+5YSL71YP7BGsU6+Xv0WDrYJQeLXEME3E3s01Nr99lJl94OvXRcGZY3giGUK1FE6Vl6eQlxl/WW7MyeIcpbmpuu+uIvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730579414; c=relaxed/simple;
	bh=pnRk3G4zvB7128KAvCCFskQZbtfGlI0GHvYB7iHLeU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZjOwPvmTBSjsXmD9pmLPJrwVGGoUn7BcrUSuAfzF36AITWYovEkbRB8uJv9/dJllQNxABXykz4Dmac9luC6TXF5QIUxoTK/AYY0ggzMqD4SW+2TDzIMu+ooSbyOWuyRD4RnhsqZsI+N+6r85jNk5WSB88MrgmtqBTb2F+nPbvdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=NeJMhu4O; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=udhHLRdU; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="NeJMhu4O";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="udhHLRdU"
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4Xgq964rp4z49Q4b
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Nov 2024 22:30:02 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1730579402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cLWyKi07yJ+ov2tAFZIVPPh8RLhnfJLWo//x149trSY=;
	b=NeJMhu4Oyrh1wboICKsCSviwgCCAY57t5/CZY+EJaE2C5zLGP8arJNVg9gz0YPNDnI8IKx
	IZnh+m5qHxMpxRyb9QxYdQ18jHYq2eCSir2P0+kWY+47CSGtliBlToJk+zaIK3gNYLhxMP
	Jjq+UJHydDgMVGBDTNF9ExH9itbEuV246GMmwDv4TIMSuNSUuodNG2EpvYI8kjquCSWGOw
	aI2vpHJ/L1x3v97COIiel1w1Vs1hUHf+3XbgUzsYzc8xnf8sFr9tW0/3QojxpddN1KAyKh
	/+QAI5S/tgZvkWS+PS76xGgjEj5+Nf2gyrLrR1Cnzcal36/8maiZgJ0z/CQ7SA==
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Xgq8y4TDwz106T;
	Sat,  2 Nov 2024 22:29:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1730579395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cLWyKi07yJ+ov2tAFZIVPPh8RLhnfJLWo//x149trSY=;
	b=udhHLRdU1hK63wFFTh6KS5DnQDw7W8FpZoNRQPemXrGkf1t/WG8ZTkEAhJoLfwD0CtdAoo
	8mK+P0I7ojHeoGBT8GfI7itHtaLW/y8a67X4d3YsTMra+Jav+8oU1BSEAooFciAvOcN9XA
	mKi3Bvgqo9wDJddt0MSwEJCfg9UVuOI=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1730579395; a=rsa-sha256; cv=none;
	b=axfCgJ6Q7ILCpr++4QpkDarOc+KsPkA1Yv+g+BYVLUb8Hd6QqMHJeufGdvUptKahLH9dS4
	aL8Nrjl0sbesF35XMTHlmA4h4lXAQTlyxwviiSyAasSuOVNaZKv5ByB2AIuXCAc8Z8WOB+
	o9Bkw1WWKPpMXWUGhTdJAzENqYsZU9Y=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1730579395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cLWyKi07yJ+ov2tAFZIVPPh8RLhnfJLWo//x149trSY=;
	b=wUbzJ1IDjfenqYMwdO2fERU8hiID3PyqmH5BtqD0DVJeT0Qi7ExaHco5XZR6VIZhos7dvS
	84K6CRFUdD5EtuKmpUGa8ko2LbKLhH+LuO3YT7lZZssHZYoMTs/7jzGYnX5+hiCk1gbuuY
	+Ujfm87de2Pid8wc6HGJpLyyyctFi74=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 1/2] transport: don't disconnect A2DP if canceling Acquire() with Release()
Date: Sat,  2 Nov 2024 22:29:45 +0200
Message-ID: <e96a0f052fd93f65a24e82d44249b2aa0169cb21.1730579026.git.pav@iki.fi>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730579026.git.pav@iki.fi>
References: <cover.1730579026.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

User can cancel transport acquire by calling Release() while Acquire()
is in progress. This calls a2dp_cancel() which sends AVDTP_ABORT_CMD,
forcing AVDTP state transition to IDLE, and A2DP profile disconnects.

However, Release()/Acquire() should only result to transitions between
STREAMING/OPEN.  The expected behavior is that either these calls return
error, or they block until the target state is reached.

Fix by: Release() during pending Acquire() first sends error reply to
the Acquire. Then it waits for START to complete, then sends SUSPEND,
and after that completes, then it replies.

This also fixes SetConfiguration() after canceled Acquire(), which
previously did not work due to AVDTP disconnect. Now it does
START/SUSPEND -> CLOSE -> reconfigure.
---
 profiles/audio/transport.c | 179 ++++++++++++++++++++++++++++---------
 1 file changed, 137 insertions(+), 42 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index c7a0eaec3..8597313d8 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -88,6 +88,9 @@ struct a2dp_transport {
 	uint16_t		delay;
 	int8_t			volume;
 	guint			watch;
+	guint			resume_id;
+	gboolean		cancel_resume;
+	guint			cancel_id;
 };
 
 struct bap_transport {
@@ -394,22 +397,110 @@ static void *transport_a2dp_get_stream(struct media_transport *transport)
 	return a2dp_sep_get_stream(sep);
 }
 
+static void a2dp_suspend_complete(struct avdtp *session, int err,
+							void *user_data)
+{
+	struct media_owner *owner = user_data;
+	struct media_transport *transport = owner->transport;
+	struct a2dp_transport *a2dp = transport->data;
+	struct a2dp_sep *sep = media_endpoint_get_sep(transport->endpoint);
+
+	/* Release always succeeds */
+	if (owner->pending) {
+		owner->pending->id = 0;
+		media_request_reply(owner->pending, 0);
+		media_owner_remove(owner);
+	}
+
+	a2dp_sep_unlock(sep, a2dp->session);
+	transport_set_state(transport, TRANSPORT_STATE_IDLE);
+	media_transport_remove_owner(transport);
+}
+
+static guint transport_a2dp_suspend(struct media_transport *transport,
+						struct media_owner *owner)
+{
+	struct a2dp_transport *a2dp = transport->data;
+	struct media_endpoint *endpoint = transport->endpoint;
+	struct a2dp_sep *sep = media_endpoint_get_sep(endpoint);
+
+	if (owner != NULL) {
+		if (a2dp->resume_id) {
+			a2dp->cancel_resume = TRUE;
+			return a2dp->resume_id;
+		}
+
+		return a2dp_suspend(a2dp->session, sep, a2dp_suspend_complete,
+									owner);
+	}
+
+	transport_set_state(transport, TRANSPORT_STATE_IDLE);
+	a2dp_sep_unlock(sep, a2dp->session);
+
+	return 0;
+}
+
+static gboolean a2dp_cancel_resume_cb(void *user_data)
+{
+	struct media_owner *owner = user_data;
+	struct media_transport *transport = owner->transport;
+	struct a2dp_transport *a2dp = transport->data;
+	guint id;
+
+	a2dp->cancel_id = 0;
+
+	if (!owner->pending)
+		goto fail;
+
+	owner->pending->id = 0;
+
+	/* The suspend fails e.g. if stream was closed/aborted. This happens if
+	 * SetConfiguration() was called while we were waiting for the START to
+	 * complete.
+	 *
+	 * We bail out from the Release() with error in that case.
+	 */
+	id = transport_a2dp_suspend(transport, owner);
+	if (id)
+		owner->pending->id = id;
+	else
+		goto fail;
+
+	return FALSE;
+
+fail:
+	media_transport_remove_owner(transport);
+	return FALSE;
+}
+
 static void a2dp_resume_complete(struct avdtp *session, int err,
 							void *user_data)
 {
 	struct media_owner *owner = user_data;
 	struct media_request *req = owner->pending;
 	struct media_transport *transport = owner->transport;
+	struct a2dp_transport *a2dp = transport->data;
 	struct avdtp_stream *stream;
 	int fd;
 	uint16_t imtu, omtu;
 	gboolean ret;
 
+	a2dp->resume_id = 0;
+
+	if (!req)
+		goto fail;
+
 	req->id = 0;
 
 	if (err)
 		goto fail;
 
+	if (a2dp->cancel_resume) {
+		DBG("cancel resume");
+		a2dp->cancel_id = g_idle_add(a2dp_cancel_resume_cb, owner);
+		return;
+	}
+
 	stream = transport_a2dp_get_stream(transport);
 	if (stream == NULL)
 		goto fail;
@@ -446,15 +537,20 @@ static guint transport_a2dp_resume(struct media_transport *transport,
 	struct a2dp_sep *sep = media_endpoint_get_sep(endpoint);
 	guint id;
 
+	if (a2dp->resume_id || a2dp->cancel_id)
+		return 0;
+
 	if (a2dp->session == NULL) {
 		a2dp->session = a2dp_avdtp_get(transport->device);
 		if (a2dp->session == NULL)
 			return 0;
 	}
 
-	if (state_in_use(transport->state))
-		return a2dp_resume(a2dp->session, sep, a2dp_resume_complete,
+	if (state_in_use(transport->state)) {
+		id = a2dp_resume(a2dp->session, sep, a2dp_resume_complete,
 									owner);
+		goto done;
+	}
 
 	if (a2dp_sep_lock(sep, a2dp->session) == FALSE)
 		return 0;
@@ -469,51 +565,47 @@ static guint transport_a2dp_resume(struct media_transport *transport,
 	if (transport->state == TRANSPORT_STATE_IDLE)
 		transport_set_state(transport, TRANSPORT_STATE_REQUESTING);
 
+done:
+	a2dp->resume_id = id;
+	a2dp->cancel_resume = FALSE;
 	return id;
 }
 
-static void a2dp_suspend_complete(struct avdtp *session, int err,
-							void *user_data)
-{
-	struct media_owner *owner = user_data;
-	struct media_transport *transport = owner->transport;
-	struct a2dp_transport *a2dp = transport->data;
-	struct a2dp_sep *sep = media_endpoint_get_sep(transport->endpoint);
-
-	/* Release always succeeds */
-	if (owner->pending) {
-		owner->pending->id = 0;
-		media_request_reply(owner->pending, 0);
-		media_owner_remove(owner);
-	}
-
-	a2dp_sep_unlock(sep, a2dp->session);
-	transport_set_state(transport, TRANSPORT_STATE_IDLE);
-	media_transport_remove_owner(transport);
-}
-
-static guint transport_a2dp_suspend(struct media_transport *transport,
-						struct media_owner *owner)
-{
-	struct a2dp_transport *a2dp = transport->data;
-	struct media_endpoint *endpoint = transport->endpoint;
-	struct a2dp_sep *sep = media_endpoint_get_sep(endpoint);
-
-	if (owner != NULL)
-		return a2dp_suspend(a2dp->session, sep, a2dp_suspend_complete,
-									owner);
-
-	transport_set_state(transport, TRANSPORT_STATE_IDLE);
-	a2dp_sep_unlock(sep, a2dp->session);
-
-	return 0;
-}
-
 static void transport_a2dp_cancel(struct media_transport *transport, guint id)
 {
+	struct a2dp_transport *a2dp = transport->data;
+
+	/* a2dp_cancel() results to ABORT->IDLE->disconnect. For START we
+	 * instead wait the operation out.
+	 */
+	if (id == a2dp->resume_id) {
+		a2dp->cancel_resume = TRUE;
+		return;
+	}
+
 	a2dp_cancel(id);
 }
 
+static void transport_a2dp_remove_owner(struct media_transport *transport,
+					struct media_owner *owner)
+{
+	struct a2dp_transport *a2dp = transport->data;
+
+	/* Cancel any pending operations for the owner */
+
+	if (a2dp->cancel_id) {
+		g_source_remove(a2dp->cancel_id);
+		a2dp->cancel_id = 0;
+	}
+
+	if (a2dp->resume_id) {
+		a2dp_cancel(a2dp->resume_id);
+		a2dp->resume_id = 0;
+	}
+
+	a2dp->cancel_resume = FALSE;
+}
+
 static int8_t transport_a2dp_get_volume(struct media_transport *transport)
 {
 	struct a2dp_transport *a2dp = transport->data;
@@ -804,10 +896,12 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 
 		member = dbus_message_get_member(owner->pending->msg);
 		/* Cancel Acquire request if that exist */
-		if (g_str_equal(member, "Acquire"))
+		if (g_str_equal(member, "Acquire")) {
+			media_request_reply(owner->pending, ECANCELED);
 			media_owner_remove(owner);
-		else
+		} else {
 			return btd_error_in_progress(msg);
+		}
 	}
 
 	transport_set_state(transport, TRANSPORT_STATE_SUSPENDING);
@@ -2280,7 +2374,8 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 }
 
 #define A2DP_OPS(_uuid, _init, _set_volume, _set_delay, _destroy) \
-	TRANSPORT_OPS(_uuid, transport_a2dp_properties, NULL, NULL, _init, \
+	TRANSPORT_OPS(_uuid, transport_a2dp_properties, NULL, \
+			transport_a2dp_remove_owner, _init,	      \
 			transport_a2dp_resume, transport_a2dp_suspend, \
 			transport_a2dp_cancel, NULL, \
 			transport_a2dp_get_stream, transport_a2dp_get_volume, \
-- 
2.47.0

