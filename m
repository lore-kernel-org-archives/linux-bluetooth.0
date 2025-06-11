Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [81.187.30.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0671A284B2E
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749647526; cv=none; b=fMM+2DKI5fzF4OGtO5QzijtySYNzaKY90i5GYaul9Xt5Ke4eidq9yewPgKLgSLVI0rFmbTuL37/LRFF0MTRSQumLBDTXCHw6BJSLJKKvH6L9tjQFk4LhKxsoF4HxWhKNgryKVMfSqKAGPfQTkvtU3IZVGTrKA6KBJ+EgOx/6YFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749647526; c=relaxed/simple;
	bh=8uG4BVsDwrE97T4K7XJGDgI66TPXZoJk7Y9Crm2rq+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MCaxWfN20S4VsYispSzWOGyGbQlI+RBnPYTsOcwcgtKyNyyUK9aM9PakHadVu3hv8NJMGKFSM/PStKsoXKe17OYARJyszAq5vJiuwlMBa0x4Gc+ZevEnmSgOMCzoE5c88cf6iN9g53n0QkEYzX43iezgexlRZtgeg6RNPTxfwVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from 1.a.2.1.e.1.9.2.1.e.2.8.f.7.6.5.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:567f:82e1:291e:12a1] helo=andrews-2024-laptop.lan)
	by painless-b.tch.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1uPLFJ-00CPsc-0n;
	Wed, 11 Jun 2025 14:12:01 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	pav@iki.fi,
	frederic.danis@collabora.com,
	Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ v2 2/3] pbap: use the public DBus connection
Date: Wed, 11 Jun 2025 14:06:14 +0100
Message-ID: <20250611131125.450039-3-kernel.org@pileofstuff.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611131125.450039-1-kernel.org@pileofstuff.org>
References: <20250611131125.450039-1-kernel.org@pileofstuff.org>
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
index 7d651722a..78c46bf86 100644
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

