Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AC02E7F22
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035918; cv=none; b=P+dlgssQaDhYGyaL0slbp6E5P4Kx0wuWbd8o5MO6tg2KKZJU8j3n5pkpzS1W4AoXusIQCRYqqz75U9D0NFqNo56joMDsQ7TcZu4HwPv6drCbSNYzJPPuq1PpiVWy+sbF+pyKQH7x2Jztb7glpqrVt8v1yKHFqenH4OaL24C2ruA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035918; c=relaxed/simple;
	bh=O2jEAB5+TJHareXKqGdQxY7FFwfBvMMqdrY92iDnirg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uqS5smDLlSf5Y7YPdjHbF8SwJmZJkKK16lK2G15iyc7VkNY7V9TOmP6Y+NUAMsFOzgGD51XEvnpR3usgbrqOxR20jcHpMutdJh6noRWftGyXaaveUM9bC6p4/z+RJL2T6zSWcOAnespaJM688wgR9rIy3zka/qSXml7j1wJGMOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NcIj9s/b; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NcIj9s/b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751035905;
	bh=O2jEAB5+TJHareXKqGdQxY7FFwfBvMMqdrY92iDnirg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NcIj9s/bYFKD/q8soBTHxhHDM4MtdmPcxIikrHECF0ZKSdKiHTX5ucHauyyePwVrE
	 3ZW/UYNALbaZ7Ti4miQIpGwbGSFT4eY8QmC+TqQS2eGvoGR6xa3P8c5cOjBTAUxHLZ
	 KDE5+XtKsM+1aN9FgPccKyNOL28l5t4KlmaLR/iJMPns7VQjeeYXbYjkIH3pcfOlo8
	 x/fajm2NF3F3DX/mCBLQLVEgxR3ap44mKHo8syn2nlQufy4OjcftLyp6YkXKsAUb7J
	 0Mi8Q0ETylVZyjejGSa6xMRMuVKu7czm4cj8nSNXMhwEr0GgrXtNZjTLPAKA5bP05n
	 cB/HfesKNIf+A==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-81C9-67b7-a328-2001.rev.sfr.net [IPv6:2a02:8428:af44:1001:81c9:67b7:a328:2001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7BA2717E099B
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:51:45 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v2 12/27] audio/hfp-hf: Add hangup_active and hangup_held support
Date: Fri, 27 Jun 2025 16:51:21 +0200
Message-ID: <20250627145136.421853-13-frederic.danis@collabora.com>
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

From: Frédéric Danis <frederic.danis.oss@gmail.com>

---
 profiles/audio/hfp-hf.c | 87 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index ad759b8c3..a2a1ae39f 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -1156,6 +1156,91 @@ failed:
 	return btd_error_failed(msg, "Hang up all command failed");
 }
 
+static DBusMessage *hfp_hangup_active(DBusConnection *conn, DBusMessage *msg,
+				void *profile_data)
+{
+	struct hfp_device *dev = profile_data;
+	bool found_active = FALSE;
+	GSList *l;
+
+	DBG("");
+
+	for (l = dev->calls; l; l = l->next) {
+		struct call *call = l->data;
+
+		switch (call->state) {
+		case CALL_STATE_ACTIVE:
+		case CALL_STATE_DIALING:
+		case CALL_STATE_ALERTING:
+		case CALL_STATE_INCOMING:
+			found_active = TRUE;
+			break;
+		case CALL_STATE_HELD:
+		case CALL_STATE_WAITING:
+		case CALL_STATE_DISCONNECTED:
+			break;
+		}
+	}
+
+	if (!found_active)
+		return g_dbus_create_error(msg, ERROR_INTERFACE
+					".InvalidState",
+					"No active call to hang up");
+
+	if (!hfp_hf_send_command(dev->hf, cmd_complete_cb,
+			dbus_message_ref(msg),
+			"AT+CHUP")) {
+		warn("Failed to hangup active calls");
+		return btd_error_failed(msg, "Hang up active command failed");
+	}
+
+	return NULL;
+}
+
+static DBusMessage *hfp_hangup_held(DBusConnection *conn, DBusMessage *msg,
+				void *profile_data)
+{
+	struct hfp_device *dev = profile_data;
+	bool found_held = FALSE;
+	GSList *l;
+
+	DBG("");
+
+	if (!(dev->chld_features & CHLD_FEAT_REL))
+		return btd_error_not_supported(msg);
+
+	for (l = dev->calls; l; l = l->next) {
+		struct call *call = l->data;
+
+		switch (call->state) {
+		case CALL_STATE_HELD:
+		case CALL_STATE_WAITING:
+			found_held = TRUE;
+			break;
+		case CALL_STATE_ACTIVE:
+		case CALL_STATE_DIALING:
+		case CALL_STATE_ALERTING:
+		case CALL_STATE_INCOMING:
+		case CALL_STATE_DISCONNECTED:
+			break;
+		}
+	}
+
+	if (!found_held)
+		return g_dbus_create_error(msg, ERROR_INTERFACE
+					".InvalidState",
+					"No held call to hang up");
+
+	if (!hfp_hf_send_command(dev->hf, cmd_complete_cb,
+			dbus_message_ref(msg),
+			"AT+CHLD=0")) {
+		warn("Failed to hangup held calls");
+		return btd_error_failed(msg, "Hang up held command failed");
+	}
+
+	return NULL;
+}
+
 static DBusMessage *call_answer(DBusConnection *conn, DBusMessage *msg,
 	void *call_data)
 {
@@ -1180,6 +1265,8 @@ failed:
 struct telephony_callbacks hfp_callbacks = {
 	.dial = hfp_dial,
 	.hangup_all = hfp_hangup_all,
+	.hangup_active = hfp_hangup_active,
+	.hangup_held = hfp_hangup_held,
 	.call_answer = call_answer,
 };
 
-- 
2.43.0

