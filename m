Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A69A274665
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 08:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748422790; cv=none; b=Eevn3a/aOIGvQwbrXJkTyWLD8hfNXD3zTHobMCBZ+F9pTtIybd8zC9xUSiYV8XiwJ2F3zpvZ16TZSA9fKGIwR5nzx1sfFal2CnXegVGMmjREaYXjzaU450JwJQk8NHrLEJAk/CWkM1xMGIiO0cmkyb19MHfcD2nD8p1LEIuY1cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748422790; c=relaxed/simple;
	bh=8yrbNBywPbuO+dcL18M3RkchVDgnY5gelOJeRxG0N5U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G5KR1iP1I3g9MQlGLNI7Gch8G3gTdYXrjR+16BM6A48BF+7WxZra7cikTBx+LPHwpurjjZHoyJJUOuZOWT/H0z/65MW9A5A3UpwpXgkZF0S3Cyvma6/ENmVctdOTTGPAcNy/v3Jejj2LPOXA5uQ11xMpkbShdDvl/DuVEMDdIuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cONrtSe0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cONrtSe0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1748422778;
	bh=8yrbNBywPbuO+dcL18M3RkchVDgnY5gelOJeRxG0N5U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cONrtSe0mnHoohXLPE0njGgtRc0lRWkH655EbG9y+IBzNug0yxZNmH2anrX6lbOL7
	 StGcF7BF+h+gVBZkWVIjNc+1IUHNvnbluRSupZfCSa0dyZBlfohwShTTSuYBRLPe30
	 ujKv18iDgGj1gOP288icMH3azOdzwRyWKV18hrwOUoSzODUQ9P/7DMoy7AX8FjBxRs
	 IhCFDYtr2ksSPTvrJaf5HNB6LQLIMfThs2gb8s8sdxYhCKFG9nMpzcdXYFSBjX8lxu
	 7hzTSKmmYmVeiayJnPpa2s2A/Hu64/CwYltMr1ANjUAW34/FQIqKye6nvX1NhR6LAw
	 9Y8MG3Ml/HcVQ==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-AF44-1001-C79a-7427-1C18-f6a9.rev.sfr.net [IPv6:2a02:8428:af44:1001:c79a:7427:1c18:f6a9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6D67F17E3798
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 10:59:38 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 06/10] audio/hfp-hf: Add hangup all calls support
Date: Wed, 28 May 2025 10:59:26 +0200
Message-ID: <20250528085930.227816-7-frederic.danis@collabora.com>
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
 profiles/audio/hfp-hf.c | 57 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index 395f7ba61..5cd5f663b 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -1051,8 +1051,65 @@ failed:
 	return btd_error_failed(msg, "Dial command failed");
 }
 
+static DBusMessage *hfp_hangup_all(DBusConnection *conn, DBusMessage *msg,
+				void *profile_data)
+{
+	struct hfp_device *dev = profile_data;
+	bool found_active = FALSE;
+	bool found_held = FALSE;
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
+			found_held = TRUE;
+			break;
+		case CALL_STATE_DISCONNECTED:
+			break;
+		}
+	}
+
+	if (!found_active && !found_held)
+		return btd_error_failed(msg, "No call to hang up");
+
+	if (found_held) {
+		if (!hfp_hf_send_command(dev->hf, cmd_complete_cb,
+				found_active ? NULL : dbus_message_ref(msg),
+				"AT+CHLD=0")) {
+			warn("Failed to hangup held calls");
+			goto failed;
+		}
+	}
+
+	if (found_active) {
+		if (!hfp_hf_send_command(dev->hf, cmd_complete_cb,
+				dbus_message_ref(msg),
+				"AT+CHUP")) {
+			warn("Failed to hangup active calls");
+			goto failed;
+		}
+	}
+
+	return NULL;
+
+failed:
+	return btd_error_failed(msg, "Hang up all command failed");
+}
+
 struct telephony_callbacks hfp_callbacks = {
 	.dial = hfp_dial,
+	.hangup_all = hfp_hangup_all,
 };
 
 static int hfp_connect(struct btd_service *service)
-- 
2.43.0

