Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd 06/10] client-doc: remove agent in favour of transfer signals
Date: Thu, 24 Nov 2011 15:08:58 +0100
Message-ID: <1322143742-31182-7-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1322143742-31182-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1322143742-31182-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Assuming that the request confirmation from the agent is not necessary,
the rest of the reports can be achieved using signals in the transfer
object itself.

The main benefit of this is that the API is simpler and the client apps
do not have to register the agent, and can simply listen to the relevant
signals.
---
 doc/client-api.txt |   67 ++++++++++++---------------------------------------
 1 files changed, 16 insertions(+), 51 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 67355c6..eb06d6b 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -42,15 +42,6 @@ Methods		dict GetProperties()
 
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
 Properties	string Source [readonly]
 
 		string Destination [readonly]
@@ -64,8 +55,7 @@ Service		org.openobex.client
 Interface	org.openobex.ObjectPush
 Object path	[variable prefix]/{session0,session1,...}
 
-Methods		void SendFiles(array{string} files, string destination,
-								object agent)
+Methods		void SendFiles(array{string} files, string destination)
 
 			Send one or multiple local files to the remote device,
 			and the given destination.
@@ -281,58 +271,33 @@ Methods		dict GetProperties()
 
 			Cancels this transfer.
 
-Properties	string Name [readonly]
-
-			Name of the transferred object.
-
-		uint64 Size [readonly]
+Properties	uint64 Size [readonly, optional]
 
-			Size of the transferred object. If the size is
+			Size of the transferred object(s). If the size is
 			unknown, then this property will not be present.
 
-		string Filename [readonly]
-
-			Complete name of the file being received or sent.
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
+		string LocalFile [readonly]
 
-			Accept or reject a new transfer (client and server)
-			and provide the filename for it.
+			Complete name of the local file being received or sent.
+			For operations involving several files, this property
+			might change.
 
-			In case of incoming transfers it is the filename
-			where to store the file and for outgoing transfers
-			it is the filename to show the remote device. If left
-			empty it will be calculated automatically.
+Signals		PropertyChanged(string name, variant value)
 
-			Possible errors: org.openobex.Error.Rejected
-			                 org.openobex.Error.Canceled
+			This signal indicates a changed value of the given
+			property.
 
-		void Progress(object transfer, uint64 transferred)
+		void Progress(uint64 transferred)
 
-			Progress within the transfer has been made. The
-			number of transferred bytes is given as second
-			argument for convenience.
+			Progress within the transfer has been made. For
+			operations involving several files, The number of
+			transferred bytes represents the total number of bytes.
 
-		void Complete(object transfer)
+		void Complete()
 
 			Informs that the transfer has completed successfully.
 
-		void Error(object transfer, string message)
+		void Error(string message)
 
 			Informs that the transfer has been terminated because
 			of some error.
-- 
1.7.6.4

