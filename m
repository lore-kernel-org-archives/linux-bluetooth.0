Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F94C1D095C
	for <linux-bluetooth@vger.kernel.org>; Sat, 26 Oct 2024 10:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729939310; cv=pass; b=dZ4GWUIFWcSfk2sq+Bd3jRNINw1WH9aGihh1wM0qAhtuqgeffwAH71OqQL9cXev1q979k2tMK0DhfHIACdQhPgF1yCCDptvnNIW2Z/PLPse3p4QXf2E/Dot+0Joeb6bQgBz0/AZLG7NeBKrN2aZDeHCoX9W0W5zy89wDC90qYGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729939310; c=relaxed/simple;
	bh=xuDf66QnV3KYoN9m9/lH2CSaGt1TeoRYCrCjIITr1WA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j2pUsXtKnzv13oOtP4H6bwfrBfgBkajMXFRLfkdfjQFxr4h/0P8kSQBJgTVGOCRHhiUeFl/fYq3oOBBG+sO6oaYFswjnAVGgoeZgnxF2tkta/AhXPU9YWdcquGjQw9cDcw3nqtwoSj2tcQ5sWSIAGv+K9LMcmsA0G6Tmt7deEKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=NuAInr4e; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="NuAInr4e"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4XbGRQ3xwRzyNS;
	Sat, 26 Oct 2024 13:41:38 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1729939299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VJkDKxqYewRBuXuG+gMPwelCoMYY+1il41B5TeLo1zQ=;
	b=NuAInr4e01mhYN3INTA0GavZlR8DMid43OcPJugqwwtcOw0JB2xbd86fbEwgyPnjLboSLI
	HZU+qq5ebJMDs8fAf873OiOgof2APae9fOq/JWbK4BkufUx6gZcIvzmRgYQq+hLGfi8ff9
	7BCM28LiXqcmYe9friz7haWb3ExNIP0=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1729939299; a=rsa-sha256; cv=none;
	b=XLp/HUvJj1gYWOHb4BKgDbyW8X3c2PB9iiIuIqS8wPqjNwZkKEzTa95vlycmBw0RaxPO+l
	cjjjWpGDyNJ5miHEVwcCNw5wt9w/waLoqDf7BLtPVqu6OSQGcaU6UadaWzddO2ic1ymHzY
	CLQUEw5sj2dzZ44ACGcd7jumBaTOcTk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1729939299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VJkDKxqYewRBuXuG+gMPwelCoMYY+1il41B5TeLo1zQ=;
	b=XNmmN/qzyqMtTfNB4Esphy0Bn4upLhmmmXpAf2XXkhIOy+psIr++xXz7d0QzhTyUifXxAM
	vERSIG3GH+uUYhHeCtgAQxSZFJ/3wU+U3vI1yPxfR9x+Z4RRXQT7EhRSWtFKlip7iWItGq
	THXOW+Ivlx/h6aLYIQI8SM5Eb2ZZCCw=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] transport: don't disconnect A2DP if canceling Acquire() with Release()
Date: Sat, 26 Oct 2024 13:41:33 +0300
Message-ID: <7a256931b2a2f2fa860e8cc33d21f5100468e40f.1729939092.git.pav@iki.fi>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

User can cancel transport acquire by calling Release() while Acquire()
is in progress. This calls a2dp_cancel() which sends AVDTP_ABORT_CMD,
forcing AVDTP state transition to IDLE, and disconnecting A2DP profile,
which is not desired.

Fix by instead waiting until START completes and then send SUSPEND. Make
Release() reply only after the whole sequence completes.

Fix also sending error reply to the canceled Acquire() call, which was
missing previously.
---

Notes:
    In theory we could also send ABORT and reconfigure the SEP again after
    that. It's more hairy though as with how the code currently works, we
    may need to complete discovery first. This is a corner case anyway, so
    just waiting a bit should be easier.

 profiles/audio/transport.c | 152 +++++++++++++++++++++++++++----------
 1 file changed, 110 insertions(+), 42 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 0f7909a94..4d5afe022 100644
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
@@ -393,22 +396,82 @@ static void *transport_a2dp_get_stream(struct media_transport *transport)
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
+	if (a2dp->cancel_resume)
+		return a2dp->resume_id;
+
+	if (owner != NULL)
+		return a2dp_suspend(a2dp->session, sep, a2dp_suspend_complete,
+									owner);
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
+
+	a2dp->cancel_id = 0;
+	a2dp->cancel_resume = FALSE;
+	owner->pending->id = transport_a2dp_suspend(transport, owner);
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
@@ -445,15 +508,21 @@ static guint transport_a2dp_resume(struct media_transport *transport,
 	struct a2dp_sep *sep = media_endpoint_get_sep(endpoint);
 	guint id;
 
+	if (a2dp->resume_id || a2dp->cancel_id)
+		return -EBUSY;
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
+		a2dp->resume_id = id;
+		return id;
+	}
 
 	if (a2dp_sep_lock(sep, a2dp->session) == FALSE)
 		return 0;
@@ -468,51 +537,47 @@ static guint transport_a2dp_resume(struct media_transport *transport,
 	if (transport->state == TRANSPORT_STATE_IDLE)
 		transport_set_state(transport, TRANSPORT_STATE_REQUESTING);
 
+	a2dp->resume_id = id;
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
+	if (a2dp->resume_id && a2dp->resume_id == id) {
+		/* a2dp_cancel() results to ABORT->IDLE->disconnect. Canceling
+		 * START can be triggered by user via Release(), and it's better
+		 * to not drop the A2DP connection then, so we just suspend
+		 * after resume completes.
+		 */
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
+	/* Clean up callbacks that refer to the owner */
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
@@ -773,10 +838,12 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 
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
@@ -2189,7 +2256,8 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 }
 
 #define A2DP_OPS(_uuid, _init, _set_volume, _destroy) \
-	TRANSPORT_OPS(_uuid, transport_a2dp_properties, NULL, NULL, _init, \
+	TRANSPORT_OPS(_uuid, transport_a2dp_properties, NULL, \
+			transport_a2dp_remove_owner, _init, \
 			transport_a2dp_resume, transport_a2dp_suspend, \
 			transport_a2dp_cancel, NULL, \
 			transport_a2dp_get_stream, transport_a2dp_get_volume, \
-- 
2.47.0

