Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E362C237E
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981710; cv=none; b=EMQ6uxR2shUmWs2NWY+YGF7n4VyEnr1vQ/MMu9CLA1cBRDd4c1zSZP8uWPmVQgUha8Aef4SAp8qKuNS5QYMZVdfahFpry7t8DEWdjay4A5B1mnkQKNA+pcbutJRoQKeSbZFtsbOviZa02dAtcLFuD8lcO7TkEEzHMLaP+Du3IXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981710; c=relaxed/simple;
	bh=6DnzgOtXmNQl+/ThzNMZ0cFYZA8gqSx6dqXNTBv7D8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=omt4taz63t0H4CHmHSWO+dE/D3FLgTuW/MPayDFWbRff/6AoK7QbXH1Y1tuHuGK1YBZZL87aZruyUjoFo24lMNlDuRkkZM2uAyxO15Z/NKSJlHj3/CN1xIIKIHrbyWHgCwSozw0ARcRhTGn0Ybp5evd91GZj0v9PZMX681p0geA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from abreu.molgen.mpg.de (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2BD6E4C2C37D59;
	Mon, 17 Aug 2026 17:48:22 +0200 (CEST)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: linux-bluetooth@vger.kernel.org
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH BlueZ] obexd: Reference count the phonebook back-end setup and teardown
Date: Mon, 17 Aug 2026 17:48:10 +0200
Message-ID: <20260817154810.92634-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Stopping obexd on Debian sid/unstable with *bluez* 5.87-1 logs a GObject
critical:

    obexd[10687]: Terminating
    systemd[1804]: Stopping obex.service - Bluetooth OBEX service...
    obexd[10687]: g_object_unref: assertion 'G_IS_OBJECT (object)' failed
    systemd[1804]: Stopped obex.service - Bluetooth OBEX service.

Two builtin plugins use the phonebook back-end: pbap (pbap_init() at
obexd/plugins/pbap.c:962, pbap_exit() at :1002) and irmc (irmc_init() at
obexd/plugins/irmc.c:446, irmc_exit() at :473). Each calls phonebook_init()
when it is loaded and phonebook_exit() when it is unloaded, but neither the
callers nor the back-end track ownership of the singleton they share.
plugin_init() therefore sets the back-end up twice and plugin_cleanup()
tears it down twice. A gdb trace of the shutdown path confirms both pairs
of calls.

The dummy back-end tolerates this by accident: phonebook_init() bails out
early when root_folder is already set, and the second phonebook_exit() only
repeats a g_free()/NULL assignment. The ebook back-end, which Debian builds
(*bluez-obexd* depends on *libebook-1.2* and *libedataserver*), does not.
Its phonebook_init() stores three GObject references in static variables
and phonebook_exit() unconditionally drops all three, so the second
teardown unrefs objects that were already finalized. The registry and the
address book are effectively singletons in evolution-data-server and merely
gain a second reference, but e_book_client_connect_sync() hands back a
fresh client on every call, so the first client leaks and the second one is
unreffed twice – hence a single critical rather than three.

Put the ownership tracking in one place instead of duplicating it in every
back-end: phonebook_init() and phonebook_exit() now live in a new shared
obexd/plugins/phonebook.c and reference count the back-end, so only the
first init and the last exit reach it. The back-end entry points are
renamed to phonebook_driver_init()/phonebook_driver_exit() so that they
cannot be called directly by mistake.

Assisted-by: Claude Code:claude-opus-5
---
 Makefile.obexd                    |  1 +
 obexd/plugins/phonebook-dummy.c   |  4 +--
 obexd/plugins/phonebook-ebook.c   |  4 +--
 obexd/plugins/phonebook-tracker.c |  4 +--
 obexd/plugins/phonebook.c         | 47 +++++++++++++++++++++++++++++++
 obexd/plugins/phonebook.h         | 10 +++++++
 6 files changed, 64 insertions(+), 6 deletions(-)
 create mode 100644 obexd/plugins/phonebook.c

diff --git a/Makefile.obexd b/Makefile.obexd
index 7ad74e1..9daa5aa 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -48,6 +48,7 @@ obexd_builtin_modules += pbap
 obexd_builtin_sources += obexd/plugins/pbap.c \
 				obexd/plugins/vcard.h obexd/plugins/vcard.c \
 				obexd/plugins/phonebook.h \
