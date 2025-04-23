Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [81.187.30.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F22289351
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426074; cv=none; b=mhwowBwUQ02BKEGmoRTjaHAv0NlBSm+TwkVE1efVMBUDLLQmpDoDr7lpgP2LoZ09dfxDgYN0f2PSdhqayn6Iro77aIDXYhy56pH4rS7td6L1LwDtNExaSnFhf6E6umZQjTZAlxIeTE9U8AoKEOefrr6jWoSU7V6IpwTXXRofr6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426074; c=relaxed/simple;
	bh=udBQo0ERU/wfaLmxwUfCniAxvJRbQnufwqqB7pjwShA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abTYth9CNQ3cgQ8tYTjXcqqbGP4X7tIkE/aJmXde7D2RxzvimlGGYxKe1l2ZPBwX9d1poHNyodhpTbHn1e2jdco8Afpqk3WT3HhAESVxXw+64KvehYRs8jTNbdZ67iXrroPLKxQsiR2QmsRgUisdh7/tYnQWgqv51AIzTIzQ80Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from 2.d.9.3.3.f.4.8.6.f.f.b.b.0.3.7.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:730b:bff6:84f3:39d2] helo=andrews-2024-laptop.lan)
	by painless-b.tch.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1u7d3O-00El0N-1J;
	Wed, 23 Apr 2025 17:34:30 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	pav@iki.fi,
	Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ 1/4] pbap: Support calling pbap_init() after pbap_exit()
Date: Wed, 23 Apr 2025 17:33:23 +0100
Message-ID: <20250423163343.4160595-2-kernel.org@pileofstuff.org>
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

pbap_exit() didn't previously unregister itself thoroughly.  That
was fine if it was only called when the service was about to exit,
because everything was implicitly unregistered when the process ended.
But we need to be more scrupulous if this can be called throughout
the program's lifecycle.

Send the UnregisterProfile message directly from pbap_exit(),
then call unregister_profile().

The UnregisterProfile message can't be sent directly from
unregister_profile(), because that also needs to be called when
register_profile() fails halfway through.

Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
---
 obexd/client/pbap.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index 2f234fadf..e2a3c1b90 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -1483,8 +1483,28 @@ int pbap_init(void)
 
 void pbap_exit(void)
 {
+	DBusMessage *msg;
+	DBusMessageIter iter;
+	char *uuid = PBAP_CLIENT_UUID;
+
 	DBG("");
 
+	client_path = g_strconcat("/org/bluez/obex/", uuid, NULL);
+	g_strdelimit(client_path, "-", '_');
+
+	msg = dbus_message_new_method_call("org.bluez", "/org/bluez",
+						"org.bluez.ProfileManager1",
+						"UnregisterProfile");
+
+	dbus_message_iter_init_append(msg, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH,
+							&client_path);
+
+	g_dbus_send_message(system_conn, msg);
+
+	unregister_profile();
+
 	dbus_connection_unref(conn);
 	conn = NULL;
 
-- 
2.49.0

