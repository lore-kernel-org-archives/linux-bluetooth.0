Return-Path: <cyrus@holtmann.org>
From: Rafal Garbat <rafal.garbat@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <rafal.garbat@tieto.com>
Subject: [PATCH] Bluetooth: Finalize discovery after discover message was rejected.
Date: Fri, 9 Mar 2012 18:27:35 +0100
Message-ID: <1331314055-18669-1-git-send-email-rafal.garbat@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Finalize discovery and disconnect l2cap after discover
message was rejected.
---
 audio/avdtp.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index cd66fd4..64e5800 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -3064,6 +3064,12 @@ static gboolean avdtp_parse_rej(struct avdtp *session,
 			return FALSE;
 		error("DISCOVER request rejected: %s (%d)",
 				avdtp_strerror(&err), err.err.error_code);
+		if (session->discov_cb) {
+			session->discov_cb(session, session->seps,
+						&err, session->user_data);
+			session->discov_cb = NULL;
+			session->used_data = NULL;
+		}
 		return TRUE;
 	case AVDTP_GET_CAPABILITIES:
 	case AVDTP_GET_ALL_CAPABILITIES:
-- 
on behalf of ST-Ericsson