+				obexd/plugins/phonebook.c \
 				obexd/plugins/phonebook-@PLUGIN_PHONEBOOK@.c
 EXTRA_DIST += obexd/plugins/phonebook-dummy.c obexd/plugins/phonebook-ebook.c \
 				obexd/plugins/phonebook-tracker.c
diff --git a/obexd/plugins/phonebook-dummy.c b/obexd/plugins/phonebook-dummy.c
index 0dce13f..f308ea7 100644
--- a/obexd/plugins/phonebook-dummy.c
+++ b/obexd/plugins/phonebook-dummy.c
@@ -73,7 +73,7 @@ static void query_free(void *user_data)
 	g_free(query);
 }
 
-int phonebook_init(void)
+int phonebook_driver_init(void)
 {
 	if (root_folder)
 		return 0;
@@ -84,7 +84,7 @@ int phonebook_init(void)
 	return 0;
 }
 
-void phonebook_exit(void)
+void phonebook_driver_exit(void)
 {
 	g_free(root_folder);
 	root_folder = NULL;
diff --git a/obexd/plugins/phonebook-ebook.c b/obexd/plugins/phonebook-ebook.c
index 5fc0498..beb72b2 100644
--- a/obexd/plugins/phonebook-ebook.c
+++ b/obexd/plugins/phonebook-ebook.c
@@ -625,7 +625,7 @@ next:
 	return data;
 }
 
-int phonebook_init(void)
+int phonebook_driver_init(void)
 {
 	EClient *client;
 	GError *gerr = NULL;
@@ -662,7 +662,7 @@ int phonebook_init(void)
 	return 0;
 }
 
-void phonebook_exit(void)
+void phonebook_driver_exit(void)
 {
 	g_object_unref(book_client);
 	g_object_unref(address_book);
diff --git a/obexd/plugins/phonebook-tracker.c b/obexd/plugins/phonebook-tracker.c
index eb7a84f..36e73db 100644
--- a/obexd/plugins/phonebook-tracker.c
+++ b/obexd/plugins/phonebook-tracker.c
@@ -1420,14 +1420,14 @@ done:
 	 */
 }
 
-int phonebook_init(void)
+int phonebook_driver_init(void)
 {
 	g_type_init();
 
 	return 0;
 }
 
-void phonebook_exit(void)
+void phonebook_driver_exit(void)
 {
 }
 
diff --git a/obexd/plugins/phonebook.c b/obexd/plugins/phonebook.c
new file mode 100644
index 0000000..6afdb7a
--- /dev/null
+++ b/obexd/plugins/phonebook.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  OBEX Server
+ *
+ *  Copyright (C) 2007-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdint.h>
+
+#include <glib.h>
+
+#include "phonebook.h"
+
+static unsigned int refcount = 0;
+
+int phonebook_init(void)
+{
+	int err;
+
+	if (refcount > 0) {
+		refcount++;
+		return 0;
+	}
+
+	err = phonebook_driver_init();
+	if (err < 0)
+		return err;
+
+	refcount = 1;
+
+	return 0;
+}
+
+void phonebook_exit(void)
+{
+	if (refcount == 0 || --refcount > 0)
+		return;
+
+	phonebook_driver_exit();
+}
diff --git a/obexd/plugins/phonebook.h b/obexd/plugins/phonebook.h
index c73ae73..b878b14 100644
--- a/obexd/plugins/phonebook.h
+++ b/obexd/plugins/phonebook.h
@@ -79,9 +79,19 @@ typedef void (*phonebook_entry_cb) (const char *id, uint32_t handle,
 typedef void (*phonebook_cache_ready_cb) (void *user_data);
 
 
+/*
+ * Set up and tear down the phonebook back-end. The back-end is shared by
+ * the pbap and the irmc plugin, which are loaded and unloaded independently
+ * of each other, so the calls are reference counted: only the first
+ * phonebook_init() and the last phonebook_exit() reach the back-end.
+ */
 int phonebook_init(void);
 void phonebook_exit(void);
 
+/* Implemented by the back-end, only called through the pair above. */
+int phonebook_driver_init(void);
+void phonebook_driver_exit(void);
+
 /*
  * Changes the current folder in the phonebook back-end. The PBAP core
  * doesn't validate or restrict the possible values for the folders,
-- 
2.54.0

