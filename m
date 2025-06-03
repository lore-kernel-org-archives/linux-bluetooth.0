Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [81.187.30.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE07323099F
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748963857; cv=none; b=iMH+OdAzBk3KIfoa3x+27qUR/8mLp1W6pDi2Fa75gfhsBsl8UwRe9YmbazssJA595t6UgSAi458uI5rQTiLz+4jppldMDnl5eUmnnV1NRsyy4Nqpsa7WiMQHM5FfScwuENniLdVw0H4HQUgX9ynFwGKwvi9fNdL+T1qVpb8A8Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748963857; c=relaxed/simple;
	bh=Yec/nPySt+JalAFQ9pvInBq8u4b2OvzGO9SkgyxMRbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mf3IKZaU9LDIWUxHQ4zwrrxggIUtWGTYg5ljXO+GWXEmEDZ7nlVw0nxg8VjOUoLgcE+oKdRHNL1QlTnq/y3cho75IHLjZE7zHguEFftBdWgIcdqmt0m/b54g+c5YkwpJL4QQCyyATWvy4umE/mX4OuW8uXIduzKdp7Gg8wyOQjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from c.2.f.1.6.8.1.3.8.c.d.1.f.3.3.d.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:d33f:1dc8:3186:1f2c] helo=andrews-2024-laptop.lan)
	by painless-b.tch.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1uMTOO-001uWv-12;
	Tue, 03 Jun 2025 16:17:32 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	pav@iki.fi,
	frederic.danis@collabora.com,
	Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ 3/3] Revert "obexd: Support creating private system/session bus connections"
Date: Tue,  3 Jun 2025 16:13:31 +0100
Message-ID: <20250603151651.1080923-4-kernel.org@pileofstuff.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603151651.1080923-1-kernel.org@pileofstuff.org>
References: <20250603151651.1080923-1-kernel.org@pileofstuff.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 237d818ef294e22be87fba69b3cdd79c75c201e7,
which encouraged the use of private DBus connections.
Doing so caused a bug, so it's better to remove the temptation for now
and re-add it if a legitimate use case is ever found.

Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
---
 obexd/src/main.c  | 8 --------
 obexd/src/obexd.h | 2 --
 2 files changed, 10 deletions(-)

diff --git a/obexd/src/main.c b/obexd/src/main.c
index df150973e..6837f0d73 100644
--- a/obexd/src/main.c
+++ b/obexd/src/main.c
@@ -254,14 +254,6 @@ DBusConnection *obex_setup_dbus_connection(const char *name,
 	return connection;
 }
 
-DBusConnection *obex_setup_dbus_connection_private(const char *name,
-					DBusError *error)
-{
-	return g_dbus_setup_private(option_system_bus ?
-				DBUS_BUS_SYSTEM : DBUS_BUS_SESSION,
-				name, error);
-}
-
 int main(int argc, char *argv[])
 {
 	GOptionContext *context;
diff --git a/obexd/src/obexd.h b/obexd/src/obexd.h
index 560db29ce..5e5edc4de 100644
--- a/obexd/src/obexd.h
+++ b/obexd/src/obexd.h
@@ -33,5 +33,3 @@ const char *obex_option_capability(void);
 DBusConnection *obex_get_dbus_connection(void);
 DBusConnection *obex_setup_dbus_connection(const char *name,
 					DBusError *error);
-DBusConnection *obex_setup_dbus_connection_private(const char *name,
-					DBusError *error);
-- 
2.49.0

