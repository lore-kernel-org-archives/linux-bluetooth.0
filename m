Return-Path: <cyrus@holtmann.org>
From: Denis Kenzior <denkenz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/3] doc: Remove Profile1.Cancel() method
Date: Tue, 10 Sep 2013 11:42:22 -0500
Message-Id: <1378831343-3534-2-git-send-email-denkenz@gmail.com>
In-Reply-To: <1378831343-3534-1-git-send-email-denkenz@gmail.com>
References: <1378831343-3534-1-git-send-email-denkenz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There does not seem to be any actual need for this method.

The current implementation calls Cancel when a pending
NewConnection() or RequestDisconnection() method call fails.
Additionally it calls Cancel() when the remote client has disconnected.
In either case BlueZ calls shutdown on the file descriptor associated
with the agent and issues a Cancel() method call.

The closing of the file descriptor will trigger a HUP on the agent side,
which will trigger normal cleanup procedures.  The received Cancel()
method call is redundant in both cases.
---
 doc/profile-api.txt | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/doc/profile-api.txt b/doc/profile-api.txt
index 96cfce9..ec18034 100644
--- a/doc/profile-api.txt
+++ b/doc/profile-api.txt
@@ -145,11 +145,3 @@ Methods		void Release() [noreply]
 
 			Possible errors: org.bluez.Error.Rejected
 			                 org.bluez.Error.Canceled
-
-		void Cancel()
-
-			This method gets called to indicate that the profile
-			request failed before a reply was returned.
-
-			All request are queued and there will be only one
-			pending pequest at a time per profile.
-- 
1.8.1.5

