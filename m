Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DDE5674E
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jan 2024 17:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="PBDImyul"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=g77bv
	5aMkQxNLvG2YHbIoHLHKIq2v0VwzzR4QCKJCvI=; b=PBDImyulakaBJqAVp44v9
	WHwyWvhqnJatzwFkn6aBRXC9R+mlg6S2nQbAc6z7cgBFgeJVaW26FEuSfWHolUCQ
	qqRcttmvh+2u3CoWSQV9ay+hz1A01m+GpX2U9VMlMvhakW3B1ENI6vL3uoWcVO3u
	ot7nFWEMZMJH/kAY/5oOuw=
Received: from localhost.localdomain (unknown [58.22.7.114])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wDnj6R1IqBlb44yAA--.65429S2;
	Fri, 12 Jan 2024 01:16:37 +0800 (CST)
From: Xiao Yao <xiaokeqinhealth@126.com>
To: linux-bluetooth@vger.kernel.org
Cc: Xiao Yao <xiaoyao@rock-chips.com>
Subject: [PATCH BlueZ v1] avdtp: Fix potential incorrect transaction label
Date: Fri, 12 Jan 2024 01:16:35 +0800
Message-Id: <20240111171635.144825-1-xiaokeqinhealth@126.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnj6R1IqBlb44yAA--.65429S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WrW8XFW3tFy3Jry3ury3Arb_yoW3KF1xpF
	y7Gr97tryxJF18ArWxXr98XrWYyrn3GrW8GryUtanaya17C3Z5t3W0yry0k34DKr9xX3y5
	ur1Ygw4kGw42krDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UMv38UUUUU=
X-CM-SenderInfo: 50ld0yhhtl0xhhdo3xa6rslhhfrp/1tbiEBdi1WVLZXU4jwAAs5

From: Xiao Yao <xiaoyao@rock-chips.com>

Currently, AVDTP commands and responses from remote devices are all
stored in session.in. When one end has an ongoing transaction and
immediately starting another transaction, it may cause the session.
in.transaction to be incorrectly modified, so we need session.in_cmd
and session.in_rsp to be able to handle outstanding requests in each
direction.

After applying this patch, the problem no longer recurs. Apply this
patch to android/avdtp.c and run: unit/test-avdtp
Test Summary
------------
/TP/SIG/SMG/BV-06-C-SEID-1                Passed       0.004 seconds
... ...
/TP/SIG/SYN/BV-06-C                       Passed       0.001 seconds
Total: 62, Passed: 62 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 1.76 seconds

