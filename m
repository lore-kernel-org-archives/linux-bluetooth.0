Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAE82144CD
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Feb 2025 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738683629; cv=none; b=IL1UL29TiDkWXGcSaJAE6b8PyJhbK0ol1v3TCA4lQQWacxA+OZZKPHviCfR8eVb7zB1+o7X9UB+U3BkJzAujnsO6J4a+su5AZw8CAPo+/v3fxPW+x0B/Zp9Skh9Z5XTbvGdwzltQpE77iP++Hqfxb/PJORqMcsk0qA0JTzpeWBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738683629; c=relaxed/simple;
	bh=XSBgSTTA5rJqqOjn6S1RsooHvS5VAWWaaqSOXGRB6dU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+qwkM8bUueXdFVeTDcjGIl8iQscI6qKxOqI8H2DYl3rboBBqNGFzkwj0FRjfloMqrcDbv5s1aUMZbp66aFA7DF44z/C3UTCwwiCQvtsjKKKx6DYCsewSRtbhqHmo5FrDL5mrsBWuTW4Igriull1SmfEPqfBxJMx0MGHPZh8Emo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OvpFGca1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OvpFGca1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1738683625;
	bh=XSBgSTTA5rJqqOjn6S1RsooHvS5VAWWaaqSOXGRB6dU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OvpFGca1xR3CpTTfP1rrznytpqV+XvCfUusn6E8ngpPvgmG+KQbydtd5crHfgJkD7
	 GhXxEVnWslGIL4BahpHfZR98Sa/LcHYaazHv1cNUoJ/uxFlQ4S2cS4cQ/hqnWGmyNa
	 ruB7qBNojJfhGJdOUwT2BJLM6prdQpRvswoysxB5JrZMZN7SykiNLg+PT0rAs/rlvx
	 RtJg4o0IrmzGWYmMENByH01VG25PD1+at4tM2pNZV+cYmZa+6zGKGq15a7V7lhCqxI
	 v16xnPaLINXMvgQ/r9m4B/Wxo5pl5N0K+nkfmQ59IRlZ62m6ffCYh3sFEYfl8iMGz3
	 4BhTEBbFPHL7g==
Received: from fdanis-XPS-13-9370.. (2A02-8428-Af44-1001-Aa7E-9220-7620-339E.rev.sfr.net [IPv6:2a02:8428:af44:1001:aa7e:9220:7620:339e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 13DEC17E1519
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Feb 2025 16:40:25 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/2] mpris-proxy: Fix infinite list items reception
Date: Tue,  4 Feb 2025 16:40:19 +0100
Message-ID: <20250204154020.95539-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250204154020.95539-1-frederic.danis@collabora.com>
References: <20250204154020.95539-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Samsung Music app on Android phone send play list items in loop if
highest bit is set to 1, so limit playlist to 0x7FFFFFFF items.
---
 tools/mpris-proxy.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c
index 9edd42e99..b08733314 100644
--- a/tools/mpris-proxy.c
+++ b/tools/mpris-proxy.c
@@ -1692,6 +1692,7 @@ static const GDBusPropertyTable tracklist_properties[] = {
 static void list_items_setup(DBusMessageIter *iter, void *user_data)
 {
 	DBusMessageIter dict;
+	uint32_t val = 0;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
 					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
@@ -1699,6 +1700,12 @@ static void list_items_setup(DBusMessageIter *iter, void *user_data)
 					DBUS_TYPE_VARIANT_AS_STRING
 					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
 					&dict);
+	dict_append_entry(&dict, "Start", DBUS_TYPE_UINT32, &val);
+	/* Samsung Music app on Android phone send play list items in loop if
+	 * highest bit is set to 1, so limit playlist to 0x7FFFFFFF items
+	 */
+	val = 0x7FFFFFFF;
+	dict_append_entry(&dict, "End", DBUS_TYPE_UINT32, &val);
 	dbus_message_iter_close_container(iter, &dict);
 }
 
-- 
2.43.0

