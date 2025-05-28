Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C499D27466D
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 08:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748422790; cv=none; b=KFfiBOfKxFxGZ38XtQlukX5obrXaM0iJBspi2eDDvtfyWTEfM83+h16Iq7TR7c34TG3/sYIO2inZoi5pcWMWxwyYXZ5bwrSzsOHfNNnLfx7Yjlj2/LE6/aVxd7Tg0gW+mIofgjdP7XnNQVRh7XVDpvVOmRcPmOfMmtBMMR+WbqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748422790; c=relaxed/simple;
	bh=1TC2+y7XUUyFeaRrSi0RQ/qdkSgtq3Ec9AmB3oguyXI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VVwKvfMw8GdU/AvQnfJHemKfFhv/IVxagOjoKUZNGwPWn19msjamMM8nUVp4RetKt8b/CF2zj+V+Tb4bxCGfywdqs+u/rEWfdczn/wMgFGv/Vt+QlwHd5GSMULKsQsW/zNewGmc1T8RQ+ayvlXuyNEFbEvKRCgaiskKaY2BYvsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gKByvwVQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gKByvwVQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1748422778;
	bh=1TC2+y7XUUyFeaRrSi0RQ/qdkSgtq3Ec9AmB3oguyXI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gKByvwVQ1kHbjeQGtmn3jPtfHYJw5UUHw+C6zdQrGiwvPBp3csydhuHqbKkqRSUR+
	 oaHrrVbfVoNrs4+I6huLOs+5r9BfyJEW/JXK1IxeqkH8yWvndq66/ocNENOtBQevmX
	 9bD8Hme4rAWMADomIjrIYfMmT+AEDNiHQK+SSiT5tbhW37o62qU0i/6q/NeKsqC4Zo
	 +cbCwv1lmE/LRWy9aE4iLOmIYPHEW2uP8bbIWgT3ehqfgCLG/SS1zmi5iujRsC9SXV
	 i2qI52Tys6XnE8drQKHX77NBXkb8FqaJ4K08PSGbfMQRSsJ1FYmYDUfudZaqZZeJJE
	 YqnICpDTuJplw==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-AF44-1001-C79a-7427-1C18-f6a9.rev.sfr.net [IPv6:2a02:8428:af44:1001:c79a:7427:1c18:f6a9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B7E5B17E37AD
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 10:59:38 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 07/10] audio/hfp-hf: Add answer a specific call support
Date: Wed, 28 May 2025 10:59:27 +0200
Message-ID: <20250528085930.227816-8-frederic.danis@collabora.com>
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
 profiles/audio/hfp-hf.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index 5cd5f663b..5737c60cf 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -1107,9 +1107,31 @@ failed:
 	return btd_error_failed(msg, "Hang up all command failed");
 }
 
+static DBusMessage *call_answer(DBusConnection *conn, DBusMessage *msg,
+	void *call_data)
+{
+	struct call *call = call_data;
+	struct hfp_device *dev = telephony_get_profile_data(call->device);
+
+	DBG("");
+
+	if (call->state != CALL_STATE_INCOMING)
+		return btd_error_failed(msg, "Invalid state call");
+
+	if (!hfp_hf_send_command(dev->hf, cmd_complete_cb,
+			dbus_message_ref(msg), "ATA"))
+		goto failed;
+
+	return NULL;
+
+failed:
+	return btd_error_failed(msg, "Answer command failed");
+}
+
 struct telephony_callbacks hfp_callbacks = {
 	.dial = hfp_dial,
 	.hangup_all = hfp_hangup_all,
+	.call_answer = call_answer,
 };
 
 static int hfp_connect(struct btd_service *service)
-- 
2.43.0

