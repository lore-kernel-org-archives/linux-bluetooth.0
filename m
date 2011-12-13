Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd v3 10/20] client-doc: remove agent in favour of transfer signals
Date: Tue, 13 Dec 2011 17:44:13 +0100
Message-ID: <1323794663-2711-11-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1323794663-2711-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1323794663-2711-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Assuming that the request confirmation from the agent is not necessary,
the rest of the reports can be achieved using signals in the transfer
object itself.

The main benefit of this is that the API is simpler and the client apps
do not have to register the agent, and can just listen to the relevant
signals.
---
 doc/client-api.txt |   72 ++++++++++++++++++---------------------------------
 1 files changed, 26 insertions(+), 46 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 3b87cb5..50b0b6f 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -45,25 +45,26 @@ Methods		dict GetProperties()
 
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
 
+		array{object,dict} GetTransfers()
+
+			Get existing (queued) transfers in this session. This
+			method should only be called once, and further changes
+			should be monitored using the appropriate signals.
+
 Properties	string Source [readonly]
 
 		string Destination [readonly]
 
 		byte Channel [readonly]
 
+Signals		void TransferAdded(object path, dict properties)
+
+			Informs that a new transfer has been created (queued).
+
 Object Push hierarchy
 =====================
 
@@ -299,54 +300,33 @@ Properties	string Name [readonly]
 
 			Name of the transferred object.
 
-		uint64 Size [readonly]
+		string Location [readonly, optional]
 
-			Size of the transferred object. If the size is
-			unknown, then this property will not be present.
-
-		string Filename [readonly]
-
-			Complete name of the file being received or sent.
-
-Agent hierarchy
-===============
+			Complete name of the local file being received or sent.
+			For operations from or to memory, this property will not
+			be present.
 
-Service		unique name
-Interface	org.openobex.Agent
-Object path	freely definable
+		uint64 Size [readonly, optional]
 
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
+			Size of the transferred object(s). If the size is
+			unknown, then this property will not be present.
 
-			In case of incoming transfers it is the filename
-			where to store the file and for outgoing transfers
-			it is the filename to show the remote device. If left
-			empty it will be calculated automatically.
+		uint64 Progress [readonly, optional]
 
-			Possible errors: org.openobex.Error.Rejected
-			                 org.openobex.Error.Canceled
+			Number of bytes transferred. For queued transfers, this
+			value will not be present. When a queued transfer
+			begins, this property will take an initial value of 0.
 
-		void Progress(object transfer, uint64 transferred)
+Signals		PropertyChanged(string name, variant value)
 
-			Progress within the transfer has been made. The
-			number of transferred bytes is given as second
-			argument for convenience.
+			This signal indicates a changed value of the given
+			property.
 
-		void Complete(object transfer)
+		void Complete()
 
 			Informs that the transfer has completed successfully.
 
-		void Error(object transfer, string message)
+		void Error(string message)
 
 			Informs that the transfer has been terminated because
 			of some error.
-- 
1.7.6.4

