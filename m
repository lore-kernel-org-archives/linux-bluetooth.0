Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv7 12/14] android/socket: Support listen() with supplied chan number
Date: Fri, 22 Nov 2013 10:34:53 +0200
Message-Id: <1385109295-11445-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385109295-11445-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385109295-11445-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

No profile is assigned in this case. There is a possibility to use
Serial Port Profile.
---
 android/socket.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index 80afba5..dbd2012 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -629,10 +629,13 @@ static int handle_listen(void *buf)
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
 
@@ -667,7 +670,9 @@ static int handle_listen(void *buf)
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

