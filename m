Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6942E8DEA
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035916; cv=none; b=ikmVN1E83Ov1TOSqjijQ1g646dg8D+b8I6iQhv/pol++YJEA/MhrpC2vzmDV7B0YBNt4DrHj8NizMHZKoFNHK2Wz4GFqqtzU9PG1Gf39bjQQqz3lAn63pugLaONy4xIXkGWblXTuk+jQPNFpUsWoRgLo6CVZLYKauBlAutOEWLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035916; c=relaxed/simple;
	bh=5ldzjHdtqEPhjfmgHp9XDWylT0UYjsWPHse8we8am5M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=McPFpP8Qh2UI9xgRM2G7qLeB9FUmdkSOUCoo98mzINXT+z25BhrDxI/lQ2NGm/LOQ8sA5utAGO0iqPKek4MIwvGNBvXGm2nZImZRsl5DQqpuzXlqfKnTbDuOxfODlt2+SwPRQ+3RFt36i5Rk986UCviA0GUMD+4ehnkb6GcO0RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ns4dqDqX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ns4dqDqX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751035904;
	bh=5ldzjHdtqEPhjfmgHp9XDWylT0UYjsWPHse8we8am5M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ns4dqDqXLi9/v6QDDy/GJoywiRfEUr1EISZ5cryV30dhYTbaUXAdHx9hvfqIj10Su
	 6WQhINAukBtiC7CZEFrmyFBWDuqkhz+lQX2YtinSkXw1iWDzBr5JgCcMeTnttj3iEK
	 YZbm7kffMCnGFoRESyXEfS+zQEEQngLz3yU/nIcljDNuTggD15uDyk1Cpv5OyUEHSn
	 9sXdczt+eBpbXvAbN7pZb4079RIB1MS+yRFxzP70GCesZcIWww+NnqIyJoaQsqCt0O
	 hKFeuJQgk8+t7eXMPrEMGulW1RxXfKKAVduFj4fg3ajpc1tXlKbnBKNBZvrehroM7Y
	 7ayza4yEGgcVg==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-81C9-67b7-a328-2001.rev.sfr.net [IPv6:2a02:8428:af44:1001:81c9:67b7:a328:2001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F1BB217E090E
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:51:43 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v2 07/27] audio/hfp-hf: Add answer a specific call support
Date: Fri, 27 Jun 2025 16:51:16 +0200
Message-ID: <20250627145136.421853-8-frederic.danis@collabora.com>
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
 profiles/audio/hfp-hf.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index 6dbd6b3b0..e7bfe4f59 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -1140,9 +1140,31 @@ failed:
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

