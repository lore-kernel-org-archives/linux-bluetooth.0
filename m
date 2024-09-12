Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97313195962
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726163371; cv=none; b=qNHLIAAJZKIOQCW9PoWYbvS3JHHKijQXB0ZpLsYgkjU1NPGfKa1Wavq+8CHETMCCf3HVkSL1uIKwY/mqH3hhtLmwXY0gL+wghljKXGl1FAlR/OYmo/UjWrP9qYA0wvwJAk6KGoOh7D8VSiIqM5LIj1KvAonYRbQJ0sd4YRUqlME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726163371; c=relaxed/simple;
	bh=ejLoo7BpIgGAYbN9riNyze+0HpZaPohmi7GzRLD0QCQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcvEJYnIiKLgfnoAsWd635Uk1k+XGN5svAJsZZRrng/YpicMMEcx/pK3qsLA8yEm2VDO8ty7pzgDX/dtS5GPXXncnVzbV4jsk9s/e+PT4jDksCxyqJyUGiOhZ7C+hUrUrQYtnWT9UEtt0HEIeHLjElCBHuzab6HXzxOL0OU9S7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kg4Ev2mp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kg4Ev2mp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726163367;
	bh=ejLoo7BpIgGAYbN9riNyze+0HpZaPohmi7GzRLD0QCQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kg4Ev2mpq89GvvTFSGv5DK0X1czT8IA7xnNEjVK70pOGXAXi364txrtqPqd+oV2Fc
	 bQOt7YuX2trQzECl+6F/kuijje6jNXgmBlsS/ZZPY7P19gKWEVVIPMQIq9moB5pGCf
	 ZsKgmzmM3vs75fEdOFcD5ovdCWonaHelS35+L/cE/jOUS1s8BT9MOtN4a5ZmswUKZH
	 jGeBmksifbsujcavJEoMJhZA42ojQ8xV4GD+wdH1GSVU/edjG4cgB2Y56SFCgLy23C
	 jlJd6khHM55QKxRC0cPXJ4Xkdo0kRRpyelVk1RMfhBltX1kHwBSglvBnv3pF4ONHZH
	 2vRwDcEbRbC6A==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BD5EA17E35FF
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 19:49:27 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/7] obexd: Add PSM support to session create
Date: Thu, 12 Sep 2024 19:49:15 +0200
Message-Id: <20240912174921.386856-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912174921.386856-1-frederic.danis@collabora.com>
References: <20240912174921.386856-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

An OBEX session can be connected to a RFCOMM channel or a L2CAP PSM.
---
 doc/org.bluez.obex.Client.rst  |  4 ++++
 doc/org.bluez.obex.Session.rst |  5 +++++
 obexd/client/manager.c         | 14 ++++++++++----
 obexd/client/session.c         | 27 ++++++++++++++++++++++++---
 obexd/client/session.h         |  1 +
 5 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/doc/org.bluez.obex.Client.rst b/doc/org.bluez.obex.Client.rst
index 9f77a9abc..5ae7cc5e8 100644
--- a/doc/org.bluez.obex.Client.rst
+++ b/doc/org.bluez.obex.Client.rst
@@ -52,6 +52,10 @@ object CreateSession(string destination, dict args)
 
 		Channel to be used.
 
+	:uint16 PSM:
+
+		L2CAP PSM to be used.
+
 	Possible errors:
 
 	:org.bluez.obex.Error.InvalidArguments:
diff --git a/doc/org.bluez.obex.Session.rst b/doc/org.bluez.obex.Session.rst
index 1cef9a53d..fc5f14e5d 100644
--- a/doc/org.bluez.obex.Session.rst
+++ b/doc/org.bluez.obex.Session.rst
@@ -50,6 +50,11 @@ byte Channel [readonly]
 
 	Bluetooth channel
 
