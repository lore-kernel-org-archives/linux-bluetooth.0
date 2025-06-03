Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [81.187.30.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA882151991
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748963856; cv=none; b=XGOzUyWjMN2Cls2/z0cy1y4/LnnMKi+Qf36cRCX+HlRVcviXVpbP513Gm6bSuzwzYEFuhJTG0Uw4wuF9ONpri1I/lUEKEw0FOfYZ18nbgg3fxt4/oJHbh538Myt7g7eu/Gh4hvFbMvFebnXvT1DvS5lX2wCj0Ex3Mg4wyAaPtsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748963856; c=relaxed/simple;
	bh=rcI6apwog9Mw2MG2lck4CuLhnmizK+GIbVaWR9+QXYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WCFbul/gZXFfqFhg7ZmQisufHNImprxSyCvcTLP3UAcy7S17ORsM2mixOQzaUo9aDcTYSu3je+9IqGFmLgo/5OzhmZFka6YWXxX5/q3J8O4PMD7IJjQthM4YUoQNvJQwT/IhdSWEGoSo15f6TW6WKpdyNlfdM6iu7Dy9iRL7e38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from c.2.f.1.6.8.1.3.8.c.d.1.f.3.3.d.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:d33f:1dc8:3186:1f2c] helo=andrews-2024-laptop.lan)
	by painless-b.tch.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1uMTOO-001uWv-0Y;
	Tue, 03 Jun 2025 16:17:32 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	pav@iki.fi,
	frederic.danis@collabora.com,
	Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ 2/3] pbap: use the public DBus connection
Date: Tue,  3 Jun 2025 16:13:30 +0100
Message-ID: <20250603151651.1080923-3-kernel.org@pileofstuff.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603151651.1080923-1-kernel.org@pileofstuff.org>
References: <20250603151651.1080923-1-kernel.org@pileofstuff.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PBAP must not use its own private DBus connection, as it needs to
receive messages sent to the bus name of the public connection.

PBAP must not unregister itself when the program is exiting, as it might
cause a long delay.  Unregistering at exit is redundant anyway, as the
service will be implicitly unregistered when the connection is closed.

But PBAP must unregister itself when the user becomes inactive mid-session,
so systems with multiple users logged in at once can share bluetooth.

Use the public DBus connection instead of a private one,
and explicitly unregister the profile if appropriate.

Thanks Pauli Virtanen for pointing out the exit issue:
https://lore.kernel.org/linux-bluetooth/ae15a9fa4bf0bd509dd3d44f1f364e241e50956c.camel@iki.fi/

Reported-by: Frédéric Danis <frederic.danis@collabora.com>
Closes: https://lore.kernel.org/linux-bluetooth/333ad76e-0aba-4f93-b141-8e69fb47535f@collabora.com/
Suggested-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
---
 obexd/client/pbap.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index 64bb8ff72..0bd4e10df 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -1462,7 +1462,7 @@ static int pbap_init_cb(gboolean at_register)
 
 	DBG("");
 
-	conn = obex_setup_dbus_connection_private(NULL, NULL);
+	conn = obex_get_dbus_connection();
 	if (!conn)
 		return -EIO;
 
@@ -1485,9 +1485,28 @@ static int pbap_init_cb(gboolean at_register)
 
 static void pbap_exit_cb(gboolean at_unregister)
 {
-	(void)at_unregister;
+	DBusMessage *msg;
+	DBusMessageIter iter;
+	char *uuid = PBAP_CLIENT_UUID;
+
 	DBG("");
 
+	if (!at_unregister) {
+		client_path = g_strconcat("/org/bluez/obex/", uuid, NULL);
+		g_strdelimit(client_path, "-", '_');
+
+		msg = dbus_message_new_method_call("org.bluez", "/org/bluez",
+							"org.bluez.ProfileManager1",
+							"UnregisterProfile");
+
+		dbus_message_iter_init_append(msg, &iter);
+
+		dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH,
+								&client_path);
+
+		g_dbus_send_message(system_conn, msg);
+	}
+
 	g_dbus_remove_watch(system_conn, listener_id);
 
 	unregister_profile();
@@ -1499,7 +1518,6 @@ static void pbap_exit_cb(gboolean at_unregister)
 	}
 
 	if (conn) {
-		dbus_connection_close(conn);
 		dbus_connection_unref(conn);
 		conn = NULL;
 	}
-- 
2.49.0

