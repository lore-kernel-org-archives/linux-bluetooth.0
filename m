Received: from alt2.a-painless.mh.aa.net.uk (alt2.a-painless.mh.aa.net.uk [81.187.30.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CD7219A94
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745608743; cv=none; b=f3T2ZrFT0cwZSH65PiwjJho6TnD55Aq/jFFX5LsmACdUAww4bjdIXM21fGFReTWW9NGrPskXIj4hnM5VBB0GcFWy9wpRPUgvKYjAIMzz00wH4shtl6VedO9aPL3NEkGte7RbizJNg2t6P+3l9JfXUBaf6UDlhMHlcYYHHPqdzGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745608743; c=relaxed/simple;
	bh=iNoNFHPOntE9VXU3/sXp34BzYarmL3L23nkondhyhLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5NRHyr4htmbnMUz8bFwMkGrC+nY2kbwvPyfvXdOMTqTJUy47xwuB2ouDyZYdC52Z8zXk/69zznzQVEpAniL1p6HSllCiFh5pzHT13h9bSbOBWnKFlpL722Ndi3EIPdLz7el9e3KkXmF8lheztbNpq11H8ZwvuT3e/Jc4wtxE+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from f.e.3.8.2.2.5.b.8.9.9.0.4.5.1.6.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:6154:998:b522:83ef] helo=andrews-2024-laptop.lan)
	by painless-a.thn.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1u8OZd-000GhX-1R;
	Fri, 25 Apr 2025 20:18:57 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	pav@iki.fi,
	Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ v3 3/5] obexd: Support creating private system/session bus connections
Date: Fri, 25 Apr 2025 20:17:52 +0100
Message-ID: <20250425191846.639039-4-kernel.org@pileofstuff.org>
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

Obexd can either connect to the system or session bus.
We mostly share a common connection to that bus, but it can be useful
to have a private connection.  For example, this allows us to quickly
unregister profiles when switching user.

Add obex_setup_dbus_connection_private(), which creates a new
connection to whichever bus was specified by the user.

Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
---
 obexd/src/main.c  | 8 ++++++++
 obexd/src/obexd.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/obexd/src/main.c b/obexd/src/main.c
index 703173662..ca95a70de 100644
--- a/obexd/src/main.c
+++ b/obexd/src/main.c
@@ -253,6 +253,14 @@ DBusConnection *obex_setup_dbus_connection(const char *name,
 	return connection;
 }
 
+DBusConnection *obex_setup_dbus_connection_private(const char *name,
+					DBusError *error)
+{
+	return g_dbus_setup_private(option_system_bus ?
+				DBUS_BUS_SYSTEM : DBUS_BUS_SESSION,
+				name, error);
+}
+
 int main(int argc, char *argv[])
 {
 	GOptionContext *context;
diff --git a/obexd/src/obexd.h b/obexd/src/obexd.h
index 5e5edc4de..560db29ce 100644
--- a/obexd/src/obexd.h
+++ b/obexd/src/obexd.h
@@ -33,3 +33,5 @@ const char *obex_option_capability(void);
 DBusConnection *obex_get_dbus_connection(void);
 DBusConnection *obex_setup_dbus_connection(const char *name,
 					DBusError *error);
+DBusConnection *obex_setup_dbus_connection_private(const char *name,
+					DBusError *error);
-- 
2.49.0

