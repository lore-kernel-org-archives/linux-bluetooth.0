Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2BE5349C9
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 21:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790889054; cv=none; b=W0zSZZOKUXAwigrSfLGwPrDQiiydvBx0RtbioV0EKuB7YLWBEPYczY2kWSBEHeAJOhh3xqJhgPOBCAWTbgSTKGAQbc+qRRJ/MaxbZWQEBs9kGU3GvEe8LuInV4ZwgKps7Mv+gEQL0z2d2bmqrUC3uBEKp/3tTAzoqe8UuCkeGAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790889054; c=relaxed/simple;
	bh=6wDILU1MgvdsEkceu3pGbzlpufWrnEBTdujmRCTIipI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7cdtVagceg9NsR5tpeMXxiC5BeeWpK/xtQqJyyedJONjxNHSpf4sHggZ8W8JHIe5zpM7bOj4c1oo7+KDs4SLe+ruBe5yl3Y/eX3SMr4f282Q/aK625i2SVzYA1iZQloFHIY7gi4A0S5e7H2xiSkGLAjFZeTm6cV9gxIDvPikJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cNZ0A0/U; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cNZ0A0/U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790889042;
	bh=6wDILU1MgvdsEkceu3pGbzlpufWrnEBTdujmRCTIipI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cNZ0A0/UR8LnI45iYiaVC2QI5G2tOfzYfBptRKT36VfDTHiFMOnilfEU6P9w8UBN3
	 r/qp0ZOIFko8nO5gOTfYfzo4EpQc1iC4nKklYahaYo3X1wA1NG2hX+m0w5fHnPIV14
	 xXWqANE8l1UwornnRpuCzThyo4OhTdT2n5PQ4eyGGkVjDdjtujWsbmQGV+O9xwbrsQ
	 yI7sPVNsgZXz7lVB5bStkQ8JJ5+P1N9DuW5rH2y1SVy8tzHST8+nLDII/1kpYsdD+I
	 2xYN+V5MFoivETTgUlFIcsI4nvTefMHLkTUafK+7DTQCoxkM1Q2k6cG5q8/3L7s6Et
	 AqOZphqv1kYQQ==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 710EE17E0803
	for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 23:10:42 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 05/12] audio/hfp-hf: Add hangup all calls support
Date: Thu,  1 Oct 2026 23:10:29 +0200
Message-ID: <20261001211036.1760396-6-frederic.danis@collabora.com>
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

This releases all calls except waiting calls. This includes
multiparty calls.
---
 profiles/audio/hfp-hf.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index dddd56261..287b79f1f 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -503,6 +503,20 @@ static DBusMessage *dial(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
+static DBusMessage *hangup_all(DBusConnection *conn, DBusMessage *msg,
+				void *profile_data)
+{
+	struct hfp_device *dev = profile_data;
+	bool ret;
+
+	ret = hfp_hf_hangup_all(dev->hf, cmd_complete,
+					dbus_message_ref(msg));
+	if (!ret)
+		return btd_error_failed(msg, "Hang up all command failed");
+
+	return NULL;
+}
+
 static DBusMessage *call_answer(DBusConnection *conn, DBusMessage *msg,
 				void *call_data)
 {
@@ -535,6 +549,7 @@ static DBusMessage *call_hangup(DBusConnection *conn, DBusMessage *msg,
 
 struct telephony_callbacks hfp_callbacks = {
 	.dial = dial,
+	.hangup_all = hangup_all,
 	.call_answer = call_answer,
 	.call_hangup = call_hangup,
 };
-- 
2.43.0

