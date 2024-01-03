Received: from m15.mail.126.com (m15.mail.126.com [45.254.50.224])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBAF1A585
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jan 2024 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="m7FXtEZn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=+Fdj3
	2Pb4r88e6qphAJLFGl8V4UelBU9LghBwyUp7ZQ=; b=m7FXtEZnYX1q78tGBchrA
	ybqMeO4xUXkNrNYgaDGDePjX99EPI0NYO+wOTNuFKNW0/Z6bzI5rTATZnfBIWfzi
	Y81MIuUK9KvDCpB0Cs9Y6pGnGBr5hROlVETBGxqnO2xJEye5lQ4TRtSBjkAVVU1F
	RKeZ/Xv7PdVG4zhhxYXVyM=
Received: from localhost.localdomain (unknown [58.22.7.114])
	by zwqz-smtp-mta-g2-1 (Coremail) with SMTP id _____wD3Hz6McZVlFocNAA--.13600S3;
	Wed, 03 Jan 2024 22:39:10 +0800 (CST)
From: Xiao Yao <xiaokeqinhealth@126.com>
To: linux-bluetooth@vger.kernel.org
Cc: Xiao Yao <xiaokeqinhealth@126.com>
Subject: [PATCH BlueZ v3 2/2] avdtp: Remove unused transaction parameter
Date: Wed,  3 Jan 2024 22:39:04 +0800
Message-Id: <20240103143904.77146-2-xiaokeqinhealth@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103143904.77146-1-xiaokeqinhealth@126.com>
References: <20240103143904.77146-1-xiaokeqinhealth@126.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Hz6McZVlFocNAA--.13600S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrWrtFWkCr4rGw4fAw1DZFb_yoW8tF1fpF
	yrKry8CrZrXF1kZryxXr4DZFWSkrn7J348CrW8KasayFsrCrs0qFykKryjk34DGry8Xr43
	uFyYgas7Gw4jkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR5CzXUUUUU=
X-CM-SenderInfo: 50ld0yhhtl0xhhdo3xa6rslhhfrp/1tbi6BFa1WVLZLvx1QAAsj

This removes unused "transaction" param from avdtp_parse_resq/rej.

Signed-off-by: Xiao Yao <xiaokeqinhealth@126.com>
---
 profiles/audio/avdtp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 386c7f67c..fb49ad45a 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -419,11 +419,11 @@ static int send_request(struct avdtp *session, gboolean priority,
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
@@ -2293,7 +2293,6 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 	switch (header->message_type) {
 	case AVDTP_MSG_TYPE_ACCEPT:
 		if (!avdtp_parse_resp(session, session->req->stream,
-						session->in.transaction,
 						session->in.signal_id,
 						session->in.buf,
 						session->in.data_size)) {
@@ -2303,7 +2302,6 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 		break;
 	case AVDTP_MSG_TYPE_REJECT:
 		if (!avdtp_parse_rej(session, session->req->stream,
-						session->in.transaction,
 						session->in.signal_id,
 						session->in.buf,
 						session->in.data_size)) {
@@ -2941,7 +2939,7 @@ static gboolean avdtp_delay_report_resp(struct avdtp *session,
 
 static gboolean avdtp_parse_resp(struct avdtp *session,
 					struct avdtp_stream *stream,
-					uint8_t transaction, uint8_t signal_id,
+					uint8_t signal_id,
 					void *buf, int size)
 {
 	struct pending_req *next;
@@ -3055,7 +3053,7 @@ static gboolean stream_rej_to_err(struct stream_rej *rej, unsigned int size,
 
 static gboolean avdtp_parse_rej(struct avdtp *session,
 					struct avdtp_stream *stream,
-					uint8_t transaction, uint8_t signal_id,
+					uint8_t signal_id,
 					void *buf, int size)
 {
 	struct avdtp_error err;
-- 
2.34.1

