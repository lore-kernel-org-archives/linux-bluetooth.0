Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [RFC 2/2] doc: Add reauthentication support to Agent API
Date: Tue, 14 May 2013 23:23:15 +0200
Message-Id: <1368566595-8836-3-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1368566595-8836-1-git-send-email-szymon.janc@gmail.com>
References: <1368566595-8836-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add ReauthenticationPolicy property to AgentManager1 interface.
This will allow to change default reauthentication  policy.

Add RequestReauthentication method to Agent API. This method will
be used to request user consent for remote device reauthentication.
---
 doc/agent-api.txt |   43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/doc/agent-api.txt b/doc/agent-api.txt
index 2e70931..0074259 100644
--- a/doc/agent-api.txt
+++ b/doc/agent-api.txt
@@ -9,7 +9,7 @@ Service		org.bluez
 Interface	org.bluez.AgentManager1
 Object path	/org/bluez
 
-		void RegisterAgent(object agent, string capability)
+Methods		void RegisterAgent(object agent, string capability)
 
 			This registers an agent handler.
 
@@ -61,6 +61,32 @@ Object path	/org/bluez
 
 			Possible errors: org.bluez.Error.DoesNotExist
 
+Properties	string ReauthenticationPolicy [readwrite]
+
+			Default policy for reauthentication of already paired
+			devices. UI entity should clearly inform user about
+			possible cause and possible security consideration of
+			reauthentication before changing value of this
+			property.
+
+			Following policies are possible:
+			  - disallow reauthentication
+			  - ask for user consent before reauthentication
+			    (see  RequestReauthentication from Agent API)
+			  - allow reauthentication without user consent
+
+			Some of possible causes of already paired remote device
+			missing linkkey:
+			  - unpair performed by user on remote device only
+			  - reset of a remote device e.g. due to user action or
+			    power source depletion
+			  - lost of linkkey on remote device due to pairing with
+			    secondary OS or other host
+			  - bogus device is imitating user's legitimate device
+			    (security issue if reauthentication occurs!)
+
+			Possible values: "ask", "allow" or "disallow"
+
 
 Agent hierarchy
 ===============
@@ -176,6 +202,21 @@ Methods		void Release()
 			Possible errors: org.bluez.Error.Rejected
 			                 org.bluez.Error.Canceled
 
+		void RequestReauthentication(object device)
+
+			This method gets called to request the user for consent
+			to perform reauthentication of already paired device.
+
+			Agent should inform user about possible cause and
+			security considerations related to this request. Please
+			see ReauthenticationPolicy property description in
+			Adapter API for details.
+
+			If this method is not implemented consent is rejected.
+
+			Possible errors: org.bluez.Error.Rejected
+			                 org.bluez.Error.Canceled
+
 		void Cancel()
 
 			This method gets called to indicate that the agent
-- 
1.7.10.4

