Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/avctp: Trivial cleanup code
Date: Mon, 27 Jan 2014 18:01:44 +0200
Message-Id: <1390838504-25456-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1390838504-25456-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1390838504-25456-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Avoid extra header calculation and fix wrong line indentation.
---
 android/avctp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/android/avctp.c b/android/avctp.c
index 615fecf..6f9b33b 100644
--- a/android/avctp.c
+++ b/android/avctp.c
@@ -798,8 +798,7 @@ failed:
 	return FALSE;
 }
 
-static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
-				gpointer data)
+static gboolean session_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
 {
 	struct avctp *session = data;
 	struct avctp_channel *control = session->control;
@@ -836,7 +835,7 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 
 	ret -= sizeof(struct avc_header);
 
-	operands = buf + sizeof(struct avctp_header) + sizeof(struct avc_header);
+	operands = (uint8_t *) avc + sizeof(struct avc_header);
 	operand_count = ret;
 
 	if (avctp->cr == AVCTP_RESPONSE) {
-- 
1.8.3.2

