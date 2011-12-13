Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd v3 04/20] client-doc: replace SendFiles with SendFile
Date: Tue, 13 Dec 2011 17:44:07 +0100
Message-ID: <1323794663-2711-5-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1323794663-2711-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1323794663-2711-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now that OPP sessions exist, sending multiple files can be achieved with
consecutive calls to SendFile. Note that within a session the pending
operations will be queued and sequentially executed.
---
 doc/client-api.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 9936b1e..f5d31a0 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -65,9 +65,9 @@ Service		org.openobex.client
 Interface	org.openobex.ObjectPush
 Object path	[variable prefix]/{session0,session1,...}
 
-Methods		void SendFiles(array{string} files)
+Methods		void SendFile(string sourcefile)
 
-			Send one or multiple local files to the remote device.
+			Send one local file to the remote device.
 
 		void PullBusinessCard(string targetfile)
 
-- 
1.7.6.4

