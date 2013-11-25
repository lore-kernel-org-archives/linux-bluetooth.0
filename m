Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv8 12/15] android/socket: Support listen() with supplied chan number
Date: Mon, 25 Nov 2013 11:44:55 +0200
Message-Id: <1385372698-16212-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385372698-16212-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385372698-16212-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

No profile is assigned in this case. There is a possibility to use
Serial Port Profile.
---
 android/socket.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index ca5ea2f..5f89f2c 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -644,10 +644,13 @@ static int handle_listen(void *buf)
 	DBG("");
 
 	profile = get_profile_by_uuid(cmd->uuid);
-	if (!profile)
-		return -1;
-
-	chan = profile->channel;
+	if (!profile) {
+		if (!cmd->channel)
+			return -1;
+		else
+			chan = cmd->channel;
+	} else
+		chan = profile->channel;
 
 	DBG("rfcomm channel %d svc_name %s", chan, cmd->name);
 
@@ -682,7 +685,9 @@ static int handle_listen(void *buf)
 		return -1;
 	}
 
-	rfsock->service_handle = sdp_service_register(profile, cmd->name);
+	if (profile)
+		rfsock->service_handle = sdp_service_register(profile,
+								cmd->name);
 
 	return hal_fd;
 }
-- 
1.8.3.2

