Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 07/14] obexd: Remove unused local variables
Date: Fri, 4 Oct 2013 11:05:31 +0200
Message-ID: <1380877538-22614-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1380877538-22614-1-git-send-email-szymon.janc@tieto.com>
References: <1380877538-22614-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix following build errors:

obexd/src/manager.c: In function ‘get_root’:
obexd/src/manager.c:253:23: error: unused variable ‘os’
    [-Werror=unused-variable]

obexd/src/manager.c: In function ‘manager_emit_transfer_started’:
obexd/src/manager.c:534:22: error: unused variable ‘id’
    [-Werror=unused-variable]

obexd/src/manager.c: In function ‘manager_request_authorization’:
obexd/src/manager.c:684:14: error: unused variable ‘type’
    [-Werror=unused-variable]
obexd/src/manager.c:683:14: error: unused variable ‘filename’
    [-Werror=unused-variable]
---
 obexd/src/manager.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index a67838c..00f3537 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -250,7 +250,6 @@ static gboolean get_target(const GDBusPropertyTable *property,
 static gboolean get_root(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
-	struct obex_session *os = data;
 	const char *root;
 
 	root = obex_option_root_folder();
@@ -531,8 +530,6 @@ void manager_cleanup(void)
 
 void manager_emit_transfer_started(struct obex_transfer *transfer)
 {
-	static unsigned int id = 0;
-
 	transfer->status = TRANSFER_STATUS_ACTIVE;
 
 	g_dbus_emit_property_changed(connection, transfer->path,
@@ -680,8 +677,6 @@ int manager_request_authorization(struct obex_transfer *transfer, int32_t time,
 	struct obex_session *os = transfer->session;
 	DBusMessage *msg;
 	DBusPendingCall *call;
-	const char *filename = os->name ? os->name : "";
-	const char *type = os->type ? os->type : "";
 	unsigned int watch;
 	gboolean got_reply;
 
-- 
1.8.4

