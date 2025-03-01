Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832761E2614
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Mar 2025 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740844677; cv=pass; b=OOFaMg44qQJjDqMSDRuixLWKDbwNGi0n38+8CpWVcSYrCj8ZM0izxyzPyu6Ku9EcLZyIR1GoMn4yhs0IbOX9bUKzclWi00DWftXxGgnqwvgVogi8UvFKp/yJ+GTFtMtmGNlLG18WnCVhzePkvt7d5fHZDuiq9qsRT5jthyXoTos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740844677; c=relaxed/simple;
	bh=krzWgWBaRgzESrX8FAllhCFWCdRgM3n3/CTwsJMG3uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8Tw7l0bT7UemktyoVOzgUq0gW7Ki8LTtudGWVxmmxZXrZauoRffLfK0Loq70Ts2XpSYhUgvfx7NlrGJAAgQb/0fIxpig+51YXB9CYP3n+nXbYXx1nYEgKKhts/MJbCzv3gFGDaiQ8yp1Xc8TGIuUzroBXdGpICAhIgozQ2o/N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=HwAINF0I; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="HwAINF0I"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Z4qV40lNFz4BKHY;
	Sat,  1 Mar 2025 17:57:47 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1740844668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6da2jtaZhWuDX7JVWwBQJce5gdOKNslhErD2wiZ14EM=;
	b=HwAINF0IKqO1kotPB/Q6tJsTGZBrKxtvAUsfghGqhzVC+Gw/DoicBdFD2QUaCvle1uBz2d
	wc4Y0vT3uqavAvOkwMiMNna9kZDSFvSbknavaCAG5LIxnKUJsa1vrAE4EV0PcOT9+CQVqM
	ovLFrD0ZdAifohA944vy64L0dFOuQyUp/5a/LDNIQktRcucuJy7VhFrJVHPpj0v2W/+lSY
	3JvQVL+W+Uft4zzY8RORKF8duV/3H2qHZJznCSFTrZaez+GMh10+ZLrxmrCbOMOepSd+Lv
	gJkCNm6HkI3IP8/KZqQZZZdgrLRIiSEaruUkK4DhnejzxluFCWA2qb+MJm8DSQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1740844668; a=rsa-sha256;
	cv=none;
	b=vbEj34D6YF0REh7O5Ct+k+nhNyj9k1xhGESrODsuC8uOMRCdylcxjtz3lwqifkCm3kSfAV
	VgX0TX/hW4iB+eErAzbtXom4ek/wORfKribQkEqbQNEQkqTFRg+/K5glZlAgq6BDDfgs6/
	eB+fHJcnZMD9rHy02hyH6iL5fi4njMQSRtBsHhNl7aVybDOOAwUz8RNkusvUfmuvlX/VFy
	J/L04+MLMkBHZVjWKLMKDjimaVLuymNJen9JtaxQly8g/VkiU/bDdjaE5qSmrnQZvWOdFT
	sJ9w4EjcTQvYfNKso/tKLhfLtGrG9KwhdGbMB+/xfYFlYl8IqHTvuk77RnyvgQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1740844668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6da2jtaZhWuDX7JVWwBQJce5gdOKNslhErD2wiZ14EM=;
	b=lvtquKQJiFPWeriDMrj8vnbduQuP17IkwOolo4AbGGVhtAjVRPGdD8WVcA25tIiBaMm7Wv
	5PQHLzoOvRTtE+fq5l+4QDcfzEPJKpGAS5+CODdiETCRZ0LwxBcnq8OPYBsGcWgjLB03Uh
	h/ZkZtdVTffwC9qgQGoE417ubfoONIyjVetL4cUIZy932fMb/Pyi4Eb4FuDqWvUXnC7HSL
	ZT7HVFj8sPaRNDHtvudvUrAjBI7mrQb5xiB4mPlTCU6Y80oEqrB+xEoQv0Bl2Ez8CqRTIn
	4npoLq1VBoVOV3VMAqLp1QjOaSwS8o7EvsAFtqq6IGEViZI+dJujmMvAPRC87w==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH BlueZ 3/9] bap: add and use chainable future abstraction
Date: Sat,  1 Mar 2025 17:57:34 +0200
Message-ID: <5aff62c90e7e313b42f28cbc3c8c81788f74c8ce.1740844616.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740844616.git.pav@iki.fi>
References: <cover.1740844616.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multi-part operations will need to postpone things like DBus replies
until all parts are complete. Make this a bit simpler with a chainable
future.
---
 profiles/audio/bap.c | 136 +++++++++++++++++++++++++++++++++----------
 1 file changed, 105 insertions(+), 31 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 37168e58c..8b9b89c70 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -80,7 +80,7 @@ struct bap_setup {
 	struct iovec *metadata;
 	unsigned int id;
 	struct iovec *base;
-	DBusMessage *msg;
+	struct future *qos_done;
 	void (*destroy)(struct bap_setup *setup);
 };
 
@@ -114,6 +114,17 @@ struct bap_data {
 	void *user_data;
 };
 
