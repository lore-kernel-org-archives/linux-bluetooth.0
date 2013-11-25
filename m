Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv9 12/21] android/socket: Support listen() with supplied chan number
Date: Mon, 25 Nov 2013 15:08:48 +0200
Message-Id: <1385384937-29858-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385384937-29858-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385384937-29858-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

No profile is assigned in this case. There is a possibility to use
Serial Port Profile.
---
 android/socket.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index a8f9a6b..9ed8ea6 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -647,10 +647,13 @@ static int handle_listen(void *buf)
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
 
-- 
1.8.3.2

