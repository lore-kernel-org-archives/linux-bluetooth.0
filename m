Received: from m15.mail.126.com (m15.mail.126.com [45.254.50.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2866725578
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jan 2024 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="X2kDi058"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=vTYyO
	bde6xXWQWYYb+DFaejmQLgBLQDiWCwvb6Eu7kw=; b=X2kDi058TCAC2Luj2g52t
	Q4OABhScmfC0YB+0SU1iIpXvfH3jSIvJLyXC5NauYYDzGghmAhKSGLR+t7zZR8up
	3nWGQXuEzZpY0IfateWFRQr5QIka0JzKCwfZRkZ1GtoCYuj2FPsJfBmyQ4GPB0Is
	N7ht8xHUbiScs7jHR/zw5s=
Received: from localhost.localdomain (unknown [58.22.7.114])
	by zwqz-smtp-mta-g2-0 (Coremail) with SMTP id _____wDnrx1F55ZlcYNmAA--.59396S2;
	Fri, 05 Jan 2024 01:13:42 +0800 (CST)
From: Xiao Yao <xiaokeqinhealth@126.com>
To: linux-bluetooth@vger.kernel.org
Cc: Xiao Yao <xiaoyao@rock-chips.com>
Subject: [PATCH BlueZ v1] avdtp: Remove unused transaction parameter
Date: Fri,  5 Jan 2024 01:13:38 +0800
Message-Id: <20240104171338.124096-1-xiaokeqinhealth@126.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnrx1F55ZlcYNmAA--.59396S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar4UXw18Jw1UKrW7Ar45trb_yoW8tw15pF
	yfKry8Crs7XF1vvryxXr4DZrWSkrn7J340krW8K3Z0yFsrCrs0qFykKry0k34DGrykXr43
	uFyYqas7Gw4jkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U3DGrUUUUU=
X-CM-SenderInfo: 50ld0yhhtl0xhhdo3xa6rslhhfrp/1tbi6Bpb1WVLZNVi8AABsw

From: Xiao Yao <xiaoyao@rock-chips.com>

This removes unused "transaction" param from avdtp_parse_resq/rej.

Signed-off-by: Xiao Yao <xiaoyao@rock-chips.com>
---
 profiles/audio/avdtp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 10ef380d4..296439c43 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -418,11 +418,11 @@ static int send_request(struct avdtp *session, gboolean priority,
 			void *buffer, size_t size);
 static gboolean avdtp_parse_resp(struct avdtp *session,
 					struct avdtp_stream *stream,
-					uint8_t transaction, uint8_t signal_id,
+					uint8_t signal_id,
 					void *buf, int size);
 static gboolean avdtp_parse_rej(struct avdtp *session,
 					struct avdtp_stream *stream,
-					uint8_t transaction, uint8_t signal_id,
+					uint8_t signal_id,
 					void *buf, int size);
 static int process_queue(struct avdtp *session);
 static void avdtp_sep_set_state(struct avdtp *session,
@@ -2284,7 +2284,6 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 	switch (header->message_type) {
 	case AVDTP_MSG_TYPE_ACCEPT:
 		if (!avdtp_parse_resp(session, session->req->stream,
-						session->in.transaction,
 						session->in.signal_id,
 						session->in.buf,
 						session->in.data_size)) {
@@ -2294,7 +2293,6 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 		break;
 	case AVDTP_MSG_TYPE_REJECT:
 		if (!avdtp_parse_rej(session, session->req->stream,
-						session->in.transaction,
 						session->in.signal_id,
 						session->in.buf,
 						session->in.data_size)) {
@@ -2932,7 +2930,7 @@ static gboolean avdtp_delay_report_resp(struct avdtp *session,
 
 static gboolean avdtp_parse_resp(struct avdtp *session,
 					struct avdtp_stream *stream,
-					uint8_t transaction, uint8_t signal_id,
+					uint8_t signal_id,
 					void *buf, int size)
 {
 	struct pending_req *next;
@@ -3046,7 +3044,7 @@ static gboolean stream_rej_to_err(struct stream_rej *rej, unsigned int size,
 
 static gboolean avdtp_parse_rej(struct avdtp *session,
 					struct avdtp_stream *stream,
-					uint8_t transaction, uint8_t signal_id,
+					uint8_t signal_id,
 					void *buf, int size)
 {
 	struct avdtp_error err;
-- 
2.34.1

