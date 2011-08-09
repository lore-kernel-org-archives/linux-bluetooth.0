Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC obexd 4/8] client: add opp plugin
Date: Tue,  9 Aug 2011 14:03:45 +0300
Message-Id: <1312887829-4770-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1312887829-4770-1-git-send-email-luiz.dentz@gmail.com>
References: <1312887829-4770-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

opp plugin implements object push driver
---
 Makefile.am          |    3 ++
 client/plugins/opp.c |   73 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 0 deletions(-)
 create mode 100644 client/plugins/opp.c

diff --git a/Makefile.am b/Makefile.am
index 5ec987e..89546ce 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -124,6 +124,9 @@ client_builtin_modules =
 client_builtin_sources =
 client_builtin_nodist =
 
+client_builtin_modules += opp
+client_builtin_sources += client/plugins/opp.c
+
 libexec_PROGRAMS += client/obex-client
 
 client_obex_client_SOURCES = $(gdbus_sources) $(client_builtin_sources) \
diff --git a/client/plugins/opp.c b/client/plugins/opp.c
new file mode 100644
index 0000000..da0052f
--- /dev/null
+++ b/client/plugins/opp.c
@@ -0,0 +1,73 @@
+/*
+ *
+ *  OBEX Client
+ *
+ *  Copyright (C) 2007-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include "log.h"
+
+#include "client/session.h"
+#include "client/plugin.h"
+#include "client/driver.h"
+
+#define OPP_UUID "00001105-0000-1000-8000-00805f9b34fb"
+
+static int opp_probe(struct obc_session *session)
+{
+	const char *path = obc_session_get_path(session);
+
+	DBG("%s", path);
+
+	return 0;
+}
+
+static void opp_remove(struct obc_session *session)
+{
+	const char *path = obc_session_get_path(session);
+
+	DBG("%s", path);
+}
+
+static struct obc_driver opp = {
+	.service = "OPP",
+	.uuid = OPP_UUID,
+	.probe = opp_probe,
+	.remove = opp_remove
+};
+
+static int opp_init(void)
+{
+	DBG("");
+
+	return obc_driver_register(&opp);
+}
+
+static void opp_exit(void)
+{
+	DBG("");
+
+	obc_driver_unregister(&opp);
+}
+
+OBC_PLUGIN_DEFINE(opp, opp_init, opp_exit)
-- 
1.7.6

