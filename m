Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4F52E8DEE
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035916; cv=none; b=d4+THHqv30xn9R2M8cfIEeaKVHgRgP8XdbCwfNekNEPn4TxPTvl5Ihq/bNvLXdW5PP/CP3ley6wRiAqMrb9QhvHY1npoN94UxCBhVsNXDsIPnzRuMPgUX+OFN9HSKUEHC+Dj8S7A7NoPsZHf6WBKPFQHQ4ABSHmWyWGaGV+FUig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035916; c=relaxed/simple;
	bh=bmtkAvxKHvbgVs1GN6Eg6C4+EjoXVeXamGjgPFPJUGc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nYegZ4uTxabFtwcvs/2AMAQFeTk3sYYVp+Lbm5uv/TpTkqWkH03C1AE5SCFjRIettShVeDULIzyRNQw1uG2Ylz5/zSE+WGsuqdqwPpXKsYa4/exWRY7sA60vlF8Ru2cJaBc98fzKhKV9jmWDZys08MVLsCSoCor9rghzvexzc24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hBTXGbQH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hBTXGbQH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751035903;
	bh=bmtkAvxKHvbgVs1GN6Eg6C4+EjoXVeXamGjgPFPJUGc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hBTXGbQHNCXDCud0ojJPBJHFF+ijGMJfIxNdOjuIQqY80s8ZosPkUP4v5Qr8Ts4FF
	 grCPAkr+MKCEBe0+LKF/IY7lHgaRbcfGNsjyyityZ2OMQ851WGQ3Wgj92P45f0GYJ+
	 gWbw2V/78+plX27cpemI92OCPIPZ7QT0gDUCuCWjwkfQJyUO5KyYJVNoa1cnzDHSZC
	 Mv0KBzeEmrlUFDojAXyeUrp9mWOuTcK2dyQABihku7DEX/DHaW/W29ILrbOAzEgCzH
	 IwcgtsIeFoLS2YFLluJSAOw9eYoQ1BYpz2XzqTmOtrQ2tGe4zRiQPgV2V/+/mZi3n1
	 0O/x/Aw6tlHXQ==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-81C9-67b7-a328-2001.rev.sfr.net [IPv6:2a02:8428:af44:1001:81c9:67b7:a328:2001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5E7A417E088B
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:51:43 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v2 05/27] audio/hfp-hf: Add dial support
Date: Fri, 27 Jun 2025 16:51:14 +0200
Message-ID: <20250627145136.421853-6-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250627145136.421853-1-frederic.danis@collabora.com>
References: <20250627145136.421853-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 v1->v2:
  - Use first available index of call for new call
  - Fix DBus message memory leak

profiles/audio/hfp-hf.c | 75 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index a993229b9..ffe4ab708 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -1010,7 +1010,82 @@ failed:
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
+		dbus_message_unref(msg);
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
+	dbus_message_unref(msg);
+}
+
+static DBusMessage *hfp_dial(DBusConnection *conn, DBusMessage *msg,
+				void *profile_data)
+{
+	struct hfp_device *dev = profile_data;
+	const char *number;
+	struct call *call;
+	uint8_t idx = next_index(dev);
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &number,
+					DBUS_TYPE_INVALID)) {
+		return btd_error_invalid_args(msg);
+	}
+
+	call = telephony_new_call(dev->telephony, idx, CALL_STATE_DIALING,
+					NULL);
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

