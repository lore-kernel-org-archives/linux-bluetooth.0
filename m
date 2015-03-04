Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] android: Remove unused field
Date: Wed,  4 Mar 2015 15:46:49 +0200
Message-Id: <1425476811-25651-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

struct avdtp_server is no longer needed.
---
 android/avdtp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/android/avdtp.c b/android/avdtp.c
index b8a2147..3e32e57 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -376,8 +376,6 @@ struct avdtp {
 
 	uint16_t version;
 
-	struct avdtp_server *server;
-
 	guint auth_id;
 
 	GIOChannel *io;
-- 
2.1.0

