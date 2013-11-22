Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/6] android/socket: Check that create_record function exist
Date: Fri, 22 Nov 2013 17:49:31 +0200
Message-Id: <1385135376-21057-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/socket.c b/android/socket.c
index daf4370..4f6f02b 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -673,7 +673,7 @@ static int handle_listen(void *buf)
 		return -1;
 	}
 
-	if (profile)
+	if (profile && profile->create_record)
 		rfsock->service_handle = sdp_service_register(profile,
 								cmd->name);
 
-- 
1.8.3.2

