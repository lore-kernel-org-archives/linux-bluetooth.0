Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 01/35] android/avctp: Make browsing handler return ssize_t
Date: Fri, 25 Apr 2014 11:38:38 +0300
Message-Id: <1398415152-22950-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes possible to return errors such as -EAGAIN to indicate the
request would block and a response will be sent asynchronously.
---
 android/avctp.c | 12 +++++++++---
 android/avctp.h |  2 +-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/android/avctp.c b/android/avctp.c
index 2271d2c..4556ceb 100644
--- a/android/avctp.c
+++ b/android/avctp.c
@@ -839,9 +839,15 @@ static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,
 		goto send;
 	}
 
-	packet_size += handler->cb(session, avctp->transaction,
-						operands, operand_count,
-						handler->user_data);
+	ret = handler->cb(session, avctp->transaction, operands, operand_count,
+							handler->user_data);
+	if (ret < 0) {
+		if (ret == -EAGAIN)
+			return TRUE;
+		goto failed;
+	}
+
+	packet_size += ret;
 
 send:
 	if (packet_size != 0) {
diff --git a/android/avctp.h b/android/avctp.h
index 6bfc4cb..b395188 100644
--- a/android/avctp.h
+++ b/android/avctp.h
@@ -128,7 +128,7 @@ typedef gboolean (*avctp_rsp_cb) (struct avctp *session, uint8_t code,
 typedef gboolean (*avctp_browsing_rsp_cb) (struct avctp *session,
 					uint8_t *operands, size_t operand_count,
 					void *user_data);
-typedef size_t (*avctp_browsing_pdu_cb) (struct avctp *session,
+typedef ssize_t (*avctp_browsing_pdu_cb) (struct avctp *session,
 					uint8_t transaction,
 					uint8_t *operands, size_t operand_count,
 					void *user_data);
-- 
1.9.0

