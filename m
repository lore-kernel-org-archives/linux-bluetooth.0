Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/9] AVCTP: Allocate memory to hold incoming/outgoing PDUs
Date: Fri,  5 Oct 2012 23:20:46 +0200
Message-Id: <1349472050-25928-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1349472050-25928-1-git-send-email-luiz.dentz@gmail.com>
References: <1349472050-25928-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes possible to the handler to respond asyncronous as the memory
remains valid after it returns.

In addition to that it uses the MTU to calculate the buffer size
necessary.
---
 audio/avctp.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index 092a5e2..aa9a1ca 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -134,7 +134,9 @@ struct avctp_rsp_handler {
 struct avctp_channel {
 	GIOChannel *io;
 	guint watch;
-	uint16_t mtu;
+	uint16_t imtu;
+	uint16_t omtu;
+	uint8_t *buffer;
 };
 
 struct avctp {
@@ -343,6 +345,7 @@ static void avctp_channel_destroy(struct avctp_channel *chan)
 	if (chan->watch)
 		g_source_remove(chan->watch);
 
+	g_free(chan->buffer);
 	g_free(chan);
 }
 
@@ -446,7 +449,9 @@ static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,
 				gpointer data)
 {
 	struct avctp *session = data;
-	uint8_t buf[1024], *operands;
+	struct avctp_channel *browsing = session->browsing;
+	uint8_t *buf = browsing->buffer;
+	uint8_t *operands;
 	struct avctp_header *avctp;
 	int sock, ret, packet_size, operand_count;
 
@@ -455,7 +460,7 @@ static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,
 
 	sock = g_io_channel_unix_get_fd(chan);
 
-	ret = read(sock, buf, sizeof(buf));
+	ret = read(sock, buf, sizeof(browsing->imtu));
 	if (ret <= 0)
 		goto failed;
 
@@ -496,7 +501,9 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 				gpointer data)
 {
 	struct avctp *session = data;
-	uint8_t buf[1024], *operands, code, subunit;
+	struct avctp_channel *control = session->control;
+	uint8_t *buf = control->buffer;
+	uint8_t *operands, code, subunit;
 	struct avctp_header *avctp;
 	struct avc_header *avc;
 	int ret, packet_size, operand_count, sock;
@@ -507,7 +514,7 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 
 	sock = g_io_channel_unix_get_fd(chan);
 
-	ret = read(sock, buf, sizeof(buf));
+	ret = read(sock, buf, control->imtu);
 	if (ret <= 0)
 		goto failed;
 
@@ -688,7 +695,7 @@ static void avctp_connect_browsing_cb(GIOChannel *chan, GError *err,
 {
 	struct avctp *session = data;
 	char address[18];
-	uint16_t imtu;
+	uint16_t imtu, omtu;
 	GError *gerr = NULL;
 
 	if (err) {
@@ -699,6 +706,7 @@ static void avctp_connect_browsing_cb(GIOChannel *chan, GError *err,
 	bt_io_get(chan, &gerr,
 			BT_IO_OPT_DEST, &address,
 			BT_IO_OPT_IMTU, &imtu,
+			BT_IO_OPT_OMTU, &omtu,
 			BT_IO_OPT_INVALID);
 	if (gerr) {
 		error("%s", gerr->message);
@@ -713,7 +721,9 @@ static void avctp_connect_browsing_cb(GIOChannel *chan, GError *err,
 	if (session->browsing == NULL)
 		session->browsing = avctp_channel_create(chan);
 
-	session->browsing->mtu = imtu;
+	session->browsing->imtu = imtu;
+	session->browsing->omtu = omtu;
+	session->browsing->buffer = g_malloc0(MAX(imtu, omtu));
 	session->browsing->watch = g_io_add_watch(session->browsing->io,
 				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 				(GIOFunc) session_browsing_cb, session);
@@ -731,7 +741,7 @@ static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
 {
 	struct avctp *session = data;
 	char address[18];
-	uint16_t imtu;
+	uint16_t imtu, omtu;
 	GError *gerr = NULL;
 
 	if (err) {
@@ -743,6 +753,7 @@ static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
 	bt_io_get(chan, &gerr,
 			BT_IO_OPT_DEST, &address,
 			BT_IO_OPT_IMTU, &imtu,
+			BT_IO_OPT_IMTU, &omtu,
 			BT_IO_OPT_INVALID);
 	if (gerr) {
 		avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
@@ -756,7 +767,9 @@ static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
 	if (session->control == NULL)
 		session->control = avctp_channel_create(chan);
 
-	session->control->mtu = imtu;
+	session->control->imtu = imtu;
+	session->control->omtu = omtu;
+	session->control->buffer = g_malloc0(MAX(imtu, omtu));
 	session->control->watch = g_io_add_watch(session->control->io,
 				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 				(GIOFunc) session_cb, session);
-- 
1.7.11.4

