Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A703274666
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 08:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748422790; cv=none; b=R4bVY1yfdaZKhXgwYSsLfVndGCC9AxujjfTiljkCbWFNCaRqDEpgHtILN9fBtrbqevBFCHYwYJaV3yeQWebe4ptLkVwpEpZgjN18twZsFrtg/IRjXC6j+JJQ+EPr1MNNpKRsrhG+g2dGBGvUPxGsv3AHN5RmblmlUYOyaQxDvx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748422790; c=relaxed/simple;
	bh=e2XMZcTc2dhlYQgoMisyyayF92SvFeBPSOq3LTYjQGQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GUSKUQnLUpf30B/gTswAvBq0A73MppwLArSPHkhNXmkb4WBcnQAReLLhQp23sxU31SEyG34pdMMVjFRQA18UcDmVT+X2qxWWsAg9fI6PxHKydwAOaCmEUud3W9rpEsketgFMrytHQ3vMtffEicBYxU59iOILP8Ecx79uYPkmDgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pHYpo0nd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pHYpo0nd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1748422778;
	bh=e2XMZcTc2dhlYQgoMisyyayF92SvFeBPSOq3LTYjQGQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pHYpo0nd2ZHElWhw4VIJWA4pucHc2c6WncmEU0H6L+mXiWgF06tJh7hfLaUB8Sp+7
	 T9aRwcT7VWGbzno+D3kZAW5sNjb58/iMTLtGCM8qG0aRGGpUkzWdMmttTLjDszniDP
	 MxIjdNUi2/hLxO+U0pKc1Jnq32KS9ZpSx5GRs+nX42OfV+3sNLoo45CAnYtL33rryK
	 Pv6VOR9j0wFDtQjo6p5hI954r9Sv16GO9CkLQ3x0N8iUn+x1Jp9GjVWRF4128X3JCa
	 MyXShorXM1ZaDpbX+4mb/Lx4aJL+dFOhMF+64D2kDz5jOR8R8sv/AhnxJqvX3/E/ep
	 bqulnniMgbYTw==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-AF44-1001-C79a-7427-1C18-f6a9.rev.sfr.net [IPv6:2a02:8428:af44:1001:c79a:7427:1c18:f6a9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2357717E3791
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 10:59:38 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 05/10] audio/hfp-hf: Add dial support
Date: Wed, 28 May 2025 10:59:25 +0200
Message-ID: <20250528085930.227816-6-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528085930.227816-1-frederic.danis@collabora.com>
References: <20250528085930.227816-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 profiles/audio/hfp-hf.c | 72 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index 5068fff01..395f7ba61 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -36,6 +36,7 @@
 #include "src/btd.h"
 #include "src/dbus-common.h"
 #include "src/device.h"
+#include "src/error.h"
 #include "src/log.h"
 #include "src/plugin.h"
 #include "src/profile.h"
@@ -980,7 +981,78 @@ failed:
 	device_destroy(dev);
 }
 
+static void hfp_dial_cb(enum hfp_result result, enum hfp_error cme_err,
+							void *user_data)
+{
+	struct call *call = user_data;
+	DBusMessage *msg = call->pending_msg;
+	DBusMessage *reply;
+	struct hfp_device *dev = telephony_get_profile_data(call->device);
+
+	DBG("");
+
+	call->pending_msg = NULL;
+
+	if (result != HFP_RESULT_OK) {
+		error("Dialing error: %d", result);
+		reply = g_dbus_create_error(msg, ERROR_INTERFACE
+					".Failed",
+					"Dial command failed: %d", result);
+		g_dbus_send_message(btd_get_dbus_connection(), reply);
+		telephony_free_call(call);
+		return;
+	}
+
+	if (telephony_call_register_interface(call)) {
+		telephony_free_call(call);
+		return;
+	}
+
+	dev->calls = g_slist_append(dev->calls, call);
+
+	g_dbus_send_reply(btd_get_dbus_connection(), msg, DBUS_TYPE_INVALID);
+}
+
+static DBusMessage *hfp_dial(DBusConnection *conn, DBusMessage *msg,
+				void *profile_data)
+{
+	struct hfp_device *dev = profile_data;
+	const char *number;
+	struct call *call;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &number,
+					DBUS_TYPE_INVALID)) {
+		return btd_error_invalid_args(msg);
+	}
+
+	call = telephony_new_call(dev->telephony, CALL_STATE_DIALING, NULL);
+	call->pending_msg = dbus_message_ref(msg);
+
+	if (number != NULL && number[0] != '\0') {
+		DBG("Dialing %s", number);
+
+		call->line_id = g_strdup(number);
+
+		if (!hfp_hf_send_command(dev->hf, hfp_dial_cb, call,
+							"ATD%s;", number))
+			goto failed;
+	} else {
+		DBG("Redialing");
+
+		if (!hfp_hf_send_command(dev->hf, hfp_dial_cb, call,
+							"AT+BLDN"))
+			goto failed;
+	}
+
+	return NULL;
+
+failed:
+	telephony_free_call(call);
+	return btd_error_failed(msg, "Dial command failed");
+}
+
 struct telephony_callbacks hfp_callbacks = {
+	.dial = hfp_dial,
 };
 
 static int hfp_connect(struct btd_service *service)
-- 
2.43.0

