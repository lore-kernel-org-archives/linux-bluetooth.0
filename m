Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 32/33] broadcaster: Update some data of already broadcast value
Date: Mon, 27 Aug 2012 13:03:24 -0400
Message-Id: <1346087005-24693-33-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
References: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To update a data set previously, it is need to use same identifier
Service UUID or Company Identifier Code in SetServiceData() and
SetManufacturerData(), respectively.
---
 src/adapter.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index bbf6b06..84535cd 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2009,6 +2009,10 @@ static void bcast_session_exit(DBusConnection *conn, void *user_data)
 static void update_adv_data(struct btd_adapter *adapter,
 		struct bcast_session *session, uint8_t *data, int size)
 {
+	session->data_len = size;
+	memcpy(session->data, data, size);
+
+	restore_bcast_type(adapter, session->data_type);
 }
 
 static DBusMessage *set_service_data(DBusConnection *conn,
-- 
1.7.9.5

