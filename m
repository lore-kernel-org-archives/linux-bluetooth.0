Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 09/20] audio/avdtp: Add AVDTP_STATE_OPEN to allowed state
Date: Fri, 27 Feb 2015 17:02:57 +0200
Message-Id: <1425049388-18333-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1425049388-18333-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1425049388-18333-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

In delay report handling add AVDTP_STATE_OPEN to good states.
---
 profiles/audio/avdtp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index e409d38..434ebc7 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1944,10 +1944,17 @@ static gboolean avdtp_delayreport_cmd(struct avdtp *session,
 
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

