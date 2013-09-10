Return-Path: <cyrus@holtmann.org>
From: Denis Kenzior <denkenz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/3] doc: Label Profile1.Release() method as no reply
Date: Tue, 10 Sep 2013 11:42:21 -0500
Message-Id: <1378831343-3534-1-git-send-email-denkenz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The current implementation does not expect a reply, nor would it make
sense for BlueZ to wait for one from the agent.  So explicitly label
this method as noreply.
---
 doc/profile-api.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/profile-api.txt b/doc/profile-api.txt
index 03b7d2b..96cfce9 100644
--- a/doc/profile-api.txt
+++ b/doc/profile-api.txt
@@ -108,7 +108,7 @@ Service		unique name
 Interface	org.bluez.Profile1
 Object path	freely definable
 
-Methods		void Release()
+Methods		void Release() [noreply]
 
 			This method gets called when the service daemon
 			unregisters the profile. A profile can use it to do
-- 
1.8.1.5

