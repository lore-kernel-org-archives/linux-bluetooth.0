Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC obexd 8/8] Add Makefile.client to handle client code build
Date: Tue,  9 Aug 2011 14:03:49 +0300
Message-Id: <1312887829-4770-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1312887829-4770-1-git-send-email-luiz.dentz@gmail.com>
References: <1312887829-4770-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 Makefile.am     |   48 +-----------------------------------------------
 Makefile.client |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 47 deletions(-)
 create mode 100644 Makefile.client

diff --git a/Makefile.am b/Makefile.am
index 151865c..1b3b196 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -117,53 +117,7 @@ src/builtin.h: src/genbuiltin $(builtin_sources)
 
 endif
 
-if CLIENT
-service_in_files += client/obex-client.service.in
-
-client_builtin_modules =
-client_builtin_sources =
-client_builtin_nodist =
-
-client_builtin_modules += opp
-client_builtin_sources += client/plugins/opp.c
-
-client_builtin_modules += ftp
-client_builtin_sources += client/plugins/ftp.c
-
-client_builtin_modules += pbap
-client_builtin_sources += client/plugins/pbap.c
-
-client_builtin_modules += sync
-client_builtin_sources += client/plugins/sync.c
-
-libexec_PROGRAMS += client/obex-client
-
-client_obex_client_SOURCES = $(gdbus_sources) $(client_builtin_sources) \
-				$(gwobex_sources) $(btio_sources) \
-				client/main.c src/log.h src/log.c \
-				client/manager.h client/manager.c \
-				client/session.h client/session.c \
-				client/transfer.h client/transfer.c \
-				client/agent.h client/agent.c \
-				client/plugin.h client/plugin.c \
-				client/driver.h client/driver.c
-
-client_obex_client_LDADD = @GLIB_LIBS@ @DBUS_LIBS@ @OPENOBEX_LIBS@ @BLUEZ_LIBS@ -ldl
-
-client_obex_client_LDFLAGS = -Wl,--export-dynamic
-
-client_builtin_files = client/builtin.h $(client_builtin_nodist)
-
-nodist_client_obex_client_SOURCES = $(client_builtin_files)
-
-clientplugindir = $(libdir)/obex/client/plugins
-
-client/plugin.$(OBJEXT): client/builtin.h
-
-client/builtin.h: client/genbuiltin $(client_builtin_sources)
-	$(AM_V_GEN)$(srcdir)/client/genbuiltin $(client_builtin_modules) > $@
-
-endif
+include Makefile.client
 
 service_DATA = $(service_in_files:.service.in=.service)
 
diff --git a/Makefile.client b/Makefile.client
new file mode 100644
index 0000000..7e7c247
--- /dev/null
+++ b/Makefile.client
@@ -0,0 +1,47 @@
+if CLIENT
+service_in_files += client/obex-client.service.in
+
+client_builtin_modules =
+client_builtin_sources =
+client_builtin_nodist =
+
+client_builtin_modules += opp
+client_builtin_sources += client/plugins/opp.c
+
+client_builtin_modules += ftp
+client_builtin_sources += client/plugins/ftp.c
+
+client_builtin_modules += pbap
+client_builtin_sources += client/plugins/pbap.c
+
+client_builtin_modules += sync
+client_builtin_sources += client/plugins/sync.c
+
+libexec_PROGRAMS += client/obex-client
+
+client_obex_client_SOURCES = $(gdbus_sources) $(client_builtin_sources) \
+				$(gwobex_sources) $(btio_sources) \
+				client/main.c src/log.h src/log.c \
+				client/manager.h client/manager.c \
+				client/session.h client/session.c \
+				client/transfer.h client/transfer.c \
+				client/agent.h client/agent.c \
+				client/plugin.h client/plugin.c \
+				client/driver.h client/driver.c
+
+client_obex_client_LDADD = @GLIB_LIBS@ @DBUS_LIBS@ @OPENOBEX_LIBS@ @BLUEZ_LIBS@ -ldl
+
+client_obex_client_LDFLAGS = -Wl,--export-dynamic
+
+client_builtin_files = client/builtin.h $(client_builtin_nodist)
+
+nodist_client_obex_client_SOURCES = $(client_builtin_files)
+
+clientplugindir = $(libdir)/obex/client/plugins
+
+client/plugin.$(OBJEXT): client/builtin.h
+
+client/builtin.h: client/genbuiltin $(client_builtin_sources)
+	$(AM_V_GEN)$(srcdir)/client/genbuiltin $(client_builtin_modules) > $@
+
+endif
-- 
1.7.6