Signed-off-by: Xiao Yao <xiaoyao@rock-chips.com>
---
 profiles/audio/avdtp.c | 103 +++++++++++++++++++++--------------------
 1 file changed, 54 insertions(+), 49 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 10ef380d4..3667e0840 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -286,7 +286,6 @@ struct in_buf {
 	gboolean active;
 	int no_of_packets;
 	uint8_t transaction;
-	uint8_t message_type;
 	uint8_t signal_id;
 	uint8_t buf[1024];
 	uint8_t data_size;
@@ -397,7 +396,8 @@ struct avdtp {
 	uint16_t imtu;
 	uint16_t omtu;
 
-	struct in_buf in;
+	struct in_buf in_resp;
+	struct in_buf in_cmd;
 
 	char *buf;
 
@@ -1462,15 +1462,16 @@ static void setconf_cb(struct avdtp *session, struct avdtp_stream *stream,
 	if (err != NULL) {
 		rej.error = AVDTP_UNSUPPORTED_CONFIGURATION;
 		rej.category = err->err.error_code;
-		avdtp_send(session, session->in.transaction,
-				AVDTP_MSG_TYPE_REJECT, AVDTP_SET_CONFIGURATION,
-				&rej, sizeof(rej));
+		avdtp_send(session, session->in_cmd.transaction,
+			   AVDTP_MSG_TYPE_REJECT, AVDTP_SET_CONFIGURATION,
+			   &rej, sizeof(rej));
 		stream_free(stream);
 		return;
 	}
 
-	if (!avdtp_send(session, session->in.transaction, AVDTP_MSG_TYPE_ACCEPT,
-					AVDTP_SET_CONFIGURATION, NULL, 0)) {
+	if (!avdtp_send(session, session->in_cmd.transaction,
+			AVDTP_MSG_TYPE_ACCEPT,
+			AVDTP_SET_CONFIGURATION, NULL, 0)) {
 		stream_free(stream);
 		return;
 	}
@@ -2092,6 +2093,12 @@ static enum avdtp_parse_result avdtp_parse_data(struct avdtp *session,
 	struct avdtp_start_header *start = (void *) session->buf;
 	void *payload;
 	gsize payload_size;
+	struct in_buf *in;
+
+	if (header->message_type == AVDTP_MSG_TYPE_COMMAND)
+		in = &session->in_cmd;
+	else
+		in = &session->in_resp;
 
 	switch (header->packet_type) {
 	case AVDTP_PKT_TYPE_SINGLE:
@@ -2099,7 +2106,7 @@ static enum avdtp_parse_result avdtp_parse_data(struct avdtp *session,
 			error("Received too small single packet (%zu bytes)", size);
 			return PARSE_ERROR;
 		}
-		if (session->in.active) {
+		if (in->active) {
 			error("SINGLE: Invalid AVDTP packet fragmentation");
 			return PARSE_ERROR;
 		}
@@ -2107,12 +2114,11 @@ static enum avdtp_parse_result avdtp_parse_data(struct avdtp *session,
 		payload = session->buf + sizeof(*single);
 		payload_size = size - sizeof(*single);
 
-		session->in.active = TRUE;
-		session->in.data_size = 0;
-		session->in.no_of_packets = 1;
-		session->in.transaction = header->transaction;
-		session->in.message_type = header->message_type;
-		session->in.signal_id = single->signal_id;
+		in->active = TRUE;
+		in->data_size = 0;
+		in->no_of_packets = 1;
+		in->transaction = header->transaction;
+		in->signal_id = single->signal_id;
 
 		break;
 	case AVDTP_PKT_TYPE_START:
@@ -2120,17 +2126,16 @@ static enum avdtp_parse_result avdtp_parse_data(struct avdtp *session,
 			error("Received too small start packet (%zu bytes)", size);
 			return PARSE_ERROR;
 		}
-		if (session->in.active) {
+		if (in->active) {
 			error("START: Invalid AVDTP packet fragmentation");
 			return PARSE_ERROR;
 		}
 
-		session->in.active = TRUE;
-		session->in.data_size = 0;
-		session->in.transaction = header->transaction;
-		session->in.message_type = header->message_type;
-		session->in.no_of_packets = start->no_of_packets;
-		session->in.signal_id = start->signal_id;
+		in->active = TRUE;
+		in->data_size = 0;
+		in->transaction = header->transaction;
+		in->no_of_packets = start->no_of_packets;
+		in->signal_id = start->signal_id;
 
 		payload = session->buf + sizeof(*start);
 		payload_size = size - sizeof(*start);
@@ -2142,15 +2147,15 @@ static enum avdtp_parse_result avdtp_parse_data(struct avdtp *session,
 									size);
 			return PARSE_ERROR;
 		}
-		if (!session->in.active) {
+		if (!in->active) {
 			error("CONTINUE: Invalid AVDTP packet fragmentation");
 			return PARSE_ERROR;
 		}
-		if (session->in.transaction != header->transaction) {
+		if (in->transaction != header->transaction) {
 			error("Continue transaction id doesn't match");
 			return PARSE_ERROR;
 		}
-		if (session->in.no_of_packets <= 1) {
+		if (in->no_of_packets <= 1) {
 			error("Too few continue packets");
 			return PARSE_ERROR;
 		}
@@ -2164,15 +2169,15 @@ static enum avdtp_parse_result avdtp_parse_data(struct avdtp *session,
 			error("Received too small end packet (%zu bytes)", size);
 			return PARSE_ERROR;
 		}
-		if (!session->in.active) {
+		if (!in->active) {
 			error("END: Invalid AVDTP packet fragmentation");
 			return PARSE_ERROR;
 		}
-		if (session->in.transaction != header->transaction) {
+		if (in->transaction != header->transaction) {
 			error("End transaction id doesn't match");
 			return PARSE_ERROR;
 		}
-		if (session->in.no_of_packets > 1) {
+		if (in->no_of_packets > 1) {
 			error("Got an end packet too early");
 			return PARSE_ERROR;
 		}
@@ -2186,23 +2191,23 @@ static enum avdtp_parse_result avdtp_parse_data(struct avdtp *session,
 		return PARSE_ERROR;
 	}
 
-	if (session->in.data_size + payload_size >
-					sizeof(session->in.buf)) {
+	if (in->data_size + payload_size >
+					sizeof(in->buf)) {
 		error("Not enough incoming buffer space!");
 		return PARSE_ERROR;
 	}
 
-	memcpy(session->in.buf + session->in.data_size, payload, payload_size);
-	session->in.data_size += payload_size;
+	memcpy(in->buf + in->data_size, payload, payload_size);
+	in->data_size += payload_size;
 
-	if (session->in.no_of_packets > 1) {
-		session->in.no_of_packets--;
+	if (in->no_of_packets > 1) {
+		in->no_of_packets--;
 		DBG("Received AVDTP fragment. %d to go",
-						session->in.no_of_packets);
+						in->no_of_packets);
 		return PARSE_FRAGMENT;
 	}
 
-	session->in.active = FALSE;
+	in->active = FALSE;
 
 	return PARSE_SUCCESS;
 }
@@ -2246,11 +2251,11 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 		break;
 	}
 
-	if (session->in.message_type == AVDTP_MSG_TYPE_COMMAND) {
-		if (!avdtp_parse_cmd(session, session->in.transaction,
-					session->in.signal_id,
-					session->in.buf,
-					session->in.data_size)) {
+	if (header->message_type == AVDTP_MSG_TYPE_COMMAND) {
+		if (!avdtp_parse_cmd(session, session->in_cmd.transaction,
+				     session->in_cmd.signal_id,
+				     session->in_cmd.buf,
+				     session->in_cmd.data_size)) {
 			error("Unable to handle command. Disconnecting");
 			goto failed;
 		}
@@ -2273,7 +2278,7 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 		return TRUE;
 	}
 
-	if (session->in.signal_id != session->req->signal_id) {
+	if (session->in_resp.signal_id != session->req->signal_id) {
 		error("Response signal doesn't match");
 		return TRUE;
 	}
@@ -2284,20 +2289,20 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 	switch (header->message_type) {
 	case AVDTP_MSG_TYPE_ACCEPT:
 		if (!avdtp_parse_resp(session, session->req->stream,
-						session->in.transaction,
-						session->in.signal_id,
-						session->in.buf,
-						session->in.data_size)) {
+						session->in_resp.transaction,
+						session->in_resp.signal_id,
+						session->in_resp.buf,
+						session->in_resp.data_size)) {
 			error("Unable to parse accept response");
 			goto failed;
 		}
 		break;
 	case AVDTP_MSG_TYPE_REJECT:
 		if (!avdtp_parse_rej(session, session->req->stream,
-						session->in.transaction,
-						session->in.signal_id,
-						session->in.buf,
-						session->in.data_size)) {
+						session->in_resp.transaction,
+						session->in_resp.signal_id,
+						session->in_resp.buf,
+						session->in_resp.data_size)) {
 			error("Unable to parse reject response");
 			goto failed;
 		}
-- 
2.34.1

