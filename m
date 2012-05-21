Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 05/12] client-doc: Replace SendFiles with SendFile
Date: Mon, 21 May 2012 11:07:07 +0200
Message-Id: <1337591234-24919-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1337591234-24919-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337591234-24919-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Now that OPP sessions exist, sending multiple files can be achieved with
consecutive calls to SendFile. Note that within a session the pending
operations will be queued and sequentially executed.
---
 doc/client-api.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 32caa17..de726a8 100644
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
1.7.7.6

