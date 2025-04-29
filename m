Received: from alt2.a-painless.mh.aa.net.uk (alt2.a-painless.mh.aa.net.uk [81.187.30.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5322D3233
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745936163; cv=none; b=olWpMj52y8Oafac9SyP1kVHYUIF+hGtjrOXt0zq8SY/Av5abwWWyVyPsDMlwb5FoKbQ9+ucPf4Tncv6pByWca9E9dSJUTWoRjdRE7aOzzPwSqfNBsaunJyilgMdZU0XDE0DFgBxf7XWWXErrsalMI4Hf4oFTQIl2RF0z/aoBRhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745936163; c=relaxed/simple;
	bh=d/WxBMxqdLm7vLrEYisbha2jKiJBkkQV3Qhf6tl7cGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1/bDSTy7VziwiRJwqAFgtKL3eZA+SgNIgVE5/jpqYWIYPYsr9FHzfKg/wRGhe2zuakRTUuOjMvoGPtD2dxapQwvpDsEQ0oPlAWvOB9A2EfSuatM+C5Q8Gxqu40Bf61nRLPOnjqvbh8lSSts645TQn1ALGejHYoNzD526jMLUbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from e.d.9.2.d.8.4.d.d.a.6.6.5.f.8.1.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:18f5:66ad:d48d:29de] helo=andrews-2024-laptop.lan)
	by painless-a.thn.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1u9lkc-008Jal-0u;
	Tue, 29 Apr 2025 15:15:57 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	pav@iki.fi,
	Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ v5 2/6] obexd/bluetooth: Support calling bluetooth_init() after bluetooth_exit()
Date: Tue, 29 Apr 2025 15:14:12 +0100
Message-ID: <20250429141533.803295-3-kernel.org@pileofstuff.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429141533.803295-1-kernel.org@pileofstuff.org>
References: <20250429141533.803295-1-kernel.org@pileofstuff.org>
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

