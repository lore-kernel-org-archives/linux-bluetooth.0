Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F3C30DEB5
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 20:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765570375; cv=pass; b=QwELZI93MOe926jpUnVdA/QhSxXJtJ986vFLgYpsIGwGO+aUhnV6OLL6NLOakYzUYTJsX+VVgjyNNhrjIrDXxhkDY9/bwJqw2C1qrXBlxSEQ6WQHn6onl4euEC+tREnPeU1rzYhzKA0DJojSO20hMmfH50in1LjK7bdZ9/qrxU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765570375; c=relaxed/simple;
	bh=wHIZL2wNjvbc9km5Oemtwxj6LgHJfGW4VkzKYpUnkeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=liPq42En/gP17fctCxVLLcLhRyzGtRgxieO/6/c6rMaB9ivzSAV8DAjXwN4qTUklNIiW4L0BRMctuyRdhuYYpM8ENzmhvZOoBLfA08ICAXYaaZnr/Fn7Iqtnwotyjzuq2Hd6CDvxXQV9Zq3UI12YP97A4nC7cFKYhE4+UNLmsvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=aLvSzVrm; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="aLvSzVrm"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dSgcB3HcLzyff;
	Fri, 12 Dec 2025 22:12:42 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765570362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OgfkexMOTUXElleHTjT+yhxiJD/xfueelvB/J7HE3TM=;
	b=aLvSzVrmopM3UzTCZMTpyVWuoyBXBcNpwo83q2ibqt8Aj5RbrCG7TFsSdEueVK+aGjQ3om
	qAhQl5Ir26ZtSK5gk4mKtHCMM/I3ZWnK+9w8IcpVW+cx5BPvSYmGLuDEnLXXxBlieewd3s
	86VDg48NL98WYZxnaGXH6YYc9seoAQw=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765570362;
	b=j7sxMsjcLiEJ1WUeNGLdNr7401HDkBHrEkIBqI0G4TckHkne+RFlBvWnqW+gAfqPQAqjOV
	yHxSJN4oInxNFg5p0QY2eks+DH2sLor+78QZLSGOYfsePrEiWAxv7cuwX+jI3yTTdBfKc+
	v311ZXnkYy+37ck4mmkFO++GdpEG8wk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765570362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OgfkexMOTUXElleHTjT+yhxiJD/xfueelvB/J7HE3TM=;
	b=Rph5ID0ILNE7dgvwzRzYPHXIzrqD4Ww8gK96hCm92JeZDfc4l0mttpIriMGxBfmbvyu2AT
	mAxKLsEj2Ga5Oon1B38S0PxHRBYriHcMdwpA9VtI4GYQAQQRGPgD2k2CcpuAxNWZygletD
	0e3VCVy6AW2db3PPPA9jt/t23sJo2uE=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v6 5/9] avctp: use uinput utilities from src/shared
Date: Fri, 12 Dec 2025 22:12:27 +0200
Message-ID: <3587b1923a280c64b0bba360475a78bca87fe4a6.1765570334.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765570334.git.pav@iki.fi>
References: <cover.1765570334.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make use of the src/shared version of uinput_create() / send_key
---
 profiles/audio/avctp.c | 166 ++++++++++-------------------------------
 1 file changed, 40 insertions(+), 126 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 65eec6f6c..f20e08c00 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -41,6 +41,7 @@
 #include "src/error.h"
 #include "src/shared/timeout.h"
 #include "src/shared/util.h"
+#include "src/shared/uinput.h"
 
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
@@ -1154,92 +1131,17 @@ failed:
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
+	int err;
 
 	device_get_name(session->device, name, sizeof(name));
 	if (g_str_equal(name, "Nokia CK-20W")) {
@@ -1249,11 +1151,24 @@ static void init_uinput(struct avctp *session)
 		session->key_quirks[AVC_PAUSE] |= QUIRK_NO_RELEASE;
 	}
 
-	session->uinput = uinput_create(session->device, name, " (AVRCP)");
-	if (session->uinput < 0)
-		error("AVRCP: failed to init uinput for %s", name);
-	else
+	id.bustype = BUS_BLUETOOTH;
+	id.vendor  = btd_device_get_vendor(session->device);
+	id.product = btd_device_get_product(session->device);
+	id.version = btd_device_get_version(session->device);
+
+	session->uinput = bt_uinput_new(name, " (AVRCP)",
+				btd_adapter_get_address(adapter), &id);
+	bt_uinput_set_debug(session->uinput, uinput_debug, NULL);
+
+	err = bt_uinput_create(session->uinput, key_map);
+	if (err < 0) {
+		error("AVRCP: failed to create uinput for %s: %s", name,
+								strerror(-err));
+		bt_uinput_destroy(session->uinput);
+		session->uinput = NULL;
+	} else {
 		DBG("AVRCP: uinput initialized for %s", name);
+	}
 }
 
 static struct avctp_queue *avctp_queue_create(struct avctp_channel *chan)
@@ -1492,7 +1407,6 @@ static struct avctp *avctp_get_internal(struct btd_device *device)
 	session->server = server;
 	session->device = btd_device_ref(device);
 	session->state = AVCTP_STATE_DISCONNECTED;
-	session->uinput = -1;
 	session->key.op = AVC_INVALID;
 
 	server->sessions = g_slist_append(server->sessions, session);
@@ -1793,7 +1707,7 @@ static const char *op2str(uint8_t op)
 	int i;
 
 	for (i = 0; key_map[i].name != NULL; i++) {
-		if ((op & 0x7F) == key_map[i].avc)
+		if ((op & 0x7F) == key_map[i].code)
 			return key_map[i].name;
 	}
 
@@ -2232,7 +2146,7 @@ bool avctp_supports_avc(uint8_t avc)
 	int i;
 
 	for (i = 0; key_map[i].name != NULL; i++) {
-		if (key_map[i].avc == avc)
+		if (key_map[i].code == avc)
 			return true;
 	}
 	return false;
-- 
2.51.1

