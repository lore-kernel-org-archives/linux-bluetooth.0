Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] obexd: Fix property Size of server transfer
Date: Wed, 24 Jan 2018 11:09:30 -0200
Message-Id: <20180124130930.1539-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

OBJECT_SIZE_DELETE is shall not be consider a valid size.
---
 obexd/src/manager.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index 78b138c85..70265e445 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -377,7 +377,8 @@ static gboolean transfer_size_exists(const GDBusPropertyTable *property,
 	struct obex_transfer *transfer = data;
 	struct obex_session *session = transfer->session;
 
-	return session->size != OBJECT_SIZE_UNKNOWN;
+	return (session->size != OBJECT_SIZE_UNKNOWN &&
+				session->size != OBJECT_SIZE_DELETE);
 }
 
 static gboolean transfer_get_size(const GDBusPropertyTable *property,
@@ -386,7 +387,8 @@ static gboolean transfer_get_size(const GDBusPropertyTable *property,
 	struct obex_transfer *transfer = data;
 	struct obex_session *session = transfer->session;
 
-	if (session->size == OBJECT_SIZE_UNKNOWN)
+	if (session->size == OBJECT_SIZE_UNKNOWN ||
+				session->size == OBJECT_SIZE_DELETE)
 		return FALSE;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT64, &session->size);
-- 
2.14.3

