Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 6/6] avdtp: Remove not needed forward declaration
Date: Thu, 10 Oct 2013 10:53:41 +0200
Message-ID: <1381395221-5067-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1381395221-5067-1-git-send-email-szymon.janc@tieto.com>
References: <1381395221-5067-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

auth_cb function is not used before definition so no need to forward
declare it.
---
 profiles/audio/avdtp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index e5d4139..5b8d7b1 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -442,7 +442,6 @@ static int process_queue(struct avdtp *session);
 static void avdtp_sep_set_state(struct avdtp *session,
 				struct avdtp_local_sep *sep,
 				avdtp_state_t state);
-static void auth_cb(DBusError *derr, void *user_data);
 
 static struct avdtp_server *find_server(GSList *list, struct btd_adapter *a)
 {
-- 
1.8.4

