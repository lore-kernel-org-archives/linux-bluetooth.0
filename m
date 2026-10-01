Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF5F535FA8
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 21:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790889054; cv=none; b=YmacgFZFK+m0l1ukFTswsI6Dh2EcJIgktg+MkiPAJMdbDUZsoqJAnIB+ywBs/iKngK5EW02SSEYqZpHhuJFBYwsHl/dA5wGQc04PIxegTwmdTxUkBCsAFyaXeaq1DsI1TRffw3ttR568aM59D/xAvOXUs3lKNMlnLxJVoe1uZ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790889054; c=relaxed/simple;
	bh=jFARBSWzB+9PnxuT6gv+e04kyK/p81QPLT9CP2EyhE8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IoUX2070Zf9X6BaO8te4KiYdfkZJVZycoveQy9KNGB2DvrwdrVSC1kGJDZ3FJecL+/cYcf/iSoesYp0Y0R65C6KZF8pdRcAsQPRvI+7NQjqdijGNY3VwS7QZN3Cndfl1E8uPnuFn4XdqI7+375BkmBFGOftjNsxwIktC5IrKO9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=X+Clz+Uu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="X+Clz+Uu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790889043;
	bh=jFARBSWzB+9PnxuT6gv+e04kyK/p81QPLT9CP2EyhE8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=X+Clz+Uu/fdcurlNUgynUiBBRV1ODJPTUdbEcTbBnw2M+pC2u4NmHNsut2uTkDLxH
	 j4jgAsYgqAajU3cktUHsE7zx/eepSenDgkelLm07p8NZu6rlOa4LagV+ySFOOlgB9q
	 Fry1rd5G6VNwplJwC/WBQC5vf5y+v8duRFJ5EWdaVBhiJCSKUiXCglb4sBBsS7Ro14
	 PgUC+rcNbBzcialY4FYZl5AeJYPbEGCLC+ysvPDpoe0VmqU+/Jwa+h2wgn1vga+7Vk
	 S8LfsGToEanzmOwiob4Fx+Vg80nsjrdXJZRLA+Qp85EdIp1BXOaHLn0eLYXo6rBSyX
	 PFybUcvCPIXXw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E418F17E0906
	for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 23:10:42 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 07/12] audio/hfp-hf: Add Send Tones support
Date: Thu,  1 Oct 2026 23:10:31 +0200
Message-ID: <20261001211036.1760396-8-frederic.danis@collabora.com>
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

---
 profiles/audio/hfp-hf.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index 287b79f1f..1843b6758 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -517,6 +517,26 @@ static DBusMessage *hangup_all(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
+static DBusMessage *send_tones(DBusConnection *conn, DBusMessage *msg,
+				void *profile_data)
+{
+	struct hfp_device *dev = profile_data;
+	const char *tones;
+	bool ret;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &tones,
+					DBUS_TYPE_INVALID)) {
+		return btd_error_invalid_args(msg);
+	}
+
+	ret = hfp_hf_send_tones(dev->hf, tones, cmd_complete,
+					dbus_message_ref(msg));
+	if (!ret)
+		return btd_error_failed(msg, "Send tones command failed");
+
+	return NULL;
+}
+
 static DBusMessage *call_answer(DBusConnection *conn, DBusMessage *msg,
 				void *call_data)
 {
@@ -550,6 +570,7 @@ static DBusMessage *call_hangup(DBusConnection *conn, DBusMessage *msg,
 struct telephony_callbacks hfp_callbacks = {
 	.dial = dial,
 	.hangup_all = hangup_all,
+	.send_tones = send_tones,
 	.call_answer = call_answer,
 	.call_hangup = call_hangup,
 };
-- 
2.43.0

