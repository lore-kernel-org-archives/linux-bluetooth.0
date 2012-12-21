Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH BlueZ 24/25] broadcaster: Update some data of already broadcast value
Date: Fri, 21 Dec 2012 16:26:51 -0400
Message-Id: <1356121612-15172-25-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
References: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To update previously set data, it is necessary to use same Service UUID
or Company Identifier Code in SetServiceData() and
SetManufacturerData().
---
 src/adapter.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 9c99070..96badfd 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1570,6 +1570,10 @@ static void bcast_session_exit(DBusConnection *conn, void *user_data)
 static void update_adv_data(struct btd_adapter *adapter,
 		struct bcast_session *session, uint8_t *data, int size)
 {
+	session->data_len = size;
+	memcpy(session->data, data, size);
+
+	restore_bcast_type(adapter, session->data_type);
 }
 
 void adapter_set_controller_data_failed(struct btd_adapter *adapter)
-- 
1.7.9.5

