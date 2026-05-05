Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C78480331
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777978598; cv=none; b=iIHrC1BX4DEEj58AJLvji0dA7ruaiTYqcfasmTaObI1Nm3potciTtzj3xnjNtCcUUCjDML81nzNK2TMETwzkT7x5imF++lf4JG/9wy29nGkzx+MvZpUbZbz5670pUk2yxjdL8oYL1uqJvsBKDfR3PLSHBPhk6h+QmNHfYhV7xHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777978598; c=relaxed/simple;
	bh=nyFeiliL99DHLxexPYoTbbPmMwp197hX/UfV57bdTfU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FxZxJtlWFmDtxAJXRaGJKNbplues6jFZxhTI9P1DA+Z2+39j5dJA1N86FmwTF8QxWpZoBQULQe9gP5HyzdFsmP3PGa8DvS4RnljhnCM2jb2VXw6Oek8dqIF6Wf0X4Bb0Qcg/yMOZ1oLVumzX6fsVpUQ6t/isXlfheU7WQCeGXgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 33A3C581908
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 10:49:03 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E9DB93E9B9
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 10:48:55 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v2 1/2] mpris-proxy: Fix possible crash
Date: Tue,  5 May 2026 12:48:17 +0200
Message-ID: <20260505104847.2550550-1-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTFScmmvYYLT2wxZJrB7DFvCj8XMDG/193moz9eAgDaqTHlKcdowobdckXM7K+QN89F0GgY79QYI+mki0dXVFVNyNCEcCowMcD328QnT1If/lc6TgE470d2YRkA0ngM8w84PdIctWI36yRxzR7pLqFuTay+hOIbQydOZJQhk6xScUFhjTv8YVeE0hI7/4FsxP1Va4IKyNM/3wVHDIaNh3mVKCiT7nlyhUXXrm7byNLx8P8uzggp6snFEqJDfz75aRcPJIM2NsUTWxC+MYy6urf2gqbjlF97vs7beRekAJNdzgfqHKiuLxs0DdeNNup0mkyhUM8wmoX9B0JrCQHpQ1BlRdzIZ1XYgl/YAsotubvIbD5crYyAIX0Oa/hOSJaAyFQisAleuOP+zAErOCXfjfynStrCIV7mxmfhF/wJ/jiHApku09fwzOO6UhRx2r0XHLeM0yUEqgQyCrdPUAw8Xeyr8fthCvJRNJbsghnj610ErKS6MXh97YOHoOfBHixK6/I/Tx0P+HiVY4+pfg6Oq8bLi/mXGGJ1rKFQTNteLUmopGOljauLfAUIAnFhducwKKMcsXDBVEg5U3CHDDN4zIqeL8rLZYHIub+m5xWSYZ0ZJ88DO+aIWWJYUUZEG68KF2dgu5kBXp8fou9KPNOq6w5YnPOHazMf0TJy044sOqsdO9A

find_player_by_obex() doesn't check whether session->obex is a valid
pointer before dereferecing it, but all code paths that assign it use
create_obex_session() to assign it, a function that can fail.

Check whether session->obex is null before dereferencing it.

 #0 find_player_by_obex at tools/mpris-proxy.c:2819
 #1 obex_property_changed at tools/mpris-proxy.c:2929
 #2 add_property at gdbus/client.c:373
 #3 update_properties at gdbus/client.c:399
 #5 properties_changed at gdbus/client.c:537
 #6 signal_filter at gdbus/watch.c:416
 #7 message_filter at gdbus/watch.c:566
 #10 message_dispatch at gdbus/mainloop.c:59
 #13 g_main_context_dispatch_unlocked at ../glib/gmain.c:4451
 #14 g_main_context_iterate_unlocked at ../glib/gmain.c:4516

Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2466640
---
Changes since v1:
- Fix missing space before = sign

 tools/mpris-proxy.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c
index 1d7a421e9278..eb607347aa32 100644
--- a/tools/mpris-proxy.c
+++ b/tools/mpris-proxy.c
@@ -2816,8 +2816,12 @@ static struct player *find_player_by_obex(const char *path)
 	for (l = players; l; l = l->next) {
 		struct player *player = l->data;
 		struct obex_session *session = player->obex;
-		const char *obex_path = g_dbus_proxy_get_path(session->obex);
+		const char *obex_path = NULL;
 
+		if (session == NULL)
+			continue;
+
+		obex_path = g_dbus_proxy_get_path(session->obex);
 		if (g_str_has_prefix(path, obex_path))
 			return player;
 	}
-- 
2.54.0

