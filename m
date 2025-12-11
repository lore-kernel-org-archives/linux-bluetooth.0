Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424F51F95C
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 20:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765484173; cv=pass; b=ahbYz7OQ9s8ZA5PDRDYGzYJYuhVTEk8qIfq4BWXM6V0ZxjEP6ZMYMv3KPrhgijJGOO/3Bhhfb+0I9t95fM9G+HXcUykIGpsY00NXLM8EzCC242W2uo36nVyHBBziuTFh/kJtp4Vf7+ntg9WH9bWPqBYe65mU1T0Q1FmZIHdcWVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765484173; c=relaxed/simple;
	bh=FL7otHMn421SELMgtds1RKjbVrT/lyl8FtfAcLDzZTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6J1EiWYPZUIUe03WECifGiCSCkPSsuCaVYK7z1nHAhWg3fvgHVdpj9gbxReLpZHAzQs7z9Q+673lu8qFlnyeIK5GjEBpevJIZZ+EcbFunf+8NmweaC/s15euyNpZ1dm8e4qQGbFlBFY7H03Rh5Tq1K7VoayEt1DS76xl9KJt24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=m/hiLNCM; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="m/hiLNCM"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dS3kc51m1zyZF;
	Thu, 11 Dec 2025 22:16:08 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765484169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZ3cxtwJI4+tRpLUpbjw3iyMKn6ktoixyocmksksUQk=;
	b=m/hiLNCMpHdtUmQ0zvTI/DFup8QKArlnL/CcW2IRrtZFZZ/4Vbzsf70n0TeEwoqeqoproP
	jQEFP9yNLa1ha3/b2TlURQ+I8X3besc5vOq32R8KhudfW1GVd4uuWnEpovcCet9VzPv0Zz
	u1aLwxUn89b4V62f7E31zCjFhEk8vkM=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765484169;
	b=hYePB2/7eHfmMgM10sIcojiV8uoOR6HsWZuIcVHNROWgbtnN2snSZXMTSC5yF8mLrlO9DH
	fpzlS/LvyPgJJ0rTY7Kg1rEliKFsbC3JIUbVpqLz6pJ+yO9f1vCN4qxz0B+jYl2hLfOy8g
	eHMUQv4MvvzlGcOgDlvG1xoqoP361MA=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765484169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZ3cxtwJI4+tRpLUpbjw3iyMKn6ktoixyocmksksUQk=;
	b=vEgo74Pi1xqxM96jlA5dVn/pPc2qXsl3nie5ec6fIHA4wDuB+zPdsTeQ4UA1gO8YXFE0qQ
	vjL1sQB7Y2whTNLxIhXfJMBxtTrwOv9U+bZ08YmEm3Va56jOIItuR/RS0UrifyGWEqAfzJ
	7uqMOBYOHDy8iRn+1AlU4B//XeUhJTA=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v5 5/7] avctp: use uinput utilities from src/shared
Date: Thu, 11 Dec 2025 22:15:57 +0200
Message-ID: <13c88bea80656abcb8319fffb30f4db5d61593e3.1765484150.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765484150.git.pav@iki.fi>
References: <cover.1765484150.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make use of the src/shared version of uinput_create() / send_key
---
 profiles/audio/avctp.c | 159 +++++++++--------------------------------
 1 file changed, 34 insertions(+), 125 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 65eec6f6c..89c14747b 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -41,6 +41,7 @@
 #include "src/error.h"
 #include "src/shared/timeout.h"
 #include "src/shared/util.h"
+#include "src/shared/uinput-util.h"
 
 #include "avctp.h"
 #include "avrcp.h"
