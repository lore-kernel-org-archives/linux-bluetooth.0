Return-Path: <cyrus@holtmann.org>
From: Chethan T N <chethan.tn@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Chethan T N <chethan.tn@samsung.com>
Subject: [PATCH] audio: Increased AVDTP request timeout
Date: Wed, 28 Dec 2011 12:38:39 +0530
Message-id: <1325056119-15172-1-git-send-email-chethan.tn@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Original patch by Chan-yeol Park <chanyeol.park@samsung.com>

While the streaming is in progress, the remote headset is capable
of buffering audio packets. When it buffered the more audio
packets, we are sending the SUSPEND command before initiating
sco connection. Some headset is able to process the SUSPEND
command only after processing the buffered audio packets, hence
the delay in the response. So in this case, increasing the
REQ_TIMEOUT from 6 to 10 will solve the issue.
---
 audio/avdtp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index d3568ba..474c446 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -89,7 +89,7 @@
 #define AVDTP_MSG_TYPE_ACCEPT			0x02
 #define AVDTP_MSG_TYPE_REJECT			0x03
 
-#define REQ_TIMEOUT 6
+#define REQ_TIMEOUT 10
 #define ABORT_TIMEOUT 2
 #define DISCONNECT_TIMEOUT 1
 #define STREAM_TIMEOUT 20
-- 
1.7.5.4

