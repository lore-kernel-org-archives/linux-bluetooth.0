Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236AE1EA84
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752071784; cv=none; b=oKxfg7k4pNJxilwVutlYQpkX+sBNckZXrcrLNvh7ql3BUQsSj+UwPmrwX/mGM4DVtNsqm79gttW6geDUwvE/OxL4aXfViKv+n1Rsy/Uh5iu1LO+K9pz0lKegGS5KwnpMk0KGFUDQ5/ZoZGljfdf0m3IC4fHMDPgHTZk5TEkYQqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752071784; c=relaxed/simple;
	bh=JaSZn2TjorEc7bh8A2LyputM55UPzh3gU7NyahYIYqk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jDKy/E/TW4TYz57DlbvcbTLoRZ2CUKyuQRFN8Hv9EMBVklS4FAMZCcTUYliOe+mOZjk3aHupnF3xlKMgEZsVI6oKg+V6pv5v6l6l21G1m6ib3CsExBt2zsbMLRCUoIQgNKyU2Dg/JHwIaubEJHKrsuCiGVb9yQ6Sxa/ROh0X57g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 61C2C4430A
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 14:36:20 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] obexd: Remove --enable-threads option
Date: Wed,  9 Jul 2025 16:36:03 +0200
Message-ID: <20250709143612.2115659-1-hadess@hadess.net>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeekudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeeguedvgedvjeetgffhheeigeehvdetfeejhedvtdejuefhteejieduuddtvdfhueenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: hadess@hadess.net

Threading support is always enabled in dbus since version 1.8 released
in 2014:
• libdbus always behaves as if dbus_threads_init_default() had been called
  (thread-safety by default)
so remove the obsolete option.

Note that we also require glib 2.36, which is newer than the version of
glib with GThread support built-in:
[Since 2.32]
This function is no longer necessary. The GLib threading system is
automatically initialized at the start of your program.
---
 configure.ac       | 8 --------
 obexd/src/main.c   | 7 -------
 obexd/src/plugin.c | 5 -----
 3 files changed, 20 deletions(-)

diff --git a/configure.ac b/configure.ac
index ab2c6716eb3a..52689b4f963a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -83,14 +83,6 @@ AC_CHECK_DECLS([basename], [],
 
 
 PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.36)
-
-if (test "${enable_threads}" = "yes"); then
-	AC_DEFINE(NEED_THREADS, 1, [Define if threading support is required])
-	PKG_CHECK_MODULES(GTHREAD, gthread-2.0 >= 2.16)
-	GLIB_CFLAGS="$GLIB_CFLAGS $GTHREAD_CFLAGS"
-	GLIB_LIBS="$GLIB_LIBS $GTHREAD_LIBS"
-fi
-
 PKG_CHECK_MODULES(DBUS, dbus-1 >= 1.10)
 
 AC_ARG_WITH([dbusconfdir], AS_HELP_STRING([--with-dbusconfdir=DIR],
diff --git a/obexd/src/main.c b/obexd/src/main.c
index 6837f0d735f8..51141046ba8e 100644
--- a/obexd/src/main.c
+++ b/obexd/src/main.c
@@ -285,13 +285,6 @@ int main(int argc, char *argv[])
 
 	signal = setup_signalfd();
 
-#ifdef NEED_THREADS
-	if (dbus_threads_init_default() == FALSE) {
-		fprintf(stderr, "Can't init usage of threads\n");
-		exit(EXIT_FAILURE);
-	}
-#endif
-
 	if (manager_init() == FALSE) {
 		error("manager_init failed");
 		exit(EXIT_FAILURE);
diff --git a/obexd/src/plugin.c b/obexd/src/plugin.c
index 14327782ddd9..15df99b7ee89 100644
--- a/obexd/src/plugin.c
+++ b/obexd/src/plugin.c
@@ -28,12 +28,7 @@
  * will crash on exit. This is a bug inside these libraries, but there is
  * nothing much that can be done about it. One bad example is libebook.
  */
-#ifdef NEED_THREADS
 #define PLUGINFLAG (RTLD_NOW | RTLD_NODELETE)
-#else
-#define PLUGINFLAG (RTLD_NOW)
-#endif
-
 #define IS_ENABLED(x) (x)
 
 static GSList *plugins = NULL;
-- 
2.50.0

