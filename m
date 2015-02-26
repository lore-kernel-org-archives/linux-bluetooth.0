Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] audio/avdtp: Add AVDTP_STATE_OPEN to allowed state
Date: Thu, 26 Feb 2015 17:20:21 +0200
Message-Id: <1424964022-8887-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1424964022-8887-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1424964022-8887-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

In delay report handling add AVDTP_STATE_OPEN to good states.
---
 profiles/audio/avdtp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 3c4e9b1..1cad010 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1948,10 +1948,17 @@ static gboolean avdtp_delayreport_cmd(struct avdtp *session,
 
 	stream = sep->stream;
 
-	if (sep->state != AVDTP_STATE_CONFIGURED &&
-					sep->state != AVDTP_STATE_STREAMING) {
+	switch (sep->state) {
+	case AVDTP_STATE_IDLE:
+	case AVDTP_STATE_ABORTING:
+	case AVDTP_STATE_CLOSING:
 		err = AVDTP_BAD_STATE;
 		goto failed;
+	case AVDTP_STATE_CONFIGURED:
+	case AVDTP_STATE_OPEN:
+	case AVDTP_STATE_STREAMING:
+	default:
+		break;
 	}
 
 	stream->delay = ntohs(req->delay);
-- 
2.1.0

