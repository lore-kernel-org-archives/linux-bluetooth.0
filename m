Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org,
	Alvaro Silva <alvaro.silva@openbossa.org>
Subject: [PATCH BlueZ v5 10/18] gatt: Register ATT command/event handler
Date: Mon, 27 Jan 2014 17:35:16 -0300
Message-Id: <1390854924-31904-11-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1390854924-31904-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1390845656-29880-1-git-send-email-claudio.takahasi@openbossa.org>
 <1390854924-31904-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alvaro Silva <alvaro.silva@openbossa.org>

This patch registers the ATT channel handler to manage incoming ATT
commands and events.
---
 src/gatt.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 2 deletions(-)

diff --git a/src/gatt.c b/src/gatt.c
index 7a595c6..f5c1df7 100644
--- a/src/gatt.c
+++ b/src/gatt.c
@@ -98,10 +98,85 @@ struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid)
 	return attr;
 }
 
+static int send_error(int sk, uint8_t opcode, uint16_t handle, uint8_t ecode)
+{
+	uint8_t pdu[ATT_DEFAULT_LE_MTU];
+	size_t plen;
+
+	plen = enc_error_resp(opcode, handle, ecode, pdu, sizeof(pdu));
+	return write(sk, pdu, plen);
+}
+
+static bool channel_handler_cb(struct io *io, void *user_data)
+{
+	uint8_t ipdu[ATT_DEFAULT_LE_MTU];
+	ssize_t ilen;
+	int sk = io_get_fd(io);
+
+	ilen = read(sk, ipdu, sizeof(ipdu));
+	if (ilen < 0) {
+		int err = errno;
+		DBG("ATT channel read: %s(%d)", strerror(err), err);
+		return false;
+	}
+
+	switch (ipdu[0]) {
+	case ATT_OP_ERROR:
+		break;
+
+	/* Requests */
+	case ATT_OP_WRITE_CMD:
+	case ATT_OP_WRITE_REQ:
+	case ATT_OP_READ_REQ:
+	case ATT_OP_READ_BY_TYPE_REQ:
+	case ATT_OP_MTU_REQ:
+	case ATT_OP_FIND_INFO_REQ:
+	case ATT_OP_FIND_BY_TYPE_REQ:
+	case ATT_OP_READ_BLOB_REQ:
+	case ATT_OP_READ_MULTI_REQ:
+	case ATT_OP_PREP_WRITE_REQ:
+	case ATT_OP_EXEC_WRITE_REQ:
+	case ATT_OP_READ_BY_GROUP_REQ:
+	case ATT_OP_SIGNED_WRITE_CMD:
+		send_error(sk, ipdu[0], 0x0000, ATT_ECODE_REQ_NOT_SUPP);
+		break;
+
+	/* Responses */
+	case ATT_OP_MTU_RESP:
+	case ATT_OP_FIND_INFO_RESP:
+	case ATT_OP_FIND_BY_TYPE_RESP:
+	case ATT_OP_READ_BY_TYPE_RESP:
+	case ATT_OP_READ_RESP:
+	case ATT_OP_READ_BLOB_RESP:
+	case ATT_OP_READ_MULTI_RESP:
+	case ATT_OP_READ_BY_GROUP_RESP:
+	case ATT_OP_WRITE_RESP:
+	case ATT_OP_PREP_WRITE_RESP:
+	case ATT_OP_EXEC_WRITE_RESP:
+	case ATT_OP_HANDLE_CNF:
+		break;
+
+	/* Notification & Indication */
+	case ATT_OP_HANDLE_NOTIFY:
+	case ATT_OP_HANDLE_IND:
+		break;
+	}
+
+	return true;
+}
+
+static void channel_watch_destroy(void *user_data)
+{
+	struct io *io = user_data;
+
+	io_destroy(io);
+}
+
 static bool unix_accept_cb(struct io *io, void *user_data)
 {
 	struct sockaddr_un uaddr;
 	socklen_t len = sizeof(uaddr);
+	struct io *nio;
 	int err, nsk, sk;
 
 	sk = io_get_fd(io);
@@ -110,12 +185,17 @@ static bool unix_accept_cb(struct io *io, void *user_data)
 	if (nsk < 0) {
 		err = errno;
 		error("ATT UNIX socket accept: %s(%d)", strerror(err), err);
-		return TRUE;
+		return true;
 	}
 
 	DBG("ATT UNIX socket: %d", nsk);
+	nio = io_new(nsk);
+
+	io_set_close_on_destroy(nio, true);
+	io_set_read_handler(nio, channel_handler_cb, nio,
+						channel_watch_destroy);
 
-	return TRUE;
+	return true;
 }
 
 void gatt_init(void)
-- 
1.8.3.1

