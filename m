Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 2/2] Code cleanup: unnesessary line removed in avdtp.c
Date: Wed,  2 Feb 2011 09:42:18 +0200
Message-Id: <1296632538-2784-2-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1296632538-2784-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1296632538-2784-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/avdtp.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index 88e3e8a..cd57747 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -2666,7 +2666,6 @@ static int send_req(struct avdtp *session, gboolean priority,
 		goto failed;
 	}
 
-
 	session->req = req;
 
 	req->timeout = g_timeout_add_seconds(req->signal_id == AVDTP_ABORT ?
-- 
1.7.0.4