+typedef void (*future_func_t)(int err, const char *err_msg, void *data);
+
+struct future {
+	unsigned int step, steps;
+	const char *name;
+	future_func_t func;
+	void *data;
+	int err;
+	const char *err_msg;
+};
+
 static struct queue *sessions;
 
 /* Structure holding the parameters for Periodic Advertisement create sync.
@@ -155,6 +166,94 @@ struct bt_iso_qos bap_sink_pa_qos = {
 	}
 };
 
+static void future_clear(struct future **p, int err, const char *err_msg)
+{
+	struct future *h = *p;
+
+	if (!h)
+		return;
+
+	DBG("future %p (%s) 0x%02x (%s) step %u/%u", h, h->name ? h->name : "",
+		err, (err && err_msg) ? err_msg : "", h->step + 1, h->steps);
+
+	*p = NULL;
+
+	if (err && !h->err) {
+		h->err = err;
+		h->err_msg = err_msg;
+	}
+
+	if (++h->step < h->steps)
+		return;
+
+	h->func(h->err, h->err_msg, h->data);
+	free(h);
+}
+
+static void future_dbus_callback_func(int err, const char *err_msg, void *data)
+{
+	DBusMessage *msg = data;
+	DBusMessage *reply;
+
+	if (err && !err_msg)
+		err_msg = strerror(err);
+
+	switch (err) {
+	case 0:
+		reply = dbus_message_new_method_return(msg);
+		break;
+	case EINVAL:
+		reply = btd_error_invalid_args_str(msg, err_msg);
+		break;
+	default:
+		reply = btd_error_failed(msg, err_msg);
+		break;
+	}
+
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
+
+	dbus_message_unref(msg);
+}
+
+static void future_init(struct future **p, const char *name, future_func_t func,
+								void *data)
+{
+	struct future *h;
+
+	future_clear(p, ECANCELED, NULL);
+
+	h = new0(struct future, 1);
+	h->steps = 1;
+	h->name = name;
+	h->func = func;
+	h->data = data;
+
+	DBG("future %p (%s) init", h, h->name ? h->name : "");
+
+	*p = h;
+}
+
+static void future_init_dbus_reply(struct future **p, const char *name,
+							DBusMessage *msg)
+{
+	future_init(p, name, future_dbus_callback_func, dbus_message_ref(msg));
+}
+
+__attribute__((unused))
+static void future_init_chain(struct future **p, struct future *h)
+{
+	future_clear(p, ECANCELED, NULL);
+
+	if (h) {
+		h->steps++;
+
+		DBG("future %p (%s) init step %u", h, h->name ? h->name : "",
+								h->steps);
+	}
+
+	*p = h;
+}
+
 static bool bap_data_set_user_data(struct bap_data *data, void *user_data)
 {
 	if (!data)
@@ -740,24 +839,12 @@ static void qos_cb(struct bt_bap_stream *stream, uint8_t code, uint8_t reason,
 					void *user_data)
 {
 	struct bap_setup *setup = user_data;
-	DBusMessage *reply;
 
 	DBG("stream %p code 0x%02x reason 0x%02x", stream, code, reason);
 
 	setup->id = 0;
 
-	if (!setup->msg)
-		return;
-
-	if (!code)
-		reply = dbus_message_new_method_return(setup->msg);
-	else
-		reply = btd_error_failed(setup->msg, "Unable to configure");
-
-	g_dbus_send_message(btd_get_dbus_connection(), reply);
-
-	dbus_message_unref(setup->msg);
-	setup->msg = NULL;
+	future_clear(&setup->qos_done, code ? EIO : 0, "Unable to configure");
 }
 
 static void config_cb(struct bt_bap_stream *stream,
@@ -765,7 +852,6 @@ static void config_cb(struct bt_bap_stream *stream,
 					void *user_data)
 {
 	struct bap_setup *setup = user_data;
-	DBusMessage *reply;
 
 	DBG("stream %p code 0x%02x reason 0x%02x", stream, code, reason);
 
@@ -786,14 +872,7 @@ static void config_cb(struct bt_bap_stream *stream,
 		return;
 	}
 
-	if (!setup->msg)
-		return;
-
-	reply = btd_error_failed(setup->msg, "Unable to configure");
-	g_dbus_send_message(btd_get_dbus_connection(), reply);
-
-	dbus_message_unref(setup->msg);
-	setup->msg = NULL;
+	future_clear(&setup->qos_done, EIO, "Unable to configure");
 }
 
 static void setup_io_close(void *data, void *user_data)
@@ -872,7 +951,6 @@ static struct bap_setup *setup_new(struct bap_ep *ep)
 static void setup_free(void *data)
 {
 	struct bap_setup *setup = data;
-	DBusMessage *reply;
 
 	DBG("%p", setup);
 
@@ -881,12 +959,7 @@ static void setup_free(void *data)
 		setup->id = 0;
 	}
 
-	if (setup->msg) {
-		reply = btd_error_failed(setup->msg, "Canceled");
-		g_dbus_send_message(btd_get_dbus_connection(), reply);
-		dbus_message_unref(setup->msg);
-		setup->msg = NULL;
-	}
+	future_clear(&setup->qos_done, ECANCELED, NULL);
 
 	if (setup->ep)
 		queue_remove(setup->ep->setups, setup);
@@ -1038,7 +1111,8 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 
 	switch (bt_bap_stream_get_type(setup->stream)) {
 	case BT_BAP_STREAM_TYPE_UCAST:
-		setup->msg = dbus_message_ref(msg);
+		future_init_dbus_reply(&setup->qos_done, "set_configuration",
+									msg);
 		break;
 	case BT_BAP_STREAM_TYPE_BCAST:
 		/* No message sent over the air for broadcast */
-- 
2.48.1