+uint16 PSM [readonly]
+```````````````````````
+
+	Bluetooth L2CAP PSM
+
 string Target [readonly]
 ````````````````````````
 
diff --git a/obexd/client/manager.c b/obexd/client/manager.c
index ad1fbb04a..52c00fb0c 100644
--- a/obexd/client/manager.c
+++ b/obexd/client/manager.c
@@ -107,7 +107,8 @@ done:
 }
 
 static int parse_device_dict(DBusMessageIter *iter,
-		const char **source, const char **target, uint8_t *channel)
+		const char **source, const char **target, uint8_t *channel,
+		uint16_t *psm)
 {
 	while (dbus_message_iter_get_arg_type(iter) == DBUS_TYPE_DICT_ENTRY) {
 		DBusMessageIter entry, value;
@@ -130,6 +131,10 @@ static int parse_device_dict(DBusMessageIter *iter,
 			if (g_str_equal(key, "Channel") == TRUE)
 				dbus_message_iter_get_basic(&value, channel);
 			break;
+		case DBUS_TYPE_UINT16:
+			if (g_str_equal(key, "PSM") == TRUE)
+				dbus_message_iter_get_basic(&value, psm);
+			break;
 		}
 
 		dbus_message_iter_next(iter);
@@ -160,6 +165,7 @@ static DBusMessage *create_session(DBusConnection *connection,
 	struct send_data *data;
 	const char *source = NULL, *dest = NULL, *target = NULL;
 	uint8_t channel = 0;
+	uint16_t psm = 0;
 
 	dbus_message_iter_init(message, &iter);
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
@@ -175,8 +181,8 @@ static DBusMessage *create_session(DBusConnection *connection,
 
 	dbus_message_iter_recurse(&iter, &dict);
 
-	parse_device_dict(&dict, &source, &target, &channel);
-	if (dest == NULL || target == NULL)
+	parse_device_dict(&dict, &source, &target, &channel, &psm);
+	if (dest == NULL || target == NULL || (channel && psm))
 		return g_dbus_create_error(message,
 				ERROR_INTERFACE ".InvalidArguments", NULL);
 
@@ -188,7 +194,7 @@ static DBusMessage *create_session(DBusConnection *connection,
 	data->connection = dbus_connection_ref(connection);
 	data->message = dbus_message_ref(message);
 
-	session = obc_session_create(source, dest, target, channel,
+	session = obc_session_create(source, dest, target, channel, psm,
 					dbus_message_get_sender(message),
 					create_callback, data);
 	if (session != NULL) {
diff --git a/obexd/client/session.c b/obexd/client/session.c
index 7d8ebb04e..13a834e14 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -88,6 +88,7 @@ struct obc_session {
 	char *source;
 	char *destination;
 	uint8_t channel;
+	uint16_t psm;
 	struct obc_transport *transport;
 	struct obc_driver *driver;
 	char *path;		/* Session path */
@@ -471,6 +472,7 @@ static struct obc_session *session_find(const char *source,
 						const char *destination,
 						const char *service,
 						uint8_t channel,
+						uint16_t psm,
 						const char *owner)
 {
 	GSList *l;
@@ -490,6 +492,9 @@ static struct obc_session *session_find(const char *source,
 		if (channel && session->channel != channel)
 			continue;
 
+		if (psm && session->psm != psm)
+			continue;
+
 		if (g_strcmp0(owner, session->owner))
 			continue;
 
@@ -541,8 +546,9 @@ static int session_connect(struct obc_session *session,
 	}
 
 	session->id = transport->connect(session->source, session->destination,
-					driver->uuid, session->channel,
-					transport_func, callback);
+			driver->uuid,
+			session->channel ? session->channel : session->psm,
+			transport_func, callback);
 	if (session->id == 0) {
 		obc_session_unref(callback->session);
 		g_free(callback);
@@ -558,6 +564,7 @@ struct obc_session *obc_session_create(const char *source,
 						const char *destination,
 						const char *service,
 						uint8_t channel,
+						uint16_t psm,
 						const char *owner,
 						session_callback_t function,
 						void *user_data)
@@ -570,7 +577,8 @@ struct obc_session *obc_session_create(const char *source,
 	if (destination == NULL)
 		return NULL;
 
-	session = session_find(source, destination, service, channel, owner);
+	session = session_find(source, destination, service, channel, psm,
+				owner);
 	if (session != NULL)
 		goto proceed;
 
@@ -598,6 +606,7 @@ struct obc_session *obc_session_create(const char *source,
 	session->source = g_strdup(source);
 	session->destination = g_strdup(destination);
 	session->channel = channel;
+	session->psm = psm;
 	session->queue = g_queue_new();
 	session->folder = g_strdup("/");
 
@@ -762,6 +771,17 @@ static gboolean get_channel(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean get_psm(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct obc_session *session = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+							&session->psm);
+
+	return TRUE;
+}
+
 static const GDBusMethodTable session_methods[] = {
 	{ GDBUS_ASYNC_METHOD("GetCapabilities",
 				NULL, GDBUS_ARGS({ "capabilities", "s" }),
@@ -794,6 +814,7 @@ static const GDBusPropertyTable session_properties[] = {
 	{ "Source", "s", get_source, NULL, source_exists },
 	{ "Destination", "s", get_destination },
 	{ "Channel", "y", get_channel },
+	{ "PSM", "q", get_psm },
 	{ "Target", "s", get_target, NULL, target_exists },
 	{ }
 };
diff --git a/obexd/client/session.h b/obexd/client/session.h
index 2c646df1a..19c3f3687 100644
--- a/obexd/client/session.h
+++ b/obexd/client/session.h
@@ -22,6 +22,7 @@ struct obc_session *obc_session_create(const char *source,
 						const char *destination,
 						const char *service,
 						uint8_t channel,
+						uint16_t psm,
 						const char *owner,
 						session_callback_t function,
 						void *user_data);
-- 
2.34.1

