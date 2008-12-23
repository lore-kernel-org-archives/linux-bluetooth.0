Return-Path: <cyrus@holtmann.org>
Message-ID: <ac8af0be0812221733j262e8077re27476f18772079e@mail.gmail.com>
Date: Tue, 23 Dec 2008 09:33:51 +0800
From: "Zhao Forrest" <forrest.zhao@gmail.com>
To: "Johan Hedberg" <johan.hedberg@nokia.com>,
	"Marcel Holtmann" <marcel@holtmann.org>
Subject: [patch] fix the bug of obex_object_resume(), obex_server() in openobex
Cc: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

When developing the PBAP server in obexd we found that
obex_object_resume() can't work as expected. After debugging openobex
we post this patch to fix the bug. We did the internal test with PBAP
server/client. The below patch fixes the bug in obex_object_resume()
and obex_server().

Thanks,
Forrest

diff --git a/lib/obex_object.c b/lib/obex_object.c
index 482e6a7..0af0108 100644
--- a/lib/obex_object.c
+++ b/lib/obex_object.c
@@ -908,24 +908,38 @@ int obex_object_suspend(obex_object_t *object)

 int obex_object_resume(obex_t *self, obex_object_t *object)
 {
+	int ret;
+
 	if (!object->suspend)
 		return 0;

 	object->suspend = 0;

-	if (object->first_packet_sent && !object->continue_received)
+ 	if (object->first_packet_sent && !object->continue_received)
 		return 0;

-	if (obex_object_send(self, object, TRUE, FALSE) < 0) {
-		obex_deliver_event(self, OBEX_EV_LINKERR, object->opcode, 0, TRUE);
+	ret = obex_object_send(self, object, TRUE, FALSE);
+
+	if (ret < 0) {
+		obex_deliver_event(self, OBEX_EV_LINKERR, object->opcode &
~OBEX_FINAL, 0, TRUE);
 		return -1;
-	}
+	} else if (ret == 0){

-	obex_deliver_event(self, OBEX_EV_PROGRESS, object->opcode, 0, FALSE);
+		obex_deliver_event(self, OBEX_EV_PROGRESS, object->opcode &
~OBEX_FINAL, 0, FALSE);
+		object->first_packet_sent = 1;
+		object->continue_received = 0;
+	} else {
+		if (self->state & MODE_SRV) {
+			obex_deliver_event(self, OBEX_EV_REQDONE, object->opcode &
~OBEX_FINAL, 0, TRUE);
+			self->state = MODE_SRV | STATE_IDLE;
+			return 0;
+		}
+	}

-	self->state = MODE_CLI | STATE_REC;
-	object->first_packet_sent = 1;
-	object->continue_received = 0;
+	if (self->state & MODE_SRV)
+		self->state = MODE_SRV | STATE_REC;
+	else
+		self->state = MODE_CLI | STATE_REC;

 	return 0;
 }
diff --git a/lib/obex_server.c b/lib/obex_server.c
index f27c8ee..cf19529 100644
--- a/lib/obex_server.c
+++ b/lib/obex_server.c
@@ -159,7 +159,7 @@ int obex_server(obex_t *self, buf_t *msg, int final)
 			} else
 				obex_deliver_event(self, OBEX_EV_PROGRESS, cmd, 0, FALSE);
 			break; /* Stay in this state if not final */
-		} else {
+		} else if (!self->object->first_packet_sent) {
 			DEBUG(4, "We got a request!\n");
 			/* More connect-magic woodoo stuff */
 			if (cmd == OBEX_CMD_CONNECT)
@@ -234,10 +234,17 @@ int obex_server(obex_t *self, buf_t *msg, int final)
 		 * See Obex spec v1.2, chapter 3.2, page 21 and 22.
 		 * See also example on chapter 7.3, page 47.
 		 * So, force the final bit here. - Jean II */
+		self->object->continue_received = 1;
+
+		if (self->object->suspend)
+			break;
+
 		ret = obex_object_send(self, self->object, TRUE, TRUE);
 		if (ret == 0) {
 			/* Made some progress */
 			obex_deliver_event(self, OBEX_EV_PROGRESS, cmd, 0, FALSE);
+			self->object->first_packet_sent = 1;
+			self->object->continue_received = 0;
 		} else if (ret < 0) {
 			/* Error sending response */
 			obex_deliver_event(self, OBEX_EV_LINKERR, cmd, 0, TRUE);
