Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [81.187.30.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A9128935A
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426076; cv=none; b=Yri8jFltSPrpLueryLWn0r7zIp3YTkuRp8IIXp+uLi3InLJrq0oT207p5utsQVlpb/5ttSWEQURqOL/ngGzuQ69+uTKfI61mA9vGfbPSbOa0Hm080t+NsYNMGqHrZo+ja23OMtPBQl9gNKZshMnoNUkHq53rVLa/SC6yD+DMxoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426076; c=relaxed/simple;
	bh=EbS2BumF/JYg0FxOLQgjXCk4IZQmQKNDpw0Y8HFL/R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILYNKZ6wtu4lWOVnzUZWxxfYJg4JVeCgiZnNVK1K7+tF78CyKXV1Ib0cEapnYU1cOcLWQhk3R62RTupfnjUvxh++ZdcnGEhc/mYcpMh0xgntFEidKDMbfeAPAxXtHzYvOJ3Q4WezMw6OZaMp89rb+SYfEETllnPyW8OiHIxLor0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from 2.d.9.3.3.f.4.8.6.f.f.b.b.0.3.7.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:730b:bff6:84f3:39d2] helo=andrews-2024-laptop.lan)
	by painless-b.tch.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1u7d3O-00El0N-1g;
	Wed, 23 Apr 2025 17:34:30 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	pav@iki.fi,
	Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ 2/4] obexd/bluetooth: Support calling bluetooth_init() after bluetooth_exit()
Date: Wed, 23 Apr 2025 17:33:24 +0100
Message-ID: <20250423163343.4160595-3-kernel.org@pileofstuff.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423163343.4160595-1-kernel.org@pileofstuff.org>
References: <20250423163343.4160595-1-kernel.org@pileofstuff.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bluetooth_exit() didn't previously unregister itself thoroughly.  That
was fine if it was only called when the service was about to exit,
because everything was implicitly unregistered when the process ended.
But we need to be more scrupulous if this can be called throughout
the program's lifecycle.

Send UnregisterProfile messages directly from bluetooth_exit(),
then call unregister_profile(profile).

The UnregisterProfile message can't be sent directly from
unregister_profile(), because that also needs to be called when
register_profile() fails halfway through.

Do not free profiles in bluetooth_exit() - profiles are needed
by a future call to bluetooth_init(), or will be freed by
bluetooth_stop() if necessary.

Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
---
 obexd/plugins/bluetooth.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
index afb2215bd..bcaf19bae 100644
--- a/obexd/plugins/bluetooth.c
+++ b/obexd/plugins/bluetooth.c
@@ -440,12 +440,38 @@ static int bluetooth_init(void)
 
 static void bluetooth_exit(void)
 {
+	DBusMessage *msg;
+	DBusMessageIter iter;
+	GSList *l;
+
 	g_dbus_remove_watch(connection, listener_id);
 
-	g_slist_free_full(profiles, profile_free);
+	for (l = profiles; l; l = l->next) {
+		struct bluetooth_profile *profile = l->data;
+
+		if (profile->path == NULL)
+			continue;
 
-	if (connection)
+		msg = dbus_message_new_method_call(
+					"org.bluez", "/org/bluez",
+					"org.bluez.ProfileManager1",
+					"UnregisterProfile");
+
+		dbus_message_iter_init_append(msg, &iter);
+
+		dbus_message_iter_append_basic(&iter,
+						DBUS_TYPE_OBJECT_PATH,
+						&profile->path);
+
+		g_dbus_send_message(connection, msg);
+
+		unregister_profile(profile);
+	}
+
+	if (connection) {
 		dbus_connection_unref(connection);
+		connection = NULL;
+	}
 
 	obex_transport_driver_unregister(&driver);
 }
-- 
2.49.0

