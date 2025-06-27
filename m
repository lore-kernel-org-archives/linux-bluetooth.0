Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A2D2E8DF4
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035917; cv=none; b=pUPT4RFPMDT0jABLxo+mS/gcaxqZVGdItsh4JVDRa+gTMlBb5lvE61ETFuXhjsp0em+Rq5ctVZ3pGcZijy8bGdaJ5nUOd79Xsb+r5/x2d6rhoUEU9UT3L22lcSfoVm/iAS99vets71WJask+cWYsx/JhDyEwYIPRAEqiUzt+dzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035917; c=relaxed/simple;
	bh=ABjmM71aGZ31CeO+3Yxi66AD/RsDsBB52Bt99HZSyDw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EEu/vJboltUQiVHYBHuEARCNl2eoCkuZ8tiJRCjUVJ+CgxsWZF/ysitMxL5WvCxIDCEy1Z4frLJUvercJSm1Dgi5gattMywInxd+8rK9fRwUfA4Lb6lsElw5VDpey2ozM5WJqi34T6I8ALGByTUuyQCdIYQQ1Jj/L26KOLyildo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kEUkqBXC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kEUkqBXC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751035906;
	bh=ABjmM71aGZ31CeO+3Yxi66AD/RsDsBB52Bt99HZSyDw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kEUkqBXCAd8NSVd9oycI49VDRbRxm1exxvmZwqITll7XxIfDx0yFpy+Do60LZnGAx
	 Z/DCDlM7WeINhVHRiDdsO0keJuAve1dgDzDhG4gPvIDzRU24J2vrBk2nm/yvnvI3Nc
	 jY61uj++cq7R8GmJx2gKNiWzTnPtEMSEOSiZpQHUi7AGtyIdGD5GkyTRyci/y/D0yM
	 jdLkG/RK5LE46xUvJufvrT34Uhu1rH2q2lL07LoD+uDNiYZ+LlwzkmIXEXUJH86ztY
	 GR8b+S1JC9R3Wu/1tFYBHDdByPJ/3gux0nsFipGUiKkkkAQiybK4x5U6NNeS2ohle9
	 9K82CvSLTA+4w==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-81C9-67b7-a328-2001.rev.sfr.net [IPv6:2a02:8428:af44:1001:81c9:67b7:a328:2001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1B92517E0A28
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:51:46 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v2 14/27] audio/hfp-hf: Add SendTones support
Date: Fri, 27 Jun 2025 16:51:23 +0200
Message-ID: <20250627145136.421853-15-frederic.danis@collabora.com>
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
 profiles/audio/hfp-hf.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index a2a1ae39f..9a659a281 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -1241,6 +1241,45 @@ static DBusMessage *hfp_hangup_held(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
+static DBusMessage *hfp_send_tones(DBusConnection *conn, DBusMessage *msg,
+				void *profile_data)
+{
+	struct hfp_device *dev = profile_data;
+	const char *tones;
+	bool found_active = FALSE;
+	GSList *l;
+
+	DBG("");
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &tones,
+					DBUS_TYPE_INVALID)) {
+		return btd_error_invalid_args(msg);
+	}
+
+	for (l = dev->calls; l; l = l->next) {
+		struct call *call = l->data;
+
+		if (call->state == CALL_STATE_ACTIVE) {
+			found_active = TRUE;
+			break;
+		}
+	}
+
+	if (!found_active)
+		return g_dbus_create_error(msg, ERROR_INTERFACE
+					".InvalidState",
+					"No active call to send tones");
+
+	if (!hfp_hf_send_command(dev->hf, cmd_complete_cb,
+			dbus_message_ref(msg),
+			"AT+VTS=%s", tones)) {
+		warn("Failed to send tones: %s", tones);
+		return btd_error_failed(msg, "Failed to send tones");
+	}
+
+	return NULL;
+}
+
 static DBusMessage *call_answer(DBusConnection *conn, DBusMessage *msg,
 	void *call_data)
 {
@@ -1267,6 +1306,7 @@ struct telephony_callbacks hfp_callbacks = {
 	.hangup_all = hfp_hangup_all,
 	.hangup_active = hfp_hangup_active,
 	.hangup_held = hfp_hangup_held,
+	.send_tones = hfp_send_tones,
 	.call_answer = call_answer,
 };
 
-- 
2.43.0

