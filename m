Received: from alt2.a-painless.mh.aa.net.uk (alt2.a-painless.mh.aa.net.uk [81.187.30.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7F51FF5F3
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745608742; cv=none; b=atC2rlHUjo5wImDN+iVcOlELqMEvwIUh8qySFdc6YMQxPbX4UDucKTCX7AcGnGZbsW8xbxFTIz4Nf9Mk0QjGq17A0hAiDYsYIUoZfr6/nJ3IUu03tVsHCs0uW6CHdxwXXa2CUBhrHRKlh2WloHA84FD57SNNczw4/UfEANqRWNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745608742; c=relaxed/simple;
	bh=d/WxBMxqdLm7vLrEYisbha2jKiJBkkQV3Qhf6tl7cGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZ81c/HJ+q3jNbt0/NoRXrYDdsV+moZYRyW0ahnore33TtC/b8hNeidW/CbfDKkjt5nZC5HDr20ah0b1WvKvYZdmPcGp6IX/2/LNz72u5FF9z0cGwrZOWnZl8BGuhTImqh+tyw4B0uiClJMfYC3Orwc6hOsRFsicZnDjnP8QtAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from f.e.3.8.2.2.5.b.8.9.9.0.4.5.1.6.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:6154:998:b522:83ef] helo=andrews-2024-laptop.lan)
	by painless-a.thn.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1u8OZd-000GhX-14;
	Fri, 25 Apr 2025 20:18:56 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	pav@iki.fi,
	Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ v3 2/5] obexd/bluetooth: Support calling bluetooth_init() after bluetooth_exit()
Date: Fri, 25 Apr 2025 20:17:51 +0100
Message-ID: <20250425191846.639039-3-kernel.org@pileofstuff.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425191846.639039-1-kernel.org@pileofstuff.org>
References: <20250425191846.639039-1-kernel.org@pileofstuff.org>
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
 obexd/plugins/bluetooth.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
index afb2215bd..8cf718922 100644
--- a/obexd/plugins/bluetooth.c
+++ b/obexd/plugins/bluetooth.c
@@ -440,12 +440,24 @@ static int bluetooth_init(void)
 
 static void bluetooth_exit(void)
 {
+	GSList *l;
+
 	g_dbus_remove_watch(connection, listener_id);
 
-	g_slist_free_full(profiles, profile_free);
+	for (l = profiles; l; l = l->next) {
+		struct bluetooth_profile *profile = l->data;
+
+		if (profile->path == NULL)
+			continue;
+
+		unregister_profile(profile);
+	}
 
-	if (connection)
+	if (connection) {
+		dbus_connection_close(connection);
 		dbus_connection_unref(connection);
+		connection = NULL;
+	}
 
 	obex_transport_driver_unregister(&driver);
 }
-- 
2.49.0

