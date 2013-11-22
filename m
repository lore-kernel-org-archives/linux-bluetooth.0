Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] fixup add missing break (sjanc review)
Date: Fri, 22 Nov 2013 17:02:31 +0200
Message-Id: <1385132551-20775-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385109295-11445-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385109295-11445-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/socket.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index 70e2307..7b9e41b 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -852,6 +852,9 @@ static void sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
 		sdp_list_foreach(protos, (sdp_list_func_t) sdp_list_free,
 									NULL);
 		sdp_list_free(protos, NULL);
+
+		if (chan)
+			break;
 	}
 
 	if (chan <= 0) {
-- 
1.8.3.2

