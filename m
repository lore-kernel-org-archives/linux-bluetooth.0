Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 1/7] android/socket: Check that create_record function exist
Date: Mon, 25 Nov 2013 13:22:51 +0200
Message-Id: <1385378577-20503-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385378577-20503-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385378577-20503-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/socket.c b/android/socket.c
index 22472b9..63587ee 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -688,7 +688,7 @@ static int handle_listen(void *buf)
 		return -1;
 	}
 
-	if (profile)
+	if (profile && profile->create_record)
 		rfsock->service_handle = sdp_service_register(profile,
 								cmd->name);
 
-- 
1.8.3.2

