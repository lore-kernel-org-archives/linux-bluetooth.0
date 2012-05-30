Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v3 06/14] client-doc: Remove D-Bus agent
Date: Wed, 30 May 2012 17:50:15 +0200
Message-Id: <1338393023-29941-7-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1338393023-29941-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1338393023-29941-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The request confirmation from the agent is not really useful and the
rest of the reporting is already reported by the transfer's signal-
reporting.

The main benefit of this is that the API is simpler and the client apps
do not have to register the agent, and can just listen to the relevant
signals.
---
 doc/client-api.txt |   52 ----------------------------------------------------
 1 files changed, 0 insertions(+), 52 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 223ef9a..3c6a2e1 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -46,15 +46,6 @@ Methods		dict GetProperties()
 
 			Returns all properties for the session.
 
-		void AssignAgent(object agent)
-
-			Assign an OBEX agent to this session. This allows
-			detailed progress reports about the transactions.
-
-		void ReleaseAgent(object agent)
-
-			Release a previously assigned OBEX agent.
-
 		string GetCapabilities()
 
 			Get remote device capabilities.
@@ -330,46 +321,3 @@ Signals		PropertyChanged(string name, variant value)
 
 			Informs that the transfer has been terminated because
 			of some error.
-
-Agent hierarchy
-===============
-
-Service		unique name
-Interface	org.openobex.Agent
-Object path	freely definable
-
-Methods		void Release()
-
-			This method gets called when the service daemon
-			unregisters the agent. An agent can use it to do
-			cleanup tasks. There is no need to unregister the
-			agent, because when this method gets called it has
-			already been unregistered.
-
-		string Request(object transfer)
-
-			Accept or reject a new transfer (client and server)
-			and provide the filename for it.
-
-			In case of incoming transfers it is the filename
-			where to store the file and for outgoing transfers
-			it is the filename to show the remote device. If left
-			empty it will be calculated automatically.
-
-			Possible errors: org.openobex.Error.Rejected
-					 org.openobex.Error.Canceled
-
-		void Progress(object transfer, uint64 transferred)
-
-			Progress within the transfer has been made. The
-			number of transferred bytes is given as second
-			argument for convenience.
-
-		void Complete(object transfer)
-
-			Informs that the transfer has completed successfully.
-
-		void Error(object transfer, string message)
-
-			Informs that the transfer has been terminated because
-			of some error.
-- 
1.7.7.6

