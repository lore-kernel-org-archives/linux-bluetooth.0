Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/35] android/avctp: Add proper checks for invalid browsing PDUs
Date: Fri, 25 Apr 2014 11:38:40 +0300
Message-Id: <1398415152-22950-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avctp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/android/avctp.c b/android/avctp.c
index 4556ceb..94f84ad 100644
--- a/android/avctp.c
+++ b/android/avctp.c
@@ -814,10 +814,17 @@ static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,
 	if (ret <= 0)
 		goto failed;
 
+	if (ret < AVCTP_HEADER_LENGTH) {
+		error("Too small AVCTP packet");
+		goto failed;
+	}
+
 	avctp = (struct avctp_header *) buf;
 
-	if (avctp->packet_type != AVCTP_PACKET_SINGLE)
+	if (avctp->packet_type != AVCTP_PACKET_SINGLE) {
+		error("Invalid packet type");
 		goto failed;
+	}
 
 	operands = buf + AVCTP_HEADER_LENGTH;
 	ret -= AVCTP_HEADER_LENGTH;
-- 
1.9.0

