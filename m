Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [RFC 1/3] doc/obex-agent-api: Add AuthorizeGet method
Date: Fri, 10 Jul 2015 20:41:50 +0530
Message-id: <1436541112-21844-2-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1436541112-21844-1-git-send-email-gowtham.ab@samsung.com>
References: <1436541112-21844-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces the AuthorizeGet method to authorize
incoming opp get request from opp clients.
---
 doc/obex-agent-api.txt | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/doc/obex-agent-api.txt b/doc/obex-agent-api.txt
index 3923da6..ee27ba6 100644
--- a/doc/obex-agent-api.txt
+++ b/doc/obex-agent-api.txt
@@ -59,3 +59,33 @@ Methods		void Release()
 			This method gets called to indicate that the agent
 			request failed before a reply was returned. It cancels
 			the previous request.
+
+Service		unique name
+Interface	org.bluez.obex.Agent2
+Object path	freely definable
+
+Methods		void Release()
+
+			This method gets called when the service daemon
+			unregisters the agent. An agent can use it to do
+			cleanup tasks. There is no need to unregister the
+			agent, because when this method gets called it has
+			already been unregistered.
+
+		string AuthorizeGet()
+
+			This method gets called when the service daemon
+			needs to accept/reject a Bluetooth object get request.
+			It request user the complete path of the local file.
+
+			Returns the full path (including the filename) where
+			the local file exists.
+
+			Possible errors: org.bluez.obex.Error.Rejected
+			                 org.bluez.obex.Error.Canceled
+
+		void Cancel()
+
+			This method gets called to indicate that the agent
+			request failed before a reply was returned. It cancels
+			the previous request.
-- 
1.9.1

