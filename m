Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd v2 04/21] client-doc: replace SendFiles with SendFile
Date: Thu, 8 Dec 2011 16:27:38 +0100
Message-ID: <1323358075-27857-5-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1323358075-27857-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1323358075-27857-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now that OPP sessions exist, sending multiple files can be achieved with
consecutive calls to SendFile. Note that within a session the pending
operations will be queued and sequentially executed.
---
 doc/client-api.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 65f2c0a..43521ff 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -65,10 +65,10 @@ Service		org.openobex.client
 Interface	org.openobex.ObjectPush
 Object path	[variable prefix]/{session0,session1,...}
 
-Methods		void SendFiles(array{string} files, string destination)
+Methods		void SendFile(string file, string destination)
 
-			Send one or multiple local files to the remote device,
-			and the given destination.
+			Send one local file to the remote device for a given
+			destination.
 
 		void PullBusinessCard(string targetfile)
 
-- 
1.7.6.4

