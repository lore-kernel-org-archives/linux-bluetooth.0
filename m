Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH] Remove parameter entered from the DisplayPasskey agent method
Date: Sun, 21 Nov 2010 13:46:18 +0100
Message-Id: <1290343578-986-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In the current method implementation the parameter is not used.
---
 doc/agent-api.txt |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/doc/agent-api.txt b/doc/agent-api.txt
index d8d35c0..1ddd290 100644
--- a/doc/agent-api.txt
+++ b/doc/agent-api.txt
@@ -42,14 +42,11 @@ Methods		void Release()
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
-- 
1.7.1

