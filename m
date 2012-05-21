Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 07/12] client-test: Replace SendFiles with SendFile
Date: Mon, 21 May 2012 11:07:09 +0200
Message-Id: <1337591234-24919-8-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1337591234-24919-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337591234-24919-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The test script still accepts several files in the argument list and
internally uses a loop to individually send them with SendFile.
---
 test/send-files |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/test/send-files b/test/send-files
index 504a066..aa4862f 100755
--- a/test/send-files
+++ b/test/send-files
@@ -20,4 +20,5 @@ session_path = client.CreateSession({"Destination": sys.argv[1],
 opp = dbus.Interface(bus.get_object("org.openobex.client", session_path),
 					"org.openobex.ObjectPush")
 
-opp.SendFiles(files)
+for f in files:
+	opp.SendFile(f)
-- 
1.7.7.6

