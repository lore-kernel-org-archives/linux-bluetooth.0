Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4842E8DEC
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035916; cv=none; b=fxfqgN8VQtQm7Iypkr+184WBujG1Gd11SC8I3oVslIZDOKJdQ/ECAEjmsGUD+NGs7gnolXvf/4SO+66hpNoR4yQ6vO6qlvOhFjNTBv2O/dKaKq4+4jf8mxZ1lKzzH7YSBumruZ3/uAnWtGm1xuDmgMyU371gyqaxcQpDHE+mW/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035916; c=relaxed/simple;
	bh=PfsMwJhCcFy7akcwb7GFreYqDaZIN9rbrpi5ylBiIdA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Az6IOpDdh9fnlbL5ombzG8pMgQRrzTjXnkxNh0fzJX3BJr45Zp1U5n04dgti5o/LDcRERgIueyU2vvvTYac+A+M55GKRQrW/37mRECl1MhsPxL47QyfBKHauLtX6CYsp6g5F/GF5+JSj59o0HHNUb+1WbJOq013xCk2QsMpLaAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=owvEzpkz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="owvEzpkz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751035903;
	bh=PfsMwJhCcFy7akcwb7GFreYqDaZIN9rbrpi5ylBiIdA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=owvEzpkztxGc1CtTxjdDhKCtflSP5So6XkP9acojmUkr8Dqls365bTL5XtQg2Znx6
	 kcZ02KVRG6dj+D+kyF+13DncE3rFENuki88pGixwWC1gC1KA6Voc3AhdEhEknEbHAX
	 GFu1p4jwO4pRMwwXHkvwt6tAB1gDCaIr4fUR10fm4endFAaKCCnOcFm0mevJVwAV6R
	 8QmZwYnNNy23jB5NR3ItFKVCfBnfxtnmbi/v9axU2HFJ1LjU05uavRiLxm0xt1fEiL
	 9L9CkjYOYeqiZPNH25/mitgufQu+8U3llamw7Dbdev8RilT06MFsqtQ6+PtS6YIfqN
	 cMMpSoor+EXoQ==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-81C9-67b7-a328-2001.rev.sfr.net [IPv6:2a02:8428:af44:1001:81c9:67b7:a328:2001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A7FAA17E08E3
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:51:43 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v2 06/27] audio/hfp-hf: Add hangup all calls support
Date: Fri, 27 Jun 2025 16:51:15 +0200
Message-ID: <20250627145136.421853-7-frederic.danis@collabora.com>
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
 profiles/audio/hfp-hf.c | 57 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index ffe4ab708..6dbd6b3b0 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -1084,8 +1084,65 @@ failed:
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

