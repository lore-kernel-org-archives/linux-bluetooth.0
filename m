Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C904A2E00
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342758; cv=none; b=aCFuP3MnAzgcFQ19TmNvnA8cIZBRMva5e3xVF81oH8nU1RuYCQgWJBNQOESz6IkfVgJpXJrsSUrAtZYM1CFsiqXgf58iFHQRXvsQ1XFtkucvXLuWvkDqd5SjziFG6pzX3a8vcl5fVnlsmuKTKtGrOztLJ+NMxldKFPxOGKQdtZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342758; c=relaxed/simple;
	bh=jFARBSWzB+9PnxuT6gv+e04kyK/p81QPLT9CP2EyhE8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dchSO+t9JeC9mShOJJ2UVHTYYbS31mBUnR+Ccw9pWsnGePS0LIG8iKpB/zrkc45khbPwxGfop6EztEBgnLUDA3x8rsd+Kwxs+hBt8U599Ut4Z37Tjy84jl2t+CSqeXvGb/YS+1vCy3256jW6xC1NsCTVXyP0kfXmmfOI80AhVRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=an8jeltf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="an8jeltf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790342737;
	bh=jFARBSWzB+9PnxuT6gv+e04kyK/p81QPLT9CP2EyhE8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=an8jeltfhR3GQn6zFgFpVGlBSj+fRvhJ8+G3/K2lwwOpxuGJez1fBGA/wVhZ6Nr/Q
	 V1Ee1OyDBpzyyL8DQ1SZzbGBkZg+t0nC6Heu8agJ5I50gZDhIFbCJVqzaQ1W17L0uc
	 ueGJcARY8q9cFgGl8x6TwYYBPhN6G6i7f4Wz9EKGJZSe6XUNplLW9OM0yPgiP/NHdY
	 EI8+v2guKEKEXc510FVcNy11wfyFAyYHtdkEs3Fx97aQ5oLY0UhkQxO/DN2q4QyI3Y
	 Dfs8wPT/hTKmKDWbE34C86IzXlODj3TESBGxo1nAzRblWAXjwdcMKnFZGIKKsjdUwD
	 n7mfV/Jsar3pA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8DB6B17E0D84
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 15:25:37 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/12] audio/hfp-hf: Add Send Tones support
Date: Fri, 25 Sep 2026 15:25:23 +0200
Message-ID: <20260925132528.3361517-8-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925132528.3361517-1-frederic.danis@collabora.com>
References: <20260925132528.3361517-1-frederic.danis@collabora.com>
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

