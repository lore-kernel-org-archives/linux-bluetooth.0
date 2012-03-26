Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC PATCH BlueZ] doc: Revert "Small API update"
Date: Mon, 26 Mar 2012 12:12:54 -0400
Message-Id: <1332778374-15320-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This reverts commit fd1ac97806d4531cb54523b3d694899afce281e7. It seems
the "entered" param is not used anymore.
---
 doc/agent-api.txt |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/doc/agent-api.txt b/doc/agent-api.txt
index 9ab2063..193a2d1 100644
--- a/doc/agent-api.txt
+++ b/doc/agent-api.txt
@@ -42,21 +42,15 @@ Methods		void Release()
 			Possible errors: org.bluez.Error.Rejected
 			                 org.bluez.Error.Canceled
 
-		void DisplayPasskey(object device, uint32 passkey, uint8 entered)
+		void DisplayPasskey(object device, uint32 passkey)
 
 			This method gets called when the service daemon
 			needs to display a passkey for an authentication.
 
-			The entered parameter indicates the number of already
-			typed keys on the remote side.
-
 			An empty reply should be returned. When the passkey
 			needs no longer to be displayed, the Cancel method
 			of the agent will be called.
 
-			During the pairing process this method might be
-			called multiple times to update the entered value.
-
 			Note that the passkey will always be a 6-digit number,
 			so the display should be zero-padded at the start if
 			the value contains less than 6 digits.
-- 
1.7.5.4