@@ -191,7 +192,7 @@ struct avctp {
 
 	avctp_state_t state;
 
-	int uinput;
+	struct bt_uinput *uinput;
 
 	guint auth_id;
 	unsigned int passthrough_id;
@@ -228,11 +229,7 @@ struct avctp_browsing_pdu_handler {
 	GDestroyNotify destroy;
 };
 
-static const struct {
-	const char *name;
-	uint8_t avc;
-	uint16_t uinput;
-} key_map[] = {
+static const struct bt_uinput_key_map key_map[] = {
 	{ "SELECT",		AVC_SELECT,		KEY_SELECT },
 	{ "UP",			AVC_UP,			KEY_UP },
 	{ "DOWN",		AVC_DOWN,		KEY_DOWN },
@@ -301,27 +298,6 @@ static gboolean avctp_passthrough_rsp(struct avctp *session, uint8_t code,
 					uint8_t *operands, size_t operand_count,
 					void *user_data);
 
-static int send_event(int fd, uint16_t type, uint16_t code, int32_t value)
-{
-	struct input_event event;
-
-	memset(&event, 0, sizeof(event));
-	event.type	= type;
-	event.code	= code;
-	event.value	= value;
-
-	return write(fd, &event, sizeof(event));
-}
-
-static void send_key(int fd, uint16_t key, int pressed)
-{
-	if (fd < 0)
-		return;
-
-	send_event(fd, EV_KEY, key, pressed);
-	send_event(fd, EV_SYN, SYN_REPORT, 0);
-}
-
 static bool auto_release(gpointer user_data)
 {
 	struct avctp *session = user_data;
@@ -330,7 +306,7 @@ static bool auto_release(gpointer user_data)
 
 	DBG("AV/C: key press timeout");
 
-	send_key(session->uinput, session->key.op, 0);
+	bt_uinput_send_key(session->uinput, session->key.op, 0);
 
 	return FALSE;
 }
@@ -344,12 +320,12 @@ static void handle_press(struct avctp *session, uint16_t op)
 		if (session->key.op == op)
 			goto done;
 
-		send_key(session->uinput, session->key.op, 0);
+		bt_uinput_send_key(session->uinput, session->key.op, 0);
 	}
 
 	session->key.op = op;
 
-	send_key(session->uinput, op, 1);
+	bt_uinput_send_key(session->uinput, op, 1);
 
 done:
 	session->key.timer = timeout_add_seconds(AVC_PRESS_TIMEOUT,
@@ -364,7 +340,7 @@ static void handle_release(struct avctp *session, uint16_t op)
 		session->key.timer = 0;
 	}
 
-	send_key(session->uinput, op, 0);
+	bt_uinput_send_key(session->uinput, op, 0);
 }
 
 static size_t handle_panel_passthrough(struct avctp *session,
@@ -401,12 +377,12 @@ static size_t handle_panel_passthrough(struct avctp *session,
 	for (i = 0; key_map[i].name != NULL; i++) {
 		uint8_t key_quirks;
 
-		if ((operands[0] & 0x7F) != key_map[i].avc)
+		if ((operands[0] & 0x7F) != key_map[i].code)
 			continue;
 
 		DBG("AV/C: %s %s", key_map[i].name, status);
 
-		key_quirks = session->key_quirks[key_map[i].avc];
+		key_quirks = session->key_quirks[key_map[i].code];
 
 		if (key_quirks & QUIRK_NO_RELEASE) {
 			if (!pressed) {
@@ -415,8 +391,10 @@ static size_t handle_panel_passthrough(struct avctp *session,
 			}
 
 			DBG("AV/C: treating key press as press + release");
-			send_key(session->uinput, key_map[i].uinput, 1);
-			send_key(session->uinput, key_map[i].uinput, 0);
+			bt_uinput_send_key(session->uinput, key_map[i].uinput,
+									1);
+			bt_uinput_send_key(session->uinput, key_map[i].uinput,
+									0);
 			break;
 		}
 
@@ -570,15 +548,14 @@ static void avctp_disconnected(struct avctp *session)
 	if (session->key.timer > 0)
 		timeout_remove(session->key.timer);
 
-	if (session->uinput >= 0) {
+	if (session->uinput) {
 		char address[18];
 
 		ba2str(device_get_address(session->device), address);
 		DBG("AVCTP: closing uinput for %s", address);
 
-		ioctl(session->uinput, UI_DEV_DESTROY);
-		close(session->uinput);
-		session->uinput = -1;
+		bt_uinput_destroy(session->uinput);
+		session->uinput = NULL;
 	}
 
 	server = session->server;
@@ -1154,92 +1131,16 @@ failed:
 	return FALSE;
 }
 
-static int uinput_create(struct btd_device *device, const char *name,
-			 const char *suffix)
+static void uinput_debug(const char *str, void *data)
 {
-	struct uinput_user_dev dev;
-	int fd, err, i;
-	char src[18];
-
-	fd = open("/dev/uinput", O_RDWR);
-	if (fd < 0) {
-		fd = open("/dev/input/uinput", O_RDWR);
-		if (fd < 0) {
-			fd = open("/dev/misc/uinput", O_RDWR);
-			if (fd < 0) {
-				err = -errno;
-				error("Can't open input device: %s (%d)",
-							strerror(-err), -err);
-				return err;
-			}
-		}
-	}
-
-	memset(&dev, 0, sizeof(dev));
-
-	if (name) {
-		strncpy(dev.name, name, UINPUT_MAX_NAME_SIZE - 1);
-		dev.name[UINPUT_MAX_NAME_SIZE - 1] = '\0';
-	}
-
-	if (suffix) {
-		int len, slen;
-
-		len = strlen(dev.name);
-		slen = strlen(suffix);
-
-		/* If name + suffix don't fit, truncate the name, then add the
-		 * suffix.
-		 */
-		if (len + slen < UINPUT_MAX_NAME_SIZE - 1) {
-			strcpy(dev.name + len, suffix);
-		} else {
-			len = UINPUT_MAX_NAME_SIZE - slen - 1;
-			strncpy(dev.name + len, suffix, slen);
-			dev.name[UINPUT_MAX_NAME_SIZE - 1] = '\0';
-		}
-	}
-
-	dev.id.bustype = BUS_BLUETOOTH;
-	dev.id.vendor  = btd_device_get_vendor(device);
-	dev.id.product = btd_device_get_product(device);
-	dev.id.version = btd_device_get_version(device);
-
-	if (write(fd, &dev, sizeof(dev)) < 0) {
-		err = -errno;
-		error("Can't write device information: %s (%d)",
-						strerror(-err), -err);
-		close(fd);
-		return err;
-	}
-
-	ioctl(fd, UI_SET_EVBIT, EV_KEY);
-	ioctl(fd, UI_SET_EVBIT, EV_REL);
-	ioctl(fd, UI_SET_EVBIT, EV_REP);
-	ioctl(fd, UI_SET_EVBIT, EV_SYN);
-
-	ba2strlc(btd_adapter_get_address(device_get_adapter(device)), src);
-	ioctl(fd, UI_SET_PHYS, src);
-
-	for (i = 0; key_map[i].name != NULL; i++)
-		ioctl(fd, UI_SET_KEYBIT, key_map[i].uinput);
-
-	if (ioctl(fd, UI_DEV_CREATE, NULL) < 0) {
-		err = -errno;
-		error("Can't create uinput device: %s (%d)",
-						strerror(-err), -err);
-		close(fd);
-		return err;
-	}
-
-	send_event(fd, EV_REP, REP_DELAY, 300);
-
-	return fd;
+	DBG_IDX(0xffff, "%s", str);
 }
 
 static void init_uinput(struct avctp *session)
 {
+	struct btd_adapter *adapter = device_get_adapter(session->device);
 	char name[UINPUT_MAX_NAME_SIZE];
+	struct input_id id;
 
 	device_get_name(session->device, name, sizeof(name));
 	if (g_str_equal(name, "Nokia CK-20W")) {
@@ -1249,9 +1150,18 @@ static void init_uinput(struct avctp *session)
 		session->key_quirks[AVC_PAUSE] |= QUIRK_NO_RELEASE;
 	}
 
-	session->uinput = uinput_create(session->device, name, " (AVRCP)");
-	if (session->uinput < 0)
-		error("AVRCP: failed to init uinput for %s", name);
+	id.bustype = BUS_BLUETOOTH;
+	id.vendor  = btd_device_get_vendor(session->device);
+	id.product = btd_device_get_product(session->device);
+	id.version = btd_device_get_version(session->device);
+
+	session->uinput = bt_uinput_new(name, " (AVRCP)",
+				btd_adapter_get_address(adapter), &id, key_map,
+				uinput_debug, NULL);
+
+	if (!session->uinput)
+		error("AVRCP: failed to init uinput for %s: %s", name,
+							strerror(errno));
 	else
 		DBG("AVRCP: uinput initialized for %s", name);
 }
@@ -1492,7 +1402,6 @@ static struct avctp *avctp_get_internal(struct btd_device *device)
 	session->server = server;
 	session->device = btd_device_ref(device);
 	session->state = AVCTP_STATE_DISCONNECTED;
-	session->uinput = -1;
 	session->key.op = AVC_INVALID;
 
 	server->sessions = g_slist_append(server->sessions, session);
@@ -1793,7 +1702,7 @@ static const char *op2str(uint8_t op)
 	int i;
 
 	for (i = 0; key_map[i].name != NULL; i++) {
-		if ((op & 0x7F) == key_map[i].avc)
+		if ((op & 0x7F) == key_map[i].code)
 			return key_map[i].name;
 	}
 
@@ -2232,7 +2141,7 @@ bool avctp_supports_avc(uint8_t avc)
 	int i;
 
 	for (i = 0; key_map[i].name != NULL; i++) {
-		if (key_map[i].avc == avc)
+		if (key_map[i].code == avc)
 			return true;
 	}
 	return false;
-- 
2.51.1

