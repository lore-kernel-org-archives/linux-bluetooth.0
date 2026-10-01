Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5232C5383C6
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 21:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790889055; cv=none; b=A6V7wmUzgTK1QXy6SvE/g2UWVpbQo+J/c+7ZjyfBWIiCvK+lhrO0z7FyPu4ims2Nmfw9GnVhvt+vXErMqc9XpMSqQb1u968+71jfWByM295OxSB0RPl4NlFoa5hqBeg/ZY6J/2P+nlawn495gploZ1JeOQKNQxFGXnYeEJqqzuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790889055; c=relaxed/simple;
	bh=m2brSgysUCkW+IVe0iXrR2XPybpfQ+o0rGk4AmUYcJo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TwRMR9FC8Wack+NF2iBXwh7Rwy2y2NV4R1vPQbVvpT4h0jWZ50x798b8pxPQcMgK7ISrqmPpO0q68cdolSJEpkZLoPZrSnyMFUJteOzk0BGsCVdI2Z3C4p6iNg/VqqyJIgP1kkGJ02xQyDDhWjAl2bpZUg+ewMT5jvasSlBr5LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nim88mGa; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nim88mGa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790889043;
	bh=m2brSgysUCkW+IVe0iXrR2XPybpfQ+o0rGk4AmUYcJo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nim88mGazX90ZnI1r0ulvSdHEpP2xv2UznI62+otmbcOZddrSyvf75p7MKoHwpbzJ
	 uoG883SAg91MXUCEsWbqwVaRm//500LsuKkF1Z8lE3TpMr867zHEYLW1psS5DXbDGV
	 PFqYOkQ9ANce5eXeRvb7hMjjVZ682FLIeyqmNP67wy22is5PrlRg3laWxQfsBWSx3R
	 vuU/aZ+roc3Kg+B5za0d6SJk21mble/n5BpDkC0BJ1MbuCLMsWYOdtaU0hFMVyo+Eo
	 nW04oQvesJWRK/sLVEaIEBW6cm9ChG6YZC0xtMSfVHE5WuOmwzt/tIj1/xOGnRkh9J
	 hLKDYESutDcrQ==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6561817E092C
	for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 23:10:43 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 09/12] audio/hfp-hf: Add multi calls support
Date: Thu,  1 Oct 2026 23:10:33 +0200
Message-ID: <20261001211036.1760396-10-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001211036.1760396-1-frederic.danis@collabora.com>
References: <20261001211036.1760396-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Frédéric Danis <frederic.danis.oss@gmail.com>

This implements the SwapCalls, ReleaseAndAnswer, ReleaseAndSwap and
HoldAndAnswer methods from org.bluez.Telephony1.
---
 profiles/audio/hfp-hf.c | 142 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index 1843b6758..25dce517f 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -503,6 +503,144 @@ static DBusMessage *dial(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
+static DBusMessage *swap_calls(DBusConnection *conn, DBusMessage *msg,
+				void *profile_data)
+{
+	struct hfp_device *dev = profile_data;
+	const struct queue_entry *entry;
+	bool found_held = false;
+	bool ret;
+
+	for (entry = queue_get_entries(dev->calls); entry;
+					entry = entry->next) {
+		struct call *call = entry->data;
+
+		if (call->state == CALL_STATE_HELD) {
+			found_held = true;
+			break;
+		}
+	}
+
+	if (!found_held) {
+		return btd_error_failed(msg,
+					"Swap calls command failed: "
+					"no held calls");
+	}
+
+	ret = hfp_hf_swap_calls(dev->hf, cmd_complete,
+					dbus_message_ref(msg));
+	if (!ret)
+		return btd_error_failed(msg, "Swap calls command failed");
+
+	return NULL;
+}
+
+static DBusMessage *release_and_answer(DBusConnection *conn, DBusMessage *msg,
+					void *profile_data)
+{
+	struct hfp_device *dev = profile_data;
+	const struct queue_entry *entry;
+	bool found_active = false;
+	bool found_waiting = false;
+	bool ret;
+
+	for (entry = queue_get_entries(dev->calls); entry;
+					entry = entry->next) {
+		struct call *call = entry->data;
+
+		if (call->state == CALL_STATE_ACTIVE)
+			found_active = true;
+		else if (call->state == CALL_STATE_WAITING)
+			found_waiting = true;
+	}
+
+	if (!found_active || !found_waiting) {
+		return btd_error_failed(msg,
+					"Release and answer command failed: "
+					"no active and waiting calls");
+	}
+
+	ret = hfp_hf_release_and_accept(dev->hf, cmd_complete,
+					dbus_message_ref(msg));
+	if (!ret)
+		return btd_error_failed(msg,
+					"Release and answer command failed");
+
+	return NULL;
+}
+
+static DBusMessage *release_and_swap(DBusConnection *conn, DBusMessage *msg,
+					void *profile_data)
+{
+	struct hfp_device *dev = profile_data;
+	const struct queue_entry *entry;
+	bool found_active = false;
+	bool found_held = false;
+	bool ret;
+
+	for (entry = queue_get_entries(dev->calls); entry;
+					entry = entry->next) {
+		struct call *call = entry->data;
+
+		if (call->state == CALL_STATE_WAITING) {
+			return btd_error_failed(msg,
+					"Release and swap command failed: "
+					"waiting call exists");
+		} else if (call->state == CALL_STATE_ACTIVE)
+			found_active = true;
+		else if (call->state == CALL_STATE_HELD)
+			found_held = true;
+	}
+
+	if (!found_active || !found_held) {
+		return btd_error_failed(msg,
+					"Release and swap command failed: "
+					"no active and held calls");
+	}
+
+	ret = hfp_hf_release_and_accept(dev->hf, cmd_complete,
+					dbus_message_ref(msg));
+	if (!ret)
+		return btd_error_failed(msg,
+					"Release and swap command failed");
+
+	return NULL;
+}
+
+static DBusMessage *hold_and_answer(DBusConnection *conn, DBusMessage *msg,
+					void *profile_data)
+{
+	struct hfp_device *dev = profile_data;
+	const struct queue_entry *entry;
+	bool found_active = false;
+	bool found_waiting = false;
+	bool ret;
+
+	for (entry = queue_get_entries(dev->calls); entry;
+					entry = entry->next) {
+		struct call *call = entry->data;
+
+		if (call->state == CALL_STATE_ACTIVE)
+			found_active = true;
+		else if (call->state == CALL_STATE_WAITING)
+			found_waiting = true;
+	}
+
+	if (!found_active || !found_waiting) {
+		return btd_error_failed(msg,
+					"Hold and answer command failed: "
+					"no active and waiting calls");
+	}
+
+	ret = hfp_hf_swap_calls(dev->hf, cmd_complete,
+					dbus_message_ref(msg));
+	if (!ret)
+		return btd_error_failed(msg,
+					"Hold and answer command failed");
+
+	return NULL;
+}
+
 static DBusMessage *hangup_all(DBusConnection *conn, DBusMessage *msg,
 				void *profile_data)
 {
@@ -569,6 +707,10 @@ static DBusMessage *call_hangup(DBusConnection *conn, DBusMessage *msg,
 
 struct telephony_callbacks hfp_callbacks = {
 	.dial = dial,
+	.swap_calls = swap_calls,
+	.release_and_answer = release_and_answer,
+	.release_and_swap = release_and_swap,
+	.hold_and_answer = hold_and_answer,
 	.hangup_all = hangup_all,
 	.send_tones = send_tones,
 	.call_answer = call_answer,
-- 
2.43.0

