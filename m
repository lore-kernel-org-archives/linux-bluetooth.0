Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] audio/avdtp: Fix calling abort confirmation
Date: Fri, 20 Jan 2017 15:43:30 +0200
Message-Id: <20170120134331.25438-2-luiz.dentz@gmail.com>
In-Reply-To: <20170120134331.25438-1-luiz.dentz@gmail.com>
References: <20170120134331.25438-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Abort confirmation shall only be called in case an abort has been sent
and the setup has to be unref asynchronously.
---
 profiles/audio/avdtp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 4ec9cca..4a21e03 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -2442,10 +2442,9 @@ static int cancel_request(struct avdtp *session, int err)
 	else
 		stream = NULL;
 
-	if (stream) {
-		stream->abort_int = TRUE;
+	if (stream)
 		lsep = stream->lsep;
-	} else
+	else
 		lsep = NULL;
 
 	switch (req->signal_id) {
@@ -2515,6 +2514,8 @@ static int cancel_request(struct avdtp *session, int err)
 		goto failed;
 	}
 
+	stream->abort_int = TRUE;
+
 	goto done;
 
 failed:
-- 
2.9.3

