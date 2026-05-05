Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E12F3D16E9
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 07:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967665; cv=none; b=S8T9qMrgfGxDiGArWkQTY09mmDKIcPMGq8ZbU6bSpUE8LjJe5WGDTd0ZtoZO8CY7cHf/kPkOHAMh3WJzBqfYiQ/K/43MXgJruDNcoHdW1pnZpO0NqsWgYrhx1pZIgS3dV2P4VSNBr5MdgOayTQU7Y2VF0SXiyFeUpdhP5dpr3Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967665; c=relaxed/simple;
	bh=WwBq4lrCodmcGr7Ej0qZrsxYj1Fjs7VSSf38ImN6FoI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=biG2Cw5VkkxrPN2ofcO9rLSDq2x69AV+uttyjq4rcykKvean5/nyXc4XvEV9xr7GIPwt3mJYznfaKWI2dBwVGqc/obHlyzkHEU+/XlGB72B4w9vy1F2ryuql/JvzjK8n/Uun157MZZCWLD+BeLmJliPBGUv9UHAek9BM6zqV2ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 5E68858178E
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 07:30:14 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D12EE3ED59
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 07:30:06 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 1/2] mpris-proxy: Fix possible crash
Date: Tue,  5 May 2026 09:29:24 +0200
Message-ID: <20260505072958.2424004-1-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: dmFkZTGjaeHrd0Q3juavGxHexwN9Yo+/RUNZWi87DJuU2qnSn3C4o+3DXpLlA9wHvtBoufr8f/ECwJhYwCBED2xO6NaWLBy8QN8mdGXllCck4NqrEHWTDb+Zir3T/4ecZ7lwwLdLL/wM63UyRjeiUMs387z/GTPqCKRWkMJOtsX3+2JO9BQTFT0Dpzg6E2+MMolcPP0pN2p8mWMI8Jz+rV775HlFrP+w4NAKW2eovBJHFmDqCBSffrljWdUaT/7lA1FzxInyS7y+s/s6HB6DTiIBz3U5NrHn2fKHMsgPHDok5yrVU8hrNt15h6A3UG/RsOTaVFRnilp1o9jrcxwSG9DDnwHZf441+QUrIiOvpx6U2JgcG3GqyCXvmn6TyJJ9rrnewXf3Jxydn8XMm+pWNkSfmaSjtdbSnpNlHChM04Oa6NQoe7c8vkiAgKblXCeKRpJ7oYs8i/XYg+qvM3rKjCfgNMs12wazKh7vJT6w4t+HR+HpAtyuNWL0g4FYqCifiH+hoM3vDixS4WbriUcjCXouwlz3LTt4yzQPuaErS4wbeASwxHuGXVV+RyQJSpykmHLWs1jL1dhHt5wU0oxbhkllA8BlzTPGTfprOi9ZH6Wg7guCql8DzsCiMycXsQ5V2ipRmhAdy/W78Mf2i6PebgSK/rdD02mHz8FkVkvm6C52E+zIpw
X-GND-State: clean

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
 tools/mpris-proxy.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c
index 1d7a421e9278..360b8ab34469 100644
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
+		obex_path= g_dbus_proxy_get_path(session->obex);
 		if (g_str_has_prefix(path, obex_path))
 			return player;
 	}
-- 
2.54.0

